Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BE0CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 17:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RJD-0001gH-Bn; Thu, 16 Oct 2025 12:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RJ5-0001XC-4b
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:28 -0400
Received: from p-east2-cluster1-host9-snip4-7.eps.apple.com ([57.103.76.110]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIV-0001ge-FR
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:58:13 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 B9FC81801850; Thu, 16 Oct 2025 16:57:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XXxmCGrw3A7yoY22VdhSWP2DZy3nPyJTDepFV431JiU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=GB7hwzHKFmN/hEulG5ra+neIontyGtqIBFYeaRTdwZz8UxCvIi9MNlu9ssEMub4fVMwQ+2ddVjoEiDeGDxmpcnmZhSVInr5360GW6dXcWtDpmDqQMmPzZJFVtH86CAIDm60FPBw6Nat0KPZfbah+DidrETXDkPy8GBbBgRaJsOVPZd/G41hBcoVWhLLLxnQ0Swx+zdloMEvoeRyIffO4/Cb7fdyk1Fc+pf7kiXdD2/YKqksiscqpP1OwdtjN+lEfEApWmxGNsNgyf+nLmL0cvw9S5B2i0u0K1ZXnQT7XuKR0+Ojq2lPMo1ilZnxZ5ouoP+dFsR02eER0sG5vQNuduA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 6100018011DC; Thu, 16 Oct 2025 16:56:41 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 23/24] MAINTAINERS: update maintainers for WHPX
Date: Thu, 16 Oct 2025 18:55:19 +0200
Message-ID: <20251016165520.62532-24-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfXxVvW6wWaENS+
 2A3l3E2Virp5V14DLevwsSjjyHn9uN/EQ+TIcgB0XjAxrHwAFDpd0PtM82CkbmUiPq6oMTy1gvg
 f7CAAXDCGZLPGVBcaVd1q3gGJbJrkfJlA22/CA+I2toVIsLT2XSE1Wo09tl9yd5q7SYLkDGuxcH
 JH4M49aC7Wcz05r5QpfZeNK+wtSwPyva+5cjp11OKQA5twzd9n7D08qCx2MdcQzt0WLPJGlNzR9
 QzxgiuVfopKi3rfugfwqiX9EY8mO3CtJw52S8dlh5LK0dZIg5PpxpecUVnCjl9xmg4qx+5JLg=
X-Proofpoint-GUID: wJNaRMLLJzLK6FHYFfpP3tbniwg0bIlp
X-Proofpoint-ORIG-GUID: wJNaRMLLJzLK6FHYFfpP3tbniwg0bIlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=900 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0
 clxscore=1030 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABBFeBE2oOJopGBuIMoX+iRngQjjVB2BEL7RjgOojp2rWGSIeRpyN2yUjJSd+DxsgU52nfeb6448yILSWcKR4KSpvpqsNw99oj04kXpWolG6nAtVMu8KYjRv9KcybJkRJq7cGo6y1vliJcw+v5p2qKpZ4VXAq3MOJmDetcMES1EBWaKAFkC1FE0VgF+eyZM6tUeiNApCB3FopG5sYyYlgh/fwiLeUec0QeNb+hp9A8UnpSsRPgtLPsEgZzNDV1xl4qNnl/t+Q5pu1qLpxgWqc6JxkBvPFyApOezVoLQ+371QheCsDoE+f7A/gffS1QY98PB5/jOAZ4yubOIUC4rzZNP9qbDpyTRZ2vod5DGk6qdyL+/S0s2pjdDwO+SfhKJ2JgONXiydGzITXktbiyQqPdForCQIOqd6nAIeTbCxUhiBLeCKTxw28UCezhvOzpFGxLAOrMZOdcIlfuJ8n+HboH2OYWiGr7a8rLi6kg9+hLVKISyoA7QI6HKHoR/PInOSRaPq7eRQP6NiKPGwgdUeJTpg0PoOMd9t1LA5AG62viX4nb+vp27lP/wEHR89frPHNKOM2IEWbdbapbCNxzjWvRTrs8gtYAs4QAKdse8oevZVKxWCplIVKjApvcjWt5oXRhnf8HJ5yA5w/FPjzm7NoJJqYNrSGOdVPrDdBKKLef+1nQKoa+zyVOOkwoJjSOp8879AJEQxIPkFBQ4qh36xINAE+a5sMS9WJ5Llo066+MCyP4M+/nnUAIEeUIk+Q3BYD6Uuvihc5F3L6/PwB5poNZbls3pA0mGcTU3CmXl44v7VGsQrQKjdUWWu+pwv+N6lfs8OIkRQ9sFPoU4NF0bx/8A1Kr6G4TfOX9En9UnwwBDMawj59/iXn6+v4R7IM9Zk+qetevD6T9WEa6SkUp
Received-SPF: pass client-ip=57.103.76.110;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index a516e66642..5faa4a2fb6 100644
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


