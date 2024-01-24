Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804B8C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSn1x-0005O5-BK; Wed, 24 Jan 2024 18:51:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSn1s-0005Nu-Uv
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:51:37 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSn1r-0007il-3c
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:51:36 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6dd87e7c355so1352051b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706140293; x=1706745093; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KYzTic2jRsgywGr1ttQI+Aww2cwwhruAURzwniXtwKk=;
 b=LtITxS0uPdFOp5XNpJYo9jimk7WJuu2dO6b6H0oNvBSQYrs6V3YB5cbpY2i5XgjHQg
 LVziIGayV/h8XFBRXZsr6BpTr5h7hsM/lgZz663tyq5+jYRBZVgGr5EOcS6GjYPSS6qd
 HvaBI/pZhePg+3Wn6pVSRyx/KD2KKkjPuYFgP5sVp9Ho2LGQ819LfwBy9TB5jBZc+spw
 X+eGjOo4P0dEzK8aeJbwrPvPcPMlE9dTfgAUW0pANnxntcbjx1q8GiwwvkTgcpQjGjGE
 l20MV+0HF49zAhucaM9DODT5KRWZEqiT3jp6LFQ5qAckOCfGVqidtBSdMJ6mZa9yNdpL
 kyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706140293; x=1706745093;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KYzTic2jRsgywGr1ttQI+Aww2cwwhruAURzwniXtwKk=;
 b=s2iXrNp+e2c4XA+5Ij7o4TD/5MOCJ9srQppyCcJKVAGiT8E7G8ZwbNOaBD6LhV7j+J
 oIFPReMdPmarlwos5qdo8s7K+YADepf30as0uWK00d9pyc0Q8yUJiL2nc85yOoIz0DOM
 N2vY9eCQXNfBHWaZ5ifRf7FiFCMls10rvq1XiQbqp/NEJid9bKoG4ustkNdrK8YdgQPz
 AkgqIo7KRMaM8ouwkLCgw8JvMEBXmP2llogCl8NuWteUQQz+IQFeXwDo69Q0lNzo+erX
 0i1cBbJIxwbhgEHHuSGg4NQmb0jcFCjvtUobE0SrybwiAE/RPv48QElDB45m8Q41EDHi
 SORg==
X-Gm-Message-State: AOJu0Ywgh8zsY1r8TcNlRrSFjyREjN87gctglZRtITp1fO6meRxq+O0W
 KqDRNj0alY7+bUQ9cSyNEr6NNZx0mM1s7RxsavqbNDSy6dUVLb3H
X-Google-Smtp-Source: AGHT+IG6eQZrsqh/a2qdic52mZp9UwTKi9IL1hqrBRngvYk9a/N7/I2GqBYdJTSI7v0ZvLmut+zmNQ==
X-Received: by 2002:a05:6a20:42a1:b0:19a:4f9b:3bf0 with SMTP id
 o33-20020a056a2042a100b0019a4f9b3bf0mr259226pzj.0.1706140293095; 
 Wed, 24 Jan 2024 15:51:33 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902b70500b001d74c285b55sm5803504pls.67.2024.01.24.15.51.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 15:51:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:51:30 -0800
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
Subject: Re: [PATCH 08/12] hw/cxl: Pass NULL for a NULL MemoryRegionOps
Message-ID: <ZbGigs0ymWgjB0Lm@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-9-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-9-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42c.google.com
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

On Wed, Jan 24, 2024 at 12:40:56PM +0000, Jonathan Cameron wrote:
> From: Li Zhijian <lizhijian@fujitsu.com>
> 
> a NULL parameter is enough for a NULL MemoryRegionOps
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-component-utils.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 9dfde6c0b3..5ddd47ed8d 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -197,7 +197,7 @@ void cxl_component_register_block_init(Object *obj,
>                         CXL2_COMPONENT_BLOCK_SIZE);
>  
>      /* io registers controls link which we don't care about in QEMU */
> -    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
> +    memory_region_init_io(&cregs->io, obj, NULL, NULL, ".io",
>                            CXL2_COMPONENT_IO_REGION_SIZE);
>      memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cxl_cstate,
>                            ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
> -- 
> 2.39.2
> 

