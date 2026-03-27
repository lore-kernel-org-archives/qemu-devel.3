Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D4A10F285A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:08:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Aey-00078T-W9; Fri, 27 Mar 2026 13:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6Aex-00077e-6X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6Aev-0000Sb-FJ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774631264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4vDLI2IfMUsCyYXrEI9ZK+/g2AAeGVbn41NHRVP4L6o=;
 b=Jr18HShhpz3hSCr3JttUs4tdSUsVIrYxzpzy9rlwpsOMk5OrL7hi4ENtLn4xwmcRt18ab+
 7YwqNVeWO6rdjPjrr9HSdWEZHAJWu3miTwyOATS8UYHjiEf+MJmqIk0E42qNL1g2wanQgQ
 FcUc+qONtJz4KZON7ec1H36lfQVrxy0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-EdpoOYVQOyq6wXbv75ZOCw-1; Fri, 27 Mar 2026 13:07:42 -0400
X-MC-Unique: EdpoOYVQOyq6wXbv75ZOCw-1
X-Mimecast-MFC-AGG-ID: EdpoOYVQOyq6wXbv75ZOCw_1774631261
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4871fc50fe7so15560365e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774631261; x=1775236061; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4vDLI2IfMUsCyYXrEI9ZK+/g2AAeGVbn41NHRVP4L6o=;
 b=BXPiH/qGpr/Lqaz+5GDnlv1zoM1iuOY13LcN8aEe0qaKUZM+kRz7ykC/PEGWL0CFD0
 mS9K8tfb/oX+tKGpYEtQvZkLAHeXW242T77NQqqHOXgifP8vKPvXsTwhzcpH/KOpD1v1
 5zcZbkJDTOpKy3oCV6t50VdmbD6y5pJj85i+YaiKxft2r0efNn5QgOpyje0uNrIgYaDC
 U7x9mTLq/rr6bfr5Z+BNomqaSeMcfHnrwab2Rp02sO+j2iFEUU8Lroi/kPWiF7lkVRrF
 Xcc4FtSQp5lTaqRYY+QRLK16zX31kmwW4JUs1Jp8h9+LQe91BZP3v4NRAfrxFzrLGE/f
 +GHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774631261; x=1775236061;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4vDLI2IfMUsCyYXrEI9ZK+/g2AAeGVbn41NHRVP4L6o=;
 b=fXndAJwINRmZ/1iTsUb213Cq7e7eqXip572QUck4FkJLfK8ZXNCWjg6P6tiduPS7Nz
 gsu4WHn2LoBoj/BdTIRlRuz66ARPDniKNfzmJ6I3pVQ0+Ie28FiOcUnenoyKzWcsfLTA
 cFiL0GQ+/a2rBsoD+OcxMVxdHRiCUBSpCRUc79eSwjqkWC83KGMZfP206WxPF9DpEp94
 ryXr5bzpIPf7UGOdlSq17WQDp6pxLR7LMaSaVDXRNoO+OUUtDuyXnJq9ddITcnQjIERF
 b7wFKoEtR6NJRSTlkZVAnEsq14Gg86rC92O7x2H0NKetD9MEYjLgcCk+mlJYbWTUqMtT
 37Eg==
X-Gm-Message-State: AOJu0Ywi2C4cauAeIKMgU4+eFLE4g8s77/YcUfDHKEbhXccf5VUK4oJ4
 bH+yMsWIqDtXBkxz6FKJ4+8cXulI1Gy6aKcHg8HaRmCTeopb/+mrxg3b7WPOSI0a/T1S82FyEeU
 GQr3+OP790HgQBJyZdrPOluK6r09j7SkFYbiDok2/gdTgslXncQMTg58E
X-Gm-Gg: ATEYQzy6DbAd4jVwjmW7RLkKGmB9YN+9zSGAlJaVQQ0QN+ElwgR4Ymr8cGyr98fE970
 TUMJRGLjhUtKZhE6i+hnLW7561aPSFOeiMCwNih5lvCX3CFMjWRmKQkGPwgPvPHNd+N+FCr4l4H
 MZ/dwk64YqvPymLBw8oYytG6iz0YOt41bvgrgB1Y4HLjrAUfnQH7hb5M33Eb7HYayTvfhaQqWFh
 2ZHeOhLzPMhysDnEchT2LOl7szl3Jz9qNWUcIQ3qBy/8wtGXlKm99A3QA640YhJ/JEikWil1gUd
 gvHu6THfV2nm4Hz/zH2axfnM3JIDFjHXPvRsJyVRGywBLb/jHvtuGhLbVtMMMmXB+FE+2iUv8jM
 1vA==
X-Received: by 2002:a05:600c:828a:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-48727d8fc2cmr53309885e9.9.1774631261191; 
 Fri, 27 Mar 2026 10:07:41 -0700 (PDT)
X-Received: by 2002:a05:600c:828a:b0:485:3ca4:4ef4 with SMTP id
 5b1f17b1804b1-48727d8fc2cmr53309185e9.9.1774631260715; 
 Fri, 27 Mar 2026 10:07:40 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d236a9sm196071665e9.11.2026.03.27.10.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 10:07:40 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:07:38 +0100
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Kirti Wankhede <kwankhede@nvidia.com>, 
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>, 
 Joao Martins <joao.m.martins@oracle.com>, Alex Williamson <alex@shazbot.org>, 
 Yishai Hadas <yishaih@nvidia.com>, Fabiano Rosas <farosas@suse.de>, 
 Pranav Tyagi <prtyagi@redhat.com>, Zhiyi Guo <zhguo@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>, 
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Subject: Re: [PATCH RFC 10/12] migration: Introduce a helper to return
 switchover bw estimate
Message-ID: <aca2rpCPVqb-y2IY@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-11-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-11-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jmarcin@redhat.com;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2026-03-19 19:13, Peter Xu wrote:
> Add a helper to be able to return an estimate of switchover bw, called
> migration_get_switchover_bw(). Use it to sligitly simplify the current
> code.
> 
> This will be used in new codes later to remove expected_downtime.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  1 +
>  migration/migration.c | 43 ++++++++++++++++++++++---------------------
>  2 files changed, 23 insertions(+), 21 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index b6888daced..bf3ee6cc07 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -586,6 +586,7 @@ void migration_cancel(void);
>  void migration_populate_vfio_info(MigrationInfo *info);
>  void migration_reset_vfio_bytes_transferred(void);
>  void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
> +int64_t migration_downtime_calc_expected(MigrationState *s);

Couldn't find the definition until I looked at the next patch :)

>  
>  /*
>   * Migration thread waiting for return path thread.  Return non-zero if an
> diff --git a/migration/migration.c b/migration/migration.c
> index ad8a824585..56d605ede9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -984,6 +984,21 @@ void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
>      migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
>  }
>  
> +/*
> + * Returns the estimated switchover bandwidth (unit: bytes / seconds)
> + */
> +static double migration_get_switchover_bw(MigrationState *s)
> +{
> +    uint64_t switchover_bw = migrate_avail_switchover_bandwidth();
> +
> +    if (switchover_bw) {
> +        /* If user specified, prioritize this value and don't estimate */
> +        return (double)switchover_bw;
> +    }
> +
> +    return s->mbps / 8 * 1000 * 1000;
> +}
> +
>  bool migration_is_running(void)
>  {
>      MigrationState *s = current_migration;
> @@ -3126,37 +3141,22 @@ static void migration_update_counters(MigrationState *s,
>  {
>      uint64_t transferred, transferred_pages, time_spent;
>      uint64_t current_bytes; /* bytes transferred since the beginning */
> -    uint64_t switchover_bw;
> -    /* Expected bandwidth when switching over to destination QEMU */
> -    double expected_bw_per_ms;
> -    double bandwidth;
> +    double switchover_bw;
>  
>      if (current_time < s->iteration_start_time + BUFFER_DELAY) {
>          return;
>      }
>  
> -    switchover_bw = migrate_avail_switchover_bandwidth();
>      current_bytes = migration_transferred_bytes();
>      transferred = current_bytes - s->iteration_initial_bytes;
>      time_spent = current_time - s->iteration_start_time;
> -    bandwidth = (double)transferred / time_spent;
> -
> -    if (switchover_bw) {
> -        /*
> -         * If the user specified a switchover bandwidth, let's trust the
> -         * user so that can be more accurate than what we estimated.
> -         */
> -        expected_bw_per_ms = (double)switchover_bw / 1000;
> -    } else {
> -        /* If the user doesn't specify bandwidth, we use the estimated */
> -        expected_bw_per_ms = bandwidth;
> -    }
> -
> -    s->threshold_size = expected_bw_per_ms * migrate_downtime_limit();
> -
>      s->mbps = (((double) transferred * 8.0) /
>                 ((double) time_spent / 1000.0)) / 1000.0 / 1000.0;
>  
> +    /* NOTE: only update this after bandwidth (s->mbps) updated */
> +    switchover_bw = migration_get_switchover_bw(s) / 1000;

It isn't clear from the name, that switchover_bw is in milliseconds, I
think the _per_ms suffix would solve this.

> +    s->threshold_size = switchover_bw * migrate_downtime_limit();
> +
>      transferred_pages = ram_get_total_transferred_pages() -
>                              s->iteration_initial_pages;
>      s->pages_per_second = (double) transferred_pages /

There's also expected_bw_per_ms which should be probably replaced by
switchover_bw[_per_ms], otherwise it doesn't compile.

> @@ -3178,7 +3178,8 @@ static void migration_update_counters(MigrationState *s,
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                /* Both in unit bytes/ms */
> -                              bandwidth, switchover_bw / 1000,
> +                              (uint64_t)s->mbps,
> +                              (uint64_t)switchover_bw,
>                                s->threshold_size);
>  }
>  
> -- 
> 2.50.1
> 

Except the comments above, the change looks good. With those resolved:

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


