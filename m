Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612AEC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 10:39:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCFhS-0007sW-Q2; Tue, 06 May 2025 06:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uCFhR-0007sN-2Z
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:38:57 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1uCFhO-0004Dr-Ja
 for qemu-devel@nongnu.org; Tue, 06 May 2025 06:38:56 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-476a1acf61eso59623641cf.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 03:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746527931; x=1747132731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FfJTCQ2R1KEWdIxYZv+z04lPQX+YE4Qn1qD8Loep20=;
 b=M28IOa4JxDpyuG59jGJAQ2MSjcAVQGKj5W+wmauUpBnn4Cw2a0NnwabapvZmGl4rVY
 NpdB3UgXvPh4iWK68g/UsaOmny7B9HfpsKzjbOBw/PRkS/hSx8GIFjKhgK615RCSr5Gm
 K2yB42UflajEmQa6vbQ4kaynGb6OJ+G6NiPYZ1OZlSuoVmp7+cjbTBcEgkGqGp1d8o3G
 sHrxsDW7mAsIOFsCSMJJlXPvBwMnPA3zy8T2NP0A9cAF5j0tWf80AfJncDJW/jqD7RYV
 BM0vbRejoySpjInGmgGch5J65n1FKfXKxWoKMo6b7HZBzF0a+l/pxBiFSsLiBdN0tBEH
 PAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746527931; x=1747132731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FfJTCQ2R1KEWdIxYZv+z04lPQX+YE4Qn1qD8Loep20=;
 b=CRpQDSOHpBXRsab2afhIxDJNByI3kjHxCadsj3h2m8F4Rn/Xuh90bXmOfvnef0JDHL
 SI+GOKuIZfgkg6mKSQxKtcLN10l8djJeu7O8PvC+t3ky8ItfgABHyeN9O/CPrA78A8Xb
 z4HyimxSn2k3hKuiATZ2dHj3XhgRPt9IHLxuxmzoHu+mRt6YPAmiv0SwUtEQ04Xgzdnm
 cvOK5BxX9GLmu5OxVfV9ruovzg7/J6phFfZrc4ZNet5FFyXveWzvtd/siyXDk2MBI4r3
 tJUqZz5xQeV7cqsaX90sduJ1rg2V5oRYn2M2hBA/Tb9GJGiGFuDM4n35NZEIYVd+/7pQ
 FoCg==
X-Gm-Message-State: AOJu0Yxf5bBkOe5t/f52GWS0xwTSq/2X7kzwhmtY8kw31BBTZYd4vMmM
 vGwwJjv/hoUfoZMUA396o9HvzpOfKV3CMll4H0ztdsqVZNhaiqddhPLphT8JMSfY+tOQL1krsyp
 CvQoonnuyKYou5jRYVpQZ9rUoyNA=
X-Gm-Gg: ASbGncvQh3PswXpKlZwMrdyJpM7IJF9aeKcT9q4TBAaVXlsBZDrYZoDBkqfOkKtxCiM
 pPhjTajAFRZ6XpJD2jENpy9JiBQth2Ub0Iv8c3Qlu5XPP9GXNOCxJ1ITnk2Tn0Ed5aNqE5MN8Sy
 4qiRMBbvdhVpvp0YnoFZ/zhL0=
X-Google-Smtp-Source: AGHT+IFqognh8C67G+HB36XybGpBN2tTEw6Ec9oNVLR2PTG5BL57lwLdyMEgz0IUW3M8qLOkaoxsb/HJ4gpBea3abJI=
X-Received: by 2002:a05:622a:4244:b0:48a:1594:6207 with SMTP id
 d75a77b69052e-4910c394f2dmr35549721cf.15.1746527930644; Tue, 06 May 2025
 03:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250311155932.1472092-1-marcandre.lureau@redhat.com>
 <Z9Bg157qSKt2v74Z@redhat.com>
In-Reply-To: <Z9Bg157qSKt2v74Z@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 May 2025 14:38:38 +0400
X-Gm-Features: ATxdqUHdUG3N_TGGgp8AhE4Sms_NQhfay3pP4vSs_IDjYEoQyIOeNS8tG6x5Qc0
Message-ID: <CAJ+F1C+GJ-3+4O0Hdjh3ZPbBiMmAfQdey1J++4mCPkNufReFSg@mail.gmail.com>
Subject: Re: [PATCH for-10.1 00/10] Support vdagent migration
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
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

On Tue, Mar 11, 2025 at 8:16=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 11, 2025 at 07:59:22PM +0400, marcandre.lureau@redhat.com wro=
te:
> > From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> >
> > iQJQBAABCAA6FiEEh6m9kz+HxgbSdvYt2ujhCXWWnOUFAmfQXbMcHG1hcmNhbmRy
> > ZS5sdXJlYXVAcmVkaGF0LmNvbQAKCRDa6OEJdZac5bmLD/49TJdk8vSnG/G53f3Z
> > UdUGdDiv98lAr/1wPZvmLPGfxiVLrVQK9Rarjnq9+dzmjoJC+w8THyPIvlvlKAQO
> > aNSe5LV2lcYFLZwJqXQdGHTEWWZX3BmXroSFY06F9znX4lrNSg/cxLaI+Lt+dbEt
> > BA9IIMzGYB+zhkgJh86Yji1Ioz29qwMgb4etf4OtP3PqT7/djWxxdlYLmyqN7D13
> > seHAkvhaA7sqglLcfUv0MjrNA1Yxg3QQmbmiErpyaHo9kQ2AuV49THZl5/Pe3WR5
> > FJAeO83G8hdxdqFuDvnXB0ID2klqWYkZTJsTD75F1hU1yqszkVt8k4mUWubTIDNm
> > VEFKGz/S+xR2rO0RGgGzMPzEm0FSPbLq1+U2ETRf3xBns0Jbqe6njHeLGAzmOx9p
> > 3F8fkM4mzIrs3oOU/e7dlxOl9N6uQhVfJW6G+9QMLPLveIpNR6CGphbgHuMK8PPL
> > vZ1WNrGa/xoHvqQi2FvIJJrnKYYBJDXQW1edM+apDgO9jBSmiO5XlKZjeNHwgZ6J
> > 0sNmJUKCmk2SPGtFHdpdRfjfYfN2eR07eTVnVgstpHCUZi0nRz+4A6yq4k0SQLQH
> > ZWsaq6cdZyfNOOdSHaLfI/2/36eiLpVCAuwn+AjK+XvPR6mQc9rwebV8N5nXLEZ8
> > OFcig1i00RhHBRJFPrOjWIFIQg=3D=3D
> > =3DiTg5
> > -----END PGP SIGNATURE-----
>
> Huh ?  I presume there should have been a cover letter here
> instead of the tail end of a pgp signature....
>

No idea what went wrong. But anyway, there was not much to say in the
cover letter, ttsia.
Up for review?

> >
> > Marc-Andr=C3=A9 Lureau (10):
> >   ui/gtk: warn if setting the clipboard failed
> >   ui/clipboard: use int for selection field
> >   ui/clipboard: split out QemuClipboardContent
> >   ui/clipboard: add vmstate_cbinfo
> >   ui/clipboard: delay clipboard update when not running
> >   ui/vdagent: replace Buffer with GByteArray
> >   ui/vdagent: keep "connected" state
> >   ui/vdagent: factor out clipboard peer registration
> >   ui/vdagent: add migration support
> >   ui/vdagent: remove migration blocker
> >
> >  include/ui/clipboard.h |  31 +++++--
> >  ui/clipboard.c         |  66 +++++++++++++-
> >  ui/gtk-clipboard.c     |  13 ++-
> >  ui/vdagent.c           | 202 +++++++++++++++++++++++++++++++++++------
> >  4 files changed, 268 insertions(+), 44 deletions(-)
> >
> > --
> > 2.47.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>
>


--=20
Marc-Andr=C3=A9 Lureau

