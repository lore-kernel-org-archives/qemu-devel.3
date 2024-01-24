Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C2AC47DDF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 08:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSZ5V-00080k-L1; Wed, 24 Jan 2024 03:58:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rSZ5U-00080I-06
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:58:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rSZ5S-0006rF-9h
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 03:58:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706086700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xqF7xeXx4QdGIePp01OWGWGK0gn7pWQRSN+ak9TRF0A=;
 b=hfSGDxGM+uqEO/nZehU376PtWcwWPrV0HES8rmP3x6O645RlGPDukj+syb/uLbA+bxjA1h
 R7pdjDlNDkGQsqzRQYdhthyI4MTsI0ptSNvRlF1vvcf6ClLzwqgfSanm0cqOfIkrfLfR+U
 5+KDwDFjC0ePfId8Jgt6APUEdjVdieY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ZyGAwALgN-6NnqPV-DP-TQ-1; Wed, 24 Jan 2024 03:58:18 -0500
X-MC-Unique: ZyGAwALgN-6NnqPV-DP-TQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-337cc89a049so2677916f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 00:58:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706086697; x=1706691497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqF7xeXx4QdGIePp01OWGWGK0gn7pWQRSN+ak9TRF0A=;
 b=EaNLNjuCBDtAyXjO3w0APdgxe3H6b/K9u8yJ8aaEVhIK1GZWzTGcdfDqPn/D+nRd2Z
 ddllKqfRvfBN5uerODuxE0hGM0k+cim7yHqTXPY2a3Z3M9yZbQWXmbAnxeIuWixqhgSD
 GBQR22FzxIqzTPsd+PscYyZMIkFcCp0cTpDy+rhXNe5jGeUa+aqc6CTNWK6iIFKoBQwe
 61hjAAP1aqC66ArV5XMmjAVXb/b4QqTGsIOzSU93SopXvUDh3oNX/xlhSuVSHLmTseTm
 Bxdw11pfLjwzJm2QMbvyeYIDVT1cJTa2Bpkq6fWhGwS4DRaYTL9GEchZUq5LdDcStgc5
 UQmA==
X-Gm-Message-State: AOJu0Ywvek1hKP4LcRzasIHrvn3BBaiUwFm4PzwiCelTMdbKjsfZoEFv
 5sf5DXd5o2UKSDsH6RHGsZuEQ1w5dKGIYa/dy1NxXsDS3I8W6iJmdkGuSyXyXvGPI9jgD7Efa3N
 xdWRlj8+671hD932Tz6pauT7uyAEWSzFM17sKqYcYthUVhCuxOeD6
X-Received: by 2002:a05:600c:4750:b0:40e:bfbf:f332 with SMTP id
 w16-20020a05600c475000b0040ebfbff332mr904243wmo.27.1706086697326; 
 Wed, 24 Jan 2024 00:58:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHbiZboiYxcbzltM+cc80JbPyEqFsnJI1P2TY7ip9Dz6SIyGTsC7AGuGh0WW2HjkBZUC6jsuw==
X-Received: by 2002:a05:600c:4750:b0:40e:bfbf:f332 with SMTP id
 w16-20020a05600c475000b0040ebfbff332mr904234wmo.27.1706086697015; 
 Wed, 24 Jan 2024 00:58:17 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 k13-20020a05600c1c8d00b0040eb99a7037sm4607070wms.44.2024.01.24.00.58.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 00:58:16 -0800 (PST)
Date: Wed, 24 Jan 2024 09:58:15 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Ani
 Sinha <anisinha@redhat.com>
Subject: Re: [PULL 03/15] tests/acpi/bios-tables-test: do not write new
 blobs unless there are changes
Message-ID: <20240124095815.3392a6a4@imammedo.users.ipa.redhat.com>
In-Reply-To: <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
References: <cover.1701450838.git.mst@redhat.com>
 <11a3b4ebee91cf6129c8d6fa3fd94fb29b1f8bff.1701450838.git.mst@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.327,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 1 Dec 2023 12:15:16 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> From: Ani Sinha <anisinha@redhat.com>
> 
> When dumping table blobs using rebuild-expected-aml.sh, table blobs from all
> test variants are dumped regardless of whether there are any actual changes to
> the tables or not. This creates lot of new files for various test variants that
> are not part of the git repository. This is because we do not check in all table
> blobs for all test variants into the repository. Only those blobs for those
> variants that are different from the generic test-variant agnostic blob are
> checked in.
> 
> This change makes the test smarter by checking if at all there are any changes
> in the tables from the checked-in gold master blobs and take actions
> accordingly.
> 
> When there are no changes:
>  - No new table blobs would be written.
>  - Existing table blobs will be refreshed (git diff will show no changes).
> When there are changes:
>  - New table blob files will be dumped.
>  - Existing table blobs will be refreshed (git diff will show that the files
>    changed, asl diff will show the actual changes).

> When new tables are introduced:
>  - Zero byte empty file blobs for new tables as instructed in the header of
>    bios-tables-test.c will be regenerated to actual table blobs.

Ani,

what previously worked is the is there weren't _any_ expected blobs
(exact match/fallback) found a new table would be dumped.
So then later 'git status' would show a list of new files. 
With this commit it's however not dumping new files files,
and explodes at
#5  0x000055555556808e in load_expected_aml (data=0x7fffffffd7b0) at tests/qtest/bios-tables-test.c:414
#6  0x00005555555676b0 in dump_aml_files (data=0x7fffffffd7b0, rebuild=true) at tests/qtest/bios-tables-test.c:256

sure it can be worked around by manually creating empty files
for expected files but if it's a new machine type, one has to create
a bunch of them basically running multiple iterations of rebuild in V=2
mode to see what's missing.
(IMHO cure turned out to be worse than illness)

for reproducing create a test for other than default machine type, ex:

    test_data data = {                                                           
        .machine = "pc-i440fx-2.0",                                              
        .variant = ".pc_legacy",                                                              
    }; 


is it possible to fix it so that one doesn't have to create empty files manually?

> 
> This would make analyzing changes to tables less confusing and there would
> be no need to clean useless untracked files when there are no table changes.
> 
> CC: peter.maydell@linaro.org
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Message-Id: <20231107044952.5461-1-anisinha@redhat.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 71af5cf69f..fe6a9a8563 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -112,6 +112,7 @@ static const char *iasl;
>  #endif
>  
>  static int verbosity_level;
> +static GArray *load_expected_aml(test_data *data);
>  
>  static bool compare_signature(const AcpiSdtTable *sdt, const char *signature)
>  {
> @@ -244,21 +245,32 @@ static void test_acpi_fadt_table(test_data *data)
>  
>  static void dump_aml_files(test_data *data, bool rebuild)
>  {
> -    AcpiSdtTable *sdt;
> +    AcpiSdtTable *sdt, *exp_sdt;
>      GError *error = NULL;
>      gchar *aml_file = NULL;
> +    test_data exp_data = {};
>      gint fd;
>      ssize_t ret;
>      int i;
>  
> +    exp_data.tables = load_expected_aml(data);
>      for (i = 0; i < data->tables->len; ++i) {
>          const char *ext = data->variant ? data->variant : "";
>          sdt = &g_array_index(data->tables, AcpiSdtTable, i);
> +        exp_sdt = &g_array_index(exp_data.tables, AcpiSdtTable, i);
>          g_assert(sdt->aml);
> +        g_assert(exp_sdt->aml);
>  
>          if (rebuild) {
>              aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
>                                         sdt->aml, ext);
> +            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
> +                sdt->aml_len == exp_sdt->aml_len &&
> +                !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
> +                /* identical tables, no need to write new files */
> +                g_free(aml_file);
> +                continue;
> +            }
>              fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                          S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>              if (fd < 0) {


