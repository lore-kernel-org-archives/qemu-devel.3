Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409EFC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAkt-0000fW-Q3; Fri, 28 Jun 2024 08:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAkk-0000es-0Y
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:30:59 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAkf-00028k-Pj
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:30:56 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a729d9d7086so299475366b.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719577852; x=1720182652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hy7qSaj2XnTgXbIUKTrcXvqJgtbnL/ZpdGsQGjk8D7c=;
 b=VVu6wWZzjxjShYxIELyJ9KYM1iRrUuO7NZywVDm4GczxyAu0oLNrDcUJxhGu13G/+v
 BQIdVgjB9vGHMY1o8euKtBqbp3GSBuU7dCm19eoiivXN7r0IHQIMmDIKCm40fgftHd34
 RQRX9CRaoW+1Vt0OeO+ZGjj9M6uBS4ewmMkdRIcLvvfyIG1gAFOKMzfWcnAgAd1U8zih
 cMgamMZA2fmaeDr9pnmqX8k0VCl6ZpwpZOKoV6CyRLRvDkZowDC7AuZZoPaPyqERqsYj
 f0B6XxrjvPsyqVp6rF2FJms/47Uv8PFfn58hpSw37wkpoY4/995mqaOzaOhuq8EAdgcU
 119A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719577852; x=1720182652;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hy7qSaj2XnTgXbIUKTrcXvqJgtbnL/ZpdGsQGjk8D7c=;
 b=Wk6okIJwP1d/qs92MsedPjMRLAfJQa1G5cVEQa4PF+UwrPEic/Z2kJYyHreOOuE7C/
 sQABtZL9Duqu13RhLcqPJdTIn03vdHhYwzkeA1n1EZ4IbgwtzrW6avOSDjTkl/PltArI
 iavNMF/9r5650LfIYaHDbE1uN89ASScCt9/glBR4Epa5qBKE4AHDz+aaZWv+xPogGTl0
 xeJ5cbk8httXbHCoz0j8BdZlUaAJavWJkHvwVBLj7h1SE0qc2sF18BeUR/U1ck/EsneJ
 ZTn7v+++vVXYfKM6QfbKpm0bUcdr3DadxxtswR/6xO45fX7zqPyCDHonaYJSObbxbp/i
 AOjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ+jQqOcIN8TFJyUfnbeV7lkhN9tbwdox1IJwPRLAjUDtFN+j3Yys8bqs11UWrIrUA+/FDxtJaC+bRrw+D9rKoRr0t0z0=
X-Gm-Message-State: AOJu0YzFytxzZy09X0ssLXYGvnmC29gJAkkXw/b7jbv5PGQTYyRjTW53
 uWh4BUnhL6oQQ8OqZSNsL9+0E5itM4j44uUgKgeKPYaWB5DYgR/RBUbQOB++gqg=
X-Google-Smtp-Source: AGHT+IEItOpOXijt5fEomVQ6FMYtPL67nMBqbAeTVUIBxbcm2Mme7wrPdH+Z/8nCkMck01W3nOYCNw==
X-Received: by 2002:a17:907:2688:b0:a6f:1d4e:734f with SMTP id
 a640c23a62f3a-a72aef685e2mr142920966b.36.1719577851436; 
 Fri, 28 Jun 2024 05:30:51 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72aaf61f4dsm75794566b.71.2024.06.28.05.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:30:50 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7DA815F7A1;
 Fri, 28 Jun 2024 13:30:49 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-arm@nongnu.org,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/6] tests/tcg/aarch64: Fix inline assemblies for clang
In-Reply-To: <20240627-tcg-v2-0-1690a813348e@daynix.com> (Akihiko Odaki's
 message of "Thu, 27 Jun 2024 22:58:01 +0900")
References: <20240627-tcg-v2-0-1690a813348e@daynix.com>
Date: Fri, 28 Jun 2024 13:30:49 +0100
Message-ID: <87v81tntae.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
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

> Unlike GCC, clang checks if the operands in assembly matches with the
> type in C. It also does not support "x" constraint for AArch64 and
> complains about them.

I guess there are more needed:

  ninja: no work to do.
  /home/alex/lsrc/qemu.git/builds/all.clang/pyvenv/bin/meson introspect --t=
argets --tests --benchmarks | /home/alex/lsrc/qemu.git/builds/all.clang/pyv=
env/bin/python3 -B scripts/mtest2make.py > Makefile.mtest
    BUILD   aarch64-linux-user guest-tests
  tests/tcg/aarch64-linux-user: -march=3Darmv8.1-a+sve detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.1-a+sve2 detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.2-a detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.3-a detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.5-a detected
  tests/tcg/aarch64-linux-user: -mbranch-protection=3Dstandard detected
  tests/tcg/aarch64-linux-user: -march=3Darmv8.5-a+memtag detected
  tests/tcg/aarch64-linux-user: -Wa,-march=3Darmv9-a+sme detected
  tests/tcg/aarch64-linux-user: -march=3Darmv9-a+sme-i16i64 not detected
  <inline asm>:11:2: error: instruction requires: sve or sme
          ptrue p0.s, vl4
          ^
  <inline asm>:12:2: error: instruction requires: sve or sme
          fmov z0.s, #1.0
          ^
  <inline asm>:20:2: error: instruction requires: sve or sme
          st1w {z0.s}, p0, [x0]
          ^
  <inline asm>:22:2: error: instruction requires: sve or sme
          st1w {z1.s}, p0, [x0]
          ^
  <inline asm>:24:2: error: instruction requires: sve or sme
          st1w {z2.s}, p0, [x0]
          ^
  <inline asm>:26:2: error: instruction requires: sve or sme
          st1w {z3.s}, p0, [x0]
          ^
  6 errors generated.
  make[1]: *** [Makefile:116: sme-outprod1] Error 1
  make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:50: build-tcg-=
tests-aarch64-linux-user] Error 2

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Changes in v2:
> - Removed spurious a compiler flag change for normal SME tests.
> - Fixed sme-i16i64 detection.
> - Link to v1: https://lore.kernel.org/r/20240626-tcg-v1-0-0bad656307d8@da=
ynix.com
>
> ---
> Akihiko Odaki (6):
>       tests/tcg/arm: Fix fcvt result messages
>       tests/tcg/aarch64: Fix test architecture specification
>       tests/tcg/aarch64: Explicitly specify register width
>       tests/tcg/aarch64: Fix irg operand type
>       tests/tcg/aarch64: Do not use x constraint
>       tests/tcg/arm: Manually bit-cast half-precision numbers
>
>  tests/tcg/aarch64/bti-1.c         |   6 +-
>  tests/tcg/aarch64/bti-3.c         |   6 +-
>  tests/tcg/aarch64/mte-1.c         |   2 +-
>  tests/tcg/aarch64/sme-smopa-2.c   |   2 +-
>  tests/tcg/arm/fcvt.c              |  20 +-
>  tests/tcg/aarch64/Makefile.target |  11 +-
>  tests/tcg/aarch64/fcvt.ref        | 604 +++++++++++++++++++-------------=
------
>  7 files changed, 330 insertions(+), 321 deletions(-)
> ---
> base-commit: 046a64b9801343e2e89eef10c7a48eec8d8c0d4f
> change-id: 20240624-tcg-bf8116e80afa
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

