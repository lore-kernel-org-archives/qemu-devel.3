Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95896C54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 07:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1res6G-0002jg-DO; Tue, 27 Feb 2024 02:42:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1res6E-0002jT-Vl
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 02:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1res6D-0002Rv-6Q
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 02:42:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709019719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DzXWrfNjP+XNMRSD5nMOyU9aV4MwlRiXkP+4p8OwIgo=;
 b=ayUyQcpCEInlfrPeaRByKdWHnecdhaRIFJ+eWV6/1PPbUF6BcTa0XHA68ITovaRvHupHam
 qnoiaEf/LvHq1BZ+pu1tEmegwXjD0PDpRIkcMASD4vpg0m7PqPKBCRKLAZef0eXMrds4Pi
 47ZSYpGfFZ6T2Ss7gjQV44j0eeTh1Ms=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-idtZXLd6OjWXOEAT4AaJiw-1; Tue, 27 Feb 2024 02:41:58 -0500
X-MC-Unique: idtZXLd6OjWXOEAT4AaJiw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29999b97b39so1396653a91.1
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 23:41:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709019717; x=1709624517;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DzXWrfNjP+XNMRSD5nMOyU9aV4MwlRiXkP+4p8OwIgo=;
 b=LMsPPJDGqxUpUX+XhkW3O0dfYpKhds4TopZDITI0a4M9Ur155yXAOWK6SJmPsPD5R6
 3IMeLsWSZjvxaf9GOYmwVBhFEP3o87jI1pMtMcGXsFVxtdG4Bie0geh1nfF9fgPnuLLS
 23rcb4hIOqdYTnXgJCFzblCnG/2EWdTSINykuIHdJDuWv1k1a3oK2h2ofAxTPiLRAhWR
 Ao8VUFWUzA1l6zVHT8Pw8mNBqlyLaJZfac0M/6T5E6AKPRdySRnc2qtcvrcx/tcbXGkD
 H0l+I11rJyJhOo0uW6ghIobBmG2vxcCJuypNzyU9DYL9nnihHQy7Qc16+Phh36OAFYHJ
 HHqQ==
X-Gm-Message-State: AOJu0Yz1J7XVib36444VV4nCEIwYRIaND3MPgXaNcKpiIsRoAExIFq65
 19iOdLWQrHiihEwNCN9U5SJhVkAJz+WTjYt7iiPUGWg2ZlGADe4M0i8HnqCGpI04LMgnL5TCZLL
 HbKiSahOdjvKDC1f5Z8DSfGwUz70o61f8zDtv5kHGTAlUJGW7y3aT
X-Received: by 2002:a17:90a:17e4:b0:29a:4f72:28e with SMTP id
 q91-20020a17090a17e400b0029a4f72028emr7341884pja.2.1709019717266; 
 Mon, 26 Feb 2024 23:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbC9NYVRgokB/uGNr7Selpbd3ZLshwC4OqTzpaSe00RH8gK3WRW1YdwJaIdGMb6NWh56PR7g==
X-Received: by 2002:a17:90a:17e4:b0:29a:4f72:28e with SMTP id
 q91-20020a17090a17e400b0029a4f72028emr7341870pja.2.1709019716852; 
 Mon, 26 Feb 2024 23:41:56 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 rs11-20020a17090b2b8b00b002994f848bc9sm7796371pjb.43.2024.02.26.23.41.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 23:41:56 -0800 (PST)
Date: Tue, 27 Feb 2024 15:41:48 +0800
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Joao Martins <joao.m.martins@oracle.com>,
 Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH] migration: Don't serialize migration while can't
 switchover
Message-ID: <Zd2SPGPVhW80b1Hu@x1n>
References: <20240222155627.14563-1-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240222155627.14563-1-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

On Thu, Feb 22, 2024 at 05:56:27PM +0200, Avihai Horon wrote:
> Currently, migration code serializes device data sending during pre-copy
> iterative phase. As noted in the code comment, this is done to prevent
> faster changing device from sending its data over and over.

Frankly speaking I don't understand the rational behind 90697be889 ("live
migration: Serialize vmstate saving in stage 2").  I don't even think I
noticed this logic before even if I worked on migration for a few years...

I was thinking all devices should always get its chance to run for some
period during iterations.  Do you know the reasoning behind?  And I must
confess I also know little on block migration, which seems to be relevant
to this change.  Anyway, I also copy Jan just in case he'll be able to chim
in.

If there is a fast changing device, even if we don't proceed with other
device iterators and we stick with the current one, assuming it can finally
finish dumping all data, but then we'll proceed with other devices and the
fast changing device can again accumulate dirty information?

> 
> However, with switchover-ack capability enabled, this behavior can be
> problematic and may prevent migration from converging. The problem lies
> in the fact that an earlier device may never finish sending its data and
> thus block other devices from sending theirs.

Yes, this is a problem.

> 
> This bug was observed in several VFIO migration scenarios where some
> workload on the VM prevented RAM from ever reaching a hard zero, not
> allowing VFIO initial pre-copy data to be sent, and thus destination
> could not ack switchover. Note that the same scenario, but without
> switchover-ack, would converge.
> 
> Fix it by not serializing device data sending during pre-copy iterative
> phase if switchover was not acked yet.

I am still not fully convinced that it's even legal that one device can
consume all iterator's bandwidth, ignoring the rest..  Though again it's
not about this patch, but about commit 90697be889.

I'm thinking whether we should allow each device to have its own portion of
chance to push data for each call to qemu_savevm_state_iterate(),
irrelevant of vfio's switchover-ack capability.

> 
> Fixes: 1b4adb10f898 ("migration: Implement switchover ack logic")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  migration/savevm.h    |  2 +-
>  migration/migration.c |  4 ++--
>  migration/savevm.c    | 22 +++++++++++++++-------
>  3 files changed, 18 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 74669733dd6..d4a368b522b 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -36,7 +36,7 @@ void qemu_savevm_state_setup(QEMUFile *f);
>  bool qemu_savevm_state_guest_unplug_pending(void);
>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>  void qemu_savevm_state_header(QEMUFile *f);
> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
>  int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
> diff --git a/migration/migration.c b/migration/migration.c
> index ab21de2cadb..d8bfe1fb1b9 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3133,7 +3133,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      }
>  
>      /* Just another iteration step */
> -    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy);
> +    qemu_savevm_state_iterate(s->to_dst_file, in_postcopy, can_switchover);
>      return MIG_ITERATE_RESUME;
>  }
>  
> @@ -3216,7 +3216,7 @@ static MigIterateState bg_migration_iteration_run(MigrationState *s)
>  {
>      int res;
>  
> -    res = qemu_savevm_state_iterate(s->to_dst_file, false);
> +    res = qemu_savevm_state_iterate(s->to_dst_file, false, true);
>      if (res > 0) {
>          bg_migration_completion(s);
>          return MIG_ITERATE_BREAK;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index d612c8a9020..3a012796375 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1386,7 +1386,7 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
>   *   0 : We haven't finished, caller have to go again
>   *   1 : We have finished, we can go to complete phase
>   */
> -int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
> +int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy, bool can_switchover)
>  {
>      SaveStateEntry *se;
>      int ret = 1;
> @@ -1430,12 +1430,20 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
>                           "%d(%s): %d",
>                           se->section_id, se->idstr, ret);
>              qemu_file_set_error(f, ret);
> +            return ret;
>          }
> -        if (ret <= 0) {
> -            /* Do not proceed to the next vmstate before this one reported
> -               completion of the current stage. This serializes the migration
> -               and reduces the probability that a faster changing state is
> -               synchronized over and over again. */
> +
> +        if (ret == 0 && can_switchover) {
> +            /*
> +             * Do not proceed to the next vmstate before this one reported
> +             * completion of the current stage. This serializes the migration
> +             * and reduces the probability that a faster changing state is
> +             * synchronized over and over again.
> +             * Do it only if migration can switchover. If migration can't
> +             * switchover yet, do proceed to let other devices send their data
> +             * too, as this may be required for switchover to be acked and
> +             * migration to converge.
> +             */
>              break;
>          }
>      }
> @@ -1724,7 +1732,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      qemu_savevm_state_setup(f);
>  
>      while (qemu_file_get_error(f) == 0) {
> -        if (qemu_savevm_state_iterate(f, false) > 0) {
> +        if (qemu_savevm_state_iterate(f, false, true) > 0) {
>              break;
>          }
>      }
> -- 
> 2.26.3
> 

-- 
Peter Xu


