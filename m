Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE105C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmATS-0005Qs-MX; Mon, 18 Mar 2024 06:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmATR-0005QR-5Q
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:44:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmATP-00041x-G2
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710758645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5iXP/gpd9L7ldbls55N2RB3/MiQOlb1DMl3GAVzVgqE=;
 b=c5dTM1Z9zKmUxYTp/nSWLztbCRecniI3Mk6q6XGsthWO838PhXAni8q2Ukk3vtWsKE7ji8
 7Rl/YiFO9By+0P9RSK+EEcMBycTArGPwO82LrpxIjr6sh6UL/uPhFQIYkVjy+wE44ctfOc
 zCY0rbPChPEB1loogDH9StDSpBKzqdw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-A6cd1vdIMSu6Tv_THv2jTQ-1; Mon, 18 Mar 2024 06:44:03 -0400
X-MC-Unique: A6cd1vdIMSu6Tv_THv2jTQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41401eef944so14271625e9.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:44:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710758642; x=1711363442;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5iXP/gpd9L7ldbls55N2RB3/MiQOlb1DMl3GAVzVgqE=;
 b=qg/CWRQeXmgD2J1v9zsqeGNiyIz3lwcO7uADhNTbyp45oxYs9ECv1uG36aDViGg0KQ
 VR8uY/f90j0qNo33X2jYW9vMRRgAsEiaFMbF/7W/BAYh1wOewWhxjQJx04MDzuqHW2DW
 DEk3wyvAaKEBPPMNGLR0bouuXeWQ+zq26aXn6tGviV7d7ncnSYTTsRyCVEr85hJWlWy8
 BU9bh7Q+xq3qRZshS8l2Z1jJZkkKbbP12fBVh3b4MRaNKFI52oTyLt/qfuanMPkMRdkd
 +aWDWhNOWkgV8KHlP4IFKDKawHcfPFgIR2cz5gccmeIC2BtLhRM9Is1PwEJrHJ8FQQIn
 lSCg==
X-Gm-Message-State: AOJu0YxfYcLC1tSQwUYgzrhe8btW4dueP0GMKe3iB7Ag21aZfoY+iRvV
 48yK/JsEiBRQuPM1sGX+67lHBUXdPMNdEEKdcVzVwRYBJe3PJA9/UVYZT72RwWoxlhXtVIsQv/e
 p590sIMxqk+SN8bEezCchQZIU2PV1hOf/tGfycGRjuOH53+G4vazl
X-Received: by 2002:a05:6000:d04:b0:33d:8c86:e859 with SMTP id
 dt4-20020a0560000d0400b0033d8c86e859mr7219054wrb.60.1710758642084; 
 Mon, 18 Mar 2024 03:44:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0BMOQx76yKKbQiHv6l4zyUKXb7eVrj1uzc+4KODM/s9LDVeq77Nvb+wyzeXMBKA91iYRTsw==
X-Received: by 2002:a05:6000:d04:b0:33d:8c86:e859 with SMTP id
 dt4-20020a0560000d0400b0033d8c86e859mr7219042wrb.60.1710758641745; 
 Mon, 18 Mar 2024 03:44:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m14-20020adfe94e000000b0033cf60e268fsm9434976wrn.116.2024.03.18.03.44.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 03:44:01 -0700 (PDT)
Message-ID: <df906e4d-24d3-47db-b1fe-a429907b2f20@redhat.com>
Date: Mon, 18 Mar 2024 11:43:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/25] memory: Add Error** argument to the
 global_dirty_log routines
Content-Language: en-US, fr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Hyman Huang <yong.huang@smartx.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-15-clg@redhat.com> <ZfQyRu7nt6M6uzTJ@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZfQyRu7nt6M6uzTJ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.316,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2836,18 +2836,31 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>>   
>>   static void ram_init_bitmaps(RAMState *rs)
>>   {
>> +    Error *local_err = NULL;
>> +    bool ret = true;
>> +
>>       qemu_mutex_lock_ramlist();
>>   
>>       WITH_RCU_READ_LOCK_GUARD() {
>>           ram_list_init_bitmaps();
>>           /* We don't use dirty log with background snapshots */
>>           if (!migrate_background_snapshot()) {
>> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION);
>> +            ret = memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION,
>> +                                                &local_err);
>> +            if (!ret) {
>> +                error_report_err(local_err);
>> +                goto out_unlock;
> 
> Here we may need to free the bitmaps created in ram_list_init_bitmaps().
> 
> We can have a helper ram_bitmaps_destroy() for that.
> 
> One thing be careful is the new file_bmap can be created but missing in the
> ram_save_cleanup(), it's because it's freed earlier.  IMHO if we will have
> a new ram_bitmaps_destroy() we can unconditionally free file_bmap there
> too, as if it's freed early g_free() is noop.

OK. Let's do that in a new prereq patch. I will change ram_state_init()
and xbzrle_init() to take an Error ** argument while at it.


Thanks,

C.



