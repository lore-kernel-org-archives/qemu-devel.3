Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFD7C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzd6i-0006js-Rf; Thu, 27 Aug 2026 12:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd6h-0006jS-66
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:37:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wzd6d-00057b-QL
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 12:37:38 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RFcv4V359714
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +3OAPDqJKcK4sQxpiEEmJ4+PxF5F2yinSrddqu8/lLI=; b=ia6YGBZxJDrdfTM5
 q7llNd0L4o84wajWFPYgV7/VW7/t1LFNLqEHrSSIJ791taYHLSkuodd9FQkrfGU0
 UuGeviWs4Kd+jImAG1uyCYmkX0J8wtnUeZAwHe9lmM7ilIFe8x+qJLPsnP39OLm6
 VcluKVXjVr8WVh+9hpLjHeiNJg3PjHYRgim8CuAPjG+imvt6ZH1XTV0yRj8Qt69D
 H94UwB5mcYfi4d+UU341yEMo5xoWHIRXq2YC8jsrR+ci2YBbwqY3KwCwj1+rAweg
 D4N+d+RU4S9mH/Z+USzHoTeX/fUunggBay+oKUAF5s/8I14IpXqErXKqtYRi72Fa
 C0Ti3w==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr68v0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 16:37:33 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cf1c86963bso14555255ad.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787848652; x=1788453452; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+3OAPDqJKcK4sQxpiEEmJ4+PxF5F2yinSrddqu8/lLI=;
 b=awSgAWNZBnZsIfC8y3mKDcsbNMdxIVxSaY83OWlbv+4CP20arF5dClY0fsXRQfbIbc
 NqRT26PAsXjnhq51kKQutrmdX/Vyl3koV44KShrmg3KFGmjFwtamwW1HVL1J5TsGPOmS
 lNthVztKRcStIp4UTUZcC83+sCgS4GL8wqKGOsWPLTzLH4HjdVfufTbd5WwIDogzv3Hd
 pNZMeySF+UATGeynL7oyeJ9Z5UhhCmwTfWZGcAVIkaEsoQB6CwMU4TtJ0ekc3imXJJDI
 HBkAg334Uns+0hUed1xysy1u7evejmlZ7iUFFHgyGjmjD3nnObbN1lsmzmumGyJAs80K
 chCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848652; x=1788453452;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+3OAPDqJKcK4sQxpiEEmJ4+PxF5F2yinSrddqu8/lLI=;
 b=ejauWEgZLHC1qVC5oqdRO5pneEEa0TK0zS6ABIVtmMRlHxxrftZNUROE3KnNoP80Oe
 BewQos/WVBauohNLRPZa4mQAE9A1QHEaJu8V10PUh05hLomK+xO3qX2sFEEXNzDLksND
 aEW3TnqOkRWW1epG9I4SOLymq9Fja+rJP29ZC13nqmg3IH7ZaA9Zl//Xt2UUBFoPeJht
 7q0iAalY/Wt1S/Aw4gWNvigH31m2D5YNnK1XXYB6MQloOZ5JmG6nxZjkfHw7akgQPuNM
 m6n/bY6ZI7veGA9t9On4D1gYDStJpZO4cJk/wb/MmDOWjhrBjvKDqEcoKMgyumHXiOpm
 z8JQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrdy2ry21bM/+u8gVb70HzkQZA/Z/9fbL2RpClLFPmzra6c2WpLaRK2uMOpLDdBN22pRSuqLbOxsG78@nongnu.org
X-Gm-Message-State: AFuF++kKQfvcc6oOW9qWRJO+9eOaOJCeQZ2wunRVx8sTZJbMJTSKw9da
 31uuXdYLSjHm1Y94YzyMaSPCK5mvVrbzd/ZmOzLj1CD4IXcQxDicSzerrL+CIBOujL9TgdD4SW0
 Y7yBh5cMXJM9qlg0SyBVF0zNcVYITZTW3mQxs9NJtHC5EDWPiqt+Fea1lWQ==
X-Gm-Gg: AR+sD11PwICldGl6DvpALkcInEqa/1BdhV8KfwZMn5UhyvGG+YJfkkQsHgFFCkHvPWU
 ciArPIYwtU6zQ+y5ayf5z5Js7gYB755dEmPx4qLTUV4sAKbGrSciarMHXYhS6m5JmCpvRzJRYfS
 PCqMCwB9k4WNy4Xw0fj8HFT5lNQhdcbGjFkBvpeaFSsJmJAiywDlZA5s4Vz0V3PlsyLjub1nu7w
 zLBb3xmFbvKQcn5h4gEZS2XabRoLe3hRus43KiG4AGR4Nehn6FaOxbpvkVlrRT05GJEyVwfQjOp
 LkGFlRWNaFzAD/kxka76RLKJiLvG3n0WqMNGOPBasH/spAPm8tinTKithZFEI0vhwvwb5d7imt3
 PxEztTFI2YWLlYer4TTKuoFMi+c9YgvHmZOVy7qIBEYPdi89s/z867/Dl5MQcOj9l+CSD
X-Received: by 2002:a17:903:2308:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d72659fedbmr86022795ad.8.1787848652541; 
 Thu, 27 Aug 2026 09:37:32 -0700 (PDT)
X-Received: by 2002:a17:903:2308:b0:2cc:ac15:ff4c with SMTP id
 d9443c01a7336-2d72659fedbmr86022415ad.8.1787848652119; 
 Thu, 27 Aug 2026 09:37:32 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d63bb23sm21576480eec.7.2026.08.27.09.37.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 09:37:31 -0700 (PDT)
Message-ID: <786975da-2021-4a0f-be96-78aa315be2cf@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 09:37:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] target/arm: Build cpu32.c once in system mode
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@oss.qualcomm.com
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827041557.775080-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXzvA7PWb7pGxl
 zZ73B0vQA93ZT61DeUXKo6NW6SM41qRhtGRH7RsAxghD5IGBgwHLuDrQcF8tgWzpjPDz4Ot8cxj
 9KADyGwJoGeGY4HQEZaDHaUiFxpddG/vMP8jIoH471fG9NZFyXPFmXgYstSEW87vWXe/TEwQGUh
 NdDGIb/6wMmlKR3BsK74FQpum6KSsYKyjVpYW6lFwRfarIKlGhgvUo4mezhJKrfCOKOAgdN4rSQ
 mAdKTVgbujYURuKFuwHGp558OdAtojPGPhpFpG/KDkLqVGSy39FDH6ENw7eTax7q+RmLDUrPUYV
 AH9YjGJvJuqEUuhDn9s2stUzyo6/CK3jDD4J9txs1e5ceOiX1XfqhV1G9HfnozzkuTbNROzIGlr
 rt0srUl1XmTbGPq07di9+KyW/kA42lqqSkFjHDchSJKFQAOm5ADZMg9WkvwZ8oOYfrgnm4oq/jA
 Jr+RQl0Vp8sQLbDlhIA==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a9067cd cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=ENnqmNvwfkBjyS8sMAsA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 5642U6HN3DuHOSYNsojIzoyMGrFel4oV
X-Proofpoint-ORIG-GUID: 5642U6HN3DuHOSYNsojIzoyMGrFel4oV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE0MCBTYWx0ZWRfXwOOwYMYobQ1r
 WfjmHfV6nYXAGJdN6PuGXn+/oLx5dmyukLsqgBKFGeRFfSeh4ut0C8C/QK7BVqhlGqYHpCiz+is
 Eb7S4Px1G0OuAAG1ZHzHL0l/L3rpSqg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270140
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/26/2026 9:15 PM, Richard Henderson wrote:
> "Move" the ifdef to meson.build rules.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu32.c     |  5 -----
>  target/arm/tcg/meson.build | 10 +++++-----
>  2 files changed, 5 insertions(+), 10 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

