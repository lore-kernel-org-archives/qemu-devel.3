Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38DAEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmwf-0004Oo-FJ; Wed, 24 Jan 2024 18:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSmwd-0004OV-1u
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:46:11 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSmwb-0003Xp-Bn
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:46:10 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6dc6f47302bso2806452b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706139967; x=1706744767; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=he2KEP2HM2IJJa5SoOBxLONvQh8hQtu1DQYEA4eCTE0=;
 b=dbuXjndZ/OtwG7kjPOvtDKoFS7xXBBOfIZqPaNDkNsJxeKU7C2eZcKV4PNnUl/BKyz
 39wfM46pwi7GkIgeyWE4Lv+m6tk8IrtK9t5CT1qrUGY7kcXVp3kROXiq779v7YD9kL6N
 UNFaovsv2nv/7MsxdHByKsVP/J7Rcc+6+xAG/oYIUV61lg8xc6SzZEt//unCs1hAeMBZ
 uqgkMVao2kAy+YQmRMCOzxp2wgUM3MNknl/uWBb/kBPTAh/H1V6sLduRVq4xUUPvYB4p
 hvh5eW16m5HIozmjXDhWA/CyBI8H7XXbKZ9mTv6f8jiogRNRHg/PASybJrUZG7Geg7IW
 13uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706139967; x=1706744767;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=he2KEP2HM2IJJa5SoOBxLONvQh8hQtu1DQYEA4eCTE0=;
 b=H0IjmxCmxXhsU1jmVvmv7JwQLhQgikoxgKxRqlGjBCyx0VzGCpWf3MJd7ZuXfuD8RU
 z2iy5f/3m9BKus0athIsArxuNx8k5eTgC461H8aPHd+GPWkVNcOSRN+TLn20EokaKfeB
 k7XyselXo0HiLDvl2PoJ6kn5ti5k3MwWnFCN3AG20SkdUwsNOG2IlO4696IqUNcYO/Ks
 msskZAXTZNsNicM0ZevNcC91QchXWCG69p9eTDfWtOrxVGgI9ZXmbxmG4KCJ3UZigF7W
 BoaOQy+7zI/Vg9eQluTlcoW8pnQjd2xU0gfvPtroihK3noaNDMJpRingL95BY6Dv2N0Q
 mPcQ==
X-Gm-Message-State: AOJu0YzF5QfieGU/Nd+WvpNobluAZ037ujW0zl7Ic3zhD+2UIFcgbWOd
 OGFCxLLqv27dYV001pX6tZONA5GnBC4rlEDaVSSNQQbEHR53DXCDwvW6pu32
X-Google-Smtp-Source: AGHT+IEFp2stuPVEumm3xFBOnpfpRQTE1qiBs/EKyk20iJhoJG/Rgqut73EXKM7vZ31fzH2XWMKWFg==
X-Received: by 2002:a05:6a00:3499:b0:6da:9ab2:d933 with SMTP id
 cp25-20020a056a00349900b006da9ab2d933mr7400pfb.20.1706139966904; 
 Wed, 24 Jan 2024 15:46:06 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 fk19-20020a056a003a9300b006db87354a8fsm14260226pfb.119.2024.01.24.15.46.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 15:46:06 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:46:04 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Huai-Cheng Kuo <hchkuo@avery-design.com.tw>,
 Dave Jiang <dave.jiang@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>,
 Stefan Hajnoczi <stefanha@gmail.com>, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 07/12] hw/cxl: Pass CXLComponentState to cache_mem_ops
Message-ID: <ZbGhPIfJgzWlnsDS@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-8-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-8-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 12:40:55PM +0000, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> cache_mem_ops.{read,write}() interprets opaque as
> CXLComponentState(cxl_cstate) instead of ComponentRegisters(cregs).
> 
> Fortunately, cregs is the first member of cxl_cstate, so their values are
> the same.
> 
> Fixes: 9e58f52d3f8 ("hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-component-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 29d477492b..9dfde6c0b3 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -199,7 +199,7 @@ void cxl_component_register_block_init(Object *obj,
>      /* io registers controls link which we don't care about in QEMU */
>      memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
>                            CXL2_COMPONENT_IO_REGION_SIZE);
> -    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
> +    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
>  
>      memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
> -- 
> 2.39.2
> 

