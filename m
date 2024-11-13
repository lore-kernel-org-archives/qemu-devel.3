Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CD6D637A6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHq0-0000V2-C2; Wed, 13 Nov 2024 13:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1tBHpy-0000UN-N9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:11:30 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <randrianasulu@gmail.com>)
 id 1tBHpx-0001AX-6c
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:11:30 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso80786455ad.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731521487; x=1732126287; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WzGULHODnNpfjTdySYaaqQ3uIVdkpgbBDUqsLXxl1XU=;
 b=JxC/0PSL4bAhsD32nMjPwtqCS+RU1Fm/Le0/ME0T21OHagVmSGh8xJOnD5u2pFS7e1
 ia3Aso+ABxhLOadeOCp0BfKDc23aUeEvpzVuyu+2xPjs7uZQozAJta1PMCWZSMAvP734
 KGrq9SYOmVoNLzSxKC38Piikxqoe3H7NqPLM4sgrzBR2SEnOzDyS44pAsqi9VmkrPlKE
 8twRw2gQncdOLYQNIgmwTE0nAwEhdjLmbkfM/9WXeF4mMI40ZDZACRmT5DnWwdhEJI93
 T8DoXhAwfd64ckx0nZi8C7wmr3QWGesw9mV3SWj+nK6GWogIq5Uui9VmRicUQZcC3Lfl
 3HGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731521487; x=1732126287;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WzGULHODnNpfjTdySYaaqQ3uIVdkpgbBDUqsLXxl1XU=;
 b=jbV6NpAeDKT6nToBOOGxfdK4MUFLVXYaDYscVtsTHtjM+XqlAhI/TviOL5eJiIWCMZ
 mL99gkk+1cwYuvo0+KB9BGo27fnUklk5XWCz/iGfbakqAaneinvGG0Qf7N57IYe1XqzJ
 hg/FkwsckmWvfRzdIDh+4U6kFhHTXpYF+NSm3C6g6lrBVV4pcXTDlOyqqZEh4YWxa9l/
 HiderHC3Nd4uc9q4T6x26LJ8HVwTuQ2CV9cKdEWMD2SnmPBvMe2AVt1zlBPnq/rrEmsO
 M7cZhZobIPuKqXLtvAQnglrCXbiWc11ImWUQbXqi04uKrzKWj8TJ8n0A/S8xOQVN/U8a
 mbHg==
X-Gm-Message-State: AOJu0Yzk39H/PR//oG/ZJuyY/enIo85dpAEL8Fv6v1zhTpbgy3AqSU/H
 a94ES8yL/ei8WMYeKsrTQ2o+aqEOzkPl+EiKGJjWDdb/gdySZT5nWGe3RfAN9KQK9377rW5zWCa
 hGIFiB9ZthM4RzW5Eo2NkN4MtJ/rQICXoK2w=
X-Google-Smtp-Source: AGHT+IHCAK9JFrgSUbjDWtqfeKxqvo2pFVSenVK9Bz/y6r9swTs8lnpXN66F5edhzDm9pbSPVWd5lHPPGFz6g904Wmk=
X-Received: by 2002:a17:903:1247:b0:20c:79bf:6793 with SMTP id
 d9443c01a7336-211834de5afmr294056965ad.3.1731521487075; Wed, 13 Nov 2024
 10:11:27 -0800 (PST)
MIME-Version: 1.0
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Wed, 13 Nov 2024 21:20:03 +0300
Message-ID: <CA+rFky6jM9gKvgvy5BTR9CLOOAv+KycZORiu=3udwrFCZAE=6g@mail.gmail.com>
Subject: qemu-systems-sparc can't do 1152x900 ?
To: QEMU <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="0000000000002880ac0626cf4339"
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=randrianasulu@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--0000000000002880ac0626cf4339
Content-Type: text/plain; charset="UTF-8"

Was trying to figure out if my glitches at [1] due to wrong resolution
tried to start
qemu like this:

qemu-system-sparc -g 1152x900
qemu-system-sparc: Unsupported resolution: 1152 x 900

ow?

in source

hw/sparc/sun4m.c (git commit f0cfd067867668870931c9411d96cd518564b7a8)

           if (!(graphic_width == 1024 && graphic_height == 768) &&
                !(graphic_width == 1152 && graphic_height == 900)) {
                error_report("Unsupported resolution: %d x %d",
graphic_width,
                             graphic_height);
                exit(1);
            }

may be && should be || ?

[1] - https://gitlab.com/qemu-project/qemu/-/issues/2674

--0000000000002880ac0626cf4339
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Was trying to figure out if my glitches at [1] due to=
 wrong resolution tried to start</div><div>qemu like this:</div><div><br></=
div><div>qemu-system-sparc -g 1152x900<br>qemu-system-sparc: Unsupported re=
solution: 1152 x 900</div><div><br></div><div>ow?</div><div><br></div><div>=
in source</div><div><br></div><div>hw/sparc/sun4m.c (git commit f0cfd067867=
668870931c9411d96cd518564b7a8)<br></div><div><br></div><div>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0 if (!(graphic_width =3D=3D 1024 &amp;&amp; graph=
ic_height =3D=3D 768) &amp;&amp;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 !(graphic_width =3D=3D 1152 &amp;&amp; graphic_height =3D=
=3D 900)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 erro=
r_report(&quot;Unsupported resolution: %d x %d&quot;, graphic_width,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0graphic_height);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 exit(1);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 }</div><div><br></div><div>may be &amp;&amp; should be || ?</div><di=
v><br></div><div>[1] - <a href=3D"https://gitlab.com/qemu-project/qemu/-/is=
sues/2674">https://gitlab.com/qemu-project/qemu/-/issues/2674</a></div></di=
v>

--0000000000002880ac0626cf4339--

