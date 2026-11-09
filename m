Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D092606A326
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RfCJX5fn;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iyK0c4c8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVmm-0005CU-Ow; Mon, 09 Nov 2026 15:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVml-0005AH-29
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:16:11 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVmj-0005i8-El
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:16:10 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHC1m370210
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Zx9vuv3vdrGUOXhtJ5gk9kZNZFeFJC7ITsqFfkKlqNM=; b=RfCJX5fna83X8xhO
 oJYDuj/tvsO7Fp68y0tlZvw21T7gjbi9BkovGw/0hkPldV40pvWymi7KZtsoYh0J
 /KVWEqEys9muNQcvdyv5j96YLoZ2MSXXge7nRqu6/OuPgmOZele6xXlEXGkX+nqg
 X4L094eJ3iEQGSSs8AcUVtyjgdVm3Za1G2hmpbeqqnJ4FH14w52XXdTdxWQaoSLt
 wg+bp9l5VDubJ961L4uTPgdgJUrQ91Ca1Q0dem6/TOc3/KTlrP0aNvLyZ3NF8Yf0
 gbUTKj8cAzM/ftJsL/smirSOWm53rw+ZLfpIHtFyR7C+qtGhVxSn7YJdngw0YICO
 0UCSWg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua58amht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:16:07 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ea9e91221so24675736d6.0
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255367; x=1794860167; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zx9vuv3vdrGUOXhtJ5gk9kZNZFeFJC7ITsqFfkKlqNM=;
 b=iyK0c4c8FPUFYKwWnHZB18A/6FLZqJvA6clXfJyIpufX5NkJc+BmfXP0KF/kfc7Z5L
 R0/wOiRpK8MRzWKRk3m5nUyddCP2AN93/z+neME9MOH0bHhF7DmRQi7IUy+AyXD9ayxQ
 9mqmGwYnPbpJZu9s/piFEtwDvrc59DgZTBsOxG6BRQ7WD6gML1XKlnHthw22/B3RshT6
 xV3Hj4LXPyWLVwQa+c/wn+5rHM5Aa32iN1IyKwvKDDYRKywwMhydbaXnOimMIPX7xLsE
 PBVsmxU+HXpHhmLhbaBt0AiWFaOJ8qpOJ30ohT0gUsCtbyfWPvYkEhBMtXfkfnFK1TJS
 RsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255367; x=1794860167;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zx9vuv3vdrGUOXhtJ5gk9kZNZFeFJC7ITsqFfkKlqNM=;
 b=bKJrLiHdPiVtj5vayvVIlVGdzECGF/wSLgF6LwNCLdYZ/HErmgINI0il04/b+DFQnE
 1pgBWk0UOBVHG+ZarF/Vy0w4xbyldCzRHOUTwU+TrOx2a+ybwwL5VKqwKn3Gg0PGj7+I
 6bOpa1NDZ8M+wM4aXoCRvyMoTEnOhKXJlNsybLXWhUxgekUpLtBuxXUA/+pAgd5TzOA2
 4/2ZDuHBDe4xhXsQQiVNjrHdz8ALfe7zBEsorkwbHB52ApWbByBawvHtVBV+GEhZT57c
 4dWslEEupbhJ9wiO89Q/JdJauB4T4YL/Q070PkRe6kd3VcH8YcG1VXC1JB1eo/bcpv42
 FMCg==
X-Forwarded-Encrypted: i=1;
 AL+hErHpkwI2J9I8xz+DfzAmZHRj5ngoS8m0SZ+fq038uDbhyBDAGfXliqmC9xSeQQGet0le59DdlPOMdNr/@nongnu.org
X-Gm-Message-State: APuU4Z81kBGlxxXPYS7ddV11uywJP0/YMFSihzs5sBrONbPiIzwUJcUp
 n9l6Eaqejbnc/KnsrKJCnLm4VDS42lLx3QuIkCz3oVmaMSdp63vcyVztwZRlCz41AHaBrhaJr1X
 VOd5JKi6BGdSmpFb9dL29/rOvNDm7BE7iqMBN0/JtVxE1u7PwIno4f4Cxrg==
X-Gm-Gg: AYBFou38cB6olzRvQAs1qCq4hVPodCFwicYVolF2IFmAxhUeflvVod8q2s7RXBnuVVy
 P1M2gyDoffX/xU0nTomgA8AQNyV5i6yIN1C6+uuXNdlH+S1MprsoKOD1l/iCO287v7b9DC/D/iq
 A993spluis9fTVK/bZEaGqRYdssp3nOBTT0mwAjPIc6LIESAFfcGlsoy/P0AsGTuNZ6/IxakevM
 NrUpv47wKGgyc7JVcGQet4KoBzuwNndVjc2XLMNK7OWPcr38HJvq1vvECehAFrxG7vkxskwhqIQ
 ZX26uvmRJlVw7q/YvSJAoI/HNsAFPD5dL3efrrIBKcHDuQnWRDs4sV0oEBIupm5ujgif+xtpfJv
 FnZnM1QA6q8Yuz13QvnO+S5Gp6sMmoCAnuLP0pO8CaXkKpCVX1HRSl+L+/ORpa+6QOjTR7j3qUs
 9jCwEfdOBT
X-Received: by 2002:a05:6214:62b:b0:91e:9db6:c329 with SMTP id
 6a1803df08f44-91eef913dedmr12320026d6.35.1794255366767; 
 Mon, 09 Nov 2026 12:16:06 -0800 (PST)
X-Received: by 2002:a05:6214:62b:b0:91e:9db6:c329 with SMTP id
 6a1803df08f44-91eef913dedmr12319246d6.35.1794255366029; 
 Mon, 09 Nov 2026 12:16:06 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ef0316214sm4230756d6.5.2026.11.09.12.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:16:05 -0800 (PST)
Message-ID: <847a864f-3fc9-4e3e-8a24-433256c62de8@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:16:02 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/38] target/riscv: Add implied rules for Zvfqwdota8f
 extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-17-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-17-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfX6RugRoy56Ho6
 WrznRRFfEubA+PxhqX8x5C8OfKSEj5zbVJXspQmm3+xXHGSL45RB1pRKzwTGkwMTZR+YK19KB4+
 ZwpgHpqMvdFo6YG3D2Sl7dSR5KzQcDfvECd0wjP878ekBMtsC55DE7+2cwGAFLdtoRmVaB4g4/F
 Wt6o5tkhkF4kxr0H86tOl05boI4Z6wX22F+XQfLrgyA+EWPlMW52Xg5KckDyH6Gx0LAipzy4QZj
 KGOJxQ6OozSTtXHXTY4vVMkbB12JTjev7jDItjaPmNlgeytFlIruMw29aVdZqIWzIDy+WMSzQYt
 Sd4A20OjYoXfWtEyMYe7DAF0+zIoOCIay0WP1W/ELgQhHycIgWUSjOcm859U9WImcIAk9urXT0a
 gfLFRRnzxUdm+FxrUdEqf8RmHHDHh4BiG3bflxGGY7OdfJyfOB6MGmXUjRNTaNlcQFXYaPv8/2r
 V+4y/0J3nfAlD0M3/CQ==
X-Proofpoint-ORIG-GUID: EVjsqF5VMVV079ds-nkhRsbbWX-mJ9pW
X-Proofpoint-GUID: EVjsqF5VMVV079ds-nkhRsbbWX-mJ9pW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MCBTYWx0ZWRfX77XS/rK3lAg8
 YMK+jvWzH7zuKzYSDFn+9NX4oAlbRa8ksrHdNiOyFFagn6lwyYEXdHYLl9Dg994Z//5HRpaXsbm
 My3bvrAZhiWZKBqlJbEeLAhxt8iGq2A=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af22a07 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=_HVl63z-bU3wyhxsAlgA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090080
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvfqwdota8f
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4f2e7a8faa9..6c09685bd4b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2875,6 +2875,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfqwdota8f),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
>       .implied_multi_exts = {
> @@ -3081,6 +3090,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVFBFWMA_IMPLIED,
>       &ZVFH_IMPLIED,
>       &ZVFHMIN_IMPLIED,
> +    &ZVFQWDOTA8F_IMPLIED,
>       &ZVFWDOTA16BF_IMPLIED,
>       &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED,


