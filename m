Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9760C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 15:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxqLZ-0004vK-Km; Fri, 19 Apr 2024 11:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxqLX-0004v2-3t
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:40:15 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxqLV-00063v-05
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 11:40:14 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-571e3f84196so3909a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 08:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713541210; x=1714146010; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WTdCviGZ9qHem6s3wrKSV2QtNAZIjVwEKrNnz+ytkqw=;
 b=F0cH8w2ZKXPGeZSq/xQ/Si1z4i7jp2n+ZAIS5AtFoGh3UjRhAhyfeg1HOifDOZMyes
 xekcpJkN4fBYxWBeQPL62w+WeJ9HLR6J2n5E+TNXv+0S6fen2ZVghSM6sxiaiBEob0uK
 6gBwlDweuIpt46cwaNSaZDzdRH7988+KL8Ld+rDKtfBAjn/EXQ7yeKZQTco7/LMPiYIR
 wex4MsWTwHGFfKQBb9QS2wpsYBS5KV9nwSOD0RR2lVJ7ehvwUoIk4ds5wglalQyQFckO
 44FoxUCZowa4jJv+4GH9IZu+Kw2iPHwW4U+poQJPD8cC1qYNjreM2K2yxljf2xbzW9A+
 1rjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713541210; x=1714146010;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WTdCviGZ9qHem6s3wrKSV2QtNAZIjVwEKrNnz+ytkqw=;
 b=HfS+Gm4O8cS7zX590feGF2cEVSOJcHyWUc0c6GDOmmTrJsYJrOPJdeW7ZUKJ0sTApI
 xTTSTMOUyZaTwNykCIZfQb0lRg4jqUPynFRixz0ab2M9rZ5UdJKNLuUkqBvD6YtfHjHR
 RinA3AuaruJV/JwOAILUD1Tu2dhCFOv/8dx2kPRr+ZrNbMVuHR31RwSC34yrueh/XqQ3
 ot7hdJVSpuSDX/lJ5utESNrxQHjYC+BsV9rRQWvSZA8NTjk2Behuwt6vXqE9m/ZdmLWc
 H9Jn/d2R6oZV2nnTednSYXS2CS3Dtq8SPQKN+AqlxjwCNMvbC23baWWWT45vqSOdb04Z
 gZjw==
X-Gm-Message-State: AOJu0Yzy0xrImjaFjeZZl+WfuE13Jun3Ye3MB3XkHhWhcVjLt+CgE6vZ
 iPg3ZkRKNdY3M8up8Xucc3/TcicMmdI7ky1sEY5vDejrQfzt+PuQHwj1PF8+OqM=
X-Google-Smtp-Source: AGHT+IECQY/OIXi/enPj97SN60GdfFSdJGck6jFsMNaIzhUqGsiRffsS3Muyyt3hB9v/KfFjJpmGDQ==
X-Received: by 2002:aa7:df07:0:b0:571:bbad:32b7 with SMTP id
 c7-20020aa7df07000000b00571bbad32b7mr5166450edy.4.1713541210174; 
 Fri, 19 Apr 2024 08:40:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.199.54])
 by smtp.gmail.com with ESMTPSA id
 15-20020a0564021f4f00b00571d74c6074sm629514edz.46.2024.04.19.08.40.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 08:40:09 -0700 (PDT)
Message-ID: <75fff51d-3786-40fa-bf2f-bae99afe5628@linaro.org>
Date: Fri, 19 Apr 2024 17:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return
 boolean
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
References: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240418100433.1085447-1-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52d.google.com
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

On 18/4/24 12:04, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>


> ---
> Zhao Liu (3):
>    hw/cxl/cxl-cdat: Make ct3_load_cdat() return boolean
>    hw/cxl/cxl-cdat: Make ct3_build_cdat() return boolean
>    hw/cxl/cxl-cdat: Make cxl_doe_cdat_init() return boolean

Since Jonathan Ack'ed the series, I'm queuing it via my hw-misc tree.


