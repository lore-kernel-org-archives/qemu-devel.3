Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7D4C982FE
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 04:41:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8sKE-00063m-PK; Tue, 22 Sep 2026 00:41:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sKD-00063c-QL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:41:49 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8sK9-0007F7-Rb
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 00:41:48 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68M00J0T2578884
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eZMRbG/3unaK3Cg8QLbjb/+lEETLQIbFWepLzfQiKhw=; b=f6OcMksWyc7JPhjh
 32cNlOGFYQK+4DuRpiFNf3F/ruDDYP7EDiop0T8VufANwEKQRWuzZzt9kNQp21bY
 rNXYkcFZSd6qeLRd9fknbtWfdo20dcUZOAYoYYGOp3YP5jNB6HyiTFm4moPsAn3n
 tVUyoe7/BPVj86BWoy4lQLv6BZnocauoX/GawHV/v/UQ8yMKVwedmtLTvH7PD94q
 HTvaQkftInTiANwE6Ttl5Ua42f2YaVGV/QJ9NODwftBiPkeHFWIP9s7hVrE8U35W
 /uLWunB5JhkgH7UV7CKNqZ3UcrQgBltDIP7qOtxSDK7X3g0NpuGyEpWJFZctBBJf
 K9tvsg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gub329knr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 04:41:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so336232385a.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 21:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790052100; x=1790656900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eZMRbG/3unaK3Cg8QLbjb/+lEETLQIbFWepLzfQiKhw=;
 b=J+rZBBZAAuZQM1GAnTTWaRiFe4vIQ3jGPkX/usK/CzBMonEF8WfxE7vBu8Fc6KN2yO
 2LWPw/wEGd/6jNeNChRkPYdvwAzOe5Xtqm9AeWYOuD9aFlNeKAh7tKgzez383YveHydY
 oHO0+HDQvyBTgaxLyOFlW1zmqEIv6qc/ATbEI5+iY8FNB23ahkSGNrjir0ieJrptbGzR
 a8PiStIVhpJZnAtQ5mjse3QJ6YsqQQd3SSbZT6MLasK4EV6khAnPKrwJoEa3OMkkfy/P
 BqrP/ezRiDiOqxI5cDueA7df3TLXt1/J7snLZtYDhcLq6CVOwVgetbvTe7hyEZKhcMKv
 6B4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790052100; x=1790656900;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eZMRbG/3unaK3Cg8QLbjb/+lEETLQIbFWepLzfQiKhw=;
 b=Nx470BLnYZ6bZ00qPrW3jL3rV6NAQk9KufKHDxfNuoKGh6vXamC/5WGR12bXmJ0zZU
 S0ZXwJ0uNblY6wU+CGM+3g00G1BGWIL/oZjGa96wajuNEJPwh9TVxcognHr6YepJe1fW
 6sPF8Zuy9g6xU4/du0/RcDjuui1TAaXQhMDyI+obbKrJutIV+Y5XJ4b5vzq3XWdbFy3+
 iQocFhLrSyyXBPr6pkaIYi7UNEou0mvijKYEB6kva9EwIm2Sp2e5fDhvE2PrcKrjyfE+
 RCFHwfUtTqd7qedXKtrJX3ZLs7GsLShsW6nQzL6dt8eWYwF+vVL7p0bHw1oUQaYChUYt
 09IA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVWo38UQdttUyEKrGFugeX+shNxOgUQ8eO5BaNEN77A7hiRGHAfKGSnpA+nevKv+cHNb3Ofaym5Km3@nongnu.org
X-Gm-Message-State: AFuF++kUf1s9Omv2NwgXifBhaLQBz2nK5EHHAgspZTIInL4Gw4Fhn5KS
 jQSnH/qGCl6UHe5Ckt3zfG8oncmUOrdqykyH21RKh2bmhtiPb8c3tIwljV0I5lu6r926Nv5dSmG
 /KMGlz5SKNBABprGkQUWhi9iEZvtzni2AnLkM3iO3GNM7txWSrp60hdRuweRUqj6C6w==
X-Gm-Gg: AYBFou2XU3yACIVlbVJeQYE05VVGuVLPaqu/VTkKmgU1ObyWumdthQHQBNK5dK7f1dR
 azw5VxTXG/D3dMcxu2ta3Gj/fkNM8fsi0HvX5R/kQrkP6dHxszaLm20HJphLs5RDRObt48i4m7o
 8hhQ8it4y09TH7vS9zF7Xbo8OWkU1ZSGgeSCq9+N7fB3wpRnAmlSTmMBqnJdhkvqsNhz/eIDEIv
 7uvVoGisq0Q31ZnGvdqgwSo+jOJ2tSnYjpnWnAAfGRvbkmr/AZzmxPzx9GcQvmteoGWn6qYIyM8
 Ky6mAXn+WSux00HY5HtqNg9l0x3qPrS+8+7fF3JwDQAjtOnHnATCGJqRik+FNWPyCdDCymitu+E
 T67e6KtDuHKCCutl7o3WkfuWggjZpqb0T5w==
X-Received: by 2002:a05:620a:4045:b0:93b:d79f:d951 with SMTP id
 af79cd13be357-93c15f11d3fmr377220185a.70.1790052100074; 
 Mon, 21 Sep 2026 21:41:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4045:b0:93b:d79f:d951 with SMTP id
 af79cd13be357-93c15f11d3fmr377219185a.70.1790052099700; 
 Mon, 21 Sep 2026 21:41:39 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fdaaec8ebsm18091435e9.2.2026.09.21.21.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 21:41:38 -0700 (PDT)
Message-ID: <d6fe5e7d-3514-41b0-9595-948f42755688@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 06:41:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target-info: add multi-target test binary
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>
References: <20260921204954.50529-1-pierrick.bouvier@oss.qualcomm.com>
 <20260921204954.50529-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921204954.50529-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B8ssQ+tM c=1 sm=1 tr=0 ts=6ab20708 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=FKUTM8gET8WFl88oZXYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: 3FdYF_jEPoGwJANUK6JoSYQLE7lhiGMK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDA2NCBTYWx0ZWRfX8H+gCosVsxuo
 7GPh5OpHT8tWqHrbD05Ir7ILZ6xcVyydFD8/BAP+QTkv0Pyj3UXK0OCy5V3DGLgx2IPMHeAIaUU
 Tivqg/LJwb4utMiE6RXUe2m413Ul83/FEknDjIYG+Ny1tb8WSHzs6Dus53Oogf76bp7eGbClWPm
 SBRKSxPg8N/HEM0fxWw0TAfUfgRq6Tc54hZYuwOaVIZpiLtRX360Bg5PmQpXFGuGLL4tUXaHYW4
 cIbwG6klPxjL55pFZLtpGc8f7bxDohfnyZWr0jR1XBO9QtkmYUXu2Ejc2sSUwoKQgWqrsBI2wBE
 YSpq9GHU29CIS3WU7BSd+fk9H4T5r/GVZvykjXkX4t8Djjr3vwuDgHIKW/bMN8GaMMT9HV9l7nB
 QqmK2S6MZwOtWA4TBO3xelJlp8aVMBVBBAvAtYBipRG8KG5SSXnXR5b+kHGheYEZWg/WbYE8aAF
 L2kUVOFK+dhqd/MeaTg==
X-Proofpoint-GUID: 3FdYF_jEPoGwJANUK6JoSYQLE7lhiGMK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDA2NCBTYWx0ZWRfX1hAwyGI/3Xx4
 23G/7VVnzwpVurssmLNzrl+3ZLSd1X6WWOc12pojBdJo7G4XNpoAuGRETMJxF3l5XW+OTCa8XiG
 A8LOz06TrKgAV+0F10lyEqu5ZMhUFFE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609220064
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

On 21/9/26 22:49, Pierrick Bouvier wrote:
> Now we are able to link multiple targets together, we want to make sure
> no build regression is introduced. For this, add a new unit test linking
> compatible targets.
> 
> In addition, we check QOM types can be initialized, ensuring uniqueness
> among all targets.
> 
> For now, supported targets are:
> - arm-softmmu
> - aarch64-softmmu
> - microblaze-softmmu
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   MAINTAINERS                    |  1 +
>   include/qemu/target-info-qom.h |  1 +
>   meson.build                    | 23 +++++++++++++++
>   target-info-qom.c              |  5 ++++
>   tests/unit/meson.build         | 12 ++++++++
>   tests/unit/test-multi-target.c | 53 ++++++++++++++++++++++++++++++++++
>   6 files changed, 95 insertions(+)
>   create mode 100644 tests/unit/test-multi-target.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

