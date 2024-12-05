Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B85FE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 20:37:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJIbc-0003H6-TJ; Thu, 05 Dec 2024 15:37:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIbb-0003Dj-3h
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:47 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJIbZ-0005IR-PZ
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 15:37:46 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5d0cfb9fecaso2094144a12.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733431064; x=1734035864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OGm8EqEb1JifMuwTcEGrtstI8nwT9JKzSTAuJg9GFbw=;
 b=l2TDYBoOVTend+Vzl59qCvv0HlAkpX5JllyMhiYd4TAdcENTiYNfTehcYgGhV4jsN2
 t1sgT985jN8wg/Tk7iILrCzJeCzZ5BuP8fRTJoFiuJ89haIK2bjwBgN4sfcBPlEaPgXy
 WS9nF2YAFgYpwi9ppJeTk8fqsCL1Q8Oos3j9+3hFuMLWcPhznTRX5g8YAL3fQViOxN5s
 Hi2FmuSrTbX1ekquVjmfbe+tB7Eglt7SCqQS7r/3jrr2HtzgGgxVl9pvpYJUIIkK2dTX
 LbsceROou6VH5zX6VkoZcYbt2dUaqFVeUh1/K5N06CPloconU390nSPaJtwaeSFRShfx
 nkMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733431064; x=1734035864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGm8EqEb1JifMuwTcEGrtstI8nwT9JKzSTAuJg9GFbw=;
 b=Sv7PHl9VnKGxLsIor75eBSb9IajXafP/gtWmW5dd2MZtrvZzFuRGVvplctkCt98U2L
 4qvEdRzuRlewc2Y70Pk08QjjhFxAYJAugXcHNvOQWOw2TGUOngariRc3Fs3/P3W3/RQ7
 J9KabrqmKDig7xaYcgpnvYvQ787EnDhqxR5U8uOicM19Fd+DC6cubsHT38Ngh8F8uyDI
 /X5XWYS3KtlZF61BEJG6eRbr3RP+Gz42/sV8g+3on76cPxiHfBJpz5fMmo6kzxaTHJe6
 YFxmCi769ib1JpJt+1KPgr9b3kFGmUDUTCV9KZtB/svNmOlvFEML7wqy4abzpJRo/PCf
 0DTg==
X-Gm-Message-State: AOJu0YyhTgzDwK7DlZQJ1SW4ZvvwRPISznJRE10TqLGNcG1CFQ+oV0f/
 XGP+OZozkyWYqAOl/XyDrtursZffAbuumXgfyVCQGzoQNcEA+3XaQh+VPq4oByHdrMbfkvpZgda
 W59OvK/0p1A06vKxQXUA7LiyEwU3T9KAsJV4t5w==
X-Gm-Gg: ASbGncuILJyXn4SuzmxJkVgVw/e/WEo32rmd2/3HFhPKqaW7sRYZlqVlOrDGhWbiJmR
 Ug5rkteeYrfKWcDvmrvAwoOQypM6kzWivzZjg
X-Google-Smtp-Source: AGHT+IEpjCoFnAWc4A/6wkKK0yA1aL0GVANCCEGywZDhds13MxVPjAyE64yeU1MTPcJSBZdUGX7wq1IfEbZsLn/f1QM=
X-Received: by 2002:a05:6402:354c:b0:5cf:d078:c9dc with SMTP id
 4fb4d7f45d1cf-5d3be763173mr388614a12.22.1733431064208; Thu, 05 Dec 2024
 12:37:44 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-21-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2024 20:37:32 +0000
Message-ID: <CAFEAcA8c+TrdUPa_FYJjzCj5CyQY3m2aTMq-gSBUO0++6-rfDQ@mail.gmail.com>
Subject: Re: [PATCH 20/67] target/arm: Introduce fp_access_check_scalar_hsd
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Sun, 1 Dec 2024 at 15:17, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Provide a simple way to check for float64, float32,
> and float16 support, as well as the fpu enabled.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

