Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3EBC44502
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAKt-0004Ws-Fa; Tue, 07 Jul 2026 14:15:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKq-0004Lk-AR
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whAKo-0006Ka-EV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:15:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667GxYbI187936
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 frYxSiaK3qJwcC0U9uDP6i2C7oqCrcJgFrCBCNGWUJI=; b=YdGV17huhschw1jV
 WbQO07oicJeOat9R/HuV+UGp2ejHG2n8aCTRyhtILA/qKXYbNUWqTFR3r/3mh799
 sQZqbnI7cbBMk8lDmmY+ngsdymTIxLVNkmuUryMkzzUMzyziy9gPR2wbIIAeT/cb
 ZO3TtXU2MRxH76qFolTfop6yGB5IIdXDxZ5M6YscSy5QdwB0FKor1rOwji1IZSf3
 waujanbGJadRc3dCm9LPtM3HeS5lwyKlllsSUF4UlDU3+qjcXl546qnBgpae4620
 cJdaLEl/hhrO+DLuhhgFN0sGbaYSmauTm5aNdBRD29DKadc1K7FIzTv4fpuAvl4R
 CZsCIQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f95fd0c6h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:15:53 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0e702df8so55419061cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448153; x=1784052953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=frYxSiaK3qJwcC0U9uDP6i2C7oqCrcJgFrCBCNGWUJI=;
 b=eMYkqwcK07AB+LFMcXoUI6aBXeUslzmFO4/OF5mptnLHmQ0ePGEjq0K3KP1nXEmgku
 FpPqlfR8aPgw+K+TDr8OfMl67gxIUjgLqXPlBQ2DlP0y7KHZ18hs49zPU77dqqIZhjSG
 tUGVllzEKLaiwQitAbhbWOCIuy1U3cpp/tkNV/voThTs4N1HNUO23mRfEwZpOuP2KG1P
 5fWJmmO1CeNSJCY6EBjWgLx/OhWYo2yVTY/PoW1xcu2OO0jHoy7AhiiVeoyhoT4wSfQ9
 fvZVzAMwm9/C5l9WsjfTcFHp6rcKSsGRkr1ZuaLNXowFhLuqnHLLB19le6j+b9BjSQF2
 9sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448153; x=1784052953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=frYxSiaK3qJwcC0U9uDP6i2C7oqCrcJgFrCBCNGWUJI=;
 b=j3y8DDAicl7Rbyd/AqTixmuRdRAvj+cwfI3lxXOWv7Nhovh61J9tgDcVOObr8xUDJ6
 8rOdqZEX9qKUdDc+5pP2H3j7bQ4AVJqdyKHPfXofN2NFmYHsOz+gDQTyZSJlLlPu2Ifw
 CyTeoh5zJpqWWcJgfBtryJaVOkbVGe2k0gQbHWfpYmqr2glMJ06Fbn2zv/cGCWZ7ouus
 7T1MziIODq/VcfIR9sAp+Womm8/Rzb6XXfRwARz5mV/8TjWokNag3q3yl8/wDMGM0DZT
 EPoyVb6ApMqq73HGvFAb5oYlcNZIDDX2hhEw/4PkUWloAQ0Laj7MHyTRrGSVzcX6N2RB
 ptdw==
X-Gm-Message-State: AOJu0Ywbzsvn6nYQAAnF7Jletpfhmg2sr0fbeUsYMhLHGO48yi+kBCzT
 1EYwcEgExiItShFZWdIlS+s/x6ToH2rSeDaNpfDy1FoX3EK7MJXIVERsPiuKfBC+PViYEfKTKVF
 jliB9LKnvXuokOhSupgYqwZKaJt3b4oUXSRQPiwNJtOgu8HiCPJgqOPvmtppXihKu6A==
X-Gm-Gg: AfdE7cnl/0dW0xE8d5nkAqVbg5IuqFya/X1jtMaCm0e3JzHNCiS7XHWohv6/RUfhxvo
 8x60B/z0KYCTjj8Wdp8QjPibBgnMW9DbffPVBNgxnLXO0+fWzyyG9sHkt+E3/fvfHtE4Ug0OlzJ
 pqDL8R07hcKaxUkYizY0fnwwJpH1twZvfzpgukemHED1vf+gKbwA6N/QsTvnkoBrWSZAt/ehjRP
 fd5cdXaX/FiK5tt73jw/yAJGUm/w6UljOWQ5DTvvD0CFI58uHDXHYXE9uDTS61R7RwkMRtOdibw
 ieStgtE3Wo4f1S2dEUebsHIrf4Yg3aVwi1/UrJIJHVedKd3flnOjC1AUYls6Xh9ijsf38n+5ZuD
 T7mmownGdhP0ZIwz9YPIshsmpkD4Bgc9p+ej6jEQWnZYWDa2EEC0dXL+NK88hEUi6XGX6
X-Received: by 2002:a05:622a:1a88:b0:51c:1fa1:80d3 with SMTP id
 d75a77b69052e-51c74856e20mr67221831cf.49.1783448152668; 
 Tue, 07 Jul 2026 11:15:52 -0700 (PDT)
X-Received: by 2002:a05:622a:1a88:b0:51c:1fa1:80d3 with SMTP id
 d75a77b69052e-51c74856e20mr67221281cf.49.1783448152016; 
 Tue, 07 Jul 2026 11:15:52 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm144040435e9.1.2026.07.07.11.15.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:15:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/23] target/mips: add Octeon CRC COP2 helpers
Date: Tue,  7 Jul 2026 20:15:08 +0200
Message-ID: <20260707181529.60191-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX4+7972wstHIv
 7SxHeiRSTrRDCaKX7/OedSLOmW4+mDfUWUDXmsRZU8JMksPkMal13G1kD8hty0V8EEsRwk9AgK6
 I/s5g1XOo1CbdrYjSKmklwBf5Pq512Sqza7hTdrVaUJRfzGhpkKa8bU/gvBjcP4gVy2g4xSMlIZ
 ijjw9BSpu77NQGbVVx3uJhEBSoWbXEK5sDPIo9giH3s3MyKjf7JCdf6bXAjpoRG2k6QBH4dxBAQ
 K8C5w+X8a3o+VeFnLcUHA/DtIdJYWl3wdvofPYxnLCV+Z2RZGybCN20iK2ybxx99PUAWQ4qb5cu
 rjAuFslx91sdvRuOM/TapEXgfLIA+3TtJOuXJ5/Nc19rmGIBUYh+RCW3yn2zBY6y4YyVs6hurUj
 35hlIDDBKu8Nw9Ux9iaKw9AZGH6VCwOyjh3dnwq6yhpOkJDIn5F9iMsfnYDSgJ025lDe1oV3DMg
 4v6NbNRcc85xYld4DHg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=6a4d4259 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PXyl_kNEWH3ax5_YoicA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: VW-Mz4N85-kPpkim0d8L8w445hM0MuFs
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX8oHc/M2EdQFV
 P2RP0mlhXC3Zze37kwFhhcvqDyARhJYfxKA6gdQFps8vM3AHQ5beb+9nxpTL84EsPWMqXiTuLca
 QgnNoRGrpdSmC/zsxpCkHnGLO/DJ0po=
X-Proofpoint-GUID: VW-Mz4N85-kPpkim0d8L8w445hM0MuFs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607070179
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Add helper support for the Octeon COP2 CRC register interface. This
covers normal and reflected CRC state handling, byte/halfword/word/
doubleword/variable-width update selectors, and the reflected IV readback
operation.

Register moves that can be represented as direct TCG loads/stores do not
need helpers. Add only the side-effecting CRC helper implementation here.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-3-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |  14 ++++
 target/mips/tcg/octeon_crypto.c | 131 ++++++++++++++++++++++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index e2b83a1d19d..e802f50fd6e 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -25,6 +25,20 @@ DEF_HELPER_3(crc32, tl, tl, tl, i32)
 DEF_HELPER_3(crc32c, tl, tl, tl, i32)
 DEF_HELPER_FLAGS_4(rotx, TCG_CALL_NO_RWG_SE, tl, tl, i32, i32, i32)
 
+/* Octeon COP2 selector operation helpers. */
+DEF_HELPER_1(octeon_cp2_mf_crc_iv_reflect, i64, env)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_iv_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_byte_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_half_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_word_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_dword_reflect, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_crc_write_var_reflect, void, env, i64)
+
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
 DEF_HELPER_4(swm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index df5b0449aeb..c589077ea7c 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -14,3 +14,134 @@
 #include "crypto/sm4.h"
 #include "qemu/bitops.h"
 #include "qemu/host-utils.h"
+
+static uint32_t octeon_crc_reflect32_by_byte(uint32_t v)
+{
+    return bswap32(revbit32(v));
+}
+
+static uint32_t octeon_crc_state_reflect(const MIPSOcteonCryptoState *crypto)
+{
+    return octeon_crc_reflect32_by_byte(crypto->crc_iv);
+}
+
+static void octeon_crc_set_state_reflect(MIPSOcteonCryptoState *crypto,
+                                         uint32_t state)
+{
+    crypto->crc_iv = octeon_crc_reflect32_by_byte(state);
+}
+
+static void octeon_crc_update_normal(MIPSOcteonCryptoState *crypto,
+                                     uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = crypto->crc_iv;
+    uint32_t poly = crypto->crc_poly;
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= (uint32_t)byte << 24;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 0x80000000U) {
+                crc = (crc << 1) ^ poly;
+            } else {
+                crc <<= 1;
+            }
+        }
+    }
+
+    crypto->crc_iv = crc;
+}
+
+static void octeon_crc_update_reflect(MIPSOcteonCryptoState *crypto,
+                                      uint64_t value, unsigned int bytes)
+{
+    uint32_t crc = octeon_crc_state_reflect(crypto);
+    uint32_t poly = bswap32(crypto->crc_poly);
+
+    for (unsigned int i = 0; i < bytes; i++) {
+        uint8_t byte = value >> ((bytes - 1 - i) * 8);
+
+        crc ^= byte;
+        for (int bit = 0; bit < 8; bit++) {
+            if (crc & 1U) {
+                crc = (crc >> 1) ^ poly;
+            } else {
+                crc >>= 1;
+            }
+        }
+    }
+
+    octeon_crc_set_state_reflect(crypto, crc);
+}
+
+uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
+{
+    return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
+}
+
+void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
+                                               uint64_t value)
+{
+    env->octeon_crypto.crc_iv =
+        octeon_crc_reflect32_by_byte((uint32_t)value);
+}
+
+void helper_octeon_cp2_mt_crc_write_byte(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword(CPUMIPSState *env, uint64_t value)
+{
+    octeon_crc_update_normal(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_normal(crypto, value, MIN(8U, crypto->crc_len & 0xf));
+}
+
+void helper_octeon_cp2_mt_crc_write_byte_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 1);
+}
+
+void helper_octeon_cp2_mt_crc_write_half_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 2);
+}
+
+void helper_octeon_cp2_mt_crc_write_word_reflect(CPUMIPSState *env,
+                                                 uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 4);
+}
+
+void helper_octeon_cp2_mt_crc_write_dword_reflect(CPUMIPSState *env,
+                                                  uint64_t value)
+{
+    octeon_crc_update_reflect(&env->octeon_crypto, value, 8);
+}
+
+void helper_octeon_cp2_mt_crc_write_var_reflect(CPUMIPSState *env,
+                                                uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    octeon_crc_update_reflect(crypto, value, MIN(8U, crypto->crc_len & 0xf));
+}
-- 
2.53.0


