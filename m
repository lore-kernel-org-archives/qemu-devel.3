Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18889CD11DD
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 16:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpsd8-0003zr-MO; Thu, 28 Mar 2024 12:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpsd4-0003z8-H3
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rpsd2-0000rV-2T
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 12:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711643362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDlPG5b3qO5EZUIxe9xnoUT3X+FKkpEADHsdsGrCU3Q=;
 b=IgHcng/N/EwvEJByMakwlI0h5VtOND9M6jXm929OlJ8m0GJj5NbQ5zZalFbKRa+aN5koQw
 iLihMyEa23yN1ZLUXS9S6CbfgKUc2U4hibUNbF5aZZByD18KALOAC3F9P2r8wuieT9rVGP
 bOz/M6jA/F0vyVuIn5lZsfhlqiqIAtg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-OrIwlUEyOQuavGQXcVJQ0w-1; Thu, 28 Mar 2024 12:29:19 -0400
X-MC-Unique: OrIwlUEyOQuavGQXcVJQ0w-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-430b7d8b428so10962141cf.1
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 09:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711643358; x=1712248158;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KDlPG5b3qO5EZUIxe9xnoUT3X+FKkpEADHsdsGrCU3Q=;
 b=gGZ1W94Lx8Wrs1gLNJnCc4EOIdwIaZ7AHbXL8vAXHzSmO6XkQTOfrCJDqpJn1gR7X8
 m8e9oQzl1Y/fv+qzyN0vvsRLGUNk7xoXKSZwBGmpJoriQkS9/gX21Nt39cJKBlMHFIsk
 UBqoU+TM5U7oFa53ieD+Evg2iJ0D2MQY7W2dPVSXVYC8B6mr2BjZ95Q9HKlaMxoNRBtZ
 iBlAcm5cqFqm1UDpXV0fF2u0vih0WhM9guzFCkEhO22JqLUcEvl7uCiB8TjiZqd7D4rR
 523lI6xCtc9up6ShavPNuAY/qw5UgRNd85XciHtRQRQIXUapocS0D/pyMjiGWnmj7mY5
 aoDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE4ZkSVZR57NoKN+W6Q1Xk6wH8/we5OJRhazUSaCMRPsBbW5lQ6KHOoCknbbXWRLV8WslMQXcM87VfVWqpVvPXMDjZyeE=
X-Gm-Message-State: AOJu0Yx4PstXBnK2Hx4uvYTSwTTx8CiI51kgVNyWbsDjw9YVdCkjkvoy
 BXTMYz18RmfAXZufGGSClqrX7x4/+klTLv/mmxVJwjX1ZXoSNKDqakC0i8tPRSNIDLKSuMZ7IrE
 s1F06YbeEpylT/Buk4kIB1GaEGfgYqep3tP5C1MDUYBMys9MdVw3q
X-Received: by 2002:ac8:588c:0:b0:430:b6e6:1c20 with SMTP id
 t12-20020ac8588c000000b00430b6e61c20mr3302790qta.60.1711643358422; 
 Thu, 28 Mar 2024 09:29:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXoKRQyOMvaVRY//d2G+x7Uw4KVh4yIdTw7zKwnvsVLA/fjrTrsm0YiZYeVIO/f7BRKXMvhQ==
X-Received: by 2002:ac8:588c:0:b0:430:b6e6:1c20 with SMTP id
 t12-20020ac8588c000000b00430b6e61c20mr3302770qta.60.1711643358116; 
 Thu, 28 Mar 2024 09:29:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v26-20020ac8749a000000b00430afbb6b50sm744458qtq.51.2024.03.28.09.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 09:29:17 -0700 (PDT)
Message-ID: <ca670136-b362-42b0-9a93-3b28ff4b3397@redhat.com>
Date: Thu, 28 Mar 2024 17:29:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0 1/2] migration: Set migration error in
 migration_completion()
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20240328140252.16756-1-avihaih@nvidia.com>
 <20240328140252.16756-2-avihaih@nvidia.com>
 <9aea916e-ea64-424b-bb48-4d1ad75e85ac@redhat.com>
 <9d3a476d-9e99-4ed8-8320-8bf86269dbf3@nvidia.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <9d3a476d-9e99-4ed8-8320-8bf86269dbf3@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 3/28/24 16:50, Avihai Horon wrote:
> 
> On 28/03/2024 17:21, Cédric Le Goater wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> Hello Avihai,
>>
>> On 3/28/24 15:02, Avihai Horon wrote:
>>> After commit 9425ef3f990a ("migration: Use migrate_has_error() in
>>> close_return_path_on_source()"), close_return_path_on_source() assumes
>>> that migration error is set if an error occurs during migration.
>>>
>>> This may not be true if migration errors in migration_completion(). For
>>> example, if qemu_savevm_state_complete_precopy() errors, migration error
>>> will not be set
>>
>> Out of curiosity, could you describe a bit more the context ? Did
>> vfio_save_complete_precopy() fail ? why ?
> 
> Yep, vfio_save_complete_precopy() failed (but it failed while I was experimenting with an unofficial debug FW).
> 
>>
>> We should propagate errors of .save_live_complete_precopy() handlers as
>> it was done .save_setup handlers(). For 9.1.
> 
> Agreed.
> 
>>
>>> This in turn, will cause a migration hang bug, similar to the bug that
>>> was fixed by commit 22b04245f0d5 ("migration: Join the return path
>>> thread before releasing to_dst_file"), as shutdown() will not be issued
>>> for the return-path channel.
>>
>> yes, but this test :
>>
>>     if (ret < 0) {
>>         goto fail;
>>     }
>>
>> will skip the close_return_path_on_source() call. Won't it ? So I don't
>> understand how it can be an issue. Am I missing something ?
> 
> It will skip the close_return_path_on_source() call in migration_completion(), but there is another close_return_path_on_source() call in migrate_fd_cleanup().

OK. Found it. This is a code path I hadn't explored yet.

Acked-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> 
>>
>>> Fix it by ensuring migration error is set in case of error in
>>> migration_completion().
>>
>> Why didn't you add a reference to commit 9425ef3f990a ?
> 
> I thought this commit didn't introduce this bug, but looking again in the mailing list [1], it kinda did:
> The hang bug was fully fixed by commit 22b04245f0d ("migration: Join the return path thread before releasing to_dst_file") and then 9425ef3f990a re-introduced the bug, but only for migration_completion() case.
> So, you are right, a fixes line with 9425ef3f990a should be added.
> 
> Thanks.
> 
> [1] https://lore.kernel.org/all/20240226203122.22894-1-farosas@suse.de/
> 
>>
>>
>>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>>> ---
>>>   migration/migration.c | 10 ++++++++++
>>>   1 file changed, 10 insertions(+)
>>>
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 9fe8fd2afd7..b73ae3a72c4 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
>>>   {
>>>       int ret = 0;
>>>       int current_active_state = s->state;
>>> +    Error *local_err = NULL;
>>>
>>>       if (s->state == MIGRATION_STATUS_ACTIVE) {
>>>           ret = migration_completion_precopy(s, &current_active_state);
>>> @@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
>>>       return;
>>>
>>>   fail:
>>> +    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
>>> +        migrate_set_error(s, local_err);
>>> +        error_free(local_err);
>>> +    } else if (ret) {
>>> +        error_setg_errno(&local_err, -ret, "Error in migration completion");
>>
>> The 'ret = -1' case could be improved with error_setg(). As a followup.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>
>>> +        migrate_set_error(s, local_err);
>>> +        error_free(local_err);
>>> +    }
>>> +
>>>       migration_completion_failed(s, current_active_state);
>>>   }
>>>
>>
> 


