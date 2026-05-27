Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B226CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 13:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSE4S-0006rq-DF; Wed, 27 May 2026 09:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSE4R-0006r7-1z
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:13:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSE4O-0001Or-EA
 for qemu-devel@nongnu.org; Wed, 27 May 2026 09:13:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64RAWMrI150054
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:13:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /pLyaRPFQ+PYMAAclbvZ1wLKMK+AmMW+DX55V7GWKV8=; b=p4yXxBR+WtcIPo10
 e2J4N65tp7pNh4OfnIe8/eKqwgem3SlxHjPzA+6oG7yCcl8+V40PgkCEs69m5HG6
 G6kqRgKFvU2sNpxSxNlFBXAFL8UQxVEkm7QJQbKA+Wz0p8YduabFapYssSK9Rfql
 DOPhHjsY8eMLscLq0ovOcM4Qnu7sUsKexu0/9RIA84pKCZ6I9qQ4ersT5Zh7Y9P2
 Wz/NWWkGu5jgkZ97EGmnDYmRChtAC6gqoG3XUQV/o3BoQ3ezidIjZDZtAh/FtxlG
 oaP2d38pk0tbona6erP4ncdh2BV8unAJYC1IqrqBEQOKgRM+bX2rRwuSJkMRjy53
 vo4rMQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edxxvrgyh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 13:13:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5104b861649so28116971cf.1
 for <qemu-devel@nongnu.org>; Wed, 27 May 2026 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779887589; x=1780492389; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/pLyaRPFQ+PYMAAclbvZ1wLKMK+AmMW+DX55V7GWKV8=;
 b=Arb9j7ce94WDqkhSu3h1PDpTYBE1LgIVDLTMsSa0aBDig7QVAhv1zZwOBXxIO0QO1I
 p0+fKUKUOgwtwSnQhLov2NUjeQAhEcbXFblwqFFGjnJ8FmHbXUswfeGhKuyZPptbb/pp
 QCWbKsurNS+E/9c7y/9ty+mA4UM5EI6Jgtyfq6I3RxWlZA8dVJDGES3fUE2bUVtdO+6m
 JvkmAFlMKkVy1WPuqckvkKdUBPrGPd66TPPi5X6wQamU/cEg13pq3MTASTtVtKdotU/a
 0ZElQH2Q/FRm/PTHg0lYC4QVyEskbQh4mvU/88xjq49p7cJA/o5THN1EGa4W0ccuIE+v
 q6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887589; x=1780492389;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/pLyaRPFQ+PYMAAclbvZ1wLKMK+AmMW+DX55V7GWKV8=;
 b=EIA6+evPXHKZ76JU6NcbE4NCxxzg4zJ/NXfv/AVaNhc4M2ey1vt0+tqbRfOhfNlOIH
 PXSHOBvy1dcL+lJPdYk0GPuKv1EPN7DW2XOvg9m3kEEbc/PfZAjTIGDT8Pio+1zoFG7L
 xM9taaLJh5xix0P6A4bfgs1Vb6zZgEi2vl9W0u/SeeIQ5xM+VmKboZPx1Z3wiPm+g5YT
 W2VRyFwkbvf0/pONh8DCKonrLFXNH/sJ9JdF0rGz6YdiTWmA60L7K5P8ineT5hCvaEz1
 n4VR/uZGhvKUQ0/RAca6PDx3KnBo5mCrJe7xYh5741R4sQcmchOI7CQ66lKrGlRr/PG3
 BznQ==
X-Gm-Message-State: AOJu0YxclmFoD5BylNXU8P8q9mR5mxThYd1NWUGo7yy+BI8dymTCXkcs
 tmGfAZi/8jOKBZuO3Zo1YAUskSe2qRtmxDnJJpdUUhOufTjcJKaQUgxWTbWP77m+fXJbqtpz8BZ
 /8t/yF1LEPkUbs+2woT745imZVDzL+BvmJ5uxD/65G1RNiJIyeEuFOvHJ3Q==
X-Gm-Gg: Acq92OHL9APPoP8KHiirfPsmLGdcX6v9px9sRa917zP9ZF1CppJOPn0mJBdoiUeQdxH
 gz4EZ/c1X3E4k+d/qoen/A9caPf+OwGOuWHAQKQ5bU7WNIXzqw8ZKf2iuGamLdHzFjCOOOTdzb2
 cDUumRU147LV6WjeiU4MYKpNqBzGJaNe/UQ+FyPpGiwuXXTOjNHV2QBtlsYYt23kZF6J1lcJidY
 w5+X43qDScG+rR5Eat2MJLEs+MT+9NFoVq7Q9zI78hXIodAzruORcnvxRT7gr/w+MHxLSSs7Izn
 zgdAm/dHzCi//+TjI9rkJVsC9bNw+/LpI3GE1P59MSA4g6qxq2ZpzKYaLEZpSma+Qt8aIUoIudm
 BNRlQR4l8cAmNSx1voN0DhoU9636blgZ3lmKREGmMhwGbV3iqGZf17LyIzPcTVirttyEljg==
X-Received: by 2002:ac8:7d0e:0:b0:516:e9b8:a923 with SMTP id
 d75a77b69052e-516e9b8ab31mr220882161cf.41.1779887589228; 
 Wed, 27 May 2026 06:13:09 -0700 (PDT)
X-Received: by 2002:ac8:7d0e:0:b0:516:e9b8:a923 with SMTP id
 d75a77b69052e-516e9b8ab31mr220881441cf.41.1779887588637; 
 Wed, 27 May 2026 06:13:08 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706b0bad4sm42621101cf.31.2026.05.27.06.13.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 06:13:08 -0700 (PDT)
Message-ID: <3e965cdc-3250-4443-8623-859e39441477@oss.qualcomm.com>
Date: Wed, 27 May 2026 10:13:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] riscv: add initial sdext support
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, tangtao1634@phytium.com.cn, devel@lists.libvirt.org,
 qemu-riscv@nongnu.org
References: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cover.1775959096.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: YeVt7YAnq1yXcIB9S69zIb8SydtA-rF7
X-Authority-Analysis: v=2.4 cv=bJAm5v+Z c=1 sm=1 tr=0 ts=6a16ede6 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=xvfqbYfxAAAA:20 a=VwQbUJbxAAAA:8 a=pFyQfRViAAAA:8
 a=p0WdMEafAAAA:8 a=AWrsuSWsiZSHnyhcZ9gA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=oJz5jJLG1JtSoe7EL652:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDEyOSBTYWx0ZWRfX4xx+uKBpIPIt
 HsTkd5KMVIM3f0T8bqqOT6mZq3HoQBAulGTKwghCkxNFq6p59ZDI/XQnSY32zJ+5xd7O9dXB9P4
 u9XII7lu/VzGZ3p489qIuVppxvHvxdmrwG+R8rntqUwcMnXnlV2kX89HkpJ/TrvpDq7L2fqTSMU
 XWF922qwoMQF2BbAo58TWmJ+FDq1baRUnKc96GC5eXYK7N56sl+LvRau4XW9e0t/J4OktXEfS0T
 qAkbEFWQ7UuZ+REwLM7MJuy7tsznTPSjOnh11DB4mlsK+4JeLGJ/ObMfGYuTL7UH1HeXjJDQ2a4
 NsrR7l8yTzFtokh1I/ypGomsEQeWIj52WpeMv+7Yh0YRzIv2CJbEZfrlyXiT/0tFpEX/WfE6A5w
 4eH0h4MHj0EuxS7yBhZdP6zOaOMV5uoxIBpUlUYFBQ48IuV0CCGkIKpowaEn1jRVMRK6YExjxxQ
 IfJDwTupBOebsu3DIaA==
X-Proofpoint-GUID: YeVt7YAnq1yXcIB9S69zIb8SydtA-rF7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270129
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

Hi Chao!


Can you please re-send this series?  We did changes in the last PR that
will conflict with what you did - most likely a trivial conflict in
patch 2.

I'll resend patch 1 myself.  Feel free to pick the rebased version to
include in your v7.


Cheers,
Daniel




> Hi,
> 
> This v6 series is rebased on Alistair's riscv-to-apply.next branch [1].
> 
> The implementation follows RISC-V Debug Specification 1.0 [2].
> 
> It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
> Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
> trigger action=debug mode.
> 
> To reduce review load, this series focuses on the Sdext features first.
> The Debug Module (DM) and related flows will follow in a later series.
> 
> Changes in v6:
> - Rebased onto latest riscv-to-apply.next
> 
> Changes in v5:
> - Patch 2: removed redundant `cpu->cfg.ext_sdext = false;` in
>    riscv_cpu_init() since it's already set to false in MULTI_EXT_CFG_BOOL.
>    (Daniel)
> - Patch 7: changed LOG_UNIMP to LOG_GUEST_ERROR for invalid trigger
>    action=debug mode when Sdext is not enabled. LOG_UNIMP is reserved
>    for unimplemented features, while LOG_GUEST_ERROR is for invalid
>    guest actions. (Daniel)
> 
> Changes in v4:
> - Fixed linux-user build errors: moved debug_mode/dcsr/dpc/dscratch
>    fields inside #ifndef CONFIG_USER_ONLY block in cpu.h, and wrapped
>    all code using these fields with proper guards. (Daniel)
> - Updated dependency from single patch (patch 5 only) to patches 1-5
>    of Max Chou's "Add Zvfbfa extension support" v2 series to avoid
>    compilation errors.
> 
> Changes in v3:
> - Rebase onto Alistair's riscv-to-apply.next branch.
> - Depend on Max Chou's patch "target/riscv: Use the tb->cs_bqse as
>    the extend tb flags." (not included; apply it first) [3].
> - Patch 2: default sdext to false in riscv_cpu_extensions.
> 
> Changes in v2:
> - Drop the RHCT expected AML update from this series.
> - Replace the split sdext/sdtrig config bits patch with deprecating the
>    'debug' CPU property.
> - Rebase and update patch subjects to target/riscv prefix.
> 
> Changes in v1:
> - Debug Mode entry/exit updates DCSR/DPC and restores execution via DRET.
> - EBREAK honors DCSR ebreak bits and enters Debug Mode when enabled.
> - Single-step uses DCSR.STEP with a TB flag and a helper at TB exit.
>    It references Max Chou's patch "target/riscv: Use the tb->cs_bqse as
>    the extend tb flags." [3].
> - Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
>    inst-count triggers in tinfo.
> 
> ---
> 
> Differences vs Debug Spec (known gaps):
> - No Debug Module (no DMI, dmcontrol/dmstatus, haltreq/resumereq).
> - No debug ROM, program buffer, abstract commands, or SBA.
> - Resume is modeled by leaving Debug Mode at cpu_exec_enter.
> - Step/exception ordering is simplified: if the stepped instruction
>    traps, the normal exception is taken and Debug Mode is not forced.
> - Several DCSR fields are not fully modeled (stopcount/stoptime, etc).
> 
> Roadmap (next stage, DM focus):
> 1) Add a DM core with DMI access and hart state tracking.
> 2) Implement halt/resume handshake and move Debug Mode transitions
>     under DM control.
> 3) Add debug ROM, program buffer, and abstract commands for GPR/CSR
>     and memory access.
> 4) Add SBA if required by tooling.
> 5) Tighten ordering rules for step/exception/trigger priorities.
> 
> CI (all jobs passed except check-patch which flags pre-existing
> upstream style issues, not related to this series) [4].
> 
> References:
> [1] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
> [2] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> [3] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
> [4] https://gitlab.com/TaoTang/qemu/-/pipelines/2446308835
> 
> 
> Thanks,
> Chao
> 
> Chao Liu (6):
>    target/riscv: add sdext debug CSRs state
>    target/riscv: add sdext Debug Mode helpers
>    target/riscv: add dret instruction
>    target/riscv: add sdext enter Debug Mode on ebreak
>    target/riscv: add sdext single-step support
>    target/riscv: add sdtrig trigger action=debug mode
> 
> Daniel Henrique Barboza (1):
>    target/riscv: deprecate 'debug' CPU property
> 
>   docs/about/deprecated.rst                     |   7 +
>   include/exec/translation-block.h              |   4 +-
>   target/riscv/cpu.c                            |  59 +++++++-
>   target/riscv/cpu.h                            |   9 ++
>   target/riscv/cpu_bits.h                       |  33 +++++
>   target/riscv/cpu_cfg_fields.h.inc             |   3 +-
>   target/riscv/cpu_helper.c                     |  90 ++++++++++++
>   target/riscv/csr.c                            | 128 +++++++++++++++++-
>   target/riscv/debug.c                          |  58 +++++++-
>   target/riscv/helper.h                         |   3 +
>   target/riscv/insn32.decode                    |   1 +
>   .../riscv/insn_trans/trans_privileged.c.inc   |  24 ++++
>   target/riscv/machine.c                        |  44 ++++--
>   target/riscv/op_helper.c                      |  70 ++++++++++
>   target/riscv/tcg/tcg-cpu.c                    |  21 ++-
>   target/riscv/translate.c                      |  15 +-
>   16 files changed, 544 insertions(+), 25 deletions(-)
> 


