Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAFBC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 06:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weoWQ-0003yM-FO; Wed, 01 Jul 2026 02:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoWK-0003y8-Mr
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:34:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1weoWI-0002C7-NK
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 02:34:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6615lIAc138684
 for <qemu-devel@nongnu.org>; Wed, 1 Jul 2026 06:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iCAMIuR+JqZRq8lrovhK5NYiZ2LTW2jGzDfhPWBG7Iw=; b=IL9cvldqtzW2fVfF
 x1Nism00DTPeRh9N4NUDz3utKmyxGUXz842aOnN5omWQ3YnhN4/RcGSFG9NCiPrx
 NXobE2kBc6V4wQXMWM/TKBpbbBXEUJEKQM27cTtTKmi3FdEJQbQn6MVhDmBhhLdx
 tiC/IazafOHppMWGW6rxl0vJIDskJ9KLQUWVEaMCXvFU5MVL6ETnPkWH5IqmbX6G
 0cGyTzpkBP4lb8oB0gjMQNc26TF1iwBBWZozStp1/ekb1yqtA0aeiealS5w1XjoO
 hdsFuJOj/W9wsml7BNVtklD1ExX28cUpl77H81Y0T8sAW8ZaDYBy8i8rxppzdcAf
 cgbRJw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw2d70-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 06:34:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e62e3459fso43368385a.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 23:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782887639; x=1783492439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iCAMIuR+JqZRq8lrovhK5NYiZ2LTW2jGzDfhPWBG7Iw=;
 b=A/ncv66H+oZLZxl0uk4NImI+4QTY087q/xLMfSOr3ZRkF91F9Fw1wnNr7CVuH/gL05
 /3gJyR2HOaFDtXMrEa/a/d58tzmV884/VLv7N3ufPYMIniDyG8+N1A5Z5QlaLAUgn2uG
 7yHXalfeyzUaXXnuVBeroVlbmJB9nqPH7Wrr+conSW/8Cpy5vPLuVpou3rAhVCr9t0eh
 wgoKEZfPXhVX7RqQalbkpojepUy7pkLtelYNntsEFk1Ty/4vG2IesLYKn382i8fmDEDE
 juIzNUZPf6pPLPX7TM7ps7ta+jJ0uGOMsBKKE4xGAa5pyfwh8IBCXuXS+Kp/IVkT2eRC
 KVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782887639; x=1783492439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iCAMIuR+JqZRq8lrovhK5NYiZ2LTW2jGzDfhPWBG7Iw=;
 b=ZgyukyLuKfApQRFJCGuZr84icvBaBfIU0+wqXPYKFW4bKnT3NluoOAS5yexXPCFSGd
 rW8cBVTSMd9Eb/XCwL/Y5yUMAlYKlsMtyfgaDYXyNrk2yeVGzx8KaEI+mrhQzUyskF+2
 Scp8k3wlHEXEAJ7Lz1kIhG2k7fxFKw8r9h9MLH9bIQ6y9BxhmAE0aCct8IMO6fnVb1UE
 hw+w3EW8arlgVMYCp1YCj5TzrQFvyl/U1D/YmwFFhpmUsXfvrniaA+mC2CbYTXrCysV7
 O2eubxUoYIAtPS22/UUPn5qAvIneNU7r+aeeREX87BAnQ6OkH0rEig7FylpIOCYKgzLq
 L/gg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9JzC2fcQTZe+o8yJuu49BsKyk75zv1nChJxTkBJQlsTO69pJ7DM1jbq8E0KqXwGj0krLsWKHtctX0G@nongnu.org
X-Gm-Message-State: AOJu0YwfKRgT6V+0HY2gO3vMpiWNMOuR2cs6AmGdCgrFuWK6I+Xu99gC
 vFSfT7PBSGNW/Z1mqFaLFvUKPWhsA4biDcZmv+fDIcIyoTjHwaT5tll03lJYmb12HYq1lM8iw3d
 iwBRJSD7qpUcsnkB815F9B3P6f+3pvigYQJhP4sni2u9aFhGRF8H6jYzahw==
X-Gm-Gg: AfdE7cmndUWcUtWh+h9qa65ySeZDQFrx6p3gMw669yTtOpXhu5vzYcSu9uy1rrSahNC
 QxawNEoqrxq9ilUdsUNvC3JHo4qf5dya5lMSeCzuyi+oJ+HhsMJmGyVtrTBmRVg3n0Ki1L3dAY8
 dx40huL7cFqsuthvtsGalOWzyzNF+00hA1cUBkTpGMoEfA42jPwWXK4JnO054Mj8GYufhqo3Z+Y
 pGOa2fU6fAAf7axy1jOz3ja5EHuTpFTLlWtZL+Irlu27QKIGJHw27GxfBt+r5KA0w2iQQHeENuU
 hwQ6l3H34JWsk2nbvpE114cD99LRGyH/rkGsXZvxPzCjHnb4fZDJ+/LcOSltdN5qbBpUD4HAzZx
 1VGp/wUkWsl/L+drljRGwhTqvX6e3u18kXhiTFCt/bEBZx5+HdXDu+Z8HIRg9gA==
X-Received: by 2002:a05:620a:4554:b0:92e:573f:c2 with SMTP id
 af79cd13be357-92e7851d814mr47001985a.72.1782887639355; 
 Tue, 30 Jun 2026 23:33:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4554:b0:92e:573f:c2 with SMTP id
 af79cd13be357-92e7851d814mr47000385a.72.1782887638929; 
 Tue, 30 Jun 2026 23:33:58 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-475641e4cdesm15024252f8f.13.2026.06.30.23.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2026 23:33:58 -0700 (PDT)
Message-ID: <eaccbbdd-98c6-4127-87fe-4340c896e368@oss.qualcomm.com>
Date: Wed, 1 Jul 2026 08:33:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] accel/tcg: Pass CPUBreakpoint to
 debug_check_breakpoint
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: shivangu@linux.ibm.com, qemu-arm@nongnu.org, qemu-riscv@nongnu.org
References: <20260701030443.1382447-1-richard.henderson@linaro.org>
 <20260701030443.1382447-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260701030443.1382447-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a44b4d8 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ld03FW7sFlhNYB23blmJUsp_R8Xd0NX_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfX865zlQgoYoB1
 a+GsEAcmkwJ87512PQAYQeW5cCfQzJCwF5P9PTrrq1gN34OHACQQMmlafk2yfHM53UVmYELqKly
 CEqbLvCVNuX9cmMwcc0Fd3hnPwimcRw=
X-Proofpoint-GUID: ld03FW7sFlhNYB23blmJUsp_R8Xd0NX_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA2NiBTYWx0ZWRfX4OpAF2Gd4vdO
 wC23ifKdVm5gXbHI1cwqEAflyBmumk/Vp0MkxlKr9bkdXupLbxgCpE9jZQOFMl1slJDPmRbnJu/
 RICp6fqKZizs7LzA/4TRoTp3b/XRWZ5IzxQ7E1GptTjLH7q+FVKlHJxc8uoZeLvAL59iCKZoq82
 rXfJKuSKNocTWfl/8tcsVfIMdnM7Kv1btGiKuC1VpeVA8j3c5r16RDBztXUq+E2vqF0X8noF35/
 qdMnbT2RLleVPRhAt1ilGQ6n7YcOSurpA6Dp1F9QKyJ0tzsi3miWhZc1h574G+elzVPppIZrB5V
 8hYyo8XSfb72ITN7uDq0oW/vd8rmX9krw7pJ0KQyhRRCq4YJ+y480o1d8I8mB4BN41kmXB/rnqk
 bQbwoRUnMl46814SfMV7Iqib+5Rr6ZZ+K2LQvQRvqEGZGdEZbm/RuWByHd7S7kxMyT+Fc7lKIgP
 //rJAWhFcxkR5Z1+//Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010066
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

On 1/7/26 05:04, Richard Henderson wrote:
> For 3 of the 4 targets that use this hook, add the argument
> and ignore it so far.  For riscv, drop the loop over all
> breakpoints and use the new argument.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/accel/tcg/cpu-ops.h  |  2 +-
>   target/arm/internals.h       |  2 +-
>   target/ppc/internal.h        |  2 +-
>   target/riscv/debug.h         |  2 +-
>   target/xtensa/cpu.h          |  2 +-
>   accel/tcg/cpu-exec.c         |  2 +-
>   target/arm/tcg/debug.c       |  2 +-
>   target/i386/tcg/tcg-cpu.c    |  2 +-
>   target/ppc/tcg-excp_helper.c |  2 +-
>   target/riscv/debug.c         | 55 +++++++++++++++++-------------------
>   target/xtensa/dbg_helper.c   |  2 +-
>   11 files changed, 36 insertions(+), 39 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

