Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDD8E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:29:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZKY-0004ep-K7; Fri, 06 Dec 2024 09:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZKR-0004bM-2B
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:29:11 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZKO-00038N-EF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:29:10 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aa6413fc7c5so70983366b.0
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 06:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733495346; x=1734100146; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q2K9u7TGAzixneHesDe5rrtwEuAVGAJBqiMVHlkwc38=;
 b=WyQuf3uY8v7/qT9vCtwdpyF3cF0J6l8L4uhxu/cbhRwXBjoNiqMRcABYZCrIZJ+/iC
 7ioTzaXR/fNgstKX+XeKo+cVEwtEiuh3bBmP/kqsXTN1mPHHYUmo7wnmHPrEk4WjAdwQ
 7JbJZ1YTr1lVrJkfvlMuAa+mz6c5ozPgddlnQatFRCZzhFUMA9VyScCzv7+GOrZS9tf2
 Szc7gXoUdFIWDCAAfSp80Ir0V+jwoXyVskMjiJvhINCxKVOJXZMTw1MTrOrS3MfeZHLd
 nzxd8RzhEqW+lrEp0ICn+GR9wnmX3UmaueSm/aqpAlmLSGfTSmnEMsKZRvku0j6vnDPH
 ZUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733495346; x=1734100146;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q2K9u7TGAzixneHesDe5rrtwEuAVGAJBqiMVHlkwc38=;
 b=mnlif9zzowECKrQ2rgMjhY27m5RUqqI/s/G3fmlU19FgpAIPfumwzVt3qRM8JHfths
 Tww65DedfJreakpLnNgxmVKKEQ2rZT65gk2IohCqKR/pydi/EIukBb/aiCyEuISlEUA6
 /MewRJVewcOBhtubMr2ici9ckRAjn4EZh9BpSPfCQzhjG6XGPQGLZmX22/JVe961/wEy
 uK6EWpaN4mE0fev2PkDn90a77kzsmPO/LPflginW915Vh7dFO1Xoy7qsAFhR8dR9pvbU
 yq+U0wIh1mZTGBgUuMBvXAE9VKAXka8sNZ+kGriWevhDjfVExVh4oW8Jy5GNx23DLWcO
 LsQA==
X-Gm-Message-State: AOJu0YxKTwnAFQhxKqfe4+DuUdA63+vupjMLEOfpzOkBXz/E8H37ZF7h
 kbQ2kZH5yZVcMlIW8UqdwWcqdEdqwDE6CKYt6QX6NpB11j05AngwCHmCQHw1wmDhOX1xVBBVZJr
 +Kybc1EynN4bwhem833rxMazCd7U1WTPpSSX8NA==
X-Gm-Gg: ASbGncvYYKfPeZnzbDz5r09MI+3DqFoM0D/IqQ1DdBPCyEouoEm0XT60E6aFtah0Mfk
 Tq6XZo5/l1Zi6ABS9Fe3K6sieMl/y7lYd
X-Google-Smtp-Source: AGHT+IFnxIIYzfO9JGHaFY1tzZMhRojWucpR7Mlq+tb4EQE3WQa+oU0qLCMpzoOgNqRwWhWgWHOaN7y9SZBRkqhXbzY=
X-Received: by 2002:a05:6402:1d55:b0:5d0:ea4f:972f with SMTP id
 4fb4d7f45d1cf-5d3be68007emr7767202a12.8.1733495346523; Fri, 06 Dec 2024
 06:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-35-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 14:28:55 +0000
Message-ID: <CAFEAcA_ZetREHWS39g80pTPLPdDbvT_pVsOxS3EhHgO9qs6LwQ@mail.gmail.com>
Subject: Re: [PATCH 34/67] target/arm: Convert SQABS, SQNEG to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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

On Sun, 1 Dec 2024 at 15:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 123 +++++++++++++++++++++------------
>  target/arm/tcg/a64.decode      |  11 +++
>  2 files changed, 89 insertions(+), 45 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

