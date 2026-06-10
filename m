Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC864CD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:15:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLYP-0002WN-MN; Wed, 10 Jun 2026 12:13:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYN-0002Qr-Pd
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLYL-00066J-Vz
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:13:19 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490b211ee6aso54324875e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107996; x=1781712796; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GAkPKVM4QUVX7Djbw3yzqlDqDAw3t+ZJ3cZZxIAV4wg=;
 b=Xd1M9XOqEzlefQ9wuOc7mgnRsLfA13FJyI5bsRIedC6w0uZkss+Ordzv2ZJTeiezkM
 7TBDoOL33jhE1A0RT/QoAW0ZxnKRgz+Ol1X0vvOQaKi6XiCIbashT1MSIeYWiLuiDMKX
 uua29PNHpPwFrJ+36SSASXBSBFgxqEhCZ8wESMwtsRVguAgnFoF0pnVxcBPDQ0Ou1uTZ
 VjVYwLA+F9K19HoeNMm9ii9+Tc+FWbQIYgwwO0yJk3Zo3ua3gHpfRwjAWQHIo9q++6+Z
 ECwUNM3RNVXTXxBzI3XbSoU6zRniydv+aGoNN0EApYDLQngfW24Fryj0fRes+H65o3rj
 1uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107996; x=1781712796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GAkPKVM4QUVX7Djbw3yzqlDqDAw3t+ZJ3cZZxIAV4wg=;
 b=lFg6dxjMWwCeJ0FW0UIp+cMENMSqSKzjnSs8ZTtqyY04fcxt3Vg3jUhOXfCQ51SZcU
 3E84pLIb1bgZFx7z39mrFk0zWNnKngmGPkjrRpsjgQ/PQRLLdw+saZ6xVV7xFBQJnr+p
 Ur84JCsCDn0Rve+a9RwNT5VxSR2ntztXBJTtOMa6x0I+I0Ci364tc7eHNWnqqyDVf0ET
 gWRW9dHsd1eSwlNXIEcShE+duNSKAAUEKXdYfkUczdnLfCZVVFahKfqDBiOP7hw0M/XF
 tzFut5/tiDq+tCiGOyZNqDD2RqRgQSYwqVTU8CfOzvfnzH0bFuDlSbRE2xB8+/8ugX/v
 CNQA==
X-Gm-Message-State: AOJu0YwTLXKRGEIwrnujVyBZ+GmmK9ymyu14undoRYeFjU8dgCcbVsCZ
 JVaKQqczjujM3WBEGLe/WcefqyUFreyVynBrlGukI/pm/8QeLWl6QEyHXHO1eyhkoKjqO25PAtt
 6X+At
X-Gm-Gg: Acq92OFCaaE7ocsQTyICxlgn61440bHh1POrVAZ639maklJhQpVwkpD6HiQZA2MeF9s
 YT/b1d05ISfA7u+QxuwSNqRP9X/DD8FwFkXLipRIXICsYwWBLOaj3IB1n3HOuv91Yo9Ewrw4nxw
 RkVYyXZvqCILSd41HOGGCw58Eco48X7JIvKgAFGDqVNrJP1I1rE8BMYx4rnvYQJCgUhif3ocUsK
 bbxZSW8RxrlM9S4N+lY8cGEhy0DjTQWB/ziYLAtf3ckoIFeSA6Fuo0mtf0/QVt7L67GpXoNAJjE
 QTa+FErPu9ygoYipZvRzl4QBwxqf3Q5AnFRMp8RW+f0158cDRhxEHZ3TXkAll99c9qR3F5FfTh3
 h0OdFa5yhJr0jyhFcHnSV3l82PG3sfvle8mdyB4QODWwDnVSGokCE/zQxeKoZsCWj7+q6pgrfsu
 fpPWXJGk2d12p3y7oHwrsDUZWkvvrqrmimRN3Cq48nq/nWcMcNx0C3R5eHMrxMDcWv4VjoW1qBx
 4lPMRamN0r28LES9AaWv6h6GJBWsKhaX9zYvT+Vcjo=
X-Received: by 2002:a05:600c:674f:b0:490:b9fe:e64a with SMTP id
 5b1f17b1804b1-490c2560317mr431453645e9.2.1781107996093; 
 Wed, 10 Jun 2026 09:13:16 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.13.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:13:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/71] target/arm: Implement LUTI4 (four registers, 8-bit)
Date: Wed, 10 Jun 2026 17:11:44 +0100
Message-ID: <20260610161202.2235298-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260609192110.752384-28-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-features.h      |  5 +++++
 target/arm/tcg/helper-defs.h   |  1 +
 target/arm/tcg/sme.decode      |  6 ++++++
 target/arm/tcg/translate-sme.c |  6 ++++++
 target/arm/tcg/vec_helper.c    | 14 ++++++++++++++
 5 files changed, 32 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index db1bdb4786..11e8c7a57c 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1668,6 +1668,11 @@ static inline bool isar_feature_aa64_sme2_f8cvt(const ARMISARegisters *id)
     return isar_feature_aa64_sme2(id) && isar_feature_aa64_f8cvt(id);
 }
 
+static inline bool isar_feature_aa64_sme2p1_lutv2(const ARMISARegisters *id)
+{
+    return isar_feature_aa64_sme2p1(id) && isar_feature_aa64_sme_lutv2(id);
+}
+
 static inline bool isar_feature_aa64_sve_i8mm(const ARMISARegisters *id)
 {
     return isar_feature_aa64_sve(id) && isar_feature_aa64_sme_sve_i8mm(id);
diff --git a/target/arm/tcg/helper-defs.h b/target/arm/tcg/helper-defs.h
index 05ccf795e8..8ec6c16319 100644
--- a/target/arm/tcg/helper-defs.h
+++ b/target/arm/tcg/helper-defs.h
@@ -1120,6 +1120,7 @@ DEF_HELPER_FLAGS_4(sme2_luti4_2b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_2s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
+DEF_HELPER_FLAGS_4(sme2_luti4_4b, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4h, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 DEF_HELPER_FLAGS_4(sme2_luti4_4s, TCG_CALL_NO_RWG, void, ptr, ptr, env, i32)
 
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 339de72b8a..495330aed7 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -1014,8 +1014,14 @@ LUTI4_c_2s      1100 0000 1000 101 idx:2  1 10 00 zn:5 .... 0   &lut zd=%zd_ax2
 LUTI4_c_4h      1100 0000 1000 101 idx:1 10 01 00 zn:5 ... 00   &lut zd=%zd_ax4
 LUTI4_c_4s      1100 0000 1000 101 idx:1 10 10 00 zn:5 ... 00   &lut zd=%zd_ax4
 
+LUTI4_c_4b      1100 0000 1000 101     1 00 00 00 ....0 ...00   \
+                &lut zd=%zd_ax4 zn=%zn_ax2 idx=0
+
 # LUTI4, strided (must check zd alignment)
 LUTI4_s_2b      1100 0000 1001 101 idx:2  1 00 00 zn:5 zd:5     &lut
 LUTI4_s_2h      1100 0000 1001 101 idx:2  1 01 00 zn:5 zd:5     &lut
 
 LUTI4_s_4h      1100 0000 1001 101 idx:1 10 01 00 zn:5 zd:5     &lut
+
+LUTI4_s_4b      1100 0000 1001 101     1 00 00 00 ....0 zd:5    \
+                &lut zn=%zn_ax2 idx=0
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index c4bede2ae3..98d3d18791 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1846,6 +1846,9 @@ TRANS_FEAT(LUTI4_c_2s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_2s, false)
 TRANS_FEAT(LUTI4_c_4h, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4h, false)
 TRANS_FEAT(LUTI4_c_4s, aa64_sme2, do_lut, a, gen_helper_sme2_luti4_4s, false)
 
+TRANS_FEAT(LUTI4_c_4b, aa64_sme_lutv2, do_lut, a,
+           gen_helper_sme2_luti4_4b, false)
+
 static bool do_lut_s4(DisasContext *s, arg_lut *a, gen_helper_gvec_2_ptr *fn)
 {
     return !(a->zd & 0b01100) && do_lut(s, a, fn, true);
@@ -1866,3 +1869,6 @@ TRANS_FEAT(LUTI4_s_2b, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2b)
 TRANS_FEAT(LUTI4_s_2h, aa64_sme2p1, do_lut_s8, a, gen_helper_sme2_luti4_2h)
 
 TRANS_FEAT(LUTI4_s_4h, aa64_sme2p1, do_lut_s4, a, gen_helper_sme2_luti4_4h)
+
+TRANS_FEAT(LUTI4_s_4b, aa64_sme2p1_lutv2, do_lut_s4, a,
+           gen_helper_sme2_luti4_4b)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index f4ff56e034..3c06e93e02 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -3345,6 +3345,20 @@ DO_SME2_LUT(4,4,s, 4)
 
 #undef DO_SME2_LUT
 
+void helper_sme2_luti4_4b(void *zd, void *zn, CPUARMState *env, uint32_t desc)
+{
+    unsigned vl = simd_oprsz(desc);
+    unsigned strided = extract32(desc, SIMD_DATA_SHIFT, 1);
+    unsigned dstride = !strided ? 1 : 4;
+    uint64_t indexes[ARM_MAX_VQ * 4];
+
+    memcpy(&indexes, zn, vl);
+    memcpy((void *)&indexes + vl, zn + sizeof(ARMVectorReg), vl);
+
+    do_lut_b(zd, indexes, (void *)env->za_state.zt0, vl, 0,
+             dstride * sizeof(ARMVectorReg), 4, 32, 4);
+}
+
 void HELPER(gvec_luti2_b)(void *vd, void *vn, void *vm, uint32_t desc)
 {
     unsigned part = simd_data(desc);
-- 
2.43.0


