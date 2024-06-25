Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592B3C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 12:43:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM5WA-000065-MZ; Tue, 25 Jun 2024 08:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5W6-0008Sj-TE
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:43:23 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sM5W5-0002ls-6b
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 08:43:22 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57d0f929f79so5116913a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 05:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719319399; x=1719924199; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9KT5wPwVBGAp6POKcn4D1ShlMSN8ZeqGVZRXSqSnOW4=;
 b=xIEexahVBMC7+oNUSaBnPbTlM8uG92Fu+eq2fo/fKC0ch6oCbJawrniXlslzucNx11
 NlAmgKcFUp3QShX1o3gCl7sffC8gBk20dE1S7cCaPBCt95gjbyEvltfkXxmQo7orzdFR
 ZBEHtygoG4lf92p79LOVaSqpJenv7xK7hTQrl4mfNP+YuKTgEeCWPEFWmTlVEZxxH/ty
 JVlYkdy1i+Uo9cFWxRUbhNaqCDunLEN/OtxieKSBOPb0Ng5NAE7zwVBhU46OQaN7mswA
 bDNLmLsQU8z/QS+AtTrmo2vKh30ClLTLZah6wmB8KKgiZXuMdsO6MkBMDLX0OpyxlwEe
 vQGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719319399; x=1719924199;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9KT5wPwVBGAp6POKcn4D1ShlMSN8ZeqGVZRXSqSnOW4=;
 b=WXyK9xtfNx2d7nPJejTz7cI3eZoNFUILaqNYU5LG1jaPoPGI26mYRGjmA4kobVXlK4
 yxrFr/L2Al7HDe0K/U636CtFc1MWeT7RJxH2gzoYRrFBmz4LzHRkOMt6pxyiGCq6Xgoq
 qljKiGv+3NURTr/s6Wn9qdSvddl107MFumE/RufPByQ59nlCsRKJG446Jnl7I7hZJON9
 Wyy6LEcaFQkO8jbWZseryxNU+uY2c2TmstZ0k5W8upPco6aAB/lSvGiLWhb7eLRTqL8e
 nW8BQWTaV4mJiI2c2ax8s/Rp5JKOWF592Fqk5KIzmoiyS2aKmoBh2MF1AVuUcYVe8U97
 DRYg==
X-Gm-Message-State: AOJu0YxXnRpr9YXMKOqvg7ZHLZfr7q4C8UNxU6BY+SJoG02GHq/ObkmB
 vnDHTc4GgQNXtLjmQCCt4qlkJvwykU2qvw2uKyfeKytq4By9q+3S1TOUmr8SQco1iA666riW6My
 JjXeVxqN03k2dGRRvoSGgDF0NtHfnjg6LDBKoTQ==
X-Google-Smtp-Source: AGHT+IEAwt8Rn0GLjBRxoBmE0UNRhszdY0iBHqgQX8uhH0uvfFsY6WumFKwdI3+ItRLgZAGAUupOVnU/wuMB7LcVeGk=
X-Received: by 2002:a50:9555:0:b0:57d:4cbc:cb59 with SMTP id
 4fb4d7f45d1cf-57d4cbccbf9mr5042493a12.25.1719319399726; Tue, 25 Jun 2024
 05:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240625050810.1475643-1-richard.henderson@linaro.org>
 <20240625050810.1475643-11-richard.henderson@linaro.org>
In-Reply-To: <20240625050810.1475643-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jun 2024 13:43:09 +0100
Message-ID: <CAFEAcA9jh6aT5f9tVuQMqrt2GDT-csXuDMRQ6p=5sFZfm+V6Cg@mail.gmail.com>
Subject: Re: [PATCH 10/13] target/arm: Add data argument to do_fp3_vector
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

On Tue, 25 Jun 2024 at 06:10, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 52 +++++++++++++++++-----------------
>  1 file changed, 26 insertions(+), 26 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

