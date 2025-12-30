Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0BAE92FE3
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNII-0001kh-1A; Mon, 29 Dec 2025 19:08:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFD-000745-8l
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:47 -0500
Received: from p-east2-cluster1-host5-snip4-8.eps.apple.com ([57.103.76.91]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNFB-00042E-A9
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:46 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 A1D4618010D5; Tue, 30 Dec 2025 00:05:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=l9p5jVYclwL2K7rHpkywk2BNDTimX+u9/pjnya/K+yM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ZAQpfL6jFmoH6TJe9ryscWIkEN1tJ9lFOENAskmDm6g/oXtd7vJ8Y+AVBEYu4iw2Gbf4qk66HxGOnR/wmhYuMMCRod7fj3HvN5ixzOSDZ6pKIENJAn3y0H/glTVTRgA/Tx7QgS6vPMz6ncdKScCbrV2yQs3Zi+1f05Fl2YW3Mjh65DA1ofcnh1n7BY9H+QXS9DY9XtveHpdlhiWd1er5FQ+rT/FtKWhIAuf7NVAwDjze2qmVvRoB+CRl5Ecd6vsAffu4RW6fkw9pquqvMDdZl5ogf//rBs7aY8rMr3JYT+XTImmgKHa81ICenYuID+j/yzzETAEaCwZaaxy4WJaaHA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 31F4E18010D6; Tue, 30 Dec 2025 00:05:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 18/28] target/arm: cpu: mark WHPX as supporting PSCI 1.3
Date: Tue, 30 Dec 2025 01:03:50 +0100
Message-ID: <20251230000401.72124-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfX/Vct240fj2eX
 UMExZjPQkx648rqBQIS0zMbTAkI/fqfXNu1ctGC2tYF26VxylbH3tmhKMYaunyKC+ye1wzJfR+u
 9wKxfQu2TeS6+ZRLoZtAOdfiTBXVvlMa7qdVm8Rpx2JJlMNvwoyOd2bAlkF1dnCPTmlf3uVul0d
 FGcpXIunyBccxHOVPF3oTBQ5NTUEI37JR7q9efoVKMC3Yif0WDXpAfnzqhvM3WMkhpz0ND4ZJIW
 XWnxKhIA2JiIq2ee0+wLOze9lGR5ECbK9UZcqDCLtXdb4Ct939y4BbbGPpMC+yRTbTKVGbJWzRl
 P2Io0OsJjLzBFhWe+Ih
X-Proofpoint-ORIG-GUID: aZS_OUviAKYJ2vz3KvDNK1EN0xr-1OdT
X-Authority-Info: v=2.4 cv=fr/RpV4f c=1 sm=1 tr=0 ts=69531756 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=GfoCO2L6IEBdUbzNuv4A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aZS_OUviAKYJ2vz3KvDNK1EN0xr-1OdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 mlxlogscore=943 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 adultscore=0 bulkscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAAB9y66rQar7KXxsAHfs+4k4iGOdpOjTBtuH6C5PNXWo7vFSZW7azL6a/uYTPzZHmcZ3gaKY/K1om9iXAeZZ5woEWr9YZhl9Mw/Eybd+pc+80WI4ZNo5wTbylwzF6rQGq02yp7zXK9vWmLz9pDeAQ5WQSk99B8APbPyAaoxsK7VxAbcJcsGQAUiRP4POoWkfYG0BLmwE0H98GDmUOhlxX1Pi///NFVM+HDjROjTkZ6u1dCLj5mRwQRe0kxvnrRTGkC3ZOwhGhSgUkH7Hs+xy+7btijJ3j2/xgIaa/c71Z1uZBccGh4jr9O86DF78s+23fpgcNkoTk++b1owiUQR/QD/GzKl74SAMmMkHckLjen3dI2EuCJMf/Bc3ZX3RU6Vj1HnaiIIihLkp95P3ILda83PV5O48zuG3Yt48kyTkTym8qCG9aEpVYdCykWJzn2uMkTXiXkshFrnuKUYFfJHcV5ibeofIVzaaG5qrCPVvbW1Zi/kvoebmmpcgGy6jjKVj553FPFa6FT9KbLKQGXC0AVqTwkzJ2l1MCemcSrr60EZmblzkToKmwdxxYgO5EXEuFfd8Lt6xrsEYOWpOmz1/WQpobfUoYUl0+vsZhtgEXoH96L0XtaieaoYjaiWv1lBMG9yzUmNe49tzC5eM+KrMvohNmKDeyqYfK2tm7Qz2jYB2rKRCwxp5pCoVCsMdyXMpoN58ZPmHxPhgp8x18m3zC97EAcbVLM/G3t4sd+1gVgHn2VLcqSOLgizlO5oPV7SA9bKFgCc/hrdC2MnIchjWybaTv4XSqMCYMQUKcxb28bLl3X1ncw0IyXL249cnzTJ/gAPkaYo+fkhaqWNtodTf0toIxhBBjkKCXUqf6aOatHoxXO2/aJpF308aY7sU2xnd0t9brAw1xir+vitq4cfufP3LpbozflHeSn48YU4o4SbEgW8vBV2D5hK3gOeicziaOPCvAM25LI/hP6KM+TlSolU1DQ
 SIAluw/IHX7Q=
Received-SPF: pass client-ip=57.103.76.91;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hyper-V supports PSCI 1.3, and that implementation is exposed through
WHPX.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index caf7980b1f..70f0bebd19 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "system/whpx.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1143,6 +1144,8 @@ static void arm_cpu_initfn(Object *obj)
     if (tcg_enabled() || hvf_enabled()) {
         /* TCG and HVF implement PSCI 1.1 */
         cpu->psci_version = QEMU_PSCI_VERSION_1_1;
+    } else if (whpx_enabled()) {
+        cpu->psci_version = QEMU_PSCI_VERSION_1_3;
     }
 }
 
-- 
2.50.1 (Apple Git-155)


