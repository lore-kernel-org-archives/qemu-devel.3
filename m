Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 900E0CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 14:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyWGI-00060y-Go; Tue, 16 Sep 2025 10:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyWGF-00060E-Si
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uyWGD-0004gS-Mb
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 10:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758031338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjqJU4syondXw0YbzhTPMQpZ7rAn7AS5G0ElTiycx7k=;
 b=EAGj01hjqJONXJ+h8XWii8rGiKSbGB1QGP3j5IpR3PQVeMuUyP6m+RL/KEwkqnzWjgfEXp
 mf/DRhPCkMfEr+0xo5W4RitEe/11eFkYSjBKkfHXuxubxbTyBCFHPhAdKK9t5x8/JwlWIl
 C7YA4pK8TMKhLWtOoED1yKG+vFxKFUo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-WiIZLemSM1Oa7XOmZmPKIw-1; Tue, 16 Sep 2025 10:02:16 -0400
X-MC-Unique: WiIZLemSM1Oa7XOmZmPKIw-1
X-Mimecast-MFC-AGG-ID: WiIZLemSM1Oa7XOmZmPKIw_1758031336
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-82ea379874cso29011185a.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 07:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758031336; x=1758636136;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjqJU4syondXw0YbzhTPMQpZ7rAn7AS5G0ElTiycx7k=;
 b=MejUsieg3Pp35mTbaiGoL93gTznLbTQGIMWg2WMV90tBK3FUOyiCdCUZotZFcuJxaq
 F+oZIX+b7hbx1kXm8b/+I30Zj6mZgdrJwEAdyVSO2MUnJu8mNwZrTdQ+uWRiCt6RkaSX
 05Z6JmQFHoGhs6HH3eUFtE5dwOItWDvGEPanUbYeoaaaSvCOgGmasV3gBEj2N2DuX5Nx
 yUTgFkFLCPIJdJIJgGH8e64Q+H9UIMHX3ddng0JNa1W5/m+JohFGaqEyLpE+K/l8yREL
 WhHowwV2hl1a1XBE0W5mksVltX2cquNUR3n16eogOsKD54FkIedMUBRvqP4p73n92pIz
 v6rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPyafZaYM3O9TubVc+LbNbqyux2Es2DB5XTgpG/0vyTM5Dcg10eBOFteGk/+TTOZ0KVMqLFWYZTA/V@nongnu.org
X-Gm-Message-State: AOJu0YwmNvMjY5RMVMlNyj6+tbz5vgW6bPcQ06nAjTuPKijTTzDA/qgN
 Gmjya+kxjmd9PxpcTyz46vMPWkTwRBX2NgPv79iLy/YapkuQsutmU6Asoe/4CwCkm5gfRhMHmbS
 AzJEAJtkAlKgG27oTfTtcrrodmaIYSBZ3Vqvh8bfUAut7g+Y9/S2681hz
X-Gm-Gg: ASbGncvBqCJgs8sy16heVYuQPfgKFO/DJ9W9geWFgWUqvSpcXchqntHHProORA/TzLC
 rWCKgdp9RXTNO3C12+uBNWr4c7cf8IP2LQpbmBD2ivz8ypvYfBHYck/lF0Iqe5L1WmhNe138RHm
 xgFPHy/0G8roY2Vie9uWbBacAvzLv1HP6UvU0PDQogp9B6ZyO4685/sqgR4uXSounJKCAUqG0b9
 yezrLSjtPE1p8+3Afv4cyzNpX0gdeuc/EqR2w5d/zTfQWofOwEKpDoSRQ1iaKnR3EdvbaOZnB7Q
 mhEaRm40X2PUyojGDRRQgLUHC2qFu12M
X-Received: by 2002:a05:620a:690e:b0:806:b3c1:b85e with SMTP id
 af79cd13be357-823ff3f19f1mr1826256085a.29.1758031335837; 
 Tue, 16 Sep 2025 07:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4SDYmZPNeEpAXGu0Ga0ZyZcas9xltE4RUF3I7OAoPaSyDUTSX5gy3af5Ql8RHhNXjYp1kng==
X-Received: by 2002:a05:620a:690e:b0:806:b3c1:b85e with SMTP id
 af79cd13be357-823ff3f19f1mr1826249385a.29.1758031335147; 
 Tue, 16 Sep 2025 07:02:15 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b639dd11d8sm84555911cf.45.2025.09.16.07.02.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 07:02:14 -0700 (PDT)
Date: Tue, 16 Sep 2025 10:02:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: berrange@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 leiyang@redhat.com, marcandre.lureau@redhat.com,
 Hailiang Zhang <zhanghailiang@xfusion.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v5 05/13] migration: qemu_file_set_blocking(): add errp
 parameter
Message-ID: <aMlt2nEGLt84pHQd@x1.local>
References: <20250916131403.368343-1-vsementsov@yandex-team.ru>
 <20250916131403.368343-6-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916131403.368343-6-vsementsov@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 16, 2025 at 04:13:54PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
> so let's passthrough the errp.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Dan, please still have a look at my reply, and if possible it'll be great
to touch up the commit message if you agree.

https://lore.kernel.org/all/aMlrVHYxhuj1TYYL@x1.local/

Not a big issue even without that, it's OK to me. I confess I do not expect
the assertions to trigger..

Acked-by: Peter Xu <peterx@redhat.com>

> ---
>  migration/colo.c         | 5 ++++-
>  migration/migration.c    | 8 +++++---
>  migration/postcopy-ram.c | 2 +-
>  migration/qemu-file.c    | 4 ++--
>  migration/qemu-file.h    | 2 +-
>  migration/savevm.c       | 4 ++--
>  6 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/colo.c b/migration/colo.c
> index e0f713c837..cf4d71d9ed 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -859,7 +859,10 @@ static void *colo_process_incoming_thread(void *opaque)
>       * coroutine, and here we are in the COLO incoming thread, so it is ok to
>       * set the fd back to blocked.
>       */
> -    qemu_file_set_blocking(mis->from_src_file, true);
> +    if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
> +        error_report_err(local_err);
> +        goto out;
> +    }
>  
>      colo_incoming_start_dirty_log();
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..e1ac4d73c2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -951,7 +951,7 @@ static void migration_incoming_setup(QEMUFile *f)
>  
>      assert(!mis->from_src_file);
>      mis->from_src_file = f;
> -    qemu_file_set_blocking(f, false);
> +    qemu_file_set_blocking(f, false, &error_abort);
>  }
>  
>  void migration_incoming_process(void)
> @@ -971,7 +971,7 @@ static bool postcopy_try_recover(void)
>          /* This should be set already in migration_incoming_setup() */
>          assert(mis->from_src_file);
>          /* Postcopy has standalone thread to do vm load */
> -        qemu_file_set_blocking(mis->from_src_file, true);
> +        qemu_file_set_blocking(mis->from_src_file, true, &error_abort);
>  
>          /* Re-configure the return path */
>          mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
> @@ -4002,7 +4002,9 @@ void migration_connect(MigrationState *s, Error *error_in)
>      }
>  
>      migration_rate_set(rate_limit);
> -    qemu_file_set_blocking(s->to_dst_file, true);
> +    if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
> +        goto fail;
> +    }
>  
>      /*
>       * Open the return path. For postcopy, it is used exclusively. For
> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> index 45af9a361e..0172172343 100644
> --- a/migration/postcopy-ram.c
> +++ b/migration/postcopy-ram.c
> @@ -1909,7 +1909,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
>       * The new loading channel has its own threads, so it needs to be
>       * blocked too.  It's by default true, just be explicit.
>       */
> -    qemu_file_set_blocking(file, true);
> +    qemu_file_set_blocking(file, true, &error_abort);
>      mis->postcopy_qemufile_dst = file;
>      qemu_sem_post(&mis->postcopy_qemufile_dst_done);
>      trace_postcopy_preempt_new_channel();
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index d5c6e7ec61..0f4280df21 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -888,9 +888,9 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
>   *       both directions, and thus changing the blocking on the main
>   *       QEMUFile can also affect the return path.
>   */
> -void qemu_file_set_blocking(QEMUFile *f, bool block)
> +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp)
>  {
> -    qio_channel_set_blocking(f->ioc, block, NULL);
> +    return qio_channel_set_blocking(f->ioc, block, errp);
>  }
>  
>  /*
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index f5b9f430e0..c13c967167 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -71,7 +71,7 @@ void qemu_file_set_error(QEMUFile *f, int ret);
>  int qemu_file_shutdown(QEMUFile *f);
>  QEMUFile *qemu_file_get_return_path(QEMUFile *f);
>  int qemu_fflush(QEMUFile *f);
> -void qemu_file_set_blocking(QEMUFile *f, bool block);
> +bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp);
>  int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
>  void qemu_set_offset(QEMUFile *f, off_t off, int whence);
>  off_t qemu_get_offset(QEMUFile *f);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index fabbeb296a..abe0547f9b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2095,7 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>       * Because we're a thread and not a coroutine we can't yield
>       * in qemu_file, and thus we must be blocking now.
>       */
> -    qemu_file_set_blocking(f, true);
> +    qemu_file_set_blocking(f, true, &error_fatal);
>  
>      /* TODO: sanity check that only postcopiable data will be loaded here */
>      load_res = qemu_loadvm_state_main(f, mis);
> @@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
>      f = mis->from_src_file;
>  
>      /* And non-blocking again so we don't block in any cleanup */
> -    qemu_file_set_blocking(f, false);
> +    qemu_file_set_blocking(f, false, &error_fatal);
>  
>      trace_postcopy_ram_listen_thread_exit();
>      if (load_res < 0) {
> -- 
> 2.48.1
> 

-- 
Peter Xu


