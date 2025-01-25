Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F129DC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 15:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbi0W-0000Nw-LN; Sat, 25 Jan 2025 10:23:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0U-0000HX-OZ
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:34 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbi0T-0003ey-4I
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 10:23:34 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2ef72924e53so5406287a91.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 07:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737818611; x=1738423411; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UFHE9i1/h566n7SS6864RMOqWpicQdcg+KGgj0sw9ZA=;
 b=znJPDBEEPlHOm9Z1AS/x/J/vXmgfBQuLBI4MoYzyC+dZbZS/uVazaFhnmPCbEu/77e
 qmYD8jzXFKQIwIDYsEGL+UnR5HrKef7qIiwrX3N53q95TISQ2SWSqjQX22wh7WF6rJar
 bM5arabGdh2E6E9HpaC/91JdklD5F911FGD58r0Zw3xqrdvk3X8oDKVlBPHJiEYLi3gu
 9eIxpj1OUHxdXeRDvJn7v3rqwjQk2xx4rVaolmIY5ugwklMTiLOcOrEC32ZKzahAjWM2
 gPb6i7Wuc4HY7jLij7jiNLd/ldoIiFXwwJ/jVcW6izkb7Pke8DYNRraAwVavlZPeELTa
 53qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737818611; x=1738423411;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UFHE9i1/h566n7SS6864RMOqWpicQdcg+KGgj0sw9ZA=;
 b=TR50bsmg/QHtYWx9Tk1ucnCbKgEzZeO0G43Ds7z1NnZysdxYWuIMJyb1GNn4GZVtUC
 7cR+2xt7wiZEYb/IFmlQh2DBiUoQnm/tP09U4S6G4Za+XBXXomVYTlB/6/Z+ZToya5zW
 h7pWSLZ19LeMKJcSencKd8H+grZHacaqrmKrTWJgxpanp+I71oaxMPgdzkIQ9g3DIwkD
 QyV+CS85Iv/VOKw+twLF9c0AJ1Y2P9Z4PbEFZ2hvLFOkLkFlG1avyQbbd9J75BPI5J1T
 l2fbmO/a8fNkzl9KJtkpVPWN/rE0wGhSMzYgla8NHdDDuyAA8K+j/U/7xDQyuJVyUEuQ
 6lCw==
X-Gm-Message-State: AOJu0Yyi6qRYd/DhkaDUKsKKI1OLuZNc5gvlLYUHIPXMJy7Cy82e30rK
 wnjcst/INzG68THhWvOXzDPsF2W748wUe1Q3Mx4KeqlMCAytwL3Cm9DI00MXH/D5lNP/7pgCP4s
 p
X-Gm-Gg: ASbGncue3BByNW/FAflPuB4skFxWJVyrHDh/DuGHzMH86e1TYLdPJCyjBbUKFsXJ2KV
 CV7AEWBKD25ursU54yopJO1qRgh/GAOr4r6mnUkgKbx6/EzfAKk43by3Q8rwPJEqIjarjxQ5gfF
 EUXhN596u3gXzeSD4F9hBJDQGnGTAXLjV1bX4v6gG1i1E1XI98qu/86+m2jZjR+GsftRPwzVX1m
 LGpslRkX27v003G9LNBEl2t9TTMci+BD5i63Apo+KdA9maljr5XvPioFjQ1x+EoGpa2u/G3Z8zy
 7y16V0bBYX7KifST2dh5dw==
X-Google-Smtp-Source: AGHT+IF4qgvISqNdDKKRrdgRu5+gjWd+uFYrF+D5eU9krZmgO1DPPXDXHsAH1gpWYDXIm9lvwIl9bQ==
X-Received: by 2002:a17:90b:1f92:b0:2ee:8427:4b02 with SMTP id
 98e67ed59e1d1-2f782d4ee70mr51571358a91.28.1737818611570; 
 Sat, 25 Jan 2025 07:23:31 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffa6abeasm3647344a91.29.2025.01.25.07.23.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 07:23:31 -0800 (PST)
Message-ID: <0bf50763-e2fc-41dc-a1a0-a0f4b5e4a8fd@linaro.org>
Date: Sat, 25 Jan 2025 07:23:29 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/76] target/arm: Use FPST_FPCR_F16_A64 in A64 decoder
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-18-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-18-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:27, Peter Maydell wrote:
> In the A32 decoder, use FPST_FPCR_F16_A32 rather than FPST_FPCR_F16.
> By doing an automated conversion of the whole file we avoid possibly
> using more than one fpst value in a set_rmode/op/restore_rmode
> sequence.
> 
> Patch created with
>    perl -p -i -e 's/FPST_FPCR_F16(?!_)/FPST_FPCR_F16_A64/g' target/arm/tcg/translate-{a64,sve,sme}.c
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 32 ++++++++---------
>   target/arm/tcg/translate-sve.c | 66 +++++++++++++++++-----------------
>   2 files changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

