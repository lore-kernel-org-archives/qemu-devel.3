Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE8ECA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBoTH-0005lB-FP; Wed, 30 Sep 2026 03:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTG-0005l2-45
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBoTE-0008NJ-5Y
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 03:11:17 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68U6oX2S2710006
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EwWSOV+DqPtKAlyxdGK0yZ76WvmPxW5DCUJ/NpjNaac=; b=KdmEF5xvn+fc4jCg
 iCZmC+5ZSFQ4sBjsETTFXD+aI8YVQN0Mhtgbnk7js2U0y47m5ztRzrNUTs2+JeXK
 /5vVm0KQNkS7AQcrYzpeNTBRGqC74utLZvfLorWBE4E6Kadd0jWE+fDJlazDMd6R
 C31M311rdf3FgP+UUWAWNMHn6emRo5/IwgM+5xun7FmLgUcPCs1prlK0bPUlINu4
 /JR4Is59ks+SLwojoldFAcNyMscG7aRKfV1VAAB4sJqthrbvJz3G9CVwqcSLsd63
 MQ3me5PKhkITrG+1pv2y7gmH0DQXpRO2MSuuvGmaNE5WBbRHB/wjnbDBqcDaI1Gq
 nHFm3w==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2sdmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 07:11:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917870a9be3so29758656d6.0
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 00:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790752273; x=1791357073; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EwWSOV+DqPtKAlyxdGK0yZ76WvmPxW5DCUJ/NpjNaac=;
 b=V1Bm25Irx/+72jCY8sCMrSW1DCzCljonLbDqEsLymiD3O0m1xwJ3oSnvoHGurIOPwM
 nEd8WCdK+vtu+my8i3FxRlXL9Zrb/QQCxDxFFbH0uhI0G2vDdbyTXm53XwXGNKwSSzl2
 GzClJE/SMdijpXPnKrs5mXgtjxbCzrzIyKO6EKW4iulSLm6pMLs5KmXQNwCSaagRlyjK
 jsh4HQSRjpMsJQeK+iwi0xEgryKNC8jIh3poaykPy0NxkELDao2DheZV4VbYHUYf4H7F
 9htFfkLs7dQFyFRa/IdAbcghhePB2DbsTs4pG3qQvWgfr8v1/2zmiMQbVBk1JaC2Ccbt
 eDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752273; x=1791357073;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EwWSOV+DqPtKAlyxdGK0yZ76WvmPxW5DCUJ/NpjNaac=;
 b=iV+CvLPUAwP1Qi9F/Wq5kvs+W/XUqa1hU/51X2Y7MbpzgMG8n5tih7EvlvNTl0avK+
 njkE3s6+FQkTk7tnwhtxUPjKIrJ+fgii10tluhav8ro31EfaqgnJZmoETkXjPn2EuZIK
 pPvMauL2os7Lere9NrsXHyoIqXLgK9h9au5Mu1n90CZam4mwTeJWj+mX5I2CZlDUAwE2
 wIUydx+VuAbZoYr9MRRszy2ByTRfciY3GxFbXY17u7Kr7xs8UK6x/RvkMnHcDiePyy3i
 BqCGl66rJWA0Kxc4N/mYFCnOfBFHrrpCt7a7i0kq6XLwcWwDkvkXHROUT+iHKnGaopax
 JYdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8e2AT2a+difVvmAqyHkm7oA8I88meSmF5qG+RYmTz5YZdtUtcCcoEty1uSsXrrV0Qy8KrSXySBjPh@nongnu.org
X-Gm-Message-State: AFuF++kt5Wj1HULYOls2o2vIP+XoXKOzUZ5JZiBnLWkDFXSk/V/ZIzUV
 uwaJ9aqwvR/sAmwD5jxBI5g59AHh2I6/FxD4HR/v+sq7vQVm5y7T7AVUYnlSZ4bCZB6mKSqlXhJ
 nLzXvOjb5HmjgfQ7O5RpTbjS9tEbHR1vbvZYxiX1tIJ4VpcTOYGJPhyvbZQ==
X-Gm-Gg: AYBFou1kZyiCdfTP8GDx3T+OTZFEnhCNo01FDfVRhcVh9+TtuPVMREJPvJaBb3tygZK
 tZutJX1QCuuGQPry4WlzqvYO+/lTA96jMeU95dsO+5ROdHiiX14wiyOP7a5LLXmAGI0hfM/amiu
 MP1/Y30LD/BkLAq1JCJynKt7sb6SRB868ZCitEmoTTdadr3oQigZxosTl/r1WJzrvHCgj23e8Gt
 0s5NqhWopgBmKiHdykgMghK6oRTY2lhbnXZ2GbqbCwQ15MXvymY7PCopXpi2KSv5slNahyIRQK4
 N80yEPqyFJ3IbENdiPqhuROZdmjWEpXcNMu6BnEYpQo13vz5jbbXnvZjm9LMCJlTCO8WgTbEUNW
 RwO49EIZxC3TzFhJpETzBkwKCZRvJjaK8TA==
X-Received: by 2002:a05:620a:489a:b0:93c:60ea:d0b with SMTP id
 af79cd13be357-93ca9744bd1mr65633185a.21.1790752273412; 
 Wed, 30 Sep 2026 00:11:13 -0700 (PDT)
X-Received: by 2002:a05:620a:489a:b0:93c:60ea:d0b with SMTP id
 af79cd13be357-93ca9744bd1mr65627285a.21.1790752272365; 
 Wed, 30 Sep 2026 00:11:12 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0174f9eaasm34613875e9.10.2026.09.30.00.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2026 00:11:11 -0700 (PDT)
Message-ID: <5c5bbfc2-7b28-4dfe-b5ce-91ecd74f4dd4@oss.qualcomm.com>
Date: Wed, 30 Sep 2026 09:11:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] tests/docker/debian-all-test: add mips32r5
 toolchain
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
References: <20260929212439.110454-1-pierrick.bouvier@oss.qualcomm.com>
 <20260929212439.110454-23-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260929212439.110454-23-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nDrim-C9qTKVPZOhDhJsNrQxZ6l2gR26
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX027wAc7JvSAK
 zaEUGNRN1uq269CQir98NVbR/rJZ4iG6MGyhbUu6eQhzlrUt5SB3A5ZcYCUC3H/5baut0Y9fdxb
 KQfL9VfzNc4SWCQGDmqk3+B469QC4cdmHhvQZP2WkhAv0J8zNyLWmwo2LCYSNJFAumrsHr3sDSL
 ZkPP2Htx2wP0e55EBDzzqDMuGG4Q/kHUmgBHN4p577jRvAqnRcgvY0dqcPnxRdKmke5cGz9tV3E
 JIqZa8jyHOzV0CyssL45pRNJPmXqc46coSahKYMY6A60fYhtFq7DrWQxE5W8AkTShF0vEVnhEB9
 9hiaMHmX0nvqSQ7CbZj7xky8MlR7cxrQw+dYTwAoNAcfSzh0K0OM9msUAyvl4MTkXG9oGCAWrlY
 w4hFPguksTZUIIGOoUUro+exaVG063EgOjhfbC/aTMP3VemOBHFcd9Ni/RhSt5y2PD759XTeTk/
 BjORDohOKBa+5dCeanQ==
X-Proofpoint-GUID: nDrim-C9qTKVPZOhDhJsNrQxZ6l2gR26
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abcb612 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=gPJu0pBYAAAA:8 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=zCQ_cy4jSEDB9T6WFzMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=AlIIF0cMT2hfDT4axODj:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyOCBTYWx0ZWRfX5RhNxpy2OtEt
 rvV+lFFYgYhWN4xFCtBfOe2N/nywk5ktkYjGqtF9Bi8yOlb0fVIKgOpbnyl0bfBYJaXOmZiHX18
 Mp32ly0kgUQCPNdh2+wCIiwCXpzCo7E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300028
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

On 29/9/26 23:24, Pierrick Bouvier wrote:
> For our test, we need a compiler and libc that supports -mnan=2008.
> Debian compilers support this option, but no libc is available for it.
> 
> One possibility is to use previous version (2019 or 2020) of official
> MIPS toolchain from https://codescape.mips.com/. However, it's a huge
> download (2G), and even bigger on disk (8GB).
> 
> Bootlin provides toolchains
> (https://toolchains.bootlin.com/toolchains.html) for mips64r5el only,
> which is small (80MB dl, and 500MB on disk). Since all mipsel* variant
> binaries have the same name, we explicitly rename them to
> mips64r5el-linux-gnu-*. Also, this toolchain is maintained, used, and
> updated frequently, so it's an excellent choice for us.
> 
> mips32r5el is more widely used compared to mips32r5, so we can ignore
> the latter.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   .../dockerfiles/debian-all-test-cross.docker     | 16 ++++++++++++++++
>   tests/lcitool/refresh                            | 16 ++++++++++++++++
>   2 files changed, 32 insertions(+)

Nice!

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

