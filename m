Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DCF5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2y2Z-0004e4-8b; Fri, 03 May 2024 14:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2y2X-0004dN-BX
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:53:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s2y2V-00076g-At
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714762426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JO+eQRrSlIQvMq0ssialyOOWFn4ZHydDFjfl98ddbbA=;
 b=AtncJG9bJBig/qYvMCR2NtBJ45UQGpALz/zAfuspDskPoFoBGPLTGMUCqGGKhYfIyAeMKs
 Vhea/MDsqWT+HBIEWNCqUVw+wysPeeM8bgithEtMQVVgBE6bCgmAwjNHNX7PYUqr5McKdb
 6fZJ1nX6jcwJ3lnxfJI/S/apWtqnhGI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-zc0366t9NQ6dpwk6ExP4AQ-1; Fri, 03 May 2024 14:53:44 -0400
X-MC-Unique: zc0366t9NQ6dpwk6ExP4AQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0dd73810bso27186d6.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714762424; x=1715367224;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JO+eQRrSlIQvMq0ssialyOOWFn4ZHydDFjfl98ddbbA=;
 b=XDg+5mOJNxz+b2CtIifjshS/qO6qZnOp+OHdkbiwqNyD/v7AFpmEdVQqrZpgZ/0ZYJ
 Gyk5HLxOBDUZsYAvxiK/K699inprj9LfHLvgmgPtvG2ExV0wdqEnXESJqJoBMTFlbToM
 MzpRjXmSc9HPP1yRjzXdR+d25XbogY8kgX1AxgmoUEUpbBhbX0DP3BXNwYPI+9ZaK9h1
 A3YXXvEdiMBeFGth5SfVnW/XjHQlP+48iJg4LRRwcOBBe+SMPUMoOQL4kiTDbSXj4s/4
 bcBwmEDMNmnYUBaY46ZAOnh7roPArOyAW7f1kMQ+boqMd9UfQ2JB6EtQDuELkHUzHllF
 y47g==
X-Gm-Message-State: AOJu0YxbuylldeTN0dCnTWnZ83QpJB4Z6pQYSRX8Xq+PK7GZ2Rr2vYCB
 LasbUPU5EBvEbOcp2NeL+0k/ERVP86aSJCCO4F7caQm14XvnLjIgPONemItt7meWiEv7Gs/dPjN
 YgQP4uGy4kk5Y9BpMEC+3QM0SmXfQi3VqnXBu4iT70aYlZLIh5nnP
X-Received: by 2002:ac8:5d0e:0:b0:43a:2677:785c with SMTP id
 f14-20020ac85d0e000000b0043a2677785cmr3656984qtx.4.1714762423872; 
 Fri, 03 May 2024 11:53:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUmlZ1MzSw1GSmDEtoSnuUpoGOpfVxvm1bCDUGy4jxRnGc+X8HHPweEyjtpwYNyTBzCQe2wA==
X-Received: by 2002:ac8:5d0e:0:b0:43a:2677:785c with SMTP id
 f14-20020ac85d0e000000b0043a2677785cmr3656949qtx.4.1714762423145; 
 Fri, 03 May 2024 11:53:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 fy5-20020a05622a5a0500b00437a6e5b3fdsm1831959qtb.66.2024.05.03.11.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 11:53:42 -0700 (PDT)
Date: Fri, 3 May 2024 14:53:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH 7/9] monitor: fdset: Match against O_DIRECT
Message-ID: <ZjUyta-q8GuTDDjJ@x1n>
References: <20240426142042.14573-1-farosas@suse.de>
 <20240426142042.14573-8-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240426142042.14573-8-farosas@suse.de>
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

On Fri, Apr 26, 2024 at 11:20:40AM -0300, Fabiano Rosas wrote:
> We're about to enable the use of O_DIRECT in the migration code and
> due to the alignment restrictions imposed by filesystems we need to
> make sure the flag is only used when doing aligned IO.
> 
> The migration will do parallel IO to different regions of a file, so
> we need to use more than one file descriptor. Those cannot be obtained
> by duplicating (dup()) since duplicated file descriptors share the
> file status flags, including O_DIRECT. If one migration channel does
> unaligned IO while another sets O_DIRECT to do aligned IO, the
> filesystem would fail the unaligned operation.
> 
> The add-fd QMP command along with the fdset code are specifically
> designed to allow the user to pass a set of file descriptors with
> different access flags into QEMU to be later fetched by code that
> needs to alternate between those flags when doing IO.
> 
> Extend the fdset matching to behave the same with the O_DIRECT flag.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  monitor/fds.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/monitor/fds.c b/monitor/fds.c
> index 4ec3b7eea9..62e324fcec 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -420,6 +420,11 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>          int fd = -1;
>          int dup_fd;
>          int mon_fd_flags;
> +        int mask = O_ACCMODE;
> +
> +#ifdef O_DIRECT
> +        mask |= O_DIRECT;
> +#endif
>  
>          if (mon_fdset->id != fdset_id) {
>              continue;
> @@ -431,7 +436,7 @@ int monitor_fdset_dup_fd_add(int64_t fdset_id, int flags)
>                  return -1;
>              }
>  
> -            if ((flags & O_ACCMODE) == (mon_fd_flags & O_ACCMODE)) {
> +            if ((flags & mask) == (mon_fd_flags & mask)) {
>                  fd = mon_fdset_fd->fd;
>                  break;
>              }

I think I see what you wanted to do, picking out the right fd out of two
when qemu_open_old(), which makes sense.

However what happens if the mgmt app only passes in 1 fd to the fdset?  The
issue is we have a "fallback dup()" plan right after this chunk of code:

        dup_fd = qemu_dup_flags(fd, flags);
        if (dup_fd == -1) {
            return -1;
        }

        mon_fdset_fd_dup = g_malloc0(sizeof(*mon_fdset_fd_dup));
        mon_fdset_fd_dup->fd = dup_fd;
        QLIST_INSERT_HEAD(&mon_fdset->dup_fds, mon_fdset_fd_dup, next);

I think it means even if the mgmt app only passes in 1 fd (rather than 2,
one with O_DIRECT, one without), QEMU can always successfully call
qemu_open_old() twice for each case, even though silently the two FDs will
actually impact on each other.  This doesn't look ideal if it's true.

But I also must confess I don't really understand this code at all: we
dup(), then we try F_SETFL on all the possible flags got passed in.
However AFAICT due to the fact that dup()ed FDs will share "struct file" it
means mostly all flags will be shared, except close-on-exec.  I don't ever
see anything protecting that F_SETFL to only touch close-on-exec, I think
it means it'll silently change file status flags for the other fd which we
dup()ed from.  Does it mean that we have issue already with such dup() usage?

Thanks,

-- 
Peter Xu


