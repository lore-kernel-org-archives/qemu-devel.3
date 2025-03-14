Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61C4FC282EC
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 17:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt8i1-0000dD-AQ; Fri, 14 Mar 2025 13:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1tt8hs-0000bX-4y
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:20:24 -0400
Received: from layka.disroot.org ([178.21.23.139])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziyao@disroot.org>) id 1tt8hp-0006gn-LQ
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 13:20:23 -0400
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id DB6B625B10;
 Fri, 14 Mar 2025 18:20:18 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gOxpLexbdJLV; Fri, 14 Mar 2025 18:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1741972807; bh=DaYB282l8x27jK7ew6fSh8TRqoEKMY+1sNzdY0pNHNQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=VCtV8WXbHwic3R8dqkIUncc2AixFylyEF5Y3DA24BFY/nn4CuXjKQ1fCBjMwwJVzq
 qy4jSodVvRYGi5Bdg4ZN8XdqZOHwf1OTIU/ykazSAqKjTTScgFvi6UvkxxzxejoIRO
 8rR9qCcw4UHrVKbJf8LTsfFWBHueIC391mT81HF1OZiO4xYACU7wow3V4MJqvO1CCv
 78KJ3IFzqyII/rXH+vutzqyce1wKTlzNqRBB0UzqAKD2kuco+rdDTqAANUYX+zELMF
 sepRCMtmKUbsth0KhDigrnzquG3DKZDNWO0+d88/Y1d+O3AoKbsPcKr9bioJqaKlHm
 CFrc/bwsd0aHg==
Date: Fri, 14 Mar 2025 17:19:57 +0000
From: Yao Zi <ziyao@disroot.org>
To: Bibo Mao <maobibo@loongson.cn>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] util/loongarch64: Add clang compiler support
Message-ID: <Z9RlPak0A9rjci0X@pie.lan>
References: <20250307011339.2246600-1-maobibo@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307011339.2246600-1-maobibo@loongson.cn>
Received-SPF: pass client-ip=178.21.23.139; envelope-from=ziyao@disroot.org;
 helo=layka.disroot.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 07, 2025 at 09:13:39AM +0800, Bibo Mao wrote:
> Float register name f0 - f31 is not recognized with clang compiler
> with LoongArch64 target, its name should be $f0 - $f31. It is ok
> for both gcc and clang compiler.

Sorry I didn't search the list carefully and sent a similar patch[1].

Apart from preventing the disk tools to be built, this issue affects
several headers used by linux-user emulators as well. IMHO this should
be fixed, too, or my patch could be taken.

Sorry for the inconvenience,
Yao Zi

[1]: https://lore.kernel.org/all/20250314033150.53268-3-ziyao@disroot.org/

> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  host/include/loongarch64/host/bufferiszero.c.inc | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/host/include/loongarch64/host/bufferiszero.c.inc b/host/include/loongarch64/host/bufferiszero.c.inc
> index 69891eac80..bb2598fdc3 100644
> --- a/host/include/loongarch64/host/bufferiszero.c.inc
> +++ b/host/include/loongarch64/host/bufferiszero.c.inc
> @@ -61,7 +61,8 @@ static bool buffer_is_zero_lsx(const void *buf, size_t len)
>      "2:"
>          : "=&r"(ret), "+r"(p)
>          : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>  
>      return ret;
>  }
> @@ -119,7 +120,8 @@ static bool buffer_is_zero_lasx(const void *buf, size_t len)
>      "3:"
>          : "=&r"(ret), "+r"(p)
>          : "r"(buf), "r"(e), "r"(l)
> -        : "f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7", "f8", "fcc0");
> +        : "$f0", "$f1", "$f2", "$f3", "$f4", "$f5", "$f6", "$f7", "$f8",
> +          "$fcc0");
>  
>      return ret;
>  }
> 
> base-commit: 661c2e1ab29cd9c4d268ae3f44712e8d421c0e56
> -- 
> 2.39.3

