Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CB26EDEBF0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 20:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxWik-0000Lg-4x; Tue, 03 Mar 2026 15:51:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWiZ-00089F-5X
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:47 -0500
Received: from p-east2-cluster4-host1-snip4-10.eps.apple.com ([57.103.78.161]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxWiX-0001Ua-D5
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 15:51:46 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 D7C1318000B8; Tue,  3 Mar 2026 20:51:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772571103; x=1775163103;
 bh=25pphdz4PKI1AC686m29Kqm3uc0MNN7Lr2qTWL/hZkU=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=BBvPP5fgwp3BKnZHXYma/rhi335m/1WTxdeq7fmAJg1roIsMY7kxKarAYyndbzRjNOgB2qCDkP61uKZPDeKVgd10i1XaCOCzydzOLap3bWGqasUo8pMsmCTNCm8/gv1w0dmHj5/CssaWPYq36c8DsjXYu6S7T1eEqbFH4eIFGemwA10y1Iv8MMBkj3MHAZ+y8pcFk2E2ax+eytg1yjkfauDqGkqyfv4pozUtu5C56zTRUTn0gy9LntAVYgJIoeEXidixMPCU4/zKIpQHlVSv5X8BvBxBdBB11tMizc0uQaIF7+dp0cL36yrEQs0RX0Fl7IvI3iDRMk4sTnH5RUxtWg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 1AAD91802BC6; Tue,  3 Mar 2026 20:51:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v4 0/7] whpx: i386: small random fixes
Date: Tue,  3 Mar 2026 21:51:31 +0100
Message-ID: <20260303205138.32450-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ZN3aWH7b c=1 sm=1 tr=0 ts=69a749df
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=2hR40MzdYebMGYd4gb8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: desl4BBv_G44RUXc9Zc_tMkgM2jB1Sq3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDE3MSBTYWx0ZWRfX3gnmdGcnn+mn
 +pNnRsP3AnmPYDdwPybAdWn1yR5x53H/dYEt7RPGns+qc4Xbog5joqiAr8VSRb+jsT/khSb3vaH
 dmkhREYkA5RYBdhxupcDZS57zDwIpL3vSS9384hlAHuUx8oG0sglDNsnbllXKpAbHS9cJXc7WwC
 BSkbIB49GxWW9JD7mKF4nllf7oKfuagsj/KXM03sIvjNl7VAzP8FkMIWsWpuMFaiNESjcDMvBRd
 XfrJ4by3GFmbS2iT5o7p34f2f2TP0ObWAaCqtggfv4gpPfqhaA7S5EOqfKzZk6ceoeupStXu0/V
 WKPKRngkrYOi8YNMkwf6Jr2/JdHj5VGTtpNFPwBjAeIDrHfJW1eCRJNkLvwRvA=
X-Proofpoint-ORIG-GUID: desl4BBv_G44RUXc9Zc_tMkgM2jB1Sq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-03_03,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=755
 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030171
X-JNJ: AAAAAAABLEWlvdegV0GkjnvIIDyy4+x8mn7LJG66NZHbFVJstWsPf8GK3kIrFk09YaiQYwVoZrRfZgnxFEx16devQP8iIVUQCZwYgQVBUFrEVB08u+Im3yyWMHht8dnWhiiUJBQXCUtOkUw9RosCH0OBazAmjTUAhQfYEow4rk9U4eegKmJT0DyeapqbW0XmP6oMLtstHeTXNIiDJTEJVsqIVXh804GGiIXMEfSjkMpA9JULyNYXyqjoSDOOyS46d9NQ7HBz5PzkGPXe3xCZzGeItuKUmiYSqtzItbNdRm9i1CYgH9Iay27t7P4Ygv+Rn3a6S5iypeY+0eHDlv7cb/GcmPJxqGb8mQzyhsqPjOTeJlGnMuLSenFDcM340s0ENltvOvw/RnL2kAFIfINI6vcyhuoEc4DSWlH6ZjHNCkaiV4XqGT2ZnmSqydn7wUPct9lZAZozo/FA41zNyPu8pOTncCfnWWED/npHPxemqLqDelHCRZXzyxfyHsN+DQkZL5m5YHZGsOw/o/43dqBJmKFv/zV9LVGshrtV1bXRgojGHOSJDKmhYndv6E4yVuUUyZ/iDd95NZjAHC6AO0wCcIqj4i8uNqPiLmhgIbo802q2pmRVce2AfF5F70jnKzBSkaFiPTRub3OfsyMLvaD6Z6jwlbtjV66anKwd7+y0an8JCHMAdl8KkyP7ryZSoj/9KuWhnG2ZUrlA0vqlgTpvArz/aqbBcq4/hPmHxBSFPlrxb0irb/8LS7HC
Received-SPF: pass client-ip=57.103.78.161;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
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

Also has a small arm64 patch for enabling Hyper-V enlightenments if asked
for, which depends on another (common code) patch in the series

v4:
- Removed two patches that I didn't intend to be merged at this point yet...

v3:

- Added HVF build fix from Pierrick Bouvier (oops... forgot to have it copied over from the test machine earlier...)
- Also added a fix for "whpx: make enlightenments configurable" highlighted with an error from GCC. Clang did not catch this...

Mohamed Mediouni (6):
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments
  whpx: make Hyper-V enlightenments configurable
  whpx: arm64: enable enlightenments if asked for
  whpx: i386: remove SIPI trapping

Pierrick Bouvier (1):
  target/i386/hvf/hvf.c: fix compilation

 accel/whpx/whpx-common.c       |  44 ++++++++++++
 include/system/whpx-internal.h |   4 ++
 target/arm/whpx/whpx-all.c     |  37 ++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/hvf/hvf.c          |  14 ++--
 target/i386/whpx/whpx-all.c    | 122 ++++-----------------------------
 6 files changed, 108 insertions(+), 115 deletions(-)

-- 
2.50.1 (Apple Git-155)


