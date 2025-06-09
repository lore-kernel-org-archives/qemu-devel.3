Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3824C61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 19:15:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOhvv-0006OS-Fh; Mon, 09 Jun 2025 15:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvt-0006OC-VF
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOhvs-0000r8-D4
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 15:13:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749496399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uggx0LWnDXw25MvWp6nsAnmpm2psyW3qEQ4EOTJZ55E=;
 b=PIRQcILTXzYTltQdj2fRd/molCop0z/kGbRiU8gzHUYHhTzqAz/YGv3WKbWNS7o25sQ9//
 lB1orpudhJ6UkSc/O/XLczLr7sOCCbyCk57vDQ4fg6XDDguRys1Ok1dzIwhzFoyx9fr4pe
 e/XxJejTmKxEV4LmGpGtS6LwnLmIpOg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-ITbYZNghOoy9w_mY6WVJCQ-1; Mon, 09 Jun 2025 15:13:16 -0400
X-MC-Unique: ITbYZNghOoy9w_mY6WVJCQ-1
X-Mimecast-MFC-AGG-ID: ITbYZNghOoy9w_mY6WVJCQ_1749496396
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6fad49f42cbso73764546d6.3
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 12:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749496395; x=1750101195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Uggx0LWnDXw25MvWp6nsAnmpm2psyW3qEQ4EOTJZ55E=;
 b=RRLbifMn90RkivDlubgIF+n9lXUOA13vWTzwwKkCr3V+/baXVD7FyI7sI/LEXJatzj
 ULngXQnKQQnWUSwgG7cMMO8JGLaOld4K2XPQYrI5Aqs9XwxkTdX71hUKvrD9ehZjrl8N
 vX8+zR7KVSkWPsEctJ6X0Ml8HoTLFrMzin+jK79AIvTJXneGBP5DVqfcHALvS/eg6vzX
 Dul5ZMOL73a+iSFO+g6ZNEu/YSiGZPDCO/0/aORUUa9vjt6onvEy2K8PXnR+Rr2TFUzt
 yKfgeG+REy5CyiqollzZhorSeG8L98RUbKvczu345YvF5rAPAbkwbN/Fgi4rfJQrhsDY
 pHGQ==
X-Gm-Message-State: AOJu0YwiJ7axxeK9Focx2i4j7sxgaHuuoiejzxcJT6tQNv2oL9UUvujp
 eWgvTyLEOm2qjbZlmIYHqtqhRcr9lJ6vfqrU2RirqED4XM2Oojv+yo+ZrWJGsFhbQacqLDHqpDd
 Lfl9IQf3IlEFwDJr0Y5FNgJp+zAbjFqDtiU6YXKSTMR5Zmwid347Awu5ipgi+/fk+/el6U6MXtq
 nlvAB5K3xWw5ZMCBEp3GwNBrDExPOOJWIdUvSy6w==
X-Gm-Gg: ASbGncsZY1XgIU7hGnT6NcVAIpobZBUteVABc78CY9icXSOq7FH5W5BCtgeDPtD9P+a
 aVXXPtO8PP3W2dVXRatMkm8gN1hKBGg0/9+9b9SCVmajMOWnqQOcXZg9USem6BPki30pkWXWYja
 mHW0PSVdfzayBKqywK9vk5fqKjczWgBsWXBUERV3BpLp7/7cVA8q5uCDjdXU3h81C+aO+LW4O88
 FZ5H/xacADMXis8ABEAkEdBntkLLS7Yy7lTuIOHGEvYgQf5hvCmliApVMocZZIBvYPasu790geM
 MekDKkyofmSzhA==
X-Received: by 2002:a05:6214:29ee:b0:6f9:201a:c05d with SMTP id
 6a1803df08f44-6fb08fbb38cmr236865716d6.33.1749496395370; 
 Mon, 09 Jun 2025 12:13:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDn+ir+hW3TIaA3GbOILz2nlMFk6p8PnSGGTI/oGIjj9++F+I+OVoJ20havcr/iKCIvtfAGg==
X-Received: by 2002:a05:6214:29ee:b0:6f9:201a:c05d with SMTP id
 6a1803df08f44-6fb08fbb38cmr236865296d6.33.1749496394902; 
 Mon, 09 Jun 2025 12:13:14 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09b1cc24sm55178856d6.72.2025.06.09.12.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 12:13:13 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexey Perevalov <a.perevalov@samsung.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 09/13] migration/postcopy: Initialize blocktime context
 only until listen
Date: Mon,  9 Jun 2025 15:12:55 -0400
Message-ID: <20250609191259.9053-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609191259.9053-1-peterx@redhat.com>
References: <20250609191259.9053-1-peterx@redhat.com>
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

Before this patch, the blocktime context can be created very early, because
postcopy_ram_supported_by_host() <- migrate_caps_check() can happen during
migration object init.

The trick here is the blocktime context needs system vCPU information,
which seems to be possible to change after that point.  I didn't verify it,
but it doesn't sound right.

Now move it out and initialize the context only when postcopy listen
starts.  That is already during a migration so it should be guaranteed the
vCPU topology can never change on both sides.

While at it, assert that the ctx isn't created instead this time; the old
"if" trick isn't needed when we're sure it will only happen once now.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 98d4c29532..6ed4546744 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -324,13 +324,13 @@ static bool ufd_check_and_apply(int ufd, MigrationIncomingState *mis,
     }
 
 #ifdef UFFD_FEATURE_THREAD_ID
+    /*
+     * Postcopy blocktime conditionally needs THREAD_ID feature (introduced
+     * to Linux in 2017). Always try to enable it when QEMU is compiled
+     * with such environment.
+     */
     if (UFFD_FEATURE_THREAD_ID & supported_features) {
         asked_features |= UFFD_FEATURE_THREAD_ID;
-        if (migrate_postcopy_blocktime()) {
-            if (!mis->blocktime_ctx) {
-                mis->blocktime_ctx = blocktime_context_new();
-            }
-        }
     }
 #endif
 
@@ -1238,6 +1238,11 @@ int postcopy_ram_incoming_setup(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (migrate_postcopy_blocktime()) {
+        assert(mis->blocktime_ctx == NULL);
+        mis->blocktime_ctx = blocktime_context_new();
+    }
+
     /* Now an eventfd we use to tell the fault-thread to quit */
     mis->userfault_event_fd = eventfd(0, EFD_CLOEXEC);
     if (mis->userfault_event_fd == -1) {
-- 
2.49.0


