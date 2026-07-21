Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8333AC4452B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 19:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmGZ0-000553-1y; Tue, 21 Jul 2026 15:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGYt-00052l-PL
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:55:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmGYr-0000MO-71
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 15:55:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LH2S492548651
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MnP+0dZUMFJvFUKZ0DIE65jUoc+P8FRZ6PG0PnAb5eQ=; b=hguhzREI7cCj1lBE
 5oLGASRM/8f0edUfyfdS55oI6Ukw5dlcA8NUpy4KmyLXIwvaVtzLE4wrVGlc/rYi
 ItSMsCXZQu23XL8+0IXiuRBDhzJ/X/psiia8C2/W4k3pjdn9mAnq6iVoejx55u5R
 eBZhaQAv2aEe8TN/iCTiXjBtFcQtEJ201ICAsp4LHejrWBrNaiMGc0Mc9TsSOd2B
 sV/9RG8r+6/p1Qoerk2rgN1N4H7JaOmAtnulu+vpg5Dw6lPPwl0a0POFoKb6lBSN
 cHZ7dIUGLUYw9fBvwNXDB3FMFESayRjK2hMLZwNZPYc3XmxzXRRRby9Xt9OJYyqx
 HRuBgw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3jqx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 19:55:27 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90284139cceso91285366d6.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 12:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784663726; x=1785268526; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MnP+0dZUMFJvFUKZ0DIE65jUoc+P8FRZ6PG0PnAb5eQ=;
 b=C6yTY/D77A3D3ezUeJODu2//O0e09NitiG/pS0VpBs3I1mTBHSBBOM4bIn75Z/6kSQ
 a6tLGAwedCaqMmSwGSGGLYwJhiROcXWxV00O3gcI80ReU81M+03II3afhAPDenhxZOdd
 Iqm44tRANP9Bf6IuGCv2tCSyU7Tm/6+2bAe3bwXPSITVFyIUW+1PSdc3BcI48y6ldxVZ
 YQvY5Rd3K6xH3qNhucTEyJUy403jPsw+hcbCNrRxH0oK9KC12O0xKLNN+qAfv2mazDRw
 HZtcIDe9aB4gGWLNouFwAqcdxGdPRGkmder1pGdgBwUYP9g9+aSiZ2dJltrgQIhoSRu6
 iwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784663726; x=1785268526;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MnP+0dZUMFJvFUKZ0DIE65jUoc+P8FRZ6PG0PnAb5eQ=;
 b=f6tp49o059rF3vs3pC5MD3Y4VAP4z/xkf1MlUr52tucOHpkgak2JBLUsh5Hw+oA5ML
 NhVzD/ZHDzXFUuIQ1eiAwOJqeBy9XaTFH0zlH2lchcQZB439ZZSNTlHYaS6x8OT1Xdd5
 ETt5EvaZBbhkQFfwB45lhwvSalVsRDMkFV7DMD1fWB2J/s0171hsyNsPX0qW0Ksfo3gz
 018r3adiwCGNPUBr576Ww9vQMdfPb5ktXYtPXQhEyoqCdnl9ox03tJJ/mosl1croME+5
 YA2Gd11tZWt8036XrA8YhQFkqgu8vuOQQysA1mY8xKq83y5QKK+aVUY+dJYJUXhWGXM4
 aPJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMdJF6wG2QHQ+ucYqNupN2bbn5CHhO2VvvOuRJA9pBaSbm56QaOb+6hkU2vbOSDWxcQf4q+ny0avSp@nongnu.org
X-Gm-Message-State: AOJu0YwosDQrUUUYHoCINcE98ZTWYZ6wMII3o/lkz1v9q0x5Dg02wDQm
 PycuXfbj0ZErRKW8EnLs0Zs4pekmph7DcpJMC4fUku9d8rKOKYotv5uSFXtIBjzhdzE/9fSoQun
 11bxmt50UyyeKEbXDRGrdoxV4xOE9c22l7PTEYAgO82YxaMUK7B9g1+ptJQ==
X-Gm-Gg: AfdE7ck1cZ4BKtzQmdhRG5qSb17DzJ5DolMP0hTSpTkiI3cBsG8cBHJETimpr8/gUuF
 3zpiQz8J4rGLLe2tBKmystwY37Li/cepcMw1HlV+ghjj9impv1wpeMIzjalg9GbD6EXb8Rb2Aym
 G9gj4cLsLhWQu1qLE/kfIFftNqMLZG9KULJ2zmKlYFY0SBWIMhs0twvHgnA2Ld/s5HIcSR/ELBI
 f7AtZvVPtvhPNHTnmeLSkr6nRZ2ciiJZGIXDYk/mEsZitXuhE5CZMcyNWgNS/xlFqnSUeu+QQNT
 lEG78QsPwcRRHjfTAoPwvCgXQsjPQeQ7Q9MOIFtAYdyZgR3TLK4VDkDzEYA/H2QCrNSkpy7jQNb
 4o2AMxFqw7R2/3lAWHAshufhioWZVzbNJmUowRoXt1hsnTzh047c=
X-Received: by 2002:ac8:588b:0:b0:51c:753:4679 with SMTP id
 d75a77b69052e-527a8471b9emr14919691cf.28.1784663726375; 
 Tue, 21 Jul 2026 12:55:26 -0700 (PDT)
X-Received: by 2002:ac8:588b:0:b0:51c:753:4679 with SMTP id
 d75a77b69052e-527a8471b9emr14918971cf.28.1784663725803; 
 Tue, 21 Jul 2026 12:55:25 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956b01a758sm4090855e9.4.2026.07.21.12.55.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 12:55:25 -0700 (PDT)
Message-ID: <4474c778-6c5b-4bba-aca4-6f926f125518@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 21:55:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.2 v3 09/15] hw/vfio: Use qdev_is_realized()
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, Igor Mammedov <imammedo@redhat.com>,
 FangSheng Huang <FangSheng.Huang@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Luc Michel <luc@lmichel.fr>, Fam Zheng <fam@euphon.net>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260721-qdev-v3-0-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
 <20260721-qdev-v3-9-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721-qdev-v3-9-d2e226fa002e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX+pRjArUhzZe/
 KVjOC0HzXFJCRJA2jXkP3rIlGXCxE3EGIug1Av6guQNEPxu5o/ZVUP39NJcbfNLzN8bgCydNoyl
 kdrROx+yV8Ia3AepgyOvATpCTm5ibgfK7BnsZ1Pf4Y2D0ZUyPnUXUoYWHV8abq5KFYgvcHRwdRY
 W4XjUwoj5hF3MQcUFw6/ZEkUU8Z9gsXTtAGZtZ9ZVhoAUAkut7cj83XOcxuKIB6oB5AmEYP3UTw
 a1dk7IPd2X2MbldebuK8eMBojctzfhbSgFFY+1necYOjEK4JhppoN/WlzWaOZnIMM2bQUY7fQHq
 XZ6tM/Lo7QW1Ep3ddU0wTDyap5BEetQXwMbcpS2zhkSI2OSui9su12cnl6QC8enjyUc/eQiehvN
 hWxDU02Jy6yjZCQSJofX026wogKjziPo9xb4BKgvp1Y9NnwsmO6JsA2yVcfeQLnetGKElXKUwNi
 6Ombp39j+Je6eE0QItA==
X-Proofpoint-ORIG-GUID: jTRiP3wkw84niT8OQrLA4bea8Y75Q4CY
X-Proofpoint-GUID: jTRiP3wkw84niT8OQrLA4bea8Y75Q4CY
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIwNiBTYWx0ZWRfX8emaAaOPrk6e
 Jv/+RVNTAzaRqxGkIBldv4IKhLcTfEJL5bX6UiOcZn9YUrINTemLgVTB4av6v1n7lb/60lpo/wx
 hEXlLaRo4q7t+GTagJr0UJu67gbAod0=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5fceaf cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210206
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 21/7/26 10:16, Akihiko Odaki wrote:
> DeviceState fields should be accessed through qdev helpers rather than
> directly. Use qdev_is_realized() instead of reading
> DeviceState::realized directly.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/vfio/container-legacy.c | 4 ++--
>   hw/vfio/device.c           | 4 ++--
>   hw/vfio/iommufd.c          | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)


> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> index 1a7f8088aad9..4f119596336f 100644
> --- a/hw/vfio/device.c
> +++ b/hw/vfio/device.c
> @@ -59,13 +59,13 @@ void vfio_device_reset_handler(void *opaque)
>   
>       trace_vfio_device_reset_handler();
>       QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> -        if (vbasedev->dev->realized) {
> +        if (qdev_is_realized(vbasedev->dev)) {
>               vbasedev->ops->vfio_compute_needs_reset(vbasedev);
>           }
>       }
>   
>       QLIST_FOREACH(vbasedev, &vfio_device_list, global_next) {
> -        if (vbasedev->dev->realized && vbasedev->needs_reset) {
> +        if (qdev_is_realized(vbasedev->dev) && vbasedev->needs_reset) {
>               vbasedev->ops->vfio_hot_reset_multi(vbasedev);
>           }
>       }

Interesting.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


