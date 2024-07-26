Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6EAC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXK7V-0007Wx-Fy; Fri, 26 Jul 2024 08:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sXK7C-00075q-59
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:32:10 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sXK79-0003D7-Om
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:32:05 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1fd69e44596so4458505ad.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 05:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1721997122; x=1722601922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EtRK4zWhoiaMF0j+CVYjLlZPKRTkFC/ig+Ipn+BZYKg=;
 b=aCef13bxeAzcXPfM49pWR3H09a9k+qm1HLlHopWP1cs6kPAPfFkfk0DfjpgeBwPuIL
 tXugJeRjQfsFJ1Av2NyCKy34EEaLfISf98M6ib0XPljo/3lMFr90NXxGTSEilePBxPHV
 IK4YVdgv1Dr93JpWBLWwNHGITwJ79+6uKKvx8VHEcC0EmiPvAImI/uLNA5vgX4bACXpR
 8iwEd0AJm1ajJ/OLEjJ+uDctJfL/3vVfzyzwV98MNrQMLICIK5n916T9EmjL9WvIs80T
 c9fGz0s1SkECveW+3lGfBukvkL4YwJp2tvHiKls4VbpziuLOIU8auqTdaDz1R4hvWbwd
 8Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721997122; x=1722601922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EtRK4zWhoiaMF0j+CVYjLlZPKRTkFC/ig+Ipn+BZYKg=;
 b=c4F9HooCa/iiFOs2uE1DPSdjXbrh8biFs/ZFMKiJTX54qsTmsKWWdOkg6ODp8P1u54
 dZpHU53BwF6ehBSgjYGwdPHUQrRXa5paM1mn1nT3vOYxDijFpgvMMJ+zjuPfn2CWJcl7
 b5OIfDwR5jS5JZJrpEozUbLeLYL/wfytS9L/Q3CUvFD7D3EYPzNloWHJRhQ9gzVArUVE
 /EH/qcp99HJwme7eoClabJ0rojNCqO8AlCJEbM/PfnSwSDfuGlR8DFbuIzSrwk/ZGEk+
 pj80X7xcJAw42LrGoPSxvx4uqiNk2IIuKAYiR6XY+JBBnVN2pQCJgiQlHMPXTQ86dy2I
 5E6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh8o4DEFS4nZrl2hLZoB3IdodFT6z8B7SOZ8eO/JRSERuQwA5VVeKT3ZknverC3Z9IOYmp4xIyjmdsuzE+QkEotogKlRM=
X-Gm-Message-State: AOJu0YzJHpC8qHFbkY1dpaT4WEeDq0vXlqePB8idLgkzjsgjiZcfkCKW
 L0FVmHCyyzHEjdfnQGH6xlNGhnAYgs0EwOgf61gq+cIp4OC8L3L91f4+Xy9p7+U=
X-Google-Smtp-Source: AGHT+IEgymvyGjOEhBuJXdL2Wi2DdocA3Ya4PRzqyhDbvku0sARpaof0y551Ua96Zr/2a9KYz+atcQ==
X-Received: by 2002:a17:903:41cc:b0:1fd:b5fe:ee91 with SMTP id
 d9443c01a7336-1fdd6e42911mr143186455ad.25.1721997121912; 
 Fri, 26 Jul 2024 05:32:01 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc0:54b1:ce70:829:8c74:d7d4?
 ([2804:7f0:bcc0:54b1:ce70:829:8c74:d7d4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead874aeesm2577489b3a.163.2024.07.26.05.31.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:32:01 -0700 (PDT)
Message-ID: <73a0b3bc-2742-432e-a1bc-061621634a46@ventanamicro.com>
Date: Fri, 26 Jul 2024 09:31:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Improve the performance of unit-stride RVV ld/st on
To: Paolo Savini <paolo.savini@embecosm.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Max Chou <max.chou@sifive.com>
References: <20240717153040.11073-1-paolo.savini@embecosm.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240717153040.11073-1-paolo.savini@embecosm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x62f.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Paolo,


I suggest adding a "riscv:" at the start of the cover letter subject for the next
version. This will make it easier for everyone else to quickly identify which arch
the patches are changing.

Other than that, and checkpatch.pl style changes, looks good to me.


Thanks,


Daniel


On 7/17/24 12:30 PM, Paolo Savini wrote:
> This series of patches builds on top of Max Chou's patches:
> 
> https://lore.kernel.org/all/20240613175122.1299212-1-max.chou@sifive.com/
> 
> The aim of these patches is to improve the performance of QEMU emulation
> of RVV unit-stride load and store instructions in the following cases
> 
> 1. when the data being loaded/stored per iteration amounts to 8 bytes or less.
> 2. when the vector length is 16 bytes (VLEN=128) and there is no grouping of the
>     vector registers (LMUL=1).
> 3. when the data being loaded/stored per iteration is more than 64 bytes.
> 
> In the first two cases the optimization consists of avoiding the
> overhead of probing the RAM of the host machine and perform a simple loop
> load/store on the data grouped in chunks of as many bytes as possible (8,4,2 or 1).
> 
> The third case is optimized by calling the __builtin_memcpy function on
> data chuncks of 128 bytes and 256 bytes per time.
> 
> These patches on top of Max Chou's patches have been tested with SPEC
> CPU 2017 and achieve an average reduction of 13% of the time needed by
> QEMU for running the benchmarks compared with the master branch of QEMU.
> 
> You can find the source code being developed here: https://github.com/embecosm/rise-rvv-tcg-qemu
> and regular updates and more statistics about the patch here: https://github.com/embecosm/rise-rvv-tcg-qemu-reports
> 
> Changes:
> - patch 1:
>    - Modify vext_ldst_us to run the simple loop load/store if we
>      are in one of the two cases above.
> - patch 2:
>    - Modify vext_group_ldst_host to use __builtin_memcpy for data sizes
>      of 128 bits and above.
> 
> Cc: Richard Handerson <richard.henderson@linaro.org>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Alistair Francis <alistair.francis@wdc.com>
> Cc: Bin Meng <bmeng.cn@gmail.com>
> Cc: Weiwei Li <liwei1518@gmail.com>
> Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> Cc: Helene Chelin <helene.chelin@embecosm.com>
> Cc: Max Chou <max.chou@sifive.com>
> 
> Helene CHELIN (1):
>    target/riscv: rvv: reduce the overhead for simple RISC-V vector
>      unit-stride loads and stores
> 
> Paolo Savini (1):
>    target/riscv: rvv: improve performance of RISC-V vector loads and
>      stores on large amounts of data.
> 
>   target/riscv/vector_helper.c | 63 +++++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 

