Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB8BCFA45F
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fh0-0002NS-1t; Wed, 23 Oct 2024 14:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgk-0002Ld-Bn
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgh-00040X-Rs
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729706546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aQi0jNBi64+93LR6lEvSe205PyBWXB4O7JAmokml2GE=;
 b=FzFTpDQfxeTOYiWn+AH1aj5iAyp4jEbGpKuGui1/7dFhOsAd4wWBo/rd8o6KzvlGAUuKaY
 SnQmEE4ludguxwfN3W1skrxHcz1GV13pPYz+NljVsj1M8lF/xZS9+MyrJsy5RGrpEMJPfj
 iEz2PB8cHX4HolZm9JDjXO/JmDpe7bQ=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-gtlfmt_vPHyoNdMyIcbM3A-1; Wed, 23 Oct 2024 14:02:24 -0400
X-MC-Unique: gtlfmt_vPHyoNdMyIcbM3A-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-71806ab1a97so88352a34.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:02:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706543; x=1730311343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aQi0jNBi64+93LR6lEvSe205PyBWXB4O7JAmokml2GE=;
 b=nALD0cRoUMWezvdaxISoBPGj/E9mKot9fMhoUymGa04c14Nw2e6KDIqpjM0F1O0D+m
 UWvoFBArsdfqgvQnTjkJQhAJJIaF7Hk09WrUCJHli7gu+ykT9bhUUwZGHU2TfUOU+NH6
 nit8QbFCgd8SurSr1joqlw7GCJ/xkutpNcUiGkO/k3MgaozfuVvRd3AG3ISfzKFAkwQr
 3TDUsZpbTMAa18zTWIPawjRFgjxVcliU6hBbtPgxi/64jl3UDoTCMICDe+EudK1UBW/m
 LQ1dXHj9lxQ5tL9s+ANiZAg2XS0Y7FVBh1HWJDv/+bXTktj75FxAmQQ4HFhzfmn7ztNX
 ZHRw==
X-Gm-Message-State: AOJu0YxiU75w1dQAfiNAw0/KuXR3bVeOpOnqmLp4ObnNfi0WM4e3vYi3
 PkDi2WxDzuMOrA6ntnoZjvEyUW/AwPVUNnMNBLDJeiM/AAPo526kFbrmP1thjsGpnq9RyjFdeZJ
 WFXVQekJjYOB27TY8HFEA7CNH//JUoXDa5L6dV22XOYW+n8QEl1FplINd1QULVsZH84yqroRUoU
 cuIgA91cFNR9rFAVzTkbTb85AmB6rUyjb2tA==
X-Received: by 2002:a05:6358:71c8:b0:1c3:6f59:fe3b with SMTP id
 e5c5f4694b2df-1c3d8122bf1mr242284955d.16.1729706541857; 
 Wed, 23 Oct 2024 11:02:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmn6yFChVSCmeLaCr4qv2RHZMO9pPhoYeEkVqv/N0bbtcZqtTpNV1ujXwBzEXTcSaSjyIHEw==
X-Received: by 2002:a05:6358:71c8:b0:1c3:6f59:fe3b with SMTP id
 e5c5f4694b2df-1c3d8122bf1mr242267555d.16.1729706539985; 
 Wed, 23 Oct 2024 11:02:19 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fcd0esm41746716d6.132.2024.10.23.11.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:02:18 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 1/4] migration: Unexport dirty_bitmap_mig_init() in misc.h
Date: Wed, 23 Oct 2024 14:02:13 -0400
Message-ID: <20241023180216.1072575-2-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241023180216.1072575-1-peterx@redhat.com>
References: <20241023180216.1072575-1-peterx@redhat.com>
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


