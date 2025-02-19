Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E752C021B1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkgrU-0001V2-ET; Wed, 19 Feb 2025 04:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <falhumai96@gmail.com>)
 id 1tkgrS-0001Ut-S6
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:59:22 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <falhumai96@gmail.com>)
 id 1tkgrQ-0005XZ-T4
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 04:59:22 -0500
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3f3fc8f5ffdso739601b6e.0
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2025 01:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739959159; x=1740563959; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=rofWR/ThaW+o4RvXKUV/RT+URsbB/LzG5Gi/vKNeA7A=;
 b=U3UAjreB4OiNFB8m+tUVKW9YnGGybm0cpIwBLbhxvQkJ8XANzGczAZhHkVJZnoVygc
 k17lJebNHMezIcuHmjag+vODLncnvOanr1Y9cKFx56IeHXJEDaeWFo9hUNgjNgsYoGwS
 IE0pqJXHrUIax76PdL0TfNHRpUd++5fSQIt5Zilazi0mFctdEr+PtXVOb1AYGi1/twjd
 KQe42TbpRGcpLtleeCndunI8wUWj07k8Tr+hcDeWrUMy9iXsi8PHwUS0SlPScLyjgykM
 UMcpfKbM6ctm98QllHEFXeT1PNYvcLfAOVfitj4Nhk0NjRo1WRLX9Es7rU6ffZLVDZ9k
 MyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739959159; x=1740563959;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rofWR/ThaW+o4RvXKUV/RT+URsbB/LzG5Gi/vKNeA7A=;
 b=a4loe0CqBDjD3DDpz9BovF/tvHaVrTpRBYAEBqHbF6NMMqCD6ldQLAkl1uQjf6cmik
 y7glCilGBTZx669T2nqTCWsCqFTSnGfa2lnOh06aeBvxaXd+HNa6lEXiL29Zd4TD/Cj5
 Apd4YrV6OL3UMVG6TsNwKKDkTtrZZTOjJznrmQ+qekj42VLs/fGRlA2HJMbcqdOmdD/m
 tYIMC3K8Bpj0KmfULkYEvWjtp6ZJBI4kQEuwq1niSRQAV8ThItTX5u0wBMu42ydPUtV5
 IxYIpOFFG+OKG1s9i39XZbJ6CA6iZRm0TsgVR3OY8k23vMSYl+JF/KD63ZsJppTVfZz/
 PQow==
X-Gm-Message-State: AOJu0YyF6xVIwSyJfpn56A6qAKFCtpoEQzoQVPoWBQ+wmSM+l6TLacze
 3dckuPKLv2LWioILye2EOXylohdvOaaaAMFdj8+ZI0a775fQivKDwihl9hnhdixLeO2qtTOR0d2
 G0BWMfdt8iv+rWFHZHMZZQ1vjLUTzQqeY
X-Gm-Gg: ASbGncubUT8lLblM9RSAxBm24HFHeBsRs5vIn2wvgr1ne0EzPN/QaI7uKjaiN2aHfHY
 7FWizWsyZn7rXuB+2sq77lOu9HlAlCeRDJTPkhLoL4cZpk/ACaUGJS4NVqkrU7rwo5rxQMrqaWt
 ITgMpbgjBlpDk7VA==
X-Google-Smtp-Source: AGHT+IEjVv3xwpSwSQV7mH/Xe6bwNj2iYdLNmJIpP+N3ABRSuPqdc2qZuzwZ1ZN2R5z7nzilsPWP7RpNSRXCbOIIRsY=
X-Received: by 2002:a05:6808:2209:b0:3f3:dedb:844e with SMTP id
 5614622812f47-3f3eb0b95d7mr11827909b6e.18.1739959158533; Wed, 19 Feb 2025
 01:59:18 -0800 (PST)
MIME-Version: 1.0
From: Faisal Al-Humaimidi <falhumai96@gmail.com>
Date: Wed, 19 Feb 2025 01:59:08 -0800
X-Gm-Features: AWEUYZlvsZ9lCW4rL0C_fP8Py6hLbu4EaZGUNBbEdAGM-KA6ssmSX9wkLxMSjRM
Message-ID: <CAMx8kb0zN7CPjuFJatoF+5UBwdLaCA_AJGcxUV8cdBoDd1RBag@mail.gmail.com>
Subject: Permissively Licensing the CPU Component
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000009176d4062e7bcf1e"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=falhumai96@gmail.com; helo=mail-oi1-x22c.google.com
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

--0000000000009176d4062e7bcf1e
Content-Type: text/plain; charset="UTF-8"

Hello QEMU developers,

I understand from this page, https://wiki.qemu.org/License, that TCG is
being licensed permissively (BSD license) so it can be integrated as a
library in other projects, which is great! However, I'd like to know if the
CPU part of QEMU, no peripherals included, is also permissively licensed
(maybe BSD or some other permissive license such as LGPL, ...etc.)?

The reason I am asking this question is because projects such as the
Unicorn Engine would greatly benefit from a permissively licensed CPU
component so that the project itself (Unicorn Engine) is also released
under a permissive license, which would be great for people wanting to do
research with the Unicorn Engine but are tied with proprietary code (e.g.,
in proprietary university research projects). I have started a discussion
for that matter with the Unicorn Engine developers in their GitHub page,
https://github.com/unicorn-engine/unicorn/issues/2114, and it would be
great to have a feedback regarding this matter from the official QEMU
developers, whether directly on the issue or a reply to this email and I'd
relay your response.


Kind regards,
Faisal Al-Humaimidi

--0000000000009176d4062e7bcf1e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hello QEMU developers,<div dir=3D"auto"><br></div><div di=
r=3D"auto">I understand from this page, <a href=3D"https://wiki.qemu.org/Li=
cense">https://wiki.qemu.org/License</a>, that TCG is being licensed permis=
sively (BSD license) so it can be integrated as a library in other projects=
, which is great! However, I&#39;d like to know if the CPU part of QEMU, no=
 peripherals included, is also permissively licensed (maybe BSD or some oth=
er permissive license such as LGPL, ...etc.)?</div><div dir=3D"auto"><br></=
div><div dir=3D"auto">The reason I am asking this question is because proje=
cts such as the Unicorn Engine would greatly benefit from a permissively li=
censed CPU component so that the project itself (Unicorn Engine) is also re=
leased under a permissive license, which would be great for people wanting =
to do research with the Unicorn Engine but are tied with proprietary code (=
e.g., in proprietary university research projects). I have started a discus=
sion for that matter with the Unicorn Engine developers in their GitHub pag=
e, <a href=3D"https://github.com/unicorn-engine/unicorn/issues/2114">https:=
//github.com/unicorn-engine/unicorn/issues/2114</a>, and it would be great =
to have a feedback regarding this matter from the official QEMU developers,=
 whether directly on the issue or a reply to this email and I&#39;d relay y=
our response.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Kind regards,</div><div dir=3D"auto">Faisal Al-Humaimidi<=
/div></div>

--0000000000009176d4062e7bcf1e--

