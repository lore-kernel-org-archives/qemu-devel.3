Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66287C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzAD-0004KM-B0; Tue, 28 May 2024 11:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzAB-0004Jj-Sj
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:54:59 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzA9-0006iC-8C
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:54:59 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-579fa270e53so940303a12.3
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911696; x=1717516496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nFxJYvNldHwZrVCu+fFet6j2GNc53uIscAyjPU2nE/0=;
 b=Szvlft/vbsNKp4eY00LbD7s9nw/bk0rJOtrvZYWO51VZnGi0eI4lRISs8q+nGptMjT
 gmnEZL+RoPhrI7LvAyd8XOB1dfvjo6A/r72N41Z420dPrHlOmgTJlpw7WodBya+6a9v8
 6u050p7R3kNVZgTchhodm3CxDpupe8AvWbBWbXxS82SD7Ys8ADb/t6r31+uzDxG/u5N8
 H0R+sKsePxS8tQ+g9+4j4x3evLk7L0Jc0TmIQiVNrzn5bOxmpXrLqxnQg1MPO93Zdl5Q
 /QQQwHPZj1t4sjpzKWeZO+xzhpIXdLc9Vae2aOjojK85Ha6webhXVUekpWxM8zOIYOGy
 zxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911696; x=1717516496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFxJYvNldHwZrVCu+fFet6j2GNc53uIscAyjPU2nE/0=;
 b=GMVvihPNSHGX1JCcVpN1l0kNGacfoASGnXQvq/Es8TfihU7WZCYHbcnOzuzY0dsHAU
 sY7O3Q728Ju6sMrX+OmNPgaYTfTUV12VCjJV0SGlf+r/4xtmjVKPmBbb0Jh5tdupVg4A
 u65lZ3efLz/Fcse672y2+9FDrWfQA0iWbbDTVLQj2A4XhJESKKOMwLKw/pCjneJ6YcpO
 kaBiFd4oWtxfFqCshIE7gursSTIRcinPX35eLNCk2yT0mcOHxNqEX9j7lJtZ4diwytmj
 sGE2X9W2ls3VXzrsBM4mO4uyq+pyphxpPKz+9dkLLxqbWucO9K152lWT4lJN2mcc4UlT
 Rtlw==
X-Gm-Message-State: AOJu0Yyit9jwIm32Tn+nzpjaymqIzRnpkG8YLuNR3UHH0crlTGhpSwOs
 K8SqJC32uiQeBDCYuPF5XEVsckGTkC5SJdHop6ON6E/m6KDWKxAhjrv3B0YnOyNshn+q8U4dN+L
 U/T/yPo88Ge9zhuwyYqhjCCHsFIQxw1J9DskrIw==
X-Google-Smtp-Source: AGHT+IH2Iy/WhiCNzYTlOFnsAp3cFLGzrBqsPinKGZ9d+zVsVYv39rLOTF/fQW5HekfF36yhXvPhae+LvuLmBflpAa0=
X-Received: by 2002:a50:d5d2:0:b0:572:719f:b430 with SMTP id
 4fb4d7f45d1cf-578519aa424mr13014427a12.32.1716911695634; Tue, 28 May 2024
 08:54:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-49-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-49-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:54:44 +0100
Message-ID: <CAFEAcA9oLG4U5-pnAJhsiVbBttAyJ-+2xmpEOT-fZs1MRAX2OQ@mail.gmail.com>
Subject: Re: [PATCH v2 48/67] target/arm: Convert SQRSHL and UQRSHL (register)
 to gvec
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

