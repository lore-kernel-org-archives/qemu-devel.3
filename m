Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98B2D5B872
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 15:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6B5C-0003f6-Mm; Wed, 30 Oct 2024 11:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B5A-0003c0-9p
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t6B58-0007oj-RS
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 11:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730303882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YXAngTXg1wboh7wqy0j68c2KKpEv3hBNCwOU5kZxwrs=;
 b=eRKhMrMmTuLGFqNvy8fj4LplkCPWlpcPatObWb86C4ue+6A79R/SByVY+A9px/+14w7UWg
 /6D243q6HwPxh3A1Dn71QG79pnt37wSkECWkAg4jj9UhhHdDkOcAUkrmotOSnq/OJolVzK
 eiuGplvuxklqsKUWDcb0bIgfMFrPQFs=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-B9z9GOrAPY-D3Hvh4ztJ2g-1; Wed, 30 Oct 2024 11:58:00 -0400
X-MC-Unique: B9z9GOrAPY-D3Hvh4ztJ2g-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6cbf76b01deso61996d6.2
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 08:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730303879; x=1730908679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXAngTXg1wboh7wqy0j68c2KKpEv3hBNCwOU5kZxwrs=;
 b=Oi70MGY6oEH7cUSFfFlgEa13gbSxwoiZoP8Kym7HIMDjJqYRkieHcs+Kac10d63Ctr
 lowESmm9u+6pxBRvLukSlKcC3/ZoxlmCxPY+RdQbCj4T12G29PM9TmuMoiNaFkuhK2PW
 Z+lHpSXo4lBdo0mZIYFqWAfy/emPKM9D2QkL2WTCUKlLy37ZBPpetq2wEzG9byoHX+vs
 uo5UfkbqxMnLg/Az31VKlPZq9y/8emnU80egZZV9gaRSlyeiODRKqyVEc7MDNpbgLBXw
 LPBDFx4HA8YEKPsz1xsoQ9gq4WsLw4TJ0Ui0e0h+rBhPaW10hlb1u1GXF+JAd+4118ie
 TWqQ==
X-Gm-Message-State: AOJu0YxDaUhWI6mooYnuZ1SWIdPz4dH9bPlhEY0kBYJ1wgyYZ+99lFqD
 ubtMVIbE4TGmx8SP3/wA04WsyctkZdu0mpxe98Fdlu2RrSIAsCPjZG7x2lnNcjVjxbBdsbQZuMF
 ThIkeUH6znYmUpR8i5zlB/EBxQEgeNAi1xxXtFwjNC7v48Vps6MCbsVMCNljfAUkOjnquoEMZqy
 E+1iEmCsWDyzG6m1J+BwUULDlLmWnSVkxIsw==
X-Received: by 2002:a05:6214:2dc2:b0:6cc:51f:6c41 with SMTP id
 6a1803df08f44-6d18584a22bmr292407506d6.36.1730303879707; 
 Wed, 30 Oct 2024 08:57:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFszfrvspKeBen/IW8J4o0BUw9noNv84Qg6xtuGYieFC3ucmWm+WVfg3kzxJcOR9XWQ3OatZw==
X-Received: by 2002:a05:6214:2dc2:b0:6cc:51f:6c41 with SMTP id
 6a1803df08f44-6d18584a22bmr292407246d6.36.1730303879375; 
 Wed, 30 Oct 2024 08:57:59 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d19c57c1ffsm22802276d6.89.2024.10.30.08.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:57:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/18] migration: Unexport dirty_bitmap_mig_init()
Date: Wed, 30 Oct 2024 11:57:29 -0400
Message-ID: <20241030155734.2141398-14-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241030155734.2141398-1-peterx@redhat.com>
References: <20241030155734.2141398-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

It's only used within migration/, so it shouldn't be exported.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20241024213056.1395400-3-peterx@redhat.com
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


