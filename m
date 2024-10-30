Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAE6D6B6A1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 16:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5L-0003p4-25; Wed, 30 Oct 2024 11:58:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5H-0003o5-VQ
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5G-0007qH-2G
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2azfgrHGWZXFInBw3IGghM+a5xX+aBe1mBdMjVZb6pQ=;
 b=gJvrNjm01XYdJigX2ubTV42suZms3233CZUgUTDRaiBdk6wckVjRvBCOgdIRaRpYgNEaCs
 drQaZSGBBNElb2ASVideOtJA2LOUiz41xTqKNPhyOGEsCgIf+EPusMoiRokDJy5V7NT5bF
 EXI8wug1SoYyXkZT7H2rhKKeI8xLvWo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-15iv24NzPUGKwcuEuzrCKA-1; Wed, 30 Oct 2024 11:58:08 -0400
X-MC-Unique: 15iv24NzPUGKwcuEuzrCKA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cdeed5a061so97961766d6.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303887; x=1730908687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2azfgrHGWZXFInBw3IGghM+a5xX+aBe1mBdMjVZb6pQ=;
 b=mOBFsBLq9txngJoFkcQltJmMBKZ8yXBHwgBKUqauCOhcEHcsrQYr+RdgrKSd6EPVJi
 XbMN1VX5tTk98RjPRllso0ATCrhiH4ECfkvVHxngR2lkJEIgIQ5a3a9UX+Hc8Bx5BYe9
 bHDPsOt2Z/RoBWixsHqXPueMLKFJ1ndnNl6geJTZcsodiSaySUJ86AwgBms7MUW2KLVH
 riW1U+Zt2F6FxAeIDX0BqGFlKo57GuJeyr9TLj7xGOUsiNTLKE9b+ZT9eF32L1Elfn1d
 d0LmbMneQteeHTtpnhjrKE1/B1Knz2bnbKLmItdgyKxwnd40JlKzUofghtKSqnmhGuxT
 OsiQ==
X-Gm-Message-State: AOJu0Yw4lB136y2erWrzg60Oa+XEQJuP/P/K8n6Cuh2TQtON5KHEdXYk
 9gUygw5OvjEGyIbJQoY85MJfYVC91rs9FwrHpnbPKh6DTtqCVUqih+0Dh5KDF6NNk2fIJ1Wa3aE
 WeNHPaR6iTCdY2tI/DJc06FACqYGLTnUMiH0gR8N3tuRplenBGeSjyHlKNUFPhEtoWpPQdrOv46
 f2jNlbzNnh13P2XF4yBv1VZEjqtqHT/b9i/g==
X-Received: by 2002:a05:6214:4411:b0:6ce:26d0:c7af with SMTP id
 6a1803df08f44-6d18571761emr180022706d6.31.1730303887212; 
 Wed, 30 Oct 2024 08:58:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHW2MNWZEqv4BU6M3I56hGMzOsfrW22HsHDYq01ihZkDo8Hu20mkIUmZu+0fbvY83duhvDyTw==
X-Received: by 2002:a05:6214:4411:b0:6ce:26d0:c7af with SMTP id
 6a1803df08f44-6d18571761emr180022456d6.31.1730303886841; 
 Wed, 30 Oct 2024 08:58:06 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:58:05 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 17/18] migration/ram: Add load start trace event
Date: Wed, 30 Oct 2024 11:57:33 -0400
Message-ID: <20241030155734.2141398-18-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

There's a RAM load complete trace event but there wasn't its start equivalent.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/94ddfa7ecb83a78f73b82867dd30c8767592d257.1730203967.git.maciej.szmigiero@oracle.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 1 +
 migration/trace-events | 1 +
 2 files changed, 2 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 504b48d584..12031df4e5 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -4294,6 +4294,7 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
      * it will be necessary to reduce the granularity of this
      * critical section.
      */
+    trace_ram_load_start();
     WITH_RCU_READ_LOCK_GUARD() {
         if (postcopy_running) {
             /*
diff --git a/migration/trace-events b/migration/trace-events
index 0638183056..bb0e0cc6dc 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -115,6 +115,7 @@ colo_flush_ram_cache_end(void) ""
 save_xbzrle_page_skipping(void) ""
 save_xbzrle_page_overflow(void) ""
 ram_save_iterate_big_wait(uint64_t milliconds, int iterations) "big wait: %" PRIu64 " milliseconds, %d iterations"
+ram_load_start(void) ""
 ram_load_complete(int ret, uint64_t seq_iter) "exit_code %d seq iteration %" PRIu64
 ram_write_tracking_ramblock_start(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"
 ram_write_tracking_ramblock_stop(const char *block_id, size_t page_size, void *addr, size_t length) "%s: page_size: %zu addr: %p length: %zu"
-- 
2.45.0


