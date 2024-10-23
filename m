Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54CCCFA45C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 18:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3fgj-0002LU-Vg; Wed, 23 Oct 2024 14:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgh-0002Kx-MP
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t3fgf-000402-Dv
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 14:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729706540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aqZ/Ijhs/hI2p5Nae02aaMBoerDF2C7PiBNtjCESoWo=;
 b=F0IP63+QGOCsPyaxKyYHHSPmKXGh44/xc4R6I3EKxRPQS5eqCN9h+ZUYhKUWOTxTWM4GxB
 UXl2Hj2fYn6pIUfao3FqcipNAN7ellUBnc3YlPjA8djCKXb1lgtYKQZff+zbfkWb4936ao
 +ANs5kKp6ycfqQFVldoWpA7jpakxHZ0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-IssDSp9BPLCEEFeYLJR_HQ-1; Wed, 23 Oct 2024 14:02:19 -0400
X-MC-Unique: IssDSp9BPLCEEFeYLJR_HQ-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6ce2d91fa3bso1470826d6.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 11:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729706539; x=1730311339;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aqZ/Ijhs/hI2p5Nae02aaMBoerDF2C7PiBNtjCESoWo=;
 b=fmCEKdsFkUrIyYPmtLCYX28DnoCgp62RRVEfzvYBei6T316m4bYtnQtgVKDKTVB6U/
 IR3ypJqBUCAPdx4QGY8CeNyuStcmrJLbB/DpRp4MwHFXjWp9iOLfYlW1QS+8Ayr3Hg1e
 a2y09XpghEH15IOeox3YQ6yYjKxNiWQ08Mbpcx14pii12WCrp78c7gPyxsI+Fs1PWnNL
 dDY6H+4jZni02N6gsCF/9vkSGPrZJn53iAaJijYFz2AWbm+u6K2kHmeq2n9uj1oLHgYM
 lrHeIi4Qr3ia4WuRF0wNhXs3QL7hpjNwpeoComtA7s/Dvrn1QNtLgzyb8e4VB3Pk/bLH
 JY1A==
X-Gm-Message-State: AOJu0Yy9Yxp2Cf3i6Vnf/rlZ8w9DvDgPjejXmZ44BvOox0avMeaj2ACi
 QB1wGzCAwoyIToUFNBp0fEZNu8HQK/h3JEI17mcgCVeGXinN3VZth2JWK31OlVtktm2kqJR9h8u
 Gv40AaiTsqBm2tFMPDHFsS8CqQWVBUULH1mqzo7bKLaP94EcuwLJoC+YRmNt8xI0Zv8HoiamUYh
 hHOsTEWVy4PayfN9A4OFtcmE0baSxUtGp9Gw==
X-Received: by 2002:a05:6214:4904:b0:6cb:fa07:fcd7 with SMTP id
 6a1803df08f44-6ce342048e2mr46539266d6.5.1729706538562; 
 Wed, 23 Oct 2024 11:02:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI8QghgAdXuN4ScXb/VaWOsmgn99QLTKiGP8tndPk23Mdzc3HPydAg9KLO3xLfewJWeBL39A==
X-Received: by 2002:a05:6214:4904:b0:6cb:fa07:fcd7 with SMTP id
 6a1803df08f44-6ce342048e2mr46538876d6.5.1729706538156; 
 Wed, 23 Oct 2024 11:02:18 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009fcd0esm41746716d6.132.2024.10.23.11.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Oct 2024 11:02:17 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Alex Williamson <alex.williamson@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 0/4] Migration: Make misc.h helpers available for whole VM
 lifecycle
Date: Wed, 23 Oct 2024 14:02:12 -0400
Message-ID: <20241023180216.1072575-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

This is a follow up of below patch from Avihai as a replacement:

https://lore.kernel.org/qemu-devel/20241020130108.27148-3-avihaih@nvidia.com/

This is v2 of the series, and it became a more generic rework on how we do
migration object refcounts, so I skipped a changelog because most of this
is new things.

To put it simple, now I introduced another pointer to migration object, and
here's a simple explanation for both after all change applied (copy-paste
from one of the patch):

/*
 * We have two pointers for the global migration objects.  Both of them are
 * initialized early during QEMU starts, but they have different lifecycles.
 *
 * - current_migration
 *
 *   This variable reflects the whole lifecycle of the migration object
 *   (which each QEMU can only have one).  It is valid until the migration
 *   object is destroyed.
 *
 *   This is the object that internal migration so far use.  For example,
 *   internal helper migrate_get_current() references it.
 *
 *   When all migration code can always pass over a MigrationState* around,
 *   this variable can logically be dropped.  But we're not yet there.
 *
 * - global_migration
 *
 *   This is valid only until the migration object is still valid to the
 *   outside-migration world (until migration_shutdown()).
 *
 *   This should normally be always set, cleared or accessed by the main
 *   thread only, rather than the migration thread.
 *
 *   All the exported functions (in include/migration) should reference the
 *   exported migration object only to avoid race conditions, as
 *   current_migration can be freed concurrently by migration thread when
 *   the migration thread holds the last refcount.
 */

It allows all misc.h exported helpers to be used for the whole VM
lifecycle, so as to never crash QEMU with freed migration objects.

Thanks,

Peter Xu (4):
  migration: Unexport dirty_bitmap_mig_init() in misc.h
  migration: Reset current_migration properly
  migration: Add global_migration
  migration: Make all helpers in misc.h safe to use without migration

 include/migration/misc.h | 29 ++++++++----
 migration/migration.h    |  4 ++
 migration/migration.c    | 99 +++++++++++++++++++++++++++++++++++-----
 3 files changed, 113 insertions(+), 19 deletions(-)

-- 
2.45.0


