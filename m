Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3357FC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzVZ-0006lc-TL; Tue, 28 May 2024 12:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzVX-0006iq-8F
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:17:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzVV-0001nw-HR
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:17:02 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57864327f6eso1746709a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716913020; x=1717517820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tBgieR/viPTn3U2zbnH1Ut5T/F5fwHVCaQDR/eJLJv4=;
 b=dYuY5nD+LosIUXPuFo3WUSJmsw2DQuoj8Okax3jE8wswtQ5drfEHhIuo+FDwEcRPiJ
 wtSvShPLg72di9q4xJXZ5FnUAm4cNRLRd9hW1n4Wd784B+5mHXSn44pgmpQdYB/3nETE
 o33oGjPyEiWtfiJF7GNsoidd5M0QITGhF9K098HMKvRdtfxLG0bCwByR5veYe2F5UBE/
 tm9iV3DgM1A/Po3zM1FAJUFzMpfI8zwT/PSyfVD+odbO5sYRHyWcHi+Cv/pdQTUwvmmV
 /NhC2cIZofrUEb0xa1QIeDpRhk+6h8EYGhYv8J+KEZD9hKoEmtu8LNeDov7zjsgOAoE9
 d1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716913020; x=1717517820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBgieR/viPTn3U2zbnH1Ut5T/F5fwHVCaQDR/eJLJv4=;
 b=SHKUTD2dMlPVcnPi+LkvpRhS1OlxcAqIFGAfwM8df4ApWXbRmXjCYb2P2GowaoIPAE
 zNbBgIb6aPIDV06UVrEvgy9+tX2D5AIOUnoHS0jogjdloyQa5X84jAUeIhgldxUGM9tA
 bp+4x/Hf89MnugKlwvocVEZiV4AYqIVfcLcdJbql7VuotmdQaHXkupYGu33lSL+I2cvH
 AfRw2/trkIJ3XFFO1Vp+bYe4oLRHDO9MWa5m82G/AWG+k0RuvlY8eXCyq4dGBVsemWX6
 hJ6yuE1uXxrZWG6113EmmgIAHlU/17qmxtjI7NeNb9Llkmo3iQNxlysQ9N0fIBNThrJe
 /R8g==
X-Gm-Message-State: AOJu0YxpeBz3DJ8yk/ao7fb52LwIeRYZYHipiHm+mxDUFEe67M+yv/Dm
 IRngqiHGikq7YYH4g2TvNec8F62/IsDaapLHAa8ug23lX+JwQ/0KbJfeXL3plxf826rCQxqhA71
 GWQ91JoWO+QHBlJ6qqPDdPUTtdir/NtiB9S+I9zUNLa0F1tNU
X-Google-Smtp-Source: AGHT+IE2M6rJnB28/7uqqzMZGf1SFad8gMYd0MO8LIgQ0TzbmcrGwawnfxk/MOmeQHWxjrZKjTx9NtThA0lnXlMv4Ig=
X-Received: by 2002:a50:8e5a:0:b0:579:a157:81c6 with SMTP id
 4fb4d7f45d1cf-579a1578959mr7600609a12.8.1716913020083; Tue, 28 May 2024
 09:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-68-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-68-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:16:49 +0100
Message-ID: <CAFEAcA-e+80XkzD_cRnyJNZiqqDuZ-bdm8aCVg78jKVtqbFxug@mail.gmail.com>
Subject: Re: [PATCH v2 67/67] target/arm: Convert FCSEL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 25 May 2024 at 00:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

