Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1A4C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 03:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raSVV-0002qo-VO; Wed, 14 Feb 2024 22:33:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSVU-0002qW-OP
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 22:33:52 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raSVL-0002Ne-8c
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 22:33:52 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-4c02a647ed9so103336e0c.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 19:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707968022; x=1708572822; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o4Se4pHCrR9SN4bNG52JmLnh9/soUUm9hvdPcqRIeQE=;
 b=aEdF99ycj3CDKXU+68q3JxaS569fytYvtrgxPKoXgRM6yyaXHd2A4BOmmFrPlIZPgJ
 Qy+23SxcrK+PLKerENUbopKdHK0dsbXV4GNoNVGn48i2QDcU2Vsysw1D5TJ2fvM1MiqU
 JyvqkCC0JV0uk4ovRmnL1KMBz/MlUuGrg2m4SOkhRJaH/d2I90Xp2TgDgF6a0LQ2WdwX
 U3JmSSiucdYKxqkzN3JjmrruNfUUP9FyWHbpx/IJ7XZVUFSjHrIB3epMC7+MhVNELvEs
 nn8qXxHStj7vaIqqb1zZcvfrx0AynXQihKymbtjsvJIOZzoDI+eol0bqwJG3L/du65qv
 Uvlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707968022; x=1708572822;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4Se4pHCrR9SN4bNG52JmLnh9/soUUm9hvdPcqRIeQE=;
 b=oW9CK5yIDkWaYxPHHwokPxVN11ZC1ypKo8qDPqFZCMyjEu/MnDYauQnQ/biAMdGV+e
 /NLmfYVj3jltVaute9YPgCON0PLU4UjxvryfC3/tk1vQmUtMDEpToJYxtNTwZdm88L4P
 aYKulxjQv4CGqFtbZmR1zVIT84rrlYq7Qh67y/eepLavfrYFfyQYP0tiyhWZ1HWBIR9G
 SPBY17Ryj0FNtdUPW6JNGezLPZl9wgdpEr5bH15NaHq2aTTgnN0wQke3SG+4vidM7j/A
 1VWJ60Q41oYgZCcMkzpaHiznvG4psM0MVR/uqupMfwZDS3Voy2xWLRMBUyknBe5Vo1OJ
 iMjA==
X-Gm-Message-State: AOJu0YwQgqxEh6oy+RcwSJ2TXfYd81n/lgjB3Jm8gRbILHF6n1WLzUF+
 vVQBjwqPWUzxyCcN229sWUFpCrGef2vYASonxbWrxNBmrhtf9ANgKRS4Ss5TBUoBBnuihD8kvfJ
 7/DRUN5ZlWQGbJS25vcyAkNocCOE=
X-Google-Smtp-Source: AGHT+IGX2n1A0D16SNN5Hfa7M9lnKv4SgpmDXXC7jOWPi8bteUDgTaGDAdzb1uTBJ7KHuvIGnr0aBdwVDkfLfRgFH2s=
X-Received: by 2002:a1f:ccc4:0:b0:4c0:1cb7:1ba9 with SMTP id
 c187-20020a1fccc4000000b004c01cb71ba9mr388711vkg.9.1707968021986; Wed, 14 Feb
 2024 19:33:41 -0800 (PST)
MIME-Version: 1.0
References: <tencent_29796A8EF3E655396E27566AC5CE1103A509@qq.com>
In-Reply-To: <tencent_29796A8EF3E655396E27566AC5CE1103A509@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 13:33:16 +1000
Message-ID: <CAKmqyKMaG6g3Aa5kW-gyiC09yv4V7LzJaDbKvr4_sy854dScWw@mail.gmail.com>
Subject: Re: Assessment of the difficulty in porting CPU architecture for qemu
To: =?UTF-8?B?5pa5?= <1584389042@qq.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Nov 17, 2023 at 5:35=E2=80=AFPM =E6=96=B9 <1584389042@qq.com> wrote=
:
>
>  Hello everyone! I am working on implementing a tool to assess the comple=
xity of CPU architecture porting. It primarily focuses on RISC-V architectu=
re porting. In fact, the tool may have an average estimate of various archi=
tecture porting efforts.My focus is on the overall workload and difficulty =
of transplantation in the past and future,even if a project has already bee=
n ported.As part of my dataset, I have collected the **qemu** project. **I =
would like to gather community opinions to support my assessment. I appreci=
ate your help and response!** Based on scanning tools, the porting complexi=
ty is determined to be high, with a significant amount of code related to t=
he CPU architecture in the project.  Is this assessment accurate?Do you hav=
e any opinions on personnel allocation and consumption time=EF=BC=9F I look=
 forward to your help and response.

The people who did the original QEMU RISC-V port aren't involved any more.

You are correct that QEMU is significantly complex to port to a new
architecture compared to most other userspace software. I think it
would be similar to other JIT software in that regard.

Alistair

