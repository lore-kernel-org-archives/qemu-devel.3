Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC23C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 16:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZYnR-00030Z-7x; Mon, 12 Feb 2024 11:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZYnO-00030K-Pk
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:04:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZYnN-0008AM-2y
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 11:04:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707753875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I3roUxIEJvzC1gCDtu5pbypgiw8zatYlhLu24vzKOLs=;
 b=JT/ROWlnjXddwDuuMwZSTIIgGYnEKehS2/cGjqhrq36EnVciiMvI0Yjvlj2K5MdVfXiC2p
 2KkoccaKscDTZ2UaFBXwYp00m/t84jAdTgrAvS9qEsHaPWaA+iPTTP3xQOF9750fj/5AD9
 qBAWhoddQhb2QoFlqY50YkIVspgZTtE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-XpyOgalVNayopjs4ifSAbg-1; Mon, 12 Feb 2024 11:04:33 -0500
X-MC-Unique: XpyOgalVNayopjs4ifSAbg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7830ab8fb5aso414617485a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 08:04:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707753872; x=1708358672;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I3roUxIEJvzC1gCDtu5pbypgiw8zatYlhLu24vzKOLs=;
 b=WlnJxhbToiCbAomtWlOtAB7WMBmDAF+wtI5LqzJKFkF+PNFuy0RabInDNWq/1rXrAm
 MfmqBk6k3WabdAVjUKK4AyfhUSpDdf91IGkyYsrpCHUIh7m56vfVx7A8LqMfcIARQGcy
 /vFvyiz1pK2IVoIdvUsD91/tXaRhvjO5Mfl0REbhKkBaw8rmhiM+vM/DineJySCtfjQM
 cRU4Ncm8GtIEJwPt9bCE4AGTN1j6HJ8EhnNmAbDJGx8O8FjC5TloZCUoJmu3yZYfuVL7
 ZOp5ySF3Ifg1sOI0KWvPgosShj4IEdEZ2GGwd4SuUSlYFB+q472sbVedNMclyQNwYpbR
 Iy5A==
X-Gm-Message-State: AOJu0YxFFb76Bi4p6dOVTl0hemWZMz90InF/OJa+DJLz1mb9cKUO7v/6
 hKyVASM+JVzqLUoXMyOfvASxcjmSUAG+dsX8c/UZtIMKhl0bcYS8kr7e7OhW108BbcTMBmVk02z
 nmekDWmW1mN1p2vRWc2JAB/G0Co60I/0wFq3Fdl3ItKwcr9qBhT06cE5QP5t1
X-Received: by 2002:ae9:e715:0:b0:785:ca4d:2a3a with SMTP id
 m21-20020ae9e715000000b00785ca4d2a3amr6640988qka.77.1707753872115; 
 Mon, 12 Feb 2024 08:04:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEDnYeZyO4bt8izNKVFkNHRNL+YcMEMMAvFqjT5uLHqKJV7NH7Yg/XUL4MYFw+9ePSOoIlOJw==
X-Received: by 2002:ae9:e715:0:b0:785:ca4d:2a3a with SMTP id
 m21-20020ae9e715000000b00785ca4d2a3amr6640943qka.77.1707753871555; 
 Mon, 12 Feb 2024 08:04:31 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjS7l8DNKCx+gzwhpwWP47U9dWdl/p9BxiqiczYhw97mlqFqMRGY0jOEj124WumOFlCtZ7a0CedA8A+prRlAaK8VTMOZ76+0yyEOTMOj9U7jgRo4hqplIARqyW+R6KMGiGo+hr6EiE0vKwHC93Gqim
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a05620a24c400b00785bdc9d08esm2149649qkn.32.2024.02.12.08.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 08:04:31 -0800 (PST)
Message-ID: <da0532c4-818f-4aab-8ad4-46323d85f50d@redhat.com>
Date: Mon, 12 Feb 2024 17:04:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <ZcRtSdInpBGgWhk0@x1n>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZcRtSdInpBGgWhk0@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.774,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Peter

On 2/8/24 06:57, Peter Xu wrote:
> On Wed, Feb 07, 2024 at 02:33:47PM +0100, Cédric Le Goater wrote:
>> In case of error, close_return_path_on_source() can perform a shutdown
>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>> 'to_dst_file' is closed before calling close_return_path_on_source()
>> and the shutdown fails, leaving the source and destination waiting for
>> an event to occur.
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
> I think this is okay to me for a short term plan.  I'll see how others
> think, also add Dan into the loop.
> 
> If so, would you please add a rich comment explaining why tmp needs to be
> closed later?  Especially, explicit comment on the ordering requirement
> would be helpful: IMHO here it's an order that qemu_fclose() must happen
> after close_return_path_on_source().  So when others work on this code we
> don't easily break it without noticing.

Sure. I will when we have clarified with Fabiano what is the best
approach.

> Also please feel free to post separately on migration patches if you'd like
> us to merge the patches when repost.

This series is a collection of multiple (related) changes :

* extra Error** parameter to save_setup() migration handlers.
   This change has consequences on the various callers which are not
   fully analyzed.
* similar changes for memory logging handlers. These looks more self
   contained and I will see if I can send then separately.
* return-path thread termination

and then, in background we have open questions regarding :

* the QEMUfile implementation and its QIOChannel usage for migration
   streams
* qemu_file_set_error* vs. migrate_set_error. It is confusing, at least
   for me. Do we have some documentation on best practices ?

Thanks,

C.



