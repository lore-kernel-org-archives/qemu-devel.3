Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99271D6D255
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 02:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGUVx-00035U-6H; Wed, 27 Nov 2024 21:44:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGUVv-000351-AX; Wed, 27 Nov 2024 21:44:19 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGUVt-0003UN-Lr; Wed, 27 Nov 2024 21:44:19 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-85714347e80so72220241.3; 
 Wed, 27 Nov 2024 18:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732761856; x=1733366656; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIlUWADJlRT4ztwFtZSIi/GZf1do5i7FpkNdxWQTtc4=;
 b=hl3zLWxt6QvW3tF1ngJfmMxgkiXMUagqOf3AmSN6KlWyQXd0O12BzYCcp+n8vSJwyE
 Y1TsncjwTT34sg+hsjxr04kYLu5NV5E8+wKaCJBRFqV6mkrKMyXA5GdPV2UkKUEOcw8n
 Pqh2JTX+oJ50TP4UDyxaM01yU/PtCoFqGNEXCyqkI/mMyAAEjrugKUoXI5kUuy9ot7Aq
 d87oq6Gm3XGV5qB0PIjG8o0xPcNJ519sBoAyrAtpnTPsyQ9odeDpo+KfIxo5QOW/5LH9
 CvH5p2T0DuHAm8ZxeM122rutec/qDwlKRRU95gvD5OcfPkKdcEx3bncLMtcDcegwjkG0
 BANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732761856; x=1733366656;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yIlUWADJlRT4ztwFtZSIi/GZf1do5i7FpkNdxWQTtc4=;
 b=CGYDWMiJQdeB61U+WVgcS3cL9T1ogZuvJF/1WNYwRZ22VshOGoP9rYIzd8LjviIuYp
 /C40kr2COH6jYAiNpOArC/sbj87T1HX5hNVB5JJ9MnVq0KOwkipBfdiubBYGwQUqnq8w
 BI1BRY9dM7+xd7BTBnULZu/O+wpQmLsRCO1rlp2B9E51VLLBNubzqNDute8KvK60fh6j
 bbH/1IYQ5buk7ph0qkAlrabFNxFZ+C5qK9RwdOT2Y/BzL/kXDWJsJuSN9IYNEUvLam7C
 Q2WS0O1vPaK9DFgH93ZR6qYNTG8pR4D/2rt9mYqFBmnddHTVXN45TpsXxrLBs5IbIoUf
 dm7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaWGQTw7jnvdO8dZsQbTF7hy3PKeSsCFjrTfNy2TUIFnSVd9ivhlkLKmT2EtTusHd2iddjg0KgYnpE@nongnu.org
X-Gm-Message-State: AOJu0YyoeNn72mvBXnmCQQyzFzTpq+ksKGVxr+H6lwdk9h+q4hGEgIgM
 G5F25u3PlwkrukFId4BYMiqsDODme4RduHXd+zC0hkevROqnerhQlavGAbgFmvZ2URFS58b4WoE
 oo9p85JtnU4eSt+75AJH9epEC+38=
X-Gm-Gg: ASbGncs6Zb99mLuSg3yCwy9mbxiPryPnwmogz8yA9M21LXApT4XUqYSy2p525ovp2JP
 I8q+X83hcfLgIrN+h9sg8r4SrFG7DBYstw/KIrDF7crPmITNKtL3sV4ay5GAGRw==
X-Google-Smtp-Source: AGHT+IHXvVPFBp1k2cZdDgIWgqsOIofSoHFfhubLGzaqI7sCdd7uIOkwRPC427O1aVWOql5Xu281UHvXwxRtmor4ijk=
X-Received: by 2002:a05:6102:d88:b0:4ad:641f:e63a with SMTP id
 ada2fe7eead31-4af448f7eefmr6639995137.2.1732761856014; Wed, 27 Nov 2024
 18:44:16 -0800 (PST)
MIME-Version: 1.0
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
 <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
 <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
In-Reply-To: <tencent_B97DED0E6971DEDD2F960CC63DFF414A2A05@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 12:43:49 +1000
Message-ID: <CAKmqyKO6Wjknoc1sXVm6d0BGzwcuF7VBqJdg_a1gh=6zz=KZNQ@mail.gmail.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
To: Yanfeng <yfliu2008@qq.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Nov 28, 2024 at 11:43=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wrote:
>
> On Thu, 2024-11-28 at 10:39 +1000, Alistair Francis wrote:
> > On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wro=
te:
> > >
> > >
> > > When debugging hypervisor extension based programs, it is convenient =
to see
> > > the
> > > current virtualization mode from GDB debugger.
> > >
> > > This patch shares the virtualization mode as part of the existing "pr=
iv"
> > > virtual
> > > register, or more specifically via bit(8).
> >
> > Interesting concept. This seems fine to me, I don't think this will
> > break any existing user.
> >
> > Another option though is to add a "virt" virtual register, which might
> > be easier for people to figure out as it isn't obvious from GDB what
> > bit 8 means. That might be a better approach as then it's really clear
> > what the register means.
> >
> > >
> > >
> > > > From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:00 2=
001
> > > From: Yanfeng Liu <yfliu2008@qq.com>
> > > Date: Mon, 18 Nov 2024 08:03:15 +0800
> > > Subject: [PATCH] riscv/gdb: share virt mode via priv register
> >
> > It seems like something strange happened when you submitted the patch.
> > Can you fix this up?
> >
> I prepared a patch file via the following steps:
>
>  - Did  `git format-patch --stdout -1 > /tmp/patch`,
>  - Pasted the /tmp/patch content to email composer window,
>  - Filled in email receipts, subject line and a few lines before the patc=
h
> context in composer window.

You should use `git send-email` instead, see the QEMU documentation
for more details:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#submitting-y=
our-patches

>
> I am wondering if the lines added before the formatted patch content in l=
ast
> step caused trouble?
> When resending email, should I use [patch v2] in subject line? I guess it=
 is
> unnecessary as it is the same patch.

Ideally I think a "virt" virtual register would be a better approach,
so if you could do that instead and send a v2 that would be great :)

Alistair

