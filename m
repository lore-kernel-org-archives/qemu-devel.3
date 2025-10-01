Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04DFFCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:43:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3sPW-0004Se-2U; Wed, 01 Oct 2025 04:42:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3sPN-0004Ro-N1
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:41:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3sPB-0007U3-UX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:41:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759308099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OoxPbfNPOVDhTmTUjEeR9wPvseI20Xeikoc5bFV+ZYg=;
 b=FB79tHokiUFQfUaj6WQBtTC1xgpiagv32dBIZh1eIH+QCM9Obx4IG3CTKITLNB4NxaP3hg
 /wJOSMjqmF/jR8I7JiG9y/Zy132bn86wQRZumX/gQEcWnLOciq+fbyB2VASPGlhyktTEUo
 Q5OmiQFOeqyyU6naMnsRB5hIHITqg4o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-oN5VdGdgOma-zQnTfiFjRQ-1; Wed, 01 Oct 2025 04:41:38 -0400
X-MC-Unique: oN5VdGdgOma-zQnTfiFjRQ-1
X-Mimecast-MFC-AGG-ID: oN5VdGdgOma-zQnTfiFjRQ_1759308097
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-46e502a37cdso20272825e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759308097; x=1759912897;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OoxPbfNPOVDhTmTUjEeR9wPvseI20Xeikoc5bFV+ZYg=;
 b=WB6OnrqHi09F42IPv5tOIWp3g1FEe40XTGyOmnmt654Nt8mk25wOWA5LkuWEaXeUUE
 yyc7MGuo384ox8iNGGLLS2BNBaohtQ4/eD0uPRafpwNUzwZwfUJwDA/vV9FF8BUiEKOH
 zRpwwQEUWnB5EGtaVW2jNS4wsqiuO+mU7r9KOyGK56t2EYn5x6Jgacuu0j05/ATNQscT
 veiOUrrz72tBQkF2tk5UheITZSghmK5PRL3nyvZ5lN+3oY5nXZe0SdffUvHcmkU0RhRa
 NzU/GNK74mt8rH5F/YeI/hzlqByCKoO/Wq7mvVc0rUjeaG09r5pnQzglWI7dzOq5a7ot
 idVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5nFinaIXZbzrKRmDyXz+nVhF+BNQaf4bsXaPYI9/Injuz8X1ehNMKQYV4dW4iKnH7yd9o2xonGHYr@nongnu.org
X-Gm-Message-State: AOJu0Yz3bxM9alpZhoe9kdLQp/Mp499jLgn6El9S8SdFOgdENzP87NJ+
 GRbgIRejCl4Naai3mYhWyg/0C3jMzPxZuh1th1MGaOl1EuCfpul04tf8p7RvXSV2YgvV349Js0X
 aoQIn8EW5O+uKxrJ0do0gQOojw0FB81oYQfMyhzpP9lDLno1mkOrdhSv9
X-Gm-Gg: ASbGncvFxqysR74nOqmh7xb1ySsaTIcXc7/ABSFTnSRG52TM7v4u154ez8wv2AFwjhb
 H+CwdX8rLYMwszbram4p445AQNEdjxFHyXJTgZFZy3Q4qgkbwopFAwVJbo8wpYccBAr39p37DM4
 ZI3aI6dLPRhLZNtjbwDGnKhOZWMup8DmqMcjvVmCNjYCrStG9IakWDzFcN/6og8QkrLYaWCbLe5
 dAPgQB0qpkZb98TDe2vBx7VStMjkozGUowFqsMu3aOOrPFI+t3pCdBCqgHok+ww8M/03Ke2e2P4
 wm8iO+5XdZ+e4Oira1jGoZJmUILkhxlHMTt2IfPnJqJ29zlAde8nhm+C93NQNYDJ3wd3Tnk=
X-Received: by 2002:a05:600c:4e52:b0:45b:7b00:c129 with SMTP id
 5b1f17b1804b1-46e612e6f9fmr20481965e9.35.1759308097329; 
 Wed, 01 Oct 2025 01:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8QJAuvtlCsccWP6Z3nHhGp8ri9bfmSgiuHkBCRTAQ5VY/+kdMyl+7997vo9nNzkJh4eB3wg==
X-Received: by 2002:a05:600c:4e52:b0:45b:7b00:c129 with SMTP id
 5b1f17b1804b1-46e612e6f9fmr20481615e9.35.1759308096925; 
 Wed, 01 Oct 2025 01:41:36 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602eccsm27512661f8f.40.2025.10.01.01.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 01:41:36 -0700 (PDT)
Message-ID: <07c0b947-8a17-4efb-a0e8-0f17ab70021a@redhat.com>
Date: Wed, 1 Oct 2025 10:41:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/25] system/ram_addr: Remove unnecessary
 'exec/cpu-common.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin
 <npiggin@gmail.com>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 qemu-arm@nongnu.org, Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, kvm@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
References: <20251001082127.65741-1-philmd@linaro.org>
 <20251001082127.65741-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251001082127.65741-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 01/10/2025 10.21, Philippe Mathieu-Daudé wrote:
> Nothing in "system/ram_addr.h" requires definitions fromi

s/fromi/from/

> "exec/cpu-common.h", remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/ram_addr.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
> index 6b528338efc..f74a0ecee56 100644
> --- a/include/system/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -29,7 +29,6 @@
>   #include "qemu/rcu.h"
>   
>   #include "exec/hwaddr.h"
> -#include "exec/cpu-common.h"
>   
>   extern uint64_t total_dirty_pages;

With the typo fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


