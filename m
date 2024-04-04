Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7372CD1284
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 14:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsNsO-0005Ko-T1; Thu, 04 Apr 2024 10:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNsL-0005Es-84
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:15:33 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsNsH-0008Ej-UQ
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 10:15:32 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56dc9955091so1155383a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 07:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712240126; x=1712844926; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P90flCIXqUHtKs0vW1E9bDJJZ4uMb2sFup+Z/DHN1cc=;
 b=nKOGCR5ZyjT+R3jQAdGhGm4lrCuX8Cf1zpCripENtv1uL5ONeo2vAJ+G0yhYNsDVCe
 3itiA1GaI7ESbGgWgnufFQSwWAonPjlVBx/Re7CwXvMwvxt+8rVlqxuHIFTtqZoDLl4r
 s9t9QYZxsvPYMpbEmHnz4wKWLjrETDGpdVQylEKVsq8IoMvbNCTsaWKeQluqJqinqrwn
 5V9AXGauAo7Hmhf1ERvJvmCjKa3kKpxYdROED35dFabXwl/uDSaYaTuB2Thmzuc2uB1X
 77zH7f5peNABJiwip89JnY5fjeskFBiKl1YAH4+IjAmfIUwNxNj22kN6nt4xhasJGQBU
 qYEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712240126; x=1712844926;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P90flCIXqUHtKs0vW1E9bDJJZ4uMb2sFup+Z/DHN1cc=;
 b=hev/Rr+vZLKfUG1c5MwweyRRP4B+E8CBx28B4ph7ZGz+5isuZKmVSfiWfgN4LiVFTV
 ClZbtg+vn1+h2fusgzEs89xrG2AoyiJaXHtPeiI9V/a7Bs6svvnyAfuveI4Dwfd3eHHk
 viY6NTAJi4J7AncRuHIHAVhrCLZK6CrcLKu6Is+wVVfXMosUDXiKJRrOd5vuTM+xQCv1
 qpctqM8P3NVlbkMxhlnzKsgLM6eYN+rxhBz5p49xhUIjyOrnUXYOOO+LdpMZMYB8xr6c
 rUvzYf9vDIw31gc9uR21FWK8X5ui/uQiqcT/4AD1MQ3gBhiuP3s301QDb6Hgkr1zJK+3
 9xHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEsxw7y+FReKzDYqusSaTAuIamSr+ZZly3xUn1Q3HAsb6q+CMhYZ4oZPogP7ApV2IXIo7BQc8YkeCx+6UkAz6435r7qNQ=
X-Gm-Message-State: AOJu0Yz2A9XVK6jvhydtZcl249EdWPnhIvWL+iW/i5pegFlzRIScfy11
 c68pzN9s3PMy6UX81troBQS2JDbOjwW4upD8ndEGM2z7m40VgpRTDkaYRK5q7YhAIhT6VnEUyd9
 rouRzSXOKFYxO6LizHrq6YRTtPryPhrwbCA7fSg==
X-Google-Smtp-Source: AGHT+IHop9T9h0KiPOeACcy9DIcR3OeB6aIu6gGNOr7S4Km++nMq37y6Cxq17nEJbCG7Om3G7rcgMN7aemOO1oTOmP4=
X-Received: by 2002:a50:9b5a:0:b0:56e:603:9fc9 with SMTP id
 a26-20020a509b5a000000b0056e06039fc9mr1957815edj.3.1712240125191; Thu, 04 Apr
 2024 07:15:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-4-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-4-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Apr 2024 15:15:14 +0100
Message-ID: <CAFEAcA9-TJJuDvf1TZO4QcPPgH6Ct6sCbYBUHkhb=c9wxK2fpA@mail.gmail.com>
Subject: Re: [PATCH v12 03/23] target/arm: Add support for FEAT_NMI,
 Non-maskable Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add support for FEAT_NMI. NMI (FEAT_NMI) is an mandatory feature in
> ARMv8.8-A and ARM v9.3-A.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v3:
> - Add Reviewed-by.
> - Adjust to before the MSR patches.
> ---
>  target/arm/internals.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index dd3da211a3..516e0584bf 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1229,6 +1229,9 @@ static inline uint32_t aarch64_pstate_valid_mask(const ARMISARegisters *id)
>      if (isar_feature_aa64_mte(id)) {
>          valid |= PSTATE_TCO;
>      }
> +    if (isar_feature_aa64_nmi(id)) {
> +        valid |= PSTATE_ALLINT;
> +    }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

