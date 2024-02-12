Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3934C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 15:45:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYUR-0005HY-BH; Mon, 12 Feb 2024 10:45:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZYUP-0005Gu-9Y
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:45:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZYUN-0004SG-IR
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 10:45:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707752698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6BWXIys6ZkD0mB7XpqrWKZuV2FiqfRpVj2zMCek5bio=;
 b=M46n3q0Z2oKmAcJaO96294eaOq5r+X9IaoWN5d0JUDFEEwHClsfQjnYoaIOlFsd76ngY3H
 tUKeokJ/wiwxLVSKTT6QIvkBRNLoi+tKg/L0NxCFS818XWIpWrTQ+NXqwUNXp3V9/wtMay
 54kEVBTTO0SaYkeGUFaZYVcRDJ4lZyA=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-NgVXoZUSO5a9qQvxKYheag-1; Mon, 12 Feb 2024 10:44:56 -0500
X-MC-Unique: NgVXoZUSO5a9qQvxKYheag-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3bfdd135eebso3222298b6e.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 07:44:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707752695; x=1708357495;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6BWXIys6ZkD0mB7XpqrWKZuV2FiqfRpVj2zMCek5bio=;
 b=kruRAOw35jxzJZwB5K39074RVebDDklCiAKGqMbMYpI8FJO/9dtp3Pb7WKT6ZoAF55
 eNCns9478Gpi/4iRHsX3LMqkw3xZDBbbG//hlvl5FMd9MDGbMGJhMYCosL9A2nuRpkjs
 OliXeiLRy7xMNKKgQ+vVfoAL+zQD8j69q+kcfCInMRgRPd3orCrmXaypQ6S93apNtTkI
 +qeRFA936BKyHZ+vqohNTroLFv5D2YVYj7BO0I+FbOlgJB821cNl1cPedwxrByTdyzPU
 oBadKGNi+T8VsnNZKV1rGRgmDS6+8IhVCjp11PzNFYt1E+tRoOMx8VEkdCZTA1S7DAQG
 rPig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaeit0vuM41CoYNVLZ2dtqaD2aYK5sqbjtrEU9u5P7W6n3xPAXISgdgx8dB+oYkd3uRumDO/Ru+tWJuyDIQrLBnDxdUNY=
X-Gm-Message-State: AOJu0YzgR476OJFzYAQva1oJFGTyRhziafqwZojXbb8pva0TitifSuFp
 XYFs95edkFrSG7g0dGrS8d3PwmeKnNxJbox0qkqSE9ceYscvxeBNSDKgjhkA0/IwclcEv7VXT+l
 7G5a0xV7F4jt1HjUSwGe9+GfmDpybxVSfIP1qrvbABtd/Hnp8qbmf
X-Received: by 2002:a05:6808:3a06:b0:3bf:fdb2:ca5b with SMTP id
 gr6-20020a0568083a0600b003bffdb2ca5bmr11540769oib.3.1707752695186; 
 Mon, 12 Feb 2024 07:44:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSo2y2pos3twCQFHsAtd2g1L5E7ZiQdrVmxQgnnEQgQlFSTUI/Ijs7YeFZwvBCiIFxn3ai9Q==
X-Received: by 2002:a05:6808:3a06:b0:3bf:fdb2:ca5b with SMTP id
 gr6-20020a0568083a0600b003bffdb2ca5bmr11540760oib.3.1707752694970; 
 Mon, 12 Feb 2024 07:44:54 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXiDzSOz9PBVehx4yuRUQKeg3YsiFee3sphgLCyjJtcqr9+JFi8VIXMTXgHvKgmmyCfD1X0F7xaeRlhLQBGZeZlWczdptRC5DCcRh/3zmNWpcTKcmY6nFt1hzB0qPlognO0
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 bp32-20020a05620a45a000b007840a08a097sm2126750qkb.76.2024.02.12.07.44.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 07:44:54 -0800 (PST)
Message-ID: <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com>
Date: Mon, 12 Feb 2024 16:44:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87v86zaxtv.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Fabiano

On 2/8/24 14:29, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> In case of error, close_return_path_on_source() can perform a shutdown
>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>> 'to_dst_file' is closed before calling close_return_path_on_source()
>> and the shutdown fails, leaving the source and destination waiting for
>> an event to occur.
> 
> Hi, Cédric
> 
> Are you sure this is not caused by patch 13? 

It happens with upstream QEMU without any patch.

When vfio_listener_log_global_start() fails, it sets an error on the
QEMUFile. To reproduce without a VFIO device, you can inject an error
when dirty tracking is started. Something like below,

     @@ -2817,6 +2817,8 @@ static void ram_init_bitmaps(RAMState *r
           * containing all 1s to exclude any discarded pages from migration.
           */
          migration_bitmap_clear_discarded_pages(rs);
     +
     +    qemu_file_set_error(migrate_get_current()->to_dst_file, -EAGAIN);
      }
      
      static int ram_init_all(RAMState **rsp)

Activate return-path and migrate.

> That 'if (ms->to_dst_file'
> was there to avoid this sort of thing happening.
> 
> Is there some reordering possibility that I'm not spotting in the code
> below? I think the data dependency on to_dst_file shouldn't allow it.
> 
> migrate_fd_cleanup:
>          qemu_mutex_lock(&s->qemu_file_lock);
>          tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
>          qemu_mutex_unlock(&s->qemu_file_lock);
>          ...
>          qemu_fclose(tmp);
> 
> close_return_path_on_source:
>      WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>          if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>              qemu_file_get_error(ms->to_dst_file)) {
>              qemu_file_shutdown(ms->rp_state.from_dst_file);
>          }
>      }

close_return_path_on_source() is called by migrate_fd_cleanup() in
the same thread. So, when we reach the locking section ms->to_dst_file
is already NULL and qemu_fclose() has been closed :/

May be I misunderstood. Please try to reproduce with the little hack
above.

Thanks,

C.

> I'm thinking maybe the culprit is the close_return_path_on_source() at
> migration_completion(). It might be possible for it to race with the
> migrate_fd_cleanup_bh from migration_iteration_finish().
> 
> If that's the case, then I think that one possible fix would be to hold
> the BQL at migration_completion() so the BH doesn't get dispatched until
> we properly close the return path.
> 
>>
>> Close the file after calling close_return_path_on_source() so that the
>> shutdown succeeds and the return-path thread exits.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>>   This is an RFC because the correct fix implies reworking the QEMUFile
>>   construct, built on top of the QEMU I/O channel.
>>
>>   migration/migration.c | 13 ++++++-------
>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5f55af3d7624750ca416c4177781241b3e291e5d..de329f2c553288935d824748286e79e535929b8b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1313,6 +1313,8 @@ void migrate_set_state(int *state, int old_state, int new_state)
>>   
>>   static void migrate_fd_cleanup(MigrationState *s)
>>   {
>> +    QEMUFile *tmp = NULL;
>> +
>>       g_free(s->hostname);
>>       s->hostname = NULL;
>>       json_writer_free(s->vmdesc);
>> @@ -1321,8 +1323,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>>       qemu_savevm_state_cleanup();
>>   
>>       if (s->to_dst_file) {
>> -        QEMUFile *tmp;
>> -
>>           trace_migrate_fd_cleanup();
>>           bql_unlock();
>>           if (s->migration_thread_running) {
>> @@ -1341,15 +1341,14 @@ static void migrate_fd_cleanup(MigrationState *s)
>>            * critical section won't block for long.
>>            */
>>           migration_ioc_unregister_yank_from_file(tmp);
>> -        qemu_fclose(tmp);
>>       }
>>   
>> -    /*
>> -     * We already cleaned up to_dst_file, so errors from the return
>> -     * path might be due to that, ignore them.
>> -     */
>>       close_return_path_on_source(s);
>>   
>> +    if (tmp) {
>> +        qemu_fclose(tmp);
>> +    }
>> +
>>       assert(!migration_is_active(s));
>>   
>>       if (s->state == MIGRATION_STATUS_CANCELLING) {
> 


