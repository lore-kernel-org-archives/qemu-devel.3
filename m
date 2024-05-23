Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF34C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 12:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA7TG-00077G-OT; Thu, 23 May 2024 08:22:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7TF-00076n-IH
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:22:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA7TD-0006Lf-BB
 for qemu-devel@nongnu.org; Thu, 23 May 2024 08:22:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e69888a36so12714530a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 05:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716466974; x=1717071774; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DyVhdIbQLAcGTVeFpbhFp2SdJOB8dGJIsYLEV94Ho1w=;
 b=fR/HJpXL4AAD1qwRkDjprFPSHj3UD2VPzo8DPSkY48wvKM75Bau14JLmqCp2HhmNxz
 lIW7eJmmlrUorGAkwc080qMT2OjD8SpXMN7FkYLaywh8p3ppNyM+QXZsbwp890mdRgT8
 3rWfOppp1CsxuhXnmLT57gT8GM1r7xPF5uZZhvbAt+rcX9vJWvqZYftNKEIqRpHyw3Sj
 5Cxnw1X/Etp5hx688YyPKsWguT7opRxj6/cyGoJu8mZmPNyvxDjnC5hXZxS4OJbcJDHu
 7DSwBPq8ok0Gnc36H4Os8riep7Sbx2RObHR105qPW7RSZnWYYDQwXpoj9k3/tTWaAwAw
 NlEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716466974; x=1717071774;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DyVhdIbQLAcGTVeFpbhFp2SdJOB8dGJIsYLEV94Ho1w=;
 b=bhw621NBtMYr75e7oWN5Rxmy/YFSfUei/CXtUyfXfHqL0e46ezosgJh92DVqmMYC1K
 mzxfVEMgDKZOwmB6pldCTnY0tJyHsiVTwGQx0sR8wusJJ3FR49mP45Q/tcBzGyx/oGM7
 u1ug4YV1tRyfmxAW10r9gPipu8FZyuJE4r1vf/6H8ZaDan1IFba6UKs5agIThYcz/LQQ
 8adzWoM7H9RflepZ0gmb2iXCZ4jAr9kepuSWbVdzoVH6kFLpnuQUuh/mYMi6KbpIbM5I
 xKo8qmj6XInh/nFDsUg+UH/KqOsUcaR18YWBe8v9VD/gJLUYeOnoZAef0C6cukBGFJWS
 f5mg==
X-Gm-Message-State: AOJu0YwgNYIRrUF7FzX5c9ioXnA1t8OX/IwA7f3RMJC01rB6/ITAujuN
 /mzSR1FQ4srbcCl1E+Q7unUDwQEF7sH6NfNmRYoONrEVuiiz6npU5KHRnvZe0Ik7HX8eeGpAIqx
 7p9b4dJZlnk6LI/WIsXRXbm/Veb9JdAUE2x0Txw==
X-Google-Smtp-Source: AGHT+IH0PTgafeRNMBJjCi3hMtDZ3IpqFBbOJuC39FqvTb44+DFs5NpgEjOgS9Tr/UhN9IOWDhticp6GrxRya0PfjJA=
X-Received: by 2002:a50:9b08:0:b0:573:5c1c:4f5e with SMTP id
 4fb4d7f45d1cf-57832854af3mr3229702a12.0.1716466973755; Thu, 23 May 2024
 05:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-22-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 13:22:42 +0100
Message-ID: <CAFEAcA9UMnt61ZW_AjoLD4UYB-vUusbOGaB_E0toH38_5Ojgfg@mail.gmail.com>
Subject: Re: [PATCH 21/57] target/arm: Convert FADDP to decodetree
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

On Mon, 6 May 2024 at 02:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This fixes a bug in which scalar half-precision did not
> diagnose sz == 1 as UNDEFINED.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.h            |  4 ++
>  target/arm/tcg/a64.decode      | 12 +++++
>  target/arm/tcg/translate-a64.c | 87 ++++++++++++++++++++++++++--------
>  target/arm/tcg/vec_helper.c    | 23 +++++++++
>  4 files changed, 105 insertions(+), 21 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

