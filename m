Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B72C02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taC04-0005ha-Dw; Tue, 21 Jan 2025 06:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1taBzs-0005aC-Li
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:00:41 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <titusr@google.com>) id 1taBzr-0005Xk-2u
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:00:40 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-53e3a2264e1so13286e87.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1737457236; x=1738062036; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zndr1XYkJikd7VIgMXUsHDwmWp2anajoRq+WP7WaRSw=;
 b=DPmmjFoZh/eMEAX6dn1ssuB2JvnRYX97k+Z+J8Dczs+1aSFHpU4SLTgjHJgMpmUnEh
 hFl3XTbKNxAKjrb25BoHGSzJbdEZWkVeJ1Q6inbZKNXSVsXdGcknZhNYEopEkbNQu4/A
 XWbbI4F10poWmpt0ocF3CK3mh0sB13QHaw73Hxy+i0ZtOn22Brl9rkfozU6HoBwKIyot
 8OGTPVWnxR/Cl+qwfhNOL2dkm5kzX1abc+6TI9r2rXjhIuZ4AvX65yUkngFrHFWBi9fw
 0uR1nDzxmdbh49K1vKH728zi0uAY/6r3jQFD8A5fiP/fT/L2k3Wb+79RdK0vtHRRPwt4
 H0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737457236; x=1738062036;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zndr1XYkJikd7VIgMXUsHDwmWp2anajoRq+WP7WaRSw=;
 b=CHuGQMh74kT7c3HWWEvgGkj8x5fTMre5UJ/HZN7TDdZW78+Aq6FGX4yoR+xiz3XZO0
 WmDod+J0357wB4f5fJaaULl206tDaFT2fEV1TpiJcIN9NMs1fQXH8D6c2tDwVR7K3Zko
 /cADXSHkqvlHxBSZlKxR/GLoz74e7bzcSfTFmOvu7mRCQQKdlB7v+Csj65qJeaqkO9vo
 CfFgZQVmCYWkpFz88QCNW1LHxowsktDAdCZcDneNyS17yhMyhsnkPcybRuT0VFi3SQuu
 53pTfCjmyZdPjUcMiqrHOSrIZ2/qMOLm1WK2dixZUcGhei1wBNupUsDMTMnmkfpwFEEw
 0hcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLNRvcavwgUNulYp0miZp3RyUh6qGmNY6C4aQmGe27HhfWru0TXtbEBXbgXK6wffxgzyTqKuvTnlk8@nongnu.org
X-Gm-Message-State: AOJu0Yzu69KUcuykXHEsQJG51c5eEQh1f3cWbJG/eu4cD0pIJsJN3UJT
 b5VTwTNq8GiK5yvOZwHDPaMzTEi4J/0eFTqDZOlieVOV9lxR/FMdFQ8kh6ICubwEVA4lEZ27Oqq
 zV+i6sjxGioEX9Tq5SvVKXJnoWnrSOvE5A9ZX
X-Gm-Gg: ASbGncvSiE2tApA2CIY49Oh4AIHvwe4GzXJH9QfDSxRLAW17j3xvn7lwSGm/I7OJ/X1
 +5v6avkMJdMgpNtf5dr6t68JIL/fvJxpYFiNVBAHqYbaGv+369ms=
X-Google-Smtp-Source: AGHT+IFfiI89Yexpjqfw43+c6pIkjSM8ULHxeQtrXemhLODGKs8MijRC8DUxX6B3hd0FkUwTlCkIPdz7adJ140kA49s=
X-Received: by 2002:ac2:44c1:0:b0:53d:e822:ebaf with SMTP id
 2adb3069b0e04-543a3b7bfadmr449243e87.4.1737457235897; Tue, 21 Jan 2025
 03:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20250121103608.3056288-1-titusr@google.com>
 <bfa02ef0-12a3-46b5-9749-c9e367145dc3@linaro.org>
In-Reply-To: <bfa02ef0-12a3-46b5-9749-c9e367145dc3@linaro.org>
From: Titus Rwantare <titusr@google.com>
Date: Tue, 21 Jan 2025 02:59:59 -0800
X-Gm-Features: AbW1kvb-boAJNdBhMF-t1O54wCt4BYwbJKw8R_3EYw55ouj2y-NVuKWYSMY7srg
Message-ID: <CAMvPwGo=5vZRwDvkefEQ-5ooHHvagTH_6yHQ1EFbBpCD+CX1yA@mail.gmail.com>
Subject: Re: [PATCH] hw/misc: i2c-echo: add tracing
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: minyard@acm.org, its@irrelevant.dk, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org, clg@kaod.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=titusr@google.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

On Tue, 21 Jan 2025 at 02:43, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Hi Titus,
>
> On 21/1/25 11:36, Titus Rwantare wrote:
> > This has been useful when debugging when unsure if the guest is
> > generating i2c traffic.
> >
> > Signed-off-by: Titus Rwantare <titusr@google.com>
> > ---
> >   hw/misc/i2c-echo.c   | 13 +++++++++++++
> >   hw/misc/trace-events |  5 +++++
> >   2 files changed, 18 insertions(+)
> >
> > diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
> > index 5ae3d0817e..06110e0f8e 100644
> > --- a/hw/misc/i2c-echo.c
> > +++ b/hw/misc/i2c-echo.c
> > @@ -13,6 +13,7 @@
> >   #include "qemu/main-loop.h"
> >   #include "block/aio.h"
> >   #include "hw/i2c/i2c.h"
> > +#include "trace.h"
> >
> >   #define TYPE_I2C_ECHO "i2c-echo"
> >   OBJECT_DECLARE_SIMPLE_TYPE(I2CEchoState, I2C_ECHO)
> > @@ -80,11 +81,19 @@ static int i2c_echo_event(I2CSlave *s, enum i2c_eve=
nt event)
> >       case I2C_START_RECV:
> >           state->pos =3D 0;
> >
> > +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_REC=
V");
> >           break;
> >
> >       case I2C_START_SEND:
> >           state->pos =3D 0;
> >
> > +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEN=
D");
> > +        break;
> > +
> > +    case I2C_START_SEND_ASYNC:
> > +        state->pos =3D 0;
> > +
> > +        trace_i2c_echo_event(DEVICE(s)->canonical_path, "I2C_START_SEN=
D_ASYNC");
>
> This patch is doing a bit more that what it describes, since now
> START_SEND_ASYNC returns 0x00 instead of 0xff (besides updating pos).
>
> Please split as one patch per logical change.
>
> Thanks!
>
> Phil.
>

I've removed the async case from the patch as it's not something that
has come up.
- Titus

