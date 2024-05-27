Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E72BC25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 07:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBUPO-0000LU-Cl; Mon, 27 May 2024 03:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1sBUPM-0000Ka-9m; Mon, 27 May 2024 03:04:36 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1sBUP9-0002ON-Gy; Mon, 27 May 2024 03:04:36 -0400
Received: from localhost (sekoia-laptop.home.lmichel.fr [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 27BD7C60180;
 Mon, 27 May 2024 09:04:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1716793458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sUN+hBq6elNx/aMrQCnyEWtQdzIQfoahXjvsGkN14Zc=;
 b=ISVkyPt9F7IbIUn/ZA9Ea3Opzx6jG2ceNSZ9uHG1VCbNVhez+jNMv4J+Q78sZ8+Hlm7jQ0
 9G+PLgfgC1bSYmJ0TDxb4wV4tAC2VpRChXvpmNLmuBQl1Bd6NJ4R4SUDo4sCLvSU5UM2zk
 1my4BkykGv3ISA7gEEAbUX/q4yEV0oYuBhjsXTaD0tjur4VD75yggiRmCu4dEnhDX+IIBK
 CWnn2JJkVL8/0NrWMvY2iZbM0PTBbR2IUBgvQ88tjUPaChFHKQ/hQK+nogAtuN1DvqVuGu
 ss+pICKgV3pPuLpPJelfTSAscjdmFlQDsxG/5azsxss+yl6Z7BKYPTe6CBGAGQ==
Date: Mon, 27 May 2024 09:04:17 +0200
From: Luc Michel <luc@lmichel.fr>
To: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Damien Hedde <damien.hedde@dahe.fr>, Paolo Bonzini <pbonzini@redhat.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v3 3/4] hw/clock: Expose 'qtest-clock-period' QOM
 property for QTests
Message-ID: <ZlQwcWKiuuYhjU22@michell-laptop.localdomain>
References: <20240523194441.21036-1-ines.varhol@telecom-paris.fr>
 <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240523194441.21036-4-ines.varhol@telecom-paris.fr>
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21:41 Thu 23 May     , Inès Varhol wrote:
> Expose the clock period via the QOM 'qtest-clock-period' property so it
> can be used in QTests. This property is only accessible in QTests (not
> via HMP).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>  docs/devel/clocks.rst |  3 +++
>  hw/core/clock.c       | 16 ++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/docs/devel/clocks.rst b/docs/devel/clocks.rst
> index 177ee1c90d..19e67601ec 100644
> --- a/docs/devel/clocks.rst
> +++ b/docs/devel/clocks.rst
> @@ -358,6 +358,9 @@ humans (for instance in debugging), use ``clock_display_freq()``,
>  which returns a prettified string-representation, e.g. "33.3 MHz".
>  The caller must free the string with g_free() after use.
>  
> +It's also possible to retrieve the clock period from a QTest by
> +accessing QOM property ``qtest-clock-period`` using a QMP command.
> +
>  Calculating expiry deadlines
>  ----------------------------
>  
> diff --git a/hw/core/clock.c b/hw/core/clock.c
> index e212865307..216b54b8df 100644
> --- a/hw/core/clock.c
> +++ b/hw/core/clock.c
> @@ -13,6 +13,8 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/cutils.h"
> +#include "qapi/visitor.h"
> +#include "sysemu/qtest.h"
>  #include "hw/clock.h"
>  #include "trace.h"
>  
> @@ -158,6 +160,15 @@ bool clock_set_mul_div(Clock *clk, uint32_t multiplier, uint32_t divider)
>      return true;
>  }
>  
> +static void clock_period_prop_get(Object *obj, Visitor *v, const char *name,
> +                                void *opaque, Error **errp)
> +{
> +    Clock *clk = CLOCK(obj);
> +    uint64_t freq_hz = clock_get(clk);
> +    visit_type_uint64(v, name, &freq_hz, errp);
s/freq_hz/period

Otherwise:

Reviewed-by: Luc Michel <luc@lmichel.fr>

> +}
> +
> +
>  static void clock_initfn(Object *obj)
>  {
>      Clock *clk = CLOCK(obj);
> @@ -166,6 +177,11 @@ static void clock_initfn(Object *obj)
>      clk->divider = 1;
>  
>      QLIST_INIT(&clk->children);
> +
> +    if (qtest_enabled()) {
> +        object_property_add(obj, "qtest-clock-period", "uint64",
> +                            clock_period_prop_get, NULL, NULL, NULL);
> +    }
>  }
>  
>  static void clock_finalizefn(Object *obj)
> -- 
> 2.43.2
> 

-- 

