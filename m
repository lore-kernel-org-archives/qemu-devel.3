Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A942C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 12:30:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBvwA-000604-PX; Tue, 28 May 2024 08:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBvw8-0005zY-ML
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:28:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBvw6-00080E-4b
 for qemu-devel@nongnu.org; Tue, 28 May 2024 08:28:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35a264cb831so543845f8f.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 05:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716899291; x=1717504091; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZRWgvb+4gkYPGkIV8FKckvdCMeBsk/D0kJeBsTCwWME=;
 b=t5OhQS4GoRu4wCEpuFIyCkF1fp7dtqyCam+O0muvx00u8IXcsuxfr4Uatr2XgsoXgN
 uOAGVsuhI8Ub3sF8Qw/E54cTYTc8NDfwkOlDJk29BsXumdtiXjCC82EpVNH3m5cInNlX
 Bk5laF+s07hEl/EDcng430WKaj9yVZBGoK5HbE37PZALX9Je+ODmHV7Hz5csvJmIAGts
 p40Z1LY7cC546PEcJgcvTbLFdZmNO8P2XxCHTXSAVZ062xgg91OBqDfF6q+/UjxCUQFW
 iMUDU3ToseYrPnv1qRGF/F8amKkuR8E2mZn240KI9Zsxnw/fD0qa83uJBM6M9uquXWRP
 wcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716899291; x=1717504091;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZRWgvb+4gkYPGkIV8FKckvdCMeBsk/D0kJeBsTCwWME=;
 b=cm4ZPv9jOVPcO/Ke2FAP+72hvdVhKVYAuYisktlmCWDGvfp3WMJZFBjDeFfIfabPI3
 DFnX+aw4f1zIRJGxrbLLSQY2KaiLmL6orXoRRNvIb1ybAg/IB4IYp3WT0jJNqOb4QX6a
 Y/wrtuBHKSCR5F2jhOJ30paTycCY294oPTLNtTOKKRq4xr3iQ3aJI+f46Q56a4r02eNZ
 h7VDqnfCH0H2BXpZDqDhQhrR4B33FZwCTtXdgo0dX78ceuH3HhBaHiyK8fjJr5fygQB1
 ANq5ueoiBZTDqJZvXYVeWOtwRoU4i5SZUdWuyg0LVnEjohaohvBWNLDwiNlGhiQZ2Ifw
 7L5A==
X-Gm-Message-State: AOJu0YwtjdYo4LslPnS9TEp5XcNdW/8lz58/fbDMBd0rFb4v4evAvdMg
 ZuO3qDvCXuQOzTI9oVKfYJkyWszZNvncqKH915wFXIUc+BRvXlbQ4zF57CljQF1rMbH5ZxFSxKi
 s+GAsL8tM7+tkhJQTuU6sPKK3x5HpkR9Q/eC5VQMe7jts296y
X-Google-Smtp-Source: AGHT+IHZfONmWoMDjX/5+nw7oewx8C81y7wZakwH9TYd4twnM4MpGIUCxL2ciki8qsAoaICVWIWxE3kXv0ZRXpCEgOs=
X-Received: by 2002:a50:950f:0:b0:56d:fca8:d209 with SMTP id
 4fb4d7f45d1cf-5785195c33emr8569608a12.10.1716898942747; Tue, 28 May 2024
 05:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-22-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-22-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 13:22:11 +0100
Message-ID: <CAFEAcA_k3S0mJntmJXH=48CreZJzFUvNspCyEDp4O-qEwcucXQ@mail.gmail.com>
Subject: Re: [PATCH v2 21/67] target/arm: Introduce vfp_load_reg16
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

On Sat, 25 May 2024 at 00:23, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Load and zero-extend float16 into a TCGv_i32 before
> all scalar operations.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

