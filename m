Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C328CC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:37:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjyi-0001eC-Ke; Tue, 02 Jul 2024 16:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjyg-0001bJ-KV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjye-0001IA-SN
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=GbXnFh55D1gt20ih1WvlwSIBA8VTQG3juaF2xzIEaSWo0sDjgUVJ/NtJq/72WrVa6XDxkP
 A3MW9uYum4oLS2ZciBmpnmtitG+vzrlg8I1kJAzeSW+0ZqLockhMjWJFU7f21ndEgnDLsX
 G3nXFWFALLrZcd2wGVz0j6YXAjJO9e0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-r8vsfOGYNS-SSPVuIfBAmg-1; Tue, 02 Jul 2024 16:19:45 -0400
X-MC-Unique: r8vsfOGYNS-SSPVuIfBAmg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42566c4aa0fso37132575e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951584; x=1720556384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=vG1899/L9eTEHgU1RvbZW7cIUQMXONqVdaaBmN4Cuv1trSqrCEyQo9aU6x1ZvQHf8N
 qGliHwa9NFBrNQYVvXShEAQ+oLSJgGDJXn24ZVjejKYa1T81O26CY7OivsxyUn7yLqjD
 oGs3LbvKr2qkhTXcArWOEvGCYiokPOOC4CthPxjm4IrjMtvwNTc1wx3LjwV1PDw9Nk//
 5CAjYqy9cDNv7Z0Hfsq1+XdTs5NqQa7ZLLYN5sJOc6Mu2s8Gs4BcDf69Xcr4A3S6QLZ/
 bV7hnOSBF6W4VW2BzuWt5uysSWDNjMkQW2p3PI3bWWMFUsxn4JNv2pGX3OCZFom1cbn1
 hhlw==
X-Gm-Message-State: AOJu0YzU6pmGD+KDhG21gc0KFVEYSprN96MBQISPmB84AI7TKahQ2hSP
 +QjJ8Llxauf1F+sr1ivfJ2dKe4MAaeQEqHlIrnAbN5cNQxL1KxawMC0dPVe4piHFxxi16CGZbhQ
 tezLvt+kDqfCSq9cTU3odtNlkMU93zckBg/yW64hbA8eKSQOxT1Ujt/f+bN2NUWb+XtjVFfvm28
 jjYU30eE6Keye7C1FcibAPQxWQ2ktv0g==
X-Received: by 2002:a7b:cc96:0:b0:425:7798:6d66 with SMTP id
 5b1f17b1804b1-4257a02b915mr61748785e9.1.1719951583777; 
 Tue, 02 Jul 2024 13:19:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXu9mNeA8o6CP316ctEd915bQMvWJyEPypga2a1QCj/hxAoy7OcitqGUm+WofjsvpTBzp3Tg==
X-Received: by 2002:a7b:cc96:0:b0:425:7798:6d66 with SMTP id
 5b1f17b1804b1-4257a02b915mr61748575e9.1.1719951583123; 
 Tue, 02 Jul 2024 13:19:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b91bsm212171875e9.20.2024.07.02.13.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:19:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:19:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 67/88] tests/qtest/bios-tables-test.c: Add support for arch
 in path
Message-ID: <c5533d89a72de3e0758d1fa4551edca8427e17fb.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since machine name can be common for multiple architectures (ex: virt),
add "arch" in the path to search for expected AML files. Since the AML
files are still under old path, add support for searching with and
without arch in the path.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240625150839.1358279-7-sunilvl@ventanamicro.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index c4a4d1c7bf..29c52952f4 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -78,6 +78,7 @@
 typedef struct {
     bool tcg_only;
     const char *machine;
+    const char *arch;
     const char *machine_param;
     const char *variant;
     const char *uefi_fl1;
@@ -262,8 +263,19 @@ static void dump_aml_files(test_data *data, bool rebuild)
         g_assert(exp_sdt->aml);
 
         if (rebuild) {
-            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
+            aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir,
+                                       data->arch, data->machine,
                                        sdt->aml, ext);
+
+            /*
+             * To keep test cases not failing before the DATA files are moved to
+             * ${arch}/${machine} folder, add this check as well.
+             */
+            if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
+                aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir,
+                                           data->machine, sdt->aml, ext);
+            }
+
             if (!g_file_test(aml_file, G_FILE_TEST_EXISTS) &&
                 sdt->aml_len == exp_sdt->aml_len &&
                 !memcmp(sdt->aml, exp_sdt->aml, sdt->aml_len)) {
@@ -398,8 +410,13 @@ static GArray *load_expected_aml(test_data *data)
         memset(&exp_sdt, 0, sizeof(exp_sdt));
 
 try_again:
-        aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
-                                   sdt->aml, ext);
+        aml_file = g_strdup_printf("%s/%s/%s/%.4s%s", data_dir, data->arch,
+                                   data->machine, sdt->aml, ext);
+        if (!g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
+            aml_file = g_strdup_printf("%s/%s/%.4s%s", data_dir, data->machine,
+                                       sdt->aml, ext);
+        }
+
         if (verbosity_level >= 2) {
             fprintf(stderr, "Looking for expected file '%s'\n", aml_file);
         }
-- 
MST


