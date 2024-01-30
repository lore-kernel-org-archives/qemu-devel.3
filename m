Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F12C46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 10:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUlNZ-0000Qb-0D; Tue, 30 Jan 2024 05:30:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlNW-0000QP-9Y
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:30:06 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rUlNI-0006lZ-6T
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 05:30:06 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55f0b2c79cdso2693014a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 02:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706610590; x=1707215390; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V3AACafdIR9mOFbk8iUl9aKL4lE+jvSmOg4nIbrA3sE=;
 b=MBhMShcj020w8LZZeWtlflHN3U9Fv6w0yjx4UimA2Xo8bDvNcFnU7tbdvD8/7MeJp8
 abcZT+WDrjCQDPycdnuTSFb7Pz9jx0/z0iquC6T37bf34wLHv6dn7z8irJeLZv0hYFBs
 QenquyxrjH5i+yPtbM1IReIyGcGWoA4utCUAJT7xDQOxad3ILP270AyagZUmC7WQJ/vs
 gHSSj9zzc9CHbbGpIXy4PVJZhLFogpf/HwIdBR3c9Sg9UxPCrUUJo6pw1T8vnCsFoyej
 KgMgLZz0IAlvjd1J4DcJdBZnfTgF39s8CsQqtVjCXVOmitu9LaMxN1QyL9FsNKSvbf8h
 uYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706610590; x=1707215390;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3AACafdIR9mOFbk8iUl9aKL4lE+jvSmOg4nIbrA3sE=;
 b=C1dIDpQZS4qGBapxQC30brx6rHOmWG/QLZz/8ztKfsdFlr8jVgXBQve6B7sT79AkTw
 TWfqXBWAweGzrNY1J4XURj7iyRxJLm6sykUDBneOpyYii53Ztoi/ttUprqj/8SWRF3Q6
 hVTecRRyzRc5DYGcKRVNZ4ZvCWA2wxeCMRcDhYFZ1Lupwgu9mKKmAx6VyVoOHm7xpFnM
 x4cWVlk3ekH6yZpC2LVq9MgwxPMHU7KB1oimJIhNGcmJEaKvUbWV9F4AZbHkAVNFfdp9
 P9I8hdhDD4gJ1KsJHt3rd+5hxnUJhocIOIHF4RwwqQwVxMNyYwDvwqSLSio3dAoq5NWQ
 TzqA==
X-Gm-Message-State: AOJu0Yw8F7H9+UpfoOSfTq+nfYavt11olSZBpWCSrBPiK2zFKpbS0fBW
 ITaMih+ts4yAOyBlz8GGZSfx+CK+BYiare7Fhb1HBMNA5xs8T/NZi6HcKd3D6mKXDID6bnam13x
 ENo7aZwTlvYx2ZmohvtHkoU8YuBcGe5vt3qrHf9Ncq+wdgxys
X-Google-Smtp-Source: AGHT+IGrLyv5IzW881YIpPQ2itR6R3479J5iBYmgxhnK2S+lhuqQRvzw+oM7A2wTTaDOTY3oktk3qwRMEba08Up8uE8=
X-Received: by 2002:a05:6402:504:b0:55e:f164:7765 with SMTP id
 m4-20020a056402050400b0055ef1647765mr4000426edv.32.1706610589713; Tue, 30 Jan
 2024 02:29:49 -0800 (PST)
MIME-Version: 1.0
References: <CA+ji3pGBJBp+trjM-RhgkYjOs8rrtLJgHsaNvf=EyGtWB4gAow@mail.gmail.com>
 <CAFEAcA-L2vepWXfgaHW=ogLAvAZjJd5yv1hm6dBU6dsEOS_gCA@mail.gmail.com>
 <CA+ji3pGVBmDAeUoPM9Zk8pOtpxcR+92XeUBN8G=Mmmyi4Eh8-g@mail.gmail.com>
 <CAFEAcA9AeqbWt1Q5QM_HEwi+A2KYXFs1ZEqfFJcqdktYwWujTQ@mail.gmail.com>
 <CA+ji3pH4ZapKAZ+vCSw6P=svWUtfsWt8aqoTFZX_CV5DzPoOyg@mail.gmail.com>
In-Reply-To: <CA+ji3pH4ZapKAZ+vCSw6P=svWUtfsWt8aqoTFZX_CV5DzPoOyg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2024 10:29:38 +0000
Message-ID: <CAFEAcA-Hsm1b2-2r=c0n0g+pJUWxLNjhGwdeomBt6=1XqZux=Q@mail.gmail.com>
Subject: Re: Assistance Required for QEMU Hardfault Error with Cortex-M33 on
 MPS2AN505
To: sanjana gogte <sanj27272@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 30 Jan 2024 at 07:48, sanjana gogte <sanj27272@gmail.com> wrote:
>
> I wanted to express my gratitude for your insightful solution concerning =
the INVSTATE fault I was encountering. After recompiling my code with the -=
mthumb compiler flag, the exception is no longer being raised, which marks =
a significant step forward in my project.
>
> However, I've encountered another challenge while working with a specific=
 version of QEMU (QEMU emulator version 7.1.0, v2.6.0-55433-g23b643ba16). W=
hile the code runs flawlessly on QEMU version 8.1.50 (v8.1.0-2375-g516fffc9=
93), the earlier version throws a hard fault, which is critical to my use c=
ase.
>
> The use case involves attaching a remote port to the MPS2-AN505, and for =
this, I need to utilize Xilinx=E2=80=99s fork of QEMU, which is based on ve=
rsion 7.1.0 (v2.6.0-55433-g23b643ba16). The error I encounter during emulat=
ion is as follows:
>
> Loaded reset SP 0x0 PC 0x0 from vector table
> Loaded reset SP 0x10080000 PC 0x10000009 from vector table
> Taking exception 3 [Prefetch Abort] on CPU 0
> ...at fault address 0x10800000
> ...with CFSR.IBUSERR
> ...taking pending secure exception 3
> ...loading from element 3 000000c
> ...loaded new PC 0x10000011 of secure vector table at 0x1
> Taking exception 3 [Prefetch Abort] on CPU 0
> ...at fault address 0x10800000
> ...with CFSR.IBUSERR
> qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)
>
> Observations: When I trace it using the GDB:


> It goes to prefetch abort as soon as I step into reset handler and the co=
nnection gets closed.
> What I do not understand is:
>
> 1) Why is my PC going to address 0x10800000?
>
>
> 2) When I use Qemu version 8.1.50 (v8.1.0-2375-g516fffc993), the PC goes =
to the right address and does not throw a prefetch abort.

This strongly suggests you're running into a QEMU issue
which we've fixed in some QEMU version after 7.1.0.
For bugs in Xilinx's fork of QEMU, you should talk to Xilinx.

In terms of why your PC is going to 0x10800000, it is
almost certainly executing a lot of NOPs from some point
until it runs off the end of the flash memory. If you
use the gdb 'si' command to single step single instructions
you'll probably find this is less confusing than using
the 's' command, which steps an entire C source line.

thanks
-- PMM

