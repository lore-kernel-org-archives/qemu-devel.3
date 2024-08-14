Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DAAAC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 06:10:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se7Cg-0005mA-Eo; Wed, 14 Aug 2024 02:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1se7Cc-0005jl-Q7; Wed, 14 Aug 2024 02:09:46 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1se7Ca-0007UG-Ux; Wed, 14 Aug 2024 02:09:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-710dc3015bfso436530b3a.0; 
 Tue, 13 Aug 2024 23:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723615783; x=1724220583; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tvj6dxzwaKtmrj1Y4GCRu3Xmy7ActFFgMrXCLugTjHo=;
 b=KB8sMwfaV3H/k99X6c8t9ILSmEdjPNXzr0CPwFCTJGfiajd+bkaWGRwnuYLVioBKh5
 JJ3AX24hrm3Y89w4KznS8HlgNAeVME+FlkOhsUOFlwZbW3t28YSnEsBy7EJqOEGcH/uD
 O1b0k9+3O6wq3AQFifvr4kL7jaOHLnymc5ae5rccyGi5Qeo0KmFdzUENo6t/oT3v/f3+
 U1WuUT5+D4m68j8PW3bUEp1LuVhmBj4k2wqWjj/CzkAywanmpOCvVyVRMgFpD63cU+dg
 Cf2+yrl2R793He/aOOuAJGMfEJSkmMKeRZPiic8Cx6ZDeta9XhcagyQvZhLdd8mK1S+d
 EveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723615783; x=1724220583;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tvj6dxzwaKtmrj1Y4GCRu3Xmy7ActFFgMrXCLugTjHo=;
 b=AAV+22HJINV8Z45nX+Jfn76CZUDd68ZQK7LQg0w3i+KmbnbgZjPSvPG53f2e5qGYnB
 xAvvBjgYnZq8e+bTrspaSu8YnTXWbSAnWLikc3WfZq6Q2gYPbUAKHGjH+AJBVuv1+yQ5
 9g5cBbuXWagyfLA+0BIWiEsnmhUXdTdqgBzff3gNiNRLGcIxeJiVErYu/w9c/xmrN6r/
 jg4CnZFPhvhsIjySoRPed5SsiFV7vyEUnFltfnUCXmQ4aTYwcjGEELhHnz8tGwogGp1s
 nEkOV4eiLJaZe8a9/xzNRVu2p2mkDTAjQEJG1dnV6TfzZG5zRpF9+s30SnyQulxj46Md
 yRHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8qxN8+A3zGX6VY9nmOXIjE3sjhL6r6DzACR+G8/zfEewPfI8dtH+6PwsJkjwADMdoGgCclMIL4jmoxN33ExE6WWxY7zgfTHP0Bmyu+cCUW8YyCCnpcMnJtBY=
X-Gm-Message-State: AOJu0Yz5cSZV/uwFNWPgnwMl9bqHHlZOlezynqLvy2j+Ifu2/QAGsV3t
 t9EC4q1fp1wD1IOyvLgYnl37B0H2eKiUFDsyCDIeEvOf5SfdHv9A
X-Google-Smtp-Source: AGHT+IH0eP31zmhNSHBssl8AhB4n0K3oMrU74Bc4tu4PoZcPVnOSNU2J6KCWFnIFOMDn3LKVNRx7uQ==
X-Received: by 2002:a05:6a20:3d95:b0:1c4:8573:b3f9 with SMTP id
 adf61e73a8af0-1c8da18b791mr7831343637.2.1723615782819; 
 Tue, 13 Aug 2024 23:09:42 -0700 (PDT)
Received: from localhost ([1.145.94.19]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c697a05ed4sm2457906a12.56.2024.08.13.23.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 23:09:42 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Aug 2024 16:09:36 +1000
Message-Id: <D3FESSMCNW22.3S68NMF7NI5KR@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>,
 <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [RFC PATCH] accel/tcg: clear all TBs from a page when it is
 written to
X-Mailer: aerc 0.18.2
References: <20240809074725.320801-1-npiggin@gmail.com>
 <c098afe9-d09d-400d-8f2b-9278744a4ad4@linaro.org>
In-Reply-To: <c098afe9-d09d-400d-8f2b-9278744a4ad4@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon Aug 12, 2024 at 11:25 AM AEST, Richard Henderson wrote:
> On 8/9/24 17:47, Nicholas Piggin wrote:
> > This is not a clean patch, but does fix a problem I hit with TB
> > invalidation due to the target software writing to memory with TBs.
> >=20
> > Lockup messages are triggering in Linux due to page clearing taking a
> > long time when a code page has been freed, because it takes a lot of
> > notdirty notifiers, which massively slows things down. Linux might
> > possibly have a bug here too because it seems to hang indefinitely in
> > some cases, but even if it didn't, the latency of clearing these pages
> > is very high.
> >=20
> > This showed when running KVM on the emulated machine, starting and
> > stopping guests. That causes lots of instruction pages to be freed.
> > Usually if you're just running Linux, executable pages remain in
> > pagecache so you get fewer of these bombs in the kernel memory
> > allocator. But page reclaim, JITs, deleting executable files, etc.,
> > could trigger it too.
> >=20
> > Invalidating all TBs from the page on any hit seems to avoid the proble=
m
> > and generally speeds things up.
> >=20
> > How important is the precise invalidation? These days I assume the
> > tricky kind of SMC that frequently writes code close to where it's
> > executing is pretty rare and might not be something we really care abou=
t
> > for performance. Could we remove sub-page TB invalidation entirely?
>
> Happens on x86 and s390 regularly enough, so we can't remove it.
>
> > @@ -1107,6 +1107,9 @@ tb_invalidate_phys_page_range__locked(struct page=
_collection *pages,
> >       TranslationBlock *current_tb =3D retaddr ? tcg_tb_lookup(retaddr)=
 : NULL;
> >   #endif /* TARGET_HAS_PRECISE_SMC */
> >  =20
> > +    start &=3D TARGET_PAGE_MASK;
> > +    last |=3D ~TARGET_PAGE_MASK;
> > +
> >       /* Range may not cross a page. */
> >       tcg_debug_assert(((start ^ last) & TARGET_PAGE_MASK) =3D=3D 0);
>
> This would definitely break SMC.

They can't invalidate the instruction currently being executed?
I'll experiment a bit more.

> However, there's a better solution.  We're already iterating over all of =
the TBs on the=20
> current page only.  Move *everything* except the tb_phys_invalidate__lock=
ed call into the=20
> SMC ifdef, and unconditionally invalidate every TB selected in the loop.

Okay. I suspect *most* of the time even the strict SMC archs would
not be writing to the same page they're executing either. But I can
start with the !SMC.

> We experimented with something like this for aarch64, which used to spend=
 a lot of the=20
> kernel startup time invalidating code pages from the (somewhat bloated) E=
DK2 bios.  But it=20
> turned out the bigger problem was address space randomization, and with C=
F_PCREL the=20
> problem appeared to go away.

Interesting.

> I don't think we've done any kvm-under-tcg performance testing, but locku=
p messages would=20
> certainly be something to look for...

Yeah, actually Linux is throwing the messages a bit more recently
at least on distros that enable page clearing at alloc for security,
because that clearing is a big chunk that can happen in critical
sections.

Thanks for the suggestion, I'll give it a try.

Thanks,
Nick

