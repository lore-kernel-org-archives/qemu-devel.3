Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B121DCA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY8i-0008DF-Cm; Tue, 13 Oct 2026 04:45:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4O-0000zX-In
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:12 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY4M-0008EM-Hj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:41:12 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso19396465e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880869; x=1792485669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ajLhckcu3c2igWxUB3Vhg4b0TdY9O1nDNXhQTb9MzSE=;
 b=QQg/Iko93jcSaAKZhc72naJI+YAA3/Bc5/aG3fvSuFPHZPVPLaF0WzFAkPZq6d/sZK
 ibdBBB/lam2QaFLO+u0eRt2BHWeIrkeFnYtFW77YRU/I5rjd0hVCAKkUW8q/LcSSjKpG
 O79Kmm0U9QGt5W9suTc2qzzLjn08LCMermbR269mEABoM5VSt0jrSserMYj+KWHoSz/0
 F587BQ69LWWgvD08AHDJTx5aMB/2kVLMf/jFJLixgnxd7T7L9z313JNyAVsGDi44feSi
 fVUNl3uGqAR1n21j+7d4QoKaV8YHjszGXsoKOY2qeAeeKaNcDFFluKcjbBbptmiLRZ2M
 6ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880869; x=1792485669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ajLhckcu3c2igWxUB3Vhg4b0TdY9O1nDNXhQTb9MzSE=;
 b=PA/cj6I03Ak5SdP1F3tqm7eO0Ddeinn4bOmxOZXokMscWxCgsHZG6N823Qf5MtWbuG
 VrD8p+0F/VhOWIpAfLj50Ubk/u6FsBkMQ1A9bcU+w8Y+67QaGLx1EXJo474QoIEw14Rx
 GjeViaeBHy4cK0n38q+huWD12DZrL89+9qRJ/e+QQF0ozmVo+dhZQetBGvd31vKxwuMa
 /bLxw2zvKnK+ywNT7ZxeXHYGndSOKOBFHZId2+Ft8F/HuzBu749vF9u0uF3XBy+piMV+
 RiWQrQUvp1ootkBSc5jAiCyb5OwyagfIdcLMpx4QzTZK+dRBzILr10tQ0ErzwfTJOwYR
 2pxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/ws+y1XVYufSGvZlBDQ1Hn0vBFT2U+j9csnAFuwbxEhJTwX9KL5P7PJUSJwxlMA8gdxQfQKG7VdXe@nongnu.org
X-Gm-Message-State: AFq9FYL8Kw1VqIxpbiTcL6rJvsQTuMybaGCUhPxH5gxVisZa02OA3zjo
 aA1OijERGAVxcRAW3P1knTaf4LiVtv/WkUZ09B0dixrO8Lkhro08azExTBOB6TsUvH8=
X-Gm-Gg: AYBFou0acw1rQ6Pk3vRZvW3ZSEe7oVhxiBuWWkQCu2QykxP3fGccpoNkxlikUpbq2NA
 H16ia/CJYtgc3YvO7lEbvzqgh7Vy3nftsgdirlvS6flnqlRfmeXmUb5LlI+P22f3BQ5O2SRF2k5
 48rJt6RZ9YLzpxbFQXOOfRweHchaKGE2xAhpeLc7OUXzB+/iA5Y+6tEet9U/kRijUSBDfhZXG+o
 BWDGS+OaJxO2+BpryM/nPA8NnWcR2YGS+OQtxIiQx22O3gQm1bwA8jUmaGJv4bvbi603znJlkhp
 uwJmBTk/gnD4+4PbgkGo2c/PaOGJPLLRqn7BGijyqFTiRrMX7+wl1H3NBqlIGW3ZP039zqWR+cp
 HpYPzYe1NoG25642Y+tUl+CKtqUkZRe1FyHO+V4KXiDsSGqrWNtTwenmoRygoL3PgqKR2J0TW1J
 96lw+eLlgV7VVoIprx4WgAfPrYQBO5WXVU4Yy7j9/KaI3mdWGDUTsO5IuiCE/ZlquTu4u89s9Op
 Cv4xUyXxzX4RB23tR6JKWBrHPAHjluiKaPXGHTCws1cFsa5GhxAQWX+OEauXTDHfndR1uBnOGFT
 wLI=
X-Received: by 2002:a05:600c:138a:b0:4a1:7bd4:d07d with SMTP id
 5b1f17b1804b1-4a18e4c85fdmr249993545e9.34.1791880868893; 
 Tue, 13 Oct 2026 01:41:08 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:41:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 72/86] hw/intc/arm_gicv5: Handle virtual=true for setting
 pending
Date: Tue, 13 Oct 2026 09:39:19 +0100
Message-ID: <20261013083933.1024405-73-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Add virtual=true support to gicv5_set_pending(). This is similar
to the handling for set_priority and friends, except that the
Pending state is the one change a cpuif can make to an interrupt
that doesn't require a VPE for the VM to be resident on it.
Instead gicv5_set_pending() is passed the VM ID to operate on.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv5.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
index 1bb649cf4f1..c07122fe6e4 100644
--- a/hw/intc/arm_gicv5.c
+++ b/hw/intc/arm_gicv5.c
@@ -643,6 +643,7 @@ static const GICv5ISTConfig *ist_for_vint(GICv5 *s,
 DEF_SET_FIELD_FOR_IST(priority, uint8_t, PRIORITY)
 DEF_SET_FIELD_FOR_IST(enabled, bool, ENABLE)
 DEF_SET_FIELD_FOR_IST(handling, bool, HM)
+DEF_SET_FIELD_FOR_IST(pending, bool, PENDING)
 
 void gicv5_set_priority(GICv5Common *cs, uint32_t id, uint8_t priority,
                         GICv5Domain domain, GICv5IntType type, bool virtual,
@@ -761,8 +762,30 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
     trace_gicv5_set_pending(domain_name[domain], inttype_name(type), virtual,
                             vm, id, pending);
     if (virtual) {
-        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_pending: tried to set "
-                      "pending state of a virtual interrupt\n");
+        /*
+         * SetPending is the one operation on an interrupt that a cpuif
+         * can do without having a VPE for the VM resident. Instead it
+         * passes us the VM ID to operate on, and we must look up the
+         * IST to use that way rather than with ist_for_vint().
+         */
+        GICv5VMTConfig *vmcfg = &s->vmt_config[domain];
+        const GICv5ISTConfig *cfg;
+        VMTE *vmte;
+
+        if (!gicv5_domain_has_virt(cs, domain) || !vmcfg->valid) {
+            return;
+        }
+
+        vmte = g_hash_table_lookup(vmcfg->vm_cache, GINT_TO_POINTER(vm));
+        if (!vmte) {
+            return;
+        }
+
+        cfg = type == GICV5_LPI ? &vmte->lpi_ist : &vmte->spi_ist;
+        if (!set_pending_for_ist(cs, cfg, id, pending, &iaffid)) {
+            return;
+        }
+        irs_recalc_vhppi(s, vmte, iaffid);
         return;
     }
 
@@ -770,15 +793,10 @@ void gicv5_set_pending(GICv5Common *cs, uint32_t id, bool pending,
     case GICV5_LPI:
     {
         const GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
-        L2_ISTE_Handle h;
-        uint32_t *l2_iste_p = get_l2_iste(cs, cfg, id, &h);
 
-        if (!l2_iste_p) {
+        if (!set_pending_for_ist(cs, cfg, id, pending, &iaffid)) {
             return;
         }
-        *l2_iste_p = FIELD_DP32(*l2_iste_p, L2_ISTE, PENDING, pending);
-        iaffid = FIELD_EX32(*l2_iste_p, L2_ISTE, IAFFID);
-        put_l2_iste(cs, cfg, &h);
         break;
     }
     case GICV5_SPI:
-- 
2.43.0


