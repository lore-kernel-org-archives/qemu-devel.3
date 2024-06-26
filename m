Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3A70C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 16:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMVIo-0005CT-MU; Wed, 26 Jun 2024 12:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVIk-0005BY-Be
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:15:19 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMVIf-0005bm-LS
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 12:15:15 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a725d756d41so133443766b.0
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 09:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719418512; x=1720023312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MWDLW8saGRSrZMAnW8LFvRs007oaRULLteZ343lZWiY=;
 b=YGZz36YfUNI7ckBI2Oa/NGLFq/7FQMtVF493hR1jmNuaMHbK0V21KKMd7pCjVEb7Fw
 JPHVgDgAAlChxZaQ3brQX/EOxo3K0Mcyi4yCOZxuuAvPSte+V+ig7N8+/PNdmTLBQmCy
 lumi/AYPpU7fJxspoFRBUHSLS80tJdqVGa6k8qGwkiJZPdX9+OHkeH08WXghb3Tb11yb
 TxzHRPQFiNxT9qUiseXYSiW2vxSRLEPceuyEXIDgD/1/vda9wr97m66LcXFMHS1vvxo0
 XhX4YdnswOtRH5hRogMDs7uUKywFmV9Jwz8IfY8r+0GWd7RghilRifjjRPkoq9MjgcaR
 0yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719418512; x=1720023312;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MWDLW8saGRSrZMAnW8LFvRs007oaRULLteZ343lZWiY=;
 b=FPMKzKh6fndCwFxErI7AUAnrHRcAdaeYh2YJHgcBF9znAWWjzo0Wrum5wxvyDSyiFN
 BWo6l83CVStyWrzRaWoKxd4lwmC63AS6RR9yqRAe0uHZr5m1t+rzkfckg+4NmFFAfpiD
 cCvavHvE4jb8b1ZoNUrtmOe6ejga7Mr0Zua+LsPz6NmmsDMdi6L7/7j0f6rGiYb/d/5d
 6QA2HMBUTdpmFlY8+Zsqb5g6MvQBXVfVPftcv3TPsOkhauWIXWCmDvxWSqkQkzTm9T16
 D/lbIRPDarI+spHWOqYmLf7mDZzCuecS9Cj49V9TpGpeIbX55wF9uV4vYdydVfJGfwBW
 7Y3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSLNrhnZbSH9yiC2HT8SkFOW0qarimF92or5CQgfKbeNUIVEy0cPgby4SqnJc++USto/fuw2z0yrrh9Ne0ykaTfpmdVsQ=
X-Gm-Message-State: AOJu0YwneQ/pw6tt0laKqZ/JH5RslbIljFNkvwv9RfCd14VqBvQtS7Yg
 tA3yS7tuO6clHFqPhwijmBekiklREodxJ7OVvYGloBogu/AseARyanODhPovcyk=
X-Google-Smtp-Source: AGHT+IHRbMJvPWpk5hUeIuKGMrgi09UuRcILUogDkK9KEwJh4shu+h3qpkx7OT77jx40wcKA1WzagA==
X-Received: by 2002:a17:906:f9c8:b0:a6f:b91c:5197 with SMTP id
 a640c23a62f3a-a729706be69mr4708966b.36.1719418511324; 
 Wed, 26 Jun 2024 09:15:11 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7287b7e17asm87340966b.222.2024.06.26.09.15.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:15:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 790D95F8AA;
 Wed, 26 Jun 2024 17:15:09 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] tests/tcg/aarch64: Fix test architecture specification
In-Reply-To: <20240626-tcg-v1-2-0bad656307d8@daynix.com> (Akihiko Odaki's
 message of "Wed, 26 Jun 2024 20:26:23 +0900")
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
 <20240626-tcg-v1-2-0bad656307d8@daynix.com>
Date: Wed, 26 Jun 2024 17:15:09 +0100
Message-ID: <87zfr7of3m.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> sme-smopa-2.c requires sme-i16i64 but the compiler option used not to
> specify it. Instead, the extension was specified with the inline
> assembly, resulting in mixing assembly code targeting sme-i1664 and C
> code that does not target sme-i1664.
>
> clang version 18.1.6 does not support such mixing so properly specify
> the extension with the compiler option instead.

Also with gcc on aarch64.ci.qemu.org (Ubuntu 22.04.4 LTS) I get:

  16:05:44 [alex@aarch64:~/l/q/b/all] plugins/next|=E2=9C=9A1=E2=80=A6(+0/-=
0) + make run-tcg-tests-aarch64-linux-user
  ninja: no work to do.
  /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/meson introspect --targets=
 --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/all/pyvenv/bin/pyth=
on3 -B scripts/mtest2make.py > Makefile.mtest
    BUILD   aarch64-linux-user guest-tests
  tests/tcg/aarch64-linux-user: -march=3Darmv8.1-a+sve detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.1-a+sve2 detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.2-a detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.3-a detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.5-a detected
  tests/tcg/aarch64-linux-user: -mbranch-protection=3Dstandard detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.5-a+memtag detected
  tests/tcg/aarch64-linux-user: -Wa,-march=3Darmv9-a+sme detected
  tests/tcg/aarch64-linux-user: -Wa,-march=3Darmv9-a+sme-i16i64 not detected
  cc1: error: unknown value =E2=80=98armv9-a+sme=E2=80=99 for =E2=80=98-mar=
ch=E2=80=99
  cc1: note: valid arguments are: armv8-a armv8.1-a armv8.2-a armv8.3-a arm=
v8.4-a armv8.5-a armv8.6-a armv8-r native
  make[1]: *** [Makefile:116: sme-outprod1] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:50: build-tcg-=
tests-aarch64-linux-user] Error 2
  16:08:32 [alex@aarch64:~/l/q/b/all] plugins/next|=E2=9C=9A1=E2=80=A6(+0/-=
0) 2 +=20
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  tests/tcg/aarch64/sme-smopa-2.c   |  2 +-
>  tests/tcg/aarch64/Makefile.target | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/aarch64/sme-smopa-2.c b/tests/tcg/aarch64/sme-smop=
a-2.c
> index c9f48c3bfca2..2c9707065992 100644
> --- a/tests/tcg/aarch64/sme-smopa-2.c
> +++ b/tests/tcg/aarch64/sme-smopa-2.c
> @@ -14,7 +14,7 @@ int main()
>      long svl;
>=20=20
>      /* Validate that we have a wide enough vector for 4 elements. */
> -    asm(".arch armv8-r+sme-i64\n\trdsvl %0, #1" : "=3Dr"(svl));
> +    asm("rdsvl %0, #1" : "=3Dr"(svl));
>      if (svl < 32) {
>          return 0;
>      }
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefi=
le.target
> index 70d728ae9af7..f53a1d615c21 100644
> --- a/tests/tcg/aarch64/Makefile.target
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -27,7 +27,8 @@ config-cc.mak: Makefile
>  	    $(call cc-option,-march=3Darmv8.5-a,              CROSS_CC_HAS_ARMV=
8_5); \
>  	    $(call cc-option,-mbranch-protection=3Dstandard,  CROSS_CC_HAS_ARMV=
8_BTI); \
>  	    $(call cc-option,-march=3Darmv8.5-a+memtag,       CROSS_CC_HAS_ARMV=
8_MTE); \
> -	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme, CROSS_AS_HAS_ARMV=
9_SME)) 3> config-cc.mak
> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme, CROSS_AS_HAS_ARMV=
9_SME); \
> +	    $(call cc-option,-Wa$(COMMA)-march=3Darmv9-a+sme-i16i64, CROSS_AS_H=
AS_ARMV9_SME_I1664)) 3> config-cc.mak
>  -include config-cc.mak
>=20=20
>  ifneq ($(CROSS_CC_HAS_ARMV8_2),)
> @@ -68,7 +69,14 @@ endif
>=20=20
>  # SME Tests
>  ifneq ($(CROSS_AS_HAS_ARMV9_SME),)
> -AARCH64_TESTS +=3D sme-outprod1 sme-smopa-1 sme-smopa-2
> +AARCH64_TESTS +=3D sme-outprod1 sme-smopa-1
> +sme-%: CFLAGS +=3D -march=3Darmv9-a+sme
> +endif
> +
> +# SME I16I64 Tests
> +ifneq ($(CROSS_AS_HAS_ARMV9_SME_I1664),)
> +AARCH64_TESTS +=3D sme-smopa-2
> +sme-smopa-2: CFLAGS +=3D -march=3Darmv9-a+sme-i16i64+sme
>  endif
>=20=20
>  # System Registers Tests

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

