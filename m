Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43084E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 16:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJbF0-0006ap-2J; Fri, 06 Dec 2024 11:31:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbEe-0006Z6-8l
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:31:27 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tJbEb-000642-K5
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 11:31:20 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3ab136815so1670846a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 08:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733502676; x=1734107476; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oSn/Ho6cPmBzGKUU/VJ5mduJ37o94cj6go9jaApyeNw=;
 b=xZS1t4jtB5zew/v67IjsS1fcbDDBI+bdqrxQtG8GYmKe2hb3hVgqz7HlKjWqp1Zhmx
 77a8IrYrJPYVO+BUvvWszlL7LTUHt5f/Ay97QRJ3vWB3MNg9+SCgj7qAKq5WVLqGK4Ao
 l7MvJ97QhUSH5g6Qhzq94CRVvSvRuJbZnZ1NP15MMybjaM42jQQS7V9AvN9MslwlNXEf
 nZ/I6Y30TJ69NIFvkMiEVW2n8b/1ILWD6Ns0milAg5OuYaZiWAtmlwmF0+n2bdIlXTIA
 X5gbwHB/av80xCLSCgpR29wxTvjEjef8CU89FQDjQTYFcMV269nyXKqGa2+o0q2/wQJS
 sDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733502676; x=1734107476;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oSn/Ho6cPmBzGKUU/VJ5mduJ37o94cj6go9jaApyeNw=;
 b=NshDCZdihuDBJva7Eujqk79ubqtLCqllTf9SViHARqKTG1UuQJgcluUsUIXY+ax038
 OCEPDgfH0VK7LvgkW1Gu9vOcD5emvGsfXko6gk0wg6dpvHpikqH7HGVvMUj9lv8INuZ3
 wkHduZq/Zar+9F7uTwteJXhgJR2CyMuWqVhnuzHX2WqsWIsszcyxEIyEXFiNQqG76peY
 YrwRf+Am0dcwN9s3RZ6pSnCpxhdtCI7IHuncU92uiKmAoyFnaIDBRjzLaKGh/rwNL0FX
 GM2sb+YG8my2ZUpEMwRe1NvJQiSwZad2/2OFsICmxBdNTAL/a48DcPvwLFDk0i2m9eHP
 QJPQ==
X-Gm-Message-State: AOJu0YxnL8yxksb98u+Ltv217J6eQFyQYI55+EQf4LB3SSwyJtsk6v40
 uLsyzZTpoaJPVGbEaAu9P045E6EDiBhae+eFzFrC/gP3iNgt5ODpoHB1/INbB2zfU8z5SkivFUq
 vqhCOVLE+rXHs2vjR9pIvHvR/nbaOtkgN7nM+wA==
X-Gm-Gg: ASbGnctdYWCTXepmj0YFcjgo9bOIIzSHD+YvGR9soHRWa8YQsifLYfNXX1s8v8qS6Vp
 uczrYqBl/rtkE/YtsJa1i3FolOM/XM4GM
X-Google-Smtp-Source: AGHT+IGqxVaQXKNlDToKF3X4I7oV1ebXMP3CWEeRSHvsi3L7fELXDqNhfQySZDMwd27XW2Uh7Ahy1BIe1vsBPcQzvL0=
X-Received: by 2002:a05:6402:4487:b0:5d1:2631:b897 with SMTP id
 4fb4d7f45d1cf-5d3be6d7399mr2694411a12.14.1733502675990; Fri, 06 Dec 2024
 08:31:15 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-65-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-65-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2024 16:31:04 +0000
Message-ID: <CAFEAcA-SUVoBXX3WkG3O_1as4AQ6sr9wR9hyTVqxO05efZY72A@mail.gmail.com>
Subject: Re: [PATCH 64/67] target/arm: Convert FRECPE, FRECPX,
 FRSQRTE to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Sun, 1 Dec 2024 at 15:12, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Remove disas_simd_scalar_two_reg_misc and
> disas_simd_two_reg_misc_fp16 as these were the
> last insns decoded by those functions.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

