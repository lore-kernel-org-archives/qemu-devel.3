Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62737C52D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 09:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scLUC-000812-7p; Fri, 09 Aug 2024 05:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLUA-0007zs-1b
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1scLU7-0004s6-AS
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 05:00:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3687fd09251so947562f8f.0
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2024 02:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723194027; x=1723798827; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmYyzHtVTcDjPEdEVArsEoK0VXoPUGExEsdo4wzUW1I=;
 b=iJj0nN9ILoM4E15+rR+QD6kmnyzoGrFq/rSLLQDO+ffquvH/qbwtxsXP+vxPv4Dq1w
 QpR7VOGoirtssSqs1GipagOKLXno5DeICPhY5mq5w//PHflMd8hS3OlM9usPsrgcIOBE
 aPAXOpVQBm4aJCgPfsJTfCyNpV4uOUyB5nIoTZCIPLQp8N0oQ+SeJehnSu0nxbRWC+5h
 mX00/1kbk6NycAOzj7pU9UdHFd0ip1r6noRsLQgpV1Tz+v7btuOaaKdFTUFfP+EtH9+2
 GQY07ye4szuZzPgC+xT06+mz4anZQkqa4BztinT5SKiO8AwII6tU7Mwcxj3OK1RCr2vB
 5xMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723194027; x=1723798827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmYyzHtVTcDjPEdEVArsEoK0VXoPUGExEsdo4wzUW1I=;
 b=uWwIL3XMuG2uVjEIBYS/uHlX43pmakJ9T4U/a53k/IQtmszjYkrqiqEWLX1MY7WhLU
 oTaYh3WhZ7x/8iHeOZFK/+qc2G9s+92TP9TVlQP88qWus//GE+7KDz2O9Ic9q1DxifSu
 wNZwe88+hOrhdNndL36Yki91eP7ERw7kG5XLI64oSkDN8yGnQ/VSd/uZ+YhLi5Anl2Lf
 y2diCgWnypnmdT2jEDYPaJIcZYXngc/sM2semleIxlrwhHPBRW6FQqIt8tApCjyCvG5L
 JxRu96QUyi9fSQFfgM8hN4NPzUPvwrQUaJFRggbKDjakH6ERt7FjiAnKHSSF21ow+lv6
 nKiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKp/ova53A+OtmElfms7RDUZlUrG64c4Nb6kYqJ3pkVpcbjzfW56aBmKLdKYIb4Jpx59+Y5CK4BdoU2ub26XGC4yQ34zU=
X-Gm-Message-State: AOJu0YzR3Jzy7Rm2lcG07KYE+PNGuOpKuDLQ5GQCW9PklySJqOE7LDPb
 19B4p90FhPbTykiLeHcb5M2EJx/EdbiDUFoklBNeMDHkp31+OGES+WW6tKNYWfYPB6FiqQdpuTq
 r+9ncMJ018sf26ALol2Sn0l+5+NXuHA1OjL4VCw==
X-Google-Smtp-Source: AGHT+IHASa5CI/8VmF2a8okXHufY3PkBARhBp95qEtdhDbCsWAHqeSitT533Wpul/4/9NgM/SMffObYY+EtStWUPA0Q=
X-Received: by 2002:adf:cc88:0:b0:368:4edc:611e with SMTP id
 ffacd0b85a97d-36d5e7fd9e1mr676747f8f.14.1723194027412; Fri, 09 Aug 2024
 02:00:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240809035134.699830-1-gshan@redhat.com>
 <20240809035134.699830-4-gshan@redhat.com>
In-Reply-To: <20240809035134.699830-4-gshan@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2024 09:59:52 +0100
Message-ID: <CAFEAcA_bfBNFBeJ-cMS+KACaC6Sw2VAAdg_gb5xn6-TE5C-7nA@mail.gmail.com>
Subject: Re: [PATCH 3/4] hw/arm/virt: Use kvm_arch_get_default_type()
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com, 
 philmd@linaro.org, richard.henderson@linaro.org, shan.gavin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

On Fri, 9 Aug 2024 at 04:52, Gavin Shan <gshan@redhat.com> wrote:
>
> kvm_arch_get_default_type() and kvm_arm_get_max_vm_ipa_size() are
> interchangeable since the type is equivalent to IPA size (bits)
> with one exception that IPA size (bits) is 40 when the type is zero.

Well, sort of, but they're conceptually different.

kvm_arch_get_default_type() is the API for "give me the value
I need to pass to kvm_ioctl(s, KVM_CREATE_VM, type)"; it's
architecture independent and different architectures do
different things. In the future Arm might need to do something
other than "just pass in the IPA size".

kvm_arm_get_max_vm_ipa_size() does exactly what it says on the
tin: it is an Arm specific function that returns the maximum
supported IPA size.

I would prefer not to conflate the two.

thanks
-- PMM

