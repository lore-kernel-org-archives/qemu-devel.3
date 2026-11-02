Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CD606A905
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 17:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hRUtUJ/i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNvUz-0002Fz-11; Mon, 02 Nov 2026 12:07:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvUx-0002FV-4Q
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xNvUv-0005xg-CC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 12:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793639223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=SiCyuVt4HTpawcb2S4NJWC+KFjsz6DUMEI6tIwrnW2k=;
 b=hRUtUJ/iMXlYNLroLLgu2ZBjxShZg8sgsiaBMHQfSQxyC2g3KHcyICUHgaKhcs54p3QZMV
 AQ7ajmlcVPTXyN+VyX8GPfd6wvnp17Tp7IABYnSX0PkrNemXKhaH63MNOnEk3UvX/MweMF
 N3wghuKshDWtdEMP+e+0qIp6hpXcgtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-0jmgcL_XNlK0rdiSl07i_A-1; Mon,
 02 Nov 2026 12:07:01 -0500
X-MC-Unique: 0jmgcL_XNlK0rdiSl07i_A-1
X-Mimecast-MFC-AGG-ID: 0jmgcL_XNlK0rdiSl07i_A_1793639220
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A1C6180065D
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 17:07:00 +0000 (UTC)
Received: from berrange.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78585300019F; Mon,  2 Nov 2026 17:06:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 00/12] Misc fixes patches
Date: Mon,  2 Nov 2026 17:06:46 +0000
Message-ID: <20261102170658.3649401-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

for you to fetch changes up to b95f1036d5f8b35d8d5b4c18d33bb6564fcbf2e5:

  accel/nitro: mark 'nitro' accelerator as secure (2026-11-02 17:05:33 +0000)

----------------------------------------------------------------
* Mark virtualization related machine types as secure
* Mark KVM, Xen and Nitro accelerators as secure
* Use getexecpath on OpenBSD

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

 accel/kvm/kvm-all.c        | 1 +
 accel/nitro/nitro-accel.c  | 1 +
 accel/xen/xen-all.c        | 1 +
 hw/arm/virt.c              | 1 +
 hw/arm/xen-pvh.c           | 1 +
 hw/i386/microvm.c          | 1 +
 hw/i386/pc_piix.c          | 4 ++--
 hw/i386/xen/xen-pvh.c      | 1 +
 hw/loongarch/virt.c        | 1 +
 hw/nitro/machine.c         | 1 +
 hw/ppc/spapr.c             | 1 +
 hw/riscv/virt.c            | 1 +
 hw/s390x/s390-virtio-ccw.c | 1 +
 hw/xenpv/xen_machine_pv.c  | 2 +-
 include/hw/i386/pc.h       | 1 +
 meson.build                | 8 ++++++++
 util/cutils.c              | 6 ++++++
 17 files changed, 30 insertions(+), 3 deletions(-)

-- 
2.56.0


