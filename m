Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A864CE7DEE3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmusd-00022W-QN; Mon, 02 Feb 2026 09:26:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmusY-00021q-G3
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vmusW-0004lz-Sa
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770042371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U/5w9drX3tzG/anYr9Kv0P5u6Nf3b2AYC44Ox/DM1DQ=;
 b=KQ+8mIAlJ5Uez9cC3llzM8MA61fTOF01w3oaqQmO3nL30GzWfKMGZB/NlE8LeERBJNCFw+
 yBnuMg4+PDSzz9jHgjCW1A7BmqzbgAZDr7rFeYlhwwdUqHdEFXNOczxHh7QbXX1hOS1Gkt
 tEBaAqdJ0G5dZ6HCaZypycGUs2uIlLU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-20_yTBFhNA2gFNAY2-0OwQ-1; Mon, 02 Feb 2026 09:26:09 -0500
X-MC-Unique: 20_yTBFhNA2gFNAY2-0OwQ-1
X-Mimecast-MFC-AGG-ID: 20_yTBFhNA2gFNAY2-0OwQ_1770042369
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c71304beb4so1046699385a.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770042369; x=1770647169; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U/5w9drX3tzG/anYr9Kv0P5u6Nf3b2AYC44Ox/DM1DQ=;
 b=kw96pah6b5ADufp7Hv9iH98+STD3WD9ZRobWkPSmol2ggpN6j3tsJlJ3TDLOpHSub8
 MS18mvBhsavUJLMhMBG4+M/ynCWzyTqy0eRDeeKdqR/vYJN5h9gFD2WdwEcMvV6AXYU9
 7B3GCkGge3Oy5JSJsj0p1LKYXf8gAJ/qPv8Bsu3nMGySy4NnP6I1ltSTp7+DsFqAvgkv
 LrCe7Rp20tLU964h8Xf6B6ddUY34u9wN1pTV+flYYoZZqGVqD/sbm/gtFE+w8fpkLXhh
 ZGcj5C54SqLCczurPPsk+xXC4BwkpdkO7tVkYZpKY0zSydXls1zug+J8jExmr7fjFTKm
 RR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770042369; x=1770647169;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U/5w9drX3tzG/anYr9Kv0P5u6Nf3b2AYC44Ox/DM1DQ=;
 b=X2RCGGZxpIH0ddSvaevKbXfJTz4B6P63zesmx5tn2Yo3EtvpPKk+ytL5QAAU5oz12a
 RPcmxFjn8E6ppWCAOfzINyavPsKmr5muuGsmS1YmI9i+LDsr8uPl2eC0/0QaCpm5fZ9v
 B0chbCTHiT6DdQjhD5si8oR6AVQcqrsD9lQcB7suFM4Nie4ZWcCS4xUr7HiZ5H9aEMfH
 kiSoKQsMnILtjtGkp9ox+LSpu2w3i4Rf+iraI5Kh4qQ19rEEXAVC3MoLXl0fZYOhlJl2
 FrUO1Po2v0pFOQ5QwLYpvvyrck/v/C7RcaPpiT21/edLivsbvpVv60qOUm6fcc6h8R7X
 tLbw==
X-Gm-Message-State: AOJu0YyYbvtW2gIwvRnTDZQE+af19ME2p1/YYUkTZXP/lk48x28jpkhl
 7wY78MkdDwEN+rDoHakqKqLwD1dspags5zU4SzlhEHOVz+sS+m0Lfg2D+SdfKOp2sDRaH+zRMLm
 tNczMFidHXDbLDkcoXAoUm+rGd3x5drV+0lZ7zjJF+muzysHBGVuWyctC
X-Gm-Gg: AZuq6aKJU8aVjIjWnhFP6XRD/CDs5xY2ulABKigrPIgKs+sts8zUCGlussK48OVzhwO
 UEpRkuVlcduUOOoa+Fq5I0LAGK8dcQaqvW/EYCas3/DRbYNlMHI88ooX55jx4eiDp36eoKAFX9D
 AmldqhbIcmP417unx6WDcbW5yZu6/Ey6lxQZDeBo8t8L7h8Z44spdpk6aAzv8nzL+tkdhYRVuog
 O0Bd/m0h3mJIfBo1/JOPWnhVjnjoHpwnvVDpMFKlUQEMiQx4VgcSdnrB0XL5dD6/QAxHQvmQx0q
 +C+geya2Vd/4tpEIwOa+yqOcvQCDsRxOOUkaXM37ZSFjuG/NTi+CQTO7yi9cQxFeYSF0l88qM4Y
 DTTU=
X-Received: by 2002:a05:620a:4149:b0:8c6:b45b:9e2e with SMTP id
 af79cd13be357-8c9eb28e99cmr1460783685a.38.1770042369223; 
 Mon, 02 Feb 2026 06:26:09 -0800 (PST)
X-Received: by 2002:a05:620a:4149:b0:8c6:b45b:9e2e with SMTP id
 af79cd13be357-8c9eb28e99cmr1460779585a.38.1770042368623; 
 Mon, 02 Feb 2026 06:26:08 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c711b95e43sm1244098485a.17.2026.02.02.06.26.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 06:26:08 -0800 (PST)
Date: Mon, 2 Feb 2026 09:26:06 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhang Chen <zhangckid@gmail.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Markus Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v3 06/10] migration-test: Add COLO migration unit test
Message-ID: <aYCz_se6Ji2g5d_L@x1.local>
References: <20260125-colo_unit_test_multifd-v3-0-ae926ccd8eae@web.de>
 <20260125-colo_unit_test_multifd-v3-6-ae926ccd8eae@web.de>
 <aXkk22x1M0k4qZoo@x1.local> <20260130112402.2c008707@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260130112402.2c008707@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Fri, Jan 30, 2026 at 11:24:02AM +0100, Lukas Straub wrote:
> On Tue, 27 Jan 2026 15:49:31 -0500
> Peter Xu <peterx@redhat.com> wrote:
> 
> > On Sun, Jan 25, 2026 at 09:40:11PM +0100, Lukas Straub wrote:
> > > +void migration_test_add_colo(MigrationTestEnv *env)
> > > +{
> > > +    if (!env->has_kvm) {
> > > +        g_test_skip("COLO requires KVM accelerator");
> > > +        return;
> > > +    }  
> > 
> > I'm OK if you want to explicitly bypass others, but could you explanation
> > why?
> > 
> > Thanks,
> > 
> 
> It used to hang with TCG. Now it crashes, since
> migration_bitmap_sync_precopy assumes bql is held. Something for later.

If we want to keep COLO around and be serious, let's try to make COLO the
same standard we target for migration in general whenever possible.  We
shouldn't randomly workaround bugs.  We should fix it.

It looks to me there's some locking issue instead.

Iterator's complete() requires BQL.  Would a patch like below makes sense
to you?

diff --git a/migration/colo.c b/migration/colo.c
index db783f6fa7..b3ea137120 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -458,8 +458,8 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
     /* Note: device state is saved into buffer */
     ret = qemu_save_device_state(fb);
 
-    bql_unlock();
     if (ret < 0) {
+        bql_unlock();
         goto out;
     }
 
@@ -473,6 +473,9 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
      */
     qemu_savevm_live_state(s->to_dst_file);
 
+    /* Save live state requires BQL */
+    bql_unlock();
+
     qemu_fflush(fb);
 
     /*

> 
> #6  0x00007ffff7471517 in __assert_fail
>     (assertion=assertion@entry=0x555555f17aee "bql_locked() != locked", file=file@entry=0x555555f17ab0 "../system/cpus.c", line=line@entry=535, function=function@entry=0x55555609bfd0 <__PRETTY_FUNCTION__.9> "bql_update_status") at ./assert/assert.c:105
> #7  0x0000555555b09f1e in bql_update_status (locked=locked@entry=false) at ../system/cpus.c:535
> #8  0x0000555555ec60e7 in qemu_mutex_pre_unlock (mutex=0x555557166700 <bql>, file=0x555555efe1dc "../cpu-common.c", line=164) at ../util/qemu-thread-common.h:57
> #9  qemu_mutex_pre_unlock (line=164, file=0x555555efe1dc "../cpu-common.c", mutex=0x555557166700 <bql>) at ../util/qemu-thread-common.h:48
> #10 qemu_cond_wait_impl (cond=0x5555571442c0 <qemu_work_cond>, mutex=0x555557166700 <bql>, file=0x555555efe1dc "../cpu-common.c", line=164) at ../util/qemu-thread-posix.c:224
> #11 0x000055555589e6c8 in do_run_on_cpu (cpu=<optimized out>, func=<optimized out>, data=..., mutex=0x555557166700 <bql>) at ../cpu-common.c:164
> #12 0x0000555555b17a06 in memory_global_after_dirty_log_sync () at ../system/memory.c:2938
> #13 0x0000555555b55b47 in migration_bitmap_sync (rs=0x7fffe8001340, last_stage=last_stage@entry=true) at ../migration/ram.c:1157
> #14 0x0000555555b56721 in migration_bitmap_sync_precopy (last_stage=last_stage@entry=true) at ../migration/ram.c:1195
> #15 0x0000555555b59f8a in ram_save_complete (f=0x5555575db620, opaque=<optimized out>) at ../migration/ram.c:3381
> #16 0x0000555555b5e4f5 in qemu_savevm_complete (se=se@entry=0x5555574c0d80, f=f@entry=0x5555575db620) at ../migration/savevm.c:1521
> #17 0x0000555555b60437 in qemu_savevm_state_complete_precopy_iterable (f=f@entry=0x5555575db620, in_postcopy=in_postcopy@entry=false) at ../migration/savevm.c:1627
> #18 0x0000555555b60a4f in qemu_savevm_state_complete_precopy (iterable_only=true, f=0x5555575db620) at ../migration/savevm.c:1719
> #19 qemu_savevm_live_state (f=0x5555575db620) at ../migration/savevm.c:1855
> #20 0x0000555555b65ed9 in colo_do_checkpoint_transaction (fb=<optimized out>, bioc=<optimized out>, s=0x5555574c0070) at ../migration/colo.c:474
> #21 colo_process_checkpoint (s=0x5555574c0070) at ../migration/colo.c:592
> #22 migrate_start_colo_process (s=0x5555574c0070) at ../migration/colo.c:655
> #23 0x0000555555b4971e in migration_iteration_finish (s=0x5555574c0070) at ../migration/migration.c:3297
> #24 migration_thread (opaque=opaque@entry=0x5555574c0070) at ../migration/migration.c:3584
> #25 0x0000555555ec58c0 in qemu_thread_start (args=0x5555576583e0) at ../util/qemu-thread-posix.c:393
> #26 0x00007ffff74d2aa4 in start_thread (arg=<optimized out>) at ./nptl/pthread_create.c:447
> #27 0x00007ffff755fc6c in clone3 () at ../sysdeps/unix/sysv/linux/x86_64/clone3.S:78



-- 
Peter Xu


