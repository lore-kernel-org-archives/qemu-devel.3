Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A775C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razy2-0000gz-KE; Fri, 16 Feb 2024 10:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1razy1-0000go-TF
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1razy0-0004HP-5p
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708096651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZHDGJzBOIMpLQPuM8MYFTCXIdjMpnj/st5iNb+WRDxk=;
 b=ObJ1bnVdD52sH1CpfQ6cTGQqBxqTZYNPMVW8supM/GRev8Ma3yJBVII/ts6XJ8jPJ5pDqD
 5GOc/904sSDwnLGp6wznd1yZzQF2JGmWAwfXCaM035sCW7n9WI13cmxogX+Yv+ZdjlRviS
 uyrLDlbdcPewc4YrK96n0VvoupI5Z38=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-EKNGFtzBPuOvf8I51hKhQQ-1; Fri, 16 Feb 2024 10:17:29 -0500
X-MC-Unique: EKNGFtzBPuOvf8I51hKhQQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6805f615543so35811206d6.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:17:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708096648; x=1708701448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZHDGJzBOIMpLQPuM8MYFTCXIdjMpnj/st5iNb+WRDxk=;
 b=xUULPcTKuWzGaDlq++0f9I0BKPDQd3HkSGD3WChlfJIM3KMu2Cbb1AMhFCiNANVdxM
 nFV99mrn1/1HQm0fn2c0d9eHm3I2au9V7yWGb7vgjZ8Mik+3BN+FqZ931TMdVCeWlmFS
 LjGthXgEex8ng5vkPKCuATxFJusbkIFW5J7lAed1ncjkC9DjACQcfZNvkNWR5cS9vqrk
 68XPR630Tkk/mPK4O2ugmWr7zZwvLSy+pq3xmiwi1i/q4XOAtX5w06TxNsoRmM+ChJNB
 oLnw+0TYcLu2foSK+qgkGZ71ZF1sOEekoaBVGoBVT7E8C+7x/Wc8OGvZhcXPdmEGmkjj
 ptqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1Zlu7gv+MOwqsRAv8VAX0pWCKRmh1SET2iQ8IuIlpDzOLAsetXyESq8Ow+NjwQidKgXGhfhn9mpiHPWk4WOHN851fiew=
X-Gm-Message-State: AOJu0YzOjBRfKMRcgDESq5/7V0TIH5rQFQIh+zwxL+57lKl9A2+2ze+u
 7PVSse7VbwoXhVEPKAGv/ghz8VgV5HdRSuUGY5z2ipHbEIkwU1ND6m9Qt8lt9Hd5gxFzGEKciDV
 u9RwZ8o5yZhjNgz/zAf/STk3fg5GjFmCNj8ElUqNTYGpcYGrsU4Ub
X-Received: by 2002:a0c:db87:0:b0:68f:162d:a8ad with SMTP id
 m7-20020a0cdb87000000b0068f162da8admr4784570qvk.0.1708096648375; 
 Fri, 16 Feb 2024 07:17:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4u0m+Dy/HvKVwJ/+VTep/Add9y0R2yiUT3dktJyhTbub9x/HFSsuviDuB0Lb2cDcuHMNtCg==
X-Received: by 2002:a0c:db87:0:b0:68f:162d:a8ad with SMTP id
 m7-20020a0cdb87000000b0068f162da8admr4784547qvk.0.1708096647984; 
 Fri, 16 Feb 2024 07:17:27 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 ld8-20020a056214418800b0068ef238441bsm952756qvb.39.2024.02.16.07.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 07:17:27 -0800 (PST)
Message-ID: <10a2610e-713d-41ec-a317-b442f2062000@redhat.com>
Date: Fri, 16 Feb 2024 16:17:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/14] migration: Use migrate_has_error() in
 close_return_path_on_source()
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-14-clg@redhat.com> <87y1bvayu7.fsf@suse.de>
 <fbdb9fbc-c3de-4b0a-be1f-2bed405dfd86@redhat.com> <87sf23awjp.fsf@suse.de>
 <4af61bb2-4b21-4560-a7c1-c3fb65f20ff3@redhat.com> <87zfw3ox2m.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87zfw3ox2m.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
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

On 2/14/24 17:00, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 2/8/24 14:57, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> On 2/8/24 14:07, Fabiano Rosas wrote:
>>>>> Cédric Le Goater <clg@redhat.com> writes:
>>>>>
>>>>>> close_return_path_on_source() retrieves the migration error from the
>>>>>> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
>>>>>> shutdown is required to exit the return-path thread. However, in
>>>>>> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
>>>>>> close_return_path_on_source() and the shutdown is never performed,
>>>>>> leaving the source and destination waiting for an event to occur.
>>>>>>
>>>>>> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
>>>>>>
>>>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>>>> ---
>>>>>>     migration/migration.c | 3 +--
>>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>>>> index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c4177781241b3e291e5d 100644
>>>>>> --- a/migration/migration.c
>>>>>> +++ b/migration/migration.c
>>>>>> @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(MigrationState *ms)
>>>>>>          * cause it to unblock if it's stuck waiting for the destination.
>>>>>>          */
>>>>>>         WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>>>>> -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>>>>>> -            qemu_file_get_error(ms->to_dst_file)) {
>>>>>> +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
>>>>>>                 qemu_file_shutdown(ms->rp_state.from_dst_file);
>>>>>>             }
>>>>>>         }
>>>>>
>>>>> Hm, maybe Peter can help defend this, but this assumes that every
>>>>> function that takes an 'f' and sets the file error also sets
>>>>> migrate_set_error(). I'm not sure we have determined that, have we?
>>>>
>>>> How could we check all the code path ? I agree it is difficult when
>>>> looking at the code :/
>>>
>>> It would help if the thing wasn't called 'f' for the most part of the
>>> code to begin with.
>>>
>>> Whenever there's a file error at to_dst_file there's the chance that the
>>> rp_state.from_dst_file got stuck. So we cannot ignore the file error.
>>>
>>> Would it work if we checked it earlier during cleanup as you did
>>> previously and then set the migration error?
>>
>> Do you mean doing something similar to what is done in
>> source_return_path_thread() ?
>>
>>           if (qemu_file_get_error(s->to_dst_file)) {
>>               qemu_file_get_error_obj(s->to_dst_file, &err);
>>       	    if (err) {
>>           	migrate_set_error(ms, err);
>>           	error_free(err);
>> 	...
>>
>> Yes. That would be safer I think.
> 
> Yes, something like that.
> 
> I wish we could make that return path cleanup more deterministic, but
> currently it's just: "if something hangs, call shutdown()". We don't
> have a way to detect a hang, we just look at the file error and hope it
> works.
> 
> A crucial aspect here is that calling qemu_file_shutdown() itself sets
> the file error. So there's not even a guarantee that an error is
> actually an error.
> 
>>
>>
>> Nevertheless, I am struggling to understand how qemu_file_set_error()
>> and migrate_set_error() fit together. I was expecting some kind of
>> synchronization  routine but there isn't it seems. Are they completely
>> orthogonal ? when should we use these routines and when not ?
> 
> We're trying to phase out the QEMUFile usage altogether. One thing that
> is getting in the way is this dependency on the qemu_file_*_error
> functions.

OK. the other changes, which add an Error** argument to various handlers,
reduce the use of qemu_file_*_error routines in VFIO.

> While we're not there yet, a good pattern is to find a
> qemu_file_set|get_error() pair and replace it with
> migrate_set|has_error(). 

OK. I will keep that in mind for the other changes.

Thanks,

C.



> Unfortunately the return path does not fit in
> this, because we don't have a matching qemu_file_set_error, it could be
> anywhere. As I said above, we're using that error as a heuristic for: "a
> recvmsg() might be hanging".
> 
>>
>> My initial goal was to modify some of the memory handlers (log_global*)
>> and migration handlers to propagate errors at the QMP level and them
>> report to the management layer. This is growing in something bigger
>> and currently, I don't find a good approach to the problem.
>>
>> The last two patches of this series try to fix the return-path thread
>> termination. Let's keep that for after.
> 
> I'll try to figure that out. I see you provided a reproducer.
> 
>>
>> Thanks,
>>
>> C.
> 


