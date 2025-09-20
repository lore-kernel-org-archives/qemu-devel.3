Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6052CAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBQ-00070R-Sg; Sat, 20 Sep 2025 10:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBN-0006v5-FH
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:21 -0400
Received: from p-east3-cluster7-host3-snip4-2.eps.apple.com ([57.103.84.153]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBH-00089g-EC
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:18 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 8BCB11817345; Sat, 20 Sep 2025 14:03:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=IHjqdFZlYtMJa8HRC4VnZhdX5Q0ePonZlOFVwjjZYxU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MPprHi67MiijYc3XhExjP2RuAVq+X9gmjes6ynzZaqHt+RY91GaILhgMrTQpZZaUnUe5mBkHvsngN3eXX4A9IQeVuKx/NBQFjzyras/latoD/9UBnWe5QOSGBGe0GmO+L82Yc6EWRrMf4NqVBCJ2bCYfiDlDs+2nlsQBzBb98yiGZsa3IJjmo3/Ov7FM6mRuFlLrC3La+BRCYJ/i2pRaxEw0DHEQzeee2aJghYoRNKO/7wqkXKBupao8XW5nafJbwI7I+OpZ25XNz6C9mMkrasUb62PxYii/PzRSA64KN06/7uRzkbMHCAot7wO5ZTmYlNLVgafCu9CSD0xfSJjhsA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 896521817098; Sat, 20 Sep 2025 14:02:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 21/23] MAINTAINERS: update maintainers for WHPX
Date: Sat, 20 Sep 2025 16:01:22 +0200
Message-ID: <20250920140124.63046-22-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4_XIPZW8Gs1LJTl1yb4x8Cmj5FvYJ9kW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfXzNkOaFQADvwR
 Itqd7fri4VQJfZtSL+sWesK/+mgrlylaJ0L+47HqotwgRZRsYcSDF74yXqJPydM+UTG8Y60qNwj
 z1IaocwzSe2SpZuAK4pGzQ/9Pw2zKVK9zwttgw/yBuyBYIPXi7pyoOc6NsfyBu9Xx0rHt4ZsRyw
 hu//JcmjSXvDZWBpzyJaMi0CtLjc3l5Azqn8XWEP6+K+8JalTldlLwdeCXTvPYp0Odlz/n0J1xQ
 tKu5Ho9FlgSWsgF2/Zg++/eNX/Y+lYcAH1UC7ac7HJy/YiC8RRutiYWQxem6DwLG7ud7+A+i0=
X-Proofpoint-GUID: 4_XIPZW8Gs1LJTl1yb4x8Cmj5FvYJ9kW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 clxscore=1030 phishscore=0
 malwarescore=0 bulkscore=0
 mlxlogscore=886 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAAB8FHS6JMIfcy7qo0KxEd26QpUFCC230Xv14XNDw4qRsHHjR8zhMv5KhP/v1+ENOuP41Z7k4OMyonbHQOGwlqjxDXss4hXe3rFz+ooGOlHO/Of/wjJlj5OADsO/R4qX+8zSU4VTAGc5Be1rTiETKLlcoFM7GiB1ZCYAurnbe+I/piujsLm1hpsmhmds/B0S1BHA8K8l9WPxporxSO26B4FvLhYZJgTmKdC8cQEHhGVEx8V/ubT2tBmjEnuqLGEvS5ZKeRUZYDDLPXm0gJ2uL9vKWdB/3uND6oMfN0DSbS5gG3/6Nom8/4B6jGFoK4e/KwzbINxbWhGn4LiPcNbpUnsvS3fSN9OwMom42HZDhTGRbBG/o4pN2fry7NNHqTfr+wFMZnehGhJ4nLp1NxFQxtNLBtNoKegQ3jn0ZbhEzQiNam+58DG/hrRauki7oTNTEGvaTgSH+hYgj1fCTS84CsiIzy9vxP7LqfzjjPzaTj9BGZH6dzQSRxdybMqkI3aINFHNqBBSASeFDZNFlp0qmJ6CFnM5bmCrK9Um6niOFxidBasCXn/VppbNf+OqIlYw2wsP+HabUi2OYd2F9hE0eXl2wHHFKEY7rc953ep8kIKg1XML0z0GheC4eR/G0uTW1vRfbnNOV+1DSF9Pqx4Dh73msS0UAxLiIKedhT+KJu6XV/verI2eLEZdKBbWqV6EI1pHgbfQ2CXmt3AkYh+ktAExt6Xgy6c6b63k4LMndAR10IM/5se2u7lyN6sNC5+LXr/Pv89PjFBHUl6xXy7BE7TSls8gMO4Bwh1PeE2E7hYcZI+250iYMlx/lAQM6ysJs4+FZ45FY9J01Wjd43T9mYyQMrQ6/TkN7M6BV+W8CT8vZZeB7HZrw==
Received-SPF: pass client-ip=57.103.84.153;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

And add arm64 files.

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 466ebe703a..e123abcfd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -544,11 +544,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
-WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+WHPX
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx_arm.h
+F: target/arm/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.50.1 (Apple Git-155)


