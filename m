Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BED7CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Apr 2024 12:10:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrGUO-00021Z-Co; Mon, 01 Apr 2024 08:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGUI-00020i-8z
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:10:06 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rrGUF-0003x6-Ao
 for qemu-devel@nongnu.org; Mon, 01 Apr 2024 08:10:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a4e79d7d21dso18191466b.1
 for <qemu-devel@nongnu.org>; Mon, 01 Apr 2024 05:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711973402; x=1712578202; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D6DNxbwvGdG1y5jTEy/exG7WEKA4eqkGllT5ObDh+0A=;
 b=HYUMJf3lYqppxSGC5/zIg+ulZVAM0+Friz/ZtxKwWsx5HCjSHurZiz9s+R0ljIVu1F
 nZlx5IJKLhzhDWe2RbE8uqPDsIA/bAsFaNPb7u/e+Xi8iVVdWdSZbGf7q5pyNgVjj8cY
 r6ZdIEG8F1DX3acDSmrWxrmg05xugMc5R1IQAgbeJ49tI6bQSMvy8Nc3Qkq0H9BDGSp8
 OuTkQ+34xl1z0Dm16zBiETrTsb6PYB20Sw6OG9uUX0uQ2spKUO0y7fSF3rEcFQ0ct+pC
 gUQAzIcl4lSGdtIygRqgOGXk6UvKRNrHSKRLF6KHYYB9brsOpurB0zeeic+nnfgydsdn
 7hlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711973402; x=1712578202;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D6DNxbwvGdG1y5jTEy/exG7WEKA4eqkGllT5ObDh+0A=;
 b=tLrpZjottcq5Eg+xnmJzvj0Wlks4y6uZdnHBUc6tU1e6M6XLPkheUKIxMvAYyK9kqr
 4EIMLErHvveyraLYi560yPYGACY4K2ZMBwABT8vHBm2Rxa8g+EG36METuCTLVcom59lu
 N5+QSyEcgaJnmJm5NVC9d8imfCS8ENx+6c/PjxVl5TQaNDpf2ALuigXpPpj2jouRg2Fc
 2Fnjge86b82Xb/3+MRofmJeKB+t+L025KkKLNhJkJGDLjK0BOxve5vYno+6nQQASE9j4
 v3I/3d7T1o75F6m+l+Q6Wo0NcRS6a5mHMTSmAUdEvCTDoYnSUQIY3VYCcha5GObse+u7
 kSuA==
X-Gm-Message-State: AOJu0Yxc5kjSMxuDEk7CqXJ5R6u9hiTlpTlENcO8lguBMCNlL6P3JOWH
 PWoD6mMgYLStdEoJqcXNJeVYgH9zHqFEmuyGN4k+Cv/0A094VuUKjCQQIzyAQYkD66/HRxIRyvS
 Vqski9H9g3Li7wxC55qd+YTpQjskYuDFiWJB0bQ==
X-Google-Smtp-Source: AGHT+IHXVrccsquIYvfakCYqn+Pj1dAz1jAPdcshVEK5j5oVAg4wDSViB5xKkiHsyRieOmSxFHJ0qHqHoNp3K8HmAFY=
X-Received: by 2002:a05:6402:2806:b0:568:32f7:6c55 with SMTP id
 h6-20020a056402280600b0056832f76c55mr10208869ede.9.1711973401807; Mon, 01 Apr
 2024 05:10:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240331073349.88324-1-npiggin@gmail.com>
In-Reply-To: <20240331073349.88324-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Apr 2024 13:09:51 +0100
Message-ID: <CAFEAcA-6hqzLowj_y_mMhD_08j5pU_D3Etnt15HTg9fpnk5Xzw@mail.gmail.com>
Subject: Re: [PULL 0/8] ppc-for-9.0-3 queue
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Sun, 31 Mar 2024 at 08:34, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The following changes since commit 5012e522aca161be5c141596c66e5cc6082538a9:
>
>   Update version for v9.0.0-rc1 release (2024-03-26 19:46:55 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-9.0-3-20240331
>
> for you to fetch changes up to b07a5bb736ca08d55cc3ada8ca309943b55d4b70:
>
>   tests/avocado: ppc_hv_tests.py set alpine time before setup-alpine (2024-03-30 18:50:26 +1000)
>
> ----------------------------------------------------------------
> * Various fixes for recent regressions and new code.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

