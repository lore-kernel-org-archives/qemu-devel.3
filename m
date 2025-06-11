Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC250C71136
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 21:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPT6j-0000gT-Pi; Wed, 11 Jun 2025 17:35:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPT6i-0000gD-6s
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 17:35:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPT6g-0007NA-0H
 for qemu-devel@nongnu.org; Wed, 11 Jun 2025 17:35:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749677733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0RDaK26vHHqNmSceTt79pJC2EttKN6NvFdXDi1SfyK0=;
 b=KFJiSye77OMi2deSF6MnP0XVb3wIb7MvDhKnZB92Nyqe3Vh12+/JfEptcE9+HR6MtmIHjk
 w05SkyFuuz7HgGqaErS/ERfLZx2LsC9SJtBzF08gN5WQsR47yH58Epj1FhIjyCukGjKvjV
 XxxdQl162csq3kkv6ZU/M8Qq/czwLXg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-_1YqbRVGNFCM5FXr838csQ-1; Wed, 11 Jun 2025 17:35:32 -0400
X-MC-Unique: _1YqbRVGNFCM5FXr838csQ-1
X-Mimecast-MFC-AGG-ID: _1YqbRVGNFCM5FXr838csQ_1749677732
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fac216872cso6598346d6.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 14:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749677731; x=1750282531;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RDaK26vHHqNmSceTt79pJC2EttKN6NvFdXDi1SfyK0=;
 b=LqwOtL/fdIMnm4c0ApusvciRL22yS9lx9ET5Xo1n7X6wg77MR7Ata21LsjgZosXOg5
 EPrYWuYsHNP/vKxjrhuz9j8Vn+7AGUzAJJfRRF7oza+8EIuE3wzoJTdlBDmS7gTo+50k
 v0kh/laTVLB4P8IYXXm1Hkizjb6NvbxGt/5ugaKqpWI6ulc6uFS4QQjG/yZE2Xt2+VvJ
 TeNA5rfaE0gmPNyuXthax0SQdTTMETQYx9gpC06Jb/5DALcYGK3YkN8mJAdQYyXfs/JU
 eNEnvofKox0wFg/t5FZsfhrep3UBgBFr2DaQ0NTAAXmy7f2DOxLOo1GYXAz+jRDwO/hv
 HHGQ==
X-Gm-Message-State: AOJu0Yx2S3Ok+ta5/g7yktG5Djg8eUibRumQLRdc4rwxqq2PwMGrrpKX
 sH1USJi1NZpeX1IukkuJC+pJlGE6jXlI9Kn2ufzyTqML3sItFf6ySjptM27olDvhuVuG2XdsvGg
 8ARlhwaLjyup59DH616vCstl5QDiGEhmajom6yDJ/74BhF3wuAoZdjN1qWeO1S7lmIPlumubB4s
 06pe0/P+uw7xhvaEy5f8RIvBHsd87yU7UR7C5fYA==
X-Gm-Gg: ASbGnctt+KgS0l5YJ5RI5rggcrTFsDtrfslRrgmzsG2I1OqHHs+iNzY1Ey7/soDP5tV
 XsSZ4x6z6sGqLCIM72yAJjDz+br58zJAmSYRk5cdVk4JHsWqNnrHEI5PgpyWSqO0clPofhwGXPb
 SVI3SosLaqPhymojqqXEgtIswN63VBlYjAwrYvh/1Nlmc51klatzrUDs/9aTxvkXsgBWF8XnUsH
 hAYEL5/b5fbAjq9iQQd7f1fRtVpkk+SEEE7t8OFlNmSsV8iSUol6zL1zcbjqcagEc9+DUWhHIDn
 RJW7JzK5N/eFxg==
X-Received: by 2002:a05:6214:202e:b0:6fa:bb44:fde4 with SMTP id
 6a1803df08f44-6fb3460dd2fmr17759196d6.17.1749677731164; 
 Wed, 11 Jun 2025 14:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI/mCiZJ0zvsWmFwV+JsXVhw/3/AyekRmtS9flSsXYPSv/FsXY7lE11FDwLG/L172JoczQrw==
X-Received: by 2002:a05:6214:202e:b0:6fa:bb44:fde4 with SMTP id
 6a1803df08f44-6fb3460dd2fmr17758826d6.17.1749677730730; 
 Wed, 11 Jun 2025 14:35:30 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c428bcsm372906d6.82.2025.06.11.14.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 14:35:30 -0700 (PDT)
Date: Wed, 11 Jun 2025 17:35:21 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 00/11] migration: Some enhancements and cleanups for
 10.1
Message-ID: <aEn2mSwdj2SB-dwe@x1.local>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Jun 09, 2025 at 12:18:44PM -0400, Peter Xu wrote:
> v2:
> - Collected R-bs
> - Avoid using "\b" in HMP dumps [Markus, Dave]
> 
> The series is based on a small patch from Yanfei Xu here:
> 
> Based-on: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
> https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com
> 
> This is a series that collected many of either enhancements or cleanups I
> got for QEMU 10.1, which almost came from when working on the last patch.
> 
> The last patch, which is a oneliner, can further reduce 10% postcopy page
> fault latency with preempt mode enabled.
> 
>       Before: 268.00us (+-1.87%)
>       After:  232.67us (+-2.01%)
> 
> The patch layout is as following:
> 
> Patch 1:         A follow up of HMP change for "info migrate", per
>                  suggestion from Dave
> Patch 2:         Yet another HMP fix for blocktime displays
> Patch 3-10:      Cleanups everywhere, especially please take a look at
>                  patch 10 which changes the core switchover decision logic
> Patch 11:        The one-liner optimization
> 
> Comments welcomed, thanks.
> 
> Peter Xu (11):
>   migration/hmp: Reorg "info migrate" once more
>   migration/hmp: Fix postcopy-blocktime per-vCPU results
>   migration/docs: Move docs for postcopy blocktime feature
>   migration/bg-snapshot: Do not check for SKIP in iterator
>   migration: Drop save_live_complete_postcopy hook
>   migration: Rename save_live_complete_precopy to save_complete
>   migration: qemu_savevm_complete*() helpers
>   migration/ram: One less indent for ram_find_and_save_block()
>   migration/ram: Add tracepoints for ram_save_complete()
>   migration: Rewrite the migration complete detect logic
>   migration/postcopy: Avoid clearing dirty bitmap for postcopy too

There're two checkpatch issues need fixing.  Two fixups will be needed as
below, one remove a space, one fix 80 chars.  I'll squash if I'm sending
new versions.

Sorry for the noise.

===8<===

From 25356e1262006fd668ba4e29b01325b5e784e19a Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 11 Jun 2025 17:23:00 -0400
Subject: [PATCH] fixup! migration/hmp: Fix postcopy-blocktime per-vCPU results

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 6c36e202a0..867e017b32 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -212,7 +212,7 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         const char *sep = "";
         int count = 0;
 
-        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
 
         while (item) {
             monitor_printf(mon, "%s%"PRIu32, sep, item->value);
-- 
2.49.0


From 58dfb3e311fb477732d0f109886d02adcb439e14 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 11 Jun 2025 17:23:38 -0400
Subject: [PATCH] fixup! migration: Rewrite the migration complete detect logic

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 1a26a4bfef..923400f801 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3460,7 +3460,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         if (pending_size < s->threshold_size) {
             qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
             pending_size = must_precopy + can_postcopy;
-            trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
+            trace_migrate_pending_exact(pending_size, must_precopy,
+                                        can_postcopy);
         }
 
         /* Should we switch to postcopy now? */
-- 
2.49.0


-- 
Peter Xu


