Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14646D2CDF8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:11:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HTn-0002pX-BI; Tue, 22 Oct 2024 12:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3HTl-0002op-C4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3HTj-0001qk-IK
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rnuqtBmzY0jUFOSpBzJmv3AVDTNRRqK/8V5RA0X/oUE=;
 b=VA7gGmJhgMmHl71ywDb0W5d7bP1JIJ5uQYpJJyFEIPMRFJTB2uUHnyCabiBf2biw1K9TKe
 3VX3OL4A7a5lgSZrUmU8guPAV6KQv0tnzuTzQsW10auHrLovXXaWhkFi6hw5NyBLz8LzCi
 HkpXXldJeINRCFRufkKacW2Cd9hynYY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-FIVDnmGBPcmdpTyzJP5Frg-1; Tue, 22 Oct 2024 12:11:22 -0400
X-MC-Unique: FIVDnmGBPcmdpTyzJP5Frg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4316e350d6aso21928535e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613481; x=1730218281;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rnuqtBmzY0jUFOSpBzJmv3AVDTNRRqK/8V5RA0X/oUE=;
 b=iyJT1KEiHFI+PNLizDzydm+oR579nbtRjjmU4mskmVlYK8czbe4CF8vMCTaIw+pH9g
 kmYUzFCTTJa9G76FS733dDgGlvDQh3/OuhHQc5MpMZbBlmatGzIYkkQhPzbGQ+reBYs9
 cIH9XTCQGE6QsbexzYP9AhkzLHQ+7WgfQFJ7oRlJoeTnxdXb0GCA24Xgj2eGCrdI5Tgj
 QyPz3V8+bt7KyUPJLwNgDiMRnbSuY/ufOsAwearZcp7GbG7cAZYGK8CkzXxrVHdjswua
 PjpEgoMkYAl0j603wzBzzLjVeBro3pNNnpqE0YvY8h6zHy4RghVNiKy17pAA1gYbW4FF
 /K3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV14m41JZEbHDYYWDHQwb9df3irChPIVHaKuRGNYnukcyaJqLp9azV1b9Kky6A7CdExU/aTM5Xe1hpr@nongnu.org
X-Gm-Message-State: AOJu0YzX/YXMALK9+ttq7vjs37LATsLoxApLnNyb5Yak2QLOfQiheglg
 34Dm2joH9HkQQrYvCa7NprfSRx9p8X+HRibkldqDCEhUVjpjmM3gk8gDiA+T1HThmgOuc9fogfU
 VHNWy2nr33f15opKLONoGVtKKpcqAFV6RCl7RHW8Rkg1M9GTsbMzo
X-Received: by 2002:a05:600c:c89:b0:431:5c1c:250b with SMTP id
 5b1f17b1804b1-43161633321mr133925985e9.1.1729613481039; 
 Tue, 22 Oct 2024 09:11:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU72c+Tr6S8hax98ONlXmAb5nJs8VKGk8w/Vlg2GRGiNX6rtcI5x286DInSVPYOq1lJS4BjQ==
X-Received: by 2002:a05:600c:c89:b0:431:5c1c:250b with SMTP id
 5b1f17b1804b1-43161633321mr133925745e9.1.1729613480661; 
 Tue, 22 Oct 2024 09:11:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5cc88esm91280685e9.46.2024.10.22.09.11.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 09:11:20 -0700 (PDT)
Message-ID: <519f0ed8-5346-463b-979a-a4c6f4c38a8b@redhat.com>
Date: Tue, 22 Oct 2024 18:11:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] migration: Make all helpers in misc.h safe to use
 without migration
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Dr . David Alan Gilbert" <dave@treblig.org>
References: <20241022160720.1013543-1-peterx@redhat.com>
 <20241022160720.1013543-2-peterx@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20241022160720.1013543-2-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 10/22/24 18:07, Peter Xu wrote:
> Migration object can be freed before some other device codes run, while we
> do have a bunch of migration helpers exported in migration/misc.h that
> logically can be invoked at any time of QEMU, even during destruction of a
> VM.
> 
> Make all these functions safe to be called, especially, not crashing after
> the migration object is freed.
> 
> Add a rich comment in the header explaining how to guarantee thread safe on
> using these functions, and we choose BQL because fundamentally that's how
> it's working now.  We can move to other things (e.g. RCU) whenever
> necessary in the future but it's an overkill if we have BQL anyway in
> most/all existing callers.
> 
> When at it, update some comments, e.g. migrate_announce_params() is

While ?

> exported from options.c now.
> 
> Cc: Cédric Le Goater <clg@redhat.com>
> Cc: Avihai Horon <avihaih@nvidia.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   include/migration/misc.h | 33 ++++++++++++++++++++++++++++-----
>   migration/migration.c    | 22 +++++++++++++++++++++-
>   2 files changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index bfadc5613b..8d6812b8c7 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -19,8 +19,26 @@
>   #include "qapi/qapi-types-net.h"
>   #include "migration/client-options.h"
>   
> -/* migration/ram.c */
> +/*
> + * Misc migration functions exported to be used in QEMU generic system
> + * code outside migration/.
> + *
> + * By default, BQL is required to use below functions to avoid race
> + * conditions (e.g. concurrent free of the migration object).  It's
> + * caller's responsibility to make sure it's thread safe otherwise when
> + * below helpers are used without BQL held.
> + *
> + * One example of the special case is migration_thread(), who will take a
> + * refcount of the migration object.  The refcount will make sure the
> + * migration object will not be freed concurrently when accessing through
> + * below helpers.
> + *
> + * When unsure, always take BQL first before using the helpers.
> + */
>   
> +/*
> + * migration/ram.c
> + */
>   typedef enum PrecopyNotifyReason {
>       PRECOPY_NOTIFY_SETUP = 0,
>       PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC = 1,
> @@ -43,14 +61,19 @@ void ram_mig_init(void);
>   void qemu_guest_free_page_hint(void *addr, size_t len);
>   bool migrate_ram_is_ignored(RAMBlock *block);
>   
> -/* migration/block.c */
> -
> +/*
> + * migration/options.c
> + */
>   AnnounceParameters *migrate_announce_params(void);
> -/* migration/savevm.c */
>   
> +/*
> + * migration/savevm.c
> + */
>   void dump_vmstate_json_to_file(FILE *out_fp);
>   
> -/* migration/migration.c */
> +/*
> + * migration/migration.c
> + */
>   void migration_object_init(void);
>   void migration_shutdown(void);
>   bool migration_is_idle(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index bcb735869b..27341eed50 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1121,6 +1121,10 @@ bool migration_is_setup_or_active(void)
>   {
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return false;
> +    }
> +
>       switch (s->state) {
>       case MIGRATION_STATUS_ACTIVE:
>       case MIGRATION_STATUS_POSTCOPY_ACTIVE:
> @@ -1136,7 +1140,6 @@ bool migration_is_setup_or_active(void)
>   
>       default:
>           return false;
> -
>       }
>   }
>   
> @@ -1685,6 +1688,10 @@ bool migration_is_active(void)
>   {
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return false;
> +    }
> +
>       return (s->state == MIGRATION_STATUS_ACTIVE ||
>               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>   }
> @@ -1693,6 +1700,10 @@ bool migration_is_device(void)
>   {
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return false;
> +    }
> +
>       return s->state == MIGRATION_STATUS_DEVICE;
>   }
>   
> @@ -1700,6 +1711,11 @@ bool migration_thread_is_self(void)
>   {
>       MigrationState *s = current_migration;
>   
> +    /* If no migration object, must not be the migration thread */
> +    if (!s) {
> +        return false;
> +    }
> +
>       return qemu_thread_is_self(&s->thread);
>   }
>   
> @@ -3077,6 +3093,10 @@ void migration_file_set_error(int ret, Error *err)
>   {
>       MigrationState *s = current_migration;
>   
> +    if (!s) {
> +        return;
> +    }
> +
>       WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
>           if (s->to_dst_file) {
>               qemu_file_set_error_obj(s->to_dst_file, ret, err);


