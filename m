Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7585AD637B1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 20:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBJnQ-0007Z1-94; Wed, 13 Nov 2024 15:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJn9-0007PS-Ey
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tBJn5-0006OP-23
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 15:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731528997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nZIjjql3XBYFLB0JoBjzZVu5ItlNqzkl91H2lTjWY3E=;
 b=VjONo2ldgfF4lJEza40vT7Gl6XP6si4mSp+hZPAoVZ9yWnHmpGfzSenN0THh/NDhb+kYZm
 ku0rOjvglyFGSCSfBpSDKXZ1Ixh+xWE8Z+MOluUZzNqrDlzz7MOtqjQZ1CxdF7jqu3Tr0A
 JBk57bYI9oFl22+l7R+1TgO+RvmDG+0=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-sTlfx1jyNEqPcg5LOCT-ZQ-1; Wed, 13 Nov 2024 15:16:35 -0500
X-MC-Unique: sTlfx1jyNEqPcg5LOCT-ZQ-1
X-Mimecast-MFC-AGG-ID: sTlfx1jyNEqPcg5LOCT-ZQ
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-83ab1b39ab1so851107239f.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 12:16:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731528994; x=1732133794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nZIjjql3XBYFLB0JoBjzZVu5ItlNqzkl91H2lTjWY3E=;
 b=MIURbpcrbDnMpjESW69LcbuNPUNt7MF7Xibpy5fHzSpYJnzmYZ6FKcBzafnnYfW+SF
 3XFON8Fu5KQFHJXu70VTmljmZEzr2a0/AOX500s58JyvURdDq6U+59kzYttP3c05TXYK
 YuBacq3wpED8tebewsyvmvswNGDRF4Q3NTBUruOguL6DLUovEUiXcDq1CAqGqb9QV4t+
 CBpseAT+JYMwhR9Uuh/oFnjetHSHrgGv683/A+FjALU35AFjDq/gx0nI/Y80Z2xBgbmh
 td4rD1BPWdj1tsY2UJ/5/VcbKX1M6se73xDRCJAfFQ6X9oxUuRSBibT9503pgtyl+MlF
 dVxw==
X-Gm-Message-State: AOJu0Yx8WOQZNm9HrEZK7yFIS0XOGsJ5Tp3IlKr5CBpKb3iAQi0bjskK
 ERHoEyrcLNQsXZ7X0lFLqpCiJwbow6EbSc4oFHsl38SRLgONH8qBx0zv0m17IJFQp92+AOTJpUo
 qCHX7bUoCOyPmkqzXOQinn1R3KG7Rq/CX/J6PZPBrxEtzfOvq4MVQWdy/p65HIE3FMPmkt5rFvr
 mFsOk3yg9GTv/7NOkryhPiYg88hAvcRMcdrA==
X-Received: by 2002:a05:6602:3f8c:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-83e03288803mr2076173139f.3.1731528993935; 
 Wed, 13 Nov 2024 12:16:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+ysWvLY3LMnDg/YrinNqZXwPZFfoena2FbuJWsZouurckvYjEK8MlvG6sN0DJPAXzTwcvEA==
X-Received: by 2002:a05:6602:3f8c:b0:82d:9b0:ecb7 with SMTP id
 ca18e2360f4ac-83e03288803mr2076169639f.3.1731528993466; 
 Wed, 13 Nov 2024 12:16:33 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-83e132239bcsm280419039f.10.2024.11.13.12.16.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 12:16:32 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 0/2] Migration 20241113 patches
Date: Wed, 13 Nov 2024 15:16:29 -0500
Message-ID: <20241113201631.2920541-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f0cfd067867668870931c9411d96cd518564b7a8:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-11-09 12:34:01 +0000)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/migration-20241113-pull-request

for you to fetch changes up to 0926c002c7c71749a781de13f28b0481e029d323:

  migration: fix-possible-int-overflow (2024-11-13 13:02:46 -0500)

----------------------------------------------------------------
Migration pull request for 9.2-rc1

- Dmitry's small patch to quiesce a warning in possible uint32_t overflow
- Peter's fix on a recent regression to iotests (and potentially elsewhere)

----------------------------------------------------------------

Dmitry Frolov (1):
  migration: fix-possible-int-overflow

Peter Xu (1):
  migration: Check current_migration in migration_is_running()

 migration/migration.c | 4 ++++
 migration/multifd.c   | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.45.0


