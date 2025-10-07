Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C1CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64ld-0007Ba-5G; Tue, 07 Oct 2025 06:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64lb-0007B8-E5
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:17:59 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64lZ-0006LV-Rg
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:17:59 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-633c1b740c5so6889146d50.3
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759832276; x=1760437076; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OWQ+uwBNoEiqE5jydiMZXoo6byrxmjspieSK53RFY4Y=;
 b=jbO/vv1Cgk5RdjpAAmCGw0LxwS6Er1Ug2ErEV482ZuuTvo/iqAxErxHQOhn/2TAtBK
 JFbF52Ja7+8A1L4wmwbsS+7p+lyq2BdMFfQ8uQHzgOp10fUJOfx9taAfTWhT9pe3QA3U
 bmK0Q/RhUbVgQ8Glb0Pur+8Wc2+cQVKigDwLTbD1BeLIEnz2e2DMlM1zP5RuRpqDGAnE
 Pt3Xyh6ERakbkVDC81dNufUVukcQRfjHB3qk/HUXvLZGeJwANW8Vy6eqWMPZRJakwzH9
 SdAwL6SwEH98zTHZ6HEmHwJqC3m67s2bI9VTubdXihslPX/G1ImJIHrZ4rwuS4PmRKU+
 OFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832276; x=1760437076;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OWQ+uwBNoEiqE5jydiMZXoo6byrxmjspieSK53RFY4Y=;
 b=mLC9rZX1nHtOmB67AZzLSovgA4n4J9jmmu1lAmFFSrhd1ih2TYQXRA8wmBd2sUy5YD
 j4jKsBKxK2WASHu5Bn2mf0EuzQFx0GiWYxzzjPw8F4bnykMuH+yPFvX6w0iGIRlKkqCt
 +ACdsN/Y9yWI0sHR3tdaX1pNjtywDJ1TctD3glwNQDqFTDsB9iXcTo9PNjXpKSOsL0NE
 8ZnebKlD1nIXKupgdhhB4Jhe/8+DtsGMqWgFyJ3IeUSJypc7arg5PrAoqE36iGAdRFJC
 rvd6PTI5FBA30/BaLvMVqvspjBgeeeEWpIgkbvzEWUyiWBue0Kmim19MG8lPQ71KmPh1
 gF4g==
X-Gm-Message-State: AOJu0Ywo4BgrPWbFw/j/vKWHBjmG6XAVftIGgAJRfBV6D/17MZNHtFk7
 MKnzOqfd+Ju+n0t4g3SNzDgam6HFlFJBeczAtTKP70y8Ap2OlccI4pkg+2LXKjaJmNFNSlZAB3p
 jwsV1qnxBYKcLAwxuEQlsTqtoVlQC6EO1RW4+A4IqEw==
X-Gm-Gg: ASbGncu9cXRXj3fszaYM+bPFATXa4PvWn6T/iBEukM7TPPTYg5bCFFdj9ddv2ptMMZ9
 Rwtjcbn3x330MurDRJ699fT/djWtHhUKK58OM1UpYwEefG+zEmzB0sJEfZKEx7Jhl2pvdXeLRdl
 LEA44yoc1KyvWOQjUqC908UeZD7fj736eotYUmsOCV3jXemboPhNNpYDokUIEffReFtUtcmI1e3
 x/trSEzMzimQeIfHV2s4xlwpGenOYTyjxyx
X-Google-Smtp-Source: AGHT+IFifdlt9WqMCVFS//UYX3C0o2Z2i3NmyrDSOxVPxxQEIcW7cM2mSvcd669tQzzGxxVSx5B8dUvYDiXfgPluQfk=
X-Received: by 2002:a05:690e:d56:b0:635:4ecc:fc22 with SMTP id
 956f58d0204a3-63b9a0f2bf2mr16398397d50.42.1759832276175; Tue, 07 Oct 2025
 03:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-49-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 11:17:45 +0100
X-Gm-Features: AS18NWANxCA7g8HysTG5baBRYrhKwrkNhdHNIx5w5YquhQMYfBcHwrMUc1_gmIw
Message-ID: <CAFEAcA-WzWDem=u8w4sGB3aMHEBkUFo1PJztbwM+mqe+REzasA@mail.gmail.com>
Subject: Re: [PATCH v6 48/73] target/arm: Implement GCSPUSHM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 3 Oct 2025 at 18:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpregs.h            |  3 +++
>  target/arm/cpregs-gcs.c        | 15 +++++++++++++++
>  target/arm/tcg/translate-a64.c | 29 +++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+)


>  void define_gcs_cpregs(ARMCPU *cpu)
> diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
> index 38a1f51ed5..4fb73f821b 100644
> --- a/target/arm/tcg/translate-a64.c
> +++ b/target/arm/tcg/translate-a64.c
> @@ -26,6 +26,7 @@
>  #include "cpregs.h"
>
>  static TCGv_i64 cpu_X[32];
> +static TCGv_i64 cpu_gcspr[32];

32 ?

>  static TCGv_i64 cpu_pc;



> +    for (i = 0; i < 4; i++) {
> +        cpu_gcspr[i] =
> +            tcg_global_mem_new_i64(tcg_env,
> +                                   offsetof(CPUARMState, cp15.gcspr_el[i]),
> +                                   gcspr_names[i]);
> +    }
>  }


We only initialize 4, so I assume that the array size
should be 4 as well.

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

