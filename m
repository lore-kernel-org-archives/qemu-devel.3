Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA40CC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ckt-0006ZP-VN; Wed, 02 Sep 2026 00:39:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckt-0006ZH-Bn
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ckr-0008EZ-Qc
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:39:23 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KT9Ho3108193
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:39:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 e16eHBKJrTLPja0sPJ5uFAjl2GUJe0A8rMCI/IQ20Ow=; b=deSg/qa3f6SC8W/q
 uMIFx1Sa6mXFvN+C/8NAQA80ReN/WTSKY1mn87RwP54XNSZvrGdLZ+4Zg8MOxnaP
 4hV/aK4TZ2hMJ+A0ZmKY/D//6PmkzQn7KKjveYOrM9iA0Qx3dMNDQpRg+YjzWUna
 8xaN3s9CTJA7Xe84UyCllZwEVE8eiB3rbiIxXG1upzE78+3bZDWcX9cR8fLJXfPF
 oo7dNnitJdsTez806iEb2QZeObzz9aiI6xWSQhI1ECQpFV04w/3idyuBc2t+T0fE
 OKhGHiO5r6VHhoi/NQZscaQRDVfeDKFH0EMvq8EAUuenA0D12WpBSn1Z+2p6WVTu
 E6/E+Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpamtj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:39:20 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9308eafb465so178373585a.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788323959; x=1788928759; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e16eHBKJrTLPja0sPJ5uFAjl2GUJe0A8rMCI/IQ20Ow=;
 b=BFLNaj8soTe6Pg3agJJfIMbdJ0g3HuezAyiVAYOQKeKj4bQr9OKbOpDCUH9LR/K4bA
 C1VozexsiVEPKUgU4NN0n43fDaszn6IukuvagERi4U48npjQ0bkd9FWSQskEpL1t/zAa
 DBGrh7RQkxjC4DZ9UZDQDjusF+hKLAUdg5Z+niKht7+m5qgQ0jwhFURcZAncog6QYpNV
 YdWiLa10d9tUBYNSMHWFNW8ykZnb3Q71DCwNt0H4EfOwwKVb0GgaHxDQD7WJ/rv9//sw
 Nic31dyP40l0zwBTv/pikZyQ0E6Z9YOAFBwvyt+6GfFZf1x38UdMJfKbPL3mrdWlRpv1
 ezLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788323959; x=1788928759;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e16eHBKJrTLPja0sPJ5uFAjl2GUJe0A8rMCI/IQ20Ow=;
 b=cr0U0uSp1NCFQ+TxjGT8DNM4FrUnLHBOyuG6oJaOkRHzEOKErwFdWwV27mkhkuf3Jl
 FfBMFEcHlZtxGogfq/JpIaAKysBonfkKmQZx9kABSjW0KAN4JHJtaQ0vWzmOVHGSlFOd
 WeWorQhxbNq+5VN5OHVOzLXF73L2YkFnp0eA5YRTFDT7PT72yImrX3W1zK+wPvZhOpSf
 U9bxeOTuXKF8CFgjxGMLYyG++xALas71jHDhTnOfNLFoHWzCkYC0xEeq81kUDoA5npj1
 pdy2Z6upRezvlYxr6TKI3STyWBKTjQxrtYKZ7G2RsHBNq5OdCJZgSJV5Nk4clx3OPUoU
 i+eg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyZcC8HlN4+51+fs+5QsZCvURyq2dku0xuSTfWccDhV4RrQ5EnSg9J4YOl5h5qLsZHecDi6tL/Zfxh@nongnu.org
X-Gm-Message-State: AFuF++n+L3etxZpvibIzDiL5roQkgLVoxd88JIp5vtCUoMSk7s3k8671
 ZzM4EQlEOnXFTOQBXNWZVcZn8AOep9ab2KeyJTYX1mHm3HYdYyOwOBzr5ZDbRm5kgpjKqR4XINR
 vSnOJmBYH7YeTHXLYq2u3962qHRkJbpmWSn/60noUpKat4+sZn9OSJM0ADQ==
X-Gm-Gg: AR+sD12ZjfmPnEVDPi18luWN0d7nyjMoN9opiARr3Z14Fr9WUnynD+l2JPvlVtuRFX8
 NObnjTbTWt9N6Z8F0+MxA3WoT5Q1uZAWj6AlYraTQOhPwTrG8QnDWFqeuGMdRHFRZmPfgK6BgxK
 lMKwKEa5aFWtjV4T6Cn5QuxzoMFg6mrdtfOsSByqnDwFb+hZdnlTkw0i/OHLkijUwKVdHCJS5mc
 yXN2ewnT0n2di8qMkegjFxzDLrKPBzqz3XiMFof9o+67lwm8rdeuP6jNWcPdhE9Pp0GgcCU2DSz
 pvqSl3vx9YAxA3sUGcx+DBepcXQrTuMLsa1TCsA9zSyhfU2S4x7AmXUNASe2jRlqVgNwl1HUM2P
 GXsztb8XzurEfdrW4EQrqhS00XOhqYlowtg==
X-Received: by 2002:a05:620a:28c7:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93960efc6d7mr260022385a.26.1788323959388; 
 Tue, 01 Sep 2026 21:39:19 -0700 (PDT)
X-Received: by 2002:a05:620a:28c7:b0:932:ddff:1241 with SMTP id
 af79cd13be357-93960efc6d7mr260020185a.26.1788323958900; 
 Tue, 01 Sep 2026 21:39:18 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448ee9cf7sm3676305f8f.25.2026.09.01.21.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 21:39:17 -0700 (PDT)
Message-ID: <4b27d78d-1e21-4d78-9b8c-cc56d8abf2ef@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 06:39:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-14-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260901202043.26532-14-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97a878 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: _ycjOqItRmIoOx_UFyMFtqluYUpL5TCU
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX07o27tKKMYaN
 NFMTjgc1LksogfZiDsGTuAQvry/xhuzC8EyjWAb/O8zL6mgkxU++xSRDfk84XUdpkjdTjG9ycMN
 ja+kjjaWSGYl1f/osSc15fW8rf4YF+I=
X-Proofpoint-ORIG-GUID: _ycjOqItRmIoOx_UFyMFtqluYUpL5TCU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDAzOSBTYWx0ZWRfX5NPrFy74Yhfb
 Z3gII/0TcsIqh87DZqeOeMZkqpYdTYSU9dlTou/i9FZgSih0dBtt3Oqo0psb5G3FYbpqNquZlOp
 nmv8+VWgj2Da1gND4RUdDET7R+kPSmEAcWuv2z8QhARsNT2acdXwTSjHs7l5rhrDX+NeWQ4Xo1v
 8+8mHes1sxvW7nelbINbc9ss5IVAEUkRkzUnOwQG1qCRG17mC+YKovO6S2z4tq+rLDaypkCm/3B
 bsRzwr+YwhJ1BJiKL8kVpZf3Y6bV6x84i5ROuXpHS1vSLv+jwKXpAornbGpMVT13ekCExDTvfQZ
 FUgpCVzwu+sJS6nRQWb7CZSabTgkiKIkqM7M4rlbAqFFbJJBagWcyt8KuZAzfPNXTtH0fwJlXOt
 CKA+0ofkv++nWoYDb///LSYqoPFLvbCDdYNC+KGhAgk7TgO56MT1xGoOTTUbnuwYuta4N90LhS7
 oqRWSPIMT5dirjVuhPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020039
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

On 1/9/26 22:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/riscv/boston-aia.c           |  2 +-
>   hw/riscv/microblaze-v-generic.c |  2 +-
>   include/hw/riscv/machines-qom.h | 17 -----------------
>   3 files changed, 2 insertions(+), 19 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

