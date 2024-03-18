Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A190EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFXN-0003wX-4k; Mon, 18 Mar 2024 12:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFXJ-0003w8-Ev
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:08:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rmFXD-0003OE-No
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710778099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0wWW+yjNDlBuzCBt+KcVbR9vBqgaHLh42EyPLykTZs=;
 b=C/s9zPvu8C6ZxTY1fWVubQjYs2cNs/xltG8SWgp3OqFIDk7susGcDF2lc6qbgNX0aWvqsx
 96yDRrCGI/6u2pR0N2oqv8ZQZRnq2VyLqI+Zy1SJFqT/y+XyeVUq0lh0BlDkwHTOk6GMDD
 crlKy08b1bcyHKwpUeQAZ59NKdSASNU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-MVLnRJ8HPXOgEp-YHf4gRA-1; Mon, 18 Mar 2024 12:08:17 -0400
X-MC-Unique: MVLnRJ8HPXOgEp-YHf4gRA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-513ec050f5cso859441e87.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710778096; x=1711382896;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m0wWW+yjNDlBuzCBt+KcVbR9vBqgaHLh42EyPLykTZs=;
 b=G7rjTGuIUW5YIN+QdaJvFeKXxocjXZ9kOBkXcYownuaXWMTMGMCa+uFRDeR2iM/McV
 DdDbs+lEkR9GO/lCvzU2Ggws0zvLZz5AdcbdxZV+eFRb6XCbiPu6TDniELL4hBEyVFgO
 ZC+EoovPN/JeQQNoti1dVfnvQZBI+2AHQKGisPXtyxEZTyKP3abkwv9gbnUwdS9qM5kD
 yta4WlegGBhmI4N2nE2p0n7c41ufMdFKgJA8rD+IhjCVPygtS0tL21lS4iTBJjgpflHW
 w9Wdrzd6Py7Ynl6cuEtU5YYjItL3P9rioL6nm6vTozaSHYLCtAOH+cGUd8AZSlDaCWwP
 QJ/w==
X-Gm-Message-State: AOJu0YxE4SDtT3RYc70EkIBqn0afmk8qeOqgAWy9kKKUWPbUlNWjLEXF
 6GoLNPJviPL61J9M/pG5mg4AgPsWAUwX9BXxqG9SUOBvKFesOQneVLKXZlkB1PF3G8O2FIUIZ6h
 +e5el2tADW5Gl488BblG/8ydGsNXnjcXOEOn6OC13nubpB9me7zHK
X-Received: by 2002:ac2:4c9c:0:b0:513:8a39:e0d9 with SMTP id
 d28-20020ac24c9c000000b005138a39e0d9mr9107840lfl.64.1710778096436; 
 Mon, 18 Mar 2024 09:08:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdB8t0YlEWTLUo2AIVqsrZAowYehCmPEYhKb7tG64RkJI8e+hI/NbDUt98MQ+Kuy8roiyRoQ==
X-Received: by 2002:ac2:4c9c:0:b0:513:8a39:e0d9 with SMTP id
 d28-20020ac24c9c000000b005138a39e0d9mr9107827lfl.64.1710778096100; 
 Mon, 18 Mar 2024 09:08:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a5d42d2000000b0033e456f6e7csm10243571wrr.1.2024.03.18.09.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:08:15 -0700 (PDT)
Message-ID: <47b36520-4198-40c1-92e2-e768f14b8cd4@redhat.com>
Date: Mon, 18 Mar 2024 17:08:13 +0100
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
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

btw, should we use bitmap_try_new() to create the bitmaps instead of
bitmap_new() which can abort() ?


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


C.


