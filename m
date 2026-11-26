Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1C606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 05:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x+ObdLBs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWS1c-0004Cz-94; Thu, 26 Nov 2026 00:28:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1U-0004CM-Jv
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:27:56 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haseebashraf091@gmail.com>)
 id 1xWS1Q-0001m3-Rx
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 00:27:55 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb69f5b161so42585715e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 21:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795670869; x=1796275669; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AkjNBLINr97Ghaaxsr3+fYKKHZYr6vV/k1JPP2Uq09A=;
 b=x+ObdLBswawM1FPfYYbMrrdMXvYMEQy2chkz5PCRdHwGXSLNdxSYR+gp3GkgT0usqw
 p9zCS5E6T5QuUSs/iWDTfZFinQnSDWKjzH5/tzU0MPw9R4BRxShNe+An15RErWZnKLHj
 c5DyzuvVZ2VUR4oJsToU6gAVXDxPQpbCOHA1dXJvSFwiSxeFNCYbvlqxGe+WXAFEWjNS
 fSKQ0xruTXWrx1WoWtIgYFfjpRRViG1S3LWeskDvzKQk3xZ7/JjiecUlnhZ7TCWa3jal
 xrNaqfEXar/YhTHCLp4J3MoxFL8x7lLpUUL8IoRF+E0Hig7F8+swfx9kx7WLdHM8mz+V
 KTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795670869; x=1796275669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AkjNBLINr97Ghaaxsr3+fYKKHZYr6vV/k1JPP2Uq09A=;
 b=k19sIoGQWBHqoxhXL3RdsXjmkImre94aFgGJkn4QhMGPBlKDMb/b3OX+A32BRFw+2e
 Z1ClBHKLqQaEAiV7644MA/jWaokNbgzOixWYB0T8Z/wa26RC24cdSnFgHDWEphs7e3/3
 c/BtaSICfCDWHz1EFfT4sxysgrM67DRfvFy9IDUBmfDllL/4kVf9DY5IWE/yLkAPrZxi
 nkIaQgRjMvH8zjePlDGgxfe0a4FgtX/hpkqb0SvWar6xa1RAJSjZEAuDPh8c/3UaN4tz
 MVPNyHK2JxHBJrWPXobIzuhTRsu5X55rgmpwxUoP1q+tcM2IXyE9sA+DW1Pcys3mkvvo
 PHcQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEaT3H4IQCDMsyzosaSdCTUbQsGBkfU1R5K3hXqeeW4Ni2scqvaclQlB4UpboUDAfGA549Af6bBcYs4@nongnu.org
X-Gm-Message-State: APuU4Z/IV5MpUuAV36BKlqNx2Dnfxy+kj4arKRlbN26osnxVF1nWg7nr
 reJyzslPm2RdUVKB/INJdMFC6PXCxr04Tv4SB9UdpiK/QxkqJ9fO8FPV
X-Gm-Gg: AZFdTZcMGrOeiaDOb9ud8oHZcJE3W1cEgWySei/v1rg8TlN3GfrHLAwcSKw5UoMJ2Az
 s3OR09IZCPJtx74WZIUTREClGbUoePT5g9MzVmgw06IbSLIbjhkSBd5SyuyC6Xi9Wd4VukA9N59
 EBftOlViOwt1WVxytivbE+rlv34iahB6J16XfR6/K23adzG/p5gKjR7opYQ3ne7+voFvZdSR6NE
 zFK9z0HkaKD732enXiLVxPT0C99TFBy25zwtC96skuMKdwHIp36NU+OM5MZbVq5qdpihO24cqSr
 IW1Z0gV4Fo+DbSN/9OvSmgIv+Kx/dW/fwApOLSX1oNvVAiLac/Ea3+GvWLEeBU7rOxngYFfK4aA
 1jAts3EpSpeSxawSQpZ+XAhALfEGEiWQrmSI8A4dVbgMEzJROdMB2EXHSLHsYsNfthi5d157ffe
 ic25hx4lEvDKcVAOaFhOUyQjm7buFySB2/bwtL1oX8sdrxfo/36yefatsrP2eCKW3B3uXLZEATg
 +iLG7uLhVq1hWwrB/kz5B6NyNq/OTo2MgAt3N1kd5oW85hOfmThAOx6G5+TqWaEuL2AqZlYhOe+
 eg32u2mWBwCmRkhyfCgQv8u373UBCgkp8OHHZufwSRs1oXW7kT9wKizuVeco84sCtyzq9x+EP7a
 l4fQrOeyBUx7dwgsjH2auk3vOiOJf/3zdDSlDbbtqj6J1CA==
X-Received: by 2002:a05:600c:1548:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4bb88800020mr427751485e9.7.1795670869141; 
 Wed, 25 Nov 2026 21:27:49 -0800 (PST)
Received: from PKL-HASEEBA-LT.. ([39.36.25.192])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b2437sm808310475e9.13.2026.11.25.21.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 21:27:48 -0800 (PST)
From: Haseeb Ashraf <haseebashraf091@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-arm@nongnu.org
Cc: Haseeb Ashraf <haseeb.ashraf@siemens.com>,
 Eric Auger <eric.auger@redhat.com>,
 Khushit Shah <khushit.shah@nutanix.com>, Marc Zyngier <maz@kernel.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: [RFC PATCH v3 0/3] arm/kvm: select an nVHE-only EL2 with
 SYSREG_ID_AA64MMFR1_EL1_VH
Date: Thu, 26 Nov 2026 10:27:38 +0500
Message-ID: <20261126052741.90607-1-haseebashraf091@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121204601.741616-1-haseebashraf091@gmail.com>
References: <20261121204601.741616-1-haseebashraf091@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=haseebashraf091@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Haseeb Ashraf <haseeb.ashraf@siemens.com>

Hi,

KVM presents a VHE-only EL2 (HCR_EL2.E2H RES1) to a nested guest unless
KVM_ARM_VCPU_HAS_EL2_E2H0 is requested at vCPU initialization. This RFC
lets an nVHE-only guest hypervisor request that mode through:

  -M virt,virtualization=on -accel kvm \
      -cpu host,SYSREG_ID_AA64MMFR1_EL1_VH=0

The series builds on Eric Auger's remaining v11 SYSREG framework. It is
based on the rebased prerequisite commit corresponding to Eric's
arm-cpu-model-v11-rc tip e32893ddcbe643d47919f55ae33ff71be2609a77.
This dependency is intentional: a version which works without that
framework would have to introduce a separate machine or CPU property,
which was the approach rejected by Marc in v1.

References:

  - Eric's v11 series:
    https://patchew.org/QEMU/20261030131406.461599-1-eric.auger@redhat.com/
  - Eric's v11-rc branch:
    https://github.com/eauger/qemu/commits/arm-cpu-model-v11-rc
  - My v1:
    https://patchew.org/QEMU/20261121095636.289814-1-haseebashraf091@gmail.com/

Changes since v2:

  - Apply init-driven SYSREG properties before creating the scratch
    vCPU, so full CPU-model expansion reflects the requested init mode.
  - Refresh ID_AA64MMFR1_EL1 and ID_AA64MMFR4_EL1 from KVM after vCPU
    initialization, keeping QEMU's cached model and QMP expansion in
    sync with the guest-visible registers.

Eric correctly pointed out that KVM already updates the guest-visible
derived ID registers. The v2 gap was limited to QEMU's cache/model
expansion view; v3 fixes that without changing the guest-visible
behavior.  With VH=0, query-cpu-model-expansion now reports
ID_AA64MMFR4_EL1.NV_frac=0; with VH=1 it reports 1.

For the init-driven property question, this series keeps VH as an
explicit exception because KVM_CAP_ARM_EL2_E2H0 currently exposes no
writable-ID-register equivalent.  A generic framework table can be
considered if more such fields arise; there is no need to add a broader
abstraction for this single case.

This RFC therefore also asks maintainers to confirm that using a
SYSREG_<REG>_<FIELD> property for a value selected at vCPU init is an
acceptable extension of Eric's framework. If that model is not
accepted, this nVHE functionality should wait for the framework
direction to settle. The standalone-property implementation from v1 is
available as a fallback for the implementation discussion, but I would
prefer not to make that upstream direction the default again.

TCG and HVF are unchanged by design.

Testing on an AmpereOne A192-32X with host kernel 6.18.29-arm64:

  - TCG-only and KVM-only builds succeeded.
  - TCG rejects SYSREG_ID_AA64MMFR1_EL1_VH.
  - arm-cpu-features passed.
  - All three AArch64 KVM functional selftests passed.
  - QMP full expansion reports the KVM-derived MMFR4 state for both
    VH=0 and VH=1.
  - Linux 6.12.67 initialized KVM in nVHE mode with VH=0 and VHE mode
    with VH=1; QNX Hypervisor 8.0.5 reached login with both values.
  - Xen dom0 reached login with VH=0 and did not boot with VH=1.

Thanks,
Haseeb

Haseeb Ashraf (3):
  target/arm/kvm: Add kvm_arm_el2_e2h0_supported()
  target/arm/kvm: Let SYSREG_ID_AA64MMFR1_EL1_VH select an nVHE EL2
  tests/functional: Add a KVM selftest for an nVHE-only EL2

 docs/system/arm/cpu-features.rst     | 22 ++++++++++
 target/arm/arm-qmp-cmds.c            | 38 +++++++++++++++++
 target/arm/cpu-idregs.h              | 31 ++++++++++++++
 target/arm/cpu64.c                   | 51 +++++++++++++++++-----
 target/arm/kvm-stub.c                | 10 +++++
 target/arm/kvm.c                     | 63 ++++++++++++++++++++++++++--
 target/arm/kvm_arm.h                 | 21 ++++++++++
 tests/functional/aarch64/test_kvm.py | 22 +++++++++-
 8 files changed, 242 insertions(+), 16 deletions(-)
-- 
2.34.1


