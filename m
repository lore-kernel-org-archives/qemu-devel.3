Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0372D2F037
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 14:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkk2P-0006AY-Ib; Tue, 27 Jan 2026 09:27:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2M-00069e-FV
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vkk2J-0003YN-KW
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 09:27:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769524038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GI+uRVxKxK+s/OhIk1x0m/UQk/QaSTjOYSUMe6PKpYI=;
 b=FU2wh/AgI0sgUaXZAUW9elF2xJUfdJwaLl7jJV60BTRgFJlB/OsydrSwnEEm1RV/XTchOl
 a/rh20WWX95Z/ZhqBAnvGuHylxKDWDZb0QWediBJUes21oTlRP2MhVzJQlM/kyPRePMNA9
 8mHxnb24basT1h0mkkQ9Q3iiwivsT70=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-CecQOpuiNYacYZhSoX3Fog-1; Tue,
 27 Jan 2026 09:27:14 -0500
X-MC-Unique: CecQOpuiNYacYZhSoX3Fog-1
X-Mimecast-MFC-AGG-ID: CecQOpuiNYacYZhSoX3Fog_1769524033
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 973771955D84; Tue, 27 Jan 2026 14:27:13 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.209])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B568180049F; Tue, 27 Jan 2026 14:27:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/9] tests patches
Date: Tue, 27 Jan 2026 15:27:01 +0100
Message-ID: <20260127142710.131904-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

 Hi Richard!

The following changes since commit f26976b9d30496d28bd4fd045f4300706e567a29:

  Merge tag 'pull-vfio-20260126' of https://github.com/legoater/qemu into staging (2026-01-27 07:14:11 +1100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2026-01-27

for you to fetch changes up to 161ea5a63413dd5efc07205483c1070a6e859785:

  tests/functional: Enforce sha256 as hashsum algorithm for all tests (2026-01-27 15:20:43 +0100)

----------------------------------------------------------------
* gitlab: preserve base rules for container template
* Fix some issues to make QEMU compilable on non-mainstream distros again
* Enforce sha256 as hashsum algorithm for all functional tests

----------------------------------------------------------------
Daniel P. Berrangé (1):
      gitlab: preserve base rules for container template

Thomas Huth (8):
      tests/functional/riscv64: Silence warnings from Pylint in the boston test
      tests/functional/x86_64: Limit the memlock test to Linux hosts
      tests/functional/x86_64: Use the right Python interpreter & fix format string
      tests/tracetool: Honor the Python interpreter that "configure" detected
      pc-bios/optionrom: Use 32-bit linker emulation for the optionroms
      tests/vm: Update netbsd VM to version 10.1
      tests/vm: Make the haiku VM usable again
      tests/functional: Enforce sha256 as hashsum algorithm for all tests

 configure                                   |  8 +++++++-
 .gitlab-ci.d/container-template.yml         |  5 ++---
 pc-bios/optionrom/Makefile                  |  2 +-
 scripts/qemu-plugin-symbols.py              |  0
 tests/functional/ppc64/test_fadump.py       |  4 +---
 tests/functional/qemu_test/__init__.py      |  4 ++--
 tests/functional/qemu_test/asset.py         |  4 +---
 tests/functional/qemu_test/decorators.py    | 12 ++++++++++++
 tests/functional/riscv64/test_boston.py     | 11 +++++++----
 tests/functional/x86_64/test_bad_vmstate.py |  6 ++++--
 tests/functional/x86_64/test_memlock.py     |  3 ++-
 tests/tracetool/tracetool-test.py           |  3 ++-
 tests/vm/haiku.x86_64                       |  4 ++++
 tests/vm/netbsd                             | 16 ++++++++--------
 14 files changed, 53 insertions(+), 29 deletions(-)
 mode change 100755 => 100644 scripts/qemu-plugin-symbols.py


