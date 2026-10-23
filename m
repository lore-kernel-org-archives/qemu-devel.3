Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFE1606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XL4ene9o
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKE14-0000tk-Kq; Fri, 23 Oct 2026 08:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKE12-0000sT-MH
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:04:56 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xKE0x-0000tg-VA
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:04:55 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-8ab37e44643so5616627b3.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:04:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792757090; cv=none;
 d=google.com; s=arc-20260327;
 b=qqg/prk3p8xnFNABRdzLxuoVf3Jayi5y31zq9Ple45WVkhwEQ0G90dfbGnTAGi+5av
 fxRPwfyyN1AJcsCFCN2t0WpozVGRdv9hbo+0n9AJG4LueW2l72A1MAM/c1uc5hTHMKfD
 LDMI+vKCE9/y19/+/p9yF1Qav2ckxfal6m+XhuX4/9KrP9Oq/EE/scFzwI+cqPJsSC3o
 nz1d9sqvp6Jf1ulbfkan6rW1x5Q8YehzP1EHmClqTRAjVbGVDkgtcCC8TBBnNIcU264S
 uZAM+uSFnv4OKVxanYa6Ouxv0hXPf8ZtY2kC2V/uiFFDH5KwLEkFrhz7DG2L4At73aFa
 ferQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FeHXqLjqAXP2xWWAenvxFwnk0YeIH+GjC1tle1H0ukA=;
 fh=Ooov+i9AeS1BcC1vonK1zlp0+cy8hPMIIb5HY6/nc/g=;
 b=FpLUZ/zvx61qJJNcQIwjDaimxhOed6keRqSy9LOJugKC1nZ+A9QxdpnjxIHBKPlsUI
 qb159pF/la5hcDmeRMU5pXTUqM8hYuVKsWpAHwZdFiMrZ59jaQV1O4YQQNQoqp/s/xYS
 gLjGqLETxeXT7n3a1RRnJpPycdRmsg/yux+ettZNZ1Mor0t+D/3AhM+2+E3FmhYHGFo5
 TNUBwPt9G1wEl/ouUAts0veuZYwUr1DuMhipFnJuCyV7/zEs8FWvdS3A0ZIhogBGELrH
 ILOVaCBSGGVTpNAUWJUgGTx7O6KQ/1m8ToGvGjY7cxWA7ApN01BjeJruVGhPx14NJSBX
 uoBA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792757090; x=1793361890; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FeHXqLjqAXP2xWWAenvxFwnk0YeIH+GjC1tle1H0ukA=;
 b=XL4ene9oBgP5kFb5YvOlxvyIEWD8UsugCIJpHftUCFPw+YPeKX5hOl6e/yKdg4omtz
 moX59TKzXbYUM5hgqtN4A8I6ommKk26Rp61djUvozV6XK7/akxmWvwkoSvwnjUOspGPL
 uAp8uklP9pFw7pUavc3xZeLRxK0be34AqPhelukHS1GNVx5eAvpAAKAtX5rBO1ea0+Kj
 QCEfOpb5e0/iXS5sb37u9RUm546zQtUbJjRUExD3gh72VOPJi2Tdpix7ZWmWp/12gmPk
 yxz6Y1MFpS5SsmhTpHxWVJ/+NXwLgvqcNjVFUJ3T6ODEW0ywtl+hmnwtEC1uEqBdKxlm
 IWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792757090; x=1793361890;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FeHXqLjqAXP2xWWAenvxFwnk0YeIH+GjC1tle1H0ukA=;
 b=tKdTkkNclwK2Vd2k+euaIDWpVOswPL2m/a3kXqbysYi7E2P7O3Hu9fls5a8J0UjOtk
 6pBbAlcq1w6tjaTwIS++510MJR6lQr3Jmq5mk1c4ncBCVSvIihNGO6EI73hqWJap544+
 Bq2wzcqf0Jn7UlQtrPl0XDB9aumqvfVYmxY4fshqiDilZ4g3jLAjqVtL8Y2dynVQiQl3
 p6q/8+litKYj/rl3KNrEwhkpMBG1r05tcTkpMyGyMg/rvXJD2eudtzGYwcJojL+ycmla
 KU6FGTVv5X/t4vKcVkkV9AhQSolnZ+ZlFZ59teN5+KD7y8DbvBQ43liCUmOSQ790sGKI
 MCgw==
X-Gm-Message-State: AFq9FYL6iX2qkqeW51C5Z3Pkozl5M2qGQRlEoKJJypkFqI6Vk2zOVLUX
 OsmuOKRuEXyxCT5gLlmWC+YzVE8F6HuUXXqzZUkIMljl8XO/TWg5Y/ogyrpNBwu5v921QcSzV4m
 j6tekx7bVHbcpmDudQIYSc1EONN1UIXVIrEKKBfftjQ==
X-Gm-Gg: AYBFou2NbLzPC/eOVID0+hcPeodZVJK/kVRALAFhq5hiUDweenaVLYMGE6STKzoRSmx
 5OAIDALpOWYvLAEvtv1mFAKr5SmSpAtjUnYKrr6hJtZrQuWDgHCPYQctL8TuTgNRcnkP0TtDEln
 bej9SgBG0jRbHt+5VkkCgoTwUyBMSH2MJIzbiD6YgW5qftI56FXPcCKmIyQRHswFNgHeSn0X+6K
 kGDa26GSgdZRtsHwIcxIPg0kYAI+ykWet/+I+Lfyn99Nn2UifVEDxixViD7kNHwLbcDuuMv05gi
 zudTdFD128nbBatXVO6ORUGF24jlM/a8J/wTnuC3xtf0lFS4l2aLsd+z8Xsr/wWTdzA6dwXhVvW
 YyI35Iyww+5WpaQEgvFTWukUU/HaKKu4IRpvz3I2d2xf6COQGpEDFzaahgtlhh+C61jUx/LkYJz
 4EArcrC2p7318UFKmtPkHX
X-Received: by 2002:a05:690c:e245:20b0:8ab:447c:b159 with SMTP id
 00721157ae682-8b157dee59dmr9779487b3.94.1792757090011; Fri, 23 Oct 2026
 05:04:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022213647.21665-1-mohamed@unpredictable.fr>
 <20261022213647.21665-2-mohamed@unpredictable.fr>
In-Reply-To: <20261022213647.21665-2-mohamed@unpredictable.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Oct 2026 13:04:37 +0100
X-Gm-Features: AclHuK_-J5UufX2xkE0Kpq0_5P4oMGP8GZ9weaijQvlWgDrHg8joT-d5Yo8GlWI
Message-ID: <CAFEAcA8c58Kn6hDJcBxwqsOXaiJ98cqvi6drCHW3Jcdrsq6Pnw@mail.gmail.com>
Subject: Re: [PATCH 1/6] hvf: gicv3: manually set GICD_ISPENDR on edge
 triggered interrupts
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 22:36, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>
> This addresses stability issues with Windows as a guest.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>  hw/intc/arm_gicv3_hvf.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_hvf.c b/hw/intc/arm_gicv3_hvf.c
> index ae881092ea..4876446189 100644
> --- a/hw/intc/arm_gicv3_hvf.c
> +++ b/hw/intc/arm_gicv3_hvf.c
> @@ -603,7 +603,27 @@ static void hvf_gicv3_set_irq(void *opaque, int irq, int level)
>      if (irq > s->num_irq) {
>          return;
>      }
> +
>      hv_gic_set_spi(GIC_INTERNAL + irq, !!level);
> +
> +    if (level) {
> +        /* Fetching state from the vGIC */
> +        hvf_dist_get_edge_trigger(s, HV_GIC_DISTRIBUTOR_REG_GICD_ICFGR0,
> +            s->edge_trigger);
> +
> +        /*
> +         * 0->1 edges latch the pending bit for edge-triggered interrupts.
> +         *
> +         * Hypervisor.framework does not seem to do this for us as expected.
> +         */
> +        if (gicv3_gicd_edge_trigger_test(s, GIC_INTERNAL + irq)) {
> +            hvf_dist_getbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
> +                s->pending);
> +            gicv3_gicd_pending_set(s, GIC_INTERNAL + irq);
> +            hvf_dist_putbmp(s, HV_GIC_DISTRIBUTOR_REG_GICD_ISPENDR0,
> +                HV_GIC_DISTRIBUTOR_REG_GICD_ICPENDR0, s->pending);
> +        }
> +    }
>  }

This basically would amount to "hvf doesn't implement edge triggered
interrupts". That seems very unlikely, because basically every guest
is going to use edge-triggered interrupts, and the documentation
for hv_gic_set_spi() says that it handles edge triggers.

I would want a lot more evidence of hvf being broken plus a
bug report to Apple about it before taking something like this.

thanks
-- PMM

