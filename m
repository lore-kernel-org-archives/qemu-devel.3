Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B8FC61CE8
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDG-0008L4-9R; Mon, 09 Jun 2025 12:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDE-0008KZ-B5
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDC-0004TJ-JZ
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rOe+rrF65ml3hQrOn8lxCrB+a9Fm605zyjbC9N6rCgo=;
 b=Yy5qQ/zQfzIxNPCijKBPsXaseSwqnXUXiOjucGxb5ejFe9/Lgk237QMzGG+PhotJSIt/rm
 YT1RvxVNDUqgmMyJ6OMvSPGakX7FVt0PGvFgZxUDr03far3fExxclc3srmbK0EI2xoqJMn
 ptMkWMKYyXdiiA73CWLciw8QOlT91XU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-PDsAweD4MK2cH26_vDtHEg-1; Mon, 09 Jun 2025 12:18:59 -0400
X-MC-Unique: PDsAweD4MK2cH26_vDtHEg-1
X-Mimecast-MFC-AGG-ID: PDsAweD4MK2cH26_vDtHEg_1749485939
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a589edc51aso110237241cf.0
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485938; x=1750090738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rOe+rrF65ml3hQrOn8lxCrB+a9Fm605zyjbC9N6rCgo=;
 b=ieBAm19cONA5F1Ybw050gHi3KiHTVk0GRbZHJTJckYtVkg/A8YfyEnhk6c04BVjW8O
 9ve7tdRcVbFw35BXhE1wghboPumF5dgUgwMk2cFeRhcvx3GSH/+uGSbPEujRRYk1ZnT/
 ZhW4fef4By976zbxEzhCjrqOZY2GhHeb569A1evNqSFjrM0seVrD2uWJzcaqNJP5wIa3
 dlo+eszef4XxDdeSFhqjMBbuEpLxh4uqWBUQhEa8rU0cxB+/MY4Uxn1yvrx8LkoNyDoy
 TMmEsn4JSeLc8XVYVVtuvFXcmnVowYaVenssPpd0uxdi+t1/ffX2+AQnGKaIN/Q/1FoD
 anxg==
X-Gm-Message-State: AOJu0Yzg54qUKktoaPxGW+ab1fuF2pGQmMNdv28W4BQDgwgW8IPBp9M6
 0KIfW+4JJKrqbrvSLQXGEAhUZutT5PsGWhcJjpBa771xxRsi7efAg/3C83Fa4AlVQ49oeTXlmJy
 JyMHqjDDHkyWhg77v5FW3O53wnYT1XzUrASiLeIgooUXSKGO4D95U/yXqibLBWv8fYrAZFwqibv
 cYfvwhs8J73lt1tOwVuATKb64cCwl2Vo32CN5uOw==
X-Gm-Gg: ASbGncuwmyApuUGDZSAomF/dtA+k28AYFKvrdZ1P1eSxSgXYfSHp4wCokgnXbbEThwN
 oryeeR6c61jPDa3jPtaCFPcrLZGSkNrBmGzL++9itf+SogRWeWlSlYsFw5HoTtxM7ctUXldOd1c
 1+VklTiyOcPo18GWxur5ZM6P92VPJenm4fMgcIOY0inISO7BQArDiIacVEanCQboCZtg6xtFQru
 2Yy1lGzsBw1GRDtnqwBkOn3lCmnImuqW3RFubc8ZDe9k7PwDmQ/iD1gu7jMH7GSIeLky+qJMSGI
 Zwk=
X-Received: by 2002:a05:6214:1256:b0:6fb:14:5e89 with SMTP id
 6a1803df08f44-6fb08fe7f6fmr242438846d6.19.1749485938532; 
 Mon, 09 Jun 2025 09:18:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzRA/ez7PlKUDAbJNAt+14VE4Gu0rhEFR2CMmQuy5GLvp1auIr126FrQxxjYmBjXcumfYv+Q==
X-Received: by 2002:a05:6214:1256:b0:6fb:14:5e89 with SMTP id
 6a1803df08f44-6fb08fe7f6fmr242438286d6.19.1749485938127; 
 Mon, 09 Jun 2025 09:18:58 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:18:57 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 00/11] migration: Some enhancements and cleanups for 10.1
Date: Mon,  9 Jun 2025 12:18:44 -0400
Message-ID: <20250609161855.6603-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
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

v2:
- Collected R-bs
- Avoid using "\b" in HMP dumps [Markus, Dave]

The series is based on a small patch from Yanfei Xu here:

Based-on: <20250514115827.3216082-1-yanfei.xu@bytedance.com>
https://lore.kernel.org/r/20250514115827.3216082-1-yanfei.xu@bytedance.com

This is a series that collected many of either enhancements or cleanups I
got for QEMU 10.1, which almost came from when working on the last patch.

The last patch, which is a oneliner, can further reduce 10% postcopy page
fault latency with preempt mode enabled.

      Before: 268.00us (+-1.87%)
      After:  232.67us (+-2.01%)

The patch layout is as following:

Patch 1:         A follow up of HMP change for "info migrate", per
                 suggestion from Dave
Patch 2:         Yet another HMP fix for blocktime displays
Patch 3-10:      Cleanups everywhere, especially please take a look at
                 patch 10 which changes the core switchover decision logic
Patch 11:        The one-liner optimization

Comments welcomed, thanks.

Peter Xu (11):
  migration/hmp: Reorg "info migrate" once more
  migration/hmp: Fix postcopy-blocktime per-vCPU results
  migration/docs: Move docs for postcopy blocktime feature
  migration/bg-snapshot: Do not check for SKIP in iterator
  migration: Drop save_live_complete_postcopy hook
  migration: Rename save_live_complete_precopy to save_complete
  migration: qemu_savevm_complete*() helpers
  migration/ram: One less indent for ram_find_and_save_block()
  migration/ram: Add tracepoints for ram_save_complete()
  migration: Rewrite the migration complete detect logic
  migration/postcopy: Avoid clearing dirty bitmap for postcopy too

 docs/devel/migration/postcopy.rst | 36 +++++++-------
 include/migration/register.h      | 26 ++++------
 hw/ppc/spapr.c                    |  2 +-
 hw/s390x/s390-stattrib.c          |  2 +-
 hw/vfio/migration.c               |  2 +-
 migration/block-dirty-bitmap.c    |  3 +-
 migration/migration-hmp-cmds.c    | 81 ++++++++++++++++--------------
 migration/migration.c             | 61 ++++++++++++++++-------
 migration/ram.c                   | 32 +++++++-----
 migration/savevm.c                | 83 +++++++++++++++++--------------
 migration/trace-events            |  1 +
 11 files changed, 184 insertions(+), 145 deletions(-)

-- 
2.49.0


