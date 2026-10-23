Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E4C606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=XS+s6ik1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDba-0006lX-T5; Fri, 23 Oct 2026 07:38:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3OEfbagoKCpEDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbY-0006kv-E8
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:36 -0400
Received: from mail-pf1-x447.google.com ([2607:f8b0:4864:20::447])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3OEfbagoKCpEDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com>)
 id 1xKDbW-000668-Nx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:38:36 -0400
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8862ed0539dso996362b3a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792755512; x=1793360312; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TC3us8FitB1y4flUQTEeLtTuCGOb45kW77IoCG4MHe0=;
 b=XS+s6ik1jqK08OTFIQg5EUXJoaP+cZAVY6sQPHk2noBEImLe07ABvLcEbWr/9YXL7A
 x4G5W01YAwaWKhamckQRius+C9ZhpirQgoo4khypIHyODMw2/QqbCFj0X0uvzXyRBwcr
 4JT20tHVOJo9THATUcI1Tca7z2nfdL8cz1OZZORwyJa0MXp6D5VgCFG/rFnPdni+ImUU
 KoiQD7QGN167AYEmX14v8aiaWCO15M7IwwUE1KoUb9hKyh5d59yvvIfHwxXS2HyFICar
 xvbhMV5njoyAluMmsUVj5mxtpxwl9FLvOXtiFaaC3Q43kgobJsXid2RiR2TyC0lO12Ra
 Z/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792755512; x=1793360312;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TC3us8FitB1y4flUQTEeLtTuCGOb45kW77IoCG4MHe0=;
 b=lrTtIbepN5Qp+C8Ow4m47ZTdvRES8/1APaab8TLUg5RYqG4ujMS9IWxlDe+Mm1WTUG
 8JifT2P9ftFwhKD2z8XRH/EcyEjeDKn3tHoPg6KXVvnwBfDGIK0W26Eep6hhd4Nf3YR7
 LF3OBbQl/uBM6cG1oy2TKjIhPCUMTL78jzAJvOvxCBMExnKVVLFwI8ZqcIcPsdAcxXLe
 BoEhKTnYgtsQQWDNBD2UtvyT4eLI2uZULhGMz4Rg+W6GAt8sPNFYThhwcxTZHFsQdHBI
 M0cIq4kwTKv15Y/n2BXBGUSZ0Ph/83GpqDAdJwa2zQy5XMGwKCwVewERgPRq/3o9BFOg
 z7/A==
X-Gm-Message-State: AFq9FYL9MM+gvTk97tq4qCnjvTkUb3YdPFfY5dccOJDLFRAC6moyFaUc
 /uuYBSKoJqiKyRX7rgqJpbBXB2OXgdKv2xKMMn8e4BVsTFQFvBv4fguxoXg73EGTlocZjz2RG9v
 yYeBG9oOsb7gRIIMfP+82uw==
X-Received: from pfblr14.prod.google.com
 ([2002:a05:6a00:738e:b0:8a0:6a08:e927])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3ccc:b0:89f:c71e:aba5 with SMTP id
 d2e1a72fcca58-8a2c765c6cdmr1682061b3a.37.1792755512155; 
 Fri, 23 Oct 2026 04:38:32 -0700 (PDT)
Date: Fri, 23 Oct 2026 19:38:22 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261023113830.3368902-1-stanleyjhu@google.com>
Subject: [PATCH v3 0/8] hw/ufs: Add fault injection, update TMR doc,
 and add qtests
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::447;
 envelope-from=3OEfbagoKCpEDEv86zJ42F19916z.x97Bz7F-yzGz689818F.9C1@flex--stanleyjhu.bounces.google.com;
 helo=mail-pf1-x447.google.com
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

Differences from v2:
- On QUERY TASK in in-transition mode, execute the held request through
  the normal path and return real task status instead of completing with
  synthetic success.
- Map x-fault-inject-mode to an enum property with QEnumLookup
  validation and reject values greater than 255 in x-fault-inject-tag.
- Match 16-byte SCSI read and write commands in fault injection and
  update trace events to 64-bit LBA.
- Verify reset queue tail pointers in HCE reset and add doorbell fault
  injection test coverage for legacy UFS mode.

v2: https://lore.kernel.org/qemu-devel/20261022074513.2292281-1-stanleyjhu@google.com/
v1: https://lore.kernel.org/qemu-devel/20261015060827.341298-1-stanleyjhu@google.com/

Tested with qos-test on aarch64 (all 29 UFS test cases pass,
including 10 zoned UFS cases).

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
 hw/ufs/trace-events         |   2 +
 hw/ufs/ufs-pci.c            |   7 +
 hw/ufs/ufs-sysbus.c         |   7 +
 hw/ufs/ufs.c                | 260 +++++++++-
 hw/ufs/ufs.h                |  65 +++
 tests/qtest/ufs-test.c      | 970 ++++++++++++++++++++++++++++++++++++
 7 files changed, 1314 insertions(+), 4 deletions(-)

-- 
2.56.0.307.g5fe7bd680c-goog


