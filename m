Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC0EC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 20:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZzGL-00047x-ES; Tue, 13 Feb 2024 15:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rZzGH-00047R-2B; Tue, 13 Feb 2024 15:20:13 -0500
Received: from mail-oo1-xc35.google.com ([2607:f8b0:4864:20::c35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1rZzGF-0005Vh-84; Tue, 13 Feb 2024 15:20:12 -0500
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-59d84559ffdso273879eaf.0; 
 Tue, 13 Feb 2024 12:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707855607; x=1708460407; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DmZZ7Ga7FpA3A3bT/QFQlV8L52+rSQb99NGQB5QTtTc=;
 b=bsL73EUPSs4Equ/rJFPQEYy8gl2K3z7Xlm1b4QKmhqH3TqMu8n9Gm7einrpHM3TMgh
 nokr0x21OZk76k0vb4Etvurx1Y0FBiP1OisF0lSK3MKIgZ0Y6EQ6mFeemAqFMyeYRmF8
 gt+AdtT5QZ3T3yGq9K23RfTSAx4ipj+QOsojNUTXHaZQRBfuTxoKBdyKWC8rGUBEqGXk
 NNnJfp8GSdxBT3YVtIaKjTjTjUeDoPgMQ8mELAZOyglFKqruekKi5We+dut7tndH9aIl
 OzxGDIFfd/mbZJbndQqES8PqrZNNjGIJ21LTFFhmgjeSs7v9tOa6HnvcWA+LZJQ5eche
 +rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707855607; x=1708460407;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DmZZ7Ga7FpA3A3bT/QFQlV8L52+rSQb99NGQB5QTtTc=;
 b=ncC5hITikVgXzC6wPRjqzA32GZLXUhA21s+wOjUsoUfcTHu3MzcgnUL+G6kwCJ//oh
 wsCFGTS6zrm6BkEnp91PSeHOKNscdpJeFT8ksNOU41yhdmaC/8jXU6TtjuLd1i35jkXA
 jRRsvzsTeAsUH3ZUvxglOidFKXLUlv6sUKnwDun14/5PfVSxfW39axurLsMOneBLM74k
 vJbEmwvukaN7z+G/O/6QsHeMv1eQJm19MGulyp14pz9zksjg0pAz45VOx4BRd9gfdJdH
 UGdTIq6mmBpZNGDfdJpSGfNdVjb1dwIezCpQSBCn+9r2XCM7pUk1CH0rYo8VHa/YaUpd
 gVHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgW7cQ2gxNiJAnm+vcD7RvSyYTzw9r0rNXOrT9jJovToQbsdJLIaMRvl0tNhk8p1FL3gIsryPr3WQB0kXCJ4UBtUKm7MoW6cDT4QxWTMOA2ip3nxGqgIO5vwYt/A==
X-Gm-Message-State: AOJu0YxPlLjLXIVMM7xmV+MnWqWA2GazhCB+XkJcAAHUVs7ch/6ONXXl
 nryF7KyyC57REzx4hjjHaw4OEVfVTPxHra7+j7nZ8j3D25LUSe5xZKOnudSzfjfr582bD37CiZM
 IpQ3Uns02SarN5o+TNoj0gDUNQac=
X-Google-Smtp-Source: AGHT+IFH4/8pj+3z6F+yUsbBf4RKv0Q71bJHeMbXYlGJvjHTkKXwGLmZT/leNILw0nZOSbJEVMho+o7wPis1DPB8Al4=
X-Received: by 2002:a05:6820:5c:b0:59c:b57a:5746 with SMTP id
 v28-20020a056820005c00b0059cb57a5746mr939966oob.4.1707855607674; Tue, 13 Feb
 2024 12:20:07 -0800 (PST)
MIME-Version: 1.0
References: <20240116190042.1363717-1-stefanha@redhat.com>
 <20240116190042.1363717-4-stefanha@redhat.com>
 <dd0dd672-78d7-4e9b-b501-020cea439fea@tls.msk.ru>
 <3185d4fa-86bf-490e-8d79-5278da1ad9a4@tls.msk.ru>
In-Reply-To: <3185d4fa-86bf-490e-8d79-5278da1ad9a4@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 13 Feb 2024 15:19:55 -0500
Message-ID: <CAJSP0QUXW6jB2zUZCH6fj2gs7i-naERb-Sv7eez6Nw+vvHZMtA@mail.gmail.com>
Subject: Re: [PATCH 3/3] monitor: only run coroutine commands in
 qemu_aio_context
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 qemu-block@nongnu.org, 
 Fiona Ebner <f.ebner@proxmox.com>, Hanna Reitz <hreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c35;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc35.google.com
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

On Sat, 3 Feb 2024 at 06:30, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 03.02.2024 12:01, Michael Tokarev wrote:
> ...
> > This change broke something in 7.2. I'm still debugging it, will
> > come with a follow-up once some more details are found, I'll also
> > check current master with and without this commit.
> >
> > The prob happens with multiple suspend-resume cycles, - with this
> > change applied, guest does not work as expected after *second*
> > suspend-resume.
>
> So, it turned out the prob here exists on master too, and manifests
> itself the same way on 7.2.9 or on 8.2.1, - in all cases where we
> have this change applied it works (or breaks) equally.
>
> A (simple) reproducer so far is a hibernate test, - it fails *only*
> after suspend-to-ram, but works fine after just hibernate.
>
> I used just an initrd (with a drive image used for swap -
> for hibernation space).
>
>   qemu-img create s.img 256M
>   mkswap s.img
>   qemu-system-x86_64 \
>    -serial stdio -vga none -display none -parallel none -net none \
>    -machine q35 \
>    -drive file=s.img,if=ide,format=raw \
>    -m 256 \
>    -monitor unix:ttyS0,server,nowait \
>    -kernel /boot/vmlinuz-6.1.0-15-amd64 \
>    -initrd /boot/initrd.img-6.1.0-15-amd64 \
>    -append "shell=/bin/sh console=ttyS0 root=none"
>
>   There, in the guest (it has busybox only here):
>   # swapon /dev/sda
>   # echo mem > /sys/power/state
>   (system_wakeup on the monitor)
>   # echo disk > /sys/power/state
>
> The system will hibernate but *not* turn off power, qemu
> will continue running, while all console messages are the
> same as when it works fine.  qemu process is spinning up
> with 100% cpu usage at this stage.
>
> Without the intermediate suspend-to-ram or without the
> commit in question, qemu process will exit normally at
> this stage.
>
> This is a somewhat patalogical test case, but I see it as an
> indicator of something else being wrong, like we aren't saving
> or restoring some state now which we should do.
>
> The tight loop also suggests we're not having success in there.

I'm unable to reproduce this. QEMU v8.2.0, v8.1.0, and even v7.2.0 all
spin with 100% CPU usage on my machine. It looks to me like this
behavior is not a regression caused by this commit.

Do v7.2.0, v8.1.0, and v8.2.0 terminate QEMU on your machine?

Stefan

