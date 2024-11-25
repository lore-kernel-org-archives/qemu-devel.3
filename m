Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB21FD58069
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 11:58:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFXjQ-0004sx-T6; Mon, 25 Nov 2024 06:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFXjO-0004sU-GY
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:58:18 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFXjN-0007Au-0q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 06:58:18 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5cf6f804233so5218593a12.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 03:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535895; x=1733140695; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HktPphgw9wf/x2lyqTJ/BfyoWoO9q6nqOuABLrI8JZQ=;
 b=vSJ2dYIHz5gFU5/kXvN3qjn+oZvc8mVJZK6wWY+VQr5H150xABCFgmd6vL4utK6GtC
 PmpoxsEa1vdtnEph5perWD9/OdDbC3T8kRJK67MsTc6lUT9RLql+4SUWW+eTIwCoeoGy
 Xz8e7g9mMHLDNamif75gJM8wcIG1oGQGRUXco5vCKDJQqgPEAfFnldUoawejpzncKxST
 zZinEhGFteCJiRFVDYvNs6P48V8raLuuo9tyu608p54Gdn6xqgeA/3oAr5VsaTdk5guI
 Etnyw9BjXni65GXOYSnsVltQPqhms0Q+jv2YNzK+tNE0X3wBXNZa7epm1hjHyudwI4Y/
 gQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535895; x=1733140695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HktPphgw9wf/x2lyqTJ/BfyoWoO9q6nqOuABLrI8JZQ=;
 b=qiPsVL5spycLuxCBgUaKw+Z2TAWlPz+/J9rTPqvs+o9g7aHUXno+ReOO8a5X5XmDnw
 9XP3m+K0xeAdF+nqTHqivNCwDHqfTVZavlTMTBIoqCsFYkslyKBUAxWvNgmZHRRJljZg
 X94hT0roPyj4kChou4vz7iOkHB4JOtXQ5mizthshc1xNmEvlok4U/p5SwYOEtqi7Wdcy
 6JSf8iLsbo5ZJZwVZf2jCOMGYrANASC76Bvw7f9adaKQi8T3NY46aVK4U6qhZLgkuFY/
 B8MoknNm+c26gExxh5yoCn3WfLxhbIaSb4Q+EgR3i7L8YJXmsHDC3Q1zq5MrMqaM3EvH
 gmPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXt0hC6SlAbB4nIO5BOCcDKPMYeH15URuXIr6xRfCnwo84Q3haGlZL9YCvupzqw6HndQZ0ehNkK8v6B@nongnu.org
X-Gm-Message-State: AOJu0Yy1Un6MzbPJAyOx2jm0bZE8zFgtrZIhH5wXck/U0CJF+cXDayeX
 lmUwnZrTy7jlLLXozUxs03qKMuORpXrYCB/7HaqQ7rbp4eyVPanPDkK3usf5Ln+1n1WrlNmXuoe
 bkEYh124Hn1gonlJecetTbBBLlLg1g/gvN3Cmvw==
X-Gm-Gg: ASbGncsiHiHOqfiOoyfZZSIpCUosiUiXKRCDJ/RVSSbX4ldXQjwL37KXnmERXHZhsSU
 UQVkmx62qtNELAahwpy8y30NxPeRP3wPH
X-Google-Smtp-Source: AGHT+IEp2dlnGYl0YzB4EpHMMLvwEe7jZTWx5oU/FeFO/BHZseSyxN0vYhUE4I4xX5d9IyG99WHIUjSddNPYUpnDtOM=
X-Received: by 2002:a05:6402:50d4:b0:5cf:dfaf:d60e with SMTP id
 4fb4d7f45d1cf-5d020625962mr10886567a12.14.1732535895288; Mon, 25 Nov 2024
 03:58:15 -0800 (PST)
MIME-Version: 1.0
References: <20241121171602.3273252-1-mjt@tls.msk.ru>
In-Reply-To: <20241121171602.3273252-1-mjt@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Nov 2024 11:58:04 +0000
Message-ID: <CAFEAcA_ywbza7rF_DcpsaiJbokOXPUn_s84VrvGKiTmwrDEMrA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/tcg/cpu32.c: swap ATCM and BTCM register names
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Thu, 21 Nov 2024 at 17:16, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> According to Cortex-R5 r1p2 manual, register with opcode2=0 is
> BTCM and with opcode2=1 is ATCM, - exactly the opposite from how
> qemu labels them.  Just swap the labels to avoid confusion, -
> both registers are implemented as always-zero.
>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  target/arm/tcg/cpu32.c | 4 ++--



Applied to target-arm.next, thanks.

-- PMM

