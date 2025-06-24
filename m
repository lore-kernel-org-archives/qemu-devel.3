Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70290C77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU10u-0001TX-V6; Tue, 24 Jun 2025 06:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU10s-0001TN-Ut
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:36:27 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uU10q-0001Um-9k
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:36:26 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-70f862dbeaeso49964487b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750761382; x=1751366182; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tw/zF4KTPLxhE/4fAx6bC0Ivpjt9AxM7g2JWgeTV1Jc=;
 b=nximtAKY4nllKyR81O3QClFbkOJ1YiM6tASNy4VstbrXNMkM78cL8w2npSEF+Ogs0B
 c0rO559yyo/Apq6rejhvRhlznOVnE7Y6zaSt7d3rL4rU0Grai1Ft7r27grvXpYvInpnH
 gq7XWgE2ox1Z9PjKacUX801uA9CO6Ajr4ayFH9i2muvygXx3HzcBLOA8AdpEiz2hhS+3
 LBw/dILFqG7fE/tH8lQ3iNAeXgN0+/LjGhL9XbZydPxpBTdA5hqbVBkrrZopisOfUE4M
 XdpBxMN9lLnt1vY80EDzz574N0s7YQeKXRQ9EWAQCp69TTv/iQpful4ds1UExNhdDiL6
 5cuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750761382; x=1751366182;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tw/zF4KTPLxhE/4fAx6bC0Ivpjt9AxM7g2JWgeTV1Jc=;
 b=GpL57OeOpLzmp6wNjGXAs8rhvHXDKlE77knUC8+wsKEbpf4w/LnN8CFpulf36keVh9
 XkZT9wlX/OcEEQPaCRJcwy4saN8dY4jtLMQRsEy561EP6Sa1IJVkMqm+lTigeWSp2A00
 b7uK8L94gkNI7FERswbtHID5ERyDl7T1Nb5mh/MZo95kRrO0ZClULp88WeT6dh0bzruk
 vjX/ixgRFH5PIsGeUS1ZV2wYM8z+SWtTZlEMWtewZsjhL1Es8JgpEfiMovecOaJRSFc3
 ZgGxKFmh98/90OvFBDcaUvDI/jzUcoGD5QayuwlXLIwE2KLBEYixBu+kv/ksgl28nz9V
 70gg==
X-Gm-Message-State: AOJu0Yxp+lux3OHs/xrMm/srdBK33krYcRykF6ltmZfZgYSIpc+yatmF
 FbOX7UMhfPG92uTJRWCm/2XZsZNOKS7CPR1hU9Swz5Kuxh3FKUghvSLk+UuYLMtxL275PKjCGmm
 fwPpef3dkzY+6HVGELx+/kk1fLn4cBUiQE3SXKxc6bw==
X-Gm-Gg: ASbGncu3OpKpGvODU8e38nF6vlCXfcS67D+QWuVDaslzSDN/cdBfNbekFc+iAimZcpQ
 klav3cqZjQ5k9g2jYoRVdgR7ymz1wlQjK4OjV1ZSBtk4eQjQzxd2PfDFqm0zqkz9EKUKlkUlE+y
 VrWmOC2wE0zuERAKnTb+Edhsht8Sq8tJjNApzKU/cKmEkd
X-Google-Smtp-Source: AGHT+IHNgTqfBU/FTR3oLhQUFIkJ1zzGXdl35LdLh9V8j6e2h4o7n/kcEEgQsHSXiPa1P27KiZi3+eVqTLPTU34sYok=
X-Received: by 2002:a05:690c:ed1:b0:70d:f892:2dca with SMTP id
 00721157ae682-712c651684dmr247824177b3.32.1750761382644; Tue, 24 Jun 2025
 03:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-45-richard.henderson@linaro.org>
In-Reply-To: <20250621235037.74091-45-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Jun 2025 11:36:11 +0100
X-Gm-Features: AX0GCFswzo7EN07kHtKqENdMfjBNtjirAPUYzO--44yLwOzN3a62u-ZZWJtcfZo
Message-ID: <CAFEAcA_=WLr66Ni667VjZw-7JHi2dW1-u8T02AS2i2Ria-XJ=w@mail.gmail.com>
Subject: Re: [PATCH v2 044/101] target/arm: Implement SME2 SVDOT, UVDOT,
 SUVDOT, USVDOT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 22 Jun 2025 at 00:54, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/helper-sme.h    | 11 +++++++++
>  target/arm/tcg/sme_helper.c    | 42 ++++++++++++++++++++++++++++++++++
>  target/arm/tcg/translate-sme.c | 23 +++++++++++++++++++
>  target/arm/tcg/sme.decode      | 11 +++++++++
>  4 files changed, 87 insertions(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

