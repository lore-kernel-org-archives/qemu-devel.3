Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B424C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 21:24:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thEmc-0001ub-IE; Sun, 09 Feb 2025 16:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1thEma-0001tM-4r
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:24:05 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <a.tarasenko@gmail.com>)
 id 1thEmW-0004cI-4U
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 16:24:01 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso5346700a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 13:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739136237; x=1739741037; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSiOpw+C4OG9Y7kki3qCGviRlSuvL4zBKAmUunFPRSs=;
 b=EXoZwa46wT4YPHf1DAZ/I8zvvtg1pdScsuGmxAXGIXdQJKVunwYBebmFs1smOnD/D2
 +vrRYdIGnfR9G4TwBYNnjxA8Xhsx4uAYD2/lVL4RpR/WBI48LLRUqw2ELA/OO54aji2j
 znd5qPdrwRZdv1obZFR6/Xx/qM3SVUVeJabavQYddyEmESxjEDioFXA4P5nEy86phTaB
 a6Q46MYe00d6fWENg0Iy0knpGnBxM7N1Fok4X/fNkXMMDLPZ/l6vcdtzt7FE1C7C9ID/
 ZD6FgIz9JDbAbnKp6poD4b5RSZQE23LDGcLGNL0Ke0V2m8Sd5QMvtWvxZ8IFhclC4L/N
 mX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739136237; x=1739741037;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSiOpw+C4OG9Y7kki3qCGviRlSuvL4zBKAmUunFPRSs=;
 b=QJi7kVxggxHRNfG9f7kJpOGFFMHm9D079PTTNzp+tEo+Vq02/3TPLlnr5tEJTacgi0
 dHPwCDSvNCdVXaa1RJbcsc51w1VIwinq55/BoEm3P0di9+sjJoQfXajqvOI/7FahrcIi
 ZrFdDwrYi3OM05+3BVDaXcvH78VB4NIS0ULcp/hatmM4oCbHoCoE3wLTGaeC2gVs7NzU
 tzO99sRMivnlfkrUQj4raQaH3QGGtga4Yl+OJVUzG5vgxC0B5O4UjZXXEvb6u4JsjARS
 bYGi6I0AIbDwc1aQvSihQ04JSfSw+Lt4hP0BanUS4QSv2O/2EvW45JdVKdz3HxNul0Yr
 3EQQ==
X-Gm-Message-State: AOJu0YyGT0UBKMc5pPzgPezUJWEx0tdnz8n1+NGWpqUfdM1gZFgUxeBi
 CX84pTTWld7MITXLWQeo7nQ6DJr8CvqBG4Fn09JrCRaoA70iJeDKGtumATx7/TriU1XOawv2UBZ
 Q3MexUXVdvEciWe5sJc1u+OswAfjyLA==
X-Gm-Gg: ASbGncuNO4cexrrkRzAFtYRvKIvtVXrZXdc1Y97jb/uzqj9HI5o96QuJy6sMSd518n6
 B3yCYwTbZL0lQ61XjekzTvoEjKs4A2rqGSez7vnJT8KfTtC3VHCtcXRW1sa5XuzirV5uCRoY+
X-Google-Smtp-Source: AGHT+IEoy3DNVgALGDcGfCQtpZQ8VobX2nb/KFivz8sCxFwvnozQMm8yeCszanU1kCsv8WO3uVvEX80aZtf+X/PbPJQ=
X-Received: by 2002:a17:90b:2391:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2fa243f0ac1mr18082658a91.25.1739136237097; Sun, 09 Feb 2025
 13:23:57 -0800 (PST)
MIME-Version: 1.0
References: <20250205090333.19626-1-git@miszr.win>
 <20250205090333.19626-3-git@miszr.win>
In-Reply-To: <20250205090333.19626-3-git@miszr.win>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Sun, 9 Feb 2025 22:23:45 +0100
X-Gm-Features: AWEUYZn8-fwVvyVTm1YBnIf1M_zxcwZCbp9X9YzlehHDk2Zh2_c_srtQUWC3bxc
Message-ID: <CAAM0arOoLuORHtjCxxrWFsdmgJ9G0XawUE9tBikj0xX3LPoTSA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] target/sparc: Fix register selection for all F*TOx
 and FxTO* instructions
To: Mikael Szreder <git@miszr.win>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=a.tarasenko@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Feb 5, 2025 at 10:03=E2=80=AFAM Mikael Szreder <git@miszr.win> wrot=
e:
>
> Fixed a mistake I made in the FqTOx instruction.
> Fixed issues in the FsTOx, FxTOs, FxTOd, FxTOq instructions.
>
> Fixes: 0bba7572d40d ("target/sparc: Perform DFPREG/QFPREG in decodetree")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2802
> Signed-off-by: Mikael Szreder <git@miszr.win>

Acked-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
>  target/sparc/insns.decode | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
> index 694a28d88c..cfcdf6690e 100644
> --- a/target/sparc/insns.decode
> +++ b/target/sparc/insns.decode
> @@ -321,12 +321,12 @@ FdMULq      10 ..... 110100 ..... 0 0110 1110 .....=
        @q_d_d
>  FNHADDs     10 ..... 110100 ..... 0 0111 0001 .....        @r_r_r
>  FNHADDd     10 ..... 110100 ..... 0 0111 0010 .....        @d_d_d
>  FNsMULd     10 ..... 110100 ..... 0 0111 1001 .....        @d_r_r
> -FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @r_r2
> +FsTOx       10 ..... 110100 00000 0 1000 0001 .....        @d_r2
>  FdTOx       10 ..... 110100 00000 0 1000 0010 .....        @d_d2
> -FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @q_q2
> -FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_r2
> -FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_r2
> -FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_r2
> +FqTOx       10 ..... 110100 00000 0 1000 0011 .....        @d_q2
> +FxTOs       10 ..... 110100 00000 0 1000 0100 .....        @r_d2
> +FxTOd       10 ..... 110100 00000 0 1000 1000 .....        @d_d2
> +FxTOq       10 ..... 110100 00000 0 1000 1100 .....        @q_d2
>  FiTOs       10 ..... 110100 00000 0 1100 0100 .....        @r_r2
>  FdTOs       10 ..... 110100 00000 0 1100 0110 .....        @r_d2
>  FqTOs       10 ..... 110100 00000 0 1100 0111 .....        @r_q2
> --
> 2.48.1
>

