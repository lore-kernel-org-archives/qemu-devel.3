Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B764BC87FCA
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 10:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiWCP-00037P-Jh; Sun, 03 Aug 2025 06:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWCM-000353-K7
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:44:15 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uiWCL-0004xV-82
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 06:44:14 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-71b6703ba32so24572007b3.3
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 03:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754217852; x=1754822652; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KMPsDsohFkvyOxM6sIRlEOV9SgK/SERohFl/tyWMwlc=;
 b=H/xZRFejMq6nGNvC8UnU2RihHrVrJLc3sne50mdLYS6SS8G8gZoF8SiRwOQ3BtBnF5
 3A6T8JZH48SjXgnN0D0eIusBJlp/21RioybGI1oNTZiYdRW9XbwLy3fNZT1Ly9QkgdYX
 8FlR56fmhos4v20IDopWqRZrD+RiVx7MSmgdqoTM5l0qBZP1OP0WwMj5Uol+oA64cL53
 iVkROpAqMJGyILqMfUZMnzQvDUPRzSxDjxw7x+QkFbyW7u6do99WJzEyaD3ONKkI9Cz8
 ATzyRpUwyGgaek16Fmj+xBnP8nEcIY74FNHRSWGub328hJa85zOC73k5lK+xvPCXwGjo
 9UYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754217852; x=1754822652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KMPsDsohFkvyOxM6sIRlEOV9SgK/SERohFl/tyWMwlc=;
 b=ujgVzitUS1QA3wqVk3noVwfHwSa3QnZPu2CArNrb8j3lipqIkWdoUyvybnTD5Ds1/w
 Fh+fidCDAPih4UaQU3l2vt0KX9V8Y3zwNH7mTOBR2D0SemHmpHf5Vgrmmaw1CHC1D4n0
 8vRbn3AzrTvFtt8AFH/3C4wW0FMqOVN84xI9yB08dYZEU4+JJad9wn5cKkLo6auLObvv
 a+Gu018vvYAyioFX+wIQIFBGuQSZi1ljF0q/My57TZDPJ7OF+ua5zwRPdGoEVrhU9+b6
 H5ozHSBUDAJt8LZ87IBy2Zr8NhL1YiMqvqR8mjj7wzPb2g8OWfKUBUbb6sRyz8xVpx23
 BWaw==
X-Gm-Message-State: AOJu0YzeIkZPCI74Rlv7FOao4IAO7wdfbc68S9vCwNI4+oFFr+0wD44G
 ia3nJVwWCVH3VKyjZMpMoWZS+T6S0REJMixE4gGg+v4bdvS4LYYxr2/dol66tNj1ajHhw08buiB
 ChkduUoSleiNLEeSsANjp4qOn2zgoN3JSEViNgMRtTyZrkt7juQYd
X-Gm-Gg: ASbGncvCZb6pOtNicSmoeymuudL7Jjv7y3OYLmDqAsCzhxM8uiDt1wdkq/6q0vGHmHW
 wv5St9morH5IKukDbQgGOpo8K128yU9f+DpvL1bQ9JF1tambjnciD1Q97UhehuCahBLLEIlqoKJ
 EqnzAQTku1s/3MGgQ9+edleKl9tQ9S0VdOCiLkHJlHKsA+H4IThFfO48DZ9XaSA0C5wtkiM+oij
 h9t2xOh
X-Google-Smtp-Source: AGHT+IGjoT1oUHN9Nr0ggpAQQSUpnjVUf1RO689LLC1/59DkqL9jugZVkmTuT8kgLP5JTF7lB5VnRyjfx1MeN0ziMcc=
X-Received: by 2002:a05:690c:60c4:b0:71a:17fa:bf06 with SMTP id
 00721157ae682-71b7f3cafafmr69338047b3.12.1754217852168; Sun, 03 Aug 2025
 03:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250802230459.412251-1-richard.henderson@linaro.org>
 <20250802230459.412251-17-richard.henderson@linaro.org>
In-Reply-To: <20250802230459.412251-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 3 Aug 2025 11:44:01 +0100
X-Gm-Features: Ac12FXyuk0N8iXhm6rqFPqx_knkYxp5SlMDDw9XBsn6EglmPiYbpN4hy2Fj4-tw
Message-ID: <CAFEAcA-X+HSr_3bhkUwVirAS+jHp2kRkpjZ5baTrPUs85PqGnA@mail.gmail.com>
Subject: Re: [PATCH v2 16/95] linux-user: Remove ELF_HWCAP2
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
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

On Sun, 3 Aug 2025 at 00:07, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> All definitions of ELF_HWCAP2 are now identical.  Provide a
> not-reached stub as a fallback definition of get_elf_hwcap2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 23 ++++++++++-------------
>  1 file changed, 10 insertions(+), 13 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

