Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE7BCCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtwJ-0004Ct-Eg; Fri, 31 Oct 2025 14:33:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwH-0004At-Pe
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:29 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwA-0006Am-24
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:33:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426f1574a14so1697374f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935592; x=1762540392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=sGx31Ll513CXKqm3c4XM9FoCRrQIvlZb6QfyJDJg0c8=;
 b=y4qChX3JXS6cd95D6Crz4th1Me0vaChRaYO0/3p1EMPPQZ3Db96BbQSUltonQd1rpP
 rzrnVa4w6B/ls0OBSGC52Wvomn1QUY8/aUGR988RZLBd1gvE4V8pvB8ej1gjmWwh1on2
 LdsnGNDLKyK8SZUwS+HRspxaKc6e0Kmd1NU+a7/7Pdcp9mnaz4vfMmqVgB1hHccv1gD8
 D7weth893oZYwRVbuDdfSiPPBmKSYWj1S3M9aQ2To1srEtbPkdFY0WSz+huwNvVUpBUi
 nrXCV/H2HCWvhZXdc5mqmPI575izBYOxaHtmaJA713l5KXbrV/ZPwT6MOzLjJ6q/ZOwo
 5aEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935592; x=1762540392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sGx31Ll513CXKqm3c4XM9FoCRrQIvlZb6QfyJDJg0c8=;
 b=mRlqt0EAGK17kQ5mueGRIQDpbAYrXDkvantCD/MosffTLa+cAhOtcPOwOlpokzIex5
 FN1ufqgqeaelvapL0IWCJRc3DJt/tr9lXOfodOYH8lno453OuE6grOt0QbDCBcv8mFXf
 L8Gq153pgM+c79EiCdXTqbWFUNOXaTzUk1LHTXTyEydyz0r0UScz3DHUtuDw9lz2SO0O
 9MfilJV4oYxvjbNgDcKTDcv9ZBEqHt4Jy5HdGYLShEjq3NIQHe99Z0zeBZwaxrJ6AeYh
 xOdsAOw3QI2L26AxPqJ7OMHEvySygfgObfnU64nhnx+Uc4S+BRQyRiNJWxTrHEwncXcb
 8NcA==
X-Gm-Message-State: AOJu0YybEinbCA5Grp7mY6d7zRS2v/6GIh1B4moRgsgJBbRoiUx00suu
 d19LkQ+4jrs7VjP8cY9HVqdBL9Sb7/QdGYXgQ43Yho5U4sGX0J0V/8j1N7ZSZgfE3DzOJRvS/IQ
 ql9N3
X-Gm-Gg: ASbGncvljjKRQqbi3Dbtx2mZdoW/qLTI40jx9kdQMJTqmdPmUTUAjVK+9tr6xajgIZn
 bSH1Jp8nRP1WWcJuDcd/SLWTfJ5uDHZcGtcEHEnLy4a9pdf09uQ6Iv7uYVAAaHaXPZzpKp845s8
 s57taOHc+bz6Br4uZjM/SIYC7naSjPFIjgMVVQdniKkIb1qqxcbR5M8YA6DPLmldMRvyzV3ldU2
 TIniPs8gVxddgWnY1tX+VQfKXkZ6uwl43O5UVC62YDCHO+m8mdib6vCLJcgfP1uG6GjPL0NDDU6
 zVPIUNrFGFIBkveHDMuws0uRrbK1e0mNuBY6VkKQAjwjP5hNCn9DYYmKG/h/Kc/Nosp1oX84zk3
 m5z+u0McymcEfQ08iP1ucW+ame29ZqLLWUrlElc53xygrld4b8k5kEDZsxjpkzppKP+Z3j+g3T9
 SeFS/dZyCgLLqufGyI
X-Google-Smtp-Source: AGHT+IGUj3xhRi4EJKuKoGNd3RlNberl5YgXZqGD3OZww/ytnnmV/y0Cok4COMCTvyoCDmW/soVb2w==
X-Received: by 2002:a05:6000:2dc7:b0:428:5673:11c5 with SMTP id
 ffacd0b85a97d-429bd6add35mr4151127f8f.61.1761935592468; 
 Fri, 31 Oct 2025 11:33:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 00/38] target-arm queue
Date: Fri, 31 Oct 2025 18:32:32 +0000
Message-ID: <20251031183310.3778349-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
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

Hi; here's an arm pullreq for the freeze. Mostly this is Philippe's
hvf cleanup work, but there are some other smaller things in here too.

thanks
-- PMM

The following changes since commit 3728de31925ae9658e2ce3d1ff9b63c83609f310:

  Merge tag 'single-binary-20251030' of https://github.com/philmd/qemu into staging (2025-10-31 10:26:34 +0100)

are available in the Git repository at:

  https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251031

for you to fetch changes up to 8b733be9f408f9b550fc998c790e32aded5119f1:

  accel/hvf: Trace prefetch abort (2025-10-31 16:26:46 +0000)

----------------------------------------------------------------
target-arm queue:
 *  hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
 * docs/system/arm/virt: Document user-creatable SMMUv3
 * docs/system/security: Restrict "virtualization use case" to specific machines
 * target/arm: Add assert to arm_to_core_mmu_idx()
 * hw/arm/virt: remove deprecated virt-4.1 and virt-4.2 machine types
 * hvf: Refactorings and cleanups

----------------------------------------------------------------
Mohamed Mediouni (2):
      target/arm/hvf: Hardcode Apple MIDR
      target/arm/hvf: switch hvf_arm_get_host_cpu_features to not create a vCPU

Peter Maydell (3):
      docs/system/arm/virt: Document user-creatable SMMUv3
      docs/system/security: Restrict "virtualization use case" to specific machines
      target/arm: Add assert to arm_to_core_mmu_idx()

Philippe Mathieu-Daudé (33):
      hw/gpio/pl061: Declare pullups/pulldowns as 8-bit types
      hw/arm/virt: Remove deprecated virt-4.1 machine
      hw/arm/virt: Remove VirtMachineClass::no_ged field
      hw/arm/virt: Remove deprecated virt-4.2 machine
      hw/arm/virt: Remove VirtMachineClass::kvm_no_adjvtime field
      target/arm/hvf: Release memory allocated by hv_vcpu_config_create()
      target/arm/hvf: Trace vCPU KICK events
      target/arm/hvf: Check hv_vcpus_exit() returned value
      target/arm/hvf: Check hv_vcpu_set_vtimer_mask() returned value
      accel/hvf: Rename hvf_vcpu_exec() -> hvf_arch_vcpu_exec()
      accel/hvf: Rename hvf_put|get_registers -> hvf_arch_put|get_registers
      target/arm/hvf: Mention flush_cpu_state() must run on vCPU thread
      accel/hvf: Mention hvf_arch_init_vcpu() must run on vCPU thread
      target/arm/hvf: Mention hvf_sync_vtimer() must run on vCPU thread
      target/arm/hvf: Mention hvf_arch_set_traps() must run on vCPU thread
      accel/hvf: Mention hvf_arch_update_guest_debug() must run on vCPU
      target/arm/hvf: Mention hvf_inject_interrupts() must run on vCPU thread
      accel/hvf: Implement hvf_arch_vcpu_destroy()
      target/arm/hvf: Simplify hvf_arm_get_host_cpu_features()
      target/arm/hvf: Factor hvf_handle_exception() out
      target/i386/hvf: Factor hvf_handle_vmexit() out
      target/arm/hvf: Factor hvf_handle_vmexit() out
      target/arm/hvf: Keep calling hv_vcpu_run() in loop
      cpus: Trace cpu_exec_start() and cpu_exec_end() calls
      accel/hvf: Guard hv_vcpu_run() between cpu_exec_start/end() calls
      target/arm: Call aarch64_add_pauth_properties() once in host_initfn()
      accel/hvf: Restrict ARM specific fields of AccelCPUState
      target/arm: Rename init_cpreg_list() -> arm_init_cpreg_list()
      target/arm/hvf: Rename 'vgic' -> 'emu_reginfo' in trace events
      target/arm: Re-use arm_is_psci_call() in HVF
      target/arm: Share ARM_PSCI_CALL trace event between TCG and HVF
      target/arm/hvf/hvf: Document $pc adjustment in HVF & SMC
      accel/hvf: Trace prefetch abort

 docs/system/arm/virt.rst    |  35 +++-
 docs/system/security.rst    |  26 +++
 include/hw/arm/virt.h       |   2 -
 include/system/hvf_int.h    |  23 ++-
 target/arm/internals.h      |   6 +-
 accel/hvf/hvf-accel-ops.c   |   4 +-
 cpu-common.c                |   3 +
 hw/arm/virt.c               |  33 +--
 hw/gpio/pl061.c             |  16 +-
 hw/vmapple/vmapple.c        |   4 +-
 target/arm/cpu.c            |   2 +-
 target/arm/cpu64.c          |   8 +-
 target/arm/helper.c         |   2 +-
 target/arm/hvf/hvf.c        | 244 +++++++++++++---------
 target/arm/tcg/psci.c       |   3 +
 target/i386/hvf/hvf.c       | 484 +++++++++++++++++++++++---------------------
 target/i386/hvf/x86hvf.c    |   4 +-
 target/arm/hvf/trace-events |   6 +-
 target/arm/trace-events     |   3 +
 trace-events                |   2 +
 20 files changed, 511 insertions(+), 399 deletions(-)

