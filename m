Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCE8C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreQ6-0004ue-Kr; Wed, 05 Aug 2026 12:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreQ5-0004uL-Dh
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:24:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreQ2-0007Yo-Ir
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:24:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVg843625547
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zjdhQBmw3qU8jEg/fNI4fVvR5XhhInuIQKYiRotgjbE=; b=cpstlxYVbJ82lkCx
 EVinaB0XeHQGFWYq6NbYMV7WA0zOoXT+o6Yl45I87t8p4IQhACTZFg6gwy7ADeMm
 rUJ3YcPDwrBjLYUTxBT1/mP0/ECkWZw7WSP/mPQvOHsVOcE5zkeqZBGgz2yOSu/z
 Edf0XajbyxCb+0gQj/n4aH2+n8qSUHd5IxNux3HCDXHXrnL+Qgvobnh4OQPr/knz
 +BH0w4uR3Y1eQ/jPsGv/LZfs9w9k+iVIs4bGKDO8OZkBtBTa5dHhRqIZQB/PaHaJ
 HksDT2NZgyeIqH7PGDf2DufXOKcf0Rn7zLptu2Q2CturoZspYRyJ9qSPc72787Uk
 JjaOrw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv14wad4n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:24:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so42434a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785947076; x=1786551876; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zjdhQBmw3qU8jEg/fNI4fVvR5XhhInuIQKYiRotgjbE=;
 b=HFGsY6iBcnPq2S1ChN3F9tROmoT8K6+KVLAIa1emP2aBMwekFlkmWXbD3RVVeSufy9
 Sn8T4g4V1acICrlkpupZ7q0fV9Tt3H9jCkjnV82EI1KiKL0yF5zXIPSbRmmXGxl1jrWq
 QTgU5aGUZOlbADQhoiGTsScrA806EKPqjK5yEgV6hYMbb17X0VbVj1f4Jz1Xxinmxc2b
 Rqe//FEbs7Bc6GffftwsZCh85+bD/wXB1N9HqyuMvLpZHtdLOAL7tfIDjLn+YoPtAmj4
 PSJF5DcELCzfq23RHN48UJSvOW/XOc+KtspTto4wfVn3MxAXzKWGy8wpQX995sS4IAw8
 tDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785947076; x=1786551876;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zjdhQBmw3qU8jEg/fNI4fVvR5XhhInuIQKYiRotgjbE=;
 b=akYSJufB2+iplLKFbifpUrRn/f/ZdOlmMHoaPxzo60RNjKZL42WDGTcaJ1RV4fOFkM
 BGS3y1nvJBZac29zUxXk1UST1IEZwPifwBWsULzfSDX56VRRyYy3qQlhibVZJdr8QbjR
 ZQ01blK6DkbaujbubclablZBoPzMDpRjlIiBnZGeaa2lprkf1lmWHtwj63qxFnPtHHYk
 IVLJ7lqor9t+zvn1dC9mKKxanK6eKLkFbRE66Cjywb+PfY+AMCMUBry4cbQLiSLkIvlr
 /bZxzLc7uvdAtAjalXkeoIA9yos9OQMCgKjVCWwTEYyrrLZ2Vm8hw1iAlUumsWqC6IvD
 UyhQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGuSpyNKW4SHv2vo3FJrXld0gbfTmb1nyyG3aaOgy0Li5Onwck2rWxTPsyBdbznBeyHof4WOD4p/Zi@nongnu.org
X-Gm-Message-State: AOJu0YxnVQMtB2sZd0ot4X5Wkw8HibivwU3IU6VHq5cm11N0/zkUtUV+
 5RYjQJmTZwpLIs6jPnUP+E4JIVAU3bYDxnG+sGT/4lkncy9vN4WalpfV4oKN70tE1GSyfXdPyaz
 ceq8lHfsdmaRQbTPQsGOy7UPF3J30e8DvCjFRJ34ZFwnsQgZ/ek0WLR8uKg==
X-Gm-Gg: AR+sD12F6HOV2Z2El1v5YR5cEYmb9BRQKvv8Pm8eBQNcvewcxWrWoqoVnvFCZ0o8nJG
 hhfyTGU2jh0Vr3WNO3QM+arqyN9ceGDvy8Va7ifc5x8zZsaQYJCbJUc4vwz/SeV05EL8Ojt+iZx
 LLYwr4/vYBnai2q7lwYDvKTVaOnWNfV7T62o/eh0GBzaERWMlqsG2q0ogNVgR/axJ7JrZxSz/Ew
 RIqvQbwpY6Rs6dKyXjYxySb13Azcmo0ZMRFUUODlcqrKSqOf9dZYgzDv4pny0bXI6VZCrGUgkA6
 IhX/9vE9LdiVwm/LfSyt246MbgixUv8smEGMkujPbduTUfwaCHOu6OqhoBGeqS32R6XQxNxhmsn
 5C8LmUXeYTIdyyGgY1wq2+Sm9P8WBhx7LDod39Gm0R9usdDUtG8JGjgvP9hJsckDYclVf
X-Received: by 2002:a05:6a21:3393:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cb9c0712b1mr414294637.2.1785947075695; 
 Wed, 05 Aug 2026 09:24:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:3393:b0:3bf:b7e8:68ab with SMTP id
 adf61e73a8af0-3cb9c0712b1mr414247637.2.1785947075222; 
 Wed, 05 Aug 2026 09:24:35 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867a68fdsm29857333eec.25.2026.08.05.09.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 09:24:34 -0700 (PDT)
Message-ID: <4cc53df9-faf4-4fff-859e-820e906328df@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 09:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: don't let an idef-parser dest clobber its
 own source
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20260805140200.2710205-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260805140200.2710205-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX8BYFuMyBu5g2
 QpmL6dQ8U/PjRoTktxPZPTwXC39ppdx86azWaZZFXik/T0MdcgW0xTMrwCiza6KvvgDbCGhJ/jo
 POu2hp/E6tbHRf+8mKqJfaliv0BYSkk=
X-Proofpoint-ORIG-GUID: DBc45qdQe8wyFBhPCHFFnCKNWR9OXJf-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX4LLKauRHTXtM
 bAbJgfQx4PVYPYtCgFWJIy5mcaihOHP442D8xDJQ9fCsZ0gclq3tvsLf3z2SWjQNpi3Ouo/E/YS
 TbI4fSwTx1hWCYapmHgA5d6oButaaCEeAq2raLLnTI6A9Z1b/W73d7LHTW0zo2g6Wzu4uRoQZSv
 NRghbUf5e+mZ4pqsGHB6UqCKp/x8xaoTHMvZiceVDalKzKSPr2oEPCvLicm1wKnxsgQIKsx25mt
 pRCjS+gY+2d1F4/0uODTH+NVgVs8F1Ym5LRGOHy6GGJ7nPPDjmYqwpCG+QmIEr3qcZo9GMXOKyP
 UUY7ceIQGwusC49YB3yhwqebzSoLmnQ4jFJfg+vfgBiqdST1h0kJIDDdGzzzZg9oShrkId7FYpr
 I8mMIPfnTKM1yBY47cs88KnssZa5nhGYgRb93nJxYu87268j80GS+khbRosT4MUcIJfEJCEvr2m
 dTW0BE4rlbr3diSEn8g==
X-Proofpoint-GUID: DBc45qdQe8wyFBhPCHFFnCKNWR9OXJf-
X-Authority-Analysis: v=2.4 cv=Cu+PtH4D c=1 sm=1 tr=0 ts=6a7363c4 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=tV-7dVTNtac5_eSaCJoA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050133
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/5/2026 7:02 AM, Brian Cain wrote:
> The idef-parser emitters write the destination in place, so when a packet
> is short-circuited and get_result_gpr() returns hex_gpr[] itself, an
> instruction naming one register as both source and destination reads back
> a value it already overwrote.
> 
> `Rd32=cmpy(Rs32,Rt32):<<1:rnd:sat` with Rs == Rd is an example.
> 
> Give a source reg that aliases a destination its own copy of the
> register value.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/genptr.h                |  1 +
>  target/hexagon/genptr.c                | 11 ++++++
>  tests/tcg/hexagon/read_write_overlap.c | 47 ++++++++++++++++++++++++++
>  target/hexagon/gen_tcg_funcs.py        | 15 ++++++++
>  target/hexagon/hex_common.py           | 12 +++++++
>  5 files changed, 86 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

