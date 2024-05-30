Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418D9C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfmO-0002M2-1V; Thu, 30 May 2024 09:25:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmL-0002DF-Hz
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:13 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmG-0000eo-JK
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5788eaf5320so1086614a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075506; x=1717680306; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=F74Wbx43d9yV1DeKGcpW/Xj5P9jhL9sEG1rVH8CKDe8=;
 b=UYIvIgROp5blkFHGZUo5byJzQsR9dNJ/6vOmUhb+e/XWKehiYZQJuN9t1aQYVBW8iW
 OZu2BHfovdXyqoFQr0ceQlNhF0SMReKiegYadaC3nU2GI17ZvRCedC7P2qy6nJKWUgQj
 tJkrrLzol+pSKDcqUakP4RX1DtUqFApqmgS3kdKddxDO1HtT2Cc2fWM++lVSPXWdSN11
 H+54Qu42A/2qEN/D6UramJGzihyPP3uHIzJbckp6j04RYsJnqltKC3eHu5NU4/y44oVW
 cMxXuw9Nvwv562pFVq0VUOObfpXQ8rGTL+g9rySlZGRY+uG9j75047k0+XBJRYrTvL8w
 51wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075506; x=1717680306;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F74Wbx43d9yV1DeKGcpW/Xj5P9jhL9sEG1rVH8CKDe8=;
 b=Qx7cYAC9xNrh3rTtyhEzHA440OmqtCIx3IkQZqxNnfInQuZ0T1CLfbVL0P4+jhBvYR
 CrzipLdbh9qEVLmbp1i2i7C/6OIEdpmVh+pw6zacgBujjRU22f//uugjXIxcGAqH5L3Z
 /sOKyUQD44JWqbB4GFeZqubFVz4JQudoPoIEt+9G5sZeQwArFnF5ZBAqA63QskN73dQU
 k21W9fxtrHOhffxboSeLP+ACqFUAg+fBGC5OMILaO78MOEpx5wopoHPPi5G7bw6BhGaq
 N+RZOYMBsuaUgfCAAYhD+IMpkPwfa5XwrPRqgHw48s+27udquMy1jT4scgm35mROU28c
 gdMw==
X-Gm-Message-State: AOJu0YzQYcZqoGj/C147q7/y3XbEgdAVWtjDITRKIBFwCSwp02iQueX+
 S6QRUB3OT5S69MVFaBD+zTIZnwQP/IzGSE+CoBomVDhi4xWNXIxQ5g+pNw91sYmS72v5XjlnG1I
 K8/jOU+oQT7ZGeqqTspuBFiVwYAhalPk3kxovVw==
X-Google-Smtp-Source: AGHT+IHl2oxh6xEfi/4HQnRhjNj9Y2Z1X7n6sg/PcxuPsUFz7dsSsdBF3sbAz40DlJ4tqq4oJ6YmgwBi04srwiEBz4s=
X-Received: by 2002:a50:d7d3:0:b0:57a:2525:f1ee with SMTP id
 4fb4d7f45d1cf-57a2525f38dmr885674a12.4.1717075505792; Thu, 30 May 2024
 06:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-9-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:24:54 +0100
Message-ID: <CAFEAcA_vJ7hR_iXJsyNYC7Sx1WCS4rAVzpqvBPgfR3=Hct3dbg@mail.gmail.com>
Subject: Re: [PATCH RISU v2 08/13] sparc64: Add a few logical insns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Just a token to verify the script is working.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

