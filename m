Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BB8EC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whALC-0004ki-OA; Tue, 07 Jul 2026 14:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKz-0004e1-4J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKx-0006LW-3r
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:04 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTkwb3996766
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V/XjRFJGYYwW24zgFL9schuX7w2keGuXAKWhI3IMUDE=; b=PbyvXj936XtBsABd
 /nA8kcG9SpTt9S9qfmLMmaZEYXzrLo7MOm+qKTENIQgygECdjohO85AT8+rEFhRv
 Wd4gxDpFWwV6TOtidhg3O7bawYO6veEL5v/shOg1dY7gf+kjrY5bCkcqu3ts6b91
 WIMdpjE+/erl5j6NgW/19aghHT0Hh1KUaqrl/AfMpG37yZkZ0YlcUlNrMwH3sV+D
 TD+aO6aekd6cDqUkMzAiQP08GwgdnpFSjPBDH5hjm/zjL/utA93SMT2T06M3IELK
 OvXw58EVSBYK9wMb7A4Ia8TEhZuXczY7PFNTBZhnNAC9oiKoF7BxgIaj4DqPn/87
 Nap1wQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su73gkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so55304811cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448160; x=1784052960; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V/XjRFJGYYwW24zgFL9schuX7w2keGuXAKWhI3IMUDE=;
 b=GI09LWmhSEjz4HiYFhq0Agdb50q0aZsBNGlLrZONBuy8F4akNrIYXdaJsx6lCifq4u
 cyM8Zf/7wsdFohiCTWy++KPVa7plEEiBoo9OVnYp6+LOMurOmcsMTGC3QDVl0gxzaHWl
 4ysn3BzZaMTQdSUDMTQ1+byjy9RnOIj17197Kk4hC8GCXxycbLdbgozcxpGg+Gp2D9VH
 c40EvFUca7XYskJbR5qWbxxTiF5DOUTPbFHzzjNb7CfIjrjCMkcwpo/V+IaYYMHUMwUM
 p42SbVCjQxZpSSB5x/yEh+kvEfwGNor5GAz7Ki0mhtBFWk3oQYor5UcRIDMfAr4euaWt
 LzmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448160; x=1784052960;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V/XjRFJGYYwW24zgFL9schuX7w2keGuXAKWhI3IMUDE=;
 b=UcJTIiagxsPgPQ3yH+C3Tc+QMkwTJdYb0s7CeBuxv4c89AMGKsFcHsr5F9Z22qrApZ
 M9C8dQCn3KzdOXe/va8ocQl24nBNFGEf8qAb80KueBff2oWlvtTLUTkTQEbdBvAJh65m
 FWNMNJBGUoM1EZvhMcxWM4WHsMwwjZ6/tOnS8ysZViuywATqK4+qOgMRPTyrvdl1btst
 9FcUMPSLdfo2rrOnpTDZodklDnRddpN2/38bQEVBbHlJjAXfefzmCWk0ZVqUYacwh/4d
 PPh/G5q/I2XBo/fKmPmRRmXxyhY1c6DS4HqXLQ68m6iITMJmXlGjdcoV5K4PkMrn2DxM
 G61g==
X-Gm-Message-State: AOJu0Yz/sevt+Od/mLypLwFcg9IBPkpU7fZ7Sjieu7VRKjraf9N0SdGi
 qWb0xJmD3FaMpDpOcdrnwg0n3pILZ2cgC7hGb8PaU1lA+6/gcGs6ah+fYvsH1cK5+teDhkGSO0M
 /a4nL8rIPsL29LFNxf2nC85YaVcYRCNWVK8CLqWCuZQyVObrYMhRcGNn9NNdRm+aDNQ==
X-Gm-Gg: AfdE7clCW1juXboGxjrFMSGHmpeeun/wGqUDmWZHUlKVQ2d7eI3w9ZroP3wVJZQv+32
 L12jtv+NTrPHjuMUkST/Uksjg7FEgUEXx11cpvXRwZXsvcKgJDMNyTLYK0FbDQeuND9bPtc1lch
 adiOsc1uN3gbO9DoXzp2+HMBoNeFfXpvuVkcA7eoz4yTnhtDX+XJlWJwB7dfsMOGbIpUh09rug+
 O+QVwFwpY544wUgNTZ/Sm6sQh3V2/ZjgC2HvHAei/csOKnC3gBoK1DTg4Brqv8sfS/OYC5JYIMm
 jxXq8Ya7z56+b0JoEmLo9EP5m1aVlkUFvZCiM0YlMxm0Uau9fm/Ic4+TVUj0JTxSskYs9wtZLzW
 buV5w8NpBycPVE6TmrrVvzPIW4LSCYGuDLcrPNYfpGAx2Jpn5/XFSdgXbn7UQ8cnGWLKQ
X-Received: by 2002:a05:622a:2516:b0:51c:7b12:11fe with SMTP id
 d75a77b69052e-51c7b121745mr41365251cf.76.1783448160025; 
 Tue, 07 Jul 2026 11:16:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2516:b0:51c:7b12:11fe with SMTP id
 d75a77b69052e-51c7b121745mr41364611cf.76.1783448159228; 
 Tue, 07 Jul 2026 11:15:59 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e549dcd5sm3144235e9.1.2026.07.07.11.15.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:15:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/23] target/mips: add Octeon GFM COP2 helpers
Date: Tue,  7 Jul 2026 20:15:09 +0200
Message-ID: <20260707181529.60191-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX5qKI82FK00Iy
 biy4+5lsXxpQMb/+snWabyoZnmBJUrXuRS1qrcipMOzl+8hilZmsjH2RcKP6/TVc7TCATsnKutV
 dNUMEof4mvuoamb+BQke9NvLBh0H3L5DRc93+Czjmuu3FM0lgAo0Yyyu6xaCGHlWiANhaPTNSBq
 ANp0RRC956ZJ6EdyI33itPcuPsSh7MkOm7jR4ziLn6AA3mwiHKbxDHHdWSDaQiykDcvw2Dulvwf
 bIDEodvBbg5lVCkijgvJt07TwJGS2oHbiZYKUEdTKpayKtDoA/Q74NcpH6rc+bZA5kKQ31LgRhx
 N9xxhqy0l2iL8HQoKMMBm17BnUq3rYDs97y0iEgKfPJvHwPfxVTvS9fcJrfivJemsWo0ivtnYI8
 VfflVSI2G7MtCtQ77NZhxP8+dlQ2w9+YPMZruTpkORIodmw853bDAkTJx7kkq5JNlkwlrVdE1WQ
 OEk6lvJIcQp8GwlUYKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX975bKiaEm723
 UYL4zytxD5JeshPdGvKU3HGa9KKK38+EvusQjTSG4PZS/B4XANxYRYOcLuI8oHQ5F/cMQJEv/Zz
 AStexUjHKgCrM1fkLnmT06MplZIOXl8=
X-Proofpoint-GUID: BiGxK4WmVGADke_PtkYB_eOFMtZELYTE
X-Proofpoint-ORIG-GUID: BiGxK4WmVGADke_PtkYB_eOFMtZELYTE
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d4261 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7mZLfOp9yqhDg7vxLwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

From: James Hilliard <james.hilliard1@gmail.com>

Add helper support for the Octeon GFM carryless multiply selectors. This
models the normal and reflected multiplication paths, including the
XOR-and-multiply forms that update the result/input state used by Octeon
crypto code.

Reflected selectors operate on the architectural GFM register bank using
bit-reflected register transfers rather than a separate shadow state.
Keep the 64-bit UIA2 reduction path used by SNOW3G F9 and share that
shortcut between the normal and reflected XORMUL1 paths.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-4-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   9 ++
 target/mips/tcg/octeon_crypto.c | 142 ++++++++++++++++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e802f50fd6e..20ffbfb7096 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -27,6 +27,10 @@ DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
 /* Octeon COP2 selector operation helpers. */
 DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_mul_reflect1, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect0, i64, env)
+DEF_HELPER_1(octeon_cp2_mf_gfm_resinp_reflect1, i64, env)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
@@ -38,6 +42,11 @@ DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect0, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index c589077ea7c..b417dcf53b6 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -11,6 +11,7 @@
 #include "internal.h"
 #include "exec/helper-proto.h"
 #include "crypto/aes.h"
+#include "crypto/clmul.h"
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
@@ -75,11 +76,152 @@ static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
     octeon_crc_set_state_reflect(crypto, crc);
 }
 
+static void octeon_gfm_mul(const uint64_t x[2], const uint64_t y[2],
+                           uint16_t poly, uint64_t out[2])
+{
+    uint64_t zh = 0, zl = 0;
+    uint64_t vh = y[0], vl = y[1];
+    uint64_t rh = (uint64_t)poly << 48;
+    int i;
+
+    /*
+     * Keep the reflected-shift formulation used by Octeon software: the
+     * selector polynomial is already in reflected bit order, and the software
+     * view folds its 16 reduction bits from the top of the high word.
+     */
+    for (i = 0; i < 128; i++) {
+        bool bit;
+        bool lsb;
+
+        if (i < 64) {
+            bit = (x[0] >> (63 - i)) & 1;
+        } else {
+            bit = (x[1] >> (127 - i)) & 1;
+        }
+        if (bit) {
+            zh ^= vh;
+            zl ^= vl;
+        }
+
+        lsb = vl & 1;
+        vl = (vh << 63) | (vl >> 1);
+        vh >>= 1;
+        if (lsb) {
+            vh ^= rh;
+        }
+    }
+
+    out[0] = zh;
+    out[1] = zl;
+}
+
+static uint64_t octeon_gfm_reduce64(Int128 product, uint8_t poly)
+{
+    uint64_t lo = int128_getlo(product);
+    uint64_t hi = int128_gethi(product);
+
+    while (hi) {
+        int bit = 63 - clz64(hi);
+
+        hi ^= 1ULL << bit;
+        lo ^= (uint64_t)poly << bit;
+        if (bit > 56) {
+            hi ^= (uint64_t)poly >> (64 - bit);
+        }
+    }
+
+    return lo;
+}
+
+static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
+                                  uint8_t poly, uint64_t out[2])
+{
+    /*
+     * SNOW3G UIA2 uses the GFM datapath as a reflected 64-bit multiply in
+     * the low half of the 128-bit register pair.  When RESINP[0], MUL[1],
+     * and the high polynomial byte are all zero, octeon_gfm_mul() observes
+     * only x[1], y[0], and the low 8-bit polynomial.  Reflect those operands
+     * into normal carryless-multiply order and reflect the reduced result
+     * back into RESINP[1].
+     */
+    uint64_t vx = revbit64(x[1]);
+    uint64_t vy = revbit64(y[0]);
+    Int128 product = clmul_64(vx, vy);
+    uint64_t res = octeon_gfm_reduce64(product, revbit32(poly) >> 24);
+
+    out[0] = 0;
+    out[1] = revbit64(res);
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
 }
 
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_mul_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_mul[1]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect0(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[0]);
+}
+
+uint64_t helper_octeon_cp2_mf_gfm_resinp_reflect1(CPUMIPSState *env)
+{
+    return revbit64(env->octeon_crypto.gfm_resinp[1]);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect0(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[0] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_mul_reflect1(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_mul[1] = revbit64(value);
+}
+
+void helper_octeon_cp2_mt_gfm_xor0_reflect(CPUMIPSState *env, uint64_t value)
+{
+    env->octeon_crypto.gfm_resinp[0] ^= revbit64(value);
+}
+
+static void octeon_gfm_xormul1_common(MIPSOcteonCryptoState *crypto,
+                                      uint64_t value)
+{
+    crypto->gfm_resinp[1] ^= value;
+    if (crypto->gfm_poly <= 0xff && crypto->gfm_mul[1] == 0 &&
+        crypto->gfm_resinp[0] == 0) {
+        octeon_gfm_mul64_uia2(crypto->gfm_resinp, crypto->gfm_mul,
+                              crypto->gfm_poly, crypto->gfm_resinp);
+    } else {
+        octeon_gfm_mul(crypto->gfm_resinp, crypto->gfm_mul, crypto->gfm_poly,
+                       crypto->gfm_resinp);
+    }
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1_reflect(CPUMIPSState *env,
+                                              uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_gfm_xormul1_common(crypto, revbit64(value));
+}
+
+void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_gfm_xormul1_common(crypto, value);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {
-- 
2.53.0


