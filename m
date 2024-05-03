Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDB9C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 16:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2vMu-0002jf-3y; Fri, 03 May 2024 12:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2vMs-0002iQ-8q
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:02:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2vMp-00071D-Fy
 for qemu-devel@nongnu.org; Fri, 03 May 2024 12:02:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714752153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jeos8eAKqQHao55tUtgw/MrPF1wEOOPBHC4g/m8vJJQ=;
 b=UEtYaHxS+PXaEJs/F/keLalpWf8Vey/lpKCSy/hM8uRNzSXGacsK8zwUGHJVA61idP4EZ4
 7nmAB95u7SEnUWNiEygjU4SbX8lyyR63JeVjzGohfEQqLqRZ8SM07/UQLQ8NswgGbuBc/O
 rhA7Thx8kqkGEBJUpfLn2Fe+bUIgUwA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-Ve8CJ60hOFaAIuwxLWuTMQ-1; Fri, 03 May 2024 12:02:32 -0400
X-MC-Unique: Ve8CJ60hOFaAIuwxLWuTMQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6a0e61203ecso13529366d6.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 09:02:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714752150; x=1715356950;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jeos8eAKqQHao55tUtgw/MrPF1wEOOPBHC4g/m8vJJQ=;
 b=C96MxF7wJI2NrteeZ1G0SP0ACQvWR1Nx2Euq8KWSCJHvE04/BwQMkXWleuCa/dcQeL
 OJi54M8RV4O524tcloLQ2ZsBLFTdiZX6E6uxtd5fuBAjXGdtTPHqwmHbrxksDap4tEJH
 jlvKeqFOw7eYjuNihRGABCKfrTmhTzXfXQtuliYUQ98d5r4rUVy5HTedlQq14MkTtaw1
 kJBkCpIJLk4WG6sbkFIM1Rry/f6FzjY+k1U08r1mgCHcKOoBvggmpL3lePY4qUAQok7n
 MrWfBk62zUAE0OKxYTs0anTHFRUCIHC1V+upH9uSwSZ1E7ESPpuFN6ku0BTpQ7X5XImJ
 b5pQ==
X-Gm-Message-State: AOJu0Yy6nSoAZ3P5i5DVYITH3M5g7Fo4hzjI563R0+01f2YTXlQoZyVk
 tTQ7dNwUK66uGgus/uutvVUzZXsPPn3Gdx6X/y4O3j7obxB1tp1cixdTMcTDjRvEZef0PPI/v8e
 qGriuC8sAVtIVake+/fX1gNGkwLR1KDPCr/HusiyWBS6biRiUAbKWE9Kv9cfI
X-Received: by 2002:ac8:7fcf:0:b0:43a:a840:69c with SMTP id
 b15-20020ac87fcf000000b0043aa840069cmr3018276qtk.1.1714752150222; 
 Fri, 03 May 2024 09:02:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErkJXqRytAHrXqpQy602DI7xGtgMQ11a+hG2QK5ym3WwVtEZlJLO1VUk+obrfuPCzkSxqfcg==
X-Received: by 2002:ac8:7fcf:0:b0:43a:a840:69c with SMTP id
 b15-20020ac87fcf000000b0043aa840069cmr3018222qtk.1.1714752149535; 
 Fri, 03 May 2024 09:02:29 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fp35-20020a05622a50a300b00439c660ee16sm1695526qtb.84.2024.05.03.09.02.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 09:02:29 -0700 (PDT)
Date: Fri, 3 May 2024 12:02:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>,
 Corey Bryant <coreyb@linux.vnet.ibm.com>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/9] monitor: Honor QMP request for fd removal immediately
Message-ID: <ZjUKk3cNVzAH6IPQ@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.483,
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

On Fri, Apr 26, 2024 at 11:20:34AM -0300, Fabiano Rosas wrote:
> We're enabling using the fdset interface to pass file descriptors for
> use in the migration code. Since migrations can happen more than once
> during the VMs lifetime, we need a way to remove an fd from the fdset
> at the end of migration.
> 
> The current code only removes an fd from the fdset if the VM is
> running. This causes a QMP call to "remove-fd" to not actually remove
> the fd if the VM happens to be stopped.
> 
> While the fd would eventually be removed when monitor_fdset_cleanup()
> is called again, the user request should be honored and the fd
> actually removed. Calling remove-fd + query-fdset shows a recently
> removed fd still present.
> 
> The runstate_is_running() check was introduced by commit ebe52b592d
> ("monitor: Prevent removing fd from set during init"), which by the
> shortlog indicates that they were trying to avoid removing an
> yet-unduplicated fd too early.
> 
> I don't see why an fd explicitly removed with qmp_remove_fd() should
> be under runstate_is_running(). I'm assuming this was a mistake when
> adding the parenthesis around the expression.
> 
> Move the runstate_is_running() check to apply only to the
> QLIST_EMPTY(dup_fds) side of the expression and ignore it when
> mon_fdset_fd->removed has been explicitly set.

I am confused on why the fdset removal is as complicated.  I'm also
wondering here whether it's dropped because we checked against
"mon_refcount == 0", and maybe monitor_fdset_cleanup() is simply called
_before_ a monitor is created?  Why do we need such check on the first
place?

I'm thinking one case where the only QMP monitor got (for some reason)
disconnected, and reconnected again during VM running.  Won't current code
already lead to unwanted removal of mostly all fds due to mon_refcount==0?

I also am confused why ->removed flags is ever needed, and why we can't
already remove the fdsets fds if found matching.

Copy Corey, Eric and Kevin.

> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  monitor/fds.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/monitor/fds.c b/monitor/fds.c
> index d86c2c674c..4ec3b7eea9 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -173,9 +173,9 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>      MonFdsetFd *mon_fdset_fd_next;
>  
>      QLIST_FOREACH_SAFE(mon_fdset_fd, &mon_fdset->fds, next, mon_fdset_fd_next) {
> -        if ((mon_fdset_fd->removed ||
> -                (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
> -                runstate_is_running()) {
> +        if (mon_fdset_fd->removed ||
> +            (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0 &&
> +             runstate_is_running())) {
>              close(mon_fdset_fd->fd);
>              g_free(mon_fdset_fd->opaque);
>              QLIST_REMOVE(mon_fdset_fd, next);
> -- 
> 2.35.3
> 

-- 
Peter Xu


