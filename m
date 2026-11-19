Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80520606A325
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 15:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Y3zFIkou
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU3al-0003gx-Tc; Thu, 19 Nov 2026 09:58:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3W7-0007zR-Cf; Thu, 19 Nov 2026 09:53:50 -0500
Received: from [115.124.30.110] (helo=out30-110.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1xU3Vr-0001I2-UG; Thu, 19 Nov 2026 09:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1795099983; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=Bb+IN3QAeXPKu/t5xgVp6Pjp1hZmDcn80zkwE2ZIs38=;
 b=Y3zFIkougBzN3x/6D4YHjlMTEp6pzAbCHq/KkYoBH4PO5Bq5nJpbkleUQpzMUD3tdQQRGFnyFqnZVgHb/+ufDIoCq179yN6cEZiAesRC30T/CqLebyhQGOxD0ntaMMIVwRal6s8seJ2DFm1O/MNvbyUJVJuWEHtTFEE0Ptl62DY=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R181e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037026112;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=12; SR=0;
 TI=SMTPD_---0XF3nDqQ_1795099982; 
Received: from 30.180.144.153(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0XF3nDqQ_1795099982 cluster:ay36) by smtp.aliyun-inc.com;
 Thu, 19 Nov 2026 22:53:02 +0800
Message-ID: <d9a849a7-5b3a-45da-8d59-17afc721d1f8@linux.alibaba.com>
Date: Thu, 19 Nov 2026 22:53:02 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] RISC-V TCG PMU correctness fixes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20261112-riscv-pmu-correctness-v4-0-e9067bdf4df5@linux.alibaba.com>
 <c95dace6-1c4f-409c-8878-d4c68ec16d62@oss.qualcomm.com>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <c95dace6-1c4f-409c-8878-d4c68ec16d62@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.110 (deferred)
Received-SPF: pass client-ip=115.124.30.110;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-110.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-19.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

在 2026/11/19 20:31, Philippe Mathieu-Daudé 写道:
> Hi,
>
> On 2026-11-12 10:49, TANG Tiancheng wrote:
>
>> TCG tests cover RV32/RV64 counter accesses, delegated registers, 
>> selector
>> and filter changes, multiple counters per event, overflow notification
>> with and without Sscofpmf, instruction exceptions, and reset. The RV32
>> HPM tests also cover full-width accesses through the shared counter 
>> path.
>
>
>> ---
>> TANG Tiancheng (14):
>>        target/riscv: Preserve PMU state across event selector writes
>>        target/riscv: Support multiple counters per PMU event
>>        target/riscv: Use VM-elapsed sources for fixed PMU events
>>        target/riscv: Preserve MINH on delegated config reads
>>        target/riscv: Preserve minstretcfgh on RV32 minstretcfg writes
>>        target/riscv: Fix RV32 accesses to delegated PMU registers
>>        target/riscv: Preserve fixed counters across PMU state changes
>>        target/riscv: Require Sscofpmf for non-fixed event overflow
>>        target/riscv: Rebuild fixed-event PMU overflow deadlines
>>        target/riscv: Apply minstret exception accounting to HPM counters
>>        target/riscv: Process PMU timer expiry on the owner vCPU
>>        target/riscv: Migrate fixed PMU counter state
>>        target/riscv: Clear virtualization mode on reset
>>        target/riscv: Preserve fixed PMU state across reset
>>   tests/tcg/riscv32/pmu-fixed-rv32.S          |  90 ++++
>>   tests/tcg/riscv32/pmu-minstretcfg-rv32.S    |  52 ++
>>   tests/tcg/riscv32/smcdeleg-minh-rv32.S      |  78 +++
>>   tests/tcg/riscv32/smcdeleg-rv32.S           | 115 ++++
>>   tests/tcg/riscv32/sscofpmf-event-rv32.S     |  99 ++++
>>   tests/tcg/riscv32/system/meson.build        |  35 ++
>>   tests/tcg/riscv64/pmu-cycle-controls.S      | 107 ++++
>>   tests/tcg/riscv64/pmu-lpad.S                |  72 +++
>>   tests/tcg/riscv64/pmu-reset-vs.S            | 105 ++++
>>   tests/tcg/riscv64/smcdeleg-minh.S           |  78 +++
>>   tests/tcg/riscv64/smcdeleg-sxl32.S          | 233 ++++++++
>>   tests/tcg/riscv64/sscofpmf-cycle-overflow.S |  58 ++
>>   tests/tcg/riscv64/sscofpmf-event-overflow.S | 103 ++++
>>   tests/tcg/riscv64/sscofpmf-overflow.S       | 134 +++++
>>   tests/tcg/riscv64/system/meson.build        |  88 +++
>>   tests/tcg/riscv64/test-minstret-ecall.S     |  26 +
> Do the tests need the 'AI-used-for: Regression tests' mention?

Hi Philippe,

Yes, AI helped write and refine the regression tests. I've added

     AI-used-for: Regression tests

to the commits that add or extend them for v5.

Thanks,
Tiancheng


