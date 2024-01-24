Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063BEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkXY-0000s2-U4; Wed, 24 Jan 2024 16:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkXU-0000mx-JM
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:12:04 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkXR-00051a-HQ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:12:03 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-290fb65531eso644250a91.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706130720; x=1706735520; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=en9elrlzH5ROGIslaMPqVVimkyWbMWGsUFGcvQEX4OE=;
 b=PzqaRw1wdFAPBFx8MmDeKZONUCKyEM2J2zE0X/m/QjHZefJPNEv+K4a7SnQHSDPPTw
 lkFrADM6POAewJ18F7Ea+bmCmhW8w8B+vzW2Ayu/Fe2eAMJJq/TaFRUKEEXpbZyrFetg
 OxTV15blR8oleiPnKiN+HH1ec9uPhDPq3gJ9m4Ip636DbaxpTIfh3oRNwdeNfCp2KuaE
 SEu/5WOghXrUIOcW+FwJ6SQytIfN2TiuiV0v2VThY3e4y3dd9z4UqYNq/RbNAhCVWb1I
 CP+WYIyG6lJ3/3/Z2ePo4NGr8zzKZFrG/gsHh7042tosYIPKDkXP81xT9+VkxMRcVWbm
 rGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130720; x=1706735520;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=en9elrlzH5ROGIslaMPqVVimkyWbMWGsUFGcvQEX4OE=;
 b=ooruXWSMDlANsHU5pRhuhPxXxpvCvshDvmZ3yRgsRtOs61I3ZAr2lak7Cg9bvyn/eM
 osnH+/UXEJG0aPRucIVQ1WcUnWqM/FqCnALsJ8FJuja9JEuWEOwvPa3Labki78y5oSJ4
 FDRKY0lRgjmPpc4uY5llNJWwaVRBsJkGgWcnjHOKOo6dxEBS3hOgpyk0XixYsNmn/nhL
 cDmJpE9a1Wj2jfcrNsOuo0D7gsWcmY+6b/JEVN+KE28qC3xUfSVGQmdZSgdxnonef2ey
 qdRxyJxKNHd3wac6ufZTueAdYLBbTO7wvKjPGEjSsS4+AARvJ16mPaULLJj7m1G84Cxa
 09Kw==
X-Gm-Message-State: AOJu0YzGKZHDzct1dBD7oJec1pPbBBDVsS84r5TUIe8RbnBEUWvc2RJo
 YhcLZfyBDef01wTdakQTFT6m5eUu+UOcWdfXfGjhtjAniiz6ETrb
X-Google-Smtp-Source: AGHT+IEk5Kj8Zs9IkifoB3g21OSw1ffdiYqnVXgWmdl/J8qaASYgziaGsv8xwvbkOOT2F+qre3g5sg==
X-Received: by 2002:a17:90a:a410:b0:28e:8012:1329 with SMTP id
 y16-20020a17090aa41000b0028e80121329mr139000pjp.23.1706130720053; 
 Wed, 24 Jan 2024 13:12:00 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a17090add8500b0028dfdfc9a8esm94448pjv.37.2024.01.24.13.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 13:11:59 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:11:56 -0800
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
Subject: Re: [PATCH 03/12] hw/pci-bridge/cxl_upstream: Drop g_malloc0()
 failure handling
Message-ID: <ZbF9HMx_XJCKTcIH@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-4-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-4-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pj1-x1035.google.com
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

On Wed, Jan 24, 2024 at 12:40:51PM +0000, Jonathan Cameron wrote:
> As a failure of g_malloc0() will result in QEMU exiting, it

s/g_malloc0/g_malloc/


Fan

> won't return a NULL to check.  As such, drop the incorrect handling
> of such NULL returns in the cdat table building code.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/pci-bridge/cxl_upstream.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
> index 36737189c6..d5341b530f 100644
> --- a/hw/pci-bridge/cxl_upstream.c
> +++ b/hw/pci-bridge/cxl_upstream.c
> @@ -228,9 +228,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      sslbis_size = sizeof(CDATSslbis) + sizeof(*sslbis_latency->sslbe) * count;
>      sslbis_latency = g_malloc(sslbis_size);
> -    if (!sslbis_latency) {
> -        return -ENOMEM;
> -    }
>      *sslbis_latency = (CDATSslbis) {
>          .sslbis_header = {
>              .header = {
> @@ -251,9 +248,6 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      sslbis_bandwidth = g_malloc(sslbis_size);
> -    if (!sslbis_bandwidth) {
> -        return 0;
> -    }
>      *sslbis_bandwidth = (CDATSslbis) {
>          .sslbis_header = {
>              .header = {
> -- 
> 2.39.2
> 

