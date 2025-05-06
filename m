Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC4EC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLPs-0002Y0-Ow; Tue, 06 May 2025 12:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCLPq-0002TU-Ki
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:45:10 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCLPo-0003mP-U2
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:45:10 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-30863b48553so61972a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746549907; x=1747154707; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=yC0ECXde75V6nobHfnqunfAw2EloRLIfdnkLuabJLMs=;
 b=bFhXLaHmg++IK2JvEFQW3gs7v7ROQo7GqoDofWP/Nx257ZRm7Y3bRHxGRdmYtJx0kl
 r0sQn09iNGp2YVMQsJ4O5dEYb00sNTJDceIFgJtglI2X0AUqUNX1xarWRKTOy81PtxaN
 d+q1hPA5lA6FzjZAztoQhrsx7q5IKiAZGm2x6JfkCO3OkbdsYEMEdIrlM2VA3CTUe6cW
 IsynJetTVEDpOzK25d108Oofvv51v7ZSBqMi01zouUFUAMjXSjozDvvmuXx8dohJ5vpp
 kr6N9JxFQZ6rj5T5eTytBVru6gIIEEwR9UBSGPAAhAX9r+2aHYrJhSMJyy4AG8mgvnCj
 hULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746549907; x=1747154707;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yC0ECXde75V6nobHfnqunfAw2EloRLIfdnkLuabJLMs=;
 b=mXAz+uoOr2mLvsJYGpPMvs++dQdIi2Wp2/5NEha4dAYgW8DiuCKIiyI6gLeLiXjJEP
 F8EAEHu+zKVJXI9O4xN/lUFxif03F9ZVuYsQqfpzD+LFxjvmPOMU+iyGupJE6wLgSM/n
 jDOPqC9/gT1q24Hcq5x0xVfS3I+Gl15sggtD1Lm8ZAvSBY/9BGTke4PdxERnTzW6ZVKD
 L0ref18aZUuWl/SGvpxoJnkIFL5MlqS2vtAfWJWBCDsJcpWk9ddhbuVnc1KWLcU0QvrY
 qM3C+dgF+l1Wizjw8xO7dC6jCm2vFFSA72M1chSvZ7mY7nuYt6zPQgcsJ/OcvP4e2AjS
 Y3Ww==
X-Gm-Message-State: AOJu0YzUfK8eeaZV2cczWlMMl80QC0kYrdR0ZKLXBIU+fWqePt2OkbTA
 O8l3WTu6PYTgF0jBUU8XtbxiVq9r3L0kjZOkbnhOAhbUq3tYFSeo279i35tll7mCinyGE8cprhU
 B3o0om9pfQBGldhd+mmNRRUS2OCU=
X-Gm-Gg: ASbGncvHoO+QAqZ/ydsAeb6YHpKO8XlO8/k9TtYP64gfC8/79ZtMUuxKIyZvl6nDXhC
 QyvBp2i3LruRtVAkXI2I2ytPK2WmRXD/uzRHzyCUW10ScFcdu7XlrAIgtLgG46chX2rwJ+dwZf9
 gjQwix2LhOu+ADqqT6gMCKpNKP2NDf/Su/HPCKBqalpQ==
X-Google-Smtp-Source: AGHT+IFc6amYjd80dSNMM+8v33LCZ0x1lEz8Xx38dO6cOocKmclvgGZZ9cgbCEj/PVurEuy/CW35U8KEJvuznpR4KmI=
X-Received: by 2002:a17:90b:17cd:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-30aa8a28478mr446994a91.4.1746549907422; Tue, 06 May 2025
 09:45:07 -0700 (PDT)
MIME-Version: 1.0
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 6 May 2025 19:44:55 +0300
X-Gm-Features: ATxdqUGVLOrH4iLgWU4c8DtTpp47OR1a1x1Ga9qgB5yWTJfznFDK6bvC4PE2IZQ
Message-ID: <CACkyd_aL_KAgG1FzoC+H+TpNm2KCvWq+35HMUsVaBKWThNSBNQ@mail.gmail.com>
Subject: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Elisha Hollander <just4now666666@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000d0817e06347a562a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x1032.google.com
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

--000000000000d0817e06347a562a
Content-Type: text/plain; charset="UTF-8"

> As I mentioned earlier, let's say you don't initialize the vertical
display end registers, and set the minimum scanline register, the emulation
will then have to allocate some display buffer, but because the vertical
display end is initilized as 0 the buffer will be empty and the program
break.

Signed-off-by: donno2048 <just4now666666@gmail.com>

---
 util/memfd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/util/memfd.c b/util/memfd.c
index 8a2e906..e96e5af 100644
--- a/util/memfd.c
+++ b/util/memfd.c
@@ -108,7 +108,7 @@ err:
 void *qemu_memfd_alloc(const char *name, size_t size, unsigned int seals,
                        int *fd, Error **errp)
 {
-    void *ptr;
+    void *ptr = NULL;
     int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);

     /* some systems have memfd without sealing */
@@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size,
unsigned int seals,
         }
     }

-    ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
-    if (ptr == MAP_FAILED) {
-        goto err;
+    if (size != 0) {
+        ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
+        if (ptr == MAP_FAILED) {
+            goto err;
+        }
     }

     *fd = mfd;
--
2.30.2

--000000000000d0817e06347a562a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">&gt; As I mentioned earlier, let&#39;s =
say you don&#39;t initialize the vertical display end registers, and set th=
e minimum scanline register, the emulation will then have to allocate some =
display buffer, but because the vertical display end is initilized as 0 the=
 buffer will be empty and the program break.</div><div dir=3D"auto"><br></d=
iv><div dir=3D"auto">Signed-off-by: donno2048 &lt;<a href=3D"mailto:just4no=
w666666@gmail.com" target=3D"_blank" rel=3D"noreferrer">just4now666666@gmai=
l.com</a>&gt;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div dir=
=3D"auto">---</div><div dir=3D"auto">=C2=A0util/memfd.c | 10 ++++++----</di=
v><div dir=3D"auto">=C2=A01 file changed, 6 insertions(+), 4 deletions(-)</=
div><div dir=3D"auto"><br></div><div dir=3D"auto">diff --git a/util/memfd.c=
 b/util/memfd.c</div><div dir=3D"auto">index 8a2e906..e96e5af 100644</div><=
div dir=3D"auto">--- a/util/memfd.c</div><div dir=3D"auto">+++ b/util/memfd=
.c</div><div dir=3D"auto">@@ -108,7 +108,7 @@ err:</div><div dir=3D"auto">=
=C2=A0void *qemu_memfd_alloc(const char *name, size_t size, unsigned int se=
als,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *fd, Error **errp)</div><div dir=
=3D"auto">=C2=A0{</div><div dir=3D"auto">-=C2=A0 =C2=A0 void *ptr;</div><di=
v dir=3D"auto">+=C2=A0 =C2=A0 void *ptr =3D NULL;</div><div dir=3D"auto">=
=C2=A0 =C2=A0 =C2=A0int mfd =3D qemu_memfd_create(name, size, false, 0, sea=
ls, NULL);</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0=
 =C2=A0/* some systems have memfd without sealing */</div><div dir=3D"auto"=
>@@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size,=
 unsigned int seals,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">-=C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_READ | =
PROT_WRITE, MAP_SHARED, mfd, 0);</div><div dir=3D"auto">-=C2=A0 =C2=A0 if (=
ptr =3D=3D MAP_FAILED) {</div><div dir=3D"auto">-=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 goto err;</div><div dir=3D"auto">+=C2=A0 =C2=A0 if (size !=3D 0) {</div=
><div dir=3D"auto">+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ptr =3D mmap(0, size, PROT_=
READ | PROT_WRITE, MAP_SHARED, mfd, 0);</div><div dir=3D"auto">+=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 if (ptr =3D=3D MAP_FAILED) {</div><div dir=3D"auto">+=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;</div><div dir=3D"auto">+=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0*fd =
=3D mfd;</div><div dir=3D"auto">--</div><div dir=3D"auto">2.30.2</div></div=
></div>

--000000000000d0817e06347a562a--

