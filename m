Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B03C3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4sn-0000wd-Fk; Wed, 14 Oct 2026 15:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4sl-0000wR-T9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:43:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4sk-0001lM-9E
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:43:23 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEai0b500409
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aOZ7110EOC00rbj0qWaSPrz5RO51Lx7O27XwF4XVrDU=; b=B5gqrn5LdazLLMbQ
 10GbsNChOxXVA+P8GRHrice7QmqRw8KpHyoV+fCdeuLKCkm/KyTxvUcRCPonXeo/
 Kw47lsUWivJ5qyz1el5CxewNdEl2UTs5rxTRHX13rr1PiEpG/VARY7jmiXL2UayU
 a4i14KKWt6we9G9IaYGk+Xjmiiw78dQFpsm02XJe/p7WW1n0SsAM+nlRbgs4+Sa4
 zcN60RDK1EcnBSxo1BTX72X1d27PFun5ZyPm23spe9jmXeyPiQK9XmsPKlPVt3io
 tgGxOVI6inkPanMDYG0c5zj3lqBCppIdy2kymwofmTA6D5xS2/T0SrdL9TRzSpwb
 OZmxxQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1ga4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:43:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93ea8067974so1082530285a.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006995; x=1792611795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aOZ7110EOC00rbj0qWaSPrz5RO51Lx7O27XwF4XVrDU=;
 b=d4L0x5H6CT8BTrAFs3Niprbl1YM2u7BRV7KWAaNfspG0gV0FKnB8sF5UHl0M20xgT3
 EkJIZPFtVrAsss+mX07JipMnyEKiwJnjwgM/T8P6zD2lIruJ+e6pY4ozdHmYB3K2dt3V
 YRk4Ns/TdMRTvhT86r1nJ0npPqf3sAPKd6QDHEWaZyRnEkw3sNwoyPEV+Zy4IIbRkLJ4
 bLHkv/UnJ+4UgsH89Q0Pr0DpA10hMfY5+7UyjcwGY9R3k5wU27jhVYwEWNcFnN5ZDlnp
 Z1WZudj1INRxLl3+u1oqGCKy8880htDxxUEh69A0bJDhDgVI3fxmNaYq6BOjZ5EBZ6j1
 amNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006995; x=1792611795;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aOZ7110EOC00rbj0qWaSPrz5RO51Lx7O27XwF4XVrDU=;
 b=mOvhPjYjVcwadK/IoWqgOBzTgeDL29ds8VIPY5/UR6Hr233/vb3/ckd93yTe90mhPs
 /Bb+nmxBgZ4YcJocLyDRMusUAJ93EhQJ3TNohU2DnzLTpf94wUy7armRQ25Q9R2J6hpZ
 mvThZwjqSBbe38PPpTzprE82ysO7KeoduGPeiMSVqrkilyjY48SOWHHbLsE7p2rjQbHH
 OuNWcJhoWflzdlHHKsRQ/beDkZ2CcskfW5RPayr/tQ5u6mrXqYVlATU1vYimmtQiCkqL
 rnQGX4BnsJx/TJLqdxSIPnThB+yGJOHkzZvHX8OrO71GwWR7VezMZqMFRX5EQcIrbKxS
 cSPw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1I2ff2maicJUaLLOcYJqr7MO4QqkDZhdZ5k4MYfa0UNOROhuR/xMJcBVuXynGOStI3sTSxV+OvZUY@nongnu.org
X-Gm-Message-State: AFq9FYJHYI6SLhSrsDVnV7nH8QZPRD5cE7ZhiXEhZmhaQ1K3bWimi8wD
 leDdQcj+gPHkr6fRjCEBfAQ9HxfP5U+dLJ+fNtwG77JzE+AOrhvEzf/pisuAD0z0SSSmyr5MyNQ
 fpp9GZQ9XTbTDIXhaZqp4dELAbAZf743hjdhfxovTY2nZP5g27GzTs9jOkA==
X-Gm-Gg: AYBFou2FtGpIYtFvGQd1csjzQlO+mKdkv5fLKKvsNoU/gvCEUtm3fGoh8sPV10XphC4
 LwsFgcb5TOlH5lkVlGygt9iREhnqLCVG37UnWfw/H1BqPYOELdaUQhA8lpIkV8M1S1YsrNxqVQz
 eHbqTrItZe/xr9ePheZjLgaLCSwZTdif7RY9Lnn9Qz7pFvMW/IEycI7ZJaq52Ht3K3jOb6Lawre
 zh9tXX4xD1jIqGXc9dfDciZQmqo1/R1sUbc7sUy9raZ1DT1mA/9So1yTi3pPTHyOx2W0dKy2jXT
 BzvtYfsB1lTIiCwc3NMnyQ5Sq4m63aZM7FVcrUA59C3jlEDC+7o5wfqXqIPNHxw3pN7HKPSmceJ
 RTWb05IYgj0TTJC+4leW0m1UtEqFUnKa0Vg==
X-Received: by 2002:a05:620a:2b92:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93ebd28ffa7mr2884963885a.58.1792006995161; 
 Wed, 14 Oct 2026 12:43:15 -0700 (PDT)
X-Received: by 2002:a05:620a:2b92:b0:93c:a468:2db1 with SMTP id
 af79cd13be357-93ebd28ffa7mr2884960385a.58.1792006994642; 
 Wed, 14 Oct 2026 12:43:14 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd6428b3sm16004555e9.1.2026.10.14.12.43.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:43:12 -0700 (PDT)
Message-ID: <98eb67b3-af20-4f94-b13e-b179dbac233a@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:43:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX3KOiGf4DHcjD
 hopCgJAXPuGFys1de4c+R6LdurMKOBCkkik/qrSGthVEC7bZPw46sja3KEs4pRXeAAtpBnsSLuw
 NVoYskskj+BXnDW7MpFrP15U0anbYkg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX8S9RAl/YqfFP
 3R/NzG22yp9J7y4E/LbbEJcJxD4CIM5yXtYnAQB0rGSzSe6k17LvWzpU/RdGOUOQ9qZywpy6KqO
 FafvPL2XMcz0wDUzgOhhWIM+vRCUvVs02TRgKAsZR4toW5fRakSWaHnfloE/WuT0/ozB+nISlQu
 9ccQ63dHI56PDRcq1oC6v3Da+gPBMRXcaRdyRnR59CW4lIaa0bNq10WyTl57cKNdwilSALcH8CU
 1IBUxb8Pjwav7k27jPDJFLj9e3WfGbD3fgt4+pP/tk+gFhLshkFI/Z85kQpNfRcvQ4545DZbySe
 YROM/njuwE8rmWW9sICvIcTI3KyRfRbR1198BqswAbt5FQ6xPp6Ncn2ugsrUDcHgf9Lcku2wxPC
 iVhdOrQ9hFu4SwAR+d9Cs4/LUqHmDg==
X-Proofpoint-ORIG-GUID: IfKrI8ssXv0ELJa6Rhf-rPBBOb-YBTGb
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfdb54 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=T_pGonRykoMQUb57tI4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: IfKrI8ssXv0ELJa6Rhf-rPBBOb-YBTGb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> This allows a specific target to declare its implementation of
> semihosting.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/hw/core/cpu.h             |  6 ++++++
>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>   2 files changed, 23 insertions(+)
> 
> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> index 76801444a16..456154df6f6 100644
> --- a/include/hw/core/cpu.h
> +++ b/include/hw/core/cpu.h
> @@ -98,6 +98,9 @@ struct AccelCPUClass;
>   /* see sysemu-cpu-ops.h */
>   struct SysemuCPUOps;
>   
> +/* see semihosting/common-semi.h */
> +struct SemihostingCPUOps;
> +
>   /**
>    * CPUClass:
>    * @class_by_name: Callback to map -cpu command line model name to an
> @@ -186,6 +189,9 @@ struct CPUClass {
>   #ifdef CONFIG_TCG
>       /* when TCG is not available, this pointer is NULL */
>       const TCGCPUOps *tcg_ops;
> +
> +    /* when target does not implement semihosting, this pointer is NULL */
> +    const struct SemihostingCPUOps *semi_ops;

Could these be *const?

>   #endif
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


