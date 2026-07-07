Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02B3C44503
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:21:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMg-0006Nr-5E; Tue, 07 Jul 2026 14:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALa-0005B7-4b
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALU-0006PB-FV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT8Ep017943
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GuFm/jE/wf7BKZT68Hx+ZYHvSygRcmivlthYrV4stSk=; b=cC7pvcl8FukgBYth
 WpA0/grmJCh/pZR03jaGoupnuK04HJuWdVOkA0U2NszwNoaPgSsNcZyNaBPg6tT6
 OgmCijV1mAZjdj6HTcvUgce/1KuGArGnSllRco7XGwTsIEnMLPauV4nXRTaEF1ju
 IzbcSFqLkzB+BHeea13XUw5zLdMoTo+GIxav5pSZT0VBkGHLrQEOFiLLewkJCS0I
 w1boxXKc6Odr6VFZGwgD6sfspNreSlfoRGlXge99i4E7Lle53ktrOMXk4CZM7PJp
 eInDwRFT4Ms4pONdYascBjroTRtSevgSoQGTLMHX1hFq0ZuLPi6GHaPQcoO88gtq
 acLYOg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep2nyg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c20762d21so55312131cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448193; x=1784052993; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GuFm/jE/wf7BKZT68Hx+ZYHvSygRcmivlthYrV4stSk=;
 b=aN7ayZn7og5eiHa7wsDS46eaEu2C9BXCS9x96TzH2yJNnkY5li8/53booPlNSo0ElB
 DbYyEIqjSscgQxT4PYiNA5zpgrS+MSkFj83RhXWdnbfLdIUn1YHtywARNk8CF60Vtxjb
 l2beM9QHvCTgKvVT51/U8k1AHvv4aDugx77H61tT3OkiAn933rfyJ7ruKsJm9YdSXmrY
 kJBe6k6TCG3IuxCsO4ZRlQAnil8rIfvsqHJT3ezERhLmRy/5+vkgfKkwpdtneBFvj8Sl
 Tfpt7Uez30Kwi0xaH7hkGGUNHtSQRaEgAaNhTqI+6OiB5oB/BYnFkj0ta5QhRZCnwqKR
 DFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448193; x=1784052993;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GuFm/jE/wf7BKZT68Hx+ZYHvSygRcmivlthYrV4stSk=;
 b=QR5m5fBJNcUadeeBnS+ml2HqptiyQ+3SF77S5Ui60CSCKGjUfP2WZgQCMxnLl7sSf4
 w4RtLskcElKeNb1nZORbKgJhzvIHSoWEH++qc1eCNLmN6RfgZuJvQZp1hOD/HeJ8nT3M
 h0d3f99+uzCxQUHHqJmNWxvIecCWqnWGoozVcdSjDVsEFWVdvdm4ct6/TXucB86OOjmF
 uHeE9+wZzuNyykzwrUEC8mClwbkSw0ycUNcSqZDgHB3t2NUJIkU7DPHBAEYEOkPhWgBw
 xmsL5xOgBV6+N5/d8BKxl7kqqsKBjIvjT+SNrM8YXICevaXUpfEzbHXiz3Nhp/zKiqj1
 XJ8A==
X-Gm-Message-State: AOJu0Yze1uOvAjFrPHkg/CTQgvBQbpKZdTSVM6Ujg//YbWicEzX6fAR6
 X/Ccfwlcd29/14AMjVEBxz7AwMNS6dwBGX1D/mKtLeHUNntWNyfWtD/YEgfaz9IpAAkL4YNfMiB
 16PBcGEslRFyNB+JWTax1E1h925XIttcCqQ+MsbIaPu1DJxH7wkKfoLUz32RFtGrI+g==
X-Gm-Gg: AfdE7cnShOqxn32ywG0+Lpodr6K12h1JP62+EA0FqeOWIXpq97Jq0sSp2EirlV2bICY
 Q8y1j3GcAJer2AZBmlsKTnKnOo7ubwHcovWSTq0av1VeW5ViGG4P1FrHmwWFtDxlO70ZbGKgrqA
 RNloawBVCGkg+KsOKVjerM/bKbWrjFmpEqjvt0Uc5qh/0cHAZAEaVjIQnx7IyJtD6XZpErbPSgY
 onbN97MgLxCOM4l2fqNmegj1Ef99/yjoskwBphTFoCGZ6dF7k75s0f608zIiG0Nnzk+tlU8XRuG
 7sRkV/yyikMxzj9w7z9piLxgYX9aIDT/Zss192Hu2m1qqX3Nms6fpsuuHeGLWgslgw1dHZkitBO
 wIjlnXRUvqGcm2uIT8zadmzCvBhVC8kfKr7eLYZhEJ3mUZBMGHOxj6SZS+7VmeNnvRrd7
X-Received: by 2002:ac8:5f4b:0:b0:51c:1d67:379 with SMTP id
 d75a77b69052e-51c747bb735mr66289221cf.23.1783448193174; 
 Tue, 07 Jul 2026 11:16:33 -0700 (PDT)
X-Received: by 2002:ac8:5f4b:0:b0:51c:1d67:379 with SMTP id
 d75a77b69052e-51c747bb735mr66284331cf.23.1783448187523; 
 Tue, 07 Jul 2026 11:16:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493e0f294a6sm144099735e9.1.2026.07.07.11.16.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/23] target/mips: add Octeon AES COP2 helpers
Date: Tue,  7 Jul 2026 20:15:13 +0200
Message-ID: <20260707181529.60191-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7IwV2qpvd1H3S2f6Z4P-ctHcHKBfTLk7
X-Proofpoint-ORIG-GUID: 7IwV2qpvd1H3S2f6Z4P-ctHcHKBfTLk7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX3lemBd2icobe
 AWu1icfTmxpL436mR7tloJgz5aYvyyO5Lq667frHE/J4aw4HvMP0oRIYkapC44e38A/MH9Mvi0e
 iIk3k+VfB+/tdBgTeCOmDF+OuEjOfAobPFr81YK3MsQC1pPnbhHVonNBNHStw8eSRQiFJzmUHzM
 l/uiEnkoznlhlEfESjwYFz8yCG5x1UlC+A2KFHDnxe4CuEcWWLyneT+aRp7q2TvNE3VuBvPlLNh
 rMDX6Pl4pdgWXh3ImszvWPrmtdTaMr3svWkC2jfj83QTOxyUlvxO6KMUFEz+eRBsUXxAeOBUCal
 pnHT8yRC8+DMDu1zYkSPd2l83Zcv9ylLfubSHtHx9xcndGJUGI4VWN+j7sbe/DPdC4M3YhqG61F
 rwx/JJVeNJ0c9jl0Yxcieuy7hjc/Ex75fL3tefxOgBTd0kpye/gec6MuAh0sHjg9LCPQ61jqsEg
 AqT36nhR1yVubjAqLMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX2w9uoa4xeJcB
 EBdkiU/vjnE9SQHcNDL86Lx3NrIlSdANS41URiUQjwRE0wXPJaU7N9msSgGKrLLT8UGgniZrxv+
 aw5RW/yZ2/Yf2Jcrzj8++3orKz2NQFc=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4d4282 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=EKV_0V3Nn1vJCTxTkoUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
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

Add helper support for the Octeon AES operation selectors. Direct
register-transfer selectors do not need helpers; the ECB/CBC encrypt and
decrypt operations consume the AES input, key, IV, and key-length state.

AESRESINP is modeled as one architectural register bank; operation
helpers consume the current AESRESINP block and write the result back to
the same bank.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-8-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   4 +
 target/mips/tcg/octeon_crypto.c | 145 ++++++++++++++++++++++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index c4e7693df63..39c226ded92 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -52,6 +52,10 @@ DEF_HELPER_2(octeon_cp2_mt_zuc_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_zuc_more, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_start, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_snow3g_more, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 930a67346ef..117e3a5026e 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -840,6 +840,151 @@ static void octeon_snow3g_more(MIPSOcteonCryptoState *crypto)
     octeon_snow3g_queue_result(crypto);
 }
 
+static int octeon_aes_key_bits(const MIPSOcteonCryptoState *crypto)
+{
+    enum {
+        OCTEON_AES_KEYLEN_128 = 1,
+        OCTEON_AES_KEYLEN_192 = 2,
+        OCTEON_AES_KEYLEN_256 = 3,
+    };
+
+    switch (crypto->aes_keylen) {
+    case OCTEON_AES_KEYLEN_128:
+        return 128;
+    case OCTEON_AES_KEYLEN_192:
+        return 192;
+    case OCTEON_AES_KEYLEN_256:
+        return 256;
+    default:
+        return 0;
+    }
+}
+
+static void octeon_aes_load_key(const MIPSOcteonCryptoState *crypto,
+                                uint8_t *key, size_t keylen)
+{
+    stq_be_p(key, crypto->aes_key[0]);
+    stq_be_p(key + 8, crypto->aes_key[1]);
+    if (keylen > 16) {
+        stq_be_p(key + 16, crypto->aes_key[2]);
+    }
+    if (keylen > 24) {
+        stq_be_p(key + 24, crypto->aes_key[3]);
+    }
+}
+
+static void octeon_aes_load_block(const uint64_t regs[2], uint8_t *block)
+{
+    stq_be_p(block, regs[0]);
+    stq_be_p(block + 8, regs[1]);
+}
+
+static void octeon_aes_store_block(uint64_t regs[2], const uint8_t *block)
+{
+    regs[0] = ldq_be_p(block);
+    regs[1] = ldq_be_p(block + 8);
+}
+
+static void octeon_aes_encrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        int i;
+
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        for (i = 0; i < sizeof(in); i++) {
+            in[i] ^= iv[i];
+        }
+    }
+
+    AES_set_encrypt_key(raw_key, bits, &key);
+    AES_encrypt(in, out, &key);
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, out);
+    }
+}
+
+static void octeon_aes_decrypt_common(MIPSOcteonCryptoState *crypto, bool cbc)
+{
+    AES_KEY key;
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint8_t raw_key[32] = {};
+    int bits = octeon_aes_key_bits(crypto);
+    int i;
+
+    if (!bits) {
+        return;
+    }
+
+    octeon_aes_load_key(crypto, raw_key, bits / 8);
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        memcpy(next_iv, in, sizeof(next_iv));
+        octeon_aes_load_block(crypto->aes_iv, iv);
+    }
+
+    AES_set_decrypt_key(raw_key, bits, &key);
+    AES_decrypt(in, out, &key);
+    if (cbc) {
+        for (i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_aes_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_encrypt_common(crypto, false);
+}
+
+void helper_octeon_cp2_mt_aes_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, true);
+}
+
+void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_aes_decrypt_common(crypto, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
-- 
2.53.0


