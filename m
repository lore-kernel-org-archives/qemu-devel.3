Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA49606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oDKMok1w;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=g/5tSYJ+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJNQe-00024v-5K; Tue, 20 Oct 2026 23:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNQc-00024l-T9
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:55:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJNQa-0007A1-S1
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:55:50 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2FPWD2394187
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:55:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TbUkysE20BkIrdhDZdfEKEOJhGUID56GecVWgEpMVbI=; b=oDKMok1wB3FT6AW7
 wClQQ8keS6E3JlHLHYdexUNNmEuuw9lZq+NT7WJgzjqrKqgBKvpEgMrbyPR5W1up
 0fbw8gdwGF20tfFvx0xZXqRERmaqUAbFO/yWf5IlVv1TCD17EumcXgeFlx+63ZHP
 wTtxzHM41ggRXYnMg2qV1z+SruBv6kq0YlBdrAeF6bgUJZkJBOzNeuXGF0vI/OjX
 OxAPy15NSPbTSv3QkhWugcqrHhXNTIdu0hJ9pJ2k30BYiR4diAXQaeSEZx1ho0aH
 ialWPJkEd32bRfieqtpls8vfUI/t0G1NgzIg7c/NZRDA7hGSL0OQK95C4nMfFsgh
 FeHuqg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4heeb99mwn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:55:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb6391e89so68989985a.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792554946; x=1793159746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TbUkysE20BkIrdhDZdfEKEOJhGUID56GecVWgEpMVbI=;
 b=g/5tSYJ+TyX+rV7FUsaeVE4SC2mbRnOLE076v/qgZH0PxMXccB8Wg8ECdKKNIxf00X
 p8XpKBbaQcEJjwD5xmAX8NotUICbV0ZJWuIUJkdZAOv3Ieeyyi5SvLuVRhrCWZIbp3RG
 423kcIN8G63GzyUsgz5CQ9DHx3QBdeSJTuDltxupchc6HoWrEPCf8bHPHGGMOiGf6iqd
 sTjYjjbYs7pru01UyVFXkqxM7C1TlUIsoZol5wynBhSGZxMHUJ5DIyYfidWn7OhtmzWy
 tUt9aA3/uoVi4iWHBbsIoTzhjxK2FwcckkmonPUe1qgMKEMpu9ksYpobwJXB6lRWOK/X
 SVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792554946; x=1793159746;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TbUkysE20BkIrdhDZdfEKEOJhGUID56GecVWgEpMVbI=;
 b=DZUuJWYMFKejso7OUYppreTMzJxkn2YXwktSFtOanYcEELoDtj8XSOImEiBq5yaRYY
 TzqsyMKQMgI8JUjVLm/G1OkfEA0ZS4emXX1AIYHIML63cd1fWeTc96WlYv1HhZw0iuvy
 kxOPHxjcO1iWykoI0qwvpiIqUnnJjZSwnsC/UNv1SXmQGdpEr6xKu2aGmqT1aZYKDxt0
 XiFK8nbif6rKdh1/53qjigKiqk8/MGL6ZeaQYDYkFzuykfHqoy81sbcPDn8Cz6JgjqZv
 LmWC3UIrHMD4d//g6nBygOrZgwwPVemkYzY1fN4S3vjLxe8ca3kQhA2GR4m4ACWmzoAg
 y9xQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByeBH2Bx7PUTnUNrlpPN9sPNo4oXvjzMC1PKA/8mgK0dFbnovaiUuyNAC9jNwFNVrWdVwq7TVzKDWrx@nongnu.org
X-Gm-Message-State: AFq9FYJbZjfulvCYoI4WAqojXfA8J45l+xk1xqKzHAADTh8n/mHCGyrD
 V1bVtBSvpIG5Bb2RFC8D37UEQmBwez99t8wx1k+Apn7YR6HMxkWPZt99TUKZ9zNcHGnut+Sm2cN
 YcY32cSJwec8ovMulc11i9FKwPsjYMDfq/V/apZDOocLUx9jSh3oOnq5u/Q==
X-Gm-Gg: AYBFou2uSzp2+9CgnqretKR5ycXSknz7rZzXolHjmDLlfSwB7nd9+NZcoLW+A6LU3KN
 SqA/KQqwFwlDFTtLk8gjqtHCNNpC2Npa4RSJaK6V/mZA4R9RnFPEvZGXjHhb8ASB/JlCZ+NGoaY
 7gYhZWUCXfTjxgj0p+jrGmAFI8OABPUbDBvAcC99urDkNcWKo+WNxk9/ofc7PUTqc90D/9DhYPF
 xwIvgXImu7PJNjV8319qRcETfDhJva6DJMJuzZ8aGX2Gz3a2mCz3tnbfvebpCQDh0F20y6b/1Gf
 daPhrSQ/SRKsU39miNksEwPN/mCSRw6TykBcifu0k3vPImW+b4QPgWJ0WzNc62UsnhAgKq6MOWH
 XoRt9/jMrPDYyTCjsLLbXSE9/QLSVxlloiQ==
X-Received: by 2002:a05:620a:4395:b0:93f:2eaf:64cd with SMTP id
 af79cd13be357-93f57f466f0mr216088985a.50.1792554946170; 
 Tue, 20 Oct 2026 20:55:46 -0700 (PDT)
X-Received: by 2002:a05:620a:4395:b0:93f:2eaf:64cd with SMTP id
 af79cd13be357-93f57f466f0mr216086385a.50.1792554945701; 
 Tue, 20 Oct 2026 20:55:45 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2584c3b0sm2803778f8f.57.2026.10.20.20.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 20:55:44 -0700 (PDT)
Message-ID: <e8f5a805-c81b-424c-b5e8-9c5f2b7a6e9f@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 05:55:43 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] target/alpha: Convert to translate_for_debug
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20261020122752.3651914-1-peter.maydell@linaro.org>
 <20261020122752.3651914-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261020122752.3651914-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfX2FXIuiQ8ex47
 VUClOfTrwrZWLpQ1cYVCB7hEYRePJGfg5uuSosDi3s5zrFoa67aMqjBBDHboR8BNjbxifn1fiHn
 axLJd3mUrqqjN6/wbPqAwqgHJe274q4=
X-Proofpoint-GUID: veSqy4DwTs8_8XX5LeDHrokTkPE9049j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNCBTYWx0ZWRfXwt+TdH3CmG1U
 2dn/D5NiascpzeGiNOOKo25I4WMAsBAbHQQJLnp6LpIMcoPncAqJSO3YTsfXcdZvtEHKjPMhnAm
 kbnLq4pdrXA2sJW+b4c53yAo4qJG+lIsx3158f2zp5fgkk+MMlnZLKBlxWxEX6X2L2WTrNf2At9
 U+KfOeafXGfas+nZJe0kmTKBa/G+M+UBG6mPvUrnHMnf6CT41TbkaXpA4oQ3hqHLYcSRv9GQYJJ
 RdqjAnFgw/FQz9atCAmuuuqLJCCBRbwAOdYazBYa0OKVHLZjaPiXrDW7va1YwYkU4Wwo3eMvLWO
 a/hzBCpfbxEBkhQSQf1HI9ocu8x3MmPmcuZ9ZQtphy7Mu0GZPC7zhQPxU1gNCExYy2w+AmyVuYU
 L9Y0dhswvw09wNQJdxD6Ud6oqVDyIuJytdp9fVKusLuUAV/0MTj/z2oEadE4RJSbSmAA/iZpTgW
 WiMpRqL0Ow8GG0J2hkg==
X-Authority-Analysis: v=2.4 cv=R42WitRX c=1 sm=1 tr=0 ts=6ad837c2 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Y6gY2AGrPiTvvie_gDQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: veSqy4DwTs8_8XX5LeDHrokTkPE9049j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210014
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

Hi,

On 20/10/26 14:27, Peter Maydell wrote:
> Convert alpha to providing the translate_for_debug method rather than
> the deprecated get_phys_addr_debug method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/alpha/cpu.h    |  3 ++-
>   target/alpha/cpu.c    |  2 +-
>   target/alpha/helper.c | 15 +++++++++++++--
>   3 files changed, 16 insertions(+), 4 deletions(-)


> -hwaddr alpha_cpu_get_phys_addr_debug(CPUState *cs, vaddr addr)
> +bool alpha_cpu_translate_for_debug(CPUState *cs, vaddr addr,
> +                                   TranslateForDebugResult *result)
>   {
>       hwaddr phys;
>       int prot, fail;
>   
>       fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
> +    if (fail >= 0) {

Pre-existing, @fail is mis-named, it is the target @excp (or -1 on
failure).

> +        return false;
> +    }
> +
>       phys |= addr & ~TARGET_PAGE_MASK;

Clearer, we don't update @phys and discard it on failure.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> -    return (fail >= 0 ? -1 : phys);
> +
> +    *result = (TranslateForDebugResult) {
> +        .physaddr = phys,
> +        .lg_page_size = TARGET_PAGE_BITS,
> +        .attrs.debug = 1,
> +    };
> +    return true;
>   }
>   
>   bool alpha_cpu_tlb_fill(CPUState *cs, vaddr addr, int size,


