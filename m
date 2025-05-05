Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D010EC369C2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 06:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBosA-0007h2-P7; Mon, 05 May 2025 02:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBos7-0007f9-Pm
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uBos5-0002SX-3m
 for qemu-devel@nongnu.org; Mon, 05 May 2025 02:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746424806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZTZTUplo6rkqYAaAh6o9VSWFXYqwSGkq8yWaAqABhdo=;
 b=afmax7wremYo9Lmgq04qpCo2FKWakZe9r7hdVORnDVxV1wd3cj6AqgduGLAcUit7QzI1Tx
 XJmyorf/A7qL+J/gvCum46Jpk/OEoRYyQwEbbDOdXIhqROKmwsbcshXQjKsAR+fphCHWE2
 Hbl5hcMOKDwycqkGXh04y9x3h8fJrLE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-MNy8fqQrOuCqpsDfoRrH8g-1; Mon, 05 May 2025 02:00:04 -0400
X-MC-Unique: MNy8fqQrOuCqpsDfoRrH8g-1
X-Mimecast-MFC-AGG-ID: MNy8fqQrOuCqpsDfoRrH8g_1746424803
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-441c96c1977so5415315e9.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 23:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746424803; x=1747029603;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZTZTUplo6rkqYAaAh6o9VSWFXYqwSGkq8yWaAqABhdo=;
 b=d8qawhhTTXb2ejwx0l40a5DLmH1JDLpze9QrKl+f3jFRoSnkhSHLib/+SBt75RUhXz
 6ZfTU5uF+Xeco/KJ4DKGshNmec7n1LYbGAMUvl+AB7yyh7DoKo/iwddqeUpLFmPu0h79
 EsgFfCUzzhhYpQ6ZQYgXy4PYIlKPJamYDmZOqyTF5UxB1W9SK+MNSsqrwkY4+4B8RHt5
 GTIr6dJAl5b7LuvndEH5DKVWKdqoWkrgYf1uJ1oUsn2YRUyslxxSYteSA++a1SLtBvIs
 fDofmjeBX01eSLrd3HW2aA5a9DYRPYXyX/oBvrlBZVTy+Ttqz/2TNbqr+BEaviGbC8yB
 SIUQ==
X-Gm-Message-State: AOJu0YxhB/dEnZN1sxOcLbCn0feH0H1urg0l+E5KaWJQYf0xMwgr3Tjk
 7tLB3LURahcppk1BxiJmGCHgLdUe0nDa4mTWna+nlxQvQJE7csPc/KanQUWjikfZ3TEWLmKJKUB
 zebSmlcRF+Hynwq3GQD1aEtI5dTXyK7/NQCrM/vmrlx34hbllKzu37vAB+I/5LuTIpZbyc+O5DK
 s5H2GLmKqeXJZx8PahFSVG7vIgmFc=
X-Gm-Gg: ASbGncv30FmrboqbTwGUDdvZ9k2BvCCetin8m37b4IziNP5eg/LZRIMT/Go5farqpJb
 otuCuDWt4JwPBhtRZVG+tWSdaN43UGUOvBV/w1cgJgcmjerI9zRddN4oWpTfaJW2XA+Rr
X-Received: by 2002:a05:600c:500b:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-441c48bc5e4mr47673015e9.14.1746424803548; 
 Sun, 04 May 2025 23:00:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXcJzdYLqwqz7trqDNTyETeTg8TpgfIqArVg0lervah31K29hkn42uPB57SxHJnZ3zuffBRiDIRKvvsIyxvJU=
X-Received: by 2002:a05:600c:500b:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-441c48bc5e4mr47672835e9.14.1746424803268; Sun, 04 May 2025
 23:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 5 May 2025 08:00:00 +0200
X-Gm-Features: ATxdqUF-vcoMWB5Fx69WaNr-y6sR5mYURTgjImD9w2hMRMCtc94STCq76J9bAKQ
Message-ID: <CABgObfYxsES9JYDDrQzZzMpMPbN9se9ykg9OhE8xvYy0DQBzNg@mail.gmail.com>
Subject: Re: [PATCH] meson: use thorough test setup as default
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000006b4ad06345d36ac"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--00000000000006b4ad06345d36ac
Content-Type: text/plain; charset="UTF-8"

Il sab 3 mag 2025, 22:18 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> Allows all tests to be visible by default when using meson test
> directly.
>
> This has no impact on make check-* commands, which use SPEED=quick by
> default (see scripts/mtest2make.py).
>

What's the advantage of having different defaults depending on whether you
use "make check" or "meson test"?

I don't oppose this change per se, but if it's useful it should be matched
by a change in the default SPEED.

Paolo


> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index f8bf6e7bb66..57ff3f722d8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>
>  meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default:
> true,
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>                 env: ['RUST_BACKTRACE=1'])
>  add_test_setup('slow', exclude_suites: ['thorough'],
>                 env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
>  add_test_setup('thorough',
> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
> 'RUST_BACKTRACE=1'])
> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough',
> 'RUST_BACKTRACE=1'],
> +               is_default: true)
>
>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>
> --
> 2.47.2
>
>

--00000000000006b4ad06345d36ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il sab 3 mag 2025, 22:18 Pierric=
k Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvi=
er@linaro.org</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Allows all tests to be visible by default when using meso=
n test<br>
directly.<br>
<br>
This has no impact on make check-* commands, which use SPEED=3Dquick by<br>
default (see scripts/mtest2make.py).<br></blockquote></div></div><div dir=
=3D"auto"><br></div><div dir=3D"auto">What&#39;s the advantage of having di=
fferent defaults depending on whether you use &quot;make check&quot; or &qu=
ot;meson test&quot;?</div><div dir=3D"auto"><br></div><div dir=3D"auto">I d=
on&#39;t oppose this change per se, but if it&#39;s useful it should be mat=
ched by a change in the default SPEED.</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><di=
v class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex">
<br>
Signed-off-by: Pierrick Bouvier &lt;<a href=3D"mailto:pierrick.bouvier@lina=
ro.org" target=3D"_blank" rel=3D"noreferrer">pierrick.bouvier@linaro.org</a=
>&gt;<br>
---<br>
=C2=A0meson.build | 5 +++--<br>
=C2=A01 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/meson.build b/meson.build<br>
index f8bf6e7bb66..57ff3f722d8 100644<br>
--- a/meson.build<br>
+++ b/meson.build<br>
@@ -5,12 +5,13 @@ project(&#39;qemu&#39;, [&#39;c&#39;], meson_version: &#3=
9;&gt;=3D1.5.0&#39;,<br>
<br>
=C2=A0meson.add_devenv({ &#39;MESON_BUILD_ROOT&#39; : meson.project_build_r=
oot() })<br>
<br>
-add_test_setup(&#39;quick&#39;, exclude_suites: [&#39;slow&#39;, &#39;thor=
ough&#39;], is_default: true,<br>
+add_test_setup(&#39;quick&#39;, exclude_suites: [&#39;slow&#39;, &#39;thor=
ough&#39;],<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env: [&#39;RUST_BAC=
KTRACE=3D1&#39;])<br>
=C2=A0add_test_setup(&#39;slow&#39;, exclude_suites: [&#39;thorough&#39;],<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 env: [&#39;G_TEST_S=
LOW=3D1&#39;, &#39;SPEED=3Dslow&#39;, &#39;RUST_BACKTRACE=3D1&#39;])<br>
=C2=A0add_test_setup(&#39;thorough&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env: [&#39;G_TEST_S=
LOW=3D1&#39;, &#39;SPEED=3Dthorough&#39;, &#39;RUST_BACKTRACE=3D1&#39;])<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env: [&#39;G_TEST_S=
LOW=3D1&#39;, &#39;SPEED=3Dthorough&#39;, &#39;RUST_BACKTRACE=3D1&#39;],<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0is_default: true)<b=
r>
<br>
=C2=A0meson.add_postconf_script(find_program(&#39;scripts/symlink-install-t=
ree.py&#39;))<br>
<br>
-- <br>
2.47.2<br>
<br>
</blockquote></div></div></div>

--00000000000006b4ad06345d36ac--


