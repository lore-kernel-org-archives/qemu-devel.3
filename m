Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9139606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EH3BrUvl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhlT-0006Bh-EZ; Fri, 30 Oct 2026 04:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlM-00069D-Lo
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:01 -0400
Received: from mail-dl1-x1234.google.com ([2607:f8b0:4864:20::1234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1xMhlJ-0001Lz-W0
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:15:00 -0400
Received: by mail-dl1-x1234.google.com with SMTP id
 a92af1059eb24-188406bb948so394446c88.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793348096; x=1793952896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=e9LlI/V/g0/8qT6wJbJbo03V167hJsPckYFLY6TsBjI=;
 b=EH3BrUvlfOSIvyqM900i4FY2n84+qJ4ZoXhWW+cliC7HtpHPtYy+4cIbCo7gqJyoOL
 2ahcHiA2GIrLUYZb3HfLJkAtUve2McPu6xCJ/xtYGcLjc1Wdg+CsvBoxoocAz2QN1wbK
 NhA69bjoHEx+uSuIAS71UpG+aEBR6mUvMZwahJeEnPFX3mYsN3oPsU3uj2EFjudYUns1
 WKV5pLI+rsqESvUX0Nr8IObTwBcWO/p3wUNhS4c2xrkW9Z0B5z3NWRyd3DnjR7NvbCX8
 Efhe8517oXZD3Vyw1Cnr8E2j3N/RMdZH4H62Ewu00w1o6Sb09K37fMrX/iPINLurEgpi
 ZHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793348096; x=1793952896;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9LlI/V/g0/8qT6wJbJbo03V167hJsPckYFLY6TsBjI=;
 b=tfJQphIFNUP3VxlfnkHmn0HU/qIkUo5PlGtDGLOX0Tp48sydtMZoVxRd7nbkoKVHK1
 srH1ScE+nu+g23rPJNSdEZg5J/wBhvogFZ/sFcmRlSvTMwIoqxgSVo/66jZslOPy0NAs
 QxLsoBH0pNCvN2d3Ed3kGcPx3ao8GhTpas98A3+l/Xyor+1AonuHtz0z3aHMG21/QhBd
 0baRocdEMRlvZqNJlhiDeFSLkoQpYli3bq77v770PwrkI/oroDz3T0pCa497Xy2WHbuY
 2DTXh/Rbm3Qcc3GabmQBm0bHM0J74lLx9TtnZHsVRtbzJRsBmUx/0toQaABusIohXpO+
 Ce7A==
X-Gm-Message-State: AFq9FYLUjK7yTWjNI+cNiFbBqcmxTnM7VQ67Xt6cF5MpStbjk5dXittB
 uMnf8Yu5B8K4rlg7PUoz0Xw+gBVzGQBZK4AHtK213tLG6Ro1RVW3+76+Rb9rAA==
X-Gm-Gg: AYBFou3UkYslI6KK9gUeDt56Nj3tJCfCQIOu6CxGvOy7yuv82Vzzh2sliyUsbfEdTh9
 SORRaCq3cLnT8DO6DPVsYMvAWX4+9DlQLB8q3z/wN1EJ/HStOBWBBfQseSJ4ZhpmOJQrbKMaSST
 Ga4tWlcDDlCWD2V6gcFiY7PuDaCBMn1+agO6S13k+XS/rd9TCrjdxDrbqn+AO6M27juuUC65Nvv
 hOj+0odSUOc89W6hiQMVgRKIbF7du6lTQR5iVRXCDfhvf/nY+gK7zoZpDtNxOlZCV5HDQ/nTbc3
 O3gEV+tW0H4vkmOpUsvjBApFeOnzscVMLmDffNrODRqf03F7CUps61tqCFhcCI/qP0gOc/c8iB7
 PkAnSHkxCsGNYkdlTmd4vP0K5IstDwfFzb6fG6I1iHK755L8IdryVS07cT6/Wa0pqwUKDovt6e+
 gG3a6zkOB2Cx468HqrLe0of71wWkZ57SRUkvk9Xwf6YhpWbgcX3QMfD0g70FH7uRXDhCMwLF3D+
 QV37E+RibLPWgJkTP4GmAQASrPdBSKnZ/Ml6FtWZsNIge2QsZQY7AFn3FsUH9FHRGYgik0ybAVP
 hw+bJ9iKRBJURTyQ4NcO8XUL9UGnBkNV5JtOLifKtG7ibNpBujucYoR5irL3Phx4aw==
X-Received: by 2002:a05:7022:ea48:10b0:144:ddf7:2570 with SMTP id
 a92af1059eb24-1ac5da7b12fmr2302540c88.39.1793348095746; 
 Fri, 30 Oct 2026 01:14:55 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm5905766c88.11.2026.10.30.01.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:14:55 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: stefanha@redhat.com, pbonzini@redhat.com, fam@euphon.net, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, daejun7.park@samsung.com,
 stanleyjhu@google.com, dridiha98@gmail.com, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com
Subject: [PULL 00/12] UFS command fixes and fault injection tests
Date: Fri, 30 Oct 2026 17:14:26 +0900
Message-ID: <cover.1793347487.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1234;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-dl1-x1234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit b574eaf640f02c4edf28cbee6417378f0d79cda0:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2026-10-29 13:47:40 -0500)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20261030

for you to fetch changes up to cc145a41586bde12c94b7e8932988cff323ad3a7:

  tests/qtest/ufs-test: Add QOM fault injection task abort test (2026-10-30 17:00:58 +0900)

----------------------------------------------------------------
UFS command fixes and fault injection tests

- Add REPORT LUNS support for well-known LUNs
- Fix PRDT validation and SYNCHRONIZE CACHE handling
- Add fault injection and reset/task management tests

----------------------------------------------------------------
Daejun Park (3):
      hw/ufs: Fail SCSI commands that move data without a PRDT
      hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
      hw/ufs: Check the PRDT size against the transfer length of the CDB

Stanley Jhu (8):
      hw/ufs: Add experimental fault injection properties for holding requests
      hw/ufs: Handle task management requests for fault-injected held requests
      hw/ufs: Add ssu-timeout mode for power management recovery testing
      docs/system/ufs: Update task management request support status
      tests/qtest/ufs-test: Add TMR and async MCQ SCSI submission helpers
      tests/qtest/ufs-test: Add HCE reset unit test
      tests/qtest/ufs-test: Add MCQ runtime register and TMR handling test
      tests/qtest/ufs-test: Add QOM fault injection task abort test

dridiha (1):
      hw/ufs: Add support for REPORT_LUNS SCSI command for Well Known LUNs

 docs/system/devices/ufs.rst |    7 +-
 hw/ufs/lu.c                 |   85 ++-
 hw/ufs/trace-events         |    3 +
 hw/ufs/ufs-pci.c            |    7 +
 hw/ufs/ufs-sysbus.c         |    7 +
 hw/ufs/ufs.c                |  305 ++++++++++-
 hw/ufs/ufs.h                |   68 +++
 include/block/ufs.h         |    3 +
 tests/qtest/ufs-test.c      | 1202 ++++++++++++++++++++++++++++++++++++++++++-
 9 files changed, 1666 insertions(+), 21 deletions(-)

