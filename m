Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4157EC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 18:22:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whAMT-00066x-Ti; Tue, 07 Jul 2026 14:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALa-0005B6-44
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whALW-0006PK-3J
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 14:16:40 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FT3BU4130287
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 18:16:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0xSsbyWYVQowYc1hLq5nR7qvqE9dZIS5qYJuw/rgqQg=; b=j55yUb9idck7ttLc
 cHJdQBJw/faEAth1f2+4uEu2A9AYaKHDRrNB6NWBAYUYzLXPB0OmYKyRdGHRl9gb
 OvyRCGQ1mWDAh5ZNc1szJAk2cJE41ByBoTwf9SCSHL29XlW4DYVCo+pwy+/CMfiF
 9fK99rhsUX35YWe5kFZZ7cMJT2f9iwHa4W+kicOnb9Qhp7VuoxzhREmkt4Nt6nl7
 F6OqWKFnwn8al99TIHSlCcXujljJrCAMA8QoXMga3u2RtjC9MHT1JLno1tHk3+gf
 HYubfXT0CuwZuH8vBOsrlU9GdfTAQXq5f1757HC3VwFf8B8dNVJeC9wGIZrpw51w
 H8PJ3g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8t15bhmj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 18:16:36 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ec3314f65fso48725166d6.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 11:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783448196; x=1784052996; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0xSsbyWYVQowYc1hLq5nR7qvqE9dZIS5qYJuw/rgqQg=;
 b=aAzDmKe8m4oDrh1AYS09Cc+R3Pkuk3SlEYl6D4GhWkCgIP+apdBFC5HVDGdOpHUWbz
 Mkw66FcpVAey2BJkaKEixx2hXzAzBYJEBd4apD6C0VwhymojddKUSzNg1iWgD65oVSBJ
 6BsY29q0mdm7K2N1PuFhz+k9FBi5GHZMkmomYjKa6F+GP8Ofdsm78IRdYKXJkw7w3AQU
 REBxna6vj20veZmyGH6IP0/NVj8uhFV79VaxxbKL8aZ4qP+LkPFZb61yjS8H0v7xYKGW
 XJZiBZBrT2RvUWcQWrbrcKmteDfHQ23N2NzLbai2SZ68wD0yaIG92zF7ZD5r/pHcJAVC
 ZF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783448196; x=1784052996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0xSsbyWYVQowYc1hLq5nR7qvqE9dZIS5qYJuw/rgqQg=;
 b=og9SLAjd6r/i6ioOAlfGcrR8D4dBkYvv9GoHOAVQQm7LQjqu9J9j6uN1FRZgE2A6Tc
 S4RnrgQn7t3TU2cdTER4iu8cCOqKiUt1omtGd1OfYk/sDlaB7806aPNaOfc5fkFI/inw
 uAGr+DxMz3CZYRQLNB4qpDKGRrQnA38SvubjRVnILRKR0N6g6poxu7SfuXEoP8TsqyIY
 JO1DC8/XebBQh388TMcJ+rhq/8c2iwOIf8ijfYYWLg6ETx0dTe4I7o2Brga6KlHDHTQT
 6TjuD8KPEMwJy+XxV1wiVh9xGbSoeTT5IVZlE7wZLKhMtNzcLfeP4H6J3OakUGgDizmb
 O8rQ==
X-Gm-Message-State: AOJu0Yy8FP7R8pbZMyvyux804uWhv0m06vllmJZs+eHNt35Y/AlLx6Le
 0l1iidbNVo3HXdyvcntSCFxAPSIvzTUVwhqH3z8Fg9fDO92iPvf81NtC9VBRrSKNLCI3PEGJO5C
 IkkK82K7cSNcQk/hHY2+6ctA0l51XcLPM66OGewTZGfVi4akEETvhkdXo9Pr2Pv3SYw==
X-Gm-Gg: AfdE7cmNp4r3PwtJQcuJbSpDtvaMdim2zF3Ncypd+Pf2UqhruErMQryCTJ6vC2jEJpB
 ts2fRndmHgewcpfGQxz1XL6vv9gPlZvh4sqO+vEKwg7I4oqcVP8woOs33i4fR8ZdSr8KCMDUU2G
 Pq8PWGm/RN5THf/U9WDfKCjHzsnyqS38wmF0glWyKBCr+MIsPfxCJfFbqisPTvnDyz7SX7mWCNe
 aCHHObxXg8CVnWKO+aCfRbeMzoOAhkQBK8UeiG2q9dWV/PrY2XazB/27oBi6XRZ4YHGs+yuSlpb
 4ixiU1/LuOX/ttxkcwGG+PR/AEUwQ5Q6HgCmP1e43KwwUmtGDZjoYsGkt6u+RjCy4X6JdogLcRV
 rT+F4dYJ6NgwkYjupdT7IYsTJJVCRDLkb0DyFZadT78qiYT1FcfguAQaIMidJ3JKib/ra
X-Received: by 2002:a05:622a:20a:b0:51c:167d:b328 with SMTP id
 d75a77b69052e-51c748852d5mr66189101cf.40.1783448195362; 
 Tue, 07 Jul 2026 11:16:35 -0700 (PDT)
X-Received: by 2002:a05:622a:20a:b0:51c:167d:b328 with SMTP id
 d75a77b69052e-51c748852d5mr66188471cf.40.1783448194445; 
 Tue, 07 Jul 2026 11:16:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960b06sm34938694f8f.28.2026.07.07.11.16.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 11:16:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/23] target/mips: add Octeon SMS4 COP2 helpers
Date: Tue,  7 Jul 2026 20:15:14 +0200
Message-ID: <20260707181529.60191-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707181529.60191-1-philmd@oss.qualcomm.com>
References: <20260707181529.60191-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: zoRwb4FvRmhmOfvkiyJrwSJmp3ztEB4j
X-Authority-Analysis: v=2.4 cv=HstG3UTS c=1 sm=1 tr=0 ts=6a4d4284 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=-q6YWustoGv2AnBTiSgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: zoRwb4FvRmhmOfvkiyJrwSJmp3ztEB4j
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX0wx/vAAgr2wn
 B4b0oMbe3Z2ibbsh5bAvJeisCqC6fBzqfpKvh3jsQ6iIVndOznbj7kHHQPw++n6lk2oCGK8bjS5
 shy4NjViaCP6XYxsto676uzitCH2Hx4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3OSBTYWx0ZWRfX+zj0eyOkr+nr
 lpKeTItBq+aAy4sIXlRZ7zVgSVNYWXhi4bDaI1qmznTlbq5elQ4hJa/QKdh2RJXPNV0WFb1YB3z
 3JFs8HoFhHGNwKhhwD2Yl36ZVNAgDGtt00isKeJ2kA0cEsSxLKnt43d/U3UaX0j0RvvOOIxilAU
 AA8au621DB7uDeki4lpP6cMSavMdf3X8tLd+KnpXF3quXHe3srdMURK2sf5ywzxm1BrHIMm1BTX
 CA4Lo1CRO5ScRxFmwO47ueSK6Ko9XeFjhFJrj0zL2qKbYIn9ZRqLAS4OTK2L8waLWq13xdLOgqt
 iO61M0gaFfoOSxaebo+ISRWW4RPRV3d5t+nSUrbN5ceOHbnBwDxIazRg8A8xmnpykqqEHEeWZwl
 0fH/0ko3j9EHibA3U6ypw8yTeSYGfh6C9gdFFz0n+m6IpsuK+8GqIZ12WG7WVISSJZZZXs0yVy9
 KALxaQTd0zWEzVhaEhw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070179
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

Add helper support for the Octeon SMS4 operation selectors. SMS4 reuses
the AES RESINP, IV, and key banks, so the helpers share the existing AES
state while implementing the SMS4 ECB/CBC encrypt and decrypt operations.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Message-ID: <20260608-mips-octeon-missing-insns-v2-v16-9-daef7a0d8b04@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/helper.h            |   4 ++
 target/mips/tcg/octeon_crypto.c | 123 ++++++++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/target/mips/helper.h b/target/mips/helper.h
index 39c226ded92..4949b94657f 100644
--- a/target/mips/helper.h
+++ b/target/mips/helper.h
@@ -56,6 +56,10 @@ DEF_HELPER_2(octeon_cp2_mt_aes_enc_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_enc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec_cbc1, void, env, i64)
 DEF_HELPER_2(octeon_cp2_mt_aes_dec1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_enc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec_cbc1, void, env, i64)
+DEF_HELPER_2(octeon_cp2_mt_sms4_dec1, void, env, i64)
 
 /* microMIPS functions */
 DEF_HELPER_4(lwm, void, env, tl, tl, i32)
diff --git a/target/mips/tcg/octeon_crypto.c b/target/mips/tcg/octeon_crypto.c
index 117e3a5026e..bcffd17ab6c 100644
--- a/target/mips/tcg/octeon_crypto.c
+++ b/target/mips/tcg/octeon_crypto.c
@@ -985,6 +985,129 @@ void helper_octeon_cp2_mt_aes_dec1(CPUMIPSState *env, uint64_t value)
     octeon_aes_decrypt_common(crypto, false);
 }
 
+static uint32_t octeon_sms4_t(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 2) ^ rol32(x, 10) ^ rol32(x, 18) ^ rol32(x, 24);
+}
+
+static uint32_t octeon_sms4_t_key(uint32_t x)
+{
+    x = sm4_subword(x);
+    return x ^ rol32(x, 13) ^ rol32(x, 23);
+}
+
+static void octeon_sms4_expand_key(const uint8_t *key, uint32_t round_keys[32])
+{
+    static const uint32_t fk[4] = {
+        0xa3b1bac6U, 0x56aa3350U, 0x677d9197U, 0xb27022dcU,
+    };
+    uint32_t k[36];
+
+    for (int i = 0; i < 4; i++) {
+        k[i] = ldl_be_p(key + i * 4) ^ fk[i];
+    }
+    for (int i = 0; i < 32; i++) {
+        k[i + 4] = k[i] ^ octeon_sms4_t_key(k[i + 1] ^ k[i + 2] ^
+                                            k[i + 3] ^ sm4_ck[i]);
+        round_keys[i] = k[i + 4];
+    }
+}
+
+static void octeon_sms4_crypt_block(const uint8_t *in, uint8_t *out,
+                                    const uint32_t round_keys[32],
+                                    bool encrypt)
+{
+    uint32_t x[36];
+
+    for (int i = 0; i < 4; i++) {
+        x[i] = ldl_be_p(in + i * 4);
+    }
+    for (int i = 0; i < 32; i++) {
+        uint32_t rk = round_keys[encrypt ? i : 31 - i];
+
+        x[i + 4] = x[i] ^ octeon_sms4_t(x[i + 1] ^ x[i + 2] ^
+                                        x[i + 3] ^ rk);
+    }
+    stl_be_p(out, x[35]);
+    stl_be_p(out + 4, x[34]);
+    stl_be_p(out + 8, x[33]);
+    stl_be_p(out + 12, x[32]);
+}
+
+static void octeon_sms4_crypt_common(MIPSOcteonCryptoState *crypto,
+                                     bool encrypt, bool cbc)
+{
+    uint8_t key[16];
+    uint8_t in[16];
+    uint8_t out[16];
+    uint8_t iv[16];
+    uint8_t next_iv[16];
+    uint32_t round_keys[32];
+
+    /*
+     * SMS4 aliases the AES state onto the RESINP, IV, and KEY banks,
+     * with only the operation selectors remaining distinct.
+     */
+    octeon_aes_load_key(crypto, key, sizeof(key));
+    octeon_aes_load_block(crypto->aes_resinp, in);
+    if (cbc) {
+        octeon_aes_load_block(crypto->aes_iv, iv);
+        if (encrypt) {
+            for (int i = 0; i < sizeof(in); i++) {
+                in[i] ^= iv[i];
+            }
+        } else {
+            memcpy(next_iv, in, sizeof(next_iv));
+        }
+    }
+
+    octeon_sms4_expand_key(key, round_keys);
+    octeon_sms4_crypt_block(in, out, round_keys, encrypt);
+    if (cbc && !encrypt) {
+        for (int i = 0; i < sizeof(out); i++) {
+            out[i] ^= iv[i];
+        }
+    }
+
+    octeon_aes_store_block(crypto->aes_resinp, out);
+    if (cbc) {
+        octeon_aes_store_block(crypto->aes_iv, encrypt ? out : next_iv);
+    }
+}
+
+void helper_octeon_cp2_mt_sms4_enc_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, true);
+}
+
+void helper_octeon_cp2_mt_sms4_enc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, true, false);
+}
+
+void helper_octeon_cp2_mt_sms4_dec_cbc1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, true);
+}
+
+void helper_octeon_cp2_mt_sms4_dec1(CPUMIPSState *env, uint64_t value)
+{
+    MIPSOcteonCryptoState *crypto = &env->octeon_crypto;
+
+    crypto->aes_resinp[1] = value;
+    octeon_sms4_crypt_common(crypto, false, false);
+}
+
 void helper_octeon_cp2_mt_snow3g_start(CPUMIPSState *env, uint64_t value)
 {
     octeon_snow3g_start(&env->octeon_crypto, value);
-- 
2.53.0


