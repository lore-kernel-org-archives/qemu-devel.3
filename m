Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27CE3C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 21:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2K9-0004iM-4e; Tue, 27 May 2025 17:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K6-0004hK-Pn
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K5-00086H-AG
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKj88guqNck61IBFBPod07ps5JD2pesHip82PrHuWHs=;
 b=jAf75dyb7fNVmDGtNRT3OfbGbGzKPXqfO+YWeLUNoW0n65ZnuULGdvYW760wDJk6it9nW+
 kLRIV0FXGhCtrI9WUlTodVNY/RMeOCvYBODHn7lywPudiu5GUSK8POSuiDxlY5fAr+FnwH
 bHzUmCMjaN6aYHHuZXOQcgTQALXR72E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ypn2uxfrP1mGhU2OzncPbA-1; Tue, 27 May 2025 17:58:59 -0400
X-MC-Unique: ypn2uxfrP1mGhU2OzncPbA-1
X-Mimecast-MFC-AGG-ID: ypn2uxfrP1mGhU2OzncPbA_1748383139
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6faa66f6c78so5486066d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383138; x=1748987938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KKj88guqNck61IBFBPod07ps5JD2pesHip82PrHuWHs=;
 b=lkbhYzCAmTbv+njj1Zi0ittv4the3YKhraJuDG51tXnJf8vwv2lI1Jiaq0cEdPXliG
 A0DYyVGvIn2AttOtCa4fsok1xAVqrnYwRKUAF4Y65L2unrM/xMuRx34SCVY1OXkjXrj1
 67xW3MdrTrDmV0I9NhQZOWyw63ct4zSy4+AjtfJKOg7vjeS4LZi/xJ/eJSDlJbhzKMXp
 oIkpAokrLB06a6/hD2dLnDVpL085/zRTy2djBgYpF/f9Aaumd1PoKr8yWTQ9+MSO/Xih
 XdplSfdlv3eODZkKi0Ps0c6uYx29nSWAIGARAIZjS2XdQgs2QERExdyOVCjOL7w+7ZbH
 MMMg==
X-Gm-Message-State: AOJu0YyOXps4ex4qgbHtrz0GIgrE5fjvmoFynk/dHRO44Uhe4RtQKbwX
 FzuSxobMc83TRW3xSzkwiQRGos7fqX5X8R5NcE1bo4cILUoU4G+RIMzJnIosC8xoYQ2Vw13Uogt
 AvCB+9RuZjW/hTiwAhR+z8HPoukVQkW12VTDRpuYs9rFWkk6GSDKqqJwJqrn9FIzen1D6aiUc+k
 h68wmtJfkqs/cp9npKgIvfvH2tbOx8HpKmUthzBw==
X-Gm-Gg: ASbGncsnTRm8rotBrkIN+YDm3nrP3PsoqWs+lE1sHv3ikscyU77huT90TDyBwc95fsK
 6yXLWvucZAE8yVVdrcqX83tO9cniRCUisWUFmWMULE/BBMIL83Hs99NNtwqu2baH6Pg0iHr+i5a
 EIacdPGs+tHzLtvqXUQa58cWEDkiAmn2aO3PW37egUsc50RFvFnXfYj3TxS81iSbGLyKOSn3+rF
 1/fASiuoHej6QCZAXtquqDpMLYJE0vlBnZGPxtZPxCF62H8UvxFwp1FL1PhfdxkQb4InUT88cq3
X-Received: by 2002:a05:6214:2461:b0:6fa:a52b:d4ba with SMTP id
 6a1803df08f44-6fab9ea8514mr40642546d6.12.1748383138591; 
 Tue, 27 May 2025 14:58:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjBPsezoRPeFuu+6e++/RIDvWLYp9703pFdjLWRuS04DceRkH7JUgxhuk1a5gvkIwb+EdnRg==
X-Received: by 2002:a05:6214:2461:b0:6fa:a52b:d4ba with SMTP id
 6a1803df08f44-6fab9ea8514mr40642336d6.12.1748383138244; 
 Tue, 27 May 2025 14:58:58 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:58:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 03/11] migration/docs: Move docs for postcopy blocktime feature
Date: Tue, 27 May 2025 17:58:42 -0400
Message-ID: <20250527215850.1271072-4-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Move it out of vanilla postcopy session, but instead a standalone feature.
When at it, removing the NOTE because it's incorrect now after introduction
of max-postcopy-bandwidth, which can control the throughput even for
postcopy phase.

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


