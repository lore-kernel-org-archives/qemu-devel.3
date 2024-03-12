Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366F3C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 10:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjzYR-0005hK-Ga; Tue, 12 Mar 2024 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzYJ-0005gS-UV; Tue, 12 Mar 2024 06:40:12 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjzYG-0007dc-2C; Tue, 12 Mar 2024 06:40:11 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6e56787e691so4229353b3a.0; 
 Tue, 12 Mar 2024 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710240006; x=1710844806; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0wkh5vlrIpHi2cSd3fiQ4H0ke18IWyPO1yxkqyO4Vvo=;
 b=EJoufWE+uLfmOCajG+wOocIkbGcwJO7sFRc/mhTubv47meyywsiQFYLmkVp166pBa0
 LUfhlO09mgbXNPXBJlztznH4d+Jg0ZQ2v8jQwSJXx+0MNvgywuzZZW0CE9ve16FunaxJ
 uTcXx+xtToMORtORMSJeFPmGfpnrH7syj2+ExpUEbzhx95X/f0a5VQwPCq5eXnVqHAB6
 znqXf7QDyC1BuqDqjPNUG8LrEQ71yn+9c04IT6wqRglc05RnxcZ23Cf6G0n+D1fvR4bl
 E6XIbpa3AM3Qez+h8SI+E4TPMVh015ES9gCCngKupdyr8NifYsMGLm2Ayp/hCjo9mHDq
 1wWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710240006; x=1710844806;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0wkh5vlrIpHi2cSd3fiQ4H0ke18IWyPO1yxkqyO4Vvo=;
 b=KzGKtkTmIPbdMZYLxrzcp6YUcfsu+Cf6aOZyEWNXRUHIEIYEuxGK5TrHogpftA41ky
 kAUQN5W8hYCe1EICJRpdNCVwd6TaDzqah0QT4C8GqRlhGEH8wY13Z8OsQGk3Y1a10bCG
 8Znjg6Ye4i1hV/h18k95lv2YuWCBUU+V2acv5IJa758U2ca6XZb0DDnqDbhMYbwJA4Mt
 CltyqNYIhLXM0OEH830L07LBZ7JloTRKb3WYKGkMqfJr12DcoFZEoLk6Qldbpm/pVFWx
 4xqPo5quyR8OYfWq/k/TTp/xF8UV03rF7OEug5KQaFvr87OJrpCx6yT7nYOUqYXWdjGN
 mR4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRWQdal5ptQlMbmwgqzK/3KksyAOGbE6QFo+XOtuoXgG6F2Q+oqnEvX/OnJTKqBQnHWq9xzFrrh+eKREsQ0+KQQ37O
X-Gm-Message-State: AOJu0Yz2b8Dg/xTTZu58c3VodqAZIkY9K1vUNUQnM/V35vBM5YsO9HRw
 6aVyKXYiz4aJhhVLg4TVfk9hADMRIUAMEjSbItkzxfU0Nmx4peEbikvNvvUCAWA=
X-Google-Smtp-Source: AGHT+IF3r0EOGZ2xvC6JwAdlubqOdclTbbgkwPKcI849uyzp6oeDLep3OX/nj+mIJ46nwwP7E6eOxw==
X-Received: by 2002:a05:6a20:a128:b0:1a3:1514:3e4 with SMTP id
 q40-20020a056a20a12800b001a3151403e4mr8059230pzk.20.1710240006100; 
 Tue, 12 Mar 2024 03:40:06 -0700 (PDT)
Received: from localhost ([118.208.155.46]) by smtp.gmail.com with ESMTPSA id
 16-20020a631650000000b005b458aa0541sm5727181pgw.15.2024.03.12.03.40.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:40:05 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 12 Mar 2024 20:40:01 +1000
Message-Id: <CZRPHE6EOXQI.24XEVX89QPMHT@wheely>
Cc: <qemu-devel@nongnu.org>, "BALATON Zoltan" <balaton@eik.bme.hu>, "David
 Gibson" <david@gibson.dropbear.id.au>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH] spapr: avoid overhead of finding vhyp class in critical
 operations
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240224073359.1025835-1-npiggin@gmail.com>
 <a465cc07-17ee-48ea-95e6-14c15697ab09@linux.ibm.com>
 <CZRN44HD20CR.33XSLDXL84FZH@wheely>
 <672bd14a-235c-40e3-a859-d822f1b063cd@linux.ibm.com>
In-Reply-To: <672bd14a-235c-40e3-a859-d822f1b063cd@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

On Tue Mar 12, 2024 at 6:56 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 3/12/24 14:18, Nicholas Piggin wrote:
> > On Tue Mar 12, 2024 at 4:38 PM AEST, Harsh Prateek Bora wrote:
> >> Hi Nick,
> >>
> >> One minor comment below:
> >>
> >> On 2/24/24 13:03, Nicholas Piggin wrote:
> >>> PPC_VIRTUAL_HYPERVISOR_GET_CLASS is used in critical operations like
> >>> interrupts and TLB misses and is quite costly. Running the
> >>> kvm-unit-tests sieve program with radix MMU enabled thrashes the TCG
> >>> TLB and spends a lot of time in TLB and page table walking code. The
> >>> test takes 67 seconds to complete with a lot of time being spent in
> >>> code related to finding the vhyp class:
> >>>
> >>>      12.01%  [.] g_str_hash
> >>>       8.94%  [.] g_hash_table_lookup
> >>>       8.06%  [.] object_class_dynamic_cast
> >>>       6.21%  [.] address_space_ldq
> >>>       4.94%  [.] __strcmp_avx2
> >>>       4.28%  [.] tlb_set_page_full
> >>>       4.08%  [.] address_space_translate_internal
> >>>       3.17%  [.] object_class_dynamic_cast_assert
> >>>       2.84%  [.] ppc_radix64_xlate
> >>>
> >>> Keep a pointer to the class and avoid this lookup. This reduces the
> >>> execution time to 40 seconds.
> >>>
> >>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> >>> ---
> >>> This feels a bit ugly, but the performance problem of looking up the
> >>> class in fast paths can't be ignored. Is there a "nicer" way to get t=
he
> >>> same result?
> >>>
> >>> Thanks,
> >>> Nick
> >>>
> >>>    target/ppc/cpu.h           |  3 ++-
> >>>    target/ppc/mmu-book3s-v3.h |  4 +---
> >>>    hw/ppc/pegasos2.c          |  1 +
> >>>    target/ppc/cpu_init.c      |  9 +++------
> >>>    target/ppc/excp_helper.c   | 16 ++++------------
> >>>    target/ppc/kvm.c           |  4 +---
> >>>    target/ppc/mmu-hash64.c    | 16 ++++------------
> >>>    target/ppc/mmu-radix64.c   |  4 +---
> >>>    8 files changed, 17 insertions(+), 40 deletions(-)
> >>>
> >>> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> >>> index ec14574d14..eb85d9aa71 100644
> >>> --- a/target/ppc/cpu.h
> >>> +++ b/target/ppc/cpu.h
> >>> @@ -1437,6 +1437,7 @@ struct ArchCPU {
> >>>        int vcpu_id;
> >>>        uint32_t compat_pvr;
> >>>        PPCVirtualHypervisor *vhyp;
> >>> +    PPCVirtualHypervisorClass *vhyp_class;
> >>>        void *machine_data;
> >>>        int32_t node_id; /* NUMA node this CPU belongs to */
> >>>        PPCHash64Options *hash64_opts;
> >>> @@ -1535,7 +1536,7 @@ DECLARE_OBJ_CHECKERS(PPCVirtualHypervisor, PPCV=
irtualHypervisorClass,
> >>>   =20
> >>>    static inline bool vhyp_cpu_in_nested(PowerPCCPU *cpu)
> >>>    {
> >>> -    return PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp)->cpu_in_neste=
d(cpu);
> >>> +    return cpu->vhyp_class->cpu_in_nested(cpu);
> >>>    }
> >>>    #endif /* CONFIG_USER_ONLY */
> >>>   =20
> >>> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> >>> index 674377a19e..f3f7993958 100644
> >>> --- a/target/ppc/mmu-book3s-v3.h
> >>> +++ b/target/ppc/mmu-book3s-v3.h
> >>> @@ -108,9 +108,7 @@ static inline hwaddr ppc_hash64_hpt_mask(PowerPCC=
PU *cpu)
> >>>        uint64_t base;
> >>>   =20
> >>>        if (cpu->vhyp) {
> >>
> >> All the checks for cpu->vhyp needs to be changed to check for
> >> cpu->vhyp_class now, for all such instances.
> >=20
> > It wasn't supposed to, because vhyp !=3D NULL implies vhyp_class !=3D N=
ULL.
> > It's supposed to be an equivalent transformation just changing the
> > lookup function.
>
> I agree, but not just it appears a bit odd, my only worry is if a future
> change cause vhyp_class to be NULL before the control reaches here, this
> check wont really serve the purpose. Anyways, not a mandatory
> requirement for now, so I shall leave it to your choice.

It does look like it should be the other way around without context
of s/PPC_V_H_G_C(cpu->vhyp)/cpu->vhyp_class/

We'll never have a vhyp !=3D NULL && vhyp_class =3D=3D NULL though, so
should be okay.

Thanks,
Nick

