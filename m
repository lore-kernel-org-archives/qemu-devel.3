Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC9CC48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:09:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razph-0004PF-NO; Fri, 16 Feb 2024 10:08:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1razpe-0004OH-R4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:08:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1razpd-0001pF-31
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 10:08:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708096132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZ07LVa/77Fc4t12sB3vin8+61ig5hiQNtDSXR0Gpv0=;
 b=i3qwaAh+NWsizDwGr1aaFhvWPalnQccH09VUg+NGLNs9h1vPCCSaEBxdcwsgyliQzIF5P5
 8hP3SNTXKDuB14+yzm1Vx05eHNXZMVSrBtdBuXxZG2DAJLPanwHyWBsDokJbP7n8NYGVe7
 J7mNmR0h1NcsJHO+8sjF0exR9MkfJwA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-K57b8-7qMEugmIIznfnsQg-1; Fri, 16 Feb 2024 10:08:50 -0500
X-MC-Unique: K57b8-7qMEugmIIznfnsQg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-680118b101fso29487936d6.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 07:08:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708096130; x=1708700930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qZ07LVa/77Fc4t12sB3vin8+61ig5hiQNtDSXR0Gpv0=;
 b=gIC/yacz2AF4ITXogP9lBbPFAhezhBhD9s2yn4tYvLng2dVgZZb0o+L5YEreileEBq
 FsN6gU1e3MXGdCedSA2kZGpTO1ApQhj3+g2/jJtqptmgWCAl+Ze35YBSVyd9O+lVTckD
 UtRn0T4a2M0ycsLlIk7SMdu+i3aW1HyX8pb7aoBT0wuKgMZYA6XAokszSxvUP3rfDyi0
 mSrIpEMqnBJu57lO7Pp/dOuvqCbPi26PDuvxX2YVcsJqgerIGk658YpqDxC/ZGbiIAwo
 oBZdcjgsBIb/iORu0GsK/90OvoCCVUlxou7rRj8hSxbuVgHcF/x4TP+V0WP8ZWJcq48F
 /lMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Xg1Oi+pqnjNG9XDrsERf0O3IYSMkk+0M4E1fIVz/5sW4M4veDPFh0BOF3DVsnZa7BLB2rK5Mk0+8QveiLsX2G2w2Lgs=
X-Gm-Message-State: AOJu0YxNq1tyQAX2uKLbK+kZalBC0XcWZX8TtjULhcghjeYh5Oo/BuGM
 idTGP30YBRmhWybgHnPoaqalFT/f7DFuFvfyKOaqtg9+Mwcoankl2XNbfXl7UdPHLxgiqBnirEG
 HjsZMusC8Ysycut68JHYqo7cS/rMu+ss5+7g2YWJDv8R046zvx2TH
X-Received: by 2002:a05:6214:440c:b0:68f:2e24:6155 with SMTP id
 oj12-20020a056214440c00b0068f2e246155mr3753697qvb.11.1708096130403; 
 Fri, 16 Feb 2024 07:08:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFglHrsORUVtM3PLVrSFQ+QOoehIn+i97kJ5kd5yx0MVh1LvMOZwTohyLiyiO8/4ofC6AVVdg==
X-Received: by 2002:a05:6214:440c:b0:68f:2e24:6155 with SMTP id
 oj12-20020a056214440c00b0068f2e246155mr3753674qvb.11.1708096130005; 
 Fri, 16 Feb 2024 07:08:50 -0800 (PST)
Received: from ?IPV6:2a01:cb19:853d:fa00:f59e:918a:6675:6332?
 ([2a01:cb19:853d:fa00:f59e:918a:6675:6332])
 by smtp.gmail.com with ESMTPSA id
 ff16-20020a0562140bd000b0068cc75f7b3fsm1808571qvb.60.2024.02.16.07.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Feb 2024 07:08:49 -0800 (PST)
Message-ID: <2b7d3773-3cc0-41b1-8dc8-0aff90107771@redhat.com>
Date: Fri, 16 Feb 2024 16:08:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/14] migration: Fix return-path thread exit
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Alex Williamson <alex.williamson@redhat.com>
References: <20240207133347.1115903-1-clg@redhat.com>
 <20240207133347.1115903-15-clg@redhat.com> <87v86zaxtv.fsf@suse.de>
 <50ca9637-bc18-4002-abc3-52c1bb834038@redhat.com> <87mss2pywv.fsf@suse.de>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <87mss2pywv.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
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

Hello Fabiano

On 2/14/24 21:35, Fabiano Rosas wrote:
> Cédric Le Goater <clg@redhat.com> writes:
> 
>> Hello Fabiano
>>
>> On 2/8/24 14:29, Fabiano Rosas wrote:
>>> Cédric Le Goater <clg@redhat.com> writes:
>>>
>>>> In case of error, close_return_path_on_source() can perform a shutdown
>>>> to exit the return-path thread.  However, in migrate_fd_cleanup(),
>>>> 'to_dst_file' is closed before calling close_return_path_on_source()
>>>> and the shutdown fails, leaving the source and destination waiting for
>>>> an event to occur.
>>>
>>> Hi, Cédric
>>>
>>> Are you sure this is not caused by patch 13?
>>
>> It happens with upstream QEMU without any patch.
> 
> I might have taken that "shutdown fails" in the commit message too
> literaly. Anyway, I have a proposed solution:
> 
> -->8--
>  From 729aa7b5b7f130f756d41649fdd0862bd2e90430 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 14 Feb 2024 16:45:43 -0300
> Subject: [PATCH] migration: Join the return path thread before releasing
>   to_dst_file
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The return path thread might hang at a blocking system call. Before
> joining the thread we might need to issue a shutdown() on the socket
> file descriptor to release it. To determine whether the shutdown() is
> necessary we look at the QEMUFile error.
> 
> Make sure we only clean up the QEMUFile after the return path has been
> waited for.

Yes. That's the important part.

> This fixes a hang when qemu_savevm_state_setup() produced an error
> that was detected by migration_detect_error(). That skips
> migration_completion() so close_return_path_on_source() would get
> stuck waiting for the RP thread to terminate.
> 
> At migrate_fd_cleanup() I'm keeping the relative order of joining the
> migration thread and the return path just in case.

That doesn't look necessary. What was the reason to join the migration
thread only when s->to_dst_file is valid ?


> Reported-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

LGTM, it fixes the hang when an error is detected, the migration is
aborted and the VM resumes execution. FWIW,

Tested-by: Cédric Le Goater <clg@redhat.com>

It requires more thorough testing though.

Thanks,

C.




> ---
>   migration/migration.c | 36 ++++++++++++++++--------------------
>   1 file changed, 16 insertions(+), 20 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index ab21de2cad..f0b70e8a9d 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1326,17 +1326,19 @@ static void migrate_fd_cleanup(MigrationState *s)
>   
>       qemu_savevm_state_cleanup();
>   
> +    bql_unlock();
> +    if (s->migration_thread_running) {
> +        qemu_thread_join(&s->thread);
> +        s->migration_thread_running = false;
> +    }
> +    bql_lock();
> +
> +    close_return_path_on_source(s);
> +
>       if (s->to_dst_file) {
>           QEMUFile *tmp;
>   
>           trace_migrate_fd_cleanup();
> -        bql_unlock();
> -        if (s->migration_thread_running) {
> -            qemu_thread_join(&s->thread);
> -            s->migration_thread_running = false;
> -        }
> -        bql_lock();
> -
>           multifd_send_shutdown();
>           qemu_mutex_lock(&s->qemu_file_lock);
>           tmp = s->to_dst_file;
> @@ -1350,12 +1352,6 @@ static void migrate_fd_cleanup(MigrationState *s)
>           qemu_fclose(tmp);
>       }
>   
> -    /*
> -     * We already cleaned up to_dst_file, so errors from the return
> -     * path might be due to that, ignore them.
> -     */
> -    close_return_path_on_source(s);
> -
>       assert(!migration_is_active(s));
>   
>       if (s->state == MIGRATION_STATUS_CANCELLING) {
> @@ -2874,6 +2870,13 @@ static MigThrError postcopy_pause(MigrationState *s)
>       while (true) {
>           QEMUFile *file;
>   
> +        /*
> +         * We're already pausing, so ignore any errors on the return
> +         * path and just wait for the thread to finish. It will be
> +         * re-created when we resume.
> +         */
> +        close_return_path_on_source(s);
> +
>           /*
>            * Current channel is possibly broken. Release it.  Note that this is
>            * guaranteed even without lock because to_dst_file should only be
> @@ -2893,13 +2896,6 @@ static MigThrError postcopy_pause(MigrationState *s)
>           qemu_file_shutdown(file);
>           qemu_fclose(file);
>   
> -        /*
> -         * We're already pausing, so ignore any errors on the return
> -         * path and just wait for the thread to finish. It will be
> -         * re-created when we resume.
> -         */
> -        close_return_path_on_source(s);
> -
>           migrate_set_state(&s->state, s->state,
>                             MIGRATION_STATUS_POSTCOPY_PAUSED);
>   


