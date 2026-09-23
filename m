Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EA0C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9JrN-0004eO-6C; Wed, 23 Sep 2026 06:05:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9JrE-0004dw-ON
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:05:45 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1x9JrC-0003uE-WC
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:05:44 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f70553dso109109966b.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790157940; x=1790762740; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5gFV4nkRElYlleG5KSTvanzCdZ/I4Hu3sxnQemdOiuQ=;
 b=yHR48RYj1qamTYh8n0UxcNaoTxagz7b+Cf44lvHx54qh5nphY6/PQ0f/e6tZWXCoO/
 WBSDqhtwpt1FgYs4Vit9JrKxp7at0ND1Z1TDsoGcRwQJmAMS3CMgC4ul5x1q0fWkz2p8
 gKN71khbttisQ6jPzYHWJugAiidq1dGc2iV/gdz8BefROMsUr+40iby/RD8YZpLVGRag
 m5thm3wJmPT0nDdC/kxpj+91b8ul/EjdMZgTP4ivyUMMMmKn9zqspstZo1vH08aYwth1
 kNHeYNzqle1fWt0QEYq+XRq4r5AH+JdoA8U8bxeyrEuDQwDw2zDneQnNgf+Tyh9UjB/X
 YW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790157940; x=1790762740;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5gFV4nkRElYlleG5KSTvanzCdZ/I4Hu3sxnQemdOiuQ=;
 b=OODFyOH5KiRrAUSkqtqTeAFWFhSGBOT2nVWRMIuFH73iiFxflutl97kHZwfA5ZO/aM
 z1UM1hFIbBuSuhJPSsALdl061DWeIlsdFl8CuQ3CkE9cM5qA0al9CNW7lNgVURxE0o9e
 J1PTvYGZ7tsgpVGQCyiCjqfiIG6PQrFTr4gAUQztat42qACm6o7LZyTVGj4vmtVz5dNX
 /14meuKgBeDYXo4Mp4gO7B8E+qlBJXVEFxmLEZRkQOSaGtLnxlaG98QqbfwYKTX9+yFK
 WjN8cqBZQwgrXiG+raxm+D19mlbVZc7yf0tc0cZptAsScBkAweNYng3AgbesnYmCgQ4Y
 23Bg==
X-Gm-Message-State: AFuF++kfFcZXPqeuCIe1SroHor/q+hsvJEkGEZ6OxMDTUI4fZ5wXBpI4
 ijz0PJOZJmvt/805zR0PYGHUfjz0A6Jxm5CstQenpJSabvKASgn29B+dZBG7r16nC8FcKODJsXM
 pILWQNDw=
X-Gm-Gg: AYBFou0nIt5FpVqX0ueFqgd2cBhzo0u+byRulk4WbF36WqEr1bglu4cC5LOPt92YexV
 FPBRTJomMbGKxitDfwQvwM+/fdjFaICgTkJdrp8ftWIRUCgOW7i1DSJPk1wTL0HzpQUoraEen/Q
 Fij04rjb5VyVdTdoGT5tB+RdtxIwzn2iaBcRRqYb+D+R0bTiAk3rqJateM/BDHM9UF0eQU96cpN
 UrlFjHjlS6/GZTgmbwrI24ac9rfb4o4ea/XhH5Nx8oGYN/tsHCsxodjtDwtnr1BbrOuiywusecG
 SJtavcKZQRG5m75NkShzIvyPIpKt7Oxb+qdGoGnQbnokTvdwHWGPqXWmyf2dG4BMWBkhZz6ONtW
 1AjFyEIYqawEhw9QI91ZDfUhgtol+WcT3/p3eX7EXj19wp8VpvExScpNG4KECZFy6+YyTdWHVFN
 7AnbvUEj9Oh9hSzYgfExRw9FQvGUagKR81vuDbA3b71MucbdESYUGaYG+Q8iYis224Rj6hSQFqL
 oBb7X7aBDs=
X-Received: by 2002:a17:906:6a27:b0:c29:d31f:7d73 with SMTP id
 a640c23a62f3a-c2aadc98c81mr182646066b.9.1790157940455; 
 Wed, 23 Sep 2026 03:05:40 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:805c:5b2c:d225:9d51])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2aae6a4a00sm85498966b.46.2026.09.23.03.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:05:38 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:05:36 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, richard.henderson@linaro.org
Subject: Re: [PATCH 1/2] tcg/optimize: Fix expansion/simplification of deposit
Message-ID: <arOkcCpbLwvHp8JT@linaro.org>
References: <20260916122322.3224918-1-richard.henderson@linaro.org>
 <20260916122322.3224918-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916122322.3224918-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ej2-x10.google.com
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

On Wed, Sep 16, 2026 at 02:23:21AM -1000, Richard Henderson wrote:
> When we computed z_mask/o_mask for the deposit, we may accidentially
> prove that the result is a constant.
> 
> If we let the rest of the code expand as-is, when can we get to the
> end we'll see the constant, note that it's the same as the current
> value, remove what we think is "the opcode" that computes this same
> value.  But in this case we've been expanding deposit to multiple
> opcodes and the removal of only the last opcode breaks the expansion.
> 
> Fix this by noting the constant result early, before expanding,
> allowing the entire operation to be removed.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 5f747705a4 ("tcg/optimize: Lower unsupported deposit during optimize")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4449
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/optimize.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


