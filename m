Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27755C47E49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 18:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rShrb-0002dl-IR; Wed, 24 Jan 2024 13:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShrZ-0002cV-CJ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:20:37 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rShrX-0004ps-II
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 13:20:36 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1d71e1d7c78so34819295ad.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706120434; x=1706725234; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uDr042bqAkTMmsZtF2KErj5W9qTXGoieWliyT4SgJxE=;
 b=grqMGOevXQqsq3oOUuc16l49jYaRvof8ZWZ+FQqQHfp/tahvvi42Fn6GwIoh/JWoLH
 Wtx+D9TAVHajYRW2LD6Yu/qhIos+9CIb/lYu8xMM4RpshN3VhzVGobYgH/BRKhEVUfHA
 56vNRnibv7TwwSw3vdZw4aL/09RNsQBlxVZoAvmJcaHNGtMkWx7/2PG2ZoiZ64mwx0UJ
 iTgRQWOnb+joU1AColQyxPVdww3I9G1pw8MqQWhnelctRGFz1K03nWh9KWrETaOPlQU+
 kIMrgLUHWaazUiYQCbDHKqDo46LIis3mihPjme//t/5iXusY/2lFcEs3GpHcg3RRBuws
 /DTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706120434; x=1706725234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uDr042bqAkTMmsZtF2KErj5W9qTXGoieWliyT4SgJxE=;
 b=KrNkHxfosF3RG1PROePEzJpO0lPn4ZHYpXM+vJ6vCC0+eFuyszjxfwh66F54CMSd4O
 xa+oR0AYERRUK3tIuD78gw0p/7UXded0cMBBNRWzfuCh07Rnnq1W+NCD+eu3ISms+fJE
 00dqiBW/PDpYv7BKP4kQ+drrm+RoIU2ic9Po5jJ9ALE31j62XnpJ1Ghe6ymSQpMfQ2p/
 Cw/eQB1addYiUCAb9xkTZU7BCDlYLvfMwK4RDOCrzjmaDOPXTv0+43xborOI/8G04+/n
 nyCgfc/bsOhCqfrdRFV3CbDRxXfTsjZsuJjm4ffgznVKgQ3ifD9+XH3KWNNaO1u5/WqC
 9XLw==
X-Gm-Message-State: AOJu0YxS71OqewBSpjxpeqZePFrKX0A/jtRs0/rktYTEuHzbr9SPX+/4
 /SD/UPGufMgZEDwgc+V8GBezSWXwddvaDnGZkdWnVJ4gnU6N8RZb
X-Google-Smtp-Source: AGHT+IHRRM1yZHXWP2uIEivqRQkForhuWSpsUgHFjV90Pu3FR/zZH7WRIR8uslMgL8blqX8DhX+AYA==
X-Received: by 2002:a17:902:f681:b0:1d7:4681:c501 with SMTP id
 l1-20020a170902f68100b001d74681c501mr1211313plg.59.1706120433789; 
 Wed, 24 Jan 2024 10:20:33 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a170903308b00b001d76e9ce688sm3021216plc.114.2024.01.24.10.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 10:20:33 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:20:31 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 2/5] hw/cxl: Update link register definitions.
Message-ID: <ZbFU7-k_3qwQz4rS@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-3-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-3-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x635.google.com
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

On Wed, Jan 24, 2024 at 01:48:11PM +0000, Jonathan Cameron wrote:
> Not actually implemented, but we need to reserve more space for
> the larger version of the structure in CXL r3.1.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_component.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 7d3edef1bf..2c7631bd1e 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -104,10 +104,10 @@ REG32(CXL_RAS_ERR_HEADER0, CXL_RAS_REGISTERS_OFFSET + 0x18)
>      (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
>  #define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
>  
> -/* 8.2.5.11 - CXL Link Capability Structure */
> +/* CXL r3.1 Section 8.2.4.19: CXL Link Capability Structure */
>  #define CXL_LINK_REGISTERS_OFFSET \
>      (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
> -#define CXL_LINK_REGISTERS_SIZE   0x38
> +#define CXL_LINK_REGISTERS_SIZE   0x50
>  
>  /* CXL r3.1 Section 8.2.4.20: CXL HDM Decoder Capability Structure */
>  #define HDM_DECODE_MAX 10 /* Maximum decoders for Devices */
> -- 
> 2.39.2
> 

