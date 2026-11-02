Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73E9606A32E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QvrerBn5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNr7m-00087a-Cm; Mon, 02 Nov 2026 07:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7k-00086q-F1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNr7i-0001kM-GQ
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 07:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793622409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Eg3hCTN+uzEUkJHauZfnC5zO5gJ2ex37rLKl8C/0Z3k=;
 b=QvrerBn5sM1BBdYelmv9XXtdTtQWkMuHlRP5ztctqTMPtelqnCd7Zg6XWhUy7FVB4J2oVy
 ERmdD0U3p0lSmgGOkJuqa6f+tqj0fBFoxuLwaP3uLA8j2vBifltE7/5C5Ko5my0npKMD2X
 lFOF8ounEDiF6oozipJjekyGo3WGZyM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-sHJaPPj5NlO-25k3hzu9aQ-1; Mon,
 02 Nov 2026 07:26:48 -0500
X-MC-Unique: sHJaPPj5NlO-25k3hzu9aQ-1
X-Mimecast-MFC-AGG-ID: sHJaPPj5NlO-25k3hzu9aQ_1793622407
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EBBB1955E9C
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 12:26:47 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 77B2B1956087; Mon,  2 Nov 2026 12:26:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/13] Misc fixes patches
Date: Mon,  2 Nov 2026 12:26:32 +0000
Message-ID: <20261102122645.3353402-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to f4b560dd12612fa12217f3a621ab54dfb6157040:

  accel/nitro: mark 'nitro' accelerator as secure (2026-11-02 11:08:45 +0000)

----------------------------------------------------------------
* Mark virtualization related machine types as secure
* Mark KVM, Xen and Nitro accelerators as secure
* Use getexecpath on OpenBSD
* Use qemu_dup() over dup()

----------------------------------------------------------------

Brad Smith (1):
  util/cutils: Use getexecpath() on OpenBSD for qemu_init_exec_dir()

Daniel P. Berrangé (11):
  hw/arm: mark 'virt' as a secure machine
  hw/i386: mark 'microvm', 'i440fx', 'q35' as secure machines
  hw/loongarch: mark 'virt' as a secure machine
  hw/ppc: mark 'pseries' as a secure machine
  hw/riscv: mark 'virt' as a secure machine
  hw/s390x: mark 's390x-ccw-virtio' as a secure machine
  hw: mark xenpv, xenpvh, xenfv as secure machines
  hw/nitro: mark 'nitro' machine as secure
  accel/kvm: mark kvm accelerator as secure
  accel/xen: mark xen accelerator as secure
  accel/nitro: mark 'nitro' accelerator as secure

Filip Hejsek (1):
  treewide: use qemu_dup() instead of dup()

 accel/kvm/kvm-all.c            | 1 +
 accel/nitro/nitro-accel.c      | 1 +
 accel/xen/xen-all.c            | 1 +
 hw/arm/virt.c                  | 1 +
 hw/arm/xen-pvh.c               | 1 +
 hw/i386/microvm.c              | 1 +
 hw/i386/pc_piix.c              | 4 ++--
 hw/i386/xen/xen-pvh.c          | 1 +
 hw/loongarch/virt.c            | 1 +
 hw/nitro/machine.c             | 1 +
 hw/ppc/spapr.c                 | 1 +
 hw/riscv/virt.c                | 1 +
 hw/s390x/s390-virtio-ccw.c     | 1 +
 hw/virtio/virtio.c             | 2 +-
 hw/xenpv/xen_machine_pv.c      | 2 +-
 include/hw/i386/pc.h           | 1 +
 io/channel-file.c              | 2 +-
 meson.build                    | 8 ++++++++
 migration/cpr-exec.c           | 2 +-
 qemu-nbd.c                     | 2 +-
 system/vl.c                    | 9 +--------
 tests/qtest/bios-tables-test.c | 2 +-
 tests/unit/test-util-sockets.c | 6 +++---
 tests/unit/test-vmstate.c      | 2 +-
 ui/dmabuf.c                    | 2 +-
 util/cutils.c                  | 6 ++++++
 26 files changed, 41 insertions(+), 21 deletions(-)

-- 
2.56.0


