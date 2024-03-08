Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58DCC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 22:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rij0H-0003sA-Gi; Fri, 08 Mar 2024 17:47:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ipXrZQYKCpkL73GC59HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--seanjc.bounces.google.com>)
 id 1rij0F-0003ri-Mp
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 17:47:47 -0500
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ipXrZQYKCpkL73GC59HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--seanjc.bounces.google.com>)
 id 1rij07-0004Jz-QU
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 17:47:47 -0500
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-60a08eb0956so13483677b3.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 14:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1709938058; x=1710542858; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=SKmvQ5PcWXT/71cgvqMhhqx5Wzq7n7WsxYjGNYsq8ec=;
 b=ifS9j9AfY4WGCtWIhodfN20xzvmGM+RHTDY+lD6LRK+SXcAVdwVEdGVtxWagb1P95b
 brsq5dQNueEUD5HkDYvGPSTemL7PEWIUIkeOCX0QEcdK+BRYzujolOvmxTQZ8RU6cMht
 P9l2WbhV1FfhifN0E+0bn+gW2v1PCkZi5/Bgmwwme5jm0/67LKlVdz9C2rN6C4JeYjr0
 HP6VcYvS69xNN0boyL8HyoiIIdgSHZwmZGmh305VtXRS42JBj+wqbqfJhi6ibL7BsodS
 bBU/qQZs87id9hvYkmSAs3tCgJN1BFDA+P6YMape/cyo1IyMtjbUhE8i8Y0fCf57MB1H
 GSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709938058; x=1710542858;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SKmvQ5PcWXT/71cgvqMhhqx5Wzq7n7WsxYjGNYsq8ec=;
 b=rvhANnKlNAarv6HwWXLSVF6+Kfrq+fCd36mv4+kmbbMUaxeEOwLZxxN6LAhoSEU+rA
 cELoeDgoeBbDSBCBaW8ZaJHt4VymPyaps8DhDgunir96JQg0IicnqjJuTbSvmIvNZzKc
 qOkZKixaa31IX5XiyCjQYUo7KUHKLbnJ0f/xq2XXbDVBYu9r5sG8OFSQvChzJP6UxUSe
 Il++5WcsMS6dN7xswfMxTfXvnpdCECT8wwB5rzGaLYTe0ZybNlZ7+njdrpZYZtnPJ7Qr
 67m2/0fCQTJmkWrccxSUqufNJaEgGvoz/NHQbCN+Pr3yvpbs3segrcXCAGNOZqJxHuPW
 IIfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhCP4m+AA2qVF5Zc67t5q227roIOaYquK9TtdnmWxThOW7fw2yAhMzo+wFDKWATqMKtJAw5SiQ3TsqYwKFozl7i0di/SA=
X-Gm-Message-State: AOJu0YzYBnhVxfJwDCEyjfa8Jk3P80XQ73yPRBdushx0RUPqtn+Asvga
 sO1uJvLVqavUrx8bwWjZ2bNIXmeM5RExco1JNTijy0VnB5pcKQsvj/cF4fUL7VjigxGboDFYVLN
 v8Q==
X-Google-Smtp-Source: AGHT+IFqRwVOtamqH/NKTy0aNd2o9IZB1qaPOD/2a3NruNRdmlhFTn+MhqozJICSJlnbYsW/c2VqgNYGi+8=
X-Received: from zagreus.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:5201:0:b0:608:ecf3:ef8 with SMTP id
 g1-20020a815201000000b00608ecf30ef8mr124505ywb.0.1709938058024; Fri, 08 Mar
 2024 14:47:38 -0800 (PST)
Date: Fri, 8 Mar 2024 14:47:36 -0800
In-Reply-To: <aa50a5ea6dbcd5f3f1df39dcf2fc4f5ee881ec8e.camel@infradead.org>
Mime-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
 <CALzav=fO2hpaErSRHGCJCKTrJKD7b9F5oEg7Ljhb0u1gB=VKwg@mail.gmail.com>
 <aa50a5ea6dbcd5f3f1df39dcf2fc4f5ee881ec8e.camel@infradead.org>
Message-ID: <ZeuVV3Jo31lcL41H@google.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Matlack <dmatlack@google.com>, Brendan Jackman <jackmanb@google.com>,
 James Gowans <jgowans@amazon.com>, 
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 Patrick Roy <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 Derek Manwaring <derekmn@amazon.com>, "rppt@kernel.org" <rppt@kernel.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, 
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
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1149;
 envelope-from=3ipXrZQYKCpkL73GC59HH9E7.5HFJ7FN-67O7EGHG9GN.HK9@flex--seanjc.bounces.google.com;
 helo=mail-yw1-x1149.google.com
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

On Fri, Mar 08, 2024, David Woodhouse wrote:
> On Fri, 2024-03-08 at 09:35 -0800, David Matlack wrote:
> > I think what James is looking for (and what we are also interested
> > in), is _eliminating_ the ability to access guest memory from the
> > direct map entirely. And in general, eliminate the ability to access
> > guest memory in as many ways as possible.
> 
> Well, pKVM does that... 

Out-of-tree :-)

I'm not just being snarky; when pKVM lands this functionality upstream, I fully
expect zapping direct map entries to be generic guest_memfd functionality that
would be opt-in, either by the in-kernel technology, e.g. pKVM, or by userspace,
or by some combination of the two, e.g. I can see making it optional to nuke the
direct map when using guest_memfd for TDX guests so that rogue accesses from the
host generate synchronous #PFs instead of latent #MCs.

