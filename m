Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B38C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 19:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLpZJ-00056A-Od; Mon, 24 Jun 2024 15:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLpZH-00054z-IF
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sLpZF-0005ca-Fj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 15:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719258091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4nlOl9sGDvx+iX/CJP6pS7mXz6uGsbsHxDYhCtD8Jas=;
 b=YlpsKKCYedJ6wT3ieBtPQFBM2NA1RRvtN9+ZESYoHfXlKI3bL8YB1om+N17Ae53iqe14nI
 lu2eDuwpUa559n8lq6OGp9PT8jvQ5NYMBTg830zynQSRxh+olnBA2qf+0p4wUeJq3RSLkt
 tRpBF0j8/LpMrKfi4qP7EnA5Fmdbjgo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-3Q2VxqVJNbSaGUyDwOkFOQ-1; Mon, 24 Jun 2024 15:41:28 -0400
X-MC-Unique: 3Q2VxqVJNbSaGUyDwOkFOQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6b4ee849339so2635866d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 12:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719258087; x=1719862887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4nlOl9sGDvx+iX/CJP6pS7mXz6uGsbsHxDYhCtD8Jas=;
 b=oaVZ5uCJlOptbKiiDVY5+YgvhCrblCV/007E7mugL2n1XtD32vM7P5dSXilnIJFfG7
 wZm48sygCiv6cO6G/5kLzHUYlw7iyZ/qcjJZJmNzYgNhmnz9FVsA9wipGIQ/Tw+lWdWc
 a8Dpf+Cf9aNXepAQlQUzH/Gnvz4WesPu+dnaTpVwi8Pl/KHD/GxPjOqexbR8sRhtk8+9
 TwoPKk/UwOx5d6On01j+W0ZTDrRB23pPuujmwZGWRdv0N2KzSjFOldjL8Hv0pGX4xvRu
 j41gFQkXhu6RLO/y4BP2NfnBqzo//pGUze42NB/4STDf3KGgPgXnPvBn9aTkO5N4pgFT
 nJHg==
X-Gm-Message-State: AOJu0YwPsRXP2T1EN5ibtAl6HtVwRu71N4f/uTC1BN1qP3MSncsLl7oP
 +mnNbCnJGPYrNrhNU1mTrLaKCzue+zg4T+C+yrRvjzvivbAmUfSyRqfODlzcOMVOUCwxtGOzu6g
 mRIK7RReKXMrCe8xgLonkRv6mtz2UBU6q4j9EF6GBbrjKyh0zsCCD
X-Received: by 2002:ad4:596f:0:b0:6b2:b53a:5ef3 with SMTP id
 6a1803df08f44-6b53008e808mr83567066d6.3.1719258087044; 
 Mon, 24 Jun 2024 12:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENujjOBx8Y3E4e6wiDcqHshA2Mkqt204yeYasry4Va0vTkjTgNwaNvOzvwPAdbC/ZMKN0SMg==
X-Received: by 2002:ad4:596f:0:b0:6b2:b53a:5ef3 with SMTP id
 6a1803df08f44-6b53008e808mr83566886d6.3.1719258086572; 
 Mon, 24 Jun 2024 12:41:26 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef4ace1sm36517076d6.106.2024.06.24.12.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 12:41:26 -0700 (PDT)
Date: Mon, 24 Jun 2024 15:41:23 -0400
From: Peter Xu <peterx@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: qemu-devel@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, farosas@suse.de,
 eblake@redhat.com, armbru@redhat.com
Subject: Re: [PATCH RFC 2/2] migration: abort on destination if switchover
 limit exceeded
Message-ID: <ZnnL42_iDip3hfUh@x1n>
References: <20240621143221.198784-1-elena.ufimtseva@oracle.com>
 <20240621143221.198784-3-elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621143221.198784-3-elena.ufimtseva@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
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

On Fri, Jun 21, 2024 at 07:32:21AM -0700, Elena Ufimtseva wrote:
> During live migration, receive current downtime from source
> and start a downtime timer. When the destination dowtime
> and added source downtime exceeds downtime limit for more
> than switchover limit, abort live migration on destination.
> 
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> ---
>  migration/migration.c  |  2 ++
>  migration/migration.h  | 15 ++++++++++
>  migration/savevm.c     | 68 ++++++++++++++++++++++++++++++++++++++++++
>  migration/savevm.h     |  2 ++
>  migration/trace-events |  3 ++
>  5 files changed, 90 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 5cc304d2db..64d7290997 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -240,6 +240,8 @@ void migration_object_init(void)
>      current_incoming->page_requested = g_tree_new(page_request_addr_cmp);
>  
>      current_incoming->exit_on_error = INMIGRATE_DEFAULT_EXIT_ON_ERROR;
> +    /* Downtime will start when source sends its current downtime. */
> +    current_incoming->downtime_start = 0;
>  
>      migration_object_check(current_migration, &error_fatal);
>  
> diff --git a/migration/migration.h b/migration/migration.h
> index aa56b70795..06f4ebe214 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -230,6 +230,21 @@ struct MigrationIncomingState {
>  
>      /* Do exit on incoming migration failure */
>      bool exit_on_error;
> +
> +    /* Initial downtime on destination set by MIG_CMD_SEND_SRC_DOWNTIME */
> +    uint64_t downtime_start;
> +    /*
> +     * Current donwtime on destination that initially set equal to source by
> +     * MIG_CMD_SEND_SRC_DOWNTIME, then updated by destination itself.
> +     */
> +    uint64_t downtime_now;

Is this needed?

> +    /*
> +     * Abort live migration on destination when current destination downtime
> +     * exceeds the abort_limit. abort_limit is being set by
> +     * MIG_CMD_SEND_SRC_DOWNTIME sent from source.
> +     */
> +    uint64_t abort_limit;

If we assume both QEMUs will be applied with the same cap/params, we may
not need this and we can directly read the parameter on dest.

> +    uint64_t src_downtime;
>  };
>  
>  MigrationIncomingState *migration_incoming_get_current(void);
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 031ab03915..f3b5ea98bf 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -90,6 +90,7 @@ enum qemu_vm_cmd {
>      MIG_CMD_ENABLE_COLO,       /* Enable COLO */
>      MIG_CMD_POSTCOPY_RESUME,   /* resume postcopy on dest */
>      MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> +    MIG_CMD_SEND_SRC_DOWNTIME,    /* Send current downtime to dst */
>      MIG_CMD_MAX
>  };
>  
> @@ -109,6 +110,7 @@ static struct mig_cmd_args {
>      [MIG_CMD_POSTCOPY_RESUME]  = { .len =  0, .name = "POSTCOPY_RESUME" },
>      [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
>      [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
> +    [MIG_CMD_SEND_SRC_DOWNTIME] = { .len = -1, .name = "SEND_SRC_DOWNTIME" },
>      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
>  };
>  
> @@ -1218,6 +1220,18 @@ void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
>      qemu_savevm_command_send(f, MIG_CMD_RECV_BITMAP, len + 1, (uint8_t *)buf);
>  }
>  
> +void qemu_savevm_send_downtime(QEMUFile *f, int64_t abort_limit_ms,
> +                               int64_t source_downtime)
> +{
> +    uint64_t tmp[2];
> +    tmp[0] = cpu_to_be64(abort_limit_ms);
> +    tmp[1] = cpu_to_be64(source_downtime);
> +
> +    trace_qemu_savevm_send_downtime(abort_limit_ms, source_downtime);
> +    qemu_savevm_command_send(f, MIG_CMD_SEND_SRC_DOWNTIME,
> +                             16, (uint8_t *)tmp);
> +}
> +
>  bool qemu_savevm_state_blocked(Error **errp)
>  {
>      SaveStateEntry *se;
> @@ -1635,6 +1649,14 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
>          }
>      }
>  
> +    if (migrate_switchover_abort()) {
> +        MigrationState *s = migrate_get_current();
> +        uint64_t abort_limit_ms =
> +            s->parameters.downtime_limit + s->parameters.switchover_limit;
> +        qemu_savevm_send_downtime(f, abort_limit_ms,
> +                                  migration_get_current_downtime(s));
> +    }
> +
>      if (iterable_only) {
>          goto flush;
>      }
> @@ -1919,6 +1941,20 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis,
>      return 0;
>  }
>  
> +static int loadvm_handle_src_downtime(MigrationIncomingState *mis,
> +                                      uint16_t len)
> +{
> +    uint64_t src_abort_limit = qemu_get_be64(mis->from_src_file);
> +    uint64_t src_current_downtime = qemu_get_be64(mis->from_src_file);
> +
> +    mis->abort_limit = src_abort_limit;
> +    mis->src_downtime = src_current_downtime;
> +    mis->downtime_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);

I guess this didn't count in the delay of sending this packet.  Since the
whole point of this feature will be "making sure downtime is less than xxx
or cancel migration", I think this might cause the real downtime still more
than expected.  Not sure how big a concern this is.

E.g., have you measured how a packet can be delayed when the socket
pipeline is mostly full, then queue this SRC_DOWNTIME message after all
that?  I think that's very possible the case here at switchover where src
is trying to dump as fast as possible.  I'm not sure whether it's easy to
measure, either..

> +
> +    trace_loadvm_handle_src_downtime(src_abort_limit, src_current_downtime);
> +    return 0;
> +}
> +
>  /* After postcopy we will be told to throw some pages away since they're
>   * dirty and will have to be demand fetched.  Must happen before CPU is
>   * started.
> @@ -2540,6 +2576,9 @@ static int loadvm_process_command(QEMUFile *f)
>  
>      case MIG_CMD_ENABLE_COLO:
>          return loadvm_process_enable_colo(mis);
> +
> +    case MIG_CMD_SEND_SRC_DOWNTIME:
> +        return loadvm_handle_src_downtime(mis, len);
>      }
>  
>      return 0;
> @@ -2659,6 +2698,18 @@ qemu_loadvm_section_start_full(QEMUFile *f, MigrationIncomingState *mis,
>          trace_vmstate_downtime_load("non-iterable", se->idstr,
>                                      se->instance_id, end_ts - start_ts);
>      }
> +    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_FULL &&
> +        mis->downtime_start) {
> +        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
> +        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
> +            error_report("Shutdown destination migration, migration abort_limit"
> +                         "(%lu ms) was reached.", mis->abort_limit);
> +            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
> +                                             mis->src_downtime);
> +            return -EINVAL;
> +        }
> +    }
>  
>      if (!check_section_footer(f, se)) {
>          return -EINVAL;
> @@ -2714,6 +2765,19 @@ qemu_loadvm_section_part_end(QEMUFile *f, MigrationIncomingState *mis,
>                                      se->instance_id, end_ts - start_ts);
>      }
>  
> +    if (migrate_switchover_abort() && type == QEMU_VM_SECTION_END &&
> +        mis->downtime_start) {
> +        mis->downtime_now = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
> +        uint64_t dst_downtime = mis->downtime_now - mis->downtime_start;
> +        if (mis->src_downtime + dst_downtime >= mis->abort_limit) {
> +            error_report("Shutdown destination migration, migration abort_limit (%lu ms)"
> +                          "was reached.", mis->abort_limit);
> +            trace_qemu_loadvm_downtime_abort(mis->abort_limit, dst_downtime,
> +                                             mis->src_downtime);
> +            return -EINVAL;
> +        }
> +    }

So this traps both iteration and non-iteration phase.  What if the downtime
was caused by after these, or unluckily at the last non-iterator device
state?

After trying to think about it, I figured this is not easy to do right.
Also, I start to doubt whether it's definitely a good idea on having this
in the first place.

Firstly, I'm wondering how we should treat this new feature
v.s. downtime_limit.  It's about how the user should set both.

If this is about "cancel migration if downtime more than xxx",
then.. AFAICT that's exactly what downtime_limit was "designed" to be..
It's just that downtime_limit says the other way round, as: "don't
switchover if the downtime will be more than xxx".

Then, if the user has option to set both these parameters, what would be
the right thing to do?  Shouldn't they simply always set both parameters to
be the same value already?  But if so, what's the point on having two?

This caused me to think whether the 2nd parameter is needed at all, instead
whether we should simply make downtime_limit more accurate, so that it will
start to account more things than before.  It won't be accurate, but the
same case here: making this new feature "accurate" can also be very hard.

Thanks,

-- 
Peter Xu


