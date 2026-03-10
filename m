Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7948FEA8550
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztwG-0006xV-0Y; Tue, 10 Mar 2026 06:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztwB-0006xJ-7j
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:03:40 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vztw5-0005FK-Sk
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:03:38 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-662abedbeb7so1995783a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:03:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773137012; cv=none;
 d=google.com; s=arc-20240605;
 b=lWgcItVbQKrJwrqsDr0bBSzkMNX7uHqdGAh4vA2zXXrVXVxV6J5SdG1BJtFzp9RJn7
 GdSBkUA0qufsOAVXhp3r1WIH3jFwVt8RITeGAy0Kh41VwGLnN0RAuNn1xv8EgpwIEtF5
 OkB1cuqE4OL2kLtw5dkELR1io62d2SBLNCPKtD0Q6euopE94uMcf4d3qWUNK3oc94bZq
 xzJiOzuhayTafcap+UUlnHBpGKIgAwwW3/3HXD5qsGgErrSPXitrVCkN1x5oET9XQg+F
 Qh1BX7Fj8F5Nqrq4LEjTj7JFCfIfIUeql1uAAnQY/puJcV2nWKyi759W5xRK00XQBvWC
 LW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fXrYWJ97Wx0+u3hRBLccGW8qXx+v21YOPINNKipUzFI=;
 fh=QptDyNslKGOgM7YQDmPmjIJ3s5ixH2z+xkxKHrHph54=;
 b=gLn6wgEHsWIlPpxqvB6Lo5UMxytnZ8A6nU2zd+6PGnPsL2rnlVER1uu2UvIghrHIwN
 ViNMKRzcWyvoSCyDQZiDcM+0oyKYuksS5VjXQwGyvt5M9+bsldtGfaJqzH9Q04l+oi9G
 o1MtrlSkDlgTV0Dl/oHcdioICDxPATtrupKSXkF7Y/MJmuRNbR6P5ZoJy8UYhLr3f2+y
 FJfXEiJD8Tm1idXvH8Pxn4OkKrXShpV9JtICJxR1I0BUOKjeg9Zb64VOBwK4LV/svEwp
 KOpTfjker8YKfu6AM9HV/+yZ5e5bxMexR1/GVNFSbeCj1/qK1qt7RMmVs25Uf/oCpNCc
 z3Qg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773137012; x=1773741812; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fXrYWJ97Wx0+u3hRBLccGW8qXx+v21YOPINNKipUzFI=;
 b=NVga6BexiMU1wCh6SBjxqcIq6gXdEwZyxVaRMHRLoX3bGM1baTf0cdqc8dF4YR7e76
 W1CC9Gkez4hKQKwOBzLoDGJn20aYhGxojHLQrxMVLPolOsmj+QwlHZtmkTGm41dAGGR7
 2ZOIJcQYBIEYu2su2X0ryaLVTRyZ6YlsVBdg8bUsuB8zatru4LYKTmGEQfljFDrynMuL
 t20PAaX+HsUI0WMzlIBxsGVKMcZP2+rXQ+34SwWz9/5+8otsrmzB9nmwvlOxNYhxRjwH
 HkYa31/Eh6nBYGd6kDrhVGiHemqe1Vk8DoJKc0fvWD5o8/LhuVGFp8akHSFfvDCOLVQT
 HLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773137012; x=1773741812;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fXrYWJ97Wx0+u3hRBLccGW8qXx+v21YOPINNKipUzFI=;
 b=Gf54lJi+2v/aQc2TJ5+joRrAMUHs0b0ZM+W+5aNQX9dQ+TvZJag2TpdWdsCFm0xcze
 h2yrR1tfv6KQrO6ZdGu5kSElc7avsRJ1cKauBYTAmZCoeA3bAw+IdvHoxcR7NQ8jAeuM
 coiWRSDmZzPj9z2dIPF3ZSGPg7gmMKyahI5RnVptFTvvoHQVCB9LesJs9fXj5d0JNTRs
 mHYcjaPya50hWJQnLDfU4uJ8k8ezMtCKKcdSZKDNG9nQgcUSizli4LJdOce3H8gxNcRt
 pkI4gdXnj3RhNJkA8boOMf1GRBwNLDDMrpchX8PnC/LOulyOyxTFaWlIDumRbUQIEsyX
 /pkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYTtK6TbDJ/uJESlNu+5Re8GltUsy285UG9Cmj0K8y8JYYiy1aYelqYK557+Kzma7eJ/Awta2DzYmP@nongnu.org
X-Gm-Message-State: AOJu0YyOkK7+dn4g7VkROuErfr05uKuqbWo5TQL3KxjfrY8Hy+fq4rC+
 XgpFpgocedz+7gGQi/hbHqrS5qax1in12Ancr2QlUGTYx62FsWKwRX8FwNJjrHRotOohYMOINPG
 FAcOM2GJUlnNCQAiY+wtPzXdsSZc6trw=
X-Gm-Gg: ATEYQzywSkbYL8dIYASUvccIY34jEhzCOHT7kyLAhLaCwMfTGi/ir6wbxNdgJFxfBzG
 9KbqtW1zLplfPFZtTDjOwBBZWlvKzNBPi0gWqdN/7oyPYkc9GKvZF0OC3mv9vH0pFlLS2JZ6blX
 +1T8d4YzVtn7R4Wn1UhBh3zMMJsWs4IAdwQZXwZS6h/IhXSyWBQ6NkO/i+GvKY32AjKHt5PCPib
 vP6dapgShIKFmKwgTEtearlMoZn6yOEJVtEWDU5Lq2AnvNBV+3YKoWTVOhZPjwizLQhZR0Lte2s
 aJfeeCE=
X-Received: by 2002:a05:6402:278d:b0:65b:a76d:7004 with SMTP id
 4fb4d7f45d1cf-6619d560f1dmr7330453a12.30.1773137011547; Tue, 10 Mar 2026
 03:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-5-zhangckid@gmail.com>
 <20260309081502.GC39949@fedora>
In-Reply-To: <20260309081502.GC39949@fedora>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 10 Mar 2026 18:02:54 +0800
X-Gm-Features: AaiRm53S4hjgQKMABDrAiFRdxGiOn6bvFuQzVuY9HgrK_712hG5UjiwW2DAZD3s
Message-ID: <CAK3tnv+HfV9JCR7whLRDcXpfp6ZAdbw1AhWzT1RSdTVevtyvBg@mail.gmail.com>
Subject: Re: [PATCH V5 04/13] blockdev: Update tracking iothread users with
 holder name
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, armbru@redhat.com,
 qemu-devel <qemu-devel@nongnu.org>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>, Eric Blake <eblake@redhat.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=zhangckid@gmail.com; helo=mail-ed1-x531.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Mar 9, 2026 at 4:15=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Thu, Mar 05, 2026 at 10:24:50PM +0800, Zhang Chen wrote:
> > Update the usage of "iothread_get_aio_context()".
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  blockdev.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/blockdev.c b/blockdev.c
> > index 6e86c6262f..01ccf64b3f 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -3683,7 +3683,14 @@ void qmp_x_blockdev_set_iothread(const char *nod=
e_name, StrOrNull *iothread,
> >              goto out;
> >          }
> >
> > -        new_context =3D iothread_get_aio_context(obj);
> > +        char *path =3D object_get_canonical_path(OBJECT(bs));
>
> CCing Kevin and Markus in case they have an opinion on this.
>
> BlockDriverState is not a QOM Object so using OBJECT(bs) is undefined
> behavior and may crash.
>
> node_name is unique across block driver graph nodes and could be used.
> Unfortunately it's not connected to the QOM Object hierarchy. Maybe it's
> best to build a holder name that is an invalid QOM path so there can be
> no collisions between QOM paths and block driver graph nodes.
>
>   g_autofree char *holder =3D g_strdup_printf("BlockDriverState %s", node=
_name);
>
> (A cleaner long-term solution would be making BlockDriverStates QOM
> Objects so they have a proper path.)

If no other comments, it's OK for me. This issue like I mentioned in
patch 7 and 9.

>
> > +        /*
> > +         * For this qmp case, hard to find the point put aio context ?=
??
> > +         * It looks like a pairing function is needed:
> > +         * qmp_x_blockdev_del_iothread()
> > +         */
> > +        new_context =3D iothread_get_aio_context(obj, path);
> > +        g_free(path);
>
> Who calls iothread_put_aio_context()?

As the comments I wrote:
> > +        /*
> > +         * For this qmp case, hard to find the point put aio context ?=
??
> > +         * It looks like a pairing function is needed:
> > +         * qmp_x_blockdev_del_iothread()
> > +         */

Please Kevin and Markus help to see if we need to add new function
'qmp_x_blockdev_del_iothread()'?
The iothread_put_aio_context() will be called in it.

Thanks
Chen

