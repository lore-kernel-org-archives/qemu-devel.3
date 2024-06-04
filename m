Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3386C25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:30:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOc5-0004Iu-8c; Tue, 04 Jun 2024 03:29:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEOc3-0004IL-MJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:29:43 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1sEOc1-0001uF-Pc
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:29:43 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso2883793a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1717486180; x=1718090980; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9Pc9B4z1dxBoTcAKe6NCLiUY6SZ9pFTORrY9zIAuuS8=;
 b=O+BhGiKOTBMhS5Oq6DpHtz4k/RIym+AzSSZsjfowy+zW4AmLoPRBMqfhNgiGHyMxGR
 ALU++0BDt6KHdFS8hOLGOA510yB9dk7Pj7p9Mr/hprnowEGDqUtcvLEgYALvyiYyPic5
 lwWDIHjKBj/FaH+EotRPpsK1tIghrN6UsI5+k+xvxMTs3RzxrJVknBn74dT/yvqEoROM
 SBNa5ZDdD+e29LaYH0gyHQ3Lp6k8xOHHxqWOx0lksLRroFtjRYQOMcPXBYIW0tjUqbRl
 x+YtRaPw5FvfFpx1asZ/VDTaJGpn2dcX/kGKEogfjIOdt04hbuj53BhHibit8gywJ5Fx
 YdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717486180; x=1718090980;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Pc9B4z1dxBoTcAKe6NCLiUY6SZ9pFTORrY9zIAuuS8=;
 b=JVbhAgeLmmQdrbQzrl4+hPGTNljcy5yIS9umMNMdkEJVS8dfz16CIMXpap+VozQPWV
 44Y+FmGA9mbFz6i2vAIxjLBBrT825Kk+ix30NJZa0QXwi0YItGd8Pu5w7xcjHtwZvXeT
 B0viZbhS9TxMb+xmWAf1xTUk7YTTC/Tlj2naj0w/1ja4G5To8GH97MxCyT1c8yW2q02y
 sgFgq2qn9gN1PDu1O5p/mKFatYp5gJ8PRQN56TCCgo29F58Q2jT5rUUbxDh5i1lRVZEl
 uS7/RQaSf5V3IbAMMqnEfqGEfbGLhaRQ8zEha1Gjb+I/Vawv3I8VoepL2qjIZPnQR9/T
 sATQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUB6OFJtCREwVkqOwzvI9NR+Q0efUeyailg/TH/USPb2x81M2ONg0GNko3Sjck9BV8QfbMInjtmulkQ2ZKkpkVDBrZ/fKM=
X-Gm-Message-State: AOJu0Yz5PAao2fC0LDdHhznv4I0/O9F6PEcdHIT+evSw+LMiib8iv4YC
 n12g+pcdUrV1bo3IuiMBVzh4CIGSiZkj/iC+nkAjSuEOHvoWj6GEcADvozTLkc0=
X-Google-Smtp-Source: AGHT+IGtK739R2sA2XcetuC9PBqp1vi5u6xiXYsbkvw1am9n4mculNSfLASTLBDhYHQR4TjWu4bxIQ==
X-Received: by 2002:a05:6a21:6d8a:b0:1af:d07a:37c8 with SMTP id
 adf61e73a8af0-1b26f22b0e3mr12776843637.37.1717486179607; 
 Tue, 04 Jun 2024 00:29:39 -0700 (PDT)
Received: from [192.168.100.252] (59-124-168-89.hinet-ip.hinet.net.
 [59.124.168.89]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323e3c33sm76452725ad.176.2024.06.04.00.29.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 00:29:39 -0700 (PDT)
Message-ID: <da896d6b-7b7f-4246-9750-f7bc11e54d3b@sifive.com>
Date: Tue, 4 Jun 2024 15:29:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jason Chien <jason.chien@sifive.com>
Subject: Re: [PATCH 0/6] target/riscv: Add support for Control Transfer
 Records Ext.
To: Rajnesh Kanwal <rkanwal@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 atishp@rivosinc.com, apatel@ventanamicro.com, beeman@rivosinc.com,
 tech-control-transfer-records@lists.riscv.org
References: <20240529160950.132754-1-rkanwal@rivosinc.com>
Content-Language: en-US
In-Reply-To: <20240529160950.132754-1-rkanwal@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=jason.chien@sifive.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Smctr depends on the Smcsrind extension, Ssctr depends on the Sscsrind 
extension, and both Smctr and Ssctr depend upon implementation of S-mode.
There should be a dependency check in riscv_cpu_validate_set_extensions().

Rajnesh Kanwal 於 2024/5/30 上午 12:09 寫道:
> This series enables Control Transfer Records extension support on riscv
> platform. This extension is similar to Arch LBR in x86 and BRBE in ARM.
> The Extension has been stable and the latest release can be found here [0]
>
> CTR extension depends on couple of other extensions:
>
> 1. S[m|s]csrind : The indirect CSR extension [1] which defines additional
>     ([M|S|VS]IREG2-[M|S|VS]IREG6) register to address size limitation of
>     RISC-V CSR address space. CTR access ctrsource, ctrtartget and ctrdata
>     CSRs using sscsrind extension.
>
> 2. Smstateen: The mstateen bit[54] controls the access to the CTR ext to
>     S-mode.
>
> 3. Sscofpmf: Counter overflow and privilege mode filtering. [2]
>
> The series is based on Smcdeleg/Ssccfg counter delegation extension [3]
> patches. CTR itself doesn't depend on counter delegation support. This
> rebase is basically to include the Smcsrind patches.
>
> Due to the dependency of these extensions, the following extensions must be
> enabled to use the control transfer records feature.
>
> "smstateen=true,sscofpmf=true,smcsrind=true,sscsrind=true,smctr=true,ssctr=true"
>
> Here is the link to a quick guide [5] to setup and run a basic perf demo on
> Linux to use CTR Ext.
>
> The Qemu patches can be found here:
> https://github.com/rajnesh-kanwal/qemu/tree/ctr_upstream
>
> The opensbi patch can be found here:
> https://github.com/rajnesh-kanwal/opensbi/tree/ctr_upstream
>
> The Linux kernel patches can be found here:
> https://github.com/rajnesh-kanwal/linux/tree/ctr_upstream
>
> [0]:https://github.com/riscv/riscv-control-transfer-records/release
> [1]:https://github.com/riscv/riscv-indirect-csr-access
> [2]:https://github.com/riscvarchive/riscv-count-overflow/tree/main
> [3]:https://github.com/riscv/riscv-smcdeleg-ssccfg
> [4]:https://lore.kernel.org/all/20240217000134.3634191-1-atishp@rivosinc.com/
> [5]:https://github.com/rajnesh-kanwal/linux/wiki/Running-CTR-basic-demo-on-QEMU-RISC%E2%80%90V-Virt-machine
>
> Rajnesh Kanwal (6):
>    target/riscv: Remove obsolete sfence.vm instruction
>    target/riscv: Add Control Transfer Records CSR definitions.
>    target/riscv: Add support for Control Transfer Records extension CSRs.
>    target/riscv: Add support to record CTR entries.
>    target/riscv: Add CTR sctrclr instruction.
>    target/riscv: Add support to access ctrsource, ctrtarget, ctrdata
>      regs.
>
>   target/riscv/cpu.c                            |   4 +
>   target/riscv/cpu.h                            |  14 +
>   target/riscv/cpu_bits.h                       | 154 +++++++++
>   target/riscv/cpu_cfg.h                        |   2 +
>   target/riscv/cpu_helper.c                     | 213 ++++++++++++
>   target/riscv/csr.c                            | 312 +++++++++++++++++-
>   target/riscv/helper.h                         |   8 +-
>   target/riscv/insn32.decode                    |   2 +-
>   .../riscv/insn_trans/trans_privileged.c.inc   |  21 +-
>   target/riscv/insn_trans/trans_rvi.c.inc       |  27 ++
>   target/riscv/op_helper.c                      | 117 ++++++-
>   target/riscv/translate.c                      |   9 +
>   12 files changed, 870 insertions(+), 13 deletions(-)
>

