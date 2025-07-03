Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9DDC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 09:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXFwI-0006Y2-KY; Thu, 03 Jul 2025 05:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFwH-0006Xd-FX
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:05 -0400
Received: from mail-yb1-xb2b.google.com ([2607:f8b0:4864:20::b2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXFwF-0000bW-Vq
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 05:09:05 -0400
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-e812fc35985so6277053276.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 02:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751533743; x=1752138543; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=19sM8GQAH3nygG+aDNkJlOVi0vNLscL809RESZtHiic=;
 b=N7iQ3QDUYxddCg9NKIji6CLMhP7mF8TtkotJ2/AthODpG92fKcsrYYqi2LH67Wj1DB
 E1Zh82+rtwWLg8xA83m6Dg2fbDWGjCN9r9XjtDIYP4iZto9yMlAkhs2+QqMdO6L+1L5D
 X4ff09p4L1SmDWWrvVfchbYJ9smDY7dgRllTmLlRXbYfTOE9DMrkW8PW2AKyvhLISY78
 0iqxMw40wZKd9og8uQ3fRh3cMa0vT0Q7X1PnbhTYlLZ1crQbIoaUOL2vuEJjWJwE9Ojk
 aX5I7VBYHzLclsxm3TgdEI17R3GvM0drLJ5qXvz7/7xb0XBl0FDv365nIxYFHWWI0lCm
 gxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751533743; x=1752138543;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=19sM8GQAH3nygG+aDNkJlOVi0vNLscL809RESZtHiic=;
 b=NjpKMnqIePVsZej3afpSZMWcjvGTeGhxq7NiAItCYwEcjBWMBmOIU1vBhEY78kpT0v
 uNAS4iGHdgQvmjbzUs2lFdmsjKshGg6+FNXKm5d7VUCIEqWlTp0xfekJoSi+y8MGH62Q
 8el7XMVt7dyBfMrqdpUciQTRj/cyf+2pTHlgTgpr2z00xPFuDl0YTr4y4bBY6Jrr1KNS
 liRNOHjuOgSEDs31VAylXCOSz0Ri6SZhAugSkPnzcmeWhfFOnjFrvR/D6uIGl2uxeANB
 FDmevbM0u3eiwgydG6bB59p6grbxMetiHRXSP909CnoG4K2uetjHZOknpLWU11mgKsHy
 85gQ==
X-Gm-Message-State: AOJu0Yxy9034zEgQBrVlZILF7/EpbcSvMp3v912CRoX98kJNSaaKGYDx
 sKw1Zsa8UaxcZzr41/xtPv38Xhhd1MJcA1h31RELIpwF0b9jD2oxv2nF6RyE/dfql7WNUzeCN5e
 OzQp/MHKKwb7jr8aVvrjMTQIcl+ymWoq4cu3ONYC/jw==
X-Gm-Gg: ASbGncsD2mXe76vyOX6nRXJ+xTkHh1fG6Z039oF0jBIajhKdi00+Zx0haj0mMhOF+PD
 2lDONd5uVyQNtOs3nZ+cVJOZEkCOpDhU6tvzYizpPhCZFRl1VbSpGdcOLGUY6N7rBnRfzHoNTnn
 EveXjk32dX0ERF9srXRQEeLS9/SXnRI6+9jMiMQhFs1hna
X-Google-Smtp-Source: AGHT+IEhG62BU0Z7KEfa2i7eQWrP+YLCmQJp77lXRQiz+xiPdvgtkdEy4Z71TkIBzMnW8Lu171VyptZyI9JwclrOA4M=
X-Received: by 2002:a05:690c:8689:20b0:716:5986:e4c7 with SMTP id
 00721157ae682-7165986e512mr28518197b3.11.1751533742988; Thu, 03 Jul 2025
 02:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250702122213.758588-1-richard.henderson@linaro.org>
 <20250702122213.758588-6-richard.henderson@linaro.org>
In-Reply-To: <20250702122213.758588-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 10:08:50 +0100
X-Gm-Features: Ac12FXwF23s7tgNY1scvtcyyBij7boKIgo9hFP5dLldkqSungnaSws3NyQJfQW0
Message-ID: <CAFEAcA8V+W70XHyo5FVVcsHsGvsYVUnJd=xwNQzeDedyhiMjiQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] target/arm: Fix FMMLA (64-bit element) for
 128-bit VL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2b.google.com
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

On Wed, 2 Jul 2025 at 13:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-sve.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

