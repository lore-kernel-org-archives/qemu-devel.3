Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603D0C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 17:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6ZBs-0004yP-G0; Mon, 13 May 2024 13:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3aElCZgYKCj0rdZmibfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--seanjc.bounces.google.com>)
 id 1s6ZBj-0004xx-RT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 13:10:12 -0400
Received: from mail-pl1-x649.google.com ([2607:f8b0:4864:20::649])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3aElCZgYKCj0rdZmibfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--seanjc.bounces.google.com>)
 id 1s6ZBg-0001d9-0K
 for qemu-devel@nongnu.org; Mon, 13 May 2024 13:10:09 -0400
Received: by mail-pl1-x649.google.com with SMTP id
 d9443c01a7336-1ed941c63b3so47314455ad.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 10:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715620201; x=1716225001; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=eqAMYyJARP70lQweb95UizBZYpowafIc/1BTiL7HAHE=;
 b=KXVm1y7KxV0phKT9EK9AzuCA0PQkTI5ip5YxQBYzR+G0ozDWKpMZ12Z8mM0Fg04Vp0
 BxstFDkPVv+teazI7tDpuKnoACwgm13FKffEPtYOPfz0YXTANDg4kLkcvsE8fcCZfxmA
 4TC1ADxMiSW7kSGwMEGt8j3GFDOsTCgNuWv1RNAefXKAxCKE+HE4F5mk2Tu4FWGyvrBt
 hm+tnHJckqOgQG9wTdsoNOvYr6MorUOqmqM9c1X90Ilrk+QVDYGJ7A1oStaL0H67ugeA
 A9dUNtyWc7cQXADsa9/pkgSbkljyaQGjkC5MOt94owcEm2PLonl3SwPShpVnl3JJuFQD
 CDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715620201; x=1716225001;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=eqAMYyJARP70lQweb95UizBZYpowafIc/1BTiL7HAHE=;
 b=XpsADfSdQ1s5ZrX7HXlxdnIIjznPfL2JZ+06joSnheMpPcjcCHkPZbtSL6QU/c+ifG
 46BuFTsGkDKDk2bC0Uz27wHFnj7lN7t3ugInRSlT9hp0dC2vL5B+3K1n5kq5sqaHC7H7
 U9QBZRH/qmnyka292pohvN9suW8cHUzQV5b6Dsz5Xe16paJEILPslodqgTArpuIOWnO8
 ddYuNA99DPOJCTfGbsdkkkXZHo311GGQY2B5QbSC/l0KDpx+b285MdvrXlRWLhR0wqre
 cZzBiQITdocGyWiAYROilaBU3l+xZnIeyXzZQlftTXtli8HXrQS7R1RGpYB0bzBvC3yX
 7+Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEilh7D34hpwgQ+hC/lpR019XkwrmkJ9yu1QMsbxu2fVxRGZ2Fr+ClLxgdV76Gwtx988P0HILdqolJjaSrjE3cmASWh1I=
X-Gm-Message-State: AOJu0YwJtO7xG75nDiS/Uq5OQ7wu8easkp+g78bsl6ZrVglFdpJt9luJ
 WeMuMVDmmDeL8HjFQ9JI7y9Cn5aqHJemkvaZdzkgSfT8MPWDjlPJM0Msa/cXd4c6SjfwLD2xCtr
 aPg==
X-Google-Smtp-Source: AGHT+IFe9bUcF2cKcIAR1X9HznQBXdRthmRbSGERQIgzvsrvwXGdt51Pjnpg13XPQnNPLlENosr3rjbDm/4=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e752:b0:1e5:62:7aa6 with SMTP id
 d9443c01a7336-1ef43c0fe5emr540015ad.2.1715620200915; Mon, 13 May 2024
 10:10:00 -0700 (PDT)
Date: Mon, 13 May 2024 10:09:59 -0700
In-Reply-To: <aaf684b5eb3a3fe9cfbb6205c16f0973c6f8bb07.camel@amazon.com>
Mime-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
 <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
 <ZkI0SCMARCB9bAfc@google.com>
 <aaf684b5eb3a3fe9cfbb6205c16f0973c6f8bb07.camel@amazon.com>
Message-ID: <ZkJFIpEHIQvfuzx1@google.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
From: Sean Christopherson <seanjc@google.com>
To: James Gowans <jgowans@amazon.com>
Cc: Patrick Roy <roypat@amazon.co.uk>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 Nikita Kalyazin <kalyazin@amazon.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "rppt@kernel.org" <rppt@kernel.org>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, 
 "somlo@cmu.edu" <somlo@cmu.edu>, "vbabka@suse.cz" <vbabka@suse.cz>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 David Woodhouse <dwmw@amazon.co.uk>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, 
 Alexander Graf <graf@amazon.de>, Derek Manwaring <derekmn@amazon.com>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, 
 "mst@redhat.com" <mst@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::649;
 envelope-from=3aElCZgYKCj0rdZmibfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--seanjc.bounces.google.com;
 helo=mail-pl1-x649.google.com
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

On Mon, May 13, 2024, James Gowans wrote:
> On Mon, 2024-05-13 at 08:39 -0700, Sean Christopherson wrote:
> > > Sean, you mentioned that you envision guest_memfd also supporting non=
-CoCo VMs.
> > > Do you have some thoughts about how to make the above cases work in t=
he
> > > guest_memfd context?
> >=20
> > Yes.=C2=A0 The hand-wavy plan is to allow selectively mmap()ing guest_m=
emfd().=C2=A0 There
> > is a long thread[*] discussing how exactly we want to do that.=C2=A0 Th=
e TL;DR is that
> > the basic functionality is also straightforward; the bulk of the discus=
sion is
> > around gup(), reclaim, page migration, etc.
>=20
> I still need to read this long thread, but just a thought on the word
> "restricted" here: for MMIO the instruction can be anywhere and
> similarly the load/store MMIO data can be anywhere. Does this mean that
> for running unmodified non-CoCo VMs with guest_memfd backend that we'll
> always need to have the whole of guest memory mmapped?

Not necessarily, e.g. KVM could re-establish the direct map or mremap() on-=
demand.
There are variation on that, e.g. if ASI[*] were to ever make it's way upst=
ream,
which is a huge if, then we could have guest_memfd mapped into a KVM-only C=
R3.

> I guess the idea is that this use case will still be subject to the
> normal restriction rules, but for a non-CoCo non-pKVM VM there will be=20
> no restriction in practice, and userspace will need to mmap everything
> always?
>=20
> It really seems yucky to need to have all of guest RAM mmapped all the
> time just for MMIO to work... But I suppose there is no way around that
> for Intel x86.

It's not just MMIO.  Nested virtualization, and more specifically shadowing=
 nested
TDP, is also problematic (probably more so than MMIO).  And there are more =
cases,
i.e. we'll need a generic solution for this.  As above, there are a variety=
 of
options, it's largely just a matter of doing the work.  I'm not saying it's=
 a
trivial amount of work/effort, but it's far from an unsolvable problem.

