Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE195C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 13:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4KQN-0005Gs-1H; Tue, 07 May 2024 09:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4KQH-0005GW-9W
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:59:57 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4KQE-0006Sk-RH
 for qemu-devel@nongnu.org; Tue, 07 May 2024 08:59:56 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-23d38cd0df6so1895036fac.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 05:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715086792; x=1715691592;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uT0vo8CG8M630M+5NtwG4obebjUh3TR5iZy6CCB8lwE=;
 b=udHf+uZXrUD69Ovw6aBNHDHdVt7eH4o/o1K5Kb1OeVvWy4W6sxKdisYTgkXfNxkM+6
 YHW8R+QuWssOjjSnzvlDi9r9MJHUPgwpo6DlD9nmS9ISWkJfcK4NCV6TbL/GQb/c7JyT
 klNVvJZ3r7ade/Ar5W4aGhPAMZptuFlakXrXHPvjxGMqNvDInWXZZ9v0Xgdh3x0QDxDB
 iMG8UsFJqJcehndpVKDpZXkxgAO84346YkG5WoA2NlYhyZs5CsBH5uMh01/D4MJRzD7u
 f6JJTitw2g7VamuEOA5de8WMb5e/jpJfpkXxDr2Uf5lsUH4a6U023imHN1A2/dHAfVbh
 yoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715086792; x=1715691592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uT0vo8CG8M630M+5NtwG4obebjUh3TR5iZy6CCB8lwE=;
 b=lizpG9crLT6jTo/w+aUrGiuUcST00ooof7GF4TdGOhRKbu3ohRbYLqDiHKMQ7ybir6
 LpytCfUhNk65PQslMvkQ4MVt7sLd8FMFhktovDAk6TL5n7TBuR6ozOHtgY1ACxUZvx3Z
 eabkN657xLO8dMlYp4YlkC65Xpc9VtfKifHqTCDntgqOJI+0AmJRdEZ5cYDw8M9C+jfC
 xbfOsBN+EvtetpE34Z4i7lJgJKTrSgVwBfZjiwyS3pRTdTNVRlPgbtuS+x/2DRZVSKpN
 QLH4JZ4ev19wDWA+0Y75fZj5v3xmCXTsBK4PZqFOtQhu7O/dYjF4v8Orecb7a2OkrZE4
 RtKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6OsofVFnoFl8S8bSfhjuEN3qMH6CkahIuqWLHLQV1RL4egzKod0lmYXDw+l2wJYX/jSiKFMevrUx1B0H+zDXqV18dp44=
X-Gm-Message-State: AOJu0YzRWdiBUbg5aubukGMIS0IO1KCDozhNdjcbvQnVcIjh+CRtMhPv
 jIlrM7HuX0jGIPQblGwFVbhxAck6xlIgeYDrm3RLs/713V6jKT9nAQIgsYWxaUPKnvb20X97+/W
 RXf6phSkLm2brjDXXR4TP/9nUmVA67RRzPXJweg==
X-Google-Smtp-Source: AGHT+IGEsYVfZ2MTxIHb1+WOKsO8rUX/ytkuXvnETlDYQBjiOl1U63444clJq2hDqt5Wbb/Vj/7Dbo2fbfsT3OJZTqs=
X-Received: by 2002:a05:6870:310e:b0:22e:df68:ee7a with SMTP id
 v14-20020a056870310e00b0022edf68ee7amr13913429oaa.42.1715086792573; Tue, 07
 May 2024 05:59:52 -0700 (PDT)
MIME-Version: 1.0
References: <20240304100554.1143763-1-mnissler@rivosinc.com>
 <ZeWho6ZW41tg0rob@x1n>
 <CAGNS4TYd7qVjLb6VCUSQa9DrYivwJV5UDhdSnSde0t2UCMpXrg@mail.gmail.com>
 <ZjjsyF_ZMIPGqcci@x1n>
 <CAGNS4TaSxprHvoVCMRLw2YCGA2FXirO=Wp-TgzzxquwaL6y51Q@mail.gmail.com>
 <CAGNS4TYUPwQFWZ5Pc3eqTkLX2u0_mP5EFMJgGLUva3CGL=ZxLg@mail.gmail.com>
 <cf640e4c-610e-4357-a9bb-57d2d4ab1254@linaro.org>
In-Reply-To: <cf640e4c-610e-4357-a9bb-57d2d4ab1254@linaro.org>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Tue, 7 May 2024 14:59:40 +0200
Message-ID: <CAGNS4TbQP7+vMpaBBgGx+SbC1-vaz53UoP7sNPq8K6Bc5Ynarw@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] Support message-based DMA in vfio-user server
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, john.levon@nutanix.com, 
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=mnissler@rivosinc.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, May 7, 2024 at 2:52=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org> wrote:
>
> On 7/5/24 11:43, Mattias Nissler wrote:
> >
> >
> > On Mon, May 6, 2024 at 11:07=E2=80=AFPM Mattias Nissler <mnissler@rivos=
inc.com
> > <mailto:mnissler@rivosinc.com>> wrote:
> >
> >
> >
> >     On Mon, May 6, 2024 at 4:44=E2=80=AFPM Peter Xu <peterx@redhat.com
> >     <mailto:peterx@redhat.com>> wrote:
> >
> >         On Thu, Mar 28, 2024 at 08:53:36AM +0100, Mattias Nissler wrote=
:
> >          > Stefan, to the best of my knowledge this is fully reviewed
> >         and ready
> >          > to go in - can you kindly pick it up or advise in case there=
's
> >          > something I missed? Thanks!
> >
> >         Fails cross-compile on mipsel:
> >
> >         https://gitlab.com/peterx/qemu/-/jobs/6787790601
> >         <https://gitlab.com/peterx/qemu/-/jobs/6787790601>
> >
> >
> >     Ah, bummer, thanks for reporting. 4GB of bounce buffer should be
> >     plenty, so switching to 32 bit atomics seems a good idea at first
> >     glance. I'll take a closer look tomorrow and send a respin with a f=
ix.
> >
> >
> > To close the loop on this: I have posted v9 with patch #2 adjusted to
> > use uint32_t for size accounting to fix this.
>
> "size accounting" calls for portable size_t type. But if uint32_t
> satisfies our needs, OK.

To clarify, I'm referring to "bounce buffer size accounting", i.e.
keeping track of how much memory we've allocated for bounce buffers. I
don't think that there are practical use cases where anyone would want
to spend more than 4GB on bounce buffers, hence uint32_t seemed fine.
If you prefer size_t (at the expense of using different widths, which
will ultimately be visible in the command line parameter), I'm happy
to switch to that though.

