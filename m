Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A89C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 16:01:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqex-0001Om-6z; Fri, 19 Apr 2024 12:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeY-00014t-6U
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1rxqeT-00015N-NZ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:59:53 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-419c8c314d4so2902625e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713542387; x=1714147187; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wF2tUJhmRvxM/T9bOvPLdjIMa/R/CPSkeOISd4fhQks=;
 b=SfgLhn10dTv6h5Y1T+oLUfxgy3Khm9RiK/I9Dx3m2n6n1rYEs0jKdCg3STrVzBEW7I
 Zd3QngQGudESwR0WPRoOiWsSRqv/uIw9F2pyRtbaL/Ejs3Rlr/E4ygB5hsMswCJ9aA6e
 pizmaKJah5468ugT0N8L6ZbgN7qMSjbz3LmhRYsmttUwkIefhGQ8jE74d8goWZ6Sc9jW
 vQ93s1RtBwJPRPJmBiC27TwK7ClJ+1s9bXpGG3NcjRSNUVVB+Z+GpnsAF33Q8B0fgyMo
 TcxAu5loCXlw/SOsh2Q1r7LcsRNthzUjPDZrE/kSwAOXz8jfAfGiHnO9oCYZFbndy7VY
 PL9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713542387; x=1714147187;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wF2tUJhmRvxM/T9bOvPLdjIMa/R/CPSkeOISd4fhQks=;
 b=HalZbJLPa7m/GoW6ptJ/CKaztkdFJVRCWx/RShq9vtxpzVoon8JwtYBBJnWDpXN4DV
 SoAm4+otn+qtMlN2Urk6Hs6/gYtQyep1ezZjr1ErisPlIEmAvaryknhJPtrIV4gF7KTI
 ENHOnh9vYMEcKfHxOpI7K/YXdGTHI7x74cKmwP3V7F4k8M22U6W8o9VSmg4StFmVVlhT
 MTthQAonXFw/w5DAFnT4YnpYIx04CLHSzuZ7KnKVcqQ8h3RnY/1gC3+SANGmzAtynq41
 dnIrFq20uABlqP1SBmZtdrOxZv0G2p5XDTN/Tk1RmnrO71FFl6P7qb/BWkc5k6MZgD7Q
 GDbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEN+eVmwPmOoNBkegVFiV71SKDuf+3NfAeEISrD2vv7yA4ouyfDonTA3EN5ME5AsZEZi6UoIkp4AQXi2g6reP0GWEueJI=
X-Gm-Message-State: AOJu0Yz0qGxJ2tcMYgNPIgEkHHflwwmjykBPCR+aHyhkGk6fG80QKJoQ
 DaDDiwrHbmayl52X/aOfbtwByU3Cf9VAkmyUd5JJJlmyjH/cc7PoCT6FtKUuHdI=
X-Google-Smtp-Source: AGHT+IEiRI0eMWirDzLkMfmstUZjsYIpT5VQHFucWRVWQQLXNXR8Do1zelw3/ID4ONhnZvX3HWIgqw==
X-Received: by 2002:adf:e60d:0:b0:34a:4f5a:ac20 with SMTP id
 p13-20020adfe60d000000b0034a4f5aac20mr1535118wrm.11.1713542386895; 
 Fri, 19 Apr 2024 08:59:46 -0700 (PDT)
Received: from localhost.localdomain ([2.221.137.100])
 by smtp.gmail.com with ESMTPSA id
 p13-20020adfe60d000000b00349b73143e7sm4793089wrm.75.2024.04.19.08.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 08:59:46 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: peter.maydell@linaro.org,
	richard.henderson@linaro.org
Cc: philmd@linaro.org, pbonzini@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH v2 00/22] arm: Run CCA VMs with KVM
Date: Fri, 19 Apr 2024 16:56:48 +0100
Message-ID: <20240419155709.318866-2-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

These patches enable launching a confidential guest with QEMU KVM on
Arm. The KVM changes for CCA have now been posted as v2 [1]. Launching a
confidential VM requires two additional command-line parameters:

        -M confidential-guest-support=rme0
        -object rme-guest,id=rme0

Since the RFC [2] I tried to address all review comments, and added a
few features:

* Enabled support for guest memfd by Xiaoyao Li and Chao Peng [3].
  Guest memfd is mandatory for CCA.

* Support firmware boot (edk2).

* Use CPU command-line arguments for Realm parameters. SVE vector length
  uses the existing sve<N> -cpu parameters, while breakpoints, watchpoints
  and PMU counters use new CPU parameters.

The full series based on the memfd patches is at:
https://git.codelinaro.org/linaro/dcap/qemu.git branch cca/v2

Please find instructions for building and running the whole CCA stack at:
https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/Building+an+RME+stack+for+QEMU

[1] https://lore.kernel.org/kvm/20240412084056.1733704-1-steven.price@arm.com/
[2] https://lore.kernel.org/all/20230127150727.612594-1-jean-philippe@linaro.org/
[3] https://lore.kernel.org/qemu-devel/20240322181116.1228416-1-pbonzini@redhat.com/

Jean-Philippe Brucker (22):
  kvm: Merge kvm_check_extension() and kvm_vm_check_extension()
  target/arm: Add confidential guest support
  target/arm/kvm: Return immediately on error in kvm_arch_init()
  target/arm/kvm-rme: Initialize realm
  hw/arm/virt: Add support for Arm RME
  hw/arm/virt: Disable DTB randomness for confidential VMs
  hw/arm/virt: Reserve one bit of guest-physical address for RME
  target/arm/kvm: Split kvm_arch_get/put_registers
  target/arm/kvm-rme: Initialize vCPU
  target/arm/kvm: Create scratch VM as Realm if necessary
  hw/core/loader: Add ROM loader notifier
  target/arm/kvm-rme: Populate Realm memory
  hw/arm/boot: Register Linux BSS section for confidential guests
  target/arm/kvm-rme: Add Realm Personalization Value parameter
  target/arm/kvm-rme: Add measurement algorithm property
  target/arm/cpu: Set number of breakpoints and watchpoints in KVM
  target/arm/cpu: Set number of PMU counters in KVM
  target/arm/kvm: Disable Realm reboot
  target/arm/cpu: Inform about reading confidential CPU registers
  target/arm/kvm-rme: Enable guest memfd
  hw/arm/virt: Move virt_flash_create() to machvirt_init()
  hw/arm/virt: Use RAM instead of flash for confidential guest firmware

 docs/system/arm/virt.rst                   |   9 +-
 docs/system/confidential-guest-support.rst |   1 +
 qapi/qom.json                              |  34 +-
 include/hw/arm/boot.h                      |   9 +
 include/hw/arm/virt.h                      |   2 +-
 include/hw/loader.h                        |  15 +
 include/sysemu/kvm.h                       |   2 -
 include/sysemu/kvm_int.h                   |   1 +
 target/arm/cpu.h                           |  10 +
 target/arm/kvm_arm.h                       |  25 ++
 accel/kvm/kvm-all.c                        |  34 +-
 hw/arm/boot.c                              |  45 ++-
 hw/arm/virt.c                              | 118 ++++--
 hw/core/loader.c                           |  15 +
 target/arm/arm-qmp-cmds.c                  |   1 +
 target/arm/cpu.c                           |   5 +
 target/arm/cpu64.c                         | 118 ++++++
 target/arm/kvm-rme.c                       | 413 +++++++++++++++++++++
 target/arm/kvm.c                           | 200 +++++++++-
 target/i386/kvm/kvm.c                      |   6 +-
 target/ppc/kvm.c                           |  36 +-
 target/arm/meson.build                     |   7 +-
 22 files changed, 1023 insertions(+), 83 deletions(-)
 create mode 100644 target/arm/kvm-rme.c

-- 
2.44.0


