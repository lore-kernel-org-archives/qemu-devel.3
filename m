Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9BDC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9MrM-0006Gi-GE; Tue, 21 May 2024 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9MrK-0006Fr-JO
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:36:42 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9MrJ-0004N5-0l
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:36:42 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59a352bbd9so1190433566b.1
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716287799; x=1716892599; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KDrdFPsEYwoZM+mIonOdgpd36He9kcq1w7XS/0XBLuM=;
 b=KMFbJ8BVe1NSiFEIPZRgkwuwbdQLOoeTtpseonBlDCKie2sUpOZeMdnDIGMuxCEmEJ
 6sO1jBiqaSnLe8xFmk6J8Sm7SzjHZ2HpSXx0LzDko/Qoe2bRRsdjGNiUUBtJOrwVJ6cf
 7jRva4mJ4V+ZsGL65Ah2uNd0fqTpQdwaBMX7rEFLhpTXZqcVyHLA2xKLYA9HTIUDL8T+
 JtaVxWrKkZ1VSW/uvwsvrQrM2Bbw6Wk8ChamSLuqgIm3zpM5CzirSYcdri20aA1aT6v1
 ZsVHS1Bi3xYhlJxpgj5o2ogAtT6aBvDyY9Y8DLpBmjrfCCkwK82xn+9Il8aS3j1grL+Q
 adgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716287799; x=1716892599;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KDrdFPsEYwoZM+mIonOdgpd36He9kcq1w7XS/0XBLuM=;
 b=sjSZ3IrXIulF19EBQkL/aSFQCHDnjmNJ+V6irATdn9u8eF+s6kavzjiA5j3vTDz9jA
 sTR7s+z6eKnm2tSvVvXkotwrbv/Zaf7FNQGpDJpZCCZRLgwmp0+vDRFafpZclUtTKqmy
 qE1nVd/KpZYY4B87ELYFbWxxrh7q49piF7YUxewOOORF9VnULzpRU5ZHfhZUvSLYxuuZ
 kXL7sYtljoI7xYHIFDpeJaLanxCAkUIEWzlUMbunMUUdQiftT6Ux828Sj9c8HEwayuQe
 PCEJbWidYGvD4zh1irOdC4lAzf1Ds9lnQ68smzlGOEVw0h77Kt3D0OLrlBncogzdWdfs
 Z4QQ==
X-Gm-Message-State: AOJu0YwRdNTqE7ZXGBVzxsSdIn5b/qWvoWGIClVaFriLLGwTq2hWo7qC
 Lbxc8UblQqe+tDEY5+6C6YcoQya2Ra3DeRpEvJyCNWcqwtVZ97j7jJQ2cEn3mDS4gcUeyJBnP64
 IoF5K9TKI81FyoXV//6qAINu9WiqdWpWv9h448g==
X-Google-Smtp-Source: AGHT+IEaGmWPH/B8cbbM6A/xHdsqg47U1EMOO02MZoVMNz4f3Vh8x0rRP2WGR0TgGTy3+PFQEsRriwOsgfrCzOtJMjo=
X-Received: by 2002:a17:906:16d0:b0:a5c:e372:222f with SMTP id
 a640c23a62f3a-a5d59cbeafcmr791296966b.11.1716287799653; Tue, 21 May 2024
 03:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-3-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 11:36:28 +0100
Message-ID: <CAFEAcA8aGTtFH2TJoWCqdPvowa5vKA2N_MmGjsjkFhdHsVgYRQ@mail.gmail.com>
Subject: Re: [PATCH 02/57] target/arm: Split out gengvec64.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
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

On Mon, 6 May 2024 at 02:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Split some routines out of translate-a64.c and translate-sve.c
> that are used by both.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

