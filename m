Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28554CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcPBE-000362-7C; Wed, 24 Jun 2026 11:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPBA-00035T-Gv
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:06:16 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wcPB8-0001Sp-Mi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 11:06:16 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso6458955e9.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 08:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782313573; x=1782918373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f8ufwlZ3zz5EBuU/4lkCHYixp/oTIOjbCFRp8+ljV7w=;
 b=pDRc1SFxx5FzdQt0LN8sGdFcYjhbM92zPp8OfAbTbcysZ3lJ54Uuyv68zmwG7Ou3u9
 aYdyPbuiMc11ClJ7ON4dZQdnRRjwYPuZWl6qbtbNH370z9B6vLbRsWuD5Y2xM2xXjPys
 8A1Op2aFYBOq+XrlSHtI13iGjx9v1dGzV3ituDx054Y7txlNj69e0ceWj3H6r0x/9I3q
 EmvKopFAF6nl4QOqMRwTR3W/ZK/NxwqDrC3kxShJoykvrmhNTdjozjpkiqascT8c+7SP
 XVpKBYFfOjohfX8E/eukB593XMxbJfNS5CvS21YfLzhNmv9CqcXMiTZgPeqOv1NfKWJf
 pzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782313573; x=1782918373;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f8ufwlZ3zz5EBuU/4lkCHYixp/oTIOjbCFRp8+ljV7w=;
 b=m+a53nN4jUx4GEfygXFbRfTlJms4KM1myf3cUO2sYNMBmIVNb5nJpM+xxQ0YQTqKzx
 VFH1uaNn4x5nqLSv0RBGosJFB3fgHk3xlbh7xsHTP7S0kUeILvlGYEkLdKBwy5l3w+Lg
 xOkaNILBLNQTIT4eUfHGdInG9OR7L8NNFsJea+JCjXZ4czxbo97Eti88a/OC7gyFPC2Q
 gsiZtqWyry5JPEVCc2g+83wbIb4+xGkUzB43UbVzHGGlXilVYXr2fdtuTRv1iuRoc/MO
 YyCSj/Bil1hblqCDhjzIApo7dPWigRYZm2MyRQIC77mhK2XP4sV+h1qNfdaAsqyxYeIL
 O4Tw==
X-Gm-Message-State: AOJu0YxfNfBd6nZvB8AggExLf0xX3vHxa8CXZ2U5ViIlKxKUU4/0IVRW
 w0E9dT507tJ7M4DwjiWtSqtYWLVHmz3e4/R7BROfbrOXQqFMXE8JnkDibwcOk8zSfl4=
X-Gm-Gg: AfdE7cnzDCWF6V8vJcRFFpe2iWzFXE7MYANsix/5GWoyTXRu3wWm3JajTXjMyURnTbX
 yYToOTXU1Jo8I/EUkYy6boZrVchb2NxD04zIFn4jQ/Pt07VO2YAE16E4V1n/uvlrZ1CeiecAB0w
 UIq3oujpbBY2ktFM7Bb34wvswxGssneL4xnZeWj2dwQcdj8xal9lbFSkMZl9m+SIjqNrcwjviXG
 gOWdIhL/jm/5FxPnFWgR4xGLZHVFYtwu9mBNQNLhGpJLtlSXA0JgsGsNyumE1Yu7mlG0vPP9b4b
 fVm2hyqnX7K9xiDV8hm1vgILKPsJWsBAsI9HTAisow7J+vvTbJagWL6YDJw7M4AMmsVcoXEhtMe
 cuhUGgBYYSWdpugExyrcFMwUPc/ajWhLHghrRE/+FHuX1a1n69dkwsUmLF5PI/x1crqD5dgbEj+
 gW5R/Spll15qD/
X-Received: by 2002:a05:600d:844f:10b0:492:5e20:3ee9 with SMTP id
 5b1f17b1804b1-49260840bbemr43176615e9.6.1782313572494; 
 Wed, 24 Jun 2026 08:06:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492494496d8sm376292155e9.9.2026.06.24.08.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 08:06:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBE155F807;
 Wed, 24 Jun 2026 16:06:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org,  Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 05/27] tests/tcg/meson.build: introduce exe_name
In-Reply-To: <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 9 Jun 2026 14:47:23 -0700")
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
 <20260609214745.772536-6-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Wed, 24 Jun 2026 16:06:10 +0100
Message-ID: <87pl1gj7vh.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> We add possibility to duplicate a test executable for a given source
> file. This is needed when different cflags need to be used (like
> vectorized vs non-vectorized for instance, like sve tests in aarch64).
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/tcg/meson.build | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
> index 72d1a9f8986..2c6d85c586a 100644
> --- a/tests/tcg/meson.build
> +++ b/tests/tcg/meson.build
> @@ -11,6 +11,7 @@ tcg_tests =3D {}
>  #     'tests': [
>  #       {
>  #         'src_file': {
> +#           'exe_name': ['provide an alternative binary name'],
>  #         }
>  #       },
>  #       ...
> @@ -18,10 +19,10 @@ tcg_tests =3D {}
>  #   }
>  # }
>  #
> -# Every test executable, is built only once.
> +# Every test executable, identified by 'exe_name' is built only once.
>  # Tests for a given src use the same executable by default, and their de=
finition
>  # is guaranteed to be unique also.
> -# Default name is derived from src.
> +# Default name is derived from src if 'exe_name' is omitted.
>=20=20
>  # plugins come first, as we need to build the list
>  subdir('plugins')
> @@ -47,11 +48,23 @@ foreach target, plan: tcg_tests
>=20=20
>    foreach t : tests
>      foreach src, setup: t
> +      # return a clear error if user mispell a setup entry
> +      foreach key, _ : setup
> +        if key not in [
> +                       'exe_name',
> +                       ]
> +          error('unknown tcg setup entry \'' + key + '\' for test ' + sr=
c)
> +        endif
> +      endforeach
> +
>        # meson '/' operator drops left operand if right is an absolute pa=
th
>        src =3D folder / src
>        file =3D files(src)
>        test =3D fs.name(file)
>        exe_name =3D fs.stem(src)
> +      if 'exe_name' in setup
> +        exe_name =3D setup['exe_name']
> +      endif
>

Would it be better to put exe_name =3D fs.stem(src) in an else leg?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>        exe_name =3D target + '-' + exe_name
>        test_name =3D exe_name

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

