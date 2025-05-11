Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66483C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 17:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEAa8-0002kP-32; Sun, 11 May 2025 13:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uEAa6-0002fe-7t
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:35:18 -0400
Received: from mail-yw1-x1141.google.com ([2607:f8b0:4864:20::1141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1uEAa4-0007LY-Dh
 for qemu-devel@nongnu.org; Sun, 11 May 2025 13:35:17 -0400
Received: by mail-yw1-x1141.google.com with SMTP id
 00721157ae682-703cd93820fso33384087b3.2
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 10:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746984915; x=1747589715; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Od/bYHMkqh8HuPtuVnhFKddGUAN3J22K/RqW7t69+ks=;
 b=CRzK6CTMNFvzXc2/LdT44RpxyOq5MRiSPpmuSZEEVmwOv1JDpNMyrvkb7ct2OldIrE
 LHIB13KTm2wu246nliJ9g5H2S7xA3kqZ4fP9Kgu/FCkEsVKgK4apz7NgYneqs5pmGDyY
 BRCYmckO4SzheobtVkwOQrOSI+EWdgOLAwqUuKSx3VDnibVIuOXebnwNJuPjM6sLH6DT
 gK5S1Dyb5iWUjWvPxPja0+VMSV1maJEgboZXu1mj+GvkJqcSVnvA9i5ss0zkG1ZUyhPg
 YM8+42oPyYVIi7z8gmVz+RZ7s4879u58lrq+900CPyhRYEV0QaiyFKVtosY4sEL2mOyx
 JauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746984915; x=1747589715;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Od/bYHMkqh8HuPtuVnhFKddGUAN3J22K/RqW7t69+ks=;
 b=TMIA+mUDKjSv4TK13IPl4vCOjTlBI7v/eEOVi319fX2tGHDnlBYoRc9W+K4yNG6+A6
 pr5Am7IK9/XMRXUuijgfs2pdZKQknrY4+nejVvJkGxg9OwOCrKJNhEPjbIyCwFMn486V
 Yya3VXq74W8MRlA1F5FVpoM76l8rGR0lK9m6NcY3NmOI6+L75z+OukZdqLKBF0kzsdjX
 A8InmMD286HZjKpgpR+MPY9PZCXNS1QqDP1EuUlFrEcfRru+5iUINvzUGlf0G681V7M7
 eEgNsQw+vQ1n7l+8dl8Hm7jr/M3NT8O3rfwfFZBXha+hjTV3YjZj0tR0VPOcy1OJuK4i
 sbSw==
X-Gm-Message-State: AOJu0YzrK+m259RNaay1BzTy1TG0xOJL8HO4AncdC7wGVB3pHAs2QWz/
 N47TbgGSYPXD2HuyTq6Oj6ZZ29KX+LbLmYJMMR5nar377Wv/UxLzc/IVRqsVsHTmFi71s8h4gsf
 2QacqOO7kbJt8CJ+wGI9pGXOx3GB/zpkKwJHMuw==
X-Gm-Gg: ASbGncuJi+6ezMMdTo/Q2GfHAqq+bAz55FprJiOMZSLuFoF1qBwcfyQ6S7gWfw88Pib
 hxCsKGMoR3jYUW+/axvoOb+RNRuskenU85x64vM9Hy4/JqjUpyx8LNqRd8R8HvaCUB+QFUJIYVL
 L30HGNx1XDFXcFurjw0h0TOmKWwNrpsGXlod3xggCS2nRo
X-Google-Smtp-Source: AGHT+IFHQQYYnY16l86pBDySvBksi2dWW06zp1gjnBuv1S+Af9MYKMHn3zQYHyqGjNS4/6XVlOFc8rT831f2Ji6sJ1k=
X-Received: by 2002:a05:690c:3341:b0:6fe:aa66:5d82 with SMTP id
 00721157ae682-70a3fa40be7mr144168467b3.19.1746984914518; Sun, 11 May 2025
 10:35:14 -0700 (PDT)
MIME-Version: 1.0
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Date: Sun, 11 May 2025 23:05:03 +0530
X-Gm-Features: AX0GCFt-xqInsJ1qV0lObN8nBm5woqev06TjMp_yHA3IZzR3DU3EHrDEVE5GVIo
Message-ID: <CAGkZZ+ttRPMmK9ynnwvNE32z3ayGqH-DDcq0_DUrJoc0Da6N6Q@mail.gmail.com>
Subject: GSoC Intro: Soumyajyotii Ssarkar, working on Implementing LASI
 Network Card & NCR710 SCSI Controller Device Models
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000420da10634df9f0d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1141;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-yw1-x1141.google.com
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

--000000000000420da10634df9f0d
Content-Type: text/plain; charset="UTF-8"

Dear QEMU Developers,
I am Soumyajyotii Ssarkar, a sophomore Computer Science student from India.
It is truly an honor for me to be a part of this community. I look forward
to a productive summer with our community.

For the first half of my summer, I will be working on thoroughly testing
and debugging the current LASI Network Card implementation in QEMU and
adding missing code.
For the second half of my summer, I will be working on the NCR710
implementation taking the current NCR710 implementation from WinUAE which
was ported to QEMU by Helge Deller(my Mentor) as an inspiration and
building upon it. Refining both of them to reach upto QEMU standards,
I plan to keep you all in the loop with updates every alternate week, and
to be in constant touch with my mentor every week keeping them up to date
with my project progress.

I humbly appreciate the community's work in bringing such a wonderful
software into reality and I am greatly honored to work among you all, to
further enhance QEMU this summer.
Thanking You,
Soumyajyotii Ssarkar.

--000000000000420da10634df9f0d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear QEMU Developers,<div>I am Soumyajyotii Ssarkar, a sop=
homore Computer Science student from India. It is=C2=A0truly an honor for m=
e to be a part of this community. I look forward to a productive summer wit=
h our community.</div><div><br></div><div>For the first half of my summer, =
I will be working on thoroughly=C2=A0testing and debugging the current LASI=
 Network Card implementation in QEMU and adding missing code.</div><div>For=
 the second half of my summer, I will be working on the NCR710 implementati=
on taking the current NCR710 implementation from WinUAE which was ported to=
 QEMU by Helge Deller(my Mentor) as an inspiration and building upon it. Re=
fining both of them to reach upto QEMU standards,</div><div>I plan to keep =
you all in the loop with updates every alternate week, and to be in constan=
t touch with my mentor every week keeping them up to date with my project p=
rogress.</div><div><br></div><div>I humbly appreciate=C2=A0the community&#3=
9;s work in bringing such a wonderful software into reality and I am greatl=
y honored to work among you all, to further enhance QEMU this summer.</div>=
<div>Thanking You,</div><div>Soumyajyotii Ssarkar.</div></div>

--000000000000420da10634df9f0d--

