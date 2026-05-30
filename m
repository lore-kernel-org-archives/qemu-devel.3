Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F118CD5BD0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 16:36:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTMf2-00026n-8S; Sat, 30 May 2026 12:35:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <komolmoni@gmail.com>)
 id 1wTLJt-00027K-0y
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:09:49 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <komolmoni@gmail.com>)
 id 1wTLJr-00082h-Bt
 for qemu-devel@nongnu.org; Sat, 30 May 2026 11:09:48 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so2280643a12.3
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 08:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780153785; cv=none;
 d=google.com; s=arc-20240605;
 b=SOckriK8+ecsHWpyIKi1/fRYJtp+zq00Pcsx6k8rVnB3NyxzAnKDn10KO7t+vhBAuj
 sMR7QXSrC13xC2D+4+EobmE6foz+Uc7vbX0phrHqfUQbc/84mCeguU2H7tWQREvt9mn3
 rcSpUB4Kb44+x9vvZTHqZawPSh4JpVRjY1XTbKfZmPtdC3kMiGBDbJGX1I4XV6oh4WX4
 jL5V+34E1KgkDYVZL6r80IlLsz+TQEh19NbkDEOL8bBBm+kzzXDdv2FeivFidMehUEG6
 tzsoNEN7sS2v7FFfF3Q3XUEAVF4y7PPKCKLxRik/pbicOF8oxVDCmXbW0KD+XIFY9U7e
 K1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=6Sdf8AzBzMlo8Fby273aICdcGtvbsvKwTPdMajfaafk=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=RFqM45f9m0jOCDXkzyvfc7IBmeB6pBF4cCmJKzYlyAYyLl/lRRUO/2FOOkQMdsK7VP
 XTdYdVt4Is0VcrA1lIrqaDiVt2hAZIdx6be7t6VENS1dalugnZ8Wwq4BviZfBUHW5oYV
 cH8vpBI0H6MD8parKrX8GkQ+9y0mUl6fic/0x8rXhazmR5UJgPVu9BemfcesEo7HYPX3
 Or7OvsEHPsFRMzNPcdwxQkREX6lGk4v6Q1NuP7dmoF/rgqoWce/9M4XqeXuG6ahV4b/X
 gpsOFjjm3BrClG0PdpjOZBxwD/LZ5q2bjk9pxq4D3mZRgRxq4EHKNV9mTTwRoEfoXLQ7
 domA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780153785; x=1780758585; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=6Sdf8AzBzMlo8Fby273aICdcGtvbsvKwTPdMajfaafk=;
 b=I04kuMtARFqVZyieNT2xklm8bscw+6KRebZnRDKG6CVe1y48kLh3ml8XU9m4SJddHk
 e0eejZsa5pcGu5IFIUA8nQuEtKrQQsTD6sc24kuPhEwtmgxbDLVd2HGvwzy8ca0jngmr
 I4dQjAsndLwPW2V6DOh6s/CuGl5WNL84CLVRZCkymMeAEmcvDkoyPMoGz/OLYAwAM4ye
 Se0ioYyp/yI+jBnXQntKADr0aeEF+SHnuakFy/tLi/5vefCMrxE64ONx6FDqJXhM257j
 T5k50rRy2wD8u2ch9gbD9wVA9RzwHbRrs2Di/+gy72GBgwONi+sKE/QVv79ghSz88yuh
 wNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780153785; x=1780758585;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6Sdf8AzBzMlo8Fby273aICdcGtvbsvKwTPdMajfaafk=;
 b=sM32A6cb6KE57+5aLnKz1UtNQA+9BSZMWCJmwQp6IeMwV7ts++v5rrxc8mMfvBYucU
 rtteSeGkvfc44pYyM0Z3UupmuUBJkDb0PV+YIDIuNsLT3a5YelRqw8vuwp+jsLGT7xZO
 zzV8rtH1p7t33vVxAqVi/RY3Cdr17dsSwsxnyzsjWccdBoHQuj2ouvxNsLKXoaPkRwww
 /pUsn2f3E7w4ykPZ2qoG0Ba+TuNnqCd9iexxfzJY2X5ecOi3XbDuPS5qFokC9I4DHSzf
 cBog40PdxYayd4pBYCNzxMg0t7UZh+nh3upI6uH84D8Lf2H8wdHqZrVKJAyX118cm1Mz
 urRg==
X-Gm-Message-State: AOJu0YwDeNGTxn3u0ta9Hthz6MpP5jKM2quwy3/aw7ItNL+fSsw6nohr
 ezSyJbhte5IsGNqkByNvhW7irlJHxtMjRvzhYlxW61PIn15EB5KBbX1H12UQtBYxTwsbRvyYIL/
 PVW1g6Xo8go/zyEmfCUeV24SqrmPQx6N8dtoF
X-Gm-Gg: Acq92OEFAHn9ECNuoQH6pULn/jRs1DbMnKwighmkbUVn2Py1dHXOuWp5qGFs3IqBWyo
 lvj/AhnkIYZtkQOJkXBRISovoV69d1JrIc8fUrf3YgEgqiiRO2/rTLJDSmVwsh0q6qErf2J0UO5
 HzvoC3McVRTsKsj+GjGtDZerA2Y+G8oktX0pKoRviYwlMeQk+A2HyQD9Clan8XGa7af41VnFuQp
 af/zNWVRpGo52yI8OpfXW02BZNRBtONo/3hWmZB15lzmrVUfWB0zPaLlNkFwvNJDCHy/kVXOZfm
 35Cc6d7d1m5RlxT+hQ==
X-Received: by 2002:a17:906:3098:b0:beb:133d:cf02 with SMTP id
 a640c23a62f3a-beb133dd1d4mr88695566b.26.1780153784277; Sat, 30 May 2026
 08:09:44 -0700 (PDT)
MIME-Version: 1.0
From: komol moni <komolmoni@gmail.com>
Date: Sat, 30 May 2026 21:09:32 +0600
X-Gm-Features: AVHnY4KJAyM4N4uNHlOPtImkHJyY7ZcysjZZFmNW1fEAfkg3uUmQzGtp03tx1_c
Message-ID: <CAFH-dFZKdjVFf=n+xpAKursHzNh8Tn67N+GW778JTvCybq+5Jw@mail.gmail.com>
Subject: Subject: [RFC/PROPOSAL] Improve Default PC Speaker and Audio Backend
 Configuration for Installer Environments
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000f5205106530a5978"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=komolmoni@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 30 May 2026 12:35:38 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--000000000000f5205106530a5978
Content-Type: text/plain; charset="UTF-8"

Subject: [RFC/PROPOSAL] Improve Default PC Speaker and Audio Backend
Configuration for Installer Environments

Hello QEMU Developers,

I would like to propose an enhancement to QEMU's default audio handling,
specifically regarding the emulation of the PC speaker (pcspkr) and audio
backends during operating system installations (like Debian or Kali Linux).

Current Behavior:
Currently, when launching QEMU, the virtual PC speaker beep and installer
audio often do not work out-of-the-box without complex command-line
arguments (like `-machine pcspk-audiodev=...`). This creates accessibility
barriers for users who rely on audio cues (like the installer beep) during
text-mode OS installations.

Proposed Change:
I propose that QEMU dynamically links or automatically configures a default
host audio backend (such as PipeWire, PulseAudio, or CoreAudio depending on
the host OS) to the emulated motherboard speaker and sound cards by
default, without requiring manual backend routing from the user.

Why This Matters:
1. Improves accessibility for visually impaired users who rely on installer
beeps.
2. Creates a more seamless user experience for beginners.

I look forward to hearing your thoughts on the feasibility of this change.

Best regards,
Ahanaf Labib

--000000000000f5205106530a5978
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Subject: [RFC/PROPOSAL] Improve Default PC Speaker and Au=
dio Backend Configuration for Installer Environments<div dir=3D"auto"><br><=
/div><div dir=3D"auto">Hello QEMU Developers,</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">I would like to propose an enhancement to QEMU&#39;s =
default audio handling, specifically regarding the emulation of the PC spea=
ker (pcspkr) and audio backends during operating system installations (like=
 Debian or Kali Linux).</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Current Behavior:</div><div dir=3D"auto">Currently, when launching QEMU, th=
e virtual PC speaker beep and installer audio often do not work out-of-the-=
box without complex command-line arguments (like `-machine pcspk-audiodev=
=3D...`). This creates accessibility barriers for users who rely on audio c=
ues (like the installer beep) during text-mode OS installations.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Proposed Change:</div><div dir=3D"=
auto">I propose that QEMU dynamically links or automatically configures a d=
efault host audio backend (such as PipeWire, PulseAudio, or CoreAudio depen=
ding on the host OS) to the emulated motherboard speaker and sound cards by=
 default, without requiring manual backend routing from the user.</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Why This Matters:</div><div dir=
=3D"auto">1. Improves accessibility for visually impaired users who rely on=
 installer beeps.</div><div dir=3D"auto">2. Creates a more seamless user ex=
perience for beginners.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
I look forward to hearing your thoughts on the feasibility of this change.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Best regards,</div><div =
dir=3D"auto">Ahanaf Labib</div><div dir=3D"auto"><br></div></div>

--000000000000f5205106530a5978--

