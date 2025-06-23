Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D836AC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:13:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTeAu-0001Ub-Da; Mon, 23 Jun 2025 06:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeAr-0001Tr-HB
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:13:13 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uTeAo-0006xU-Hv
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:13:12 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7111d02c777so32379987b3.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750673589; x=1751278389; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8BBkfqibraRa0aoAi+c4xDtH+N8aKTvoypud0ydhsYw=;
 b=LXu7GqbRp+wC6BchWj/274cle8+WhAm+qHgEDI//B3EBDAJ7ND/7EE7vCED8xZAjWo
 cqrgZZ7KL62JhNutugwB5E+RJ8fv0op9oRJHxVs4Fjn8GIuam1dhfwGvnoEcqcqmL1jl
 LgDKNE03eOovxBdXDFjZFJoBz8G720FniQWVgLTWuMYrbXF9EdLLSaLtkKcconEDGwQA
 9254WGI0Q5x9N7gs13cIDdxXuK09Ydncz3b3Wq9SMfnBuRF6SzecLLYP+UEF0Ru2j03R
 UVSmxHxl8RbtPzOypGBGcLjOXZXillXCUg9WIC7kK6Ni0Eo1j14gSDF/fCzHKoykL/LD
 b9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750673589; x=1751278389;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BBkfqibraRa0aoAi+c4xDtH+N8aKTvoypud0ydhsYw=;
 b=qWc7BZQpUg/k18yrMs3VJ1rZ2grNiw0vP1MmqUuuL6a7JnkGO44b6H+ct+HoQ7xgIy
 SF7maf2RhuSS9R46Ew0qMDwIFp7nT+kZfjJhuPtjkAjs9oucsiQ1mvOQgYUyBj5bfGsI
 QVPcF7hMmi8X+sfmlK6mPO1OQ6RvOs5cOoYilecnFX4EphQ2EmjuBky0B1pzrWNWr5ZF
 FHTkkTGXrCv7Rnpi4bxB7bXlNnin9MLCbv4aYCygVtcCmhvKXgmvB7AbHH+PGR2Lyt8C
 jZpZjt+Q+GWGFUfaGNuKhlR0dwpLLUbmdN7PkL/5fbBF/4VYmyoDu2AcD+jYTP3UceWw
 nuJA==
X-Gm-Message-State: AOJu0YziOcRycT202+Chi3aSXi/9l4CnP8mUIalB9GAldbbwF3tb6O8q
 FN3QptwNMJJ3JkHwck7zBuZcJkxJc/Cq4VX7KGQH2Cng+KimG/qZz4NteMyHmT6V5Zo/PeQewOr
 x4JTSFm2tyGRXk4P0e+SjLQs5BE0l9yv2bOY3gCR5Yw==
X-Gm-Gg: ASbGncv7zouTvdMoul/7lPoCLsfYnWxE5fG7p6r4PsdN8ZgkHKtZlOVC0knT/IHSA4B
 J+dSWzbjswOPggBwvtBL2vrXr9o46D2Dgx0Y4hS5F/l463QC2+g08oQWQviPZ/lrCMDVRLs9jtG
 AFB1aVA8iBLmsPQv9WTtsY3qFawpLEoA3qswPmxHPGyMaG
X-Google-Smtp-Source: AGHT+IH9+gabJF/EUhoxWqKKOXLsMqbz3MbIcQYDn7VHewxYlZtza27/dpGH3q12B81RTxy3GeuCl4tXpmiKQQ4EE54=
X-Received: by 2002:a05:690c:360e:b0:70e:2b60:1562 with SMTP id
 00721157ae682-712c63b1f77mr178931397b3.16.1750673588863; Mon, 23 Jun 2025
 03:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-6-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jun 2025 11:12:57 +0100
X-Gm-Features: AX0GCFsIL8TcrTNIy37AjxSE4SNkBOBpNQvMkp5uqj4mZsSl8dOZT8ziav-01h0
Message-ID: <CAFEAcA_abVC2O3icdpu6RyCBn3xU6DoB=ejG=2aRzianj4VDOQ@mail.gmail.com>
Subject: Re: [PATCH v2 005/101] tcg: Split out tcg_gen_gvec_2_var
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
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

On Sun, 22 Jun 2025 at 00:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/tcg/tcg-op-gvec-common.h |  3 ++
>  tcg/tcg-op-gvec.c                | 85 ++++++++++++++++++++------------
>  2 files changed, 56 insertions(+), 32 deletions(-)
>
> diff --git a/include/tcg/tcg-op-gvec-common.h b/include/tcg/tcg-op-gvec-common.h
> index 65553f5f97..877871c101 100644
> --- a/include/tcg/tcg-op-gvec-common.h
> +++ b/include/tcg/tcg-op-gvec-common.h
> @@ -227,6 +227,9 @@ typedef struct {
>      bool prefer_i64;
>  } GVecGen4i;
>
> +void tcg_gen_gvec_2_var(TCGv_ptr dbase, uint32_t dofs,
> +                        TCGv_ptr abase, uint32_t aofs,
> +                        uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
>  void tcg_gen_gvec_2(uint32_t dofs, uint32_t aofs,
>                      uint32_t oprsz, uint32_t maxsz, const GVecGen2 *);
>  void tcg_gen_gvec_2i(uint32_t dofs, uint32_t aofs, uint32_t oprsz,

I know the existing tcg_gen_gvec_{2,3,4}{,i,s} don't have any
comments documenting them, but is it possible to add something
here? Part of the reason I find the TCG vector handling a bit
inscrutable as somebody who mostly sticks to target/ code is
that the interface between the target/ code and the TCG
core code is not really documented.

Either way,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

