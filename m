Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D22C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnAVj-0005SU-2B; Fri, 24 Jul 2026 03:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAVg-0005PZ-OK
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:39:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wnAVe-0003nF-DM
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 03:39:56 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4lKYS2137634
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NR3WhVbe0fnOGNOrwOXA5woDwjaF4xtNd/47f2d+jLo=; b=aahQ1Kw6exKIV1xj
 s66stlQ2HsuH8OwdrzIQDsxJNtx+Pk/FWyxfXLEQgsFRjoJj7o6g5m3qpwi5ibPv
 /orAB+x/VyZIpkya1d7Nv11QDL04GKOOn7j31EHIvwWvKq7MhxV5mActaAC+FLhN
 dOKfIzgsOS4tbNeVKimgW5+ohBoUQPGpw2qbpkVOKTHFpKFHSLXdeu58mcYNBqXt
 7bS8P1VPQJz3G4r7uKvlfHc8RSh2td24MYRhQtGjHNuuORLUqeHGsB4OAdpis819
 8FBelkmzML8wiQ10Lxsrs3aE5WW6WsLCZP4kVsZN9awD8w6XPK/Tm85HYhnbo5tS
 mJTg3Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa1aqf4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 07:39:48 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c01ff996dso1153391cf.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784878787; x=1785483587; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NR3WhVbe0fnOGNOrwOXA5woDwjaF4xtNd/47f2d+jLo=;
 b=TTrHFSprErCGXRqeO7z35VT2NRecbv7n+MjAPS5EW7sCCvJCsEveQIobCbHVWDBZTs
 1Gd7iOehDOZg0/Eyxg3pSPQAR/zzzPpWdTheaCRbyksSxkCSvgueAJDXGZo7kMLTWLK5
 mbiSs7EolJV5y96xVOmRi74czp1XPYD/c589r2GLSoynrp+iee2nZs7Jt+CvQh6/TFSn
 oSCKsTSseRFl9BZfXv32a2UjSFGS5TZBoOdnZwT49t6YOoPZApdfZTz1Xb0AIAeag90y
 jd2UaIoZ7VIWCK46WEHW6EUU3uTf5QEdnauVyDKr2KqttzTSBS0CFeqBPSmQe/RdyaxL
 bd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784878787; x=1785483587;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NR3WhVbe0fnOGNOrwOXA5woDwjaF4xtNd/47f2d+jLo=;
 b=FvtyjsQ1MK7O1xP3xw9PpsRZgMUE3NY6AyH8KMoB5CsjwsvCNPwI8WPORwzKHwK6Cf
 Op0Htouot0hjnGdtvxJRg9NoNhSfZ+dumYBe7oS7u4sRpzYXWax7sIDd2xp6CuJ6zew/
 O4EVkAvwHByHzWlC0fkWSa8StfMs0kDtkRJrEzfRcT2EKtKYtoqQhsTf1YAYi53BFHOt
 G5iH4Ll3q3x0s8kFZGGnn4Doj59W9+6kMXsLBIXLdMCgtA96vCB4eONlfkD+R4xwwbm+
 PL/I6fSrVedjR1t3OfcV0zIyGVErriOwCthxL3rk6TGP1N/UcZdePFOjYpTiFl+Teh/0
 03+A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpTetz0hkPphs9T63p/BDdspOqfREngWje+fYveGSrKH2GiMhQO1pA5DzYbgEHdFq6MFqNLF7bTcEYy@nongnu.org
X-Gm-Message-State: AOJu0Yw4naYKuY1CU6cVKi9Ui7oAdH0JYOOaMlEJtBmzVtXTVcgBqgzk
 1cG9rsW9p2yYFh3RUvQpGcqS8k0YddqHWf4riMTBd4lC482fcQ1u0NiNUEbZL8HN4YLUlG06Xy2
 rIAK6XiIHEln5A8whVu7+l0GCk1dA1uC9U3EJttWfhuCT1+ldS7TskmImYA==
X-Gm-Gg: AR+sD11PRXYkLaGj3n9iorFzxgb7XiG2hF2KqjduTbl6kMgXrr00WnQ9uaB2p0VawH2
 nR8DHfLFJfqGgYHpaCV9AMr8wJSjZAQKzELGYgaxWUdlvxLTiObUBvOw9PTraTYgNgAHjGUtv0V
 yK1rRsTa9t8sQ87Dij9b5WHSMvEIf0vxdQM9JBVJzVEtes6N4V/I1lZvPNJCOK+JCT9GkL5Sf6Q
 Rx4S9+ZAnFsUJoVq4muvWiDgjbUvw2xeuK1ZBe3ccb4YpriUsuWF523MEPhAHknh5VPJt48tRNk
 0zp6+H3Kpep9Fmp0wdjn35+wsWw2zX+BODI5KN3POh6GTY7hA6HBcrR22VOAPFeF/puipVYkGqa
 +aLIp+yBUUM9EvHLb8dpuDw==
X-Received: by 2002:a05:622a:260d:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-5283de32352mr62651171cf.37.1784878786554; 
 Fri, 24 Jul 2026 00:39:46 -0700 (PDT)
X-Received: by 2002:a05:622a:260d:b0:51c:207f:6524 with SMTP id
 d75a77b69052e-5283de32352mr62651031cf.37.1784878786110; 
 Fri, 24 Jul 2026 00:39:46 -0700 (PDT)
Received: from [192.168.1.138] ([176.176.154.185])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5a2sm23897230f8f.7.2026.07.24.00.39.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jul 2026 00:39:45 -0700 (PDT)
Message-ID: <dc5310b0-4b35-4b36-acdc-df986ec3fbf5@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 09:39:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/virtio-net: Protect from DMA re-entrancy bugs
Content-Language: en-US
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 qemu-stable@nongnu.org, alxndr@bu.edu
References: <20260723233555.2970619-1-lvivier@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723233555.2970619-1-lvivier@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nHD81RL9llbiY73AbkEvmdaZqDltfpOZ
X-Authority-Analysis: v=2.4 cv=L4wtheT8 c=1 sm=1 tr=0 ts=6a6316c4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uVRRv9AK2fddTnT+2a2/4A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=PxXMqMQ-lXPmZMY9CagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2OCBTYWx0ZWRfX0MFHLd0qoKiC
 mWjUqmENcmIqidu2ZTJBzXboKbLvqbw8aV0BekZSzWgN1kwH6Zwga2bQ8JiW8Zq2fQ05Z0dhwIj
 8ITZ1i+u+CZt8l1b6zudXZ6+vFDU2+rsNvQunuQN+2Q42KlwlF1nZYCQVd3vwaTzEBtR0V+CaZr
 rJgfRHy5MvezedlL0vVvkQt0WEIg9Kl1nNrUXBDO3KcFjg4BQF8nxyvxlVvNm4GY2/Bq13Tmj/i
 vz50wgNWUDpWXodCKotln27/p9Pb/4YSQ5BhOUL00TNjsazvX0NGx9j2QxjFwL4nwb+zb6vEHB6
 cPqlLofHIxu2N56Kgoetn7f2rtQcCH6Tv7U+KZ1VgxuV1RtSS1E520YCjYbF2G7dXmUuLUPNjfv
 5vdyRvl/GYA8rLNhUNO+HU+/oeEpYd6e0U5GyixCSHwvgrZPixJ1DJGkm7ByLoJxEtuLXSjoYzA
 5c3O0rhnbnBW8wLXM4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2OCBTYWx0ZWRfX9pVTUkR9NzM6
 NtryGck2q30s43tsXAmJabsqH1yAG6rxmuig9sndTEmKITx2CH48Ui+tJx5yCSwns/Qpx6FHKUQ
 FRXM0oWBU8o+eRj7koTSC0vYbCxFzP0=
X-Proofpoint-GUID: nHD81RL9llbiY73AbkEvmdaZqDltfpOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240068
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

On 24/7/26 01:35, Laurent Vivier wrote:
> Replace qemu_bh_new_guarded() by virtio_bh_new_guarded()
> so the bus and device use the same guard. Otherwise the
> DMA-reentrancy protection can be bypassed.
> 
> This update was missing in CVE-2024-3446 fix.
> 
> Fixes: CVE-2026-66022
> Cc: qemu-stable@nongnu.org
> Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Cc: alxndr@bu.edu
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4073
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   hw/net/virtio-net.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index f0e3beb29032..7033664ac0c8 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2991,8 +2991,9 @@ static void virtio_net_add_queue(VirtIONet *n, int index)
>           n->vqs[index].tx_vq =
>               virtio_add_queue(vdev, n->net_conf.tx_queue_size,
>                                virtio_net_handle_tx_bh);
> -        n->vqs[index].tx_bh = qemu_bh_new_guarded(virtio_net_tx_bh, &n->vqs[index],
> -                                                  &DEVICE(vdev)->mem_reentrancy_guard);
> +        n->vqs[index].tx_bh = virtio_bh_new_guarded(DEVICE(vdev),
> +                                                    virtio_net_tx_bh,
> +                                                    &n->vqs[index]);
>       }

This matches commits b4295bff25f and f4729ec39ad9, so:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


