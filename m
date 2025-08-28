Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA37CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 10:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urZcB-0004Wh-9R; Thu, 28 Aug 2025 06:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urZc4-0004Ua-C5
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:12:13 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urZc1-0004IY-Sz
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 06:12:12 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e96f401c478so507656276.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756375927; x=1756980727; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0tLPLtTKw4gLPTg4FLtEyN364FrJLmV5HJ3/RjjnJz4=;
 b=bGZ1MQPmga/QJKfHDHq1QjZNbMdIsEVP5pCqD5kLJ26B+bSut38TgPrNfutUmkYgw2
 otuLydaXEu16zB2EEnf+A7SzocnqxZlMAdQAhGn/CPDmqMstjFy58f/4d6NVOwzVKQjc
 bpaMsOT5NYZPVioqKecdOUqzboNe0zfFJ7Oxw9bTVqLk+HfcWQPl3+MCNuR59f8iEwIH
 NMevHPJQEvlduoEBG5RSK64YhnT7ytw2U+pfFaLFvHKQSOIBBfGn9dfEdl84TtTdMKqq
 md374YodrjJvRNfi8Pp5WHn2bqDdjUPNPr4VFUMyPk7EE8P1nNbwdP7oXWr1oRN8tTnH
 RjtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756375927; x=1756980727;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0tLPLtTKw4gLPTg4FLtEyN364FrJLmV5HJ3/RjjnJz4=;
 b=GnvhiqW0VxP+dx+5OqWfYLBZ5+JhV9kwqN0ueSXXV3AoZmbAvqw2NfWpZM7WyTsZAe
 orEy8WNh2wbHFu7P6F7KTQpkMFfSQqUtvnj8dRypWBe0u5XXOf0k7v2Zd16nRWnlVdHW
 QOIJKv/FZwzeIGzTWGQ3Xwr+pUvfjHJ+vKmaemhgUhCLmSJPAehWzq1RDxtp+ieArKoy
 BWGh/zRligXN2UH8GQYzRoz4PzyZwxs9C1ns5dNAke8tIdbjYxVNTSL3FqfCriwg9bfR
 4J9DS0P2pZhtPR02Ncg5B483ukhV/qVc1b6Onkv/NugtwzowNuLkRZ67GQ0wDgl80sCd
 HARA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1KfyLckYd7LyXNDNoIn3JGJDBz4HoucK7i13boG5tZub1e4U49GUrDK96CESbRcs2yYDA3rBEcmPr@nongnu.org
X-Gm-Message-State: AOJu0YyIqFWEpHt4ofDakxObNZvU4c5bJbYJVycoB7Xar58bTMyMTeRF
 uCGUcbaabrmsD7NRCEy/dsehLRQjVFM7mmhBZSfVTDFTrSHKjg//LIoplQmboNece6c0xGdwN7I
 i7/ZakoWQdI9bSh3/OItUH5HUlAaAautcLcHQp97hrg==
X-Gm-Gg: ASbGncuTcaPbXzbR+gUtLD83WHTZK8L/VgkG28wGjIXU74IJmWQQOY4n7LbT82QNBRx
 XtHp9cMu+HBcEMrQzpWVVvFdCIpTc/9adwsyOcHgKry9DaPao+qWEHeHUhsQ/aSWsk2ZuVsRhQX
 hdBTJEfSM2S/OaIp0f+k7RoD6sg1jUbIQe8PaMbHYT7d77GMQLAvBaDGArliWO2mOfYuBGLDf0o
 6cwf0r/tEDMufK7qGQ=
X-Google-Smtp-Source: AGHT+IHzwad4jEP/ymZFDxhe+Y8s4Y56asUCrB9A57moRe/bqzY6Rpm1bcgYbN+l4JtlbZgIAQ0RiYSuwk5BDxd+Bvo=
X-Received: by 2002:a05:690c:6082:b0:721:10a3:6584 with SMTP id
 00721157ae682-72110a36c63mr164529087b3.11.1756375926711; Thu, 28 Aug 2025
 03:12:06 -0700 (PDT)
MIME-Version: 1.0
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n> <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n> <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
 <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
 <d9acf231-829e-4a9c-7429-282fcc2ae756@eik.bme.hu>
 <2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com>
In-Reply-To: <2fe8b128-dda1-40af-89ac-e86ba53138f5@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 11:11:54 +0100
X-Gm-Features: Ac12FXyZh29LlEVt9V6PbmtXlaII1HVaram_3eJlpmW7Mnz64-dP-ALcJn18rbo
Message-ID: <CAFEAcA8A97ocOfv72KeSEgFkchmAOfc=GiX8QmvRui5=DDF=qQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Xu <peterx@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 17 Jan 2025 at 06:19, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> Let me explain my and Peter Xu's solutions by listing object references.
> It will abstract the details away and allow applying the analogy of
> other reference counting systems like Objective-C.
>
> "Real" reference relationship
> -----------------------------
>
> First, I'll introduce one basic rule:
>
> Rule 1. If A needs B, let A refer to B.
>
> Now, There is an owner and a memory region. The owner needs the memory
> region to function. The memory region needs the owner to provide to
> allocate itself and e.g., to provide MemoryRegionOps for
> memory_region_init_io(). So we will make a bi-directional reference
> between the owner and the memory region.
>
> O (Owner) -> MR (Memory Region)
> MR -> O
>
> Now, let's think the case where there is a container and subregion, and
> they are owned by different objects. The container needs the subregion
> to satisfy its accesses, and the subregion needs the container for
> memory_region_find(). So this relationship is also bi-directional.
>
> CO (Container's Owner) -> C (Container)
> C -> CO
> SO (Subregions' Owner) -> S (Subregion)
> S -> SO
> C -> S
> S -> C
>
> Let's think someone took a reference to the container e.g., for DMA.
> This mean we add the following reference:
>
> DMA Controller -> Container
>
> This will ensure all of Container, Container's Owner, Subregion,
> Subregion's Owner are alive during the DMA.
>
> "Weak" references
> -----------------
>
> Next, I'll impose the restriction that prevents circular references. To
> avoid circular references, we'll stop counting references for one
> direction. In other words, we'll make some references "weak". Weak
> references are prone to be dangling (in Objective-C or other platforms,
> such references will be usually replaced with nil-like values).

I'm not sure this is really how we think about the lifetimes
of these objects, though. In particular, we definitely don't
ever expect, for instance, the link from a memory region to
its owner to be dangling.

I think what we actually have is:
 * the thing which really has a reference count is the
   device object
 * this device owns various things (irqs, child objects,
   memory regions, etc)
 * we expect that when we destroy the device that all these
   other things it owns also should be destroyed
 * some parts of the system have free-floating memory regions
   which don't have an owner
 * parts of the code have to deal with both the "MR belonging
   to a device" and the "MR not belonging to a device" case

> Comparison between the two patches
> ----------------------------------
>
> I'll compare them by showing pros and cons of Peter Xu's patch.
>
> Pro:
> a. Will not add yet another direct reference to memory regions where
> currently there can be only one reference from the owner to each memory
> region.
>
> Cons:
> b. It requires two new rules.
> c. C will see its reference to S to disappear at random timing due to a
> weak reference.

C should never see a reference to S disappear at a "random time".
Either (a) we are going to clean up all these objects because they
all belong to the same device and they get destroyed at the same time,
or (b) something should be cleanly removing S from C.

-- PMM

