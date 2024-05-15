Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697F6C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 20:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7LIm-0002jc-Jy; Wed, 15 May 2024 16:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <32RtFZgYKCl4OA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com>)
 id 1s7LIe-0002ii-Q6
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:32:33 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <32RtFZgYKCl4OA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com>)
 id 1s7LIc-0007x7-66
 for qemu-devel@nongnu.org; Wed, 15 May 2024 16:32:32 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-6f441afba80so8253762b3a.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 13:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715805146; x=1716409946; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
 b=L9eUKQRjEJeyeEM7a3vdWf1duJCdkAZorXKFtGuyuxb6aKGiKS0ddkQxtFx4wiPaw/
 uVmaySLELMtPl6QMHDP3r2ia0G+6FHCRPgzOJKOncsh0oubpRhkLYy+nFMeWzQZjFiNt
 XqGAmdot0XSITDvTeVQj5oWE1Kq/XlOhUIX5HqwnEDUJBSiJG9yobZhWUzBo0ZleS3Uw
 kauDN+iHXMWI78sGS3MmpHwOe84zcvfFFkDJSLEhfrcsGYd4Z+5O9yuMzdHfvC1Thk4M
 K7faA0GA43YVGqjJvxSSIM7Y5TOSuioh4xD6hQmebR7ZztLs23aKP/AiLOotjKscr+p3
 XMug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715805146; x=1716409946;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iyv87Dbnyu7gm4af/LI0TOX4gLeF6QvKnfsIZOOyrfc=;
 b=TAYXm/l+9k96CbVAiAEJB+uhqtfd8D+Y6+gEmWevR7kE3cD4n+HQ0Ka8TwmRKLN87w
 ElNtXGGyWTNZMeI3qFLW3Q94w1LWk+yg065ufMGZk912DgsOR3tDPuJX99Uh79/3P/lP
 fQFpWcvcxt7KM/USorgmqsNkd/hNDXWf92K1c8+AM/pHdOTkdTgN1uU9S/2NcFEsTRw5
 m64nKbcIu6dx1s/R/RLtJwK+KwRF009AcDds7MI9v23tvlSl3Qobi3YeK7WuCCv/qi7n
 +gDBEk8rGfPzLdVsBMuM1/ifwL1/9z/cu/KUroDAfLYmtIvUdMV5ter4U2W20q19oLt1
 60lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXY6O03j0XgLgJMyV1AlLx5jdFXV9MANxsIfIxuU8o+tdhdkIKinO20XZ5OXIzQpcyfTtXP2UyPocQNFREoA8tjxv7zhEc=
X-Gm-Message-State: AOJu0YxKGMXIfcDkx6UXACoj2E6QmwVnoMCxMAm8QE1/GXPE+XBSz713
 +6YVti4zaCkQzEln9EGTs0fItit0uhWb6ssWasHLRkItZzJw4LjeXiqs1noI+A6fOSeYx+rKA7W
 FUw==
X-Google-Smtp-Source: AGHT+IECDBDOitjYW0H0HtQ+B5fogjE5oB/VbBha173B4uff3BsqArnMeFZozd93oJEEJOGvPRJpNAKBnf4=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1d26:b0:6ea:baf6:57a3 with SMTP id
 d2e1a72fcca58-6f4e0431a08mr1169393b3a.6.1715805145969; Wed, 15 May 2024
 13:32:25 -0700 (PDT)
Date: Wed, 15 May 2024 13:32:24 -0700
In-Reply-To: <20240514.mai3Ahdoo2qu@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-1-mic@digikod.net>
 <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com> <20240506.ohwe7eewu0oB@digikod.net>
 <ZjmFPZd5q_hEBdBz@google.com> <20240507.ieghomae0UoC@digikod.net>
 <ZjpTxt-Bxia3bRwB@google.com> <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com>
 <20240514.mai3Ahdoo2qu@digikod.net>
Message-ID: <ZkUb2IWj4Z9FziCb@google.com>
Subject: Re: [RFC PATCH v3 3/5] KVM: x86: Add notifications for Heki policy
 configuration and violation
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
 Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, 
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=32RtFZgYKCl4OA6JF8CKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x44a.google.com
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

On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrote:
> > Development happens
> > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-next
> > branch, but I'd advice against looking into it until we add some order
> > to the rework. Regardless, feel free to get in touch.
>=20
> Thanks for the update.
>=20
> Could we schedule a PUCK meeting to synchronize and help each other?
> What about June 12?

June 12th works on my end.

