Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3976606A330
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YlMggtgg;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dAzQhzfP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQWBX-00032S-H6; Mon, 09 Nov 2026 15:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBV-0002vY-KZ
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:45 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQWBU-0000HP-2k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:41:45 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHEZ9879372
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V8LA1K2MhY3qSGqrMiwaC9cEb49HUeOpHVR3klfcxpQ=; b=YlMggtggOVqEmFBk
 R8/whBIbR7AH+BIAYspMI2wKNgUttysmezcwv2TmYLK8reDZxBcBfk15eqCTcAlv
 vdCt0iWfJKzdbVd9U0FjyOmt/M52aIETgq/e7OVB6hWloSrttU4LgyiHNpI0L7DP
 w10N3E65ZNOS3EcbuN7bhK/RZkVrZ0O4XIZGwQYm/ZClswf16SsyXiQ5KsPpA9yP
 jOJ+4uclMoTRryQnjgeHfJ9MI/Mye8JR58nKOIlEceXQlGpO2voIbLwalpVrjoWM
 qPlvgc1b8kW0i2l+c73GbgVN7r6Px6c1x86pHyyj02ZfnCDOO7q1p83C9W/JV1Un
 JmEj0Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucr5t33n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:41:42 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so28742251cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794256899; x=1794861699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V8LA1K2MhY3qSGqrMiwaC9cEb49HUeOpHVR3klfcxpQ=;
 b=dAzQhzfPXXS9e7Bq78yegb9aJ95XgKOtdL8TXSVToUhWgg+pRlzG+p+mKO1x20hYTk
 VtRsyW/59aHcER3uX4yXczlzcuFWGce82aXwVI/VaXukHaQ40UFXHtHSvb/xh1fBbTYR
 mXJ9hld9yvxJtzHGxd3Ctc7+pYCSwjVVLiG2BY3Nrb9Xjw7XuNchCxGLdlr49Tnm/72n
 kfQe7P9+R+oa1T3APXmMAe7bxmOUivDWGuDukP4cXVGJce/NdhzTZj8DvSonSpQM7zLg
 6zVQzHVHrnmeeL359sf2zfL1/VxB89RrqWf3V/0cD6uw07noP99yKDoR3Ea1jVgd4520
 7K3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256899; x=1794861699;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V8LA1K2MhY3qSGqrMiwaC9cEb49HUeOpHVR3klfcxpQ=;
 b=HO0QxasKdpFTLpqNOw4GCnox3p6I7EwmBMjtyWqHiwR6WtSEhCOq0fD5STEsb2hYUc
 /In25qoKs3llC2QDxLVf5vjm4VSmpgxZAuHH2vkGtXKvgBsDKsB0rMrJlzpjN3jVJ7kc
 AENjpsES2P9tTZzb7jY8EgAAJgcscpVcxeY0lxh68OjfvfcuutPM5kXMzicxar1ypXv+
 FmDEoe+p7rctpeLTogxEktSARwCeM/JFZDeWdwO3DKa2w3emfOe5wpUM3/Otd/Nd/3yW
 bCoLzN6uGw/sC21bQ/yVnD6nzHLAQJOV/Kbi9C4+oL0e8oRr0MT2IN3O9QtVZAX67E8Y
 AW6A==
X-Forwarded-Encrypted: i=1;
 AL+hErEfYt1Z56HaJ9vclalj79mUxGPXwqHFsQPig93liaYl7b9G3j/PJFdZzswhLHzY0ROYzsUoCUk1RJUb@nongnu.org
X-Gm-Message-State: APuU4Z8+xd+UjXLgV6cs+m79JTCn7WyE7IhMqtezNRQzFX4TMIp5MH4N
 kiRy7d1uuxN8SYKZdhl6GzANdaPsEtimRBzbYc5UshgwxJlzA+/NpCV+PaXiem/8isJh1y8Vm50
 Y68oN6vWl0TOkA8fWD2n7UQiml312ameejMW6VS+NScsBj5Vzln3+n2eS7w==
X-Gm-Gg: AYBFou118XJO37xp2dMTFexxWBkLT5DnO04RBxh/q84l6h5iiZsFLXhbJ+ZkyaLXhsO
 leJUMOtDvfiMk/42QwNg3/usULgs2Q/2l1nOT0f0FOU4TZxMxSDkIUrEfZm6VzPHlbBtUThJE6j
 AA7SoUkuyrmR6iL9MG70Xbp8AyS7u+u0nx8wYbyZfLA8ccYeU0RTe/dSja9vW3GXftGxnIZBuTa
 Nt+ubeevmhcWK3P7oL8J2I1rwSM+nJSc5pig5WB7eQBWJOJM1UJEj5faf7JSzQRouOpEccsHh/x
 9TA0uApV9GRY0XJBDXKYRY3waYdkn618cmRKufuPF7HGYg3+gMiBnDPCk4Kbc8O2EjTZ3fdaERm
 dLkYao2yHL/hS7GeRGOF3cBbS+uIpsLysmI3hcAhiLljfRitwgWEMhhjQ/Qy/jwxaTfCloakPEA
 0IjTr78/00
X-Received: by 2002:a05:622a:1aa8:b0:535:f9f0:19c1 with SMTP id
 d75a77b69052e-5552a45dfbbmr8061731cf.45.1794256898523; 
 Mon, 09 Nov 2026 12:41:38 -0800 (PST)
X-Received: by 2002:a05:622a:1aa8:b0:535:f9f0:19c1 with SMTP id
 d75a77b69052e-5552a45dfbbmr8061441cf.45.1794256897951; 
 Mon, 09 Nov 2026 12:41:37 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550be2e592sm6195011cf.24.2026.11.09.12.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:41:37 -0800 (PST)
Message-ID: <ff22dc05-bf64-4d24-bc51-9b4cc38ba16f@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:41:34 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 31/38] target/riscv: Add implied rules for
 Zvfqwbdota8f extension
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
 <20261104194155.679241-32-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-32-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXzHxJ8x3d30ST
 tsvcWQnJB77SxnNsOsb8rMCMvM5LJdMt0lKHYQhS7zqmPzdGEMpJ2LEmX7XoifB6FYDVYksJuZh
 +SjPUspekjFlEI797g3JKqtApumzG40=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MiBTYWx0ZWRfXyvy/CV6nfANq
 yN2jCkvTY5OPGlMa2IQDqr09UTTTJzUSyihOeTPniYlAwm7E6dTrQPfwzvWbYDg2KCwvRoUX2x9
 kODkWhayNWCLk2bGhjGwtscxjY9nHppnQY+unAs36eGZeZtY3huUkQ0GsGIK6jcBV62L0+3dSkH
 phKQ2FIOjQS7tmGecUeI6zg8MbnKtW9182QfMQueYhjYaZ7wKcNPih4Ny66vNuVM8wOvQpV4azX
 wR/ChGjRkoKVcjXIcoo3nm+uZSF8T+piGliYa3TMJqb8vXePWA+XuSdkKiccK9R4mXQJX+QmWlB
 aElSrpjjRbDlSG3hZkKsatQKl0LrNxpiKMX3nXfJmQVImjf9vhWPxBAx7xQgClaaa5Q5S9XsG4J
 i2MH9pvdzRi9S+bnqk9BHafoY/1/eyHnE94Vaz7bU697Lr1PSknrJ0W4ZMQrNhLMMS3mhtFs24w
 0ymW9xeFjcXAuHRykrg==
X-Authority-Analysis: v=2.4 cv=ErlHPicA c=1 sm=1 tr=0 ts=6af23006 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=XYTSCjYpITQbR8rEsFMA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: jgdKb0lKOwIyoOrYtUpFiOwA4MzTvHEK
X-Proofpoint-GUID: jgdKb0lKOwIyoOrYtUpFiOwA4MzTvHEK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Add implied rules to enable the implied extensions of Zvfqwbdota8f
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index b4a9f2c3e30..0a35bc7c416 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2892,6 +2892,15 @@ static RISCVCPUImpliedExtsRule ZVFQWDOTA8F_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFQWBDOTA8F_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfqwbdota8f),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVFWBDOTA16BF_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvfwbdota16bf),
>       .implied_multi_exts = {
> @@ -3125,6 +3134,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVFBFWMA_IMPLIED,
>       &ZVFH_IMPLIED,
>       &ZVFHMIN_IMPLIED,
> +    &ZVFQWBDOTA8F_IMPLIED,
>       &ZVFQWDOTA8F_IMPLIED,
>       &ZVFWBDOTA16BF_IMPLIED,
>       &ZVFWDOTA16BF_IMPLIED,


