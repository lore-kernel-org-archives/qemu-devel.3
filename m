Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0DFCD4F4C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Sep 2024 07:29:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snCLd-0003YU-Kz; Sun, 08 Sep 2024 03:28:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jkurape@gmail.com>) id 1snCLb-0003Y1-Rx
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 03:28:35 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jkurape@gmail.com>) id 1snCLa-0001OE-9a
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 03:28:35 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6d5a4615a56so30688477b3.0
 for <qemu-devel@nongnu.org>; Sun, 08 Sep 2024 00:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725780511; x=1726385311; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2psCH6/rql/g5qpA/7EEVHbdZyUvlGDkFB1uESR72PA=;
 b=J4QhnVyk5Kn2ETiwakVLh8pDUrRWXUTk2u9P6J6OAYI5noBtI5lbFYFqRaztxfAqCJ
 oM59j4nM47DvQPmalCGvb9v0Npxb6UIjXRUe38T7IV1YVeiYeYlGvqnDoXk4zY9RI0Ex
 5fBRRXfpDuFXj1OHkJZn1CtUBkirOJxetRpldLYUZWMIZCWhtx7ZBBKa7lheMl6CGpO0
 qZJhknwMkl5r2YgC2+UrCeoWOkuFfeCKdf022Cn6X/la0vNkmkxgcsM/6k+Ub/tNweWq
 gF65u3SHhrZgR8wxjHefo5tqSkboPh3l97+NDBVBKEAF75v9VUC64I+7/JOQXG35uJnv
 QBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725780511; x=1726385311;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2psCH6/rql/g5qpA/7EEVHbdZyUvlGDkFB1uESR72PA=;
 b=uUZOSppCcBTflQP9UXFEYubxYXEnGhn7IjHeoWE+azi8TnQwVI1KXdyGkjFAJ0DKWd
 kYrU16w8KF15q9ZAi7QX1AVddYDLSBLaPROfoveUg/MPTaV6JcJZHPQtzyLSbsf1PWzJ
 UwiXntSmLdFttdrD2cOqLubIUV6IsIShI9ctUBk2afluhR+K0yyjfzjolzwgUVC7OO10
 y6icIky87D9hoXRNFbvgzRydTrFzV4s9EhpmLLONzY9RnrcmfXjevNGAcU2F2hZWMRwN
 VVGG2p34pj5XItz1n7eRdGTbLO3rsWEDNICQI0OpbI0IiM3E3XwVDFsMq+R5En3y9rN2
 kD1Q==
X-Gm-Message-State: AOJu0YzVCgrlXS/V15nV66fzfqtV7YIa8FpHQ3Et1Xj5IfldPJVQUsqy
 TJfyCKRqnnHUzAclQ1PMT46w03DCC4EjJRxsrGEnW6nr5IDikhdVONXgTPROXJm7AntLZhEHHlT
 15XT7TfWLfk7R37oxFkK40mXpmFRg2+QeeeYW
X-Google-Smtp-Source: AGHT+IEEyyX6UdDvrkzpdh9RL0qcir3akw/FczWcgkEY6a+ioBnDMk3E11DMzfcvX1ZQDtmcV9GV0HFIQOZIGeod3tw=
X-Received: by 2002:a05:690c:f0f:b0:648:baba:542f with SMTP id
 00721157ae682-6db44a5d7acmr77373747b3.0.1725780510752; Sun, 08 Sep 2024
 00:28:30 -0700 (PDT)
MIME-Version: 1.0
From: Joseph Kurape <jkurape@gmail.com>
Date: Sun, 8 Sep 2024 08:28:18 +0100
Message-ID: <CALcAbx6pnqwB2TRJMOGu10ZkY-6STOJX81ZGeUNarfXwV+fPvQ@mail.gmail.com>
Subject: Contributing to Qemu
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000004dcbe406219696ea"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=jkurape@gmail.com; helo=mail-yw1-x1131.google.com
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

--0000000000004dcbe406219696ea
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm new to open-source, but I've learned C and Python.

I've read the 'Getting Started' guide, but aside from signing up for the
mailing list and getting the source code, it doesn't provide much direction
for beginners.

I'm looking for somewhere I can contribute. Could any maintainer suggest
any issue they need fixing or offer general directions on the best way to
get started?

- JK

--0000000000004dcbe406219696ea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Hello,=C2=A0</div><div dir=3D"auto"><br=
></div><div dir=3D"auto">I&#39;m new to open-source, but I&#39;ve learned C=
 and Python.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto">I&#39=
;ve read the &#39;Getting Started&#39; guide, but aside from signing up for=
 the mailing list and getting the source code, it doesn&#39;t provide much =
direction for beginners.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">I&#39;m looking for somewhere I can contribute. Could any maintainer=
 suggest any issue they need fixing or offer general directions on the best=
 way to get started?</div><div dir=3D"auto"><br></div><div dir=3D"auto">- J=
K</div></div>

--0000000000004dcbe406219696ea--

