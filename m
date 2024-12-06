Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B89DE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:38:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJaPC-0004OM-EN; Fri, 06 Dec 2024 10:38:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaP2-0004Nr-Pu
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:38:01 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJaOz-0001qd-Nr
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:38:00 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa62f5cbcffso276437366b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733499476; x=1734104276; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G8Fo6iIJlNHhzDlVVt/Rjav4R9vrj9oER1SMrM6sGPc=;
 b=FQrF5O4lsezmSrrZMSxxDwj6E0qw5mMpIHHsHA/ggOLHi74zPwLAfp58jRAGM+8tO2
 VmUdTa+SAjblyxBRY3GnajNgb9WIc2Yrr6ShrHS6RT2Jm6Il/r8DYA/9I1PlZFD8zUeJ
 slzbpeXLYuTqUDQ0fDMdYw9P0Y3+bu1gyPnRejrJ7sMt2mybjVF1FWHO+RRLA/fqF1xn
 36Rzrp4bOiARVKSR4+yZuOZ7vMtH2uHIaK3N4CqjhEg9O1EreGn6s18DlcvxmZatCgX9
 aD3YFlONSDANr8hZJeo1L7q7mxA2h/bCw4LTVx4lfrntmbv4vZLBG/SIZ0ADjwUf7KYw
 zJmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733499476; x=1734104276;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G8Fo6iIJlNHhzDlVVt/Rjav4R9vrj9oER1SMrM6sGPc=;
 b=nBc8nacfd21i9JBcfYylQWqL6IrNpd/YFULFn6advEsBSfiajJrY8Ej67/SIe3h60a
 heVc4tJ1IiNGca0GUxCysWz3KA3ZvRe5I/DTPHCRlJXRvftS62OSmWUqmEmq1M1cI69T
 R36i7cmeLySLB56WtiCgIBqP6RlTiZ7H6+Zv3vEgXaykQp9QalXzGffrs/9wnOHDHrlE
 5v44kmtawzNdITdX4k1snge6gFE06GC+EFS1xJnKxxQ3Hulf/8BeI9a31aEVI2UAklM+
 U8H4fCPzWyNRwmVvwnZzaFAz+d8ZrxpcN8mCoCnXqlZT/tw7CUYqBCnaOb5UpnZDPjVr
 qBYw==
X-Gm-Message-State: AOJu0YyrrZAaQJhxWXArJ4o0FJVbsqEBfQRzyD03aL4+MokDvgU8Q3cX
 /odArSgDne4s3/O8uDWhuSXoe1nNMcL6AV7pelZR+hiuQxCowqbvW8sjOp6DV9W2b+WUYPLMsI8
 a+Cd4oR62DAGXtnsAPT/oTPvGFJFeeNRTw6OZcNHIUud3rAr7
X-Gm-Gg: ASbGncvU/FAPIb0I5ANl52GREDkbdCoRunR+59z1fcnhXVv0uxHIBqntKvqWYggtv0M
 EfX29OXsJDPUlBr7jR4LZEWy2A5uX02ou
X-Google-Smtp-Source: AGHT+IEFckLQm7QqAW7a9Mf/UyaHgpqBcCFMSymNaQuMqG2/W4tWCIuFm/7l9fVwvgBg8iXqIowaP8SyrAtVlrfUwsk=
X-Received: by 2002:a17:907:7da4:b0:a9a:6c41:50a8 with SMTP id
 a640c23a62f3a-aa621892191mr781692066b.17.1733499475774; Fri, 06 Dec 2024
 07:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-46-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-46-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:37:45 +0000
Message-ID: <CAFEAcA-1Lqmeu+3v2vim_oKSXZmCshFpr+j5cT42mSOoLiRfQw@mail.gmail.com>
Subject: Re: [PATCH 45/67] target/arm: Convert handle_2misc_pairwise to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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

On Sun, 1 Dec 2024 at 15:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes SADDLP, UADDLP, SADALP, UADALP.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---


Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

