Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D1DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 23:09:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3jSj-0001wJ-S4; Tue, 30 Sep 2025 19:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3jSh-0001vb-PW
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 19:08:47 -0400
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <salil.mehta@opnsrc.net>)
 id 1v3jSa-0004BZ-3X
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 19:08:46 -0400
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-43f4650340eso1900525b6e.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 16:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=opnsrc.net; s=google; t=1759273714; x=1759878514; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JutWE/BW8xjSP9Os/HWnR89kLZJpdr3odH2i7rcP+64=;
 b=RyzkA7FJlT1ZfZwENaZL4dez2ZoV6cV0G+TAFBBttzReTjNCyPl9XJYo5/N9COI3OT
 IDVBNXCErpwmAkH5lPOoOjLq0gcARUpYh8UpFcaVHrUITxoDlVGDBAVTeDclxvsof4pV
 He8yxeILjZMXkwBNpszhyqhLzVhToMqG46pZtNwWHdL+FwGLcQSsipGDuEJGvvaJlVN8
 gMyn2smlKBHU4MuF1PqwypoGjDhi3g3CvdRgnhJ7oIhAPS+XgV9LVhW3Dcg6hOEPZ4mI
 eQqe9O4uTp5rNDLj7lgD/LR/6GJKtRhyVj/5Bu9/QSaSxywxVx+auskWLaQy63vrL+n+
 552w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759273714; x=1759878514;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JutWE/BW8xjSP9Os/HWnR89kLZJpdr3odH2i7rcP+64=;
 b=iTr66oLHAGLEtgS8JO/ngetRBL/3ELdfRTbzGYFgGkWpvDlD13r0+XeAsqte+sRFxN
 IGXfI/XVHbCZ+WYED6oSMpYkybJArZ4NV8ZexiqO+w4C2H9pzH6F9bRL+0qG0z9cbBPw
 7BMtPdJdONlWvWf/9Bb37t1X7XCRo3F/TqYyQbUS4BqlYEdN+Lo2TAaWjQaz62FqBxzv
 o/jkrekz1u+gKCiOcCvzU6wAtbCDVkUs23NVtGrX/ESbLTnqH8djmmS3c5/9+1Z20gnW
 rBpgxU5mtBNkxUJQElHGRY4CVrTXMf/anj61lX9txoXTRhPfIfEWEQruWaWC5D+jDhc+
 5B6w==
X-Gm-Message-State: AOJu0YwxdmR1pC9av5zs0f+KlhCuTi6KNJGQq0DfcGNNr6XsY5Ndq8LH
 xzlf8pP/zcQdwpMMaGkSxf80PsQDvWLcSda8BcjMA9H7eO74aH+wUB6RYSJtJKMnRMTP7xmPT+I
 uAQMPNCKWpJCMvgMYE5alkCv/3Tq3DOJc9Mvm2GcvVFzBwR86dd0ztJQ=
X-Gm-Gg: ASbGncvDg/ryHlWDGDrrgpVZDv9+HlvR29fBkZqNsIqXQ3EPma4tPkDVwjpvXiiP+/Y
 KxXCScMcKzCeiSd7RUvQqi7r1V1cZJJ6KI4SotCH/03lprj/ZAz9qRU6ZBViu/eDsjLBHcFH8CF
 vyPcgzr39GyAAZ6LpV6CVIZfVBHO/iSFkjvkDyBS8j+aCNzryVF7oND5uWWFxTmWbTe9Ck37YQR
 dBWDCA5AH5wTygDXQ0naSWXkU+OS1SRkBj41z7PHDotNs1CAq+VI5uhLmLOxo8nebf/9GeISjuE
 Qga2tNbA3QSZ
X-Google-Smtp-Source: AGHT+IETsXGbRDxsazooza5Bsm8ioHhl+GpQiDiUF/aZZ7YWTbil1j31ERfm1h+mwrgq1Q/s5jpvmDrqDVldHpN+JpQ=
X-Received: by 2002:a05:6808:1b23:b0:439:a7bf:4b2 with SMTP id
 5614622812f47-43fa41ccef0mr736391b6e.39.1759273714439; Tue, 30 Sep 2025
 16:08:34 -0700 (PDT)
MIME-Version: 1.0
From: Salil Mehta <salil.mehta@opnsrc.net>
Date: Tue, 30 Sep 2025 23:08:22 +0000
X-Gm-Features: AS18NWAc0ZFouzSf5LNyZjsvnZmmDB5MJcplYW9xYgIhQbZJyId1jue7XDQJdlQ
Message-ID: <CAJ7pxeZ77vBOXrPPkDwYuk4amo8xtSjxxOspVZUUhQn5mVGA7A@mail.gmail.com>
Subject: test email
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000cfe8fc06400cd4c0"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22f;
 envelope-from=salil.mehta@opnsrc.net; helo=mail-oi1-x22f.google.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_05=-0.5, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
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

--000000000000cfe8fc06400cd4c0
Content-Type: text/plain; charset="UTF-8"

test email (sorry for the noise)

--000000000000cfe8fc06400cd4c0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">test email (sorry for the=C2=A0noise)</div>

--000000000000cfe8fc06400cd4c0--

