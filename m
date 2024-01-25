Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFA9C47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 14:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT0GW-0002ZW-3C; Thu, 25 Jan 2024 08:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rT0GU-0002WL-0q
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:59:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rT0GS-0007We-D2
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706191170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Re3c+KJWH3bNudfRYB+9GmOIyL/3Ce00Hc1oyRFjYkk=;
 b=Z+OBtDMWIJ2XevwXz9vWsWStLWYsPYnVLjSkdJb7XwPuAaAD7OVemg/DaBhu3+a4eZf9OY
 yKNCzD+OkpSlmwa2KzyCC3q/F6ZcUpMKSS670dI3ZflXnqJcRrlmmWeelfq8yACBw6XupC
 XSKN8ipmZ3fNda3Dmpz/eHXKt3MnvCw=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-K2Uq_zz9Mda2lyFAhqrDAA-1; Thu, 25 Jan 2024 08:59:29 -0500
X-MC-Unique: K2Uq_zz9Mda2lyFAhqrDAA-1
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-7d2df856a0bso1178596241.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706191167; x=1706795967;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Re3c+KJWH3bNudfRYB+9GmOIyL/3Ce00Hc1oyRFjYkk=;
 b=b52EMBU/Uw0+q5WQ+bHjbn0bDvsxrvwwWpHoOITjqeZov+xi3Y/BI7DOUwFbsfUWBS
 Oec1QtIXN7TlKxOjH0iBu/rHWP2HT6vvdSPTb2wYfBRbVNZwUNwr8fezDxWhYv8xDOUz
 b8GKvTgddMZs/UIkjvjCvjCxk18MmdorHq8am4Bm51ElEYFCsxLiSa/gtbSlPvrQqz6K
 KoXJjHxScjbUXk4aZIDUzM5d03rfG9IXvXaMFkBYaWc6HpoF0gr6ZyTxrcXz5uMMQxoL
 8eFxwWfQHhXgfwc/WBkGntpTAE9zg/XtT3guYTIzku0iZQUcEbqZi8hbZys6G8oEkH8c
 xPDA==
X-Gm-Message-State: AOJu0Yyanb8NShzVqNR/ldBospojaKVn2sXWU8/ziC+j1Z2EEG2s+6zM
 QEd7iGInkxmmL3GXpDOt1JhBDSXcFvoco39zZ52Wc5t33c6SLmt8u4bsCWWC0tIax0S9ig4no8f
 /S7mp6Xu2QjgpEkXq9wN9Tyfcv7r2Z+0/h1NvchdRTQYQrT2A9b9uFatAmd/VIoDn5arXfphMsP
 pbh9LiVpivnFNK9mwdxZH89dUQcBA=
X-Received: by 2002:a05:6102:a04:b0:46b:1f7d:4e8d with SMTP id
 t4-20020a0561020a0400b0046b1f7d4e8dmr203074vsa.6.1706191167730; 
 Thu, 25 Jan 2024 05:59:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLZrcW01K4ol06zzTrvOO6k3Y+QiQJlJkB02IjPv13Sab0FS39iEIpF1lETV2roIs3SUkZ3FmkfA2foAbmPz8=
X-Received: by 2002:a05:6102:a04:b0:46b:1f7d:4e8d with SMTP id
 t4-20020a0561020a0400b0046b1f7d4e8dmr203068vsa.6.1706191167486; Thu, 25 Jan
 2024 05:59:27 -0800 (PST)
MIME-Version: 1.0
References: <CABgObfaCq+++xj7ow5Sm22P5nfMZyh-BKt57m3Po6voKyCnuXQ@mail.gmail.com>
 <CAFEAcA-fnOjEOWGjw1vqyx3Evnf6U99-Yo-mqMkXD87J_ZdTgg@mail.gmail.com>
 <289b0f6c-8d77-4604-88c0-c257e0837d67@tls.msk.ru>
In-Reply-To: <289b0f6c-8d77-4604-88c0-c257e0837d67@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 25 Jan 2024 14:59:16 +0100
Message-ID: <CABgObfb9V25_ScxxRiqgF7fAPRrnBqzweKebkDTY9uKpqiuzsw@mail.gmail.com>
Subject: Re: Do we still need pre-meson compatibility hacks?
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Wolf, Kevin" <kwolf@redhat.com>, "P. Berrange, Daniel" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 2:02=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
> Heh.  I still use `make qemu-system-arm` (or `ninja qemu-system-arm`), bu=
t only
> because I haven't followed closely what's the "right" target to use.  I d=
on't
> care much which target it is exactly, but guess this is some info which n=
eeds
> to be findable somewhere (again, maybe it's in the docs for a long time, =
and
> I just need rtfm).

Yes, it is the right one.

> > I suspect that "just run configure in the source tree" is still
> > popular with the kind of people who don't frequently build
> > QEMU, though.
>
> "Run configure" is popular indeed, -- configure might either be a startup=
 script
> or just something to tell which command to use.  Again, personally I don'=
t care
> much which it will be as long as I know what it is ;)

Sure, that one can be kept.  Part of the reason I asked, was to
understand if it may make sense to clean the Makefile a bit (e.g.
split source and build bits).

Paolo


