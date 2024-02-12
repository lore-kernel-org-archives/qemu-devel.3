Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9A2C4829C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:37:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZZJ6-0004bl-55; Mon, 12 Feb 2024 11:37:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rZZJ3-0004bc-Qd
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:37:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1rZZJ2-0005u3-8H
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707755838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AVilNyWZ+QqT11vRjFnWm046PSwN7xepS7mfivGhL9E=;
 b=JdfapBiP5GssOKnKczz9C6gfToipL8AkUpkC3Vnzme81hT/jos7I7llj5q8Lo7LMfv/PaL
 FagqjKRWvDKYhWIj9i5Fe5sPbaOdR7Tbc7IzGG8qnF+L3rGDcAX08ZHoSynoKON5rlq6ZF
 +QoPiojn7HOgKIg6qZ/kkvkVH0MdzIU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-YP2wHnHOOyyz4WmqyWrFlQ-1; Mon, 12 Feb 2024 11:37:16 -0500
X-MC-Unique: YP2wHnHOOyyz4WmqyWrFlQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-784066a6190so256171185a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 08:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707755835; x=1708360635;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AVilNyWZ+QqT11vRjFnWm046PSwN7xepS7mfivGhL9E=;
 b=Pqtd4CUHdDZY3gbAtffmGIbAFDMkguKEBzEkj1aZfVYqk++xH9KD+5KrSPS6qLv9Nr
 W/1/az0Xzr+C6ABkiyu4cFyaQeEFikl9ooOUkeDSmVBdpEkjifzKqdFG+URJ7bNSQHSa
 8UpYTpWMpGsaKlqgQ2WaV1wn5GW/sW57Bv7+F+R2l94xtgLOnmpfhRaeik9sz6q1emsv
 MuEQRiss0hymBvzx+aWIGTE34UkOjqfCXUxgaWbB/TM4LW5LetUK93sJ8GpIzzMe7J9U
 7vpz4Nm9pzwXoqAhMXAdto2xPnBlh6Ycvg9DBfA1iyObi+ZITuogs2Z5d3/GxoRUqSTF
 jpAw==
X-Gm-Message-State: AOJu0YzStdavSTDEffzjRYfwm4VdXwpw6KiRZhw99snw7VryE/n5zjnm
 iVOcSUUXuEUfmxzrzp+FtW6kO9d2O+vGH68u+pyGpIMEbHvjsOhcu9G2QAoZJzLsWKHsIHErpau
 XHnPWZBZRJis4AEPuynWKPBtqcx+mgIqvSKwuVaRA8UaGoydLYQsZXqCLOaB+yTXWlvCfV2tA9W
 VM8sVu5j1jVRYo0qCrEPIjBAu/ItJz/kvZKTfB
X-Received: by 2002:a05:620a:8119:b0:783:d709:54a3 with SMTP id
 os25-20020a05620a811900b00783d70954a3mr7458535qkn.32.1707755835534; 
 Mon, 12 Feb 2024 08:37:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFOJ90gVwie2vnFlfOuuzg2OZAVrluWjpmvJ0g28qgdZqz4cezTLCVP9Td65zljA9nkd2UjlA==
X-Received: by 2002:a05:620a:8119:b0:783:d709:54a3 with SMTP id
 os25-20020a05620a811900b00783d70954a3mr7458520qkn.32.1707755835117; 
 Mon, 12 Feb 2024 08:37:15 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 o10-20020a05620a110a00b00783b6da58a9sm2170981qkk.39.2024.02.12.08.37.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 08:37:14 -0800 (PST)
Message-ID: <e21cdd37-9794-43bf-aa61-b14936ff5be7@redhat.com>
Date: Mon, 12 Feb 2024 17:37:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/14] migration: Modify ram_init_bitmaps() to report
 dirty tracking errors
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-5-clg@redhat.com>
 <9e8d8479-7202-417f-a3e2-3ed3cebda423@nvidia.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <9e8d8479-7202-417f-a3e2-3ed3cebda423@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
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

On 2/12/24 09:51, Avihai Horon wrote:
> Hi Cedric,
> 
> On 07/02/2024 15:33, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> The .save_setup() handler has now an Error** argument that we can use
>> to propagate errors reported by the .log_global_start() handler. Do
>> that for the RAM. qemu_savevm_state_setup() will store the error under
>> the migration stream for later detection in the migration sequence.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/ram.c | 19 ++++++++++---------
>>   1 file changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index d86626bb1c704b2d3497b323a702ca6ca8939a79..b87245466bb46937fd0358d0c66432bcc6280018 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -2802,19 +2802,17 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
>>       }
>>   }
>>
>> -static void ram_init_bitmaps(RAMState *rs)
>> +static void ram_init_bitmaps(RAMState *rs, Error **errp)
>>   {
>> -    Error *local_err = NULL;
>> -
>>       qemu_mutex_lock_ramlist();
>>
>>       WITH_RCU_READ_LOCK_GUARD() {
>>           ram_list_init_bitmaps();
>>           /* We don't use dirty log with background snapshots */
>>           if (!migrate_background_snapshot()) {
>> -            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, &local_err);
>> -            if (local_err) {
>> -                error_report_err(local_err);
>> +            memory_global_dirty_log_start(GLOBAL_DIRTY_MIGRATION, errp);
>> +            if (*errp) {
> 
> I think we should use ERRP_GUARD() or a local error here and also below at ram_init_bitmaps() (or return bool like Philippe suggested).

yes. I will rework that part.

Thanks,

C.


> 
> Thanks.
> 
>> +                break;
>>               }
>>               migration_bitmap_sync_precopy(rs, false);
>>           }
>> @@ -2828,7 +2826,7 @@ static void ram_init_bitmaps(RAMState *rs)
>>       migration_bitmap_clear_discarded_pages(rs);
>>   }
>>
>> -static int ram_init_all(RAMState **rsp)
>> +static int ram_init_all(RAMState **rsp, Error **errp)
>>   {
>>       if (ram_state_init(rsp)) {
>>           return -1;
>> @@ -2839,7 +2837,10 @@ static int ram_init_all(RAMState **rsp)
>>           return -1;
>>       }
>>
>> -    ram_init_bitmaps(*rsp);
>> +    ram_init_bitmaps(*rsp, errp);
>> +    if (*errp) {
>> +        return -1;
>> +    }
>>
>>       return 0;
>>   }
>> @@ -2952,7 +2953,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>>
>>       /* migration has already setup the bitmap, reuse it. */
>>       if (!migration_in_colo_state()) {
>> -        if (ram_init_all(rsp) != 0) {
>> +        if (ram_init_all(rsp, errp) != 0) {
>>               compress_threads_save_cleanup();
>>               return -1;
>>           }
>> -- 
>> 2.43.0
>>
>>
> 


