Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FE2C624D2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 08:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vu4mr-0000ym-5q; Sun, 22 Feb 2026 03:25:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vu4mn-0000y1-Bn; Sun, 22 Feb 2026 03:25:54 -0500
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vu4mj-0005aA-Tc; Sun, 22 Feb 2026 03:25:53 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBXcqiFvZppKUBbBw--.8309S2;
 Sun, 22 Feb 2026 16:25:41 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwB3z+x9vZpp+HAcAA--.49763S3;
 Sun, 22 Feb 2026 16:25:34 +0800 (CST)
From: Tao Tang <tangtao1634@phytium.com.cn>
To: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tao Tang <tangtao1634@phytium.com.cn>
Subject: [RFC 0/2] tests/qtest: Add memory-access attributes (secure/space)
Date: Sun, 22 Feb 2026 16:25:27 +0800
Message-Id: <20260222082529.491384-1-tangtao1634@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwB3z+x9vZpp+HAcAA--.49763S3
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQANBWmYzyUAVwABsE
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxGF17Xr1kKr13CFyUur48Zwb_yoW5ZFWUpF
 Zxu3ZxKr48CFy7JryfJF4kWFy5KFZ3A3ZrJr9rtw18uF4YyFy8Xr1I9F1Fqr9xA3y8Xrn8
 Cw1Dtrs8Wwn8trJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi all,

This 2-patch series extends the qtest protocol/libqtest memory-access commands
so QTests can drive memory transactions with selected MemTxAttrs. In particular,
it adds support for:

- MemTxAttrs.secure (Available on Arm/x86)
- MemTxAttrs.space  (Arm security space selector)

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
a bigger issue for Secure SMMU work, which is RFCing in [2] and for future Arm
RME-DA enablement.

[2] https://lore.kernel.org/qemu-devel/20260221100250.2976287-1-tangtao1634@phytium.com.cn/

This series therefore adds qtest protocol/libqtest helpers to drive memory
transactions with:

- MemTxAttrs.secure via *_secure commands (Arm + x86)
- MemTxAttrs.space via *_space commands (Arm-only)

and introduces qtest-attrs-test to validate the new APIs on Arm virt
(Secure/NonSecure/Root/Realm spaces) and on x86 pc (SMM AddressSpace).


Compatibility
-------------

This series is strictly additive:
- Existing qtest protocol commands remain unchanged.
- The new *_secure / *_space commands are optional extensions.
- The implementation is confined to qtest.c + libqtest, plus the new test case.

Testing
-------

The new qtest-attrs-test is registered for both x86 and aarch64 qtest lists.
# test secure/space attributes on Arm
QTEST_QEMU_BINARY=build/qemu-system-aarch64 ./build/tests/qtest/qtest-attrs-test
# test secure attribute on x86
QTEST_QEMU_BINARY=build/qemu-system-x86_64 ./build/tests/qtest/qtest-attrs-test

CI is all green [3]:
[3] https://gitlab.com/TaoTang/qemu/-/pipelines/2341872040


Future work
-----------

Once the Secure SMMU series lands, I plan to build on this qtest API to extend
iommu-testdev-based tests to cover more security contexts (Secure state and,
later, RME-DA-related paths) while still avoiding a full guest software stack.
The branch below [4] demonstrates a modified iommu-testdev using the new
secure/space qtest interfaces to exercise Secure SMMU behaviour.

[4] https://github.com/hnusdr/qemu/commits/qtest-arm-secure-api

Tao Tang (2):
  tests/qtest: Support for memory access with secure/space attr
  tests/qtest: Add qtest-attrs-test to verify memory access with attr

 system/qtest.c                 | 482 ++++++++++++++++++++++++
 tests/qtest/libqtest-single.h  | 133 +++++++
 tests/qtest/libqtest.c         | 249 ++++++++++++
 tests/qtest/libqtest.h         | 281 ++++++++++++++
 tests/qtest/meson.build        |   4 +-
 tests/qtest/qtest-attrs-test.c | 669 +++++++++++++++++++++++++++++++++
 6 files changed, 1817 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/qtest-attrs-test.c

-- 
2.34.1


