Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782FEC4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 10:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZqR8-0000aS-Q6; Tue, 13 Feb 2024 05:54:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZqR6-0000aG-10
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:54:48 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rZqR4-00050R-3o
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 05:54:47 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-51183b02564so920751e87.0
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 02:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707821684; x=1708426484; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYKMRwPvPt+gbeCzWS3ITC3zUTUIXvjqbpebJ36/kuY=;
 b=BDj0YHJ8qtZhPIh2dSxWs1MGyDQ57+yAwFXRfmMxVqipJ7zLj+cRBq2oesSrvCmM2o
 U56wM4SgjzCHlQzvKiYVGphspTA98khByZk9roNL/bTcw1ZBAUjybE7fFRJohZCCl45Q
 m2RncEKCLTHsBsiMMQ3cEqIzOIGwckc6SO1zyCKUsDLOuGOovVdbFV5ljoZwV660ZSVW
 a4Isx+xbhomXQlAB6Sg4MgFzxnVxCSSanml3QEFcX+Q6yD9zgy0g4QpnuhSYBGGcvXwe
 c5Zh6ACsC+BBpnyQvkqhvhOYQd8ePX0LejIhiEUhx+ertYRcZ1qJYGxGM6bHYPaOCilf
 DYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707821684; x=1708426484;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EYKMRwPvPt+gbeCzWS3ITC3zUTUIXvjqbpebJ36/kuY=;
 b=XPSvHAvA2EchiTCP5RqLLerkqP2o0WLg8xgESgzNsaoHevEEVH0WAY8Soa5+LlgEvA
 ogU43XK7YpDYH5kPGZ6EIfsXndEOFtBdaaQK72drM9TCTGLgy3IW9mIhFYV2IiZi3bbi
 i/xi5ac97N3+witvIyu6cpU6V/PwKQPVuhRsrKHzLxkEYTZvamdMLNzUogZrIBUYZD+d
 ycx4YE5pTI+FhQ7dhNsIgwpkJmRu3WWub4k08nYYCykyu+5bTfafUkskyXKv9v478zoj
 COO9Q90N622TP+z32Qp0vbjA7vypob/AjeXSiAX2Fdtk0ngfopWFi92OaNl07798d3lj
 6cdw==
X-Gm-Message-State: AOJu0YxpfcyTgT98faFjtHD7BVopuCQr+dA6tAj174ccxGREEHsgF+PY
 sx0dvh3l5LPSqavzc4Tidhd2mScMbyDEjcaz+Ge3VVxxPia0ZPTeS7y1te5TJXzmXDpHCpESFAu
 3vVM6Oky5T6QIDuGQo0pynmcHK+zb2Awu2kuahQ==
X-Google-Smtp-Source: AGHT+IH5Hcedp5nS7whtwyeJogTOm+CLlb+DNpWse6ejrfxIly5K4MHGjISrn9md+jWfzWTq6uZsLqX/HboPYdc3Qt0=
X-Received: by 2002:a05:6512:ea4:b0:511:603e:7afc with SMTP id
 bi36-20020a0565120ea400b00511603e7afcmr7981206lfb.46.1707821684103; Tue, 13
 Feb 2024 02:54:44 -0800 (PST)
MIME-Version: 1.0
References: <20240212085142.523317-1-armbru@redhat.com>
In-Reply-To: <20240212085142.523317-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Feb 2024 10:54:32 +0000
Message-ID: <CAFEAcA9zTjesN+6CxcG1EGmVzwmrt7kdZMCPY7K1ibwO02MbMQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Character device backend patches for 2024-02-12
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 12 Feb 2024 at 08:51, Markus Armbruster <armbru@redhat.com> wrote:
>
> I offered Marc-Andr=C3=A9 to do this pull request, and he accepted.
>
> The following changes since commit 5d1fc614413b10dd94858b07a1b2e26b1aa029=
6c:
>
>   Merge tag 'migration-staging-pull-request' of https://gitlab.com/peterx=
/qemu into staging (2024-02-09 11:22:20 +0000)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/armbru.git tags/pull-char-2024-02-12
>
> for you to fetch changes up to 684d03acff6096b8ae79da0fcd6194238827c67e:
>
>   qapi/char: Deprecate backend type "memory" (2024-02-12 09:39:38 +0100)
>
> ----------------------------------------------------------------
> Character device backend patches for 2024-02-12
>
> ----------------------------------------------------------------
> Markus Armbruster (4):
>       chardev/parallel: Don't close stdin on inappropriate device
>       tests/unit/test-char: Fix qemu_socket(), make_udp_socket() check
>       qapi/char: Make backend types properly conditional
>       qapi/char: Deprecate backend type "memory"

The new test-char test fails on the x64-freebsd-13-build job:
https://gitlab.com/qemu-project/qemu/-/jobs/6155393879
https://gitlab.com/qemu-project/qemu/-/jobs/6158373424

652/850 qemu:unit / test-char ERROR 0.14s killed by signal 6 SIGABRT
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95
stderr:
** ERROR:../tests/unit/test-char.c:1218:char_parallel_test: 'chr' should be=
 NULL
(test program exited with status code -6)

thanks
-- PMM

