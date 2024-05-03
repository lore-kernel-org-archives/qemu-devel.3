Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 922F4C25B5C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 13:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2tIR-0000tP-Cg; Fri, 03 May 2024 09:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3fes0ZgYKCmAQC8LHAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--seanjc.bounces.google.com>)
 id 1s2tIP-0000pn-Fz
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:49:53 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3fes0ZgYKCmAQC8LHAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--seanjc.bounces.google.com>)
 id 1s2tIN-000088-Kp
 for qemu-devel@nongnu.org; Fri, 03 May 2024 09:49:53 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-6f446a1ec59so1008743b3a.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1714744189; x=1715348989; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=rQGv5UfxS6jX/aTPX2JQQkA4rH0rnz4JsGbkCfvMiug=;
 b=gVKlaqlbZ5btf0YcWkY9qxI6c7vhP9G2EIALQDyfhtNeNjq/GIfadPil6G32vfKFKN
 LftsChtH9jBBRYFhNUpC7jUbRGqHbgvhCKUdWVMz7q2i3xeCLmuPggG5MmO6zRIbPRgP
 F5qxY80diwQcKd2byMLA6upT0uJ5MQqI0J/MA8yocvFvnQpA1FlI/t8Hz5XNu/MpYj2I
 HFucwy7wOWKYmFQ9oNXsQggKRGsA4nNuVDpB4SsphUqUy4zc46x7Z2RGhFMGzlumlOOs
 LGlTRmpxS0YxVNMy1cxS01QJWLmevIPKfhq9Jdaomf4PHiw65X2MokbLRl99wxvnZgjA
 GxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714744189; x=1715348989;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rQGv5UfxS6jX/aTPX2JQQkA4rH0rnz4JsGbkCfvMiug=;
 b=L87txMxI9PjXhZPbw9J05dU+LHmH02cPpupJT8Kk3Axrbu+sgSnpim9XAB43atclf9
 LCP6aoUsqstNPWcp65vS1GTcHX69PJnw2dMaRvF/eubcTFp/q8smpGteKdzrFVykJQH2
 XN7hWkMGnuPero0BsYhUQxEP0I9kn5I9+TPZLjKtDmI+eF8oPGslRLVP/dv2GU2vwskE
 TjAuKPylUx+RvPOVBQITESECypawDn2cA3vkeNHBzgpeAovhEpcJ1x+xZLNJ05YjYL1N
 6e3bFudmDU5AqSHQF2XpbL5N72C/RTeak6mcwF6qMajqL5UU+j1fNFmUGDwSXSzndi4+
 fPNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOu+JsA3BfQI/GU9W0DifyStIpvHOLPHW6Vgkzx9vmwOW/8yMslQZAValcuicFj1zx0qOL+v5lKN997E0nrTdXdl6bLjQ=
X-Gm-Message-State: AOJu0YxaKSPZQZfZgtJ3nA2+1hs/QM5g2fq8wmqAgEscJO3qjs3JR8sz
 lIfdcPbVS3W0Mw8oL0HYTREkQJUzT/qEUUy6jhV9DXQUGJt/4EBZLx6IEkopVtNzPumhrh4d1jh
 x7A==
X-Google-Smtp-Source: AGHT+IGc0eGZplb+oZL3dkGKqelUQj57uqxGLcLhw0noqTEVy1iaqZaCu7zCqnCr5z1/yKblcKIpSFxnXkk=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2e07:b0:6ea:baf6:57a3 with SMTP id
 fc7-20020a056a002e0700b006eabaf657a3mr154355pfb.6.1714744189252; Fri, 03 May
 2024 06:49:49 -0700 (PDT)
Date: Fri, 3 May 2024 06:49:47 -0700
In-Reply-To: <20240503131910.307630-1-mic@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
Message-ID: <ZjTre6BYRpkI_H4o@google.com>
Subject: Re: [RFC PATCH v3 0/5] Hypervisor-Enforced Kernel Integrity - CR
 pinning
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
 Kees Cook <keescook@chromium.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, 
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Alexander Graf <graf@amazon.com>,
 Angelina Vu <angelinavu@linux.microsoft.com>, 
 Anna Trikalinou <atrikalinou@microsoft.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, 
 Forrest Yuan Yu <yuanyu@google.com>, James Gowans <jgowans@amazon.com>, 
 James Morris <jamorris@linux.microsoft.com>,
 John Andersen <john.s.andersen@intel.com>, 
 "Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
 Marian Rotariu <marian.c.rotariu@gmail.com>, 
 "Mihai =?utf-8?B?RG9uyJt1?=" <mdontu@bitdefender.com>, 
 "=?utf-8?B?TmljdciZb3IgQ8OuyJt1?=" <nicu.citu@icloud.com>,
 Thara Gopinath <tgopinath@microsoft.com>, 
 Trilok Soni <quic_tsoni@quicinc.com>, Wei Liu <wei.liu@kernel.org>, 
 Will Deacon <will@kernel.org>, Yu Zhang <yu.c.zhang@linux.intel.com>, 
 "=?utf-8?Q?=C8=98tefan_=C8=98icleru?=" <ssicleru@bitdefender.com>,
 dev@lists.cloudhypervisor.org, 
 kvm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, qemu-devel@nongnu.org, 
 virtualization@lists.linux-foundation.org, x86@kernel.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3fes0ZgYKCmAQC8LHAEMMEJC.AMKOCKS-BCTCJLMLELS.MPE@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, May 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi,
>=20
> This patch series implements control-register (CR) pinning for KVM and
> provides an hypervisor-agnostic API to protect guests.  It includes the
> guest interface, the host interface, and the KVM implementation.
>=20
> It's not ready for mainline yet (see the current limitations), but we
> think the overall design and interfaces are good and we'd like to have
> some feedback on that.

...

> # Current limitations
>=20
> This patch series doesn't handle VM reboot, kexec, nor hybernate yet.
> We'd like to leverage the realated feature from KVM CR-pinning patch
> series [3].  Help appreciated!

Until you have a story for those scenarios, I don't expect you'll get a lot=
 of
valuable feedback, or much feedback at all.  They were the hot topic for KV=
M CR
pinning, and they'll likely be the hot topic now.

