Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2BFC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmv-0003Kv-6p; Sun, 21 Jul 2024 20:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglc-0003Pn-MQ
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglW-0005yj-Q1
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:19:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=23tk34UMbS5KN8DzcPjFZwgbF2YmEX25+n6MkYYLPTM=;
 b=hBi9AZENJAMcmdPuLzbiiVd6vBvOSOuofQAaYd76HI2SvMWoOE0Z6K+33pfBqRulc4QQb5
 jDnlY0PSNQJdv/UHh0FMwggfu8/7bucgM7YHP2Uhzlze6yW651PskTLmm5anJj7MnDBCWf
 gT8Fk/J005XDXG/38RnjIj+EB1b/Nog=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-LwRAtUqlPtKCY-XgeeIgZw-1; Sun, 21 Jul 2024 20:18:53 -0400
X-MC-Unique: LwRAtUqlPtKCY-XgeeIgZw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4279837c024so26479955e9.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607532; x=1722212332;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=23tk34UMbS5KN8DzcPjFZwgbF2YmEX25+n6MkYYLPTM=;
 b=EJmlANi/QB2oo0tpo5qONUL73eVmuwTXT6Km8w6yLH0KYxUDzUWzBo67hYPj3beocz
 FfMR9ekQuzswkNik+x722R3hC8DCSsiTjIr70XLWsbKfSASDbWp7FvZ7PPED6tNiu/WL
 tSbemnKAZC1RrPwtzi9EuBlnEiFQNvqLGATp2EVEiggsbzObrYyAsx27vIUSv+dFs8S4
 grkLgy/M/5WwtSfGwTs7NF5362Cso93pLV7ETzhpF+EmHO82GTxygdiYa0s9HiOyiTDh
 lCh6MJuCYBZwC3tDyS7ZIRZc8GCh+5nZDkQWNfxZgQySZ2+4V0MjpcILxjHWwDCNib0q
 DTog==
X-Gm-Message-State: AOJu0Yy5mF7EvWcQz0SH9R18wkGBwQxppU8urPmmWQZnc4ncJWDhUxLO
 4nahUbqQIJRDL32LSc7M22/u2Lwkn2HrANx+Prd9ykvxQfmXsmBl6CrxpJrq9eSTGPHQsNbuIPg
 8h3Zz6TIyFwj+HZqz54W3rktalLTTnymaK6W1Tg9sRWh0VLsvkx6QCGi6FUxwpwCfh1J3Uo1gE5
 Z72trJO0qVMmpJIJl5GvtO5yCVj8Ib6Q==
X-Received: by 2002:a05:600c:4589:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-427dc59e752mr39667785e9.32.1721607532178; 
 Sun, 21 Jul 2024 17:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKDuDlo79LxifLkTRki1rRKQt1Y8nLJhLUbuYMWhv2a7QyUSI2zWK/nIhXjtq/CJhYUAh2yQ==
X-Received: by 2002:a05:600c:4589:b0:426:602d:a246 with SMTP id
 5b1f17b1804b1-427dc59e752mr39667645e9.32.1721607531571; 
 Sun, 21 Jul 2024 17:18:51 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2a3c159sm134925665e9.8.2024.07.21.17.18.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:51 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>, Igor Mammedov <imammedo@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL 56/63] tests/qtest/bios-tables-test.c: Remove the fall back path
Message-ID: <1ad2fe8d4792da37fefe6791050efc46016f9645.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sunil V L <sunilvl@ventanamicro.com>

The expected ACPI AML files are moved now under ${arch}/{machine} path.
Hence, there is no need to search in old path which didn't have ${arch}.
Remove the code which searches for the expected AML files under old path
as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716144306.2432257-7-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index f4c4704bab..498e0e35d9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -267,15 +267,6 @@ static void dump_aml_files(test_data *data, bool rebuild)
                                        data->arch, data->machine,
                                        sdt->aml, ext);
 
-            /*
-             * To keep test cases not failing before the DATA files are moved to
-             * ${arch}/${machine} folder, add this check as well.
-             */
-            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
-                                           data->machine, sdt->aml, ext);
-            }
-
             if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
                 sdt->aml_len == exp_sdt->aml_len &&
                 !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
@@ -412,11 +403,6 @@ static GArray *load_expected_aml(test_data *data)
 try_again:
         aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
                                    data->machine, sdt->aml, ext);
-        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
-            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                       sdt->aml, ext);
-        }
-
         if (verbosity_level >= 2) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
-- 
MST


