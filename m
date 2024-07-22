Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C899DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 12:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVrxp-0002DT-0V; Mon, 22 Jul 2024 08:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrxV-000104-Qa
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:16:08 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVrxJ-0001eU-9F
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 08:15:57 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2eee083c044so48028711fa.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 05:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721650551; x=1722255351; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TqlB7XkmOv2gcWdklQRtGqt6OgLVM+VAhGIbvGdK15Q=;
 b=gDaQ5k8tXaQmYOi5OpGPtxsdDIDrIrw04v0HvwNKQT1mrtTIUA9y4m+3OwPlOprTvI
 hY7bnLWZFgVqSqEsw21X1ByZkbEN7fZeEnixHniyO2MesQX2GeOlqBczfdpub8SshQNQ
 3L6hJskUx8Gc2yYKUiJ0fQQw/FtWsPKwK3vaCXdPsY6It+GhiYycFizJARgWVrzBku9R
 8395U8WOSYktGa7oJcC+Y3C/kvCsbw7WmnoBT8qbmRjCe6wbqDa+DPENmJnh6y2dySkq
 SibAdgjwrCQvZPx5o1o1nlxyHOD746lVl+lGT5FYW3fOrGbNKtL4s9sCveZq7jpNdCuf
 Iu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721650551; x=1722255351;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqlB7XkmOv2gcWdklQRtGqt6OgLVM+VAhGIbvGdK15Q=;
 b=G6WkbAIjjpy1BbPccTg30A5SbxDVMlt1RQ68lofgqG64dTSWgCj6XqfNVjRmXzgwBC
 OXt/No2//wvPcrIwetdhRhAxQN0Gpeijy0OVl9rXjwZZDAd7+5aKJ+91u4fJ6ChJmD2M
 z5TNKGTrqwn0dMdOaK5sR07sCm6y1jKXrqhEIhiX9UTf38e4hQDcsBYUZQwtmF/s9sHr
 KQYeqw8rH/HmHHRkSOYubFDRBiEcsU8qUKD0sTufNZF7yTtpg6Vu9YH897TI4H7wQsQg
 9Q+RJdDyETvnQj0mVOirTXrcdxkRj4PeBhY2pkF5Lpvunhe4ipUrXDI2LKgCWy5oZYK2
 BBug==
X-Gm-Message-State: AOJu0YzRsKUTvrTiOfwThf/S59HE76wtjthPCK4AZwExVfDqpjngAw9Y
 kpjcAAtP2VDOvQKBZe/THilsnvbz3F3eMPlQzvfsnDE5bWyKAjOutQQMb/e4MManbXKRljlDzeS
 Sx3j/q6JBZxfQlymN5VL5ISjKorbjov5507hwnw==
X-Google-Smtp-Source: AGHT+IFUIvf7+O3wvJHY6qDQBZ1da3l28u2HYN0OHXIelu2ghjunSIrq84qrxxUFpmTM2s21RD3fYwPylAjr3tqFkv0=
X-Received: by 2002:a05:651c:549:b0:2ef:32fb:6c4c with SMTP id
 38308e7fff4ca-2ef32fb6e8amr14789411fa.45.1721650550970; Mon, 22 Jul 2024
 05:15:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240719010707.1319675-1-richard.henderson@linaro.org>
 <20240719010707.1319675-12-richard.henderson@linaro.org>
In-Reply-To: <20240719010707.1319675-12-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jul 2024 13:15:40 +0100
Message-ID: <CAFEAcA895VodF0Ejfuy5aA44cL7UvmoaWU0WiGrngk7gyU5mHQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] target/s390x: Use set/clear_helper_retaddr in
 mem_helper.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x230.google.com
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

On Fri, 19 Jul 2024 at 02:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Avoid a race condition with munmap in another thread.
> For access_memset and access_memmove, manage the value
> within the helper.  For uses of access_{get,set}_byte,
> manage the value across the for loops.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/tcg/mem_helper.c | 43 ++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

