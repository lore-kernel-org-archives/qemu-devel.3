Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B5CC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:42:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmsU-0003Sb-6l; Wed, 24 Jan 2024 18:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSmsR-0003Qq-IW
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:41:51 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSmsP-0001Fs-N0
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:41:51 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6db0fdd2b8fso3214319b3a.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:41:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706139708; x=1706744508; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gaSatxmH+joCu/w8PnCw+KneNZItml6/XeGG6dTffFY=;
 b=K4geTy8xTwnx02Nn6G0kxEmCMsGGLMXPDMiwtINjjbz17QipBCRarxjx1XOP68uSfi
 GUCL6Ml2LRV6fGfiIGzlDmJfWyAr8ltsxVK4DpWkmmf3ndcrjwbkeJ8Ept8OIfWP4bKW
 CUX72AGqAL//KqvOQkk2H3FH3mQpnQK15weFCAmsFAwOVySvitiL0sVHJscIg8MPIaCI
 KsYtMPnbqiLlwyt8VG1+4guJh9jSKa8JCj99fn++ZkZCSeP3++wCI64jNr3hymp2Y8Qf
 kDzDUPoQAz0c9eb3kV7n8+s0xNZTYIxH2JKM9hAPWJhzyv49Q7cw2Gp7jPuOQqO82i4A
 gDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706139708; x=1706744508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gaSatxmH+joCu/w8PnCw+KneNZItml6/XeGG6dTffFY=;
 b=Q3z4+r2AFjm2kN58oDHshJq9CBuqmXR4DZB7Wa9A8CPLSOD6FCtH7vaQnJUkoHLSZc
 BGp6yIgMdgqqBVshHWAd+oJYQNg+L+5LZ3YmdBSevuk3YJ3kXefW/pE29o8ROmEGdWVY
 Dy6hyfVMLOOJ46/9MSw6wrE0pvJhoM6vpJLF5r9qS2C6W9BbESrjMg8Jz6QHVAxDvYbq
 sggTTB7QNbRJ3OndFl9SeupXF+qfEjrGSQMxKHEJ+/Lnvvs7+zdMBP9mEJeQ6nG3nO9r
 Kf5MhOXN74pHlKEbia4GZDxU4v8oWUlxjrvTeqQEjUN/WyHk8bF51G8fTY8Bus3x4z5L
 NMew==
X-Gm-Message-State: AOJu0YzXwNwJ+XxP0I/Fjo7JRJHYLOSfakGqM4oeaAhA0EDXxcmnelyP
 fJIr+6cxNlmUNwFfAYO4+8SNzYUIn+pHcT1a471PqpjwMDeGOsdM
X-Google-Smtp-Source: AGHT+IHVe9lTVakJVs+F5MIJosRAJv06fJmfY4gFLfd0qojOcZiL4TdrioGI5uwOyIKDgl47EPPBxA==
X-Received: by 2002:a05:6a00:2194:b0:6d9:ac99:316b with SMTP id
 h20-20020a056a00219400b006d9ac99316bmr358593pfi.50.1706139708121; 
 Wed, 24 Jan 2024 15:41:48 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 i3-20020aa78b43000000b006d9be279432sm14352504pfd.2.2024.01.24.15.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 15:41:47 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 15:41:45 -0800
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
Subject: Re: [PATCH 05/12] hw/cxl/mbox: Remove dead code
Message-ID: <ZbGgOR1zTEp17_F7@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-6-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-6-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x42d.google.com
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

On Wed, Jan 24, 2024 at 12:40:53PM +0000, Jonathan Cameron wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> Two functions were reported to have dead code, remove the bogus
> branches altogether, as well as a misplaced qemu_log call.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-mailbox-utils.c | 43 +++++++++++++-------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6eff56fb1b..dc42850767 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1001,15 +1001,8 @@ static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>  
>      cxl_dev_disable_media(&ct3d->cxl_dstate);
>  
> -    if (secs > 2) {
> -        /* sanitize when done */
> -        return CXL_MBOX_BG_STARTED;
> -    } else {
> -        __do_sanitization(ct3d);
> -        cxl_dev_enable_media(&ct3d->cxl_dstate);
> -
> -        return CXL_MBOX_SUCCESS;
> -    }
> +    /* sanitize when done */
> +    return CXL_MBOX_BG_STARTED;
>  }
>  
>  static CXLRetCode cmd_get_security_state(const struct cxl_cmd *cmd,
> @@ -1387,27 +1380,21 @@ static void bg_timercb(void *opaque)
>  
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
> -        if (ret == CXL_MBOX_SUCCESS) {
> -            switch (cci->bg.opcode) {
> -            case 0x4400: /* sanitize */
> -            {
> -                CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> -
> -                __do_sanitization(ct3d);
> -                cxl_dev_enable_media(&ct3d->cxl_dstate);
> -            }
> +        switch (cci->bg.opcode) {
> +        case 0x4400: /* sanitize */
> +        {
> +            CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> +
> +            __do_sanitization(ct3d);
> +            cxl_dev_enable_media(&ct3d->cxl_dstate);
> +        }
> +        break;
> +        case 0x4304: /* TODO: scan media */
> +            break;
> +        default:
> +            __builtin_unreachable();
>              break;
> -            case 0x4304: /* TODO: scan media */
> -                break;
> -            default:
> -                __builtin_unreachable();
> -                break;
> -            }
>          }
> -
> -        qemu_log("Background command %04xh finished: %s\n",
> -                 cci->bg.opcode,
> -                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
>      } else {
>          /* estimate only */
>          cci->bg.complete_pct = 100 * now / total_time;
> -- 
> 2.39.2
> 

