Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA899CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:33:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXxF-0004lO-CD; Tue, 13 Oct 2026 04:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGXxB-0004kH-OU
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:33:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGXx7-0006Yz-OD
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:33:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8WbTR923065
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 epREFiIlJjP+MEMRArcN3bQyVsTI4sgO/LKcRgG/N/Q=; b=m4IdoRAYtD0Bndxe
 X0zxtsdSYWvekwFWs8dmAXb2U1Jky6+2jnMwerYGIM4DWTcXrhTHvTTCCiEHbEqw
 edd5Na/70/jvLmFlB7Vk2udtrrgMKZRTPWtCTrZ/8PEVPreZV5eHFFmp7gP+Omww
 L1/2XSFnmVl0Ji1dKxMZZ/IzYkZzSwUN6J3jgRus/C95VE53WWT7BmJ3DwXl6Of2
 6k8AIXw6qydKgghIhK922+nyxt3LcCxElF5TknDPK/BXevvCaU7ISUl4NMu3QUh6
 TXTTNMUsNhw+oF+J7/ZfSWn2xBLUdxkyGWECaSxO7Tz6LNpX/HFvIYOGvQ5yOUi3
 MbaJJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1sy00-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 08:33:37 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53514fbd4a3so59636291cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791880416; x=1792485216; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=epREFiIlJjP+MEMRArcN3bQyVsTI4sgO/LKcRgG/N/Q=;
 b=a3B7UM2EtyBQmL9/y8MxJ4DscWrb1iLV6IGBIyyc3IuaXLuFMZ5P3ZNB0UhMKb+pJo
 tjpmnMkDEcvBOhZrTcRYVyIxaU2tb4pcXI6Ah68xsZ4yd8BPMHuMG+kX17pmyYom1JFc
 myHrEjxsA00iUeNDEJUG9RuDH5eT7g+Lb2YeAS2lFjhCfa8QKNzz7+G1dIU3IgQYOjjv
 dm4BIBGqyBZJqw0DUUQdsvfhAGBengXBtBpnFo4XjBmHsZPwlvliV7D/1dfevzaRR7qH
 ZrMsZHRD4zSC9PFLS7WLlNOlHT2DL9PYjVcLFXQ088IILBbl6NQOGVKdZx9m+bsqOpZK
 0ZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880416; x=1792485216;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=epREFiIlJjP+MEMRArcN3bQyVsTI4sgO/LKcRgG/N/Q=;
 b=U6XF5XVns+8cWkDPjd8gpXYs3VKwTuKCKcWJldqhKcF80N/zGY3T8R8gVNbB07vORb
 z7KP+lLUfG7tke82rYE8otNIkcNYCKt5+SoG/u87azK3XYKrMxOgHIN0DLCSxMj5topk
 vLPzqMFY/0vnG1Z+nDDKB9uphxsBgWyzjthdlh/I8LD1IXlR7bSHg/KG7E/Iozt7D1y1
 N+rhOuHzLp3NHPRzlEpprIfgQqbw9A2j2Fm1QMz7lOP7XQAQXsx4wGSdUkPjFkK5gavh
 4bGZxHHXiriWHPAgvrGqO1cT5Q5BMBN8iwECsuH6QwpQDGbJFX8Sz3GqVQ34XGcP3uXs
 VQQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8psN5cEqpBeb+X9rgRdR9pFSqNAiddPosnSJNpWi25B52WBmub33/1qKqjoFeev2ihofrmqN8W7sf@nongnu.org
X-Gm-Message-State: AFq9FYKus0KGa85NmaU6b299RSiQC2rwIZpv+NV6PwFRyxcYonn4uog9
 ue4ES9d1ZNSBX1zntt2ysmaZcFpQ5pQgyULyC+YdkVp1o4fTJThDdV3Phr2HY/hiMNAFSNZoBe4
 IVZTpd+5G4Jfbn1IlmturgPHM2Hjul4ub9SqTHD7YNSh1pXx0/l0R8bNt2w==
X-Gm-Gg: AYBFou2dyUrgkzVqi8a0OvC1Kk8kSt4qpDG4MsOVKHVs1J45OEAD+XHBPU6tgW2qN39
 RdPRDkvwwGoJGSHLJvI6vBYuZYLFFEI/Uu8wo4isbk0qxAVDW+VFerZ6ZO0HxqJIZ8Ag+0cfjai
 xyUzauPvdZ2pyKiw0DZsN9NxugbXip94sPFMFKvPQgFUandkAv25/Q4BHPPjBo8SbCstLpqX4f2
 GtjH6PWXIuIs0zqTE/MTJdSCtdDTcH1F82+D2abA9DRt1pfkjQ06TKQdZ/6p1bl9zMp2HKVei85
 jiGXmPjzq0rpFVhh7bGxDf30PLKIFHd2i+x+W035S9pBirmhMcxZWHdPjlyLAOrJRM7LvddRffS
 U77p/ZAkcyr6n7XB+rl13czesrE5gYWXZsg==
X-Received: by 2002:a05:620a:1720:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-93ebd29005cmr1828615485a.56.1791880416213; 
 Tue, 13 Oct 2026 01:33:36 -0700 (PDT)
X-Received: by 2002:a05:620a:1720:b0:93b:d7a3:45cf with SMTP id
 af79cd13be357-93ebd29005cmr1828612985a.56.1791880415696; 
 Tue, 13 Oct 2026 01:33:35 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18d12fe04sm215133245e9.4.2026.10.13.01.33.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 01:33:34 -0700 (PDT)
Message-ID: <e47f3319-0d23-4565-ad4a-7297d734a864@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 10:33:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] hw/arm/aspeed: Use a table for unimplemented
 devices
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Ani Sinha <anisinha@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261012064445.2571633-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdece1 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=L0LbioGFXwacteMSHUUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: 9YjnyVi7XOoYuEznQwq_-zPFtSBgkrCd
X-Proofpoint-ORIG-GUID: 9YjnyVi7XOoYuEznQwq_-zPFtSBgkrCd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfX+vU2LaaIVYKl
 bNt7tPNMvDfE8JKNYOxuE921liUq4jnOLFhnFsPvSYJyFCk1TRW9m3XuiG9Je+FTlXiJlaBndUP
 fOGW7ttzxeLq6rpddd/3P2uv7c6BT5s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzMyBTYWx0ZWRfX6gr0LlGvId4y
 RnEhOK0Cf+EAf7eAmHYxj995Mqny66q2LQ5rV/v7xm1PjkGHj70pWMOS0mQ2Z50IXU+QxG9D2nf
 5O/2ilJszpoO4zTYANvC45xNd04/jZg0icV/Nlx20P8LwhW+0gc6MktmLd+RjXo2x5vwc3NZxGd
 XVckOvde9qG1TdKP6GkitbFd6SoVoAfCrAuScs3DT7jzlvJPwJnIab02HVNBH926FD8Vr24JBZz
 9qCZIqzcR6dQTfwdThSMPaJ/JaGe5oUC+mFuCOGz2ZzRttfHEeuyw8qaY5gijB+2GW8+yqJ9vBa
 IZ378IuQ7TvhNLugL7F2ar7P7NW24hGajnhjOYVh2QvPslup6lAnFi4aGBjsrDP22aaGvsFd6as
 siptc4P197nbsiOv0uONCAN8E0AfSuSiAOtRI7w3W1N7WAji2e3u5mKCrwWjafBB1eKNCVHpYhA
 y/Y+VAgu021UzUbc5EA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130033
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

On 12/10/26 08:44, Jamin Lin wrote:

>   include/hw/arm/aspeed_ast1700.h     |  2 --
>   include/hw/arm/aspeed_coprocessor.h |  5 +--
>   include/hw/arm/aspeed_soc.h         | 14 +-------
>   include/hw/misc/unimp.h             | 21 +++++++++++
>   hw/arm/aspeed_ast1040.c             | 40 +++++++--------------
>   hw/arm/aspeed_ast10x0.c             | 55 ++++++++---------------------
>   hw/arm/aspeed_ast1700.c             | 21 +++++------
>   hw/arm/aspeed_ast2400.c             | 25 ++++++-------
>   hw/arm/aspeed_ast2600.c             | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0-ssp.c         | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0-tsp.c         | 44 +++++++----------------
>   hw/arm/aspeed_ast27x0.c             | 41 +++++++--------------
>   hw/arm/aspeed_soc_common.c          | 11 ------
>   hw/misc/unimp.c                     | 20 +++++++++++
>   14 files changed, 138 insertions(+), 249 deletions(-)

Per the diff-stat it was worth it IMHO :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

