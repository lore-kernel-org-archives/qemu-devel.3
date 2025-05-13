Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24747C3ABC9
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 22:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uExoq-00061K-Gm; Tue, 13 May 2025 18:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExoc-0005yS-Rm
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uExoa-0006Fs-6T
 for qemu-devel@nongnu.org; Tue, 13 May 2025 18:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747174171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jt4JB+/eyLHSTi7aofMxYcpO1aDa+89PDt9ClOTPYVM=;
 b=c5kszyvdAJBzqf0tAgURxIwvEIliIYNrllINf7+VfE0/JyeDuoJ4PS1tGPKBKTHLrrYal9
 mqaegvKYCyhVZ2CLE8vaH2w42+kKiaRhAlRFmCt8Ls2h6RhenT1CpF6zfnNn8TG0IXNcqL
 ZJBUEficriEL/Foi5RxXez0prhzcRFU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-M0qrB1BEPPitQy9RcRvcgg-1; Tue, 13 May 2025 18:09:30 -0400
X-MC-Unique: M0qrB1BEPPitQy9RcRvcgg-1
X-Mimecast-MFC-AGG-ID: M0qrB1BEPPitQy9RcRvcgg_1747174169
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f54fe13562so101863656d6.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 15:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747174169; x=1747778969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jt4JB+/eyLHSTi7aofMxYcpO1aDa+89PDt9ClOTPYVM=;
 b=IQl+k6F5+ajXxfE1qp2efNk/D8ll44Er8Zl7Slb2xnGJaietOf9MygGvHgs6XLgBUJ
 GOylQtTzk+CXJ/yqaw2o2HXS9sYFGgPSr/5kW1O4S5btT3Ra1NrBWN5WPGeaFCkMdXDY
 FDNVYRMEDALWGZ02lEqTGAy8nZcN6p+y2hmcjC+cowqweQS4KyNqY0b1UR+zuBRt3mOQ
 rQ66khHKqkzVaWZSGNHaPmK1EdLs9XTzVem0Ned6u4Nd7YuaMlvX7Zvg1/kpZT+ioHdV
 mOAWm1m8+0AXusNeDKCbqkVBNZ1FVg5qah5wdBNdipywe8FVRPKDLyRKk4ufYF5EmGLH
 BD7w==
X-Gm-Message-State: AOJu0YxLLy9d2nhZ5i3PugJ8sRxOXsvgrdz874Q5CfmDMfMUMSIxkkFK
 ba1vT6gr1gpmt9F9ethIpwYvokTDMLl9QsCM9/oSXGpHFhv0demvC+YlhAX1HazYPTO1LQWm3oz
 9PQ/tKCMvi2LXPj3xFSbxJo+v1wWVVBIY4u4hSXOhi8wl31K0Vj+43E/tZCJBDgEpJ77XzX2vg7
 OHvKnzO4hMcgAzZe9W9fVBe/2/oTxeQzBchg==
X-Gm-Gg: ASbGncsPIfxshyj1AnOzD3+wPt8cqY8roaJw288TViQIAuhFFwS8NrzytNyIfqaPuhg
 D7e6U8DuhBPs8hMMreb85ZPgVnjHHUqxd2HYlWC3aZZggvlNsubG5N2pbZiZeX2quhjAl+2Z+kW
 GmkvS8fq10SkMyQKDvOyDLRRrPfJLtNamUNDB7Nu1RcrPFG8K8Mraz6xMI6SkVXCChL5NqNWkaz
 JZjzUBBO7clR5WyXOUA12vv9Ic32m1OteDuBIEwt09DCQKNB8E8xtUJkXW2ukw2PaEJHrOxXtmR
X-Received: by 2002:a05:6214:48b:b0:6f5:3e38:612b with SMTP id
 6a1803df08f44-6f896ec06f3mr15740496d6.41.1747174168913; 
 Tue, 13 May 2025 15:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcpuO0TnVb/usDEEYL9kHzBURNazRpwFiplAFSkPLEXB5RzK9oaRRYqVaAb7F3mL7dBZvxDg==
X-Received: by 2002:a05:6214:48b:b0:6f5:3e38:612b with SMTP id
 6a1803df08f44-6f896ec06f3mr15740116d6.41.1747174168532; 
 Tue, 13 May 2025 15:09:28 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a0c5e3sm71708616d6.63.2025.05.13.15.09.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 May 2025 15:09:26 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com
Subject: [PATCH 1/3] migration: Allow caps to be set when preempt or multifd
 cap enabled
Date: Tue, 13 May 2025 18:09:21 -0400
Message-ID: <20250513220923.518025-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513220923.518025-1-peterx@redhat.com>
References: <20250513220923.518025-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
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

With commit 82137e6c8c ("migration: enforce multifd and postcopy preempt to
be set before incoming"), and if postcopy preempt / multifd is enabled, one
cannot setup any capability because these checks would always fail.

(qemu) migrate_set_capability xbzrle off
Error: Postcopy preempt must be set before incoming starts

To fix it, check existing cap and only raise an error if the specific cap
changed.

Fixes: 82137e6c8c ("migration: enforce multifd and postcopy preempt to be set before incoming")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3fcd577cd7..162c72cda4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -568,7 +568,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        if (migrate_incoming_started()) {
+        if (!migrate_postcopy_preempt() && migrate_incoming_started()) {
             error_setg(errp,
                        "Postcopy preempt must be set before incoming starts");
             return false;
@@ -576,7 +576,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        if (migrate_incoming_started()) {
+        if (!migrate_multifd() && migrate_incoming_started()) {
             error_setg(errp, "Multifd must be set before incoming starts");
             return false;
         }
-- 
2.49.0


