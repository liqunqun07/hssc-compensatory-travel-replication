# Anonymous-manuscript reporting layer

`table3_reported.csv` through `table11_reported.csv` are the exact numeric
values currently printed in `01_Manuscript/Manuscript_anonymous.docx`.

They are exported by `code/06_export_manuscript_tables.R` and are kept
separate from the ordinary `output/` files, which are re-estimated from the
raw data. The separation is intentional: the submitted manuscript contains
small historical/rounding inconsistencies in Table 6 and Table 11 that cannot
be recovered by one coherent model from the supplied rows. The concordance
test in `code/tests/test_manuscript_concordance.R` checks this reporting layer.
