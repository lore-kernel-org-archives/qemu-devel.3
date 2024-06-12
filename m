Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06F5C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 14:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHPBS-00086i-0q; Wed, 12 Jun 2024 10:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBP-000850-V7
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sHPBO-0002in-8k
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 10:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718203355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NMgIQElkTz3EaYzdIBFH5AM5/eiHwL2J/KTZHp1RR7Q=;
 b=eQZ0qfE9idQ082MAtwZK+LT65kT8xJ+fKGZgpremrhprYvRR8bx0oH0qmCak8QCTTGpSsf
 7mauqmwIIRZmTt0GfAl6LiM2fDx9w4g3jQ06ZHbgOQkV2WszbjWDud6iOCT9uCG5AdPd8D
 NzaC7gsYoYvsMysqOuYFYcI/nuoVleY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-98rW1rlVP5ONFORY_ejH9g-1; Wed, 12 Jun 2024 10:42:33 -0400
X-MC-Unique: 98rW1rlVP5ONFORY_ejH9g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-440aedca77cso4108631cf.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 07:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718203353; x=1718808153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NMgIQElkTz3EaYzdIBFH5AM5/eiHwL2J/KTZHp1RR7Q=;
 b=fw9509yIZHvfF8jrgB34FJrAKnHpr/vHLKPOJ4bS7STsapChCl/Q4SdOwEOruonYyi
 MXOEpS97hp+BtFfjywQb3jWZwuRshbEv6VN+mPWE8Fe7AgPchXP9wrbEp3/EegMnBkBL
 /oUA+F0hw6r2EV+o6IqfnzMwHWohrjDb3uutsud20iQkudkfQeKp+t9tfZF7rkjeeKou
 /KNg/0DdeP5qzOLZmfbD7b/5nH+3gVJl2iGZnC2WNvKkR2hTKvtp66cwOFfOPOS7bFOI
 yJKfvI7LLG0PqUoqegFDZ6f8C7AtULEgTEQVT/xP/t9V8r1Qa+veoc0C2rl8P0kJcLPS
 oW2Q==
X-Gm-Message-State: AOJu0YylkTkT/q0jgmArYRdj9jQeF5f7epVODu7wLdJNJug9ETlKpUYH
 8zJf20Mh8wYura4ixWrPi+6BXSaMBlrDwbPsjR2pm7Efq+0MvQZBkBEXXHoEd+YwEiKEGFd1lhm
 X4mLvVB2GenYMrQ3BPrQqlxNC/GYSJ8kiQTtvcpkXRa4pNRYfOcH3aPclDrIR236Zq1aevulhG8
 KSmfjUDDFItfSf+89bBbsg0a7T34ZoF/Hktg==
X-Received: by 2002:a05:622a:1aa7:b0:441:322:af8f with SMTP id
 d75a77b69052e-4415acd0368mr21517961cf.4.1718203352881; 
 Wed, 12 Jun 2024 07:42:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8Rg4jNIEi307U5HTJp9uju9+1gF9IPA/bku07wUWPDB/UXDexAkOTkDhz7WCBw3d4Ne0kZw==
X-Received: by 2002:a05:622a:1aa7:b0:441:322:af8f with SMTP id
 d75a77b69052e-4415acd0368mr21517491cf.4.1718203352228; 
 Wed, 12 Jun 2024 07:42:32 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4405e3ded65sm37581681cf.87.2024.06.12.07.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 07:42:31 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Bandan Das <bdas@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 0/4] migration: New postcopy state, and some cleanups
Date: Wed, 12 Jun 2024 10:42:24 -0400
Message-ID: <20240612144228.1179240-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The major goal of this patchset is patch 4, which introduced a new postcopy
state so that we will send an event in postcopy reconnect failures that
Libvirt would prefer to have.  There's more information for that issue in
the commit message alone.

Patch 1-2 are cleanups that are not directly relevant but I found/stored
that could be good to have.  I made it simple by putting them together in
one thread to make patch management easier, but I can send them separately
when necessary.

Patch 3 is also a cleanup, but will be needed for patch 4 as dependency.

Comments welcomed, thanks.

CI: https://gitlab.com/peterx/qemu/-/pipelines/1328309702
    (msys2-64bit is failing, but doesn't look relevant)

Peter Xu (4):
  migration/multifd: Avoid the final FLUSH in complete()
  migration: Rename thread debug names
  migration: Use MigrationStatus instead of int
  migration/postcopy: Add postcopy-recover-setup phase

 qapi/migration.json      |  4 ++
 migration/migration.h    |  9 +++--
 migration/postcopy-ram.h |  3 ++
 migration/colo.c         |  2 +-
 migration/migration.c    | 85 ++++++++++++++++++++++++++++++++--------
 migration/multifd.c      |  6 +--
 migration/postcopy-ram.c | 10 ++++-
 migration/ram.c          |  4 --
 migration/savevm.c       |  6 +--
 9 files changed, 95 insertions(+), 34 deletions(-)

-- 
2.45.0


