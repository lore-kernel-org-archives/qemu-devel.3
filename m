Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFFADC25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 15:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBz98-00036R-Bz; Tue, 28 May 2024 11:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz96-00035L-TM
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:53:52 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBz95-0006e1-7e
 for qemu-devel@nongnu.org; Tue, 28 May 2024 11:53:52 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-57883b25b50so1186470a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716911630; x=1717516430; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3kJEO62mWg3US9gjJ9OfrPSAyd/LSSHwxTOOro+bxno=;
 b=uDu2voBaWhraEJRStgwiyrTqvmCr05lce7fgGKNQq9kX73ZCTUe2niaE8o0ZRNWE0Q
 kZmgrQC9Soh5lPC1pTp/LJPzgw7aEH8i28D4Xw3R6cappyrb6p+QFYErPJnxPW21oeiY
 SkaWp6KxTITDFshh8l/UjZS25ThdG3K6vgE6p+MNu1DFb03bRWSp3knmQSM6V2j6XvFD
 yhW1kj+PakJW1hO32A7Dx/tegaQuetOlyUF62sXKssgqt/g8Z/sov+jFBnmc2naV5E+p
 RLa4Fve4R7Zt/c0lIMot3xDE/l8+k20T6b1xd6OwKPGAjKeBpbLi6KKudNjlnItDyRn/
 +NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716911630; x=1717516430;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3kJEO62mWg3US9gjJ9OfrPSAyd/LSSHwxTOOro+bxno=;
 b=B9b0lc4E9R7cJ0F8C39SzrkNHPKZrR1tiRV9huMHd9bocQKKQVkd9GkmBJKh/xBZjJ
 TlEBqSlm2AU83yq7CvmQX/UMlMSpoSrpOA6MTeUsRxBOFJ1leasXQek1gwIVvZBdhniu
 a0+d3RMevh1G3FstHXW2LDUvyrZDHioih1Kv5bqcC5uN9kJqrWdbfjbQ7HX9EN6pLaKB
 uzGOlB3n1KhApD56zehd7N/6OpBnsSjQUQJEA0w/mOSfLKo9sN10W15vFL5P0QH4W7WW
 fohBFKf5Hwg2ovNt7/ytT3pBPNf8706wUJUDDtAST5D9u94qiv59T6ohIYxy3OXBdwHO
 Rumw==
X-Gm-Message-State: AOJu0YwtfNmAGJm4i4YuiE0N9gzv0e3wFK/rPjT4zvx2bTA9XaWYa+Wu
 fCLHPKD7fN5ynPa7Tu/PR9clKZQ78lZ/pJQzHEI+l+8BvZ7K4IudODjkgd4HUtQt/8FYi/afU7r
 rxoxkeb9gycsoaO61B9CRPi4JQMSzLyezmbTeag==
X-Google-Smtp-Source: AGHT+IHZoMoXKJTVQ0TJL9PFUg4zeO1Pvsk5751RqXaNuh4eL9i6Yb5DGFO+cfAv3nOcBf4cLpd8oGCwZiAHKckY2qg=
X-Received: by 2002:a50:d49b:0:b0:578:5635:a24d with SMTP id
 4fb4d7f45d1cf-5785635a4c2mr7980626a12.26.1716911630053; Tue, 28 May 2024
 08:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-48-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-48-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 16:53:39 +0100
Message-ID: <CAFEAcA_zkFzbxNXmyeqrp1Gy-xOhbv6OW5ao6rC_WtYP3VXqaQ@mail.gmail.com>
Subject: Re: [PATCH v2 47/67] target/arm: Convert SQSHL, UQSHL to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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
>  target/arm/tcg/a64.decode      |  4 ++
>  target/arm/tcg/translate-a64.c | 74 ++++++++++++++++++++++------------
>  2 files changed, 53 insertions(+), 25 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

