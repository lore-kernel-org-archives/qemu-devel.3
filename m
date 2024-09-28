Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30323CF6495
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2024 11:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suViX-0005LU-W2; Sat, 28 Sep 2024 07:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suViW-0005Ku-Bj
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 07:34:28 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1suViU-00076t-JP
 for qemu-devel@nongnu.org; Sat, 28 Sep 2024 07:34:28 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a8ce5db8668so485815566b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Sep 2024 04:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727523263; x=1728128063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oa+O+Qdevwxsp4agPgwENth31zthndTfKkPIDFq4wzY=;
 b=IHWYVtjRGvZ+QmNIEUUXOl79C6W34akVxV6ApIurAMRpa9exUbL9k9jJuT67xScVyI
 iOb+35Mig00sKpkBEXuLX8xVe4yhhILpTpnpm6nMSyOEjMK0LFiddqVfa6t6Cv+xuo91
 yRpKttgN2OLDbD5UaFdjiIbC4NdEBjEELXHzatN/AAOvz/n4mqNtUzyvdeTHyhlhDncq
 4K8+DpqOjpLMOhePezlFCgXU15uxXiw4JrQJZnKDmcDyitLpwfu7Lc8sfDLXUZFvrfoH
 upgJDhGIiz9QDZ4RljnvVGFZMl2eofipjVM+HL70UXq07QCPRDiCUcgsP31IUDPFTGHD
 kSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727523263; x=1728128063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oa+O+Qdevwxsp4agPgwENth31zthndTfKkPIDFq4wzY=;
 b=GaTXIFsGMNsuQPxhoILsmypvL2DE4h0OypHhP2SfvZY1VvEI2m1wwbP4yuGO2UkV4X
 VXXjDx47hUwtXLhajZvhgCSCp6fIUOP3V/fdCcaertKFYowXGEgFbJLBMLjJO7D+HgYE
 99kuuZ617OUYqloKQdFjbLjojDRhybSECldU/oBXRsWx4yPTBNeI5WOTUd1sL5h0T838
 jPfJ/IifPGHZMvm5FQSkLsV7qltAr2kve1AZwbIT7s96MA1yevGLQUC4iCi6UhkJUiYN
 rNtM7PQvfKM0VhT+4hp/nzxs13MFLA0YhDyX80Ixf14IEagK/6wvRpdiQjimlkxDd6F5
 Ss5g==
X-Gm-Message-State: AOJu0YxXcK2K6WMQcNqJuJbEcAETaetxAucBoGslLusTkvUrEiOocABH
 pQLhPCoLaC89pCoc+ITQbT2GHqq4BxRhauu5B6fVc22MSr1pvC8wv6nnEgzys0je4P9JtB8dWlP
 lhKWKytWVEJ5D/yOnsCmPU0Hc1zb8NxeHjbCLOw==
X-Google-Smtp-Source: AGHT+IFLwkOVmlSL+OXL5Cizs5fKOpMUPc5+w/y/IwcDhjwTdLvAm2ExTGkrs/tFggVSWshPuxgiMGFVeK+/yLK3prk=
X-Received: by 2002:a17:907:1b92:b0:a80:d913:be07 with SMTP id
 a640c23a62f3a-a93c492a39emr396679766b.36.1727523263277; Sat, 28 Sep 2024
 04:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 28 Sep 2024 12:34:11 +0100
Message-ID: <CAFEAcA9Sb-fpNhm-6DPwss5zMpw=nEp31Wt6q1OA6DqCg3wKEg@mail.gmail.com>
Subject: Re: [PULL v2 00/47] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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

On Tue, 24 Sept 2024 at 23:18, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:
>
>   Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240925-1
>
> for you to fetch changes up to 6bfa92c5757fe7a9580e1f6e065076777cae650f:
>
>   bsd-user: Add RISC-V 64-bit Target Configuration and Debug XML Files (2024-09-24 12:53:16 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.2
>
> * Add a property to set vl to ceil(AVL/2)
> * Enable numamem testing for RISC-V
> * Consider MISA bit choice in implied rule
> * Fix the za64rs priv spec requirements
> * Enable Bit Manip for OpenTitan Ibex CPU
> * Fix the group bit setting of AIA with KVM
> * Stop timer with infinite timecmp
> * Add 'fcsr' register to QEMU log as a part of F extension
> * Fix riscv64 build on musl libc
> * Add preliminary textra trigger CSR functions
> * RISC-V IOMMU support
> * RISC-V bsd-user support
> * Respect firmware ELF entry point
> * Add Svvptc extension support
> * Fix masking of rv32 physical address
> * Fix linking problem with semihosting disabled
> * Fix IMSIC interrupt state updates
>

This fails the riscv qos-tests on s390x. My guess is that the new
IOMMU support has endianness bugs and fails on bigendian hosts.

https://gitlab.com/qemu-project/qemu/-/jobs/7942189143

full test log (4MB) at
https://qemu-project.gitlab.io/-/qemu/-/jobs/7942189143/artifacts/build/meson-logs/testlog.txt

The assertion failure is
ERROR:../tests/qtest/riscv-iommu-test.c:72:test_reg_reset: assertion
failed (cap & RISCV_IOMMU_CAP_VERSION == 0x10): (0 == 16)

but there are a lot of virtio errors before that so the
problem probably happened rather earlier.

thanks
-- PMM

