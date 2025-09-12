Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1512CCAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 18:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux8PV-0004UV-9S; Fri, 12 Sep 2025 14:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8PU-0004UF-3x
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ux8PR-0005Ec-KO
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 14:22:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757701326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tlWSm+cBftCKIlPDz0tzvUuiAaoXPfIS4YzKA5xycXE=;
 b=h9iqffLSSLTCdcp5c538SAW7tIwFNKxpJUt0ff2fcLjezESuRCy4ZrOPWLtaKnR5jrLJ/4
 mi92uIHQQH/h45J3av0PhUN+jL3TSwVBfN9pCkZnii0o59Kgszm6UlfD2DawfA5NtdoAdE
 JQb7K99fQ9IWJbtZpFF6DVNeziyzdSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-FNKR1em4PbWBwKZOemNlFw-1; Fri,
 12 Sep 2025 14:22:05 -0400
X-MC-Unique: FNKR1em4PbWBwKZOemNlFw-1
X-Mimecast-MFC-AGG-ID: FNKR1em4PbWBwKZOemNlFw_1757701324
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DA21800562
 for <qemu-devel@nongnu.org>; Fri, 12 Sep 2025 18:22:04 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.154])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95B221800446; Fri, 12 Sep 2025 18:22:02 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/6] tests/functional: remove last use of avocado.utils
Date: Fri, 12 Sep 2025 19:21:54 +0100
Message-ID: <20250912182200.643909-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This simply imports the GDB code from avocado.utils to the QEMU
functional test suite, and drops the other redundant avocado
usage.

Daniel P. Berrangé (6):
  tests/functional: import GDB remote code from avocado
  tests/functional: convert reverse debug test to local gdb module
  tests/functional: replace avocado process with subprocess
  tests/functional: drop datadrainer class in reverse debugging
  tests/functional: close GDB socket in reverse debugging test
  tests/functional: use self.log for all logging

 tests/functional/aarch64/test_virt.py      |   4 +-
 tests/functional/arm/test_integratorcp.py  |   3 +-
 tests/functional/mips64el/test_malta.py    |   3 +-
 tests/functional/qemu_test/gdb.py          | 237 ++++++
 tests/functional/qemu_test/gdbmi_parser.py | 419 ++++++++++
 tests/functional/qemu_test/spark.py        | 850 +++++++++++++++++++++
 tests/functional/replay_kernel.py          |  16 +-
 tests/functional/reverse_debugging.py      |  59 +-
 tests/functional/x86_64/test_acpi_bits.py  |  31 +-
 9 files changed, 1557 insertions(+), 65 deletions(-)
 create mode 100644 tests/functional/qemu_test/gdb.py
 create mode 100644 tests/functional/qemu_test/gdbmi_parser.py
 create mode 100644 tests/functional/qemu_test/spark.py

-- 
2.50.1


