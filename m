Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AB3C43602
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUv7-0007AI-T0; Sun, 05 Jul 2026 18:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUv5-0006xw-W2
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:02:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUv3-0001TK-Hc
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:02:35 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxaqR2716420
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l+Cb4Du/dcN++8nK3fDGL9BijxWyWk8X7pjSAGD/v30=; b=aMHAHRF5sn61ieZ+
 jG9oNVEVXmkZMszRzoPGI4purM8yhS38yBCfGkUnYINLwn9XDZZjf8oFrPebCrC6
 Wh9U8fCSVY9gArKrO1oLoG7I4v29bSGjvk31IWPEvuUKfVfuUCCB06gjf126xn0W
 U7PD3RGH4Z90faJGsBxygNlVHumLZzoLTZbr2Ns4EwTrIvX4qRKKAv9ALV6rAivH
 kc6FnaWqSi192MXS8aBvgu+KvAijGusR5lsQgShLPkWeChgZkwciNY95AhIeNU7t
 IA6yZSSmE37AD8wk2+khtgCbs/sDFtwzTDOaO6lWEFmx/G2iPqRL6xA96icmFkwV
 9UevLQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6txeke1r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:02:31 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5bd797e447cso3560847e0c.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288951; x=1783893751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l+Cb4Du/dcN++8nK3fDGL9BijxWyWk8X7pjSAGD/v30=;
 b=iUj+PFNKbm68Kvr+R4+rL64u/Lfk7xTacqwzieAdcKE92poIYZP2dn6gBWr4k6SVH7
 27xUA6XRitX5ib9uGgp4NQOnH/+HuSStj48EUvvZ4heytRF+wAVQfyoH5q5ImN52p7B3
 TBInaR8dfcWbFzkEP12LB5YNCBmj/3f6V8fVpSrbDDHj7D6m/PRotqO6i/pboXju18E9
 V76gUhTFNj7eRh7c4+9cqwv4ws+z0nOuSRKed/RvDJVHW6f2uiwAxNUT+l8VyA+Pxhzk
 X8YSVjr0T8HLqDuEBL8jfg8wMZ9CwySDOkLrM24jOFvzEMBP5monf+e6PjNJzFu1fnUS
 DNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288951; x=1783893751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l+Cb4Du/dcN++8nK3fDGL9BijxWyWk8X7pjSAGD/v30=;
 b=Nd/AwVeC4k+N157+BnfojdYq70nyeu9QvXu/dg+6XEpKsUqggp2eE0J1Z7Ry31UqtE
 t9EhkulZ+lT8S+CXp3vFoKSygMddzMuRBCCWt0h/RYt9iOr6bVYEf2OA6kWqZeAmpssq
 1NctI0+t3TghZEs6U4U4/KAtmvnOJxrqDf7gwKHKgtkkswr0WWS/TWSvmuuSK1fRoq6q
 Hnvadzhv1HM4LAFpgh9yz0memmnzkV2Q+MsCLvRCQS+L2eoWYbo0SvYyzTaGT1A0Enqo
 1HgHmTGauxRqHM/dY/se8QpPXIzteUj2t8CIhoXQc/+vKg4/Pi2Lqb0kdXYXLik4rtkb
 55mw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8EZC5OkiEA3LL0vfTFkmlj69gP3c0sjTPCPXOcHuHllVCPRMDWEYRVD4mp7uLZSLJDOc/u43WUOfq@nongnu.org
X-Gm-Message-State: AOJu0YwxqR9BaxDDIOD/mMav6tuQzV2XZz18n5vnLtMqU/qI2VFTM+wf
 EspYwaKY3RrKoGpDvAf3Cq+QUeEcrgQbxGsjeU6n/52itHwGJG+9ObwGhE4cu4jgVmMsEQjudf8
 yZm0h+MclXkeleaebvKSygV2jbeKGEOgk+bN+zXer6n4CbWD/UBcvhB2xUw==
X-Gm-Gg: AfdE7cnEhBFd2MV1EM6MdNdf6My3AA0T/wdrSf7tZyGl3eLUzP/6SGROmAwJQ0C9LKO
 +Bmh8DV+8YCOCBcC4ByDwbH8WX3HSgfKIMK63ptYIRBkgFBQ625wgU2dj4cMEKC92Wjew1TFOas
 cAK5wVNOt2w1NNV8lxMeLFqZarh9OtI1Qfk+U59OjNquDq7Mrt6jIqwo0cobjo/JJ2d4tAH/h9p
 XSFcFv9j0idbTd4nIAPaNIRboxFSXWTdbcGvJMTe+u8epiiBZiSr7Wp2LhW5Dqw4vUsCSAACsZr
 TDuLMoCrGwL/uP0GKXHb6AmO12o4mwIQUowzmaKSUgQMp2FD5GcCQ5rjBGd7JOA8s/TElBgU9M4
 re/WZbKzS8exXNzonS6tb04vOQz5oCzN8v6EtCS7ivLMZEtXcdelsweg9lgBhlA==
X-Received: by 2002:a05:6122:6610:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5be101fdf17mr2943718e0c.7.1783288950820; 
 Sun, 05 Jul 2026 15:02:30 -0700 (PDT)
X-Received: by 2002:a05:6122:6610:b0:56b:9b7b:83e7 with SMTP id
 71dfb90a1353d-5be101fdf17mr2943667e0c.7.1783288950234; 
 Sun, 05 Jul 2026 15:02:30 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c637bc21sm568891265e9.7.2026.07.05.15.02.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 15:02:29 -0700 (PDT)
Message-ID: <942c974f-3b7b-40f1-a5fd-75d3432aa384@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 00:02:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/46] cpu: Define BreakpointFlags type
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20260705043725.1373137-1-richard.henderson@linaro.org>
 <20260705043725.1373137-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260705043725.1373137-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfXzCPvoQx0iHQB
 oh4LZk7rP2TCEODjqBmaCGEbc4fRhbvRoxmSbW7CLGbCIrwtBTsUZXhxmjn3YEmhw/zf/QMx7JF
 DqpU/Up1HJxxGp+W5meKvZ9Q+FiK8S4=
X-Proofpoint-GUID: XKHV1adXu2G_qqhvFiw3upIcl6r3MNZt
X-Proofpoint-ORIG-GUID: XKHV1adXu2G_qqhvFiw3upIcl6r3MNZt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX0vrRa+eBNbtO
 a+rapF8AJ8i0MlpXThgDPinW+8wD4bGjnZ3DRnX7Q9/mzCqBnzpmFiBhjgpmgoLYCKSMnNIxuT0
 SjBocePDy1HLAFBhfVd+pEIPgI2/+HfrLdFxCXwGJCiUsyqra5IVunbdYcLKrtsQBYqcWisc6d6
 gJ6isbDzUfDqECmW/jY6EfqgxH3DraLwxHi5evwAgHHwp5rm6s3IEHt5BvDZomnxUjS/q19R0Op
 ruIAyWftHgJbp3Fd5gCwDGiy/AQCNIKOG3fn17Dw/e1W0nbPHH97USJHPZHyTqf7uIQnL0wNRRx
 uSSwoLSjUUkLtvIdIzQ6hFHgkdGa2qA7E9lM77wisZm7I8+USvHMYV2TAAiJgK2uYNnYBsYBkk4
 c58HurNxMdN/+Btx90OclElxUxP2xsTe9X72WEC0Zl+kxAmMrQQ3nkpmuobw9u8xfDxNjcsqNyx
 ik/LeKWaeVx7uEL4mCA==
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a4ad477 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=6XGGRaPhJGb0HrX91toA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

On 5/7/26 06:36, Richard Henderson wrote:
> From: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> Use the BreakpointFlags typedef to better follow when
> we deal with breakpoint flags (BP_*).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> [rth: Don't rename mask variables to flags]
> Message-ID: <20260630220100.1289-19-philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-ops.h |  6 ++++--
>   include/exec/breakpoint.h   |  3 ++-
>   include/exec/watchpoint.h   |  8 +++++---
>   include/hw/core/cpu.h       |  9 +++++----
>   accel/tcg/cputlb.c          | 12 +++++++-----
>   accel/tcg/tcg-accel-ops.c   | 10 +++++-----
>   accel/tcg/user-exec-stub.c  | 11 ++++++-----
>   accel/tcg/watchpoint.c      |  9 +++++----
>   cpu-common.c                |  6 +++---
>   system/watchpoint.c         |  6 +++---
>   target/arm/tcg/debug.c      |  4 ++--
>   target/arm/tcg/mte_helper.c |  3 ++-
>   target/ppc/cpu.c            |  2 +-
>   target/ppc/kvm.c            |  5 +++--
>   target/riscv/cpu_helper.c   |  2 +-
>   target/riscv/debug.c        |  6 +++---
>   target/s390x/tcg/debug.c    |  3 ++-
>   target/xtensa/dbg_helper.c  |  2 +-
>   18 files changed, 60 insertions(+), 47 deletions(-)

Bah I'm just noticing this after addressing your previous review
comments and posting as v3. I think in order to avoid demotivating
duplicated work I'll merge the first part and let you manage the rest.

