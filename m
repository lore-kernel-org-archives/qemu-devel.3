Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F5D1C5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2K6-0004hJ-Mz; Tue, 27 May 2025 17:59:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K5-0004gs-9H
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2K1-00085s-Rp
 for qemu-devel@nongnu.org; Tue, 27 May 2025 17:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SzjMwRn1rvI6Q4SnN2ASTrwfZT8jwIWDMFe811+Mqqw=;
 b=NhfmkiAeHLm1xNNfKQ1shrxYDtRE9jZOfYPpaM+GFgbbnkZMixVeUofsHCnSg8GF4BlWC0
 YJ2oeHsC6Tli0hVXl44uku/t0VZnuG+yUoRVH5qH6AmGOMh2WA/W5mOhfFEWGjt4VJYCDW
 s+6xFMy5bLfaSSLz4sEg2O27NKrwg8A=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-ceLBQOMrOAukz1--Ry3n8w-1; Tue, 27 May 2025 17:58:55 -0400
X-MC-Unique: ceLBQOMrOAukz1--Ry3n8w-1
X-Mimecast-MFC-AGG-ID: ceLBQOMrOAukz1--Ry3n8w_1748383134
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6faa9ffe50fso40636566d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383134; x=1748987934;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SzjMwRn1rvI6Q4SnN2ASTrwfZT8jwIWDMFe811+Mqqw=;
 b=BKWIERNdMCWVZx77d1NccN3BGA+4huJxSsAfq8pYKGAuy8ubJWJVMTZcfz1fZ0MYe4
 Xu4nCpz1C7ElqDE0S2XKhbSoeEdz9xsCKVXIdydPi6WS8B3AzjKVDWKwZGFnJmvmwddW
 B+hWJlevCV1F/L+fxIVT2Ud6asKY3mYn/Y36084IMmjRfxO/fwDC7ZvrSdksWkoYBUUX
 A5CWUOE/Fb55WOtMXFIfjHTAXvTehlKPHWQYLzuWKRsiYOCQ7SvfekMuV1iaOhirufBy
 K5CXf7/uV8tS27fuilFCHfeLQKDUmAu3ZF1vbLRPWNFh/0AYZEZ4CXjyYyzvU/apH8Kv
 gZMg==
X-Gm-Message-State: AOJu0YyRNgaXXS2zDCacVJ1O074dzuPVhmrjyBj2B8qXHaLH0VjFvfE/
 RrkJJn8UPT0UAEnS9vor+5GZ2FZ2+g1wgBrnufeb5TEKvPZQN/WLGEtsnKikmTFeP/Y0Y/NxY8a
 TOVrGIKAqCe4FEHddOaHDW+rxrzaFJWeVElAhNbf4KOA2cDfhF/0eV+jNkQ8pVz9MlMI+r97pZC
 Kh31NwYH6Ft+CldVNz0DiwktBGQRP2B08KmUJxHA==
X-Gm-Gg: ASbGncs0OLBXWH8HmZr8eTmdojP96eSt0MDB3BD2YL9AdY/V38ISEnECgDhuAUu0h3B
 panBGR4hUpzSOckEueZujw3psQAgJcknafR/nYNV2k1ZuDDh1DSebsQUUGhMuts9DEKsczO+8t2
 C8i/bd8GOG2MgOrgBmCRfaGcYSYUo56B2FbvrdnA4ZO7AgqWg6vGxxdCuObNawQegY3Rz0BCxtq
 EMEs/RSf6s22wWj6iGeQNIADDWTGMaxkRVUcNi/P7ro81xFm1s3hZxv0jjdL0chmKckbdeAx0yX
X-Received: by 2002:ad4:5bad:0:b0:6e8:f4e2:26e1 with SMTP id
 6a1803df08f44-6fa9d1533b1mr219451696d6.20.1748383134245; 
 Tue, 27 May 2025 14:58:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeaCABUqaf5MVlesW1vYIdCLtoyAjhVHecMAIk9t8tVQpMbO8JK4QI2QvzkrXF/qdbavxSxQ==
X-Received: by 2002:ad4:5bad:0:b0:6e8:f4e2:26e1 with SMTP id
 6a1803df08f44-6fa9d1533b1mr219451386d6.20.1748383133845; 
 Tue, 27 May 2025 14:58:53 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:58:53 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH 00/11] migration: Some enhancements and cleanups for 10.1
Date: Tue, 27 May 2025 17:58:39 -0400
Message-ID: <20250527215850.1271072-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 migration/migration-hmp-cmds.c    | 82 ++++++++++++++++--------------
 migration/migration.c             | 61 ++++++++++++++++-------
 migration/ram.c                   | 32 +++++++-----
 migration/savevm.c                | 83 +++++++++++++++++--------------
 migration/trace-events            |  1 +
 11 files changed, 185 insertions(+), 145 deletions(-)

-- 
2.49.0


