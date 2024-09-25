Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6BFCCF9E7
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 17:25:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stVkp-0005LT-Oz; Wed, 25 Sep 2024 13:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stVkn-0005Bk-7N
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:24:41 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1stVkl-0002Wx-4f
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 13:24:40 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e078d28fe9so112882a91.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2024 10:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727285077; x=1727889877; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lI0IF/9Wf9RfvJhUVbIzN+I/aDVIuibDlnrdMkYD+K4=;
 b=yFKPg3v5P00timOsKpUcz7OB0uVl1ykcza4c67hoKnsXThZxRkjrNaf9KVZJMfnnHj
 nHggCx5clCNW8I21fVHhEHWF8L5nrNg1G9KfIE8qbSpI/FhyjETDGokiirMedfFVkkkX
 V49vQHg3iKLfpaKH1bXGEhnVy1mkYKaFzfXxCDqSAPKj21h2ZEzPSSmfreEz8ziIq3ad
 4epj0wL7EiPjK4q3cZ/QNEh/w8VfhiqxfUibBH+sjnUTfhUhmnflTR/Cw8oiziP+XJFo
 22UijimY6s+3YuBdn6Oq9OtIsT5mZqUQrFI1w6lQSdMDKFLM0/L8o0m2JWii+7nxts86
 enxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727285077; x=1727889877;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lI0IF/9Wf9RfvJhUVbIzN+I/aDVIuibDlnrdMkYD+K4=;
 b=KR+CQvHCnkzUOShYhaOlMh4GdxGdAGTt5IAMT+x6ufCQq4TdZXoZ2l81tzf+TUDP2w
 hvNvLaowNrcTLlFP+3H+jSa0mnOtsiiGmFKeUusR1DwL65kIo0c5wi4+uZCqAFedy3DB
 /itOOM/KLnE5mm4zZnE2acZqd0XeC+PQnsuIQxtwUUPF3VVibl3qWMlcoIRAgo35vhzq
 AAhkDl7O/RhcKDQOmHCiSg+rIq6qxMAJTW1F6ywrmqC8dJ36RTZvmZgYKBPU0yB9YoxS
 Zjjlm+zNQxKGHdxlSdtsMS3I2o9zvjz9vf4kBXZbOU+hJMmwCJFwagpksRUO30IAGPYb
 OXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtFqpCh9A3IX+NdGsnU9eHNQ+ufRON/siPxYZ1+l8MSuR8/rJFe8ltnMZkueXrNrUZdqxDa6WLVg9Y@nongnu.org
X-Gm-Message-State: AOJu0YwPxcfBCOv2Dyo1WuQvF6AhRpnAniRX+EEpCqv+OOE10zSeRof0
 A2DvMYlia+gQnpFzFNA3bO/sNEweG06HqY5bfhqEyF6cC9m6Vmnq9frSGhi2K9c=
X-Google-Smtp-Source: AGHT+IFfz/oSXO8JPxnuCRmSa8+hVqUNRf2rtyFHArFCYrSKKC1WKiqqPLvF9tIpycBROF8nXg6V9w==
X-Received: by 2002:a17:90b:4a11:b0:2d1:c9c8:301c with SMTP id
 98e67ed59e1d1-2e06afbdf1bmr3698398a91.29.1727285077581; 
 Wed, 25 Sep 2024 10:24:37 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e06e28afbasm1767831a91.43.2024.09.25.10.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2024 10:24:37 -0700 (PDT)
Message-ID: <86372271-318e-49ae-8fa6-83faceba9b0c@linaro.org>
Date: Wed, 25 Sep 2024 10:24:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/44] Functional test conversion, and assert(0) cleanup
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
References: <20240925111029.24082-1-thuth@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/25/24 04:09, Thomas Huth wrote:
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
> 
>    Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-25
> 
> for you to fetch changes up to dc05b2628e3913e668590ba66d9c618382d351ae:
> 
>    .gitlab-ci.d: Make separate collapsible log sections for build and test (2024-09-25 09:42:06 +0200)
> 
> ----------------------------------------------------------------
> * Convert more Avocado tests to the new functional test framework
> * Clean up assert() statements, use g_assert_not_reached() when possible
> * Improve output of the gitlab CI jobs
> 
> ----------------------------------------------------------------
> Peter Maydell (2):
>        .gitlab-ci.d: Split build and test in cross build job templates
>        .gitlab-ci.d: Make separate collapsible log sections for build and test
> 
> Pierrick Bouvier (34):
>        hw/acpi: replace assert(0) with g_assert_not_reached()
>        hw/arm: replace assert(0) with g_assert_not_reached()
>        hw/net: replace assert(0) with g_assert_not_reached()
>        migration: replace assert(0) with g_assert_not_reached()
>        qobject: replace assert(0) with g_assert_not_reached()
>        target/ppc: replace assert(0) with g_assert_not_reached()
>        block: replace assert(false) with g_assert_not_reached()
>        hw/hyperv: replace assert(false) with g_assert_not_reached()
>        hw/net: replace assert(false) with g_assert_not_reached()
>        hw/nvme: replace assert(false) with g_assert_not_reached()
>        hw/pci: replace assert(false) with g_assert_not_reached()
>        hw/ppc: replace assert(false) with g_assert_not_reached()
>        migration: replace assert(false) with g_assert_not_reached()
>        target/i386/kvm: replace assert(false) with g_assert_not_reached()
>        accel/tcg: remove break after g_assert_not_reached()
>        block: remove break after g_assert_not_reached()
>        hw/acpi: remove break after g_assert_not_reached()
>        hw/net: remove break after g_assert_not_reached()
>        hw/scsi: remove break after g_assert_not_reached()
>        hw/tpm: remove break after g_assert_not_reached()
>        target/arm: remove break after g_assert_not_reached()
>        target/riscv: remove break after g_assert_not_reached()
>        fpu: remove break after g_assert_not_reached()
>        tcg/loongarch64: remove break after g_assert_not_reached()
>        include/qemu: remove return after g_assert_not_reached()
>        hw/hyperv: remove return after g_assert_not_reached()
>        hw/net: remove return after g_assert_not_reached()
>        hw/pci: remove return after g_assert_not_reached()
>        hw/ppc: remove return after g_assert_not_reached()
>        migration: remove return after g_assert_not_reached()
>        qobject: remove return after g_assert_not_reached()
>        qom: remove return after g_assert_not_reached()
>        tests/qtest: remove return after g_assert_not_reached()
>        scripts/checkpatch.pl: emit error when using assert(false)
> 
> Thomas Huth (8):
>        tests/functional/qemu_test: Add a function for launching kernels more easily
>        tests/functional: Convert the vexpressa9 Avocado test
>        tests/functional: Convert the xtensa lx60 Avocado test
>        tests/functional: Convert the SPARCStation Avocado test
>        tests/functional: Convert the e500 ppc64 Avocado test
>        tests/functional: Convert the mac ppc Avocado tests
>        tests/functional: Convert the r2d sh4 Avocado test
>        tests/functional: Convert the powernv tests from boot_linux_console.py
> 
>   MAINTAINERS                               |   7 ++
>   include/qemu/pmem.h                       |   1 -
>   accel/tcg/plugin-gen.c                    |   1 -
>   block/qcow2.c                             |   2 +-
>   block/ssh.c                               |   1 -
>   hw/acpi/aml-build.c                       |   3 +-
>   hw/arm/highbank.c                         |   2 +-
>   hw/hyperv/hyperv_testdev.c                |   7 +-
>   hw/hyperv/vmbus.c                         |  15 ++--
>   hw/net/e1000e_core.c                      |   4 +-
>   hw/net/i82596.c                           |   2 +-
>   hw/net/igb_core.c                         |   4 +-
>   hw/net/net_rx_pkt.c                       |   3 +-
>   hw/net/vmxnet3.c                          |   1 -
>   hw/nvme/ctrl.c                            |   8 +-
>   hw/pci/pci-stub.c                         |   6 +-
>   hw/ppc/ppc.c                              |   1 -
>   hw/ppc/spapr_events.c                     |   3 +-
>   hw/scsi/virtio-scsi.c                     |   1 -
>   hw/tpm/tpm_spapr.c                        |   1 -
>   migration/dirtyrate.c                     |   3 +-
>   migration/migration-hmp-cmds.c            |   2 +-
>   migration/postcopy-ram.c                  |  21 ++---
>   migration/ram.c                           |   8 +-
>   qobject/qlit.c                            |   2 +-
>   qobject/qnum.c                            |  12 +--
>   qom/object.c                              |   1 -
>   target/arm/hyp_gdbstub.c                  |   1 -
>   target/i386/kvm/kvm.c                     |   4 +-
>   target/ppc/dfp_helper.c                   |   8 +-
>   target/ppc/mmu_helper.c                   |   2 +-
>   target/riscv/monitor.c                    |   1 -
>   tests/qtest/acpi-utils.c                  |   1 -
>   fpu/softfloat-parts.c.inc                 |   2 -
>   target/riscv/insn_trans/trans_rvv.c.inc   |   2 -
>   tcg/loongarch64/tcg-target.c.inc          |   1 -
>   .gitlab-ci.d/buildtest-template.yml       |  14 +++
>   .gitlab-ci.d/buildtest.yml                |   1 +
>   .gitlab-ci.d/crossbuild-template.yml      |  48 ++++++++++-
>   scripts/checkpatch.pl                     |   4 +
>   scripts/ci/gitlab-ci-section              |  29 +++++++
>   tests/avocado/boot_linux_console.py       | 138 ------------------------------
>   tests/functional/meson.build              |  15 ++++
>   tests/functional/qemu_test/linuxkernel.py |  12 +++
>   tests/functional/test_arm_vexpress.py     |  26 ++++++
>   tests/functional/test_ppc64_e500.py       |  25 ++++++
>   tests/functional/test_ppc64_powernv.py    |  42 ++++++++-
>   tests/functional/test_ppc_mac.py          |  38 ++++++++
>   tests/functional/test_sh4_r2d.py          |  31 +++++++
>   tests/functional/test_sparc_sun4m.py      |  25 ++++++
>   tests/functional/test_xtensa_lx60.py      |  26 ++++++
>   51 files changed, 384 insertions(+), 234 deletions(-)
>   create mode 100644 scripts/ci/gitlab-ci-section
>   create mode 100755 tests/functional/test_arm_vexpress.py
>   create mode 100755 tests/functional/test_ppc64_e500.py
>   create mode 100755 tests/functional/test_ppc_mac.py
>   create mode 100755 tests/functional/test_sh4_r2d.py
>   create mode 100755 tests/functional/test_sparc_sun4m.py
>   create mode 100755 tests/functional/test_xtensa_lx60.py
> 

Thanks for pulling the assert cleanup series.

