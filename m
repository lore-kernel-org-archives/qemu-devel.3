Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8575C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 00:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEI4C-0001Q5-P7; Mon, 03 Jun 2024 20:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3FmBeZgYKCok5rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com>)
 id 1sEI4B-0001PO-50
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:30:19 -0400
Received: from mail-pj1-x1049.google.com ([2607:f8b0:4864:20::1049])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3FmBeZgYKCok5rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com>)
 id 1sEI49-0003XS-En
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 20:30:18 -0400
Received: by mail-pj1-x1049.google.com with SMTP id
 98e67ed59e1d1-2c1aa8d19bbso4423835a91.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 17:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1717461015; x=1718065815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
 b=Z1ZELQzIzR8v+vj/OQ2Qt1Dq88s2zDS4mGVTHjmI2nm4YZLWs5/O45cPD8I5s2+g1s
 juZHYfYVxmaKBHbqvZIT2HWdZ3Gr3AWvVE+LFCS9H+1vp/iAPD516iL/ta2gpKuSlfRh
 gEmqbeGYc1PMM47/sLkVAj0vZIi+6IlC/TJcmPNV583BHcXslsgJ+jVn+f/rRWf4vlz1
 /93duqw7AEJ0oiM/64amh/MKo5ZwS6CtDFvBUbIPdBgkxF3RZnPD7SK2LqLonZDvNYUC
 8arl/JQsbAt56cCF9kDYfOD0gV5VExgzo/CZvP4XVpB8pL31txZxNqIp33+eiLiHKWLM
 N4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717461015; x=1718065815;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qxZAvQthUOLtrgNKYUD6oiL7rAnsVeqwoSoZowsNkW0=;
 b=tFtsSfE3OAViEfiWlBKfeDKm+pKZ0dyuqGLBl51O2bTBqyMmzwVCDXo+yjz/qiJa2h
 yNPj7NZfrhM1vt6lJUR2GHstxRkDYW5uHmmgu7irmumOODzM3Dh+V4b89GM9+OsDkK3Q
 7oI0vTKHpIuOVEnjKoYzRk1CXCy0uMd/4qTewBvOQFDfhZgieEbl3wvWu1lDseudc7xh
 jxBsQzMKrziZkbXzKIrLYYq04tjps5PiR91nZU+A/nAvao/NBXbUu9/evDihhERmb+Vb
 rtxLPmm41TLyYdaQEetqKpbh18pwyTcKLEqqRsck29VUuIdSP/7tj3Gp4na91t9vylQR
 pZ6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmWqNIlRwvKWjsyYbRbC0rE5fdQixzRzBiGrOoMIGJyRh3tp0b+lJ83aV3mBu4ww76AEqhUEvvL63izcZWPjWU+lVJYYI=
X-Gm-Message-State: AOJu0YwvPeKxbJoEt/U7+PYtjzWcRShlhafmmvpxc2PYnP2+YBD0Hj7M
 i2STfztstSwZLE8KHIeS8u0lUecaySMAqdgLtaSODWwQHQNKHRDTbAxuLGiVcmoez9xmPDYrYNl
 WYA==
X-Google-Smtp-Source: AGHT+IHQGaBTeBmAnXtOHPKtCDExst6sxM2uUbRh6POZbhCe3IxNIvO17m1N9WlbQ/aSMCylqTV+FPzEOtI=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:2c86:b0:2c1:aa8e:13cb with SMTP id
 98e67ed59e1d1-2c1dc5e0ab2mr29758a91.9.1717461014195; Mon, 03 Jun 2024
 17:30:14 -0700 (PDT)
Date: Mon, 3 Jun 2024 17:30:12 -0700
In-Reply-To: <20240603.ahNg8waif6Fu@digikod.net>
Mime-Version: 1.0
References: <20240503131910.307630-4-mic@digikod.net>
 <ZjTuqV-AxQQRWwUW@google.com>
 <20240506.ohwe7eewu0oB@digikod.net> <ZjmFPZd5q_hEBdBz@google.com>
 <20240507.ieghomae0UoC@digikod.net> <ZjpTxt-Bxia3bRwB@google.com>
 <D15VQ97L5M8J.1TDNQE6KLW6JO@amazon.com> <20240514.mai3Ahdoo2qu@digikod.net>
 <ZkUb2IWj4Z9FziCb@google.com> <20240603.ahNg8waif6Fu@digikod.net>
Message-ID: <Zl5gFMJp3nECJVW-@google.com>
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1049;
 envelope-from=3FmBeZgYKCok5rn0wpt11tyr.p1z3rz7-qr8ry010t07.14t@flex--seanjc.bounces.google.com;
 helo=mail-pj1-x1049.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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

On Mon, Jun 03, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, May 15, 2024 at 01:32:24PM -0700, Sean Christopherson wrote:
> > On Tue, May 14, 2024, Micka=C3=ABl Sala=C3=BCn wrote:
> > > On Fri, May 10, 2024 at 10:07:00AM +0000, Nicolas Saenz Julienne wrot=
e:
> > > > Development happens
> > > > https://github.com/vianpl/{linux,qemu,kvm-unit-tests} and the vsm-n=
ext
> > > > branch, but I'd advice against looking into it until we add some or=
der
> > > > to the rework. Regardless, feel free to get in touch.
> > >=20
> > > Thanks for the update.
> > >=20
> > > Could we schedule a PUCK meeting to synchronize and help each other?
> > > What about June 12?
> >=20
> > June 12th works on my end.
>=20
> Can you please send an invite?

I think this is all the info?

Time:  6am PDT
Video: https://meet.google.com/vdb-aeqo-knk
Phone: https://tel.meet/vdb-aeqo-knk?pin=3D3003112178656

Calendar: https://calendar.google.com/calendar/u/0?cid=3DY182MWE1YjFmNjQ0Nz=
M5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb=
3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986S=
ngGlhPH?resourcekey=3D0-FDy0ykM3RerZedI8R-zj4A&usp=3Ddrive_link

