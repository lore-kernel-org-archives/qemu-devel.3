Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAC2FF60C4
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 04:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7QOQ-00010H-W2; Tue, 31 Mar 2026 00:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QOL-0000zS-4x; Tue, 31 Mar 2026 00:07:49 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w7QOI-0002FB-2w; Tue, 31 Mar 2026 00:07:48 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwD38Y2FSMtpPYjBCA--.61S2;
 Tue, 31 Mar 2026 12:07:33 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwSJR6SMtpYqQHAA--.18366S3;
 Tue, 31 Mar 2026 12:07:22 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [PATCH 0/4] tests/qtest: Add memory-access attributes (secure/space)
Date: Tue, 31 Mar 2026 12:06:55 +0800
Message-Id: <20260331040659.401397-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DwSJR6SMtpYqQHAA--.18366S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWnJfH8GCQABsj
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZw17ZF18tFy8tw45Ww4xCrg_yoWrWFWkpF
 W3Aa43Kr48JF17Jw4fGa18XFy5Ka97GF17XFy7tr15uFWYyFW7Xry29ryFqr9xGrW8Xr1Y
 93WDtFn8Wwn8t3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=-1,
 RCVD_IN_MSPIKE_WL=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
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

This is v4 of the qtest attrs support series. The main changes from v3 are
improvements to error handling validation and negative-case coverage.

Thanks to everyone who reviewed the previous version and provided valuable
feedback.

This series is also available in a branch below:
https://gitlab.com/TaoTang/qemu/-/commits/series/qtest-secure-api-v4-2

CI is all green:
https://gitlab.com/TaoTang/qemu/-/pipelines/2418450703

The remainder of this cover letter is unchanged from the previous version.

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
a bigger issue for Secure SMMU work, which is RFCing in [2], and for future Arm
RME-DA enablement.

[2] https://lore.kernel.org/qemu-devel/20260221100250.2976287-1-tangtao1634@phytium.com.cn/

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
- The first three patches are the upstreamable API and test additions
- The fourth patch is explicitly marked NOT-MERGE and only provides extra x86
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


Future work
-----------

Once the Secure SMMU series lands, I plan to build on this qtest API to extend
iommu-testdev-based tests to cover more security contexts while still avoiding
a full guest software stack.


Tao Tang (4):
  tests/qtest: Add attrs support to qtest server memory commands
  tests/qtest: Add libqtest attrs helpers for memory accesses
  tests/qtest: Add qtest-attrs-test for memory access attrs
  [NOT-MERGE] tests/qtest: add q35 SMM-only x86 attrs coverage

 hw/pci-host/q35.c                  |  26 ++
 include/hw/pci-host/q35.h          |   8 +
 system/qtest.c                     | 420 +++++++++++++++++++++++++----
 tests/qtest/libqtest-single.h      | 156 +++++++++++
 tests/qtest/libqtest.c             | 246 +++++++++++++----
 tests/qtest/libqtest.h             | 177 ++++++++++++
 tests/qtest/meson.build            |   8 +-
 tests/qtest/qtest-attrs-test.c     | 350 ++++++++++++++++++++++++
 tests/qtest/qtest-x86-attrs-test.c | 170 ++++++++++++
 9 files changed, 1452 insertions(+), 109 deletions(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c
 create mode 100644 tests/qtest/qtest-x86-attrs-test.c

-- 
2.34.1


