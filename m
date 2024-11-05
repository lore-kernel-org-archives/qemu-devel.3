Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E55D3E773
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 21:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8R9w-00035C-4I; Tue, 05 Nov 2024 16:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8R9t-00034d-JD
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:32:18 -0500
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t8R9r-0001Ct-Qu
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 16:32:17 -0500
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e28fe07e97dso6130837276.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 13:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730842333; x=1731447133; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7RkXnVjpcVt4e93NoUNF6wrUWDEE5LM7Uldi1UcOV6w=;
 b=I0W1NCTu0c09FSJH3hHsrtOPBBUq51e3ETL6vWmqyfRxtcQaK5dNamlqH4rIjJ4BzW
 4sZAnoTjN8OzuzunoDRqOFdyRd2tkgMTn1XK9uKUAfEUrwhcbg+KBE89X4Mog97q4xej
 HMwsUzFe6DKnBiUVDlIi6i3JOp5AX1zTxmjNFw4Y7py5roFNt7FylKX2fLy17BtAt9Gf
 ony7qI9ZGIboltvCZlNUCrwEtRvUFHjt3g7zm3n3ew6btizN4LdX6SmQcHkG7qNV9Wmo
 FZ6AwHjs+H9f6YtOcbGURhiLeEa8vpKMgao/vbTvR+egjJgct8eePHwy6PrFiUKziEvj
 sgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730842333; x=1731447133;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RkXnVjpcVt4e93NoUNF6wrUWDEE5LM7Uldi1UcOV6w=;
 b=mHCnCjrsoXzjajyJJsRBW07pup/Er9j8KCbxK/ESN34ojDCIi70NzlkS6EvM2PrmS4
 Me4lPQ16KR52PtqknMVdyjZokKgdb3tXrmFB9rEhwSliMEgYwp7aQNOsc+DPyuzBVHIY
 OmnHHuMdNADgiqVzOZjUEeOhqo3Cw5HxdBrTtxvK3DCwdNjveS452SYOIASzTiSpGahy
 IZHCbMQ1jaL7E2JXBVucB4gfk1lwkSLYL9aS9jWSnGO2nB8MjDiMXFQ1HwW3l/yyrxZA
 ajybAQyl5T7w+UVjTh6GeRCUpnreV2uDd5yBJa/FE6ssYAjAU+HoZ6aZHEgpeY/qFbdt
 FoFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNJwISsS0zVmaWg5f9uZwPP5+lF6/2lkEr79a1ijCmmY2U+goAZg0GvE6OapbeaqB2rg1lO4oMw83K@nongnu.org
X-Gm-Message-State: AOJu0YwO5O65W+dymI4U7N2xuUKQvRewH9yRgyY68sWkOsC/CHzNry91
 xDvdPctbO5+cxE9PeR6FLXwUX1zgQWuPfr0wxDxk89iSpqmj2Lj/
X-Google-Smtp-Source: AGHT+IHl8uFBg6XDhX0Vw70PzWun3HBMcGGd/ffvhldqgpRaKtZSeibF2h0+0UUWu5Cjpj/hTRmB/g==
X-Received: by 2002:a05:6902:2b85:b0:e29:288f:33fd with SMTP id
 3f1490d57ef6-e33025ad4c0mr14994900276.26.1730842333268; 
 Tue, 05 Nov 2024 13:32:13 -0800 (PST)
Received: from fan ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e30e8a851a5sm2721445276.22.2024.11.05.13.32.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 13:32:12 -0800 (PST)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 5 Nov 2024 13:32:10 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org,
 Esifiel <esifiel@gmail.com>, linuxarm@huawei.com
Subject: Re: [PATCH qemu 08/10] hw/cxl: Check that writes do not go beyond
 end of target attributes
Message-ID: <ZyqO2nzQM3zXZMMW@fan>
References: <20241101133917.27634-1-Jonathan.Cameron@huawei.com>
 <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101133917.27634-9-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri, Nov 01, 2024 at 01:39:15PM +0000, Jonathan Cameron wrote:
> In cmd_features_set_feature() the an offset + data size schemed
Not 100% sure if I get it right, but s/the an/the/.
> is used to allow for large features.  Ensure this does not write
> beyond the end fo the buffers used to accumulate the full feature
s/fo/of/
> attribute set.
Other than that,


Reviewed-by: Fan Ni <fan.ni@samsung.com>

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
> -- 
> 2.43.0
> 

-- 
Fan Ni

