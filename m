Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85419606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DU1oacy4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J7B4wvn3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJQiV-0007Da-Q4; Wed, 21 Oct 2026 03:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQiL-0007Cg-UY
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:26:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJQiI-00014Q-S0
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 03:26:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L5ivB5164981
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2zoaF2iR+Wz6pFtnanrhWuer4x1dALmitloSery1EN0=; b=DU1oacy44htJh1ge
 PxnuUsu2JXVP7C9Nra58wJlgE5D0llUoR5gu4hTWAvBOFrQ0g3jZGAOXo8RJ/836
 zPORlmZCvN+c1iYUhivOc4W+oaNy8fDhdcJYKsUuM/EKAwfpSwJYGXmb8UP6bskE
 Dgg6qRkVtCnKeyZHtqs2Q+pQ+PMYeaxuclny7sKFACvIIyEaZ/tMFtokyNZP9Me0
 E/HqXjwLcs8qFoxi7BbAd9tr55FfmXgal1EVpF9waPHCNYg06pcbHHuumS7JYFb+
 YUiu6Cj3JeASR5w7X0ehVyqumHWo2wkHgDQPczR50aLYx6UtJtYzr9XBlScm6Mc1
 MxNQ+Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs01r64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934956beec8so94950585a.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792567575; x=1793172375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2zoaF2iR+Wz6pFtnanrhWuer4x1dALmitloSery1EN0=;
 b=J7B4wvn3zxDO3205gwJCDAf5a14gEQrBz0r5bPZQR1j5y0ZmjcBUamnfwdaJn7NHzD
 V2QgKPHiYTysCsWTHUSh8nKdBvtWVm5eI+DwOeVsJP7oB8sn5a6TFAeXBf+cYeTIJc5F
 2+5ozuxOc9LALbo2An0N1gZTCe/cRyLp5BEjczVbSyspAeMPMiIonAx6VzaXVvWPpzES
 n2AW2PoEtkSmmVpb878SOZ8Mo0QUq1yQVnUkA3ahcr9+EnqqkchgCpc8hJJD4bj6SmWH
 IPI62cuGfZzhNwh72Zrz4iIvoN9v9hSAdJZoc7SXCP/PKBEvVukrwza/IGgMpKuGwF4m
 DFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792567575; x=1793172375;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2zoaF2iR+Wz6pFtnanrhWuer4x1dALmitloSery1EN0=;
 b=KFQ2OYBvpQnREmzzbVmx9im1UA8Zbb9Uoe49yXDz9nKCvn3srpbDwfVoSZsf/4/Qxk
 Qkv0uULqcpJoilj9jFiItT3rbwskC23GzADOQs/dBJa3HNm6PyKqZO5qVD5goNXAwlRl
 +0o5L/SnVnwISguG8RssTaYhXT8sHrAecLH4EyV61sYwwhBQIogD4KubaKIl3gWh1usB
 Oz1KbpUbXFvLhx6pJgohJuQ/JrdZo/7I76mEYy3QxB0e+53C4Dv7jBD6WVqgOtwOVHZa
 CACmNFl2DGnLYqOs5VQTITDQWs8b0/ChCziH/OOmWq72KtOmP7nIrI/JsaHf43gM34F3
 Dd8g==
X-Forwarded-Encrypted: i=1;
 AKwUvByVXRMz29Wn2Kr4nKaxHRRAqIAdUh7g91CF5NmGkf59Aq3B5ISmSTOxF5i3ytrv1H3zVqK208ARCLgV@nongnu.org
X-Gm-Message-State: AFq9FYIrYvsW+N1DFwHHDbzEpUwDz0hhiM8qCxkOIS2HvLfzAozJLfml
 mG78TyKirizBV4QOvswyxuespUnQWVTUyAChN9KhJHQgx8eWjM+mSHtitrbkE+va52WPOzWbqrd
 9nR/nJJl5CqCfgkGliGy+MwC8E2Wd5JX1A+UWwIJwfmz0pLWxkfijzhSitA==
X-Gm-Gg: AYBFou1GyCE1pBDwjDb2KLTKxwGxTVGAgEtboT9xC117iGiEzSQ2H/x3ifi1TEjdIrJ
 xyAQJDDphhedQBybXPI+am7DSBGXMv+07zvYmem+FftEAQ5+8MxurhuoAagV2U5P7EvN2D+JTIC
 3ITLgXqCVVvJ6r+q9t/lHrdrlmNCGFgG9j5ZyVmnKgdLUZa31qEVAhfq+bfT7mBkETT1O+/CLw+
 bB08X/tnFSyjK2lhhsdDc4QOvboWtXGmdeqCwad+jPWYtLGXZI93G6/jeGzdglov24T8u45Lc3M
 2AbBtyzUErUF7//bwfHMcdLlJEUDNgaAP+0d2XroLusHbP/nm734NB0L5PQMCZLvQmyNFRGdS11
 D69Uwj6kZ2KwLvv+NG3e7I9LdInOTDCVaPA==
X-Received: by 2002:a05:620a:a88d:20b0:93f:38c7:70f9 with SMTP id
 af79cd13be357-93f57f0bd94mr189722585a.14.1792567575551; 
 Wed, 21 Oct 2026 00:26:15 -0700 (PDT)
X-Received: by 2002:a05:620a:a88d:20b0:93f:38c7:70f9 with SMTP id
 af79cd13be357-93f57f0bd94mr189720085a.14.1792567575050; 
 Wed, 21 Oct 2026 00:26:15 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fcd2eff9sm32910885e9.4.2026.10.21.00.26.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 00:26:14 -0700 (PDT)
Message-ID: <145a7086-d9eb-4cf0-a162-b3a44d51e9e6@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 09:26:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] target/sparc: Add the AES key expansion
 instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20261021064640.3591682-1-stian@itx.no>
 <20261021064640.3591682-5-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261021064640.3591682-5-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad86918 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Tw0MqJahTJh3gxrfwiMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfXyMM/g1RjVS0p
 NdpkH2fo5U9is3+3LfVZx67xDL1YRYtJFknkkX1eHS/oYtOGF8oGGoQ/5FYQdY26xJKV9frq0id
 uNfYC/17wFhNVfwejM4wKTFIIvXfQnQCxqQpiRKTefxp83t7rrZGLaUyOzpFXxW769oV5eLF6fm
 sxv2BKfOgQK54J0Q3Ps1cbY/gsFKmiQtD2egvEx+NaRwRtL/VruO7w3LwL4xYoSSWPHGUv+k3Av
 0yGlBOD29dPd3XLB3hfALUTfdfelDE6Qj+bKoBl7PmrWLQEHdT2uF9nw8SXlU1PrYwffn1vzRTv
 a0r89mZpzgum8w78jt8JRxuppnZTR9B/NwVdOmK6tJW5pGBloNI9LO6X5978cQ1+4iemy+K7yTw
 L1Ro92/2TbNOMe5PKERNfnL0QmEwCl69Wmgq8YLHYDZ4tUU5adIkiSNrqZNIIfuudvSHNmDe5N4
 kZ1UUjFppqAIf/+tRiA==
X-Proofpoint-ORIG-GUID: X3h4Xp6PtRIltMVoyKWOMkFqcyqACTOo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyOSBTYWx0ZWRfXyhwEVT1H+wTp
 nTuRN1FYKVQX+ylu0B9Cyx3OWnLWyilfPQ48PAWJYlSGGWlYsmUpXy1pV3iPLYgVVJzjhq8v/zY
 cqFwOcQDFwkE2dSFI1D+jK95Vtoesco=
X-Proofpoint-GUID: X3h4Xp6PtRIltMVoyKWOMkFqcyqACTOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210029
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 21/10/26 08:46, Stian Halseth wrote:
> Implement the AES key expansion instructions according to
> OSA (Oracle SPARC Architecture) 2011 sections 7.3 and 7.4
> and set the AES bit in the CFR.
> 
> 4-operand form (7.3):
> - AES_KEXPAND1
> 
> 3-operand form (7.4):
> - AES_KEXPAND0
> - AES_KEXPAND2
> 
> Like the AES round instructions, they are gated behind the
> crypto CPU feature and disabled for sparc32.

~ "The AES feature is now complete and exposed in the Compatibility 
Feature Register".
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 58 ++++++++++++++++++++++++++++++++++++
>   target/sparc/helper.h        |  3 ++
>   target/sparc/insns.decode    |  7 +++++
>   target/sparc/translate.c     | 30 ++++++++++++++++++-
>   4 files changed, 97 insertions(+), 1 deletion(-)


>   /*
>    * SPARC four-operand AES round (Section 7.3).
> @@ -87,3 +88,60 @@ uint64_t helper_aes_dround23_l(uint64_t key, uint64_t s2, uint64_t s3)
>   {
>       return aes_round(key, s2, s3, 1, true, true);
>   }
> +
> +/* Combine the transformed word with the two words in rs1. */
> +static uint64_t aes_kexpand(uint64_t rs1, uint32_t t)
> +{
> +    uint32_t hi = (rs1 >> 32) ^ t;
> +    uint32_t lo = (uint32_t)rs1 ^ hi;
> +
> +    return ((uint64_t)hi << 32) | lo;

Alternatively:

        return deposit64(lo, 32, 32, hi);

> +}
> +
> +/* Apply the AES S-box to each byte, preserving byte positions. */
> +static uint32_t aes_subword(uint32_t x)
> +{
> +    return ((uint32_t)AES_sbox[x >> 24] << 24) |
> +           ((uint32_t)AES_sbox[(x >> 16) & 0xff] << 16) |
> +           ((uint32_t)AES_sbox[(x >> 8) & 0xff] << 8) |
> +           (uint32_t)AES_sbox[x & 0xff];
> +}

We could move that method to include/crypto/aes.h and re-use
it in RISCV's vaeskf1_vi / vaeskf2_vi helpers.

> +
> +/*
> + * AES Cryptographic Operations 4-operand (Section 7.3)
> + * AES key expansion with RotWord, SubWord, and RCON.
> + */
> +uint64_t helper_aes_kexpand1(uint64_t rs1, uint64_t rs2, uint32_t imm)
> +{
> +    static const uint8_t rcon[10] = {
> +        0x01, 0x02, 0x04, 0x08, 0x10,
> +        0x20, 0x40, 0x80, 0x1b, 0x36,

This table is also used by RISCV aes64ks1i, vaeskf1_vi, and vaeskf2_vi,
so we could add a common const uint8_t AES_rcon[10] in include/crypto/aes.h:

-- >8 --
diff --git a/include/crypto/aes.h b/include/crypto/aes.h
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -29,6 +29,7 @@ void AES_decrypt(const unsigned char *in, unsigned 
char *out,

  extern const uint8_t AES_sbox[256];
  extern const uint8_t AES_isbox[256];
+extern const uint8_t AES_rcon[10];

---

and in crypto/aes.c:

@@ -944,6 +944,11 @@
  };

+const uint8_t AES_rcon[10] = {
+    0x01, 0x02, 0x04, 0x08, 0x10,
+    0x20, 0x40, 0x80, 0x1b, 0x36,
+};
+
> +    };
> +    uint32_t t = rol32((uint32_t)rs2, 8);
> +
> +    t = aes_subword(t);
> +
> +    if (imm < ARRAY_SIZE(rcon)) {
> +        t ^= (uint32_t)rcon[imm] << 24;
> +    }
> +
> +    return aes_kexpand(rs1, t);
> +}
> +
> +/*
> + * AES Cryptographic Operations 3-operand (Section 7.4)
> + * AES key expansion with SubWord, without RotWord or RCON.
> + */
> +uint64_t helper_aes_kexpand0(uint64_t rs1, uint64_t rs2)
> +{
> +    return aes_kexpand(rs1, aes_subword(rs2));
> +}
> +
> +/*
> + * AES Cryptographic Operations 3-operand (Section 7.4)
> + * AES key expansion without SubWord, RotWord, or RCON.
> + */
> +uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
> +{
> +    return aes_kexpand(rs1, (uint32_t)rs2);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


