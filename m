Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C615606A328
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 13:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VQfbNewo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOEfO-0003oA-Gf; Tue, 03 Nov 2026 08:35:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xOEfN-0003np-D6
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:35:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xOEfL-0006EC-54
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 08:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793712905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kmmWzNoNKKNTKijdZm9e+dgjJHa2MpCTwdt6oaGQosE=;
 b=VQfbNewo+rAG2wU6VHIeeWLFUTp5zt/8iIQv2uDScVjIuT3I1hjSIj6LMrYLw3gNSQfRS/
 ImODGCF2KyF5hyfX8Wg7zl7Vr0/jfjYMPNP6LDNvvuSnQWt45zzI6lOptktWFm7XN3f4EM
 Te/Ry3BIteFQOEd7YJvQYeIDm0I28Fg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-JSMy-V8sOyq63YHIoKL6rw-1; Tue,
 03 Nov 2026 08:35:03 -0500
X-MC-Unique: JSMy-V8sOyq63YHIoKL6rw-1
X-Mimecast-MFC-AGG-ID: JSMy-V8sOyq63YHIoKL6rw_1793712903
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B41CC195606B
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:35:02 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0ECAD195608C
 for <qemu-devel@nongnu.org>; Tue,  3 Nov 2026 13:35:01 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
Date: Tue,  3 Nov 2026 14:34:59 +0100
Message-ID: <20261103133500.2295582-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

The following changes since commit 74f7bf4c59e6b6d50dbc6e124d93440be8be4386:

  Merge tag 'pull-target-arm-20261102-1' of https://gitlab.com/pm215/qemu into staging (2026-11-02 20:19:27 -0800)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ab78ac76f44a1241e76fd32d248df62d83f1ea58:

  meson: rewrite scripts/qemu-version.sh directly in meson.build (2026-11-03 14:31:24 +0100)

----------------------------------------------------------------
* target/i386/tcg: bugfixes and cleanups
* AGENTS.md: add final instructions
* meson: rewrite scripts/qemu-version.sh directly in meson.build

----------------------------------------------------------------

v1->v2: also adjust ui/cocoa.m

Alex Bennée (1):
      target/i386: terminate a tcg block on gen_RDMSR

Jiang Yuxuan (1):
      target/i386: raise #DE for INT_MIN / -1 in IDIV helpers

Paolo Bonzini (8):
      target/i386/tcg: change popl_esp_hack to an X86InsnSpecial
      target/i386/tcg: inline gen_leave
      target/i386/tcg: reject VEX.NP for MMX instructions
      target/i386/tcg: remove X and Y operand types
      target/i386/tcg: remove F operand type
      AGENTS.md: add final instructions
      include: introduce qemu/version.h
      meson: rewrite scripts/qemu-version.sh directly in meson.build

 meson.build                          | 29 ++++++++++-----
 include/qemu/version.h               | 20 ++++++++++
 target/i386/tcg/decode-new.h         |  9 +++--
 bsd-user/main.c                      |  2 +-
 linux-user/main.c                    |  2 +-
 monitor/qmp-cmds-control.c           |  2 +-
 qemu-img.c                           |  2 +-
 qemu-io.c                            |  2 +-
 qemu-nbd.c                           |  2 +-
 qga/main.c                           |  2 +-
 scsi/qemu-pr-helper.c                |  2 +-
 storage-daemon/qemu-storage-daemon.c |  2 +-
 system/vl.c                          |  2 +-
 target/i386/tcg/int_helper.c         |  4 +-
 target/i386/tcg/translate.c          | 21 +++--------
 tests/tcg/i386/test-idiv-overflow.c  | 70 +++++++++++++++++++++++++++++++++++
 tools/i386/qemu-vmsr-helper.c        |  3 +-
 tools/qemu-vnc/qemu-vnc.c            |  2 +-
 util/module.c                        |  2 +-
 target/i386/tcg/decode-new.c.inc     | 72 ++++++++++++++++++------------------
 target/i386/tcg/emit.c.inc           | 30 ++++++++++-----
 AGENTS.md                            | 10 +++++
 scripts/qemu-version.h.in            |  1 +
 scripts/qemu-version.sh              | 25 -------------
 tests/tcg/i386/meson.build           |  1 +
 tests/tcg/x86_64/meson.build         |  1 +
 ui/cocoa.m                           |  2 +-
 27 files changed, 206 insertions(+), 116 deletions(-)
 create mode 100644 include/qemu/version.h
 create mode 100644 tests/tcg/i386/test-idiv-overflow.c
 create mode 100644 scripts/qemu-version.h.in
 delete mode 100755 scripts/qemu-version.sh
-- 
2.56.0


