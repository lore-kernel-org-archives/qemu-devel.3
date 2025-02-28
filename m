Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30E8C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 18:18:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to4vl-0002HE-A7; Fri, 28 Feb 2025 13:17:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to4vj-0002E0-P0
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:17:47 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1to4vh-00047d-A7
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 13:17:47 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-868ddc4c6b6so1016123241.2
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 10:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1740766663; x=1741371463; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=K/V8BHz+2lU8pa23Tdt3MKE9cegKBv8cSR6xXMsMjuQ=;
 b=Hhc80o0y30oLP2neqTywFEq2HUX+AJR36sdqRtXE398OY0LEIo1Vs8jesmIXdmCHr8
 BqEh/TparTfokc5bT/o+qizkF3pT6+QCR8kOJQKsVWNFBDqbVkd0sDBTRLf44gnBg1Ph
 azlgJU3tlkTNUsaqaSnVq9X2rySobieP/SM2isAYUMlTWRSFvuUHtgHCxZOKIFT9U321
 jgsT+7whzrLqIPIrLPHyotyUaTAMsDdB2WcZqa0MoK82bbnTs3HL1iVc8yc9mQOQ7jEZ
 CwxfVJSNJv7WF+ADvXZXavMuCcf3dfkb+d2QyhmwWIeDTiOvE3sWi8jW5FhXLGlvEKj2
 GrvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740766663; x=1741371463;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K/V8BHz+2lU8pa23Tdt3MKE9cegKBv8cSR6xXMsMjuQ=;
 b=mgrKdIx8AC4oCo8gCwJVyPUDvcLW3fF3GToESD6/vxGamJLA1ogqFATyVZE6fcCJla
 LsOVO+IvOOpxTdQ15zSxANJjzVwqwMqBYq6MOneJ3t+zKZx8UZ3O6xegrcVU1PsKlbUj
 qUMFXKTYGCcatAhgnVTEDIhwv3RJTb4HXkKBXdV4KiwN/0RRUPa2wexeiFeofvYTu9Ot
 i4LU9Ws3qIYYfB8KVtZbFFgnpTn8syaUclnx+OlnInjH0koIhaMwWFMmu/yOgEh4dBeU
 4/NyaUGLzxG2s0is4huhKaLm93ctxwOQ/h9EaTT2xXiSjHjf6XezHL00wY65Kceiq+uq
 9vrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1VruNmM+k/qgkYitS3xSBj+GfTu1gyOyHCJ7PT/YKpbcvY5WJs7cfjlhmbignJUz7hrtzjCghhJ6V@nongnu.org
X-Gm-Message-State: AOJu0YxgfP7w3Zoa5uiZBvDVU3cmOn9wjeaWHtnNO8V+nEW11Y56bnF5
 omv0RAixDUee8N/dS4NHyUn3ulf4ckK5YdzpmnsG2Jl4YeuTHZ0FRYJBbWT7bW54VlqTs6ClFhZ
 2nAkv4nMY0wizbeyVqUve0rnTeRKzg7nXvL6n
X-Gm-Gg: ASbGncu+MK4vCQROaMZ0lFjhsot00Z7m8wic78ME5SUsVKJHPHtHNULhOyKn4C9zCL9
 gSsw5SWqI4beSoDNKaPbKFOFCQ205AqTCw/qgRe3S7pf0uyzU1DESCTiml0KZe8wXHYiy/0GNP3
 ox0mRHkOXWykzi54a0R9bXZSyXbT9dOZiwcPlBWF1zHw==
X-Google-Smtp-Source: AGHT+IHUnM/2caDCb2imMbI1j6eFxAotteKtR8VGWe9XN6ISpkdZuU7hrntsUno+E2N02IzmOQRsPB3iT9p0B1KXhdQ=
X-Received: by 2002:a05:6122:8d3:b0:51b:b750:8303 with SMTP id
 71dfb90a1353d-5235b8cccffmr2747210e0c.11.1740766663146; Fri, 28 Feb 2025
 10:17:43 -0800 (PST)
MIME-Version: 1.0
References: <20250227180454.2006757-1-venture@google.com>
 <20250228102611.867231-2-pbonzini@redhat.com>
In-Reply-To: <20250228102611.867231-2-pbonzini@redhat.com>
From: Patrick Venture <venture@google.com>
Date: Fri, 28 Feb 2025 10:17:25 -0800
X-Gm-Features: AQ5f1Jpbu85tFu_Ke-7sCJd7UW8jz8AGboP1tri5MikN33vGZBxgcGJjIxjtiu0
Message-ID: <CAO=notxg=SOu8JrHwzYgdxK3DUxQVkfrPSvtVH866_gG1ioQNg@mail.gmail.com>
Subject: Re: [PATCH] scripts: dump stdin on meson-buildoptions error
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, philmd@linaro.org, 
 qemu-devel@nongnu.org, Nabih Estefan <nabihestefan@google.com>
Content-Type: multipart/alternative; boundary="000000000000988068062f37d2e9"
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=venture@google.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
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

--000000000000988068062f37d2e9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 2:26=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:

> > Dump sys.stdin when it errors on meson-buildoptions.py, letting us debu=
g
> > the build errors instead of just saying "Couldn't parse"
>
> Sure, why not. :)  Queued the patch, it should go into 10.0.
>

Thanks! we kept seeing this because we didn't have rustc installed and it
would just fail to parse the json. :)

>
> Paolo
>
>

--000000000000988068062f37d2e9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Feb 28,=
 2025 at 2:26=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redha=
t.com">pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">&gt; Dump sys.stdin when it errors on meson-build=
options.py, letting us debug<br>
&gt; the build errors instead of just saying &quot;Couldn&#39;t parse&quot;=
<br>
<br>
Sure, why not. :)=C2=A0 Queued the patch, it should go into 10.0.<br></bloc=
kquote><div><br></div><div>Thanks! we kept seeing this because we didn&#39;=
t have rustc installed=C2=A0and it would just fail to parse the json. :)</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Paolo<br>
<br>
</blockquote></div></div>

--000000000000988068062f37d2e9--

