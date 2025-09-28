Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5BCCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 23:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v30ww-0003PO-E3; Sun, 28 Sep 2025 19:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30wt-0003Mn-6H
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:36:59 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v30wc-0006r9-Ac
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 19:36:55 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-afcb78ead12so681972166b.1
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 16:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759102598; x=1759707398; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DIDYxo2FOigbwhuw9xpTc9C3BNw4sDCTeBxli+pKHU4=;
 b=P+sYes1jOrx/uq+mEjnt+IqpcRdmWcKl03a9BcKwDw2PpcfJrEJGOqzUQYnbO9+yZp
 qMF+k8982X4dOMR9on9PSZNJhetz4BMrB83+pjj/FQLoORPDiJJmzaHyj0N6DfECqqcn
 r8wJ3rvCX0mbvXdKoHrkjzbXd3gHi3xmfRmh+Vl5fZBsW61W6VeBerT+t4p4HvDzBrs1
 LLhLX5kcCn7gotLM5ffTNc5EAp6woXUZljT09EnHy61oNglgoKMRQnCod0Qr2wJqzOCb
 mlibmQkFhsYKFknW98mJx78hlqkMhy3kFGHflTAmrMI77y5VvgkQf0p5NFFMS0Zv9XhB
 ulKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759102598; x=1759707398;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DIDYxo2FOigbwhuw9xpTc9C3BNw4sDCTeBxli+pKHU4=;
 b=Cp/aLophuJ/W+ba0Zq30/zjKSem4U8ClSZdyEnPJRHtaQGxTYjYomFolxgoOKj10wH
 WVZyyvs4BDPp4fQN1fIKx0GCuzIFdf14MVQxnjicwUgP8/rpjrX8AvDRg7cWo2rEVBWk
 r81+8yfVwAySNC5PNke5R0UxwoV8IOFK5GPK5rwAGgKNqGRK4lfkJHmGM7WVvc3fMPU4
 JT0Qlc1DBcYQwqYuv6esJ5DyRTjXxseYIrZvRC2weJ7mPQvI28M3qqH9NehDrRVajpcv
 orq8sNKtQ0Ep6UgvCbhgJnLabjsB+jr3GBbmWjRQyYVO0WSjCwMszQ0xqD+rQQPezHDK
 AEhg==
X-Gm-Message-State: AOJu0YwjeL7kNhxmg2Rju7RB7GDHp/5uWM3u51YOaK0Fhvssr9rLdhGm
 AgNRfBwf9QBQSGzv/tDYM2zIaorn9vx8srjJBwXKmYUFmXVUfCs3xS4qKfUytQY2Ny9cvNmh462
 HiA6V+YSfeWg4G5ke2UMUo7spd0EBS+k=
X-Gm-Gg: ASbGncsq5shZ68amnIOsdnnBlqjo5AZxs2O1V2WCweHce4cKFFkvPqXsBQOxLqfyURk
 9tI5LBDqEvhfbGlJDBb0XMVjDJrK8WUMNWMxlGqWpQ6RVZXO3aJFvE6uDvzuGosNbuWTGpjrV3h
 RXtSNUwkqjFkpPyFkChaxhuVJFAlm2NZ4Jck3v3pIkcNHbyEtm3jeYoeYvU9cJKnluhyht2rE8g
 NAdh8/tN2ot2qJuL9GAZZ/SR7xZZBlcCJb3MssdcngVOp9G
X-Google-Smtp-Source: AGHT+IGS6xjUy9NrIjjjuIOlng0TP+PjJKRa9pRJowuYGTcv51U7pfHmAFefffNbfPBJbmPsQeZcLjA9WgTKRjgJWQw=
X-Received: by 2002:a17:907:6d29:b0:b40:52:19c2 with SMTP id
 a640c23a62f3a-b4000521c0fmr6326666b.20.1759102598299; Sun, 28 Sep 2025
 16:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250917114450.175892-1-luc.michel@amd.com>
 <20250917114450.175892-6-luc.michel@amd.com>
In-Reply-To: <20250917114450.175892-6-luc.michel@amd.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 09:36:12 +1000
X-Gm-Features: AS18NWDneHVg80SmJ-GzTzTwXjkOkvtiUAs27YVcERIJZaDU0qaQWhngnGP8_gI
Message-ID: <CAKmqyKO4iLMLtyiRY6cas2Wnn3GM+qcCYJ9SBv7f83RtHM9pSA@mail.gmail.com>
Subject: Re: [PATCH 5/7] hw/net/can/xlnx-versal-canfd: remove unused include
 directives
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Sep 17, 2025 at 9:49=E2=80=AFPM Luc Michel <luc.michel@amd.com> wro=
te:
>
> Drop unecessary include directives in xlnx-versal-canfd.c.

unnecessary

>
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/net/can/xlnx-versal-canfd.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canf=
d.c
> index 3eb111949f8..343348660b5 100644
> --- a/hw/net/can/xlnx-versal-canfd.c
> +++ b/hw/net/can/xlnx-versal-canfd.c
> @@ -33,16 +33,12 @@
>  #include "qemu/osdep.h"
>  #include "hw/sysbus.h"
>  #include "hw/irq.h"
>  #include "hw/register.h"
>  #include "qapi/error.h"
> -#include "qemu/bitops.h"
>  #include "qemu/log.h"
> -#include "qemu/cutils.h"
> -#include "qemu/event_notifier.h"
>  #include "hw/qdev-properties.h"
> -#include "qom/object_interfaces.h"
>  #include "migration/vmstate.h"
>  #include "hw/net/xlnx-versal-canfd.h"
>  #include "trace.h"
>
>  REG32(SOFTWARE_RESET_REGISTER, 0x0)
> --
> 2.50.1
>
>

