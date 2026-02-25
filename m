Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7234AFD3760
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:50:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGBm-0002M4-0c; Wed, 25 Feb 2026 09:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGB6-0001Rt-Ch
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:47:55 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGB3-0007DM-CL
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:47:51 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso53182395e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 06:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772030867; x=1772635667; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gfCBWb1jCWrpmu924srQv7dY9rwTR923VxeS0aFXZGM=;
 b=RcNheF1+5aacW8WIcdo3dmtfmZtkTwulFElri7msjQjkRaF691Q+THYJgK4lNG2a/5
 AUlXc2Z9vhz2xhPGxHof6sl1Xc9nosDyh5WEp087n0C4gf4Vz9axBeESIkAV02kzezTA
 hknhxHbc/y30YDw6nEx81hIHKtnHT0l+6qKuQBwYuekb8EnJ8iv7kLepeEpb222sS5ff
 f/3vYRyF6lgkweCBmnmci/PVAgnX/RVJesZB99aa+nZItmb6EEgStkL4sSkvXpmkUjr3
 UhfPV3UUYWQ/uCFwBswmbsDaIkssRIskxrYUu2tjvCU3tbDJZaAKUnSV296mafWcaI85
 Gjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772030867; x=1772635667;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gfCBWb1jCWrpmu924srQv7dY9rwTR923VxeS0aFXZGM=;
 b=L03tsZhuACqgXhQS4uCeGt7z3Us30T4akS7+Xxd7m/swElw83LJSYwyzbkk6agXy4Y
 EKeCkSBBkW9YzgUnvYb0RLB9zkIUPINlQj1sSLDltSuKcFhxhQZdyieQ+1VZR9LsM7c9
 240ko+V8i2Rq5BAjYKAXzL2x8rFMMabVoSu6vHoqJpODKAA5aQJPPooCIuNSV34wIHwA
 /wSjw9NH7KioRUJbKGMaw7ivzMf082eXZTPi0R1Cndq8ROEFL8N6nu0QsDIxT0HvS4Ns
 9ZfgxfFLkA+nAuH5NAsV8G6opVwikzfT2XjvO4Z58fHTyuUu/+q7wULHYe+CDjYE+9JU
 +Bew==
X-Gm-Message-State: AOJu0YyMCVVxx4/nR829dG69ICsuAeO/VcTqeWsRn5KBibiHlsyUgzq4
 5v1rnFvH22wMmq3bI6CJ7uORm2JXw/C53R8tHnWZzHtMFSI+00L4hqhSqs6SBRDKIuarI4NzYrw
 y//mB
X-Gm-Gg: ATEYQzxaSjHDu8/OxWo8mI84eBA1+x1f/iLXmn3g5ihEEWNVtDYKk131nfaSo0GcoVc
 jDX9ECWz39hXIjSIRBtyrsA6U73spzISs+KehRAA0wLkt8E+MLOC3xXgn5z2x43xi6Y4nRBWTvp
 WShN7N6SFutWQ/yScx7Yu7k0REPa4EJm38lRPIg01hwft7iMS1OeYXoublGnjWfhPNkpcw5D+AB
 n/lYHvgp0r7dQIMzVxCPT6Siv1HdyGtjC7ude3MtQSaxCs8X2lWW71pZZkGFrRNn8o3ClU/1eqo
 lC2b0v/x6zg+ZnSZ11hdsnquJ1+/McD63XIJkWPQzsicBwNR4sfE0hZs/Agn/lyDATTveQNzp99
 bfMtRwkAyaYyJZa2S+nCI0i8oASg7VmCx/l3pLujv+DBYHBY8amNnpU6OzJc7Ky6dSassXjse7/
 dwUWgWGEE+lSmalVqlLACAhQab
X-Received: by 2002:a05:600c:6990:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-483a95aa328mr277981465e9.5.1772030867281; 
 Wed, 25 Feb 2026 06:47:47 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:506c:58b9:ee75:9229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd6f3124sm75267015e9.1.2026.02.25.06.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:47:46 -0800 (PST)
Date: Wed, 25 Feb 2026 14:47:45 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 2/6] tcg/optimize: Lower unsupported extract2 during
 optimize
Message-ID: <aZ8LkQk0TAQ1YATH@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204052456.970605-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x335.google.com
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

On Wed, Feb 04, 2026 at 03:24:52PM +1000, Richard Henderson wrote:
> The expansions that we chose in tcg-op.c may be less than optimial.
> Delay lowering until optimize, so that we have propagated constants
> and have computed known zero/one masks.
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


