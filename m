Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15D7D2C551
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 13:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3Esn-0002sp-1f; Tue, 22 Oct 2024 09:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3Esl-0002rE-7Z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3Esi-00072w-Hk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 09:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729603500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8fHD9mzkuuWpT7HIHmCVsjy9glVTUQWcvyIraoDIVrs=;
 b=MEM00pRlEzy4JkIwNefyVtat0cpLZf8IoQbsVy9xmsZp8qo48DPwybmqhAlzqvWwp/6mNk
 CpD5FdWgXJZGmB+pN7qqIdHbwIaT8jXp/uU0msYiMqQzlXbSFpLWByfJmw1IIuNJ6eQAPC
 G+rxlbldro6fxQpk+obe81UfzaW7Leo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-bF55bLtTPJOkutFEydtKGQ-1; Tue, 22 Oct 2024 09:24:59 -0400
X-MC-Unique: bF55bLtTPJOkutFEydtKGQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4315c1b5befso41013305e9.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 06:24:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729603498; x=1730208298;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8fHD9mzkuuWpT7HIHmCVsjy9glVTUQWcvyIraoDIVrs=;
 b=pAC6MuTS4MHHZ8z4WN0gLNy9uJCk6ZyiOENUhws0/kF9eFW0DYpcEtZjhakFxrcPOg
 luZEIbe2ZWqN1Mg7mevDbocBN5HVg/Ua2Cg6+wNvyzWi/3db0/ryJ9HwfYTS1UxF3Zq8
 cUqlBLjndj8cgpyxavTrMwlvBOfLasQhmPGE9Tes0Q+OvwGL5mzefxfMA7n6e6ejf9m9
 eWWQA2vfc2DokcVWpgU3VVjSjjpx3Le2wg+mf7otOitifnVAzd9nlZVp4e9xVkFbYYhy
 c8Y0onwOAJmJNVFjb5dmQhfv15oqNDTX38vZPFDJI8IT2i6MvH0eyZA2RLtKajwTXDJj
 KZ0Q==
X-Gm-Message-State: AOJu0YxeB45z9m0xnWHLWi8dcwfBMZ5XYLMpaGSGRhMHgDxR1mh2TSdg
 ZDC2aIrQD/y4MQQgA6Jyv2dcQTBbxRks+ekR6tYJyeH227tIBhDFaX+LlVkor3yggbItPD/gua5
 95zzLQqoEZiPIbrDvCgV1sWCX/pRk90N/yyPN9X8q361sKxpPZQ0b
X-Received: by 2002:a05:600c:3b1d:b0:431:6052:48c3 with SMTP id
 5b1f17b1804b1-4316163a2b4mr141256175e9.16.1729603497853; 
 Tue, 22 Oct 2024 06:24:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUQKUTnwJafNxqCn+eqj12xFr4vOvezL7HlSjA5xTTssC5OlZmFYUcdxsOYdE5kG3JIIB/zg==
X-Received: by 2002:a05:600c:3b1d:b0:431:6052:48c3 with SMTP id
 5b1f17b1804b1-4316163a2b4mr141255935e9.16.1729603497396; 
 Tue, 22 Oct 2024 06:24:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0a57e0fsm6632233f8f.47.2024.10.22.06.24.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 06:24:56 -0700 (PDT)
Message-ID: <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com>
Date: Tue, 22 Oct 2024 15:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
To: Avihai Horon <avihaih@nvidia.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com> <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com> <ZxaHPo7GRPuby5ky@x1n>
 <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/22/24 11:38, Avihai Horon wrote:
> 
> On 21/10/2024 19:54, Peter Xu wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
>>> Hello,
>>>
>>>> IIUC the migration thread should always see valid migration object, as it
>>>> takes one refcount at the entrance of migration_thread():
>>>>
>>>>       object_ref(OBJECT(s));
>>> Could the migration have failed before ? in migrate_fd_connect()
>> I just noticed it's a vm state change notifier..
> 
> Yep.
> I stumbled upon this bug by accident when running on a buggy machine.
> Migration wasn't involved, I just started the VM, shut it down and got the assert (as my VFIO device was faulty and errored on RUNNING->STOP state change).
> 
> You can repro it by forcefully triggering an error on *->STOP transition:
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 17199b73ae..d41cb7c634 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -831,7 +831,9 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>       }
> 
>       ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
> -    if (ret) {
> +    if (ret || new_state == VFIO_DEVICE_STATE_STOP) {
> +        ret = -1;
> +        error_setg(&local_err, "%s: forced error", vbasedev->name);
>           /*
>            * Migration should be aborted in this case, but vm_state_notify()
>            * currently does not support reporting failures.
> 
>>
>> If so, maybe VFIO could refer to its internal states showing that it's
>> during a migration first (so as to guarantee the migration object is valid;
>> e.g., only after save_setup() but before save_cleanup() hooks are invoked).
> 
> It's an option, but I think it's a bit awkward as we'd need to check that VFIOMigration->data_buffer is set 

That's what I was looking at too. It works. It feels a bit awkward
indeed. We could hide the details in an helper routine though.

> or add a new flag.

yes that's another solution.

Peter,

I wonder if we could grab a ref on current_migration in save_setup(),
store it under VFIOMigration and drop it save_cleanup() ?


> Besides that, as Cedric pointed out, VFIO code calls migration_is_setup_or_active() which can also be unsafe, as it might be invoked after migration object has been freed.
> 
> Maybe a simpler solution would be to extend the the migration object lifetime?
> Looking at commit history, you can see that commit 1f8956041ad3 ("migration: finalize current_migration object") added migration object finalization at the very end of qemu cleanup.
> Then came commit 892ae715b6bc ("migration: Cleanup during exit") and moved the migration object finalization to the beginning of qemu cleanup (before stopping the VM etc.).
> 
> If so, the fix could be something like the below?
> 
> -------------8<-------------
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index bfadc5613b..5eb099349a 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -52,6 +52,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
> 
>   /* migration/migration.c */
>   void migration_object_init(void);
> +void migration_object_finalize(void);
>   void migration_shutdown(void);
>   bool migration_is_idle(void);
>   bool migration_is_active(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 021faee2f3..9eaa7947bc 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -265,6 +265,11 @@ void migration_object_init(void)
>       dirty_bitmap_mig_init();
>   }
> 
> +void migration_object_finalize(void)
> +{
> +    object_unref(OBJECT(current_migration));
> +}
> +
>   typedef struct {
>       QEMUBH *bh;
>       QEMUBHFunc *cb;
> @@ -330,7 +335,6 @@ void migration_shutdown(void)
>        * stop the migration using this structure
>        */
>       migration_cancel(NULL);
> -    object_unref(OBJECT(current_migration));
> 
>       /*
>        * Cancel outgoing migration of dirty bitmaps. It should
> diff --git a/system/runstate.c b/system/runstate.c
> index c2c9afa905..fa823f5e72 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -930,5 +930,6 @@ void qemu_cleanup(int status)
>       monitor_cleanup();
>       qemu_chr_cleanup();
>       user_creatable_cleanup();
> +    migration_object_finalize();
>       /* TODO: unref root container, check all devices are ok */
>   }
> -------------8<-------------

892ae715b6bc was trying to fix potential use-after-free issues.

I think it is safer to introduce an helper routine checking
(in some ways) if a migration is in progress than partially
revert 892ae715b6bc.

Thanks,

C.


