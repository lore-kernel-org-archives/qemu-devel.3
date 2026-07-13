Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3878AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 10:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjEK3-0004CP-LG; Mon, 13 Jul 2026 06:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEJm-00043U-GK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:55:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjEJk-0004e3-OK
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 06:55:22 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9dUJI952899
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Xn3S2PvtzozBUUcxgsDoJvy0/X/Pjk+r9GG0gXpZTzA=; b=LuZkT2fmn+UMJ46d
 gDUpBDnZL4ygj7XF5a9Cu8rpRrFRcqdHJGU3F+SjoGj8gLkxl0z1h1snlhQggW8w
 gZQm/fmdUCKGRCLXvkKeEpLIdf7HHcXq7n2aR0EdS60SxKxLdX4tQIifyF2/sbFh
 AM6FHtdjx+09NOzfiqDBmCjgOnQzGF0VEXk3mjKOeNMdDZ5IzlwpSmv0arCuEH45
 iace3G28+R44E7Sia1OjRNxWjoHPcbqfrkdTfj/1limULqfY+MnRvF0BsdDfqBmR
 lcarmzV8H+OKZr7B2Yi76qu5pQnhla+oVFsWQyEf1p5UZ37dWOXD8NHS282q7eH6
 rqh72Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3g8h4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 10:55:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-517e054fe07so60364771cf.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 03:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783940118; x=1784544918; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xn3S2PvtzozBUUcxgsDoJvy0/X/Pjk+r9GG0gXpZTzA=;
 b=dhNHPgav0FEX4+Znbo0LsDSULtm2DH29Ly+lOzh19HoRWdWxos+qnwlGHMZ33dO82b
 IC1wGUfsXzyH1HaTwxgqtaI83V/wnYgOe4dDQfv3CFJPJ41j1FJJBQWLuVIo4bZvPlus
 mAPZnbz0aw0V2dUjdFQHCkz+31q+CtobIE8MLiQMEHlLyZrNTmS3jYzG9J6SNW6AUGZw
 eKAis1zukgQYwAzFF75CUIJbddmjBN5dBwczrD7B2z6RV9KPfJfTP6puGgXezXu4JwMX
 ZWITa++JXJXopjECCGdFmtdPSjEEO3MgcRO8DSytFXkoLq2NNt3wOSRdljE0dzjr9ALB
 lLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783940118; x=1784544918;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xn3S2PvtzozBUUcxgsDoJvy0/X/Pjk+r9GG0gXpZTzA=;
 b=PvvPfE48PKFoknWaLbYLmese8pf6FMqa2HJQln1mJO5tdOVTkDAyNISyMMIoVeVp/g
 UxiVEHMrL0s0+J/j1o85JlcDaonc2R5ASm9VtGlT1iJUTyNg0MCvxjmnt7HJEYJ6MN66
 PKR83IxBHttXjXZYNdAeLwEclr+k2C6OVCT5JsuBXgK8plSfzmwrpQAKQzRvuVDm0gPC
 RJjMhO/g5uURyujtvZlDkXgMtrrGWH9w5STBEg/CGQ6Jl85vdOHYdd+tahfyOYp+ZhaT
 0lUi2ld6RtGDZ31nJIsw3NVfv87GB3NllWVD9B3ivFVEcOaOIByIt2l3FK9SUT8KI4cc
 bO/A==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQ2LOPynezXrYG7GytUYhAVOEcpLpLvY79zDOT2Xbo7E7KG7NAJuRkTXRmNvHNTWbeWRGgCu+FISXI@nongnu.org
X-Gm-Message-State: AOJu0YyjbCg2dhI+uZjUptqjFHFnz5Nu+VZ2NnN4gLLPkcMwFyskLTrz
 /2SpCWB8kTBHOmz+uysY3MuMqcVIz/qRN0fXhu+R52AXi65H6RnPmbUHSxOn9udpdMi100/4b36
 M7G5dyZ/S/ctaPyiATIOE+wPdH2Tqz913P4DFuEejlAA1k/ghO4R+fr01xg==
X-Gm-Gg: AfdE7cmIxWYLaPs+HvMaI5VW3r0abFrZSkZ6KxFaCbmY97nWt++0gQ2Jy0RwbqiF3uO
 RHEyPPMwfyZiJiTP8uPa8BAJvmjkGSfKM74FEqtSXhpjMwsgpndjwC9haDBM1s0NRE8w0zjA8oe
 S3XlquLOUgRobqFA+sPnjnr57CAktDTlRdUb8O1MemdpyU/Hg58w6ahd3ZgHphYDex3gQGhbIrE
 lBWWY5CEhWy0DPAhhYYyiClBJYcMqmpdpBWhNSHm2+V/H1Ulgdkdgo/DKRP9HMhW7xZc7LJJHYi
 iGKhEF2jOx+UHgn8WGnYww5TqVEan2U9UHm6BvPqFk0c19Tekpu8UJWsgbGpM7l8fdBu/ih+sLM
 XfdRDNvQdzWVDzkyWDxkeawpTalkXDQTa5z9hqqXU7gHKX4Oj5bR69iCQLHuwOw==
X-Received: by 2002:a05:622a:ce:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-51cbf1bf868mr89378851cf.37.1783940118177; 
 Mon, 13 Jul 2026 03:55:18 -0700 (PDT)
X-Received: by 2002:a05:622a:ce:b0:50d:3e1e:7998 with SMTP id
 d75a77b69052e-51cbf1bf868mr89378271cf.37.1783940117742; 
 Mon, 13 Jul 2026 03:55:17 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ccaf1sm630091325e9.2.2026.07.13.03.55.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 03:55:17 -0700 (PDT)
Message-ID: <63a772b4-caaf-4708-9014-dc40e5b03bcf@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 12:55:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 003/134] qdev: Reintroduce qdev_new() with a mandatory
 QOM parent
Content-Language: en-US
To: Alexander Graf <graf@amazon.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Aditya Gupta <adityag@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Farhan Ali <alifm@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Alistair Francis <alistair@alistair23.me>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko
 <atar4qemu@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Felipe Balbi <balbi@kernel.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Helge Deller <deller@gmx.de>, Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eric Farman <farman@linux.ibm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>, Gautam Gala <ggala@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Jan Kiszka <jan.kiszka@web.de>, Max Filippov <jcmvbkbc@gmail.com>,
 Joel Stanley <joel@jms.id.au>, Jared Rossi <jrossi@linux.ibm.com>,
 Tyrone Ting <kfting@nuvoton.com>, Frederic Konrad
 <konrad.frederic@yahoo.fr>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Glenn Miles <milesg@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Halil Pasic <pasic@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Samuel Tardieu <sam@rfc1149.net>, Bernhard Beschow <shentey@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Sergio Lopez <slp@redhat.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Ran Wang <wangran@bosc.ac.cn>,
 Hao Wu <wuhaotsh@google.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260711223707.42139-1-graf@amazon.com>
 <20260711223707.42139-4-graf@amazon.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260711223707.42139-4-graf@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 36DvlooGRZwQb0Nc3DRZTp0pRxqQ-HjK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfX+5mqENpgZn2+
 rFbCfiNiWG+RqqoNClA/Xn5cMn2/LwHL6QOeBF37uf2OyZTqV5OX61qLue2TSKrqHWVmT+3Pnwz
 A9ak3hUF0nCe3Tn2BIO/iALCseAhYzI=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a54c417 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=vggBfdFIAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMyBTYWx0ZWRfXwg6j4Ankwsar
 Cl2ReUQFjb0V9rYsMAvKA+8d/A446LyjM4ihsHSzZ0qwfustDZbDi1dllZUYcG9WF7zh/heYF68
 69zM2n/IiSqpD9sOzyoJ/LQQ0pvZTsrcUyKwq0FdqTKKMzpdqwSOdHWMX+Wh3XhSB/JGCjvyYuG
 0hZtVgttf/8tx9RXaCdYm1q+e+XpL5x+ZsWN5gYSF2jMpT2j1xDEzmGd7ClQzpPL8esylQoKBV7
 GkFt5b285dYeb/5OJQyhJL8+uDe3S6nROjc10iF9O3wEi62SvUxTqr8oOBKoyNTbbf2vXJi4lNQ
 1OYFnxgYumtp0JjgHf8srNH46uq/G1MnBsi0MyppWXnlBJHQt6ElEQBquN85vvW/oNjk3idxBqI
 MPZMa8aq4ZRMmRqmBVKJ+Ej24wqM4Q2KsNaxEKWmWUjEsESDnhZAlRisCy9GzRRfra9s+vRDMRx
 BClSSKjnM1kGkgtBVyA==
X-Proofpoint-GUID: 36DvlooGRZwQb0Nc3DRZTp0pRxqQ-HjK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130113
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

On 12/7/26 00:34, Alexander Graf wrote:
> The previous commit vacated the qdev_new()/qdev_try_new() names.
> Reintroduce them with the signature we actually want:
> 
>    DeviceState *qdev_new(Object *parent, const char *id,
>                          const char *type);
> 
> which is the qdev-layer, heap-allocated dual of
> object_initialize_child(): the returned device is created and
> immediately added to the QOM composition tree as a child of @parent
> under @id.
> 
> Refcount contract: the initial reference is transferred to the
> child<> property of @parent, so on return the caller does not hold a
> reference.  Pair with qdev_realize() (not qdev_realize_and_unref()),
> matching object_initialize_child()'s convention.
> 
> qdev_new_orphan() remains for callers that set the parent themselves
> before realize (notably qdev_device_add(), which parents under
> /machine/peripheral via qdev_set_id()).  Later patches convert the
> remaining orphan callers subsystem by subsystem.
> 
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Assisted-by: Kiro
> Signed-off-by: Alexander Graf <graf@amazon.com>
> ---
>   hw/core/qdev.c         | 19 +++++++++++++++++++
>   include/hw/core/qdev.h | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 53 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

