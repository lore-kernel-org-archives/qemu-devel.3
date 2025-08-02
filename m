Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4E4C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 17:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiFaO-0003qe-40; Sat, 02 Aug 2025 12:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ballofenergy11@gmail.com>)
 id 1uiFMN-0006d2-VS
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 12:45:40 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ballofenergy11@gmail.com>)
 id 1uiFML-0002Fa-91
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 12:45:27 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-88bc56adaa4so614184241.0
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 09:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754153123; x=1754757923; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LdIBK9+P8TTtd9hm4IMkGKGpI5WScfW3/ijntL5sdcc=;
 b=Lf8O4c2nrF4oOpjAlR5n+4wyqhUc80p0lsLsj59p3pnObR/RSBV4+otxU8EUledTxM
 T5YkeKAv0UJBl1ejUHBnZwN+r2ngJ2y6+2+tZwO0MY21dLKSsc2eO7qGYSIR421fujqP
 X3l9uUZ3AhRVkbNQloc0Miwx3qNDlOiI/BLtJ49nWpOy/8Brjfg+g8UjcTFqu8Leqib2
 VhrRJOqiajAz61PizgQdNCmoXcw0HWZeRl6WyA80FJpn9LbpTaa9gaRM0khcK2lcp19y
 gjY7LyLvsGZBoUv01GlNpM581KPwfBYPDRAM0sWv8KWV4pNd3viccpmAiFq5jLCwoV9L
 Ftig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754153123; x=1754757923;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LdIBK9+P8TTtd9hm4IMkGKGpI5WScfW3/ijntL5sdcc=;
 b=UOv9WjRKBUIDitiizDQtCAQRcnJh/hqXmFuyVzX28rVYo8uX5Q8b/Vw1qvzxC1p9ez
 ahPuBmwL5WobmT7FyqgAFMGiDZuWvRqi36VET0YZxlEdPkjMECErWpfpkt1J72Yqs19y
 9nSquJlmvHq46H32yd3ITe+u6vX0srN1im8mP93fhB7qvZddLH5QxXEWE33FwdlN+Tnv
 bciuEIf8hs2U6Ti7kLDFHVeBOzh53ne3KlVxLZF4OQKIBwYfOghLCCbVrsklbGvp3wIw
 lWwV+X+CiQzzCrNmvvUe7pwHQutjpuSbhEcTSuizlzP2rhuPIaZKf/xNjJp2AJtwxXnl
 mYnw==
X-Gm-Message-State: AOJu0Yww0kjs9VL/7Ba6xLKYQUjcQGl+o8pfYoGBn0EUWjRewUCvE/F2
 QcQNscMUSeDMBv6D4apuElYmUIDGpphAmCnn4WJ5D7q4VBEHXSF/eNhX/xRcK4sU34yIwNwk7Gb
 oRoMJNvw8EkDb5eKREOgXrRiRvE5s+PGi/lga
X-Gm-Gg: ASbGncuThd+MZBVy1wtWySaPRwx+OiKFYUDiyY2XJWg7G3Ryl//182/W2BogTqAF8yK
 QWrhJTlXIk/a/j2gOJvr8lkUqUC39tigi2cDwYmnQIM1XaTJi214rWN+t+WnnsXHfTwiMElcYDh
 idiKX9H1ZBEOxmQUzZIZ+fTLzNDLaPeiBlwRbviKkxRgPpVCRqa1FmQz+dbyjOpyN90jweqZ96e
 prd6AU6EgXVnwC06zaMLYS/eg==
X-Google-Smtp-Source: AGHT+IESdeRYPH7N9BFfpOuyh4sUe8PsaVCOVO/CDZ9llag9ybRAA2dG+b1zeGilPKP9D4jvosyigxCnudIe9mu4K0k=
X-Received: by 2002:a05:6122:2a51:b0:530:7747:80a7 with SMTP id
 71dfb90a1353d-5395f31dfd5mr1714533e0c.9.1754153122533; Sat, 02 Aug 2025
 09:45:22 -0700 (PDT)
MIME-Version: 1.0
From: BallOfEnergy_ <ballofenergy11@gmail.com>
Date: Sat, 2 Aug 2025 11:45:11 -0500
X-Gm-Features: Ac12FXyWnp3twsgNsvai8WxMKE_a4QAC3mFiqwaYmVPBn2AkjW5V_OxwgcNSBDU
Message-ID: <CAN=g_Ls_H-YfomjYOyEpCTGG998=25FQCA8DEEStPQY-oWUjMw@mail.gmail.com>
Subject: Potential license violation on fork of QEMU.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c01542063b6499c2"
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=ballofenergy11@gmail.com; helo=mail-ua1-x934.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 02 Aug 2025 12:59:39 -0400
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

--000000000000c01542063b6499c2
Content-Type: text/plain; charset="UTF-8"

Hello!

I am emailing about a fork of QEMU called AQEMU (Android QEMU; not to be
confused with the more common AQEMU fork
<https://github.com/tobimensch/aqemu> made by tobimensch
<https://github.com/tobimensch>). The public GitHub repository can be found
here <https://github.com/AQEMU-dev/AQEMU>, and violates several GPLv2
license terms.

This project copies files from the original QEMU project without the proper
licensing or crediting. The project as a whole may violate sections 1, 2.a,
and 2.b of the GPLv2 license (as seen in the COPYING file inside the QEMU
repository).

I'm not sure of the actions that would need to be taken here, however the
goal is to bring this to your attention in case something needs to be done.

Thanks,
Microwave.

*Microwave* *(BallOfEnergy)*
ballofenergy11@gmail.com

--000000000000c01542063b6499c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello!</div><div><br></div><div>I am emailing about a=
 fork of QEMU called=C2=A0AQEMU (Android QEMU; not to be confused with the =
more common=C2=A0<a href=3D"https://github.com/tobimensch/aqemu">AQEMU fork=
</a>=C2=A0made by=C2=A0<a href=3D"https://github.com/tobimensch" id=3D"gmai=
l-contextregion-usercrumb-tobimensch-link" class=3D"gmail-AppHeader-context=
-item"><span class=3D"gmail-AppHeader-context-item-label">tobimensch</span>=
</a>). The public GitHub repository can be found=C2=A0<a href=3D"https://gi=
thub.com/AQEMU-dev/AQEMU">here</a>, and violates several GPLv2 license term=
s.</div><div><br></div><div>This project copies files from the original QEM=
U project without the proper licensing or crediting. The project as a whole=
 may violate sections 1, 2.a, and 2.b of the GPLv2 license (as seen in the =
COPYING file inside the QEMU repository).</div><div><br></div><div>I&#39;m =
not sure of the actions that would need to be taken here, however the goal =
is to bring this to your attention in case something needs to be done.</div=
><div><br></div><div>Thanks,</div><div>Microwave.</div><div><b><br></b></di=
v><div>
<div>
<b>Microwave</b>

<b>(BallOfEnergy)</b></div><div><a href=3D"mailto:ballofenergy11@gmail.com"=
>ballofenergy11@gmail.com</a></div></div></div>

--000000000000c01542063b6499c2--

