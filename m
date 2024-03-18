Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21FCC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmGDf-0005B9-17; Mon, 18 Mar 2024 12:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rmGDX-0005AF-M5
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:52:07 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rmGDW-0002VX-71
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:52:07 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-609eb3e5a56so49604657b3.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710780724; x=1711385524; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vz0r7CrxXAbXAWl8jQv4wux9fTOJzzdZaP8w4NIvRC8=;
 b=ZBXwjGPcBdpwGTwZ56nZaGfkZh8eRGMWhRQ3P0Y3A59U2Fchfv4Bg7zuQa4qVOQ8gy
 45uz8Pv6JsoHIXP6cQCM8ffpMwCuQg4vfVC+vDDEAFIUNaPSPaTY1LT83OP5n0S51eK+
 YVrNUE4L/aROC+ql/xHppA4leKkcmF2Poousfkb788MH3bp/fOFOKEcu/eVYXU+CiGbO
 5nRjBMK4Q3PF4eWTn/OhM/oTQmrq2X+jE1EzS0U4sBh/iF6noOyG1iNw7IE2YfPoCSvF
 zprFYRCzxVUz4qR25Q82pA63uD+LBd5nwAFrhe/JxhFDhze9IaB09t+QbtzPxZHx10vx
 wD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710780724; x=1711385524;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vz0r7CrxXAbXAWl8jQv4wux9fTOJzzdZaP8w4NIvRC8=;
 b=UAyjefC8R4nijOPpW60a/tQJLP7gfVDGx7m4yHfd6KvYVxJ5mmQTYne7NOiUjcYNV+
 D4Bsp3l4E9DK4myRXXigUlenDW1yYjoBgYU488/tYeQVsqCnUT7bpHpoizpbTyh6UgL8
 oTGwOPvRcPgx0IuUjidIffKv4XkJqEGkiu31IYR4A1visefyoM7eN29/tp944wWBc/lu
 g6G32yNzWHelavXcAUyNWDgs/TPlb7xAUC5f75gBMtXr/MEhb6O6ZXoWMk7kZzXS4vSS
 dA/5KVYRv4jMd+cXPLc28+6vlFFWIUuwnsGA53pa7v8uIqp8NlBEnIESqWcRjS96GTqN
 zHfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9q9mVb7Acp73LSQptJcbvqSussa+JDTrBIj7CkcUW8SAKdXyzmhwEIpsIoGbJ9UoVugZ7KP/eEktEpsj3UpaO+oEv2ow=
X-Gm-Message-State: AOJu0YzJX5soEDwMI11nqdLuQGjbDgfp8B/mTTChFrdDHYxmf+2wO4SG
 T2i6ToSPnXYWL8YNc1fWXe7eCaoIT0nkl11XvhrbBZaNaSZuo4c6
X-Google-Smtp-Source: AGHT+IE74Blc9zBVN0WzDHrovLKlrrSAraGNg67XAavl/JFPJfRSr+e3Xmo8Mk52fM6O7BPN4plgLw==
X-Received: by 2002:a81:6e8a:0:b0:607:f09a:d298 with SMTP id
 j132-20020a816e8a000000b00607f09ad298mr12423396ywc.42.1710780724301; 
 Mon, 18 Mar 2024 09:52:04 -0700 (PDT)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 r123-20020a0de881000000b00609f4a354d2sm2032136ywe.71.2024.03.18.09.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 09:52:03 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 18 Mar 2024 09:51:36 -0700
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: ira.weiny@intel.com, jonathan.cameron@huawei.com,
 dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, qemu-devel@nongnu.org,
 chenbaozi@phytium.com.cn
Subject: Re: [PATCH v2 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <ZfhxGHXCCgWSLqcX@debian>
References: <20240318022928.509130-1-wangyuquan1236@phytium.com.cn>
 <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318022928.509130-2-wangyuquan1236@phytium.com.cn>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112c.google.com
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

On Mon, Mar 18, 2024 at 10:29:28AM +0800, Yuquan Wang wrote:
> The dev_dbg info for Clear Event Records mailbox command would report
> the handle of the next record to clear not the current one.
> 
> This was because the index 'i' had incremented before printing the
> current handle value.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/core/mbox.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..b810a6aa3010 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -915,7 +915,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  
>  		payload->handles[i++] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));
> +			le16_to_cpu(payload->handles[i-1]));

LGTM except for the space issue mentioned by Jonathan.

After the fix,
Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
>  
>  		if (i == max_handles) {
>  			payload->nr_recs = i;
> -- 
> 2.34.1
> 

