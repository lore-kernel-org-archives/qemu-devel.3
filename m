Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A69DC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEA-0005TT-HJ; Tue, 02 Jul 2024 10:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDM-0004tf-8D
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeDJ-0000Ld-Uv
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=Q/BB67pMXjtHPXAW25z5Ix6AYETbsRMSUGSXTfSHiJ70O5WcKJYsh3ynxkpmZYeaH4vgor
 0ofgXrXdnKJwG0/fbBpxG5RA2PpuqifrRvLg+6CMNxDq2gPKdGQASy9sU9D1m1uAACNErw
 h1oa2prjt5a+j5Ymz74C7/boaQEht/M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-znHBKBLiP6WYDoNOJU7FQg-1; Tue, 02 Jul 2024 10:10:32 -0400
X-MC-Unique: znHBKBLiP6WYDoNOJU7FQg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-424a5a5f024so27798805e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929430; x=1720534230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=sJ23BLZBAUhNWZkWrMiGEEW9LEmmyLvz2mB2CTS2J6TFMuIoS8UhAr6OIDUFZc1T9G
 14aqrjFozupLWusHeGtzIJeHqHgeQVdZmnj1fXdc1pg1Djs7ch9+h7iNAyvNzq1XmO53
 RF7cIVt3SdggLJY8uU0D/A6QSiyd18iuUsleboYDcxOGYz/oblrHRWUEDBZ47oWYl3Gj
 qTmt38+apYVmrzOt+PMj8113VZF2EzzP9+cPYJqCKYzfNGYnVzkbZqKFvmQCPURslN1v
 qbJbMtGcUnXQ0f7H7+yy3mheYWqJAnhHWVYzSx/Oz+aTMctL50cvFB8VJnpZtfjy4/1m
 +QgA==
X-Gm-Message-State: AOJu0YwxGNiNQUeW1eS44BDie8ukM5a1x/yCNNmH7Vz2XkwfKcLu9sbX
 3zC9J0XVABuFLMQcliF0waVoPhBaVjeXxgTISgisQrDK9khY/UkEjQ9Ivvew+rGACwCAyQQWgon
 /YOAnaAvaJV8fLTwbxeFnsXxES0DURUK55tdqZ+ZlGyvKgii2rKSttYmOnCjV+4caCv1foGR8Zv
 AG0VzU0GOTg4wTvIJIItNdZXOSSLtS/g==
X-Received: by 2002:a7b:c458:0:b0:424:a2d9:67c5 with SMTP id
 5b1f17b1804b1-4257a02b78emr60752535e9.16.1719929430237; 
 Tue, 02 Jul 2024 07:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFGcnsqGUSWFyRiKzfD8TZ+BZGK32tI5ABZTZPejum6k8AolDjKljRxOnae1298rb63x8Q6g==
X-Received: by 2002:a7b:c458:0:b0:424:a2d9:67c5 with SMTP id
 5b1f17b1804b1-4257a02b78emr60752265e9.16.1719929429586; 
 Tue, 02 Jul 2024 07:10:29 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm202056005e9.31.2024.07.02.07.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:10:29 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:10:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 67/91] tests/qtest/bios-tables-test.c: Add support for arch in
 path
Message-ID: <b31b58375840b3de2caaf1d519d4593d3a9cb351.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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


