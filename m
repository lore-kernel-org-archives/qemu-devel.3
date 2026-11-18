Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE18606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XQkPK+qI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThdV-0004BP-Jj; Wed, 18 Nov 2026 10:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xThdG-00048x-DB
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:31:36 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1xThdE-0006uH-Ax
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:31:34 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so6519585e9.1
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795015889; x=1795620689; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xWxL8/TeQZ5GwiysaE6OXHvyuXrn7cu6NxWcHzqNhsw=;
 b=XQkPK+qIQocpSyW/FZIHU8wdT2bGkLmkY+HCZ+4vJHJIO61Fnznd8XHYXqYpfdJ20r
 D2uvY/Yxfui7G4B9AQGxsKeCE21D8fMsL5/k/fik9vRIpDWkXmSXqA3wSHYDerl4/e3C
 Tisv9e1dp/FBuJxs7BqRuOQ+clsjWuEeRwUvu7QTFaz8kLEvbCRnuJ72VKM3Gp3YJQcE
 prmB17DcDVyHN4rMOm8USHs7tuPE8/YlI5cgFa4i7BGltyVgCcAOXGBRyfhu1VUcTnvG
 dcPbT/cXoLCInxim8GBGjeN9bMGUMNME1gJ19flXeT0g+45CY7FcTm5wEvIffQLUIACu
 wFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015889; x=1795620689;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xWxL8/TeQZ5GwiysaE6OXHvyuXrn7cu6NxWcHzqNhsw=;
 b=vmj5W2BJCDPuIPgST+BMbBjeyGUINhshdehUfHHvfsOAWg46c6/bP8nnX7Cgeb/Tbh
 86x5LjuALdKjonRNtTflWJdUQAItyJD23iz1FrOoyC2mIqdIlh32egKnI3iCq6+W21sx
 lgfBMQhrfXbfyd3xwggLTSz0fMWuXS52ZOD5e2FNw7nsrLkKBWnBZgBH+hWiMCxxV7an
 poATBW3PuPIJkAPGeUzWYXwTYm1m4/t3ldaCvMU0BLPryCwYtTCrxGRcs4nAbTX77USK
 GANV2OWWa/g1UwoW4it8bPAHfc60cHjSzx9iXamaJGlOF+XtIhq8jUYCxtXi2bsMwQ4B
 FiMQ==
X-Gm-Message-State: APuU4Z/zQ8zA2yjmeP73IJ/u2ViCBUW4AJdJOcVmNdzCeCfCBodLSVXO
 iFjauEa4vv4U+mJ0vi6SaIhonwQXQ2QS1lnp5GDNSiAdIqyj71qqdqlsNyFGsoLq0ho=
X-Gm-Gg: AYBFou2M2OPP4tv6pIJJuH3uBHnV9xkTxLlQr7Rh/83MGvZnGmBLvr6uNwmIiNvDpPw
 RStWU3HULfqFn/VwIkiXWUJwtKcSro/njUIu682phQLRuozbqoB6sB7KIviSWinX4foc49y80ry
 zdt+IgOgbnKvTADjlAtUjHd8egrljYYGX2ohexcF49hxgtWMkKms7Jky0CkDXAyOExw+V2X9ss0
 pHubG3ZsTh58C9qUisq4n4w4wW/ds/iz0ysS6IFGn9g8ofHpHa+1C+Jz0Lb4Yb0D2syED6aBMXJ
 ULIp7225goVVSaTVnywhMX6S1H/YGgEQ4gIdM5EzY9E1V2dTFSz/kweycoFTiLoErol1gKSA9Rn
 4A2sLHZgaCyfF2+MfT4CxvwL/+EKyfv2g+gP4MhRJ4me5Yfsm5Vthhijs000Dn/FlC7DVoSq+v8
 vcUE7UJfqCU6kHs5srB2AJz7aHcQTtS2SVQrCRH3jZrdJ0BhicQXSC+/cF3QofQ8W7V6Xt7SAkV
 sTDaUUQY9qhbcdyrW6CrXqx/y/VO5u+rzvMZeQpRDmYxd9CGqP+/8s7hdGyp3jYQyUyL7wQJ74Y
 jUZZI0RpLF8iKSCuI9IYQT3n+LK7AypawAqa1boe+mJsYKknQg==
X-Received: by 2002:a05:600c:c16d:b0:4a1:d459:db4b with SMTP id
 5b1f17b1804b1-4bb7da3aee1mr55391225e9.24.1795015888595; 
 Wed, 18 Nov 2026 07:31:28 -0800 (PST)
Received: from draig.lan ([185.124.0.158]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e580745sm39976685e9.2.2026.11.18.07.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:31:27 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2E6845F857;
 Wed, 18 Nov 2026 15:31:26 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,  Mauro
 Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: [RFC PATCH] docs: add a diagram of the development process
In-Reply-To: <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Fri, 6 Nov 2026 13:01:33 -0800")
References: <20261106122111.3005638-1-alex.bennee@linaro.org>
 <dfc31d65-d309-461d-a47e-3df3c658d56e@oss.qualcomm.com>
 <87ld7566jz.fsf@draig.linaro.org>
 <b6a6e0bc-90b0-4162-8ec9-098d1ced1069@oss.qualcomm.com>
User-Agent: mu4e 1.14.5-pre1; emacs 30.1
Date: Wed, 18 Nov 2026 15:31:26 +0000
Message-ID: <87zev65f75.fsf@draig.linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 11/6/2026 12:36 PM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 11/6/2026 4:21 AM, Alex Benn=C3=A9e wrote:
>>>> We've had various versions of this diagram for a while so I thought it
>>>> would be worth adding to the developer docs. I chose plantuml as it
>>>> has a plugin for sphinx that we can use and supports sequence diagrams
>>>> which could be useful for documenting other features in the code base.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>>
>>>> ---
>>>> vRFC
>>>>   - I've bundled all the plumbing together in this commit but it can
>>>>   be split up if we want to go forward.
>>>> ---
<snip>
>>>> diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/=
qemu.yml
>>>> index abbd3e3f0b8..de4395cd3c7 100644
>>>> --- a/tests/lcitool/projects/qemu.yml
>>>> +++ b/tests/lcitool/projects/qemu.yml
>>>> @@ -89,6 +89,7 @@ packages:
>>>>   - pcre-static
>>>>   - pixman
>>>>   - pkg-config
>>>> + - plantuml
>>>>   - pulseaudio
>>>>   - python3
>>>>   - python3-numpy
>>>
>>> It will silently disable doc by default for most of the people
>>> unfortunately, not sure it's the best move we can do.

Do most people build the docs? As long as it fails hard for
--enable-docs I think that should be OK right? Especially if we update
the min requirements for the project.

>>=20
>> plantuml seems to be pretty widely packaged so in this sense its just
>> another dependency.
>>=20
>>> Maybe a simpler solution could be to generate diagrams out of sphinx,
>>> add them as a dependency, and generate a blank image (or an image with
>>> diagram source and a message - please install plantuml) if not
>>> available. What does plantuml brings compares to graphviz builtin
>>> extension?
>>=20
>> Ohh I didn't realize there was graphviz - I'll see if I can recreate
>> with that.
>>
>
> If graphviz is not installed, a warning is emitted, which stops the
> build since we turn warnings into error.
>
> The warning emitted has no type, so it can't be filtered with
> suppress_warning setting from sphinx-build.
>
> However, since sphinx uses standard logging framework, you can silence
> it this way: https://github.com/sphinx-doc/sphinx/issues/10219
>
> ```
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -24,6 +24,7 @@
> +import logging
>  import os
>  import sys
>  import sphinx
> @@ -66,8 +67,20 @@
>      'qapi_domain',
>      'qapidoc',
>      'qmp_lexer',
> +    'sphinx.ext.graphviz',
>  ]
>
> +# Render graphviz diagrams as SVG so they scale cleanly in HTML output.
> +graphviz_output_format =3D 'svg'
> +
> +# Silence the warning emitted by sphinx.ext.graphviz when 'dot' is not
> +# installed. Diagrams are then rendered as their raw source instead.
> +class _NoDotWarning(logging.Filter):
> +    def filter(self, record):
> +        return 'cannot be run (needed for graphviz output)' not in
> record.getMessage()
> +
> +logging.getLogger('sphinx.sphinx.ext.graphviz').addFilter(_NoDotWarning(=
))
> ```
>
> The advantage is that graphviz is not a required dependency, so doc is
> still built for anyone having sphinx installed. That's a nice end result
> I think.

I don't know - silently building a not quite complete set of docs seems
like the wrong way around but I'm happy to defer to the distro folks
here.

>
>>> Also, text diagrams (https://asciidraw.github.io/) with raw formatting
>>> have the advantage to not require any external tool.
>>=20
>> I have the ascii original although ditaa seemed more of a stretch:
>>=20
<snip>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

