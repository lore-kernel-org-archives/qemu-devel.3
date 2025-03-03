Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D67EFC282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 06:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tozaE-0006GD-2g; Mon, 03 Mar 2025 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hab.gallagher@gmail.com>)
 id 1tozZf-0005VL-RI; Mon, 03 Mar 2025 01:46:47 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hab.gallagher@gmail.com>)
 id 1tozZa-0004vp-V4; Mon, 03 Mar 2025 01:46:47 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-30b9f7c4165so18619391fa.3; 
 Sun, 02 Mar 2025 22:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740984399; x=1741589199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=0up8XXJHP4h5Nsrwm+3enO66Sh/xCVaeT+8E+F4INiM=;
 b=RkeOWSNJR3ShtIev15N6lvUfwjwOeBbTehKmzfLROVhgVjCbKAfSzNKe2wFb0MnB8l
 s80gI8nlLeaJxU0+/6kPu2negTeoMzzcOhKq8kiz45gTMnQqjSNBK3pAKbCCDyX+0oj4
 qrHtM5KqzlXKsII1aGPgI1WqwBkaaHoREc40cqg0LimZeCojeauQwsq/qDfQD521m37w
 uYzb3gf9oCwUw9jcI3exZGA5HB8QEsQzNQD04IepKRF/IwXV9q6HuB7RQ7QvAuM4LKyw
 fFX90WPCnB93D5yU2vo77a+O4eg1cuOpsSlWQp9R50yOxolgO+eFYFBhz5YXMgIgD1uy
 ZYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740984399; x=1741589199;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0up8XXJHP4h5Nsrwm+3enO66Sh/xCVaeT+8E+F4INiM=;
 b=VDd9nwDvd8VzvXEsGmnEiNlSTXFiSzi6ul5UF+UpuJYowYOQkpTYGT2dcyG+Pcp1qe
 sp2k6UCMMH7kp0+IjbWGERUVEFI4oUcqDybtTdL1bVY+f4lT6sRYA3uwMPAFBjEoIers
 HJWEBLzoPrIfDqfYm07dWKF9xVeRc4LNn9SbxnGzKdKTqMalVThEDJrTTHzadPtRRroX
 rxf+17mWuFZZOvXXvRl2BaRTQ5U+UpPflUG/vqNHpAPePMv+VxygEt9Rixms20ivmTx7
 h813hIKYu9sWbDrQfuJizy+pS1pFDLWwFg71KYT3V24ih5OghhuBXgFMyAmqxCv5K7ZD
 tUiA==
X-Gm-Message-State: AOJu0YzY0mhtzaQV80U2G3RNn921s8fNeFizJFCRlNbJMT6P5lGPvQYD
 DzSF83mkvIHbZhTCTPG0E1aL2TxgDxze+B8ku5gyKp/89Nu7/4nhjLC3XpNKOk0xPmA/6o+ZVG1
 x/vBXndYg3Lo1qImEI3+58vSseCnfKYheNWA=
X-Gm-Gg: ASbGncv6tiQ1qoAkEccxGMqN/Q76VJeP0JWaAAUox3zmlr1HmYW9LmMroqUs9h4Q4nw
 QzMOWLvhoNo7hA0MO8GJmCG7VNUHF7KBaPS7279XQVvki1aIC8X/xX9sDuRDA/BDvaDFsLKzzuZ
 Sr9oCWoIyc9fdVv1wfAr3lXkEsafmgY9e60ZF9GGbi
X-Google-Smtp-Source: AGHT+IFY7amdeVpVU0p6cijOIzzMmtvJmnItteGsM3NGfPG6wGxqJSRskLew9G4ntXdREBDx0LLNqwuPvpQFlSMbJck=
X-Received: by 2002:a2e:a541:0:b0:302:3de5:b039 with SMTP id
 38308e7fff4ca-30b931fb846mr37185601fa.8.1740984398287; Sun, 02 Mar 2025
 22:46:38 -0800 (PST)
MIME-Version: 1.0
From: Hab Gallagher <hab.gallagher@gmail.com>
Date: Sun, 2 Mar 2025 22:46:27 -0800
X-Gm-Features: AQ5f1JoW0bSKNOxiyfIIkaYISOGgkoc6CUGMThxTwoyM1ykUM21R_fRgj3SzZAY
Message-ID: <CANDMsCp3wH3xhEvHz_DvnPbv7NLCdGb2LDaECOG=yJqfKObLkA@mail.gmail.com>
Subject: Adding gamma support to QemuMacDrivers
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009ea1ad062f6a84e1"
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=hab.gallagher@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--0000000000009ea1ad062f6a84e1
Content-Type: text/plain; charset="UTF-8"

Hi.

I have interest in contributing patches to extend qemu's powerpc graphics
card emulation to include more comprehensive support for gamma. Some
classic mac applications will balk at launch if the graphics card doesn't
claim enough support for gamma tricks. Native parity should be possible,
allowing applications to ramp the apparent screen brightness using gamma
tricks.

As far as I can tell, both https://github.com/ozbenh/QemuMacDrivers and
qemu itself need to be updated for this endeavor. It is unclear to me how
much of the code "should" live in one repository or the other. I assume
that it would be preferable to put as little code as possible into the
driver that runs emulated, and move the bulk of the work to the driver
side, in the qemu host.

I could not find any existing work on this, nor anyone asking about the
feature. I don't have experience hacking on qemu, but I have extensively
patched SheepShaver before. I hope to contribute more to qemu-ppc instead.

Thank you for any advice on direction or prior art.

--0000000000009ea1ad062f6a84e1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi.</div><div><br></div><div>I have interest in contr=
ibuting patches to extend qemu&#39;s powerpc graphics card emulation to inc=
lude more comprehensive support for gamma. Some classic mac applications wi=
ll balk at launch if the graphics card doesn&#39;t claim enough support for=
 gamma tricks. Native parity should be possible, allowing applications to r=
amp the apparent screen brightness=C2=A0using gamma tricks.</div><div><br><=
/div>As far as I can tell, both <a href=3D"https://github.com/ozbenh/QemuMa=
cDrivers">https://github.com/ozbenh/QemuMacDrivers</a> and qemu itself need=
 to be updated for this endeavor. It is unclear to me how much of the code =
&quot;should&quot; live in one repository or the other. I assume that it wo=
uld be preferable to put as little code as possible into the driver that ru=
ns emulated, and move the bulk of the work to the driver side, in the qemu =
host.<div><br></div><div>I could not find any existing work on this, nor an=
yone asking about the feature. I don&#39;t have experience hacking on qemu,=
 but I have extensively patched SheepShaver before. I hope to contribute mo=
re to qemu-ppc instead.<br><div><div><br></div><div>Thank you for any advic=
e on direction or prior art.</div><div><br></div></div></div></div>

--0000000000009ea1ad062f6a84e1--

