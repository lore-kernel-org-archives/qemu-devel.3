Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB71CA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:18:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xF6kU-0000AY-LR; Fri, 09 Oct 2026 05:18:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xF6kS-00009g-Ey
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:18:40 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xF6kQ-0001v1-Uh
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 05:18:40 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so70312185e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2026 02:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791537517; x=1792142317; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IUik2nJ1sLoZODUFHtsZRmPOdkekH+V32LDN7J+VHQ=;
 b=odVbzv6JwXXPGLubcS/TPor3eU9B5F2KXcWMu3q+D1jVbah+DvkRAAZaMttW6fOhvv
 oGtEoHdIn2YqL33m/KwTl+SFVDiU7BGpsjXTVlrCPY6JBlsVSlqDIOwitbYcyjRJpIdM
 UKaG/d9TbZbfzs5HxjB+qseOtFTDGbqqzMLFje0cC59SVQddxw+D5U4Pv88KU+343AiO
 +7haMvec3DorTtjhSk9W1TB4FsyQaQ/I2/KROVHsVYBkpcQgql2hFEsTJIJGVwgovx3M
 mSkMzlTP0B+3XbIPM/cDfXDgajCR7fMd/gjkWkfW+xpVG6OonE9dDe1ashwxzE+2g316
 ll5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791537517; x=1792142317;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IUik2nJ1sLoZODUFHtsZRmPOdkekH+V32LDN7J+VHQ=;
 b=0OOgeIFA4RzGPt6FGaMRC2zfuSce9qfZxUYtzXb7TJ+6xDAq7uj+KgAv1va/ea9nRn
 idAIBAE5GZrQX9AxJBYi977Fn+1v0vloJISxy5SkG8gEquFhr7OjDAadCjHVLSmvRh56
 Zedcs3+XC4xV2KnKP7ZbcYz+U0ZMJMc0fvShPp/Yr8L14eYh/HxLhxTzIWZXeJmDlZU5
 zlEZYHvg1UFbFpMIPJEFjECo5xPBujG8pOfvfVln0U4xnzQpu8/KN/Qre9CVt9tn9uFh
 tA2L0qTH1CY9XRF7nYxTlKmbcukCPN8/PgJmVnibJ8K0xh53ET7UKeqcACYjlOVDx7f8
 1hxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaoNp44vxWUMtcHNTIGS1c/gjEUvMYHm/KtLBQWLS7FHHMbClrJMX4vfG7z905w0htY+0VpEYKjPwZ@nongnu.org
X-Gm-Message-State: AFuF++lX3golPIYrh4ik/VVZP6KWzfas+Yq1Vr0MevzibHBvNzzqNfNm
 Ay8C80/yWfTlxa3NIg/qwDq3trguhPTyuQ0N4KYzoF3Eaj/LFOCHDIgxyCUKKs0Id0M=
X-Gm-Gg: AYBFou1lxDOG16yH8/NZvw/AO70NBtZIn9PfRjDc82Mte+2Z8R2rRd42HGu9dMYVcuW
 NYPlMxoQjiaEe8NphikuubD9m03eKZhuyAXQLmqGtFUC7AX/4gt0qZKmK9+Fg2KfkkJAWB8CR2N
 JUo8yyqtpHlK1q3EWhpX8+EBgRayOpzstU2OzzcbJJyNiJLRGuAjLPJ8XxuiewmkvGdxTPIM076
 eZbE+fStStBFv0inM4Z+sCT1wh5YzcZeiI4p0RK+38bXD3ltL00ZyIAiFSPTWCW7fp2Lu4nGaXF
 cfzQng87u4Hc5ZGHLsXSoPjA4lEXykry6B65P5PVgXjHRd9lWo3d5N38LE6OfRPZrF4ow8e958C
 kELa6NbvhRLCUg3DeBTclU6d7wJNAIWPHw0vwcZMN1SSwruqg2bcyB+TmspNOaFyUSFddwJTRQ6
 sRaCyGqAnuB25J6DGd6MH7HdeYGYyniHLiVoLVbfdTTEeyYr/6VGGs9ik8dbQ96n/X3F4hlE744
 4ZrV2VJkyY=
X-Received: by 2002:a05:600c:a01:b0:49f:ce72:e931 with SMTP id
 5b1f17b1804b1-4a18e4fe3e1mr22535255e9.35.1791537516785; 
 Fri, 09 Oct 2026 02:18:36 -0700 (PDT)
Received: from linaro.org ([2a10:d582:31e:0:fde2:547b:5069:256e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf135fasm39591195e9.5.2026.10.09.02.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 02:18:36 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:18:34 +0100
From: Jim MacArthur <jim.macarthur@linaro.org>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: Re: [PATCH] hw/intc/arm_gicv5: Make IRS_IDR0 reads return actual
 value, not 0
Message-ID: <asixaoIo55u7LDXt@linaro.org>
References: <20261008092327.4036856-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008092327.4036856-1-peter.maydell@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wm1-x32d.google.com
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

On Thu, Oct 08, 2026 at 10:23:27AM +0100, Peter Maydell wrote:
> IN the code for handling reads of IRS_IDR0, we carefully construct
> the correct value starting with cs->irs_idr0 and adjusting it.
> However, we never actually write the final value into *data, so
> the guest will always see zero.
> 
> We didn't notice this before, because Linux happens to not care
> about this register value except to check for the presence of
> virtualization.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 405ad2e76f13254 ("hw/intc/arm_gicv5: Implement IRS ID regs")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 08878193dfc..ebfb0878af3 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -1433,6 +1433,7 @@ static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
>              /* ...which means VIRT_ONE_N is also RES0 */
>              v &= ~R_IRS_IDR0_VIRT_ONE_N_MASK;
>          }
> +        *data = v;
>          return true;
>  
>      case A_IRS_IDR1:

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


