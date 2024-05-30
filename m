Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3091FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 21:06:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCmxx-0000pN-7b; Thu, 30 May 2024 17:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCmxv-0000p9-LD
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:05:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCmxt-0003RV-Kr
 for qemu-devel@nongnu.org; Thu, 30 May 2024 17:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717103136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+VeJQQo06fmgpwxBBWZJgUYtsUFjGiDdcla87MqDuk=;
 b=dwcGpLqdni8Vmvb7MmMZAuOF9X5iCVR3n+hh+tdGefMWBE/941rq8ZUHneC/hMXj3tbcyv
 WF9wnH9BaA788r6wYR1B+GLAPdy7V17Zig13t9jez9+rywl2cI0AGTRz7Jj5l2k4nG6ysv
 PA8nvJnG8fycoaoIZdkZs32dbWwzIz4=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-yARBkz1sN2qgsRxE0jukeg-1; Thu, 30 May 2024 17:05:35 -0400
X-MC-Unique: yARBkz1sN2qgsRxE0jukeg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-792ed3a15ceso13076985a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 14:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717103134; x=1717707934;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+VeJQQo06fmgpwxBBWZJgUYtsUFjGiDdcla87MqDuk=;
 b=w7fth8sGPS2JlBN1Nqbv3kOvIACDohebAUE4MorfMpLWqcy1ZV2lAdlmbLFd2ufORn
 H5BA4s1iRqBISzTjtAvORuR8m8rZaZTZ7ufRYmUALuRN0jobPiXyH7MEG1qMZBVlqGmr
 0KqLzKfm754rcJwr6QfmKg7ZCDmeDLhJTj51MPjuycewWG1Vo1fZOk/2MapipXHWkKqS
 nGd4Uaz+k/iXOIL3U2sU+eFP55l5CyxXF55TxSSFgdu8m5/OEu/sD49WegdNQdLy+5+t
 3fmPN4kwUspnb/6/O5+0oa3WTJTR/G5Vm7vKuuDNw02Zx3Hv61m/+imoGB22JrUXNLH8
 dy7g==
X-Gm-Message-State: AOJu0YwiPXYySBlls2uS590JDLhXgAEyn1PfRrc90M/a9Z3wZBZKEqhK
 dQcDksg5x4W6855QdJw5T1qnTFbpwu/ThSwFdK81hJbwhTLe7ubx9+A8OLHIF0QZ233MjJq2awh
 rGDgjiNK6BKas6yOfE892o0AhygjILIFpss+o2pttPUJWxgNfALdN
X-Received: by 2002:a05:620a:408a:b0:794:f4f1:4326 with SMTP id
 af79cd13be357-794f4f147dcmr17389285a.0.1717103134289; 
 Thu, 30 May 2024 14:05:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNBZ9kXBvQQYQfti+et/cMa+7Lu5NDFMl8bzzxg+FJVv6J6zNhFFPEFrUaY6dvHor995JP0w==
X-Received: by 2002:a05:620a:408a:b0:794:f4f1:4326 with SMTP id
 af79cd13be357-794f4f147dcmr17384685a.0.1717103133511; 
 Thu, 30 May 2024 14:05:33 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794f305f56fsm12313485a.84.2024.05.30.14.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 14:05:32 -0700 (PDT)
Date: Thu, 30 May 2024 17:05:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 06/18] monitor: Stop removing non-duplicated fds
Message-ID: <ZljqGitCeG9-Fi9l@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
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

On Thu, May 23, 2024 at 04:05:36PM -0300, Fabiano Rosas wrote:
> We've been up until now cleaning up any file descriptors that have
> been passed into QEMU and never duplicated[1,2]. A file descriptor
> without duplicates indicates that no part of QEMU has made use of
> it. This approach is starting to show some cracks now that we're
> starting to consume fds from the migration code:
> 
> - Doing cleanup every time the last monitor connection closes works to
>   reap unused fds, but also has the side effect of forcing the
>   management layer to pass the file descriptors again in case of a
>   disconnect/re-connect, if that happened to be the only monitor
>   connection.
> 
>   Another side effect is that removing an fd with qmp_remove_fd() is
>   effectively delayed until the last monitor connection closes.
> 
>   The reliance on mon_refcount is also problematic because it's racy.
> 
> - Checking runstate_is_running() skips the cleanup unless the VM is
>   running and avoids premature cleanup of the fds, but also has the
>   side effect of blocking the legitimate removal of an fd via
>   qmp_remove_fd() if the VM happens to be in another state.
> 
>   This affects qmp_remove_fd() and qmp_query_fdsets() in particular
>   because requesting a removal at a bad time (guest stopped) might
>   cause an fd to never be removed, or to be removed at a much later
>   point in time, causing the query command to continue showing the
>   supposedly removed fd/fdset.
> 
> Note that file descriptors that *have* been duplicated are owned by
> the code that uses them and will be removed after qemu_close() is
> called. Therefore we've decided that the best course of action to
> avoid the undesired side-effects is to stop managing non-duplicated
> file descriptors.
> 
> 1- efb87c1697 ("monitor: Clean up fd sets on monitor disconnect")
> 2- ebe52b592d ("monitor: Prevent removing fd from set during init")
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  monitor/fds.c              | 15 ++++++++-------
>  monitor/hmp.c              |  2 --
>  monitor/monitor-internal.h |  1 -
>  monitor/qmp.c              |  2 --
>  4 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/monitor/fds.c b/monitor/fds.c
> index 101e21720d..f7b98814fa 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -169,6 +169,11 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>  
>  static void monitor_fdset_free(MonFdset *mon_fdset)
>  {
> +    /*
> +     * Only remove an empty fdset. The fds are owned by the user and
> +     * should have been removed with qmp_remove_fd(). The dup_fds are
> +     * owned by QEMU and should have been removed with qemu_close().
> +     */
>      if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
>          QLIST_REMOVE(mon_fdset, next);
>          g_free(mon_fdset);
> @@ -189,9 +194,7 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>      MonFdsetFd *mon_fdset_fd_next;
>  
>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> -        if ((mon_fdset_fd->removed ||
> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> -                runstate_is_running()) {
> +        if (mon_fdset_fd->removed) {

I don't know the code well, but I like it.

>              monitor_fdset_fd_free(mon_fdset_fd);
>          }
>      }
> @@ -206,7 +209,7 @@ void monitor_fdsets_cleanup(void)
>  
>      QEMU_LOCK_GUARD(&mon_fdsets_lock);
>      QLIST_FOREACH_SAFE(mon_fdset, &mon_fdsets, next, mon_fdset_next) {
> -        monitor_fdset_cleanup(mon_fdset);
> +        monitor_fdset_free(mon_fdset);
>      }
>  }
>  
> @@ -479,9 +482,7 @@ void monitor_fdset_dup_fd_remove(int dup_fd)
>              if (mon_fdset_fd_dup->fd == dup_fd) {
>                  QLIST_REMOVE(mon_fdset_fd_dup, next);
>                  g_free(mon_fdset_fd_dup);
> -                if (QLIST_EMPTY(&mon_fdset->dup_fds)) {
> -                    monitor_fdset_cleanup(mon_fdset);
> -                }
> +                monitor_fdset_free(mon_fdset);

This and above changes are not crystal clear to me where the _cleanup()
does extra check "removed" and clean those fds.

I think it'll make it easier for me to understand if this one and the next
are squashed together.  But maybe it's simply because I didn't fully
understand.

>                  return;
>              }
>          }
> diff --git a/monitor/hmp.c b/monitor/hmp.c
> index 69c1b7e98a..460e8832f6 100644
> --- a/monitor/hmp.c
> +++ b/monitor/hmp.c
> @@ -1437,11 +1437,9 @@ static void monitor_event(void *opaque, QEMUChrEvent event)
>              monitor_resume(mon);
>          }
>          qemu_mutex_unlock(&mon->mon_lock);
> -        mon_refcount++;
>          break;
>  
>      case CHR_EVENT_CLOSED:
> -        mon_refcount--;
>          monitor_fdsets_cleanup();
>          break;
>  
> diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
> index 252de85681..cb628f681d 100644
> --- a/monitor/monitor-internal.h
> +++ b/monitor/monitor-internal.h
> @@ -168,7 +168,6 @@ extern bool qmp_dispatcher_co_shutdown;
>  extern QmpCommandList qmp_commands, qmp_cap_negotiation_commands;
>  extern QemuMutex monitor_lock;
>  extern MonitorList mon_list;
> -extern int mon_refcount;
>  
>  extern HMPCommand hmp_cmds[];
>  
> diff --git a/monitor/qmp.c b/monitor/qmp.c
> index a239945e8d..5e538f34c0 100644
> --- a/monitor/qmp.c
> +++ b/monitor/qmp.c
> @@ -466,7 +466,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>          data = qmp_greeting(mon);
>          qmp_send_response(mon, data);
>          qobject_unref(data);
> -        mon_refcount++;
>          break;
>      case CHR_EVENT_CLOSED:
>          /*
> @@ -479,7 +478,6 @@ static void monitor_qmp_event(void *opaque, QEMUChrEvent event)
>          json_message_parser_destroy(&mon->parser);
>          json_message_parser_init(&mon->parser, handle_qmp_command,
>                                   mon, NULL);
> -        mon_refcount--;
>          monitor_fdsets_cleanup();
>          break;
>      case CHR_EVENT_BREAK:

I like this too when mon_refcount can be dropped.  It turns out I like this
patch and the next a lot, and I hope nothing will break.

Aside, you seem to have forgot removal of the "int mon_refcount" in
monitor.c.

-- 
Peter Xu


