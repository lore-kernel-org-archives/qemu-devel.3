Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F273C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk12k-00005v-2N; Tue, 12 Mar 2024 08:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk12c-0008TM-DE
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rk12Y-0002Q4-DV
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:15:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710245726;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxrzgawp0feMCzKorBK3yil2PFefuiF+4c6lFK4CwKg=;
 b=PC8w9rneOv64fybDlE+jcQ0pcogDboAR66cxQKzFsfReBeGyS+8BCD0EX9l/s9JmSquIkB
 NgfknSHVpQ2/euLiaTEJ0jE4UJ63QZAN2W7eKWO0BryzNpqUgEhkrzCt+rEvbzKjCYtBEz
 NQzAfIvMw6lNRiVJDFgWTvqmJGXdbDk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-YifYAV8vNBet-0TiQHqZJQ-1; Tue, 12 Mar 2024 08:15:25 -0400
X-MC-Unique: YifYAV8vNBet-0TiQHqZJQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4131eaecb4aso17513575e9.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 05:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710245724; x=1710850524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cxrzgawp0feMCzKorBK3yil2PFefuiF+4c6lFK4CwKg=;
 b=F/2N+R5khsWTLaS+Fcmm0tTKSvVw9dkq5FeAb0370fJ+H9VmoHxcPGw0GangNgHEp7
 KL/ErjraQ+vMpOk4v2rDYnHGAiWn7/KEdmKadMSn8NC8As5O0Eh+Uq2LfmzbEWfXwBrA
 d0mzp45Biv0Ze5bKPCcIsxGNSCkxcDL/muNCahi75C94cK+xIi0QS1QLDZb3oSZEdnzj
 GKmF/LjaWEre2CZmg5V2i2ZtPZO+c2aE1C0r11oJiYy3xCHjZ1jVNX9Y03Ke0vUQyN2w
 C8wZSBjDQmBDjELEVAH7jK+cXpjCcYmZ3UPDGJGE95rQx2btLJu4fr7C1q7r1kyJdJrX
 yptw==
X-Gm-Message-State: AOJu0Yyoe2FuHZfhzvuKUDS+vYYDSMspz9XGZNblFjSQMA1DAcizXYN1
 217kjks8YOvjeex4oF1ppKF0i50RiKhnvwxCuXtYObY5/TipHWPbHilg7qRQbRlOkCigjf6V5/J
 hiEb6/a/k1CJHejha2RZo3iSD84BfHzzUDj70yYD6AfvcMY0jUfq/ZF3E4yTT6aosfg7twT11ke
 hZK2yog5490rQqqcQQTCCpsAtBOoO2Vw==
X-Received: by 2002:a05:600c:458d:b0:413:2779:8e29 with SMTP id
 r13-20020a05600c458d00b0041327798e29mr4738980wmo.19.1710245724324; 
 Tue, 12 Mar 2024 05:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAupj8zEOKKjsB35Ul3nDpZhIuKLv2ybOoRjx0yM/GUDjJzeH9Ci7G3wGBGa0KiZdSyfbuLA==
X-Received: by 2002:a05:600c:458d:b0:413:2779:8e29 with SMTP id
 r13-20020a05600c458d00b0041327798e29mr4738955wmo.19.1710245723981; 
 Tue, 12 Mar 2024 05:15:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 i6-20020adffdc6000000b0033b66c2d61esm8902190wrs.48.2024.03.12.05.15.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 05:15:23 -0700 (PDT)
Message-ID: <8cbda205-e8a4-4420-b49a-dbe7593fc341@redhat.com>
Date: Tue, 12 Mar 2024 13:15:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0] migration: Skip only empty block devices
Content-Language: en-US, fr
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
References: <20240312120431.550054-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240312120431.550054-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 3/12/24 13:04, Cédric Le Goater wrote:
> The block .save_setup() handler calls a helper routine
> init_blk_migration() which builds a list of block devices to take into
> account for migration. When one device is found to be empty (sectors
> == 0), the loop exits and all the remaining devices are ignored. This
> is a regression introduced when bdrv_iterate() was removed.
> 
> Change that by skipping only empty devices.
> 
> Cc: Markus Armbruster <armbru@redhat.com>
> Suggested: Kevin Wolf <kwolf@redhat.com>

That's better :

Suggested-by: Kevin Wolf <kwolf@redhat.com>

Sorry for the noise,

C.


> Fixes: fea68bb6e9fa ("block: Eliminate bdrv_iterate(), use bdrv_next()")
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   migration/block.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/block.c b/migration/block.c
> index 8c6ebafacc1ffe930d1d4f19d968817b14852c69..2b9054889ad2ba739828594c50cf047703757e96 100644
> --- a/migration/block.c
> +++ b/migration/block.c
> @@ -402,7 +402,10 @@ static int init_blk_migration(QEMUFile *f)
>           }
>   
>           sectors = bdrv_nb_sectors(bs);
> -        if (sectors <= 0) {
> +        if (sectors == 0) {
> +            continue;
> +        }
> +        if (sectors < 0) {
>               ret = sectors;
>               bdrv_next_cleanup(&it);
>               goto out;


