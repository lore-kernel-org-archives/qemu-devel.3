Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D99D3C91A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTLl7-0003dz-Kr; Wed, 10 Dec 2025 10:05:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1vTAFV-0005i3-Mv
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 21:48:17 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1vTAFU-0007la-3o
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 21:48:17 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29555415c5fso72745265ad.1
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 18:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765334894; x=1765939694; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=hMplGQ8TAlq5d2JpG55V/7VLf5BIxQHExdh5XTme4sg=;
 b=IxGNfPEfqoiG72UaqZ6YVhsDkL1fcbToU7lIc3bQhBTKusxS1N7RbpwQcJ9km0+XSa
 cA/BS11uByv9+1D9hcjYh1N57mG2k9emBxKuOuTJAYqOzGJQX8CkVLpGGWoxAra4UQ/n
 uwJmmn4cF5tp58N3ugQ2jcNAipCaK/DEOJgRmsybtyfT3I/BZb+YXHQ/yg/bVCP6q7GQ
 6EwDjo6eglEOI4h1k9pcc4fSQMZy8OsW4Iz0pP17oQUHsZYOgJv/0hYulbB2KBk2YjZi
 fLDFv4U5fUWPZjQ+zP+PliT7aGVWhPf9a1BxGLAYrLLibqwIJ1OloUABRtewnOSfJEx6
 rx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765334894; x=1765939694;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hMplGQ8TAlq5d2JpG55V/7VLf5BIxQHExdh5XTme4sg=;
 b=rc3cvqBsmwvLjdh8BHjLVYxoAorr5sxoatD1CdR8BAYLVvqxny/CAoxgGMmH2finqw
 +ZXooFDJaNmaN3mQX/Tw66H7Rr3OnO068JUfs0gT9xZkT3xjyCEouLGVu/PXuTpZX8Ou
 dlrcy295MbtMyQHh5tTu8dOX4Mx7apPCdhjj21ax+dSrh9fbgRvEcSGQv7ijT2BUwxsA
 PC9O9COZL+NyIIImEq9W2CTv+wEYLxPc4vE9gY/kob4acYIxA+kXRmdr6iAtTM6+w2Bg
 PwlxHQu25L1EQ12jPIWLk2JhizuMAPeFbRvRBtg8xCJ8qWPunJN+YJkPhz2ZXI35/nCt
 qYbg==
X-Gm-Message-State: AOJu0YzgFhciuTaYGB65t/LEOsGqtdyuNwyI2QrGq0HS3BDBqAiUuhWd
 xRUiIPOuSJSKYVfwOJeXY5KHgfSTGlKbC+OsYy7A+gbQSxubm1TAHowgkY6DKCf6dd7iF8Kf5By
 d0rJegGVW95MIHMJ7yDVcRIVCAMGzAu6FzCmYnKuatEg=
X-Gm-Gg: ASbGnctrmaEHcHPGyi9ICayKdrdKP+wDBkC35be97kPwwL5+DVtRH1HCp1VAY5aUzrO
 LUCSdJvfVw6sMc+0zgRjbAd2OuzBXJVnaTxo1Ydm+dm4SNJc1fHzFv5uI0lEBPEiJ8R2ZhAlur5
 GGvhzF9UoGO/5c4vpoNQRN+7Prx5xHE28OCL8eh5nNKrQWtZZuCY6/Xczu+pxEoJ/vOvPqB1Lsd
 6aXHKHwjO0Dbs8sHpWvP/GYQuM/fJ5hmv47kr1RtWfYk8o1l2KPabM05v2xRWI0zirb6fu0DhNe
 VhY585rrmE8kTAy+FaXwRWh4/to=
X-Google-Smtp-Source: AGHT+IG6ZPLayUKo5SkMUhWASW8MGuC0pp5TqStWWtebBSedAoUQiWL4hRaJarOxnssIf7kDsJ0a2SXWVO36pcA6ziU=
X-Received: by 2002:a05:6a20:918f:b0:366:14ac:e1d7 with SMTP id
 adf61e73a8af0-366e31b504cmr842104637.61.1765334893654; Tue, 09 Dec 2025
 18:48:13 -0800 (PST)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Wed, 10 Dec 2025 02:48:03 +0800
X-Gm-Features: AQt7F2qIcotGGyEluxsW9kUWilYLp3rskbaHV0ckDPUI_YwOM6tGCp1iPVQZths
Message-ID: <CAOYM0N3YdrkhOXrpxE6rzk5DbLOF0GzEVaThAHxnHfQYLk+pzQ@mail.gmail.com>
Subject: make pxerom report error
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003ef4430645900f5f"
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=liu.jaloo@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 10 Dec 2025 10:05:38 -0500
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

--0000000000003ef4430645900f5f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

$ cd qemu
$ git submodule update --init roms/ipxe
$ cd roms
$ make pxerom

report error like this:


> In file included from tests/bigint_test.c:38:
> tests/bigint_test.c: In function =E2=80=98bigint_test_exec=E2=80=99:
> tests/bigint_test.c:232:14: error: =E2=80=98result_raw=E2=80=99 may be us=
ed uninitialized
> [-Werror=3Dmaybe-uninitialized]
>   232 |         ok ( memcmp ( result_raw, expected_raw,
>       \
>       |
>  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   233 |                       sizeof ( result_raw ) ) =3D=3D 0 );
>       \
>       |                       ~~~~~~~~~~~~~~~~~~~~~~~
> include/ipxe/test.h:45:19: note: in definition of macro =E2=80=98okx=E2=
=80=99
>    45 |         test_ok ( success, file, line, #success )
>       |                   ^~~~~~~
> tests/bigint_test.c:232:9: note: in expansion of macro =E2=80=98ok=E2=80=
=99
>   232 |         ok ( memcmp ( result_raw, expected_raw,
>       \
>       |         ^~
> tests/bigint_test.c:565:9: note: in expansion of macro =E2=80=98bigint_ad=
d_ok=E2=80=99
>   565 |         bigint_add_ok ( BIGINT ( 0x8a ),
>       |         ^~~~~~~~~~~~~
> In file included from tests/bigint_test.c:36:
> include/string.h:32:19: note: by argument 1 of type =E2=80=98const void *=
=E2=80=99 to
> =E2=80=98memcmp=E2=80=99 declared here
>    32 | extern int __pure memcmp ( const void *first, const void *second,
>       |                   ^~~~~~
> tests/bigint_test.c:213:17: note: =E2=80=98result_raw=E2=80=99 declared h=
ere
>   213 |         uint8_t result_raw[ sizeof ( expected_raw ) ];
>      \
>       |                 ^~~~~~~~~~
> tests/bigint_test.c:565:9: note: in expansion of macro =E2=80=98bigint_ad=
d_ok=E2=80=99
>   565 |         bigint_add_ok ( BIGINT ( 0x8a ),
>       |         ^~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile.housekeeping:943: bin/bigint_test.o] Error 1
> make[1]: Leaving directory '/home/jaloo/slackware/qemu/qemu/roms/ipxe/src=
'
> make: *** [Makefile:126: build-pxe-roms] Error 2

--0000000000003ef4430645900f5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>$ cd qemu</div><div>$ git submodule update --init rom=
s/ipxe<br>$ cd roms<br>$ make pxerom</div><div><br></div><div>report error =
like this:</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">In file included from tests/bigint_test.c:38:<br>tests/bigint_test.=
c: In function =E2=80=98bigint_test_exec=E2=80=99:<br>tests/bigint_test.c:2=
32:14: error: =E2=80=98result_raw=E2=80=99 may be used uninitialized [-Werr=
or=3Dmaybe-uninitialized]<br>=C2=A0 232 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ok ( =
memcmp ( result_raw, expected_raw, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~<br>=C2=A0 233 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof ( result_raw ) =
) =3D=3D 0 ); =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 \<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~~~~~~~~~~~~~~~~~~~~~~<br>include/ipxe/=
test.h:45:19: note: in definition of macro =E2=80=98okx=E2=80=99<br>=C2=A0 =
=C2=A045 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_ok ( success, file, line, #succ=
ess )<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 ^~~~~~~<br>tests/bigint_test.c:232:9: note: in expansi=
on of macro =E2=80=98ok=E2=80=99<br>=C2=A0 232 | =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 ok ( memcmp ( result_raw, expected_raw, =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~<br>tests/bigint_test.c:565:9: note: in=
 expansion of macro =E2=80=98bigint_add_ok=E2=80=99<br>=C2=A0 565 | =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 bigint_add_ok ( BIGINT ( 0x8a ),<br>=C2=A0 =C2=A0 =C2=
=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~~<br>In file included from te=
sts/bigint_test.c:36:<br>include/string.h:32:19: note: by argument 1 of typ=
e =E2=80=98const void *=E2=80=99 to =E2=80=98memcmp=E2=80=99 declared here<=
br>=C2=A0 =C2=A032 | extern int __pure memcmp ( const void *first, const vo=
id *second,<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~<br>tests/bigint_test.c:213:17: note: =E2=
=80=98result_raw=E2=80=99 declared here<br>=C2=A0 213 | =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 uint8_t result_raw[ sizeof ( expected_raw ) ]; =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>=C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~<br>tests=
/bigint_test.c:565:9: note: in expansion of macro =E2=80=98bigint_add_ok=E2=
=80=99<br>=C2=A0 565 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 bigint_add_ok ( BIGINT (=
 0x8a ),<br>=C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 ^~~~~~~~~~~~=
~<br>cc1: all warnings being treated as errors<br>make[1]: *** [Makefile.ho=
usekeeping:943: bin/bigint_test.o] Error 1<br>make[1]: Leaving directory &#=
39;/home/jaloo/slackware/qemu/qemu/roms/ipxe/src&#39;<br>make: *** [Makefil=
e:126: build-pxe-roms] Error 2</blockquote></div>

--0000000000003ef4430645900f5f--

