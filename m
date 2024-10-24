Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1B5D10380
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 21:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t45QM-0005gR-7Y; Thu, 24 Oct 2024 17:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QF-0005dY-Ob
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t45QB-0005XZ-UF
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 17:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729805465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQi0jNBi64+93LR6lEvSe205PyBWXB4O7JAmokml2GE=;
 b=g9FugSj754VdO0tswSuKFzQkHiQ9Z3LRern8Xx42cEF67rDHwoqo074Ue6UN0xdan9Q8J7
 c1d3gw/dqq/c+u+e3L08KEUNTohvxM6B4KPPh1Oqy7aX9yn7npjCqBJIAO82I9BZQEHKt4
 pzV5hEL5UF6AH591Me4VScjBfpl9UTM=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-wAFJxnQiMJimptAh-OgsPw-1; Thu, 24 Oct 2024 17:31:04 -0400
X-MC-Unique: wAFJxnQiMJimptAh-OgsPw-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4a470b7ff49so444714137.2
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2024 14:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729805463; x=1730410263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQi0jNBi64+93LR6lEvSe205PyBWXB4O7JAmokml2GE=;
 b=dxfVcMUWk+a2pFY2IVTg8JFuDC9hXFrNlMKTQqZdzg/6qfCCmpEULNOK3JwW4U2MGy
 pni/m+xocAyYQBRQuzR7ho7PJBD9+/c4fev+Wd41dug0OGI8RM7w2MDFPKC+Bz5I1dZS
 UMgxcppSvyVJ2ojusfaJ/wt/P9wGoSoTihicche1d9bI1ojGUIkGAXmshLD1kHMEYItO
 LLzNMJlhrZq0UU/tYipYMP5a4OykTEnOIhJIQmHSOoNMRyafy9prFtfVXaCRvM9R+ORo
 Z7x8mAN4sxFsfitTQJ+cIRkQISGCXQ4UcuA0Tq4bfXCH2ZWw7UzJ/L9/jAyEieH36t0b
 XULQ==
X-Gm-Message-State: AOJu0YwJEgj0uCECyR8DpJrqcZ6ET2djphLdK4pKO2A+9uBDJf58HlIh
 CdA1AS4GtGD6lfa+OGE/fAIoxz83cb2qS9xX9YNMCxhfliUUCMAkp9u7ein8RstQD8t3cElVc/x
 DVHBX2W0i4f0P53bfKk8t3JgUVcruuz5ObfzF8WTmyufT93VTNnaZepzbMOfEoUUeNun1DmqmDS
 dzTHs0/51Aw5QgH52sSTQnf/9IM05rEfScsA==
X-Received: by 2002:a05:6102:955:b0:4a7:4900:4b83 with SMTP id
 ada2fe7eead31-4a751c0b89cmr9617324137.15.1729805462797; 
 Thu, 24 Oct 2024 14:31:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB6u934XPonhdzpQjPiG5vkxK3ZjOKaQEkToJjnesu6BmSqva8uW+Wru+VQEuSP6n9jWapow==
X-Received: by 2002:a05:6102:955:b0:4a7:4900:4b83 with SMTP id
 ada2fe7eead31-4a751c0b89cmr9617289137.15.1729805462382; 
 Thu, 24 Oct 2024 14:31:02 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c3a434sm55465091cf.19.2024.10.24.14.31.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 14:31:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v3 2/8] migration: Unexport dirty_bitmap_mig_init()
Date: Thu, 24 Oct 2024 17:30:50 -0400
Message-ID: <20241024213056.1395400-3-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241024213056.1395400-1-peterx@redhat.com>
References: <20241024213056.1395400-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

It's only used within migration/, so it shouldn't be exported.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/migration/misc.h | 3 ---
 migration/migration.h    | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index bfadc5613b..df57be6b5e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -108,7 +108,4 @@ bool migration_incoming_postcopy_advised(void);
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


