Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0180FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 20:04:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCm0J-0006Dy-NT; Thu, 30 May 2024 16:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCm0H-0006DS-Vl
 for qemu-devel@nongnu.org; Thu, 30 May 2024 16:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sCm0G-0001Nl-AX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 16:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717099438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IuTAyfSz7KQfpGUHD+ESye4y4YLqREi+H2xn7viX1Y=;
 b=Ccw4z+I3UlAIBa2r54nQ2cXQVLnh30gtSMAuKIbIbj7BRxAMxusJmzXpWgHeBY9FCYac2W
 423+1zXKD2dKmbSOGwvnyDL3NpX1f/XsHCukSgQV1CTwiKaJmTUBVQo8ztH4R9478+6nc0
 Gk/bXcvNV2IGWB9SBIx5bhkBZ/W35kE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-lsrSWVGGNQS7STPZJegwYg-1; Thu, 30 May 2024 16:03:56 -0400
X-MC-Unique: lsrSWVGGNQS7STPZJegwYg-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6ad803bc570so3834336d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 13:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717099434; x=1717704234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9IuTAyfSz7KQfpGUHD+ESye4y4YLqREi+H2xn7viX1Y=;
 b=TKPvCyJC9V7Y16bRi+qgx0CrtBFiONZXpvngzd4aEjSOLsNftHLJ/V+KURdGu3EuZO
 8SJY6FL869rN/zveDcQQjJ6sdBQbbU65AV1XzLMxFWOMP17jwaW2jCt2uXp7Gz++bPET
 dXjOzlzAXRcpVZRYZ8MDk7Sh7QZXX+BWnJGFePdEeMsdzSy9Vj3Sx9UqSF9aaSsUPA6P
 bmXlJKiTwcBx4oEaRKzSaoCCmJFHulFXjMjG6DSNosxStgmV/oxGXQQ8kfnp0VssUhpi
 2rH4tmZsfRhVd2kxpLwDHQZyYAdDHpGFo45durgnn9FxGVgmIABAf9/hal/f04wU3mta
 rDBA==
X-Gm-Message-State: AOJu0YxOVHhDJTPWqDKqNLWCOxCO5Hd7npuYPu3+0FUcvnaH1Ji5wCE5
 mMJspGTLwbePe7lLhUI711nFoYbBcoylPsNFeStipJgBJPnBPQfhjHL7qYJa8KmzIcoacximx3r
 Xkg7Bj1lZXS/8aw1kOD531Swh3pJy2NI5TqPIyeqDrkb3VM0aeAIj
X-Received: by 2002:a05:6214:1c0d:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6ae0cf5fd79mr34121756d6.4.1717099434208; 
 Thu, 30 May 2024 13:03:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIaZwXnL8ThyIumoVKwDwUl2QcF7L4fVxYAGe4+fNOOmn4ibFZpWXaso9Cw5lh1b5LXkbUJw==
X-Received: by 2002:a05:6214:1c0d:b0:699:2d88:744f with SMTP id
 6a1803df08f44-6ae0cf5fd79mr34121486d6.4.1717099433527; 
 Thu, 30 May 2024 13:03:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ae4a7462a6sm1366976d6.40.2024.05.30.13.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 13:03:52 -0700 (PDT)
Date: Thu, 30 May 2024 16:03:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>, Jim Fehlig <jfehlig@suse.com>
Subject: Re: [PATCH v2 05/18] monitor: Introduce monitor_fdset_*free
Message-ID: <Zljbptai4sXq4Ai5@x1n>
References: <20240523190548.23977-1-farosas@suse.de>
 <20240523190548.23977-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523190548.23977-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, May 23, 2024 at 04:05:35PM -0300, Fabiano Rosas wrote:
> Introduce two new functions to remove and free no longer used fds and
> fdsets.
> 
> We need those to decouple the remove/free routines from
> monitor_fdset_cleanup() which will go away in the next patches.
> 
> The new functions:
> 
> - monitor_fdset_free() will be used when a monitor connection closes
>   and when an fd is removed to cleanup any fdset that is now empty.
> 
> - monitor_fdset_fd_free() will be used to remove one or more fds that
>   have been explicitly targeted by qmp_remove_fd().
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick below.

> ---
>  monitor/fds.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/monitor/fds.c b/monitor/fds.c
> index fb9f58c056..101e21720d 100644
> --- a/monitor/fds.c
> +++ b/monitor/fds.c
> @@ -167,6 +167,22 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
>      return -1;
>  }
>  
> +static void monitor_fdset_free(MonFdset *mon_fdset)
> +{
> +    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
> +        QLIST_REMOVE(mon_fdset, next);
> +        g_free(mon_fdset);
> +    }
> +}

Would monitor_fdset_free_if_empty() (or similar) slightly better?

static void monitor_fdset_free(MonFdset *mon_fdset)
{
    QLIST_REMOVE(mon_fdset, next);
    g_free(mon_fdset);
}

static void monitor_fdset_free_if_empty(MonFdset *mon_fdset)
{
    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
        monitor_fdset_free(mon_fdset);
    }
}

> +
> +static void monitor_fdset_fd_free(MonFdsetFd *mon_fdset_fd)
> +{
> +    close(mon_fdset_fd->fd);
> +    g_free(mon_fdset_fd->opaque);
> +    QLIST_REMOVE(mon_fdset_fd, next);
> +    g_free(mon_fdset_fd);
> +}
> +
>  static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>  {
>      MonFdsetFd *mon_fdset_fd;
> @@ -176,17 +192,11 @@ static void monitor_fdset_cleanup(MonFdset *mon_fdset)
>          if ((mon_fdset_fd->removed ||
>                  (QLIST_EMPTY(&mon_fdset->dup_fds) && mon_refcount == 0)) &&
>                  runstate_is_running()) {
> -            close(mon_fdset_fd->fd);
> -            g_free(mon_fdset_fd->opaque);
> -            QLIST_REMOVE(mon_fdset_fd, next);
> -            g_free(mon_fdset_fd);
> +            monitor_fdset_fd_free(mon_fdset_fd);
>          }
>      }
>  
> -    if (QLIST_EMPTY(&mon_fdset->fds) && QLIST_EMPTY(&mon_fdset->dup_fds)) {
> -        QLIST_REMOVE(mon_fdset, next);
> -        g_free(mon_fdset);
> -    }
> +    monitor_fdset_free(mon_fdset);
>  }
>  
>  void monitor_fdsets_cleanup(void)
> -- 
> 2.35.3
> 

-- 
Peter Xu


