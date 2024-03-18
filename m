Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2541CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDik-0004vw-J8; Mon, 18 Mar 2024 10:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackmanb@google.com>)
 id 1rmDiI-0004o1-FX
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:11:45 -0400
Received: from mail-qt1-x829.google.com ([2607:f8b0:4864:20::829])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackmanb@google.com>)
 id 1rmDiF-0006x4-L4
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:11:42 -0400
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-42ee0c326e8so419521cf.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 07:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1710771097; x=1711375897; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rU3zFykgVuweueIsoxzQMtKYDDN5Bjw0bqJ5bY+qA6E=;
 b=2VQxD3qHFIJQkowAhJC1QwpdtzBbzkRMbWmfT+Llpxq1RCsgqc/gdkbNEY5juLyqob
 V2gxXJ1ReHKk7wFQuPoxf+UxEVd9UzCgYQbC2t7bqc8a90FFoh+QY5SgFkR3JcTihVJj
 Y24qmxe43/KLOOwL1Be96qCwMe3454mZtaZeV/+R5+jjMyYB98gMCjHC45QTEj5Hvjay
 8dbhcHl6lqbWgyZRmLsTND2C/tbmJ5GDRFlPwHfHL5Z9rEBA60aNn4a44KXtlhbtsGrV
 W82YQ3F35gyYT48kwDyDn0ncHUgFlwyM2kIbS5dmgL3817VD2kWiW0Jyb1BXfoqKdpNN
 imxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710771097; x=1711375897;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rU3zFykgVuweueIsoxzQMtKYDDN5Bjw0bqJ5bY+qA6E=;
 b=QknSoIf8OxnaZGIvUQum83FpvwwSnC6y/QE9FZvOFKqVuIfL4RggvG0kiPvNJcIr4D
 VLSINdLbpNcF0KDF8VJPmRPQPy8laJAQ8FMeuIlPuNm3u4irqR6lhzpoCtUaZQbI9LgD
 1QhWRpjgL5iaI3zzpJSmI0kUKE9op1jLJrx9Hi88lfYO/D5sBn6usqrS0tpAaB75vhs6
 90zoAqa/uOjCMFTJAhSo8qpi4ZIdDnIp4DqgkmLLRjUB+2yEwWGGmEGv1/lkFUp4ZnzY
 /gP8y/zTTHvI08niP/pXz67NhnrYtomFK0LdYJ/PrKCEVecO6tYuvgj6KgN/aVoqnxsE
 TthA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1PcarUgxQcAkq209/ziDzgOY097f4GZL6hGT3BdMUhsmN9yMmy5QE1d6R5IMmY5pZ+Vg/2Prc+4CjEdz+KADoxhOf0VM=
X-Gm-Message-State: AOJu0YxOSQ15T2Z/FGNFjdtsaguZmjWrbP1+TtmyzeF17XGRCQF8rCua
 04K2e0jdIriFpK+vwGPceUJOFjPOKv5OX0TlFMOvREr+BnAhs+RdxToD+qzJjvatc6FCTnwQOnB
 LR+UVuEocLfyYdaoT0YCff9zHlgGOwi4X0wj7
X-Google-Smtp-Source: AGHT+IEP1eDBtV9wwG22o9FLtfUkcC57ZS5hhvLcQHaosamz9mFsDACdCEemZgZ1KW9i0+WwUAZxZDxm/IPXpyAyIxs=
X-Received: by 2002:ac8:57cd:0:b0:430:9ee1:a8 with SMTP id
 w13-20020ac857cd000000b004309ee100a8mr330194qta.3.1710771097539; 
 Mon, 18 Mar 2024 07:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <cc1bb8e9bc3e1ab637700a4d3defeec95b55060a.camel@amazon.com>
 <CA+i-1C34VT5oFQL7en1n+MdRrO7AXaAMdNVvjFPxOaTDGXu9Dw@mail.gmail.com>
 <CALzav=fO2hpaErSRHGCJCKTrJKD7b9F5oEg7Ljhb0u1gB=VKwg@mail.gmail.com>
 <8e3c2b45-356d-4ca9-bebc-012505235142@amazon.com>
In-Reply-To: <8e3c2b45-356d-4ca9-bebc-012505235142@amazon.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 18 Mar 2024 15:11:25 +0100
Message-ID: <CA+i-1C3DtXzzkatepVvn-E45Gyxb3YmYd-irxfjDL5bL5MhWVA@mail.gmail.com>
Subject: Re: Unmapping KVM Guest Memory from Host Kernel
To: "Manwaring, Derek" <derekmn@amazon.com>
Cc: David Matlack <dmatlack@google.com>, "Gowans, James" <jgowans@amazon.com>, 
 "seanjc@google.com" <seanjc@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
 "Roy, Patrick" <roypat@amazon.co.uk>, 
 "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
 "rppt@kernel.org" <rppt@kernel.org>, 
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Woodhouse,
 David" <dwmw@amazon.co.uk>, "Kalyazin, Nikita" <kalyazin@amazon.co.uk>,
 "lstoakes@gmail.com" <lstoakes@gmail.com>, 
 "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "vbabka@suse.cz" <vbabka@suse.cz>, 
 "mst@redhat.com" <mst@redhat.com>, "somlo@cmu.edu" <somlo@cmu.edu>, "Graf (AWS),
 Alexander" <graf@amazon.de>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 kvmarm@lists.linux.dev, tabba@google.com, 
 qperret@google.com, jason.cj.chen@intel.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::829;
 envelope-from=jackmanb@google.com; helo=mail-qt1-x829.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Fri, 8 Mar 2024 at 18:36, David Matlack <dmatlack@google.com> wrote:
> I'm not sure if ASI provides a solution to the problem James is trying
> to solve. ASI creates a separate "restricted" address spaces where, yes,
> guest memory can be not mapped. But any access to guest memory is
>  still allowed. An access will trigger a page fault, the kernel will
> switch to the "full" kernel address space (flushing hardware buffers
> along the way to prevent speculation), and then proceed. i.e. ASI
> doesn't not prevent accessing guest memory through the
> direct map, it just prevents speculation of guest memory through the
> direct map.

Yes, there's also a sense in which ASI is a "smaller hammer" in that
it _only_ protects against hardware-bug exploits.

>  it just prevents speculation of guest memory through the
> direct map.

(Although, this is not _all_ it does, because when returning to the
restricted address space, i.e. right before VM Enter, we have an
opportunity to flush _data buffers_ too. So ASI also mitigates
Meltdown-style attacks, e.g. L1TF, where the speculation-related stuff
all happens on the attacker side)

On Sat, 9 Mar 2024 at 03:46, Manwaring, Derek <derekmn@amazon.com> wrote:
> Brendan,
> I will look into the general ASI approach, thank you. Did you consider
> memfd_secret or a guest_memfd-based approach for Userspace-ASI?

I might be misunderstanding you here: I guess you mean using
memfd_secret as a way for userspace to communicate about which parts
of userspace memory are "secret"?

If I didn't misunderstand: we have not looked into this so far because
we actually just consider _all_ userspace/guest memory to be "secret"
from the perspective of other processes/guests.

> Based on
> Sean's earlier reply to James it sounds like the vision of guest_memfd
> aligns with ASI's goals.

But yes, the more general point seems to make sense, I think I need to
research this topic some more, thanks!

