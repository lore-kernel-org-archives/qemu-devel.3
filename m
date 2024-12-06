Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA77AE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 15:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZs9-0002QG-18; Fri, 06 Dec 2024 10:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZs2-0002J1-Ca
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:03:56 -0500
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJZs0-0001zj-Mo
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 10:03:53 -0500
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5d3bbb0f09dso1228168a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733497431; x=1734102231; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4nyMkgs9IjhYqg0/+lboPEpqbbXpcekADgozcythdL8=;
 b=wW+1ykBC/lvSSnvN9Ibx0G6qyT62x2iIOZ2fV5BKhQEW25+m6l+k8HGYOLu2t96W9C
 mo72JUXxWKHDat3SsqDAip80/CXfE5OnF3bGL7pmqopNkir3kKn234jbq5vEYRh/RChw
 VU7yD/9IeMHvuPcpFypphnWVfGq3mqr7yomKaDrvGorwXGca/hsXRPFa9eTmx1TYmrPW
 JaQthifpTGh9hK4enlO+hKt+RZ/CGZMtkCiwU0oXbnQEyX1mbUdGqorxjDQnqbgXW+wJ
 msw597D73bfrQIWS+43H2CetNyPvXly72H6LGmBBmws5lNpYWrRle07qAmilsN12ql0i
 Ct1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733497431; x=1734102231;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4nyMkgs9IjhYqg0/+lboPEpqbbXpcekADgozcythdL8=;
 b=jaiaBllWDmrzkmMuqJBDxT8eL3qiLYIIc2M3WpmGHk/euFXlmUQ1F2YI0vAsivxNJJ
 I2kEkttLN+i81kDjWEwJUe7avXah3iTxSnkVR25PIUc5otn4BHUF8Ig1Z3NrwJrk3ra6
 STFjfDcgBWKCcpjdi7qr3/svxI9IXppdPFePoJ70SqQj5zUaFl3W+i5pXV+oMA4AxwB8
 Igp9ds0hCTV0KfcuU+wEB41fj2KooK87doovq06ZahPuVV00MrZxw21XJQE2J0z+aiea
 yZWLcwzTp851qzPII9/S+h3GkO6GVv49pJkZ+8oUmoIKHy2J9xJ4r2ZKkpiCSG8LJscA
 BgSw==
X-Gm-Message-State: AOJu0Yyj9hbeW/UJGtn/DuAkaoPRrh4QuYKmNze7v0kVvPYY2Z2vNtkI
 pcwCPAymnL6bdaK6nFnCpszcEppExVFn92fYO3A/P81TkML9oSO88smh3s5vxNY9s1OYfGt+j6y
 PMxBcAS33p6GHRbp0weS/7X+hdRix6hq1R5BAsA==
X-Gm-Gg: ASbGncugvOgSWKxsHXPNr/f/6pIA6+LWaVqBEOVdzZJhN+IKpOOLZHQdghRHWYJuWEk
 O74oIMdRU2dagDB1V7YiiAbLGOKkY57ZQ
X-Google-Smtp-Source: AGHT+IHJz36R8yNrVh9gtNWEVnMNAdCwA0zbg2g3jwyJdxoWtqUarlJSUvQBC3EGm04bGbDaj62C5H+ZZGuHZO3wDKE=
X-Received: by 2002:a05:6402:40c3:b0:5d0:c67e:e263 with SMTP id
 4fb4d7f45d1cf-5d3be678280mr2681696a12.8.1733497430834; Fri, 06 Dec 2024
 07:03:50 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-40-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-40-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 15:03:39 +0000
Message-ID: <CAFEAcA9t+tKHiWvE3nt_6+Hgz320pdSJOfwyL5c_OKeQfsy0GA@mail.gmail.com>
Subject: Re: [PATCH 39/67] target/arm: Convert CNT, NOT,
 RBIT (vector) to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Sun, 1 Dec 2024 at 15:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 34 ++++++----------------------------
>  target/arm/tcg/a64.decode      |  4 ++++
>  2 files changed, 10 insertions(+), 28 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

