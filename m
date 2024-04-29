Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E665C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WrE-00008X-ER; Mon, 29 Apr 2024 15:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Wr9-00005V-G5
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s1Wr3-0001OY-4H
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 15:40:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714419600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GSQe/h2wWeLJ+3w1lyMrdRrd8fBViSgErHzYEf/8Tgo=;
 b=Rt683AuARsXD0SKrNmDe+udsOiTcfuxqw592Ow5DIyGjryMf0V4zpwiWox91vHwcWTpZfY
 i1i/Bfj3pdwQEmTF05Uxjd0r6JujZwEytMYRHT7CdjZpd5K0swGOf7mXNxMqSLdxT8qEG2
 GUa81csPVBr3m/TIIS1P2OHTs2A1k0I=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-7BuPMOSKMICHCwnxtW4JTw-1; Mon, 29 Apr 2024 15:39:58 -0400
X-MC-Unique: 7BuPMOSKMICHCwnxtW4JTw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ab48d18751so1778762a91.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 12:39:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714419597; x=1715024397;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GSQe/h2wWeLJ+3w1lyMrdRrd8fBViSgErHzYEf/8Tgo=;
 b=NPJV/LykPk0usBWI5GFE8NMYs5PExLax00qoVFCyHESyQV8TGsszoA/cFVuyHQo0IS
 SC6fxSPvdEni8ka9i0LcVJ8d+vKKB9ZmHjDSxawLTZRsx3wbN5IbLqfAfAX4y8FjuUj1
 85fkJ9PXIWq9Pcc98DH+iLIzo0VH/yO4j+XmFWp8ZLkJVYlBGxdiIcMQBVIc+pWHe7NM
 6cmbn6tlFl+UHYJXzllwm+XNJ3WS9wkxYDNDB6H0Sdybl3G5lKD7lnrgIkQKycfE6+f0
 ba3IlTFAPs78yDPLsZEyRcmhsFzPM8BhIbJe08grth6bHRCNztD857UbK1nsV/VHc6k3
 k5Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX92tN4soyVoRkn6XJenPTB9wg9E+PC0sReIbZ+nV3HAQAjUenDxIoZLFi1+JKlEk2jQnx0La9Bn1QQd3/JBU/d4Q917mI=
X-Gm-Message-State: AOJu0YyE9S2DQp1HGvGV2fga0Bd+7M3+09Wk/ikUn/ALL/4BxddiZED1
 md2WwSnQ0a8iF7VJ7cULjDr++Nfyv+SictC9SXwmytFv+RGulvCam7h7e0IdxynhvhRu4GQDGSS
 XbW7b5lUpxa4HhyGhP3jfLogSje7/D8W0k/B83NMQUTD21bdOM0H2
X-Received: by 2002:a17:90a:f2c7:b0:2b1:99fd:4eea with SMTP id
 gt7-20020a17090af2c700b002b199fd4eeamr4218504pjb.2.1714419597268; 
 Mon, 29 Apr 2024 12:39:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGugRODFkx/J5SJTkLmKBwsrUVNWGo5hbhOzfykz0dSE5v5z149bXO046vL/j08f2eZJwh8fw==
X-Received: by 2002:a17:90a:f2c7:b0:2b1:99fd:4eea with SMTP id
 gt7-20020a17090af2c700b002b199fd4eeamr4218479pjb.2.1714419596657; 
 Mon, 29 Apr 2024 12:39:56 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 o16-20020a17090aac1000b002a27132ac02sm19478132pjq.2.2024.04.29.12.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Apr 2024 12:39:56 -0700 (PDT)
Date: Mon, 29 Apr 2024 15:39:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 pbonzini@redhat.com, qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH v5 4/5] migration: process_incoming_migration_co():
 rework error reporting
Message-ID: <Zi_3iEr3imN4C80_@x1n>
References: <20240429191426.2327225-1-vsementsov@yandex-team.ru>
 <20240429191426.2327225-5-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429191426.2327225-5-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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

On Mon, Apr 29, 2024 at 10:14:25PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Unify error reporting in the function. This simplifies the following
> commit, which will not-exit-on-error behavior variant to the function.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 58fd5819bc..5489ff96df 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -748,11 +748,12 @@ process_incoming_migration_co(void *opaque)
>      MigrationIncomingState *mis = migration_incoming_get_current();
>      PostcopyState ps;
>      int ret;
> +    Error *local_err = NULL;
>  
>      assert(mis->from_src_file);
>  
>      if (compress_threads_load_setup(mis->from_src_file)) {
> -        error_report("Failed to setup decompress threads");
> +        error_setg(&local_err, "Failed to setup decompress threads");
>          goto fail;
>      }
>  
> @@ -789,16 +790,12 @@ process_incoming_migration_co(void *opaque)
>      }
>  
>      if (ret < 0) {
> -        if (migrate_has_error(s)) {
> -            WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> -                error_report_err(error_copy(s->error));
> -            }
> -        }
> -        error_report("load of migration failed: %s", strerror(-ret));
> +        error_setg(&local_err, "load of migration failed: %s", strerror(-ret));
>          goto fail;
>      }
>  
>      if (colo_incoming_co() < 0) {
> +        error_setg(&local_err, "colo incoming failed");
>          goto fail;
>      }
>  
> @@ -809,6 +806,12 @@ fail:
>                        MIGRATION_STATUS_FAILED);
>      migration_incoming_state_destroy();
>  
> +    if (migrate_has_error(s)) {
> +        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
> +            error_report_err(error_copy(s->error));
> +        }
> +    }
> +    error_report_err(local_err);

Here migrate_has_error() will always return true?  If so we can drop it.

Meanwhile, IMHO it's easier we simply always keep the earliest error we see
and report that only, local_err is just one of the errors and whoever
reaches first will be reported.  Something like:

  migrate_set_error(local_err);
  WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
      error_report_err(error_copy(s->error));
  }
  exit(EXIT_FAILURE);

Then when with the exit-on-error thing:

  migrate_set_error(local_err);
  if (exit_on_error) {
    WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
      error_report_err(error_copy(s->error));
    }
    exit(EXIT_FAILURE);
  }

Would this looks slightly cleaner?

-- 
Peter Xu


