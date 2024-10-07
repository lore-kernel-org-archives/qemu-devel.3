Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E573CFB446
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxpdo-0008NC-1O; Mon, 07 Oct 2024 11:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpdl-0008Ms-Go
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxpdj-0000EY-P8
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 11:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728314832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A0fxT2GYYQGHk0Lg7E0sdKx0WaKerQzPamF7pzvbEeo=;
 b=dvnxohsaIBZPfWJi9cOFD5+4A+4V8UATW/w5pOb/fPazIsTMmNBr8RoUE3l7S7FQGunbdU
 TEq58mP5l981mM+eyGhdAWvRG6DiCff7LFGVo+twN8JpXLJ774qLAht1MYMIUD9y3qe85a
 tMNTSK/bO0AWxmLxLNs9i4SvKXWb+Gw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-dbrZQ485MGickY_0FpoTVA-1; Mon, 07 Oct 2024 11:27:10 -0400
X-MC-Unique: dbrZQ485MGickY_0FpoTVA-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e28690bc290so6699839276.1
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 08:27:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314829; x=1728919629;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A0fxT2GYYQGHk0Lg7E0sdKx0WaKerQzPamF7pzvbEeo=;
 b=X2mLOG+uK39xNtmF2cRh9iFmnzDC/yqMzZ8UmlEc0G+FWMCAc51jwLmHAQyVoMIvUG
 3KwVOodRsbUujE1wPimgxrZBCAk58ZD5XnPz1onDkYmjXt4OFYiPsziHsTu4R0k9oOU/
 X5zy4+JxTtfadANj74POyzR5dZAXOddyEKIpXdUd0pqC2CmcibH4fP4GQHTBf1y0rV1f
 FGjOMpVi0AmKpI9fUC+TRsrm19Bhs6t7C7xAFmPgdsySXRaSZJiBIOuz8Pm2vsEjbEn1
 p+NBHdGINntRRhoAqcrzYlVcwOO4xbIT+oV9W38lo1Rgh9IoY+tL+z5IRDCtg8rsSeOe
 ay9Q==
X-Gm-Message-State: AOJu0YyUDOATujewHb2tkPHiwuAXHKVWtjxTdazh4C+by1FBD+tZ7071
 VQZfszjCWkygQQt13IZMNIKgTNe0APZT9IuR4h7NcIrChSR8J8rt13lqgBVWA1BBWdD+lT9NDJD
 pD1UWF9XEPhse2utTSDflFLAXVD3jvmSvA/kB6UA1MitbCLSlIg+G
X-Received: by 2002:a05:6902:2747:b0:e1d:9ccf:86ba with SMTP id
 3f1490d57ef6-e28939019cbmr7955421276.4.1728314829619; 
 Mon, 07 Oct 2024 08:27:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc07AKeSh36XLDFZuZ+kY/LKb2qlo9X7QjNe2XVj7glTV3xcD/CX3nL/sNHYiR7pYT5+J83g==
X-Received: by 2002:a05:6902:2747:b0:e1d:9ccf:86ba with SMTP id
 3f1490d57ef6-e28939019cbmr7955406276.4.1728314829309; 
 Mon, 07 Oct 2024 08:27:09 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba46df927sm26625086d6.40.2024.10.07.08.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 08:27:08 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:27:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 04/13] migration: stop vm earlier for cpr
Message-ID: <ZwP9ynimqzlmJ3uT@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1727725244-105198-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Sep 30, 2024 at 12:40:35PM -0700, Steve Sistare wrote:
> Stop the vm earlier for cpr, to guarantee consistent device state when
> CPR state is saved.

Could you add some more info on why this order matters?

E.g., qmp_migrate should switch migration state machine to SETUP, while
this path holds BQL, I think it means there's no way devices got hot added
concurrently of the whole process.

Would other things change in the cpr states (name, fd, etc.)?  It'll be
great to mention these details in the commit message.

Thanks,

> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/migration.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index df00e5c..868bf0e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2082,6 +2082,7 @@ void qmp_migrate(const char *uri, bool has_channels,
>      MigrationState *s = migrate_get_current();
>      g_autoptr(MigrationChannel) channel = NULL;
>      MigrationAddress *addr = NULL;
> +    bool stopped = false;
>  
>      /*
>       * Having preliminary checks for uri and channel
> @@ -2125,6 +2126,15 @@ void qmp_migrate(const char *uri, bool has_channels,
>          }
>      }
>  
> +    if (migrate_mode_is_cpr(s)) {
> +        int ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> +        if (ret < 0) {
> +            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> +            goto out;
> +        }
> +        stopped = true;
> +    }
> +
>      if (cpr_state_save(&local_err)) {
>          goto out;
>      }
> @@ -2160,6 +2170,9 @@ out:
>          }
>          migrate_fd_error(s, local_err);
>          error_propagate(errp, local_err);
> +        if (stopped) {
> +            vm_resume(s->vm_old_state);
> +        }
>          return;
>      }
>  }
> @@ -3743,7 +3756,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>      Error *local_err = NULL;
>      uint64_t rate_limit;
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
> -    int ret;
>  
>      /*
>       * If there's a previous error, free it and prepare for another one.
> @@ -3815,14 +3827,6 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
>          return;
>      }
>  
> -    if (migrate_mode_is_cpr(s)) {
> -        ret = migration_stop_vm(s, RUN_STATE_FINISH_MIGRATE);
> -        if (ret < 0) {
> -            error_setg(&local_err, "migration_stop_vm failed, error %d", -ret);
> -            goto fail;
> -        }
> -    }
> -
>      if (migrate_background_snapshot()) {
>          qemu_thread_create(&s->thread, "mig/snapshot",
>                  bg_migration_thread, s, QEMU_THREAD_JOINABLE);
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


