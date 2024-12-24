Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03C9E7718B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 03:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPvZ3-0008HU-O2; Mon, 23 Dec 2024 22:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tPvZ1-0008H4-Hi
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 22:26:31 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liu.jaloo@gmail.com>)
 id 1tPvYz-00067y-VX
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 22:26:31 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3023c51146cso48608901fa.1
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2024 19:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1735010787; x=1735615587; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=/5ed/AUx/r86xaMHzNN8NfUeD7Wmm529FPieMUGAPZ8=;
 b=cM9v+hsNbRApgrPiC2yzNxxdc4MKc9Zp+dOTvYRXtMPaCLMjGrX4ZLAK9ihuGbuEDo
 /nyZ3X8CObs+SgaPq80aG+ehPJ0iG7i96cO2FnXlHXM/MDTpdxzFYmazmx3SJr1Uddgz
 ODClqu0nJtsyjfDUWckOs72iLWDOz8kQlGD/A0tJKdhk8ihVqmqC7r9BjthBkJijKv75
 cxc2DPa3O2l34dFVvRgeu7oN7JzfBYT3+6qxGKMvt1U1w7o+k24MVJAh0EkXoaBbjkZ1
 k739ZiXkNbjFbEJd1c5DL1r+RRsaCTks5G8MeGOS2S9yGkNybmSAvyHmwmW2eyjOvDHe
 Zvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735010787; x=1735615587;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/5ed/AUx/r86xaMHzNN8NfUeD7Wmm529FPieMUGAPZ8=;
 b=m2KXQp4w4BiRKn2wGJKJNfpNdNsNY81af4+8wMWsxBbN+wtX3k40BdlbS9heTfosq0
 uRp1MsArOenKbmu8AvD9fq/uYRidL5D1h80Cj0ehotcLtvaB6HXF03QFFRX1deKiSLAV
 +LoKaQeIf8a20hy+yLPhCoVONlvo66GwmoQ2wk4K8buZS4/noGAVxHVXhqgGHNhXOrIj
 jRTvNgAe37hFtT21zz1LMFZCHcgye2fLmGBgOFTIeeLOIPhOClxwsU2rpBZ7HSif5obF
 fb1jFt/RfDjEivGRmfSSYo0YuQ2oSg4q1JzZR4SURBnHxT6czciFSrjcQISwEUBkJn3Y
 jC7w==
X-Gm-Message-State: AOJu0Yy6ftVQrainmMIWyTTDNj6ONcYLKkejN0c1YF3QlfouW3lrXXZ2
 31ZwulLB8rlzMrqvk5ebLpPUYrynSsqEJRlbzdiLa8ahmknzTxOgTcuVuDIkbF9EsLdKSLymv6X
 +jhI/STpliMYavVI/fjL8PIIrAz0oreVuFta3BXvvvw==
X-Gm-Gg: ASbGncsL4eQYIVNTYndX8eh04YjHhHa0EcAYsY+2Dggxr0m6zCrd/eBscVa0ds86rSx
 OrTgzZknr3cyg1YawNgtCMTcKUuYlxbXpXOiWyho=
X-Google-Smtp-Source: AGHT+IH6i2taasv9mcXV27Tw/lWxA3ov0G16BOmwJWg27DhNdTkhjFVH41y79HC0HOXqYtU+Gkj5WCQ/ctmZb/Ln6a4=
X-Received: by 2002:a05:651c:2118:b0:302:23bd:354b with SMTP id
 38308e7fff4ca-30458337837mr65049121fa.1.1735010786478; Mon, 23 Dec 2024
 19:26:26 -0800 (PST)
MIME-Version: 1.0
From: Liu Jaloo <liu.jaloo@gmail.com>
Date: Tue, 24 Dec 2024 11:27:36 +0800
Message-ID: <CAOYM0N1sbP=xRfNPaNK6ZzzhD3A-5PKimaeSrDzXHGxAYH3oCQ@mail.gmail.com>
Subject: macaddr: ignore the checking from index to 0xFF
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009c13180629fbad32"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=liu.jaloo@gmail.com; helo=mail-lj1-x235.google.com
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

--0000000000009c13180629fbad32
Content-Type: text/plain; charset="UTF-8"

bash-5.1$ git diff net/net.c
diff --git a/net/net.c b/net/net.c
index c1bb19a523..af68029428 100644
--- a/net/net.c
+++ b/net/net.c
@@ -173,6 +173,7 @@ static void qemu_macaddr_set_used(MACAddr *macaddr)
     for (index = 0x56; index < 0xFF; index++) {
         if (macaddr->a[5] == index) {
             mac_table[index]++;
+           return;
         }
     }
 }
@@ -188,6 +189,7 @@ static void qemu_macaddr_set_free(MACAddr *macaddr)
     for (index = 0x56; index < 0xFF; index++) {
         if (macaddr->a[5] == index) {
             mac_table[index]--;
+           return;
         }
     }
 }

--0000000000009c13180629fbad32
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">bash-5.1$ git diff net/net.c<br>diff --git a/net/net.c b/n=
et/net.c<br>index c1bb19a523..af68029428 100644<br>--- a/net/net.c<br>+++ b=
/net/net.c<br>@@ -173,6 +173,7 @@ static void qemu_macaddr_set_used(MACAddr=
 *macaddr)<br>=C2=A0 =C2=A0 =C2=A0for (index =3D 0x56; index &lt; 0xFF; ind=
ex++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (macaddr-&gt;a[5] =3D=3D in=
dex) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mac_table[index]+=
+;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br>@@ -188,6 +189,7 @@ s=
tatic void qemu_macaddr_set_free(MACAddr *macaddr)<br>=C2=A0 =C2=A0 =C2=A0f=
or (index =3D 0x56; index &lt; 0xFF; index++) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (macaddr-&gt;a[5] =3D=3D index) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0mac_table[index]--;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0}</div>

--0000000000009c13180629fbad32--

