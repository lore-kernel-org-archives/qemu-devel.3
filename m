Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8939610F285E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6AoG-0001re-40; Fri, 27 Mar 2026 13:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6Ao5-0001pQ-FV
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:17:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1w6Ao2-0002e6-9g
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774631829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zlBNoTYQCz7Dg0zM94ltkURdaNSd3tDZkqlnvVSMW2A=;
 b=NaXBEZtz8WGWGPyh2ZscmMny5rK14cNF5EMve9DeYXX84Fvpkb8fefprc+gtRTD0XAMcoU
 e6t8fEJm9cVSQRnR8x3/ihhcLhUe1fikk+LoHHopCwWJWiX6iRl6I/B5yk3hsTbI+d1/u8
 4tQ1IUZG6tTfFF0hY8TbotmuXncYYKA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-qlzaMzfXN0G0Ymq-HDgdQw-1; Fri, 27 Mar 2026 13:17:07 -0400
X-MC-Unique: qlzaMzfXN0G0Ymq-HDgdQw-1
X-Mimecast-MFC-AGG-ID: qlzaMzfXN0G0Ymq-HDgdQw_1774631826
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43ba02dc34bso520202f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 10:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774631826; x=1775236626; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zlBNoTYQCz7Dg0zM94ltkURdaNSd3tDZkqlnvVSMW2A=;
 b=i9OfxKea87O2BCxk87kDHSAWVHv86Oga0QerxUEbfkY7WIFECqQX0yBV42/NRrynCr
 KQaj6VweEvQfJR34tbWVTlKhZyfn4gTMw7D3LT+86kdF3NP4uk+0GgvCkb7RD0Xabwb7
 FUQL7LI+jj+I3jbLzM0Wxn2isF65VX79P9Plz8hXe4udELjuZAmbZ8w0sPaNymSy5hy7
 ISF/czQaaCATrxdpvcIp5mB43/wUZX8FfjYtbir9Sct66dhN05KvdpS7xGqzhM6RS6Ij
 rETG4F5N977oSNH9ezocGqt+0NVGAkEGz1uX10ruOwO6jboSl9wJC0fM7XfVZe5z1ixR
 P8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774631826; x=1775236626;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zlBNoTYQCz7Dg0zM94ltkURdaNSd3tDZkqlnvVSMW2A=;
 b=dy/pDxhEiRL4qT2hidt7IfD5Jc6r/eHY932BJY65Fi3bJR7QzwFKVvlhbVlG3RHtOi
 hqncQKuTs8WOitZ8pUIn7Xy937E1ZAcixjaZvRyGJzlLbspnjMX5O+DvGP42W5nS7d93
 wDqYWlmLCEiqPQm7hucF9UfnC0Zbkbx25C2eX12YG7FjMr2GdhEyhODbCEhogdc2QnVJ
 P2fvDWteliroae+oR2iEot01wpw0Knk860JPVAv3dOm18xoTPJCHaZAcj4YRWEMiD4lm
 FxQVszmNmG+hCTRcy2r1Q55d1+ixMWTNltkJk54w1OCXclVmnxhzZAEq2l8oI6KyyVZr
 O4Kw==
X-Gm-Message-State: AOJu0YwAlTjlfeRu3Psk5p855INyeM2WHBRAaIdNyTHsztsWcmqoGx/1
 pg1ilUauxrg65pfxQTIXsl/IZlyWeJapTIM5UewmIlBY0tGQ5Oq7M8NqxLtKP5oGHXQNnu3T0TC
 2OsttKRWsovD4EtGKuryueXwTt9pS3ORORd6UeVkB7ED4N8SnqKniFMU6/S/hbCf9/KO+1A==
X-Gm-Gg: ATEYQzxCSgfxsVFXBFh6hNRTi4sYaC3wfPh/dDhOA28H71Sqg7+fVPS0lb0veNGtyYb
 7bywnXGNQVddbMJir/RznQLaynjKrrPjREv3ZvxIBGwR87lLNiZcb8U9G10pidlRT/EtQv+j8md
 LxfqWkgyiBupdI0KdC2kUf2kDZQQlBuboLKC++Vylo99xSvKi3gCkABnl8L0kYeddrc+bJL8+We
 dNyj9pBQF5IHECAC63/q4GuqTp2MNYSvqrU+u22N6fwExvdFD3WZTbniuQzybvcivVa41pa4yN/
 +UQ5xdG3ojWjzu9/F7Vve8h+nu1MF5ksBHp4eqOexgZxdEvtywFiA5m9bUpAosPo5xl529Wy+VW
 XgQ==
X-Received: by 2002:a05:6000:22c2:b0:43b:858e:6671 with SMTP id
 ffacd0b85a97d-43b9e9e8f2amr5766121f8f.14.1774631826190; 
 Fri, 27 Mar 2026 10:17:06 -0700 (PDT)
X-Received: by 2002:a05:6000:22c2:b0:43b:858e:6671 with SMTP id
 ffacd0b85a97d-43b9e9e8f2amr5766057f8f.14.1774631825696; 
 Fri, 27 Mar 2026 10:17:05 -0700 (PDT)
Received: from fedora ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919df7dcsm17520088f8f.27.2026.03.27.10.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 10:17:05 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:17:03 +0100
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
Subject: Re: [PATCH RFC 11/12] migration: Calculate expected downtime on demand
Message-ID: <aca6I81dKUdk2bI2@fedora>
References: <20260319231302.123135-1-peterx@redhat.com>
 <20260319231302.123135-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319231302.123135-12-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
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
> This value does not need to be calculated as frequent.  Only calculate it
> on demand when query-migrate happened.  With that we can remove the
> variable in MigrationState.
> 
> This paves way for fixing this value to include all modules (not only RAM
> but others too).
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.h |  1 -
>  migration/migration.c | 26 ++++++++++++--------------
>  2 files changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/migration/migration.h b/migration/migration.h
> index bf3ee6cc07..ba0f9e0f9c 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -359,7 +359,6 @@ struct MigrationState {
>      /* Timestamp when VM is down (ms) to migrate the last stuff */
>      int64_t downtime_start;
>      int64_t downtime;
> -    int64_t expected_downtime;
>      bool capabilities[MIGRATION_CAPABILITY__MAX];
>      int64_t setup_time;
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 56d605ede9..23c78b3a2c 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1041,6 +1041,17 @@ static bool migrate_show_downtime(MigrationState *s)
>      return (s->state == MIGRATION_STATUS_COMPLETED) || migration_in_postcopy();
>  }
>  
> +/* Return expected downtime (unit: milliseconds) */
> +int64_t migration_downtime_calc_expected(MigrationState *s)
> +{
> +    if (mig_stats.dirty_sync_count <= 1) {
> +        return migrate_downtime_limit();
> +    }
> +
> +    return 1.0 * mig_stats.dirty_bytes_last_sync /

If the intention of '1.0 *' was to get double out of dirty_bytes_last_sync, I think
an explicit cast would be better.

> +        migration_get_switchover_bw(s) * 1000;
> +}
> +
>  static void populate_time_info(MigrationInfo *info, MigrationState *s)
>  {
>      info->has_status = true;
> @@ -1061,7 +1072,7 @@ static void populate_time_info(MigrationInfo *info, MigrationState *s)
>          info->downtime = s->downtime;
>      } else {
>          info->has_expected_downtime = true;
> -        info->expected_downtime = s->expected_downtime;
> +        info->expected_downtime = migration_downtime_calc_expected(s);
>      }
>  }
>  
> @@ -1649,7 +1660,6 @@ int migrate_init(MigrationState *s, Error **errp)
>      s->mbps = 0.0;
>      s->pages_per_second = 0.0;
>      s->downtime = 0;
> -    s->expected_downtime = 0;
>      s->setup_time = 0;
>      s->start_postcopy = false;
>      s->migration_thread_running = false;
> @@ -3162,16 +3172,6 @@ static void migration_update_counters(MigrationState *s,
>      s->pages_per_second = (double) transferred_pages /
>                               (((double) time_spent / 1000.0));
>  
> -    /*
> -     * if we haven't sent anything, we don't want to
> -     * recalculate. 10000 is a small enough number for our purposes
> -     */
> -    if (qatomic_read(&mig_stats.dirty_pages_rate) &&
> -        transferred > 10000) {
> -        s->expected_downtime =
> -            qatomic_read(&mig_stats.dirty_bytes_last_sync) / expected_bw_per_ms;
> -    }
> -
>      migration_rate_reset();
>  
>      update_iteration_initial_status(s);
> @@ -3817,8 +3817,6 @@ void migration_start_outgoing(MigrationState *s)
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>      int ret;
>  
> -    s->expected_downtime = migrate_downtime_limit();
> -
>      if (resume) {
>          /* This is a resumed migration */
>          rate_limit = migrate_max_postcopy_bandwidth();
> -- 
> 2.50.1
> 


