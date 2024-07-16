Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3314DC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjPJ-0005nR-7F; Tue, 16 Jul 2024 10:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjPC-0005X5-E2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:50 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <sunilvl@ventanamicro.com>)
 id 1sTjP8-00033O-PM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:43:50 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2cb09dc1dafso1489111a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 07:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721141023; x=1721745823; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SU8GfqelSqXJWaHbA4tCleDNQ3MgjXFsCeI35E4yuvw=;
 b=diNLcoznskXTVsNcXmGpgt3JEGFfpZmSYUWtS6+TleL80tQtR5omxvgluDH0C7u5jV
 KacI6TaBSDfDEVf7+jhN1RX0yvETTRTlEA4aN7wJ/mJ8VRdVURVNYehE556lkyKjZDdi
 HV10Tvhf+5BZqTpCmw7h4jP6w9mkfUQPUJHwGZfE1uymrXkVk4OJvG2O1hYz9iPhZyOU
 j5yPZ0wGciXBZbJp9iHzsY7YFk8Qf0EoRdzjUHoMNb5s0q12C1KnI7DELCiBO6xQMdi1
 6pQXhthL/A8YaOZ33c0uL36AddAgyv9XeWsQHMXwZFVdFGgPa4GqXy3yg62uWjS3+68C
 Z8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721141023; x=1721745823;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SU8GfqelSqXJWaHbA4tCleDNQ3MgjXFsCeI35E4yuvw=;
 b=vulYyflNsB2EnzXBkTy2JQrRtEcubtDeMl4vZyOHE2zTKBL6W224eXhLiQney1GoaB
 CFJjvfbCm0oe6gol3p0BEV8xYlNcihUYNH4qLUPyLezWfkwuaycJ39IFMuDlSFcDDere
 7v70/3/d4z5Gj4jCwHUFIv/uxPb/hC0Yo7+TTLrEdmSUkoAUJIwUkDkTw1R4VWtBo27e
 YFIYC6+7rTCMirrD/BmA9zvi2x5siWB259J6qd8CeB9EYoyL583geI45Cs8ZXwUkm8jc
 hkQ1PHiorMTl86z89rutFK1SmP+3XWrQZb8MDVTuSlLytk75gBTL1XX5cPj+HR+w4ZHV
 uTjg==
X-Gm-Message-State: AOJu0YyfimywmTwM4pqzI4Ru83EU1ZMaEwSATsqwglBCjEA9OMSKeymm
 x0b/CS7SE0oYdLy2gtyqNmkPLAe9eQqxUSzO+rOA1htT3lchihFIaBqKWmcdR7dvlO8hZoDKxhw
 tN04=
X-Google-Smtp-Source: AGHT+IFqZiLASXNusByEK2CUUkNUyS1JOCtGWijUXENDPCeWgUAak7R+Po4iuWLg8kOQY+sFf2nXtA==
X-Received: by 2002:a17:90a:8a08:b0:2c9:a3d4:f044 with SMTP id
 98e67ed59e1d1-2cb37416a46mr1701341a91.11.1721141022889; 
 Tue, 16 Jul 2024 07:43:42 -0700 (PDT)
Received: from sunil-pc.tail07344b.ts.net ([106.51.187.237])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caf480d61bsm6084782a91.18.2024.07.16.07.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 07:43:42 -0700 (PDT)
From: Sunil V L <sunilvl@ventanamicro.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH v4 6/9] tests/qtest/bios-tables-test.c: Remove the fall back
 path
Date: Tue, 16 Jul 2024 20:13:03 +0530
Message-ID: <20240716144306.2432257-7-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
References: <20240716144306.2432257-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=sunilvl@ventanamicro.com; helo=mail-pj1-x1033.google.com
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

The expected ACPI AML files are moved now under ${arch}/{machine} path.
Hence, there is no need to search in old path which didn't have ${arch}.
Remove the code which searches for the expected AML files under old path
as well.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
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
2.43.0


