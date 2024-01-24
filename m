Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4450EC47422
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 21:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSkQU-0002Y9-Dd; Wed, 24 Jan 2024 16:04:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkQN-0002XC-Lj
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:04:45 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rSkQL-0001Pk-R6
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 16:04:43 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cde7afa1d7so3093759a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 13:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706130280; x=1706735080; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8JYoZcnluoDvCJc9xqAMy3/BcoaNF0u77JLKKb6+Ahg=;
 b=jEn/YJlY/RcgO5ZoBBZE01PEDWBYMzkoahSJZyjI6fSJ125rFTqFmx7b6eq1kb3wFA
 t4KTNAwkad0HsBmsQ938aFFb9UVP9R0K9wGIfkynV9mf2+0VkQrbAnWnyQIK6VoiMo3Z
 O0Yo33mLBdia6gu70u2rkPvMq7jWmg8NQw6jQnuFk6h2JAqHiQOiHJ0K3/g8MI/Jhkvm
 /68UrT7cvM0xvgBJ6R49rSIwCDHHrakAexsuq14rT3aq6cszDHP7mkOPyDzxoW1dqKMU
 yfkXzcKq8P4h0RXoe3+PCow+L5DPd2KRzQg0KWjilLmE8KVyvb9aFbVSpCSKRbhZ+0ma
 ViJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706130280; x=1706735080;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JYoZcnluoDvCJc9xqAMy3/BcoaNF0u77JLKKb6+Ahg=;
 b=QD8pq4UyWk2PGmP3zSgSkgvdmTqO9agIPzg3ni7kFiG/jVJL0hNCVc6FNlIyGzqgs8
 +aC1KtfnqeTH77i8ersncSlxXcHaPIs4C9Z+o87kUHyzYGBJdqFZAxIf4iW7ATyftcn7
 IN1pRAUyDkCxySAINOE3vhcBkfID0BX8pd0vXvPg7LyHs0/PEI9ivoc2tqlC9jm5GmRH
 7mEPNIaDr/++uHhpyrlFaecjm9rqiBqhP1NMoMBzNwHglSFLUj2ARIrzE4E9S0A5Iknw
 TWEsepPYMaqRXg4Kb3A4cOJfajED8A0DR5X8KCONbqaaRRQ6UmffnTG6I4NJghSpTuFD
 u2YA==
X-Gm-Message-State: AOJu0YyWxjBnP50qmOntomKfP4iQiWDkMUP7z67ztKImtesS4zmrDzPo
 ownuW4j4vnXuJfk6/G7lDSn34t3vFmyXYR/yXCoqeN2OSFWesGZO
X-Google-Smtp-Source: AGHT+IEdc1zUvJpKwLv00KX1tKvpJYxkxJv/r8oxFFtNTpoU7K9eRW/RciWy/etjhzi2Tw5/6a3v+g==
X-Received: by 2002:a17:90b:440b:b0:28e:3daf:f6e0 with SMTP id
 hx11-20020a17090b440b00b0028e3daff6e0mr133045pjb.53.1706130280164; 
 Wed, 24 Jan 2024 13:04:40 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
 by smtp.gmail.com with ESMTPSA id
 md2-20020a17090b23c200b0028adcc0f2c4sm90521pjb.18.2024.01.24.13.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jan 2024 13:04:39 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 13:04:23 -0800
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
Subject: Re: [PATCH 01/12] cxl/cdat: Handle cdat table build errors
Message-ID: <ZbF7V0lhCwZ2fey4@debian>
References: <20240124124100.8218-1-Jonathan.Cameron@huawei.com>
 <20240124124100.8218-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124124100.8218-2-Jonathan.Cameron@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x52f.google.com
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

On Wed, Jan 24, 2024 at 12:40:49PM +0000, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The callback for building CDAT tables may return negative error codes.
> This was previously unhandled and will result in potentially huge
> allocations later on in ct3_build_cdat()
> 
> Detect the negative error code and defer cdat building.
> 
> Fixes: f5ee7413d592 ("hw/mem/cxl-type3: Add CXL CDAT Data Object Exchange")
> Cc: Huai-Cheng Kuo <hchkuo@avery-design.com.tw>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-cdat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-cdat.c b/hw/cxl/cxl-cdat.c
> index 639a2db3e1..24829cf242 100644
> --- a/hw/cxl/cxl-cdat.c
> +++ b/hw/cxl/cxl-cdat.c
> @@ -63,7 +63,7 @@ static void ct3_build_cdat(CDATObject *cdat, Error **errp)
>      cdat->built_buf_len = cdat->build_cdat_table(&cdat->built_buf,
>                                                   cdat->private);
>  
> -    if (!cdat->built_buf_len) {
> +    if (cdat->built_buf_len <= 0) {
>          /* Build later as not all data available yet */
>          cdat->to_update = true;
>          return;
> -- 
> 2.39.2
> 

