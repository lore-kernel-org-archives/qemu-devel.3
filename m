Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C17FEF99C98
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2026 22:37:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEEFA-0006uu-JM; Sat, 18 Apr 2026 18:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEq-0006O5-Mw
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:10 -0400
Received: from p-east2-cluster3-host12-snip4-10.eps.apple.com ([57.103.77.191]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEEEl-0004yR-BI
 for qemu-devel@nongnu.org; Sat, 18 Apr 2026 18:34:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 C8DFF18000E2; Sat, 18 Apr 2026 22:33:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776551642; x=1779143642;
 bh=IShay1Ni0PZxOVHY3UdoELgY8h3uyJIPv2UhTb9vE4s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=foPkY30M5cRhZRT3cILXj41N+1Vm/Zvuyvs14almptyG/6EsH2/C+K1RvojkWLcCkTg0WZK79i/5PBfYtan7Gb6cTwHnHss6G9dhm+wzf4af3doPl9pNB6UtmHuFv4PhIfk+XJr8mNlaHzQWXO502rsI8tr0ze9CwU6WxDmHoJPj9Ix4aoBuQ9FuiGHeGK9BhGY00Rb1AHEKY/7v87pXw4UUBk4E99j9WsKho3OsQAQanlVMK8/zxfLs13UbLA/CBmqtR8zlYboZqs+VP9OfIJjLB5F71ffhIMFJ1hfZZnRAVIHF7vyjMRuTvrIKa0KEgz7/+TnLnpaokcLW8X8NWw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 412F718000B2; Sat, 18 Apr 2026 22:33:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 18/38] whpx: i386: enable GuestIdleReg enlightenment
Date: Sun, 19 Apr 2026 00:33:00 +0200
Message-ID: <20260418223320.51330-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260418223320.51330-1-mohamed@unpredictable.fr>
References: <20260418223320.51330-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lr3D4EwNRaeDvwZp3yMyj5heHmSQJdV1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDIyOCBTYWx0ZWRfX6HMIG+Zo+/Rt
 qolfK9F1dh8duRHZDDYWhhkLZYfjsNzelLopF9fEONrXJL92qPP/O/PTpzeIySciuNhQi10TD5c
 hEuSVZFObhP0vi6egBkGana2iyxsgVLWl+V6j4ZZAJKwRy90TWPKLLw//kEbNAAfr2FRLZfDUnR
 4mrnBmeZ/9ixgcbb6Ox2KtrvuqwayoqUYL8+KIFjWBWId/cdpExK0YWdLwcoRvsu/VN7F4oI7KJ
 Fm2tiMCdqvhXysRB57la4peX4N+I9InNGS2OMJEtCoiyUlj9JtM/QuxQRdKu0FB0Y9KfKgocex/
 iWiG7EXJwam+g+OEMFM1XoQFpGqPMOVJ6QjeQqNsGr00a4h/vrBkt/js+FH7/w=
X-Proofpoint-GUID: lr3D4EwNRaeDvwZp3yMyj5heHmSQJdV1
X-Authority-Info-Out: v=2.4 cv=W9M1lBWk c=1 sm=1 tr=0 ts=69e406d8
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=givlr1pFTcEyfNb0yRoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_06,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0 mlxlogscore=981 lowpriorityscore=0 clxscore=1030 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604180228
Received-SPF: pass client-ip=57.103.77.191;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This corresponds to HV_X64_MSR_GUEST_IDLE (0x400000f0).

This enlightenment is only available by the HV when using the Hyper-V LAPIC.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 550f30d50a..f856022a87 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2686,6 +2686,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
         synthetic_features.Bank0.SyntheticClusterIpi = 1;
         synthetic_features.Bank0.DirectSyntheticTimers = 1;
+        synthetic_features.Bank0.AccessGuestIdleReg = 1;
         /*
          * These technically work without the Hyper-V LAPIC
          * but behave oddly for multi-core VMs.
-- 
2.50.1 (Apple Git-155)


