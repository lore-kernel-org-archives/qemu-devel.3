Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE864C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:54:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSn4J-00067U-9i; Wed, 24 Jan 2024 18:54:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSn4H-00067I-Ks
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:54:05 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSn4F-0000Re-KF
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:54:04 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-290b37bb7deso2716429a91.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706140441; x=1706745241; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u7pyltUvzVFGZNAZxa7Mlyt8rLeSRqqjX7xnAHcOcr0=;
 b=i72i2JqzCHXxR9suy+gA2cn14L8B9dDmD669L1PoIeeWSkvmrSmaFyXRGw2LfNjasi
 rOPXfnx41m+09eHHkgoRxz6qPeAlGYvjH2AvWSdNXupJKV/vXOOI95MHvo7Rb2daBEot
 9Q99741ja6L8W1FnS3MNPNG138tX8Tdj78E7ltccL5qwQMo6RS0+0DwuLuuh5S6CJfx+
 lIdmXGfGZ1M/UnmlX0y82sR6n5Uiy+agFsc5PPTbKDKWSuI/DgyOmrO4oeRsk9CmkIc+
 r5/xxF11oasHNOwOKDeGYL4pj1KPvpp2d+OLplgP6TNvo6TnA/JYTgm5rNTbA15n7D8S
 YBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706140441; x=1706745241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u7pyltUvzVFGZNAZxa7Mlyt8rLeSRqqjX7xnAHcOcr0=;
 b=vk1h0cgq36lLfeHp2Da8YuWZXRG1TEOPM9Zl1IqL6SEH2PEn6/hBcl87mqU0VjksTr
 pfPTbXRiSFQ2c7yGCZPM0xE4kHPeUvjimQ++tskrrxvxcSVA+siZcF8UqbAqB5OCvMl8
 daryk8p0+JvlKn36KqDh2MWpk00GQMbDE5FWMIF9aHrVseKDaHuilz3kp9cHaFO4QsUN
 HqPXYo+7pKjdbaQvCdOu1aD8lhFKDjNg5Nz8GTa/W4MTuZ6JzyaUhii6gFnOhiiXgBc+
 L5uXfXzBAPIUJrAmUeLNRGA+9xECHbGZvKTMQgyGqqZrQk3LNmKhQKke9qfs0vNBjLdP
 JCEg==
X-Gm-Message-State: AOJu0YwQVWntszLUFC5bAulSe3V4zmTCr8m5YSISZpfae9eGJJyql1cJ
 A0ITh3V9E2vb7/CaAEHymzrZtxqNfCs4nn1FeNatdREE0RdOyV2+
X-Google-Smtp-Source: AGHT+IFfj7f5Cyb6ETziKXIhjRTeU0iGmtCXi0SIOWtQmIrz+8FhPfXpWgpY72O9mvFbjBNwkOTT4Q==
X-Received: by 2002:a17:90a:880a:b0:290:172f:3b1b with SMTP id
 s10-20020a17090a880a00b00290172f3b1bmr104708pjn.98.1706140441160; 
 Wed, 24 Jan 2024 15:54:01 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 iz1-20020a170902ef8100b001d72358de29sm8848933plb.287.2024.01.24.15.53.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 15:54:00 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:53:58 -0800
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
Subject: Re: [PATCH 09/12] hw/mem/cxl_type3: Fix potential divide by zero
 reported by coverity
Message-ID: <ZbGjFiKKPhC_uiOF@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-10-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-10-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1031.google.com
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

On Wed, Jan 24, 2024 at 12:40:57PM +0000, Jonathan Cameron wrote:
> Fixes Coverity ID 1522368.
> 
> Currently error_fatal is set if interleave_ways_dec() is going to return 0
> but we should handle that zero return explicitly.
> 
> Reported-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> Note this is a stop gap until a more complex HDM decoder verification series.
> ---
>  hw/mem/cxl_type3.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 1b92a065a3..24211703c6 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -794,8 +794,12 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>          }
>          if (((uint64_t)host_addr < decoder_base) ||
>              (hpa_offset >= decoder_size)) {
> -            dpa_base += decoder_size /
> -                cxl_interleave_ways_dec(iw, &error_fatal);
> +            int decoded_iw = cxl_interleave_ways_dec(iw, &error_fatal);
> +
> +            if (decoded_iw == 0)
> +                return false;
> +
> +            dpa_base += decoder_size / decoded_iw;
>              continue;
>          }
>  
> -- 
> 2.39.2
> 

