Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10998CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCs6-0000F0-2s; Tue, 21 Oct 2025 09:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCs0-0000DJ-Mi
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vBCrx-0007we-U3
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 09:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761055064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=szPxpttNSZBGBgRs5/zRXAVwbzz9nfEweIAoiIl71+Q=;
 b=LM1gR6zZpJ35x9EBJUixS9MtCReuV7RkDffGcb8gBSuWWjgrJDwTl2X2MYex83ET5fF1Rj
 3qNiFcHbwWIgks+wKLvR4vY9VqbJTNTXMxshHVAbPazrBsv65MaSU8bo03+jqMaIeaFp93
 jiZfSK0YljMXrmn6lUcvz3e0XmnyjD4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-359-Lo5v7p8POz6m0nEFHf0LZQ-1; Tue,
 21 Oct 2025 09:57:39 -0400
X-MC-Unique: Lo5v7p8POz6m0nEFHf0LZQ-1
X-Mimecast-MFC-AGG-ID: Lo5v7p8POz6m0nEFHf0LZQ_1761055058
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29E6E1956086; Tue, 21 Oct 2025 13:57:38 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-176.str.redhat.com
 [10.33.192.176])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4015119560A2; Tue, 21 Oct 2025 13:57:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/6] s390x patches + gitlab-CI fix
Date: Tue, 21 Oct 2025 15:57:29 +0200
Message-ID: <20251021135735.96145-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Richard!

The following changes since commit 3a2d5612a7422732b648b46d4b934e2e54622fd6:

  .gitlab-ci.d/buildtest.yml: Install 'file' for the Coverity job (2025-10-19 11:49:36 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-10-21

for you to fetch changes up to 8a2b283efa007f705f12784fc10185435bd1852f:

  gitlab-ci: Decrease the size of the compiler cache (2025-10-21 15:47:45 +0200)

----------------------------------------------------------------
- Add a missing QAPI event + functional test for the CPI feature on s390x
- Remove the obsolete s390-ccw-virtio-4.2 machine type
- 2nd try to fix the slow cache up/download in the MSYS2 CI job

----------------------------------------------------------------
Philippe Mathieu-Daudé (3):
      hw/s390x/ccw: Remove deprecated s390-ccw-virtio-4.2 machine
      hw/s390x/ccw: Remove SCLPDevice::increment_size field
      hw/core/machine: Remove MachineClass::fixup_ram_size callback

Shalini Chellathurai Saroja (2):
      qapi/machine-s390x: add QAPI event SCLP_CPI_INFO_AVAILABLE
      tests/functional: add tests for SCLP event CPI

Thomas Huth (1):
      gitlab-ci: Decrease the size of the compiler cache

 qapi/machine-s390x.json                   | 21 +++++++++++++++++++
 include/hw/boards.h                       |  7 -------
 include/hw/s390x/sclp.h                   |  5 +----
 hw/core/machine.c                         |  3 ---
 hw/s390x/s390-virtio-ccw.c                | 33 ------------------------------
 hw/s390x/sclp.c                           | 34 +++----------------------------
 hw/s390x/sclpcpi.c                        |  4 ++++
 .gitlab-ci.d/windows.yml                  |  5 ++++-
 tests/functional/s390x/test_ccw_virtio.py | 26 +++++++++++++++++++++++
 9 files changed, 59 insertions(+), 79 deletions(-)


