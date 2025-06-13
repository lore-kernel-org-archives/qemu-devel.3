Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58D0C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54u-00048g-Pl; Fri, 13 Jun 2025 10:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54q-00047S-Rt
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54o-0001T7-Qe
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hT+PxuMKRJ8Bh39RMhUF6/Cm7/wGAILL/wn1CqdT0Rg=;
 b=gVkHEBQdr4EP9lf/MLIXosrHU74fM0BLqdSphhK7Sy+bXuJzpUmByPwG2rN8KNaEMNheK5
 eyqCUBm8O32+VfuLQiaOKjLEyiEwzjjvJIGB8eLWSiXgVKEekdXPP6S2AhkXFAyuMM3so3
 M8+NRIZWxJSv+cNBBUNzm3iXVmkL2C4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-IErH_cxnMOm46BSBeis90Q-1; Fri, 13 Jun 2025 10:08:09 -0400
X-MC-Unique: IErH_cxnMOm46BSBeis90Q-1
X-Mimecast-MFC-AGG-ID: IErH_cxnMOm46BSBeis90Q_1749823689
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4a4403a6996so36788051cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823689; x=1750428489;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hT+PxuMKRJ8Bh39RMhUF6/Cm7/wGAILL/wn1CqdT0Rg=;
 b=Gm/fMSfn6SMnXoVmHUDB+Oy5un8rMBFWssLGbl/iMRhLsWYjMuDcFsSv6+scjiLyy5
 MX3nKIX6ALZ5CSxsv7+UvIZNYXKXGY8NcT2YTRtCnZ2+6Z0nkFAoE9GBbk8tQlfaU3ii
 CNZR/6BaWkm/+77HoPNO8V7LFnP1dKtjk/xqgqSHs1Xqv/N7ZFlPVFKFgrOmugu3QRgB
 RZ8iBKOG6/CcjoQdFjmsypm5LcmTsYspPSlHrcZcz5ejMgRMy2uGSfHXSHRMONjiIKRU
 2ILWVYfkyNVapeIjPSaH5JwALJ2yB4UMCyVDDF/A3hpwtLIVeOiaJHkHXb+Urytcb4Q4
 tENA==
X-Gm-Message-State: AOJu0YxNxgvEtXQJjtiyFOtwYL93XZW61s6emn1R8vOpqreqK5pJJLdp
 HWFcYIQgzClrVy+wWrLuELfDw1S1a33kAeJ+fn5psJLEyzhfoemdeY1ZhtUg/9EnSxhUKwZ+e/t
 PXYNtUlktZ0u24k59fhsSvykG6cHUA6AlaSI1yRgOmPIDjSklnPAltkYvPd5VngsFI5Svf035E0
 +HvC/s8XRTnmd2PzvsdtWeXoZornqVTe+bNuLKTQ==
X-Gm-Gg: ASbGncttCKvaE77XqYf3I7ZlBIVYeNULuF+TKnXu/gBFn7xDQs7Iz36D4YA9GrE5+BD
 1lsGG40wYFQ7EGKcT0lUnGCxpqX3nBEpLaayhAr/r5rCZwNNkPmj7v5yIWvyJQrhHc0+jX+D2rn
 kIC8CNxQyXxT9sSWJX1Y1RvfWGJDuHzXiC7nNdajpsPdP8PnID90N/hUBWusczksR4sqfkGdaA4
 WKXGDHs6O7Yv688zW0OfEceMEoNbqTiB/ac07XM33soZPQwV9eMworB6R4yRcupA42nrN0j1foo
 lcdroH2pBsU=
X-Received: by 2002:a05:622a:a13:b0:497:6a94:dba0 with SMTP id
 d75a77b69052e-4a72ff2b054mr49205991cf.25.1749823688826; 
 Fri, 13 Jun 2025 07:08:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGX/OhDRG0j7TAQTY7XwZhcR31JIiFgJNZqzcwSt4AWT8k/Zn/iuzHvytgbPv2QUzibcQHesA==
X-Received: by 2002:a05:622a:a13:b0:497:6a94:dba0 with SMTP id
 d75a77b69052e-4a72ff2b054mr49205591cf.25.1749823688324; 
 Fri, 13 Jun 2025 07:08:08 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:07 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 03/11] migration/docs: Move docs for postcopy blocktime
 feature
Date: Fri, 13 Jun 2025 10:07:53 -0400
Message-ID: <20250613140801.474264-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

Move it out of vanilla postcopy session, but instead a standalone feature.
When at it, removing the NOTE because it's incorrect now after introduction
of max-postcopy-bandwidth, which can control the throughput even for
postcopy phase.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 docs/devel/migration/postcopy.rst | 36 +++++++++++++++----------------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
index 82e7a848c6..e319388d8f 100644
--- a/docs/devel/migration/postcopy.rst
+++ b/docs/devel/migration/postcopy.rst
@@ -33,25 +33,6 @@ will now cause the transition from precopy to postcopy.
 It can be issued immediately after migration is started or any
 time later on.  Issuing it after the end of a migration is harmless.
 
-Blocktime is a postcopy live migration metric, intended to show how
-long the vCPU was in state of interruptible sleep due to pagefault.
-That metric is calculated both for all vCPUs as overlapped value, and
-separately for each vCPU. These values are calculated on destination
-side.  To enable postcopy blocktime calculation, enter following
-command on destination monitor:
-
-``migrate_set_capability postcopy-blocktime on``
-
-Postcopy blocktime can be retrieved by query-migrate qmp command.
-postcopy-blocktime value of qmp command will show overlapped blocking
-time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
-time per vCPU.
-
-.. note::
-  During the postcopy phase, the bandwidth limits set using
-  ``migrate_set_parameter`` is ignored (to avoid delaying requested pages that
-  the destination is waiting for).
-
 Postcopy internals
 ==================
 
@@ -312,3 +293,20 @@ explicitly) to be sent in a separate preempt channel, rather than queued in
 the background migration channel.  Anyone who cares about latencies of page
 faults during a postcopy migration should enable this feature.  By default,
 it's not enabled.
+
+Postcopy blocktime statistics
+-----------------------------
+
+Blocktime is a postcopy live migration metric, intended to show how
+long the vCPU was in state of interruptible sleep due to pagefault.
+That metric is calculated both for all vCPUs as overlapped value, and
+separately for each vCPU. These values are calculated on destination
+side.  To enable postcopy blocktime calculation, enter following
+command on destination monitor:
+
+``migrate_set_capability postcopy-blocktime on``
+
+Postcopy blocktime can be retrieved by query-migrate qmp command.
+postcopy-blocktime value of qmp command will show overlapped blocking
+time for all vCPU, postcopy-vcpu-blocktime will show list of blocking
+time per vCPU.
-- 
2.49.0


