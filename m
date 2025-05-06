Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD724C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKsy-0006LK-MD; Tue, 06 May 2025 12:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCKsw-0006DN-8y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:11:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCKsu-0007kb-Cc
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:11:10 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-224341bbc1dso77970725ad.3
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746547866; x=1747152666; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/ibQx9Z5ub/XXOwvi/oT7xx7C9Az0djaG8/v2DOGJ9Y=;
 b=JuLEMcXS3F74n/jM/+4wCDKdpsZpjZ0/Alqf7jiQboMcibGDPNDMNMufQbecvfJjCB
 xWqXWKst1Y+ZBGwJHKgmaz3Arq/u5wgtU1NbVIeY1CmvR49e6A+KYQ4PuE27TNOqqKwK
 7gGzYIgTJXW8SO517s1lAXQqJCo1DHkrSeZXFO7D6eZlr6YXm8dvwikWZf2TtD1xOpCo
 Y8eKARyPylB2/8gu9gkr3DwNO2P5fqlei5ItemPTyc1vHwaWaCDx2a9MWd0gPkBGDEZu
 U/WVSMJ5qMm7my+Jp/xvBfBwYkTfeL7FkLY+ZVJJCudi9FxMGzVGtDW1DfPAjzVwywMw
 ZA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746547866; x=1747152666;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/ibQx9Z5ub/XXOwvi/oT7xx7C9Az0djaG8/v2DOGJ9Y=;
 b=mxLpaUaHwqkcBhz8PoCxl2h+3s5ABOsQOc1qnvVg1mcKzqSbdod5jgu5F2KmRYJnLg
 ByGnigGbvkmJxq2orBZPkpatQEKmzKiP/55igC77BSvsp7fVQhEiXbCEHLcG7w5dA9aV
 /l1Zial6wtdv/FzmekiCf3F5/pberDue/87hCR7v82fxf6amDnYExh3WHZmRjALHFzbO
 ka3RlN2NULVUfnwAGQgXyl1+AT9nrcz2Qmk+BjR5B8VYVRSmyKcQCdPmT6j3A/R+qRhV
 UO/yA9o7T8safwhxtxbQkAHObRWUWzXB+ilEBFUWaPnQkr+GfTw0mj55DWIzRdz/reUi
 PfSw==
X-Gm-Message-State: AOJu0YxlkXdNu73nPaVFTNid8zRKhrmk3thVKD9H1Yp3aA9bKENJeNfo
 UtKZeq/CdPTOn3PQGxYXXkuvOe9O01xEOch8BzMcJ2JDFAPJ4YHm4BGIHqhMrQvvCVkJWDIv9PN
 FHWT2j/2LBucngMyHJxEQAy8dggjce/hy
X-Gm-Gg: ASbGnctGy1GkIEUyZ2Ko+gskpVJ2QK+Rq4LE5PrkypAElIaw1FhK/JxJBfwT3NfPK5G
 Xs68kSD41gc4kvpJuCwNBdNsInzg5EZG7tOTX0BtrSot7LaskyVnka8atqJQTME5uhnAH1KdtUK
 WPicnDL4FuWae6el3HVnJN1AfTz0R2cPIvM7W0c64gyw==
X-Google-Smtp-Source: AGHT+IE3865TmTefOdEyO7F9SKOr7m51xJnzo5IWgyLVWvyJGdQgzbgWrgICR5cCvA8A7iQMUg0wT3t6lXFHkJqZ/uI=
X-Received: by 2002:a17:90b:3e83:b0:2ee:d433:7c50 with SMTP id
 98e67ed59e1d1-30aac21f34dmr20502a91.23.1746547865385; Tue, 06 May 2025
 09:11:05 -0700 (PDT)
MIME-Version: 1.0
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 6 May 2025 19:10:53 +0300
X-Gm-Features: ATxdqUEfH0d3pRU1a3lOqd49jHpIt5jf3ISsSF-oMmmYIl54H7tIAuH6fKsS5iE
Message-ID: <CACkyd_bu3J4EFep2nF__+p5kg=CCROnVt75H-t2QoxR26_WuAw@mail.gmail.com>
Subject: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Elisha Hollander <just4now666666@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000019826c063479ddde"
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=just4now666666@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000019826c063479ddde
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: donno2048 <just4now666666@gmail.com>
---
 util/memfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/util/memfd.c b/util/memfd.c
index 8a2e906..e96e5af 100644
--- a/util/memfd.c
+++ b/util/memfd.c @@ -108,7 +108,7 @@ err:
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp)
 { - void *ptr;
+ void *ptr = NULL;
     int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);

     /* some systems have memfd without sealing */
@@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size,
unsigned int seals,
         }
     }

- ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
- if (ptr == MAP_FAILED) { - goto err;
+ if (size != 0) {
+ ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0); + if
(ptr == MAP_FAILED) {
+ goto err;
+ }
     }

     *fd = mfd;
--
2.30.2

--00000000000019826c063479ddde
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4=
now666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gm=
ail.com</a>&gt;</div><div dir=3D"auto">---</div><div dir=3D"auto">=C2=A0uti=
l/memfd.c | 10 ++++++----</div><div dir=3D"auto">=C2=A01 file changed, 6 in=
sertions(+), 4 deletions(-)</div><div dir=3D"auto"><br></div><div dir=3D"au=
to">diff --git a/util/memfd.c b/util/memfd.c</div><div dir=3D"auto">index 8=
a2e906..e96e5af 100644</div><div dir=3D"auto">--- a/util/memfd.c</div><div =
dir=3D"auto">+++ b/util/memfd.c                                            =
                                       @@ -108,7 +108,7 @@ err:</div><div d=
ir=3D"auto">=C2=A0void *qemu_memfd_alloc(const char *name, size_t size, uns=
igned int seals,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *fd, Error **errp)</di=
v><div dir=3D"auto">=C2=A0{                                                =
                                                   -    void *ptr;</div><di=
v dir=3D"auto">+    void *ptr =3D NULL;</div><div dir=3D"auto">=C2=A0 =C2=
=A0 =C2=A0int mfd =3D qemu_memfd_create(name, size, false, 0, seals, NULL);=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0/* =
some systems have memfd without sealing */</div><div dir=3D"auto">@@ -131,9=
 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size, unsigned =
int seals,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}</div>=
<div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">-    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHAR=
ED, mfd, 0);</div><div dir=3D"auto">-    if (ptr =3D=3D MAP_FAILED) {      =
                                                                  -        =
goto err;</div><div dir=3D"auto">+    if (size !=3D 0) {</div><div dir=3D"a=
uto">+        ptr =3D mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd=
, 0);                            +        if (ptr =3D=3D MAP_FAILED) {</div=
><div dir=3D"auto">+            goto err;</div><div dir=3D"auto">+        }=
</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0*fd =3D mfd;</div><div dir=3D"aut=
o">--</div><div dir=3D"auto">2.30.2</div></div>

--00000000000019826c063479ddde--

