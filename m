Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3B1C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 14:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYRCl-0007jJ-86; Thu, 16 Jan 2025 09:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYRCj-0007iZ-4W
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:50:41 -0500
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tYRCh-0006ML-4C
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 09:50:40 -0500
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e399e904940so1584251276.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 06:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737039037; x=1737643837; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=24aiD7MW16LT+9B2StEz1I26wtggWUSaUUYnVOHg+e0=;
 b=JtyZHEEf00NF0yPpaNe14nviG48E2g7dssOIAaSzm0PzNN+4XDgzlqQ/GY1WvoCQkS
 eEiLJ2Ng2ldK/51cziVRuQ/qrrI6YLHyE0Elw73LRz6M/7Fq8e8H5LMv56GY2QTWgxgp
 vf01lVLtv5RIXfRXiwCpdN17Y6IuIE+SSiJw8SKPIle34KKt5gscyzU419AVqQE3f8HS
 P/+T1UNmjq+lHpxwYsCbm2Ps7Untatk5hLWYuV6WBKf+cWqrSs0uecg12CCMyMU4McC4
 uV0gsrHmP7ouSM3Oqv9q7XTcHhDkDYVJvRl1wUBnc5TdbrPBPpfNEO9wRwyzswGMDg0g
 8bXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737039037; x=1737643837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=24aiD7MW16LT+9B2StEz1I26wtggWUSaUUYnVOHg+e0=;
 b=urvz2xk7s2hTildZSXBEF6QlWEc8f5G/XPlpjRMk/01v9Op/pTwGIbTP4L990VS5wx
 yIGxSLMMKitjBRvwLMflxFribWT+oFPqTTNa8Q1I7745ad/zG6/qXw/drdoQs+Y8mp4a
 qicpQuk4BDUw3A/csMEKJoZD9IKpqVk4NcDz4BonfcAdUOP/AX0iVqCyooEgg5j/yQ5i
 bMffG1IMvZlit3fpcxYagFTcOuwyaxK856cKZj085CYE11eZ1LB3bLKAmhZqo28MheQU
 XLQMAMJgDSUzByKAtMFZBu4aNp7MvyGClJMzpUCiBC6yr6dhcjocGt6WUHwcTNh1JA4B
 oIDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkEhCcy+5GwKc+RgdanVk8To0h27JyGCOLOgPJ5coTVet6TczCyDcM2ygECaEXosUAWq5T40pLtL4Y@nongnu.org
X-Gm-Message-State: AOJu0YyZqEEPFR+cbqJsLxrado1Ke9eWgNmMzHje58tw+yrvtU940Bnh
 oHg/BP6RK21En0VaHQ18/8dRjSruG+k5HpChyDgT2gi6qM4xK/As0imghaGHkgda0Se0SbWC1JG
 NJRRUgqI0BA1E5K2y93Q9WIY7hNW8n2MhlmovAw==
X-Gm-Gg: ASbGnct1nw455265LAPA2mJ2stFbfb3Q0+qFXz9R6OJOEacbqQ8YKk8hVYO2XeUefoj
 0q4C0cCLF3dWGT5H/HexoyhyD5sSHMNHTAzYYI0A=
X-Google-Smtp-Source: AGHT+IHa47v8mo174sTi5oR1WVd/JxaV50sdpX1EHZyrk9h10U4rEd3XtWXSfSv5ImQyjZZoQvKerNEHsUk6iWlLasE=
X-Received: by 2002:a05:690c:6189:b0:6ef:7d51:ebb3 with SMTP id
 00721157ae682-6f5312a2f2cmr308517557b3.34.1737039037503; Thu, 16 Jan 2025
 06:50:37 -0800 (PST)
MIME-Version: 1.0
References: <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n> <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n> <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
 <CAFEAcA_mpWZO8V9cE74bKzveEEZDXkqE+XbOFFdhmKUKO3dmSw@mail.gmail.com>
 <Z4a3GxEbz1jjCDc5@x1n>
In-Reply-To: <Z4a3GxEbz1jjCDc5@x1n>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jan 2025 14:50:26 +0000
X-Gm-Features: AbW1kvakyDiZHM1MixFJGY2sNFIPZKMaf6rUwp4k4PVTBI4VheaRO9Gq6N4gfrE
Message-ID: <CAFEAcA87oYqMj1t+yriXHLuTg3G-=eRwOvt4-n4uJmeNujTBxQ@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
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

On Tue, 14 Jan 2025 at 19:12, Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Jan 14, 2025 at 05:42:57PM +0000, Peter Maydell wrote:
> > There's at least one test in the arm qtests that will hit this.
> > I suspect that you'll find that most architectures except x86
> > (where we don't have models of complex SoCs and the few
> > machines we do have tend to be old code that is less QOMified)
> > will hit similar issues. I think there's a general issue here,
> > this isn't just "some particular ppc device is wrongly coded".
>
> I see.  Do you know how many of them would be important memory leaks that
> we should fix immediately?

None of these are important memory leaks, because the device is
almost always present for the lifetime of the simulation. The
only case you'd actually get a visible leak would be if you
could hot-unplug the device, and even then you'd have to
deliberately sit there doing hot-plug-then-unplug cycles to
leak an interesting amount of memory.

The main reason to want to fix them is that it lets us run
"make check" under the sanitizer and catch other, more
interesting leaks.

> I mean, we have known memory leaks in QEMU in many places I assume.  I am
> curious how important this problem is, and whether such would justify a
> memory API change that is not reaching a quorum state (and, imho, add
> complexity to memory core and of course that spreads to x86 too even if it
> was not affected) to be merged.  Or perhaps we can fix the important ones
> first from the device model directly instead.

The problem is generic, and the problem is that we have not actually
nailed down how this is supposed to work, i.e:
 * what are the reference counts counting?
 * if a device has this kind of memory region inside another,
   how is it supposed to be coded so as to not leak memory?

If we can figure out how the lifecycle and memory management
is supposed to work, then yes, we can fix the relevant device
models so that they follow whatever the rules are. But it seems
to me that at the moment we have not got a consensus on how
this is supposed to work. Until we have that, there's no way to
fix this at the device model level, because we don't know what
changes we need to make.

thanks
-- PMM

