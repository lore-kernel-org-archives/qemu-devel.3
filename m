Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F36C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 15:58:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiy5A-0005Gl-2q; Fri, 14 Feb 2025 10:58:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thenesk@gmail.com>) id 1tixfp-00055y-KG
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:32:13 -0500
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thenesk@gmail.com>) id 1tixfo-0001yU-4M
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 10:32:13 -0500
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e53ef7462b6so1750921276.3
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739547130; x=1740151930; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=k+b9fkI4aWeF+Pn0Mb6Tuc/RCZqY3ta9PW40+82HCgk=;
 b=Xw1dZz07+YbJ8Q0MTGKeWV/hhLvTSJUZJ5//e07LtrIXJRB0OpK07N5g9o9UsBNBkM
 lOvggWyCasJoSiSMbDXTByR4G+Y1Eu+MjzAYgI5kiI4vtohGzrpl1FGsJtJLYq3170Qh
 NSYCFkjgGNWm0I7C88F349mTZxFVHmxMa8SVKBeSbxWh7bDpHI2wT3WhJGYjbzoUF7MI
 Zg8/WyHwFfdRdakTd/yBtE0Nf6qWMKHowt0InecY5WWfDcsGC1M1pM5ebkfQk1DRd0d8
 Mcinz9PR+GjTC1f9EQTNpvqTbLVQUz02PJYp29KYtBDeMfvdNj3y8lryfkm+7Vr+ifNN
 mczQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739547130; x=1740151930;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k+b9fkI4aWeF+Pn0Mb6Tuc/RCZqY3ta9PW40+82HCgk=;
 b=AGd4tbJbMV4duUwJbLAW5T+h0KeN9TbqqT121n/EBd7l87bEprl4fqelaoRUsM6shb
 mNPai2le8cayKM/t3EugcHqUAmDMPzaraMMFcYGhVIdcMqXBOyPc3ppMv9xLL/EeZUOf
 ZanhrrjPU5miSIb43d52DBo85rG1uVT/pemk/QM8d94Emyq9lWytMLjC+LVauozMCT9i
 DUJr1QscNvznxWrg7lDjLxNk87yqX0HVXqoucdHAfflgCRMChEqxGgxq4x4vX1TbtkNY
 lNF4++obPe7Du32SFQ9NiwKF2uxcHgQDq1SBQnPWV4mGmGu8zmkv8pvPgjMumz6Lu6YD
 3G1A==
X-Gm-Message-State: AOJu0YzHSCfW3pRDh8ivID79RHui7nWyrlxjWjEnUpmDdHfexzxdU8DQ
 Ftqh9zxYxrV1ZozEaZDLzLcNCGSRKY9Ih0tJD/eqhM3VlRfzrqOntw1kesJjwi5ZvwBfUUTiAZg
 RqsJ1uaqzze/CqD1keRQ4pWqn/ciCaA==
X-Gm-Gg: ASbGnctaR3/YBfo+uPsy1zrCxEc6dlNjWDutrUOQQEHS5ZznRkmHPon01Lpos/EFrwB
 ryRjOV+200mxfeL+T2iiu9Qbtk47XjJNPn4L0YCkXXPlR1gBzQbMO+GhWniZshw9SGdhDw05R
X-Google-Smtp-Source: AGHT+IGGnU7umG0BoJtiZIXh0zDlT8jUY8CPLi9hqDnsXRmd3tVEZWinasepTTwZ1QDTPDSr581Vn+ZB2zehj2RtRcU=
X-Received: by 2002:a05:6902:2383:b0:e5b:248a:bf3a with SMTP id
 3f1490d57ef6-e5da81e6c47mr6710597276.30.1739547130223; Fri, 14 Feb 2025
 07:32:10 -0800 (PST)
MIME-Version: 1.0
From: Mark Nesky <thenesk@gmail.com>
Date: Fri, 14 Feb 2025 10:31:59 -0500
X-Gm-Features: AWEUYZlT5ImWwPFsfEDENvaLihpqV31h0FQzCf3TaweToz-TehJz6U6f5_XaM6s
Message-ID: <CADQ=JkR046QnzWVV2=VshuS14r86riXUzLb3eh+Qer69N1rp0Q@mail.gmail.com>
Subject: Question: how to add CLI options for custom hw model
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c4711c062e1be01a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=thenesk@gmail.com; helo=mail-yb1-xb36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 14 Feb 2025 10:58:19 -0500
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

--000000000000c4711c062e1be01a
Content-Type: text/plain; charset="UTF-8"

Hello,

I am new to the QEMU code base and I am working on a project involving a
custom hardware model representing a customized ppc board.  What is the
best way to add command line arguments applicable to my model?

I see options in qemu-options.hx + vl.c, but I am not sure if that is the
right place for arguments that only apply to one model, and I am not sure
how to access those options from my model.

I also see the function qemu_opts_create which looks like it can add
command line arguments at runtime, but I am not sure where to use this in
my model since it seems like my model code (machine state, class, and
instance functions) does not run when invoking "qemu-system-ppc -machine
mymodel -help".

If there is some good documentation or examples, please point me in the
right direction.

thanks for your help,
Mark

--000000000000c4711c062e1be01a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>I am new to the QEMU =
code base and I am working on a project involving a custom hardware model r=
epresenting a customized ppc board.=C2=A0 What is the best way to add comma=
nd line arguments applicable to my model?=C2=A0=C2=A0</div><div><br></div><=
div>I see options in qemu-options.hx + vl.c, but I am not sure if that is t=
he right place for arguments that only apply to one model, and I am not sur=
e how to access those options from my model.=C2=A0=C2=A0</div><div><br></di=
v><div>I also see the function qemu_opts_create which looks like it can add=
 command line arguments at runtime, but I am not sure where to use this in =
my model since it seems like my model code (machine state, class, and insta=
nce functions) does not run when invoking &quot;qemu-system-ppc -machine my=
model -help&quot;.</div><div><br></div><div>If there is some good documenta=
tion or examples, please point me in the right direction.</div><div><br></d=
iv><div>thanks for your help,</div><div>Mark</div></div>

--000000000000c4711c062e1be01a--

