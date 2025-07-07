Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39CBC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:20:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrO8-000325-Nn; Mon, 07 Jul 2025 15:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <34x1saAYKChoI40D926EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--seanjc.bounces.google.com>)
 id 1uYrNq-0002TB-4b
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:20:11 -0400
Received: from mail-pg1-x54a.google.com ([2607:f8b0:4864:20::54a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <34x1saAYKChoI40D926EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--seanjc.bounces.google.com>)
 id 1uYrNm-00040U-Ua
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:20:09 -0400
Received: by mail-pg1-x54a.google.com with SMTP id
 41be03b00d2f7-b3216490a11so4490630a12.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751916004; x=1752520804; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=oRPungLhCMbFT17gwpSiJyBFIFmaCnbMT4a01H3rmSk=;
 b=qoxR08cQd0Bh0EQjXHubFHKZi88r4vT235as2UZ7+I2Y17d8K9I7LhcSdQov4JU0Cm
 rNobr5tdrZKHB7zmXPBCFTDnTN1J0bjRuxJDSMRDL1d5jC6nYabv4zTE4Y+OlwOOIfNK
 2aM9AbfsgthVuDU+CoVmGuzOmoYp40Sdobiqojkp9+UeRSh+rTa8lRXPzDeZ+kcGkOfm
 vmd8vKEQz0BqX8CUJNna1hYNFfdo1FMtYQLdkAWTNiFT4rjsX1emw5aRvygWkyJVHpjl
 0sZT8yjKRUs7Z0tFqFzcbYkM+mex7Sa5Uc7uUc97qqP14cuwRUWb/uOFffUVCVOef0Oy
 /jyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751916004; x=1752520804;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oRPungLhCMbFT17gwpSiJyBFIFmaCnbMT4a01H3rmSk=;
 b=oiJxqU2tq6Ni9dikzO9j8xSMnN71L7lHvowfSlathvSl7aKJzk/Ptmzsbgt/slhUQO
 OS1AMmkkiCYKMEpJHiKLHVtXpQyEh9afprcIZyl9QAWjUCG/LHq3Dul43bzT2caV37yn
 0EH9eCC2Z2dfVkoAk8npxUqs+kZTI5L3lo+fxglnLpYfg7KjU8EY3tUInauGFairhC5H
 oMcHUXt7Y0Bw7drYM0LSvGovyyfMRch43kBOplojPpsgmDJlHZgFDjSqcQtxGdAc09Lf
 lovlO0hCwAXyQbOuuEzoEqXbSG1SZVCecqr7q2dM9uiPnvBqoeXaOfRDQLZ7oDWiCUwR
 BOSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVItvVlTcPIWXLJGl5yfQ3GvOx9b8O1+BxF8AlVY0hE2UYfz0YL33Sf5xr/w/Sgp8cobAkGErIczdfo@nongnu.org
X-Gm-Message-State: AOJu0Yx8xNxDe+u3mhwy0GTa9k8CD/i6xQaE0DiPTG5t7vbZ1mVXzQyo
 ePZm4G+4O424gV9Oe9E7Rt1fzKGxOq+N/nkZ9OfnSkwpvZX+/ITeD0ZXiklzk2XPp8jse21pM4W
 h0p8+QQ==
X-Google-Smtp-Source: AGHT+IHuZExtBi8nkRDLNH/gGrIUwAHBNEsHmAJ1owCt4iggl3WIus4SV7ghwVoHaOOok8bL/o5LhDmMIuA=
X-Received: from pjbpq12.prod.google.com ([2002:a17:90b:3d8c:b0:30e:7783:edb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4a81:b0:312:e279:9ccf
 with SMTP id 98e67ed59e1d1-31aac432867mr18709895a91.5.1751916003788; Mon, 07
 Jul 2025 12:20:03 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:20:02 -0700
In-Reply-To: <aGTvFbqLKcG1wLqO@intel.com>
Mime-Version: 1.0
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com> <aGS9E6pT0I57gn+e@intel.com>
 <f1d53417-4dce-43e8-a647-74fbc5c378cb@intel.com> <aGTvFbqLKcG1wLqO@intel.com>
Message-ID: <aGwd4uVrAGzka95_@google.com>
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
From: Sean Christopherson <seanjc@google.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, 
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::54a;
 envelope-from=34x1saAYKChoI40D926EE6B4.2ECG4CK-34L4BDED6DK.EH6@flex--seanjc.bounces.google.com;
 helo=mail-pg1-x54a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Wed, Jul 02, 2025, Zhao Liu wrote:
> > I think we need firstly aligned on what the behavior of the Windows that hit
> > "unsupported processor" is.
> > 
> > My understanding is, the Windows is doing something like
> > 
> > 	if (is_AMD && CPUID(arch_capabilities))
> > 		error(unsupported processor)
> 
> This is just a guess; it's also possible that Windows checked this MSR
> and found the necessary feature missing. Windows 11 has very strict
> hardware support requirements.
> 
> > And I think this behavior is not correct.

It's not really a matter of correct versus incorrect in this case.  Software is
well within its rights to refuse to run on unsupported hardware.  E.g. many
hypervisors now require EPT/NPT and other modern features.  Even KVM requires a
minimum set of features; KVM just happens to have a *very* low minimum, and KVM
tries to be gentle and friendly when unsupported or incompatible hardware is
encountered.

Windows' behavior is arguably flawed, misguided, and user hostile, but we can't
say it's wrong.  E.g. even if the argument is that AMD could ship a future CPU
that supports ARCH_CAPABILITIES, it's not a violation of AMD's architecture for
Windows to not support such a processor.

