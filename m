Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F0EC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 11:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA6lV-0002tx-FZ; Thu, 23 May 2024 07:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6lT-0002tE-NU
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:37:43 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA6lO-00063g-8I
 for qemu-devel@nongnu.org; Thu, 23 May 2024 07:37:43 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so3471495a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 04:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716464256; x=1717069056; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AjPzKmdwd4hPWL6XPZftU1PYBYkQeoM1bSkpN9r0UEs=;
 b=OmhJyvbEbAeDr4iH6JKBHwlVKtheDgp7hJGGRtLZG57Bua9ku5LHiB3sLIbnalPrEL
 G8coJLkS88bNsvO6bXvb6lByAiBrJ0RxoWO2uCUdAokHv7Hln43dHdyWYjh0limWfHDz
 4H+iydn8EoeCdnaYW2tHgvO/vOa15PI2GgfsuAUlkEvyrrjI/valkNJ/bBA4vSAjutTX
 qj0kohosu6m1G2jJ9o/aT2CY/TRBoKXSdqLJGA8LeYuOzZo1X1TX/o/nN4Bwr2a8ADM8
 vJEYbwcQOVQkICO0PQ2VnHCY5LPziZZIe1Tpjq+2y/WAOyI/Vxat4Bj2biC3b0RKWJgO
 Ztcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716464256; x=1717069056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AjPzKmdwd4hPWL6XPZftU1PYBYkQeoM1bSkpN9r0UEs=;
 b=H0aAmu3H4+jUjKfM6So45MRvtpHDCbYaIdn0fsG02fdZWD+kOuF6upoEoVtHJDVcji
 s0aqwGbb2DZ7lqpiDfMQLdt0G1nZ3XZfSkI6Ob4L5GoFB78YWoYT/aUH+gcV0b18UWwh
 XbyPva3eiQo+FEFMW3DvvpS2UA26PC8YsYmAEBsZyXSo/iqkx29S7CTpPBEqmQR1f30h
 hH5EPs17BWIrl+SotckVCif2acWjvSltk4lxtmIGeycUuxbgaqfzFLvs4OFFJuBbZISP
 dAl7r3g6/RwXqnk3EzTOFoVhgqBEEUcPq0iHoOEViMkN5lg+UW+xCTfvbBu/ZrRq7A8a
 v88g==
X-Gm-Message-State: AOJu0Yzs4WfnzZiBsjL1k4uzM848BZUTBjKxzIsYlzZwyR8A7fFHKEmQ
 ia3khLHEGHyxa0rIlH4UNWBLkQK1rOHAN+6QVl3cgooX5knUAyCtnvyVAUyrKBtlYdOL5pY10xv
 D+paVlV3Hgn7zTV6f+mJMLBUk/dxZcgj2bEr/pA==
X-Google-Smtp-Source: AGHT+IHYNXhv3YqyY9y5+54p4A9EYGeQjZEih83MpYwLNJT7MRHI3PnOSujuy4Jq5Wvf4c/Imx8ovEdihwWnoObQu/I=
X-Received: by 2002:a50:a69e:0:b0:572:a172:be71 with SMTP id
 4fb4d7f45d1cf-57843ec07cfmr1600934a12.14.1716464256156; Thu, 23 May 2024
 04:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-14-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-14-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 12:37:25 +0100
Message-ID: <CAFEAcA_+wf4Xjz+z304kd4tKoWKLaiogFOhfW2Yw+3S9QRDmaQ@mail.gmail.com>
Subject: Re: [PATCH 13/57] target/arm: Convert FADD, FSUB, FDIV,
 FMUL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 6 May 2024 at 02:08, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-a64.h    |   4 +
>  target/arm/tcg/translate.h     |   5 +
>  target/arm/tcg/a64.decode      |  27 +++++
>  target/arm/tcg/translate-a64.c | 205 +++++++++++++++++----------------
>  target/arm/tcg/vec_helper.c    |   4 +
>  5 files changed, 143 insertions(+), 102 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

