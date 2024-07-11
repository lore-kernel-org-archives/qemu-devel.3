Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 835B8C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRrtY-00037y-Bt; Thu, 11 Jul 2024 07:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRrtR-00036j-Ox
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:23:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sRrtP-0000Rz-Q0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:23:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720696999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0huqPjI6wAGLjUHTG50iB5AUUBEw7ZShfPaeHVBkOqw=;
 b=A0gFTDOyQjULGhN9HtLgiEMOzKwPNK5UBLMf1btqVWhTgENEcM9801xWs9isFcSoNzbQ6c
 sz+w8XicwHwTozR2qt128aFXGAh/+JbogGm/2C7I8ysH82bef5+RXaLnX0krGDj31NgMUK
 YESlAOGWOZ47Hvb+5VjBdrdHp/L6cMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-iukWR7DNOPKGVTOAaBLIRw-1; Thu, 11 Jul 2024 07:23:17 -0400
X-MC-Unique: iukWR7DNOPKGVTOAaBLIRw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3679aa0ee0aso391561f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 04:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720696996; x=1721301796;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0huqPjI6wAGLjUHTG50iB5AUUBEw7ZShfPaeHVBkOqw=;
 b=BJ0m0VbTUio1KWbBA65NgiTtCKMExtqaocJNMf1F/ewNmt4EYCwNA4BllDP4AkKqC1
 6iw6H3yhouUl9CG2xQQEbxejxDp5loW41+Ah+uxuBDidbdqGowIIzHM7o8JJeEnjY8NQ
 nmeDin+DuTHzaZqY5SU6Ecx12b+KcuvfYEIxr549ZgAfZY7wcj96WkuCKZrmbJWa/k/H
 jq435eA9lhW8x0JyJfA6OxwbZPpXXcTO+4XEMovm7DejvsoYrZl8423YiooKo4Ed03VW
 B/2pls77j99L4pMJ5Px5mR+rRINnYWF8MZ2tDHyA2DF56gRlWUT/XBFEnx3NxcBqff2H
 pfOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr3Z1WqupESqwyJ0WL+Fm8h5wVsmuVmo+c+gDJzuN5g2SLUEtqsF+EptZvADC0bjnBwsI9YXPsdOPgW4j99esAGxxxTo0=
X-Gm-Message-State: AOJu0YzfXb7clH6fDIilrZuroEB6L2CYiuWKbYC8napJkZ57QIFHJQ1w
 Ihy+SJiL/cGQvi9HlZHuQsnJMC/y098/AclzFNkzLqi4MSq4ECyHGWiZQkJIWh4Frcz3gKvcZEy
 EU3gwF2V0g6Rjn9dseL3i58OnHLUnqu139ZN6LEhWy87cKqMo4UY0
X-Received: by 2002:a05:6000:1a42:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-367ceac4899mr4280590f8f.49.1720696996486; 
 Thu, 11 Jul 2024 04:23:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/2U57UJyl6o8lZ3R5X3AlDTLeQeTkeFvv16+BZeTlwspH84WYppNjbx+73ACMYMzdthyADQ==
X-Received: by 2002:a05:6000:1a42:b0:367:83e9:b4a5 with SMTP id
 ffacd0b85a97d-367ceac4899mr4280580f8f.49.1720696996013; 
 Thu, 11 Jul 2024 04:23:16 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-367cdfab111sm7443061f8f.97.2024.07.11.04.23.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 04:23:15 -0700 (PDT)
Message-ID: <1cfb54b4-0b13-46ef-881c-5acb71fe56fc@redhat.com>
Date: Thu, 11 Jul 2024 13:23:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] chardev: add a mutex to protect IOWatchPoll::src
To: Sergey Dyasli <sergey.dyasli@nutanix.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
References: <20240711095106.185377-1-sergey.dyasli@nutanix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240711095106.185377-1-sergey.dyasli@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On 7/11/24 11:51, Sergey Dyasli wrote:
> After 038b4217884c ("Revert "chardev: use a child source for qio input
> source"") we've been observing the "iwp->src == NULL" assertion
> triggering periodically during the initial capabilities querying by
> libvirtd. One of possible backtraces:

Hi Sergey,

thanks for the analysis!

I noticed however that this comment is really old; it was added from 
commit 2b316774f60 ("qemu-char: do not operate on sources from finalize 
callbacks", 2013-04-22):

     /* Due to a glib bug, removing the last reference to a source
      * inside a finalize callback causes recursive locking (and a
      * deadlock).  This is not a problem inside other callbacks,
      * including dispatch callbacks, so we call io_remove_watch_poll
      * to remove this source.  At this point, iwp->src must
      * be NULL, or we would leak it.
      *
      * This would be solved much more elegantly by child sources,
      * but we support older glib versions that do not have them.
      */

and the original mailing list message points to a problem on RHEL6 and 
Wheezy, which were both relatively old in 2013.  And in fact the issue 
with finalize had been fixed in glib in 2010:

     commit b358202856682e5cdefb0b4b8aaed3a45d9a85fa
     Author: Dan Winship <danw@gnome.org>
     Date:   Sat Nov 6 09:35:25 2010 -0400

     gmain: move finalization of GSource outside of context lock

     This avoids ugly deadlock situations such as in
     https://bugzilla.gnome.org/show_bug.cgi?id=586432

     https://bugzilla.gnome.org/show_bug.cgi?id=626702

     https://bugzilla.gnome.org/show_bug.cgi?id=634239

diff --git a/glib/gmain.c b/glib/gmain.c
index b182c6607..301adb0a7 100644
--- a/glib/gmain.c
+++ b/glib/gmain.c
@@ -1520,7 +1520,13 @@ g_source_unref_internal (GSource      *source,
         g_source_list_remove (source, context);

        if (source->source_funcs->finalize)
-       source->source_funcs->finalize (source);
+       {
+         if (context)
+           UNLOCK_CONTEXT (context);
+         source->source_funcs->finalize (source);
+         if (context)
+           LOCK_CONTEXT (context);
+       }

        g_free (source->name);
        source->name = NULL;

So I think we should just revert commit 2b316774f60, which is not hard 
to do (if it works) even if the code has since moved from qemu-char.c to 
chardev/char-io.c.

Thanks,

Paolo

> Thread 1 (Thread 0x7f16cd4f0700 (LWP 43858)):
> 0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50
> 1  0x00007f16c6c21e65 in __GI_abort () at abort.c:79
> 2  0x00007f16c6c21d39 in __assert_fail_base  at assert.c:92
> 3  0x00007f16c6c46e86 in __GI___assert_fail (assertion=assertion@entry=0x562e9bcdaadd "iwp->src == NULL", file=file@entry=0x562e9bcdaac8 "../chardev/char-io.c", line=line@entry=99, function=function@entry=0x562e9bcdab10 <__PRETTY_FUNCTION__.20549> "io_watch_poll_finalize") at assert.c:101
> 4  0x0000562e9ba20c2c in io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:99
> 5  io_watch_poll_finalize (source=<optimized out>) at ../chardev/char-io.c:88
> 6  0x00007f16c904aae0 in g_source_unref_internal () from /lib64/libglib-2.0.so.0
> 7  0x00007f16c904baf9 in g_source_destroy_internal () from /lib64/libglib-2.0.so.0
> 8  0x0000562e9ba20db0 in io_remove_watch_poll (source=0x562e9d6720b0) at ../chardev/char-io.c:147
> 9  remove_fd_in_watch (chr=chr@entry=0x562e9d5f3800) at ../chardev/char-io.c:153
> 10 0x0000562e9ba23ffb in update_ioc_handlers (s=0x562e9d5f3800) at ../chardev/char-socket.c:592
> 11 0x0000562e9ba2072f in qemu_chr_fe_set_handlers_full at ../chardev/char-fe.c:279
> 12 0x0000562e9ba207a9 in qemu_chr_fe_set_handlers at ../chardev/char-fe.c:304
> 13 0x0000562e9ba2ca75 in monitor_qmp_setup_handlers_bh (opaque=0x562e9d4c2c60) at ../monitor/qmp.c:509
> 14 0x0000562e9bb6222e in aio_bh_poll (ctx=ctx@entry=0x562e9d4c2f20) at ../util/async.c:216
> 15 0x0000562e9bb4de0a in aio_poll (ctx=0x562e9d4c2f20, blocking=blocking@entry=true) at ../util/aio-posix.c:722
> 16 0x0000562e9b99dfaa in iothread_run (opaque=0x562e9d4c26f0) at ../iothread.c:63
> 17 0x0000562e9bb505a4 in qemu_thread_start (args=0x562e9d4c7ea0) at ../util/qemu-thread-posix.c:543
> 18 0x00007f16c70081ca in start_thread (arg=<optimized out>) at pthread_create.c:479
> 19 0x00007f16c6c398d3 in clone () at ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
> 
> io_remove_watch_poll(), which makes sure that iwp->src is NULL, calls
> g_source_destroy() which finds that iwp->src is not NULL in the finalize
> callback. This can only happen if another thread has managed to trigger
> io_watch_poll_prepare() callback in the meantime.
> 
> Introduce a mutex and a boolean variable to prevent other threads
> creating a watch in io_watch_poll_prepare() in case that the IOWatchPoll
> itself is about to get destroyed.
> 
> Signed-off-by: Sergey Dyasli <sergey.dyasli@nutanix.com>
> ---
>   chardev/char-io.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/chardev/char-io.c b/chardev/char-io.c
> index dab77b112e35..b1edccf0cc85 100644
> --- a/chardev/char-io.c
> +++ b/chardev/char-io.c
> @@ -34,6 +34,9 @@ typedef struct IOWatchPoll {
>       GSourceFunc fd_read;
>       void *opaque;
>       GMainContext *context;
> +
> +    QemuMutex mut;
> +    bool dead;
>   } IOWatchPoll;
>   
>   static IOWatchPoll *io_watch_poll_from_source(GSource *source)
> @@ -62,10 +65,20 @@ static gboolean io_watch_poll_prepare(GSource *source,
>        * more data.
>        */
>       if (now_active) {
> +        qemu_mutex_lock(&iwp->mut);
> +
> +        /* Don't create a watch if we are about to be destroyed. */
> +        if (iwp->dead) {
> +            qemu_mutex_unlock(&iwp->mut);
> +            return FALSE;
> +        }
> +
>           iwp->src = qio_channel_create_watch(
>               iwp->ioc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL);
>           g_source_set_callback(iwp->src, iwp->fd_read, iwp->opaque, NULL);
>           g_source_attach(iwp->src, iwp->context);
> +
> +        qemu_mutex_unlock(&iwp->mut);
>       } else {
>           g_source_destroy(iwp->src);
>           g_source_unref(iwp->src);
> @@ -97,6 +110,7 @@ static void io_watch_poll_finalize(GSource *source)
>        */
>       IOWatchPoll *iwp = io_watch_poll_from_source(source);
>       assert(iwp->src == NULL);
> +    qemu_mutex_destroy(&iwp->mut);
>   }
>   
>   static GSourceFuncs io_watch_poll_funcs = {
> @@ -124,6 +138,8 @@ GSource *io_add_watch_poll(Chardev *chr,
>       iwp->fd_read = (GSourceFunc) fd_read;
>       iwp->src = NULL;
>       iwp->context = context;
> +    qemu_mutex_init(&iwp->mut);
> +    iwp->dead = false;
>   
>       name = g_strdup_printf("chardev-iowatch-%s", chr->label);
>       g_source_set_name((GSource *)iwp, name);
> @@ -139,11 +155,16 @@ static void io_remove_watch_poll(GSource *source)
>       IOWatchPoll *iwp;
>   
>       iwp = io_watch_poll_from_source(source);
> +
> +    qemu_mutex_lock(&iwp->mut);
> +    iwp->dead = true;
>       if (iwp->src) {
>           g_source_destroy(iwp->src);
>           g_source_unref(iwp->src);
>           iwp->src = NULL;
>       }
> +    qemu_mutex_unlock(&iwp->mut);
> +
>       g_source_destroy(&iwp->parent);
>   }
>   


