Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC57D232CF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 02:15:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve21D-0000wI-H3; Thu, 08 Jan 2026 21:14:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve21B-0000vv-E3
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:25 -0500
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1ve218-0002MV-KB
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 21:14:25 -0500
X-ASG-Debug-ID: 1767924847-086e2306f90c580001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id uFStxy4tdE9ABJ8p (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Fri, 09 Jan 2026 10:14:07 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX1.zhaoxin.com (10.28.252.163) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:14:07 +0800
Received: from ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85]) by
 ZXSHMBX1.zhaoxin.com ([fe80::936:f2f9:9efa:3c85%7]) with mapi id
 15.01.2507.059; Fri, 9 Jan 2026 10:14:07 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.zhaoxin.com (10.28.44.15) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Fri, 9 Jan
 2026 10:10:28 +0800
Received: by ewan-server.zhaoxin.com (Postfix, from userid 1000)
 id 1791B2D0005A; Thu,  8 Jan 2026 21:10:28 -0500 (EST)
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>, <ewanhai@zhaoxin.com>, <cobechen@zhaoxin.com>
Subject: [PATCH v3 0/3] target/i386: Add support for Zhaoxin Shijidadao vCPU
 model
Date: Thu, 8 Jan 2026 21:10:25 -0500
X-ASG-Orig-Subj: [PATCH v3 0/3] target/i386: Add support for Zhaoxin
 Shijidadao vCPU model
Message-ID: <20260109021028.83985-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.44.15]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 1/9/2026 10:14:06 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1767924847
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://mx2.zhaoxin.com:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1642
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.152763
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This patchset introduces cache enumeration and a vCPU model for the
Zhaoxin "Shijidadao" architecture. The model provides two variants via
version aliases: Shijidadao-Server (v1) and Shijidadao-Client (v2).
With these additions, QEMU can expose the core identity and features
of this architecture without relying on host-passthrough.

---

Changes Since v1:
- Incorporated Zhao Liu's suggested patch that introduces the cpuid_0x1f op=
tion.
- Dropped explicit x-force-cpuid-0x1f property declarations from both
Shijidadao-Server and Shijidadao-Client models, since the new option provid=
es
a cleaner solution.
- Updated commit messages for the Client and Server patches to remove
references to the earlier x-force-cpuid-0x1f approach.

Changes Since v2:
- Removed Zhao Liu's cpuid_0x1f patch from this series, as it has been
  merged into mainline (commit 3d4978).
- Consolidated Shijidadao-Client and Shijidadao-Server into a single CPU
  model, differentiating them via version numbers and aliases.
- Dropped the original Client v1 model, as it represents an early silicon
  revision rather than the final production version.
- Updated the missing feature comment for FEAT_C000_0001_EDX to explicitly
  list individual features instead of using a generic TODO message.

---

Ewan Hai (3):
  target/i386: Add cache model for Zhaoxin Shijidadao vCPUs
  target/i386: Introduce Zhaoxin Shijidadao CPU model
  target/i386: Fix FEAT_C000_0001_EDX comment in Yongfeng model

 target/i386/cpu.c | 252 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 250 insertions(+), 2 deletions(-)

--=20
2.34.1


