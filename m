Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC194C27C44
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 13:26:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCfma-0002eS-Rd; Thu, 30 May 2024 09:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmV-0002ap-7N
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:24 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sCfmT-0000gR-Lc
 for qemu-devel@nongnu.org; Thu, 30 May 2024 09:25:22 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-57a1fe6392eso749277a12.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717075520; x=1717680320; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tseCNavxQrCrU7vzFFmM/OKtYj7eR15VFFHhfFEzrl4=;
 b=G4ce31KrMg+T/ltNv0HRgWsGqpq1M227ufnoCibG6c2Up0Xyzsp0LScseUlJ9vdd/z
 A4Sdpu16is/YyPMNtcKzVTqR1rI0CujEQVh5AkXfLn1WqVMWNAB33RXyvhAqHMj1S4p3
 FxBCA2P8xcFFmC0c1//IpiJaAHI5AN/5aherlw3s8ED+9uGjb5Vqsg6WNnEIk50ddtgK
 M25FZf0rmkx4qvF2BVwzaaXMgmeSERjTVE5gFKrMDFY8Tjs4nQjGg4Y3wwM61Axnf29r
 46OFgkl7L05+CFYvsE2DnFaXfOL87kdBbenkxGOTs+sLfAOK8Nhrt+Fpf+9Vq7r/G4Bk
 Au5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717075520; x=1717680320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tseCNavxQrCrU7vzFFmM/OKtYj7eR15VFFHhfFEzrl4=;
 b=EOPEFqmuMxy5v48DX2XL+L05OHxbMPblNlakGwR2BE/excey2P8tOpqOEwxATTKt62
 7tJ7Z1XVqZJ4d+wdKa/gzQtrRDHXmKTqOYgpR+x4di02BbO6k/5pRylMYuLVnA04RAo7
 /RvWPz+4b3Om7AA9ikoJW/89+4hO9LwrYX0r5X1gn2U0Ra2qZ9v3DYQQhWHODezPZIsH
 5h/uMj6/4PIsFEn0fTSyDosf9d5e91aO/3O4CzxTKGg/xI2Ftg/NVsbcxRGPUt7v3o7f
 X64SlymNmhXbV6Sd99WNx7NAUYy2mxk6hvOIWe1/g2V8adx1uyZJRRnPumwMRTkymoSF
 4IVQ==
X-Gm-Message-State: AOJu0YwACarXB8//VBk6VJ6XOZsmTqeqcnncseTS1KkdrPU+Q0S9gFJ4
 e/X6gLn1ZDfeRKRQPs/lKqNYPrVOipVcLu5x0mHbh7fTAAkCTK4VA4vMgQa0WTTLjRNsxOxOV81
 t9m+In/665IseHSFcwPF9AUuSa5+TgEsy6uVmUg==
X-Google-Smtp-Source: AGHT+IFnHAduFYzCpB1gMrsqGQIkWcik2elrL2cdghSk+6eVvfUFgcQSe9o4DsNSYHGAQowuGCK+fpMy75w1U/FY+pY=
X-Received: by 2002:a50:cc94:0:b0:57a:22ac:ccfe with SMTP id
 4fb4d7f45d1cf-57a22accee1mr1003779a12.23.1717075520117; Thu, 30 May 2024
 06:25:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240526193637.459064-1-richard.henderson@linaro.org>
 <20240526193637.459064-10-richard.henderson@linaro.org>
In-Reply-To: <20240526193637.459064-10-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 May 2024 14:25:08 +0100
Message-ID: <CAFEAcA94=Wuz1uphVBDjQGV2no7sVy7Z=yKCDPE9=T8Ey_h+FQ@mail.gmail.com>
Subject: Re: [PATCH RISU v2 09/13] sparc64: Add VIS1 instructions
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sun, 26 May 2024 at 20:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

