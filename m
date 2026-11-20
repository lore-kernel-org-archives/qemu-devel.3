Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558E606A335
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=JxmFAUg0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BsbYgnQw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUHip-00065e-M6; Fri, 20 Nov 2026 01:03:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUHin-00065D-L4
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 01:03:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUHim-0004ur-26
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 01:03:41 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AK4r3BB734576
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 06:03:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2Xh4N2hLQjInk8ORhlWdQU31/zHngSDkfxM4hHLSiuE=; b=JxmFAUg0sUggEM23
 mLrVW7PJH2fcEcwkOdqakpea9VLF8LXhlbmJkSyuSP1G0s2XxINOZtDanuvtb8gR
 Es3qRwVe5edpVMoEb5Zj/w0LiJDEeB83ibKIH0V73sw4zHA50D6KBnWMm4DNIzkT
 mxnVaFtbDN3KRsKSnGT7oOH64H/PvcnmxHdJxJHkeODOzN0LlSpCY4rKp7mv3eVH
 qkhbOJkNSzEHi1qU8pqTdtBkH28f8Dv5nJOzlg8cWHUbklPIXE/iyZymoRmFofpX
 H0y7No19eIcJFKfLfOl2CQZOTmBBgcnP0++65NA4MH0Ups2d0Ymg1VSXYS8f/dFx
 rcFH1Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjtr8f4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 06:03:37 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-92114c39cadso12182236d6.2
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 22:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795154617; x=1795759417; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Xh4N2hLQjInk8ORhlWdQU31/zHngSDkfxM4hHLSiuE=;
 b=BsbYgnQwLsy3HClWfWffsgsaKZ8+4AHW1gJR794vjsQC9ogvjUT+XhZ2QVRLndF4FP
 92Cc9A5oxCt0tm4TABA5bRI90wgEhLgJc+Q3bLwFfw8re0WOtfS+YROhySe8WBxE2b7N
 QouWhdfbL8gxz72b0NVL4CtD3c1QZXtc2BoN0MEDFYmTw3eMslZIDdbpjgP+UHns7EnR
 R0q0Y+xhXzLxYbvyItgM1MxEnvp768EhbXa0W533pmeYgSFDl8jze6hRVHQvsaxZfLUy
 BBq+3fLC/Jxo4Kn5PnKZf+XU7kRCirYiqDMRsPQe/nUaSh9749WZrJwScozXDr2mEafH
 jBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795154617; x=1795759417;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2Xh4N2hLQjInk8ORhlWdQU31/zHngSDkfxM4hHLSiuE=;
 b=FuR65dW+sK36+h8EBRMMfDnwoZ93oCZ4wmWWhR+8rAf5e7hbBrQXkSd1bcARjZygyu
 x8PQRyFjrMYi9Pb/Ie7i4l+VH42U/uNJ8GWZ6AEm/5xxnQOf6EOmBO/eLLxjRtcmFAmt
 D64L7LOWz/mat6Pe90NawuKyGut0sBiwfh3oz5eI9R64WQhcqa37RQ1X78Hdz9mBO9px
 Cm+zz989UrIg6yxc7J/53DKCXyxTnmqZIfBI7enwAUp3xfO1XGimeNeevIVngQczGQ9G
 7xy3arWjJ7ovBxLRIa+1L2BFwA3ThiVmyjyXSEvtG7JL/XAAMxfc7CBDh5n19G9OSx3t
 GuIw==
X-Gm-Message-State: APuU4Z+eEAjrhUA1hEk14FPkdQEze3LAO78mC6Dclixq8zAFjeMc7hY0
 eVLeqXs0qg42jMncfMDcS1eSTuEwIqY0FTWxJaIecOyOJXkFeh2GHItZYj/murnF6EtCXFZKrj7
 HS0oFkUS4uzKzugRVqC+FwNcFHxnfVKpw1YsrVEAPMub5Bm611QAM3ZiTAd1za5jMIL/G
X-Gm-Gg: AYBFou1Vc4ZiXvxgKQ+D7c1hKKfFqokDLSA75yIndQnaoLlIedc4Px9OTaUcBSp1bN/
 aycjtT0tRpYlnRKE8G/UanNBLNNTfHDSNpcIjiUaHHgipKsAIs2FgDDwBSSk57+F07F1a4PsMXc
 hdw12WY9clbiFYBJ0Z/IdHec3GE28dJ6dX1UC9qae7IoYrDHvt1iNY1ty1+ohkvIdpDnYPFugCp
 NiwfxFu/l0O4n7kAOHxizqYRGemGlh1rdHG5Rtm2FcyYyA8BRU/tWQAsSyYXKxtc/f5ufzLzE2m
 l0iD5BxeAX/31Iq17ZN8tEez4lKsoC2sGjMLWs17kzq2KpyRWMqr8i61bHXIpqziHXYOI2BD4il
 bBtvk59w3XGQA1hlHI0TPaV956/p35PYGp6Q0lu75y8OZCVBYLk88SloVG7/BqDLLTgSljGgg1T
 B9j5RxonI=
X-Received: by 2002:a05:620a:4403:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-949ba7e2b4dmr354593385a.4.1795154617263; 
 Thu, 19 Nov 2026 22:03:37 -0800 (PST)
X-Received: by 2002:a05:620a:4403:b0:93c:7f48:8f46 with SMTP id
 af79cd13be357-949ba7e2b4dmr354590185a.4.1795154616772; 
 Thu, 19 Nov 2026 22:03:36 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf629dsm3240037f8f.9.2026.11.19.22.03.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Nov 2026 22:03:36 -0800 (PST)
Message-ID: <0a1ac3d2-b0ca-4f7c-90b7-0b6eea794b79@oss.qualcomm.com>
Date: Fri, 20 Nov 2026 07:03:35 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] util/qemu-timer: Honor sub-ms poll timeouts on
 Darwin
Content-Language: en-US
To: qemu-devel@nongnu.org, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Joelle van Dyne <j@getutm.app>
References: <20261119233451.47453-1-philmd@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261119233451.47453-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4gykKILYI0CFI4ytvI0jwG2_Yv1ej4pz
X-Proofpoint-GUID: 4gykKILYI0CFI4ytvI0jwG2_Yv1ej4pz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAyMyBTYWx0ZWRfX3+dOO2tHgZYg
 9ibZi+WDKSCi4sqivkH1+++O+l5lEOTEVOhnfY0lrGrADdsY53/o37HZJum3sQ8JR/8jen/llH1
 E4iDBBNenFyWRqPBPQfeHYqN4b/KlbyrPfI+DYRsLAAGXTMSKdcryIy2JUf/8/1EmiEmoN2zO+s
 zLyovZZBoZRqfPM0cmvSfwdwx0vn0cLIWk4nvS7WxGFO+tTr8M9KDcwJyW/G1mqc36CpjcNrY8D
 EYRUzz/keLBWG6sGRmkPmgNMxwmMxSAh3FQGXy6qQ5QdErX+ZJqcWaVhzFsuBHa/yMdtXoiTpoo
 Q5xEvWyJIMtMxU1cY3qqjycK0QBNZJyHuQVH5XmOgCow9dUSAgA2voZ2EYR+1pCKAJ4NdtsMYL5
 TnVhcFh++35NPJ5/quB37eYqx9WBurgbYP1nZOWMAQ0hRN0o5b2wYQIyQomJ1AW4lnYZFlNrqos
 i7+AaFpJedFpB4tmetA==
X-Authority-Analysis: v=2.4 cv=XcccX455 c=1 sm=1 tr=0 ts=6affe2b9 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=seKwgcqWBtyr1Y5faxwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAyMyBTYWx0ZWRfXxC6nsBC+VXDT
 Gtfq2NpPlE2XUfeVzuD0+/GbM6lSHBMZFGkFQfvY5VMDAx9Ty9ZRs47/4U6K6qsvnrGJTclvwGp
 5c+14AwxmHjBiFSx0ihd5m+U8LlrEmA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_02,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200023
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

(forgot to Cc Akihiko)

On 20/11/26 00:34, Philippe Mathieu-DaudÃ© wrote:
> This series corrects a long-standing platform limitation:
> qemu_poll_ns() promises nanosecond timeouts, but Darwin’s
> g_poll() fallback rounds up to milliseconds, making sub-ms
> virtual timers fire late. Fixes the observable behavior.
> 
> Add a Darwin-only microbenchmark used to compare wait
> primitives and justify the chosen approach.
> 
> During the final sub-ms sleep, descriptors are not polled,
> so fd readiness can be delayed by up to <1 ms. This is still
> much better than whole-ms timer overshoot and avoids busy-waiting.
> 
> Philippe Mathieu-Daudé (2):
>    tests/bench: Add macos-pollbench
>    util/qemu-timer: Honor sub-ms poll timeouts on Darwin
> 
>   tests/bench/macos-pollbench.c | 290 ++++++++++++++++++++++++++++++++++
>   util/qemu-timer.c             |  27 ++++
>   tests/bench/meson.build       |   6 +
>   3 files changed, 323 insertions(+)
>   create mode 100644 tests/bench/macos-pollbench.c
> 


