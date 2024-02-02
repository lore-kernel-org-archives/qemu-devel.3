Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB0CC47DB3
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 14:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVusv-00018d-3q; Fri, 02 Feb 2024 09:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVuso-000184-T3
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:51:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rVusl-0004CS-Tg
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 09:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706885467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DDCen4lnvbulyjIz9kBjBd9GPoi7IHvJbCGWzpCYK88=;
 b=EDij8eySG7P19o8u9rBc3ncjKQ1qdxPgKxswkgqq8SI7zKADg3ElzhwbJGFRE3rWsHHETG
 EXvXW0nKI4OMpYQAUOHya2VjSKsFvG7zzstpMLuv150yHiIX3LnNAXyaPvtcySnDZRxkUJ
 Ab1CM6/et7ad005CnWpHeg3gayE3pok=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-ruscD0bWNjuX5IrbHboU9A-1; Fri, 02 Feb 2024 09:51:05 -0500
X-MC-Unique: ruscD0bWNjuX5IrbHboU9A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a2cb0d70d6cso137611166b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Feb 2024 06:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706885464; x=1707490264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDCen4lnvbulyjIz9kBjBd9GPoi7IHvJbCGWzpCYK88=;
 b=sc3finOLvIXGgtHgAazREJCOK9ZfkDG7aWXFeRlIvGa730Ojjz+cAfrbLKBJLUhV8A
 sMInhz3IP29oKouYSUlwgx5C5K7N4/CfKzO8/8/nfkAVcscrhO8O5P2pk/YhVK/BN1u0
 1ov8gCR+iXZUzKz6c3yvN5+JQHVazw1+zxeXO25K28sf1m3udyy2PhUziPuMD0Yptk4b
 HPOdnets9pDSZR0Ja3mVdeDWuOsHOf8l6vGo+joKosEReXtJZUGmewtTbFwl2NiRU4TM
 pJcYlIfZLNSJNbONB6FssQt6/NLk5yq5Ybybsn5UtNFk8JoXfn3st7HyKqh9QF4n07lK
 1oiQ==
X-Gm-Message-State: AOJu0Yys94WEqp9C+HNBsXHQHC3QC6Yi4y2NMMgGZYk2P1cbAILFxqDs
 sK3HY1BVQorNVTbrAlcJgACOVNhSMGiRrhKlDJBi2bZpaK3mLP7zTZdNY+L7VBkg76AP9W+nw40
 GjGYytR0k6wWn2Yra9sq24a8NvoNirIkNNmw5k1SaKhAQb8xxAbd2TByxzSAj
X-Received: by 2002:a17:907:584:b0:a35:9dd6:ce06 with SMTP id
 vw4-20020a170907058400b00a359dd6ce06mr1404064ejb.14.1706885464021; 
 Fri, 02 Feb 2024 06:51:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHWiH4kFxdRlynrmY5IttXO57TSPn9IUTM68+c1cboKEhmoAMQBv7lJXmNLRoW4rLLhhkqHOw==
X-Received: by 2002:a17:907:584:b0:a35:9dd6:ce06 with SMTP id
 vw4-20020a170907058400b00a359dd6ce06mr1404055ejb.14.1706885463583; 
 Fri, 02 Feb 2024 06:51:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCW93MQSQKhB0BDioMPSLU2LBqPgCAlAd69rqWbZUhOOQ7falR2ghz3d9ooeZWQxAffb9mf0QZhBgmJ1nlm4mLOmYf56Occ=
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 th8-20020a1709078e0800b00a3717f96e6esm497530ejc.171.2024.02.02.06.51.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Feb 2024 06:51:03 -0800 (PST)
Message-ID: <d2d0314a-494f-4ace-ba73-e14019fb4fd3@redhat.com>
Date: Fri, 2 Feb 2024 15:51:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] migration: Fix return-path thread exit
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
References: <20240201184853.890471-1-clg@redhat.com>
 <20240201184853.890471-3-clg@redhat.com> <8734ubhqr9.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <8734ubhqr9.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2/2/24 15:42, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> In case of error, close_return_path_on_source() can perform a shutdown
>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>> 'to_dst_file' is closed before calling close_return_path_on_source()
>> and the shutdown fails, leaving the source and destination waiting for
>> an event to occur.
> 
> At close_return_path_on_source, qemu_file_shutdown() and checking
> ms->to_dst_file are done under the qemu_file_lock, so how could
> migrate_fd_cleanup() have cleared the pointer but the ms->to_dst_file
> check have passed?

This is not a locking issue, it's much simpler. migrate_fd_cleanup()
clears the ms->to_dst_file pointer and closes the QEMUFile and then
calls close_return_path_on_source() which then tries to use resources
which are not available anymore.

Thanks,

C.




> 
>>
>> Close the file after calling close_return_path_on_source() so that the
>> shutdown succeeds and the return-path thread exits.
>>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>   migration/migration.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 2c3362235c7651c11d581f3c3639571f1f9636ef..1e0b6acaedc272e8ce26ad40be2c42177f5fd14e 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1314,6 +1314,7 @@ void migrate_set_state(int *state, int old_state, int new_state)
>>   static void migrate_fd_cleanup(MigrationState *s)
>>   {
>>       int file_error = 0;
>> +    QEMUFile *tmp = NULL;
>>   
>>       g_free(s->hostname);
>>       s->hostname = NULL;
>> @@ -1323,8 +1324,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>>       qemu_savevm_state_cleanup();
>>   
>>       if (s->to_dst_file) {
>> -        QEMUFile *tmp;
>> -
>>           trace_migrate_fd_cleanup();
>>           bql_unlock();
>>           if (s->migration_thread_running) {
>> @@ -1344,15 +1343,14 @@ static void migrate_fd_cleanup(MigrationState *s)
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
>>       close_return_path_on_source(s, file_error);
>>   
>> +    if (tmp) {
>> +        qemu_fclose(tmp);
>> +    }
>> +
>>       assert(!migration_is_active(s));
>>   
>>       if (s->state == MIGRATION_STATUS_CANCELLING) {
> 


