Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3351CD43370
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 15:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t94bb-0002Nz-Ca; Thu, 07 Nov 2024 10:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t94bY-0002ND-Js
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:39:28 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t94bW-0003H0-Mt
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 10:39:28 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9693dc739so1583807a12.3
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 07:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730993964; x=1731598764; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S1ojgGMe04oTpXQ5H/CMjh7ambNOZIyTDE3vys0YK64=;
 b=Dp3Hj57DwxlnX4Le91thKlsYNGvbgsDOohc9BS9Jw8vLMRbCbWgkoXqc0cUeHhH/q+
 P+7JwTgXZXivq/tBr3meeB77NKdM442GmfpG3rD+3Ui8MjxE/79Rk8M5bqYhJX5uwIGq
 DV3ZSH3U2TN9Y3UVrf9Kyo0JQ3t9RYpfxdQ37Vlf7YxzFT6dkhnI1y8+VLxtiPk5pNk9
 IR0m20tNs7Rn867tjMraGvh6cgDOvrPJ4NuVnW496prtag2HGks7yhye3Agy3R+lGwgY
 WDaUgsNTtp43SLBYMbveT4Tz87AVNOcBYCUNUJOrNQDVAxm0Phyzff6N0JYP6wcdYOJF
 A4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730993964; x=1731598764;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S1ojgGMe04oTpXQ5H/CMjh7ambNOZIyTDE3vys0YK64=;
 b=ZLefYOQXyqC1NQphXpvEMGN1SNXgcL+58N61Hpj5MDcoZuQRE9SirJBIoLI+23i/1b
 DyHgzcLLPWKX/jURm9MaxMYdL+SIjbHCjU7RpNWpHfE8qWwb6Ff608G+FLvzBP0TjObv
 Kom6WTHYiaQJLcfx5Rs8COF63OR5YS7ltXVZvY7pL3/4RnfgykJAhFpRJyvXGllpEQkv
 iDEYUUkCyzxMtrXkKPJJYYfRkGzteFZJMHc/BxeGrJ+EulU1qI69UgTneHTKdjGnoSz2
 YqUntsdjsbUEVTQy158gmwFaVMrZvOmIAooce00VSsc5XDkruC+14n4SNZoONeBeV9Tf
 QwlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhbEOpRAefXzo6Yi70LdkSsN9mIuBIVY2bAodmJqcW6Dw4aWjlgqZe7vLuo9BIwA8Ax5TjKVRGchIH@nongnu.org
X-Gm-Message-State: AOJu0Yxyco89pW5/YHVsqx0npJ+GNETqYAYMQ1oWyqpcFh6HG2i0N2QQ
 S3waIaL4KL4Kx8GlsZj/XvipfbNuCBPAM/TXm5iunv0T+zPmkmj7di5XS/59UsWqB9om6CLH320
 GL0KJEMEav6nTwYYVG9/yDJZ9lMuKkLK3roxziw==
X-Google-Smtp-Source: AGHT+IGXOrtkRVrCYc75d33lyAV/3LiQk52p2PPpTahHjZKRW22P6Mji6/gzk/OmarJ3qb3dvfOp40D+9g82vg9Bxz4=
X-Received: by 2002:a05:6402:42c9:b0:5ce:fa29:5938 with SMTP id
 4fb4d7f45d1cf-5cefa295c74mr3861608a12.8.1730993964398; Thu, 07 Nov 2024
 07:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
In-Reply-To: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 15:39:13 +0000
Message-ID: <CAFEAcA8LB3t0n_BqjBeEejfmVVYMbQ1rT9qwEbsNEoUDbkym9A@mail.gmail.com>
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond end
 of target attributes
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, 
 Esifiel <esifiel@gmail.com>, Fan Ni <fan.ni@samsung.com>, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, 1 Nov 2024 at 13:43, Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
>
> In cmd_features_set_feature() the an offset + data size schemed
> is used to allow for large features.  Ensure this does not write
> beyond the end fo the buffers used to accumulate the full feature
> attribute set.
>
> Reported-by: Esifiel <esifiel@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a40d81219c..078782e8b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1292,6 +1292,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>
>          ps_set_feature = (void *)payload_in;
>          ps_write_attrs = &ps_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->patrol_scrub_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }

Coverity complains about this code (CID 1564900, 1564901).
Essentially it does not like that this check permits
the memcpy for the case where hdr->offset is 2 and
bytes_to_copy is 0, because memcpy(invalid_dest, src, 0)
is still UB even though you might logically expect it
to do nothing.

>          memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
>                 ps_write_attrs,
>                 bytes_to_copy);

> @@ -1314,6 +1319,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
>
>          ecs_set_feature = (void *)payload_in;
>          ecs_write_attrs = ecs_set_feature->feat_data;
> +
> +        if ((uint32_t)hdr->offset + bytes_to_copy >
> +            sizeof(ct3d->ecs_wr_attrs)) {
> +            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +        }
>          memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
>                 ecs_write_attrs,
>                 bytes_to_copy);

Similarly here.

thanks
-- PMM

