Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A897BC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 07:34:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcKdY-0000Y6-2X; Tue, 20 Feb 2024 02:33:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKdW-0000Xr-6p
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:33:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rcKdU-0003DJ-HT
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 02:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708414431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OkIpd5Z1QwybCYLV1Bij0G5s2z9HiyDUvG3x8fxik4U=;
 b=BB8IpVdF88KYV5gHaBuL1EoxH/SrZBGWzd6tfGkoktnMVpxuXhT/hHPa1IvWDw7GFQ5LWo
 9GorvBBjCfsJSjWE0taHjnO23vofPC1lvYi7NEb7GmfjwLiYyyca/GsDYV/oKn0HTrh3nM
 +LcireUHehT4wHhFAO2URWaa/moA2GI=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-Da8NnOETPj-JM7PN8-zmDg-1; Tue, 20 Feb 2024 02:33:48 -0500
X-MC-Unique: Da8NnOETPj-JM7PN8-zmDg-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6e2ea6ca499so1799914a34.1
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 23:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708414428; x=1709019228;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OkIpd5Z1QwybCYLV1Bij0G5s2z9HiyDUvG3x8fxik4U=;
 b=i35HLsYsscGGUbg74M4CJa0v5x8XsvC4evtcsrrMVVNxCnANfLoRu0Mkip1MoJDKhX
 VXT2khTBm2k4jaqX63v9UfOVweRejDmi7+o7LleqWZHH1f7fQ9zigeAi9Z7l2+NoyE7I
 Piy9YzS7d0d2oiyy8e+A5p/qkxf2RUT9rzHrRcx33B31/L8XE855A72afWISID+XV+DB
 cEQ+/d/5uPKRWWE6gGmx5xdFZFU87qh94IG/pKTriLkkdg2UCh/AjhwpwdY3LhHOt2Zt
 Xqd7PAL+t21I8X8ilLwgz28Zm89Rpipa5YBXKfRSXibuZoL1VgvYEIMmaT/g7MbWNIp1
 UgRA==
X-Gm-Message-State: AOJu0YwOEqPXkqX/enU8GhUjrjv0a6cSL/FSWVLSj2W2+5uSl480jiYv
 3XIKprTuiEczelIFyFOh3PjL0BuTwp62oaMofZeqNFrBtDEB7Zq34iCZdwLvrsQhTELj1dKK2cy
 mBjaetqVHarT+xqZwXSdfgJbfUgPWl0r1HbNH0jpgBFhPgYXATxA4
X-Received: by 2002:a05:6358:e49a:b0:176:c1e1:7556 with SMTP id
 by26-20020a056358e49a00b00176c1e17556mr14621473rwb.0.1708414428036; 
 Mon, 19 Feb 2024 23:33:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPqEUIJoGrTqdMMz6EwCUyMRyU5pv67emKgzmJUyH5RQl6cSyvcwtm5wu4mpm+NH3EGPImOQ==
X-Received: by 2002:a05:6358:e49a:b0:176:c1e1:7556 with SMTP id
 by26-20020a056358e49a00b00176c1e17556mr14621451rwb.0.1708414427621; 
 Mon, 19 Feb 2024 23:33:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b18-20020aa78ed2000000b006e39d08cad9sm5035043pfr.176.2024.02.19.23.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Feb 2024 23:33:47 -0800 (PST)
Date: Tue, 20 Feb 2024 15:33:35 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3 10/13] migration: stop vm for cpr
Message-ID: <ZdRVz7gvh-qGNxXZ@x1n>
References: <1707418446-134863-1-git-send-email-steven.sistare@oracle.com>
 <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1707418446-134863-11-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 08, 2024 at 10:54:03AM -0800, Steve Sistare wrote:
> When migration for cpr is initiated, stop the vm and set state
> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
> possibility of ram and device state being out of sync, and guarantees
> that a guest in the suspended state remains suspended, because qmp_cont
> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h |  1 +
>  migration/migration.c    | 32 +++++++++++++++++++++++++-------
>  2 files changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 6dc234b..54c99a3 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -60,6 +60,7 @@ void migration_object_init(void);
>  void migration_shutdown(void);
>  bool migration_is_idle(void);
>  bool migration_is_active(MigrationState *);
> +bool migrate_mode_is_cpr(MigrationState *);
>  
>  typedef enum MigrationEventType {
>      MIG_EVENT_PRECOPY_SETUP,
> diff --git a/migration/migration.c b/migration/migration.c
> index d1fce9e..fc5c587 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1603,6 +1603,11 @@ bool migration_is_active(MigrationState *s)
>              s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
>  }
>  
> +bool migrate_mode_is_cpr(MigrationState *s)
> +{
> +    return s->parameters.mode == MIG_MODE_CPR_REBOOT;
> +}
> +
>  int migrate_init(MigrationState *s, Error **errp)
>  {
>      int ret;
> @@ -2651,13 +2656,14 @@ static int migration_completion_precopy(MigrationState *s,
>      bql_lock();
>      migration_downtime_start(s);
>  
> -    s->vm_old_state = runstate_get();
> -    global_state_store();
> -
> -    ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> -    trace_migration_completion_vm_stop(ret);
> -    if (ret < 0) {
> -        goto out_unlock;
> +    if (!migrate_mode_is_cpr(s)) {
> +        s->vm_old_state = runstate_get();
> +        global_state_store();
> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> +        trace_migration_completion_vm_stop(ret);
> +        if (ret < 0) {
> +            goto out_unlock;
> +        }
>      }
>  
>      ret = migration_maybe_pause(s, current_active_state,
> @@ -3576,6 +3582,7 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = s->state == MIGRATION_STATUS_POSTCOPY_PAUSED;
> +    int ret;
>  
>      /*
>       * If there's a previous error, free it and prepare for another one.
> @@ -3651,6 +3658,17 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          goto fail;
>      }
>  
> +    if (migrate_mode_is_cpr(s)) {
> +        s->vm_old_state = runstate_get();
> +        global_state_store();
> +        ret = migration_stop_vm(RUN_STATE_FINISH_MIGRATE);
> +        trace_migration_completion_vm_stop(ret);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto fail;
> +        }
> +    }

Could we have a helper function for the shared codes?

How about postcopy?  I know it's nonsense to enable postcopy for cpr.. but
iiuc we don't yet forbid an user doing so.  Maybe we should?

> +
>      if (migrate_background_snapshot()) {
>          qemu_thread_create(&s->thread, "bg_snapshot",
>                  bg_migration_thread, s, QEMU_THREAD_JOINABLE);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


