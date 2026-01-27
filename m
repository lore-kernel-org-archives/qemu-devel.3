Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35A4D2594E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 06:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkciM-00030X-PC; Tue, 27 Jan 2026 01:38:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciJ-0002xp-1O
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:11 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vkciG-0006m5-BC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 01:38:09 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-34ab8e0df53so4624541a91.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 22:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1769495886; x=1770100686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/7RJutSKn1k65hDY8Ig9jUscMyGWjNCtLo7Y1bHL9Eo=;
 b=Ie3fO0bRVZYp9n5GXtVSo1XhVraP4SZNwavaAu0TlD+MKO8OMS6cxL66i0ZeAl7y8J
 /YM6o/GW4osA7DVwYs46t+kZflWlMrm6ZUDZ32vI8YhPocpoVm3ArM5QGNZAykuGIgPy
 4LvhK4aXfauuydsFnlEA95CIDl5VZov2Kc9H8XMFYwKwPtKUEfteYAC6H50rwy0h210l
 q/xERHohC4ncWkzKdav+AcvqSO7d0qGn9peZdbqEdAoXWerBDzpx3bD0R7yRzf1ljrvd
 0F54gCKymTLMHSZJtH1mtb/ADEAo6Cyae/6fey1FidWkFIQcIo9nxDfPE4idiTdD7bUh
 qeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769495886; x=1770100686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/7RJutSKn1k65hDY8Ig9jUscMyGWjNCtLo7Y1bHL9Eo=;
 b=cWrv2Tpiy2Pcpu//nU3P97pfZdHm0T/ub/cKLdS4DPM9HkdzvryNwAk0oD/xVQoa3E
 hLM8tNmFF/up7fD3azvn454c+Evci8BgAlwyPMw0Eflqaf4MXUaqDVuNTRzMDaFpKRLh
 vYb0XXILge32G9ITgezYRQ0uXLSxlaq+rrseaPL2jRaJdKuzmLAnsHcZM+2YEfR9zCJj
 niBLQhXnS+jiaVekboflNescAG6fuWTdgDc0Su94i0hPiX0+5VBDUXKZhnrSmb8qOgax
 ql4VSGKygEX/iHKI1amr0sFpL8ORy/Jf0KlUz7whqGD/WFpLAiPI38YZYTIS0Bsd3thS
 22PA==
X-Gm-Message-State: AOJu0YzXOOUFxWiTQ5t0Sj/DFCt5s53gAVQA0afZo9OjrsZzrP6n0ozP
 JpnDMkyqZ6eBCjoBXxOKQ6hzovPo0VCiazDlCL8/XOMm3y2rfa6jd0OYTBeJPUVKZCD6fFOIlxi
 1kgO8QhfJDTei2TLjO1nsuMeHQuWX+Wlf1kQ+9gcWicHl52tFfaoGgxJD43cqnwu6Za+SbsJSo1
 RCj6vtJPL4llPWUMUmmX0R9g5Owy/OHj9ru8F8jm32ng==
X-Gm-Gg: AZuq6aJ4ujGEExEdtj18X2xv8DJwDaNqETWfbxd4ZPeWsP0+4PA2PmiuXdSHmxOXfkP
 c+8DJ9tE87a7trgq2aGShMkrZVPrpY/zjTy2E5qEapykiKTgNLJJOcaJ2J/x/EmPMznJaqOpVF9
 XAVyc4hdnKNwacnwDHa8tnDbljj3d3dEfqBnKcLGG909vROjrbxuVLWoa0CQgGM0GtxbAtQzsOb
 iBfe0iTA6tImK5aQcAwKkVMJgLtljr2U6eNOJqk8LqUav0JHljA2EJqXEe8GZQSCdPT5frxO3R1
 XclhVFDANcSUeW0uAQ8QbvnV0LxfCssDl1vHNKSr5sPI6S/kbsxEdk46Uikx+EzhlZTAQupwDhN
 XMoPLOvz8NvwIhLuvVR82BnGgRANd5tQObbxTJSohKBrrR72KpJV+9+5SBGlvTkYnnmUdtOZgT4
 0TE8wRcaNg8+8cqjiWWDj/CmePqCA5Z7ffkFl4MRC1mI2lH7wQtaE/kB9FjXxrHJSTvCw5g3hU6
 qhaeCNkGdEUTjA3vbncXjkBNg==
X-Received: by 2002:a17:90b:3885:b0:33b:b020:597a with SMTP id
 98e67ed59e1d1-353febd56camr906020a91.0.1769495886265; 
 Mon, 26 Jan 2026 22:38:06 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f5f96293sm1414175a91.0.2026.01.26.22.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 22:38:05 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 14/17] target/riscv: Add implied rules for Zvfofp4min
 extension
Date: Tue, 27 Jan 2026 14:37:20 +0800
Message-ID: <20260127063723.442734-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127063723.442734-1-max.chou@sifive.com>
References: <20260127063723.442734-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Add implied rules to enable the implied extensions of Zvfofp4min
extension recursively.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 7823508615..87827441d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -2520,6 +2520,15 @@ static RISCVCPUImpliedExtsRule ZVFOFP8MIN_IMPLIED = {
     },
 };
 
+static RISCVCPUImpliedExtsRule ZVFOFP4MIN_IMPLIED = {
+    .ext = CPU_CFG_OFFSET(ext_zvfofp4min),
+    .implied_multi_exts = {
+        CPU_CFG_OFFSET(ext_zve32f),
+
+        RISCV_IMPLIED_EXTS_RULE_END
+    },
+};
+
 static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
     .ext = CPU_CFG_OFFSET(ext_zvkn),
     .implied_multi_exts = {
@@ -2648,9 +2657,10 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
     &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
     &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
     &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
-    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP8MIN_IMPLIED,
-    &ZVKN_IMPLIED, &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
-    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
+    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVFOFP4MIN_IMPLIED,
+    &ZVFOFP8MIN_IMPLIED, &ZVKN_IMPLIED, &ZVKNC_IMPLIED,
+    &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED, &ZVKS_IMPLIED,
+    &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
     &SUPM_IMPLIED, &SSPM_IMPLIED, &SMCTR_IMPLIED, &SSCTR_IMPLIED,
     NULL
 };
-- 
2.52.0


