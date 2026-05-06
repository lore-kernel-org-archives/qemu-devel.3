Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C05CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcrn-0002Ev-Jj; Wed, 06 May 2026 10:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqd-00006g-9e
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcqZ-00016j-US
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:03:34 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-48a3e9862f0so7208395e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076209; x=1778681009; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ObHygtAeF4PYXWvdAwerohvClrll0PrC3oop6cMmCLg=;
 b=ZGh6YHcH1wlrW6WujuVtSKgEwpLnfs5KNR8VR9HNxDr1UlJO8RtulKZQycnqk8x1Ev
 j+VhSWPMGPiGaFRdDuFgvh4hOeJx0vPAsabdim0CeTB37fgsXyLK6WxdDJyW82uDdPX5
 sS1c4yT98IqWXGSH3sME/Xlgvvr30Z6uoh7In60t00S+RXtvVPcCHL4xbO9AtXC8s0C9
 fziT682Cm0n4taJQwta1YEIm32hFbY9QTaKtj9EgcG+NM3lkPaGhQRQDSZibqAVwlrpF
 bnRqRHCYRekd0H+1mjIFO/g6qBXAl1ghaf9xiEvaWBViJzUm7ErMCyAFF8ye1CZQM7ju
 w80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076209; x=1778681009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ObHygtAeF4PYXWvdAwerohvClrll0PrC3oop6cMmCLg=;
 b=fceRWQJZikYZAZz3PHvLoc1hIqTZB9mvZSV2ho29ckGHgd4mh127xzeQoW6Kgm6hTZ
 d8O5TmeTUvhhIVlFBDHJTskRZIFoyPjs/q2HywvpQ0gUk70PfoZd72LY2SC9tvI/Hhm6
 ZnAkgQDaOkUvoHXGCyrh3ADvK15qCoiSrw8fPz0oOlIU5O01wbIbUteTomq58NKe5nyS
 QgjIfX29gSMDXQ6X3NrzgSjkJdYEHyZF/EZfcZjzC7CVGs4x3Xl6woJDmTMqdbNynQUD
 pDf5DsxYnBxwHhj1VbGMJXj63DyzL8qOzUwbQFUen/9aKa4xJEpE7QaMALTZEmd7ase1
 4B0Q==
X-Gm-Message-State: AOJu0YxYPaSfnx3losyAwCGnL1+eQu7m67g9kwYhSNMSt3/DkYg9fI0A
 zt1rVxCIUOXfP1i1FNpDm8IVEmjcTDsd66GOF6ZZiYbgAnxS7CjBLxA5n8QJUx77xgPOEsH2aWK
 lvUScnBE=
X-Gm-Gg: AeBDiesgDEuvmiu9u8CMp/BikKbjPYdCwK6Pf6SaIF0Sj3q5l/Ttt7JY4xfiOZWBneU
 ORTBru/zoeRIBxY2e1gIBrfmytPjw93vWNu0SXxEI78tvv3L52sbudLUWVXllDXJKrfXasNbjrj
 ReCzPuWkSOuroamkqPJtOKEDbPOTAoxlawn2SH3DZPoYEWsg/WQkCF5UaZC4P9JeI3rSbtAqfXv
 YFTiD3fD4s8IWkZExEjPUz/HzDotSyb4NUVh77EaW8Dc90/HjBow6hPt16OJQx8YItGKspv65bd
 KTPq8EDL7MMNMx2AK52IXCbi5BXAs0Yym/5koN/pwnSXiHWs4+jdMvbeyJt+RPQziS1CAXAQFDM
 0ykvnaCCJrhUHDY8rjC8HnB/v1cq/UkZIf5o+Ig2U0lZ+YadwbgCOFgVB4y2qbXT+y3/60DGZxc
 cHbhywVSrzELSwDg0ULV2y/KWyRysDdnfWQ3Ed6eSuKAa3r8lkhtHlG/uEF3QdWhIRXghdbMaL6
 DLoXZBZOOg=
X-Received: by 2002:a05:600c:348f:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-48e522c0854mr55354405e9.13.1778076209282; 
 Wed, 06 May 2026 07:03:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538aaa0fsm66120195e9.7.2026.05.06.07.03.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:03:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 062/110] cpus: Introduce SysemuCPUOps::monitor_defs hook
Date: Wed,  6 May 2026 15:54:34 +0200
Message-ID: <20260506135524.20617-63-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Allow targets to register their legacy target_monitor_defs()
in SysemuCPUOps; check it first in get_monitor_def() otherwise
fall back to previous per-target helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-27-philmd@linaro.org>
---
 include/hw/core/sysemu-cpu-ops.h | 6 ++++++
 monitor/hmp.c                    | 8 ++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 5b831393cf4..94e36ecdd18 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -93,6 +93,12 @@ typedef struct SysemuCPUOps {
      */
     int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
 
+    /**
+     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
+     *                use @gdb_core_xml_file to dump registers instead.
+     */
+    const MonitorDef *monitor_defs;
+
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 02e9d72e672..ad8b0d1a72e 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1608,11 +1608,15 @@ void monitor_register_hmp_info_hrt(const char *name,
  */
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
-    const MonitorDef *md = target_monitor_defs();
     CPUState *cs = mon_get_cpu(mon);
+    const MonitorDef *md;
     void *ptr;
 
-    if (cs == NULL || md == NULL) {
+    if (cs == NULL) {
+        return -1;
+    }
+    md = cs->cc->sysemu_ops->monitor_defs ?: target_monitor_defs();
+    if (md == NULL) {
         return -1;
     }
 
-- 
2.53.0


