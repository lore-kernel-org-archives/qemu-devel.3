Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34816CC6B10
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:54:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3n-00080D-7f; Tue, 13 Oct 2026 04:40:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3V-0007LJ-V7
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:18 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3R-0007rd-JW
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:17 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48af27fe287so2300225f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880812; x=1792485612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4zMTZd7IrsEt0EnquPhNbZyBoyakwm0X4gRcwyF+QHw=;
 b=rMyKJv6xU46W7RAKBEupIm3obwSCkOftKbBq2Dgg5enz8R8oyGz+NdTxJNFHeTicKE
 dPMIzb0HFD0f7O7TuQHBmfw2zqO0WTPS5YNtXxf35Y083igu7B4WYWB1PU/96clv3yoH
 aX8RHZeXT7TTD3uM/Q9FKBYeIXIuOodUh8dfVFsHjDiNAcaREnQwzmetJfwPQ2jaRSqM
 HOiOckDvHJSywrxZGQNWrzTWxUzaty5Ipybhev+6UpB7zXisAuT98wI6rt1oaiUnZGjS
 JWjZC/etRHiGPyssbpdOK8BLrZaNdbmhbC1eCWEKfIDOmuEyrqqXGnNpvFWDauALp/GJ
 BmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880812; x=1792485612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4zMTZd7IrsEt0EnquPhNbZyBoyakwm0X4gRcwyF+QHw=;
 b=JR8eRytJNua/8ZM8CdQatobKP3det0LPTJg9Zvdc+pwjrNkhR0DWP3ZdKb6zKl9gIY
 OGbz3VL0lpfbXF1yWoUt4yugC5v0pz+YWuSCZwnHdnWrwQ1PopoMzgLfgLK2v3EUBG+E
 Q8gD8brnrGHwsFzYHXdShrXEYY4yHrnvGMEp7rmXfZjytqHP7dfruo7E80q4B+J+mmMo
 ADj6k7nFcxjDvff6okD7O/tS+kMPOe+3LnX2/9qHWCXaMika2qp7dFxyKB1alOSpAbZW
 02hmWAnwY1M+3OQJQ+QzlNXHiwu4DKKtb22O71Wl3gnhSx7z1Tt+C2GA0va2n1zfPi8y
 AQXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwcI/aKtynFJ4noHlbCwMu+a+P6uXPFBarN/fQTXR3R9Ts0xQPWQB5L7XDGj4LmgQfO+bDxLSKOSP2p@nongnu.org
X-Gm-Message-State: AFq9FYK3HlnuSs5rokv/p2tWy5u3PTXPSuMkyOf5OIjlQsWdgQD+8a3L
 5CGs0DP/XSUV1TiRiBoATphafNourZIJzbipbLwYXc72mmGAFJR+qM+f95isdA9oOO0=
X-Gm-Gg: AYBFou1KplpQ8dpjVMNMBd8lckKIJugjui1wwzHNsCCW6rey9t8TngDc87uAo5I5Cat
 1c+lbWcPxnI9/uCroTutuyteGIZUtIU9PU+4clnp2yE+lM8xOeMkxQb/SQsG9EDlk5StqwrC1A1
 SPEHxBIZ+pq5BQ/pDtIhmxi7a5DLVY2YOaVxRiWlzktSp7nMNYZEkqXwuPaNtK2yAreuJpk5iG2
 rVmKcSbhSmDBz0OPtEprR9LtfBqupcFEiQnaN2ijJB7M9DtlAaYIoRHmz8rHHvdRPF8gOOV+IDt
 6wJi/JxwXr3eg7kBjHhZCrv1qHz26inbWoqW/owo7EoGVA5hNpb0YStGMjTzAah+0Mx0BuWnWhu
 BEC/ZEocKNgfHycWxVJVXEqliTtJOo3QjLHOaYBFUheKBieCbyBhAoq+Hn4k2xKtSHvyl1/yyba
 vHKySCcXR43OQlgak9lUjZB3ep5LHOYy53/1jhFF1sWCbAxLQ2vcis0cr27GhdPJhObva1LMHbf
 fGPQidYFSTbl01CwQUnUMtTRCd84ETOOR2tS2cLCW1OcHOVkify3v5ie0ACArvIrif+lCKiEcR5
 8avmuav+nxIJPQ==
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a18e48d45cmr248217005e9.16.1791880811970; 
 Tue, 13 Oct 2026 01:40:11 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 26/86] target/arm: GICv5 cpuif: Implement
 ICV_PPI_ENABLER<n>_EL1
Date: Tue, 13 Oct 2026 09:38:33 +0100
Message-ID: <20261013083933.1024405-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

Implement the redirection of ICC_PPI_ENABLER<n>_EL1 to
ICV_PPI_ENABLER<n>_EL1; the data for this is stored in
ICH_PPI_ENABLER<n>_EL2.

For the ICV access we need to honour the "make this RAZ/WI"
config bits in ICH_PPI_HVIR<n>_EL2.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 125dcd8cf4d..2c717b99a0b 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -463,11 +463,28 @@ static void gic_ppi_spend_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gic_recalc_ppi_hppi(env);
 }
 
+static uint64_t gic_ppi_enable_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    if (gicv5_icv_access(env)) {
+        uint64_t r = env->gicv5_cpuif.ich_ppi_enable[ri->opc2 & 1];
+
+        r &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        return r;
+    } else {
+        return raw_read(env, ri);
+    }
+}
+
 static void gic_ppi_enable_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
-    raw_write(env, ri, value);
-    gic_recalc_ppi_hppi(env);
+    if (gicv5_icv_access(env)) {
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        env->gicv5_cpuif.ich_ppi_enable[ri->opc2 & 1] = value;
+    } else {
+        raw_write(env, ri, value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static void gic_ppi_priority_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -998,6 +1015,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_ENABLERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_enable[0]),
+        .readfn = gic_ppi_enable_read,
         .writefn = gic_ppi_enable_write,
     },
     {   .name = "ICC_PPI_ENABLER1_EL1", .state = ARM_CP_STATE_AA64,
-- 
2.43.0


