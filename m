Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7BCBC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 11:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc1TN-0006pp-IJ; Thu, 08 Aug 2024 07:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1TM-0006om-My
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:38:24 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sc1TK-0006MC-O6
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 07:38:24 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7a91cdcc78so27757166b.3
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 04:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723117101; x=1723721901; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YfXmlz+nOAUfmRvp1CaDOvvOZB8WORoi1slNH71/UQ8=;
 b=zKfrvAh3lJCsm7t7xIWWhNWAWiAcSYg9AdzqGUQ62Ha0gPo9SDksAoFY3RWHiEcK0v
 uGHjVybYRJxWrwMWDG4Xu4MMBCBafPNHRmShyRnird6yXEHdWhK5RzEg/bJo0InQ+fX1
 ZD9gKCuBObS4AJ23A1IKUZfu5Cba0evdxpH5NWj5iQIgZnJb7XNhhRk1sy2e65l82yVf
 rLlyRaxCH+eLLTGPf44wA40sqYRuEnGChPE6lGprOXWpB2gkqG8jU25tUV2qT0X+f9pu
 JbcjzLlFwGBuMYn/3NQIep95IN+WkzGoZ48qbVwyBoa2PeqgLD2yEqNSPu7gHsmu7NZ7
 ecCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723117101; x=1723721901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YfXmlz+nOAUfmRvp1CaDOvvOZB8WORoi1slNH71/UQ8=;
 b=IVNy4kwhd2gV6jcaq0300yEq72xQhVtIqP/K/6OWvqhx0TEl+oLhFSKBeMnH1Kxbtn
 UL8kIFJq+i+gDzuak3oi6AQ33kB+c9Ph/+dIzRExWG8OM/dsalhixCUAfbGf4UJyLtnP
 LYiYwfdF73KRSdm7e6QpaEi7JE2QnLLFy0QPsgwQbD+q+590zgEunToiQx75KwmGlmQS
 ZsuM4XpLN/pg+rZQ5srjHUKYVjlDXl4rz1oBbeexsFgK3lZMwUKTz+Gwq99aoNnB7OsJ
 Na0M2zOSLGQin16RdCGd5JaNDqsOXjP/hKYeSjE5uLgWVZtgiW7meI3RJONK2CjQw7xw
 hzpw==
X-Gm-Message-State: AOJu0YzjrJXFtIOtrQ+y+KrAGdkWevWjBeen8QaQbGijoJQEQZyM6Yyb
 +PBZ0F5UsLzTKHiWiDhtczwa8JiZ2eQ2E1tbPAM0U2K0EJNUTlqME3poGZsx0sViuqFcDe+brMq
 j+NeUDNQcQYVonhzUnkH3V//Yo4SQmxtq9ONuSh7GCPQO/Mop
X-Google-Smtp-Source: AGHT+IFYihPIk7GESU4L7wBeYZiU5quXzcs48VkLumojGfiNUpdo4aNYz6WaTmmnpJ3J7XC3Et+ewLKJNksKgSIdi80=
X-Received: by 2002:a05:6402:1d48:b0:5a2:c1b1:4d3 with SMTP id
 4fb4d7f45d1cf-5bbb2458b23mr1507790a12.28.1723117100473; Thu, 08 Aug 2024
 04:38:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240802003028.795476-1-richard.henderson@linaro.org>
In-Reply-To: <20240802003028.795476-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Aug 2024 12:38:09 +0100
Message-ID: <CAFEAcA9h9uD+J0OZ6Vfo63EhSm3WnPwXm6p8fYTC5OC+cS+GPQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/arm: Fix BTI versus CF_PCREL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Fri, 2 Aug 2024 at 01:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> With pcrel, we cannot check the guarded page bit at translation
> time, as different mappings of the same physical page may or may
> not have the GP bit set.
>
> Instead, add a couple of helpers to check the page at runtime,
> after all other filters that might obviate the need for the check.
>
> The set_btype_for_br call must be moved after the gen_a64_set_pc
> call to ensure the current pc can still be computed.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> v2: Enable unwind from guarded_page_br.
>     Since guarded_page_check is called exclusively with btype !=3D 0,
>     it must immediately follow an indirect branch or eret, so cpu
>     state is up-to-date, so unwind is not required.
>



Applied to target-arm.next, thanks.

-- PMM

