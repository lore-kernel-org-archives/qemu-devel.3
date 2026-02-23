Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92ADEEC2AB
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 23:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vufXq-0007ii-TH; Mon, 23 Feb 2026 18:40:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXk-0007Nw-U9
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:50 -0500
Received: from qs-2003h-snip4-10.eps.apple.com ([57.103.86.82]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vufXj-0004TS-EC
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 18:40:48 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPS id
 C8ADC1800169; Mon, 23 Feb 2026 23:40:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1771890046; x=1774482046;
 bh=gtU6O9Cu9XkEyzJz8skz8NQEIEN6lbh5ZiIRw855Hxw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Ipqu5P78rILbNxJrUIZUHvSUyNOlC/LapqreEJc4Itxyxr+ea64tFCIEsnjuB4B6rldOJIKkenIBYAmNiyVt7WLeEyZyEKWiREwLjiMmnBOf2bnYq7Xz7b10BxocbcutQZjycz5FXZwxXajzeVJsJAe7xbVzK0BZ1ThIo/6Qw6Qr/c6AXw5jiZupTVk1BTspis7OFP+vBnS8nkzIRypNhdfi2sQ9n0rLFjY+SZLwy68wcLlFp6FuICI5aw0uryFkpn/Dfz9lPcwQ2PfmEHsI8ED4eLV+HycQv09Jza0yy9HJ18kJR75bfSb6kNrunwI/PBH2/6u+tNmKJeOPURc5Uw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-6 (Postfix) with ESMTPSA id
 CA67F1800149; Mon, 23 Feb 2026 23:40:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v6 26/28] whpx: i386: bump to x2apic
Date: Tue, 24 Feb 2026 00:39:48 +0100
Message-ID: <20260223233950.96076-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260223233950.96076-1-mohamed@unpredictable.fr>
References: <20260223233950.96076-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=MvxfKmae c=1 sm=1 tr=0 ts=699ce57e
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=wF7mTIv5wlbhAN2AGiYA:9
X-Proofpoint-ORIG-GUID: oXDlnru7KDKyZdZxaZ7HFI-gR0-K79c1
X-Proofpoint-GUID: oXDlnru7KDKyZdZxaZ7HFI-gR0-K79c1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDIwNiBTYWx0ZWRfX7QYG10Bv1FiW
 uoWiXzyR+UesclY3g1EZ7iXeZ1YWH6LCOji+XEIvh4sL10LgJv1SbRaSoRv3OGuubsJ2UxbU9h+
 oJmC7WSTIug5YQiXJegpKw7yT9aX+eQNkuzyluSMSpMQ+NGq6RMCxSq3zn8aNA+oM1/6/RgbY1k
 5tuOU2Cki0VFTMHSyeONJJYtz8h1vTdnGx0QPE5A4vNbzp3uXTl5k0g7HU6oyUlC9x6d8e5dIOz
 O/M2xf/11GyTnpSg0qgPoBd+x9fkdooIswq/uXE7ovmmbBxtAd2RQ/3so4IpvbahJwfQsjTQMoR
 RJk+YR9lcie+Su0VSSRdHBVCHpT2xhAhjwDWVNFo8eApG2RffWc+BbsU4iCL9I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_05,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=740 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1030 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602230206
X-JNJ: AAAAAAABj/hE8VD9X4/hzaiJMwTNB9cvs91WOr+pHoponpi/3rZYyQPNxqQmxGOr5wD6j88Nmh4bwE6SOvctaeOEWR0Fl/9iHsmLQ0rZ+c4AOqlgqrL+v5h40hXkHNaLKCbyXfkTHJepxM1ifX+KDUjOLCZd461Zz1z7IOU5IB76VvWzs68Wz1LzNhIsdIlTYDSC9oyCRGSUi9u9vWZFtNka8tmCBFoUCP+WqUKeBZ21BnwTJG4SJ1j9hxzNdptcqVkYeybT74Z5FpiYIiV7E4FL7eRk+GlQibYalRZWzQ617cKjWLUYdZOooCgzAvRP8gj46vuC9CuLeTX6vCo7yYU2Jn6MpdTXzrqtA2ZwfViKeLDMGMWXEBf0heKpKwaMLmAPFCrq+igFLARInolpXEDLhT5P4cLXfmSRDfn6iemnqXM1acZuKh+UipeZ0PyChqsNT8CRfMMAhtUYIDXSWoqxIMonklAKKrYxqMuJ5hH5poTBYhUaLv4VjKwqwGshFfSi9dEqOCSEa3PiHQ2LPCXN2mAmuceZjUf90YEU7zTTHB0dexHyQ2/pgSFBkASv6UV63SSyk9O3x2FxsR27UppEzprRJyfDnEp8lHYOfMES0w1fBPWORjQRVLfjLQeisTogZ2xlx7B9VOWJv7sZ1f0Id8CmPlmJGTm+xHkR8sTiFGX8Faf6emDri122JDex57McwJ1dzggTtMf78iVKaxxlLRISAzJ1w9BwBDvHFw0/kXvmZvaIK0VfKS10c9WKhrxiLdOFkimll3OCgkUgMaEI+dhr
Received-SPF: pass client-ip=57.103.86.82;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 0259782a82..d98619face 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2088,7 +2088,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     if (whpx->kernel_irqchip_allowed && features.LocalApicEmulation &&
         whp_dispatch.WHvSetVirtualProcessorInterruptControllerState2) {
         WHV_X64_LOCAL_APIC_EMULATION_MODE mode =
-            WHvX64LocalApicEmulationModeXApic;
+            WHvX64LocalApicEmulationModeX2Apic;
         hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
             WHvPartitionPropertyCodeLocalApicEmulationMode,
-- 
2.50.1 (Apple Git-155)


