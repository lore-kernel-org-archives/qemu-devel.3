Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E88CA5FA1
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:20:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWoA-0002KD-FC; Tue, 29 Sep 2026 08:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWo3-0002IM-KU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:19:35 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWo2-000369-1V
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:19:35 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEc5g1392302
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QFQlP7Gl24sl5yw9tkUTjlHxZhjVyTAgpAkpZPUi/WE=; b=PZY2L5b1Nc2pbGUN
 cYURXlVOyzMM5FysoruGD5YLm8IAU0j8HSsFW6CipOp8CvWdfM4ehiB9hZo21RsY
 elYf8jdgH8f7w/SkF0thdaUhAcp7jQ6pwztUQGUJE+F5PZvzdPFIEeq38oww3wy8
 DSxDf2q+YPbrTOB4OLmBp+FOlHMdvtco+IeWmZGk5NnbQqDV0JSizqSpA0LCf02G
 4qg/Atw2nYb1dbsmdHtaVT1AwnK9npmB8M8w1kilQwmmUfb4BjFDX1IF22bK0+lC
 h2eje3s6IpNf83S0DR3rPPNWj/pwGhBReADWWIsfs3JNl/v0BmDV4jK1v7njr7AA
 /97yDQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyw03kxu0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:19:31 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-986ea272f77so257763241.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684371; x=1791289171; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QFQlP7Gl24sl5yw9tkUTjlHxZhjVyTAgpAkpZPUi/WE=;
 b=g6mbI8E1ByfUux4/AGSu4K3SHZR1V3ySS33pbr2F5TM40eWmWRYvk/3k493blLHcD+
 uK6R/GKTeJWLMxqTMurWoXZVePJ2pZqhoxBUBHr+42i5v3h8R/F7TOzkMp0MKTjF+VV+
 QVpr/37KDNFtCY7vyoUgKHr6a2vprh2B7bySc9Ik9267xZ49H69X8H6UAX3JrZAA0cYz
 ZfuTOhE8cLnl1Xbklbj6cpUmvbxGP14tjuwaFnQkSkbZuwg5alkaHm7lqYKUk8TYYeAN
 skLkT2uQyDpyQnljx80ZdUBTtWrAmlF/s7YOudO+/3HwXcOVLWB6zJCcZtmWMcgO6SHY
 basA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684371; x=1791289171;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QFQlP7Gl24sl5yw9tkUTjlHxZhjVyTAgpAkpZPUi/WE=;
 b=yE+qloIcUzVB9ThqJo1Lo0y36Cwtjuhud6JOvPcGMOEED6brdMT9aHzeyApse6/qza
 8deFJkwFgFUvxqryRC4A7uq+VDjSZH8u/LlFicIxhqo2Mty/W5MQe2g+Z+H+si2D1H2g
 4BnN6dR1VXncicEe5bCA2LCdOpDfMXaNiOk43vsGT2K+4F5Di2Y7tkgB6rnftzoqphpP
 e3IPr6NcKqb3nAN6m8LVkqkDgzwk5E38rBIUy/1YfTKC5oma07B4OP5aN6O6rwH3oRBV
 j84cGWgkSdROZD0l7ArZ4S2L5gvP1r3OGBeLt7EXMmhmLME/H2Bgbt1b6EGQ81uo3a19
 Tltg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwxhiqYMBhJ/qm0t//60MxmKWKyB9uKhQ8b8xg3H+sTfpMM+el5Tbmcz1lpT2AtjrmUTUWsGqF9M25u@nongnu.org
X-Gm-Message-State: AFq9FYKp/l32YZ7gp9r76Re2XzK9Lq8fguJbghMxS3lP2xfcnb36VRUA
 JkNVMv6gq8ttQyUXtNSr7a+zdHQHComkwObPG1LPEp/ZGTXBKGOOaNoK2nxxCGGd7QSDm+9Aia7
 +VFCwQf17iuulVyi5MIO9/AAALTsjR2Dn3/mAvx+vSK9R4dVvuW0EVekDpA==
X-Gm-Gg: AYBFou1uak4l+exJESLn4MXMNnFjSk8ENd0KTUEvzUGS7an/uTcTqUKRZNpuo9F1q9f
 Tekk43YAMRc7dvw6tekMURS9rSCkj8ZSNuj/tfWRjYKHlUUkXZIKs9yaGFR1IiZFqv5F1SV/VQt
 jGgiOGde+Yjlu3YqTMLFYimr8vARwhOUD+7+Y3rH1WwLJo2x7lkWmHqE7tbMMzPL57sLtWANcO1
 Yn0ro8+RvwjnheKZ4z8FEb/bu68Gdo/TIUF/se56jMw8WznCMEj8pSMPJ/ohFY/svpUG1Inu4sM
 wTsJheMxHsX2TSHYrsPiYCj/TKPCDHVuUM0lb2+viSafnSn1EE7B7nPMn3FSdLq3mLB9FHhL1v6
 uDUCnpJA4IbFLZuUuJKvr99qfdAEmk/qLML5UVFYA+KM7
X-Received: by 2002:a05:6102:504a:b0:7a1:f951:f307 with SMTP id
 ada2fe7eead31-7b1d5498d42mr3259785137.26.1790684370896; 
 Tue, 29 Sep 2026 05:19:30 -0700 (PDT)
X-Received: by 2002:a05:6102:504a:b0:7a1:f951:f307 with SMTP id
 ada2fe7eead31-7b1d5498d42mr3259770137.26.1790684370392; 
 Tue, 29 Sep 2026 05:19:30 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5078a0asm4082011f8f.23.2026.09.29.05.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:19:29 -0700 (PDT)
Message-ID: <ad1f0768-2f56-4905-a974-b9d92302dfe2@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:19:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/42] Kconfig: Extract config IMX_AVIC from config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-21-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-21-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXw7Gs4KKL0SBX
 Ut6Dlf8yzexHB8XDOI1ZRFAdcq/L32AtAIrnY9wI6+0J2+36hEUZQ8Kij41RLm/QtoQBgP0/7ei
 DBM8ujuNm/eN+TUbRvxWNPKLVP04+bM=
X-Authority-Analysis: v=2.4 cv=SIbXx+vH c=1 sm=1 tr=0 ts=6abbacd3 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=iL6aATLHOuMsmFBjOvkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX179sC1KpwWCB
 vyMtLGo61yCAFbkibB9Yf/DfgRbRdLIL9bGI7wnifllz2yuRGNObNH68dhvGAeHGl9TwD+uyy9X
 MGRmCi2yFlGa2VXIguj5tiIaKe4nr2+PtyTW/ipJvOT9OdEhl4S5Td8VGO6j+2vy5UkVfkYCkQX
 lo9NVKf22sjtIQD2eUdpCfTNZPqGjiM74XzCKps9hZ3LTGKcn08QwmTA/DCXm4G3T9SlRyEf7bN
 QbtJJT1AESzyCDUekstCQ12Vq0vg9WDUJGJz+wsdA62nJKLxV+3eB+GhQ73PIQZpmm4H/CN3QsM
 3xgxbuqZ4gEAfM8E/bZDtSqbWzcf31e6kxATC4xsMrl3arD+f8jiy+HLXvUVVQDmt3xqupu/zhG
 aucTqPvjocNXlZyKlMCk7meaTRj5dj/OTkcSZg1IyIuU79A3euYzG+yC6xIfGPSzaqv0CklBqaN
 le399/VeByfqDAIEhHw==
X-Proofpoint-GUID: 10dCnJkJSXWoY4qf4kT85kebULJ0DUW7
X-Proofpoint-ORIG-GUID: 10dCnJkJSXWoY4qf4kT85kebULJ0DUW7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config IMX_AVIC to eventually eliminate config IMX.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 2 ++
>   hw/intc/Kconfig     | 3 +++
>   hw/intc/meson.build | 3 ++-
>   3 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

