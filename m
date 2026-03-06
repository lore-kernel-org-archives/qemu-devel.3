Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D58BFCB61D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXpy-00047U-JC; Fri, 06 Mar 2026 11:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpn-00043f-Tx
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:28 -0500
Received: from p-west3-cluster3-host8-snip4-10.eps.apple.com ([57.103.72.211]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyXpm-00075D-BA
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 11:15:27 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 36CF118000AE; Fri,  6 Mar 2026 16:15:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772813725; x=1775405725;
 bh=uN8lJoU61mvTYRaLVzoXbtKJ70njqQPJMrPpFOc3RPE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KBBqWpxMt9gIbK6MOLDM7bVEUWzwZNFBHajAKhRg1uxk8yTmrNg8j9JMghbMNrHPLHHw5BTzfQ6BE42UCncC05A/awmKnamCTdfnAOzJ8GCLhAlk5sLUvtWyCGXaSOe8sICTzauDmfAUTegveU1Hf1LuVdWmTtRC4uAMfhXy3pKOwvUsVfuS0ZPQJfbMj4K+hYOlsilGWZ+v3QaI9IgSVvRYa3z8o6re8eDVMdXFWWQkwkJhV8jdGZX+RwUpHqdbu3fK6nzLNxiuW9AmXKvjAaGrPZ5Jm1KDScTIbF0YnOALEsO6cl17TfR38Ml2kuFRdsJd/KVEOXpqpS+Ori6BOg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 5135518007A6; Fri,  6 Mar 2026 16:15:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v16 03/17] hw/arm: virt: remove hvf_arm.h include
Date: Fri,  6 Mar 2026 17:14:55 +0100
Message-ID: <20260306161509.79712-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306161509.79712-1-mohamed@unpredictable.fr>
References: <20260306161509.79712-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Fnc_oZLBm7PUPUGj4rketjFob-IIaBRm
X-Authority-Info-Out: v=2.4 cv=Qblrf8bv c=1 sm=1 tr=0 ts=69aafd9c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=lDyTXvYnw_i6wWSIVMAA:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Fnc_oZLBm7PUPUGj4rketjFob-IIaBRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE1NCBTYWx0ZWRfX8rXOvFA81pyO
 BIJhk4yXFQf8UMZr9UpPQKLkZCvj2ZK0zWp40Nh9DfemOecJ7Vs8+VJ0JucUpa1ew+UYPDLzxdy
 mxghU1a45e4zoNS1fYN3DkytahcRnpy2uPJe1b4gykdsU90eJAbb9m6Ec+FFLUCScb0zu3muBL+
 f1Xjvxol75pJRtrsoQOmSJhtjvHHfKrlw3slyGJPgs5SPyz0EnwOfEX/fydesY+2wrPtKfE9lZn
 l1+TEH9MfSs7yPjny8m6eS1ATVTSaGLLBxxBrcunPJZQB5kowY/mNBiNvRea0I5/h7w4aftBGpC
 hA2ZLz2wutmRTpE6zLeNpmZ63at0ja2MzrOkQso7mIkZSUOQkg9xMXd1qPle8U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_05,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 clxscore=1030 mlxlogscore=715 phishscore=0 spamscore=0 bulkscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060154
X-JNJ: AAAAAAABVh9orUISu8Us/uSUbdc2KHjkrxy5L2k/BMoKPBaGj+PVnWl3AAe0+LZ6RwzfDmrfT+oLukPhgsEtXRmAQ+vV9s4ib1i+bwB7xTw4B03JQAa7FVGUcX04q0dnnDNW0aVtj37tnmNjWqNIrtnK+dF0x2RZ3wd/PbyrPGnkzrkOVONFhuwq32+S0I/MqrRpvJudVfaeoaKjoT1/8vdNSu1lmQ1yHktDgdGs3QnRt6HDmkw9/jGFTx319tcfbwp9f8FEmDnE1NsIIXLACzTuQFbc1n6k0QZPIBMgvDxoxtjg3ixWmL7jH03NnO1SBriZXFyQS0w3zf0RZhr7Z9+T/87rUflZ9vRotPikQ0acroZVepEtQYOjFKGLpbjoQo72cBjrpbfOHXW7EzsvDMsafmtWZAcattZQAQ5eVZ05ZyM9EWkwHU6EZGV85wc6PrP3wemHCEoRNor5tn3ZImHsQAlZTP0M+cbx9Q4Y8AhZI2crzLRTWwz5T8VEqHvs9XqaKYhS5GSg1vtwOOald1CI3SBDCGV9IgSmc/gBBgKHC3IAZRMKQJqtVU89z0f7eAMPuNVGUmz/Ctwt1n0lwYngmL+DFV85B+UjLmR3tdW7I9mZx4j3VJZQyAkBeRsqzuovuiMl0C8vOgqzM13qofe8A3/hA/7qH4Bo7ZEBNL65GjlMXbEjuOOcs+pF3kaUoa5w9it0+ma70jc2OTj49izyER17kjTaZhif7OT8CDpIehN/LcuAlCMz4uftxz0UqM7bIl9vkfz+Ut7TxUA=
Received-SPF: pass client-ip=57.103.72.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Having that include breaks the build for Linux after inclusion of SME support.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cab2e21e8a..7456614d05 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,7 +71,6 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
-#include "hvf_arm.h"
 #include "whpx_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
-- 
2.50.1 (Apple Git-155)


