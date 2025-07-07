Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1637C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrAV-00008u-S7; Mon, 07 Jul 2025 15:06:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3khpsaAYKCsEzlhuqjnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--seanjc.bounces.google.com>)
 id 1uYrA8-0007qK-6z
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:06:02 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3khpsaAYKCsEzlhuqjnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--seanjc.bounces.google.com>)
 id 1uYrA6-00024s-9g
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:05:59 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-74880a02689so2705514b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 12:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1751915155; x=1752519955; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=uhnPibTiFpdOU0rxGQkwLUax6xi0Sb89X0hOrW81VOE=;
 b=uoaG/4U5dkoOiiqUR4rdpDKYHE0Dy3gOImpQco8enEWfr4p34XD//fYR60BuHArw2+
 wKKYWBmW+WXUwatp7f6DTrz4GA/M38uouQKeK0vtbxiJkAXXa5Hm9Npgmoy8TRqAp9+r
 YFaHXUXjAldnyk0UP3nKPSlwRcZkD2iNrmlwaJqkXCJdaHJGPn40McAWfgz410+1gCK7
 ZSaL21obTVcNw9y40xKRmjHXv9WGrAtxR/fUtd3NUgyBF1OgwD3RiaZpAen9caqKo3Ug
 uZJMRkai/VWJbhKdjE1HgSdpTv4j8xFJdkcZ//txVJfL52VL38Og9zguCSZrSelBsjND
 z7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751915155; x=1752519955;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uhnPibTiFpdOU0rxGQkwLUax6xi0Sb89X0hOrW81VOE=;
 b=i3tc70t74P8Qw1dKw1Oz15hBN9zUpUg6fmMm62I5VyPIVH67v61fvRz1ANhKw4jNKe
 0gi6jACHTWhBZVUEFuR1ACsOypGIVPJ4afY7JM99S44w0w0UPqzDyNXUh+fq5kuUHGsn
 GQI4f3+mtkB74YObYd22kgk3HvzkeyPm1en42fjH6fNL0NrUW5EKCKr5vNgb/V5M6iFU
 ZHw6zpVDj3HFvMqGGIbZ0x6BkMploL0Vt7nFAIhQFUCraLLJb6PUNJocPClekEgdOVxk
 Ox01jhrI/rhqCMRHTC+rA0ZQzeW6xcqsKrHOtMwNhKi2MHDHVC6qvCVBSGh5JOC4DjRH
 Ebjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3ysx3iV96iuUsv7pn2Art+Qfun26P8ZFZxW7YQpDYbJJSSEkaVKRcKDIwjLr3DVhN+hyk1K4+TPi4@nongnu.org
X-Gm-Message-State: AOJu0YylOYjSdeXfsnzXdvDMYJKM0Yy1I0/b5quEEgoJuewcgo1cmnzZ
 CYriOqZpRBOBVjzXtlmf420Azgj5zxPzmeu2F7hxgzIr/ezveS0kgv2yvFp2WOzWPRF0N+R8b+1
 fsGxJQQ==
X-Google-Smtp-Source: AGHT+IEBQH7ZAAioHEOJOcMTVuu8EoOLPcu5RnHuohgxSMP6k/swZ2jlTt5pK3I3H0WX2gK7DOSf8TnWxNs=
X-Received: from pfbeq4.prod.google.com ([2002:a05:6a00:37c4:b0:746:683a:6104])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c94:b0:748:2fa4:14c0
 with SMTP id d2e1a72fcca58-74d24513e6bmr508036b3a.0.1751915154684; Mon, 07
 Jul 2025 12:05:54 -0700 (PDT)
Date: Mon, 7 Jul 2025 12:05:53 -0700
In-Reply-To: <aGQ-ke-pZhzLnr8t@char.us.oracle.com>
Mime-Version: 1.0
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <aGO3vOfHUfjgvBQ9@intel.com> <c6a79077-024f-4d2f-897c-118ac8bb9b58@intel.com>
 <aGPWW/joFfohy05y@intel.com> <20250701150500.3a4001e9@fedora>
 <aGQ-ke-pZhzLnr8t@char.us.oracle.com>
Message-ID: <aGwakUTUQ7ZxYlUe@google.com>
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
From: Sean Christopherson <seanjc@google.com>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>, 
 qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-stable@nongnu.org, 
 boris.ostrovsky@oracle.com, maciej.szmigiero@oracle.com, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3khpsaAYKCsEzlhuqjnvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--seanjc.bounces.google.com;
 helo=mail-pf1-x449.google.com
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

On Tue, Jul 01, 2025, Konrad Rzeszutek Wilk wrote:
> On Tue, Jul 01, 2025 at 03:05:00PM +0200, Igor Mammedov wrote:
> > On Tue, 1 Jul 2025 20:36:43 +0800
> > Zhao Liu <zhao1.liu@intel.com> wrote:
> > 
> > > On Tue, Jul 01, 2025 at 07:12:44PM +0800, Xiaoyao Li wrote:
> > > > Date: Tue, 1 Jul 2025 19:12:44 +0800
> > > > From: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised
> > > >  on AMD
> > > > 
> > > > On 7/1/2025 6:26 PM, Zhao Liu wrote:  
> > > > > > unless it was explicitly requested by the user.  
> > > > > But this could still break Windows, just like issue #3001, which enables
> > > > > arch-capabilities for EPYC-Genoa. This fact shows that even explicitly
> > > > > turning on arch-capabilities in AMD Guest and utilizing KVM's emulated
> > > > > value would even break something.
> > > > > 
> > > > > So even for named CPUs, arch-capabilities=on doesn't reflect the fact
> > > > > that it is purely emulated, and is (maybe?) harmful.  
> > > > 
> > > > It is because Windows adds wrong code. So it breaks itself and it's just the
> > > > regression of Windows.  
> > > 
> > > Could you please tell me what the Windows's wrong code is? And what's
> > > wrong when someone is following the hardware spec?
> > 
> > the reason is that it's reserved on AMD hence software shouldn't even try
> > to use it or make any decisions based on that.
> > 
> > 
> > PS:
> > on contrary, doing such ad-hoc 'cleanups' for the sake of misbehaving
> > guest would actually complicate QEMU for no big reason.
> 
> The guest is not misbehaving. It is following the spec.
> > 
> > Also
> > KVM does do have plenty of such code, and it's not actively preventing guests from using it.
> > Given that KVM is not welcoming such change, I think QEMU shouldn't do that either.
> 
> Because KVM maintainer does not want to touch the guest ABI. He agrees
> this is a bug.

No, I agreed that KVM's behavior is pointless, annoying, and odd[*].  I do not
agree that KVM's behavior is an outright bug.

[*] https://lore.kernel.org/all/aF1S2EIJWN47zLDG@google.com

