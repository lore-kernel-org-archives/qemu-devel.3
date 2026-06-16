Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DDBCD98E6
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZQi0-00036I-IB; Tue, 16 Jun 2026 06:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhy-0002m6-JW
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:50 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZQhw-0003XX-Ow
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 06:07:50 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-c86307c4e6bso1517376a12.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604467; x=1782209267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfzpkzMSoMzwHbURFfVnVGFkL1vk1Nm5GaC2STIxEuw=;
 b=HmFVq4r5DKD52W4qdwET6DZopEXBHCUO4X5iisF2PmDUsNfS3B7uEl8Xpme14xjF/E
 V5gnzRvAUP8EQd8TwBXXMlVAeU1gD54e9vthp0sfnNYcMwuLw++RD0dn4zNjfxF2Bm78
 0eptpoVr2Q1OZIHPEjr14fu4bkc8ck+r+W7JRwWD/ZFZvxGvXjqZGCLiHUpHQ0LhjRgn
 BM1gmda9BsbE/w3Ryp9cAmsz6jn0Wx55wJvN3Kvp0vFu8/BxB6W+U083AJQTSIjA1It4
 SGVCZMTNEsdjS8xm+Qd8715lAL0bG46irRTdYONktsafX6w/1LSCOY3NoM4+xv7G6tYU
 uHYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604467; x=1782209267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QfzpkzMSoMzwHbURFfVnVGFkL1vk1Nm5GaC2STIxEuw=;
 b=pEo+ZveuncPjeqdEzAx0uTti3oj127g2UH6Ff7+q0WncZDvSHRKyL5XU3aNyGx0IFB
 d4M/X/9SWBNSgP7mJR24dRxK6g9H4oCXTVPwdqHyazbVYBXaHzSGOmHPag0Jg7AAQt3a
 SNWRvc8rgKxmPJF+nfkfj1NBkqkW/yxxXj5TjS3XnI3uHxNXi8BzSptRlD84cE76iXaq
 mkRq305xb2g3C8plxyPjBIqf1373CSPPTa6gHDZwLi16Obw70X9GVVoU+dRZf7heak4Y
 DQM/OJaKgLi+IX26XTD6bta1G80M6JelT3R4cl7+WjS2OBpihLY6H6vXkvCMByc7DE2r
 00xA==
X-Gm-Message-State: AOJu0YzcvoBR1wYWbNVrcB4YUIGmIhvYtx2T8KMOCdeyJfJS4jmhjLgx
 3h9OVFRLz5MlzezDr1adLb2zoSIZ0tCAyUlSRN814zINhTcg4TuC29ia72CtUF95
X-Gm-Gg: Acq92OE+2tSmlys1X6ykCHvgrNfQ9f8bYyCSExFNc4tRZch6YBlvIs6SSnjv+WkbBHX
 gPW0IrmYCIRN2wB0n7xdZk3qUiVgJ5YgiwORditVWUfZZ1lECA2DryUoCmCTYWOY02lsIDFvzU2
 yK8JAysNIVa1nHBrLnQTxbjfknGAn5PC7vYqEfV1G1vCa6sRyTMTW9w7ctGDPNX00BX/1BE6Arg
 0xvwikDwUcMYi9jLDvJ0Mus/rft0pqeLy+VaiS03skwnBiQgnPYAw5zTOBGtj54s83hET/YeY//
 7RrR/JiHotkKZy1DnP8cnnQKa3NKnAZz2Z2XB85heCmDyNYX4OSwukz6mZrLPKdeOtOC8adNuS6
 lB+gHxG/YU/FneSFnh71vQtkZtrTY0K6GIdJXA1R3q+2ftWwGblY6jrmqXQ5CO5Nf8XTG69RQv8
 ooEdCbCkYYlCqjNCO873L2f+wjfa10UfNPpuqSuREB
X-Received: by 2002:a05:6300:141:b0:3b4:701f:a0dc with SMTP id
 adf61e73a8af0-3b7e494193emr3182576637.26.1781604467235; 
 Tue, 16 Jun 2026 03:07:47 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c866519f0a6sm10916735a12.22.2026.06.16.03.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:07:46 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 38/83] target/riscv: Fix pmp.h/cpu.h circular inclusion
Date: Tue, 16 Jun 2026 20:04:41 +1000
Message-ID: <20260616100527.1939565-39-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616100527.1939565-1-alistair.francis@wdc.com>
References: <20260616100527.1939565-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Anton Johansson <anjo@rev.ng>

pmp.h is only needed and included for system mode, however relevant
macros (MAX_RISCV_PMPS, OLD_MAX_RISCV_PMPS, MIN_RISCV_PMP_GRANULARITY)
are required unconditionally by cpu.c, and so are defined in cpu.h.
pmp.h then defines pmp_table_t depending on these macros and so requires
cpu.h, and cpu.h in turn uses pmp_table_t resulting in circular
inclusion.

Move PMP macros to pmp.h and only expose PMP properties in system mode.

Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20260520125406.28693-28-anjo@rev.ng>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.h | 4 ----
 target/riscv/pmp.h | 4 +++-
 target/riscv/cpu.c | 6 ++++++
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 3e33efdc60..68e1ec37b4 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -181,10 +181,6 @@ extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
 
 #define MMU_USER_IDX 3
 
-#define MAX_RISCV_PMPS (64)
-#define OLD_MAX_RISCV_PMPS (16)
-#define MIN_RISCV_PMP_GRANULARITY 4
-
 #if !defined(CONFIG_USER_ONLY)
 #include "pmp.h"
 #endif
diff --git a/target/riscv/pmp.h b/target/riscv/pmp.h
index eae305ac6f..4c95c2767a 100644
--- a/target/riscv/pmp.h
+++ b/target/riscv/pmp.h
@@ -22,7 +22,9 @@
 #ifndef RISCV_PMP_H
 #define RISCV_PMP_H
 
-#include "cpu.h"
+#define MAX_RISCV_PMPS (64)
+#define OLD_MAX_RISCV_PMPS (16)
+#define MIN_RISCV_PMP_GRANULARITY 4
 
 typedef enum {
     PMP_READ  = 1 << 0,
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 65bf931296..1d9e575bb2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1147,7 +1147,9 @@ static void riscv_cpu_init(Object *obj)
     cpu->cfg.cbop_blocksize = 64;
     cpu->cfg.cboz_blocksize = 64;
     cpu->cfg.pmp_regions = 16;
+#ifndef CONFIG_USER_ONLY
     cpu->cfg.pmp_granularity = MIN_RISCV_PMP_GRANULARITY;
+#endif
     cpu->env.vext_ver = VEXT_VERSION_1_00_0;
     cpu->cfg.max_satp_mode = -1;
 
@@ -1385,6 +1387,7 @@ static const PropertyInfo prop_mmu = {
     .set = prop_mmu_set,
 };
 
+#ifndef CONFIG_USER_ONLY
 static void prop_pmp_set(Object *obj, Visitor *v, const char *name,
                          void *opaque, Error **errp)
 {
@@ -1493,6 +1496,7 @@ static const PropertyInfo prop_pmp_granularity = {
     .get = prop_pmp_granularity_get,
     .set = prop_pmp_granularity_set,
 };
+#endif /* !CONFIG_USER_ONLY */
 
 static int priv_spec_from_str(const char *priv_spec_str)
 {
@@ -2522,9 +2526,11 @@ static const Property riscv_cpu_properties[] = {
     {.name = "pmu-num", .info = &prop_pmu_num}, /* Deprecated */
 
     {.name = "mmu", .info = &prop_mmu},
+#ifndef CONFIG_USER_ONLY
     {.name = "pmp", .info = &prop_pmp},
     {.name = "num-pmp-regions", .info = &prop_num_pmp_regions},
     {.name = "pmp-granularity", .info = &prop_pmp_granularity},
+#endif
 
     {.name = "priv_spec", .info = &prop_priv_spec},
     {.name = "vext_spec", .info = &prop_vext_spec},
-- 
2.54.0


