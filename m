Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892C5CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 08:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrvih-0008Pw-PQ; Wed, 03 Apr 2024 04:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rrvif-0008PN-CT; Wed, 03 Apr 2024 04:11:41 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rrvic-0000Ii-PO; Wed, 03 Apr 2024 04:11:41 -0400
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-432f93c6c7cso14055261cf.2; 
 Wed, 03 Apr 2024 01:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712131897; x=1712736697; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xy0Hae0TJ5FYeFgJACvexUfQejNdEFOqczTwk3rgAMw=;
 b=Kz6qInEmMgFLXsWP9JWhVfg4mMRBXyX6hU9BGQSQ9AAjKuSxXXNAQGce6baBT9C3m2
 VtME6cHxeKCrpbHbNz7/z6n75l+T+jPpAUS1mAmguz6RRSefVKqma19MdlJPVAQDfumg
 DyC8qa167ulLocMNTcP0V1CQjAA0Gsi7FF8PQfSu2/RsT5vvbnwCuSMXUhRlHfIe9Ktx
 3bH06LaCl1gwtBnTliG6gL6k3VuEFpbSymLC3anaeycBwYiakmzIYja9p9wQWFHI+bMB
 n6p7n6/+cwB4jCRzV2BFmKhKoVATyS0QX3mwnE9+aBkL40CtUhe+Y/uui9Jqgb1qJM7t
 LHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712131897; x=1712736697;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xy0Hae0TJ5FYeFgJACvexUfQejNdEFOqczTwk3rgAMw=;
 b=ezjcPwa9bMVCR/D33XipB8ZNsTHDxZZnHBrySfCyIV1HGidjZYowBWjLl0GNU/+aug
 UfWWgkAp4FXHpkjD6c5LYlhOiYmDaR0FcuUSmA4k8SVxCl93fVfi+QPZmOf0zYoG/xmS
 n1XZiXRagOEklWY7H8UY6wsoitt2QS2RXFV94lcIjLckrwkkVfmO95+tLekk4CHCzitO
 vIyy7PZXdoYVTxjm/GXorc7sP0ZdZffWLvbrzIgCnNdtLOEfVaHycw6A7HSsRD+ImgQp
 dk8ddTpoIVKQ5DZGqMRjfMJg18wkLa+lTvsKfKaZdoggVvjdWo1lpNevBaju3WX2Gcrf
 8LDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8OlaZA9E0Wu3vj+vavSf87jFQ3EUZneP2Jf3MXML6BftK25QMVmLluYtvk+6R2mdcW3FV0NTmIwdqUuY2JeneV0K5eoyMMiL8zWhAfOwTgu45kwmfXpUv2LVECQ==
X-Gm-Message-State: AOJu0Yw4aC2NzP0e1K+vaCGIEo2yYwhWyKo4E4HSmaAh89lLU0qcWXoA
 jcWMEvqgdZ2yHFk3JXAU0aNDndqKpAoB+RHip8Wu1Btpc5ntK3mbiGwUOqHanvSJWD7i1wPccFq
 a2aUMR9l+O3SnNCyu901iMPz0x1Q=
X-Google-Smtp-Source: AGHT+IHEWRttjgwKqJbPd5i1XeAA6oaZxwK3BzjT60aDmxcZaSXneicDPT7v3ABgxuSt3t3zVgJo+SciqFm+ZhKwk9o=
X-Received: by 2002:ac8:5908:0:b0:432:b41f:f7bb with SMTP id
 8-20020ac85908000000b00432b41ff7bbmr18928923qty.14.1712131896804; Wed, 03 Apr
 2024 01:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
 <20240328102052.3499331-7-marcandre.lureau@redhat.com>
 <65d791e4-6c68-4b6d-b181-bc3886745ce3@yandex-team.ru>
 <CAJ+F1CLbjZG24rMKwA20NFM=6sTE4CRAaGt4Vha+bP8i=+on-A@mail.gmail.com>
 <0d7344c2-b146-44cf-a911-21fa5e556665@yandex-team.ru>
 <mzls26xlctld3fd5fl3h5wdrbh6hb5i3xcakeslwzny5tva7ch@w6wnruxtefkl>
 <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
In-Reply-To: <3064bc69-3d8e-4d7c-b640-a7ab703f9575@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 3 Apr 2024 12:11:24 +0400
Message-ID: <CAJ+F1CLG+7BT8wLFmmJ0t8NvMu2a2Vp1+p6gUuBTch9haYP8LQ@mail.gmail.com>
Subject: Re: [PATCH 06/19] block/stream: fix -Werror=maybe-uninitialized
 false-positives
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, 
 Hyman Huang <yong.huang@smartx.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 John Snow <jsnow@redhat.com>, 
 Klaus Jensen <its@irrelevant.dk>, Fam Zheng <fam@euphon.net>, 
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Bin Meng <bin.meng@windriver.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82c.google.com
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

On Tue, Apr 2, 2024 at 11:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 02.04.24 18:34, Eric Blake wrote:
> > On Tue, Apr 02, 2024 at 12:58:43PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
> >>>> Again, same false-positives, because of WITH_GRAPH_RDLOCK_GUARD()..
> >>>>
> >>>> Didn't you try to change WITH_ macros somehow, so that compiler beli=
eve in our good intentions?
> >>>>
> >>>
> >>>
> >>> #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >>>       for (g_autoptr(QemuLockable) var =3D \
> >>>                   qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL(=
(x))); \
> >>>            var; \
> >>>            qemu_lockable_auto_unlock(var), var =3D NULL)
> >>>
> >>> I can't think of a clever way to rewrite this. The compiler probably
> >>> thinks the loop may not run, due to the "var" condition. But how to
> >>> convince it otherwise? it's hard to introduce another variable too..
> >>
> >>
> >> hmm. maybe like this?
> >>
> >> #define WITH_QEMU_LOCK_GUARD_(x, var) \
> >>      for (g_autoptr(QemuLockable) var =3D \
> >>                  qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x=
))), \
> >>           var2 =3D (void *)(true); \
> >>           var2; \
> >>           qemu_lockable_auto_unlock(var), var2 =3D NULL)
> >>
> >>
> >> probably, it would be simpler for compiler to understand the logic thi=
s way. Could you check?
> >
> > Wouldn't that attach __attribute__((cleanup(xxx))) to var2, at which
> > point we could cause the compiler to call xxx((void*)(true)) if the
> > user does an early return inside the lock guard, with disastrous
> > consequences?  Or is the __attribute__ applied only to the first out
> > of two declarations in a list?
> >
>
> Oh, most probably you are right, seems g_autoptr apply it to both variabl=
es. Also, we don't need qemu_lockable_auto_unlock(var) separate call, if we=
 zero-out another variable. So, me fixing:
>
> #define WITH_QEMU_LOCK_GUARD_(x, var) \
>      for (QemuLockable *var __attribute__((cleanup(qemu_lockable_auto_unl=
ock))) =3D qemu_lockable_auto_lock(QEMU_MAKE_LOCKABLE_NONNULL((x))), \
>           *var2 =3D (void *)(true); \
>           var2; \
>           var2 =3D NULL)
>
> (and we'll need to modify qemu_lockable_auto_unlock() to take "QemuLockab=
le **x" argument)
>

That's almost good enough. I fixed a few things to generate var2.

I applied a similar approach to WITH_GRAPH_RDLOCK_GUARD macro:

--- a/include/block/graph-lock.h
+++ b/include/block/graph-lock.h
@@ -224,13 +224,22 @@ graph_lockable_auto_unlock(GraphLockable *x)

 G_DEFINE_AUTOPTR_CLEANUP_FUNC(GraphLockable, graph_lockable_auto_unlock)

-#define WITH_GRAPH_RDLOCK_GUARD_(var)                                     =
    \
-    for (g_autoptr(GraphLockable) var =3D graph_lockable_auto_lock(GML_OBJ=
_()); \
-         var;                                                             =
    \
-         graph_lockable_auto_unlock(var), var =3D NULL)
+static inline void TSA_NO_TSA coroutine_fn
+graph_lockable_auto_cleanup(GraphLockable **x)
+{
+    graph_lockable_auto_unlock(*x);
+}
+
+#define WITH_GRAPH_RDLOCK_GUARD__(var) \
+    GraphLockable *var \
+        __attribute__((cleanup(graph_lockable_auto_cleanup))) G_GNUC_UNUSE=
D =3D \
+       graph_lockable_auto_lock(GML_OBJ_())
+
+#define WITH_GRAPH_RDLOCK_GUARD_(var, var2)                             \
+    for (WITH_GRAPH_RDLOCK_GUARD__(var), *var2 =3D (void *)true; var2;
var2 =3D NULL)

 #define WITH_GRAPH_RDLOCK_GUARD() \
-    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__))
+    WITH_GRAPH_RDLOCK_GUARD_(glue(graph_lockable_auto, __COUNTER__),
glue(graph_lockable_auto, __COUNTER__))

Unfortunately, it doesn't work in all cases. It seems to have issues
with some guards:
../block/stream.c: In function =E2=80=98stream_run=E2=80=99:
../block/stream.c:216:12: error: =E2=80=98ret=E2=80=99 may be used uninitia=
lized
[-Werror=3Dmaybe-uninitialized]
  216 |         if (ret < 0) {


What should we do? change the macros + cherry-pick the missing
false-positives, or keep this series as is?





--=20
Marc-Andr=C3=A9 Lureau

