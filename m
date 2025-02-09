Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DA0C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 19:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thCaH-0005W4-Kc; Sun, 09 Feb 2025 14:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1thCaD-0005VM-AG
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:03:09 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1thCaA-0002tp-H9
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 14:03:08 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa3fe04dd2so2087176a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 11:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1739127784; x=1739732584;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TR8kafjhEiVrp9JgDJtKeJ3OaZdJnz0Lz8xBaBNiKLA=;
 b=k1pq9d46xpS4019ftiLfLFCFYb02VuE8NIY7G701WL7UnTHQmyy4NNNvvcoD/tP4np
 7tgI+Q+fEMtYmKSIhWj7C6l48bj0slT/YAMiucWMJ7d+qe8hzNjeMsnu/baK/dRFmoQ0
 Tfa2ORWxX6gcbrGHTl8Plp5sq2JXKOxkRcjgRvk6G72clNTERGFWJtVPNClS+iajG9hr
 +SaGzx9OjO/JU3UBZgOkuVbOzkoqPjNTBmjApIwArWFkGQHKOd3USFXizTtfikPyW13g
 ZJow+8Kz8rghGDl+pd/nhqM6+n7YfFiCkqPtMrkjaUu4zXkGv+R5vmY9zI5VlOKGVxfl
 4wrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739127784; x=1739732584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TR8kafjhEiVrp9JgDJtKeJ3OaZdJnz0Lz8xBaBNiKLA=;
 b=brFLES45V6yuJzO/6hNzcIZY33Xs0PPozY3t5pUcyBLuG9JBI7cE43iS7GjRytJ4Yu
 5MfNB2KClJkJQK7KTDgDgDOqtyT2p8lTG4uMRmXCtH0spsSdBgYytBp4GRd2xwbbr/HO
 aSHEtB84QBcP54XnnCav6TInowoxreamV7Wy5/cJ2gji4FWsSVC1okd7NuMgFteqdhLW
 6BUMcISdQPaS0FhGxP2EqkjXQ7qWjQd64QhZSRnik6FklaMauwMa7xtl4iujwv+KQYZx
 uGOKWVDyMUNG0vWE6vnVzJC5YCG5ZpIuQnF1EgdD29/XvUGB7GY2hgIYSmBCcNvGJzs9
 7V4g==
X-Gm-Message-State: AOJu0YzQPePOE2pmmzQAQPu6UISt5nh1lJbjmFOxRzVsHnJf6ZNJAv+D
 zVudYcoxQVHbkwBWKSAhoHoxx89KK0+nHiEGiiUfBYv8qbJWGp4BfXjEYx21J6rTKoiRffbXfz5
 sGR0OXL0QDKLKWrk+C5RLu1lnLITLjgFEvNUO
X-Gm-Gg: ASbGnctmDp/XS5ICfOYCfA0yqamcX9KYNE2407Vw3lFYeypppi5RYAY3DSWcl4k00c3
 BvGRqX8deRkbsdsFKge+AfE2mZErWpyDjb/f2dLNr+KYf+NBa/nk9LQ4qmIHBztNI0ok1yHcC
X-Google-Smtp-Source: AGHT+IGI0O1SZ2Pwxd1NyC23GKrHdhWEAni0TTcpblrvAnzSKXEAQUKr3m2xbMJR/CkaH6hJQUn4Gl4PvJvSLf3q9y4=
X-Received: by 2002:a17:90a:da87:b0:2ee:bbe0:98c6 with SMTP id
 98e67ed59e1d1-2fa240634ecmr16746957a91.8.1739127784468; Sun, 09 Feb 2025
 11:03:04 -0800 (PST)
MIME-Version: 1.0
References: <20250128135429.8500-1-philmd@linaro.org>
 <20250128135429.8500-7-philmd@linaro.org>
In-Reply-To: <20250128135429.8500-7-philmd@linaro.org>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Sun, 9 Feb 2025 20:02:52 +0100
X-Gm-Features: AWEUYZmSh3Z1ViAigHO1wKwBz0pTY_RlNVds9cAr7OA8mn_DMlRvOC7G5IF729M
Message-ID: <CAGCz3vsDb+pKPQ9SyAeywDs_evU-eikEn3o1=se-gZU1K=Wmkg@mail.gmail.com>
Subject: Re: [RFC PATCH 6/7] tests/qtest/migration: Run aarch64/HVF tests
 using GICv2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 Hyman Huang <yong.huang@smartx.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: multipart/alternative; boundary="000000000000d00c9a062dba3db4"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::102f;
 envelope-from=lists@philjordan.eu; helo=mail-pj1-x102f.google.com
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

--000000000000d00c9a062dba3db4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Jan 2025 at 14:55, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g>
wrote:

> GICv3 isn't supported on aarch64/HVF, but GICv2 is.


Hmm. I'm still trying to get my head around this patch series and QTest in
general, but in my experience GICv3 works fine with HVF? (Device name
"arm-gicv3") Can you clarify what you mean or why this difference is needed=
?


> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> RFC: Test eventually timeouts :(
>
>  tests/qtest/migration/framework.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/qtest/migration/framework.c
> b/tests/qtest/migration/framework.c
> index 5629b8ba4e3..30808de14e0 100644
> --- a/tests/qtest/migration/framework.c
> +++ b/tests/qtest/migration/framework.c
> @@ -266,7 +266,7 @@ int migrate_start(QTestState **from, QTestState **to,
> const char *uri,
>      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>          memory_size =3D "150M";
>          machine_alias =3D "virt";
> -        machine_opts =3D "gic-version=3D3";
> +        machine_opts =3D env->has_hvf ? "gic-version=3D2" : "gic-version=
=3D3";
>          arch_opts =3D g_strdup_printf("-cpu max -kernel %s", bootpath);
>          start_address =3D ARM_TEST_MEM_START;
>          end_address =3D ARM_TEST_MEM_END;
> @@ -303,6 +303,8 @@ int migrate_start(QTestState **from, QTestState **to,
> const char *uri,
>          } else {
>              accel_args =3D "kvm";
>          }
> +    } else if (env->has_hvf) {
> +        accel_args =3D "hvf";
>      } else {
>          assert(env->has_tcg);
>          accel_args =3D "tcg";
> --
> 2.47.1
>
>
>

--000000000000d00c9a062dba3db4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 28 Jan =
2025 at 14:55, Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">GICv3 isn&#39;t supported on aarch64/HVF, but GIC=
v2 is.</blockquote><div><br></div><div>Hmm. I&#39;m still trying to get my =
head around this patch series and QTest in general, but in my experience GI=
Cv3 works fine with HVF? (Device name &quot;arm-gicv3&quot;) Can you clarif=
y what you mean or why this difference is needed?</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
RFC: Test eventually timeouts :(<br>
<br>
=C2=A0tests/qtest/migration/framework.c | 4 +++-<br>
=C2=A01 file changed, 3 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/fram=
ework.c<br>
index 5629b8ba4e3..30808de14e0 100644<br>
--- a/tests/qtest/migration/framework.c<br>
+++ b/tests/qtest/migration/framework.c<br>
@@ -266,7 +266,7 @@ int migrate_start(QTestState **from, QTestState **to, c=
onst char *uri,<br>
=C2=A0 =C2=A0 =C2=A0} else if (strcmp(arch, &quot;aarch64&quot;) =3D=3D 0) =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0memory_size =3D &quot;150M&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0machine_alias =3D &quot;virt&quot;;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_opts =3D &quot;gic-version=3D3&quot;;<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_opts =3D env-&gt;has_hvf ? &quot;gic-v=
ersion=3D2&quot; : &quot;gic-version=3D3&quot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0arch_opts =3D g_strdup_printf(&quot;-cpu =
max -kernel %s&quot;, bootpath);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0start_address =3D ARM_TEST_MEM_START;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0end_address =3D ARM_TEST_MEM_END;<br>
@@ -303,6 +303,8 @@ int migrate_start(QTestState **from, QTestState **to, c=
onst char *uri,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_args =3D &quot;kvm&qu=
ot;;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 } else if (env-&gt;has_hvf) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 accel_args =3D &quot;hvf&quot;;<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0assert(env-&gt;has_tcg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0accel_args =3D &quot;tcg&quot;;<br>
-- <br>
2.47.1<br>
<br>
<br>
</blockquote></div></div>

--000000000000d00c9a062dba3db4--

