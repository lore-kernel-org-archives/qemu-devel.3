Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D45ECE588
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 20:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snkbq-0002IV-R9; Mon, 09 Sep 2024 16:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkbo-0002Hx-M5
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:03:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snkbn-0004HQ-3i
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 16:03:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725912213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhbnkXGheihLSv4lJou9cvGBVCB3VglRCXYRyn4MeQ0=;
 b=gtWdVq9w/ZKyDikZUaLZQvTvhXZhu0gJOwyhTOx35l42XiCJq8LjNNwquBEg4Yz8JSnF7/
 ACo7Pun+BZfybCw7vFJDRM4xtqYFGjIxJTMLkfCa5ocrb6cvpbXRiIsABkGLnOBzSpvY+X
 +KLuw2o/VyVKkNyiM6a6TxtJekjvHdg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-N9CBnMvvPiWTerksCDynyA-1; Mon, 09 Sep 2024 16:03:30 -0400
X-MC-Unique: N9CBnMvvPiWTerksCDynyA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a32ac034so675851285a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 13:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725912210; x=1726517010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xhbnkXGheihLSv4lJou9cvGBVCB3VglRCXYRyn4MeQ0=;
 b=Hw0SxIFeabdgnYMCa9uP121mWngKrwr3xYrb19tdYPqiT3bnkiNoTOMfC6TDYnEPfu
 eWlVLpSnHRgi93Uco00sENyp/Sk/r3YJxeiUmqiBf304APYnBVrBF7lHR1X74BvFdC6D
 Y5D2ShZZdv8vHexwou4BD99L/MxQ2WjltVSbH2fAHEVJ0jBPVGdFK/2LzRTnQRd8iWLH
 lHeAihxk+fasdiVRr1RpZ5+dsEiwxVuNKRw9/j8gyyfLQXrxL2XEMK0z8h+5YK5lm5eP
 UFhBvH35I1mUrkF1d/55Gf/XTjfEcM6DWXkm5rj4HDQXbhCx09bFSeuPc8JH6YEydjmD
 gDZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnx+cw/xw97xa+LnXM/IlXlFU5W9Vrq9tDONj/aexKXNx+5fVvNaalyzfsPpcppj60jVukjW2Nh+sY@nongnu.org
X-Gm-Message-State: AOJu0YxZhgnTOMXPtKb9b/jMtvpkx9pS02islRq6/GmppYyyxfVBM6+c
 ScEHyV1jSSGG/WUDQWnH6hZupJsUO1w4dOCrrtO6pPbb8WDLLQp/l8I0Hn2Gv6+AKi/Gbg0lHs0
 L26AWSopu+ZLd1thubl03Hkk/HwlLmKfy/5grvRQ9piXPMi5MQcy7
X-Received: by 2002:a05:622a:7295:b0:458:2607:d5a7 with SMTP id
 d75a77b69052e-4582607d83fmr110980201cf.43.1725912210222; 
 Mon, 09 Sep 2024 13:03:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNzIxBCTO2wW/KShGyZVo0GgrsoYQAPpIngnPGjlysooUHxH40QphhCWQKkxJzg5AQiI7Fzg==
X-Received: by 2002:a05:622a:7295:b0:458:2607:d5a7 with SMTP id
 d75a77b69052e-4582607d83fmr110979891cf.43.1725912209830; 
 Mon, 09 Sep 2024 13:03:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822f94e8asm23459561cf.85.2024.09.09.13.03.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 13:03:29 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:03:26 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/17] migration: Add load_finish handler and
 associated functions
Message-ID: <Zt9UjvvbeUZQlGNY@x1n>
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1a7599896decdbae61cee385739dc0badc9b4364.1724701542.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 27, 2024 at 07:54:27PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> load_finish SaveVMHandler allows migration code to poll whether
> a device-specific asynchronous device state loading operation had finished.
> 
> In order to avoid calling this handler needlessly the device is supposed
> to notify the migration code of its possible readiness via a call to
> qemu_loadvm_load_finish_ready_broadcast() while holding
> qemu_loadvm_load_finish_ready_lock.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  include/migration/register.h | 21 +++++++++++++++
>  migration/migration.c        |  6 +++++
>  migration/migration.h        |  3 +++
>  migration/savevm.c           | 52 ++++++++++++++++++++++++++++++++++++
>  migration/savevm.h           |  4 +++
>  5 files changed, 86 insertions(+)
> 
> diff --git a/include/migration/register.h b/include/migration/register.h
> index 4a578f140713..44d8cf5192ae 100644
> --- a/include/migration/register.h
> +++ b/include/migration/register.h
> @@ -278,6 +278,27 @@ typedef struct SaveVMHandlers {
>      int (*load_state_buffer)(void *opaque, char *data, size_t data_size,
>                               Error **errp);
>  
> +    /**
> +     * @load_finish
> +     *
> +     * Poll whether all asynchronous device state loading had finished.
> +     * Not called on the load failure path.
> +     *
> +     * Called while holding the qemu_loadvm_load_finish_ready_lock.
> +     *
> +     * If this method signals "not ready" then it might not be called
> +     * again until qemu_loadvm_load_finish_ready_broadcast() is invoked
> +     * while holding qemu_loadvm_load_finish_ready_lock.

[1]

> +     *
> +     * @opaque: data pointer passed to register_savevm_live()
> +     * @is_finished: whether the loading had finished (output parameter)
> +     * @errp: pointer to Error*, to store an error if it happens.
> +     *
> +     * Returns zero to indicate success and negative for error
> +     * It's not an error that the loading still hasn't finished.
> +     */
> +    int (*load_finish)(void *opaque, bool *is_finished, Error **errp);

The load_finish() semantics is a bit weird, especially above [1] on "only
allowed to be called once if ..." and also on the locks.

It looks to me vfio_load_finish() also does the final load of the device.

I wonder whether that final load can be done in the threads, then after
everything loaded the device post a semaphore telling the main thread to
continue.  See e.g.:

    if (migrate_switchover_ack()) {
        qemu_loadvm_state_switchover_ack_needed(mis);
    }

IIUC, VFIO can register load_complete_ack similarly so it only sem_post()
when all things are loaded?  We can then get rid of this slightly awkward
interface.  I had a feeling that things can be simplified (e.g., if the
thread will take care of loading the final vmstate then the mutex is also
not needed? etc.).

-- 
Peter Xu


