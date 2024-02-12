Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1451C48297
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 13:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZVyF-0001yW-K2; Mon, 12 Feb 2024 08:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZVyC-0001y0-5L
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:03:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rZVyA-0003R0-6k
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 08:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707743013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2pLMCJsKT+J6SI/LgC+1Ppy/oAwgnDxEyKB3pIAk4M=;
 b=JkWjo4hXoJk8UxQqg+Hsg6M+ZxrhZAUn22YPXCMX7HbEay8RvJPHAs12evPcS44yOP07Vc
 C7T4z0R95noMO++UqwtnoQo0j3zssYcUIQ9xKKSnAG3yWEo+lAAKY5mQXk0LsCzBAnXG1c
 hEIRzSKx3KGEa/Rc0Xu8MID6nZwhji0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-CIGcMB5yNBKEq8qJOOuVdA-1; Mon, 12 Feb 2024 08:03:31 -0500
X-MC-Unique: CIGcMB5yNBKEq8qJOOuVdA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40ef9e08fffso16575785e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 05:03:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707743010; x=1708347810;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J2pLMCJsKT+J6SI/LgC+1Ppy/oAwgnDxEyKB3pIAk4M=;
 b=ATCB8NrzbOMDLbRAsWduBDYuegqz0378SXxNcyKrK3xh1z8t/UD8j+Zk8Pzn+hww+1
 uT4DbndtTFHvamroi8SnTgzRong8BxTR2JUYIcszqY87IMtfZXizs7/GWNN+N+79xxCa
 zI2eqg+IQNP6W90aRV1WnQPLHm+0TOw9LfMy2O4Rm9ykQO/afk5Y2yEcw1OzvhbAde9m
 B7LJk3FIK2Zn2EQUuSrbDM9TrNRmirqIZwKE38PC+IfsJmE/itzFJk/oL7ydFbuRFSut
 VUFV+vxyP92VZC7uX4Pn04Ob5RxRYQXha8scVi3f7oLsFSm7gG44B6/0lYsQ/nb7PFvW
 o/7Q==
X-Gm-Message-State: AOJu0YzjLtB1A4RUJ0VzIpAdwc3hbhecOwpcw9k3ifcPGDeo2vhlbwQt
 M59xP8XizBfSDixwrKAWdjXFqGhkan5niFzDa0AIEWRPIzckGlVUZkdHDUJVVYJVxmiViKE0eSe
 7EwQLRJSEZs+JTKHqAlxNGxZbIcOaJQ2+ZfxxLXnGgYoTNqXfbv+9
X-Received: by 2002:a05:600c:a3a5:b0:40f:e207:2e4f with SMTP id
 hn37-20020a05600ca3a500b0040fe2072e4fmr4457427wmb.40.1707743010263; 
 Mon, 12 Feb 2024 05:03:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXizMRZcME0UBGjhL5ycMHlhc9Zvsu6h4/JEDUpEor4zrctFeRUuiFVhVoXKnvjWdqkBTftw==
X-Received: by 2002:a05:600c:a3a5:b0:40f:e207:2e4f with SMTP id
 hn37-20020a05600ca3a500b0040fe2072e4fmr4457410wmb.40.1707743009941; 
 Mon, 12 Feb 2024 05:03:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU5qbz5+TN/YwsuIJWfKL6MzCoGgxzM8WZYYoszBCxDR8JkS9VrpECdp9puHKb2oVECo+pzfKyIs6Ndg1e9mbFngDz328bp6lrbJ4KU8ywy57qij9oUowNF2mzUaNPSeQ91
Received: from ?IPV6:2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891?
 ([2a01:cb19:853d:fa00:c28a:3e3d:34f3:3891])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a05600c354f00b00410e2214d4bsm2048266wmq.42.2024.02.12.05.03.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 05:03:29 -0800 (PST)
Message-ID: <4af61bb2-4b21-4560-a7c1-c3fb65f20ff3@redhat.com>
Date: Mon, 12 Feb 2024 14:03:28 +0100
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
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87sf23awjp.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
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

On 2/8/24 14:57, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> On 2/8/24 14:07, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> close_return_path_on_source() retrieves the migration error from the
>>>> the QEMUFile '->to_dst_file' to know if a shutdown is required. This
>>>> shutdown is required to exit the return-path thread. However, in
>>>> migrate_fd_cleanup(), '->to_dst_file' is cleaned up before calling
>>>> close_return_path_on_source() and the shutdown is never performed,
>>>> leaving the source and destination waiting for an event to occur.
>>>>
>>>> Avoid relying on '->to_dst_file' and use migrate_has_error() instead.
>>>>
>>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>>    migration/migration.c | 3 +--
>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/migration/migration.c b/migration/migration.c
>>>> index d5f705ceef4c925589aa49335969672c0d761fa2..5f55af3d7624750ca416c4177781241b3e291e5d 100644
>>>> --- a/migration/migration.c
>>>> +++ b/migration/migration.c
>>>> @@ -2372,8 +2372,7 @@ static bool close_return_path_on_source(MigrationState *ms)
>>>>         * cause it to unblock if it's stuck waiting for the destination.
>>>>         */
>>>>        WITH_QEMU_LOCK_GUARD(&ms->qemu_file_lock) {
>>>> -        if (ms->to_dst_file && ms->rp_state.from_dst_file &&
>>>> -            qemu_file_get_error(ms->to_dst_file)) {
>>>> +        if (migrate_has_error(ms) && ms->rp_state.from_dst_file) {
>>>>                qemu_file_shutdown(ms->rp_state.from_dst_file);
>>>>            }
>>>>        }
>>>
>>> Hm, maybe Peter can help defend this, but this assumes that every
>>> function that takes an 'f' and sets the file error also sets
>>> migrate_set_error(). I'm not sure we have determined that, have we?
>>
>> How could we check all the code path ? I agree it is difficult when
>> looking at the code :/
> 
> It would help if the thing wasn't called 'f' for the most part of the
> code to begin with.
> 
> Whenever there's a file error at to_dst_file there's the chance that the
> rp_state.from_dst_file got stuck. So we cannot ignore the file error.
> 
> Would it work if we checked it earlier during cleanup as you did
> previously and then set the migration error?

Do you mean doing something similar to what is done in
source_return_path_thread() ?

         if (qemu_file_get_error(s->to_dst_file)) {
             qemu_file_get_error_obj(s->to_dst_file, &err);
     	    if (err) {
         	migrate_set_error(ms, err);
         	error_free(err);
	...

Yes. That would be safer I think.


Nevertheless, I am struggling to understand how qemu_file_set_error()
and migrate_set_error() fit together. I was expecting some kind of
synchronization  routine but there isn't it seems. Are they completely
orthogonal ? when should we use these routines and when not ?

My initial goal was to modify some of the memory handlers (log_global*)
and migration handlers to propagate errors at the QMP level and them
report to the management layer. This is growing in something bigger
and currently, I don't find a good approach to the problem.

The last two patches of this series try to fix the return-path thread
termination. Let's keep that for after.

Thanks,

C.


