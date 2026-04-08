Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EF410F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYQB-0005AH-MJ; Wed, 08 Apr 2026 15:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wAY09-00052P-5g
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:51:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wATyC-0005Gk-BM
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 10:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775658806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oz9DrFRYE+J78tlCHPETBIdJkEH0BWMEs7SxSitP7n0=;
 b=ikcQkPdKGpR0hUMa6IdqwrG7d3P/NUhP4L08P00Yr811Mn+a3c+VPDIjPhuvy1bBTTrFn/
 IVJu72UqYSJ1/MzXDevaTlOdjnIdkjGVXKvZBO4Uj+AgAJa1zPMR2C+uhH6ZBGBIe3Hze/
 O0f7H7D7ZSMCoxy1qQJUiEmyKTHxp8s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-uxrfCcLMPa6etNFusWI6vg-1; Wed, 08 Apr 2026 10:33:24 -0400
X-MC-Unique: uxrfCcLMPa6etNFusWI6vg-1
X-Mimecast-MFC-AGG-ID: uxrfCcLMPa6etNFusWI6vg_1775658803
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d103e46c3so4454707f8f.3
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 07:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775658803; x=1776263603; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oz9DrFRYE+J78tlCHPETBIdJkEH0BWMEs7SxSitP7n0=;
 b=s/EGCiZ9Rv7V3UIVKnlINMCiZARyR5O1xrGPClbKVCWaget28UuaS3QTUstbDZ0Nes
 qqxvzR9lDIHJlTcbvZpDl9AvxlVT4uRZ2Dg0Ezx9MDdfIKWfj2ER/gbG8bhOw7NhbhXY
 WrvaxyWJyWYCniAB6yam9wqWb3vIK/fCgwGVqcqZRuSeK+/znkkvukT5vtn8VLbNXqHf
 P87sNFpuYRAM76+/Enu9PUhMJfUH/9bG+icuDCwgsEAdMNeV5ynrJwctWbUaE5YWDYGR
 Mhx2kaFzJ5DDYZPszosATry/NFUQge6nENwbg1DXOPSUOoC1OzhtCGXR5ZMhQl4YMFon
 7i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775658803; x=1776263603;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oz9DrFRYE+J78tlCHPETBIdJkEH0BWMEs7SxSitP7n0=;
 b=cXPiXQdYqvTF27QjUTGZ2QKtb37jqJ53SD7hQzQ43q1BcYAibfz0gyICIEOE6qSkjR
 A1/GGBarR2MqaALGNT7uPtQBkODA6nGzbo6fHoSpzJNFIqdN2/CzpkBLjdkgaHsEAJnu
 2qLVPV1yW6rC81uq30BJtwlbDi5Pz3ItfG28M1aff8kN6Xtk75S3k+yGG9COp5GFkm5V
 Fy0D32I/Y/c8/obbDp7D4cjp/Uv/qQ3vDvw53G4VcsFFNiFK29sBQv8E3MPT3z6lr5EH
 9Ve0mXCjZAsEOEIJ5wfmanMp4Vqr82kKppZsYrsmrFV6UaMjNuUauCpak7BnXQwiDLWn
 ChyA==
X-Gm-Message-State: AOJu0Yx/vZndbr8ZvHR0ruPgJpXpmKxNSyAt4NfdXNzlUA9uTD9hd/w1
 NocjFOhTG2GdcZZAI9R1yvGMTq1yUzd1YkoUEchpuZCU9n36Za4Ibs9wuKgHg/0420gMGLAHn1I
 dFnl7c6Ryh/8ICkTqXILvJ7T60y0W2Pz78Z0PXbieO3kJN70QQa/wKbZc
X-Gm-Gg: AeBDievv++BhdReN0EhuJbXIceh8+w8MaoDeGOlvFeB7M7PRtftNSqDLIhwpUI79YM7
 1guJlhnkIjLywq8eFOA4HgqxcgSZ1xykdBTBsKfU++XRS/RV/YGlLulPZiAOcnKCAxVHmF6Mq/y
 tR/IQmNoPdClkW4cgfxSai03v/Vt3B4BUbkVEYngAFUIVfieo3cWnZVO27OclovriNtTxqT0nn4
 mCgiJi+KHvcfqNd66kCOGT6Eeu1WzHXzxRn0sD4buSXUf+9FOb4egshIxmNeNvGNLONk5QEkrp7
 un71xbD3GQ2JP9/uN/23q160aSeEdKBbFQSHCNhBw6YaESBzoiY1+jye+8EKwCfB/EC/aAz5lqD
 J+2z0JSpNpg4mYkSImYOys/zLeMBnrUlnVxM9DLY=
X-Received: by 2002:a05:6000:2512:b0:43b:852d:a38e with SMTP id
 ffacd0b85a97d-43d292ff3cdmr29731851f8f.39.1775658803231; 
 Wed, 08 Apr 2026 07:33:23 -0700 (PDT)
X-Received: by 2002:a05:6000:2512:b0:43b:852d:a38e with SMTP id
 ffacd0b85a97d-43d292ff3cdmr29731803f8f.39.1775658802683; 
 Wed, 08 Apr 2026 07:33:22 -0700 (PDT)
Received: from fedora (nat-88-212-17-233.antik.sk. [88.212.17.233])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d27a8sm59682188f8f.17.2026.04.08.07.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 07:33:21 -0700 (PDT)
Date: Wed, 8 Apr 2026 16:33:18 +0200
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
Message-ID: <adZmzrYe34UNYZEj@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-11-peterx@redhat.com>
 <aca2rpCPVqb-y2IY@fedora> <adU-f0qD2ejP3BwX@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adU-f0qD2ejP3BwX@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

On 2026-04-07 13:27, Peter Xu wrote:
> On Fri, Mar 27, 2026 at 06:07:38PM +0100, Juraj Marcin wrote:
> > On 2026-03-19 19:13, Peter Xu wrote:
> > > Add a helper to be able to return an estimate of switchover bw, called
> > > migration_get_switchover_bw(). Use it to sligitly simplify the current
> > > code.
> > > 
> > > This will be used in new codes later to remove expected_downtime.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/migration.h |  1 +
> > >  migration/migration.c | 43 ++++++++++++++++++++++---------------------
> > >  2 files changed, 23 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/migration/migration.h b/migration/migration.h
> > > index b6888daced..bf3ee6cc07 100644
> > > --- a/migration/migration.h
> > > +++ b/migration/migration.h
> > > @@ -586,6 +586,7 @@ void migration_cancel(void);
> > >  void migration_populate_vfio_info(MigrationInfo *info);
> > >  void migration_reset_vfio_bytes_transferred(void);
> > >  void postcopy_temp_page_reset(PostcopyTmpPage *tmp_page);
> > > +int64_t migration_downtime_calc_expected(MigrationState *s);
> > 
> > Couldn't find the definition until I looked at the next patch :)
> 
> Good catch.. I'll move it out.
> 
...
> > > +    /* NOTE: only update this after bandwidth (s->mbps) updated */
> > > +    switchover_bw = migration_get_switchover_bw(s) / 1000;
> > 
> > It isn't clear from the name, that switchover_bw is in milliseconds, I
> > think the _per_ms suffix would solve this.
> 
> Sure.
> 
> > 
> > > +    s->threshold_size = switchover_bw * migrate_downtime_limit();
> > > +
> > >      transferred_pages = ram_get_total_transferred_pages() -
> > >                              s->iteration_initial_pages;
> > >      s->pages_per_second = (double) transferred_pages /
> > 
> > There's also expected_bw_per_ms which should be probably replaced by
> > switchover_bw[_per_ms], otherwise it doesn't compile.
> 
> Yep, will fix.  I'll likely drop two qatomic_read()s too alone the way when
> touching that line because they're not needed.
> 
...
> > 
> > Except the comments above, the change looks good. With those resolved:
> > 
> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> 
> Thanks, attaching the final version here (I also touched up the commit
> message on some English change request from Prasad):
> 
> From 2258026f454621b7a5f04bb7bcb018b29482a695 Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Thu, 19 Mar 2026 15:50:30 -0400
> Subject: [PATCH] migration: Introduce a helper to return switchover bw
>  estimate
> 
> Add a helper migration_get_switchover_bw() to return an estimate of
> switchover bandwidth.  Use it to simplify the current code.
> 
> This will be used in later to remove expected_downtime.
> 
> When at it, remove two qatomic_read() to shrink the lines because atomic
> ops are not needed when it's always the same thread who does the updates.
> 
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 48 +++++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index c6cc2f6c09..17003ac7ee 100644
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
> +    double switchover_bw_per_ms;
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
> +    switchover_bw_per_ms = migration_get_switchover_bw(s) / 1000;
> +    s->threshold_size = switchover_bw_per_ms * migrate_downtime_limit();
> +
>      transferred_pages = ram_get_total_transferred_pages() -
>                              s->iteration_initial_pages;
>      s->pages_per_second = (double) transferred_pages /
> @@ -3166,10 +3166,9 @@ static void migration_update_counters(MigrationState *s,
>       * if we haven't sent anything, we don't want to
>       * recalculate. 10000 is a small enough number for our purposes
>       */
> -    if (qatomic_read(&mig_stats.dirty_pages_rate) &&
> -        transferred > 10000) {
> +    if (mig_stats.dirty_pages_rate && transferred > 10000) {
>          s->expected_downtime =
> -            qatomic_read(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
> +            mig_stats.dirty_bytes_last_sync / switchover_bw_per_ms;
>      }
>  
>      migration_rate_reset();
> @@ -3178,7 +3177,8 @@ static void migration_update_counters(MigrationState *s,
>  
>      trace_migrate_transferred(transferred, time_spent,
>                                /* Both in unit bytes/ms */
> -                              bandwidth, switchover_bw / 1000,
> +                              (uint64_t)s->mbps,
> +                              (uint64_t)switchover_bw_per_ms,
>                                s->threshold_size);
>  }
>  
> -- 
> 2.53.0
> 
> 
> -- 
> Peter Xu
> 

LGTM!


