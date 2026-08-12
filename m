Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EE0C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:17:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu3DE-0007Q9-An; Wed, 12 Aug 2026 03:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3DB-0007Pt-Mn
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:17:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wu3DA-0003Pq-ES
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:17:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67C62IT22872255
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gDAjPWym8wGYFp5slNfluvHPiq4gtW1T5bigRv4UkBk=; b=RrvI8pOBeZVbVNEY
 PmGXk0DDdDbF5/+mJeerQ1Q3a4VGxYlIAvepoey9oI3HEuspxmCVFjGCRnFOxM6k
 wa0FkWNSXJqV4c4hY7+B6+CL9p3FhFzddUJLTeOlNUbdIlMRDr6mU+NN1eOyNaqA
 aQh+f2EaCPW2OBxhmq3JnCobhsDMGYjULXiQlPGSm9sB7VMTjiYOmL9ntTX1FM3g
 NzIdkId9yc85LBlHMGtYclGGvBitpQSLACC6U5zlV+dXzZqKmHGpLi2ybi3X+G4I
 N+QJCewXpJjHqxPACpHapYPD4ifl4dqu0AEwC4oWUFtO62mvlFnNF6NR2wRaVB+V
 7R4uaQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1gmrf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 07:17:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51ebdfceddcso7891841cf.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786519033; x=1787123833; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gDAjPWym8wGYFp5slNfluvHPiq4gtW1T5bigRv4UkBk=;
 b=kXMUUk1b8qWtN3uPIB9B1+JNLrhFlvYs3N4YQw/34lqdxkVRPC9IcMqABRNWGcA+Gn
 peWhJYXJ2yEtcBrLqE0/gU2DB+358yFq30jeUWWwu1e00Bjcv5dML8qJW7sSb57dKh4a
 CbiQC5Gf6H5bghuuqBe76Wol0FFH/lzgUw6jkdCfqjr+YEFX+0Zceq7OHj4/chn2kKnW
 svtOu1L8BbZT4uSAjqA/r5/UxB3S2djDFOeDkyD2FYCUZSWaqCY3IaZet8+X1EG1PIfb
 iFYwemxMswFmd99ox8SRvU5n92vXYRHGjqWeFVKUg1cqywdfKQeMLbH/iZUyGxVYSgx4
 yRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786519033; x=1787123833;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gDAjPWym8wGYFp5slNfluvHPiq4gtW1T5bigRv4UkBk=;
 b=e6v1rUZBLRkAL0wfF5OvjJJF3G9a9Fhx2R0e/MWY0+9p0tkgf1oZnSrsdWwNcs8Nhi
 kHWm/T5vVBsDOIQ1pVWq7l7I8LU514u1WOr9Y8ar7hJNQtga3j0Kx/lvOnWqxAJ93Upb
 VCno2/9bcBlBugEDO88hD0njViQmhnwBrB5NFdrWZy8+exKKjwtrFZnkOaCNUropYC4o
 XpRoa6Ellt/lBHbi10DWhvT9UxSYMAVLH6IEKwhvSkb3spQU/qAvoK7iWBbMEex1Q1yY
 kNjYVHJX7IjfUodjlP0yy5MC0dW8Q4xumdXxe56BGgyWay77KQMoQ4SvfsQr6kyviZO0
 /bGA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsIuEzGVso7Cin5jU/qzynjWbWPsxMXdoYuQ+fgAQlMC6J9lpwj+Sr/CsfYjbKxysD4zChQxWBxl5M@nongnu.org
X-Gm-Message-State: AOJu0YwfX+Fb6hyOMf4CJ10x2CFffonKfu3WEMaSdPGkMCp9kPUrFtHB
 Khu3LUteNPLEInEzrP0NKijQEV+lYnR1rLj2/of5e/C6mYj0RWFinoavBuSNyKePOb29SmVcRU/
 60R31UyWmmAcVQk5PVrDF4AtUVPFeSqzpwn9wr6kLpzv2zXXHxbD02vdXdw==
X-Gm-Gg: AR+sD11Tlh/rG6GzmSf53LrF0ik6ZEDGnX53DwV33ykV0YxgI+nfT1Tnfnque6HX0fM
 u3lCovi0fZ+Gn3/8AmGSfwqNPqBgiLmBZToZfKgARqPjbXvE8NjMsTjhWxEuck2n9a+hkgnCnL2
 9xG28V1T5OUMmFPoBiQLAHsPKJlhNxtD7FZTWJ62oH4WYmb4yXi57/ejpe3KOYHZzohyMGJiUNu
 RkBF36O3tntCys7yYTfkAx07mUSWYuq8IhUq/VwFS8x0Gg8fnZC+iDgvHuINz76et42FlGI/WxW
 Y3lHBxHIbmrNoTIJpoBLAb4ReZYLNdKuYaPyD2F7Dgem73RBDMpjhu6w8zs8KNHDopKtJQ6jMwG
 CgJaa6tQscFpe3vKrLirhOyYVvx4xv1ElISo=
X-Received: by 2002:ac8:5f06:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-52d64878ec5mr21601101cf.36.1786519033029; 
 Wed, 12 Aug 2026 00:17:13 -0700 (PDT)
X-Received: by 2002:ac8:5f06:0:b0:516:ea30:8756 with SMTP id
 d75a77b69052e-52d64878ec5mr21600951cf.36.1786519032641; 
 Wed, 12 Aug 2026 00:17:12 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997b15b807sm76014995e9.7.2026.08.12.00.17.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2026 00:17:11 -0700 (PDT)
Message-ID: <ca7129e5-a209-46c1-aa2e-7d3236ec9ec2@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 09:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tcg/optimize: Handle min/max opcodes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260812003143.225228-1-richard.henderson@linaro.org>
 <20260812003143.225228-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260812003143.225228-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -KKLcYz4tu0mhKN7MrUpW_BfuR2bF0l5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX3kZZRssePbOn
 nfKoYSWHukaVkL1t/7KASubnHjQLyqkuFqGWvftbOAWz+S5lYh5VGcf8HOl3gdZ0oqBf/GPs2DF
 WoIFjvD93EGoagp7fvIvl0KhSH45yUpvh2b6MfySH7IZHRo6h1H37sUwZlLN2q1tXPCCDlWxU+8
 9ts+QVzYWZVSpNwFUJoaikQmRrvm6xd9dzuinSyQFsq08NM5rG1gSYpIuWixC2/qc7pBwhPSs3M
 1s+bHYEBO7w837GVVYqc07TjSvlbAw7dARiUe8VaFH6T5cDsZ+CbkXmVNQY2Up62NbeEnZu99Yw
 0ayTK3cOTGnqmZVtcv2EHKy+1gXUd+crb/8exuQ3/hj8vnzfGHhfsIUewPYETKv56B5Yx5klnr/
 0eoJgqTmh4mtKpqd+T5XEDFjXPkuwmNq8siV4YQmlfwbtodL00W1UByBRVF0NBFRE4nZWGhY1cB
 kIiTKGAf3MTdVOjTGtw==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c1df9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=F4whdlzREtsA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: -KKLcYz4tu0mhKN7MrUpW_BfuR2bF0l5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfXwqEEEiw1F8uB
 iWDLBqG44GMcNs8Od50vd1m9McYs56JH5ZpJ5+7QQElieJv8T5nhhjw4Vzv1vNI7YU4SmCABRuN
 G7OVxHebdksAJDF7yKr01kpHog4YCZ8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120057
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

On 12/8/26 02:31, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 52 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

