Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4F0C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlCq-0006zh-03; Mon, 22 Jul 2024 01:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sVlCn-0006yy-Ea
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:03:25 -0400
Received: from esa14.hc2706-39.iphmx.com ([216.71.140.199])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1sVlCl-0002tN-Mm
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:03:25 -0400
X-CSE-ConnectionGUID: DGUPCAeqTNidOzHRBK66Rw==
X-CSE-MsgGUID: Mdl9NjrbQZaSz/Z1xyyP8g==
X-IronPort-RemoteIP: 209.85.217.69
X-IronPort-MID: 418825197
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:phLA7q45W9OR5n//+/Yb/wxRtHbGchMFZxGqfqrLsTDasY5as4F+v
 mYWXWHSOK6PYmujfIwlOdvl8kwH7JKDydZjSlY+/3syEysa+MHIO4+lIxarNUt+DCFioGGLT
 Sk6QoOdRCzhZiaE/n9BCpC48D8hk/jOHuehYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArIs
 t7pyyHlEAbNNwVcbCRMuspvlDs15K6u4GxC5ARnDRx2lAS2e0c9Xcp3yZ6ZciOQrrl8RoaSW
 +vFxbelyWLVlz9FIs+liLvybnoRSbfUOwWU4lIOM0R1qkEfzsCa+v9T2Ms0MC+7uR3Q9zxC4
 IwlWaiLdOscFvakdNLx8vVvO3oW0aVuoNcrKJUk2CCZ5xSun3DEmp2CAKyqVGGxFyke7Wxmr
 JQlxD4xgh+rq82L+JmSR/BQoMUvC9vLBqk85C9a0mSMZRomacirr6Ti4NZZ2HIunZkLE6iPI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOmLHsG+Tp5poJui4TX5AV1wL7hKvLfZ5qHSdg9ckOw+
 juWrz6kW0BFXDCZ4R+J9iOKhPXFpBHyY5BVJuSo5+9S0FLGkwT/DzVTDzNXu8KRk0O7RpdTJ
 lIZ/gIoqq498lHtScPyNyBUu1aBtx8YHsRLSqg0tlDLxa3T7AKUQGMDS1atdeAbiSP/fhRyv
 nfhoj8jLWUHXGG9IZ5FyoqpkA==
IronPort-HdrOrdr: A9a23:R70IzaGlRG0JjN6IpLqE0ceALOsnbusQ8zAXPiFKOGVom6mj/P
 xG88506faZslsssTIb6LW90dC7IE80rKQU3WBzB8bAYOCFghrPEGgK1+KLqQEIfReOlNK1vp
 0OT0ERMrHN5PVB/KLHCU2DYrEd/OU=
X-Talos-CUID: 9a23:MdTQeG1MlADDGyqCSDXay7xfNu8YSlb0wW7sBU60LnRJcpe2FwGq5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AvyPecgxGvZijzWsjJfaV80YChemaqIGiDBErk48?=
 =?us-ascii?q?MgvuNDj43CW6NnSWPEoByfw=3D=3D?=
Received: from mail-vs1-f69.google.com ([209.85.217.69])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 Jul 2024 01:03:20 -0400
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-49289ac7150so321859137.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1721624599; x=1722229399; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kB7G9I/QkcOO3vUSAaJIcvGZu6kUvnsI/8WhXL1X/Ck=;
 b=hMUOqIYSdv1eyQ9vk59nUeQYhbqrxEdfM2d5saCrJtQYq5WMMnsDzipTEXrbF8Nh9w
 cA02PoJKlBPKVk/edvVf5uLopeIXLEZOjphQKF5V5eMJnuWHVWzl4nXKFE9USNfovz4J
 CBfAUDKkGJwn2LLrh1fgL6fQto6rh5DuQkQT2pW3kPYiAzEbtvEeiQ06SZZRLwuYve/V
 cbhmz/hvZGpkvbZ7bC73CgqE4nHGRg9I7RMrKeuqFy6KcjoIMO4eksgvH4g0Avo0QNSs
 dsP0WvY6vgoB/qg6p5HyGjuOojHAmAERZl5trQe9QJZu5/RBW0VBzuI23vA1wUUotYG3
 WrxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721624599; x=1722229399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kB7G9I/QkcOO3vUSAaJIcvGZu6kUvnsI/8WhXL1X/Ck=;
 b=kYT8hOTf4k9zEQGS7fFkxkIilD0UvvqotYb85STh+rsfJbj7q8S8uZAFIuJInYpOhB
 jgA+xMKQu71tjZ6M7PER8VL+qDUptaALCWlmHhhZmS304ecxyUauIZKJNt0HEUc35BBU
 JpID+tznNbZJRIcv5edVa4vUhGQUIUrrxwxSOUsqh18sPO7rR6oKjOsVKq4No3WkBdcq
 8kiUPJs+MhWNNVLH/oU2re6mc40hLW8IwcnIUe1YZZdAFkZ7tTxxC4+yTFQJSCzc7IsB
 Up5848n/fM3HzSQg1q0KqvlqSKJISWjhLNJOO+CJRKnp5/pgyEDPhLO/oqAO+gprP0t2
 H53Q==
X-Gm-Message-State: AOJu0YzBIhedKTrTpt+V162rBmiHwuWJUJR9s6bvIszWwXr4jaluT+PD
 BeApixFbkYTy5RplklyHy5ZXAtiy4mi82OmlXzLFWCxtSvpnoVKwge9Hs2ELJI4mif233+o4m2M
 gjueqRtQpeynml1XmDC1/swwKW9caKZiiBekHbm8+I5GgxyCW3V+e4WXMXgCOTuWv9w==
X-Received: by 2002:a05:6102:fa4:b0:48f:dec0:b6c0 with SMTP id
 ada2fe7eead31-49283d8e125mr4348860137.3.1721624599431; 
 Sun, 21 Jul 2024 22:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2gZsi4nmJU8j+lcvt2xqbUQ+z6z/HWqTwRUN7AbiAYiJ+JlcGbHjhQqVytAP/2KAklouzbA==
X-Received: by 2002:a05:6102:fa4:b0:48f:dec0:b6c0 with SMTP id
 ada2fe7eead31-49283d8e125mr4348841137.3.1721624599061; 
 Sun, 21 Jul 2024 22:03:19 -0700 (PDT)
Received: from mozz.bu.edu (pool-173-48-150-109.bstnma.fios.verizon.net.
 [173.48.150.109]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a198ffe9f8sm324686185a.62.2024.07.21.22.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 22:03:18 -0700 (PDT)
Date: Mon, 22 Jul 2024 01:03:13 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Darren Kenny <darren.kenny@oracle.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/13] qtest/fuzz: make range overlap check more readable
Message-ID: <20240722050313.4tgjucwknp5jmh3o@mozz.bu.edu>
References: <20240722040742.11513-1-yaoxt.fnst@fujitsu.com>
 <20240722040742.11513-8-yaoxt.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722040742.11513-8-yaoxt.fnst@fujitsu.com>
X-CES-GSUITE_AUTH: bf3aNvsZpxl8
Received-SPF: pass client-ip=216.71.140.199; envelope-from=alxndr@bu.edu;
 helo=esa14.hc2706-39.iphmx.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 240722 0007, Yao Xingtao wrote:
> use ranges_overlap() instead of open-coding the overlap check to improve
> the readability of the code.
> 
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

Thank you

> ---
>  tests/qtest/fuzz/generic_fuzz.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
> index ec842e03c5e6..d107a496da63 100644
> --- a/tests/qtest/fuzz/generic_fuzz.c
> +++ b/tests/qtest/fuzz/generic_fuzz.c
> @@ -11,6 +11,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/range.h"
>  
>  #include <wordexp.h>
>  
> @@ -211,7 +212,7 @@ void fuzz_dma_read_cb(size_t addr, size_t len, MemoryRegion *mr)
>           i < dma_regions->len && (avoid_double_fetches || qtest_log_enabled);
>           ++i) {
>          region = g_array_index(dma_regions, address_range, i);
> -        if (addr < region.addr + region.size && addr + len > region.addr) {
> +        if (ranges_overlap(addr, len, region.addr, region.size)) {
>              double_fetch = true;
>              if (addr < region.addr
>                  && avoid_double_fetches) {
> -- 
> 2.41.0
> 

