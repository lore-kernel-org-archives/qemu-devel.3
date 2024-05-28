Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC6C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzKZ-0003ln-LV; Tue, 28 May 2024 12:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzKU-0003fj-UO
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzKT-0008Di-25
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:05:38 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57857e0f465so1391983a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912335; x=1717517135; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GG9FsqxUtLzktGbkFGaST3fWJoNoXL111OT+VEK4qRc=;
 b=y+jJWveky6hg+BdgJO+0Ul6Si/Ql2msXJgtfCjDT2cHbakiRa51OrIjppn+dBDJUWk
 OLmMYYY0MTo34xFeXOoGX46qGeTaGNX0v0tHgBgWj59Nu2lPt2NIQNoICMZeJNLWo1D9
 td8aRJEPUZaC+SrPNWvRxHUhZRxFY7dHkMibMEd+b+OZ1Qsd1i6VX+RJv+jArkN6LydB
 Cg2pBEPDp0DAn8ALet2lgqxe9LA1sZ+DMMoGeNRXWq7qihSJpIYqMOwfqUDhsFONxEca
 r/oNF1yKBgzzZ6n/f7vQIrl0rm38Ytt3/FOwN5p4vsA9Nzdbuqk5K0BkdCGOzfKeDfpm
 ypUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912335; x=1717517135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GG9FsqxUtLzktGbkFGaST3fWJoNoXL111OT+VEK4qRc=;
 b=AP6+ZuraH2KliWkxMu69Adkj6Vgp5FmLrSSXOwbyYa9QZvwu1L+9UewBTqB43Q37si
 SV8ResliN3wB72sZ9kvxkJr0WtFRFncHKRnvzCt+qgieQWOKcfFFMsfeuW0lN4xXVdqJ
 h4GyZ2wghR2sSrqJ96K5ED1GQrd7pjKvFMJnLckVVQda4ol/H+e0lOOs8qXMzkjIYqa6
 Oc5RXHYNF1rHKUwkNLULyMgRfUvbzeT4ISChnbRFZhwBLCIdshpHgeL34MSlhxqTv6ql
 tBFI7UY0gziFWZ0g0rgP23CRi+ullOLyKt3Xko3qKAJc7o2EU8bq8jhDNNiW7s8NtQXr
 CgYQ==
X-Gm-Message-State: AOJu0YyuvvKQOvGQVeaUdLHzZew/nmG6KUatmwlR7W9oMhfGCs4HqBOf
 zvotCTXTizBU/cLelrfFc+dMrUPiYqBSjqJJVln90q2oJnKWhv/gtlAzaTJ0tAzdJBGSREpeQS+
 qOmvDs3+Fl4QEIw3IydpdV+CqNKOGtSQ5BFUjAg==
X-Google-Smtp-Source: AGHT+IEgfONunQFecOlhkTmA4tBdyXdXA/Z57bI7K1PwAn1clGvPGbImUKL5zmgs7cHbRP2/4fmeOqL9o1oh4qQHIPo=
X-Received: by 2002:a50:9b45:0:b0:572:4fc3:3a28 with SMTP id
 4fb4d7f45d1cf-5785196a218mr8267315a12.23.1716912335430; Tue, 28 May 2024
 09:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-62-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-62-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:05:24 +0100
Message-ID: <CAFEAcA8zprPQDtBATn5HzVjujsSCQrra7sQvfiYSNN6yUjeDCw@mail.gmail.com>
Subject: Re: [PATCH v2 61/67] target/arm: Convert SABA, SABD, UABA,
 UABD to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 25 May 2024 at 00:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  4 ++++
>  target/arm/tcg/translate-a64.c | 22 ++++++----------------
>  2 files changed, 10 insertions(+), 16 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

