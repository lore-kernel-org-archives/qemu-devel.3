Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BBBDC48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPZL-0005zD-N3; Thu, 01 Feb 2024 00:25:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPZD-0005yx-Ah
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:24:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVPZA-0005zf-31
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706765086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4rt5my6Qxlq9Q94L/kFV0Rdoa8m6u9GduqPWKhMt88=;
 b=Jj2Yd5jjuxUwbW+FJdjNl6/WsXn7EKkSclnD4T4S1qZ07svfJNA35s6tEFIe/JePHlgE3U
 GHOMZEi3M9x0ytnh6GiyKpGqtpSTfcic8d5cePsWMTpEUKfEd+C8LwE8tqQOZZ0oAsRHqd
 HNZpOswh5top3+HYrFGc4L6w7pHUYOc=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-DBdENlGSOOqOhhaGSRMdtA-1; Thu, 01 Feb 2024 00:24:42 -0500
X-MC-Unique: DBdENlGSOOqOhhaGSRMdtA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3bd4b68fa43so178530b6e.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:24:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706765081; x=1707369881;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4rt5my6Qxlq9Q94L/kFV0Rdoa8m6u9GduqPWKhMt88=;
 b=jz/cGQYpJPEfJHleebr9PXAmPUMZY8cuChGJ6qm/rDHso5saqOIVc3BJF+Wd6S6P41
 gnCX6JUQAl28AGEdPDrbEmAG58P72WCUk/XzPM5Gws+gNbf0mmenVofOguE8zAMT2PDp
 lzZMjI1mWh9HIDcfG2B4Yvagxnsm1ZO5jUsszjMP2jtvbVoMGDMiprpgb84NntSuLJw9
 qZ3RmLiToopwt97bagWMeInt/+nbcWqNBrCEIpnipIU/T9nnIdkG9BQYYhQDeITK/d2y
 WPHEKr5Y1OVLSUbKkRR7v5KSgWJN19NP6ZgOO8+pCyMd0vQ6tNsOnfD748XTsm7/92MI
 29Aw==
X-Forwarded-Encrypted: i=0;
 AJvYcCWBKi4ZA7+EOpdyNzS+qeSYgPTj2LFEybGSY3fewIBWYYpxMY3m8R30fz+TIPhvI3Y1daBosBWl/jy5KN+uC75A1H6kSvM=
X-Gm-Message-State: AOJu0YyDZgPkr6cx7s1ZJcoqU949ug6sN5WkfUa3GajMUjUR+tmR5WE2
 OKC5FMT7qeMYONHNqgg8sjdCNWbPnFuqTskF9gPmuaBm+Z7ohl0vCoidQIYGGIkmOddB7K84EBI
 cX20gJF7Syyhdj9y/vSAvfQ8GETM0nB6muAJwcT1pljmploFonbIE
X-Received: by 2002:a05:6358:706:b0:178:9f1d:65e4 with SMTP id
 e6-20020a056358070600b001789f1d65e4mr1442918rwj.3.1706765081469; 
 Wed, 31 Jan 2024 21:24:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI4xS+6N7SdNN2DbnrlblvTcWf6to24QBvxJ9edSS9QruiNbdXZ+dMiMnMKA4zuG9tL1ov2g==
X-Received: by 2002:a05:6358:706:b0:178:9f1d:65e4 with SMTP id
 e6-20020a056358070600b001789f1d65e4mr1442907rwj.3.1706765081155; 
 Wed, 31 Jan 2024 21:24:41 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCV99I31VzOJvp6L0mI5zyEdtbsMjLaALyiFC6xeVe2Hhvi4BTXZ1VouFIvtRaZ3ygrlwL6qWVBXhcl9Cn5oqEEEo+jc70n1ezHgOohGJhmQFEYuDhNNns5To/hxZRLk3Z7e69RLPX94a5ehN1AH+Ix4lksrYhW6RXxas2KOQ2XUZy7aVoNhX80/btS/s7BiqcZDNd32Ip8V
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 s24-20020a056a00179800b006d9a6a9992dsm10828603pfg.123.2024.01.31.21.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jan 2024 21:24:40 -0800 (PST)
Date: Thu, 1 Feb 2024 13:24:33 +0800
From: Peter Xu <peterx@redhat.com>
To: Hao Xiang <hao.xiang@bytedance.com>
Cc: farosas@suse.de, peter.maydell@linaro.org, marcandre.lureau@redhat.com,
 bryan.zhang@bytedance.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 15/20] migration/multifd: Add test hook to set normal
 page ratio.
Message-ID: <ZbsrEcDbm_F4U0Hj@x1n>
References: <20240104004452.324068-1-hao.xiang@bytedance.com>
 <20240104004452.324068-16-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240104004452.324068-16-hao.xiang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Jan 04, 2024 at 12:44:47AM +0000, Hao Xiang wrote:
> +# @multifd-normal-page-ratio: Test hook setting the normal page ratio.
> +#     (Since 8.2)

Please remember to touch all of them to 9.0 when repost, thanks.

-- 
Peter Xu


