Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7538FCAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0sfa-0006zM-9X; Mon, 22 Sep 2025 22:22:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1v0sfV-0006xp-1E
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:22:13 -0400
Received: from mx1.zhaoxin.com ([210.0.225.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <EwanHai-oc@zhaoxin.com>)
 id 1v0sfH-0001Na-Dq
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:22:10 -0400
X-ASG-Debug-ID: 1758594100-086e236d0e00350001-jgbH7p
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by
 mx1.zhaoxin.com with ESMTP id E6701Frv8kQlH2p4 (version=TLSv1.2
 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
 Tue, 23 Sep 2025 10:21:40 +0800 (CST)
X-Barracuda-Envelope-From: EwanHai-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXSHMBX3.zhaoxin.com (10.28.252.165) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.44; Tue, 23 Sep
 2025 10:21:40 +0800
Received: from ZXSHMBX3.zhaoxin.com ([fe80::a428:faf0:c549:abe6]) by
 ZXSHMBX3.zhaoxin.com ([fe80::a428:faf0:c549:abe6%6]) with mapi id
 15.01.2507.044; Tue, 23 Sep 2025 10:21:40 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ewan-server.lan (10.28.24.128) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.59; Tue, 23 Sep
 2025 10:11:33 +0800
From: Ewan Hai <ewanhai-oc@zhaoxin.com>
To: <pbonzini@redhat.com>, <zhao1.liu@intel.com>
CC: <qemu-devel@nongnu.org>
Subject: [PATCH 0/3] target/i386: Add support for Zhaoxin Shijidadao vCPU
 models
Date: Mon, 22 Sep 2025 22:11:30 -0400
X-ASG-Orig-Subj: [PATCH 0/3] target/i386: Add support for Zhaoxin Shijidadao
 vCPU models
Message-ID: <20250923021133.190725-1-ewanhai-oc@zhaoxin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.28.24.128]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Moderation-Data: 9/23/2025 10:21:38 AM
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1758594100
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1556
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.147541
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
Received-SPF: pass client-ip=210.0.225.12; envelope-from=EwanHai-oc@zhaoxin.com;
 helo=mx1.zhaoxin.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patchset introduces cache enumeration and two vCPU models (Client
and Server) for the Zhaoxin "Shijidadao" architecture. With these
additions, QEMU can expose the core identity and features of this
architecture without relying on host-passthrough.

There are several points that may need particular attention from
maintainers:

1. The Shijidadao-Client model uses '.version =3D 1' to represent the
   hardware v1 revision, with 'version=3D2' added to capture v2
   differences. Please check whether this usage aligns with existing
   versioning practices.

2. For both Shijidadao-Client and Shijidadao-Server, the
   "x-force-cpuid-0x1f" feature is placed under the version 1
   definition. At present there is no mechanism to represent this
   feature via `.features[index]` in the default model definition,
   so attaching it to v1 is the only available option. Feedback on
   whether this placement is acceptable would be appreciated.

3. The Shijidadao-Server model enables the 'core-capability' bit by
   default, but KVM does not yet virtualize the corresponding MSR.
   Guidance on whether this setting should remain in the model is
   requested.

Thanks for your time reviewing this series!

Ewan Hai (3):
  target/i386: Add cache model for Zhaoxin Shijidadao vCPUs
  target/i386: Introduce Zhaoxin Shijidadao-Client CPU model
  target/i386: Introduce Zhaoxin Shijidadao-Server CPU model

 target/i386/cpu.c | 385 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 385 insertions(+)

--=20
2.34.1


