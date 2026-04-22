Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA79F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXIq-0000y9-0i; Wed, 22 Apr 2026 09:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFXIc-0000wW-0T
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:07:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFXIY-0002vi-FC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:07:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63M998Yj2064805
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:07:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Es4QFZLP6J6PjPYpKyN+hXbU2c1TUpzEvCUeMj0jbps=; b=ZB9HJzRHckjSLL2q
 CF7mDnYmVf+hl4Lacs3EKRWgIImbr3QOiN739Ek57XoOB8nP5Uc25jdy9wOhmO4y
 5BivnQ9OrJ5Bn8Yx4XOVlHDbYyIbJZiBFYCU9VNwjauJDOwmHjWFGSv8GW8PiCIJ
 uZp12Aidy9vqi4TMfcDQK5yLbj/3sDdm4BmAA7dpv5oQoT2wkKzdS72XI1wjx47P
 2729t8re77KB9OgZBD1FDduiaE5nIAEmfJg/511tpDnAotsmmyXzl6vZ+mkV/bSH
 /N3i2l0aEOJUmtRsPi8Ezcp8kLDIcwhWOQGMyjw1pfyN6GD+6ot6N+qleojkeu4x
 lLMf7A==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenhkgua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:07:20 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-69499294b86so3137867eaf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776863240; x=1777468040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Es4QFZLP6J6PjPYpKyN+hXbU2c1TUpzEvCUeMj0jbps=;
 b=PA+69jhT6vZJTW9+61uq8w/sV8yFcC6UoiFED51Q54ngv/OKuzR+GxCLinBW1JywtJ
 ZvUuQfdP7Bsn/uWSRuCRmfvoNOzpk8Kon+Wv6OX4KjW1lE9920ExYN1lx46oQSPMtfGK
 SAHQumiKgG+y57zjxrrks74xY4fHm2ok9BdfEd2/3/so0mfMtFX44WsNhkhCV/xIH4sB
 PSl7Khbl4rPaH1VTzr9EF8KK0r3wnOLNNw0+hPt+3rZxvBzpSYXLpkW8+dp6zw3vCXbn
 O0aFrI3WF+g83+lQ1bo79z/dkp/DlIsA46Tu7KTq+eUf4xjSW/TF3tvlvJWR+23WA4j2
 pXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776863240; x=1777468040;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Es4QFZLP6J6PjPYpKyN+hXbU2c1TUpzEvCUeMj0jbps=;
 b=JKjoNnuyV+RfWCLpCiLx6JXYHXZB2tiWoMIHusxj+NAh4Y9x4CWr8YRcqojYj16DbC
 mOw2Xfjea5zR7uQLi8xBwqo5sAE0xLDVdusW0DSabQIXK2Lb+ulEFrD7SqE4RCXIeNFH
 QllVkV7lFm0nf3Uc04PsIEpKdkApLjmNEfs7TJJyG7ONEZVeOAkZEp/9+oAh6SK92f2Q
 CcYyJ+EV9Z1zBZoANf7Yl+XV7lYUphbKmHGzDWWBrWd2UZ8vogWFiT4LalsEyu28P/zP
 Z54FEnhnWdPmO9FpylVO+9JlLSCIPXEO8QMKCFbyWbbx3oLkdXfmoucL3+Smh/aO6vcd
 lADg==
X-Forwarded-Encrypted: i=1;
 AFNElJ820zQ/2lVr+l5cQrdkC61CJl0ds5Cs0+ofRuLIttdZ0RrGL2aG3tpe1Yg48FT5DQx/r3KKDKRgxPSd@nongnu.org
X-Gm-Message-State: AOJu0YzGph5OJ1LrQ/Bt7k/b0h34hAhwsefyRW6pZFj+IelBRN7bQAH1
 O/L9R+FQRogg8sXlPuKbvA+FjghFuG+NFYNNuwwLtfawyDZrwdtm5Wlf/PDM2LOHb6PfNkN7oti
 efB2xX+yMRUp88NPHD2cSMbCIJUoVjNaesUG/g0lA3KNXxeyps842/F0gDw==
X-Gm-Gg: AeBDiesB1UrhbW31QZnnhwP6Y578OrsMigGdH9bjYnjPvE7p3Fzi6wR3gyn5N8fsKrw
 C4bEP2QvRT6+Ee+eSL4zDQG4JhyPwMFOGByMPdhx5gFOThm/rLnVqeVjTUW6FIw7Ys+pD7ifjh4
 tRG4Werr1Qgbxp1QjaaP//z/CD2P4W9KdPhzFxEBf/zst5G0KtUjfiLMccRP+E76W3tke9IuroU
 81W4ey9Apw+Tevcg9TMW5oq5OejnsS/6cZ025DeL9QwGlYAUsYcJ1ribzBGfAMHOLiId6u81Rgo
 AO5LoEUlueIfIb8l3+yzL05bcSZaAMn+BYzsM4RY95KNbGe/Bl7vjEBBOIz7ZAY2wg9m7gXFNb/
 aCVxr76MjMh+GeKdJhjDpdOvwdEkGJwXZKmdecWahjR4y7/yVvbo2gKFpoj5jMhKhkhqi0w==
X-Received: by 2002:a05:6820:80c9:b0:694:8da7:8a46 with SMTP id
 006d021491bc7-6948da78db8mr6343023eaf.29.1776863240085; 
 Wed, 22 Apr 2026 06:07:20 -0700 (PDT)
X-Received: by 2002:a05:6820:80c9:b0:694:8da7:8a46 with SMTP id
 006d021491bc7-6948da78db8mr6342990eaf.29.1776863239661; 
 Wed, 22 Apr 2026 06:07:19 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d6ba19c3sm1322327085a.21.2026.04.22.06.07.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 06:07:19 -0700 (PDT)
Message-ID: <395691b5-6361-45b8-b5f8-35f8fcf45fe1@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 10:07:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: rvv: Handle mask/source overlap of vector
 reduction instructions
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, liujingqi@lanxincomputing.com,
 max.chou@sifive.com
References: <20260417120626.77415-1-antonb@tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260417120626.77415-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ma0YHiCKM-H26Offc2N6mD96UHXCIIy0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyNiBTYWx0ZWRfX9Gq7IRrl4m66
 87e5sgQYUOkl+RWV34gEqcbBNpHqT7Q/yMgCvBlQa9Mu30ytG4Skfmj6MSgzM1i2B5JzSlMZSLq
 ToGID7GW3LkjBYWvD+t4kUTLG/Jwkj7RlXSFVVwJq4JnnN+rhvAxrkIEWK+Hwr2+uoyyNb9lcSk
 yWJiy+mCZ4KP+LHDWR+UUujZjZcnkk52bnohU/2aeMI6jUnfv5a0GUO0/4Nh9gRkn5YiJThvj/e
 VFk7QXG9wGF28J+lvjilOXW/s9634T/SYhKy7p2l7LopXhIgnWnPaDQPpqX3dC83RPU12Jf4Y4v
 O3kbH/VIeMqOyue0Cq6sXs9VQ5w9BoSXY32jV1hLpgwAU+tfCUjb5CEOXvG8Lki6c9g661GYYHz
 HHSyKNlgxSh73ZxoeMwuGZuUdS0VF0kayuart7SsbqR04HQoGFEopNv19cIGZv1G3CUOVALISBh
 zd534XciL9hrU7fP5Dg==
X-Authority-Analysis: v=2.4 cv=WKJPmHsR c=1 sm=1 tr=0 ts=69e8c808 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=vj4NeDAX5hZ5l_44lvkA:9 a=QEXdDO2ut3YA:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-GUID: ma0YHiCKM-H26Offc2N6mD96UHXCIIy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220126
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 4/17/2026 9:06 AM, Anton Blanchard wrote:
> Masked vector reduction instructions must not use v0 as a source register.
> Check rs1 and rs2 against the mask register when vm=0.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/insn_trans/trans_rvv.c.inc | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index d9a0027e0b..6e8d32636e 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3046,6 +3046,8 @@ static bool reduction_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> +           require_vm(a->vm, a->rs1) &&
> +           require_vm(a->vm, a->rs2) &&
>              vext_check_reduction(s, a->rs2);
>   }
>   


