Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51EB4F9EDC5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 12:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFWwf-00027V-Fd; Wed, 22 Apr 2026 08:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFWwc-00024g-2p
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:44:42 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wFWwa-00039f-46
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 08:44:41 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63MAfTsN3083125
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1SJ7BhRVaE/hKGnrzPgFuOS/a7pK7nJAVawBa5adv1c=; b=leBNe6UJ39iu4Ko0
 gUcNTlRIkDkz3348NcyzYu3mamXlP5y9HQKi1tAjdxZh9H0cLyJFtChGROJZAXNC
 jatQJMv7NWlVi4aoZfd4rq8kFmMxDRypZREPbqijRCaqEaakPAS1fvLFsCZGljYt
 H0d1glURUHpY2VRAzYtWazOwfNsnOuMnw0v65frAtR7GGXzm7RkNx7x8YQGbtd41
 RjL2QAw0b0ZApdQON3YtdPR5WCifoBx3+SddENfLO4v4+/Io7DAD6dpm4oOJfZXv
 DMwl8p1p1OAc3dWwKEVKLeOkry5+OsHMh7z+5CSTMuy+jvqoRA8q+JyErJX3m/dZ
 qEAT9g==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenmkh4s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 12:44:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e67a4f642so73237891cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 05:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776861877; x=1777466677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1SJ7BhRVaE/hKGnrzPgFuOS/a7pK7nJAVawBa5adv1c=;
 b=CiXxxoDavDLDAI5S0RDwqlSEN2oJZxxvXq+3o9pYOerAiN2UKTNbIx3T7EikeGOUG1
 KpPuUmI9i3Y9yWj/WrEeEBF3qi3C60+gX4qFRVENbNeTCeDsN+6geMtT7C6WYWYa7nDZ
 Jyh71GyolSD93kLuaZQ+ndUv4gzumXjfXZW+JOFAuoJeT1LEwJlQ8t/O9hMhay0fN4Tj
 la7rvdIGiFJExkXdPeRxVJF1/oAxoPceE0+OQnd89J+f+NBJlC+oWlfltjc7W14SHtov
 xQq8xEY6DGVOsMptwR9jJ/5BnGEgFEI6RUcgTQT4beY05yLNce5DfzjgfWMprZE+M8Fd
 4hYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776861877; x=1777466677;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1SJ7BhRVaE/hKGnrzPgFuOS/a7pK7nJAVawBa5adv1c=;
 b=nZJC7JX5iwZUxdXVcQrtPCjr7jcFMdPW6l3G0o6DQtQ6jnZQcG59KCOggseGo6p+Rx
 ZnaqkeRahWyEZCSelYYNyEaBHJxGPCNPPyHK9RwsQs3GFtGIatc6V8QcddrCYxiihgAP
 GplEa0uJyZIMFgyHpqLotlXFHPiItzj4LoMX5iiiKKSXPvEBKFmS3DvlNdTYkPE5GKxl
 kNS+/XbLTsu/Ij0ErH6DX9ekZu9G+5H2kIJ4kwWg0cqwtY7yIH76snLCKJGT3jWf1v4w
 fvUaOPljko2E8rxxGBtwiWIX7VM6/WnbiEypdKhVxeQCTKK0y7MNfyr3EjsAYAREhnJe
 lDmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/O5fJabxSQYbxu3w7HA/b3IfYAbOxcJT1i6lOe+czbnHZxPwrldmQYiuoQPyAxW4hG5cskAig6koz9@nongnu.org
X-Gm-Message-State: AOJu0YzpsQvptuTEt6XIdnDLkHKDl+QPAY9e9k6+G1ch7D+82YNFHRh9
 rWWgHfGgrCFUaF4rj11/xktpwjjekEbCgPsZ9llmnsFfRx7orR+q+fmHPf1IJQVOoj+L1ucxZY1
 jM0rRxGgl7uAWf5aFGTXqKUJo895gOfp4hTwHEz7r4z8EBYINA2+Wi9+x7Q==
X-Gm-Gg: AeBDieuSwyBcL/q95O6aoKMtNVSTdEFtEGlSqEItyFgcmbaC2Uey+LNaodiEpL1oT9R
 2fPkR6QpDQ0bEr7gohoYZc1R1/a15iYkeN2x9a4MyPSoO4hqwgryuPtPGbuwol7eIXHm4Zm9PYC
 7kFIdxM6qYqBJfQvzrFbXHVEmSbuSVEStS1QdrU5manoJM0FXEUDYIdPGMhQz/DxUS6q7vw+B0b
 D94FEatGUBA+1Mv6IP2+F94upqBlH0JlnyNUgYxjM7huy3cTSIkUz6Df41JoMeAt0VFTSxtBD4w
 0BRyCwIMT49Qr7VbN7eUy9FqpIfyDtRh8DZ/1WA4YlyUT6VUFFFC8INEHnSCdNFKDxLQwWJS5fo
 YyV51erFe1poxMHnGS8lfTkblq0EMudzw0DA7/BRF6NEM9Ug/mYy/7X/V5HeaFf8cg+kYlQ==
X-Received: by 2002:ac8:5953:0:b0:50b:3831:417f with SMTP id
 d75a77b69052e-50e36c773b3mr344393801cf.45.1776861877077; 
 Wed, 22 Apr 2026 05:44:37 -0700 (PDT)
X-Received: by 2002:ac8:5953:0:b0:50b:3831:417f with SMTP id
 d75a77b69052e-50e36c773b3mr344393391cf.45.1776861876580; 
 Wed, 22 Apr 2026 05:44:36 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac6f670sm155959866d6.14.2026.04.22.05.44.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 05:44:36 -0700 (PDT)
Message-ID: <688effc1-9ea4-4bb2-b282-fd7f290d319f@oss.qualcomm.com>
Date: Wed, 22 Apr 2026 09:44:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] target/riscv: add support for RISC-V P extension
 (v0.20 draft)
To: Molly Chen <xiaoou@iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260417104652.17857-1-xiaoou@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: bTHYFn48h7Hw2k9eVnvREYlyDSsXO8DK
X-Proofpoint-ORIG-GUID: bTHYFn48h7Hw2k9eVnvREYlyDSsXO8DK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDEyMSBTYWx0ZWRfX+dmlpOtCHGxP
 hynZv2RW3xTsryyoBt5cHHf9PTiuxWCTFmCcvrhkXsOFb5AbRx1NfAhMw15e4eRUXkajgrkjK02
 A7o636SCjJOlVbguCboeVVzoIk4KTd8ebRmpxeXWujPkT0GgJ26qA4+FpEyxFhZOiljK+x/XS4F
 4ojN4nZkMpZrqW3ngcYDoFXjh3hV8uLxEPc68yfdz6foPmfAf/Xlya+O+u9fP9Q4/sOyyHtL7ZO
 bw0WdZC/D+4A+Zh2zsEy+19XDcfkkUEdC/M8D8TUplw7u9iw3WSE07CXhNjpDXxXXbpO3sJgyiL
 oHBZ2HCw5+tWHWvWcrK7LeChQw0GlZJyNYISXddcBlH8V3JutD25CBuO5990kJzAdNU7tEmdegR
 rosQpYMm7IJ2MNo9sv9YeYTgcPsohW4jzglnUcE470WLRZ2n8k3OXt7XakbrM+PsZ8WQ7N1znzK
 diVbixMXepurAWB30BA==
X-Authority-Analysis: v=2.4 cv=Xd65Co55 c=1 sm=1 tr=0 ts=69e8c2b6 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=HIoIN3QyAAAA:8 a=NEAV23lmAAAA:8 a=yomLEbpW73c62b3guMgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=MbFZXBXkOCLWhBDvYpC8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604220121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi,

On 4/17/2026 7:46 AM, Molly Chen wrote:
> This series adds support for the RISC-V Packed SIMD (P) extension.
> 
> The P extension defines packed-SIMD fixed-point operations intended
> for DSP-style workloads such as multimedia and signal processing.
> These instructions operate on packed subword elements within
> general-purpose registers (GPRs).

Thanks for the work in putting all this together.

I did a review in patch 2 that I believe applies to all other patches:
we should strive to code re-use and avoid any code duplication as we can.
This would be a good goal for a version 2.

> 
> The implementation follows the current development draft of the
> specification (v0.20):
> 
>    https://www.jhauser.us/RISCV/ext-P/
> 
> All instructions defined prior to the v0.20 update were verified
> using a simple instruction coverage test suite:
> 
>    https://github.com/mollybuild/qemu-riscv-test-uart

A testsuite is greatly appreciated, in particular due to the amount of
code included in this work.

> 
> Instructions newly introduced in v0.20 were not tested yet because
> toolchain support for generating them is still under development.

This is fine.  You're adding experimental support so it's ok if it's not
fully tested/completed, as long as we take care to document the limitations
and caveats of the existing emulation.


Also, I talked with RVI.  I got told that this spec can move from 'draft'
to 'frozen' later this year (Q3, maybe Q4).  Depending on the time-frame of
the spec status change, and the amount of progress we can make in the review
process, the spec might move to 'frozen' and we can drop the experimental
tag and upstream it as a regular extension.  Let's see how we do.


Thanks,
Daniel

> 
> The implementation focuses on functional correctness and ISA coverage.
> Performance optimizations were not considered at this stage.
> 
> Feedback on implementation details would be highly appreciated.
> 
> Co-Authored by: Yin Zhang <zhangyin2018@iscas.ac.cn>
> Co-Authored by: Dajun Huang <djhuang_1@std.uestc.edu.cn>
> Co-Authored by: Zhiyuan Yang <zhiyuan.plct@isrc.iscas.ac.cn>
> 
> Molly Chen (14):
>    target/riscv: rvp: Add option defines and dependency check for packed
>      simd extension
>    target/riscv: rvp: add arithmetic instructions,including saturating
>      and non-saturating operations
>    target/riscv: rvp: add averaging operations
>    target/riscv: rvp: add absolute value and difference,comparison and
>      mask generation operations
>    target/riscv: rvp: add shift operations
>    target/riscv: rvp: add exchange operations
>    target/riscv: rvp: add horizontal reduction, pack, merge and cout
>      leading operations
>    target/riscv: rvp: add pure multiplication operations
>    target/riscv: rvp: add multiply-accumulate operations
>    target/riscv: rvp: add Q-format multiplication operations
>    target/riscv: rvp: add two-way and four-way multiply and accumulate
>      operations
>    target/riscv: rvp: add load and replicate instructions.
>    target/riscv: rvp: add rv32-only register-pair instructions
>    target/riscv: rvp: update to v020, add SHL and PNCLIP[U]P.*
>      instructions
> 
>   target/riscv/cpu.c                      |    5 +-
>   target/riscv/cpu.h                      |    1 +
>   target/riscv/helper.h                   |  531 ++
>   target/riscv/insn32.decode              |  829 ++
>   target/riscv/insn_trans/trans_rvp.c.inc | 1691 ++++
>   target/riscv/meson.build                |    3 +-
>   target/riscv/psimd_helper.c             | 9452 +++++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c              |   16 +
>   target/riscv/translate.c                |    3 +
>   9 files changed, 12528 insertions(+), 3 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_rvp.c.inc
>   create mode 100644 target/riscv/psimd_helper.c
> 


