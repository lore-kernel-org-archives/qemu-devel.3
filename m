Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwQF-00040z-Rx; Tue, 28 Jan 2025 19:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwQA-00040B-Mt; Tue, 28 Jan 2025 19:59:11 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwQ9-0004aT-CO; Tue, 28 Jan 2025 19:59:10 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-4b60c221587so3567845137.3; 
 Tue, 28 Jan 2025 16:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112348; x=1738717148; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tVamlpynqnVGfpuJ8zzu4KUBIo8QGAcTAL79+pQ4x4o=;
 b=hGJOZlolsnRclUBy9dtgAuPG8P3Zh2k+pMeUO6xkv8J5c3fauHnK+zOpF3onO/en8E
 OPFn10bHFW8pe952cR3+UiLEr0lfajmcIWvJ/c2+fSoyQ00/KoE+2g67253FiPnqWn39
 TwISPYTZ+NWHpEA8GTRtjzpIwpVAp+A7E6gtt1VuQXs8RTKzSThuicDBEl6CRamzJhzK
 JlEpPSMg0HdCpa7MKdo3yqyt/jKREN6pxqfgezyGD8WRSTQuIJ0AeTgm1ineMRL80BfJ
 iV/GmAc0+W7uX66fA8L2Jt4VCe3ee5HN0XZSWfiw5F97mwclofUheCeWDmjZghYGy2mr
 aeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112348; x=1738717148;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tVamlpynqnVGfpuJ8zzu4KUBIo8QGAcTAL79+pQ4x4o=;
 b=p7t1caBUqJ1ZstKMzKL4cHaqM8V4bh6+naNHC6D1irJAjeHS1/mfGkqIukFgA4K+69
 6HBeHJzN1fXK6sbSB3KnAEhOlXSzEM2Zs/ffga7HKlcMI9ZFZAYUUh5nf7LNOQt8L6Cz
 iDMnmEfX6wL8WYk5SzS3+IV/A4x9Q0/TqGo52YJks7doWnX4/jMeshEA+wwl6kePyOpP
 B5O5GOpsY0QGqBe7AkANZ3eZNu3FxnN7PC/KY20U220MHNtTTquo52ge9vefFZ/lCtyc
 d1Wv/sir6UyRUvKL/uaMrXeBlUjYoDNOYafKd8UVex3sBXSYNXoGK03/H8cPXeo9XPue
 c3Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtTYXtS3Av+xyGgGDHxH399Q7vT9BaYLDgTCp3piIeP25FhrMmxyTtD0kvtCn6DFf3DRd6btDLQ+Ai@nongnu.org
X-Gm-Message-State: AOJu0YwLOOJKwqEVQrGfpPAF0L7VyS8R40Agn6w9lJkp7EPXmNVvOuB0
 gWX5lkSuEktrg/BU3vbqNRAxVxwggl45hA6cEcGlyt/mDNbLVEDhlXAfFE4wcCgcr9DyuZZBsDU
 FRfOXL+kv2On8kuL2HKtQl6Lccec=
X-Gm-Gg: ASbGncvPJNS9pibnben4eA/ui6tHrL7kmwLRJeZ8EYcqet8VndN2sYGeMV3+kgHz6cE
 LEaRCAGLR0EcY7PWbrDPfgAypH4lthDBekVOz5vm/1r4KDg5UDxyohs3EtzR+YiTr9WBMKIWnPs
 D8F9UPCE/i6Zuu77A/D9h/JiXjpw==
X-Google-Smtp-Source: AGHT+IHF7Mw+ECkrWDCcTLeu7ffh9dG/BgiAX+cTZK07Q/ZI382uXzIEXb6rTlaWupxwSbiIiXnfHEeG0lasogxsVOY=
X-Received: by 2002:a05:6102:2ad4:b0:4b2:45a3:59fb with SMTP id
 ada2fe7eead31-4b9a4f267efmr1153190137.2.1738112347824; Tue, 28 Jan 2025
 16:59:07 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
 <20250121184847.2109128-5-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-5-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:58:41 +1000
X-Gm-Features: AWEUYZkBjphxn6umkpzcMJHRG3vA0p2F9TDn0RCnZiaHGLD-nBXHtbN0iileFVQ
Message-ID: <CAKmqyKOYvQU=1vfu=Huj650OmPMtaNgUx6_OBV3WZ-VGon9G1g@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/riscv/csr.c: fix deadcode in aia_smode32()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 22, 2025 at 4:53=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity reported a DEADCODE ticket in this function, as follows:
>
>  >>>>      CID 1590358:  Control flow issues  (DEADCODE)
>  >>>>      Execution cannot reach this statement: "return ret;".
>  > 380             return ret;
>  > 381         }
>
> The cause is that the 'if (ret !=3D RISCV_EXCP_NONE)' conditional is
> duplicated:
>
>     ret =3D smstateen_acc_ok(env, 0, SMSTATEEN0_AIA);
>     if (ret !=3D RISCV_EXCP_NONE) {
>         return ret;
>     }
>
>     if (ret !=3D RISCV_EXCP_NONE) {
>         return ret;
>     }
>
> Remove the duplication to fix the deadcode.
>
> Resolves: Coverity CID 1590358
> Fixes: dbcb6e1ccf ("target/riscv: Enable S*stateen bits for AIA")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 75f21ccabb..dc0a88a0f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -376,10 +376,6 @@ static RISCVException aia_smode32(CPURISCVState *env=
, int csrno)
>          return ret;
>      }
>
> -    if (ret !=3D RISCV_EXCP_NONE) {
> -        return ret;
> -    }
> -
>      return smode32(env, csrno);
>  }
>
> --
> 2.47.1
>
>

