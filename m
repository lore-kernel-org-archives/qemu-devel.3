Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mP6Efwgt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I13TSML/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFfV-00062Z-KG; Tue, 20 Oct 2026 15:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFfT-000620-A1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:38:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJFfR-0000Ms-Ij
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:38:39 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KJHxv81508677
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HI2tg2LWbdrc0728XJM5JrEl2XSS05l5egpTj4sAGxo=; b=mP6Efwgt7v0Sn/LH
 2/XPs11R9Uw/omgPYVhjH11OhpnGeKC/FwvYNXrbasGOTafY42l184FXMqFDVl0q
 9OWJBfV4dBdTM0TxmNmkIEVQZXDsFzukUa0pLqA79lruBBnmRrgtTZB/4BYDNJPT
 7A8EGmDA5TWmU63VwVRCjFXQER4gOgaOMpkf07Gr+wjeIZF/HAESjToCgNjh2Adb
 vk4vN3KFQvq2YdiJzkJS1EbKy9WkT/yEnpHGK/FXzDAXEKZPm8FfTCFYkhqV5Rtv
 s9nKk4FWG85EoDP/sEtdY0MunIP2meWM94dEcPDvzBkEMuoOq9oH42QqvA9J48QQ
 T/FPqg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb9829g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:38:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f5844e383so2237885a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792525115; x=1793129915; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HI2tg2LWbdrc0728XJM5JrEl2XSS05l5egpTj4sAGxo=;
 b=I13TSML/XZXcKLr4Wxeo/8bdDeYruS3QmZThCk/+7oc+uEWLLTbPrY1gw3kEhqZEw5
 pmvN5nCwGLy9FHrXBY+uqpMICATQQPqFllIQNXM+0b/5XtNQ9PZt67/rBZTusDNCXGuK
 2ZxxMXuQUaNJPlZMLCtCSCLNSylwSYtOOsIw0NjX+19bRWt2BfmJ5uaP6RFYGqUHTAWG
 78PGV62NV/7sBI90FSDHiORrsgSYNZ/+BORM8ekNOoOOmV8HJEB4+17Q7gb/WK4I3qZK
 xbEVS5zFMr4qw8GUhMp5Pm714HqZVHV/fxaiuOWqmBzMpwuyKYwSaaBxglsAqtJuS7KT
 G1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792525115; x=1793129915;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HI2tg2LWbdrc0728XJM5JrEl2XSS05l5egpTj4sAGxo=;
 b=gso1lnjNYw7i8Mpah0cjv7Z7/zRMe/Q+fz6sjI1Cs6t5V9mwWMaK3B//OVGOkSbGGs
 12B+/HpF0NwnFaHoUmmIkldDSuIc06U8bUk0+wahQPB3UTtqtOi45z5+0ldw42+kQrO3
 DGEdQlP7bokwcms2EmCrvvzAa5SqsEGheZW3KMQ7QMsEJrCHkPqTU5aZvSi1UGW09rAm
 p6TwK+Rd4P4LFyBG4ZUa/xMsu+ksTGxh7kLOzEyscK1c1deyhje2ZJceKLvqfksJBN9q
 BqFsUlQ86nZ0tBprOtSbZcWdgOYrFWNsroJuYbdTVojNVq1ZpKZQXI3xd1b9vSD4/j0q
 /n/A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQPDUSErXap6Ed85wbzx2sEkxRjxIxJhSH3XfVslV2v8IDWiuoxSsk8z4v3wnvPZQI4kYY/+6XvKE0@nongnu.org
X-Gm-Message-State: AFq9FYLOluyiFjEKPbyg/g7bAembirDFyJon2ZDvqj2LhdnuZvj7wbIr
 ud5I123MSRQXKY9m6GHACr56d1EiO+cJpGzD0QbQieMKJXeDS39inzPaK+pOIXTsRv4QdxxhP1n
 pISaXH+PtHmOjuZ+SUmjcvOZ95nJJ6Oe0pgw9p5j5++FQ6Ui0sjlUttFeYA==
X-Gm-Gg: AYBFou37dyVA3RIkNk3TlFi0+gWaYAkUHC04k0hTAyn+rtyEakKeJM/ZnY5QKntr5de
 zhb8nrwOOWJyqDyreQEXtveiXBpoGisKZTmMQaD2BUytL1oi6ngaEexBcfF9Mi8kCDH9IIPin87
 /dU6MZJfhUisH1HdSdNkerMQXdH3b4AJtXon1UFwEYwT5IK3cTJDYr2bTBelIVvEpnwxZ4h9Zvb
 HbEQkv+hH/ecqZPmiC+LaIoyxQS47QGF1cT6ikBVXPhN1LuqpRVYkgYW4jqrY6zXWsetY0B8N1r
 F9qcfeNCwc/unEcURgt0QLO5So+fjxb9trZ33JcFIZjzfP4Jt1HcNyO2v+fmkXClMq9uBrzwhce
 faslZXKxVpM/Jc6RyezlRT1dNCqpqnS9xjw==
X-Received: by 2002:a05:620a:6889:b0:93f:953:9a1d with SMTP id
 af79cd13be357-93f57f64608mr47786885a.67.1792525115495; 
 Tue, 20 Oct 2026 12:38:35 -0700 (PDT)
X-Received: by 2002:a05:620a:6889:b0:93f:953:9a1d with SMTP id
 af79cd13be357-93f57f64608mr47783985a.67.1792525115018; 
 Tue, 20 Oct 2026 12:38:35 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2e8daffsm104737615e9.4.2026.10.20.12.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:38:34 -0700 (PDT)
Message-ID: <b05a7af2-8fb6-4801-b6a3-b53565474ee5@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 21:38:33 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/sparc: Add the CRC32C instruction
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261020145530.3385376-1-stian@itx.no>
 <20261020145530.3385376-6-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020145530.3385376-6-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3OCBTYWx0ZWRfX9lFbNtxwM3tM
 90qBYnOhhtCBbXaCS4rgclwdHCONo95j7/3DZu7XWXlWVvoKaixDloBCEwVcPS20Q8AJPlryWQt
 K90lPBtN4nRUt2Ddwm6dCb3TuBWKoZI=
X-Proofpoint-GUID: dV10xFa8HwJB0cJoJN3b68UkP4bSckvU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3OCBTYWx0ZWRfXwe/vMrNFMRhp
 XNIL2HWDSffrbF1irAIj9OVv0+D68erThfpXBI/lT+66Yw3aR0QZUApi7bijvfgeg7wE6hh//Or
 CDZ8X473/Y2CU6q2oTv9Qow1lTSXZ9UDoxBH2IGP9UIblO2P4dhkxsGiN5cKSwkVdGEKpKiKv1O
 ac0qKnbk+DWP5c3a7UWrIkemQkuPFAM4Ki9NS1PErQV0dXmC9wLCyEWhyMlD1Td9u5W3geJbfCP
 5ubIfQs82BXrPLpVHzhkwloW7c/rsY9QPmMcP1pQh6G4I53iqT59HrBwqeJR5zTkXhvwdrtmvnt
 GBBcxy58UgO3ccSK0K4L4J+vB9nIvEqciWhPdWmjN+Io5BDtGo9s3JQ7DDlPoc2B3+TDEk3jBWb
 1i93YUVYPN/C45LJoYLFg6trt00pllJwlxTF9jSLuxMDBxuvgFWmUsTXMeu3K4si9CDS70lWslx
 xb17ornDZJ8ZIAd/wkQ==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad7c33c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=bDses3hDaj-Kt5rlHhoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: dV10xFa8HwJB0cJoJN3b68UkP4bSckvU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200078
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 20/10/26 16:55, Stian Halseth wrote:
> Implement the CRC32C instruction according to OSA
> (Oracle SPARC Architecture) 2011 section 7.19.
> 
> Using QEMU's crc32c.h and bswap.h.
> Gated behind the crypto CPU feature and disabled for sparc32.
> 
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>   target/sparc/crypto_helper.c | 20 ++++++++++++++++++++
>   target/sparc/helper.h        |  1 +
>   target/sparc/insns.decode    |  1 +
>   target/sparc/translate.c     |  2 ++
>   4 files changed, 24 insertions(+)

Bonus for generic tests in tests/tcg/multiarch/ (can be done later).

> 
> diff --git a/target/sparc/crypto_helper.c b/target/sparc/crypto_helper.c
> index 5d2940b825..fdae71a06f 100644
> --- a/target/sparc/crypto_helper.c
> +++ b/target/sparc/crypto_helper.c
> @@ -10,6 +10,8 @@
>   #include "exec/helper-proto.h"
>   #include "crypto/aes-round.h"
>   #include "crypto/aes.h"
> +#include "qemu/bswap.h"
> +#include "qemu/crc32c.h"
>   
>   /*
>    * SPARC four-operand AES round (Section 7.3).
> @@ -141,3 +143,21 @@ uint64_t helper_aes_kexpand2(uint64_t rs1, uint64_t rs2)
>   {
>       return aes_kexpand(rs1, (uint32_t)rs2);
>   }
> +
> +/*
> + * CRC32C Operation 3 operand (Section 7.19)

"3-operand"

> + * Accumulate CRC32C over the eight bytes of rs2, most significant first.
> + */
> +uint64_t helper_crc32c(uint64_t rs1, uint64_t rs2)
> +{
> +    uint8_t buf[8];
> +    /* IV and result are byte-swapped in the register. */
> +    uint32_t crc = bswap32((uint32_t)rs1);
> +
> +    stq_be_p(buf, rs2);
> +
> +    /* Undo crc32c()'s final inversion for the instruction's raw result. */
> +    crc = crc32c(crc, buf, sizeof(buf)) ^ UINT32_MAX;
> +

Nitpicking again to be slighly more explicit:

        /* Result lives in the low 32 bits; upper half reads as zero. */
        return (uint64_t)bswap32(crc);

> +    return bswap32(crc);
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

