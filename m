Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 585D3EA853B
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:58:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzINR-0006KQ-Oe; Sun, 08 Mar 2026 13:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vzINN-0006KA-Ef
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:57:14 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vzINI-00087k-GC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:57:11 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5353229f8f.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772992624; x=1773597424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cj9fTkWpVeTFiUE6mexF8q28ZQDdvpfaGvjImFVoTP8=;
 b=VQzGVrAAP9LczaRTBLYW3Bi4U42fV/+17cJ/QtqMcJrlg3rn801L3e7tyM4giRfSEq
 vWVZF5aSxMMWFStPGNKxt2MtrcjTII6w1l4LrMPHKLBOFa26Ihuawcdnztg1wRK5JAHR
 rB5l6Wl8hVOZrtGou5EG9Ecsbvp4/j+4viQDfJrMikj77UNjuvyg+e4jhIG/UTUyQZ8h
 XbGIfewOFprR41a9nu11uMkVQ/ITktYhyFNrOhkWUIDXxkyJxWYuAf7rnT7MNNlA2eY8
 /JNIB3Mtz9TV9RPGZJkwZFACL7uRymN5XjO7CaHl4KscRuwlN1rLZTswIYwdyhmTUWm9
 H4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772992624; x=1773597424;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cj9fTkWpVeTFiUE6mexF8q28ZQDdvpfaGvjImFVoTP8=;
 b=pvdmRLAqgWQofY33h/TxDoQmVWddld8h2ukcnJPpi8OoNM8sRSs4EBynA9hUoIXc8q
 pUf5qMMO3VJS97J678fa9xZsKN4k4BS3Z1rFTGrAGPGHgzawmM0se/oEOBAa4A4XlG+S
 4iC44Sua4HzH/OSAIDkrNkmRqCWXAThIu8jSv+HBXsmUJmYGxSYkcYjvbWFw6e3iXHp4
 xHdlqhVlAd5JXn2ks1xo4j721YTohQ9YoRAiVnxg+hE+0hj2x4wpzpspAXkrcE78cRP3
 BC8CyCuFp1L/1iS0hb71PjdKVAG7PPnBWJoLyDZmAYDp8upl6rB4uuawVvh1M67F2ON1
 C4sg==
X-Gm-Message-State: AOJu0YxQ4UbbqKzUg6mqJ/oXfI8ZYWU0iFdUE03WY8TP0+kHKIzfdMCY
 hfu5d2J/uj2neWF60aAu8hv3KAsZ9d+Sc0lO+ysnr7X6j2WCJzpUjc14y65frw==
X-Gm-Gg: ATEYQzzZ+kEKDUU0Zs9WZZQcTQ5QyFCp15roWlxS7STTF624ntBe9zWLHNZDzOE1qwW
 +kNgZRho1g2QkzjmmiksFC6oYaRydI+NkeTPQCbpUqifTqRcwv8E2POVeRXba9BhnwzQcHSieaZ
 J8jeFa88K7fllwZz4RnXrCu8rJWPry/xoHrEEiy616VWdDrFGXwZsymz0Xg8fH2FejTCwXGQm6t
 qhrWBcHe+UYRdsFKH61/ACS9KGitPQuqE/hWmb2Iqlbm8c2eAkvt1rUBAFMXaFdA4LtVxZ2HLKK
 qxsEJSfJgUP+J/vuLprRWMQbXlwrUO3ebSkxHyFwYg/N4ZBPkg0owj4ywQJMq1e77WFIhiff4wm
 DdX7kx1dM3SwbU4esONf4pvckFHpH5ouRVACO9JKVKZvup3zSutx9fqBiakmqjyLZcLIJSX5qtL
 EOPgnbFzBXxAoWIQy/9OGfMGwLydK48LAnhyCRvhuqlPVMr6/6s53n2HF+hyeCl2m4DAKE/W/vs
 v1NikrtF+cxLHmy/pLpi7LrLhiKoa8+fdFtMw9gBX/dwg0=
X-Received: by 2002:a05:6000:2886:b0:439:b7c9:2edb with SMTP id
 ffacd0b85a97d-439da35c8e3mr15570250f8f.25.1772992624282; 
 Sun, 08 Mar 2026 10:57:04 -0700 (PDT)
Received: from ehlo.thunderbird.net
 (dynamic-2a02-3100-25c6-8f00-f009-a6c9-39e7-d8fe.310.pool.telefonica.de.
 [2a02:3100:25c6:8f00:f009:a6c9:39e7:d8fe])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8d95dsm21294958f8f.7.2026.03.08.10.57.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 10:57:03 -0700 (PDT)
Date: Sun, 08 Mar 2026 17:56:53 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
CC: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH=5D_hw/core=3A_Avoid_attaching_qde?=
 =?US-ASCII?Q?vs_to_/machine/unattached_if_they_have_a_bus?=
In-Reply-To: <CAFEAcA8wu0kvL0END0woXp-yTpv-Va708Uytc--ASJBiEi7Yvw@mail.gmail.com>
References: <20260217164049.543975-1-thuth@redhat.com>
 <874ind5da6.fsf@pond.sub.org> <aZ1zsoyKcD1ChK--@redhat.com>
 <CAFEAcA-30xkboF_mt2HD+9TG+j9W7k2FCuSHGSVk9H=gbXnx2A@mail.gmail.com>
 <ef1aeb7f-d79c-446f-be58-28245b84ccfa@nutanix.com>
 <3a72c0f3-ba85-1e98-3964-5f43efb80375@eik.bme.hu>
 <CAFEAcA8wu0kvL0END0woXp-yTpv-Va708Uytc--ASJBiEi7Yvw@mail.gmail.com>
Message-ID: <34449581-D616-4BE0-AD29-84939888211E@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x431.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



Am 26=2E Februar 2026 11:58:34 UTC schrieb Peter Maydell <peter=2Emaydell@=
linaro=2Eorg>:
>On Wed, 25 Feb 2026 at 01:05, BALATON Zoltan <balaton@eik=2Ebme=2Ehu> wro=
te:
>>
>> On Tue, 24 Feb 2026, Mark Cave-Ayland wrote:
>> > The questions I think we need to answer as a starting point:
>> >
>> >  1=2E Which API shall we converge on: qdev or QOM? Can we come up wit=
h a
>> >     code sample(s) showing what we want object/device initialisation =
to
>> >     look lie? Longer term can we unify the QOM and qdev trees?
>>
>> My first question is why do we have separate qom and qdev names and tre=
es?
>> The docs aren't very helpful=2E Qdev does not have a Glossary entry and=
 only
>> a brief summary at:
>> https://www=2Eqemu=2Eorg/docs/master/devel/qdev-api=2Ehtml
>> and some confusing info in an old doc here
>> https://habkost=2Enet/posts/2016/11/incomplete-list-of-qemu-apis=2Ehtml
>>
>> For a long time I did not even know there was info qom-tree command in
>> monitor but I was familiar with and used info qtree=2E I still don't kn=
ow
>> what the qom-tree is good for therefore I also don't care when creating
>> machines or devices as I never use it and don't know why I would want t=
o
>> use it=2E To me it looks like some internal thing of QEMU that I don't =
have
>> to be concerned with=2E All the useful info about devices are in info q=
tree=2E
>
>The qdev tree is the older of the two=2E It models the buses:
>devices can own buses, and devices are (mostly) on buses=2E The classic
>example is something like PCI: the PCI controller device owns a PCI
>bus, and various PCI network devices etc are children of that bus=2E
>Reset is (currently) done by traversing the this tree=2E
>The qdev tree represents a real thing in the hardware we're modelling=2E
>(The "sysbus" is an odd thing that has all the memory-mapped devices
>on it, which is kind of broken in that a memory-mapped subcomponent
>of a PCI device is still on the "sysbus"=2E There are also problems
>with devices that aren't on buses at all, notably the CPUs: they
>don't get reset automatically, for instance=2E)
>
>The QOM tree is newer, and was introduced when QOM was=2E It is a
>tree of ownership of objects: the machine owns all the devices it
>creates, including perhaps an SoC object; the SoC object owns all
>the devices that are its subparts (the UART, the I2C controller, etc),
>and so on=2E It provides a hierarchy that the qdev/qbus one cannot,
>because not all "this object owns this other object" relations
>are ones where the other object is on a bus owned by this one=2E
>Conversely, not all "device A is on a bus owned by device B"
>relations are "device B owns device A" ones -- consider an SoC
>with a PCI controller and a PCI device that's created via the
>command line: the PCI controller doesn't own that PCI device=2E
>In that "PCI device with a memory mapped subcomponent" example above,
>the memory-mapped subcomponent is a child of the PCI device in the
>QOM tree, so here QOM gets something right that the qbus tree doesn't=2E

Yeah, QOM, among other things, seems to be the infrastructure for intrusiv=
e, ref-countes smart pointers=2E Unlike Rust or C++, C doesn't have a conce=
pt of destructors which are invoked implicitly and recursively when an obje=
ct goes out of scope=2E So we need to maintain a tree that allows us to run=
 destructors like that -- the QOM tree=2E

Ideally, we'd destruct the whole tree when the QEMU process finishes=2E Ho=
wever, this is marked as todo since years: <https://gitlab=2Ecom/qemu-proje=
ct/qemu/-/blob/v10=2E2=2E1/system/runstate=2Ec#L1002> =2E So it seems that =
we're basically leaking the whole machine and don't clean up properly=2E

Attempting to fix this first reveals that the machine object's refcount is=
 2, because apparently an object_unref() is required after setting its pare=
nt=2E After having fixed that as well, one can witness QEMU crashing in var=
ious interesting ways when quitting=2E

Fixing the unwinding of the QOM tree may perhaps shed some light on what w=
e need and what we want=2E=2E=2E Clearly a rabbit hole=2E

Best regards,
Bernhard

>
>-- PMM
>

