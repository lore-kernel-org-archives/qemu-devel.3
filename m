Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90723C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:02:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmpwk-0003WD-Na; Wed, 20 Mar 2024 03:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmpwi-0003Vq-DS
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:01:08 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1rmpwg-0004rl-OH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:01:08 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-609ff069a40so75203047b3.1
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 00:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710918065; x=1711522865; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EgA/RoSDD92C1lm2cc9wCVJeqV18BxuBCchTTG3+6PM=;
 b=d9I8EXz3wy+lduA5lFURAVCy6jSgatBPdO1wM0uP2Sd4aNTgW2dHTvvfMuUoV8sVOQ
 LK7yS9MGFQTStgQ/I7knCHY8egixdtr9SHxoHVhShb+20SPl5HECKn72upn3c5iZDt8W
 K1sfD5DymPRDFjMg6jW5W0U6Wdp2hPpugG77do8mYSjcm0E85jDxNRZBK4SpZoCV+d68
 UscqSYPPJih232y2uh11Rf6MMSketoqCvPh5OSJck4+oVStwmwaol53dgq5+avz6A2oC
 Vy8IGyWUswcnNDr1nxvrB6vTmYpHpRcPgyB3yYUCilK3fbzf952JujCSZjmM6tXv849V
 lLnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710918065; x=1711522865;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EgA/RoSDD92C1lm2cc9wCVJeqV18BxuBCchTTG3+6PM=;
 b=KxyUfMfS3JkqkOZD/NqZz33z3aOfe3vvAVXbQilzhVxvLtp7IqqvUmjHPP47JdCDrR
 7k6Ff9OPcjn7g13BqnUSkoY5C8aqM6PFpI/R5pcLSKQlTpIOwRToV/2unbhX7CZlxfiw
 jZLjcANYD+Fvvb2xr+y64Xs3/6IXn3k/wZJi0P7D1Gvq5W+FjXk4TKnVSxuZL6TVOtLq
 zyJ5C4KUZ/26d3WKqUAd/t1PS6ABnUMkkaO+MZ8G+SLu2JDii+QsHlaiIcO/n3AC454S
 ulAMs+Gf3eg4pfcenhXKaRbGkT6Rs1RKbDls5YAbQY58WIImWqQkmPiAIK2IoiMsfRGQ
 2/Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJj79GgiSxf3P+BqBdkL9GXZNb5VnsKCL65QCLoPIwpO1J46JxnJn6nSNgyloIjfHPI6bw5BfaeaHcDVXHZh6XaVSsDlA=
X-Gm-Message-State: AOJu0YxzbXS8QJk5pOfcXWL8XlgdqxWWV7fUTsGUJR8K6MovnMuN1gT5
 jN0m7lSHIEB3gYmVTLnQkHla2CnU8Q0bHNYerSHuRP9YbGlsO0gp/5fGuEAfMqHZRxQdxX+cG2J
 YRMhFEJxx+ts3DDGJgdT0rKXXWW0=
X-Google-Smtp-Source: AGHT+IGPkW6aawy8sDp2+LJxXNWfx2nceXrO0aNIF20/NYqbrhzb1Yq2UqGqilD1+MRbSmewXgM1/gVFTOlJa3Kt5Sc=
X-Received: by 2002:a25:a3a2:0:b0:dcc:4b84:67cd with SMTP id
 e31-20020a25a3a2000000b00dcc4b8467cdmr10795262ybi.9.1710918065503; Wed, 20
 Mar 2024 00:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240319-console-v2-0-3fd6feef321a@daynix.com>
 <CAJ+F1CKOuZR5nZxcxRzZyoE56p_nNW11cySEmnFvRgiPv5OAdw@mail.gmail.com>
 <5b8160c8-6774-47b3-a495-f7dc64ebd28d@daynix.com>
In-Reply-To: <5b8160c8-6774-47b3-a495-f7dc64ebd28d@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Mar 2024 11:00:54 +0400
Message-ID: <CAJ+F1CLP_LNwWQ_4M2w7cVK-DSBy6+92SY5m37fUnZMXN6oBaQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] ui/console: Remove console_select()
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Wed, Mar 20, 2024 at 7:20=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/03/19 17:29, Marc-Andr=C3=A9 Lureau wrote:
> > Hi Akihiko
> >
> > On Tue, Mar 19, 2024 at 7:09=E2=80=AFAM Akihiko Odaki <akihiko.odaki@da=
ynix.com> wrote:
> >>
> >> ui/console has a concept of "active" console; the active console is us=
ed
> >> when NULL is set for DisplayListener::con, and console_select() update=
s
> >> the active console state. However, the global nature of the state caus=
e
> >> odd behaviors, and replacing NULL with the active console also resulte=
d
> >> in extra code. Remove it to solve these problems.
> >>
> >> The active console state is shared, so if there are two displays
> >> referring to the active console, switching the console for one will al=
so
> >> affect the other. All displays that use the active console state,
> >> namely cocoa, curses, and vnc, need to reset some of its state before
> >> switching the console, and such a reset operation cannot be performed =
if
> >> the console is switched by another display. This can result in stuck
> >> keys, for example.
> >>
> >> While the active console state is shared, displays other than cocoa,
> >> curses, and vnc don't update the state. A chardev-vc inherits the
> >> size of the active console, but it does not make sense for such a
> >> display.
> >>
> >> This series removes the shared "active" console state from ui/console.
> >> curses, cocoa, and vnc will hold the reference to the console currentl=
y
> >> shown with DisplayListener::con. This also eliminates the need to
> >> replace NULL with the active console and save code.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >
> > lgtm
> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >
> > I am willing to take that for 9.0. Is there any bug already opened
> > about the issues it solves?
>
> No, I'm not aware of one.

The first patch "Do not inherit the size of active console" is not
directly related and may not be suitable for merge during freeze. Are
you ok with merging the rest for 9.0 or delay it for 9.1?


--=20
Marc-Andr=C3=A9 Lureau

