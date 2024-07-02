Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63B3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdRF-0006H4-SY; Tue, 02 Jul 2024 09:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOdRE-00068F-6d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:20:52 -0400
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sOdRC-0007XP-Ju
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:20:51 -0400
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-80fe70b6babso1097778241.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 06:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1719926449; x=1720531249;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FP0o/2aVS7a4V9l6UTHhYeTAY8mKr/PMcpwBWWp1qJI=;
 b=RlGo61ypX0VGCXto/HwjzpjiRwdTVD58xvz3NaHsATS3D/bkwl+t164GWG2eMJ8/v7
 7zqfDQqcIhjGInW8fTbHVLUxIU9LktZrsQDF1HdhhF3vZYzIoPNWqVR0qkPf77AA+d8b
 R7mVQrqPkJ8XE1q5emWdAgiEIUQ4X35BA1UqgYx0+i8OaO3uqhx82yXxAHwxSv5kk+EL
 nRW1r5+PryqY5efz7rMstRGd6eTzAQ64BnHZCtzZ8QWZXw5EGO4t0eaQme8vaid7RvA+
 qfj8zAU19YKlgOF+KUombsqkLxR1EMU8cM83VJ0cqFwpbCJGneoPyaYwyNEmkL01CJrO
 sv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719926449; x=1720531249;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FP0o/2aVS7a4V9l6UTHhYeTAY8mKr/PMcpwBWWp1qJI=;
 b=f7Wff8FE+hQZOI49+yI8KF+zO5HHVOyZGHNx2wsArqxYTl/E0B7PeUyQ9KPgK+yCx/
 vs3HdGfSEJAlN+O0hGjd596sKcOF6qrKwKEJdeMJk4uh3Z5QrSk8QSZQjQMCgItAQFeH
 OKoUGMIX9Tg8uW3L+xv6teYoFYPLJxSUy9b4uqgFLFEw6ZklJ6w8E4avE4g3cVyPcGpI
 RWZ2oW9IncoSZv3ld3xC8FjIFPDLO8aMLW1+1C7vhJtHJ8Ag7IDHUSgtSkGIQuY4QrI3
 QSgCLWGp8wGldTUYxklLyoCqvfm4E+iu2Fkm8xhkH4FqnEDbQ4xkxH8UjZLeTU79z5sq
 GfUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwYYLgx66DOr4u1yLanxIokpy3TwtD9C/yVGk+rVg7MJy2eCfg8uha7lh/vV3Vv4IjN3hHyFWPPnZda4/zhnlIVqF2LyM=
X-Gm-Message-State: AOJu0YxXoTFB7t79N+zddo/VqIP0gr1cuSpG4LBV5nyG4xCPebHh/bv4
 cb7HPSbyJjDQEA8d5p0Fr8jOJJI5QbAN7Opq3uG5da5w7PbPMQ5WYl7MXuJYAi+KK2Svmyloloa
 l0HaNi9UMqMF1+0qPXMnD3nvLWdVq6Lsejozi
X-Google-Smtp-Source: AGHT+IH2F4KxQRrgRaeP2amWH5Rb/7h3kZOZ3fVI9e1+4GFPHpt+ynXaoT98whY1SneGV1iEEs4cACH+okQb3U17g5M=
X-Received: by 2002:a05:6122:4a0f:b0:4eb:5f62:d605 with SMTP id
 71dfb90a1353d-4f2a56da701mr10123546e0c.10.1719926449445; Tue, 02 Jul 2024
 06:20:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-4-c3cd3ee35616@daynix.com>
 <CAJ+F1C+0R=K_nfLkH+xFhocy8z_e5maeKpVs501TyhAktfc3Sg@mail.gmail.com>
In-Reply-To: <CAJ+F1C+0R=K_nfLkH+xFhocy8z_e5maeKpVs501TyhAktfc3Sg@mail.gmail.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Tue, 2 Jul 2024 15:20:38 +0200
Message-ID: <CAAibmn22HZVdRtRpBbYy640hLYMn=07_AEDsu3=we3zDzs8B6A@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ui/console: Remove dpy_cursor_define_supported()
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000000f36e1061c43959d"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::935;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x935.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--0000000000000f36e1061c43959d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Jun 2024 at 14:21, Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmai=
l.com>
wrote:

>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>
>
> Agreed,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>

--0000000000000f36e1061c43959d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"gmail_quote"><div=
 dir=3D"ltr" class=3D"gmail_attr">On Sat, 29 Jun 2024 at 14:21, Marc-Andr=
=C3=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.l=
ureau@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex"><br>
Signed-off-by: Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com=
" target=3D"_blank">akihiko.odaki@daynix.com</a>&gt;<br></blockquote><div><=
br></div><div>Agreed,</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a =
href=3D"mailto:marcandre.lureau@redhat.com" target=3D"_blank">marcandre.lur=
eau@redhat.com</a>&gt; <br></div></div></div></blockquote><div><br></div><d=
iv>Reviewed-by: Phil Dennis-Jordan &lt;<a href=3D"mailto:phil@philjordan.eu=
">phil@philjordan.eu</a>&gt;</div><div>=C2=A0<br></div></div></div>

--0000000000000f36e1061c43959d--

