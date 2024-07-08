Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20BAC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtHI-0008Jy-VD; Mon, 08 Jul 2024 14:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQtHG-0008Il-7O
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:39:54 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sQtHB-0003qT-71
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:39:52 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77e5929033so278942166b.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 11:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720463987; x=1721068787; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SLDqDGlO92l92KS91xFHytjJfe2jY2GhFTgRCDnaXqg=;
 b=O1p28Pk8peJ48hcw8Mz0d5U1gd8sy4/9cU9Bs1sF5Fq0DK/M85zgkp1sctWlJ6aDXI
 cCbhdu5SAdbQ14szyVKfcLKl08VkaQiZ0oPCQPtbgzqqIkhROJq/9XgV7S/+5Iaoss1/
 TiTJ3cu0pIDOYIQlAh9ijLyOI7ZnYULTMUZmv96ltU8X741aLTkGfDgYfB8wsJvIJkf1
 oy39jsnyWxjNf9GlsMQbwVrBTucqqG6Z+lhAJG7J17LA6zce4Ly4u1tzM4qMZjlEN1Ps
 zhT4NQ+flQDsO7NFlPcP74hU5ISw3C4iWqTM9+5iaaWb2GV7wR98FxFK90fMWxlrTYmH
 sSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720463987; x=1721068787;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SLDqDGlO92l92KS91xFHytjJfe2jY2GhFTgRCDnaXqg=;
 b=lxNLIgarBlG7kG6hg4DRoF47/XHFTObEiylM8jQzFARaN5BZ5nL/po+OzYo4p730Vq
 mxfXdxli5hzemWFQpwrYJ4so6JcXc1c7OFXPNw7GUWGeh/OVbif08FCvL658OoM345tU
 jw9ypubVawmFAfsAR7XxNwJIhqylDM/l7iv87eiR+pwyAxmKmDeVedUZqK8IEpl6AjLY
 t4LMyaIRrEjGaqNcvTSAXe31tiFjp69OQEmjtpvxq1c+zQdjF5A+On4GDBLBpDUqZZK3
 +tme0yXCLeSD6u50JVMK2stVZC1KtBE/jwXfZURsaETN0HvRu8DFlxPrNBa7JNPgB6CF
 W++A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+DGYsu32f8gZFn4dK4imkKu9CtIRK8C14Y5NU8fMwctW3H0iAwb0JiaYmRtlTQGZHUgT/o7/I0MWkkboQlnIioSQYjC0=
X-Gm-Message-State: AOJu0YxMsGe/xl/TxPQSbJWolXaDGDf6uIT/sWBeiPy3P5QaX84H8Dk6
 V39uYkCOyIAHhA2WZ6pGELOuoedEOICaDGEUNTnbTkZzMx9bIXh/5MBm9jwsk4B5xrpDWWgp3J5
 dyfzN4GuaZTMGyY24/bYjbLXmIRwLaS88wOy35g==
X-Google-Smtp-Source: AGHT+IG0ESIQhxkbRNfT5Reu+djezIOSBjQt3wyKVVES3WLad13Q8ir+MY38ndCfO04z2euYDUANA3XxUrWwRmGc6gQ=
X-Received: by 2002:a17:906:5a92:b0:a6f:51d8:1963 with SMTP id
 a640c23a62f3a-a780b6ff67amr26504566b.43.1720463986798; Mon, 08 Jul 2024
 11:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
In-Reply-To: <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Mon, 8 Jul 2024 21:39:36 +0300
Message-ID: <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000c84ce7061cc0bc29"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
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

--000000000000c84ce7061cc0bc29
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, <pbonzini@redhat.com> wrote:

>
>
> Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> ha
> scritto:
>
>> That's exactly why I suggest its a pre-requisite for merging
>> this. Unless we're able to demonstrate that we can enable
>> Rust on all our CI platforms, the benefits of Rust will
>> not be realized in QEMU, and we'll have never ending debates
>> about whether each given feature needs to be in C or Rust.
>>
>
> In that case we should develop it on a branch, so that more than one
> person can contribute (unlike if we keep iterating on this RFC).
>
> Paolo
>



If you do, I'd really appreciate it if you did not use any part of my
patches.

Thanks,
Manos

--000000000000c84ce7061cc0bc29
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, &lt;<a href=
=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div><=
br><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">Il =
lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berrang=
e@redhat.com" target=3D"_blank" rel=3D"noreferrer">berrange@redhat.com</a>&=
gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
That&#39;s exactly why I suggest its a pre-requisite for merging<br>
this. Unless we&#39;re able to demonstrate that we can enable<br>
Rust on all our CI platforms, the benefits of Rust will<br>
not be realized in QEMU, and we&#39;ll have never ending debates<br>
about whether each given feature needs to be in C or Rust.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In that case we s=
hould develop it on a branch, so that more than one person can contribute (=
unlike if we keep iterating on this RFC).</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Paolo</div></div></blockquote></div></div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">If you do, I&#39;d really appreciate it if you did not use any =
part of my patches.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Than=
ks,</div><div dir=3D"auto">Manos=C2=A0</div></div>

--000000000000c84ce7061cc0bc29--

