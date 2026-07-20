Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77386C4452A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 14:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlp3K-0001s2-LV; Mon, 20 Jul 2026 10:33:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wloyw-0000lq-GK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:28:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wloyu-00022z-TS
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 10:28:34 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDrPAE2880148
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DCD6ryiRf2IMgIcsXdTwziYvUf4p/7Yn9QaMTtU6zJ0=; b=hq0klmAYnZP5JoJT
 sK8drUjzh7cTDgtIQP/uzz5l5uiX5a7DxfSaCuAs9qtlj9lEV5RHV9nY2c4JPlir
 IZXTWAJ4lfTzIAxbamP2ahNv18SeR9auDvEDjtkV6KQusvGpPakIPhWSeZoQcVOd
 3tTG61NL8drdtDPEtXiq99OhLsWQSaGUKv/HuR43F4GqATNNpd7R+17wPc6W6kUi
 wSF8mnXCaF4xTjT+i6m+O6Puk3xUTKyEkp64EJhYdxeOmVvOSlI14djRZXhF/Ybr
 H/7V1ha7Fnlhc+pxdFLSruCGISMvZkB4M2c51feCsRXGB6ZPO+yGEOgeR3MGmTr9
 DKslxg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0ksvug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 14:28:31 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso195953241cf.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 07:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784557711; x=1785162511; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DCD6ryiRf2IMgIcsXdTwziYvUf4p/7Yn9QaMTtU6zJ0=;
 b=Rd0LwTE2un7m6ZaDfnLmccTlhwJfmY7kwivU65/Gj6KCP4EQ8v1WDwSVsTsfml3di0
 GnjjeA3eWsbapzkhneSpi6tJVsSqL2Vi5KfXDKgFgbdw99mqop19bDdX1VFBXetTn37Z
 sTMWlr82DFilviSIFEECsHofth3SDN++jGTFGgkRuLLqvSQgO/p3BQVqW6MCAZKdpNWA
 dSdhcVZh6FcOHy+/3iehQu8m/EpiMLbe6sEGuM6Y92HPSwm7fiD3VfbW/U11AwHQ0W9s
 0OeH/gBLtPbhuzJ7GURrpjJboYtaARo8KsOXGAchR/Y3TQpnzb0vvNbYPr8yQHibrxZ1
 hIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784557711; x=1785162511;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DCD6ryiRf2IMgIcsXdTwziYvUf4p/7Yn9QaMTtU6zJ0=;
 b=URWl1vPQi/Vh2r0cTwax8wHSyFfxnpFZcEg8WuC6a8L7bLIKA+bPCmCNTSu+qc43fl
 LWN4DOsJfhJ6qLoQ+p2QCt5i2NqERW1cTf4ff6to3eTiVEoZkFkhfH8kpDQBsZPQb7Pg
 OKCCxFgPv6WXdk9MKZsEc3JpudOtEW4UkayyMVLgGqQN8ciy8mvOf9urLDysi4jAYNGO
 dBZxywcY8pJ5PKK/00QJbJsNt1FfF70vTkgPzNEUqFEd2Jgo+MDovjl/Ja06urJGkXaO
 AcoEz7Q1xhBCEFZS3q+3CtYp+QIceCvrTjLy0Hb3v5e1LgjiDW1pvxGD/jI1oz2TFDwP
 MjMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGv4IbyRUQ8jF9IdFaJIpV+16foRSmURwp6QK8W+TOwWNVO1svwUXM07vTrw/HIeWHDyscpcbWBZ2C@nongnu.org
X-Gm-Message-State: AOJu0YwQeZz+CCI+KgiCvQUgfDLfI/uHAaZQRaJaqPOV9mAIdUH1bNfb
 d4C7tWGfc2JpeL6jG7Evip0Wu/9FCXnVVttuv1dCRoPaBYf7yiyoPkO4PGjIVCGIfaZqJH3M92a
 ZTnGBtWzkJdB63BramvpbeTfRD9qzr59QaDNh9+W9QSO/9/6ZU4Lu/ONfeQ==
X-Gm-Gg: AfdE7cm5n4TFP2El1nmhDpdV3hZDd2Z0Ey0JlU+zXnBWwvqgBxKYTSXjAiF9Vhrog55
 dkjv663JSwhn8K/7j9NXrLruZqPqIgXBvWzl5J0SC4yQUhS05qM3J3TPh5Dss4b/Q0+9fc+HNy+
 wXS9EFW90p690SGt7fLejRMERxfg2Oy0x/2AlG6KCacCTxobO+o7vOyBuFTeT1pflBDthrFZcM0
 P96t8iNMfrLWF7Bzur/w+VEfZX5rD4bPXULR4Rf9+EI5+9EJ2j/z0+T8THJDoBRgRKr5yQx7pMt
 GdRsP+Pqk2G/fj8Wa/KMbcl9og6AyBkGoGMAPkGtuUfnFXwQGd3jMKazk0I8gbuZ+4xrPOS4Iuq
 nT61O3FQJRsFiMGHa5JIn+jnjZtbklsucwnd3p/SbK7xpNFwfYeY=
X-Received: by 2002:a05:622a:11cf:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-5213e28e1c4mr134792721cf.56.1784557710879; 
 Mon, 20 Jul 2026 07:28:30 -0700 (PDT)
X-Received: by 2002:a05:622a:11cf:b0:517:61d5:2f7b with SMTP id
 d75a77b69052e-5213e28e1c4mr134792291cf.56.1784557710387; 
 Mon, 20 Jul 2026 07:28:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed1911sm32338925f8f.22.2026.07.20.07.28.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 07:28:29 -0700 (PDT)
Message-ID: <9420cae5-c5a8-4622-944c-172c8edff13a@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:28:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] io: add missing coroutine annotation
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
 <20260720-co-v1-3-fabb4db3c204@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260720-co-v1-3-fabb4db3c204@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v2S9VG-51RLTqoMvbn9jaXPOs1MCACHP
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfX4owwcGKUQRsM
 VfeZF6mLapK6DTNxT75GRBHUiPMtricHLfdcohSA7TzIgpotU4suyj9XfYrXbKnf4t/7dGhXgLb
 XoFQN6sumPBUKRoSNdXFp0hKwwGYxTU=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5e308f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=IcDbTAYIwZMDiq8AA74A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2MSBTYWx0ZWRfXwP3qt2KrY53H
 P4Hm+AndSCzJTu7RPOVyYFYMa4upIrawmO/AlOutetDAI83YPGHZ5R3QfOmKmGfuYFRdmopFwg9
 LiUBMHVF8s64cmth5YX1jsKSQpuppvNAKTRgIk9qkm64noF7RFf87xmSGCviCy1aKp6tuxHdYzm
 PkJ24bzU0dBTvUwxkdhhcfFmRtzlPIs4L2B85f6cg0L5L7x1IJBpHtzhfW82R/MRrRLkCFZWiWh
 vloO8uDxk9cF1WcOJsnZNH5YEnphVfGUDfgZE/1jTQjmQSkTAC0zdojHoHSV7mLb4sfZKjiXhbs
 hzBuW/5cM5G7V8fXjwYDzMpOrhCAE5zUTYC6VaStT3GBGvnwKDNYIt/ysbysghbyAq1Dmh162U/
 o/5gg1Rb8R0FDX/XVftEdzK7UgWzBDryfA1uUN7j4gwI7nKqJmZ7EwjJpdRQWfXm+6UyEg7LJGk
 fICqsQGnmX2C45cE1SA==
X-Proofpoint-GUID: v2S9VG-51RLTqoMvbn9jaXPOs1MCACHP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_03,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200161
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

On 20/7/26 09:55, Marc-AndrÃ© Lureau wrote:
> Fixes: 1edf0df28409 ("io: Add qio_channel_wait_cond() helper")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/io/channel.h | 4 ++--
>   io/channel.c         | 5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/include/io/channel.h b/include/io/channel.h
> index 98485c9280a..c90ace20d53 100644
> --- a/include/io/channel.h
> +++ b/include/io/channel.h
> @@ -1016,8 +1016,8 @@ void qio_channel_wait(QIOChannel *ioc,
>    * This will work with/without a coroutine context, by automatically select
>    * the proper API to wait.
>    */
> -void qio_channel_wait_cond(QIOChannel *ioc,
> -                           GIOCondition condition);
> +void coroutine_mixed_fn qio_channel_wait_cond(QIOChannel *ioc,

Better using same alignment than below (more importantly in
a header), otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +                        GIOCondition condition);
>   
>   /**
>    * qio_channel_set_aio_fd_handler:
> diff --git a/io/channel.c b/io/channel.c
> index 2853dadb684..620256f310d 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -905,8 +905,9 @@ void qio_channel_wait(QIOChannel *ioc,
>       g_main_context_unref(ctxt);
>   }
>   
> -void qio_channel_wait_cond(QIOChannel *ioc,
> -                           GIOCondition condition)
> +void coroutine_mixed_fn
> +qio_channel_wait_cond(QIOChannel *ioc,
> +                      GIOCondition condition)
>   {
>       if (qemu_in_coroutine()) {
>           qio_channel_yield(ioc, condition);
> 


