Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA63C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 13:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl7JH-0005bJ-Ab; Fri, 15 Mar 2024 09:09:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl7JE-0005az-4w
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rl7JC-0007Wq-0H
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 09:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710508152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzkJW787itOrsdYvMgu3V+FJhc8o3XGIUykwHIG8hgI=;
 b=SOacw1TxGSs6UCTxwKYdnRgLy6VigKHtXNWSR3qee4sK+E2PC7XRnb9iX2jnvG93rbBSG1
 u5yhYHMLK79bW9Q/t/e8eMqOxdtjuZvOVo2TqSzVJOg2yTESIKc9UbnYy51BqliUOo0nrB
 IM1HLOzhoU578KXlZoLBILpj897/Wdo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-xV8g_geKMnqsb057mN3WrA-1; Fri, 15 Mar 2024 09:09:11 -0400
X-MC-Unique: xV8g_geKMnqsb057mN3WrA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-690c19ee50bso5500386d6.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 06:09:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710508151; x=1711112951;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UzkJW787itOrsdYvMgu3V+FJhc8o3XGIUykwHIG8hgI=;
 b=XEtfOulo4glVtmp1N3O4Sdx3XpCkzMZ0kZHOK90wTSNEbnAgxxm9k3S5eXQyXl2FIr
 v+q9scmHeHXOcnmVnN4ePKQ/VsGcopN+o3HLz1g5iD4jgAurxtnJNjOFgsxpSToXQ4Ed
 BRYGL3IPXLA/u9O2AjGkTWK2MzB8Li2BWQYQ4YLzRFjwK1JBYyOgi6ksGVlhYsHymNdc
 5nute+9HFFvUZuynCPhGVQsTdRdnwdfbRds02GURXlcy8sve2ZkiO0OGqTrjw6Yem/GM
 Ma8dCUgwxNkBrPLOquoPJyx33nPKk30WCEOZqXn5O6cFqbpliCi6wHkW35UDbUaabLzE
 0fdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX91jQWtR6+VNt5RGb0VsjS/bM//eR5HEHSu0FcQCV7QMCYhXxCZ0kIBB4KbMCvz3+5MkOvQth8fau7Nebv0FDJWrM2RbY=
X-Gm-Message-State: AOJu0YzaZTf60Q7m+it7pF9LNzy7JcakjQqI18Tqf4cBE9HaUZ7dF7LB
 4cEOaJ8Ei7Jmzaof4mjE5Ia+6RV+ZwbvyHj6zaBoH1hPjObMNrQ1gN1FIG7OzJUDcCLkL2oRh+n
 SdK8RmPTFxE2peA1UpAjP9rdOtRhnrJQ3WRuEzGbdTH8eLT7118bj
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr5103845qvb.0.1710508150641; 
 Fri, 15 Mar 2024 06:09:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4lmsXcQybFErFRw5uvapiRiFrQoLy8MfpfsCur7nBAk3owkfOtw6Mwh6dD+7OpysDaImErA==
X-Received: by 2002:a05:6214:459e:b0:68f:1c80:d78e with SMTP id
 op30-20020a056214459e00b0068f1c80d78emr5103810qvb.0.1710508150201; 
 Fri, 15 Mar 2024 06:09:10 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 h13-20020a0562140dad00b0069150311189sm2014601qvh.134.2024.03.15.06.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 06:09:09 -0700 (PDT)
Date: Fri, 15 Mar 2024 09:09:07 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v4 10/25] migration: Add Error** argument to
 qemu_savevm_state_setup()
Message-ID: <ZfRIc1l_PElCVNtL@x1n>
References: <87le6omw0d.fsf@suse.de>
 <9071affc-ffb5-435a-99d1-ca829703e31b@redhat.com>
 <8ba5dba7-1849-46ff-b708-a9caac66be27@redhat.com>
 <b2b52017-c4cd-43e9-a67b-2ccbb92ad99e@redhat.com>
 <874jdbmst4.fsf@suse.de> <ZfByYiL3Gl9d9u7h@x1n>
 <87wmq7l2xx.fsf@suse.de>
 <b9cb5c16-59a4-4cdc-9d12-6d7c2306b4ff@redhat.com>
 <ZfQqpK0xCwygYYho@x1n>
 <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c946ae1f-3315-496e-b316-33343e43830f@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Mar 15, 2024 at 01:20:49PM +0100, Cédric Le Goater wrote:
> On 3/15/24 12:01, Peter Xu wrote:
> > On Fri, Mar 15, 2024 at 11:17:45AM +0100, Cédric Le Goater wrote:
> > > > migrate_set_state is also unintuitive because it ignores invalid state
> > > > transitions and we've been using that property to deal with special
> > > > states such as POSTCOPY_PAUSED and FAILED:
> > > > 
> > > > - After the migration goes into POSTCOPY_PAUSED, the resumed migration's
> > > >     migrate_init() will try to set the state NONE->SETUP, which is not
> > > >     valid.
> > > > 
> > > > - After save_setup fails, the migration goes into FAILED, but wait_unplug
> > > >     will try to transition SETUP->ACTIVE, which is also not valid.
> > > > 
> > > 
> > > I am not sure I understand what the plan is. Both solutions are problematic
> > > regarding the state transitions.
> > > 
> > > Should we consider that waiting for failover devices to unplug is an internal
> > > step of the SETUP phase not transitioning to ACTIVE ?
> > 
> > If to unblock this series, IIUC the simplest solution is to do what Fabiano
> > suggested, that we move qemu_savevm_wait_unplug() to be before the check of
> > setup() ret.
> 
> The simplest is IMHO moving qemu_savevm_wait_unplug() before
> qemu_savevm_state_setup() and leave patch 10 is unchanged. See
> below the extra patch. It looks much cleaner than what we have
> today.

Yes it looks cleaner indeed, it's just that then we'll have one more
possible state conversions like SETUP->UNPLUG->SETUP.  I'd say it's fine,
but let's also copy Laruent and Laine if it's going to be posted formally.

Thanks,

> 
> > In that case, the state change in qemu_savevm_wait_unplug()
> > should be benign and we should see a super small window it became ACTIVE
> > but then it should be FAILED (and IIUC the patch itself will need to use
> > ACTIVE as "old_state", not SETUP anymore).
> 
> OK. I will give it a try to compare.
> 
> > For the long term, maybe we can remove the WAIT_UNPLUG state?
> 
> I hope so, it's an internal SETUP state for me.
> 
> > The only Libvirt support seems to be here:
> > 
> > commit 8a226ddb3602586a2ba2359afc4448c02f566a0e
> > Author: Laine Stump <laine@redhat.com>
> > Date:   Wed Jan 15 16:38:57 2020 -0500
> > 
> >      qemu: add wait-unplug to qemu migration status enum
> > 
> > Considering that qemu_savevm_wait_unplug() can be a noop if the device is
> > already unplugged, I think it means no upper layer app should rely on this
> > state to present.
> 
> Thanks,
> 
> C.
> 
> 
> > 
> @@ -3383,11 +3383,10 @@ bool migration_rate_limit(void)
>   * unplugged
>   */
> -static void qemu_savevm_wait_unplug(MigrationState *s, int old_state,
> -                                    int new_state)
> +static void qemu_savevm_wait_unplug(MigrationState *s, int state)
>  {
>      if (qemu_savevm_state_guest_unplug_pending()) {
> -        migrate_set_state(&s->state, old_state, MIGRATION_STATUS_WAIT_UNPLUG);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_WAIT_UNPLUG);
>          while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
>                 qemu_savevm_state_guest_unplug_pending()) {
> @@ -3410,9 +3409,7 @@ static void qemu_savevm_wait_unplug(Migr
>              }
>          }
> -        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG, new_state);
> -    } else {
> -        migrate_set_state(&s->state, old_state, new_state);
> +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG, state);
>      }
>  }
> @@ -3469,17 +3466,19 @@ static void *migration_thread(void *opaq
>          qemu_savevm_send_colo_enable(s->to_dst_file);
>      }
> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP);
> +
>      bql_lock();
>      qemu_savevm_state_setup(s->to_dst_file);
>      bql_unlock();
> -    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> -                               MIGRATION_STATUS_ACTIVE);
> -
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>      trace_migration_thread_setup_complete();
> +    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                      MIGRATION_STATUS_ACTIVE);
> +
>      while (migration_is_active()) {
>          if (urgent || !migration_rate_exceeded(s->to_dst_file)) {
>              MigIterateState iter_state = migration_iteration_run(s);
> @@ -3580,18 +3579,20 @@ static void *bg_migration_thread(void *o
>      ram_write_tracking_prepare();
>  #endif
> +    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP);
> +
>      bql_lock();
>      qemu_savevm_state_header(s->to_dst_file);
>      qemu_savevm_state_setup(s->to_dst_file);
>      bql_unlock();
> -    qemu_savevm_wait_unplug(s, MIGRATION_STATUS_SETUP,
> -                               MIGRATION_STATUS_ACTIVE);
> -
>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>      trace_migration_thread_setup_complete();
> +    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> +                      MIGRATION_STATUS_ACTIVE);
> +
>      bql_lock();
>      if (migration_stop_vm(s, RUN_STATE_PAUSED)) {
> 

-- 
Peter Xu


