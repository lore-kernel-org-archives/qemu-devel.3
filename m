Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA59FFD3758
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvF29-0004Ji-04; Wed, 25 Feb 2026 08:34:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvF24-0004JM-Ba
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:34:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvF1z-0002NB-KU
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:34:27 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4836d4c26d3so57311655e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 05:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772026461; x=1772631261; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UKtXpGVBoArYHFm/XEWrm0gd1e0Zm4NPvRXpAuPlgzk=;
 b=PfK5APKVT0hvDa5CaVuZU/oztXcp8JMtE3vSdKXXytVSGXWk7lM1EhHyhb7nj2PjRi
 Dud0WfazByL4Ymw1KGjlnRawjF0mMOaTlzTT6kYAf4K3T+QIqfphjymxRGgSdVyhs6JW
 lk/Hy/OBE65SIc3OcteFPBnWTiAiKhD7FRwk4TB8pVdic2nJk4yeykWQszZ6drBH8ylf
 E4WXOPhDdylLkzrNHEGbNvTeK8s3/EL7sP1knIcZByXOlvRnyefwpWcK8iLLu3taQVX2
 vyaW4LSIK3S1QrrlonwtCVxCYFI8I7PWVNoRwPi81fEVW3IjqwMix87awNU2lIIf9v5M
 gDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772026461; x=1772631261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UKtXpGVBoArYHFm/XEWrm0gd1e0Zm4NPvRXpAuPlgzk=;
 b=tUL7SYOskH2AEnEDidPPk92qNr9z8t5zzSxEnYNh5XM28STyUOgAMGgrRH5PgjnldA
 dbGKAX8TmQbD9//sDVOYq8XHevMa7M/G+XDqRH/GgZC6ks0s9w1hPfikSWJVwg96axrq
 CZf19xAvE8i/LBGHFNlQMLsDfX8ABwxzdaBQQ9blXt6OEWzDgZN+Hm15BwAti7Uz+FG5
 lHuB4lvRnKxnv6iTDFv7vofDq/FkFaG+emcDuJzRPoYbbrkxhW94MbKZtXO8k4aoIHXR
 FD1Nfpm+hm6xQMT1Y2AG1Yb5Fih87imJDIlk9xw85H2g3jmAbMZmp4Girn+nY//0xeNX
 hJuQ==
X-Gm-Message-State: AOJu0YxbOLaGyOwHNqXhiGFmIRGEexVb3g4GdrCAUhV1karfFyZJZ60G
 W22hcZsHYzguS/Mmz8DmXw/mo6C0N1Li0RBstAkiBCkY+To/6/AlyVjWYza1D4u5fWKHw9qARy2
 kD3Su
X-Gm-Gg: ATEYQzwvug/q1HnAkYpbRM6Pzn1+l09jjUbvU28SSGYo21moZpIcau8R2nmyXTLc/jb
 BZBTWPCGRHDRkZZJQHGjE6oo8vUHmOpOgIcCGAdrnAf1KD7t8wp7d9lZBPK7YOPFeLJ02111X5m
 jV6XT3rANlwpppg+RFp1ncPAqHMhsoGWGyTiPhmh88kg4dY7tdHryHNUdqvaDYfn0aIcCsjj5dk
 YwEJzvv+VG/j7soAdQ8ni9mizL0jFsF8+WJx0xRp/Bw9M8Jdttl/8Nk4F5LkCtF51SIoFnj9lCp
 cQmpaLWTT/H9CLkJn3Ta0gsJpSjGDkGl3sgNBK5UShFIUhSMN71BpOs6NTkSK2uGlnp6U3F149s
 SSCb43+sngnrvy5eYqOhUCQC+KLCaJyBeXPl+m31QjpUe6DwauFE5qTnZ7wSQLpNziyl2wjvkXi
 sqkvXMO4gPLTRYjjnFpvAIV5J9
X-Received: by 2002:a05:600c:818c:b0:47e:e414:b915 with SMTP id
 5b1f17b1804b1-483a95a8578mr264682105e9.2.1772026461514; 
 Wed, 25 Feb 2026 05:34:21 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:506c:58b9:ee75:9229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd70b3f3sm77196845e9.6.2026.02.25.05.34.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 05:34:21 -0800 (PST)
Date: Wed, 25 Feb 2026 13:34:19 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: Re: [PATCH v2 1/6] tcg/optimize: Lower unsupported deposit during
 optimize
Message-ID: <aZ76W5covvg5ejp2@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204052456.970605-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 03:24:51PM +1000, Richard Henderson wrote:
> The expansions that we chose in tcg-op.c may be less than optimial.
> Delay lowering until optimize, so that we have propagated constants
> and have computed known zero/one masks.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> +        /* Lower invalid deposit into zero as AND + SHL or SHL + AND. */
> +        if (!valid) {
> +            if (TCG_TARGET_extract_valid(ctx->type, 0, ofs + len) &&
> +                !TCG_TARGET_extract_valid(ctx->type, 0, len)) {
> +                op2 = opt_insert_before(ctx, op, INDEX_op_shl, 3);
> +                op2->args[0] = ret;
> +                op2->args[1] = arg2;
> +                op2->args[2] = arg_new_constant(ctx, ofs);
> +
> +                op->opc = INDEX_op_extract;
> +                op->args[1] = ret;
> +                op->args[2] = 0;
> +                op->args[3] = ofs + len;
> +                goto done;
> +            }

I also had questions about extract vs shift/and here. You've explained this on patch 6, but a comment here about it might help future developers.

Nonetheless,

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>

