Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4211C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 10:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXIvv-0006u6-8U; Tue, 06 Feb 2024 05:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvl-0006sK-P2
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:43:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rXIvj-00039C-8P
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 05:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707216233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=384goALF7mJoNK4zopP4QQRoFyK7PhD2ZUnkGFAJ2Ns=;
 b=Je/vjv5jHwDAeGrd+wCrf8C96gbEw1SH/mMSRiU3l0BMs1MyqGXn9W4ZIZOlDywZlj9DS9
 MOPk/76trOsSLKI72OYElg79EQCbMSZJ/46z+GAD/t7DonrSjqtb1DHdcYFq6LfwjsU8S4
 mRNotAxqmtQ4fdofD1K0B+DzBohC2go=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-W96iBOKTOOK6_EgnXSrLnA-1; Tue, 06 Feb 2024 05:43:49 -0500
X-MC-Unique: W96iBOKTOOK6_EgnXSrLnA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6AEB61025622;
 Tue,  6 Feb 2024 10:43:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.195.21])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B94C9492BF0;
 Tue,  6 Feb 2024 10:43:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/12] s390x, tests and misc. patches
Date: Tue,  6 Feb 2024 11:43:35 +0100
Message-ID: <20240206104347.238825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 39a6e4f87e7b75a45b08d6dc8b8b7c2954c87440:

  Merge tag 'pull-qapi-2024-02-03' of https://repo.or.cz/qemu/armbru into staging (2024-02-03 13:31:58 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-02-06

for you to fetch changes up to a1a9800e9721f7a4b0762b97ff8961473870bc54:

  meson: Link with libinotify on FreeBSD (2024-02-06 10:27:50 +0100)

----------------------------------------------------------------
* Emulate CVB, CVBY, CVBG and CVDG s390x instructions
* Fix bug in lsi53c895a reentrancy counter
* Deprecate the "power5+" and "power7+" CPU names
* Fix problems in the freebsd VM test

----------------------------------------------------------------
Ilya Leoshkevich (8):
      target/s390x: Emulate CVDG
      target/s390x: Emulate CVB, CVBY and CVBG
      tests/tcg/s390x: Test CONVERT TO DECIMAL
      tests/tcg/s390x: Test CONVERT TO BINARY
      tests/vm: Set UseDNS=no in the sshd configuration
      tests/vm/freebsd: Reload the sshd configuration
      test-util-filemonitor: Adapt to the FreeBSD inotify rename semantics
      meson: Link with libinotify on FreeBSD

Philippe Mathieu-Daudé (1):
      target/s390x: Prefer fast cpu_env() over slower CPU QOM cast macro

Sven Schnelle (1):
      hw/scsi/lsi53c895a: add missing decrement of reentrancy counter

Thomas Huth (2):
      target/ppc/cpu-models: Rename power5+ and power7+ for new QOM naming rules
      docs/about: Deprecate the old "power5+" and "power7+" CPU names

 docs/about/deprecated.rst          |   9 ++++
 meson.build                        |  23 +++++++--
 target/s390x/helper.h              |   3 ++
 target/s390x/tcg/insn-data.h.inc   |   5 ++
 hw/ppc/spapr_cpu_core.c            |   4 +-
 hw/scsi/lsi53c895a.c               |   1 +
 qom/object.c                       |   4 --
 target/ppc/cpu-models.c            |  10 ++--
 target/s390x/cpu-dump.c            |   3 +-
 target/s390x/gdbstub.c             |   6 +--
 target/s390x/helper.c              |   3 +-
 target/s390x/kvm/kvm.c             |   6 +--
 target/s390x/tcg/excp_helper.c     |  11 ++--
 target/s390x/tcg/int_helper.c      |  97 +++++++++++++++++++++++++++++++++++
 target/s390x/tcg/misc_helper.c     |   4 +-
 target/s390x/tcg/translate.c       |  27 +++++++++-
 tests/tcg/s390x/cvb.c              | 102 +++++++++++++++++++++++++++++++++++++
 tests/tcg/s390x/cvd.c              |  63 +++++++++++++++++++++++
 tests/unit/test-util-filemonitor.c |   8 +++
 tests/tcg/s390x/Makefile.target    |   2 +
 tests/vm/basevm.py                 |   2 +
 tests/vm/freebsd                   |   1 +
 util/meson.build                   |   6 ++-
 23 files changed, 360 insertions(+), 40 deletions(-)
 create mode 100644 tests/tcg/s390x/cvb.c
 create mode 100644 tests/tcg/s390x/cvd.c


