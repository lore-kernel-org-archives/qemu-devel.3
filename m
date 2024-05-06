Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB710C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 09:57:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3v5X-0004wu-Dj; Mon, 06 May 2024 05:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v5T-0004wC-B5
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:56:48 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s3v5Q-0000Cl-TS
 for qemu-devel@nongnu.org; Mon, 06 May 2024 05:56:47 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so11565985e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714989403; x=1715594203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2OtRlS9dnyJBli43HIli/2qfBfNu58F4VWyD11DfUE=;
 b=PZ50ZaE9K42SBNgxpd7F51qBR4YOkcXbU/3Qs3fY+bCNmWiBQHQMVxpmjaiSKeVKA0
 uVJeZKxBNznIA8njg+WsfiaZKHlVtkeKx0nBkAcKCl9OGSGAPiN7AxKjwmVcyQcUTOGS
 ZFiQ0kNQpwTOIfDcy4V4EvZVWukQfmtATy+IuV4I3REWFBkDNXWYgITTTpotQxUcE3lP
 T1PmCjmqZ+JiKyPbnA5C/K/SXuWerQV23OzrTjiRe3pzQL9vzIAYiKGicmDgOW3GQfDS
 o4yrR4Sjmwjx86cgkcFObJHw0yVdqLtGjOiFWzBeRqIWN37tMBv6+KzSdDVMrVny/wFO
 zGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714989403; x=1715594203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s2OtRlS9dnyJBli43HIli/2qfBfNu58F4VWyD11DfUE=;
 b=pZarfBAgfnUollXDHS/0bTEKaGgHe1RdpSjiiGXanp2HCriHZ6aVlugxDTCUyT+q8J
 IK6e+ETmYSbKZlD58aLL6M8QESvpv3XE4U4LppOtARBnVsupwZZCo7RjR4pEenwbhusS
 CvhPZD0M6u9xiD3kux6aYa6YMu6mpDJyX4t44OSgclaFi+v6reGeKp/knSg+MJyRXRIy
 X/LI3jXwTunLQxstlBCe5do/ZRsoLPyTLi2mTKj4l5H0AZ2/0T5dCWMHPfuIoLsfezIz
 jGrv21Ig7PVNrxZAPS6Zs5tHtAi2TZyTx81e9LfraaWxLwRNbeUdEiuxeqeeIupeRG5e
 3yGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVB/zfbAD8488TIfrkey4uTzVioMID/9Vif4HUez+aWeN9kkzGgG+o/nPLdrZYyHXZsapWXSr6rLsFBuSmmmE+992o9qZ8=
X-Gm-Message-State: AOJu0YwRLbo8z94+YdhTXHAx9Zb2CxA508d7bQj6Xm1RQEIJTzZ+5zho
 0RXOf5D0ZdaLkmmyZKEtAprFi1Uj5vmTq8lFlh1vmpJIeGBPKpqfAxtG6iNSZ6Q=
X-Google-Smtp-Source: AGHT+IEpGXuliabLS0yW1g8DkYrIw9Px9sWJY4J0BCzBVjcaQz/xa9RWsgkxol5KxbdMskmUDHBnXQ==
X-Received: by 2002:a5d:6dcc:0:b0:34c:f507:84b6 with SMTP id
 d12-20020a5d6dcc000000b0034cf50784b6mr7858286wrz.41.1714989403409; 
 Mon, 06 May 2024 02:56:43 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.4])
 by smtp.gmail.com with ESMTPSA id
 n10-20020a5d67ca000000b0034dcc70929dsm10241487wrw.83.2024.05.06.02.56.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 02:56:42 -0700 (PDT)
Message-ID: <47bd7984-39b9-44af-964c-d04620cb6e7e@linaro.org>
Date: Mon, 6 May 2024 11:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/17] softmmu: Pass RAM MemoryRegion and is_write
 xen_map_cache()
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, jgross@suse.com,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, xen-devel@lists.xenproject.org
References: <20240430164939.925307-1-edgar.iglesias@gmail.com>
 <20240430164939.925307-14-edgar.iglesias@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430164939.925307-14-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/4/24 18:49, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
> 
> Propagate MR and is_write to xen_map_cache().
> This is in preparation for adding support for grant mappings.
> 
> No functional change.
> 
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
> ---
>   hw/xen/xen-mapcache.c         | 10 ++++++----
>   include/sysemu/xen-mapcache.h | 11 +++++++----
>   system/physmem.c              | 31 +++++++++++++++++++++++--------
>   3 files changed, 36 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


