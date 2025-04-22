Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDECC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 06:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u77IN-00081I-6M; Tue, 22 Apr 2025 02:39:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u77IK-00080u-Hg
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:39:48 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1u77II-0007SQ-T2
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 02:39:48 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-477296dce8dso45356881cf.3
 for <qemu-devel@nongnu.org>; Mon, 21 Apr 2025 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745303985; x=1745908785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CH4qEfxql7qMkASUDyyJCi9qd+yFpQciZm4JYVDpPpw=;
 b=jSLMjZPh831aFsvyre2a7hggWnfHpA/iBrQfX7Dz0Gis0+rVUY53jcEH0c8P5yimeJ
 f5MOiznAJFuKaOD878W+Dbmt8vKp8TSeeOEnEB+bOl2l1MbqR/HLGcobEIqocOfC3wRL
 UlUMT1qQW5KkApcOp4XbTYFhyGisqHFnKIqSQXEpHAAGRv30qtDSFp2I7Qkb6JPIarkl
 TiL3LJFee56UcDBrwW6ZI1vuq4QXD/gXw0SH7a4vDSaDY/Id18OkNNm06P1pbLT9jdbz
 T+jqHOJZ9FYh4BcjVRnA5KitSOdcXlhfykf9f15Xbt3Cn80IZOqQpqYhm4aqP13jEdh3
 +jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745303985; x=1745908785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CH4qEfxql7qMkASUDyyJCi9qd+yFpQciZm4JYVDpPpw=;
 b=hrR5EOLUZt0933lCG8mqv/l7ltD7HWnqiityI926bEaTBfTCK4h7oHmHtZv6HxZ26z
 2kR4dRjG9O+wCvl2/tACE5NVwTthY0BCPvPxdkyS4rMmHTNlYhzuNbyW/j21X5LiRzLr
 olLqq9SUWG7e/PGoCwdYLLocGmFIaedmiQMLWB4M8J4NgS46G6iWvHJAeoDMQGmjm0lu
 kco+/1XVsPXYrO+399ggNr9lVzds20ziG1XNGAd4Ree2gZ4oDCXOUTsqLubGyIIIVPvK
 kFpOg0rH3GGrn+p+CTY0ojdU9RNthnGaWWivherP8Vzh6UX4Pobx5MeBei67xN03RmYF
 jBSw==
X-Gm-Message-State: AOJu0Ywm1t273zhFZQMxLgGgCmw4MkpynetPeS67cny6cETce+mB1E2r
 ikGg9MSX/Ez14SjSS4q4uuNPA7rwqE9l7PVlregaQt3l5fdfmKzsCLivxGVUdQcCs0DKd1ibfD9
 UYSR73CUTlmx/gZNBi7sGFZflcwOe604pfVQ=
X-Gm-Gg: ASbGnct3W+eHvaY5U/hhRPBpQaMeeRhYf0OfoAYQPWyz+IlBr/LLSLkRbrI/XpVl0cv
 48w4u9DQNxI/fiJdO31ZVgJznwA9O+6dyYhyPn/IJKfoNh8nW+8Be/Y4t8AU1/Z/GFgYiaMOP/6
 XZdgZkLo0LsVYRd6K3SnprTzU=
X-Google-Smtp-Source: AGHT+IFNhtxBmAsfqkbMW4hne1Cp3QY39gnJN7TC1GrtvPdlz2WcHX5iaIJDRau7t2YJh7ebqUaic3+7o0FPa96p8y4=
X-Received: by 2002:a05:622a:1182:b0:467:5da6:8096 with SMTP id
 d75a77b69052e-47aec4cdf23mr252729671cf.44.1745303985370; Mon, 21 Apr 2025
 23:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250418112953.1744442-1-dietmar@proxmox.com>
 <20250418112953.1744442-10-dietmar@proxmox.com>
 <CAMxuvaxniAvsag=UT9xWjU5f17ec6ua9hFBDB72iTnh4jiH4vg@mail.gmail.com>
 <300596504.3803.1745303752280@webmail.proxmox.com>
In-Reply-To: <300596504.3803.1745303752280@webmail.proxmox.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Apr 2025 10:39:33 +0400
X-Gm-Features: ATxdqUGESODDagStWpZ6YCYSvapGTJqvats2cKfjOrfJ96x697is4ea1x66wVfs
Message-ID: <CAJ+F1CL1hrK=-6eJLYo9qkBmMCogcMGYBtaKF4EmNjNZxQZe7A@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] h264: register shutdown notifiers, stop pipeline
 in destroy_encoder_context
To: Dietmar Maurer <dietmar@proxmox.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x833.google.com
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

On Tue, Apr 22, 2025 at 10:37=E2=80=AFAM Dietmar Maurer <dietmar@proxmox.co=
m> wrote:
>
> > On Fri, Apr 18, 2025 at 3:30=E2=80=AFPM Dietmar Maurer <dietmar@proxmox=
.com> wrote:
> > >
> > > Some encoders can hang indefinetly (i.e. nvh264enc) if
> >
> > indefinitely
> >
> > > the pipeline is not stopped before it is destroyed
> > > (Observed on Debian bookworm).
> >
> > but why do you need the extra shutdown notifier?
>
> Because Qemu does not close open VNC connections on shutdown.
> and if the VNC connection is open, the h264 pipeline is still active,
> which cause the Qemu process to hang (CTRL-C does not stop it, only kill =
-9)

Given that h264 code depends on VNC state, can you make VNC
close/clean the connection instead?

--=20
Marc-Andr=C3=A9 Lureau

