Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 742F8D3B9B9
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 16:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFyN3-0003eS-F9; Tue, 26 Nov 2024 11:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyN1-0003dv-AO
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:24:59 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tFyMz-0003BK-4f
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 11:24:59 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ffa974b2b0so45084481fa.3
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 08:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732638295; x=1733243095; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=imbbFsKgSJMQcpFXUzcc/I0vHluB/HWsjAPOFw/l8Co=;
 b=q9R1BWGTDbYmDhej/Ld3X62w8JMjXwW17yv/ySKrUNV3W1dh7pBhKhPQWdnqi1m8Nu
 Eb7NicE2FLynK0cYKTjV8DyTonOAgFITxwwLIVd1XwPQPKOzWzM0FzYjbwbrmxNQMzAj
 4HD7BAw3HqWwyH2zZ8JQnSlzCe933SSa88CO3w6RZLo85y+389Qanw7kvHB2OnAXlQGh
 Zw2lFFuQe4D6cijuZ56vI/zCWSF+VRFFVGfD5yZ4FpGZCXrUCCRRLKjJkcs74YjR7yXE
 IaWQrvI1fUI/2GxXXhjuQ0sSWblELp+STUwRkjEbmZDhFN/RURQbRY5NKvo8dXBZxEip
 fM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732638295; x=1733243095;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=imbbFsKgSJMQcpFXUzcc/I0vHluB/HWsjAPOFw/l8Co=;
 b=rxspNDHOTRDvm+tataNlM6vCEksz6w+eITXoVXQ0sa1kX5Rd++IitM4Zb6E78vRHII
 UoRpZJmfrJBwo9UmnrU2ckQqFKXmDNSIT3NJWHHx97bq/5jAdlOCtJaHCletVLNvReaH
 vFPTZaaot5tgVsxfI3gvpxIds+6XIe0e2Sx6HZ5gxSdaoyQ08QYuexf01U7LH1CQGIng
 6EEUd7huio5pEaKfQU+wbSe2w4DYQ84OayTqhQFpCLN643+QdRFdjTjLUEbUvUma3tgt
 W7C8bUVitO2FwUJO+o9PbJtj6A7rj5BS+9U4jz6AgqBg6M+ETWpaS9NOX+flgGrLBPYD
 nQIA==
X-Gm-Message-State: AOJu0Yy2j7WJjnACtkKGV/8m+Cqyp4ydycH/xNggP9C7hhJc0StSePBz
 3TZU45gf8PZW/an9m/0KKpe4Vhh9M0XezqcUEj3HYi88V6hjwwzibO2TAuj6BRGiCSCDjOl/00Q
 cJ27ilrZlj5zU/zucF/yTINJ82dwGii4uHgKdSw==
X-Gm-Gg: ASbGncu4DfiaJ8gRzrvw6zGGtRjPtriRkKJmRS3TONE1s0dcn89GZpMh9LaNzzIAhoL
 3j+7XW+ElD2FJHloOhS5nei+SMjwW9N0Y
X-Google-Smtp-Source: AGHT+IFMkD4c9eO2mrzo5TaUfhGhCH365Fd4tPVOe85/nNh0QIjZYsNL+3Zgy6cCMJRj31N2qwX1d8Gpwlu5Hrx3h5U=
X-Received: by 2002:a2e:a556:0:b0:2fb:5da7:47a7 with SMTP id
 38308e7fff4ca-2ffa7197a78mr95962551fa.25.1732638295119; Tue, 26 Nov 2024
 08:24:55 -0800 (PST)
MIME-Version: 1.0
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
In-Reply-To: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Nov 2024 16:24:44 +0000
Message-ID: <CAFEAcA907AJ_x73wG83HYk1xyMksx7ij2TpLpOaVKgrOffA6og@mail.gmail.com>
Subject: Re: [PATCH 00/12] Minor fixes for Arm documentation
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22e.google.com
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

On Fri, 22 Nov 2024 at 22:52, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> Reviewed following things:
> - system/arm/cpu-features (options)
> - system/arm/virt (options)
> - boards documented and listed with -machine help (arm and aarch64)
> - grep object_class_property_set_description hw/arm: ensure all options are
>   documented
> - reviewed boards description
> - reviewed all Arm features (FEAT_) from: https://developer.arm.com/documentation/109697/2024_09/Feature-descriptions/
>
> The Arm section of the documentation is in very good shape, and this series only
> has minors fixes.
>
> Pierrick Bouvier (12):
>   docs/system/arm/emulation: mention armv9
>   docs/system/arm/emulation: fix typo in feature name
>   docs/system/arm/emulation: add FEAT_SSBS2
>   target/arm/tcg/: fix typo in FEAT name
>   docs/system/arm/: add FEAT_MTE_ASYNC
>   docs/system/arm/: add FEAT_DoubleLock
>   docs/system/arm/fby35: update link to product page
>   docs/system/arm/orangepi: update links
>   docs/system/arm/fby35: document execute-in-place property
>   docs/system/arm/xlnx-versal-virt: document ospi-flash property
>   docs/system/arm/virt: document missing properties
>   docs/system/arm/aspeed: add missing model supermicrox11spi-bmc

I have taken the reviewed ones of these (1-7 and 12)
so I can put them in for rc2.

thanks
-- PMM

