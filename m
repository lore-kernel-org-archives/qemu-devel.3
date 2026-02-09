Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B54A6E7E0DA
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 19:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpWpC-0004Ja-3h; Mon, 09 Feb 2026 14:21:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vpWp4-0004FN-Dl
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 14:21:27 -0500
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vpWp0-00012L-JG
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 14:21:25 -0500
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-506251815a3so41245441cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Feb 2026 11:21:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1770664874; x=1771269674; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=siQJwehak0DIXXV7QW1SbQR2JjBbiukr4JZ3AoA2Kqo=;
 b=fjBhsqv4YJLp7WCWLNQnbM2AvjXfO647pHIa0W5sdWsOEO4XEEKYRn2JPTAJL+aghO
 vepiBxbPgv+Q8dKV260ifVBfQ3fCJ/80JakaVtvjtyOMRC+hbCosBQ82HoHACfOmIyFg
 fZOyJ77lTfCCIIsZye22875SVx6DhNsFhTmxgAq1S7eB9yYF7ezf3qML9obrt++WgAeX
 Mv8Lp7MPlnydlhfsAXK4mixZF0k3OFnItCJyO0VH9+uvqDjE857dx/QT0qSQedNTjvLg
 AWXyyMkafw0FQHU5x/EMbyTVc+pp+LGlLLtPicEjYq9Td0WXEa2+MnkZsJsFIsquWdIU
 T7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770664874; x=1771269674;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=siQJwehak0DIXXV7QW1SbQR2JjBbiukr4JZ3AoA2Kqo=;
 b=hdi983YACzHlkCds1NnUgg/xUGjrCE0RrcrWHlSsh3d803utP3UBYKJ56Vi6hrqRxP
 SZkmnSrxsM0jR3COUJ/Q9w5Ye4ltNVfywFt5i3zLYGPfTxZu6SAKonL9hEwqa2KWeyHT
 pt/cloZ83uCaaZ9Db5hdOKXm7+EtkGQQq4GRT0TPE4vxY/Ej0sCEKbdam+hUok0WYSh2
 bprF8zw0IiRS7toxs3kIX+xyf/LZdQfU7oY8Tf1SM+LGdZLVjYDccH1Ga3NNQnHtCJwi
 dHYyXZe6Ng8uy5s0l6wXZ3ZezQaMADY1bT26xGxBRzIbE5suOigWx7prP3T1Xpl6y712
 soUg==
X-Gm-Message-State: AOJu0YyX9udkA1Y39QeZdq7fo+GovBBvvLTlhRIuoHzpQD1AJePxTSWH
 bwC8F22u8WmCmCxT5cGoJ5vc5fonn5XCmT001nk/Wlhq9kLltIAw1B6w2NoVOtIT+B8=
X-Gm-Gg: AZuq6aI2MsJ7CuVo0N3wXZqCzZryNmAooDMQK5f2tLB1keaCvW1J02V38xbAV1Cw3jX
 /2GGvpisccfVsOgK4ww6OYv5Regdc7jvvS6y52nJF4Osh6Vb2TwtegHYS/kZ/Dol04dXnePryPa
 t5P3mnDVKyWp9qVXPt8I5nlNgHa2p11RCse/HRwIPbu/CN/h02vxdX8CQAIPPI7G8gIEfK+829I
 moWZSkSi1oF4UuJE5OPvtM/PRNrlr6AnzgdTzH4Qotp7737shVRnmtVgTHm2PhxCh6JbNHxMiNU
 cVzc0rGI7k1giK8TyCjiT0UTOBwJyUmXbO2dDbSNyo/LYoUKUoVH3nBtj818dmiHqPhzqKvJZl0
 SOn5ZSCVwoL/DoV4wQQT5Fg/Brb7tlLqS9G+xdH3GNeXLusUYKNxUpW60iGMR9GBpN24ZbIgOYX
 cM4SsOLxdJffpDh0cPsTrPeiG8a8mdcnkaJyM2xA==
X-Received: by 2002:a05:622a:351:b0:502:98a3:3496 with SMTP id
 d75a77b69052e-506399515dcmr156932451cf.45.1770664874389; 
 Mon, 09 Feb 2026 11:21:14 -0800 (PST)
Received: from [192.168.68.104] ([179.193.9.245])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50639e26b9fsm86661871cf.15.2026.02.09.11.21.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:21:13 -0800 (PST)
Message-ID: <3e07e5b4-0a6a-4fc1-9ed2-57624d0e96dc@ventanamicro.com>
Date: Mon, 9 Feb 2026 16:21:09 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 0/7] riscv: add initial sdext support
To: Chao Liu <chao.liu.zevorn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 hust-os-kernel-patches@googlegroups.com, devel@lists.libvirt.org
References: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <cover.1770104280.git.chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-qt1-x835.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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



On 2/3/2026 9:55 AM, Chao Liu wrote:
> Hi,
> 
> Per Daniel's review feedback, this v5 series is based on Alistair's
> riscv-to-apply.next branch [3]. It depends on patches 1-5 of Max Chou's
> "Add Zvfbfa extension support" v2 series (not included; apply them
> first) [2].
> 
> It is based on RISC-V Debug Specification 1.0 [1].
> 
> It introduces the sdext/sdtrig config bits, DCSR/DPC/DSCRATCH state,
> Debug Mode enter/leave helpers, DRET, EBREAK entry, single-step, and
> trigger action=debug mode.
> 
> To reduce review load, this series focuses on the Sdext features first.
> The Debug Module (DM) and related flows will follow in a later series.


We still need a reviewed-by in patch 1 (that I can't give, after all 
it's my patch hehe).

Aside from that the series LGTM. It's not sensible to think that we're 
going to push upstream an error/bug free extension. The code will need 
more mileage with more people using it and we'll fix what is needed 
along the way. We have a long time until the release anyway.

My vote is to queue this up (we'll need Max's series queued first). When 
this lands upstream we'll go back to the Server SoC reference board and 
get that upstreamed too.


Thanks,
Daniel


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
>    the extend tb flags." (not included; apply it first) [2].
> - Patch 2: default sdext to false in riscv_cpu_extensions[].
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
>    the extend tb flags." [2].
> - Sdtrig supports action=debug mode for mcontrol/mcontrol6 and reports
>    inst-count triggers in tinfo.
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
> References:
> [1] https://github.com/riscv/riscv-debug-spec/releases/tag/1.0
> [2] https://lore.kernel.org/qemu-devel/20260108132631.9429-1-max.chou@sifive.com/
> [3] https://github.com/alistair23/qemu/tree/riscv-to-apply.next
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
>   target/riscv/translate.c                      |  16 ++-
>   16 files changed, 545 insertions(+), 25 deletions(-)
> 
> --
> 2.53.0
> 


