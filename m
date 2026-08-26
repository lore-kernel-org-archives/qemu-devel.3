Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E5BC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz9Jh-000824-0K; Wed, 26 Aug 2026 04:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ewanhai-oc@zhaoxin.com>)
 id 1wz9Je-00080w-PV
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ewanhai-oc@zhaoxin.com>) id 1wz9Jc-0001ZS-6b
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 04:49:02 -0400
Received: from zhaoxin.com (unknown [127.0.0.1])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGQ6ctnzcYn0f;
 Wed, 26 Aug 2026 16:48:46 +0800 (CST)
Received: from zhaoxin.com (unknown [10.28.208.166])
 by mx1.zhaoxin.com (MTA) with ESMTP id 4hVJGN4DhmzcYn0T;
 Wed, 26 Aug 2026 16:48:44 +0800 (CST)
Received: from ewan-server.tailb932da.ts.net (ewan-server.tailb932da.ts.net
 [10.28.24.2])
 by zhaoxin.com (8.30) with ESMTP81748e551c3e50a3418ed4d1898850d3
 Wed, 26 Aug 2026 16:48:43 +0800
X-Eyou-Smtpauth: ewanhai-oc@zhaoxin.com
X-Eyou-EnvelopeSender: ewanhai-oc@zhaoxin.com
X-Eyou-From: Ewan Hai <ewanhai-oc@zhaoxin.com>
From: "=?UTF-8?B?RXdhbiBIYWktb2M=?=" <ewanhai-oc@zhaoxin.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, Ewan Hai <ewanhai-oc@zhaoxin.com>
Subject: [PATCH v4 0/4] target/i386: Add Zhaoxin Shijidadao CPU model
Date: Wed, 26 Aug 2026 16:48:34 +0800
Message-Id: <20260826084838.2107629-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Eyou-Sender: <ewanhai-oc@zhaoxin.com>
Received-SPF: pass client-ip=210.0.225.12; envelope-from=ewanhai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FROM_EXCESS_BASE64=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add CPU models for the Zhaoxin Shijidadao server (v1) and client (v2),
including their cache topology.  The matching KVM support for SM2, CCS,
RNG2, PHE2 and RSA is queued in the KVM next branch.

The series also adds YongFeng-v4 with the same five feature pairs.

TCG does not currently implement these instructions.  TCG_EXT4_FEATURES
remains zero, so QEMU filters the new bits from realized TCG CPUs.

The Shijidadao models expose CPUID leaf 0x1f.  A related fix for invalid
subleaf handling under TCG is available here:
https://lore.kernel.org/qemu-devel/20260609090046.2376016-1-ewanhai-oc@zhaoxin.com/

Changes since v3:
- Rebased to the 11.2 development tree.
- Added QEMU definitions for the five feature pairs now available
  through KVM.
- Enabled the new CPUID 0xC0000001 EDX feature pairs in the Shijidadao
  models and adjusted the server and client feature sets to match their
  respective silicon.
- Added YongFeng-v4 with the same feature set.

v3:
https://lore.kernel.org/all/20260109021028.83985-1-ewanhai-oc@zhaoxin.com/

KVM feature series:
https://lore.kernel.org/all/20260610023512.3690734-1-ewanhai-oc@zhaoxin.com/

Ewan Hai (4):
  target/i386: Add cache model for Zhaoxin Shijidadao vCPUs
  target/i386: Add Zhaoxin cryptographic CPUID features
  target/i386: Introduce Zhaoxin Shijidadao CPU model
  target/i386: Enable new cryptographic features in YongFeng-v4

 target/i386/cpu.c | 284 ++++++++++++++++++++++++++++++++++++++++++++--
 target/i386/cpu.h |  20 ++++
 2 files changed, 295 insertions(+), 9 deletions(-)

-- 
2.34.1


