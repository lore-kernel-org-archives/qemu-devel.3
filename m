Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3607C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 18:09:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEYaE-00032F-9A; Tue, 04 Jun 2024 14:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sEYaC-00031s-2i
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:08:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sEYa9-0005oI-T8
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 14:08:27 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4213870aafdso27862925e9.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 11:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717524502; x=1718129302; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GRdyMNWI1/nLhg2t3CJMpyoR7lf8Bg93JMh6F28wXn8=;
 b=ksKxX4xMd4QwKvEapEkxmxzH/uxDi9gb1U5dJ/Fg41ZhGv6qoi+kh/q7EgMd3hcG04
 5OB/EsvlBBOvn4DZ24MwOYU1LysM3Mg0QTI6IlndHpUw0aMdiJ2PFdroX5ZMlZ0xfMx2
 xbAeqxyomropr9qxwktWF7ttcdPSU98XovK/OCXI2cidPbS9pqVyraIuVTjyR1fkdG0H
 E8hf1YL08iPx0qYlVOVLHC1Sy72V15H5QIL1EhJMI2XM0xpaqwXR5LLfAOz/7TPH9f9M
 jPx9RF3uQSIXhfWAufTDcZJuRNE3bXVM1DwZJ5oBOqqHOXlfWy0jjUxLky/FOZ9zGgpd
 NdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717524502; x=1718129302;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GRdyMNWI1/nLhg2t3CJMpyoR7lf8Bg93JMh6F28wXn8=;
 b=pB+1WJrV/LKfiCSG9Vw51WL6VcaxEF44JXGcsewgE42Pplg8QD/mO/lUq/RImwV6ZM
 YFM3c7Z6Sy9kb/t39fIb9d8CjtyWLOWgefS+OWyFxkPfw1ifQ0vJIn0CtBzt378jLKND
 yMGUtB3Me9E24CIxPWaUvqJOYOm4pOlIcWzejmnemeVmxJnX5x3I6W8UAON9iDyFbjYK
 LrSlG8D5lzyT4IIqkOj90Wnqq29lgFc0Bq40oWtqcPaaU9g9GgzooiP5IYUk9nyvtjFu
 RHl5nWIBfbQG+hce0q/esKLpg2OTfAh6/V/D+kmELMCth/65imyEltDMAjbRcH/rXf8o
 9u7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMJWoz7VxJVQ8wAPNG9KS1yjznJgjR2+ebb4sGsk5z0XngA50SWRTU4i/bC8r6VHsymi5fg/NOVFv/7nxYDAZaRYTyYqc=
X-Gm-Message-State: AOJu0YwvAPSSyz73IurMsGpdSmMPb507vz8GMd1gZ6SKXV6UBp6LEmFd
 gHp7zjaiQm7NHw38At3kPA2nSjLg55WIz1zOjN7/OyE6bfVcvdI2vnHOSriKF8Y=
X-Google-Smtp-Source: AGHT+IEr9jhpNAxQxXIkIy8ZsXI2jT2TGN7/Gu/bWTzRMZElxbW2xrYd7/aUcSrjmt4toLV3UNb2DQ==
X-Received: by 2002:a05:6000:6:b0:34f:7788:37ef with SMTP id
 ffacd0b85a97d-35e8833a089mr125767f8f.29.1717524502366; 
 Tue, 04 Jun 2024 11:08:22 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd064fd2fsm12209005f8f.109.2024.06.04.11.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 11:08:21 -0700 (PDT)
Date: Tue, 4 Jun 2024 19:08:36 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gavin Shan <gshan@redhat.com>, Itaru Kitayama <itaru.kitayama@linux.dev>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: Unexpected error in rme_configure_one() at
 ../target/arm/kvm-rme.c:159
Message-ID: <20240604180836.GC875061@myrica>
References: <0C6F517A-5686-4BCE-8D08-1CED02CB470E@linux.dev>
 <4e7aa598-1a5d-47e1-aaa3-78af05947eeb@linaro.org>
 <CB05CAA2-9301-45F6-8AE3-A2E27A160CDF@linux.dev>
 <cbd630d7-01e8-49ba-9c8b-a6514d898ed2@redhat.com>
 <20240531150922.GA83195@myrica>
 <CAMj1kXHK+xTTMsfP0sfn+-8S_fJebSXr4QTcHU2aCzd7t5x3HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHK+xTTMsfP0sfn+-8S_fJebSXr4QTcHU2aCzd7t5x3HA@mail.gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x334.google.com
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

On Fri, May 31, 2024 at 05:24:44PM +0200, Ard Biesheuvel wrote:
> > I'm able to reproduce this even without RME. This code was introduced
> > recently by c98f7f755089 ("ArmVirtPkg: Use dynamic PCD to set the SMCCC
> > conduit"). Maybe Ard (Cc'd) knows what could be going wrong here.
> >
> > A slightly reduced reproducer:
> >
> > $ cd edk2/
> > $ build -b DEBUG -a AARCH64 -t GCC5 -p ArmVirtPkg/ArmVirtQemuKernel.dsc
> > $ cd ..
> >
> > $ git clone https://github.com/ARM-software/arm-trusted-firmware.git tf-a
> > $ cd tf-a/
> > $ make -j CROSS_COMPILE=aarch64-linux-gnu- PLAT=qemu DEBUG=1 LOG_LEVEL=40 QEMU_USE_GIC_DRIVER=QEMU_GICV3 BL33=../edk2/Build/ArmVirtQemuKernel-AARCH64/DEBUG_GCC5/FV/QEMU_EFI.fd all fip && \
> >   dd if=build/qemu/debug/bl1.bin of=flash.bin && \
> >   dd if=build/qemu/debug/fip.bin of=flash.bin seek=64 bs=4096
> > $ qemu-system-aarch64 -M virt,virtualization=on,secure=on,gic-version=3 -cpu max -m 2G -smp 8 -monitor none -serial mon:stdio -nographic -bios flash.bin
> >
> 
> Hmm, this is not something I anticipated.
> 
> The problem here is that ArmVirtQemuKernel does not actually support
> dynamic PCDs, so instead, the PCD here is 'patchable', which means
> that the underlying value is just overwritten in the binary image, and
> does not propagate to the rest of the firmware. I assume the write
> ends up targettng a location that does not tolerate this.

Yes, the QemuVirtMemInfoLib declares this region read-only, so we end up
with a permission fault

  // Map the FV region as normal executable memory
  VirtualMemoryTable[2].PhysicalBase = PcdGet64 (PcdFvBaseAddress);
  VirtualMemoryTable[2].VirtualBase  = VirtualMemoryTable[2].PhysicalBase;
  VirtualMemoryTable[2].Length       = FixedPcdGet32 (PcdFvSize);
  VirtualMemoryTable[2].Attributes   = ARM_MEMORY_REGION_ATTRIBUTE_WRITE_BACK_RO;

Making it writable doesn't seem sufficient, since I then get a "HVC issued
at EL2" fault. I'll keep debugging.

Thanks,
Jean

> 
> Running ArmVirtQemu or ArmVirtQemuKernel at EL2 has really only ever
> worked by accident, it was simply never intended for that. The fix in
> question was a last minute tweak to prevent some CVE fixes pushed by
> MicroSoft from breaking network boot entirely, and now that the
> release has been made, I guess we should revisit this and fix it
> properly.
> 
> So the underlying issue here is that on these platforms, we need to
> decide at runtime whether to use HVC or SMC instructions for SMCCC
> calls. This code attempts to record this into a dynamic PCD once at
> boot, in a way that permits other users of the same library to simply
> hardcode this in the platform definition (given that bare metal
> platforms never need this flexibility).

