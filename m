Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D40C606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 06:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=jbdEqc+u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLaGA-0007pm-5H; Tue, 27 Oct 2026 02:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Uj7gagoKCq0fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com>)
 id 1xLaG0-0007nN-T8
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:01 -0400
Received: from mail-pf1-x448.google.com ([2607:f8b0:4864:20::448])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Uj7gagoKCq0fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com>)
 id 1xLaFz-00066c-5s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 02:02:00 -0400
Received: by mail-pf1-x448.google.com with SMTP id
 d2e1a72fcca58-8862ed0539dso4469274b3a.0
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1793080915; x=1793685715; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i1bWzbL7wLqtphI9653rQJ+cKvm96JN3a88sKTtOPYs=;
 b=jbdEqc+u4kIH+iWqwRU6usLFu6qH2bftEodzSj1YQ2wFtPKm3pANt/pQG0326FHxYd
 CgyTaODJVvOCXKbEGl9WAZXGCcNC84MmiZLbAlHd/5lg0Xt8xI1CRVYnw9U5iTOLiGnU
 syJcqxSOjpJG1jdhUCrrxJ7bmZdoZ5gt3hWrOS9YA7M50rdzn0GLw/sNMGk/2LsYRXHP
 KDfGX7/G/CUszOha4689cfoFZ4dWkqYccz6toHrHwBD1uUuLLHx2HnQSPWUe6PfON9s7
 lcRP6Iup2rVrlD6raaJfJPehJ9VZsXhpGjDfgMntR2ciLAcba92S7WfnRTTLT0XCZW6A
 3PFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793080915; x=1793685715;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i1bWzbL7wLqtphI9653rQJ+cKvm96JN3a88sKTtOPYs=;
 b=tCf7hj8WolBWlC3ocbGWKA9eHMl+ELtNn+jMyswksSnXQSgqDukgrIZhyLZN8AU4T8
 x2QEftK4O6O7Ml8MtDm9+3PcHVU8bMurNpPrSTZHKmw5q9htZ945NEkZi8ogBU2ESE8K
 i/NJpw76AFLY6y7bBAfp8GuInyn4bIUdpOHo/hep/EFwZsrZ5ET5qGmF4KE/RGkT3H6Z
 zw+Dhl1k+lbSxuoAKEM1ZoQJ1GrVmbtCTRTJUWnRESsrT1dSi6pt4TLvJqP7kYjCPHSJ
 ipTOQ8s9k/4N1StpcnDg89cJgXoefakCrNnIE2wHhlFO66zub7cK3sVNg+s/rsZqY5W/
 AdeA==
X-Gm-Message-State: AFq9FYK/gaE3tqProUjwWGlf3fmz03Di83pXDsaktVIe1OHJ6RMC8Tco
 4zv3X6RSt/afoEd3hLZOziiEQjbCYL/8yfJHMWpNTnZjWjAt+BWqW5PNxfWvfUkLyJ969tXfpai
 G9c/xhfpqKXHu7EEHF1yeGg==
X-Received: from pfbdw21.prod.google.com
 ([2002:a05:6a00:3695:b0:89f:827e:eb47])
 (user=stanleyjhu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3a17:b0:89e:779b:cff with SMTP id
 d2e1a72fcca58-8a364b4ce5fmr7395364b3a.6.1793080914777; 
 Mon, 26 Oct 2026 23:01:54 -0700 (PDT)
Date: Tue, 27 Oct 2026 14:01:45 +0800
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
Message-ID: <20261027060153.1842910-1-stanleyjhu@google.com>
Subject: [PATCH 0/7] hw/ufs: Add RPMB well-known logical unit emulation
From: Stanley Jhu <stanleyjhu@google.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, Jeuk Kim <jeuk20.kim@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Jinyoung Choi <j-young.choi@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::448;
 envelope-from=3Uj7gagoKCq0fgNaYRlWUhTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--stanleyjhu.bounces.google.com;
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

This series implements RPMB (Replay Protected Memory Block) well-known
logical unit emulation (W-LUN 0xc4) for QEMU UFS per JESD220H Section
12.4.

Summary of Changes:
- Patch 1: Add SCSI security protocol opcodes and RPMB definitions.
- Patch 2: Set bSecurityLU to 0x01, enable RPMB unit descriptor, wire
  SECURITY PROTOCOL IN/OUT CDB and PRDT buffer capacity validation via
  ufs_fit_data_buffer(), add Result Register read handling in
  hw/ufs/rpmb.c, and clear volatile RPMB state in ufs_hce_reset().
- Patch 3: Add qtest case for DeviceDescriptor bSecurityLU, RPMB unit
  descriptor, CDB, W-LUN dispatch, and PRDT validation.
- Patch 4: Add HMAC-SHA256 key programming and write counter read
  handling.
- Patch 5: Add qtest case for key programming and write counter reads.
- Patch 6: Add single- and multi-frame authenticated data write and read
  handling and update docs/system/devices/ufs.rst.
- Patch 7: Add qtest case for authenticated data writes, reads, check
  ordering, general-failure paths, multi-region isolation, and HCE reset
  state handling.

Outside hw/ufs and tests, the series only adds the SECURITY PROTOCOL
IN/OUT opcodes to include/scsi/constants.h and RPMB definitions to the
UFS-only include/block/ufs.h. There is no change to block layer or SCSI
core code.

Tested: QEMU ARM64/x86_64 qos-test and Linux guest SDB/MCQ RPMB, pass.

Based-on: <20261023113830.3368902-1-stanleyjhu@google.com>

Stanley Jhu (7):
  include/scsi, block/ufs: Add security protocol and RPMB definitions
  hw/ufs: Add RPMB unit descriptor and SECURITY PROTOCOL IN/OUT dispatch
  tests/qtest/ufs-test: Add RPMB descriptor and CDB validation test
  hw/ufs: Add RPMB key programming and write counter read handling
  tests/qtest/ufs-test: Add RPMB key programming and write counter test
  hw/ufs: Add RPMB authenticated data write and read handling
  tests/qtest/ufs-test: Add RPMB authenticated data read and write test

 docs/system/devices/ufs.rst |   6 +-
 hw/ufs/lu.c                 |  34 ++
 hw/ufs/meson.build          |   2 +-
 hw/ufs/rpmb.c               | 447 +++++++++++++++++
 hw/ufs/trace-events         |   3 +
 hw/ufs/ufs.c                |  26 +-
 hw/ufs/ufs.h                |  24 +
 include/block/ufs.h         |  58 ++-
 include/scsi/constants.h    |   2 +
 tests/qtest/ufs-test.c      | 959 ++++++++++++++++++++++++++++++++++++
 10 files changed, 1552 insertions(+), 9 deletions(-)
 create mode 100644 hw/ufs/rpmb.c

-- 
2.56.0.307.g5fe7bd680c-goog


