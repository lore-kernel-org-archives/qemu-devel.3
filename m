Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE5B2D3C52C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 19:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1WG1-0000bK-9R; Thu, 17 Oct 2024 15:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1WG0-0000bA-LG
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:34:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t1WFy-0000hU-MJ
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 15:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729193636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KKjGA1hLevvwG3GTVC3hcQC9Yd6a5bOpv2jSXD7fWrU=;
 b=b8dQ3aWc8POIhkgcmq7pYV5hQyApWqHCRLLoJ2AhoSj1Pzo4tey8MDRd0ulkN4XPlpXdMr
 U/kzguaX8VtVnLUO+1w/g2Lg3ymNRcAnucAKTRcKGgxNXDcVDLiJMVSNqp35JBZVn5yLjT
 6nEeGip/1m61P19Ic4NPfayoAGrq0+Q=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-NWxBE0WoM5K08ARyd7qO2g-1; Thu, 17 Oct 2024 15:33:54 -0400
X-MC-Unique: NWxBE0WoM5K08ARyd7qO2g-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5eb8825a75cso165634eaf.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 12:33:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729193633; x=1729798433;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKjGA1hLevvwG3GTVC3hcQC9Yd6a5bOpv2jSXD7fWrU=;
 b=O7MWn/6o3Su7eEms27vmXcS3rQn+xeoTiWw+MfjU26B6FSLKPrzPwwhmZ1ROKlXtcR
 437G91tPJhzHNGQAjURBHkpKMMecblPiTvXUl4Mh51/g0ijGZSJWb8zTE31wrA29PXyx
 FiqV6GVEYFNIIzxbOjPD/5q6Z32PbPLH7IaxgZNOFvPqCauyg6Xl/FBasUSuJnfHRj52
 T3iFypLuAu7FMOnyNmpKuYq1ivrZ5dZ6vehOTrAeiwOSxSthaGNVJfyude4Hanz1naqH
 mwK3P37s6jt2BOBpxZyZncpyXbqwGU89+XLYcpUpcvhjPINIpdkMYngRcVRx9I2GN0kP
 ScQw==
X-Gm-Message-State: AOJu0Yy+WaErT+eO/X2zk/c8mzp/VtK0EXUBac4rBeFR40+cJRgnO0ZQ
 6SvOzIxWdma4zs1CvMetpiNuAkaf5bPBvhXi6U/jhD4ghfdgB5PjVrElS7XFU2/nAizjG94xImi
 1atjxWzL3g9FJR6QB+nGZjGad7Hfma9jKMesEoqA8pRqROQuYPmOP
X-Received: by 2002:a05:6358:4403:b0:1b8:688e:6ea5 with SMTP id
 e5c5f4694b2df-1c3784a773dmr736763055d.22.1729193633526; 
 Thu, 17 Oct 2024 12:33:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzXGj7R5EmkVFQhfEERIIhsyTvzdPVQ8tWEd4lKePibTSXv5nLk88A6+3qMhvRs6KDgOeK5w==
X-Received: by 2002:a05:6358:4403:b0:1b8:688e:6ea5 with SMTP id
 e5c5f4694b2df-1c3784a773dmr736761655d.22.1729193633121; 
 Thu, 17 Oct 2024 12:33:53 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cc2290fe81sm30956296d6.18.2024.10.17.12.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 12:33:52 -0700 (PDT)
Date: Thu, 17 Oct 2024 15:33:49 -0400
From: Peter Xu <peterx@redhat.com>
To: yong.huang@smartx.com, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 5/6] migration: Support periodic RAMBlock dirty bitmap
 sync
Message-ID: <ZxFmnZqgRlGaQax_@x1n>
References: <cover.1729146786.git.yong.huang@smartx.com>
 <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f61f1b3653f2acf026901103e1c73d157d38b08f.1729146786.git.yong.huang@smartx.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 17, 2024 at 02:42:54PM +0800, yong.huang@smartx.com wrote:
> +void cpu_throttle_dirty_sync_timer_tick(void *opaque)
> +{
> +    static uint64_t prev_sync_cnt;

We may need to reset this in case migration got cancelled and invoked
again, to make sure it keeps working in the 2nd run.

> +    uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +
> +    /*
> +     * The first iteration copies all memory anyhow and has no
> +     * effect on guest performance, therefore omit it to avoid
> +     * paying extra for the sync penalty.
> +     */
> +    if (sync_cnt <= 1) {
> +        goto end;
> +    }
> +
> +    if (sync_cnt == prev_sync_cnt) {
> +        trace_cpu_throttle_dirty_sync();
> +        WITH_RCU_READ_LOCK_GUARD() {
> +            migration_bitmap_sync_precopy(false);
> +        }
> +    }
> +
> +end:
> +    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
> +
> +    timer_mod(throttle_dirty_sync_timer,
> +        qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
> +            CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
> +}

Please both of you have a look on whether you agree I squash below into
this patch when merge:

===8<===
From 84a2544eab73e35dbd35fed3b1440169915f9aa4 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 17 Oct 2024 15:27:19 -0400
Subject: [PATCH] fixup! migration: Support periodic RAMBlock dirty bitmap sync

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpu-throttle.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 342681cdd4..3df287d8d3 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -36,6 +36,7 @@
 static QEMUTimer *throttle_timer, *throttle_dirty_sync_timer;
 static unsigned int throttle_percentage;
 static bool throttle_dirty_sync_timer_active;
+static uint64_t throttle_dirty_sync_count_prev;
 
 #define CPU_THROTTLE_PCT_MIN 1
 #define CPU_THROTTLE_PCT_MAX 99
@@ -133,7 +134,6 @@ int cpu_throttle_get_percentage(void)
 
 void cpu_throttle_dirty_sync_timer_tick(void *opaque)
 {
-    static uint64_t prev_sync_cnt;
     uint64_t sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
 
     /*
@@ -145,7 +145,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
         goto end;
     }
 
-    if (sync_cnt == prev_sync_cnt) {
+    if (sync_cnt == throttle_dirty_sync_count_prev) {
         trace_cpu_throttle_dirty_sync();
         WITH_RCU_READ_LOCK_GUARD() {
             migration_bitmap_sync_precopy(false);
@@ -153,7 +153,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
     }
 
 end:
-    prev_sync_cnt = stat64_get(&mig_stats.dirty_sync_count);
+    throttle_dirty_sync_count_prev = stat64_get(&mig_stats.dirty_sync_count);
 
     timer_mod(throttle_dirty_sync_timer,
         qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
@@ -171,6 +171,11 @@ void cpu_throttle_dirty_sync_timer(bool enable)
 
     if (enable) {
         if (!cpu_throttle_dirty_sync_active()) {
+            /*
+             * Always reset the dirty sync count cache, in case migration
+             * was cancelled once.
+             */
+            throttle_dirty_sync_count_prev = 0;
             timer_mod(throttle_dirty_sync_timer,
                 qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL_RT) +
                     CPU_THROTTLE_DIRTY_SYNC_TIMESLICE_MS);
-- 
2.45.0

-- 
Peter Xu


