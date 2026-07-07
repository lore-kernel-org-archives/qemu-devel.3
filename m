Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0700EC43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAM4-0005PB-Hy; Tue, 07 Jul 2026 14:17:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALB-0004jL-TH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALA-0006Mh-1h
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTDK6018048
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XCd3xNqLnYMXo9r61o2LBClIiGLnFLXqbbTtEGj6akw=; b=onGltfCBZ3mG0OLq
 Yn43K8VqTegJbx4eYOulVDtsFF2o5FifN1PgzpKE/kTck/jVCzAS4HfkZXkQaBKV
 vwee+PSbvxG2h+xZWC+oADQRXreFqxOP+N52xVNsiFjOkztLmpm75cdGjziVXmAI
 U/yVIN4q99cGB50cBeXQK5qU3uyhTCjLElv4XQXTvvbHqhfV7li9tNTfFerYj3pp
 Z+OVdCzvXIRNKjS/2C+h39iGGyjMplFQekPlenPgZTjjJ1h8e7dT6jG7RBASfPpd
 +Ap1lXuhM+7jwlQc/BbsgMu1Q3c+an2AQb845n44DLEZ6HP5qLPdu0YVq+/BPfET
 Mqt2AA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2nx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:13 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a87ef9713so9916281cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448173; x=1784052973; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XCd3xNqLnYMXo9r61o2LBClIiGLnFLXqbbTtEGj6akw=;
 b=ZThfiUajVr/0xV/DaIXq+2WRbkDDRx8d45RZs3TKpmnhz1WzaeT59pNrP7yWrt0ZKM
 oT8zIJ6DT5WEllQb5x48E7aKnm5ta+7g38B1Zy3nOrctGt83nTeWTD4cziOAB7Vs44Tu
 t/2Yr+l91Mab29Xyr0QU1FxDIzfv7ZKTBpSn/VItYf3eP5ynfeecrkd7jasui5jd1qgD
 UkYlLsjwQL57lhoXB9V8GW1XbsePlAlBILwZr1Qjqaaf1nQkvqi2IK8rP7RIXrrgcWuI
 nNapglq9D0AvTljcszLgJAm+diiarSOyo6watrB7A7XMRrIu2Jdp+gCVNpotvq/68DEM
 OO/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448173; x=1784052973;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XCd3xNqLnYMXo9r61o2LBClIiGLnFLXqbbTtEGj6akw=;
 b=iVPEnvEagU3KNfo5qJmkp1mZe80jannJqwL3lqu6ei6Pu3ka9dBNsNNoZoExGnnMt4
 vt6zPz5lD/xLpSmGV2qbaNjuUnygQRLtlqOMfNVeqPczruLQABX3JvKpRo/pkS3km2rP
 sL9QR4zRYqqEQSA/RJy+0iZczuJ6nUIOLOt2JErz+dbf9jaoAzMFkaJoRPPN+obuVvq0
 FBsoCznRXY8LXU51dRRR4LAEAZfr4kYRtRBdop8jbsAnN6ar2ZjqdEit7YiLThbMJOmw
 dAGcM61xifhO2kfT8cgDV4JbxLBXHVWds8T5ZmB0wTgeGmeBtEwlEhMXYwdVs7Q/T8Pg
 979g==
X-Gm-Message-State: AOJu0YwhnujGm7opz/QO/ypz9r4uyru1zC20PtTi6mjHZpUyW+sEHuOk
 pXUzF9EQwTGqM4B7bso+QGBr98CTeLjkROo4ongXNUtgCA1EnBYRClEv/jXbgTvmlyzxFSmUyf+
 FtvKJhhz1W1Kem9q/z34zd1R+cO48TZ1TPjzmW8pYsrUv6JacQCpTQR8nQHrifjRgNA==
X-Gm-Gg: AfdE7cl5km2H8S+Kk8v65LJ5N2c6WkLK5yOw5/MzwoovRzPXqmmBultDBL24cexSF7u
 nFAKgMfcusL8Bi0WwJvpgZyEQxYb5yqMMwCX6N196TNI2Nb5L09AmcAYcuyolHTMf5FWTwCYNe2
 ethPsjc4tf7zqOMhGQh3mTPnoa3w87OD/lT10mug63B3ONQFSxqdGRFxKQAuRk+c07GWJwiU+Y8
 NjHWQEpGzzEUCQRKBaqNhzY7Kz0cJVgEPWmtSO43wVnhTn7ffEpLvVOkMPY6j7IQAd1uNsisR1c
 b0dDLloQSXNJdAEltdxkX4dZEmaZF5rcwF92QpaACTwtiswzbTfaRYMKdoVixvGRd6Qg86SyZ+w
 uaRHc4PMECpG32rxBrol74h/lQ1x5zlRWhBp9+Ut+ATa1XXwiqv7X1U40YNcGQEEIuAX6
X-Received: by 2002:a05:622a:4a88:b0:51a:8691:4427 with SMTP id
 d75a77b69052e-51c7a0d95f4mr41810581cf.0.1783448167773; 
 Tue, 07 Jul 2026 11:16:07 -0700 (PDT)
X-Received: by 2002:a05:622a:4a88:b0:51a:8691:4427 with SMTP id
 d75a77b69052e-51c7a0d95f4mr41809481cf.0.1783448166536; 
 Tue, 07 Jul 2026 11:16:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0fccf2dsm76535695e9.15.2026.07.07.11.16.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/23] target/mips: add Octeon SHA3 COP2 helpers
Date: Tue,  7 Jul 2026 20:15:10 +0200
Message-ID: <20260707181529.60191-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AVrZ2LKebaXi2_meqGXGfgwq_UzawjlE
X-Proofpoint-ORIG-GUID: AVrZ2LKebaXi2_meqGXGfgwq_UzawjlE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX5KmCYEEtNYOu
 RRrQY6dGwlmP9SJi/tKHCYOF7W84HbZuz2fcYe5AZJWY2mGR3M5S7nj5lkOZK7N9/B69MYlU+q6
 9QCxyBvz4ifUYUWdi9DMlUoqnvcSchavDOf+vIef+NqoZXhXlko1R/6SjTqZPZiLyQogna/0l76
 6HZusXb9C8IRUnrDGodJCf1Aofo4DOGAZCV2MNLfVufZieuzVXKHFjWK4fI+SG6X2eC5JXSa/N+
 P9IKKbXJjf3yPnH1rag+yVasJGtYLl7l4Jl7m/ODo2sLamj20GBmwO4C8G4KJHwjzHBqVBuwV2J
 nw3miEKCXqGlIx3w06vZD6GhabXVpvWH+cqFQktoP9lmwubgGZ28Ys5f5AcWSikksbh6ONul0Pe
 VxG639LUrecP/N1/JLPM3cjC/TKvaUV6P13NsE1A1QuGgAxTVC8f8hPHO0h3QS9U6Zx96VICdrY
 kmcfIJdPyFVcP6SSUbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfXw+GbdpFJnWAx
 OPW3IOUsrRCt7hplQV9EiQfUNYIt1m+TWKAX0BPE7E9SSOFnjKINS+wL+P3Gn9D58VWw+py1t9T
 XTBx2zPxKdL59lmwz4l6Rei0UBG8s58=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d426d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y2HmZ-R4G0JYE2J3qnkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
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

Add the Octeon SHA3 helper operations for the architectural 25-lane
Keccak state view and implement the Keccak-f[1600] permutation used by
the STARTOP selector.

The simple SHA3 DAT register moves and XORDAT selectors are decoded as
direct TCG transfers in the selector decode patch. This helper patch only
keeps the side-effecting SHA3 operation support.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-5-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |  1 +
 target/mips/tcg/octeon_crypto.c | 93 +++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 20ffbfb7096..b887e05199a 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -47,6 +47,7 @@ DEF_HELPER_2(octeon_cp2_mt_gfm_mul_reflect1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xor0_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1_reflect, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_gfm_xormul1, void, env, i64)
+DEF_HELPER_1(octeon_cp2_mt_sha3_startop, void, env)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index b417dcf53b6..cf718d64829 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -153,6 +153,94 @@ static void octeon_gfm_mul64_uia2(const uint64_t x[2], const uint64_t y[2],
     out[1] = revbit64(res);
 }
 
+static const uint64_t octeon_sha3_round_constants[24] = {
+    0x0000000000000001ULL, 0x0000000000008082ULL,
+    0x800000000000808aULL, 0x8000000080008000ULL,
+    0x000000000000808bULL, 0x0000000080000001ULL,
+    0x8000000080008081ULL, 0x8000000000008009ULL,
+    0x000000000000008aULL, 0x0000000000000088ULL,
+    0x0000000080008009ULL, 0x000000008000000aULL,
+    0x000000008000808bULL, 0x800000000000008bULL,
+    0x8000000000008089ULL, 0x8000000000008003ULL,
+    0x8000000000008002ULL, 0x8000000000000080ULL,
+    0x000000000000800aULL, 0x800000008000000aULL,
+    0x8000000080008081ULL, 0x8000000000008080ULL,
+    0x0000000080000001ULL, 0x8000000080008008ULL,
+};
+
+static const uint8_t octeon_sha3_rotation_constants[24] = {
+     1,  3,  6, 10, 15, 21, 28, 36, 45, 55,  2, 14,
+    27, 41, 56,  8, 25, 43, 62, 18, 39, 61, 20, 44,
+};
+
+static const uint8_t octeon_sha3_pi_lanes[24] = {
+    10,  7, 11, 17, 18,  3,  5, 16,  8, 21, 24,  4,
+    15, 23, 19, 13, 12,  2, 20, 14, 22,  9,  6,  1,
+};
+
+static uint64_t octeon_sha3_reg_to_lane(uint64_t value)
+{
+    /*
+     * The COP2 register interface is consumed by big-endian MIPS code as
+     * 64-bit register values, while Keccak lanes are byte-little-endian.
+     */
+    return bswap64(value);
+}
+
+static uint64_t octeon_sha3_lane_to_reg(uint64_t value)
+{
+    return bswap64(value);
+}
+
+static void octeon_sha3_permute(MIPSOcteonCryptoState *crypto)
+{
+    uint64_t state[25];
+
+    for (int i = 0; i < 25; i++) {
+        state[i] = octeon_sha3_reg_to_lane(crypto->sha3_dat[i]);
+    }
+
+    for (int round = 0; round < 24; round++) {
+        uint64_t bc[5];
+        uint64_t temp;
+
+        for (int x = 0; x < 5; x++) {
+            bc[x] = state[x] ^ state[5 + x] ^ state[10 + x] ^
+                    state[15 + x] ^ state[20 + x];
+        }
+        for (int x = 0; x < 5; x++) {
+            temp = bc[(x + 4) % 5] ^ rol64(bc[(x + 1) % 5], 1);
+            for (int y = 0; y < 25; y += 5) {
+                state[y + x] ^= temp;
+            }
+        }
+
+        temp = state[1];
+        for (int i = 0; i < 24; i++) {
+            uint64_t next = state[octeon_sha3_pi_lanes[i]];
+
+            state[octeon_sha3_pi_lanes[i]] =
+                rol64(temp, octeon_sha3_rotation_constants[i]);
+            temp = next;
+        }
+
+        for (int y = 0; y < 25; y += 5) {
+            for (int x = 0; x < 5; x++) {
+                bc[x] = state[y + x];
+            }
+            for (int x = 0; x < 5; x++) {
+                state[y + x] = bc[x] ^ ((~bc[(x + 1) % 5]) & bc[(x + 2) % 5]);
+            }
+        }
+
+        state[0] ^= octeon_sha3_round_constants[round];
+    }
+
+    for (int i = 0; i < 25; i++) {
+        crypto->sha3_dat[i] = octeon_sha3_lane_to_reg(state[i]);
+    }
+}
+
 uint64_t helper_octeon_cp2_mf_crc_iv_reflect(CPUMIPSState *env)
 {
     return octeon_crc_reflect32_by_byte(env->octeon_crypto.crc_iv);
@@ -222,6 +310,11 @@ void helper_octeon_cp2_mt_gfm_xormul1(CPUMIPSState *env, uint64_t value)
     octeon_gfm_xormul1_common(crypto, value);
 }
 
+void helper_octeon_cp2_mt_sha3_startop(CPUMIPSState *env)
+{
+    octeon_sha3_permute(&env->octeon_crypto);
+}
+
 void helper_octeon_cp2_mt_crc_write_iv_reflect(CPUMIPSState *env,
                                                uint64_t value)
 {
-- 
2.53.0


