Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA12C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 19:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdbH2-0007rE-8F; Fri, 23 Feb 2024 14:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdaw7-0005ls-3G
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rdavz-0005AX-IR
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 14:10:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708715409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sgm+HM9BVkTRT49ENMfGGk+hx49sqTHuHj8Y05J2TdE=;
 b=JSbHqa/gr7H62rQMyiFwgBm5nvR/qbzY4mFh4xjy8D3QZ9TeqcN2cMi1HPFke55Rccy1fS
 cStVxv76ao+KV6qDmL2n4jMQpUghM/GTAqVF5RJaWdE38INSz547SucSrEs8ohZwhywOIg
 9hQXQlqC6mW4g12sFDZ7JcJ1e7wwV0g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-202-0tSzlzmMM0CVxOcN-m0dPg-1; Fri, 23 Feb 2024 14:10:05 -0500
X-MC-Unique: 0tSzlzmMM0CVxOcN-m0dPg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71D6188CDCC;
 Fri, 23 Feb 2024 19:10:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE558CED;
 Fri, 23 Feb 2024 19:10:04 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/11] Test and misc patches
Date: Fri, 23 Feb 2024 20:09:52 +0100
Message-ID: <20240223191003.6268-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

 Hi Peter!

The following changes since commit 3d54cbf269d63ff1d500b35b2bcf4565ff8ad485:

  Merge tag 'hw-misc-20240222' of https://github.com/philmd/qemu into staging (2024-02-22 15:44:29 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-02-23

for you to fetch changes up to 028ade14da9eb31a8c5dde48dd5b140e49888908:

  target/i386: do not filter processor tracing features except on KVM (2024-02-23 08:13:52 +0100)

----------------------------------------------------------------
* m68k: Fix exception frame format for 68010
* Add cdrom test for LoongArch virt machine
* Fix qtests when using --without-default-devices
* Enable -Wvla
* Windows 32-bit removal
* Silence warnings in the test-x86-cpuid-compat qtest

----------------------------------------------------------------
Bibo Mao (1):
      tests/cdrom-test: Add cdrom test for LoongArch virt machine

Daniel Palmer (1):
      target/m68k: Fix exception frame format for 68010

Marc-André Lureau (1):
      tests: skip dbus-display tests that need a console

Paolo Bonzini (1):
      target/i386: do not filter processor tracing features except on KVM

Peter Maydell (4):
      meson: Enable -Wvla
      docs: Document that 32-bit Windows is unsupported
      .gitlab-ci.d: Drop cross-win32-system job
      .gitlab-ci.d/windows.yml: Remove shared-msys2 abstraction

Thomas Huth (3):
      tests/qtest: Fix boot-serial-test when using --without-default-devices
      target/ppc/kvm: Replace variable length array in kvmppc_save_htab()
      target/ppc/kvm: Replace variable length array in kvmppc_read_hptes()

 docs/about/build-platforms.rst                     |   2 +
 docs/about/removed-features.rst                    |  15 +++
 meson.build                                        |   1 +
 target/m68k/cpu.h                                  |   2 +
 target/i386/cpu.c                                  |  11 +-
 target/m68k/cpu.c                                  |   4 +-
 target/m68k/op_helper.c                            |   4 +-
 target/ppc/kvm.c                                   |   6 +-
 tests/qtest/boot-serial-test.c                     |   2 +-
 tests/qtest/cdrom-test.c                           |   5 +
 tests/qtest/dbus-display-test.c                    |  16 ++-
 .gitlab-ci.d/container-cross.yml                   |   5 -
 .gitlab-ci.d/crossbuilds.yml                       |  14 ---
 .gitlab-ci.d/windows.yml                           |  85 ++++++++--------
 tests/docker/dockerfiles/fedora-win32-cross.docker | 111 ---------------------
 tests/lcitool/refresh                              |   5 -
 16 files changed, 99 insertions(+), 189 deletions(-)
 delete mode 100644 tests/docker/dockerfiles/fedora-win32-cross.docker


