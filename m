Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFA2C79FBA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 19:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcqST-0003sO-AE; Mon, 05 Jan 2026 14:41:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqSR-0003s9-Af
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:41:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vcqSP-0003Z5-1N
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 14:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767642094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zC+u1xwGCJpGKPuWoKniiuLj/lYQcyL8GrqWop7bZdA=;
 b=IbtkWF9N4yix3IdIst07+LTxwbP075ZGCHIQ3/tufAxWrwoKpDgh1SJ+zJ8t7a2LgYAqPS
 LO/X/3vspKUT+16no9yicf+iNjSejw6wtKiU9nFb9q5/4JEgJ1EA5VheRrhpWtz7SRFLt2
 OhHaxHjIbmkWsIPIb1hLdt4YTnuhquA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-4lUShztCOBmkOvZKrWb7_Q-1; Mon, 05 Jan 2026 14:41:33 -0500
X-MC-Unique: 4lUShztCOBmkOvZKrWb7_Q-1
X-Mimecast-MFC-AGG-ID: 4lUShztCOBmkOvZKrWb7_Q_1767642092
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-29f29ae883bso3003165ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 11:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767642092; x=1768246892; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zC+u1xwGCJpGKPuWoKniiuLj/lYQcyL8GrqWop7bZdA=;
 b=SX9JfF9eQT+FBIkJBDMzUvX9YGZu2inWU9aOSZNckY1OwPn2z3eJ69TRXsbGYyhnhv
 wTfsoxM+xcWPuLTv7Kk5/3SDLmo3HSdNVEO6lxql0HGHgX7bgYo1nVOZ/xQNXP6RhvRw
 FWUz8yAUUYmKPHzPiFkNorD0Kfnddb2eSccYfpLWWtA2JrCXqCYP2w2SESx/urOBL8G8
 nU/JDawN//fCVcYLScp9N+w/I+TVAUfbLD4ZqGrEEReRen1AAIL3PAmbt9OUE/8rkBRj
 gksEpcmJesXeRt/3IgtMAnxjxQTJDyBTC0UMxssG9PBX9nU9CBzEiHhV01Mj/5dljx12
 gyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767642092; x=1768246892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zC+u1xwGCJpGKPuWoKniiuLj/lYQcyL8GrqWop7bZdA=;
 b=nE9kWN8tXRu++CERH+LTnY0BePjL1yfKlMOfdW3bu8eWe9M0ygpec+eE3q8CtH3Mcc
 NMGKnYntp3cL2VSZlmvGgOLbvq4RzfwQxQ4tBPwyGVcIy8Jh7we5gZEALqgEemaYID2Y
 x9LfYgzMpbCPIc4Pat2cRbc9Oeu6SRL3QP+MMgNDHSQnXgIOHpp9dc473YqJUTKftoR+
 jP1+wlEV2MikzYfbsthb71Dn+2zlk5DSq71hk4eJgvlpYSB7mdE1FviDPMdDjtnTizSo
 wVLSPD3ShSL3ZdIRhZGM/bO+rk+hbxLzjb6t/pyN+E/2q+DSQjig5Q6/G2kwrvNRvYJv
 qPig==
X-Gm-Message-State: AOJu0YwnVzYwNae/P0OANs8kodtEDIW+p7Ftiw8zfTtQW6su8UdBomui
 77CjNjp/zNE1Vr6MFUyk4CuvywCICtYGvGI8smvq5b1uz/Jf1TMupoeCB0KH1aqE/piazNzVsX2
 8ZTnZojAV7ohzjHBYlIOFK0YbHq2BGjk0PgiC5d/WsYvIFNMKE/TYx8oU
X-Gm-Gg: AY/fxX6xxF2m3cX9U1JlOYNyZLXlTv4X8CI3fsQYNuSWlUVKXrvrAJL/r5l8pPtrS/9
 RkLb3TCGwznr8eiKkaHVp2WYK6hmxJcIw7okquzD2wwNiAJtrJILO2ATCGwTs3FJKyIhNKbiNmW
 vuPFz7ze0sCpNFOuoDWQFC0QEkgWviIt97piP3VoExnLWi6BmOphpb42EiMrjSY7c2xXsRb641v
 tKpWgfFZdqsgyT4pXalmz0xc0F454Af0pVzldAapAsTNAQ90/6sbVWt6wP3+CKg6GcSPcs07y2u
 XPPVKO2PfB8q0Y2hpXBQVqt88TMpRjEXnmzt60CRboZomQnaoD4+EI4tUavIN8fI/kVjte0IRVG
 fhYE=
X-Received: by 2002:a05:7022:e995:b0:11b:4351:2687 with SMTP id
 a92af1059eb24-121f18a8988mr449451c88.17.1767642092353; 
 Mon, 05 Jan 2026 11:41:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEycWN32bIne/oUNArrIg3310qg0samBYWXB1PIWseZcYNZJrVftRah14Z6g4BzrwU1ICYuNg==
X-Received: by 2002:a05:7022:e995:b0:11b:4351:2687 with SMTP id
 a92af1059eb24-121f18a8988mr449421c88.17.1767642091739; 
 Mon, 05 Jan 2026 11:41:31 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2b1707d60b1sm32987eec.31.2026.01.05.11.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 11:41:31 -0800 (PST)
Date: Mon, 5 Jan 2026 14:41:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2 15/25] migration: Start incoming from channel.c
Message-ID: <aVwT5_Oyq_oxyoti@x1.local>
References: <20260105190644.14072-1-farosas@suse.de>
 <20260105190644.14072-16-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260105190644.14072-16-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jan 05, 2026 at 04:06:32PM -0300, Fabiano Rosas wrote:
> Leave migration_ioc_process_incoming to do only the channel
> identification process and move the migration start into
> channel.c. Both routines will be renamed in the next patches to better
> reflect their usage.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

One nitpick, as usual.

> ---
>  migration/channel.c   | 12 ++++++++++--
>  migration/channel.h   |  1 +
>  migration/migration.c | 13 +++++--------
>  migration/migration.h |  2 +-
>  4 files changed, 17 insertions(+), 11 deletions(-)
> 
> diff --git a/migration/channel.c b/migration/channel.c
> index 6acce7b2a2..f1c1341a3e 100644
> --- a/migration/channel.c
> +++ b/migration/channel.c
> @@ -33,6 +33,7 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      Error *local_err = NULL;
> +    uint8_t ch;
>  
>      trace_migration_set_incoming_channel(
>          ioc, object_get_typename(OBJECT(ioc)));
> @@ -41,9 +42,16 @@ void migration_channel_process_incoming(QIOChannel *ioc)
>          migration_tls_channel_process_incoming(ioc, &local_err);
>      } else {
>          migration_ioc_register_yank(ioc);
> -        migration_ioc_process_incoming(ioc, &local_err);
> -    }
> +        ch = migration_ioc_process_incoming(ioc, &local_err);
> +        if (!ch) {
> +            goto out;
> +        }
>  
> +        if (migration_incoming_setup(ioc, ch, &local_err)) {
> +            migration_incoming_process();
> +        }
> +    }
> +out:
>      if (local_err) {
>          error_report_err(local_err);
>          migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
> diff --git a/migration/channel.h b/migration/channel.h
> index 93dedbf52b..b45e909597 100644
> --- a/migration/channel.h
> +++ b/migration/channel.h
> @@ -20,6 +20,7 @@
>  
>  /* Migration channel types */
>  enum {

typedef enum { ... } MigChannelType;

Then..

> +    CH_NONE,
>      CH_MAIN,
>      CH_MULTIFD,
>      CH_POSTCOPY
> diff --git a/migration/migration.c b/migration/migration.c
> index 906f0bdab3..8117c74b52 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1034,10 +1034,10 @@ static bool migration_has_main_and_multifd_channels(void)
>      return true;
>  }
>  
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)

.. use it everywhere, including retval.

>  {
>      MigrationIncomingState *mis = migration_incoming_get_current();
> -    uint8_t channel;
> +    uint8_t channel = CH_NONE;
>      uint32_t channel_magic = 0;
>      int ret = 0;
>  
> @@ -1056,7 +1056,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              ret = migration_channel_read_peek(ioc, (void *)&channel_magic,
>                                                sizeof(channel_magic), errp);
>              if (ret != 0) {
> -                return;
> +                goto out;
>              }
>  
>              channel_magic = be32_to_cpu(channel_magic);
> @@ -1071,7 +1071,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>                  channel = CH_MAIN;
>              } else {
>                  error_setg(errp, "unknown channel magic: %u", channel_magic);
> -                return;
>              }
>          } else if (mis->from_src_file && migrate_multifd()) {
>              /*
> @@ -1083,16 +1082,14 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
>              channel = CH_MAIN;
>          } else {
>              error_setg(errp, "non-peekable channel used without multifd");
> -            return;
>          }
>      } else {
>          assert(migrate_postcopy_preempt());
>          channel = CH_POSTCOPY;
>      }
>  
> -    if (migration_incoming_setup(ioc, channel, errp)) {
> -        migration_incoming_process();
> -    }
> +out:
> +    return channel;
>  }
>  
>  /**
> diff --git a/migration/migration.h b/migration/migration.h
> index cd6cfd62ba..c760349b07 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -527,7 +527,7 @@ struct MigrationState {
>  void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
>                         MigrationStatus new_state);
>  
> -void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> +uint8_t migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
>  void migration_incoming_process(void);
>  bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
>  void migration_outgoing_setup(QIOChannel *ioc);
> -- 
> 2.51.0
> 

-- 
Peter Xu


