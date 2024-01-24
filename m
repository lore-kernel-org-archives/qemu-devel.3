Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603F4C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkWQ-0007IE-MM; Wed, 24 Jan 2024 16:10:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkWQ-0007I0-4D
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:10:58 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkWO-0004iT-CC
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:10:57 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d750660a0aso20495645ad.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706130655; x=1706735455; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O4xU1xPzLV1x6z8Ss6xDVzDXbbEyrm2kDKmsKKYD7Y8=;
 b=gir0LRjd1PV/de3xoJ4WhxJrm/QAwjW0V/YiYrO8zM+NNmB23UCQwY3X8VXL0LSUGh
 Ontpk85bMaQe7QoMNvKhZjS2okAl+cBVVuSv1FugSnp3WpcMZri7XVACJwB5zWiUlmoQ
 cNeSn2j77lkzuD8EKdNkwMzP0SZJNa7boX2YJ1rwvNH6dLRUzcOIj+sMO5GBiTrOv/I0
 snt2MlVYaS1wzzM9YOQBtzukDT7gllMhwczEDZimCzJrGHK3SoC9nlXj0aSW85xIlHRs
 3Gd9bIWtSz37DgB1tei74jF07oKlKuMN9Pd5hfuKyYtTUbXhi75PYunWb61kVTwb5Ods
 ybFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130655; x=1706735455;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O4xU1xPzLV1x6z8Ss6xDVzDXbbEyrm2kDKmsKKYD7Y8=;
 b=SKIsGvEKUm9/NIOuoKAHhAwhNzvrLEPsiEyqgFKDDjP6ITmxLoZzKsCGosofNjwKBJ
 8v2ZpMk5uY+mgcNQm5f2cH0pvnUCy6+Xr2dd/chSuCTl4CiscXSxQNFyZAzijn/mmjsD
 EGi51+Llf++TszIgXlk44r0XJPjqJHnF8VeKOdyTOX3O56XwlT5Yj8l+tDM/DwsZ5S/e
 blw31tUs8Fa/JHf3WX5xCNdiWPkqX5vcBB87RuwdRxBj/O/dzjDK++gF55Mg+qx0Wf64
 KN/SGZGYh2BbOem+3XnnJCzUQrgo0vQiAIQOSl+kx0rWq6JdQcmAJnA4IDmZ9t1hclZL
 HLRw==
X-Gm-Message-State: AOJu0Yw+jRQOoEQOrbdBQJZEUAwzoNTqxP2QK1dUvXLPPL1oHU34yDtp
 Axwm2vfDafqGRzccUv1KWIQxD9i5hiaa76IJVlQAVyMYtgPGsmBN
X-Google-Smtp-Source: AGHT+IE4ZyUlrAQohEqAYTUCLHIZt6cHjZeVzqNz/BBqMndcA2TgxNfldeyeXFy9woRKTkRRL7ewDg==
X-Received: by 2002:a17:902:a50e:b0:1d7:852b:7020 with SMTP id
 s14-20020a170902a50e00b001d7852b7020mr1074273plq.85.1706130654808; 
 Wed, 24 Jan 2024 13:10:54 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 mq14-20020a170902fd4e00b001d74dd065e5sm5700690plb.136.2024.01.24.13.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 13:10:54 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:10:51 -0800
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
Subject: Re: [PATCH 02/12] hw/mem/cxl_type3: Drop handling of failure of
 g_malloc0()
Message-ID: <ZbF82w3iCa0t1awW@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x636.google.com
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

On Wed, Jan 24, 2024 at 12:40:50PM +0000, Jonathan Cameron wrote:
> As g_malloc0 will just exit QEMU on failure there is no point
> in checking for it failing.

The change is also related to g_malloc. So we may want to also mention it in
the comments like " As g_malloc and g_malloc0 will just ....  ". Other
than that, LGTM.

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c | 52 +++++++---------------------------------------
>  1 file changed, 7 insertions(+), 45 deletions(-)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 52647b4ac7..1b92a065a3 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -42,9 +42,9 @@ enum {
>      CT3_CDAT_NUM_ENTRIES
>  };
>  
> -static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion *mr,
> -                                         bool is_pmem, uint64_t dpa_base)
> +static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> +                                          int dsmad_handle, MemoryRegion *mr,
> +                                          bool is_pmem, uint64_t dpa_base)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;
> @@ -54,9 +54,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      g_autofree CDATDsemts *dsemts = NULL;
>  
>      dsmas = g_malloc(sizeof(*dsmas));
> -    if (!dsmas) {
> -        return -ENOMEM;
> -    }
>      *dsmas = (CDATDsmas) {
>          .header = {
>              .type = CDAT_TYPE_DSMAS,
> @@ -70,9 +67,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>  
>      /* For now, no memory side cache, plausiblish numbers */
>      dslbis0 = g_malloc(sizeof(*dslbis0));
> -    if (!dslbis0) {
> -        return -ENOMEM;
> -    }
>      *dslbis0 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -86,9 +80,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis1 = g_malloc(sizeof(*dslbis1));
> -    if (!dslbis1) {
> -        return -ENOMEM;
> -    }
>      *dslbis1 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -102,9 +93,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis2 = g_malloc(sizeof(*dslbis2));
> -    if (!dslbis2) {
> -        return -ENOMEM;
> -    }
>      *dslbis2 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -118,9 +106,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dslbis3 = g_malloc(sizeof(*dslbis3));
> -    if (!dslbis3) {
> -        return -ENOMEM;
> -    }
>      *dslbis3 = (CDATDslbis) {
>          .header = {
>              .type = CDAT_TYPE_DSLBIS,
> @@ -134,9 +119,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      };
>  
>      dsemts = g_malloc(sizeof(*dsemts));
> -    if (!dsemts) {
> -        return -ENOMEM;
> -    }
>      *dsemts = (CDATDsemts) {
>          .header = {
>              .type = CDAT_TYPE_DSEMTS,
> @@ -159,8 +141,6 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>      cdat_table[CT3_CDAT_DSLBIS2] = g_steal_pointer(&dslbis2);
>      cdat_table[CT3_CDAT_DSLBIS3] = g_steal_pointer(&dslbis3);
>      cdat_table[CT3_CDAT_DSEMTS] = g_steal_pointer(&dsemts);
> -
> -    return 0;
>  }
>  
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> @@ -171,7 +151,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      int dsmad_handle = 0;
>      int cur_ent = 0;
>      int len = 0;
> -    int rc, i;
>  
>      if (!ct3d->hostpmem && !ct3d->hostvmem) {
>          return 0;
> @@ -194,27 +173,18 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      table = g_malloc0(len * sizeof(*table));
> -    if (!table) {
> -        return -ENOMEM;
> -    }
>  
>      /* Now fill them in */
>      if (volatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           false, 0);
> -        if (rc < 0) {
> -            return rc;
> -        }
> +        ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> +                                      false, 0);
>          cur_ent = CT3_CDAT_NUM_ENTRIES;
>      }
>  
>      if (nonvolatile_mr) {
>          uint64_t base = volatile_mr ? memory_region_size(volatile_mr) : 0;
> -        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true, base);
> -        if (rc < 0) {
> -            goto error_cleanup;
> -        }
> +        ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> +                                      nonvolatile_mr, true, base);
>          cur_ent += CT3_CDAT_NUM_ENTRIES;
>      }
>      assert(len == cur_ent);
> @@ -222,11 +192,6 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      *cdat_table = g_steal_pointer(&table);
>  
>      return len;
> -error_cleanup:
> -    for (i = 0; i < cur_ent; i++) {
> -        g_free(table[i]);
> -    }
> -    return rc;
>  }
>  
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
> @@ -1168,9 +1133,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
>          }
>  
>          cxl_err = g_malloc0(sizeof(*cxl_err));
> -        if (!cxl_err) {
> -            return;
> -        }
>  
>          cxl_err->type = cxl_err_code;
>          while (header && header_count < 32) {
> -- 
> 2.39.2
> 

