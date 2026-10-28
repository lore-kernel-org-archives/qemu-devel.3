Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC31B606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dmCmRcvj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T/mmYyOs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMAY8-0001wn-Hv; Wed, 28 Oct 2026 16:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAXy-0001vp-6M
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:47:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMAXv-0005IO-Er
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:46:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPovY1395629
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7q9eqeVz7hKE9fmlVGQ2Zk1huRl0OnE1NjBx6TPb+Ws=; b=dmCmRcvjsjk4aFWV
 v3nBd3KBZG2t8JAgcOBKg/jbQLJnz64/BQcqKACMi55MJyjT7L6jJ9tZetJ3peJ5
 48/O24yo5eD21REH5axh26gPKahThxbTBY6FUb9fegjW7Lroy3pbQ1aTg4kxsSV+
 ME7LbDL/pV+SgA2KyTKzytxq89s0OmDvlicSGoiSby19cVoXzmUYnWD61Jerk5xH
 q5r1Pal83Vr0eE1aD62iB3BAYfRXNTzdOM96uz5vqczFNIsSHHZ4oMkxDvhpC3ez
 BvuIMHbcACwqipjdJD3bGNgsguxhh5Kxj93K+jH1fDSv3G0KWeLALzCTiUjd/Z2F
 QaUaEg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtjhwmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 20:46:52 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso2455585c88.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793220412; x=1793825212; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7q9eqeVz7hKE9fmlVGQ2Zk1huRl0OnE1NjBx6TPb+Ws=;
 b=T/mmYyOsAvxGrj60m4vxC5zHHjeVPopgmtHKN4/noIf6Dn0snLZqDyrsvcD+yUGNSC
 3drR3hix86QR3eud95JVv89e3tPbIQV7YdXJwoqDYwUgxRzc/6d0N15o+lD+0AAW0eMI
 EuJSB4dOa9GQ5lhLri0UhHZ4/jKs3ix78IA0O7P+Cy09sZs4mDRuF1kUJJIeYjyPoFbb
 vqQsjKh2yr1IWw75YuR5/2rR9LgB/dhsvwIjrJUJW8bis154UzDo6E/JjK8Qpvaj0geq
 vyJbAko2zcssi9genp3FjnjeT8zPvgizW4vmUF7G2zjHwiBrnFQGHQ8TdQGWdGz092bG
 aYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220412; x=1793825212;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7q9eqeVz7hKE9fmlVGQ2Zk1huRl0OnE1NjBx6TPb+Ws=;
 b=utT517+6LQYpD9/CPJqKiGLHq02ricI21QWZn0MnAbBNu0TbHaOR1IEtQSAnUzmZ/Q
 2IxZ1q58UQPYdUa7Qy/QBNlfnljE1Csf9xedAruX55TrygcG2OjOPYa1RYsrEqgIl9no
 bF46Kd6rvFL+g8hU6/p/nmw1TW1pa71Imh+ln5OH86oURbTWwhxJLguwAF/PdgROi0kn
 NSPrR7Rhar7ujBtkwcKfphQMwxc1mxyGUd8qHURRfX6uHEXZvx2MtmRObVg40R9iGP4Z
 Cyv19VB2HcvFL0GYDifzBP0WgZZy5fUgXUq5tPYLyoBGWTqKrltJ/HERc7RVzRwXCRrm
 GGtA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6OHVCtYw2LpFmcqwQ9J6drBAu2zaKzUIf7GKSNvTwo1f87C/idDT+4kZi2V8bgm6hqRSreLPaxSUT@nongnu.org
X-Gm-Message-State: AFq9FYKOcDm/7gfS89vPoEEMllzd+DWauIKwnvrITzrh1CydRgJhhuRl
 eX3/aXo0wPCFejsXfIRbVREoNCrvPxtbKNMvPh5tF7YZko+3kAbOu+BN45GL654JB7Km5ayeBVK
 hYtVaUoS7xvagTxs1OV1KfUKx9M1O/Yab7tel+JwK/z6egp2NX1+7yaWGJA==
X-Gm-Gg: AYBFou3Nr5Ktky1Qn9waqp895F+bv9nL5Kk2RutBhrcdA/bOzqc+VKNJHZSW78oP5Yl
 oVyvVvWtuMIxdWhKAfA85pW919QGRHJLR1z6CD48FDKREKT9MvynsdKCdMX/J1cb724AMxNjajH
 1qeBc0ZyRi9V88SflUgNwmMIYluv6FB7Pv9Dddp3v7vP0gYKa/auboiiZss03Y1Hef7rQrUNpKU
 5hKmeU1hMUNy0NscN2+hB6HXmE27YQYMh0hPq7nRGuwKgeYMerfKmbiONPqgMlLZpGLUZYJUhJZ
 l/+9WomB6P0AIWTmRW8MlOyAjcRMfBCOtX5QgsPzZjTnZtc7Qdgg7gH+EFaK8rAxtvjus96Dv+P
 kMHNSgVhXRNVp5r2FEVNpRdAU461dj5n9KqCfO3qRU8wUSgmBYQwBokW9F0xfRy5eVhaYmlozsr
 XVk5rtPQkU81hADV0pxv9AFkf/5pYVrs3XwkY6cM9UFOU=
X-Received: by 2002:a05:7022:3c15:b0:149:1feb:6dae with SMTP id
 a92af1059eb24-1a6cf72b67emr3527204c88.39.1793220411286; 
 Wed, 28 Oct 2026 13:46:51 -0700 (PDT)
X-Received: by 2002:a05:7022:3c15:b0:149:1feb:6dae with SMTP id
 a92af1059eb24-1a6cf72b67emr3527152c88.39.1793220410333; 
 Wed, 28 Oct 2026 13:46:50 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1a75c9fd2b4sm8328881c88.6.2026.10.28.13.46.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 13:46:49 -0700 (PDT)
Message-ID: <b78bb9c4-4d3f-401e-bc19-104825121a7a@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 12:46:49 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] tests/tcg/mips64el: Add a TX79 instruction test in
 system mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>, Aurelien Jarno <aurelien@aurel32.net>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-10-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261028192538.31600-10-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfXzQNwGYlkEm7Y
 Ycrj44HFtoHetSGqg3KikE9T3+4SX49jsaskG9gTJYCpPKjy9ptDRCwEHycQRAsfTGp+QhOcRm3
 k9DirxhObTk1kZYuYMpA1VcUQr9X5kB0fkIdeWilzddD53oFLLOdxrQSjim5PILUeHsjj7qAV59
 UnwagdFwW4EWMSPteYOCBeufbfyr7kWuzXqZgsICRoCawa5vvI13JPZIK/aFcXT9xFKmvRz8X57
 xh5R0hIyz9OUWw6UhcNKJ4JaMi1LGfw7UIh0KK4IAOqdo7KDXl4UWWEqp7dT9plznRFIFV9/AMZ
 ZLzsu0LWN9gMUxR5D/6xBmPSu8oUGavfnvzcaga/IAKAfBakqBee9Qrx2fYFV7JnvKkN24oJVD/
 nyltu1PeF3+wFBvXBYA3413uwvOIdlohAs/ZzdSVjAWM2EdNBnUGPcRkXED8VZybGJ62kv406v6
 jTf0vFg+8D6NtaOc9NQ==
X-Proofpoint-GUID: FUKrBKaPvtrXTIDlkCsvuvglvPEtknjp
X-Proofpoint-ORIG-GUID: FUKrBKaPvtrXTIDlkCsvuvglvPEtknjp
X-Authority-Analysis: v=2.4 cv=LdipeTfi c=1 sm=1 tr=0 ts=6ae25f3c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=JFK7MZsTnhIFEhhZzLEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA4MiBTYWx0ZWRfX+pNP+gnsEZWG
 ki+fWaj3ZZ+TdUgPDo+a9LWBgNEHSGr65qiCOkw1qilTzIWcjiFkQBTXxTHn8tdz9ful3YeUJJc
 1IRv2CuAlSDmnWuHsQjxKE1L4aEcxss=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/2026 11:25 AM, Philippe Mathieu-Daudé wrote:
> Exercise the instructions decoded by tx79.decode (parallel
> arithmetic/compare/logic/extend, PCPYH, PROT3W, HI1/LO1 moves, LQ/SQ).
> The instruction words are emitted directly, as the assembler does not
> know the TX79 mnemonics.
> 
> Build it with the n32 ABI, to move 64-bit values to HI1/LO1.
> 
> AI-used-for: tests
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  tests/tcg/mips64el/system/test_r5900_tx79.c | 477 ++++++++++++++++++++
>  tests/tcg/mips64el/system/meson.build       |   9 +
>  2 files changed, 486 insertions(+)
>  create mode 100644 tests/tcg/mips64el/system/test_r5900_tx79.c
> 
> diff --git a/tests/tcg/mips64el/system/test_r5900_tx79.c b/tests/tcg/mips64el/system/test_r5900_tx79.c
> new file mode 100644
> index 000000000000..64b9b53b9440
> --- /dev/null
> +++ b/tests/tcg/mips64el/system/test_r5900_tx79.c
> @@ -0,0 +1,477 @@
> +/*
> + * Test the TX79 instructions decoded by target/mips/tcg/tx79.decode.
> + *
> + * The instruction words are emitted directly because the normal MIPS64
> + * assembler does not know the TX79 mnemonics.  LQ and SQ are used to move
> + * values into and out of the emulated 128-bit GPRs.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <string.h>
> +
> +typedef struct {
> +    uint64_t lo;
> +    uint64_t hi;
> +} __attribute__((aligned(16))) tx79_qword;
> +
> +#define TX79_STR1(x) #x
> +#define TX79_STR(x) TX79_STR1(x)
> +
> +#define TX79_R(rs, rt, rd, sub, func) \
> +    ((0x1cU << 26) | ((rs) << 21) | ((rt) << 16) | ((rd) << 11) | \
> +     ((sub) << 6) | (func))
> +#define TX79_LDST(op, base, rt, offset) \
> +    (((op) << 26) | ((base) << 21) | ((rt) << 16) | ((offset) & 0xffffU))
> +
> +#define TX79_BINOP_WORD(INSN, A, B)                                      \
> +    ({                                                                   \
> +        tx79_qword _result;                                              \
> +        asm volatile(                                                     \
> +            "move $7, %[a]\n"                                           \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"           \
> +            "move $7, %[b]\n"                                           \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 9, 0)) "\n"           \
> +            "move $7, %[a]\n"                                           \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 10, 0)) "\n"          \
> +            ".word " TX79_STR(INSN) "\n"                                \
> +            "move $7, %[result]\n"                                      \
> +            ".word " TX79_STR(TX79_LDST(0x1f, 7, 10, 0)) "\n"          \
> +            :                                                             \
> +            : [a] "r" (A), [b] "r" (B), [result] "r" (&_result)        \
> +            : "$7", "$8", "$9", "$10", "memory");                    \
> +        _result;                                                          \
> +    })
> +
> +#define TX79_UNARY_WORD(INSN, A)                                         \
> +    ({                                                                   \
> +        tx79_qword _result;                                              \
> +        asm volatile(                                                     \
> +            "move $7, %[a]\n"                                           \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"           \
> +            ".word " TX79_STR(INSN) "\n"                                \
> +            "move $7, %[result]\n"                                      \
> +            ".word " TX79_STR(TX79_LDST(0x1f, 7, 10, 0)) "\n"          \
> +            :                                                             \
> +            : [a] "r" (A), [result] "r" (&_result)                      \
> +            : "$7", "$8", "$10", "memory");                            \
> +        _result;                                                          \
> +    })
> +
> +#define TX79_LQ_OFFSET(OFFSET, BASE)                                     \
> +    ({                                                                   \
> +        tx79_qword _result;                                              \
> +        asm volatile(                                                     \
> +            "move $7, %[base]\n"                                        \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, OFFSET)) "\n"      \
> +            "move $7, %[result]\n"                                      \
> +            ".word " TX79_STR(TX79_LDST(0x1f, 7, 8, 0)) "\n"           \
> +            :                                                             \
> +            : [base] "r" (BASE), [result] "r" (&_result)                \
> +            : "$7", "$8", "memory");                                   \
> +        _result;                                                          \
> +    })
> +
> +#define TX79_SQ_OFFSET(OFFSET, VALUE, BASE)                               \
> +    do {                                                                   \
> +        asm volatile(                                                       \
> +            "move $7, %[value]\n"                                        \
> +            ".word " TX79_STR(TX79_LDST(0x1e, 7, 8, 0)) "\n"            \
> +            "move $7, %[base]\n"                                         \
> +            ".word " TX79_STR(TX79_LDST(0x1f, 7, 8, OFFSET)) "\n"        \
> +            :                                                               \
> +            : [value] "r" (VALUE), [base] "r" (BASE)                     \
> +            : "$7", "$8", "memory");                                    \
> +    } while (0)
> +
> +static int check_qword(const char *name, tx79_qword got, tx79_qword expected)
> +{
> +    if (got.lo == expected.lo && got.hi == expected.hi) {
> +        return 0;
> +    }
> +
> +    fprintf(stderr, "%s: got %016llx:%016llx expected %016llx:%016llx\n",
> +            name, (unsigned long long)got.hi, (unsigned long long)got.lo,
> +            (unsigned long long)expected.hi,
> +            (unsigned long long)expected.lo);
> +    return 1;
> +}
> +
> +static uint64_t lane_mask(unsigned bits)
> +{
> +    return (1ULL << bits) - 1;
> +}
> +
> +static int64_t sign_extend_lane(uint64_t value, unsigned bits)
> +{
> +    uint64_t sign = 1ULL << (bits - 1);
> +
> +    value &= lane_mask(bits);
> +    return (int64_t)((value ^ sign) - sign);
> +}
> +
> +static tx79_qword ref_sub(tx79_qword a, tx79_qword b, unsigned bits)
> +{
> +    tx79_qword result = { 0, 0 };
> +    uint64_t mask = lane_mask(bits);
> +
> +    for (unsigned half = 0; half < 2; half++) {
> +        uint64_t av = half ? a.hi : a.lo;
> +        uint64_t bv = half ? b.hi : b.lo;
> +        uint64_t *dst = half ? &result.hi : &result.lo;
> +
> +        for (unsigned lane = 0; lane < 64 / bits; lane++) {
> +            uint64_t shift = lane * bits;
> +            *dst |= (((av >> shift) - (bv >> shift)) & mask) << shift;
> +        }
> +    }
> +
> +    return result;
> +}
> +
> +static tx79_qword ref_compare(tx79_qword a, tx79_qword b, unsigned bits,
> +                              int equal)
> +{
> +    tx79_qword result = { 0, 0 };
> +    uint64_t mask = lane_mask(bits);
> +
> +    for (unsigned half = 0; half < 2; half++) {
> +        uint64_t av = half ? a.hi : a.lo;
> +        uint64_t bv = half ? b.hi : b.lo;
> +        uint64_t *dst = half ? &result.hi : &result.lo;
> +
> +        for (unsigned lane = 0; lane < 64 / bits; lane++) {
> +            uint64_t shift = lane * bits;
> +            int64_t as = sign_extend_lane(av >> shift, bits);
> +            int64_t bs = sign_extend_lane(bv >> shift, bits);
> +            int match = equal ? as == bs : as > bs;
> +
> +            if (match) {
> +                *dst |= mask << shift;
> +            }
> +        }
> +    }
> +
> +    return result;
> +}
> +
> +static tx79_qword ref_pext(tx79_qword a, tx79_qword b, unsigned bits,
> +                           int upper)
> +{
> +    tx79_qword result = { 0, 0 };
> +    uint64_t av = upper ? a.hi : a.lo;
> +    uint64_t bv = upper ? b.hi : b.lo;
> +
> +    for (unsigned lane = 0; lane < 64 / (2 * bits); lane++) {
> +        uint64_t shift = lane * bits;
> +        uint64_t dst_shift = lane * 2 * bits;
> +        uint64_t mask = lane_mask(bits);
> +
> +        result.lo |= ((bv >> shift) & mask) << dst_shift;
> +        result.lo |= ((av >> shift) & mask) << (dst_shift + bits);
> +        result.hi |= ((bv >> (shift + 32)) & mask) << dst_shift;
> +        result.hi |= ((av >> (shift + 32)) & mask) << (dst_shift + bits);
> +    }
> +
> +    return result;
> +}
> +
> +static tx79_qword ref_logic(tx79_qword a, tx79_qword b, char op)
> +{
> +    tx79_qword result;
> +
> +    switch (op) {
> +    case '&':
> +        result.lo = a.lo & b.lo;
> +        result.hi = a.hi & b.hi;
> +        break;
> +    case '|':
> +        result.lo = a.lo | b.lo;
> +        result.hi = a.hi | b.hi;
> +        break;
> +    case '^':
> +        result.lo = a.lo ^ b.lo;
> +        result.hi = a.hi ^ b.hi;
> +        break;
> +    default:
> +        result.lo = ~(a.lo | b.lo);
> +        result.hi = ~(a.hi | b.hi);
> +        break;
> +    }
> +
> +    return result;
> +}
> +
> +static tx79_qword ref_pcpyh(tx79_qword a)
> +{
> +    uint64_t lo = a.lo & 0xffff;
> +    uint64_t hi = a.hi & 0xffff;
> +    tx79_qword result = {
> +        lo * 0x0001000100010001ULL,
> +        hi * 0x0001000100010001ULL,
> +    };
> +
> +    return result;
> +}
> +
> +static tx79_qword ref_prot3w(tx79_qword a)
> +{
> +    tx79_qword result = {
> +        (a.lo >> 32) | ((a.hi & 0xffffffff) << 32),
> +        (a.lo & 0xffffffff) | (a.hi & 0xffffffff00000000ULL),
> +    };
> +
> +    return result;
> +}
> +
> +static void tx79_set_hilo1(uint64_t hi, uint64_t lo)
> +{
> +    asm volatile(
> +        "move $8, %[lo]\n"
> +        ".word " TX79_STR(TX79_R(8, 0, 0, 0, 0x13)) "\n"
> +        "move $8, %[hi]\n"
> +        ".word " TX79_STR(TX79_R(8, 0, 0, 0, 0x11)) "\n"
> +        :
> +        : [lo] "r" (lo), [hi] "r" (hi)
> +        : "$8");
> +}
> +
> +static tx79_qword tx79_get_hilo1(void)
> +{
> +    tx79_qword result;
> +
> +    asm volatile(
> +        ".word " TX79_STR(TX79_R(0, 0, 8, 0, 0x12)) "\n"
> +        "move %[lo], $8\n"
> +        ".word " TX79_STR(TX79_R(0, 0, 8, 0, 0x10)) "\n"
> +        "move %[hi], $8\n"
> +        : [lo] "=r" (result.lo), [hi] "=r" (result.hi)
> +        :
> +        : "$8");
> +
> +    return result;
> +}
> +
> +static int test_hilo1(void)
> +{
> +    const uint64_t hi = 0x8899aabbccddeeffULL;
> +    const uint64_t lo = 0x0011223344556677ULL;
> +    tx79_qword got;
> +
> +    tx79_set_hilo1(hi, lo);
> +    got = tx79_get_hilo1();
> +    if (got.lo != lo || got.hi != hi) {
> +        fprintf(stderr, "HI1/LO1 move instructions failed\n");
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int test_parallel(void)
> +{
> +    const tx79_qword a = {
> +        0x800000007fffffffULL,
> +        0xff0080007fff8000ULL,
> +    };
> +    const tx79_qword b = {
> +        0x00000000ffffffffULL,
> +        0x01008000ffff0001ULL,
> +    };
> +    tx79_qword got;
> +
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 9, 8), &a, &b);
> +    if (check_qword("PSUBB", got, ref_sub(a, b, 8))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 5, 8), &a, &b);
> +    if (check_qword("PSUBH", got, ref_sub(a, b, 16))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 1, 8), &a, &b);
> +    if (check_qword("PSUBW", got, ref_sub(a, b, 32))) {
> +        return 1;
> +    }
> +
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 2, 8), &a, &b);
> +    if (check_qword("PCGTW", got, ref_compare(a, b, 32, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 6, 8), &a, &b);
> +    if (check_qword("PCGTH", got, ref_compare(a, b, 16, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 10, 8), &a, &b);
> +    if (check_qword("PCGTB", got, ref_compare(a, b, 8, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 2, 40), &a, &b);
> +    if (check_qword("PCEQW", got, ref_compare(a, b, 32, 1))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 6, 40), &a, &b);
> +    if (check_qword("PCEQH", got, ref_compare(a, b, 16, 1))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 10, 40), &a, &b);
> +    if (check_qword("PCEQB", got, ref_compare(a, b, 8, 1))) {
> +        return 1;
> +    }
> +
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 8), &a, &b);
> +    if (check_qword("PEXTLW", got, ref_pext(a, b, 32, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 22, 8), &a, &b);
> +    if (check_qword("PEXTLH", got, ref_pext(a, b, 16, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 26, 8), &a, &b);
> +    if (check_qword("PEXTLB", got, ref_pext(a, b, 8, 0))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 40), &a, &b);
> +    if (check_qword("PEXTUW", got, ref_pext(a, b, 32, 1))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 8), &a, &b);
> +    if (check_qword("PPACW", got, (tx79_qword) {
> +            (uint32_t)b.lo | ((uint64_t)(uint32_t)b.hi << 32),
> +            (uint32_t)a.lo | ((uint64_t)(uint32_t)a.hi << 32),
> +        })) {
> +        return 1;
> +    }
> +
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 9), &a, &b);
> +    if (check_qword("PAND", got, ref_logic(a, b, '&'))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 9), &a, &b);
> +    if (check_qword("PXOR", got, ref_logic(a, b, '^'))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 18, 41), &a, &b);
> +    if (check_qword("POR", got, ref_logic(a, b, '|'))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 19, 41), &a, &b);
> +    if (check_qword("PNOR", got, ref_logic(a, b, 'n'))) {
> +        return 1;
> +    }
> +
> +    got = TX79_UNARY_WORD(TX79_R(0, 8, 10, 27, 41), &a);
> +    if (check_qword("PCPYH", got, ref_pcpyh(a))) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 14, 9), &a, &b);
> +    if (check_qword("PCPYLD", got, (tx79_qword) { b.lo, a.lo })) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 10, 14, 41), &a, &b);
> +    if (check_qword("PCPYUD", got, (tx79_qword) { a.hi, b.hi })) {
> +        return 1;
> +    }
> +    got = TX79_UNARY_WORD(TX79_R(0, 8, 10, 31, 9), &a);
> +    if (check_qword("PROT3W", got, ref_prot3w(a))) {
> +        return 1;
> +    }
> +
> +    got = TX79_BINOP_WORD(TX79_R(0, 9, 10, 14, 9), &a, &b);
> +    if (check_qword("PCPYLD rt-only", got, (tx79_qword) { b.lo, 0 })) {
> +        return 1;
> +    }
> +    got = TX79_BINOP_WORD(TX79_R(8, 0, 10, 14, 41), &a, &b);
> +    if (check_qword("PCPYUD rs-only", got, (tx79_qword) { a.hi, 0 })) {
> +        return 1;
> +    }
> +    got = TX79_UNARY_WORD(TX79_R(0, 0, 10, 27, 41), &a);
> +    if (check_qword("PCPYH zero", got, (tx79_qword) { 0, 0 })) {
> +        return 1;
> +    }
> +
> +    got = TX79_BINOP_WORD(TX79_R(8, 9, 0, 1, 8), &a, &b);
> +    if (check_qword("rd zero", got, (tx79_qword) {
> +            a.lo, a.hi,
> +        })) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> +
> +static int test_quadword_memory(void)
> +{
> +    static uint8_t memory[65536 + 64] __attribute__((aligned(16)));
> +    static const int offsets[] = { -32768, -1, 0, 1, 32767 };
> +    const tx79_qword value = {
> +        0x0123456789abcdefULL,
> +        0xfedcba9876543210ULL,
> +    };
> +    uint8_t *base = memory + 32784;
> +
> +    for (unsigned i = 0; i < sizeof(offsets) / sizeof(offsets[0]); i++) {
> +        int offset = offsets[i];
> +        uintptr_t address = (uintptr_t)base + (intptr_t)offset;
> +        uint8_t *aligned = (uint8_t *)(address & ~(uintptr_t)0xf);
> +        tx79_qword got;
> +
> +        memset(memory, 0, sizeof(memory));
> +        memcpy(aligned, &value, sizeof(value));
> +        switch (offset) {
> +        case -32768:
> +            got = TX79_LQ_OFFSET(-32768, base);
> +            break;
> +        case -1:
> +            got = TX79_LQ_OFFSET(-1, base);
> +            break;
> +        case 0:
> +            got = TX79_LQ_OFFSET(0, base);
> +            break;
> +        case 1:
> +            got = TX79_LQ_OFFSET(1, base);
> +            break;
> +        default:
> +            got = TX79_LQ_OFFSET(32767, base);
> +            break;
> +        }
> +        if (check_qword("LQ offset", got, value)) {
> +            return 1;
> +        }
> +
> +        memset(memory, 0, sizeof(memory));
> +        switch (offset) {
> +        case -32768:
> +            TX79_SQ_OFFSET(-32768, &value, base);
> +            break;
> +        case -1:
> +            TX79_SQ_OFFSET(-1, &value, base);
> +            break;
> +        case 0:
> +            TX79_SQ_OFFSET(0, &value, base);
> +            break;
> +        case 1:
> +            TX79_SQ_OFFSET(1, &value, base);
> +            break;
> +        default:
> +            TX79_SQ_OFFSET(32767, &value, base);
> +            break;
> +        }
> +        if (memcmp(aligned, &value, sizeof(value)) != 0) {
> +            fprintf(stderr, "SQ offset %d failed\n", offset);
> +            return 1;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
> +int main(void)
> +{
> +    if (test_hilo1() || test_parallel() || test_quadword_memory()) {
> +        return 1;
> +    }
> +
> +    return 0;
> +}
> diff --git a/tests/tcg/mips64el/system/meson.build b/tests/tcg/mips64el/system/meson.build
> index fd5a759c20fa..66c3d61c3134 100644
> --- a/tests/tcg/mips64el/system/meson.build
> +++ b/tests/tcg/mips64el/system/meson.build
> @@ -39,6 +39,15 @@ foreach t: [
>    }
>  endforeach
>  
> +# n32: 32-bit pointers, 64-bit GPRs are needed to move 64-bit values to HI1/LO1
> +tests += {
> +  'test_r5900_tx79.c': {
> +    'cflags': cflags + ['-mabi=n32'],
> +    'qemu_args': qemu_args,
> +    'gdb_test': gdb_test,
> +  }
> +}
> +
>  if 'qemu-system-mips64el' in emulators
>    tcg_tests += {
>      'mips64el-softmmu': {

Without diving too much into every line, looks good to me overall.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

