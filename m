Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C405C47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 12:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneR9-0004Md-2e; Fri, 22 Mar 2024 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneR7-0004MS-WC
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:55:54 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rneR6-0003vZ-8N
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 08:55:53 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a46cca2a979so127882666b.3
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 05:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711112150; x=1711716950; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R0/o/kh2WuTultZqA1awv+uqzv6pPlLUDjsLOe3YfL4=;
 b=RjIQeZbjScpke3K3IsP6uakibWEa3DQXLqg5VomwiZUP5BWPlJEAbXRWdoSUt6Vp7w
 fHj2io3RtA1UEi7T++2uWpPwEl+eeEW7yzXgE+pbVZLhARKFsrP6BhXtDhqzQtatn+gs
 8+i9XJIbxHOtq/bkmO0Est8ixpSMRrFDjPRZzBZPlWcvrxi4xd8PzrCa5iduCPKi3Slj
 4WnztFWlJjgczfu/bym+ylA1wF+1bdEYDlLTeFarbpuZ9LdUz1SlOmTUinz8JPlc4Jso
 xA4MJW1odTEmlK03Hnm3EZX88j4O6CIuupV9bLlZaXul7BjZPcGtmzYUSFWTDdV5euYX
 +q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711112150; x=1711716950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0/o/kh2WuTultZqA1awv+uqzv6pPlLUDjsLOe3YfL4=;
 b=nLgGkQ1hIqGUIZDv/g8umcGFAFP9JNwnYFoPFpS8vRuS+5HPPlgzT7ZFDiY/h7rVG6
 zeteyzWJIbfPtVB9/f9gVtdKF+hFI4gYDIQK8fIybQEMB89rcnl7gXdfcSfX9KWXVLIY
 kyHFMBdwK6SV4n2oWIwG3yxzafh/IhfJcqaaUlrwn9PfYWlaEDdA38MblyHwSo9dyQwg
 9WlF4qw/Xe1UF0VVJEVxAPjqwUnHHHooRTEBrnvbxd2jWB8eiDJIqPG3cNYDi3Oefc8l
 BCd4zpjtW/tWWfZuV2jpwqaweNjlcO1AopmEMCwEuUfQ5o0NBuApHmI+pXQfkp32hvP3
 RMnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7y2OJUN6kfWVU8SZ+yTY6GZLL8ZzGkAK3/Uy1957vMFsiCrBwOoc69ZRq3aRQhh5jy6f85J4v2fmtLw7x/4rZDeDhlhs=
X-Gm-Message-State: AOJu0YwyVoXt/Yi2WW3vGJT7RhVIXBin0hj6lPk+6Ivx/asPtL1ae1pC
 k/m8Wfk6y0soLc4MWiV8TYl1n3Qh+3jdqQ9rpKkvKG4i1VwRT38JHXl5yYyBHcAlaYWpLnGNPT2
 ui6m2g+ltT3Vjd6mFtB6LtP2+jgPLB3i3Ubz+4g==
X-Google-Smtp-Source: AGHT+IFAqb2F8Guzj56qR5qhCx3B1Duw3zTm+bb1hiUwwa7dSvGOZiiUyE6tceOXwt17srQMMiWUdu27ubWXucZBjds=
X-Received: by 2002:a50:f603:0:b0:565:f7c7:f23c with SMTP id
 c3-20020a50f603000000b00565f7c7f23cmr2040500edn.3.1711112150044; Fri, 22 Mar
 2024 05:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240318-fixes-v1-0-34f1a849b0d9@daynix.com>
 <20240318-fixes-v1-1-34f1a849b0d9@daynix.com>
 <CAFEAcA80J1zDs1odrHmJGm0sjcg1O_rS0N3su4Gvq+NNLpaUXQ@mail.gmail.com>
 <805177eb-7cd4-463c-9d01-c955d6b91cf8@daynix.com>
In-Reply-To: <805177eb-7cd4-463c-9d01-c955d6b91cf8@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Mar 2024 12:55:38 +0000
Message-ID: <CAFEAcA9YedzrYosLLa0PaqS72Bq6XjM8GBmUrQwmzD3tC-Ecjg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ui/cocoa: Fix aspect ratio
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 22 Mar 2024 at 12:25, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On 2024/03/22 21:22, Peter Maydell wrote:
> > On Mon, 18 Mar 2024 at 07:53, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >>
> >> [NSWindow setContentAspectRatio:] does not trigger window resize itself,
> >> so the wrong aspect ratio will persist if nothing resizes the window.
> >> Call [NSWindow setContentSize:] in such a case.
> >>
> >> Fixes: 91aa508d0274 ("ui/cocoa: Let the platform toggle fullscreen")
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   ui/cocoa.m | 23 ++++++++++++++++++++++-
> >>   1 file changed, 22 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/ui/cocoa.m b/ui/cocoa.m
> >> index fa879d7dcd4b..d6a5b462f78b 100644
> >> --- a/ui/cocoa.m
> >> +++ b/ui/cocoa.m
> >> @@ -508,6 +508,25 @@ - (void) drawRect:(NSRect) rect
> >>       }
> >>   }
> >>
> >> +- (NSSize)fixAspectRatio:(NSSize)original
> >> +{
> >> +    NSSize scaled;
> >> +    NSSize fixed;
> >> +
> >> +    scaled.width = screen.width * original.height;
> >> +    scaled.height = screen.height * original.width;
> >> +
> >> +    if (scaled.width < scaled.height) {
> >
> > Is this a standard algorithm for scaling with a fixed
> > aspect ratio? It looks rather weird to be comparing
> > a width against a height here, and to be multiplying a
> > width by a height.
>
> Not sure if it's a standard, but it's an algorithm with least error I
> came up with.

OK. Maybe a comment would help (at least it helps me in thinking
through the code :-))

 /*
  * Here screen is our guest's output size, and original is the
  * size of the largest possible area of the screen we can display on.
  * We want to scale up (screen.width x screen.height) by either:
  *   1) original.height / screen.height
  *   2) original.width / screen.width
  * With the first scale factor the scale will result in an output
  * height of original.height (i.e. we will fill the whole height
  * of the available screen space and have black bars left and right)
  * and with the second scale factor the scaling will result in an
  * output width of original.width (i.e. we fill the whole width of
  * the available screen space and have black bars top and bottom).
  * We need to pick whichever keeps the whole of the guest output
  * on the screen, which is to say the smaller of the two scale factors.
  * To avoid doing more division than strictly necessary, instead
  * of directly comparing scale factors 1 and 2 we instead
  * calculate and compare those two scale factors multiplied by
  * (screen.height * screen.width).
  */

Having written that out, it seems to me that the variable
names here could more clearly reflect what they're doing
(eg "screen" is not the size of the screen we're displaying
on, "original" is not the old displayable area size but the
new one we're trying to fit into, scaled doesn't actually
contain a (width, height) that go together with each other,
and it doesn't contain the actual scale factor we're going to
be using either).

> >> +        fixed.width = scaled.width / screen.height;
> >> +        fixed.height = original.height;
> >> +    } else {
> >> +        fixed.width = original.width;
> >> +        fixed.height = scaled.height / screen.width;
> >> +    }
> >> +
> >> +    return fixed;
> >> +}
> >> +

thanks
-- PMM

