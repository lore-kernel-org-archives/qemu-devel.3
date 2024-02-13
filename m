Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF4BC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxTv-0004Ed-EV; Tue, 13 Feb 2024 13:26:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rZxTt-0004EV-R4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:26:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rZxTs-0001PV-88
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:26:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707848767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CawK4S2AGXaWuzomHre9q0Dv/PxzCRGl9UGew+f3A8c=;
 b=dg63HCa7JIPb+v1BiRMv/VxjprA8Ah0FIZjWyyDEWobnVFAUlyQllE5NPwaybSuXe5Oy6G
 /SXiuBY68RtaeBQ4qjwc/l1bMFx4KFwMtnmJ5AJRugXl5i3eYByjzaQlO9Suyhn9sNDDBu
 0O591w4/29Qptptix+0vydm5XpN4Nm0=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-XyFSIfYyNkifSjaJCHodLQ-1; Tue, 13 Feb 2024 13:26:05 -0500
X-MC-Unique: XyFSIfYyNkifSjaJCHodLQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-56001d4c9c8so2935687a12.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:26:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707848764; x=1708453564;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CawK4S2AGXaWuzomHre9q0Dv/PxzCRGl9UGew+f3A8c=;
 b=FfAqI1nbwcNbUSiGRxkpQluhaVDDugZjREYYnuP5eJxAh2xU7p8ujaLtZlXuW0Grt7
 HuSQCUNO7znBV6sKXquEQMJkWtggLG+76oyasj4vcRbR8JXlH73ZXEwM3a6fECBjt2Xm
 HSzLzZJnzbQ4WclY3A//eZSI/+jhwEaXjKy9jD1D2bAhFTg2Vf95c+ZS9xGxjeHyAwXG
 uZxol9Gnu8wEVr3XqmhkOPR9QDGnjKcLu2sfhVDGP5cd3dxgJR0Hpx/URfCNN3D8iqo1
 Z3nDdbUVhFN41QYB9BqQRD7oDmrECiwFOw5YCxKvvKZiVj9VoXtk7CgHH1X51O5GaghH
 1Naw==
X-Gm-Message-State: AOJu0YzKrIFCGaqTW3QRiSpEfi3gEqfSvZLU63YxEK+mptXfipuccEqZ
 kDYqlpEMB8LVCjHL2aH/iSxs9eLu0+AvKCwqIwFb5i1WuXsoDBquK41c3fUmKGr2LOPwEtmDEfz
 dcEiPCr2sCwawu1XH1xx9HtC6qRka5w7M/rDyxTbehUF7SqZh/6+8f+FD1UxA1ALdU2ZxYiPBXt
 8mB8DqOslPlAIHUR3HtxUexDJf4vA=
X-Received: by 2002:a05:6402:b10:b0:560:1652:e7cb with SMTP id
 bm16-20020a0564020b1000b005601652e7cbmr338995edb.16.1707848764675; 
 Tue, 13 Feb 2024 10:26:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMX+a1YnKz6vPt1FlRwLekK4uCx5OwtRQlf4B+w3thrDGtVErQ/72XylJ2O23xK99HfGHofeNYRAjBNT5yecg=
X-Received: by 2002:a05:6402:b10:b0:560:1652:e7cb with SMTP id
 bm16-20020a0564020b1000b005601652e7cbmr338985edb.16.1707848764349; Tue, 13
 Feb 2024 10:26:04 -0800 (PST)
MIME-Version: 1.0
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-2-armbru@redhat.com>
 <87mss479ew.fsf@pond.sub.org>
In-Reply-To: <87mss479ew.fsf@pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Feb 2024 22:25:52 +0400
Message-ID: <CAMxuvawGA87bjCG3AMhkKaWMRL8EDThBmVnJ+dYjWNdzM_7wNw@mail.gmail.com>
Subject: Re: [PATCH 1/4] chardev/parallel: Don't close stdin on inappropriate
 device
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, devel@lists.libvirt.org, 
 eblake@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 13, 2024 at 5:58=E2=80=AFPM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > The __linux__ version of qemu_chr_open_pp_fd() tries to claim the
> > parport device with a PPCLAIM ioctl().  On success, it stores the file
> > descriptor in the chardev object, and returns success.  On failure, it
> > closes the file descriptor, and returns failure.
> >
> > chardev_new() then passes the Chardev to object_unref().  This duly
> > calls char_parallel_finalize(), which closes the file descriptor
> > stored in the chardev object.  Since qemu_chr_open_pp_fd() didn't
> > store it, it's still zero, so this closes standard input.  Ooopsie.
> >
> > To demonstate, add a unit test.  With the bug above unfixed, running
> > this test closes standard input.  char_hotswap_test() happens to run
> > next.  It opens a socket, duly gets file descriptor 0, and since it
> > tests for success with > 0 instead of >=3D 0, it fails.
> >
> > The test needs to be conditional exactly like the chardev it tests.
> > Since the condition is rather complicated, steal the solution from the
> > serial chardev: define HAVE_CHARDEV_PARALLEL in qemu/osdep.h.  This
> > also permits simplifying chardev/meson.build a bit.
> >
> > The bug fix is easy enough: store the file descriptor, and leave
> > closing it to char_parallel_finalize().
> >
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> [...]
>
> > diff --git a/chardev/char-parallel.c b/chardev/char-parallel.c
> > index a5164f975a..78697d7522 100644
> > --- a/chardev/char-parallel.c
> > +++ b/chardev/char-parallel.c
> > @@ -164,13 +164,13 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
> >  {
> >      ParallelChardev *drv =3D PARALLEL_CHARDEV(chr);
> >
> > +    drv->fd =3D fd;
> > +
> >      if (ioctl(fd, PPCLAIM) < 0) {
> >          error_setg_errno(errp, errno, "not a parallel port");
> > -        close(fd);
> >          return;
> >      }
> >
> > -    drv->fd =3D fd;
> >      drv->mode =3D IEEE1284_MODE_COMPAT;
> >  }
> >  #endif /* __linux__ */
> > @@ -238,6 +238,7 @@ static void qemu_chr_open_pp_fd(Chardev *chr,
> >  }
> >  #endif
> >
> > +#ifdef HAVE_CHARDEV_PARALLEL
> >  static void qmp_chardev_open_parallel(Chardev *chr,
> >                                        ChardevBackend *backend,
> >                                        bool *be_opened,
> > @@ -306,3 +307,5 @@ static void register_types(void)
> >  }
> >
> >  type_init(register_types);
> > +
> > +#endif  /* HAVE_CHARDEV_PARALLEL */
> > diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> > index 649fdf64e1..76946e6f90 100644
> > --- a/tests/unit/test-char.c
> > +++ b/tests/unit/test-char.c
> > @@ -1203,6 +1203,24 @@ static void char_serial_test(void)
> >  }
> >  #endif
> >
> > +#if defined(HAVE_CHARDEV_PARALLEL) && !defined(WIN32)
> > +static void char_parallel_test(void)
> > +{
> > +    QemuOpts *opts;
> > +    Chardev *chr;
> > +
> > +    opts =3D qemu_opts_create(qemu_find_opts("chardev"), "parallel-id"=
,
> > +                            1, &error_abort);
> > +    qemu_opt_set(opts, "backend", "parallel", &error_abort);
> > +    qemu_opt_set(opts, "path", "/dev/null", &error_abort);
> > +
> > +    chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
> > +    g_assert_null(chr);
>
> This is wrong.
>
> On a Linux host, qemu_chr_new_from_opts() fails, because
> qemu_chr_open_pp_fd()'s attempt to PPCLAIM fails.
>
> On a BSD host, it succeeds.
>
> Proposed fixup appended.  Marc-Andr=C3=A9, is respinning the PR with the
> fixup okay, or would you prefer a v2?

I am okay with a new PR.

thanks

>
> > +
> > +    qemu_opts_del(opts);
> > +}
> > +#endif
> > +
> >  #ifndef _WIN32
> >  static void char_file_fifo_test(void)
> >  {
> > @@ -1544,6 +1562,9 @@ int main(int argc, char **argv)
> >      g_test_add_func("/char/udp", char_udp_test);
> >  #if defined(HAVE_CHARDEV_SERIAL) && !defined(WIN32)
> >      g_test_add_func("/char/serial", char_serial_test);
> > +#endif
> > +#if defined(HAVE_CHARDEV_PARALLEL) && !defined(WIN32)
> > +    g_test_add_func("/char/parallel", char_parallel_test);
> >  #endif
> >      g_test_add_func("/char/hotswap", char_hotswap_test);
> >      g_test_add_func("/char/websocket", char_websock_test);
>
> [...]
>
> diff --git a/tests/unit/test-char.c b/tests/unit/test-char.c
> index e3b783c06b..f273ce5226 100644
> --- a/tests/unit/test-char.c
> +++ b/tests/unit/test-char.c
> @@ -1215,7 +1215,13 @@ static void char_parallel_test(void)
>      qemu_opt_set(opts, "path", "/dev/null", &error_abort);
>
>      chr =3D qemu_chr_new_from_opts(opts, NULL, NULL);
> +#ifdef __linux__
> +    /* fails to PPCLAIM, see qemu_chr_open_pp_fd() */
>      g_assert_null(chr);
> +#else
> +    g_assert_nonnull(chr);
> +    object_unparent(OBJECT(chr));
> +#endif
>
>      qemu_opts_del(opts);
>  }
>


