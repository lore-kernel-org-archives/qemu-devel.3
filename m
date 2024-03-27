Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3645AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 11:29:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpRSG-0003Y4-7W; Wed, 27 Mar 2024 07:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rpRSB-0003Xj-Lz
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:28:23 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rpRSA-00083z-BX
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 07:28:23 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5a1b6800ba8so2330851eaf.0
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 04:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711538900; x=1712143700; darn=nongnu.org;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LsuNDLeYxEbDL3IfuJp5bJwG4xh3apF4D2vGRP+Zeog=;
 b=DlHCtNaxY1bdtilfWMBjkpU4JDk/zESY46ibMIfS9ruW+zPhwRxYY4rghIyxaPOOc2
 5a5GQLM6o87MUJRwpvM3Ri6ntz2FUy3IjXdmOsyPH/lSFiq7Xp9hobiw+VomYRhkrnCI
 /NJrvK4oKU74kXRmUl/WMW28RhGN4koTly3b15J8G8DpQuYOMbTgowkKWr3vqs8urvHP
 SuChuVEcVxqAcz07WjhJGIy5Tbp4utnKMUjHP7HiMY3LSFZEGeObmeDOLD6Qmr+wNvIA
 LE1JzkUvlakAzZ/ezaSH73epl23RMC8rYsW6rvx9xcLg2gVFy6yH6Xu+MxuRCkLkiPQX
 slCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711538900; x=1712143700;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LsuNDLeYxEbDL3IfuJp5bJwG4xh3apF4D2vGRP+Zeog=;
 b=OS9hOG8EdAMgaCcuYiEb5uF7AkVy8nsiNs+ibfbT/6Ey0qFmw10s4wHEpNrNl5vL3n
 UXSJmsAYq9RrnMzkzRGvhraFByD0JaifcX3w17j47M1DnOCJWM8jNbGcHPzRv07DZ8eW
 +0JmChMERT2bILwb1JXjGik3uIsroedM/RkiG7HRdACnIClQGoy/5Pqa6yMsM7L6nsKN
 keIA5Su8BZZ2l8UOETOCZpw6OxxxeKyy1bmAWrOZibi1zkIx8bjlQAjwFeIdoWc1a7c1
 PheXMdpvGBu7kBH3+nereMayceuDMpf580tbZChUIzZdcKOzIvKVCu11KGB/50WYcRMe
 jmKg==
X-Gm-Message-State: AOJu0YylXGUH/J5gKLAWr/su4Z4pGLSP8RjG31V4JKFv8AdTS7dJozPl
 CAsSkYJt6wxpqZekblAQc/gdxz80JgIbzHWTYK5+zS4LFxG+1xv7hIiJ21N6b8p3GJxqCRK4tJl
 OrDaJGKZ45Q1YKQXiLVdOM28eMfCZ2vQuIN/Hbw==
X-Google-Smtp-Source: AGHT+IFkVrnR0hpadMGxmx+UawoiduZeFXWjLwEY8xlHq+Or850NknPb4v9itBGe1n4SxKfHBePaff1r12RBYEqY7sE=
X-Received: by 2002:a05:6820:151f:b0:5a1:23a6:e4b9 with SMTP id
 ay31-20020a056820151f00b005a123a6e4b9mr3406349oob.3.1711538900038; Wed, 27
 Mar 2024 04:28:20 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Mar 2024 15:28:08 +0400
Message-ID: <CAJ+F1CLrKKv=Kv_Aagii4B5eATmXoKGz0ka5-m82+Eeq0uknvA@mail.gmail.com>
Subject: Compiling QEMU with different optimization levels &
 -Werror=maybe-uninitialized
To: QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi,

Depending -Doptimization=3D<value>, I get different results (GCC 13.2.1)
- g: produces -Werror=3Dmaybe-uninitialized errors
- 0: clean build
- 1: produces -Werror=3Dmaybe-uninitialized errors
- 2: clean build
- 3: produces few -Werror=3Dmaybe-uninitialized errors
- s: produces -Werror=3Dmaybe-uninitialized errors

They are about 20, probably false-positives, although it's
understandable the compiler is confused as I am too sometime!

Is it a known issue? Are we willing to help the compiler in all those
optimization levels? I can send a patch series for review in this
case.

thanks

--
Marc-Andr=C3=A9 Lureau

