Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D84C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 10:39:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnbIm-0007UL-O5; Thu, 27 Feb 2025 05:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbIj-0007Ti-0t
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnbIg-0003BJ-VI
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 05:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740652768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=zlxVGV3B0mAKC1eYQKBaWnaiqdfQu8xjAw6cbRfHTt8=;
 b=XMh6J3gFkKoiDDUxi1Yofvlz4DkOC7/fTptD0ipZyepSGPrWukUcfLc4eKVq1Y7PdP7GpT
 KwAyepHfmz+jiR6L90Mu9WlsQUBm2Jg2PV6w/9DMF/nqwS/W68Up9zpXWR/jN0lYzgjbvp
 D+PoMgxC6X9P3i7no1J5O3BKgxkp4GA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-88-4xfziyszNtmWCYfTjwMqZg-1; Thu,
 27 Feb 2025 05:39:23 -0500
X-MC-Unique: 4xfziyszNtmWCYfTjwMqZg-1
X-Mimecast-MFC-AGG-ID: 4xfziyszNtmWCYfTjwMqZg_1740652762
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B375180098B; Thu, 27 Feb 2025 10:39:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.33.184])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E236300019E; Thu, 27 Feb 2025 10:39:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/6] Convert the inux_ssh_mips_malta.p avocado test
Date: Thu, 27 Feb 2025 11:39:09 +0100
Message-ID: <20250227103915.19795-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert the linux_ssh_mips_malta.py avocado test to the functional
framework. Since this test was exercising the network via ssh, and
we don't have the ssh commands in the functional framework, we
rather run the commands via the serial console now and use a HTTP
download for testing whether the network works as expected.

While I was working on these patches, I also noticed that one of
the other MIPS malta images featured a TFTP client program, so
I added some network testing there via TFTP now, too.

Thomas Huth (6):
  tests/functional: Move the code for testing HTTP downloads to a common
    function
  tests/functional/test_mips_malta: Add a network test via the pcnet NIC
  tests/functional: Convert the 32-bit big endian Wheezy mips test
  tests/functional: Convert the 32-bit little endian Wheezy mips test
  tests/functional: Convert the 64-bit little endian Wheezy mips test
  tests/functional: Convert the 64-bit big endian Wheezy mips test

 MAINTAINERS                               |   1 -
 tests/avocado/linux_ssh_mips_malta.py     | 205 ----------------------
 tests/functional/meson.build              |   6 +-
 tests/functional/qemu_test/linuxkernel.py |  26 ++-
 tests/functional/test_intel_iommu.py      |  22 +--
 tests/functional/test_mips64_malta.py     |  35 ++++
 tests/functional/test_mips64el_malta.py   |  22 +++
 tests/functional/test_mips_malta.py       | 128 +++++++++++++-
 tests/functional/test_mipsel_malta.py     |  22 +++
 9 files changed, 235 insertions(+), 232 deletions(-)
 delete mode 100644 tests/avocado/linux_ssh_mips_malta.py
 create mode 100755 tests/functional/test_mips64_malta.py

-- 
2.48.1


