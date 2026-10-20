Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10422606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=h69dCYmf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJ7Jd-0004Ao-Nd; Tue, 20 Oct 2026 06:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7Ja-000481-7C
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:30 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xJ7JU-0004JY-Od
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 06:43:29 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so21607535e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792493003; x=1793097803; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3NNeDfISu2gpg9ZYXN0W5UQrgwObRlFXGjX8CXeq/qY=;
 b=h69dCYmfoPKNF1jFib4GFauJXecSl7LUYpU07Fszgl4Ef2VzCTxYoLXOFfNZ/Xd7BZ
 Dfh8ChJqacvyiwHu/tO+UW/cNyjBZtBzrxjnWaHNvvriyjAOrixW+F+JadSQOlpNZYuN
 a40TFL8m/x7XsWNJh1ePuL8ZH5BvwA+kw1MEMhTg3zXJe/yKlxO/mEiZZfnMGnE3EvnB
 FhZq4H1ezyB1sPCejQ92hiocdyLhvRVPd9wR0Jmwu4A9HjEJ5u7SsrqPqNw3mwXGerLs
 qRb9v0ASlPuskDVgEIbYwxDzwoiQEiy2JPwgwOH5Mm1XJh84QoxFOuplA49sekqlCfTr
 Y9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792493003; x=1793097803;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3NNeDfISu2gpg9ZYXN0W5UQrgwObRlFXGjX8CXeq/qY=;
 b=odP/gJ8veok432HgHTbse0x/a2FICUoNIriMemH5+eVGoc3XJWa3Oz1oyxuZrYeIMm
 6K43cb5FKQ1NUomNb/KQJYUYasOJ5IPfsoviS6fPudA8uLpJ4fFGoYVZNGYZW46AVgrk
 QBpDJrC406AYvtT9/n4bmegwxNW1rIdlkpOlZkWqkaHO1A8MfG+tFPzYNG2GHdnVhRkm
 wpETlsE5gh6jq9wrZ0XTLbyFpCAPyyMb9blV1pnXSq9Pdgnb1cNWUEVFwa5ForudJFKV
 YdMRJx/PXoDo0DPVAJUSeW6SSKXfcODtRbM8mX0e8OVYt9GAVeLvuLKGpRC8IJcguB7V
 uvvA==
X-Gm-Message-State: AFq9FYI0x91fnaAVqWFWao5gZADL5XpOseoeQhesRMSO59FObCwwtj3D
 vgvUpYH1me0gERwptjX0XteojzUeVAKHPVrJjjrRSY5ssitnkZ55zNQdcGY03gfCi9I=
X-Gm-Gg: AYBFou3MBvzOzJvacjW5zaUyA2rFn+aiWAoy/LTbO4dGUR/9jwLcSoS2+dlw9ArdFvW
 /uLJzgcjOuy142GjvckQn482ylIPsUb9TNrrpZjILllaUoErE5v2j5H+sKNzWmODzOTZeG06MBH
 ruWW9R1PKHE73na4etn1Z7RNXKJMoVX3AfpXJHzlVuB5QFxs6gmuD3kKzZhFOILFGNvzDRftryo
 2DBdiarMbKMRKs3OOeDhW4ZnEUlXc8MabFPj8rhRvsoelXbS98m5hPtuF2Hbv9Z5EPh8p5MCxKe
 QU5VeZZTyoFgWsUuIGH5Qrv8h2s/cpVZ20IJ3OjbbZB8l0n14cWxWOyBTNekMya9CXL6F81Jgbb
 3HHJ0nYi5ydy+1GPky/9fxYxK1yw1LUfRPdfIw+szG9TPwxjDLde6QYye0jqF95agH3z0vRgbSL
 uRdmtxrdGfPSDiFWsdqIfzHdmpSjQmEKzxiP8FQg32TCNuACfimvCxdyBacUdWwb24m7RxP9n1A
 eO2lfPn
X-Received: by 2002:a05:600c:608e:b0:4a1:e08e:46b5 with SMTP id
 5b1f17b1804b1-4a1e08e4871mr157389645e9.16.1792493003076; 
 Tue, 20 Oct 2026 03:43:23 -0700 (PDT)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce325107sm289903195e9.3.2026.10.20.03.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 03:43:21 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 37ED55F8DC;
 Tue, 20 Oct 2026 11:43:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Song Gao <17746591750@163.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Bj=C3=B6rn=20Walk?= <bwalk@linux.ibm.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org,
 David Woodhouse <dwmw2@infradead.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-ppc@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, linux-edac@vger.kernel.org,
 Glenn Miles <milesg@linux.ibm.com>, Chao Liu <chao.liu@processmission.com>,
 Cornelia Huck <cohuck@redhat.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Xianglai Li <lixianglai@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>, Zhao Liu <zhao1.liu@intel.com>,
 Weiwei Li <liwei1518@gmail.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 00/23] kvm: introduce KVMCPUOps
Date: Tue, 20 Oct 2026 11:42:54 +0100
Message-ID: <20261020104320.3686723-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is a world coming where we can have a KVM interface which
supports multiple architectures. The old style approach of using
linking to resolve per arch kvm_arch_foo handlers won't scale and is
also slightly antithetical to the flexible not-quite object orientated
way we do things in QEMU.

Taking TCGCpuOps as a reference this implements KVMCpuOps as the
shared function dispatcher for CPU specific KVM operations.

A couple of open questions:

  - should we consider some sort of shared AccelInfo region for
  CPUState instead of a bunch of mutually unused bits
  - how can we improve coverage of KVM testing?

The main driver for writing:

  Message-ID: <20261019192704.3220373-1-alex.bennee@linaro.org>
  Date: Mon, 19 Oct 2026 20:26:45 +0100
  Subject: [PATCH v3 00/19] testing/next: functional testing updates for gdb (pre-PR)
  From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

was so I could be sure the KVMCpuOps where properly working. I don't
think we have that much that exercises KVM in our CI system anyway
because most runners don't give access to HW virtualisation. I have
tested this on:

  - x86_64 (on my dev box)
  - aarch64 (on my personal dev box and the aarch64 ci machine)
  - s390x (on devcloud instance, same as the s390x runner)

Notably I wasn't able to test the riscv64, loongarch64 or ppc64
behaviour. I do have access to the OSUL ppc runner but it doesn't
support nested virt and testing on that machine needs some love anyway
(see #3207).

Anyway I await your discussion ;-)

Alex.

Alex Bennée (23):
  accel: introduce KVMAccelClass and KVMCPUOps
  target/i386: wire up empty KVMAccelCPUClass
  target/ppc: wire up empty KVMAccelCPUClass
  target/riscv: wire up empty KVMAccelCPUClass
  target/arm: wire up empty KVMAccelCPUClass
  target/s390x: wire up empty KVMAccelCPUClass
  target/loongarch: wire up empty KVMAccelCPUClass
  accel/kvm: port kvm_arch_pre_run to KVMCPUOps
  accel/kvm: port kvm_arch_post_run to KVMCPUOps
  accel/kvm: port kvm_arch_handle_exit to KVMCPUOps
  accel/kvm: port kvm_arch_process_async_events to KVMCPUOps
  accel/kvm: port kvm_arch_[put|get]_registers to KVMCPUOps
  accel/kvm: port kvm_arch_pre_create_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_init_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_destroy_vcpu to KVMCPUOps
  accel/kvm: port kvm_arch_vpcu_id to KVMCPUOps
  accel/kvm: port kvm_arch_update_guest_debug to KVMCPUOps
  accel/kvm: port kvm_arch_[insert|remove]_hw_breakpoints to KVMCPUOps
  accel/kvm: remove TARGET_KVM_HAVE_GUEST_DEBUG
  accel/kvm: port kvm_arch_stop_on_emulation_error to KVMCPUOps
  accel/kvm: port kvm_arch_on_sigbus_vcpu to KVMCPUOps
  accel/kvm: cache KVMCPUOps
  accel/kvm: remove redundant ops checks for kvm_get_cpu_ops

 docs/specs/acpi_hest_ghes.rst           |   3 +-
 configs/targets/aarch64-softmmu.mak     |   1 -
 configs/targets/i386-softmmu.mak        |   1 -
 configs/targets/loongarch64-softmmu.mak |   1 -
 configs/targets/ppc-softmmu.mak         |   1 -
 configs/targets/ppc64-softmmu.mak       |   1 -
 configs/targets/riscv64-softmmu.mak     |   1 -
 configs/targets/s390x-softmmu.mak       |   1 -
 configs/targets/x86_64-softmmu.mak      |   1 -
 include/accel/kvm/cpu-ops.h             | 171 ++++++++++++++++++++++
 include/hw/core/cpu.h                   |   3 +
 include/system/kvm.h                    |  42 +-----
 include/system/kvm_int.h                |   2 -
 target/i386/kvm/kvm_i386.h              |  20 +++
 accel/kvm/kvm-accel-ops.c               |  13 +-
 accel/kvm/kvm-all.c                     | 183 +++++++++++++++++-------
 accel/tcg/cpu-exec.c                    |   2 +-
 hw/i386/kvm/xen_evtchn.c                |   6 +-
 hw/intc/openpic_kvm.c                   |   4 +-
 hw/intc/spapr_xive_kvm.c                |  10 +-
 hw/intc/xics_kvm.c                      |   6 +-
 target/arm/kvm.c                        |  96 +++++++------
 target/i386/kvm/kvm-cpu.c               |  26 +++-
 target/i386/kvm/kvm.c                   |  42 +++---
 target/loongarch/cpu.c                  |   8 +-
 target/loongarch/kvm/kvm.c              |  96 ++++++-------
 target/ppc/kvm.c                        |  75 +++++-----
 target/riscv/kvm/kvm-cpu.c              |  95 +++++-------
 target/s390x/kvm/kvm.c                  |  89 +++++++-----
 29 files changed, 628 insertions(+), 372 deletions(-)
 create mode 100644 include/accel/kvm/cpu-ops.h

-- 
2.47.3


