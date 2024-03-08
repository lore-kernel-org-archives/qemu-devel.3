Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 059ADC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 23:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rijYM-0002NE-Vs; Fri, 08 Mar 2024 18:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3y53rZQYKCuoeQMZVOSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--seanjc.bounces.google.com>)
 id 1rijYI-0002Mq-PW
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 18:22:59 -0500
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3y53rZQYKCuoeQMZVOSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--seanjc.bounces.google.com>)
 id 1rijYF-0004UV-P9
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 18:22:57 -0500
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-60a0899c5f3so15062437b3.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 15:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709940172; x=1710544972; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=7S3B1t8pdIqU5Wjnk50i6MWuw2joVUe0pWEUYZUDmO4=;
 b=xsRSJ7UvjmleCn6wAAhjgY36zuByRCd6cX7ZboQ0GzwIez8FHfjBWSeBOPpjjN4Kka
 AYOqU0yL30TmndndrfoVX2z4myLNQm6xriexVtFPX6lhb4RBIuYiyhhuXDzZPP5TY1Cz
 Z5YjQDVHPCMc9MhkhkfaaplVpNyfGcKz+m3jG/7f2yknlFwqCqIROZkkCQFqwI3NYF0V
 zrHc6M2pRpz/Umoxg+aPcMCU62qS7d3ZCxg7lnAqQzSTNqXmy5mBHkbLuQC2HJ+nW5Eg
 BV451pjbwoXzppKLqDKx53MBYpMmCaDDNwZ3J7DrCHtcwm2EpgwUTJA71qryK1DNjp3Z
 PTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709940172; x=1710544972;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7S3B1t8pdIqU5Wjnk50i6MWuw2joVUe0pWEUYZUDmO4=;
 b=uiMsDR3XyPYZwv76jYEoVCpZ3HqheIbJUeRB6M1mjARcf8xFRmkbNsA0c79JPbHv/J
 M//TUzg18pg4UsOblKBnr8HBnqPFkn95tHm/dIqa1Zt8oSAOOz1XvEf4OwEZd/SkimiO
 fyCfSwSHUmH1kgu235tAf5gLPdOumY8QLiF4Pue5+Vpa2mwtVLgledzoOP/h+Oiur4KP
 CmYIB8HrT52AHF5Xmiyl6B2nG2J3N1Z6hA/k/uIirF7E15tkyC27ohV37fiQYbUf17+g
 RIAEt4AgR7DflWc3SMvQw/vYxxaWvq02k+f2JrjqKMBXHEc8FYyQjRHoTaLJu8gv2/FU
 GfBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO4w8bT1mMnzeIVBxIbrPQa8Hx5/to0/zT419Z9ynh/zvZZOYLDQPxCdrsY2yJ0WxQO+1ac00okUdvDRrq7nl0nIaQ62Q=
X-Gm-Message-State: AOJu0Yxo0beNavNkLrtrOZGuqVtQTDTMqbte+CCUYYY9lGtFAwU4HjfG
 QxceFcGcNlg6lRhuvIfjFFCERaxsWdM1o91R768rIarrqnSC3/DobLDBnfzEdPwehJF1sifz2yf
 ScA==
X-Google-Smtp-Source: AGHT+IHIif5Eml2ZF3fDerW6drNpqFldJ7Jz2SKMgJzKuurv4zQCJLfYI0vd1IGQU3mKE9h27C6nTWKouOk=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:d7d3:0:b0:608:e67f:4387 with SMTP id
 z202-20020a0dd7d3000000b00608e67f4387mr134113ywd.7.1709940171728; Fri, 08 Mar
 2024 15:22:51 -0800 (PST)
Date: Fri, 8 Mar 2024 15:22:50 -0800
In-Reply-To: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
Mime-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
Message-ID: <ZeudRmZz7M6fWPVM@google.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
From: Sean Christopherson <seanjc@google.com>
To: James Gowans <jgowans@amazon.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Patrick Roy <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 Derek Manwaring <derekmn@amazon.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, Nikita Kalyazin <kalyazin@amazon.co.uk>, 
 "lstoakes@gmail.com" <lstoakes@gmail.com>,
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, 
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>,
 Alexander Graf <graf@amazon.de>, 
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::114a;
 envelope-from=3y53rZQYKCuoeQMZVOSaaSXQ.OaYcQYg-PQhQXZaZSZg.adS@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x114a.google.com
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

On Fri, Mar 08, 2024, James Gowans wrote:
> However, memfd_secret doesn=E2=80=99t work out the box for KVM guest memo=
ry; the
> main reason seems to be that the GUP path is intentionally disabled for
> memfd_secret, so if we use a memfd_secret backed VMA for a memslot then
> KVM is not able to fault the memory in. If it=E2=80=99s been pre-faulted =
in by
> userspace then it seems to work.

Huh, that _shouldn't_ work.  The folio_is_secretmem() in gup_pte_range() is
supposed to prevent the "fast gup" path from getting secretmem pages.

Is this on an upstream kernel?  If so, and if you have bandwidth, can you f=
igure
out why that isn't working?  At the very least, I suspect the memfd_secret
maintainers would be very interested to know that it's possible to fast gup
secretmem.

> There are a few other issues around when KVM accesses the guest memory.
> For example the KVM PV clock code goes directly to the PFN via the
> pfncache, and that also breaks if the PFN is not in the direct map, so
> we=E2=80=99d need to change that sort of thing, perhaps going via userspa=
ce
> addresses.
>=20
> If we remove the memfd_secret check from the GUP path, and disable KVM=E2=
=80=99s
> pvclock from userspace via KVM_CPUID_FEATURES, we are able to boot a
> simple Linux initrd using a Firecracker VMM modified to use
> memfd_secret.
>=20
> We are also aware of ongoing work on guest_memfd. The current
> implementation unmaps guest memory from VMM address space, but leaves it
> in the kernel=E2=80=99s direct map. We=E2=80=99re not looking at unmappin=
g from VMM
> userspace yet; we still need guest RAM there for PV drivers like virtio
> to continue to work. So KVM=E2=80=99s gmem doesn=E2=80=99t seem like the =
right solution?

We (and by "we", I really mean the pKVM folks) are also working on allowing
userspace to mmap() guest_memfd[*].  pKVM aside, the long term vision I hav=
e for
guest_memfd is to be able to use it for non-CoCo VMs, precisely for the sec=
urity
and robustness benefits it can bring.

What I am hoping to do with guest_memfd is get userspace to only map memory=
 it
needs, e.g. for emulated/synthetic devices, on-demand.  I.e. to get to a st=
ate
where guest memory is mapped only when it needs to be.  More below.

> With this in mind, what=E2=80=99s the best way to solve getting guest RAM=
 out of
> the direct map? Is memfd_secret integration with KVM the way to go, or
> should we build a solution on top of guest_memfd, for example via some
> flag that causes it to leave memory in the host userspace=E2=80=99s page =
tables,
> but removes it from the direct map?=20

100% enhance guest_memfd.  If you're willing to wait long enough, pKVM migh=
t even
do all the work for you. :-)

The killer feature of guest_memfd is that it allows the guest mappings to b=
e a
superset of the host userspace mappings.  Most obviously, it allows mapping=
 memory
into the guest without mapping first mapping the memory into the userspace =
page
tables.  More subtly, it also makes it easier (in theory) to do things like=
 map
the memory with 1GiB hugepages for the guest, but selectively map at 4KiB g=
ranularity
in the host.  Or map memory as RWX in the guest, but RO in the host (I don'=
t have
a concrete use case for this, just pointing out it'll be trivial to do once
guest_memfd supports mmap()).

Every attempt to allow mapping VMA-based memory into a guest without it bei=
ng
accessible by host userspace emory failed; it's literally why we ended up
implementing guest_memfd.  We could teach KVM to do the same with memfd_sec=
ret,
but we'd just end up re-implementing guest_memfd.

memfd_secret obviously gets you a PoC much faster, but in the long term I'm=
 quite
sure you'll be fighting memfd_secret all the way.  E.g. it's not dumpable, =
it
deliberately allocates at 4KiB granularity (though I suspect the bug you fo=
und
means that it can be inadvertantly mapped with 2MiB hugepages), it has no l=
ine
of sight to taking userspace out of the equation, etc.

With guest_memfd on the other hand, everyone contributing to and maintainin=
g it
has goals that are *very* closely aligned with what you want to do.

[*] https://lore.kernel.org/all/20240222161047.402609-1-tabba@google.com

