Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE47C25B74
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 05:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wiE-0003i4-Re; Thu, 09 May 2024 01:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wi5-0003hl-Gm; Thu, 09 May 2024 01:52:54 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wi2-0008WD-Lz; Thu, 09 May 2024 01:52:52 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f44881ad9eso460753b3a.3; 
 Wed, 08 May 2024 22:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715233969; x=1715838769; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ng4THqpi0CZZlYmUEe2qNhSjbq+mQ2JSxgJUAFLPVRg=;
 b=fTFMSCCxdwYBnGAbi1EDyU/RPaTMwx70sG6jWnwVi4gJW+xl9qMO1cqGiMLo5TPx56
 R3wvJI7qPIAxMRyfoAmMd8g3FRsJOnzZC5VxyEMHOwPPBSIa5TI0TeHTYkP1HIehd1O6
 zs4hkV9tLdv/I8qKnHkIM/17oe3MOx09i4gKB0LCpIKZf9KJEq7zZ7vwtfM7QwoIeoeK
 cjz8hlwyX4kowOOU8241t/S3VZkzS3C1qqQ6jz1SVQXAC9ZuK+h7T8BjAXeSog23vqTM
 7/zfR/2HdLHz0a4vB8tfbOhHu1pWG9P02FW39z4ryEIje7cjNLsjsxxjKf/C7XC/a3Dq
 ArzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715233969; x=1715838769;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ng4THqpi0CZZlYmUEe2qNhSjbq+mQ2JSxgJUAFLPVRg=;
 b=vavQUfR0vCl97u6iHmP3TQa6dM/fLj+cVr3C2H5A4/p8J+GTPOuupsiOBvrusNDW9G
 G+TlMfQtStoUWFHOxi8GayBi8PUzr5YxcxJoICV3rNBseeF4+VuwG0cpcw9CCXzmCaRD
 gY6h4H7F11YpW+uzeC/pKAHPI0ZyCUft9W/fbjsUZuQqm6bBJ+sZRHiBIXaySRc5XRTs
 3CwvVeDxw9CLTYwEtF/C0Nes+X9cAtWsCMl7vdbZxI41B9wQmTv+EGhMXaeCVgG9H/aR
 gYWTnujsq1SpcMnbMPJbMk9Th4wlJsjzx9F4FMTXIwTwIVj6I2DepIu3+JMf2l2YFg1i
 HVRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/ucXsKAmx/AIXJYMwnTfOfNMq/EbUNklcZjGRUMh9z5AG+DeVKZuObWCbe3IOgcVYt1pAEtbXT9fGiyyPaPCrt9kM
X-Gm-Message-State: AOJu0YwEbZ+uKik9hprP3PHZc2hx5sOCalafBid6mxAzw1BZZagK7rJH
 Dmc0FcIYxCrvXaQ917/VZooZN2CzeZBPoHyPmPAQTGTF8uSQXQ8/
X-Google-Smtp-Source: AGHT+IF/Pmozg1S/Bld4oGz9xRL4+GwP9Ob75Qe9M9Q9RbV9WFW3moYFdJEFSwh3oKWZaMWSWmbxSA==
X-Received: by 2002:a05:6a20:dd89:b0:1af:64fb:a04c with SMTP id
 adf61e73a8af0-1afc8d5288cmr4407200637.34.1715233968741; 
 Wed, 08 May 2024 22:52:48 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0b9d47e0sm5440445ad.5.2024.05.08.22.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 22:52:48 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 15:52:43 +1000
Message-Id: <D14VP1139W6V.3UTHJMK913G1F@gmail.com>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v3 33/33] target/ppc: Add a macro to check for page
 protection bit
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.17.0
References: <cover.1715125376.git.balaton@eik.bme.hu>
 <a91a1b9455f88cbbeff2652fc4f44acd89e98215.1715125376.git.balaton@eik.bme.hu>
 <D14ASGGTNSQB.3TX66EXAL001R@gmail.com>
 <6bb8ab43-e083-6ff8-5740-1cb16ef10304@eik.bme.hu>
In-Reply-To: <6bb8ab43-e083-6ff8-5740-1cb16ef10304@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu May 9, 2024 at 1:23 AM AEST, BALATON Zoltan wrote:
> On Wed, 8 May 2024, Nicholas Piggin wrote:
> > On Wed May 8, 2024 at 10:15 AM AEST, BALATON Zoltan wrote:
> >> Checking if a page protection bit is set for a given access type is a
> >> common operation. Add a macro to avoid repeating the same check at
> >> multiple places and also avoid a function call. As this relies on
> >> access type and page protection bit values having certain relation
> >> also add an assert to ensure that this assumption holds.
> >>
> >> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> >> ---
> >>  target/ppc/cpu_init.c    |  4 ++++
> >>  target/ppc/internal.h    | 20 ++------------------
> >>  target/ppc/mmu-hash32.c  |  6 +++---
> >>  target/ppc/mmu-hash64.c  |  2 +-
> >>  target/ppc/mmu-radix64.c |  2 +-
> >>  target/ppc/mmu_common.c  | 26 +++++++++++++-------------
> >>  6 files changed, 24 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> >> index 92c71b2a09..6639235544 100644
> >> --- a/target/ppc/cpu_init.c
> >> +++ b/target/ppc/cpu_init.c
> >> @@ -7377,6 +7377,10 @@ static void ppc_cpu_class_init(ObjectClass *oc,=
 void *data)
> >>      resettable_class_set_parent_phases(rc, NULL, ppc_cpu_reset_hold, =
NULL,
> >>                                         &pcc->parent_phases);
> >>
> >> +    /* CHECK_PROT_ACCESS relies on this MMU access and PAGE bits rela=
tion */
> >> +    assert(MMU_DATA_LOAD =3D=3D 0 && MMU_DATA_STORE =3D=3D 1 && MMU_I=
NST_FETCH =3D=3D 2 &&
> >> +           PAGE_READ =3D=3D 1 && PAGE_WRITE =3D=3D 2 && PAGE_EXEC =3D=
=3D 4);
> >> +
> >
> > Can you use qemu_build_assert() for this?
>
> First I've try #if and #error but seems access_type is an enum and the=20
> preprocessor does not see those. If qemu_build_assert is a wrapper around=
=20
> the same then it might not work but I'll check.
>
> >>      cc->class_by_name =3D ppc_cpu_class_by_name;
> >>      cc->has_work =3D ppc_cpu_has_work;
> >>      cc->mmu_index =3D ppc_cpu_mmu_index;
> >> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> >> index 46176c4711..9880422ce3 100644
> >> --- a/target/ppc/internal.h
> >> +++ b/target/ppc/internal.h
> >> @@ -234,24 +234,8 @@ void destroy_ppc_opcodes(PowerPCCPU *cpu);
> >>  void ppc_gdb_init(CPUState *cs, PowerPCCPUClass *ppc);
> >>  const gchar *ppc_gdb_arch_name(CPUState *cs);
> >>
> >> -/**
> >> - * prot_for_access_type:
> >> - * @access_type: Access type
> >> - *
> >> - * Return the protection bit required for the given access type.
> >> - */
> >> -static inline int prot_for_access_type(MMUAccessType access_type)
> >> -{
> >> -    switch (access_type) {
> >> -    case MMU_INST_FETCH:
> >> -        return PAGE_EXEC;
> >> -    case MMU_DATA_LOAD:
> >> -        return PAGE_READ;
> >> -    case MMU_DATA_STORE:
> >> -        return PAGE_WRITE;
> >> -    }
> >> -    g_assert_not_reached();
> >> -}
> >> +/* Check if permission bit required for the access_type is set in pro=
t */
> >> +#define CHECK_PROT_ACCESS(prot, access_type) ((prot) & (1 << (access_=
type)))
> >
> > We don't want to use a macro when an inline function will work.
>
> What's wrong with a macro? This has no local variables or any complex=20
> operation that would warant a function IMO it's just a conditional named=
=20
> for convenience so we don't have to type it everywhere and easier to see=
=20
> what is it for. A macro is just right for that.

Macro does not get parameter or return type check, and has a bunch of
other potential issues

https://gcc.gnu.org/onlinedocs/cpp/macros/macro-pitfalls.html

Macro should not be used unless you can not do it with inline function.
There is no benefit to macro here.

>
> > Does the compiler not see the pattern and transform the existing
> > code into a shift? If it does then I would leave it. If not, then
> > just keep prot_for_access_type but make it a shift and maybe
> > comment the logic.
>
> I don't know but prot_for_access_type is not even needed because this wil=
l=20
> work for that too passing PAGE_RWX for prot as done below at one place so=
=20
> no need for another function for that.
>
> > I would call the new function check_prot_for_access_type().
>
> I can rename it and could make it static inline but I like a macro for=20
> this better.

Thanks,
Nick

