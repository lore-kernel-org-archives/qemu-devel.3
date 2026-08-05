Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 624B7C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 17:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrfNS-0007vL-3D; Wed, 05 Aug 2026 13:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrfNP-0007up-Nb
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:25:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wrfNN-0007Vu-LH
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 13:25:59 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVN473867917
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 17:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RtIVcBies79Fhv5a18oxyMplf+iCJZhWsF8bWMwMIN0=; b=Eb5VBOe+ukEMDl6M
 eCmwwwyMJzCDPcZFb4vxsDBifg+SNcs059DNdu9wTYYtxF2EGf1mpUFz2gPWaVcn
 seOe3eL8bOScQpwNVhSh2y5QH+CUMNHMRNMXzKE6Kt5u0aDN+tZBZnkxODGNtERE
 bt4GQ24d8b8U3WLGjDG0apDhwlWRFgBzUCvcwV1qolh7L0BAQFEdntFpAkLYb8q8
 fnLGwLms/WlGW+BkEmPkBa8v8C4Msgq20qxMYd8jA3vQN/apNCfbdl2T66LL0D5x
 7aiMWfUTc1WF5bgISMN8XZzt0V87UqpdGw0KxFClkJdWTpDJ+SvdLy8doWJL+hEE
 TQxIOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5dk1ct7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 17:25:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-52b4f6ac06aso18870001cf.1
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 10:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785950754; x=1786555554; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RtIVcBies79Fhv5a18oxyMplf+iCJZhWsF8bWMwMIN0=;
 b=a8tWZkReUpT+i4L+5JjMLOS74XLSifu8bVSN6Y3wp1KuAQmZl8kI1wiic8ubLtKFd2
 hnOGyr7NgWsyj7nRIcgb4mVlDhNvYyBp16rt5fG6JGGa+4MFLiuWFypS0MXJoWLLiPYY
 AMUwrn2PdeKFVqIh1h06yvGYaPfkoFnU3haDDGC5Mq+QMZVZKRn59tyZ8XzB85WuIz6O
 O8s5XLCyYTG0XRyQQ1C1WcbkssTathgqnhpwXkWIW9Xip0iAbUwuk10fjx/dEZomFLZZ
 TzGPmiakTToi0Csfu5tLlQCIAB1emVA53YfeXbdZOKHcwEa/7nBMGXPlysoZLLJkKbuK
 72TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785950754; x=1786555554;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RtIVcBies79Fhv5a18oxyMplf+iCJZhWsF8bWMwMIN0=;
 b=hNdTdwCqwj0IVGgDXy1+cO0JS4tcNOzL8TNJg8aXbkvZfR+LTdJnIC87AYpQEWv+oZ
 FFvLwaBj3LMtuDmiNVWPENC0L0IQ8dyW8YmaOI8dmwgwx/ZFIlh22W0Qu/0nprd6Qkko
 cYW6mC9YLPPygSHCkbzBn0xKiB4JDyVinrDJ9UI+UA8eCSyZaus0e5YrztTnVkxMjKlS
 hgJMZLdz/C2DFuPgtJgKOu8x9DyV/JS0rFFufIheFdxDupgiHw0z9FTwidPf+GRl+iUR
 CG9x1ITmG8LRHVfhhS8n42899Lc1krDrWx4weQd4ZLA6+/kTvjzgR8SQRz3NiuaG7gNa
 xF9A==
X-Gm-Message-State: AOJu0Yxatb30BsAunMwNIyNxOnwHpUqGD7LnQCDp3gZklfXvrGZNjE+Q
 1YjXnW/No6EcFf11svD3zuQJw2Nvae9EIN2oGeZyR0kySgRAiQEKxAAms2mqkQoo7W7kllYdFUo
 z5MQ8SLmaBbP3YyThVC7tBJEjuUFwpHKlFGj7oNeu2Wddv0cN1tFkXhi1FxIbYwdAuw==
X-Gm-Gg: AR+sD1346H7wJd8PSGjq/8EjPtPXBE5e9LkPJ299viHEMfOvF42dNZ3e1kNfF498m37
 6tC+EWdOYSbiNJVrwhVKq9fPP16VY1LO30xnpshR56hREJgfTFCaNW0H0IgopNJh9km3TXcM4Rs
 xSg+n6QMtChqUUxbo2hjfnLxn9vjZTgp5FPY89a4g1gTfkeLdTM9173dDcsiCmtLfDBtzkQ7bVF
 YXa7hI97VVxnCKpVmCPjS7oS/nms/YRxTIm6VTl10iWKCyjZeYVoCcGeLuQj/n4GAnCfzZrf9jI
 gF7KjyB8dsTv8kUCKTl+abP93Tl15l8DLQlcxR250YaY0YiezLhuR48IQ/clj/qbZ3eZuEQqm0g
 7N5i/8xtcKQ0CrB2US3GRbr5zCQrowCfqfz9Abz6UPAtKaC8Lc9Ml/xAKsdBmmjpB
X-Received: by 2002:a05:622a:d5:b0:52c:dffc:4643 with SMTP id
 d75a77b69052e-52ce607a938mr75920821cf.1.1785950754431; 
 Wed, 05 Aug 2026 10:25:54 -0700 (PDT)
X-Received: by 2002:a05:622a:d5:b0:52c:dffc:4643 with SMTP id
 d75a77b69052e-52ce607a938mr75920231cf.1.1785950753799; 
 Wed, 05 Aug 2026 10:25:53 -0700 (PDT)
Received: from [10.222.168.219] (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52ce9b0743dsm22680841cf.29.2026.08.05.10.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 10:25:52 -0700 (PDT)
Message-ID: <26823eff-3b2a-4b76-96fd-0a5bad96376e@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 12:25:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Fid host-utils sat; Add GVec overrides for HVX ops
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, richard.henderson@linaro.org
References: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20260805165225.3117924-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: u8l4NBq7Y978ubqez-y3iqnBHJfXajbW
X-Authority-Analysis: v=2.4 cv=Or9/DS/t c=1 sm=1 tr=0 ts=6a737223 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=JBLGY0N2V2MNmMGsdCIA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE0MiBTYWx0ZWRfXw8gi36qxOagN
 +ZbcraK4rzMB5/rC7Gfbjn35uNIx8UbFmZ7v3r+0fIWcTYWxyvHFD33QY93SgC9gOOHlXMqAY/m
 sR8T8e7vSpb+IX52oU8KFeyADgiTlxN9+H/4hyAXbNNpwpSe/t47wGKQ+wlWPrGaCqucmICbySd
 b56d9z584vt9sRj0+UATKU7Hw7S8G72eQt9vf8Ivu94IfJTOmJJvSrfwSrz0QfQlK2ui+TfnjYC
 P5RvTrk5TyR+DkMia/X8rhCoBwM9yUQnt21VWMUTB+MusLGFc9ToDXcgeQEN9BIl+LgiuvAL2SB
 8TJAVkZlUE+INtDIQ0T+AlPkT/CIScHJkOofGdI6cGdQ39oduslldr374A5R3zAu/ac2hvliiym
 FIAD8c19OSPovwLgE4YT4/ERSWPQWQeEjGSSI0i7kttqhThwvTm9EdmChbL7MmZijo9AhhYtzAW
 iREObfM+XX594ZeNrmg==
X-Proofpoint-GUID: u8l4NBq7Y978ubqez-y3iqnBHJfXajbW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE0MiBTYWx0ZWRfXx8WnTkKwolON
 +kgXk53mfVS6baE9VfBNuwa1tkfWBGGlBDOCioMbT6eaJMTcJ4/P1q2hqN2G7YdlXYumTKiCYwq
 HErDLrd/+zDYJx1AbjUhq44xKUfqVRE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050142
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 8/5/2026 11:52 AM, Brian Cain wrote:

> I was going to just send the host-utils change on its own but figured
> it might be useful to have the motivating commits that encountered the
> issue, so I've included those here too.


Ugh - careless review - don't "Fid" host-utils sat -- Fix... :/


> Brian Cain (6):
>    host-utils: fix ssub32/64_saturate return type and clamp direction
>    target/hexagon: add GVec overrides for HVX saturating add/sub
>    target/hexagon: add GVec override for HVX vmpyih multiply
>    target/hexagon: add GVec overrides for HVX absolute difference
>    target/hexagon: add GVec overrides for HVX vector average
>    tests/tcg/hexagon: add HVX test for V6_vsubwsat saturation
>
>   include/qemu/host-utils.h    |  20 ++--
>   target/hexagon/gen_tcg_hvx.h | 183 +++++++++++++++++++++++++++++++++++
>   tests/tcg/hexagon/hvx_misc.c |  44 +++++++++
>   3 files changed, 237 insertions(+), 10 deletions(-)
>

