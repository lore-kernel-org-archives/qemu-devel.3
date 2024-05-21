Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EBC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 10:35:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9MpX-0004KC-Qj; Tue, 21 May 2024 06:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9MpW-0004IP-AL
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:34:50 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9MpU-0003tX-N3
 for qemu-devel@nongnu.org; Tue, 21 May 2024 06:34:50 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-572c65cea55so13839617a12.0
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 03:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716287687; x=1716892487; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AJ6PC3CGDbWHHX2Q5qYVzbZXiT+T2mYSTWQN96Hvymg=;
 b=ZVDdO+AJ06TfAQEL+eudAEdLc3GoUxGfhvfE5jAJDKLBNNnPMmNaBeye7ULzyZc94F
 2liUat6DbF8Jq6yWKhu56knGY+a0jAmQgyD2Gm8tP11ZklzYloxYszaCgpX05UOEUU5v
 peI4DBcn3etbA9fn8MdjLVIib1p4zdBORBCcn6eryoCkkYxq/pPTybPAjTqdPdbv5Y7v
 8NSJodmLyAjK82zWcQhQFcO21YK9qOIa0xUzcrdpbQws5AeTfwhlt1PHRO23EL1sk6uE
 Xl0LCRaXQT40rlH+WaHn22kq6Hx6FNKgEXC1UUTWBU+9fhRU/rb9Op21B5lqEVEkgXcq
 RcDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716287687; x=1716892487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AJ6PC3CGDbWHHX2Q5qYVzbZXiT+T2mYSTWQN96Hvymg=;
 b=WE6uwAy0WYGpEel/kU1FagUeS9ubrNnyMWdWlIOztzjrmY4m7h2MDXmUfnlRQ3UCcW
 dlDYkJXtqluo270/lH/V6wJ2q7bcZvvR8a48Cpc2mksPrCSCRxhqwBku/JhoN81+ZAoX
 p8XF8qle0QoRCliLFox+uwJE4mIB1X8qXyy67L4eKh0Xi00PQ7SLZKhUW99zjTjf+QpE
 AENuWmThLkCTfb2mqDpkv8agTZzmMhpBZTyrFit/c8N/BJ5c1Gn3sjrhWSN4L+MiaKn/
 20tMPqHmsbsiYXojeYl5hsVlpPeOD06m7AichHvf66PryGNql9wwRbRbQIM1vdgH3sJd
 b+xg==
X-Gm-Message-State: AOJu0YxwA5Izv7chPP2f+QD7QspNV6n1Z4kVhslxrXVD4w/jEAMKAKVo
 UGEJKh/DuQflL139t4yJvX+2C8UPRl7sy/r2uOTbHyRQyMR8B6YZKv74CcCjpbaJKyUEtT3HYBS
 nNbpkhJOtMNA2yChb1Ikf8GlaAt497F6s7Sv+/sjz5fyEz7ce
X-Google-Smtp-Source: AGHT+IHq+msTFCfxAhU35Yfqg1SUExASjfPPobBlhX85Rdz/H0pJ5dsenoYYBSjYVykFglUi2lrBsW4Jqd+ey8m80Xs=
X-Received: by 2002:a50:8a91:0:b0:571:bf62:81ce with SMTP id
 4fb4d7f45d1cf-5752b47fe5fmr6782606a12.9.1716287687108; Tue, 21 May 2024
 03:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
 <20240506010403.6204-2-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 May 2024 11:34:35 +0100
Message-ID: <CAFEAcA-OVn1x8mThr6L8D0ShdkofhWxRWfCFNytKhnChncTLmQ@mail.gmail.com>
Subject: Re: [PATCH 01/57] target/arm: Split out gengvec.c
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

On Mon, 6 May 2024 at 02:05, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

