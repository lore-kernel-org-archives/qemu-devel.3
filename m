Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65924C3271F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 10:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPgY6-0000EL-J2; Fri, 05 Jul 2024 06:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sPgY4-0000Dw-Bh
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:52:16 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sPgY2-0004Q9-Hq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 06:52:16 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-80d61a602f2so475782241.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 03:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1720176732; x=1720781532;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mrQ/A7HS7PhvkryAUz/aM4tXJFGVGYfTqfWYcG8Ti+4=;
 b=ZM6h+hq0q20skKWtvIQScqPAxd/wtpn6A3010Y9lC5JnDeIKMZLKInQxA0P8Eywa46
 JxWAF9W7KvJLJ8RRml2xqzAEs+2lCZOT4ky6E9hYbL/1tWjERd0GzDgb/xQWla6fAqj9
 yF4tLo3gczd4lQTHs/V75ogkv5OxDpxkhtJXtxz+tq7YA8o8e6+lXJkvMQwwaT2ZDZyc
 ij+2SalxYkW/1/zkBi2D3O8gcLZ3sWv1A9rQnpsd0qBkRZTDTP67iWEagG/woHeA6sXr
 VLgeJGiu3cWz03mEui2NQJ6pv+bR0lnUTfv2MRPPcixIKnz1MGMm+3I1ofTyWUTFMAIF
 xCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720176732; x=1720781532;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mrQ/A7HS7PhvkryAUz/aM4tXJFGVGYfTqfWYcG8Ti+4=;
 b=jVcSoi8sDizGt8bMV0TUabz7YGpwS5hnCvDLkJQqWO0SEcnMpov+AXgMY3Rs7cyYY7
 L/AP5NGs0XPktMYkfisyca0oQAc52ybZtkyDmyfkkj11z2/aZeIfYgnLFwUgmN3ZuWeL
 bOjcoxYauYxUJUuWg05qsH4yGA+dG+uNKB3tiZF2mmfPpLrCbR3L7hljJvSGs+gWWN4E
 aP8ZtJLDGxeD9q36JrAmAQ6We5+B8MQktnaL8fUf53H5Ul0+CKUuXL3btNUjHnsfIH6S
 fZcLkda6CrL84C+i3O8aEcu7+nQ2zoKfcsh493HNmgRT8HSVsk99gW0gtxyDxsrr4GU9
 LoHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeuk84wNFv5q8PSk74FbtCYvb5BYpoCsnVScw7eeOmzH49tUZalGar2x7SUwPgosOL5SA7o58HjFmZXxLO2sxcu7pm2nU=
X-Gm-Message-State: AOJu0Yz2dhZXpYRmIgCVAv3mGM9Hzp1sDDIzC9nOenymzz9luCU9wuIX
 nK5eMbtqWc0cmLinYEKODLBcMxYfPrgtp7+bYZqzIyddJ0sY1ZusZHxUASd4k3BCo6LIiYeXMOB
 OOo88UZk8t48t70usX2/cbQl0NfFbM4x/ciZp
X-Google-Smtp-Source: AGHT+IF/9zTOwDHaP6Nb8ZqQRkG8FCfHv09/AnqwCauZkjKkCjmBd8j1apcLEJNAKnLFG/iPZ1Zwe1aNwiDwClP7Y2s=
X-Received: by 2002:a05:6122:1982:b0:4f2:edfa:a72e with SMTP id
 71dfb90a1353d-4f2f3f3e680mr4981186e0c.6.1720176731138; Fri, 05 Jul 2024
 03:52:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240627-cursor-v2-0-c3cd3ee35616@daynix.com>
 <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
In-Reply-To: <20240627-cursor-v2-3-c3cd3ee35616@daynix.com>
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Fri, 5 Jul 2024 12:52:00 +0200
Message-ID: <CAAibmn3GHALkLnG_BXSLZOKrVzKTkU0zWJSQNkGCe-+BLvOZ5g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ui/cocoa: Add cursor composition
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000002ceb1061c7ddbd4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::933;
 envelope-from=phil@philjordan.eu; helo=mail-ua1-x933.google.com
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

--00000000000002ceb1061c7ddbd4
Content-Type: text/plain; charset="UTF-8"

I've just tried to rebase my own patches on top of this work and noticed
the following typo:

On Thu, 27 Jun 2024 at 13:17, Akihiko Odaki <akihiko.odaki@daynix.com>
wrote:

>  static void cocoa_refresh(DisplayChangeListener *dcl);
> +static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int
> on);


The above prototype does not match the below definition - note the type
mismatch on the last parameter:

+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool
> on)
> +{
> +    dispatch_async(dispatch_get_main_queue(), ^{
> +        [cocoaView setMouseX:x y:y on:on];
> +    });
> +}
>

--00000000000002ceb1061c7ddbd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I&#39;ve just tried to rebase my own patches on top o=
f this work and noticed the following typo:<br></div><br><div class=3D"gmai=
l_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 27 Jun 2024 at 13:17=
, Akihiko Odaki &lt;<a href=3D"mailto:akihiko.odaki@daynix.com">akihiko.oda=
ki@daynix.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">
=C2=A0static void cocoa_refresh(DisplayChangeListener *dcl);<br>
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, int =
on);</blockquote><div>=C2=A0</div><div>The above prototype does not match t=
he below definition - note the type mismatch on the last parameter: <br></d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+static void cocoa_mouse_set(DisplayChangeListener *dcl, int x, int y, bool=
 on)<br>
+{<br>
+=C2=A0 =C2=A0 dispatch_async(dispatch_get_main_queue(), ^{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 [cocoaView setMouseX:x y:y on:on];<br>
+=C2=A0 =C2=A0 });<br>
+}<br></blockquote><div>=C2=A0</div><div><br></div></div></div>

--00000000000002ceb1061c7ddbd4--

