Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5A0BF55104
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 18:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vywFO-0005MY-My; Sat, 07 Mar 2026 13:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywFI-0005Kd-M1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:25 -0500
Received: from qs-2004l-snip4-11.eps.apple.com ([57.103.84.123]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vywF8-0005Pu-3G
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 13:19:15 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 9804D1800104; Sat,  7 Mar 2026 18:19:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772907553; x=1775499553;
 bh=hU9b4QgrAVOJZL2ae+ekCv8Jv6hLyKsDZdmc9E/YO7k=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JECQ0sTxvDUCurDfKs2HBdSt8XQWY9+3c8tmlaT5Po/FmPgl1JTedJ68yEGGcy7aIde+cqpV+SfcBT/tJ7EtWR2OW4gBtOOpQZN/pVdMwtmryak3c26GYVTjEchclTmksIHITUS7jSL1oUy//QhFbnSyzEuNANxs7Ls0GGpQgSWaUfSN+iyXW01DVotzlBeOg9oI1Bsv16sO+b5ZlZYL+0i/l567Jg54TmdKYLl8gTXSvsq2d9uG+G3ydOuVfx6PoMM9Wo+KPtiwork9rZdizZbo3f2jGPPvQJqA7Gnjv6fXxe3mg6ksSJKbIy9ndK1NuRXDm8UZzdYVRkIZli7aLA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 678A318000B0; Sat,  7 Mar 2026 18:19:09 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v6 6/9] whpx: i386: enable some more enlightenments
Date: Sat,  7 Mar 2026 19:18:53 +0100
Message-ID: <20260307181856.2209-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307181856.2209-1-mohamed@unpredictable.fr>
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tZwv9GpQccrmHCBz5vT0ApIsXF7FUWqE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDE3NCBTYWx0ZWRfXzSS8YFCMrx+1
 gmKSGGrAYZtqbv8G4qiIekSRTD2hotM9PXwF8FdjLl+oIct7q7fWb0HBs/cA/dYW2tvXvM/2+zh
 x1Ez8CQoCC2/QXt3L/HT2xzAgPElqC5Qr2F9J7ER1wigol76SxqbtKIWa/YAonH0SceSIFDhs9F
 5YSs1ZZAOc58WAjO0yP4NPSy7mmolUHiaegBRVJ1XKgGzb5U6hXbud1tc0F1UaZbBCeeFG+gc3J
 fpaE1sg0cgQTjmR+ZmiLRJiTNu2QV5OIkwJoa60iCjp0kR1SE2ncHrOzsBFSObM8nJNZ9fQKx5K
 uWWSULxx1gfISeQiYrZpSNGFuRbUBkfpbKH0UjEuXVR1i1KF6g7Pdh33pXph8A=
X-Authority-Info-Out: v=2.4 cv=SPhPlevH c=1 sm=1 tr=0 ts=69ac6c20
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lWQTlSF5RC17BzGQrLAA:9
X-Proofpoint-GUID: tZwv9GpQccrmHCBz5vT0ApIsXF7FUWqE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_06,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1030 bulkscore=0
 malwarescore=0 adultscore=0 mlxlogscore=871 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070174
X-JNJ: AAAAAAABDzIXb9TiHWXOFmlG+rXRf7MiYzxV6/NrD8IZ5gGpkSoknDCdOnz2eeZ5KScfKZUEODymcy2/0RX5bXpiNZvRHVTWa+s4spfvLYJUQhM8tlL82ClU8IZGicmRJDnw4e8qGUYCerzOjUtHRpsGlfWr3PPx8g5NidqvUhHGi6JKABV8c76axspTQXwGaKjRvremdQ7nJFWbARbUAO9OZRYPIomVDAfbT3eMtz+AzS5Hk61hADKjI4JyC3CeTOp5YS8EulwBzn7OScyt1/vGKFGUqU93sVwG6sKhY3ESrJcVC5f7RN1SsiItW0nUvBkd0LcL5M3IFEuYKngqDaAiQ4F86zR1kp4wFP+G76Sn6c7dkulpNFlFiW8jHyhaQXCu1yATHvYI4NrOhvuzV4EDYkvVmvesZQeJqfI251fjHDLTUOsQZZX7ZvheWzwg7SDGMc4jSv74XEUOVqyg8f5pwOnB1Ya2fBXUovWiy97DotN3ss1pMxqZig9/DsFh0qSUC2WvTzdFYlUxzpuzjiZEIyzHob0Ji8TDnajI/mabFtUDJZOzqUhuU0Ehpw603/RN727vSHVyTZQgP3vWmR5bXZghZtKshnIlXual5/+COKpSME0ts+6pac7tbCxouroa24E3+u6cSgb8VBDAKPlJHF3Fopxr51aAX+ROOLhYhinXnovQ9qBWFSxaGBwpgVY/1KxOvQKAqd8NRDn+du0FGg1xauzTiwNCNYkfAD83kZyIGxGD8rylw2wq0wWn2Nu4W/S49J3y4IBBL7gMf80Fiyk=
Received-SPF: pass client-ip=57.103.84.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 9c60295d55..bc82995b33 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2214,9 +2214,12 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
+    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessFrequencyRegs = 1;
+    synthetic_features.Bank0.EnableExtendedGvaRangesForFlushVirtualAddressList = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
-- 
2.50.1 (Apple Git-155)


