Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C784C55174
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 18:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpsPc-0007Tv-2y; Fri, 31 Jul 2026 14:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPO-0007Pt-RQ
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:39 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpsPL-0002BV-La
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 14:56:38 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2caced6038eso13707675ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 11:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785524192; x=1786128992; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tdBFRwQsgkTkxoNPbBo3ttL6cxChgSvdejWIn1SWS8k=;
 b=TBl7F88jbkfFKm1WJMmjmEWn7aFEXduDwm1eBbAchq6StwrFEA+TJq7Z/7wu4IctlS
 Z3rXDqf7INLY2f19COfVYXdK33SOV6QDG2PcAzxeAQhQVntWPzmFlKW6dtXj6ecIyf8N
 kGWWPmJTp78WuKkeSMnjEE8NB1EymOIdTDUViK94f0N7D1iZKUurJBqd6i7bGD1Qzw+R
 hZ+wTGRHw8id1BGJhVx8WAFTabTsqjnlxqbSnDwEgPjuAL/Rc2HPGAe85JAW5goU0CTF
 kMOtWHR46JuwJTtPaIJny0GiKp7kXaqcQi3cGj3raZfW7lsqtZ63AGyjwQ9hf2Q7RoyJ
 uNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785524192; x=1786128992;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tdBFRwQsgkTkxoNPbBo3ttL6cxChgSvdejWIn1SWS8k=;
 b=gR0KuSBctgH8EsCg7u2l5YvALSHCR9KyhJdzcOSrCTE9n0Y1tE+PYBMzgTKY+/NNyn
 GV1ONeKxLnE1zObKPtrtq+ymKdi22RQtiSI5MzoLAtD7HAG+rmNlqfg+2hXzgQ94nQM6
 uqWmSiwsuEOJTdwtpK4qY2YKxiuxgHTQ0DlKY2UW4V0L0v2jliXbvk2VKluKAu+r0KEg
 GJG3sGEPxOzpru6CfskZ0f1scOLJa2CslLyrCGUrdeCgoQ7YencUkhQw4r6uyXUBFCMI
 teDSQQwUYO551b6bGzzqfFP6MNtgArZ8TlQulBuJDnrKfNheKsF3UGzAs1BXaE/EURLp
 UOyg==
X-Gm-Message-State: AOJu0YxGQETyKKip9nRvBq7fRGrpIaoySgxJspkKRV4svdV2y/qTqT8f
 NOUJ6w6yG4u73RqMJsFvhfl4REW98nle0QJG/HIRnHSssmdAaenad3J7T4vrwIIhcVygdevK8c8
 j5tnc
X-Gm-Gg: AR+sD12XkHAsg7Y3yQyY9ADVuHBncdlqV35UhK9pBJKzS9NUBIMNHnn/xjLQrKO36GP
 OADSwEoTBegvNFaL/wJRphEt+qGZE7k1DQ8goZhHv3u94JRoKSSRI77FUGpb8Xrr12RnXd5KclO
 Vr1oKoWmbCTvKpgtyg+twA6dMSrWMGaEWqcCG+3YKYr6DaIfR1es07ZBESmFWa4V6pJAM0xWDC9
 TFAYWVV6jisCBsqiUJ6PAvD72IZRdBa6A/lFxmog+tJthOo36C3S8dvRK9E5LgCLAdUISC15Dmv
 +Ug54rll1+38O7MGR1bBFT9lPpIYzdDG04ejb1I02QtaJkYbaU9ro/sK9+jQOu2FbDO3EV5qrn7
 jfXYhg135vdcQm6gCKYvA99jP3J9XehLNBE2fW7ASGjczUUUGke1Y3oNGBcdZeGuQEt3L3IGYui
 cDBnCFLD5q/jpsM53Wf5ntdxE4KYB+eaXKyebcQyjIXLCxxCeC4kWu61WLFcaozkO/VF1E5jMi3
 Xumn9VHNrCwCeKFYvl4
X-Received: by 2002:a17:902:ebc6:b0:2c6:8d95:fd7e with SMTP id
 d9443c01a7336-2d047d1e722mr31245395ad.6.1785524191939; 
 Fri, 31 Jul 2026 11:56:31 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04ae193fasm9356625ad.7.2026.07.31.11.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 11:56:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	philmd@oss.qualcomm.com
Subject: [PATCH 03/14] target/s390x: Convert op_ld16s to op_ld
Date: Fri, 31 Jul 2026 11:56:16 -0700
Message-ID: <20260731185628.23161-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731185628.23161-1-richard.henderson@linaro.org>
References: <20260731185628.23161-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c     |  6 ------
 target/s390x/tcg/insn-data.h.inc | 12 ++++++------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 055e163837..e0546ba791 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -2755,12 +2755,6 @@ static DisasJumpType op_ld(DisasContext *s, DisasOps *o)
     return DISAS_NEXT;
 }
 
-static DisasJumpType op_ld16s(DisasContext *s, DisasOps *o)
-{
-    tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BESW);
-    return DISAS_NEXT;
-}
-
 static DisasJumpType op_ld16u(DisasContext *s, DisasOps *o)
 {
     tcg_gen_qemu_ld_i64(o->out, o->in2, get_mem_index(s), MO_BEUW);
diff --git a/target/s390x/tcg/insn-data.h.inc b/target/s390x/tcg/insn-data.h.inc
index 865ef23ebd..ea023fc168 100644
--- a/target/s390x/tcg/insn-data.h.inc
+++ b/target/s390x/tcg/insn-data.h.inc
@@ -498,17 +498,17 @@
 /* LOAD HALFWORD */
     C(0xb927, LHR,     RRE,   EI,  0, r2_16s, 0, r1_32, mov2, 0)
     C(0xb907, LGHR,    RRE,   EI,  0, r2_16s, 0, r1, mov2, 0)
-    C(0x4800, LH,      RX_a,  Z,   0, a2, new, r1_32, ld16s, 0)
-    C(0xe378, LHY,     RXY_a, LD,  0, a2, new, r1_32, ld16s, 0)
-    C(0xe315, LGH,     RXY_a, Z,   0, a2, r1, 0, ld16s, 0)
+    D(0x4800, LH,      RX_a,  Z,   0, a2, new, r1_32, ld, 0, MO_BESW)
+    D(0xe378, LHY,     RXY_a, LD,  0, a2, new, r1_32, ld, 0, MO_BESW)
+    D(0xe315, LGH,     RXY_a, Z,   0, a2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HALFWORD HIGH */
-    C(0xe3c4, LHH,     RXY_a, HW,  0, a2, new, r1_32h, ld16s, 0)
+    D(0xe3c4, LHH,     RXY_a, HW,  0, a2, new, r1_32h, ld, 0, MO_BESW)
 /* LOAD HALFWORD IMMEDIATE */
     C(0xa708, LHI,     RI_a,  Z,   0, i2, 0, r1_32, mov2, 0)
     C(0xa709, LGHI,    RI_a,  Z,   0, i2, 0, r1, mov2, 0)
 /* LOAD HALFWORD RELATIVE LONG */
-    C(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld16s, 0)
-    C(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld16s, 0)
+    D(0xc405, LHRL,    RIL_b, GIE, 0, ri2, new, r1_32, ld, 0, MO_BESW)
+    D(0xc404, LGHRL,   RIL_b, GIE, 0, ri2, r1, 0, ld, 0, MO_BESW)
 /* LOAD HIGH */
     D(0xe3ca, LFH,     RXY_a, HW,  0, a2, new, r1_32h, ld32u, 0, 0)
 /* LOAG HIGH AND TRAP */
-- 
2.43.0


