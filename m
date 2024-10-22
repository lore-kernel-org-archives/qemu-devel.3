Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0888D2CDF8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 16:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3HQ1-0000Ec-Gq; Tue, 22 Oct 2024 12:07:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPy-0000Dz-4d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3HPw-0001Uz-KH
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 12:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729613251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gnA2LcxAbTKhpziQJQ5f+Q6+OsbjhtmFmnKtEJ+wng4=;
 b=GTE0CaqW8urvhtRiUqaXoJDjFkgSDQcubNMMrzn9PMYWpYzkbwsmUJcBD7yaZgkANp6xjw
 EjsUb0eXmhzrAMlxj+jayBphE9Rl7ToO8Q7zRtUs2OiWFy4NZFIUNDHgnZcrwS2yQsJtvQ
 QZCnmHwcMEGRRCXFwGLM+DyBdraIXb8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-Urn-bavANYq_PG6FX5CvaA-1; Tue, 22 Oct 2024 12:07:25 -0400
X-MC-Unique: Urn-bavANYq_PG6FX5CvaA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbf59c1b3cso80503286d6.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 09:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729613244; x=1730218044;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gnA2LcxAbTKhpziQJQ5f+Q6+OsbjhtmFmnKtEJ+wng4=;
 b=LPA2BnJbaR0DlY9eMSuIaN98BWAcWyYYjVSLEtNA6I6/JaMvJFxEqDJJ3idwLXq/Ws
 cpKywjneMtHKXZ75pngSrczRTR/pieex4OyE5nlFCeUUTMT8jj+zguz9YnMXn6thC+CD
 NqwhmCxveysiY7hvujDIihvBZN5PkL+AcX4PARsTq0IH1FRh6zo5U4aHG7uF1W7l342d
 AkLJ5aRcjUarnqlyGn6+o/Zj4otZbGgqAos2wTFkTRe4eR7N5S+yy2lgDjjFBE397zM4
 WNwzIBFhvKotTyumIHb89l3y6v0LDkiTGaG+Y3jEBTY6O3w9JVBZu+SrW0grGwtD8F9f
 GxgQ==
X-Gm-Message-State: AOJu0YxoWmouQMMrNFvr1mkL/oRpCJ3mS80Y/bWJ1jjvju8MLFm7lhSE
 ZhuQa2vPAfPgLm8fPx2D66VyfodXR+oubt4wIUWUNehHzgSeVrKekrLozUNIUdeYFWssVHLGTFd
 Y9td5Rfn/UDPTwaX8kX7YY+ERo0zUruHewJ2l+phEzNnoddGhMe5WUCB9RAPqupHHBucpNxvg3R
 /zi+6PNSsnE2CckBTOHPxxOV1d03CmlstLDQ==
X-Received: by 2002:ad4:536c:0:b0:6ce:2426:473 with SMTP id
 6a1803df08f44-6ce242605f7mr23759396d6.52.1729613244714; 
 Tue, 22 Oct 2024 09:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEBTSi4QnnARNYPqmvbVNIbXAGrFWzcqE1csc0fMCTqsvHJ6fOHpVcsWSpFPOzT+njoHfGJg==
X-Received: by 2002:ad4:536c:0:b0:6ce:2426:473 with SMTP id
 6a1803df08f44-6ce242605f7mr23758916d6.52.1729613244164; 
 Tue, 22 Oct 2024 09:07:24 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fb113sm30224026d6.34.2024.10.22.09.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 09:07:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] migration: Unexport dirty_bitmap_mig_init() in misc.h
Date: Tue, 22 Oct 2024 12:07:20 -0400
Message-ID: <20241022160720.1013543-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241022160720.1013543-1-peterx@redhat.com>
References: <20241022160720.1013543-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

It's only used within migration/, so it shouldn't be exported.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 3 ---
 migration/migration.h    | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 8d6812b8c7..e0e88b1c0c 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -131,7 +131,4 @@ bool migration_incoming_postcopy_advised(void);
 /* True if background snapshot is active */
 bool migration_in_bg_snapshot(void);
 
-/* migration/block-dirty-bitmap.c */
-void dirty_bitmap_mig_init(void);
-
 #endif
diff --git a/migration/migration.h b/migration/migration.h
index 7dc59c5e8d..0956e9274b 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -552,4 +552,8 @@ int migration_rp_wait(MigrationState *s);
 void migration_rp_kick(MigrationState *s);
 
 void migration_bitmap_sync_precopy(bool last_stage);
+
+/* migration/block-dirty-bitmap.c */
+void dirty_bitmap_mig_init(void);
+
 #endif
-- 
2.45.0


