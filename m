Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CB5E9271B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 20:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaJWM-0006X2-Vm; Mon, 29 Dec 2025 15:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJWL-0006WJ-34
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 15:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaJWD-0005Vz-AN
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 15:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767038823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VjWFcz2K4hTWWfN6iCFtTpnqV/f47YvrCvXLgeHCg8E=;
 b=YI5f9B4Aqal6j60n82GMxPw5wRJkLck8L4gD9kg1iERp2R0kT3QtkVmhv+tZ9ROjz1mXLL
 1URi3pdhmHarUScAQ1JBX+yekp02fl2rYgipXVIGkIxZNdOpic64XJyIdaWyCmq15ROeE4
 2I+WjsTD9LMqm9ewKTUR0nNGSU3Lw7I=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-hUL8nUZKM4mkBOVrYdO-Sg-1; Mon, 29 Dec 2025 15:07:01 -0500
X-MC-Unique: hUL8nUZKM4mkBOVrYdO-Sg-1
X-Mimecast-MFC-AGG-ID: hUL8nUZKM4mkBOVrYdO-Sg_1767038820
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4ee1b7293e7so350610771cf.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 12:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767038820; x=1767643620; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VjWFcz2K4hTWWfN6iCFtTpnqV/f47YvrCvXLgeHCg8E=;
 b=RDkyuQ4EALyEbxhka4nvj93Mye4dgg3Hlmc2k2b+Lkg+LHJzCyOcB230KgzXVIKjuc
 00FWRlOKlK/Hzp60yOGgGtNw+tKC4m9vg8Pu65/gYySupVbZct9K/zLTUw1Mji4XhbOn
 RrEPLVtBs3xISRHaM+IPJA+BXAd8hzlR+Uv/8odovmH0Ssy9YMvfa8XdU4umaCRjsLIz
 PyIF5/AWbeqSFoUkuwb1Kmw1BXaewHWMJSLDJp11qePHuIU7wNdemUNJpNJHKlBWnFbE
 VuJpBBXMKj55OIpoQf4erxj7EgIQG3xAtZM7K2gDysg4ewmkxInt8RQclGQJcCwUgZBJ
 MfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767038820; x=1767643620;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VjWFcz2K4hTWWfN6iCFtTpnqV/f47YvrCvXLgeHCg8E=;
 b=s3hrceFSUqFssODa/Jy1vdzSI3XcZn+ltlCWoE/oh4Cq63e4Tukky8uvD1QWgwJ+Tc
 OyW3g1oZbt5HYWZ81UlhMQPXzu3sXf3//3uUaOpMGaFF9RXsR81eoeDicx3YDl13JsYf
 5WQWn+tqX1uiSgEhM5tr4iXcoE+oa+f7CPNFmlIKYNMl/91goEjHgKGnqhMViFYVbumb
 SvctqDgLSb1tKSnbUmg1LDF0UOLpnwLGil4oRLKVd2H4g/kKuTgs1U92OIf8cSbpPPle
 WPpXWXKxv9+2X/tHgcp5Z9l8jZA/y5tzHnuFTRogz7hZHs/2XicC6lGEo68MdcstUSar
 Sw6Q==
X-Gm-Message-State: AOJu0Yzb3ucrwV4ttTadKqVy9mEpTQL7AzfrCH+iwt8Uze1V8279mHbG
 0/YO7lIHkyqdTKSvGkG9fmjVT32Qsab9gwfNTClLqWn9fVtAijnS4FliLUNB/93th9LsYisYD1z
 BzOf7TO3vNOTT/tcm5+7RoMmUmVARv/nLq8M3RKJ0kxSbc/tI46cO+r/I
X-Gm-Gg: AY/fxX5cg7oH0HOYUXR9+Xycyohw4GqRMueGtgHC8UIN02z2g8Is24hkpZL+w8r4kg+
 Ik2epQiRfv89Z6ncNO0am/rwlSbGfDQ1lV5Sahr4GuZzcgDoiJ2+arZIKolqLzDPUelVbMSFYdm
 6J3ph7dL6yqvhQo5nBtFD0OxnhloMHQhlSZ0ffDyLrqqt2I6bTIElSKxa60G5QLCM1NEPOBzAUS
 jw5DWm6wwoP5rjiVDjiDBkNEtkHQBcFAdfi/EYoFettpINO/wF0fESKRNCkBOdXtR8mOipeOWl2
 dZtmWGgVb1JIjtm8zG5shSKM07bezS9JhAi0F60fjWf4sDzNKVTXjEm7h4xT9iB9sUn7vgfmqod
 XnKc=
X-Received: by 2002:a05:622a:4813:b0:4f0:23b6:c285 with SMTP id
 d75a77b69052e-4f4abd80b13mr447928461cf.41.1767038820424; 
 Mon, 29 Dec 2025 12:07:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaHZzMkqlxMmgJt8f0XNHz6eeDEBFYrZmzZsLnl8PAYV/R0ZsV6RomoXEzVAVEy2A48ApJAA==
X-Received: by 2002:a05:622a:4813:b0:4f0:23b6:c285 with SMTP id
 d75a77b69052e-4f4abd80b13mr447927981cf.41.1767038819883; 
 Mon, 29 Dec 2025 12:06:59 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88d973a7f17sm231205506d6.22.2025.12.29.12.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 12:06:59 -0800 (PST)
Date: Mon, 29 Dec 2025 15:06:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 22/25] migration/channel: Merge both sides of the
 connection initiation code
Message-ID: <aVLfYlEwDu3rL3wj@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-23-farosas@suse.de>
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

On Fri, Dec 26, 2025 at 06:19:24PM -0300, Fabiano Rosas wrote:
> Now that everything is in channel.c, it's easier to browse this code
> if it's all in the same place. It's also easier to grasp what the
> connection flow is if both sides of the connection are close together.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/channel.c | 86 +++++++++++++++++++++++----------------------
>  migration/channel.h | 14 ++++++--
>  2 files changed, 56 insertions(+), 44 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 042e01b224..ba9aa1c58b 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -31,10 +31,11 @@
>  #include "trace.h"
>  #include "yank_functions.h"
>  
> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp)
>  {
>      g_autoptr(QIOChannel) ioc = NULL;
>      SocketAddress *saddr;
> +    ERRP_GUARD();
>  
>      switch (addr->transport) {
>      case MIGRATION_ADDRESS_TYPE_SOCKET:
> @@ -44,15 +45,24 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>          case SOCKET_ADDRESS_TYPE_INET:
>          case SOCKET_ADDRESS_TYPE_UNIX:
>          case SOCKET_ADDRESS_TYPE_VSOCK:
> -            socket_connect_outgoing(saddr, errp);
> -            /*
> -             * async: after the socket is connected, calls
> -             * migration_channel_connect_outgoing() directly.
> -             */
> -            return true;
> +            if (out) {

Personally I wouldn't suggest we merge the outgoing / incoming with
migration_connect() then split paths once more in this exact function.

I got this conclusion when I started to count how many "if (out)" are
there..  When there're too much, it may imply we need to think more..

This also answers part of my confusion when reading the previous patch - if
that was only paving way for this one, IMHO it may not be as worthwhile,
and I would tend to avoid both.

Thoughts?

> +                socket_connect_outgoing(saddr, errp);
> +                /*
> +                 * async: after the socket is connected, calls
> +                 * migration_channel_connect_outgoing() directly.
> +                 */
> +                return true;
> +            } else {
> +                socket_connect_incoming(saddr, errp);
> +            }
> +
>              break;
>          case SOCKET_ADDRESS_TYPE_FD:
> -            ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
> +            if (out) {
> +                ioc = fd_connect_outgoing(saddr->u.fd.str, errp);
> +            } else {
> +                fd_connect_incoming(saddr->u.fd.str, errp);
> +            }
>              break;
>          default:
>              g_assert_not_reached();
> @@ -62,16 +72,28 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>  
>  #ifdef CONFIG_RDMA
>      case MIGRATION_ADDRESS_TYPE_RDMA:
> -        ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
> +        if (out) {
> +            ioc = rdma_connect_outgoing(&addr->u.rdma, errp);
> +        } else {
> +            rdma_connect_incoming(&addr->u.rdma, errp);
> +        }
>          break;
>  #endif
>  
>      case MIGRATION_ADDRESS_TYPE_EXEC:
> -        ioc = exec_connect_outgoing(addr->u.exec.args, errp);
> +        if (out) {
> +            ioc = exec_connect_outgoing(addr->u.exec.args, errp);
> +        } else {
> +            exec_connect_incoming(addr->u.exec.args, errp);
> +        }
>          break;
>  
>      case MIGRATION_ADDRESS_TYPE_FILE:
> -        ioc = file_connect_outgoing(&addr->u.file, errp);
> +        if (out) {
> +            ioc = file_connect_outgoing(&addr->u.file, errp);
> +        } else {
> +            file_connect_incoming(&addr->u.file, errp);
> +        }
>          break;
>  
>      default:
> @@ -79,42 +101,22 @@ bool migration_connect_outgoing(MigrationAddress *addr, Error **errp)
>          break;
>      }
>  
> -    if (!ioc) {
> -        return false;
> -    }
> -
> -    migration_channel_connect_outgoing(ioc);
> -    return true;
> -}
> -
> -void migration_connect_incoming(MigrationAddress *addr, Error **errp)
> -{
> -    if (addr->transport == MIGRATION_ADDRESS_TYPE_SOCKET) {
> -        SocketAddress *saddr = &addr->u.socket;
> -        if (saddr->type == SOCKET_ADDRESS_TYPE_INET ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_UNIX ||
> -            saddr->type == SOCKET_ADDRESS_TYPE_VSOCK) {
> -            socket_connect_incoming(saddr, errp);
> -        } else if (saddr->type == SOCKET_ADDRESS_TYPE_FD) {
> -            fd_connect_incoming(saddr->u.fd.str, errp);
> +    if (out) {
> +        if (!ioc) {
> +            return false;
>          }
> -#ifdef CONFIG_RDMA
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_RDMA) {
> -        rdma_connect_incoming(&addr->u.rdma, errp);
> -#endif
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_EXEC) {
> -        exec_connect_incoming(addr->u.exec.args, errp);
> -    } else if (addr->transport == MIGRATION_ADDRESS_TYPE_FILE) {
> -        file_connect_incoming(&addr->u.file, errp);
> -    } else {
> -        error_setg(errp, "unknown migration protocol");
> +
> +        migration_channel_connect_outgoing(ioc);
> +        return true;
>      }
>  
>      /*
> -     * async: the above routines all wait for the incoming connection
> -     * and call back to migration_channel_process_incoming() to start
> -     * the migration.
> +     * async: on the incoming side all of the transport routines above
> +     * wait for the incoming connection and call back to
> +     * migration_channel_process_incoming() to start the migration.
>       */
> +
> +    return !*errp;
>  }
>  
>  bool migration_has_main_and_multifd_channels(void)
> diff --git a/migration/channel.h b/migration/channel.h
> index 8cf16bfda9..86934fee38 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -39,6 +39,16 @@ int migration_channel_read_peek(QIOChannel *ioc,
>  bool migration_has_main_and_multifd_channels(void);
>  bool migration_has_all_channels(void);
>  
> -bool migration_connect_outgoing(MigrationAddress *addr, Error **errp);
> -void migration_connect_incoming(MigrationAddress *addr, Error **errp);
> +bool migration_connect(MigrationAddress *addr, bool out, Error **errp);
> +static inline bool migration_connect_outgoing(MigrationAddress *addr,
> +                                              Error **errp)
> +{
> +    return migration_connect(addr, true, errp);
> +}
> +
> +static inline bool migration_connect_incoming(MigrationAddress *addr,
> +                                              Error **errp)
> +{
> +    return migration_connect(addr, false, errp);
> +}
>  #endif
> -- 
> 2.51.0
> 

-- 
Peter Xu


