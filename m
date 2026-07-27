Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C06C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 06:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woEl7-0002NV-BV; Mon, 27 Jul 2026 02:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEl5-0002N8-AQ
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:24:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1woEl3-0007qO-SB
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 02:24:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R1fvOO2381774
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 V0/kOLiHNxnSYOj0fwX1DHNdOTtnC5ElIgfrThDR/oM=; b=ll3dchVpOCbeNunT
 Nr+WAe6eM+/tBOGZTOx7YEdMYnn9NwV+0xmYBJl3evdoGmnrcxBmpqyBZ9QMQCLX
 rsy5jSHR++WviJQc/RoYsKPQd3HV8pBjjhO96XWRSM83P2b2TADxdYG887cqrwqE
 RaIdRjE8S+TUWAVM3zzPUxOQYBo9gK+iP+TtH0qiQWsqv2WRP+x8+MmusFl4wAy5
 CE6aoeGCjJr1ckzUnBta5A2XL7gzaYCPzmAfa0Vxup1d7Q+fcN5TGrZsycZPZqJI
 /dd6fdW6V1FcfQ9oJ2IOI6mPYxzDyY7BIP7SEcUpR7mZ3KcnqUAifCKxB+U+hVWd
 2376ww==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fmn7vcr74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 06:24:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51a8b0a08d2so22105541cf.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jul 2026 23:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785133452; x=1785738252; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0/kOLiHNxnSYOj0fwX1DHNdOTtnC5ElIgfrThDR/oM=;
 b=g7HYKy1gPeLFIe+WB/CrqrhqL0idQ43zD+VuxNcs/Rb25aAlEUv4iJzgZlunj7bYq1
 5/2GNG51c0cjY1C5rOOEi5K2ZpRfmGxHvub31uN9K5JAwWuSApGaTB8wTPrKGeYUitps
 lw9qxkSY6xYJc2cEVFxz6P6d7xrm2tDowRDh6CBb/nej/uU/L/PT1unQIMgxP1t8h4gk
 XsvmSI52F1I4D87iG6rZ4d9ToOjjWQO/gnNS/2Qg13J5DPsa0OetO5UlSXCg05cAxlJ3
 7eNzlM8YU8VV/XOoazdDsM4co6u0NuIRN6NexHD3rwWL24aOMo0QfeVp/jaDTHpNH9pB
 UcMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785133452; x=1785738252;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0/kOLiHNxnSYOj0fwX1DHNdOTtnC5ElIgfrThDR/oM=;
 b=m8h79WvvpIXH4WpfIlYj8+G2zfm93n7f7icwFd8zCJIpY53mdPnmficjWkZYG4AUde
 94JaiN0IheueV2TqO6uWbBHosZ6suAs8jojyjwFR5F403z8PuzGwy3zgyIhhvwr14P+V
 cvByzuKb7+tVmqu3nOmY3aNeo0GwHhP847Ca4lX2mS2mK1LyRSNeWNh5Fmu71MjepT7x
 k2q8gZ33oua3qu4PXLwBpxu08q4ew7/JyWm2X/8rOFWYfwrTIk8wOn2Y1XMJxtAHxgN7
 8Wy4lP3BZcyLTUjSMhZEzjbdEzz1R3qf5RGtvH5VCdbN8GJHl+es1MdJxHZEZKOIiTBe
 upSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrwVFWZKJWaLUI7MNqP9wtyATwb+WGPtL4XIwxiLz2zsq8Kop8CYR847rNRR7hS8HP/YWaltqTVA3pe@nongnu.org
X-Gm-Message-State: AOJu0Yw6SKXbqRFLuOZXheNnaaPiX9hRgXEhOo5/+AzuO5jSsNj2MGWU
 6DwQ131FhNjLnEJklNexKF1CraeAsFaqbDPCfAXcSnyeC+WTZUBdkaZA9IKYrbw4rVVPOIll/n0
 GkIQdG4gUIN54+qOYWsYcOuZYdexJKvPmFoLyw11sszmRvqIGXeLAFuDSRw==
X-Gm-Gg: AR+sD13epLtugJoCIDCvEra4td5RbvyQm6dRcVaZcbCbLO4u4E3Wlk9zYgi/ME6Iz7w
 pjshsVHWijKLZkOWA4b9XVesFb3C7R+zU/hdcLnrvVWk/yEjSOytDf0q1eLQeQ6FoAzPP8sjnf4
 15wDilASnj4e/+mafIhxRqn35VM9Dy+pTAyk81ivC6T1RxajsXXzdwK/emefkI4Iq3DYe/D3aY7
 ThXz43UD0tSWoVkqCbd2JGJGIPaQfvl2mLybD8VU4cojfsfSc+DiiG+pHsIpYkwIK0dmXFUPFwX
 roalxtlLlle5f71m11rr43tUPJ66m8ssT3rWu7HHP6Gvg8h5UP8MR9wYjK6jcJFRzXTlXKk5IK3
 DBytGZRwojP5S58k6snuygbLpG87oAut/E24hZwTeZ6+VKQFNcEU=
X-Received: by 2002:ac8:5816:0:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-529a86be878mr76391841cf.48.1785133452125; 
 Sun, 26 Jul 2026 23:24:12 -0700 (PDT)
X-Received: by 2002:ac8:5816:0:b0:516:e39a:8540 with SMTP id
 d75a77b69052e-529a86be878mr76391721cf.48.1785133451755; 
 Sun, 26 Jul 2026 23:24:11 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb57cfsm47067391f8f.11.2026.07.26.23.24.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jul 2026 23:24:11 -0700 (PDT)
Message-ID: <47b1762d-438e-4a2d-ada0-c0be4f5642b1@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 08:24:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/virtio-gpu: Reject non-migratable large blobs
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260725-blob-v1-1-f643fbd76398@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6a66f98c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: PzoCHEMqCUIzUEGDYmmEu72na2ZQHR6N
X-Proofpoint-ORIG-GUID: PzoCHEMqCUIzUEGDYmmEu72na2ZQHR6N
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA2MSBTYWx0ZWRfX9SmkDNiQXgZv
 ckosnl9CfCVNyfQaJlWg7fMu/9nGB0FC+DWu8jjsYzlk28L0BjkudeNZ3it5mWy4Dt3mqfbHPZd
 eoDmdG2JPKmkq1xgf6B4gynYcHpPLJI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA2MSBTYWx0ZWRfX2Zs9SxXGIyaF
 7jj5lOVxXTuMLU7qm040tbsa0zY9YTtl3VgWVr7KgRQJiBXRwxAUdmW/S5wKSTZm6rGQKQBCD4q
 CIepM9z9FZVl4qm7OcC0346Ky39HOh6P1mmyyK81HmVRcyTviOMSkqhH4Rv20Yv3gjuAjOCQtIs
 M2Y2Ajk1REj8jpoF5JRfpXUwBA57iNpDfvog0DuvMib82fxSaFuFiJcYZ8EoRKhxM2kx4GaSmW1
 cUjTSyaUInNwq0vVOHL8y4CKW1wzwjXZjRQNHrfzfwIUCBLg00HA9TwMF+pW2+lS6w6AmcYHb9l
 TEbgp0D4kHthmj0ye68VVZVIukLHqzuFugblNPHF8kAsqB8F/Be3/Ce6gV+KwLOdjlqzGdsRHiY
 yJKAVQ92EUntcBF0IOwCWcZQ4VC6qvLndMOAoNmh57XSllC+JS8Rs4gJ4GVBdS9kzLsbs/Mks+b
 8fVvvh7RpUC82ig4c/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_01,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270061
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

On 25/7/26 09:13, Akihiko Odaki wrote:
> The blob size is encoded as a 64-bit integer in the virtio protocol, but
> it is encoded as a 32-bit integer in the migration stream, and
> a large blob whose size cannot be expressed in a 32-bit integer will
> be corrupted after migration. Deny creating such large blobs.
> 
> Fixes: 10b9ddbc83b9 ("Revert "virtio-gpu: block migration of VMs with blob=true"")
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   hw/display/virtio-gpu.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

