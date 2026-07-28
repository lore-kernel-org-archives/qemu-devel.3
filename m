Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1812C531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woejW-00062G-Ii; Tue, 28 Jul 2026 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woejU-00061F-NJ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:08:20 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1woejT-0002tw-44
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:08:20 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84e0688b859so2247781b3a.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:08:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785233297; cv=none;
 d=google.com; s=arc-20260327;
 b=SgdxmIzxXy8/CZLZ6dcCdZrX7L8w1+2Xoekjh7AWp/PzoAkLoZDIHhN/0lDiT1M76w
 y2q1JQC6fgHJgz3YsXk2uTBCw4aoTOGaT2A5ykcJmdMyz3B+oLKcC4z3eI0LiYeVamSl
 ekk9iYrusVB6QWq5GxXKcA1TWbw8Xl3MfCMOrfMJtENyekkpoKFO+uu4vfKCmbOM2Rnz
 zqeKqo33+IOmhx/IUaURa/UgWY7eQvfN3ZHvW9TavtpmQbdiU2MQCAcqqNnu3Zbcj9vd
 Jp0drgffQSeOWAceFJcHkCHd70zgg8vrV3O/N2Hliy3m89bsmGy0IEBfoqJ7e3Opjezz
 geZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JIgVzNEEgAxZnCC/6kCbzkUK93pDVNFQiloOlOUEUK4=;
 fh=Ignx5OwJGf5MLaEhElmXotiHFVlMs56P+2OVxWOMZwQ=;
 b=PKnbFV5jBMEZo1cvyCCUw2Mt5RGG32PLDl7XvvoEcwiMn7QHViFOVOjqhN2VD8Z1hE
 5rjj1spW8VWNlsIjUY7xZMfMQiWV4FHpmMFCPyLGBPtQY1uHITMLgZcbeAwv0iDeYLmy
 RcAxnUsSFn7Nf0cYNM9RlzmF+ZAd705ZEpYe7u0JCDSgOmMUxeWtyxGExL9eL7ikEtVE
 6f+KrTUbeZssyW2UFahir17kKr3R/SMEkBmmj6fIrOJarTxdTEWPsIbJNhBgh1oAeyMx
 AgRDS/z8v1HmyWB/DlDqPstY8BZgoSL1UmLrDe6vICCDZ2PZOX50XuGFfdGLs5hSuzSk
 LYUQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785233297; x=1785838097; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JIgVzNEEgAxZnCC/6kCbzkUK93pDVNFQiloOlOUEUK4=;
 b=CCdBrwGUocPztSKaNj+d/AjgOiYWLNkGqoq7B+i5sWuF8n+w/p63HDFspUdYluEdgF
 JyWfginpiEjbZ2+pGMJvQMHwN+pRpycO3m/B4oo9kSB1ZcYtNgmRMSONexZxbdt4LOKW
 lR9QKFUFP2DUKzUz36RrcPSgDatOrJ8vh4y62dMSnQky9DwcnD54vrCLOWlqwbPUSS3x
 jHQHoB8NxrEqeQyZA7fBdP1Yq3x+ZYrhCw6xfA8efvEERyF9GgvdeUEEJ4N5DuRDGE8r
 VNXR8CXmCpGs+/PGT6ULdO3GQF24W6+gnixRAqKMCUeHRHw0cTrcB+bB3hUowCy0ZeJN
 Wdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785233297; x=1785838097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JIgVzNEEgAxZnCC/6kCbzkUK93pDVNFQiloOlOUEUK4=;
 b=q0Sw7OZV0dPNGT4pkDkfNrt31J9BBJ4TFOVofwwB8OJHT4IjWiVEWh2MFxTnHMPQ51
 VmGGm1HNFAB5xdft0z2z7WUm8ETZ0VYdLmZPjBI1epareQfVzYjvm5Gan8c0XCqqwZT4
 TdConyx5iVUeFLpD9ZP4FN1UO9VbZwrOT+spNP1cPH/dkEqjgePNxe6pvmQ55zXWO23P
 Hld+r5ur11h63GM/uosRpTDh/Fga/OaKHux1tYhIYoscLbKEAo851KQktnVJh5jzwQ3j
 xQxkeAAu/zakbDV1vl7S9Ukj+rGx7yICvYYYBSp1IBdSw+dFy4OHnzCkIu4WvfZS9Vpy
 cFjg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrAhBTzG3+v/Hz0wiuO0UP30+K95mHm6xlJR5JYBbrn8fC/n2SEPQJJE6JnzYbeo6og9p4P8uK/7hz3@nongnu.org
X-Gm-Message-State: AOJu0YxclemPw+DSm1TivfrXI8lml9uzN4xXjbbzJEg3sGFIVPbU09z+
 ak3Bj0wdeAgJ5GQfKhjAhfkPz82Rrkwn2BJp7PTTUXYyaluyQVM89xqP3PItaZsHJmaT3/5Vb+F
 pCMJeFjVvk1y02Wk8YK3LFX0BnKQubFY=
X-Gm-Gg: AR+sD13CR3N3tBqYmF5ndL19WTQRqsjxEnooTJ2XO5TRPC/Jc5WuXrMFF6rqMd4A2/X
 fDbJ1dyGmnZ2dLxMBeMFSDTMnG/G4OlvhCBUMp94pfjYgFK60xGnDPaBdtEGmIv0s7gu6ccfcOq
 aKJ4+9YMiwZDP4U76ZDCnDIIh0oS3YCISwrjieqtSs/nGsMSzpqWZrWRWb2D9GNVyQ8c7TcM4nk
 OonGbSOFuYLP9Lu1bf27HqgUICFPLel5vkZfnxOW3ULeFrw6iu8r1QnX1gWhM3UGtGiFriJh19g
 wFaMWnapJVafqt/CZg==
X-Received: by 2002:a05:6300:4046:b0:3c0:b766:751b with SMTP id
 adf61e73a8af0-3c8aafa05famr2253524637.14.1785233297451; Tue, 28 Jul 2026
 03:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260706173324.804340-1-peter.maydell@linaro.org>
In-Reply-To: <20260706173324.804340-1-peter.maydell@linaro.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Jul 2026 14:08:04 +0400
X-Gm-Features: AUfX_mxvftl6QLAhz1gMtiJlX23nbPjTYQIYnLQwNdW1378YWXTbNuI4jb4Sj00
Message-ID: <CAJ+F1C+TO_-ktDqJnbeXuaCdAsomQMTvWZ8aAFndn=JPF1+2sw@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/display/exynos4210_find: Clamp windows to screen
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 6, 2026 at 9:33=E2=80=AFPM Peter Maydell <peter.maydell@linaro.=
org> wrote:
>
> The exynos4210_fimd device has a setup where the guest can program
> both the overall size of the LCD screen and also the corners of
> "windows" that define where the guest memory should appear on that
> screen. The current code assumes that the guest is sensible and
> puts the corners of windows inside the overall screen. If it doesn't
> then we will try to copy data to an address that is outside the
> interfal framebuffer memory that we allocate to be the size of the
> screen.
>
> This patchset clamps the window coordinates to be within the screen
> size. Patches 1 and 2 are simple refactorings to make the third
> patch easier to read.
>
> This fixes https://gitlab.com/qemu-project/qemu/-/work_items/3795

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   hw/display/exynos4210_fimd: Factor out finding screen width/height
>   hw/display/exynos4210_fimd: Pass width to draw_line functions
>   hw/display/exynos4210_fimd: Clamp windows to screen size
>
>  hw/display/exynos4210_fimd.c | 54 ++++++++++++++++++++++++++----------
>  1 file changed, 39 insertions(+), 15 deletions(-)
>
> --
> 2.43.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

