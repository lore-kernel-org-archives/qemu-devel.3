Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA2DC5AD49
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 17:57:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMVsm-0001Tw-3H; Tue, 03 Jun 2025 13:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMVsj-0001Ta-GW
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:57:01 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uMVsh-0000UA-Fm
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 13:57:01 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ad88105874aso934890066b.1
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 10:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748973416; x=1749578216; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Z9FU28RrZCofroiKwP7S6u05Ot5hpm86dlr9EyydP4=;
 b=CKTk+3uqFcEdEeuI2+87S9fSj6PxhKFXGCrlGYPkcnPfb6EnqMJDUevDTCt4mm2Vdf
 VJnW8q1/gViTCd5aMwIbb5XnxSAI+geaK0C/4hsPwTQwKuSbzJlNDhJR91Jc4h7lPZcL
 dLxyqgT6FUjCn18QGJxe3+2KO0PNkEnUbCby0oA0XQO3QxFVXhCFNetamoO6S1fMzAi+
 3XxUlQRsQbDaIL2GWf7bL8cDMwPFkpuwcIDv2jQlV8nSC5T1oIZ8+LXKwVlxm1c9nRYh
 Ntdm0fSuA/i/qLPASgQ/byTIrGeayaTN3ci7ITo7jhG70FFXWVnk/iL5MhZwPEuAx40N
 ksRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748973416; x=1749578216;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Z9FU28RrZCofroiKwP7S6u05Ot5hpm86dlr9EyydP4=;
 b=BjenIDrQyNWx8W1O2Z2AbuNasHtOMUHqIev5Zqv8R3GeEaERyHJc8AlfOl9iqK/Z9N
 w/lrjpTCCsEikfQcX213yipz54tKERuS6Y3t0PVgt8eFKS4b4II12oyX9J0eSsRwylt5
 lMSqEsUnBKuN1/Ch/TWWgOjcvQHIYywKuF99eXOJeAnUOo7PNNXc+d/ECUHoAhoF6OX6
 E9YLbP1jxjuWVHbhhvQxdOCZK7OuDgf7GnvA+8I7poKAdHeGBMtguJN0w/CsixS2vcMK
 QoliA+aSApBAeOdZ/srjGRJeySK844P3DGvOvAmSlPlLBfivBkdA5kduAg2gEQ4bOdCG
 tE3Q==
X-Gm-Message-State: AOJu0YyGBvjbf2H6Tq0547vtbQytydY36wwVgNHKTkzrjzuQp223s8So
 DFU6e4SxuB3gzS7KezDfHAYIVWcc6ys7HqBfufX5YxnfmnYhEsOT3Hxq352yLVlXa+i/3Pd29PZ
 Trcc8PzIH/NI3C7Mqw5RunJW89Ydc5AY=
X-Gm-Gg: ASbGncsOjDsJnrFeOhOU5/oolxqdWv1/r9zr1ZJxIH0VcXUBX75Yeil/qk4y/X9ELKk
 XZiEXrEHjXlf1oyzXnVG9e8TKNM+GtmeZWKqUhDrcPQ9FZEWET11LsnM/dhffkZG+0UT3V3Qlj9
 cjhPRvqa5EQwnCnKy1tm2Cc969gzXJ0uVJJb4sKTHzSg==
X-Google-Smtp-Source: AGHT+IH/wi+tFxW6xG3f4/bUuMkoXZ8sow94ur2A5bxU5zCFStv0Htli4IBD1DFX00mvJheRFNmAcwox0iK5eXD94g8=
X-Received: by 2002:a17:907:7b8c:b0:ad8:8529:4fa5 with SMTP id
 a640c23a62f3a-adb32580593mr2160808566b.46.1748973415676; Tue, 03 Jun 2025
 10:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250529085437.1479-2-oleg.tolmatcev@gmail.com>
 <CAJSP0QVT56Sx8-T2+qF2LnFksL=feGL+v0CJPnX+ZuQ6iMMMRg@mail.gmail.com>
 <CACcXsZgbzf+Rp8AujP_cGgh8J9xk=uadLM5Bem_6PCV=EzP2kg@mail.gmail.com>
In-Reply-To: <CACcXsZgbzf+Rp8AujP_cGgh8J9xk=uadLM5Bem_6PCV=EzP2kg@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 3 Jun 2025 13:56:43 -0400
X-Gm-Features: AX0GCFuU_io_p7txatKjy3wDpdHQhiOCtMW630C1VfmIG1pEegd8-WVH2pbnaT0
Message-ID: <CAJSP0QWC1JmgGQ5RoDG=kJfabOpsazXNMf1DFQQ=iTUY6zdAww@mail.gmail.com>
Subject: Re: [PATCH v2] meson: fix Windows build
To: Oleg Tolmatcev <oleg.tolmatcev@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62f.google.com
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

On Tue, Jun 3, 2025 at 1:00=E2=80=AFPM Oleg Tolmatcev <oleg.tolmatcev@gmail=
.com> wrote:
>
> Am Mo., 2. Juni 2025 um 20:45 Uhr schrieb Stefan Hajnoczi <stefanha@gmail=
.com>:
> >
> > > +    try:
> > > +        event_filename =3D os.path.relpath(event.filename)
> > > +    except ValueError:
> > > +        event_filename =3D event.filename
> > > +    event_filename =3D PurePath(event_filename).as_posix()
> >
> > Please do this in one place to avoid code duplication in the backends.
> > Perhaps event.filename or a new field can hold the properly formatted
> > value so backends don't need to call relpath() themselves.
>
> I'll move the code to "tracetool/__init__.py".
>
> > I noticed that out_filename is also emitted with #line but, unlike
> > event.filename, no special processing (relpath() or as_posix()) is
> > used there. Is it possible to drop relpath() and avoid the whole
> > issue?
>
> "out_filename" is not a problem because it is a relative path in POSIX
> format. "relpath" was introduced in this commit
> 9d672e290475001fcecdcc9dc79ad088ff89d17f. I can not decide whether it
> should be dropped or not.

out_filename is the last argument in sys.argv[] and Event.filename
comes from the previous arguments in sys.argv[].

Tracetool's sys.argv[] comes from trace/meson.build where the
trace-events filenames are built like this:
  trace_events_file =3D meson.project_source_root() / item / 'trace-events'

The output filename (sys.argv[-1]) happens to be built as a relative path:
  fmt =3D '@0@-' + group_name + '.@1@'
  ...
  output: fmt.format('trace', 'h')

It's inconsistent that out_filename is assumed to be a relative POSIX
filename whereas the trace-events filenames are made relative by the
code.

I think it's more robust for tracetool to make filenames relative than
to assume whoever is invoking tracetool.py has already done that. It's
also easier for meson.build to be able to pass an absolute path if it
wants.

That line of thinking results in the following:
1. Add a posix_relpath() helper function to tracetool/__init__.py.
2. Use posix_relpath() whenever a #line filename is required.
3. Also use posix_relpath() on #line out_filename for consistency.

How does that sound?

Stefan

