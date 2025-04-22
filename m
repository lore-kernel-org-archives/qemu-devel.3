Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 081B4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 07:08:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77jZ-0007rc-Q9; Tue, 22 Apr 2025 03:07:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u77jO-0007nG-Gd
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:07:49 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u77jM-00023g-UN
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 03:07:46 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4767e969b94so95338181cf.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 00:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745305663; x=1745910463; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2CCV4xdqSyJGRiH5jOL/n72P4mOc2xSXJfsKA/Brr/E=;
 b=e4VSjlz6p+bNe6dplMUekxNlpzkMerssy0T7iTq08LMiwoeqX7YB6yxrNIA+H9GD8F
 fBOP7vUwXPfMjoKCkFkDn9QHfKKKxvcIF46LPc5pQ6RGbjzFsSYOgjKiWfBvBmMBMs2X
 M9yKVfty+ERt/IYn6+c2Qe5fsuRtQuI96k4xzKKl/YF5bzp7kcDvbQ1+SwCp5+pr9RzJ
 Mdt2LSoxi1hyNqEplTuKCAoE7yySxjFbTUoCzHAM5kl0fV7EFoFdoKhijrCUw3cz+B6t
 icFbOmCAx/4cLpeDCsfaOYdleQFCYTxXARdvsK59hIkVKEsLt8r/qPm9ccgYNY2XObA6
 9Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745305663; x=1745910463;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2CCV4xdqSyJGRiH5jOL/n72P4mOc2xSXJfsKA/Brr/E=;
 b=d8FbnrRqJCRWH/7b8a9aw1r9/hWlbGpf/zsMmRT/HUok+F5LzA3qIazpXHgVZ7MNDl
 as/xUwTyAaZYQ84aX1BoJO23+NaLTSj93axiD/xsESDcXIeaVuw9lA1PdRAwPxqRDVRS
 Bv21ixCyZ6RoPVCuq6h/98qKYwMBotMO/hPQda95ct1PWW1QeDeW88+5orVWw7AYADNZ
 W9o7B2WsRUsHLv9MRJoOMwjduqdE6/DJSw4QWxxJwCwdfa8zDP4ZIEkUdsGpD21nh/RR
 H4JUeG7KSE1vVnTDxKTgwumPexh82v/cry3lPeMIel+jBv06Pqg6FSK5mz6u24DeJg9l
 /5iA==
X-Gm-Message-State: AOJu0Yz8y6LYDtoJnaHRPqcTb6lCu96lrcnHVUEaqA5ulpUQ4CX0LIsh
 5K0Qx91lfOYN4WNfonHA/7DkQXcH3VjDYSvTF+CYdmHqpZEXvtAWXc12gbf5MESm82JRObSEeuZ
 P3UVjDRIeHWSESosiC8873SDLdpAX4FHm75Q=
X-Gm-Gg: ASbGncuLnUWJzVM9G/KCnfRDOlTMd/iIUTQF3wjhCoGNqXNhtyH4nton3l4PV/OXiXU
 Swm9OkxlA4m+lmNcQMUHzHL6kgAPdEv4gyTqaLUMLp7lJqOr/73G/wQ+Pp0JVmpwgODVGAeJGSB
 +MlvsUAyavTjt4N5IFChjY+FU=
X-Google-Smtp-Source: AGHT+IFBnmzSp4dJqBcVHYRjm1y4ct1NIll5dYhVjp++pSjkuNQ/88Rc5ANVEJmFDqGoK8YwRT02KoaZrl2eB7JBRpU=
X-Received: by 2002:a05:622a:19a0:b0:475:ce:3c59 with SMTP id
 d75a77b69052e-47aec3cc71dmr260156281cf.30.1745305662998; Tue, 22 Apr 2025
 00:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-10-dietmar@proxmox.com>
 <CAMxuvaxniAvsag=UT9xWjU5f17ec6ua9hFBDB72iTnh4jiH4vg@mail.gmail.com>
 <300596504.3803.1745303752280@webmail.proxmox.com>
 <CAJ+F1CL1hrK=-6eJLYo9qkBmMCogcMGYBtaKF4EmNjNZxQZe7A@mail.gmail.com>
 <525848936.3820.1745305437863@webmail.proxmox.com>
In-Reply-To: <525848936.3820.1745305437863@webmail.proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Apr 2025 11:07:31 +0400
X-Gm-Features: ATxdqUGFtPQZSp30GxcOE3CXdU366etC44D5rmKPAQ8wtESE7ySmxlI20M50j-c
Message-ID: <CAJ+F1C+0ZQFafr4zYSAc6AGTxvFf+QoH5D7bw4S0FL4WZKFTYg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] h264: register shutdown notifiers, stop pipeline
 in destroy_encoder_context
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
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

Hi

On Tue, Apr 22, 2025 at 11:03=E2=80=AFAM Dietmar Maurer <dietmar@proxmox.co=
m> wrote:
>
>
> > On 22.4.2025 08:39 CEST Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.=
com> wrote:
> >
> >
> > Hi
> >
> > On Tue, Apr 22, 2025 at 10:37=E2=80=AFAM Dietmar Maurer <dietmar@proxmo=
x.com> wrote:
> > >
> > > > On Fri, Apr 18, 2025 at 3:30=E2=80=AFPM Dietmar Maurer <dietmar@pro=
xmox.com> wrote:
> > > > >
> > > > > Some encoders can hang indefinetly (i.e. nvh264enc) if
> > > >
> > > > indefinitely
> > > >
> > > > > the pipeline is not stopped before it is destroyed
> > > > > (Observed on Debian bookworm).
> > > >
> > > > but why do you need the extra shutdown notifier?
> > >
> > > Because Qemu does not close open VNC connections on shutdown.
> > > and if the VNC connection is open, the h264 pipeline is still active,
> > > which cause the Qemu process to hang (CTRL-C does not stop it, only k=
ill -9)
> >
> > Given that h264 code depends on VNC state, can you make VNC
> > close/clean the connection instead?
>
> For all open VNC connections?
>

Yes, we should have a cleanup path instead of shutdown notifiers.

--=20
Marc-Andr=C3=A9 Lureau

