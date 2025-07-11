Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A99B9C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:34:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCwQ-00086V-5X; Fri, 11 Jul 2025 08:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaCwK-0007rP-0Q
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:33:20 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1uaCwH-0005Ix-02
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:33:19 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-874a68f6516so185686639f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752237193; x=1752841993; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LW1lYEiAMLIEUwxfqjqDWqr5o3JxEe/oQ91DIyFoNMU=;
 b=BuUUs+2cgNYYoJU7n1Ky0fKA0lDPEjdHMy4vLpA+tTacoIT+lxZ13RmwSd4O2Ua75k
 /lmHJ9ryyUHHEqDwz+wgeu40DWstn1ElROh3gvK+bKOTFzUCTHRHY4+Me/TALtpUXJo+
 gOjeQV08hhite1A7GaY9Py82LadaXy735crlma9XV1CoLOhRaZDG26Xk5zmbyssSQ+L+
 OfhYFgX6vZpPAWj4wgdaBuIVnOpZ62aMsIodrnfjSIygm4HjIbi1A/azt+KXPqzSXVrs
 KeCOMnohHt+jCrZZRzRG+KDQAPBLn1x8jUCJE9PJ3ATC6+DagAtqu7MO2iq2RpzFhN/i
 d7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752237193; x=1752841993;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LW1lYEiAMLIEUwxfqjqDWqr5o3JxEe/oQ91DIyFoNMU=;
 b=W3QKMzXdMkNlpbthTYQ/CQ7cLhhhlc5duUkqNqxXDJNqqs3guTTc9cj68qku1LmIlR
 4h120EgT+KmpoOhY3eMmt6F7jReu22StDZefFFZFs6m4yDxUPcWo3oEyuuzWt5r99+eo
 ohjnWN4r3XCI0HWN/u/2VIQsyWfSgDbVbe6G8hgpV7vNPFZwBJeGXvKr97S2yYH/ZPPA
 cf4bvzRJKR+uXn6dR1HX9oLeesFFPLQrwU6V5tf2wtG+WlCjBKnyp0RkuG7qfo+9t5MG
 dVuQcwoaz5xK2Z5Nlj55Kn30f8Y3wIwB3ai/PfBB5H2IC3ShZy949Yfa8Mplunow3xsh
 nong==
X-Gm-Message-State: AOJu0YyHNm89GGSylSaakAY33U3hAEqxoJX5R5biYSILwH2r8atF9XmA
 aoK4HboV0RYW3Hh3FMWaId/sVaJfco/egAzvQV+QJO04U6rdPXinDQUndc3H/E/oxZclu5koSTt
 +cDQxvMVJiHJBe2xgpoarLxjXfRmjGduzkw==
X-Gm-Gg: ASbGncuQ0DuJ9M4vabBkv/guVMKprw7C0nGkXAjyj84F4aX15mREWeW2Bu+VcQmo2Yf
 Q6QJbmL+27jdwMkxw1lAUZIQZAV7aXGeIm6Utz7iieKep7GhZXChwOUz7Gg/Rnm1UU2TSFb396L
 EGsdbp3hs4DIZNJBZd4yHsLf6hh9RQ0Z4Ad2QxB8BpT1ZuwMA4z/YsF3e1Nair6jVDZk7T3Nr+c
 l+uopaq
X-Google-Smtp-Source: AGHT+IEuw47HSBfq1N/uF4qXuWS8tarUgJeRwxnHoKCSSR06tB4Fz2PmCSTGIwk1upPyyJ5l0yhDK+kkNpz3wnS7RXk=
X-Received: by 2002:a05:6e02:152d:b0:3d8:2085:a188 with SMTP id
 e9e14a558f8ab-3e253278dddmr37447225ab.1.1752237192748; Fri, 11 Jul 2025
 05:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250711110626.624534-1-jcksn@duck.com>
 <20250711110626.624534-2-jcksn@duck.com>
 <CAFEAcA8Z4OVDXUO+ZNe4sv2u=_vtuK_yv4vX44LjsiZKpjz4dw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Z4OVDXUO+ZNe4sv2u=_vtuK_yv4vX44LjsiZKpjz4dw@mail.gmail.com>
From: Jackson Donaldson <jackson88044@gmail.com>
Date: Fri, 11 Jul 2025 08:33:01 -0400
X-Gm-Features: Ac12FXwBX43gmsPck6hLX6HUi5qurFG_XCE4QS2xRwGguyn3EaMBBAJnIhnUUAA
Message-ID: <CAMyd1rRsf+ZEx9ZsHosOnMuEyQVK5TvOKZytm+P08CphByR2LA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] docs/system: arm: Add max78000 board description
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000006fa4620639a68388"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=jackson88044@gmail.com; helo=mail-io1-xd36.google.com
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

--0000000000006fa4620639a68388
Content-Type: text/plain; charset="UTF-8"

Confirmed.
-Jackson

On Fri, Jul 11, 2025, 8:29 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Fri, 11 Jul 2025 at 12:06, Jackson Donaldson <jackson88044@gmail.com>
> wrote:
> >
> > This adds the target guide for the max78000FTHR
> >
> > Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> > ---
>
> Checkpatch wants an SPDX line for this new file -- can
> you confirm that I can mark it as GPL-2.0-or-later like
> the C files, please?
>
> thanks
> -- PMM
>

--0000000000006fa4620639a68388
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Confirmed.</div><div dir=3D"auto">-Jackson<br><br><d=
iv class=3D"gmail_quote gmail_quote_container" dir=3D"auto"><div dir=3D"ltr=
" class=3D"gmail_attr">On Fri, Jul 11, 2025, 8:29 AM Peter Maydell &lt;<a h=
ref=3D"mailto:peter.maydell@linaro.org">peter.maydell@linaro.org</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">On Fri, 11 Jul 2025 at 12:06, =
Jackson Donaldson &lt;<a href=3D"mailto:jackson88044@gmail.com" target=3D"_=
blank" rel=3D"noreferrer">jackson88044@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This adds the target guide for the max78000FTHR<br>
&gt;<br>
&gt; Signed-off-by: Jackson Donaldson &lt;<a href=3D"mailto:jcksn@duck.com"=
 target=3D"_blank" rel=3D"noreferrer">jcksn@duck.com</a>&gt;<br>
&gt; ---<br>
<br>
Checkpatch wants an SPDX line for this new file -- can<br>
you confirm that I can mark it as GPL-2.0-or-later like<br>
the C files, please?<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div></div></div>

--0000000000006fa4620639a68388--

