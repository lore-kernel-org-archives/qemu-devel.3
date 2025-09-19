Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A54BCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzfGA-0006xk-8T; Fri, 19 Sep 2025 13:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzfG8-0006xX-Al
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uzfG4-0006Cs-JR
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758304253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kFLwhx1yxjwAvAeBQuun8IZwowW777hGdn3jgBMo5p8=;
 b=JRZbxWBHSGbBatVYBIni/p60xN0gGdvuLjYUH54Hz1jlkaBev6yhZ6fBa0xtwthhRU1f2A
 lKnewn24JocpoemVYDUfhwUlTCGJ0TAYMgfVp9RzQ4MaTmRiQrSETzfV401GOCACA/qc3N
 kyog8M1mLJg63/pK1u4QqY3TcN0c9/g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-mIpuOabENuSsHou-Ep8wHg-1; Fri, 19 Sep 2025 13:50:51 -0400
X-MC-Unique: mIpuOabENuSsHou-Ep8wHg-1
X-Mimecast-MFC-AGG-ID: mIpuOabENuSsHou-Ep8wHg_1758304251
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4b5f31ef7dfso61386581cf.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 10:50:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758304251; x=1758909051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kFLwhx1yxjwAvAeBQuun8IZwowW777hGdn3jgBMo5p8=;
 b=JX8x67qjtauSEDYU6dH5UTQdaIiLVt1JVANIkPKOGZVOssGRab76YTTC+793GDkjPI
 nzMGcpT66RhwTTkP262epVdi9FHnhnW7q2Maxy/dx87iHDsYWaipA5OkMuGfUud/sAU1
 290ZrEISlMtSgbUXK0ihZ71hUHdbqjB7ox6HZipKYyvNn0NzfeojyrPv/n6L63vmQJ8x
 Tkr/fH41mo2vND6hVPm5W8au4dKJ5LZ694PyCCiDY+Fz4eao8AFapj6Q6ao+VnxlGokA
 E0FFHTBy04VMFe+QXNGT3ev1NC+GUftjSeSpskPQAfXj32SWuKSld/mmEgYPwkRRvD5J
 keOQ==
X-Gm-Message-State: AOJu0YzULA1gxX1azLlnu5jyRsXuroKMsRHnvJvgchy659OoxYy44gWB
 keFRblv4uRgXcjxTe26rViNoQenJQqOnMkJT8HnPZ+57JglhiHRzosfP5iHZyewy4bxSNqpzsPo
 Z6oMe/eCh7ON83WWnKA7gsDyIX/qrfAME6u+XgABmdpX3MhCZcALm4YMg
X-Gm-Gg: ASbGnct9TjpgFsykEQc1g5nNSTfCUMZlyCnlQ78gSZWOhdhCNnE5PthTUHp7EvVrDEo
 r0sE/BTEXnJJn1MnyVdkEFXxmQnsIraHIBjkysy3hbvFzWZONbwvgi62e8lyk6Bk3ggwUIJCfj9
 J3gehIWaMF9D3FHHFWr7r5Vlodec3ni0UkJubpKDiwdQNw3KpCp6mBsoH4AgyQbzMJSnC5WVqi+
 zjaHftP0k+Z/A6Dg3xyjIzvdF6XkBikgOPPY73XtHxj36uwBNPUl4OJSVrG5WiH97812oATx9tY
 +Q6SpJKYOdAJHZMLw0fVILzjTXq0SYRS
X-Received: by 2002:ac8:7d86:0:b0:4b7:b051:a531 with SMTP id
 d75a77b69052e-4bdada0c411mr76749391cf.20.1758304251052; 
 Fri, 19 Sep 2025 10:50:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOyWB5HHXUPNfcP2Qa1Ivdm3Ctbq4G/HlQeS3NOY9ML5kfc5n11gv7sCuI/yli+mjDw8uBFQ==
X-Received: by 2002:ac8:7d86:0:b0:4b7:b051:a531 with SMTP id
 d75a77b69052e-4bdada0c411mr76749141cf.20.1758304250575; 
 Fri, 19 Sep 2025 10:50:50 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4bda8998580sm32029181cf.30.2025.09.19.10.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 10:50:49 -0700 (PDT)
Date: Fri, 19 Sep 2025 13:50:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jiri Denemark <jdenemar@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aM2X-N9gXvFxxdvI@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aM2LoGDh5WsVnEi8@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aM2LoGDh5WsVnEi8@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Sep 19, 2025 at 12:58:08PM -0400, Peter Xu wrote:
> > @@ -2564,6 +2569,11 @@ static void *source_return_path_thread(void *opaque)
> >              tmp32 = ldl_be_p(buf);
> >              trace_source_return_path_thread_pong(tmp32);
> >              qemu_sem_post(&ms->rp_state.rp_pong_acks);
> > +            if (tmp32 == QEMU_VM_PING_PACKAGED_LOADED) {
> > +                trace_source_return_path_thread_dst_started();
> > +                migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> > +                                  MIGRATION_STATUS_POSTCOPY_ACTIVE);
> 
> Could this race with the migration thread modifying the state concurrently?
> 
> To avoid it, we could have a bool, set it here once, and in the iterations
> do something like:
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..55230e10ee 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3449,6 +3449,16 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>      trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
>  
>      if (in_postcopy) {
> +        if (s->postcopy_package_loaded) {
> +            assert(s->state == MIGRATION_STATUS_POSTCOPY_DEVICE);
> +            migrate_set_state(s->state, MIGRATION_STATUS_POSTCOPY_DEVICE,
> +                              MIGRATION_STATUS_POSTCOPY_ACTIVE);
> +            /*
> +             * Since postcopy cannot be re-initiated, this flag will only
> +             * be set at most once for QEMU's whole lifecyce.
> +             */
> +            s->postcopy_package_loaded = false;
> +        }
>          /*
>           * Iterate in postcopy until all pending data flushed.  Note that
>           * postcopy completion doesn't rely on can_switchover, because when

[...]

> > @@ -2871,7 +2882,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
> >  
> >      /* Now, switchover looks all fine, switching to postcopy-active */
> >      migrate_set_state(&ms->state, MIGRATION_STATUS_DEVICE,
> > -                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
> > +                      MIGRATION_STATUS_POSTCOPY_DEVICE);
> >  
> >      bql_unlock();
> >  
> > @@ -3035,7 +3046,8 @@ static void migration_completion(MigrationState *s)
> >  
> >      if (s->state == MIGRATION_STATUS_ACTIVE) {
> >          ret = migration_completion_precopy(s);
> > -    } else if (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> > +    } else if (s->state == MIGRATION_STATUS_POSTCOPY_DEVICE ||
> > +               s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
> 
> Exactly.  We need to be prepared that src sending too fast so when device
> loading on dest we finished.

One thing more to mention here.. which may void some previous comments I
left.  Let's discuss.

I think it may also make sense to only allow a COMPLETE after
POSTCOPY_ACTIVE.

That is, if src sends too fast to have finished sending everything,
reaching COMPLETE during POSTCOPY_DEVICE, that is, while before it receives
the new PONG you defined, then.. I _think_ it is better to wait for that.

If it finally arrives, then it's perfect, we switch to POSTCOPY_ACTIVE,
then continue the completion.

If the channel is broken before its arrival, logically we should handle
this case as a FAILURE and restart the VM on src.

It's only relevant in a corner case, but does that sound better?

-- 
Peter Xu


