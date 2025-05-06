Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31836C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 16:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCKzE-0003Rc-Vu; Tue, 06 May 2025 12:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCKzD-0003Pp-My
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:17:39 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <just4now666666@gmail.com>)
 id 1uCKzB-0008O4-QK
 for qemu-devel@nongnu.org; Tue, 06 May 2025 12:17:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-30a8fd40723so938510a91.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 09:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746548256; x=1747153056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mqSbj9w3DhPdwtF/sf0zHQRXypyJF2qPdruK2v79sWQ=;
 b=bQnkqTKBvQIDmGlAjSfrA/2jddCO3Gj8qgRjZpJ+luxI2i8wIVWIOH6CoDjYEutbsz
 eqobVo38ONvFx1guVnkcqIXROVXfsW692Xh2UeEey3NLAQ8BqsJJoDnzFeErldEKbrK2
 pljZMf6ObJ+muPs3IeYmTN3b7OE4E2j4LkPTb34NNgFe9FHNqZEEq1GueSRRXyCXFRO7
 lOwyUQjhb9M3YtKWMeJqoekXqUEzhK2JkNFpuLfha81g1R1uMsiieWBFN4Jo2sjLBsOo
 HgTpd58N6VMjMsEBBRRTBWTMP+Auv3BCux+kgsPM2VfgyiHEOwSCG4LkaKw0bODem/Nk
 qTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746548256; x=1747153056;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mqSbj9w3DhPdwtF/sf0zHQRXypyJF2qPdruK2v79sWQ=;
 b=FuEA9RnJScWfGpH3hm2m746CD8yXMSxSJWe7kcjKWNmK/F58FS2SNa96c2axWgKL1F
 pfF+PIEnKscxTpT7jbpWX/MbKF+e1uxaOP51SyYsuNXTWL50unnaSwsqDy/MDviH84Ha
 xI/tmlK089U6ml8B6qlWg2DmSvRkuQZVPtqfGbQpL18bSvtPnGYqKE3UwnZjDtoSRKc3
 ZQOdDYU75IcV00ptLjsSqX5KWbhyR+HM1HPMNvUvWVQUAfuAnd/3/8KuT78SIu3Xc/8e
 4wG6qS/Cbramqa0CvHyf0uQy9S4jn7Nme9g2q4MPqMbs7yYKkrHzydCS8e3wNM0WDKWn
 k7hA==
X-Gm-Message-State: AOJu0YxVIT8KIOwgestcC4Vo6FUDi26RixenmMu53e1CRwMeSSF3c2f/
 Ifa8KmjkApE6qTTmlZ/7T+v/9VdymY1YpxgSIlS1CBMFd1ex3NSWBR0tyNwbD5ytFlc5hNXpn4m
 e/5+gB2UWJ85M34gGZa9P3V+ZHXmX7KbAz90=
X-Gm-Gg: ASbGncvAjXzW06V4yELDqKFV1ShfgkmBNZ3HyerKcxultPGTuY94e1rqPV0QsOo0RDV
 AizFgYN+Xq1vIHIj5VDwdywVcK3jX5AIsIjc8eb7k7uugBp2d59ssPqwHhTVTm4y1Qf9SzJuL/I
 LynVzxnrLdfoMJXgzRCI0MCCiy+XAq4z4WWEICmSHvjg==
X-Google-Smtp-Source: AGHT+IGvNqGUcD22GbuY32UvxLww3ssQwJ1/ym4H4LCELCIWTcu0troTrAXWBZjG9qrdumj3EWniCGpldPo/WnocjZM=
X-Received: by 2002:a17:90b:3849:b0:2ee:ed1c:e451 with SMTP id
 98e67ed59e1d1-30aac1b332dmr91397a91.15.1746548256259; Tue, 06 May 2025
 09:17:36 -0700 (PDT)
MIME-Version: 1.0
From: Elisha Hollander <just4now666666@gmail.com>
Date: Tue, 6 May 2025 19:17:25 +0300
X-Gm-Features: ATxdqUFUYI5V4X0yurwMlsicoujIdaW5U0lYCVSWj_TFse_cg4JjHqPwXQqYF-A
Message-ID: <CACkyd_bN=zx1LaLnrg-U35--jzF3Q3BA6ABBokQZjLznaHcjFg@mail.gmail.com>
Subject: [PATCH v2] util/memfd: allow allocating 0 bytes
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, Elisha Hollander <just4now666666@gmail.com>
Content-Type: multipart/alternative; boundary="00000000000065c5c8063479f4df"
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=just4now666666@gmail.com; helo=mail-pj1-x102f.google.com
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

--00000000000065c5c8063479f4df
Content-Type: text/plain; charset="UTF-8"

Sorry for former patch something is messed up with my email.

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
- void *ptr;
+ void *ptr = NULL;
     int mfd = qemu_memfd_create(name, size, false, 0, seals, NULL);

     /* some systems have memfd without sealing */
@@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size,
unsigned int seals,
         }
     }

- ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
- if (ptr == MAP_FAILED) {
- goto err;
+ if (size != 0) {
+ ptr = mmap(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);
+ if (ptr == MAP_FAILED) {
+ goto err;
+ }
     }

     *fd = mfd;
--
2.30.2

--00000000000065c5c8063479f4df
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Sorry for former patch something is mes=
sed up with my email.</div><div dir=3D"auto"><br></div>Signed-off-by: donno=
2048 &lt;<a href=3D"mailto:just4now666666@gmail.com">just4now666666@gmail.c=
om</a>&gt;<div dir=3D"auto">---</div><div dir=3D"auto">=C2=A0util/memfd.c |=
 10 ++++++----</div><div dir=3D"auto">=C2=A01 file changed, 6 insertions(+)=
, 4 deletions(-)</div><div dir=3D"auto"><br></div><div dir=3D"auto">diff --=
git a/util/memfd.c b/util/memfd.c</div><div dir=3D"auto">index 8a2e906..e96=
e5af 100644</div><div dir=3D"auto">--- a/util/memfd.c</div><div dir=3D"auto=
">+++ b/util/memfd.c</div><div dir=3D"auto">@@ -108,7 +108,7 @@ err:</div><=
div dir=3D"auto">=C2=A0void *qemu_memfd_alloc(const char *name, size_t size=
, unsigned int seals,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int *fd, Error **er=
rp)</div><div dir=3D"auto">=C2=A0{</div><div dir=3D"auto">-    void *ptr;</=
div><div dir=3D"auto">+    void *ptr =3D NULL;</div><div dir=3D"auto">=C2=
=A0 =C2=A0 =C2=A0int mfd =3D qemu_memfd_create(name, size, false, 0, seals,=
 NULL);</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =
=C2=A0/* some systems have memfd without sealing */</div><div dir=3D"auto">=
@@ -131,9 +131,11 @@ void *qemu_memfd_alloc(const char *name, size_t size, =
unsigned int seals,</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=A0}</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">-    ptr =3D mmap(0, size, PROT_READ | PROT_WRITE=
, MAP_SHARED, mfd, 0);</div><div dir=3D"auto">-    if (ptr =3D=3D MAP_FAILE=
D) {</div><div dir=3D"auto">-        goto err;</div><div dir=3D"auto">+    =
if (size !=3D 0) {</div><div dir=3D"auto">+        ptr =3D mmap(0, size, PR=
OT_READ | PROT_WRITE, MAP_SHARED, mfd, 0);</div><div dir=3D"auto">+        =
if (ptr =3D=3D MAP_FAILED) {</div><div dir=3D"auto">+            goto err;<=
/div><div dir=3D"auto">+        }</div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=
=A0}</div><div dir=3D"auto"><br></div><div dir=3D"auto">=C2=A0 =C2=A0 =C2=
=A0*fd =3D mfd;</div><div dir=3D"auto">--</div><div dir=3D"auto">2.30.2</di=
v></div>

--00000000000065c5c8063479f4df--

