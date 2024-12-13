Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44589E7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 15:34:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM7fU-00078l-Dp; Fri, 13 Dec 2024 10:33:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7fS-00078O-OO
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:33:26 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM7fQ-00009a-Jr
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 10:33:26 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6ef81222be7so18278567b3.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734104003; x=1734708803; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SgW0VK+tMWhI3wnmJtq9NRDsyYDXk+F8KoJoXxomD9s=;
 b=H6GXXq9z+IDCTQp35ELtzCWhFj04bAo4q+vttTi/N5NG2QJdDizyOO4ZfA1aKTzqJK
 WFCASKgUgYeCP9XMqdQV8XIWAOoSpZ+rkpuaM9B08ZeWIyK93Jb8dv9ectNPLNkjf0tW
 qhCfHMVP/vLn6ww3MRVTTVKLi0nkgxs6772JXPZ3QrCaGWsjH8N/UrAQAp9Qso1CrhrP
 nAvKqSxKs/VBMhuLA8VqNu3wa0ddWK7OvM1xhHEH3kS+mD3nQOglb9Zi05xXrQzmT/zR
 qnJY9WvW27CrxRLF6PMznxAUoAoWKlG+20KA9T5IcvY3/hsxIfnZWaiemo5s3JySg11l
 Mtww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734104003; x=1734708803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SgW0VK+tMWhI3wnmJtq9NRDsyYDXk+F8KoJoXxomD9s=;
 b=Uq0sy13lEjLOedEVdGkWZQoSOFVV4v+F3EF0C3QnLlk+a767xA0TtJB3YkVmg9tUuw
 l3K/TegaoeS/SJExDlD0wViiyLpUSmpQgW85gN333ZRC4SEQolqIzWSe02SEV7y+LV8x
 Emjmwzt58/851X346YbfmqCilRCNbgXv9n1xKeLDYS8inb1YNroPJPzAChxgVDVS/oep
 JUarpmuKcrsk+FZHMQeQ5679HIwTSfdKYsYcOlsY7Mu6XwDDMQ/e8AC1fAx1qcPqSu5s
 5h8JD/NHKxxvuUsAheqNCck7fnjn8jrMH0ugM4C9HTB7CxhDfVUk23SyBI95PYkgX3BK
 UeKw==
X-Gm-Message-State: AOJu0YwD+WRMT2KKAqXNnqpx55AWUqJz9E/EqGIDojXiqHW9FObWI0TZ
 Ryrol7aFawEYvQSUgFHZjKFaO8DIM2tLCsp7W83wDWOwdQGs+l5jwHDfLh2WphYa0GAKZ6SEEfs
 LZgk8KHsiI6XGK94aj0tECL/UbYYvnyI63as0dg==
X-Gm-Gg: ASbGncsgJsmrqbFAG7J5PEWIcg76pWtiUrPRoOJMu/lK2b5dVVaXye4Fub1gk6Bz5FK
 IQLXJN2iMZvB5tv6rXEWMNo6Pvk+1My6WofeAUZQ=
X-Google-Smtp-Source: AGHT+IFXIJu0dU8SuLIgR9WuTGHNLXCIYU7mFjj8UPbmaFpE1pixpUqWN188GdJwaZkTlY5EOKJC+2QZe7ok/Tmu5O0=
X-Received: by 2002:a05:690c:b84:b0:6ef:6d37:1844 with SMTP id
 00721157ae682-6f279adae87mr30185337b3.7.1734104002728; Fri, 13 Dec 2024
 07:33:22 -0800 (PST)
MIME-Version: 1.0
References: <20241206031428.78634-1-richard.henderson@linaro.org>
In-Reply-To: <20241206031428.78634-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Dec 2024 15:33:11 +0000
Message-ID: <CAFEAcA94CLwdYs+FNuBONycfUGwva3urhq+bZ883oJNL2OkR0w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Use float_round_to_odd in
 helper_fcvtx_f64_to_f32
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Fri, 6 Dec 2024 at 03:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Softfloat has native support for round-to-odd.  Use it.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---




Applied to target-arm.next, thanks.

-- PMM

