Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBAADC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 22:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP8n2-0005lG-I2; Wed, 03 Jul 2024 18:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8n0-0005d8-QH
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sP8my-0006ZZ-2N
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 18:49:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720046962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=bPGyG8+eYw5xJyT1H+N5E47r+lxcI/VbL4OfTvFUywAkOkx+eePA48sFQspyDfkUOswZfb
 bAjYDmfRzqkQXzHvFstK6IoOHzlH53IRMMtw4HDZ/8v8kcUWY+J00AXWdOUrq5I6Noqyyt
 C/fsBL16O9ByNI3SzRQwL3ul/YnZJLM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-c6LC3rtONZq5c0YUFigneQ-1; Wed, 03 Jul 2024 18:49:21 -0400
X-MC-Unique: c6LC3rtONZq5c0YUFigneQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ec61a87db0so59745681fa.2
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 15:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720046959; x=1720651759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8ROLmjYrb+QdAQNPXPEEZlctlgKEo5Cy/u0jGb6NPk=;
 b=OABlgufPWENc6KgVMX0wGBb1bl3YgZDr5VkZhVVGswn/nxyzoJe27fKq3grjWPy6hZ
 zNntpZQLAL6DSw10HjHFchGFC4otYu7j7PYUZWKcccVDk7RQHnwsQZpAQOoRY+iEFq/4
 nOp/7JKhvkDwi81YAoMUWnWcA9l6z6MMQkgBpi2OYEWbP5H6GXB6PqXo8I5G0/Wef3vu
 Xf6Hu24Dn0g8SeTgfCxS1QxRWYqwUrCOd+xOErnK9PgFTWsqMFOz0BUkRysDFUz0HCMy
 u7ZZTWKOHZDf2AWiYRLA1L642le/v9IaDiqmW/e6LXvnBiaAhMqIOvlCnuXIQus4kejq
 HkyA==
X-Gm-Message-State: AOJu0Yw9ib4rKsFRoErEG7DzniWk21S5vEJdwHk3MhLjYVB/6GMzxGxU
 5ofvr9z5CeMSnZXEi7Zk+nrFZ2cmQjbZqv3VoOo9ZxQ2KzLC1Ow4prBOeHejG9ZZ1dq8uGFYP9r
 e6uZ8K8snGPrBxbFeP1N9TidZ8BihL9dpSbxRVxaLMQgT6wEgLrOJ1eSRQmWHQh6UWL5CiGgoQX
 MdPuRU7aQSkMaukyTV2Vt8k4w0OC3/3A==
X-Received: by 2002:a2e:7d0a:0:b0:2ee:8c8d:d9dd with SMTP id
 38308e7fff4ca-2ee8c8ddbbfmr2785741fa.36.1720046959289; 
 Wed, 03 Jul 2024 15:49:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGr8xUrsmSAGleVs8PLCQSnGg6KMYREeErjndTr2piNjY/inasSibXo5bij3rGQ/FV/yYzI2g==
X-Received: by 2002:a2e:7d0a:0:b0:2ee:8c8d:d9dd with SMTP id
 38308e7fff4ca-2ee8c8ddbbfmr2785591fa.36.1720046958506; 
 Wed, 03 Jul 2024 15:49:18 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:91a8:a47d:5a9:c02f:92f2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1d0b24sm1242535e9.3.2024.07.03.15.49.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 15:49:17 -0700 (PDT)
Date: Wed, 3 Jul 2024 18:49:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL v3 64/85] tests/qtest/bios-tables-test.c: Add support for arch
 in path
Message-ID: <c9ad3decca13cd0f01ef16dba7a3d44abb096964.1720046570.git.mst@redhat.com>
References: <cover.1720046570.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1720046570.git.mst@redhat.com>
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


