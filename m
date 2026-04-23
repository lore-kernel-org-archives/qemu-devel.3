Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F99F99344
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:50:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqgI-000864-Nw; Thu, 23 Apr 2026 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgG-00085i-PP
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wFqgF-0001Dd-5T
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 05:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776937745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fH7O9bMNcZHR+adB4X7+64oSQIU2kraifX7H1T8AgP4=;
 b=Do8JiybPwc0poBeNH9qtSr7HIqo7Mtwfi++QYcSN5lNZ6/9u4UjW1f6Rd5LX2Vq/0wCK+4
 vleNTyjvNiofwAt/QL91C8r02Tl6j25dyNblRcWqz4G5kaRe9i1pu7Mc/R+GDU8tS9ovrv
 JVfoBsaQqinbyrv9Myj4LcKCY2fK19Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-38-L-17b0JAOceEdNesnDzyrQ-1; Thu,
 23 Apr 2026 05:49:03 -0400
X-MC-Unique: L-17b0JAOceEdNesnDzyrQ-1
X-Mimecast-MFC-AGG-ID: L-17b0JAOceEdNesnDzyrQ_1776937743
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C277A19560A6; Thu, 23 Apr 2026 09:49:02 +0000 (UTC)
Received: from gondolin.str.redhat.com (dhcp-192-224.str.redhat.com
 [10.33.192.224])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFA9C300756E; Thu, 23 Apr 2026 09:49:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org,
	Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 00/11] 11.1 compat machines and s390x updates
Date: Thu, 23 Apr 2026 11:48:45 +0200
Message-ID: <20260423094856.270215-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 98b060da3a4f92b2a994ead5b16a87e783baf77c:

  Update version for v11.0.0 release (2026-04-21 16:28:47 +0100)

are available in the Git repository at:

  https://gitlab.com/cohuck/qemu tags/s390x-20260423

for you to fetch changes up to 83f5164d25634f9104b5fb4a6772766ae646ad59:

  hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+) (2026-04-22 11:28:03 +0200)

----------------------------------------------------------------
First batch of updates for 11.1:
- compat machines for 11.1
- s390x: simplifications, cleanups, and a new test

----------------------------------------------------------------

Cornelia Huck (1):
  hw: add compat machines for 11.1

Eric Farman (1):
  MAINTAINERS: Update s390 trees

Jaehoon Kim (1):
  hw/s390x/ccw: Disable legacy virtio-pci by default (v11.1+)

Philippe Mathieu-Daudé (6):
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (cpu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (mmu)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (tcg)
  target/s390x: Replace legacy ld/st_phys -> address_space_ld/st (kvm)
  configs/targets: Restrict the legacy ldst_phys() API on s390x target
  target/s390x: Prefer MO_128 definition over magic value

Thomas Huth (2):
  target/s390x/kvm: Simplify the async pfault handling code
  tests/functional/s390x: Add test for booting from a disk with 4k
    sectors

 MAINTAINERS                            |   6 +-
 configs/targets/s390x-softmmu.mak      |   1 +
 hw/arm/virt.c                          |   9 +-
 hw/core/machine.c                      |   3 +
 hw/i386/pc.c                           |   3 +
 hw/i386/pc_piix.c                      |  13 ++-
 hw/i386/pc_q35.c                       |  13 ++-
 hw/m68k/virt.c                         |   9 +-
 hw/ppc/spapr.c                         |  15 ++-
 hw/s390x/s390-virtio-ccw.c             |  40 ++++++-
 include/hw/core/boards.h               |   3 +
 include/hw/i386/pc.h                   |   3 +
 target/s390x/cpu-system.c              |   2 +-
 target/s390x/kvm/kvm.c                 |  64 ++++--------
 target/s390x/mmu_helper.c              |   5 +-
 target/s390x/tcg/excp_helper.c         |  21 ++--
 target/s390x/tcg/mem_helper.c          |  12 ++-
 target/s390x/tcg/translate_vx.c.inc    |   2 +-
 tests/functional/s390x/meson.build     |   1 +
 tests/functional/s390x/test_boot_4k.py | 138 +++++++++++++++++++++++++
 20 files changed, 287 insertions(+), 76 deletions(-)
 create mode 100755 tests/functional/s390x/test_boot_4k.py

-- 
2.53.0


