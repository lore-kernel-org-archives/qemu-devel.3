Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72668C54E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 16:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhY6q-0002T8-N0; Tue, 05 Mar 2024 11:57:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhY6n-0002Si-TE
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:57:41 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhY6k-0003XU-AP
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 11:57:41 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2d28387db09so71543531fa.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 08:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709657856; x=1710262656; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ExHJlsRhD5XE2ARtIH6VPdj3dhaUg4TXyWFlXRc3rC4=;
 b=DVaRjoTdvmNqDKnCDkPKw+8vs4fsKdlSir1691p9Qx+OlrTK7NW/Uziatz9xhpHkzZ
 BGiZTvwKM4WE+XXbllakIN8lZq5hCmAf5gaFdv9NM9EEe35xqBLwQbtUU1MKwtDUPPxE
 Aq+DyECI+BADexgWwT3+PDZoEQlSMeakq6sNtPUjS5NsClvGHY3X/HYoOJK7z4SpSUCX
 0A6rPudAZrbSaqnX7kdvH8cHxplFN2Xi+k/TglCvWounfQjnus9awwfBdWImeThveXNW
 xIieVhbwpp2nqDUCXmp+Kgowqb9UWRBRYd/nfY3pEHdm/9k1Vnn+lUDJpT0Z8fxivPsY
 fU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709657856; x=1710262656;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExHJlsRhD5XE2ARtIH6VPdj3dhaUg4TXyWFlXRc3rC4=;
 b=QCGrZrByFPAXNkVLk7LDQrEeNPhjcM8pglpF53i00XSI7GQ9evo7SOWVKinDOEGyfL
 Z8yEAimRCrRDfBjx9M8THxl60mvOmnDuDmL5hZhi1Ns3o1XzNV4s/yR5Ok6hjksSKjsk
 IK0qEGfehogssNOPL3LwxSMmY1sjkDBUGFw4yD0eWFJ95zV6sCNwZ8drcYa1L2kYzhgB
 eaUXj2Tx8LtdMIsccD0PHVYUH4ny13gHxgAcQLWbiRoTSWWYyENz4WI9YQWqskPq5jnj
 +0rt4DCiwXkM80TPxQEsQweaA/NdgBOCevois0yoRaJZbkvPAeZEFEIVKHdCf6r77mPx
 ujEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/hwfLNCtYvfc6XwqOTJtBZyd7kyK3dFWhm4L2Tvh0UhwsqS9DDk9dgCvoZkCackz5o41Ehsua3o32iYxg0ryUvTbVE/A=
X-Gm-Message-State: AOJu0YwpNTM8PWeFfKnjprTL4v8Rnpfriz1NfI07YdbsC2O4QmyV8yDV
 HZbxMpyo/OO2BU9gPAsZHSNEMzp+q5gCHgvPbwqHNSp6CZOBH1PpzbEtnTPyiiaRXVA8cRvZMVd
 QVpob80H4cgb37OOvKlkaix+QUBJXthYLQJUcIQ==
X-Google-Smtp-Source: AGHT+IFBe+Os+97yFox7rS515ZEif4+gSeuYBItbmINUw1rfR9Np325RVpHO5j+3VB/G1+BGR6aXX+acTIE++aYJb88=
X-Received: by 2002:a2e:8846:0:b0:2d3:f4f1:ad7f with SMTP id
 z6-20020a2e8846000000b002d3f4f1ad7fmr1514761ljj.33.1709657856459; Tue, 05 Mar
 2024 08:57:36 -0800 (PST)
MIME-Version: 1.0
References: <20240209160039.677865-1-eric.auger@redhat.com>
In-Reply-To: <20240209160039.677865-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 16:57:25 +0000
Message-ID: <CAFEAcA_i7x=F-mDgkoa4Tma1xGH0no+WCfNt2Ljyk3DYhHNTiQ@mail.gmail.com>
Subject: Re: [RFC v2 0/5] ARM Nested Virt Support
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 miguel.luis@oracle.com, haibo.xu@linaro.org, richard.henderson@linaro.org, 
 maz@kernel.org, gkulkarni@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Fri, 9 Feb 2024 at 16:00, Eric Auger <eric.auger@redhat.com> wrote:
>
> This series adds ARM Nested Virtualization support in KVM mode.
> This is a respin of previous contributions from Miguel [1] and Haibo [2].
>
> This was tested with Marc's v11 [3] on Ampere HW with fedora L1 guest and
> L2 guests booted without EDK2. However it does not work yet with
> EDK2 but it looks unrelated to this qemu integration (host hard lockups).
>
> The host needs to be booted with "kvm-arm.mode=nested" option and
> qemu needs to be invoked with :
>
> -machine virt,virtualization=on
>
> There is a known issue with hosts supporting SVE. Kernel does not support both
> SVE and NV2 and the current qemu integration has an issue with the
> scratch_host_vcpu startup because both are enabled if exposed by the kernel.
> This is independent on whether sve is disabled on the command line. Unfortunately
> I lost access to the HW that expose that issue so I couldn't fix it in this
> version.
>
> This series can be found at:
> https://github.com/eauger/qemu/tree/v8.2-nv-rfcv2
>
> Previous version from Miguel:
> [1] https://lore.kernel.org/all/20230227163718.62003-1-miguel.luis@oracle.com/
> Previous version from Haibo:
> [2] https://lore.kernel.org/qemu-devel/cover.1617281290.git.haibo.xu@linaro.org/
> [3] Marc's kernel v11 series:
>     [PATCH v11 00/43] KVM: arm64: Nested Virtualization support (FEAT_NV2 only)
>     https://lore.kernel.org/linux-arm-kernel/20231120131027.854038-1-maz@kernel.org/T/
>     available at: https://github.com/eauger/linux/tree/nv-6.8-nv2-v11
>
> Haibo Xu (5):
>   [Placeholder] headers: Partial headers update for NV2 enablement
>   hw/arm: Allow setting KVM vGIC maintenance IRQ
>   target/arm/kvm: Add helper to detect EL2 when using KVM
>   target/arm: Enable feature ARM_FEATURE_EL2 if EL2 is supported
>   hw/arm/virt: Allow virt extensions with KVM
>
>  hw/arm/virt.c                      |  6 +++++-
>  hw/intc/arm_gicv3_common.c         |  1 +
>  hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
>  include/hw/intc/arm_gicv3_common.h |  1 +
>  linux-headers/asm-arm64/kvm.h      |  1 +
>  linux-headers/linux/kvm.h          |  1 +
>  target/arm/kvm.c                   | 21 +++++++++++++++++++++
>  target/arm/kvm_arm.h               | 12 ++++++++++++
>  8 files changed, 63 insertions(+), 1 deletion(-)

All the patches in this series seem reasonable, but the series
as a whole is so short I wonder if we're missing something :-)
Does migration Just Work? (I guess as long as the kernel exposes
all the EL2 sysregs via the ONE_REG ioctl interface it ought to...)

Anyway, I don't think there's anything that stood out as needing
major changes, so for now I guess we just wait for whenever the
KVM side patches eventually land.

thanks
-- PMM

