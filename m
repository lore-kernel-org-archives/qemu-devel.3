Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC46D2E9CB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 09:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAQlx-0007Pz-Ll; Mon, 11 Nov 2024 04:31:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAQhX-00074w-30
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:27:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tAQhU-00085M-SY
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 04:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731317230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DVOLscebF/60jOdVIgEQVgGRvakWQ+VSvmmAln0Jvqg=;
 b=QXzrmQ3bsWaTYE+11y/y7ef30xl2FsPHhTduDXJuB4vIOV3sMGH/+bfMJSR3K5YGXQB3Ui
 BUPACifH+uIeyGu8YyRhb9zsE3fVEndjiVPfq0JpptFK9ckiHzHyBmsoPozS894g47X81U
 M4FrNNbSYd1kPuTx/A3dKZjxqSz39ho=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-It-pIdTDN3Kl4xo5WWeOLA-1; Mon, 11 Nov 2024 04:27:05 -0500
X-MC-Unique: It-pIdTDN3Kl4xo5WWeOLA-1
X-Mimecast-MFC-AGG-ID: It-pIdTDN3Kl4xo5WWeOLA
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d531a19a9so2431408f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 01:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731317224; x=1731922024;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=DVOLscebF/60jOdVIgEQVgGRvakWQ+VSvmmAln0Jvqg=;
 b=a5PdgzYge6uTVjcOjTUM2HBnrPhUJbwolqJV7wdWAo9Xo1A6fkhf12fKtmiBxLaZGh
 gBTP/z0TTmEJY+BZYIKRuhVdN/wUvIRvz7NiZjyYxR+IsGj+DBiq42tWXwtuwjCSL7Ai
 vT78fkyKYVqTnPW5/XClbG71CLuZ6em0yaxk8e2cZcgPOlEKxAn9Cne2CiI8hcQkZsAp
 nu1rjEAL9rEfa3WW8gpRrqTyLZpfTM4syv5JlNoVJdCpnD67ofc/ZAPrg3+J2fXjBtIt
 Ll6B+hpo0ajfr/k1a3ap9+0FoXlkr7bHpAo+X5yBp3y26p6NHL5VfMOZQ+Cd9GD5edqB
 VspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEIFMUDxbtr5FKy6RMdTGNvGfNISLtUqLopUlq9BT7sNb3N0Iudd/n67ENKb/7dRuWkRKX2MJGo2Fy@nongnu.org
X-Gm-Message-State: AOJu0Ywx8Hvk9mdLMTplLPK55Y8+en+k8h0J8zfmXDbKq5/anTbETTkh
 besiNu0J/qTBPzi56jjF8T0Bq5ITDJzwwU/kXO+is/2fb1VT4mYOr8kGD0Bz7Qg8e4PboHlL8ko
 Z2MbrwMHTu6Jks5v6a8Ykun//qUSpmgGlY1TQp2aQgDoh32p2bti4
X-Received: by 2002:a05:6000:4816:b0:37c:c9ae:23fb with SMTP id
 ffacd0b85a97d-381f183f82cmr10050825f8f.40.1731317223978; 
 Mon, 11 Nov 2024 01:27:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqcUYrgwuFCafZj0SxchK73ieQvzapqEjmJ70OFOdZQCus8o6QSf0YtV7uIivmPDOFqGCXvA==
X-Received: by 2002:a05:6000:4816:b0:37c:c9ae:23fb with SMTP id
 ffacd0b85a97d-381f183f82cmr10050808f8f.40.1731317223627; 
 Mon, 11 Nov 2024 01:27:03 -0800 (PST)
Received: from ?IPV6:2003:cb:c730:4300:18eb:6c63:a196:d3a2?
 (p200300cbc730430018eb6c63a196d3a2.dip0.t-ipconnect.de.
 [2003:cb:c730:4300:18eb:6c63:a196:d3a2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed97cd97sm12347223f8f.27.2024.11.11.01.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 01:27:02 -0800 (PST)
Message-ID: <b2e42ed6-d514-46c9-993c-e7ae6384592f@redhat.com>
Date: Mon, 11 Nov 2024 10:27:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] migration: Do not perform RAMBlock dirty sync
 during the first iteration
To: Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Wei Wang <wei.w.wang@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
References: <cover.1731128180.git.yong.huang@smartx.com>
 <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <c25abae360ac204321acc5010a745a8e594f24bd.1731128180.git.yong.huang@smartx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 09.11.24 05:59, Hyman Huang wrote:
> The first iteration's RAMBlock dirty sync can be omitted because QEMU
> always initializes the RAMBlock's bmap to all 1s by default.
> 
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> ---
>   migration/cpu-throttle.c |  2 +-
>   migration/ram.c          | 11 ++++++++---
>   2 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
> index 5179019e33..674dc2004e 100644
> --- a/migration/cpu-throttle.c
> +++ b/migration/cpu-throttle.c
> @@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
>        * effect on guest performance, therefore omit it to avoid
>        * paying extra for the sync penalty.
>        */
> -    if (sync_cnt <= 1) {
> +    if (!sync_cnt) {
>           goto end;
>       }
>   
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..571dba10b7 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
>   {
>       MigrationState *ms = migrate_get_current();
>       RAMBlock *block;
> -    unsigned long pages;
> +    unsigned long pages, clear_bmap_pages;
>       uint8_t shift;
>   
>       /* Skip setting bitmap if there is no RAM */
> @@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
>   
>           RAMBLOCK_FOREACH_NOT_IGNORED(block) {
>               pages = block->max_length >> TARGET_PAGE_BITS;
> +            clear_bmap_pages = clear_bmap_size(pages, shift);
>               /*
>                * The initial dirty bitmap for migration must be set with all
>                * ones to make sure we'll migrate every guest RAM page to
> @@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
>                   block->file_bmap = bitmap_new(pages);
>               }
>               block->clear_bmap_shift = shift;
> -            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
> +            block->clear_bmap = bitmap_new(clear_bmap_pages);
> +            /*
> +             * Set clear_bmap to 1 unconditionally, as we always set bmap
> +             * to all 1s by default.
> +             */
> +            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
>           }
>       }
>   }
> @@ -2783,7 +2789,6 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
>               if (!ret) {
>                   goto out_unlock;
>               }
> -            migration_bitmap_sync_precopy(false);
>           }
>       }
>   out_unlock:


For virtio-mem, we rely on the migration_bitmap_clear_discarded_pages() 
call to clear all bits that correspond to unplugged memory ranges.

If we ommit the sync, we can likely have bits of unplugged ranges still 
set to "1", meaning we would try migrate them later, although we shouldn't?

Or is that handled differently?

-- 
Cheers,

David / dhildenb


