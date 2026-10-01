Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95900CA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCOs5-0008RU-1v; Thu, 01 Oct 2026 18:03:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOs2-0008R5-Fd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:03:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCOrz-00023p-V7
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:03:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fsj2h2886451
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:03:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oaR3IGNJcT1AjMMn9//RHSYx8SbfRu5QiyRAZ2wHIvM=; b=OoegagLWVo1Dctje
 if664/GTLfECLA1xBpylMrEelEoGt83BHibDGdTszT22EacmjCStzwapDhZuQaEl
 12Mr7MyLggnp6fF4/RySiKo6FOMsCMHDa/C8Yg+9xjMFcSqoqqKPsXP4hMVaPrHN
 XaDgDLSB8Rsvh7LMCMMyT0PrR3gzlgomwuewgzo/LknzAeaZPZ5Itu12EkUC0lTx
 kisUHvpN7U5chMmKqeThx4UJPDaz+t1ZW+I0HuxqndtKnOhHKlflA7R2nlkX+M1J
 LEweKjSHk77B668ei2iH78wWEs2ToMJqmWfOkYr4otCTgw/PcXPDInHWh4pDON2D
 thU9Mw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdchykf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:03:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so7702516eec.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892192; x=1791496992; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oaR3IGNJcT1AjMMn9//RHSYx8SbfRu5QiyRAZ2wHIvM=;
 b=E4ZHYepksGKpH1PcIPoHQCm7H3HvSLmY1jus+sju+eIsTq0e4LC5E/BpykcHvnU4zk
 rYxzm/8PK2wvllk4UkMD2e+YBCP80Sqr+xSgRyEz0xr22ay4KT+DoitfUwrHEa57NZC1
 84uzrs1/4RWA2JljPkAiiJjPks2F5JtIhjyRRJ0hXjAtLMVL6bb95Nx326ayzIN44vtX
 0e2IDjPKhAw0198kEzYcwxifJDSxPnHpnSktH1dSMM6t/SHn7FivHDcGhqW7W7bXwpYV
 Vw1lgyOtUT2fzgBDbMN2+qXsv0qtILlPe1boLUw+xNQkG4h6A1VNuC6ieOUEfnnsb92q
 vrHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892192; x=1791496992;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oaR3IGNJcT1AjMMn9//RHSYx8SbfRu5QiyRAZ2wHIvM=;
 b=gpi5SLPDL5RUUwzuLH7p70vQsRpJeYMaCGUFNwU+HczfK/hpt1lX4IRgRtKH3sPio7
 I6nObmmRGypvF6jP7FsBk8Q31e6Guga0rsotPUAIElwjzec9NmPwbLpkaNcG+4raQ5s0
 goAF1MUXgF4TnQF7ynh6aYXV4TXMJWhMdD5R5hS9hmC7OGep+t9RwPERLNnmpro/8yPu
 HPi4wGANRlhWMYFA6XPR9uSZGkv6vGIdoRy1L4DU1cjs0jKCFCi2rdDt1bjcHYlx1ltt
 EdY6X7v1X+nKtZ6F3DMaJoWHZDibfpbN5o38sqfjAX2aI9vl9WCLS7GhoB5iEjKzQ17K
 bYng==
X-Forwarded-Encrypted: i=1;
 AKwUvBwzVa6wDKhb2W2A1FTXTEqThiCNwARs6fel2s+IfK4dYZXsCanpo8k3hbGPsBi2tqXUwmbQRxq3C098@nongnu.org
X-Gm-Message-State: AFq9FYK4Y4K9JlkaOJaUbIo/jTLqqziz+5WuCfMKsvVZNSUxPHwWzr7E
 ZPHijZcqAbPgNuP3IyMUnz58qq7iKbsZJ4ncPtfZ2knFFgxXFCxQL1raczajEvtOId45MJvH4YP
 q3AXgvB8hsCxMpt06kfbv2G75t9Hhgw944sN96G44BkWAfi/EPUbXpcY5dw==
X-Gm-Gg: AYBFou1FxR/HY/LnqGhZDoE3G90l3aiSFA+xpwWLL9jcA9N4DcP/JIDjz2aY50yvLpR
 JCG5OgdjIKgcYLP3k5l7wrk4h0yAav6vz9pTobY47Mm/QXC3BNhUSebC0qcXKwyxmpWV6MKm+NW
 iXkUY4DySRwdwpIxiIHT54rbZd4bqSfFqCCb57v+HGX0fz3BMBfqqaPdXP/vve62V/rDqMIlWob
 QE3hjr3a5gbuueao4xGpAHzaKCptGwQ3P9rnW8Mc+Drq7DeCvBCQpwxXYDH+VoKy539JQ+WcjTy
 h3nF57qMv5QWUY8/o1maMvks4CIn1qilajurzWa1yJ5KWKkC9jykFOQpCRWmGeUAujfvQMyPI7X
 ME9IsJxiJFqJheP8ssJRbvBhp89hPs4Tjd1guilzvhnESb/1Wopj4qCeYUakWeP0Qz28YAA==
X-Received: by 2002:a05:693c:638c:20b0:342:645a:5cf with SMTP id
 5a478bee46e88-34f14f2b9dfmr725228eec.1.1790892192032; 
 Thu, 01 Oct 2026 15:03:12 -0700 (PDT)
X-Received: by 2002:a05:693c:638c:20b0:342:645a:5cf with SMTP id
 5a478bee46e88-34f14f2b9dfmr725191eec.1.1790892191372; 
 Thu, 01 Oct 2026 15:03:11 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f984e4sm1014418eec.17.2026.10.01.15.03.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:03:10 -0700 (PDT)
Message-ID: <879d959c-55db-4552-b5e8-565ebb7ab559@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:03:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/18] single-binary: target/riscv, compile subset of
 compilation units once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 5ENTVArExgQMSmwnh3HpBlhYFsGwG0pU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4NyBTYWx0ZWRfX1bJqoqfZLi+1
 RSmwIW9/McpHI6q/RFpyzvS7Z+6ZIkfT9nJURw6yxf4GDWdcWBO5bwel+tLo7H8qWYxWZosg9bD
 PWygi8sfzsza5Ea9O4dXCyX9SN1yCo0=
X-Proofpoint-GUID: 5ENTVArExgQMSmwnh3HpBlhYFsGwG0pU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4NyBTYWx0ZWRfX8Nwzm3qtk5xN
 xsD770BqIiADWWCSzxdX1Oorco3SUromtZCzqGSm5gKO57kzDp26y0sw45is/oqbXEFnyoGZI7f
 bmRhA+eAaIRF0pwPGKGiQSbjfi+aetnZbOeEmkVNuQB2D2wxbSfkJlg+n3+3O4/+DSeuWwN4eEw
 g99ck15w48m3AxT7PidI/1AXyiuSffakci1ZgfsKejwPwy41wLKjmmbEh9JaRGKBobVLCBkDupI
 0cfy17MBuMA4WHmRjDg5k/5dt7ObNAwQNLG56uQCpv7jC7eTgWgSp07CAHdMRrJypEmvyljw3kH
 BfeEFzc1Aqnzny92JB2OPW5VdoMJpODrcIL1atBXMHpDjifR8JqpjldKJCFxiOfKWTpfTYGT1vR
 oKJ7xATI4OY6RooHmrjfBd05VSRZrEGHcrdQ5bNokPIbR9/SjS2WfGyFMyP6UgcMB6Vv4ockHHs
 gSXrbEc8UM+ytQA6KKw==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abed8a1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=U76RVtYcYMR_ImNunCkA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010087
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

Hi Anton,

I wanted to check test results, but unfortunately, based-on series does
not apply anymore. Would that be possible to respin this with all
patches (including the based-on), so it's self contained?

Well, if based-on is on the verge of being pulled by Alistair, this can
probably wait for this.

Regards,
Pierrick

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> All compilation units which do not pull in helper definitions are
> compiled once for system mode by widening target_ulong to
> uint64_t.
> 
> This series is motivated by the fact that riscv64 already handles
> XLEN == 32 as a subset of the 64-bit ISA.  As such we can reduce
> duplicate compilation units by moving towards riscv64 as default.
> 
> If anyone more familiar with riscv is aware of differences between XLEN
> == 32 on riscv64 vs riscv32, please do let me know. No behaviour change
> is intended compared to riscv32.
> 
> Based on: 20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
> Anton Johansson (18):
>       target/riscv: Make internals.h target agnostic
>       target/riscv: meson, add user and common system source sets
>       target/riscv: Move pmu CSR read to csr.h
>       target/riscv: Make debug.c target agnostic
>       target/riscv: Widen CSR ops to 64-bit and compile once for system-mode
>       target/riscv: Runtime CPU registration
>       target/riscv: Runtime register MAX and BARE CPUs
>       target/riscv: cpu.c unconditionally check larger MXL
>       target/riscv: Stub KVM functions for machines.c/cpu.c
>       target/riscv: Compile cpu.c once for system-mode
>       target/riscv: Compile cpu_helper.c once for system-mode
>       target/riscv: Compile tcg-cpu.c once for system-mode
>       target/riscv: Compile riscv-qmp-cmds.c once
>       target/riscv: Compile pmp.c once
>       target/riscv: Compile arch_dump.c once
>       target/riscv: Compile machine.c once
>       target/riscv: Compile time_helper.c once
>       target/riscv: Compile monitor.c once
> 
>  target/riscv/cpu.h                  |   1 +
>  target/riscv/internals.h            |  31 +-
>  target/riscv/tcg/csr.h              |  37 +-
>  target/riscv/tcg/debug.h            |  11 +-
>  target/riscv/tcg/pmu.h              |   3 -
>  target/riscv/tcg/vector_internals.h |   5 +-
>  target/riscv/arch_dump.c            |  13 +-
>  target/riscv/cpu.c                  | 259 ++++++++-----
>  target/riscv/gdbstub.c              |   2 +-
>  target/riscv/kvm/kvm-stub.c         |  21 +
>  target/riscv/machine.c              |  10 +-
>  target/riscv/monitor.c              |  45 +--
>  target/riscv/tcg/cpu_helper.c       |  79 ++--
>  target/riscv/tcg/csr.c              | 736 ++++++++++++++++++------------------
>  target/riscv/tcg/debug.c            | 150 ++++----
>  target/riscv/tcg/mips_csr.c         |  12 +-
>  target/riscv/tcg/op_helper.c        |   6 +-
>  target/riscv/tcg/pmp.c              |  19 +-
>  target/riscv/tcg/pmu.c              |   9 +-
>  target/riscv/tcg/tcg-cpu.c          |   8 +-
>  target/riscv/tcg/th_csr.c           |   6 +-
>  target/riscv/tcg/vector_helper.c    |  64 ++--
>  target/riscv/meson.build            |  18 +-
>  target/riscv/tcg/meson.build        |  21 +-
>  24 files changed, 826 insertions(+), 740 deletions(-)
> 


