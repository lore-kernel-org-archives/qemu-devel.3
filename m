Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 712C4C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 13:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdVnt-0004jt-Hx; Fri, 23 Feb 2024 08:41:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdUTV-0008Jk-Qa
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:16:21 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wj28.lee@gmail.com>)
 id 1rdUTO-0006EH-L1
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 07:16:21 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dc1ff3ba1aso5603055ad.3
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 04:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708690572; x=1709295372; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=liGPk6TzyipF2EkGC5C5VT5uk5qnMjBqkU56Aj0oaVE=;
 b=TRVM3a076gaCe2AIB75bHoZ6708gdmSP0qn/tWyMfp38xbTu2AHlrHuvEi7wEfoou3
 xuC3srrxT7u2j7lHYT6FsGoGPdZbWT1nXvKBp1xXkFeNhCYGmh9zA2jXuXCLqY3tzP5p
 A4lNuF0st04Pro/TNCAL7NY2WKTlIE4rXlAKVca21+OiiVKvTdAgNa67jlkzVGVvrOTO
 uOy73xvDg6debeDpY9SLONjETNYSNxvy5JzXqecD9K7btXz0OxA1/eTykDef7HfYN0Ow
 Jq0z+IBvMlEsv1MlRvPvFusrhkDvvtn1wOqoKxCD6vLcoPazX1dQ4cYEqLtAILWA2+cY
 Bizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708690572; x=1709295372;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=liGPk6TzyipF2EkGC5C5VT5uk5qnMjBqkU56Aj0oaVE=;
 b=wtuk2klJPab7kkoygeBYepthXs1mDiaGoRSpMeDzC3vh709V6TdHENd26yrTjZqFrS
 UwWHTQMokdvLup5xnqEGPnR1u0hyMwkCO2iVyft2BIv7A9t8nejjzxyu+y2KOzLarVEi
 MOmY7GpXqilrgC7gvmP7DX/rlZeM8clA8FOju5gW26Gouoa5WXUaGBm/ZOh8mkL0dDQs
 WodyCNMC94zzLR4rSQoRlfRX/hKtnTtYTEBLvjLL/xtpO8PqDKqPhRZ/H0nWFuDq1HfZ
 6T8ZSGGIQTnbZ5D5ALYKR6Q0xs9zBwQWa2p6Zt83InPPDZvnc4TnTFzn2Kn4oIopsurE
 3wjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVrPiisnLXV66Ex0rLHuymKJU+GYmIF8/SD6hinuMyJeUd+uqxDLxh+PFfRl0J4ua0rTItKcWgFls5l6DGI6rIbRwABi0=
X-Gm-Message-State: AOJu0Yw3PsUcUQi7yNQue3p8l0ccCLsUhvjvHGkvz5h+qpdgLCvX4Fxo
 VqW9epYqjwNHPxmXfqNkkWe+UY6uz3qxwjCBIrIZwsZxOVf6d0em
X-Google-Smtp-Source: AGHT+IFU8YdKN/dHPvCC6fzGrj67uMLL5vUeoVjuOlk3cvj+Az3TprmEw2T/vXWIrEQQFf48CHLlgw==
X-Received: by 2002:a17:903:2307:b0:1db:f1e2:84f4 with SMTP id
 d7-20020a170903230700b001dbf1e284f4mr2041534plh.38.1708690571879; 
 Fri, 23 Feb 2024 04:16:11 -0800 (PST)
Received: from [192.168.0.9] ([121.137.152.114])
 by smtp.gmail.com with ESMTPSA id
 g18-20020a170902c99200b001db6a228c3esm11432557plc.307.2024.02.23.04.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 04:16:11 -0800 (PST)
Message-ID: <4da6524a-8a30-4872-8168-441105e8f7b5@gmail.com>
Date: Fri, 23 Feb 2024 21:16:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wonjae Lee <wj28.lee@gmail.com>
Subject: Re: [PATCH v4 09/10] hw/cxl/events: Add qmp interfaces to add/release
 dynamic capacity extents
To: nifan.cxl@gmail.com, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 gregory.price@memverge.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net, nmtadam.samsung@gmail.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-10-nifan.cxl@gmail.com>
Content-Language: en-US
In-Reply-To: <20240221182020.1086096-10-nifan.cxl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=wj28.lee@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 23 Feb 2024 08:35:47 -0500
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

On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> Since fabric manager emulation is not supported yet, the change implements
> the functions to add/release dynamic capacity extents as QMP interfaces.
> 
> Note: we skips any FM issued extent release request if the exact extent
> does not exist in the extent list of the device. We will loose the
> restriction later once we have partial release support in the kernel.
> 

[snip]

> +/* CXL r3.1 Table 8-50: Dynanic Capacity Event Record */

It needs a spell check. Dynamic.

...

> +    switch (type) {
> +    case DC_EVENT_ADD_CAPACITY:
> +        break;
> +    default:
> +        break;
> +    }

Perhaps this switch statement has become unnecessary in the revision to 
patch v4?

...

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 8cc4c72fa9..19927629c7 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json

[snip]

> +##
> +# @cxl-add-dynamic-capacity:
> +#
> +# Command to start add dynamic capacity extents flow. The device will
> +# have to ackowledged the acceptance of the extents before they are usable.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release

How about just using "add" instead of "add/release"?

...

> +##
> +# @cxl-release-dynamic-capacity:
> +#
> +# Command to start release dynamic capacity extents flow. The host will
> +# need to respond to indicate that it has released the capacity before it
> +# is made unavailable for read and write and can be re-added.
> +#
> +# @path: CXL DCD canonical QOM path
> +# @region-id: id of the region where the extent to add/release

And here. Only "release"?


Thanks,
Wonjae

