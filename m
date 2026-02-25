Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBAFD3760
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 14:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvGHo-0008Nr-Qp; Wed, 25 Feb 2026 09:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGHn-0008Nj-MX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:54:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1vvGHm-0007yx-7L
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 09:54:47 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48378136adcso40867505e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 06:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772031284; x=1772636084; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WIu8QSfyAvQdXRObMQ/Jym47MOfpfzUb2szrJWq1Oyg=;
 b=HFp3W8qhUFQlHDBp35cCUQuvtFCgERv+SV3jB7Y6rkQwutLME6/NW/4sGkEJqvZ235
 PE/w809SqCIzsjDxJy8myq0lNNXSsmCY6bdrR3qyosr5swN5Pc9XYkF4oDe32QROQZrb
 4CZE8C1XhZNpo+KkKyXZ+jNkteAtMrkdKSnz/x8w0csAaoveZw4diMMWJPC2Rbgbs1gp
 eV3Y3VtHd9ajmLB1If49VHvXLJQAxLghUW8g7T3zJj1h7WNe4K9LfhZKo8+fnquQPuXI
 57EpWW74FnhvAxreYSl6dRVxqUjBY8BpVwQWLYUmzDaU5N+FJY98qhT9KMo4lFhCHPvB
 rJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772031284; x=1772636084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WIu8QSfyAvQdXRObMQ/Jym47MOfpfzUb2szrJWq1Oyg=;
 b=Mg7KjcIRAeBw9B685suw5zZxXfL8tVpDz7MErZhFnQvIr/l8vU0DKi662y4ncuAaHE
 s+/eY89q4rPYa3NBlI9xxKBMRsPQhv4vFopVjNnxgaJqb2aweR8n9EgDJuAAXWqjgUSx
 AcMgAurRWG8YMY5gwv5r50Nf4FinlY+YR0IKhQ37UJEgaFdYu8WAhU/WJ1VkLJJ7s9LI
 GS+Rndm0t1nKWvMy7qsufm3fmmbSYX7sAhHa2tAgx6lQBuYhWZssnK03Inza2wD8Q50B
 A9QTUsC03Ckxa3ADXfFkBNPsurCBwlTBRetAR4bTZ0aGbt7jiwrFSvwIULGeH0VyahEp
 xDBg==
X-Gm-Message-State: AOJu0YxdnAZqEXbME2absFymvjEcV5HaiXJF6eJVIh0keKm+Gn/iiDyb
 H65nO5EjROlYRR2eAqgAia+vwWCHZF1bsGioowqfZ6C6BbNTdIRvu0e3+cSiEWDE+c47rIFobJw
 /ifEo
X-Gm-Gg: ATEYQzxDjSciIz+Mb8fFzDE4BgB+lwM04pXhFAspdNk0Fr7Vdrbsy+PD01Xq25Na5IS
 A17DGU822dADPsuZAdGON9mu8WJV2YggImxrad3zbNXpIOFV8zUUTAMUKFT5V+QnVnwnOT3RREB
 ZOC0V+7VklMKMPzqqwO9ri3dPKJaXUZ/gwq5IbqB4dkcz3YxSk8j21tt5eQf8oxwYTUHCgO98XN
 aJqVFTa1mkUviT/pQBQL9UntEm82p3X/ZMDfp/iZlRqsBk9z4E0lir4rm/I3394JUw0y0tAMBZW
 pxylcKJS77Ou5OYXMk2RCMLT5eHQKKux19AtiRXKhmf72SOe+huAGkyMbx8ZV+Gmu62Xib4tyAm
 81C3VovLkW/R3dG2VIGjnh/aFKorfMAxFAEpG4VrH07XvuFWlgX/yZ9g41q1tL3cZogQXTZyoQk
 9X2Q9qr7IQ74n1NpR4wasLE0lecA==
X-Received: by 2002:a05:600c:a44:b0:47d:586e:2fea with SMTP id
 5b1f17b1804b1-483c217e8a9mr14790205e9.15.1772031284178; 
 Wed, 25 Feb 2026 06:54:44 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:506c:58b9:ee75:9229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd726a35sm66125025e9.9.2026.02.25.06.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 06:54:43 -0800 (PST)
Date: Wed, 25 Feb 2026 14:54:42 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 3/6] tcg: Expand missing rotri with extract2
Message-ID: <aZ8NMuH32VjXMzgN@linaro.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-4-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204052456.970605-4-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x334.google.com
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

On Wed, Feb 04, 2026 at 03:24:53PM +1000, Richard Henderson wrote:
> Use extract2 to implement rotri.  To make this easier,
> redefine rotli in terms of rotri, rather than the reverse.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op.c | 52 ++++++++++++++++++++++++----------------------------
>  1 file changed, 24 insertions(+), 28 deletions(-)
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


