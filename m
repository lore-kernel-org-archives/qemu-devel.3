Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC81BC44532
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBR2-0008Vy-8A; Tue, 21 Jul 2026 10:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBQi-0008VM-Nm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:26:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmBQf-0006hs-JV
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:26:43 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LDfwwQ1804794
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pwl1EpWWUAaj5aGPQL0WoPj2xgPVG8zDGB7jlAMTp+U=; b=ksxibqm3bOWJmZYB
 kep+27Xl6QHqha7bW3EyhTYFJI7ddeGgQrBaIbaCOp4WtnaMokmwaxGpxZxcJWlW
 Ff3cm1RfLib9Yhm1urhP3ZDvL+VQ1CMcanf5H/qOaOLoiq+IvaIH/3Ia6EXbM0Mu
 pKX/fTCX3HZcbPrb1q3fHHEWYM4y1B0KogetjYNdobK6jkkyjgG98ucVWxffAan4
 9E6C2NyJ+1Yu3lqmPo/eGdkQ2uhV6CuJA1lDdTfb1kKnnze7fGg4R98vI1xfYygd
 YFMMXFrc2Ao9XNCTTGUIZdx9a9tEOrwcml+GGUFm7nBnJJmmGyp2aGkfs+rGcO41
 xmLHQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6pa96d8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 14:26:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0f0a0760so273820321cf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784643998; x=1785248798; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pwl1EpWWUAaj5aGPQL0WoPj2xgPVG8zDGB7jlAMTp+U=;
 b=IaGA7T4/Resxu30ESf+2EXqcosBnzN/aY6nFMdP5NxoXvaR393KfLs2CGtM3nQ8LCw
 PfOXbI1srDLab9vTOIogRlWGUlRtQFp6v6wCEVMdQ4By7gknIz/jsPLesrWG0H4psxBO
 EejIC41EH0XYbaLZ9ey1Jsm/dkUzL8T2Nc/nR1x1rXQ24HhwTs80GyAC3uLtm+szCcIM
 G4a1J2JYwfksZNzbwK/SPya9Qpe4mbPyO0qIelERfexFc8lozHxRVVLGB9dCeVN69/pM
 ldKe1+clilQVbNLAMsjRuuhJjaUivfkRVGKa3kZFMO7h0IhakAJ5AFcoAzAvs53qSaaw
 EMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784643998; x=1785248798;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pwl1EpWWUAaj5aGPQL0WoPj2xgPVG8zDGB7jlAMTp+U=;
 b=QtxC2ZGKtyAaDyYTspmwrWo6//JuzDowW2tpzzx/udLyqaOkiWnx6evupl8gXBcLcU
 76Yup3xObX4kQXF7S17XihWnuE+JFQIdEj88y/mxL+B5EL8DSdnbfbNaw22z0dI+fmxG
 h6P8+BCexzpAmO5gUtPkAIg9Vnk0vfMXsZb9NnSQPSHkkHPPIXSllH5CAHXLgcXHw/iG
 poo35dDCj9lXlspLh7u0UANDfiQ0ukJ7JIzUoU0ph4lKh0lw6uUs0FIdfyeXfTsgkaVt
 7a46VkmxmMIhIj2gWUdS774ggbBOjjpB1bLBsqK/1K/RvsmKZ0S8SYyANCFHmTdH6lMQ
 97xQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqh3DmHvP7FqozyLHX47t/27gqzAWecfsYMRJhl+57gEwKl3xseaapFHS3zZV+alISPIaCbjHzTdisx@nongnu.org
X-Gm-Message-State: AOJu0YxM0wKUbVs9YRHlXCaBGcAmOUsDxmvdULkm7DB8+Tyc/aQhpejn
 rJDUxlS32XJ5+GQjTlo9ZcTjiwPZmXYXoPDne2YSXUduzC4DETzPDOIbG+tVRMc3bZrBQo9+yOk
 IDubjo7Q2xuGvTmKXi4oLjwLMtqz+IK6A9hTAwFDrPMD8aMywfazJVQ7OnA==
X-Gm-Gg: AfdE7clyGVgYP337pWBiKNuUQCQ/8qH/MwriCU2FvNfUtUm/tlqgJoJfXz1uPHhk9Z1
 5cZx6do2NVglb4iYEE2J/zwuun3XTOpquIhuNQZoANLu2DOqSFOoGnbCrzoFxpac37IaRnZh+ef
 8Xej1gocBG3WG1qb+z5i/m/mvzEIjZpkDDP11o9IP4gkNLXf35RUCRFqytIzTbTg/t6mX1V46Vo
 FAyvlk1mZoN79AEZKjKXd/g84sZyirP0cf6+B9WzZZtCKeKOABNv/nvm2vsNE7R4pIQh0biy+bA
 7Byuw6CAU7NJQB68UlUehyjoV7Wiiau18xEU0FuMMRt36uGUH4IVn7gLm1LIfQN97lIHvNNU+8a
 HQQNEy51vDFjbQjqJ0AJOU1GaYF0MrVLREF+qw+tSbMfSPQ==
X-Received: by 2002:ac8:5744:0:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-5213d4b4438mr184922841cf.39.1784643994818; 
 Tue, 21 Jul 2026 07:26:34 -0700 (PDT)
X-Received: by 2002:ac8:5744:0:b0:51c:61a:50fa with SMTP id
 d75a77b69052e-5213d4b4438mr184915791cf.39.1784643985692; 
 Tue, 21 Jul 2026 07:26:25 -0700 (PDT)
Received: from [10.131.142.220] (220.171.88.92.rev.sfr.net. [92.88.171.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956546de4fsm76291865e9.1.2026.07.21.07.26.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jul 2026 07:26:24 -0700 (PDT)
Message-ID: <456ab3b5-a2c9-410b-91d0-f8b13fc0b542@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 16:26:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1] virtio: avoid packed vring virtio_queue_empty()
 infinite loops (CVE-2026-16457)
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Anatol Belski <anbelski@linux.microsoft.com>
References: <20260721134424.196337-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260721134424.196337-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HOf709Y-nvQ4uQJqK6Vk4kgf3l7BJJ53
X-Proofpoint-ORIG-GUID: HOf709Y-nvQ4uQJqK6Vk4kgf3l7BJJ53
X-Authority-Analysis: v=2.4 cv=eYYNubEH c=1 sm=1 tr=0 ts=6a5f819f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=HvFMDRKYglX6yPpWI6gtsw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=p0WdMEafAAAA:8 a=yMhMjlubAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=CKZ3y4MUYRnAqfqIwE4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfX/gxdT/yODd+l
 EpVWuCa/nGEocr3vFR96i3G19qdLH0OqYOqkGx2b0FtDETCaLY2A52Ccf8hWGU6xgbBkK4noDxI
 vloaKusNC8hjk6B7vTL47R0zlBLJ2x5J9X4nqU+//oG9mQH/OQgWJiVh8QQfYwpIX7enmShI4xY
 iofLci8H2qf9C/QsQAkXJ9QA1JazTpB0HreYdebkvMWQMymWN/QYDbMTPGd+vyvJakIs7Cbd9IK
 SVyMAROlu/64pqSxhM+Orb33iT7ZIXaq1TooYclB7i52FG86VSDHolbpwFlMyLtJmqQa2ba3WvX
 jfFyKOB4LLsQsmkPcmzcUUamXG1FJD5+l0rp7PR9WTaL9GPcO/WTTO3w+DZljqhmkPShM8VSeJU
 VUw887z4d5o2A3rfMAMstpX31mbYQ7VaT4Wers1VC3K807Ot1DRoie7ACvE+6tAS+uWdtTeKbkv
 hU92BVDbo1sUyz/HSZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDE1MyBTYWx0ZWRfXyCdGW1phc7gq
 MnhNHpbiF22+hFiiKJJ/c5CE/+SsnaH6+DsSB6fCNpI3gcqtDaYLKCp7iHudkmAm1Sgt95AN1ti
 VOUegYGlCva115KQKrNBSNZp9DHgNY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_03,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607210153
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

On 21/7/26 15:44, Stefan Hajnoczi wrote:
> Virtqueue handler functions in device emulation code often look
> something like this:
> 
>    while (!virtio_queue_empty(vq)) {
>        ...pop and process virtqueue element...
>    }
> 
> virtio-blk, virtio-scsi, virtio-crypto, and vhost-shadow-virtqueue use
> this pattern.
> 
> The device may break (i.e. hit an error that requires device reset)
> during the loop. virtio_queue_empty() returns 1 for broken split vrings
> but not for broken packed vrings, leading to an infinite loop.
> 
> Adjust the packed vring behavior to match split vrings and avoid
> infinite loops.
> 
> Fixes: CVE-2026-16457
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3968
> Reported-by: Anatol Belski <anbelski@linux.microsoft.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   hw/virtio/virtio.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index f4d86a36553..3795e3c8c68 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -763,6 +763,10 @@ static int virtio_queue_packed_empty_rcu(VirtQueue *vq)
>       struct VRingPackedDesc desc;
>       VRingMemoryRegionCaches *cache;
>   
> +    if (virtio_device_disabled(vq->vdev)) {
> +        return 1;
> +    }

Correct, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

But why not run this check in virtio_queue_empty() entry?

>       if (unlikely(!vq->vring.desc)) {
>           return 1;
>       }


