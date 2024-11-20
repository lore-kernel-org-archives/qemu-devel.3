Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3C7D7877B
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 15:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tE8kL-0007J9-9b; Thu, 21 Nov 2024 10:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asif.haswarey@gmail.com>)
 id 1tDtNi-0006HV-L7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 17:41:06 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asif.haswarey@gmail.com>)
 id 1tDtNg-00010G-T7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 17:41:06 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so250184a12.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 14:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732142462; x=1732747262; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mafJwJ/pYYRAMwCRgKj+42+khOYMNWIA8GV5f5g0fBU=;
 b=N0R66c7+H62VBRe/SVPij72uYGyRt3hD8bfiCOUvj5UAZ33bpKAzwp0GaJ06I7Dy4q
 aJGbJS6gmtbWc4MnQ9dk0X0+73s80IkaT2DJq6141bCAbHrTfRmYRDmHgJ/7oH4x4P22
 t+Uedp3q/YJ4TPRDp541v2/T5zNu2UzhoSe3T5xoFj7FLhk5il4CAFN5T33gU/LtGPhm
 g7DxbHZH0Tsau08aMRZ7y/qGP9bY7j8RTuCtsL9CBI98QpgdQbvcUSDatraupY6BNxD4
 v4j5F8HHDYmS3qxQ6SHb5gZfsanSSlPKmno/BcTIAR/MpX8KWpyG3FvBRTpgd0AyYd7k
 8RlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732142462; x=1732747262;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mafJwJ/pYYRAMwCRgKj+42+khOYMNWIA8GV5f5g0fBU=;
 b=czfZbDgTNyFqi2Xy0jgLqcyifhmE8hCiJNsFc+kVrB9j7Ky0feKdbR7veJ3tKsc4hi
 RxkV9bZsXXFoYeInIcmK0i/mZmsrjs8llRnWtFlfXyQ7scMZoIMa0ypx5+gFYVJPHaA9
 jY8AeZhosEfc+DSWtVNJet11+jOGa8cYLondeiZGSUPTsF64NAFg53wwk9sZoK0OdGtJ
 UjN8a4LpaqTjHw0Itu+APn65pYAbmTYEWa2Q7A5Zg8vBK9H35hmlWNxGc0MH8Q5Zp23u
 fpmzGHxZMMpQUB1J8lsWJGjQpAaB9qWy+SfWabbjJj00Y6e3jXzJT3upgiLRcKTeeWr4
 sMfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUshqvapiAMLg0ZhcUfv0OUJlcuv8cmlTUfFq/2DIBWUp98n1z0m0+/MIMMF4nq4YUrl6R2EqPZkrfe@nongnu.org
X-Gm-Message-State: AOJu0YyFqWz0m4bFUZbDbo4+6VQb/qJaMhkDipgmMrz1mzrTj11TsxdL
 UiGvA5wIzLg1snHMmgT7uDwijDuQ64j6nWd2XOWdlXF2osKBvySgaeebyr36wdmKyDOaEWRnZgE
 1dHAZYeNtRc1If+qjv52G4pmLmXs=
X-Google-Smtp-Source: AGHT+IFT5A6YkOqMX6gdiJUmUQ/HObWo2q5jaCGBjH6CEgPCWvJeej5tOObn8cmt/CUByZbnK0GRzf/7/AsqSMPp3dE=
X-Received: by 2002:a05:6402:350f:b0:5cf:1b53:1bf4 with SMTP id
 4fb4d7f45d1cf-5cff4c99c53mr2895470a12.17.1732142461751; Wed, 20 Nov 2024
 14:41:01 -0800 (PST)
MIME-Version: 1.0
From: Asif <asif.haswarey@gmail.com>
Date: Wed, 20 Nov 2024 14:40:45 -0800
Message-ID: <CAOzwu7cgeUmy_kxrTXS5Emi8ZmNK7JHUyXKXEXz7_hHG-VVNwQ@mail.gmail.com>
Subject: Missing PDF file download.
To: "stefanha@gmail.com" <stefanha@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000022187106275fd879"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=asif.haswarey@gmail.com; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 21 Nov 2024 10:05:28 -0500
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

--00000000000022187106275fd879
Content-Type: text/plain; charset="UTF-8"

Hi Stefan!

First off, thank you for your awesome blog!

Secondly, you have broken links on you page:
QEMU Internals: Big Picture Overview
<https://blog.vmsplice.net/2011/03/qemu-internals-big-picture-overview.html>

Broken Link:
Jan Kiszka's Linux Kongress 2010 presentation on the Architecture of the
Kernel-based Virtual Machine (KVM)
<http://www.linux-kongress.org/2010/slides/KVM-Architecture-LK2010.pdf>.
Very good material.

Thanks again for all your material!
_
Asif

--00000000000022187106275fd879
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:monospac=
e,monospace">Hi Stefan!</div><div class=3D"gmail_default" style=3D"font-fam=
ily:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace,monospace">First off, thank you for your awesome blog!<=
/div><div class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
><br></div><div class=3D"gmail_default" style=3D"font-family:monospace,mono=
space">Secondly, you have broken links on you page:<br><a href=3D"https://b=
log.vmsplice.net/2011/03/qemu-internals-big-picture-overview.html">QEMU Int=
ernals: Big Picture Overview</a></div><div class=3D"gmail_default" style=3D=
"font-family:monospace,monospace"><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:monospace,monospace">Broken=C2=A0Link:<br>Jan Kiszka&#39=
;s Linux Kongress 2010 presentation on the <a href=3D"http://www.linux-kong=
ress.org/2010/slides/KVM-Architecture-LK2010.pdf">Architecture of the Kerne=
l-based Virtual Machine (KVM)</a>. Very good material.</div><div class=3D"g=
mail_default" style=3D"font-family:monospace,monospace"><br></div><div clas=
s=3D"gmail_default" style=3D"font-family:monospace,monospace">Thanks=C2=A0a=
gain for all your material!</div><div class=3D"gmail_default" style=3D"font=
-family:monospace,monospace">_</div><div class=3D"gmail_default" style=3D"f=
ont-family:monospace,monospace">Asif</div></div>

--00000000000022187106275fd879--

