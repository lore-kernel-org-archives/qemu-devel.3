Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326B606A31D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 07:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSUwX-0008Uz-8t; Sun, 15 Nov 2026 02:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwQ-0008TC-Ku; Sun, 15 Nov 2026 02:46:22 -0500
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1xSUwN-0004oE-7i; Sun, 15 Nov 2026 02:46:22 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwBHjeRFY_lqdpowBg--.997S2;
 Sun, 15 Nov 2026 15:46:13 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwFnQ_Y_lqF+j6AA--.34770S3;
 Sun, 15 Nov 2026 15:46:08 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Chao Liu <chao.liu@processmission.com>,
 Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH v6 0/5] tests/qtest: Add memory-access attributes
 (secure/space)
Date: Sun, 15 Nov 2026 15:46:02 +0800
Message-Id: <20261115074607.456045-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwFnQ_Y_lqF+j6AA--.34770S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAABWr4tsgAbgAAsG
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxCr48GFW3Cw1xWF1UGw1UAwb_yoWrAr47pF
 W3A3W3Kr48JF1xJws3Ja10qa45Kan7CF17XFy7tryrurW5CFW7Ary2kryFqr9rGrWkXr1Y
 k34qyFnxWrn8t3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is v6 of the qtest memory-access attributes series. Many thanks to whom
reviewed previous versions and provided feedback.


Changes since v5
----------------

- Move the raw command response helper before the attrs helpers patch.
- Move the generic response assertions and typed failure helpers from the test
  patch into the libqtest attrs helpers patch.
- Check for TCG availability before running either attrs test program,
  and return early when TCG is unavailable.

This series is also available in a branch below:
https://gitlab.com/TaoTang/qemu/-/tree/series/qtest-secure-v6

The CI passed with warnings from two jobs, which also occured in upstream CI.
https://gitlab.com/TaoTang/qemu/-/pipelines/3065518609



Motivation
----------

IOMMU functional testing is always stack-heavy: for example, even for the
Non-secure Arm SMMU model, end-to-end validation can require a fairly involved
software stack. To keep the testing loop tight and reproducible, I previously
proposed using iommu-testdev + QTest to validate IOMMU/SMMU behaviour without
booting a guest [1].

[1] https://www.qemu.org/docs/master/specs/iommu-testdev.html

However, the current QTest interface cannot tag memory accesses with MemTxAttrs,
so it is hard to write targeted tests for security-sensitive paths. This becomes
a bigger issue for Secure SMMU work [2], and for future Arm
RME-DA enablement.

[2] https://lore.kernel.org/qemu-devel/20261114154623.3599750-1-tangtao1634@phytium.com.cn/

This series therefore extends qtest memory access commands with an optional
attrs argument, adds matching libqtest helpers, and introduces tests that
exercise the new APIs against address spaces that actually differ by security
context.

In particular:
- on Arm virt,secure=on, the test now uses the secure-only RAM window so the
  requested attrs must select the correct AddressSpace
- on x86 q35,smm=on, the API series covers normal RAM, and an extra NOT-MERGE
  validation patch adds an SMM-only RAM window so the secure path can be
  cross-checked against a location not visible from the default address space


Compatibility
-------------

This series is additive for existing qtest users:
- Existing qtest memory commands keep their current forms; attrs is an optional
  extra argument
- Existing libqtest memory helpers remain available and are kept as wrappers
  passing NULL attrs
- The first 4 patches are the upstreamable API and test additions
- The 5th patch is explicitly marked NOT-MERGE and only provides extra x86
  RFC coverage by wiring in a q35 test-only SMM RAM window

One behavioural improvement is that memory access failures on the new paths are
now reported consistently as ERR, which lets tests validate address-space
selection failures directly.


Testing
-------

The API series was exercised with:

  meson test -C build \
      "qtest-aarch64/qtest-attrs-test" \
      "qtest-i386/qtest-attrs-test" \
      "qtest-x86_64/qtest-attrs-test"

The extra x86 cross-check from the NOT-MERGE patch was exercised with:

  meson test -C build \
      "qtest-i386/qtest-x86-attrs-test" \
      "qtest-x86_64/qtest-x86-attrs-test"


Tao Tang (5):
  tests/qtest: Add attrs support to qtest server memory commands
  tests/qtest: Add raw command response helper
  tests/qtest: Add libqtest attrs helpers for memory accesses
  tests/qtest: Add qtest-attrs-test for memory access attrs
  [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs coverage

 include/hw/pci-host/q35.h          |   8 +
 tests/qtest/libqtest-single.h      | 156 +++++++++++
 tests/qtest/libqtest.h             | 288 +++++++++++++++++++++
 hw/pci-host/q35.c                  |  27 ++
 system/qtest.c                     | 349 +++++++++++++++++++++----
 tests/qtest/libqtest.c             | 402 +++++++++++++++++++++++++----
 tests/qtest/qtest-attrs-test.c     | 310 ++++++++++++++++++++++
 tests/qtest/qtest-x86-attrs-test.c | 175 +++++++++++++
 tests/qtest/meson.build            |   8 +-
 9 files changed, 1610 insertions(+), 113 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

--
2.34.1


