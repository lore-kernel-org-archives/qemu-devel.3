Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAE1C5CFC1
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 00:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtwsv-00044m-H5; Tue, 11 Aug 2026 20:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwsu-000445-2r
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:56 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wtwss-0000TW-K4
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 20:31:55 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-84f38f3b36eso346695b3a.1
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 17:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786494713; x=1787099513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gUosSqfWUSc02VzMDQtFyxdJDVyGwX3oumdRCXB3DrI=;
 b=Z/0pDeWi3cRpTUjePLtAbf09uH5qNUVnzYL8vDwjoDVo7FP45P1uBhd20pCBFmDicT
 U4Bn59tMsPOoMN6PLvjb8AjBTx4BilIKBMxIs/F1rkXvffIt+9138pp3zv3HdpqwXi5+
 kKPFCvI7p1V4EP96dzY/0L16WQRyPvx0VllYN3O55BJ0IgiisL1kSHBGylhk9mYvUz32
 ACvVAqOHwyeSFxLVSTkN8uL+Ur3l5g2Pp0dAFWz66/EO00nBH16tOFzDYyfAY6D6kYnc
 5G8Yi5qwwXz1Qep24zf/QxShgqNrpPqaCgZSokBZrlZFOsMv6N94lVdVEplV3BTFj9ru
 wXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786494713; x=1787099513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gUosSqfWUSc02VzMDQtFyxdJDVyGwX3oumdRCXB3DrI=;
 b=fa0PRTjRyE9yx5+7s5fteM9nmArTFxG/gGkTfqu9246j6AVuKYjAFvYxr43Vn1UAqc
 2EQ+5orQkFVCEcU6NNnNDZkxnvfpMpp6t5WjaFprNOKPYs18EvchTE/vn+afTjqGLr7P
 TevgOResNHmaQqN60ms8izP5iq8rT/VmWIPKqESTXmqkFFMywBARd+1GYR0Q36Z7JT+z
 RMrYrQICDvztvLR1VFTSWIzKlupZ3KAI1Gg1ljfXTqjt4UJE4i+pAOmWmusHSqUHJGnH
 BdEBL6pjxPBeNapzNQCCpEEs8ufL5QgARloLw07mvGUq+lHX/qZFgB+NRyS8b4ubLWhs
 cqpQ==
X-Gm-Message-State: AOJu0YwL1tD4BILbve7N0KEwU4BEeW5gLoM8hGET3Po/fAOxnLd9pu3R
 d3BpS7QFcbG9DCHDSdABLB5WE58dChz5+e1FByhgejG6PBO+SBWMgUMMrbTOvo6KyxMKqfCT/Nw
 3yMgJ
X-Gm-Gg: AR+sD108wOQWsIrOQLz9Z96HAcV2f3qvMG7FtSrEF1SS2RWOUQ4r8elHSmyPdvf27g1
 h4HpzEr/UmJr9bLaTeIfhEIzdXnjgnGHoC/gcT6hnyC5376t4iWFxT73953uHYcsqa4nPsoTBKJ
 cbO3hJ8FONX3jfwe1dabWeoACUiQjRhvYx+ezMWKxzIGVGqDrY19LwK5Ib2VFzZglKNaRl9yRyo
 aUIjC+TAIEU6e5ZOhqwi772z5j9GIyl2omxRarnG9qZxM4KTzFnY9QYZ8L18YaiBdkJmoAgbXh/
 qAN9plDmd2nnBIfg2zfz82GlVa97lNy6Z2yITBwfSptp//w5clihkGhOVj3jpbmPqV4HQZwpoIi
 jGUcu+taD8WRCQpO7MBiVfTgFlBjXdLIvlRfKZNvOsCT3fubZDBCXlHXWQRBOKX6rQyPg0CQ93X
 y5qwFN96k9+4NHZjwmyqHyF693zhf6WIzrUud4zwNCZiK1QR+eM8l+rPppqm2eZe+GhYYsTDebz
 GhkEQTzBulFlfeEzbQ7l0d/tyvUahs=
X-Received: by 2002:a05:6a00:181b:b0:847:c014:864e with SMTP id
 d2e1a72fcca58-84fb5547f91mr1125397b3a.30.1786494713009; 
 Tue, 11 Aug 2026 17:31:53 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84fb1f2587fsm321466b3a.49.2026.08.11.17.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 17:31:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] tcg/aarch64: Implement ctpop with FEAT_CSSC
Date: Tue, 11 Aug 2026 17:31:42 -0700
Message-ID: <20260812003143.225228-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812003143.225228-1-richard.henderson@linaro.org>
References: <20260812003143.225228-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 55b3be0b96..1f784e8d46 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -535,6 +535,7 @@ typedef enum {
 
     /* Data-processing (1 source) instructions.  */
     Irr_sf_CLZ         = 0x5ac01000,
+    Irr_sf_CNT         = 0x5ac01c00,
     Irr_sf_RBIT        = 0x5ac00000,
     Irr_sf_REV         = 0x5ac00000, /* + size << 10 */
 
@@ -2251,8 +2252,20 @@ static const TCGOutOpBinary outop_clz = {
     .out_rri = tgen_clzi,
 };
 
+static TCGConstraintSetIndex cset_ctpop(TCGType type, unsigned flags)
+{
+    return cpuinfo & CPUINFO_CSSC ? C_O1_I1(r, r) : C_NotImplemented;
+}
+
+static void tgen_ctpop(TCGContext *s, TCGType type, TCGReg a0, TCGReg a1)
+{
+    tcg_out_insn(s, rr_sf, CNT, type, a0, a1);
+}
+
 static const TCGOutOpUnary outop_ctpop = {
-    .base.static_constraint = C_NotImplemented,
+    .base.static_constraint = C_Dynamic,
+    .base.dynamic_constraint = cset_ctpop,
+    .out_rr = tgen_ctpop,
 };
 
 static void tgen_ctz(TCGContext *s, TCGType type,
-- 
2.43.0


