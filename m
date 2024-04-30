Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34431C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 11:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1m4T-0002lM-F8; Tue, 30 Apr 2024 07:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1m4R-0002l3-Me
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:54:51 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1m4P-0003nn-Tf
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 07:54:51 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5709cb80b03so5704639a12.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714478088; x=1715082888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/w8ZfqcwLDuaXEK2065a8lJ15TslsQ7OuTKnRb73YNA=;
 b=fdG1CZAzYkAwvOZUDz+lYca7fTDrrAjatsanBfzofYm2ouvS6rJ1/xdY07OHlrbISL
 dG12jiFB5io8XIr02AYXCTUoMqVrOXIpH0axADLnv7AsuCk0dTUufdxhzl4rjBXuFiKS
 TydbWBRScEMHvRBOAT4WfU7XPH9/DYTqJy26vFxydP0QjYs4x72diTwyS2f8ncRQyY4G
 /AQAMvYysJdbUKv0lwxrZNtSRTSyKDyUik7MSg3ytmd++DkEeYvyUJsGUdmY8P5hujGN
 utFoPbNnyZwFIMFutWD8cYQhngqsyEd+I9UPh/3wCqvebRGhnm2iifHGIDewTVqbtOwV
 OvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714478088; x=1715082888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/w8ZfqcwLDuaXEK2065a8lJ15TslsQ7OuTKnRb73YNA=;
 b=iUbbMoieTDi5tffGESxCBtoyoWJ8XCdX2myTBPqKaLTtBWIJsLWN/47igjDi6hCAaQ
 85SBSp0PLNNeQDH8DH1SfhXKRO1752kHCk6LbT1V01XvUEzsAQi3FsbkuUGwqxMumAM+
 RJjyMHrTYlVM28tSPfSriNShftpwuZBI5V8T8SNPdWUAcg3oPOi2bTmvGLAELeCdlEnx
 A/yDgbU9umRFLFQNXO+bs38OH3LzyHq8gvJn8HBLhhCKj0/odC2xJK1BIyiJbDRXN2fr
 5UWSiPdh5JdX4hTeQEfeernK+H8rcZ32BEYXCpZJGoqBBCEJQToM7ceBFvpHNquZ5wYX
 /Bkg==
X-Gm-Message-State: AOJu0YxR+lAhpXd/3QFZTMArGf0Y5Y0+qfsDTK8Uy0RbALEu+zWNB83X
 QubpPyGsUkdsf4qVL38FPAP1ZQulycaAZrlkPhftC8offHnoWpQBMn44xc/x8icnCy8EcqCd5hR
 mlLEa5f1FS0Nx/cHBFl5HbAN701sFTNStR0RWow==
X-Google-Smtp-Source: AGHT+IELyCgUqfF8XYS5QA8tJgG1LetZJYN9YpJup//taoTT78/6RlzJCbyTVqiutyHpovf31tM1jmEuGZNtQ9Wh6s8=
X-Received: by 2002:a50:d555:0:b0:572:a158:8a7c with SMTP id
 f21-20020a50d555000000b00572a1588a7cmr396552edj.42.1714478087785; Tue, 30 Apr
 2024 04:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231114020927.62315-1-j@getutm.app>
In-Reply-To: <20231114020927.62315-1-j@getutm.app>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Apr 2024 12:54:36 +0100
Message-ID: <CAFEAcA97U9Z-NAdkJ688EmPWycZtVQR5eP11-pDBBnxyd54b_A@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] tpm: introduce TPM CRB SysBus device
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 14 Nov 2023 at 02:10, Joelle van Dyne <j@getutm.app> wrote:
> The impetus for this patch set is to get TPM 2.0 working on Windows 11 ARM64.
> Windows' tpm.sys does not seem to work on a TPM TIS device (as verified with
> VMWare's implementation). However, the current TPM CRB device uses a fixed
> system bus address that is reserved for RAM in ARM64 Virt machines.
>
> In the process of adding the TPM CRB SysBus device, we also went ahead and
> cleaned up some of the existing TPM hardware code and fixed some bugs. We used
> the TPM TIS devices as a template for the TPM CRB devices and refactored out
> common code. We moved the ACPI DSDT generation to the device in order to handle
> dynamic base address requirements as well as reduce redundent code in different
> machine ACPI generation. We also changed the tpm_crb device to use the ISA bus
> instead of depending on the default system bus as the device only was built for
> the PC configuration.
>
> Another change is that the TPM CRB registers are now mapped in the same way that
> the pflash ROM devices are mapped. It is a memory region whose writes are
> trapped as MMIO accesses. This was needed because Apple Silicon does not decode
> LDP (AARCH64 load pair of registers) caused page faults. @agraf suggested that
> we do this to avoid having to do AARCH64 decoding in the HVF backend's fault
> handler.

I had a conversation about this on IRC a week or so back (though I
forget who with, sorry) that made me realise there's a problem with this
approach, and I wanted to write that up for the mailing list.

The problem with turning this into a memory-backed device rather than
an MMIO backed device is that it breaks KVM on Arm CPUs which don't
have FEAT_S2FWB (i.e. anything older than Armv8.4). This is because
without FEAT_S2FWB the guest and host will disagree about the memory
attributes of the region:
 * the host knows this is RAM backed and it's normal-cacheable
   (certainly as far as the mapping that QEMU itself has)
 * the guest thinks it's real hardware device registers and maps it
   as Device
The resulting mismatch in cacheability attributes can cause unexpected
behaviour where the guest and QEMU views of the memory contents don't
necessarily match up. (This is the same underlying issue that means
that you can't use QEMU devices that emulate VGA framebuffers on
AArch64 KVM without FEAT_S2FWB.)

With FEAT_S2FWB the problem goes away because the hypervisor can
override the guest's specified memory attributes to get rid of
the attribute mismatch.

So given that this would cause a regression for KVM, my preference
is to stick with the current "the device is backed by MMIO read
and write functions in the normal way". If a particular guest is
trying to access it with LDP/STP that is best fixed in the guest.

Potentially we could emulate (interpret) some subset of complex
load/store insns in QEMU at the point where we get the "took a
data abort but no syndrome information". This ought to be doable
in a way that's shareable between hvf and KVM, and we can write
a decodetree file for the insns we want to interpret. (I would
not try to share with TCG decodetree, though the patterns can
probably be copied across.)

thanks
-- PMM

