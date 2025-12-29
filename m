Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AC5E92FC4
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 19:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJ76-0003Ed-2Z; Mon, 29 Dec 2025 14:41:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJ6s-0002uF-Ur
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:40:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJ6r-0000qL-AN
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 14:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767037252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=twAoBe533cmrg1sqwb9ZFphFISzxH4yWtN9QEHx9MFo=;
 b=NfDMFtpTKQu5ioWjd64RxaQNpGqQRd3k40fx7hqdHxsY2C4EE0iztX92KqWjgqsHWfVxGq
 kOcmoX2hzwbVRjmCz7930VA6RJtoysV8XsmQyD6QvGVUG6Pnxohnzu4uw3u7RHnNaVtekv
 zOUoTiaVElr8ik3mUcGXEiNasUUqw8M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-5BekE4MlM4SzPCxCCcGV5g-1; Mon, 29 Dec 2025 14:40:50 -0500
X-MC-Unique: 5BekE4MlM4SzPCxCCcGV5g-1
X-Mimecast-MFC-AGG-ID: 5BekE4MlM4SzPCxCCcGV5g_1767037250
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c2a3a614b5so80486985a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 11:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767037250; x=1767642050; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=twAoBe533cmrg1sqwb9ZFphFISzxH4yWtN9QEHx9MFo=;
 b=jHGtbZfCeWoI6ICDL/bXp0oXzz1scNtb0QKp41aHrWsg00j4doraxWzy6vAk+u3sri
 wiNAIdcYWrIxpsNH7vnD0HZrBEx1ndOV8YIoM0T46hCmBy9hqcYUDZfqAIpAZZGAxoTf
 eE4xea+MxPqC17fsFbBuKHLcmq0moGyjX59qLvckoLpJwrMYBKGGcwvdLKwee7mVQaWZ
 WVOpSekr6ODyT37P0b+GlhMwMHh8U/7q/YQpBYF+Nt9SlzrIeJMtwyFPmeyAc2mdrzvd
 STidUkHIIOYbTOLhyCkcOkWQCQgRbPvgBY1G6YP/NRRJwKATL7H60lnN/gDFiVnCd+Sw
 nIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767037250; x=1767642050;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=twAoBe533cmrg1sqwb9ZFphFISzxH4yWtN9QEHx9MFo=;
 b=bwzVcc0sB5864LrbzrTDPNgK3Z4WdchSlnhI4t4Qp4KUt5iJBj8lqW4z3wAn7o7fY/
 2RFd637RLC5ceb/hR40aRJIKrn1ElrJ5DRLckRWBMbvV9Ah5hp/a3SQbfasoQuB2eXZm
 7+t0DIPFWA1XgOeuplj4bpGJHLsXTBmpQm9osgR+BMCaUj1/7FexeuFOve34oKwASjbQ
 u4ZXrMoMvQSU6sFRH7sz3LFOFp5JWdH8JCm7xR8zP3WOvLLqDzXNx4ARMl4A6T+3F2Sw
 tY6LA/sg2bZyAcP0Ku4uw9zVFQyLdUpNXKUmmNOD5mmlI+3vkQ+qf6qXlstABHhRBwvA
 s6tQ==
X-Gm-Message-State: AOJu0Yz9GvJta0VsWX8kL5DO7eC8VNE4hXz5jeFSojBUQ7BAWFnyUS6Z
 CSMmUZ3KAg9TKJ4x3LkLcpZC8/aH/+lHidf2pmpkMtIz2IYGhv4s5b9WRlIMKlInLR2Thm5sLkh
 zMHVbhwrGeVDEMAsyQMH0iT+BhBQXI2aqPIhA5qVOxjJMElmVQ4doBy9fB07NrvGb
X-Gm-Gg: AY/fxX4MatB721rMdy/FNVtM35mYhcgX7rNvYVwqfZJ20G5oFLiYi9Po6seB6evoc6D
 y72pFVLpjdghLKaNtrBAxCv6XSiM1ft5MPxdpqf6Jp90agzeg3XeCLlc46j1GkJqgt3bhEfgaQ3
 ENH2+JAHbW2JRwYoQbQGiT5UMZj4/zzIE2eyiyx5uw+zEIUaiWwUZW9Xbxmo6ook6szwPYNKEDT
 ztkawuuNuIcd3KNPnmIXZyZepYlE4byyGUHBn4UiirwtLICDSi62Cq2NuicdCxpkRgmVT+KZ0eo
 ADSgb+YswNTToxy4S6Q0nTA++UOAuPb6BQI02j7adeA4xRju1HlvFpsq4n0Bi1TmnFM48/JjbNo
 XHSo=
X-Received: by 2002:a05:620a:7107:b0:84b:7b84:4ec with SMTP id
 af79cd13be357-8c090028a13mr4771349685a.22.1767037250009; 
 Mon, 29 Dec 2025 11:40:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEBOPvuQKQIYCfR2VsRN98jKKWov9zI+6ZLmzBGwxYVTyGr0ayImG7bQVno733NnzME2elyoQ==
X-Received: by 2002:a05:620a:7107:b0:84b:7b84:4ec with SMTP id
 af79cd13be357-8c090028a13mr4771347285a.22.1767037249493; 
 Mon, 29 Dec 2025 11:40:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0975ee7bfsm2362805185a.51.2025.12.29.11.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 11:40:49 -0800 (PST)
Date: Mon, 29 Dec 2025 14:40:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 15/25] migration/channel: Rename
 migration_channel_connect
Message-ID: <aVLZQBX_RONdYTlT@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Dec 26, 2025 at 06:19:17PM -0300, Fabiano Rosas wrote:
> Rename migration_channel_connect to indicate this is the source
> side. Future patches will do similar changes to the incoming side and
> this will avoid inconsistencies in naming.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

We have a lot of other helpers are using this pattern as names:

  migration_incoming*

So I wonder if we want to unify it with

  migration_outgoing*

?

Said that, I don't think it's always the case, so it's not a rule either.
Adding "outgoing" anywhere should indeed be an improvement already.

Whichever you prefer:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/channel.c | 9 +--------
>  migration/channel.h | 2 +-
>  migration/exec.c    | 2 +-
>  migration/fd.c      | 2 +-
>  migration/file.c    | 2 +-
>  migration/socket.c  | 2 +-
>  migration/tls.c     | 2 +-
>  7 files changed, 7 insertions(+), 14 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index af6c2cc76e..a8a5f26dfd 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -61,14 +61,7 @@ out:
>      }
>  }
>  
> -
> -/**
> - * @migration_channel_connect - Create new outgoing migration channel
> - *
> - * @s: Current migration state
> - * @ioc: Channel to which we are connecting
> - */
> -void migration_channel_connect(MigrationState *s, QIOChannel *ioc)
> +void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
>  {
>      trace_migration_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)));
>  
> diff --git a/migration/channel.h b/migration/channel.h
> index ccfeaaef18..7d3457271d 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -20,7 +20,7 @@
>  
>  void migration_channel_process_incoming(QIOChannel *ioc);
>  
> -void migration_channel_connect(MigrationState *s, QIOChannel *ioc);
> +void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc);
>  
>  int migration_channel_read_peek(QIOChannel *ioc,
>                                  const char *buf,
> diff --git a/migration/exec.c b/migration/exec.c
> index d83a07435a..d1629944dc 100644
> --- a/migration/exec.c
> +++ b/migration/exec.c
> @@ -55,7 +55,7 @@ void exec_start_outgoing_migration(MigrationState *s, strList *command,
>      }
>  
>      qio_channel_set_name(ioc, "migration-exec-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/fd.c b/migration/fd.c
> index 0144a70742..150b236fbf 100644
> --- a/migration/fd.c
> +++ b/migration/fd.c
> @@ -70,7 +70,7 @@ void fd_start_outgoing_migration(MigrationState *s, const char *fdname, Error **
>      }
>  
>      qio_channel_set_name(ioc, "migration-fd-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>      object_unref(OBJECT(ioc));
>  }
>  
> diff --git a/migration/file.c b/migration/file.c
> index 7bb9c1c79f..935402f36b 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -122,7 +122,7 @@ void file_start_outgoing_migration(MigrationState *s,
>          return;
>      }
>      qio_channel_set_name(ioc, "migration-file-outgoing");
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>  }
>  
>  static gboolean file_accept_incoming_migration(QIOChannel *ioc,
> diff --git a/migration/socket.c b/migration/socket.c
> index 298bac30cc..611915f84d 100644
> --- a/migration/socket.c
> +++ b/migration/socket.c
> @@ -73,7 +73,7 @@ static void socket_outgoing_migration(QIOTask *task,
>      }
>  
>      trace_migration_socket_outgoing_connected();
> -    migration_channel_connect(data->s, sioc);
> +    migration_channel_connect_outgoing(data->s, sioc);
>      return;
>  err:
>      trace_migration_socket_outgoing_error(error_get_pretty(err));
> diff --git a/migration/tls.c b/migration/tls.c
> index a54e8e6e14..f68e6a533b 100644
> --- a/migration/tls.c
> +++ b/migration/tls.c
> @@ -114,7 +114,7 @@ static void migration_tls_outgoing_handshake(QIOTask *task,
>      }
>  
>      trace_migration_tls_outgoing_handshake_complete();
> -    migration_channel_connect(s, ioc);
> +    migration_channel_connect_outgoing(s, ioc);
>  }
>  
>  QIOChannelTLS *migration_tls_client_create(QIOChannel *ioc,
> -- 
> 2.51.0
> 

-- 
Peter Xu


