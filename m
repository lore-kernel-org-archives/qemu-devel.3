Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA4BE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:56:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZL5-0000Qg-Pv; Wed, 08 Jan 2025 11:55:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tVZL3-0000QO-9a
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:55:25 -0500
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tVZL1-0006du-Oo
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:55:25 -0500
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-85bad7be09dso14845241.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736355322; x=1736960122; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzxZaTGxPPIRAm+KXE8q1riTZas1t3eUs1TQlB8tNKc=;
 b=nmli9GnRBl8bPwWk05CMsW3o4yvpawPTyghRlEdkjknc9RM+DmeQAru1/wTOp/BsEA
 lFVLthoSxdvNlKaE8ACC2wdswrYeNe7EzYOl5o5rinSNlh57asvHjzBa0OfM7T4aftGF
 DJv32q6Uo/ppnQlOG/6gy1cby3Vd0bcdpB96iYOfMNs7MiXc0Bbeq2XidFBcybe6sGlm
 uCmRxUCnHTQyW2cxOvXPjFYNLoL0Om2bZXeUi6Lqgem5cjgRmR6kJFWekqr4Cp7+RieW
 ahanmBR4ZCTkJtY2nJTgWI649hGyxsH5TTPtcSkDleYsiUkXWY3rvyrT0yF8wvl6IKVM
 /WHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355322; x=1736960122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hzxZaTGxPPIRAm+KXE8q1riTZas1t3eUs1TQlB8tNKc=;
 b=AVwl8so1oZN7VOvsXEoN9xeoZZJUTblfegQxWtbQKEz2c+Q8Oh9vfLrBibskKebeJ/
 9V38KDDg0gZbaYWQocN2IUWGC8heGpcvDYH/A+wh7X+Y0CZnv4IyAMQVJXu7n6M/dn6S
 KoetveSJkUEdKfRrXLL4VjpzmUUei9x/wcmez53LAO403V7Mle5r+BaQhKDZBuY8g8Q3
 PbeAA96mIJgDNI7wbzGsEHTxHVEo6hXzce0Qj/SsqO/+cjtEHWzxpnYKhplWebSUWjR0
 3G4CVeHZWXpA1bwSCr1AE1OJjgc8hO/8aif4peRdDfAJdQi+/+XZbuu7sKj6Xm427DIi
 FR0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPUDh1u3wZGi1o3Ev5heCHJlc/gYo0q4i2Qcxon/GTNg9eyR/01TMa3RYpeeL3LQMGs+fImm7Yl3ko@nongnu.org
X-Gm-Message-State: AOJu0YzJELHqci0Q3mXjPx0QNu9iH/51mMEFEPhglOoGc6cU+zuGLFpm
 NdQnfQcoVLWcB7Tmdbf1c4f/bLOlmC1BlMLCr5PxjqKRNmThqNC2R+t034kJqzRZt8ckyiJjEXv
 +tyNiu9y3oqdY86O1raHhvVahaFSbZA==
X-Gm-Gg: ASbGncsV154oAAe9tEy6JYbw2dRD0zoH39vowefaSgeT+VWvCcT81vG+g9GhHxOeRHx
 yyLN0v1hqbSElwVlINcj/0chrZNPO7IC2FRz7ADkT
X-Google-Smtp-Source: AGHT+IGqUOAjWm24Yg1EK03Slc1Xp3bBme3u0IUxVtCeC1TviqMNoX9w7GB4jDz1fzvr/1p5Pp+b1gY0q+tKjoFmN6A=
X-Received: by 2002:a05:6102:38c8:b0:4b2:5ca3:f82a with SMTP id
 ada2fe7eead31-4b3d0dd08b6mr3153731137.7.1736355321667; Wed, 08 Jan 2025
 08:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20241211222512.95660-1-graf@amazon.com>
 <CAFfO_h6iv=_dae_CdhB9Ggi-Q1ETREQROn22-p6vMN=g=DjrKA@mail.gmail.com>
 <CAFfO_h4iocyfTPZ_vtGU=ny=pw4hCapP8wQHB3ZoDVE=rAsi5A@mail.gmail.com>
 <CAFfO_h60R79YgTWjZi6hvd4-xMh=qTgsZey5xqr9bzv8u=MyCQ@mail.gmail.com>
 <7b576b03-efdf-4b54-a1cd-5dfe09f38ebb@linaro.org>
In-Reply-To: <7b576b03-efdf-4b54-a1cd-5dfe09f38ebb@linaro.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 8 Jan 2025 22:55:40 +0600
X-Gm-Features: AbW1kvYqxLXYCDQrfHE90XDVgHtmdKjq6JajqlBWqD1DLqVq6RHP8voQiSIPfs0
Message-ID: <CAFfO_h5ERsQDECgSEMu81ZYT3HNkp6sHmte=n_iF+Vzm93tyFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 Alexander Graf <graf@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=dorjoychy111@gmail.com; helo=mail-ua1-x932.google.com
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

On Wed, Jan 8, 2025 at 10:03=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 7/1/25 18:01, Dorjoy Chowdhury wrote:
> > On Tue, Dec 31, 2024 at 12:26=E2=80=AFAM Dorjoy Chowdhury
> > <dorjoychy111@gmail.com> wrote:
> >>
> >> On Thu, Dec 12, 2024 at 8:14=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111=
@gmail.com> wrote:
> >>>
> >>> On Thu, Dec 12, 2024 at 4:25=E2=80=AFAM Alexander Graf <graf@amazon.c=
om> wrote:
> >>>>
> >>>> The documentation says that Nitro Enclaves are based on Firecracker.=
 AWS
> >>>> has never made that statement.
> >>>>
> >>>> This patch nudges the wording to instead say it "looks like a
> >>>> Firecracker microvm".
> >>>>
> >>>> Signed-off-by: Alexander Graf <graf@amazon.com>
> >>>> ---
> >>>>   docs/system/i386/nitro-enclave.rst | 2 +-
> >>>>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>
> >>> Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> >>>
> >>> cc Paolo. This can be picked up for merging along with the 3 other
> >>> nitro-enclave related patches from me.
> >>>
> >>
> >> Ping.
> >>
> >> It's been a while and this one is just a documentation change, so can
> >> be picked up for merging. Thanks!
> >>
> >
> > Ping.
> >
> > This one can be picked up for merging.
>
> I have queued it, sorry for not mentioning sooner.
>

Great! Thanks!

Regards,
Dorjoy

