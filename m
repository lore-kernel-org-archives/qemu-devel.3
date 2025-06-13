Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D142C71148
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ56e-00073E-V7; Fri, 13 Jun 2025 10:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ56M-0006lX-9N
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ56K-0001lX-DN
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:09:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7nILyzynSnvknIr8mqdNZ9z3dvv7bdU1U/3+yRo7Unw=;
 b=i9KTx3mTShfHp4vnj73U0SdL+yGOs1qFDi1IC8xbNGUbF3K+mSqHxyHHXz+h1L2JvQax62
 K1F/8bHdPsfRPoo0ATgIHSWu38F/2ZTbqxQiZ9fOGnX5XfmDEBlIs8atyPzVe6zgFXMifI
 EOUQZ58uhzpMqrue3LzAnkXJfqdOE14=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-jc0cE9oLON6PwFP1N35B_g-1; Fri, 13 Jun 2025 10:08:06 -0400
X-MC-Unique: jc0cE9oLON6PwFP1N35B_g-1
X-Mimecast-MFC-AGG-ID: jc0cE9oLON6PwFP1N35B_g_1749823686
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4a58cd9b142so38733271cf.0
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823685; x=1750428485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7nILyzynSnvknIr8mqdNZ9z3dvv7bdU1U/3+yRo7Unw=;
 b=R/5gvsE8l5p45l/Sp5YTTb3YrFi1I6I34Fi0XphQAXV5cI1SKWLb6OUfGy+QXRb72Y
 zdHr6LalHnZXd9dwJ991lDjZ8fp4FrN9z+YOR9+NrBGidjpT+Hd/z4RSdJqXUwmuX9hx
 u4vqZZy/RHYon707jnHyM7LG/4pxanxEscUf1OJy5qZTzypekUAay/i+t5t0jzQ1S4HF
 8s2LIHueyPe6mLNCYjdNUnEvxUptEb97E7JaM6aYM1QVpgesQL3WSabw1icLn7ktLmMW
 nvmFT5xTKZn8omXU2xx7oYAV95lst7idPsnC9gQLCdZQz6ZsfOZ2Njn+3lLFnT56IYVF
 yDXQ==
X-Gm-Message-State: AOJu0YyWWc/AL5nzKKNbgC5zlIN3ION/jeYpEF+D259PpoAt4GKjVWMF
 NlG7X78hVqmjd3goib6qo7i4m32V0Y0HDJVM1X0WVqJY0cJLnvMz6FHKtHnljimD5/naqkDTizk
 oFeD9AIm9ic5q9XEtdasTeGICyaUvkWedBtbxG8wpB1GOfw5eAB/VBNO78pNZvuJrgOVxqDWpQF
 0IIkaqniJLfmq5XRMl8ssibLCCXyLEX2vijOvZ+w==
X-Gm-Gg: ASbGncuhNzX3WBnGiaiJDx9vR/JDWe+eIzlvCmUPtOD+eLSTJFX7fZ46eRz+7NRInXs
 u0VKqt8Dsx93yiaLU3NpFlFXYnMD90g0F2Dj6BZ0UaQNqFw8SKuPqNxbEM8Usybp4M2QisejUJ8
 heVHPzSUJlePcxX8Q8znFcUPjDqWsDoN4Wpj8IRWSYOlaTQjGoR3x1ePcYZbt81bXyuYAxVZwER
 ybjpNzT5tEBiJryuYf7DJivrcGXXE/EZNX+43/kK0F725CVJu7VaFLOFFCVfNJipHEfH4sPxZEa
 FsrVtmb6Xao=
X-Received: by 2002:a05:622a:418a:b0:494:b1f9:d678 with SMTP id
 d75a77b69052e-4a72ff34caemr69052171cf.50.1749823685463; 
 Fri, 13 Jun 2025 07:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHiFeqi2sOFzCI8zx1ceUYmeWUKCIy/23RD3dCQ3aBQNudxnd154kLtXypfsQhRkWjdoK2CTA==
X-Received: by 2002:a05:622a:418a:b0:494:b1f9:d678 with SMTP id
 d75a77b69052e-4a72ff34caemr69051541cf.50.1749823684888; 
 Fri, 13 Jun 2025 07:08:04 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH v3 00/11] migration: Some enhancements and cleanups for 10.1
Date: Fri, 13 Jun 2025 10:07:50 -0400
Message-ID: <20250613140801.474264-1-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

v1: https://lore.kernel.org/r/20250527215850.1271072-1-peterx@redhat.com
v2: https://lore.kernel.org/r/20250609161855.6603-1-peterx@redhat.com

v3 changelog:
- Fix checkpatch issues on spaces etc.
- Added Tested-by tags for Mario on relevant patches

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
 migration/migration.c             | 62 ++++++++++++++++-------
 migration/ram.c                   | 32 +++++++-----
 migration/savevm.c                | 83 +++++++++++++++++--------------
 migration/trace-events            |  1 +
 11 files changed, 185 insertions(+), 145 deletions(-)

-- 
2.49.0


