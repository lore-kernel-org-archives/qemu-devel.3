Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D224606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jPPuHOGF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJnUH-0007Ep-0R; Thu, 22 Oct 2026 03:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3C7_ZagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUF-0007EI-PG
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:19 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3C7_ZagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com>)
 id 1xJnUD-0002Fl-ND
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 03:45:19 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8a05bfa6af5so1173377b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792655116; x=1793259916; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OZTtSqza/DC5uE9GXrjltUSVUmMKgCUvlJcl+I2az1Q=;
 b=jPPuHOGFc4u4BbZ2+GwUzkjanETIetwa/1z9Bo7CgRphcMcrO+naPoQq2DvOcE21fk
 9kgtH9jfqK1JrbvYkKty8ATbJ2J7Ws+mR56YSkiraHMnKPGEcH731Jx6IwsxchseOmqr
 FNv+cmRkRJhX3k2CQ3yo5Q5ryafjzbmVl59meUPUUTGe5jEx6JOtE2Z4sTdsxKIvriWE
 2G8jogqMgvmwbk2R1+G4bmFZBJtcxjoKdfhLv9WBM9Jx8jOHfY0+twfaY5PZVc74NIXP
 hkX8t3fojc3fJ/AZ8ZI6wHoWbnY3/yDDBmU9NW0h6sdWea0g/NK5qWYjaNKNoZ9hLYva
 wl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655116; x=1793259916;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OZTtSqza/DC5uE9GXrjltUSVUmMKgCUvlJcl+I2az1Q=;
 b=lhRy/b70mzASJ0n8Lg3nXu9fiWA/PLZgD5fZSOKgT2PsXcrZNJhjHE/qbm8raC94s6
 iTsM3Li/gD+KxnOThoLp/ifiqs2bAk2A9N5A/VEE40a94Oc4XY1376br1R7+v+1yle/K
 0blyJRoflTZA2mRuOufK0SZlJHrSbEMAhSUSg3TtbHIAyKSSG13G67ynly4qgHv/YrF/
 nwS/8QBlJlCqAcbtpJY2EYvlrRLOjiJQiQyJ0Ob+AYleY5YIr+trF+u9X/1jbnYdkJ0A
 TJmome4ddNrT/oPNIeVBvZ3Ijie/9fS5TU3cLdAvAxYRBFdC9kQ3dgMaRwugsXDNUQsI
 nq+g==
X-Gm-Message-State: AFq9FYKjS30dWwFHZ9pmxrm0aaXJl6bDZP54bXqoCzQCXPpGY68vYeWC
 DL3BG4he/tTeiWQsS4KhKxaM7CO8E4pgOhDkZ2wL77b+grjCYMLFupAkZGKqcbYIgP0rdb85HrW
 NXWBiXq0daSNrlRTh+TdgBQ==
X-Received: from pfbbq15.prod.google.com ([2002:a05:6a00:e0f:b0:89d:56e1:f725])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:e17:b0:874:705d:f64a with SMTP id
 d2e1a72fcca58-8a089f7430amr2911586b3a.44.1792655115539; 
 Thu, 22 Oct 2026 00:45:15 -0700 (PDT)
Date: Thu, 22 Oct 2026 15:45:05 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
Message-ID: <20261022074513.2292281-1-stanleyjhu@google.com>
Subject: [PATCH v2 0/8] hw/ufs: Add fault injection, update TMR doc,
 and add qtests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3C7_ZagoKCk489q31uEzxAw44w1u.s426u2A-tuBu1343w3A.47w@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x448.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds experimental fault injection to the UFS device model
so host drivers can exercise task abort and power management recovery,
updates the task management description in the UFS docs, and adds
qtest cases for controller reset, MCQ runtime registers, task
management and fault-injected task abort.

The series applies on top of Daejun Park's Zoned UFS v3 series.

- Patches 1-2: x-fault-inject-tag and x-fault-inject-mode properties
  to hold a transfer request, and task management handling for the
  held request.
- Patch 3: ssu-timeout mode for power management recovery testing.
- Patch 4: document the supported task management functions (QUERY
  TASK and ABORT TASK).
- Patches 5-8: qtest helpers and test cases.

The fault injection properties are experimental (x- prefix) and off
by default.

Differences from v1:
- Rebased on top of Daejun Park's Zoned UFS v3 series.
- Clarified in patch 2 that in-transition mode completes without
  executing the SCSI command or transferring data.

v1: https://lore.kernel.org/qemu-devel/20261015060827.341298-1-stanleyjhu@google.com/

Tested with qos-test on aarch64 (all 28 UFS cases pass, including 10
zoned UFS cases).

Based-on: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>

Stanley Jhu (8):
  hw/ufs: Add experimental fault injection properties for holding
    requests
  hw/ufs: Handle task management requests for fault-injected held
    requests
  hw/ufs: Add ssu-timeout mode for power management recovery testing
  docs/system/ufs: Update task management request support status
  tests/qtest/ufs-test: Add TMR and async MCQ SCSI submission helpers
  tests/qtest/ufs-test: Add HCE reset unit test
  tests/qtest/ufs-test: Add MCQ runtime register and TMR handling test
  tests/qtest/ufs-test: Add QOM fault injection task abort test

 docs/system/devices/ufs.rst |   7 +-
 hw/ufs/trace-events         |   3 +
 hw/ufs/ufs-pci.c            |   6 +
 hw/ufs/ufs-sysbus.c         |   6 +
 hw/ufs/ufs.c                | 341 +++++++++++++++++++-
 hw/ufs/ufs.h                |  62 ++++
 tests/qtest/ufs-test.c      | 618 ++++++++++++++++++++++++++++++++++++
 7 files changed, 1039 insertions(+), 4 deletions(-)

-- 
2.56.0.218.g1ec904b173-goog


