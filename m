Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70F5CCA464
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 20:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHS7h-0003IY-6l; Thu, 15 Oct 2026 16:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHS78-0003As-CJ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHS74-0005pe-6F
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 16:31:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FI3OMV406092
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:31:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IV6T4xY8qIhNHKe7Ip1e1CLJJ3oSdKW1tWzlawOZI2g=; b=MJuVkSKyimU713rU
 3dGEvj9ofaPuUt75MSEpdPRkslIJYpqZJ9lEjRLw82Su3MEJWkj3AeoAXaVBsMb0
 usMSm/U1ygcvGbtxhMVnfEpCfrrY6WBm0KPHoKLQu97ewq1u5D8nb2Jctgvx2br6
 liJ7MZQvVyq6Ynl6nKsGz8mCRU2x2emtxmOZOnFhcNcaZJpnWbp9Xn2XUuVFjeYK
 u2MQ/0aUUM7P09KTx6579PSrYiKq518Oorv7g4PxnDaQHDfzvJFdnTpqVe+kvfYz
 qbSteHsPa8AsmXNfLKzFY5iKsGNW0RLUEDXzpX6TKYR4rp6vJ4S/c68BGu06h487
 JL1v8w==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sa0fyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 20:31:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-98304865f02so4557490241.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 13:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792096299; x=1792701099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IV6T4xY8qIhNHKe7Ip1e1CLJJ3oSdKW1tWzlawOZI2g=;
 b=GzEIgS3ZmMH+l0ELQUMlO9GxTUlqU6wQXR8SQLhoxif5DjZuYZSv4MS9dMsXIvyLOl
 773jw/8vba0okz0Mw3wt/mVz1fqYMN5PutIKF0RkaNC8hGF7MkDNukHD17HCcYq1e8Ja
 Msc/Ge2yDNkV82zi1eSjFA9+76jwGRL103JWGtpcjqDx05vWhymHfDIbpXeZZKy0D65r
 c9TRqrbKxz77XvdEK8ZbC7F6LOSRDdorMA9aysBg2awWz0oBORps88f+KBiPYUcYKdYC
 WBdcBEYgkz+8IOemBJh3tcOvrUdLL7z/gnSHb/4HNT3r9i3fJdzu0NC/noQkeuRLa+wa
 YE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792096299; x=1792701099;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IV6T4xY8qIhNHKe7Ip1e1CLJJ3oSdKW1tWzlawOZI2g=;
 b=TgldA6OTWRVV73EVDHDG1zJ+qKjRKA9hvatzj7YcWBdqLqrT5tT2UP1gevGQiLyo/q
 0/RJnqhWuXwZO/L9jLfgmAeVWHMf6bnSZTSr6Rniw4KQWFiypFvYk5go0/Qe5646fHNB
 t9Ka+5hUxg2q8GNAZfG0x/at80dkcu+Ta763Hp446gVii22uBgn/Mf8P8eKoUMfeZUY1
 LF2Hr4caWo23XAHWCu0Ms9apa9pgJ1XObowuRdGCPbFWlYUzoIydop8XHVWzGBxg94GN
 KdDvuQlsoM2GJ7GHX64WiG5x+e4EC6fWNPlgPHsY8iMHvP29jRdtDh1hmowpxKUlMICH
 r39g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxn2KBsSRmEr8zF6KGlvXdd+Xx7VtTThoX7sZmBSOWX2B5MEeGufZSu2Uvc/8UUxcb6gcvVG+FB5llM@nongnu.org
X-Gm-Message-State: AFq9FYIfrBgwLvRuNnThb0eHZnkmtGmum707ZiOLbE8uIiUAN5URLKlN
 g5Yumh6e0QaZY3YTJvjkWRjIJDyBHR5YTxMbnIbh1l5gH/8hDzvG6WHoH0Bsr7dXpmcZ5uBNI3q
 krAQWDKOdj5M978LKFCAj+/aF638qGnEjACJPPS/hlPXZbIw8mWa5d7cnPw==
X-Gm-Gg: AYBFou2Yn+waHe7xrLycO0VBczXm+CdM2ahI1dbmeehsfdX91OrY4BZTvMuvoocMcAc
 vyatndC5IHOGx0Ch3qJMDQIKmRQi7aV7W7RA4hDS+9yOHD00toE5qY4tYWWUjLzegohHeZkA29B
 1jJN6glTDofFnVP2Q9wEv4pxu4sMjuSO/vkl6YTVyVJ8SUtG19dk1izIcdtOtIW78HA6jKh+zLO
 XDJYXMSuTdxzl5Z7zMI43yFYChYmldR2zczPrMvlgUxr6u/2MxUKvIfIrWGP2mdaimzoJqDCRqK
 R61wdohzlYEHq1SQaouCjdx/Vxq4YVdVIk3+pvokZ3OmRDdvv3yQzjQ8e1qH//51yRiA9Qs+zgI
 UdYcfbk1cAYpYx+AQtFDwZdhRkhaFnRBCgBY=
X-Received: by 2002:a05:6102:dc6:b0:7c8:3b8c:82b2 with SMTP id
 ada2fe7eead31-7cb3a00273fmr6547497137.7.1792096298807; 
 Thu, 15 Oct 2026 13:31:38 -0700 (PDT)
X-Received: by 2002:a05:6102:dc6:b0:7c8:3b8c:82b2 with SMTP id
 ada2fe7eead31-7cb3a00273fmr6547472137.7.1792096298216; 
 Thu, 15 Oct 2026 13:31:38 -0700 (PDT)
Received: from [192.168.68.103] ([152.234.126.58])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91bcbb0b231sm4608466d6.31.2026.10.15.13.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 13:31:37 -0700 (PDT)
Message-ID: <b87a7231-ca35-4c1d-bc05-ffeee15eebf0@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 17:31:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] machine: Support extra board CPUs outside -smp
To: Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Ellerman <mpe@kernel.org>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
 <20261015031804.2406055-8-portias@oss.tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015031804.2406055-8-portias@oss.tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA4MSBTYWx0ZWRfXwRaoIP6fNj7H
 vT+TcTvNwA/JDwgPLPawThLZk3PXz5xICdm4CiQQtBeop7VGbXmPzbJ3nq51jdhnaF5zHnrjaCF
 +vqfmTjnHfQNElUff4ypbeCajR7dfa4=
X-Proofpoint-ORIG-GUID: mAOZIrss-Z7RebMsY9Rrz6gVyfW5DiuI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA4MSBTYWx0ZWRfXysZ8/DNLt3B1
 3/O6hVPaI0jVV2+fTGe0GIKrlsZTBCLruF5oZr41Lx7EF7ZifYGf6Kc7Fpx4n2dnMUAAV4QPMfU
 vKYXRroj2E6Lbpxwp0sWyAHahc0oCkvwX3Ax+2TiwHLkRJNVZ/4U3DDXZl5OPl5Whpdb+fK9Lh4
 vz0fXFokrZOo9Sqjkzx3cA5+oPPTM0WqQW6f7j9fWaPCYN88DLbmXFpbShlIfMoximzAsLCZwii
 Z80QhMHjL1tM8/+Pm5Uoc9T+WM9NAzneiNWOs7ZGY3+Ml9qPZ+UFBnWD2jK62qwGVWHoM//rXqU
 ++3+5DuP5JVFh2LxhNUBYEdt9m0Gb3wHyA6A5BVUH3rs6Qmk0Q2etPCzSppXjhyvdkx6T5aqGul
 8fLrz8x2d6EEechsPe1Yfgdk0s985F0R2WCEG7ZFPk3wHE662mQqVWSmt4RBh7rfAXAcMTw7AzN
 QjaIdwhJwuryjNAnG7w==
X-Proofpoint-GUID: mAOZIrss-Z7RebMsY9Rrz6gVyfW5DiuI
X-Authority-Analysis: v=2.4 cv=AN0XGc5Z c=1 sm=1 tr=0 ts=6ad1382b cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=XIBTAJF/fpiF5bhQ2IRv1g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=t9496tuAAAAA:8 a=5K5A09L9cPE9y_8E8T8A:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Phil, Pierrick,

This patch seems to dwell around your turf.  Did you think about how to
instantiate different CPUs that might have different SMP topologies in
the context of single binary/split accel work?


Thanks,
Daniel

On 10/15/2026 12:17 AM, Portia Stephens wrote:
> From: Joel Stanley <joel@jms.id.au>
> 
> Boards may instantiate one or more CPUs that are not part of the
> user's -smp layout, for example an a management or boot core of a
> different CPU model. As TCG sizes its vCPU context from smp.max_cpus
> during init, creating more CPUState objects than smp.max_cpus trips the
> assert in tcg_register_thread().
> 
> smp.max_cpus is finalized before the accelerator is initialised and the
> board's init() runs later still, so a board's initialise cannot influence
> the count TCG uses.
> 
> Add a MachineClass::extra_cpus that boards set at class init time to
> declare these additional CPUs. TCG can then add it to max_threads. The
> field defaults to 0, so existing machines are unaffected.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> ---
>   accel/tcg/tcg-all.c      | 2 +-
>   include/hw/core/boards.h | 4 ++++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
> index 767e880555..655609ebbb 100644
> --- a/accel/tcg/tcg-all.c
> +++ b/accel/tcg/tcg-all.c
> @@ -126,7 +126,7 @@ static int tcg_init_machine(AccelState *as, MachineState *ms)
>            */
>           if (mttcg_supported && !icount_enabled()) {
>               s->mttcg_enabled = ON_OFF_AUTO_ON;
> -            max_threads = ms->smp.max_cpus;
> +            max_threads = ms->smp.max_cpus + MACHINE_GET_CLASS(ms)->extra_cpus;
>           } else {
>               s->mttcg_enabled = ON_OFF_AUTO_OFF;
>           }
> diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
> index d0e4ad9820..575c6bcb31 100644
> --- a/include/hw/core/boards.h
> +++ b/include/hw/core/boards.h
> @@ -189,6 +189,9 @@ typedef struct {
>    * @max_cpus: maximum number of CPUs supported. Default: 1
>    * @min_cpus: minimum number of CPUs supported. Default: 1
>    * @default_cpus: number of CPUs instantiated if none are specified. Default: 1
> + * @extra_cpus: number of additional CPUs the board always instantiates beyond
> + *    the -smp topology (e.g. an always-present management core). Accelerators
> + *    add this to the per-vCPU state they allocate. Default: 0
>    * @is_default:
>    *    If true QEMU will use this machine by default if no '-M' option is given.
>    * @get_hotplug_handler: this function is called during bus-less
> @@ -287,6 +290,7 @@ struct MachineClass {
>       int max_cpus;
>       int min_cpus;
>       int default_cpus;
> +    int extra_cpus;
>       unsigned int no_serial:1,
>           no_parallel:1,
>           no_floppy:1,


