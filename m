Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BF62CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 10:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGaY6-0006Qm-8i; Wed, 05 Nov 2025 05:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vGaY4-0006QM-Vr
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:15:29 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1vGaY3-0008M2-A9
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 05:15:28 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-63bea08a326so9204136a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Nov 2025 02:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1762337725; x=1762942525; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tswx9d+CI2f78KOpXEW8SmE1eY0NZdXjebel8U0Z1eY=;
 b=ZvboFxajbcykZvAY3iDoUGNReQId85gBr11O5eHGZQqp4bITWRaal2tku7LiacpwLw
 swREibErco0RwyIC7oRa2pUoo3EgpUgroNbZAERZQaSx3RtoiXybrurhzb1iqFgdkvQW
 q8FbabB9fyyD/HnFkEmkxHW3UGZaZuxOSIkGWaP6ecRSs9fbs+6WTKduK/vWQVj+TuZT
 40yDPo5ZbkStTQkgCSV4eFU/QMvsEv/V6iU+9ygCotshcgZsELzI6Wsou1ZImaFwaYSc
 HWELP0YuQvZLy1Em47NsRARRceLuK3Ta3ilhHn839gNKK4/XTH2SSvrmCdqULnCEmx60
 GEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762337725; x=1762942525;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tswx9d+CI2f78KOpXEW8SmE1eY0NZdXjebel8U0Z1eY=;
 b=GiQsbs185QmJjJYT1eG5qlVoSDxMumG9+hloPAgaJT48artc3yHVw1HpFi+QdHhlU4
 1Fop7zFR2CvAAXKRIXLgXbgFDWYLZhRjmDJjhvZqyHJsGruHnEL99I32ycdrkGY6SWPh
 KYheXAvNiPz8l27xcdHRKdoXjp3IYFAvZ4pu+Pxa2rqedkWuPOaKf9eiboUZEY0ArobB
 FkrFZBeXS4Gt+yH69zFOemzyJ7wpUPZbB+swZyG/6twjfWexLwXZaKRDkg7S3uDgjtqM
 y0cZRxYxxqVhcRMK6TuQLgnz6qbisTcMNmltkzLp7uWeKpLEZJcu2MR/1dNINAsE7fHg
 1bgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVlxISNY4KxreCmuZm9PjMEnm71MfujuOEzLK0VDdRObw8AI4UV8sHt582P+V7B/+GM3QB3gZUieq1@nongnu.org
X-Gm-Message-State: AOJu0YyucKEIIa7gxyMs4G7dF5egnCh1qR9psopxWEFxitYa/pTVFIDX
 JR6+c3iocbvADANmzH3pJihawQw7TdRgv3DRDhLNRTMXWTCeLuGpcH8cCAQnAsAYlaWPyv5Qf79
 Ol7yCXoq8+7fzgyqN4ayhFZOJbLlKL/WDO3LQJvsH
X-Gm-Gg: ASbGncvjGZDDgt3JxbJlpxgpKAL7ExwGZTVUI+ksKjCvXHKQcigAJnl38s3b3YtZ2eU
 NozphTim1/8ZKNIL38abyXEwz66EvOhFiMXUIc2VRpbB4Zb1x1jAHvb3BI4VvCy5xC2ZD27YRTl
 DmbEcXv6msYskHoIN4mw5R6fSkxxzO9LeK26oiYG650B4ajZGbvyP9/pVl5tzr1qAxmpTEqWiox
 ZJhRZT3JNtr39Nv9HJg5A6CpGRmKLRe00mGnD93swhvtCma8bU1Ll0rdfdJsjFe7YmTcgKRNP5J
 +S+A4GgRoLdZ9rbACT4=
X-Google-Smtp-Source: AGHT+IGnm/8ANrobJhYofRD3ZyHYEYVsQQiBR3bZF7Q49v10jV6HnigXMVfdtUOpUz/q/7KAckUVQR8O/XkBzd54uOE=
X-Received: by 2002:a17:907:9694:b0:b72:1b8b:cc3 with SMTP id
 a640c23a62f3a-b72654c9882mr242217866b.33.1762337724759; Wed, 05 Nov 2025
 02:15:24 -0800 (PST)
MIME-Version: 1.0
References: <20250903075721.77623-1-chigot@adacore.com>
 <20250903075721.77623-6-chigot@adacore.com>
 <aPqCJRNCjxcZ6jq5@redhat.com> <874ir9ot1a.fsf@pond.sub.org>
 <aQsafmFOrfEmOc0M@redhat.com>
In-Reply-To: <aQsafmFOrfEmOc0M@redhat.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Wed, 5 Nov 2025 11:15:12 +0100
X-Gm-Features: AWmQ_blYMyBgohxmROGPZb-U3vXj2OarOFYI5xs2KtTDD2lRHlAywk-WZPiIMOM
Message-ID: <CAJ307EgQBvuPVTDNiq-rL8D+n2iBPvbXVXhRGUGvv2Mm5Hrh+Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] vvfat: add support for "size" options
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 hreitz@redhat.com, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=chigot@adacore.com; helo=mail-ed1-x52b.google.com
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

On Wed, Nov 5, 2025 at 10:36=E2=80=AFAM Kevin Wolf <kwolf@redhat.com> wrote=
:
>
> Am 05.11.2025 um 08:08 hat Markus Armbruster geschrieben:
> > Kevin Wolf <kwolf@redhat.com> writes:
> >
> > [...]
> >
> > > To me it looks a bit like what we really want is an enum for floppy
> > > sizes (though is there any real reason why we have only those two?), =
but
> > > an arbitrary size for hard disks.
> > >
> > > Without the enum, obviously, users could specify 1440k and that would=
 do
> > > the right thing. Maybe special casing whatever 1.44M and 2.88M result
> > > in and translating them into 1440k and 2880k could be more justifiabl=
e
> > > than special casing 1M and 2M, but it would still be ugly.
> > >
> > > Markus, do you have any advice how this should be represented in QAPI=
?
> >
> > Still want answers here?
>
> Yes, I'm still not sure how we could best represent both hard disk and
> floppy sizes in vvfat in a way that isn't completely counterintuitive
> for users, that also isn't just arbitrary magic and that works on the
> command line.

For v2 (probably pushed sometimes this week), I've changed the
command-line approach to allow only `fat-size=3D1440K` and
`fat-size=3D2880K`. Other values will be rejected (including `1.44M` or
`2.88M`).
I'm not familiar with QAPI to see if that approach would fit properly.

> Unless the need for different sizes has gone away, but I don't think we
> found any other solution for the problem that would not require a
> configurable disk/file system size?
>
> Kevin
>

