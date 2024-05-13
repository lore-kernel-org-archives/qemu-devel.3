Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 468ABC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 15:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6XmU-00050X-MT; Mon, 13 May 2024 11:40:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3SjRCZgYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com>)
 id 1s6XmQ-00050I-It
 for qemu-devel@nongnu.org; Mon, 13 May 2024 11:39:58 -0400
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3SjRCZgYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com>)
 id 1s6XmO-00087n-Mo
 for qemu-devel@nongnu.org; Mon, 13 May 2024 11:39:58 -0400
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc647f65573so9881721276.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715614794; x=1716219594; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
 :reply-to; bh=n3Z5PYvhEmOWZdAv2mF8wgraFReVMHPpsbJyP0PVGQk=;
 b=xEy2W4GIwXfik1ULIU0Cp5W4sIvXzT5QtFm0Dz/0Y4UQXpv3ZLuBEiPLoflpu1SdRk
 l5o4j4SgKi0J2jqjcMOOyKUKXtC0UCpYjGSlAaZBgxWH2GxO0Fo0HkpcE0YGeo3MdOtd
 GPVeAmlahR7byMWsbzaaHcha6ISF2GKy+4AiJKYj5sru692FCKBZfFNfXyBCv/CIIi+9
 K0lQq2A7hnWgDwHk27vBHgEGQv0zFNCOPTas1poeIeVs0FBrTcoUW/jr73CJRjokYQ75
 bYStZr6Gz/BmxyqzuC+UfK7E8G3Oq2KfCgW98P8+woPqc3H0UYw3eK3DKMGo6nveCNAq
 21fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715614794; x=1716219594;
 h=content-transfer-encoding:cc:to:from:subject:message-id:references
 :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=n3Z5PYvhEmOWZdAv2mF8wgraFReVMHPpsbJyP0PVGQk=;
 b=s2k9xttrEk+0w0t9pS4xmzzkxpA3NRdGrGF8pGWdXzVV2dW/ZMCVbfW81lc0hfhuwY
 MNiWyrsagiHslpIS0HeiQVsJNePmMfCQeowFTDuIb1MkOWiHXNMcNtdXkiKFjip9YSlo
 zeJfu+leHmQepp30daPlNDYosUVH9BYZk+RZ8NhgqRHk/g7/IWhNDcDH6gWKW0En13ND
 oNYePAqQ1QdBCic5LoPwbElnvQ/2zajk8ZPjIWzeGk+KZZerPqi9GEWjVAknIeTlhAiD
 BMwnDjbIU4tOJJsABjD1/K4xOtC4IQn8eZPFbd/fZaNsaGmGrOusyNtipqY/gF0Km8Zo
 3TXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6YxXQO39zBJrUQ9oOIPGLRYBhpCVUcAJ6KRA1aHSMPpJiBKsnG/+WMyFNoS9GCUslnhNsSFB2V6H7dK2sb2YcMYELSg4=
X-Gm-Message-State: AOJu0YzeTHrVhfxEYX28os1Uzyc3DaPu0L98G01XzOBlJFCakYvDODc+
 yn0/m11rmH74QJUhz8w9/r11L8H6LV5DEHb/N1a0WnSsbIc7UkOopwygP+pLBF5mOxR7QGRWY3n
 YrQ==
X-Google-Smtp-Source: AGHT+IHuwIc8fyCnlatjoe9Q2CYS4eVJOdzUScq69lTq3aH08Ut4sGUdSzstpLDLmLZVgoWu5DLZoOTvNRM=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:fe0f:0:b0:de4:7be7:1c2d with SMTP id
 3f1490d57ef6-dee4f31fb93mr2560099276.11.1715614794264; Mon, 13 May 2024
 08:39:54 -0700 (PDT)
Date: Mon, 13 May 2024 08:39:52 -0700
In-Reply-To: <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
Mime-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <ZeudRmZz7M6fWPVM@google.com> <ZexEkGkNe_7UY7w6@kernel.org>
 <58f39f23-0314-4e34-a8c7-30c3a1ae4777@amazon.co.uk>
Message-ID: <ZkI0SCMARCB9bAfc@google.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
From: Sean Christopherson <seanjc@google.com>
To: Patrick Roy <roypat@amazon.co.uk>
Cc: Mike Rapoport <rppt@kernel.org>, James Gowans <jgowans@amazon.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 Derek Manwaring <derekmn@amazon.com>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 David Woodhouse <dwmw@amazon.co.uk>, 
 Nikita Kalyazin <kalyazin@amazon.co.uk>,
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3SjRCZgYKCvMnZVieXbjjbgZ.XjhlZhp-YZqZgijibip.jmb@flex--seanjc.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
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

On Mon, May 13, 2024, Patrick Roy wrote:

> For non-CoCo VMs, where memory is not encrypted, and the threat model ass=
umes a
> trusted host userspace, we would like to avoid changing the VM model so
> completely. If we adopt CoCo=E2=80=99s approaches where KVM / Userspace t=
ouches guest
> memory we would get all the complexity, yet none of the encryption.
> Particularly the complexity on the MMIO path seems nasty, but x86 does no=
t

Uber nit, modern AMD CPUs do provide the byte stream, though there is at le=
ast
one related erratum.  Intel CPUs don't provide the byte stream or pre-decod=
e in
any way.

> pre-decode instructions on MMIO exits (which are just EPT_VIOLATIONs) lik=
e it
> does for PIO exits, so I also don=E2=80=99t really see a way around it in=
 the
> guest_memfd model.

...

> Sean, you mentioned that you envision guest_memfd also supporting non-CoC=
o VMs.
> Do you have some thoughts about how to make the above cases work in the
> guest_memfd context?

Yes.  The hand-wavy plan is to allow selectively mmap()ing guest_memfd().  =
There
is a long thread[*] discussing how exactly we want to do that.  The TL;DR i=
s that
the basic functionality is also straightforward; the bulk of the discussion=
 is
around gup(), reclaim, page migration, etc.

[*] https://lore.kernel.org/all/ZdfoR3nCEP3HTtm1@casper.infradead.org

