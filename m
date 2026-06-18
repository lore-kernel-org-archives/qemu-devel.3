Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55562CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJ5O-0003g0-Rz; Thu, 18 Jun 2026 16:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJ5M-0003fp-Nl
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:11:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJ5L-0004mP-3l
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:11:36 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IHrovK1922251
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:11:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RI01ee7RIk669aLwjrox6PhV2s7RayDJB7pR4DzMRjo=; b=kfl2tKuUJmDy6Wfu
 xr6pzTXwQ8s1Y/wjkGyfDD5bsNI5+2zbjbXF1MTJRKcwiXW+oHYagCkR0QyCszzB
 0SPaX5p4YuAEDOFbT3HmFYRRtHMQg7nbZQeMTXN0oKiYaFteuRq2/15IwOYeoY6M
 SrRVwV1F6zBbwWC0uZ5LJncbdiirGAPNWze3gB1cBSQzFoHkGL3t+tZHh4VSuO6w
 jGdi+Ka3WdP3GP08dCJ2E+hYvam25MMFOptA4wyRZtLkKY5ILGd+0F8uJF+e80ik
 SkzmqEp7odAoa9btrZSEyWBm9fAY9aa81Tfn+0spy++lqt+Qwkl476QdKIe9C9GZ
 EAWhpA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evdn42q70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:11:32 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9639158a44dso388121241.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781813491; x=1782418291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RI01ee7RIk669aLwjrox6PhV2s7RayDJB7pR4DzMRjo=;
 b=RZen3mgAVu6/L0+VMmMHxHIGKuhCmqkn5fs91kiV6E7ALI6+D7q06UeUInL5APPqRi
 xIHgr7iYpb1zTDvCyuBfmbIB1Id5tt/b2hOdTMMl0T0+TESlQ88kvGvyR/3dW+JmWQbA
 ++kRkm7Q1mWRtHcOFX0m2jqNCsQUAc79hB7gvY59364dadkKthxOErzJOOWrJhA5mMri
 VyXm6B2DW6t/oD2EQoSW3ktsRxoJz7gzcXMVTYu2wfZEoGpT639+qHsyaZ2/w/p/tLD3
 AbOKXMCEr1WQPXnLL4TzrSOoL5sCRBsZ/VtyMSM+7D63rk/RGuPvmwupkeUYYZo9cRk8
 xlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781813491; x=1782418291;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RI01ee7RIk669aLwjrox6PhV2s7RayDJB7pR4DzMRjo=;
 b=qFDGWk++C+uvnITfDClxtp5Ylb2ngfYouepYWs0Mqhic4sdWiX4mjIIxXUQAtJqynD
 CNVkik6VgXGvMP7pZZLJvFivYz1cNBPtdTwLEcpbUmAONatarJYiVAp/HwJTXgsJv/v8
 cWiyF1ERwric81pT3HvptGKkWCt5JRchKkrwvrthzLasNlg8k7WY2HBgGWskOh3h0jp0
 U0R7OZyjwCQ363gAOpreFaU/TIOSSNGHKUpOmXj359vefYpye/QbfPT2/pOGlAfmgEho
 6dQMtZ1fWklXgkzqtz8qq/zP7PfTGFWDmgExKaGsutaecVuK8s6urkh9JCBmHyqQGzhk
 JewA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VZ70bIV8A6a5Bd/06SyXlgXOkBgARlOZKUmBcHJm1/lLC4vmZepIaf59klCobyI4umPJiqMorTC3h@nongnu.org
X-Gm-Message-State: AOJu0YyTrqRiFPm2+Y/8u3+6wy1dDmHtj1W1aWuevMEeCkLuWIh1x7GD
 Y8qxQ6/COZ7LAl1nyr+eL5qoLn4E/kbSHE2TheSpZBB08LlEfjXnEJt+HLXMAkOAutBTV7p2ggI
 G49pY0bpqiWLCM75/x9FDHEMVwmxMOoYR+hBnYukRMpduBLOedR6634dyhg==
X-Gm-Gg: AfdE7cmbiUKPrKV9o5eW5p5HfjyIIcf7AkpUOq6UdSyno141XFtw/nnPfBZ7vRwc+rZ
 RXLEUTOpeqWk0dhoAIDUJwqjatxqQ/XtrcaWRDRy2QM4i6UAh74H/hSJqE1dBxuuITWnhk2FqOs
 fMnSGxK+2CSLzjNkWHUXGZ/ToMFyJmGbRO1z/8r7OUh5k2J8UvKFQvxV7gj0ASy0xLXByQB8mVA
 DBZf4A6Bw9pxqN/BsjSSH5A6hvXVtw/z7cOMy896EBcc2xAN3WOThmTjx0CRWyP2RvwjCc0hAJz
 SvURDGHT6ELDstanjgPmDUnypZpr4uJUa42mp5RaX+3wUwUqVFo+KbWRj/a12GpiufDHMYyOHbs
 u/D2HU285sNDhrhSLxMjPrVwn3zHgF0f1ItlO6B8OYrAEqlywPxCoNf+dgE9opA==
X-Received: by 2002:a05:6102:5e84:b0:6ac:c0ab:5dc7 with SMTP id
 ada2fe7eead31-72a0168eaccmr1176408137.5.1781813491255; 
 Thu, 18 Jun 2026 13:11:31 -0700 (PDT)
X-Received: by 2002:a05:6102:5e84:b0:6ac:c0ab:5dc7 with SMTP id
 ada2fe7eead31-72a0168eaccmr1176402137.5.1781813490734; 
 Thu, 18 Jun 2026 13:11:30 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650c114e22sm1242614f8f.34.2026.06.18.13.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:11:30 -0700 (PDT)
Message-ID: <7d9acb4e-d1da-45da-a42a-60340d0dfb58@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:11:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/13] bsd-user: Use probe_guest_base
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260618195520.589907-1-richard.henderson@linaro.org>
 <20260618195520.589907-13-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618195520.589907-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX1SowOXrMh/fi
 HF+PgWSC8p466XtevX3jDgR1J7cMBBnCAUgouII9P1XjvzehL3z9euI6cN9yjpkv6oIIiQx9iYt
 tMhEP3C01ImKbtijyq/fivkpIcsx4Xp13Fi+PpekvyIvgPe4eE7fwRz7IXGyWallrI7t82aiCgY
 /qp2WM8Jkigxm4i2X6DkmeNrLpO+Vs1RzyD9RTz00RsaCq96QAFUkYkFMAaBYVz7VCLUWOnOMki
 MdWypd7ylpePLGaWa+AzcJc7pR1Nf0pK+mZXALnDFi/s/fsvW2+zaVg4lfMZZuQhcBlZ9YycguX
 /8n9B0k/vs6phNp2LI3HAs7S0esTWfVzRtTp7sqDiH8KPzhTSVrTgKMwcdiFfK60fTo4y7GPgTs
 p2buzqrV5XWCCyLga458rkCCxpkeNWvXJwOWmL3kfOC0spNtUV7To4dHSn1Axi4D5jvU6UZN9oX
 TxU+GETSJ4JB4TwyQgg==
X-Proofpoint-ORIG-GUID: kGLFcAEOA0gIchpOtrRjcG_v-upZf70Q
X-Authority-Analysis: v=2.4 cv=FN4rAeos c=1 sm=1 tr=0 ts=6a3450f4 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: kGLFcAEOA0gIchpOtrRjcG_v-upZf70Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4NSBTYWx0ZWRfX8EpgG6H9XaRF
 +ozPRDhXWfAywyJnJQR05/Q9kJbZSUn/KGCmPhzpFdO3VuW60S/WK5tyv+ioPqfRcHmN34Y+qNX
 TvNCwDVHzO7cQTSQXxe1Q03ye/cxPsc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180185
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

On 18/6/26 21:55, Richard Henderson wrote:
> Merge the PT_LOAD loop with the PT_INTERP loop, as the XXX
> comment suggests.  Pass the probed range to probe_guest_base.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   bsd-user/elfload.c | 37 +++++++++++++++++++------------------
>   bsd-user/main.c    | 39 ++++-----------------------------------
>   2 files changed, 23 insertions(+), 53 deletions(-)


> +    /* Ensure that mmap_next_start is within range. */
> +    if (reserved_va && reserved_va <= mmap_next_start) {
> +        mmap_next_start = ((reserved_va / 4 * 3)

Is that ROUND_DOWN(reserved_va, 4)?

> +                           & TARGET_PAGE_MASK & qemu_host_page_mask);
>       }

Rest LGTM AFAICT :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


