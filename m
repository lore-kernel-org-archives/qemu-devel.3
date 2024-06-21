Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBCEDC41513
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 12:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKcvl-0004DY-57; Fri, 21 Jun 2024 07:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvj-0004Ch-Dl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:47 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sKcvh-0003Ak-6s
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 07:59:47 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f9cd92b146so14411315ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 04:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1718971183; x=1719575983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZycHu1GawJwjwX4WxIIeJpZLZFE0AM425lGZ17tEhU=;
 b=IbUTkjIuHArbPDA+htOYVhJ+xW6dnjeYFUQwnk8tC0xIZo9Pe2HYR76OUlpVXwyxOk
 lYh+ZjhSVWdb8i3vimvsHe1bbbb933szig7IpKpRLez9ii1LnSO/m1p2PgPYJ93GN3gy
 XFkIT087Z9YRlgMpyWSKzTa3ZAl29TDJcg0G8AOZivWVGxEMiEAEb5rd5ZcohNyvorF5
 nWKK5DCAuioJQEEbHSVI7M9ZPjGbRd83ICPhe1aoUUYj82RfOFheQxIjHkAjEJ441H3D
 BFE5WhaQppDlgyjl+f6tMith4aXJwMcyF+arrs/HeFD4jDkG0HekZHAaA19Snsrd3l6e
 M4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718971183; x=1719575983;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HZycHu1GawJwjwX4WxIIeJpZLZFE0AM425lGZ17tEhU=;
 b=pXklWuHYunx0QKGcKnu9+MIhckyQMOmXoj9cpN16P5iMpUBoTjLVEd6zMWKT64AUE3
 z0vddDIBjNF8ngDSMhEQu2IKp0gQv3RXeY04fKRK61JkDEuOJKwQ454ZxDFUs+md9Ike
 rLfNhFsO+LYgxcEOo9h1XbfeZqSIlhMFnNq4tr5xXQEL38PnAZA5e8AbicpxTIn0Kvj4
 cHnWQmI7fsO8Xe8usWr2NpEcAIHK6nsSr3bgvSNYvlE3L0hZSn2oxWjrkKBWtRJo1Nje
 zUehgeGo8u+saqVQ5vQaqXzjkgWJ9quh5Uh3RAverJGCmA1I3Gxv1RzQV5jc6xfjcA+i
 sOAg==
X-Gm-Message-State: AOJu0YyzCSTT21WwJGGAz9gzut/2lDZRJKhpmrr8ld2YyogXllGso4mf
 5VecLcd0Hkbo8eUalQnBmtjMM0qFJjOcUaeoY81jGqUy1oOyolzP3SkbHXky8bXywWVI2o5vljh
 7
X-Google-Smtp-Source: AGHT+IEM/tKOfaceedNOkIfkk8ElpCPYFvefB8Uw0BTod8hzVgPZbwql+26Z4OV1rz2i6Vw1iR+loA==
X-Received: by 2002:a17:902:d491:b0:1f9:a386:2bbd with SMTP id
 d9443c01a7336-1f9aa3d0af5mr99598565ad.22.1718971183111; 
 Fri, 21 Jun 2024 04:59:43 -0700 (PDT)
Received: from sunil-pc.Dlink ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9ebbb606dsm12422995ad.270.2024.06.21.04.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 04:59:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>,
 Alistair Francis <alistair23@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v3 05/15] tests/qtest/bios-tables-test.c: Add support for arch
 in path
Date: Fri, 21 Jun 2024 17:28:56 +0530
Message-Id: <20240621115906.1049832-6-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
References: <20240621115906.1049832-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Since machine name can be common for multiple architectures (ex: virt),
add "arch" in the path to search for expected AML files. Since the AML
files are still under old path, add support for searching with and
without arch in the path.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
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
2.40.1


