Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59967C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 10:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYOaW-0008Fh-4a; Fri, 09 Feb 2024 05:58:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaU-0008FZ-Qo
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:30 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rYOaT-000099-23
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 05:58:30 -0500
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6e1270e8cd3so287348a34.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 02:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707476306; x=1708081106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhVEEHSzTAAO8vgoSXdpRdq8Z5Ls61QhmnDtYSP6haw=;
 b=Hl1GyTX/dFQwqMDUO8rjGMIfNCSiya5Fe8BGDwUI+GqAhKO5XwQUeqeLD9PVQ8BxI5
 2MgC5IhCNCsmpXNUXUbbapV5hDy05vzyBF5lhSOuA0QfqF8mPfbJxtzWaTevzOa04xo0
 +UbAWc+LP7nqUjWrlkIrzQZeZJhboqSd+VBvxl0EPRNOl2Y+TxHfAI5fR6f4yIXDKds5
 KDxkkLO3KWcEp65m4TbrA6wh21+dnu8aoL9PUvPfIyoZuu0W6VUgyB4V0RXB6mKNOFT9
 rBJoLCLW1sP9cTLJovSuJKIlIpZjtCxNyc1DUEDI1+Ao7kfu+MeFNKi5BBLruht3MIFs
 v/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707476306; x=1708081106;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhVEEHSzTAAO8vgoSXdpRdq8Z5Ls61QhmnDtYSP6haw=;
 b=WEnMZ1sktE1IPi6j9Ev8MgzLlF2/c9pV6Lu4rXp8alo9TCFMVBuWuOK9NJ2dRau0nf
 EACE4p+CDEbc4EeZqZnDYaGEOshNh9tIgTtra4iPpPTcAwEETMef59s2LpC4N4hHCpYc
 aiZ0klIKgQtID94PlFX6BWi2NojexqfeLh2134kckjer5eQnNkkl7jeOqpNp3UyFUztP
 ywVyeF927Phk15gb1FIcPhLZExpkdTmZfC+fINsvm81YUpOtJHpVvwQXxQZZRRCIqG4h
 o3vqd3RRDuZvoOOZ7XZa2sBdpgOuvFbhwCjhGSKj8OeyfvTF59HnwB+j8Bnyxt3x89zT
 70VA==
X-Gm-Message-State: AOJu0YzD/ggnAiiYtJwgo5hnoEZd+BH16Xx77yChlFopXOkXEN00N15E
 IlFIQmu6qAEoALPN9MfpyEVkdRcK/aFWrjUhbw/rVyiSzuHYz1z6Jow8IUTZ4j3aOA==
X-Google-Smtp-Source: AGHT+IFG5HIpw+BWRp9938Z7NArY91NxGmCwnMfEaS2FeWICGCa+QAmKQlIOuGN3X4qIqxkWCYmQ4w==
X-Received: by 2002:a9d:6b11:0:b0:6de:9b9d:a493 with SMTP id
 g17-20020a9d6b11000000b006de9b9da493mr1068288otp.14.1707476305887; 
 Fri, 09 Feb 2024 02:58:25 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXGg0BpewP/rj1y3WXYTNHkuMS/ceefasEedpgfNjvzPtbUGENheEWe0QQfoOgmRrmAPcKP2GimtbbGGNiXcBG7IIS3+RY2Ooc=
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 d20-20020a637354000000b005d3bae243bbsm1473623pgn.4.2024.02.09.02.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 02:58:25 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 00/61] riscv-to-apply queue
Date: Fri,  9 Feb 2024 20:57:12 +1000
Message-ID: <20240209105813.3590056-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 03e4bc0bc02779fdf6f8e8d83197f05e70881abf:

  Merge tag 'pull-tcg-20240205-2' of https://gitlab.com/rth7680/qemu into staging (2024-02-08 16:08:42 +0000)

are available in the Git repository at:

  https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240209

for you to fetch changes up to deb0ff0c777d20602ecc5b6f74f18cb7ecc0b91f:

  target/riscv: add rv32i, rv32e and rv64e CPUs (2024-02-09 20:49:41 +1000)

----------------------------------------------------------------
RISC-V PR for 9.0

* Check for 'A' extension on all atomic instructions
* Add support for 'B' extension
* Internally deprecate riscv_cpu_options
* Implement optional CSR mcontext of debug Sdtrig extension
* Internally add cpu->cfg.vlenb and  remove cpu->cfg.vlen
* Support vlenb and vregs[] in KVM
* RISC-V gdbstub and TCG plugin improvements
* Remove vxrm and vxsat from FCSR
* Use RISCVException as return type for all csr ops
* Use g_autofree more and fix a memory leak
* Add support for Zaamo and Zalrsc
* Support new isa extension detection devicetree properties
* SMBIOS support for RISC-V virt machine
* Enable xtheadsync under user mode
* Add rv32i,rv32e and rv64e CPUs

----------------------------------------------------------------
Akihiko Odaki (3):
      target/riscv: Remove misa_mxl validation
      target/riscv: Move misa_mxl_max to class
      target/riscv: Validate misa_mxl_max only once

Alvin Chang (1):
      target/riscv: Implement optional CSR mcontext of debug Sdtrig extension

Conor Dooley (2):
      target/riscv: use misa_mxl_max to populate isa string rather than TARGET_LONG_BITS
      target/riscv: support new isa extension detection devicetree properties

Daniel Henrique Barboza (42):
      target/riscv/cpu_cfg.h: remove unused fields
      target/riscv: make riscv_cpu_is_vendor() public
      target/riscv: move 'pmu-mask' and 'pmu-num' to riscv_cpu_properties[]
      target/riscv: move 'mmu' to riscv_cpu_properties[]
      target/riscv: move 'pmp' to riscv_cpu_properties[]
      target/riscv: rework 'priv_spec'
      target/riscv: rework 'vext_spec'
      target/riscv: move 'vlen' to riscv_cpu_properties[]
      target/riscv: move 'elen' to riscv_cpu_properties[]
      target/riscv: create finalize_features() for KVM
      target/riscv: move 'cbom_blocksize' to riscv_cpu_properties[]
      target/riscv: move 'cbop_blocksize' to riscv_cpu_properties[]
      target/riscv: move 'cboz_blocksize' to riscv_cpu_properties[]
      target/riscv: remove riscv_cpu_options[]
      target/riscv/cpu.c: move 'mvendorid' to riscv_cpu_properties[]
      target/riscv/cpu.c: move 'mimpid' to riscv_cpu_properties[]
      target/riscv/cpu.c: move 'marchid' to riscv_cpu_properties[]
      target/riscv: add 'vlenb' field in cpu->cfg
      target/riscv/csr.c: use 'vlenb' instead of 'vlen'
      target/riscv/gdbstub.c: use 'vlenb' instead of shifting 'vlen'
      target/riscv/insn_trans/trans_rvbf16.c.inc: use cpu->cfg.vlenb
      target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb'
      target/riscv/insn_trans/trans_rvvk.c.inc: use 'vlenb'
      target/riscv/vector_helper.c: use 'vlenb'
      target/riscv/vector_helper.c: use vlenb in HELPER(vsetvl)
      target/riscv/insn_trans/trans_rvv.c.inc: use 'vlenb' in MAXSZ()
      target/riscv/cpu.h: use 'vlenb' in vext_get_vlmax()
      target/riscv: change vext_get_vlmax() arguments
      trans_rvv.c.inc: use vext_get_vlmax() in trans_vrgather_v*()
      target/riscv/cpu.c: remove cpu->cfg.vlen
      target/riscv/kvm: change kvm_reg_id to uint64_t
      target/riscv/kvm: initialize 'vlenb' via get-reg-list
      target/riscv/kvm: get/set vector vregs[]
      hw/riscv/virt-acpi-build.c: fix leak in build_rhct()
      hw/riscv/numa.c: use g_autofree in socket_fdt_write_distance_matrix()
      hw/riscv/virt.c: use g_autofree in create_fdt_socket_cpus()
      hw/riscv/virt.c: use g_autofree in create_fdt_sockets()
      hw/riscv/virt.c: use g_autofree in create_fdt_virtio()
      hw/riscv/virt.c: use g_autofree in virt_machine_init()
      hw/riscv/virt.c: use g_autofree in create_fdt_*
      target/riscv/cpu.c: add riscv_bare_cpu_init()
      target/riscv: add rv32i, rv32e and rv64e CPUs

Heinrich Schuchardt (4):
      smbios: add processor-family option
      smbios: function to set default processor family
      target/riscv: SMBIOS support for RISC-V virt machine
      qemu-options: enable -smbios option on RISC-V

LIU Zhiwei (3):
      target/riscv: FCSR doesn't contain vxrm and vxsat
      target/riscv: Use RISCVException as return type for all csr ops
      target/riscv: Enable xtheadsync under user mode

Rob Bradford (6):
      target/riscv: Check for 'A' extension on all atomic instructions
      target/riscv: Add infrastructure for 'B' MISA extension
      target/riscv: Add step to validate 'B' extension
      target/riscv: Add Zaamo and Zalrsc extension infrastructure
      target/riscv: Check 'A' and split extensions for atomic instructions
      target/riscv: Expose Zaamo and Zalrsc extensions

 include/hw/firmware/smbios.h               |    1 +
 target/riscv/cpu-qom.h                     |    3 +
 target/riscv/cpu.h                         |   30 +-
 target/riscv/cpu_bits.h                    |   15 +-
 target/riscv/cpu_cfg.h                     |    8 +-
 target/riscv/kvm/kvm_riscv.h               |    1 +
 hw/riscv/boot.c                            |    3 +-
 hw/riscv/numa.c                            |    4 +-
 hw/riscv/sifive_u.c                        |    7 +-
 hw/riscv/spike.c                           |    6 +-
 hw/riscv/virt-acpi-build.c                 |    2 +-
 hw/riscv/virt.c                            |  153 ++--
 hw/smbios/smbios.c                         |   20 +-
 target/riscv/cpu.c                         | 1106 +++++++++++++++++++++-------
 target/riscv/cpu_helper.c                  |   11 +-
 target/riscv/csr.c                         |  157 ++--
 target/riscv/debug.c                       |    2 +
 target/riscv/gdbstub.c                     |   18 +-
 target/riscv/kvm/kvm-cpu.c                 |  250 +++++--
 target/riscv/machine.c                     |    7 +-
 target/riscv/tcg/tcg-cpu.c                 |  143 ++--
 target/riscv/translate.c                   |    3 +-
 target/riscv/vector_helper.c               |   43 +-
 target/riscv/insn_trans/trans_rva.c.inc    |   45 +-
 target/riscv/insn_trans/trans_rvbf16.c.inc |   12 +-
 target/riscv/insn_trans/trans_rvv.c.inc    |  152 ++--
 target/riscv/insn_trans/trans_rvvk.c.inc   |   16 +-
 target/riscv/insn_trans/trans_xthead.c.inc |   10 -
 hw/riscv/Kconfig                           |    1 +
 qemu-options.hx                            |    6 +-
 30 files changed, 1522 insertions(+), 713 deletions(-)

