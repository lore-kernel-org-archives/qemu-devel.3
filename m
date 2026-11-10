Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B15606A203
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 16:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=F5yfKB+T
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQooG-0003ns-VI; Tue, 10 Nov 2026 11:35:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQooF-0003na-2n
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:34:59 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xQooD-0005ti-GW
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 11:34:58 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4afe2d546f9so29786635e9.3
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794328495; x=1794933295; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=O4VqeB37CpQ42k1egu7OtnYs9i15ePxXbF8O9zUkyis=;
 b=F5yfKB+TsKYofrYgPJVsVYZIoedcOFNW8BZ9Y51CAwizlsD1iuz6J8WtiYAmvY/DTZ
 TEGPwKAatM/dSnP9mTQUXchvqtQYy2LboOQCSU+le6J/0mYah5cV0DprSxFGrCGIuL7D
 Hl0HHC8AO52qSW1nOwyCZyadiBLqUU20dRZRR03ZGr6hWYilb51/xF+5RPX0TvYYaL7u
 o6U3TgAIuHgRtnIXmYaK7inBkFJMAMx/RjQsDKIupV6SvHvvolF/xDphLu4DmP92Oln9
 C8NODOdaULWXEJuuSRY/WKeHvRByEDulL56/x8Pro103X5jV3nqVnaBt6XYyT5tHycZC
 JjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794328495; x=1794933295;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=O4VqeB37CpQ42k1egu7OtnYs9i15ePxXbF8O9zUkyis=;
 b=Ea0jsqNpVszMMlzw1vCPODCkyDdeQbtSJgTnet3JHYbJyGPY9gcBr5OcwG3FuXWPiL
 79POkgtvGfoFIlaRfPyS2VAgwlBY+b6xYcXTFFW5QjwhOyjoAAozKpMpqXfDL1Vx7Wkj
 j3X7gXVxVmUz9w/NjRDuudiAfHpXURGLA5ntAAqlsC7zf4+MILehSa9hwUh/3t6aiDn/
 W8pBf8tfKSRe34OzQItSKeW8WmUQwmmOlDyzLrL4fWqktjR1MW/5BF3PcBO2p5tEHYzf
 QQBfhvuap3hyAC81Vv1UfZhRjf9MhIqT7C0+6R2RJFbgf+32c30gbo0EB/4MnWhmOK+o
 BczQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEycjL68vW6TI+SqZe0K0Kq4eSUnaHN38O5ARt+P8EOYB+pMOpvCF+y5/9Lwz1ekPtioaP4otlZyB8P@nongnu.org
X-Gm-Message-State: APuU4Z/lNq8JGYLQZkDPrjgYG9Y0mc7gfXRHQBNE59nOVGq7GYWH61yQ
 zambsCTDWHPFFsgkfvLfiwZICaM1/PVWQLsQgpcum+8Z4fiignZuG6DWTSy+YTx8OOY=
X-Gm-Gg: AYBFou0YNkNHlEeGlrhOCphY3XQ+aHvvdtmhB8IEOnY2QuoF0el01nt9KpyEc5SfhXS
 xcuFMUKDqDTQhYCcZskuD+v0GlMxaiUKj1vhyTk0xoq2g7vG4675ivaDBWHlCZlWuWLWAHJU78X
 3YBeEUOwjR5TcRRnS6qO4vM5ovn5+k3aqMC5dNosEqsvjtrle06YZk7vrswZB/njFMAVpe8eotj
 nbsXJxZ6VAqYcAKelxYsjLn2cOedA7j+RYuS5j/TjcXBZkYmjunD6GCoSBMLY2pPqdqFeAZa0kk
 pN1FKTUyiTzCaSF/KlU2N1aEsDhYMeQucMkld4Mj0tV8hQdwGdI5V9Vh2WzR4vR755Q+mxvMg83
 x8A1Pw5Jq5xvIiqXlqKOXi8bm5ULv/QEJuhc2nB1HLuwJM39i9Z6jNBzYhLPSmHoLoqBiGbuHaU
 T9fmJO0Or+pUR5g92hqA7XKUr9Jkc2QObjC3wvbeB6WxaxIPKMqgkOQ/blppypaKrUNXmxkHrzK
 nOqzh6gktT+Qhfj0WURKFmwJS9hPincrrKPu/VQQUouaUOfpP06SV10qpRyrec9OQ0v0axDLSr0
 T7BVyd9rNZ3o4Ic3ttqsOzR79Tx1qx4C
X-Received: by 2002:a05:600c:46d2:b0:4a3:5aee:2c25 with SMTP id
 5b1f17b1804b1-4ba02355f3emr49365415e9.31.1794328494968; 
 Tue, 10 Nov 2026 08:34:54 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:aa96:7f3b:af27:16e8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a4238sm6141492f8f.54.2026.11.10.08.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 08:34:53 -0800 (PST)
Date: Tue, 10 Nov 2026 16:34:51 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH for-11.2 2/4] hw/intc/arm_gicv5: Free memory in finalize
Message-ID: <avNHq9ukmSPmqPXW@linaro.org>
References: <20261103172616.2400758-1-peter.maydell@linaro.org>
 <20261103172616.2400758-3-peter.maydell@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103172616.2400758-3-peter.maydell@linaro.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 05:26:14PM +0000, Peter Maydell wrote:
> The GICv5 allocates memory and creates hashtables during realize and
> as part of its operation.  Free those resources in finalize.
> 
> Since the GICv5 is created at QEMU startup and remains in existence
> for the lifetime of the process, this isn't an in-practice leak,
> only a theoretical one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c        | 11 +++++++++++
>  hw/intc/arm_gicv5_common.c |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index d0a8574916b..fd6456cd8aa 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -1970,6 +1970,17 @@ static void gicv5_init(Object *obj)
>  
>  static void gicv5_finalize(Object *obj)
>  {
> +    GICv5 *s = ARM_GICV5(obj);
> +
> +    for (int i = 0; i < NUM_GICV5_DOMAINS; i++) {
> +        GHashTable *ht = s->phys_lpi_config[i].lpi_cache;
> +
> +        if (ht) {
> +            g_hash_table_destroy(ht);
> +        }
> +
> +        g_free(s->hppi[i]);
> +    }
>  }
>  
>  static void gicv5_class_init(ObjectClass *oc, const void *data)
> diff --git a/hw/intc/arm_gicv5_common.c b/hw/intc/arm_gicv5_common.c
> index 2920b11cc39..cfadfee4f05 100644
> --- a/hw/intc/arm_gicv5_common.c
> +++ b/hw/intc/arm_gicv5_common.c
> @@ -112,6 +112,9 @@ static void gicv5_common_init(Object *obj)
>  
>  static void gicv5_common_finalize(Object *obj)
>  {
> +    GICv5Common *cs = ARM_GICV5_COMMON(obj);
> +
> +    g_free(cs->spi);
>  }
>  

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


