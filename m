Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96ADC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 22:46:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkWLc-00086i-KF; Tue, 18 Feb 2025 17:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <traceoliver06@gmail.com>)
 id 1tkW5P-0004su-Q8
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:29:04 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <traceoliver06@gmail.com>)
 id 1tkW5O-0002Oi-26
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 17:29:03 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e0573a84fcso4647741a12.2
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 14:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739917738; x=1740522538; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=X/PyZTct2+4blJiZZrrN5ODeYgcJ/oSkfHx5eHST2pg=;
 b=QGkprxCnOvKd6C8CVXl8HMIyax3RrHIDaai8d/MtJbJ714xVo+yeoflKLUp/RwlRej
 eLlD9JX/uXOzhA0D5YkyUVRQpM/ksbd5EO0RY750Trjc9T8sRaz+WZnUbNey6Uk/CcWO
 9wuvutptCp2L7oPJJvAjn1Lxq1uMBWHeSc7+HS1hrRNrOlJDlrnSHSTLhMFf0GhiIAQ3
 bsgb8Qyu2S0hyYxBYDSsUXZdn7LaVMDc/+5VR4T9srVMrlwR0DTC2fn9DAfqpJkN9Sfj
 1dw98V1+xRilAktcodPnCwItdzEmYhkH7B4xybaULP8hOOzjqqvUVuQM+sU4DRL8XNP6
 QngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739917738; x=1740522538;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X/PyZTct2+4blJiZZrrN5ODeYgcJ/oSkfHx5eHST2pg=;
 b=q4jRB/wv/wAjnCNbkJyDgG4zvaz1MMduY/U+o3/Z3Kejd/Giq50att+5btiQUFpxPX
 UhyryTmfT7DDcHNcRhu05oixJ1WLh8iUq39yptnVgbmfTunj3gPJiIjGT1LU7JOxE/lO
 BC8EA7N1edSjBSaElvbaI1qVbXk3dqLv7UVvVCU7t+zECp4ryO3ZltN3xGiCd9Z3JyYp
 avOcBYpz5uFHrQUj1PgG0u1q55zfpLWTcoKDZoyrrHYaWL0squXBW1DAdwC61QHSi7fe
 6i5mcIArAwbPBLRQNjF107SH44xtsKvjKOWwjyCKx3jdyoeaela88MnCiTWi9vYetTxY
 +W4Q==
X-Gm-Message-State: AOJu0YwFPCmmoxb5xVic6M+bWLQQ1hWyxBp+DuttNEHprwF2C9Qnd7e1
 GGeRr1oIrDoJ2yZa/zTDM6/r4XaTdKX7RwXV16Zli/T5CvjB2eGQK75hKF2bEZ6R3laGQLlJQTC
 6QmcTEfNHd11Gl7eYnXhC1wQo2ViO8zahaKc=
X-Gm-Gg: ASbGncuHuvPpe/C/32XJ/zKJIjYLJRYdJm/7MVrsvgZa4n9J5u3LUEtDrEfkw+ROklf
 HhNiVsisKjpLcULaz64ffVuT5NWuk9NiXmAvjiUJrxC6OTvn8b7x7JMh5jZMYLSBzgDHw1tOaDT
 9MyeFUK1MOX1/hkj9AYKhaW27XZ13SASE=
X-Google-Smtp-Source: AGHT+IEwQN+0z8vTejCgGZki8iaHFDaSQYTaHSbdzQqqqmwCqBficpNhGgvv685Nvs/+HGFJdWx81M2g01yiXBTUAmM=
X-Received: by 2002:a05:6402:268a:b0:5db:f5bc:f696 with SMTP id
 4fb4d7f45d1cf-5e03601eb1cmr18251303a12.5.1739917738139; Tue, 18 Feb 2025
 14:28:58 -0800 (PST)
MIME-Version: 1.0
From: Trace Oliver <traceoliver06@gmail.com>
Date: Tue, 18 Feb 2025 17:28:43 -0500
X-Gm-Features: AWEUYZnimno0snqOz98JaFi8gf4KXQdV13PUyYE76k_p_Nm-rURFEc0Xh8v-kxM
Message-ID: <CAJq1-rgbNjN5BFRAzVGiux+eDuq7k=eFJfOgHxR0k+Gw3DhmGg@mail.gmail.com>
Subject: Trying to boot VM from powershell Windows 11
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000b86716062e722a2d"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=traceoliver06@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 HTML_OBFUSCATE_05_10=0.26, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 18 Feb 2025 17:45:44 -0500
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

--000000000000b86716062e722a2d
Content-Type: text/plain; charset="UTF-8"

Hi guys! My name is Trace Oliver and I just downloaded qemu using the
64-bit Stefan Weil link on the qemu.org website but, when I try to do the
command "qemu-system-x86_64.exe -boot d -cdrom
.\ubuntu-24.04.1-desktop-amd64.iso -m 2048", qemu pops up but, it gives me
this error message "Guest has not initialized the display (yet)." and I
don't know why. Can you guys help me figure out what's going on and help me
fix it? Thank you so much!

Best wishes,
Trace Oliver

--000000000000b86716062e722a2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi guys! My name is Trace Oliver and I just downloaded qem=
u using the 64-bit=C2=A0Stefan Weil link on the <a href=3D"http://qemu.org"=
>qemu.org</a>=C2=A0website but, when I try to do the command &quot;qemu-sys=
tem-x86_64.exe -boot d -cdrom .\ubuntu-24.04.1-desktop-amd64.iso -m 2048&qu=
ot;, qemu pops up but, it gives me this error message &quot;Guest has not=
=C2=A0initialized the display (yet).&quot; and I don&#39;t know why. Can yo=
u guys help me figure out what&#39;s going on and help me fix it? Thank you=
 so much!<div><br></div><div>Best wishes,</div><div>Trace Oliver</div></div=
>

--000000000000b86716062e722a2d--

