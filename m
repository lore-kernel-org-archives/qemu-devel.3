Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC49F0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 07:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQ4b-0007P7-Av; Fri, 06 Mar 2026 02:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4Z-0007O9-G4
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:11 -0500
Received: from p-west2-cluster1-host7-snip4-6.eps.apple.com ([57.103.68.89]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQ4Y-00063w-7C
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 02:58:11 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPS id
 8F2EA1800115; Fri,  6 Mar 2026 07:58:05 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772783889; x=1775375889;
 bh=9oCqgkLy0DFJ4Z9S9ppARUIR4xtUYlH2rZkEz4wFBJQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JGiuzMT0E1/92xr1czUJVk3yQnA9q9jZjXlsyxnBDghJ6cVsiy0w5pLWMz1FRb3BgfW/mMN/4p8CxHkRFwqC2qyVcJnH3lmqtYJ+HhUaBWpzB1DvgT1GRbyP+bmdMLoMNDTneQ58jPjLHxqWlbgCkMtiEY17EuhJSu2l/g+angdxJvoChgFMhQlCwJRBIlSoMqqbAlGI/Op9aBe8rggj3TfIsC5oFoCo9yUDWPK3H18Aj79U62B2CsnkRyxn83TqU+ZUCqE0Ei3jnUgHOwiRYoOdfLzq4B31IN5ASTUwaO1EVEz5m0DSd+kXH6gLWy1UT3jJjXXbwdVTfIz9QdWYWQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-3 (Postfix) with ESMTPSA id
 4BAB7180019D; Fri,  6 Mar 2026 07:58:02 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v13 01/17] hw/arm: virt: remove hvf_arm.h include
Date: Fri,  6 Mar 2026 08:57:40 +0100
Message-ID: <20260306075756.88922-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306075756.88922-1-mohamed@unpredictable.fr>
References: <20260306075756.88922-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6cOiNnDJocIINmB7Jb6B4rV8Pc7x5WiY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA3NSBTYWx0ZWRfX8ezIe5CA0EBu
 m4lbkNe/wrLSN78WCy6g2A+ALNgL49hWbK9p0EAVNlqWQRX8GDJhNun+tB0au5u1KoRx/OzRR9u
 0JTX5uTC2lm6V57Fi/SJqITEehIKExbEDyXQvELPGDEzXjASybh3gCbBhqc3Wn1cmQlkYOxiUD6
 SKEikbxqaZGWAHy02ZOAyOQ6IytkK9d/b1BlTyFB/UEzCjHbVwcASAW33iwsFUpXvcelVMRcu6+
 36ON7sua5j4ZapVYNP1B1fRNu36w71Bzr9vyrTbvgRvrBOYkGBgqFMdMLZ3Za9m0jtlBTKjc0qM
 H8BDKbHDNj2lTzZb/3olc5+tg0n4zjn+/aXgEJh9UcuKqGmvpkm5gCo/IqlW4c=
X-Authority-Info-Out: v=2.4 cv=RKC+3oi+ c=1 sm=1 tr=0 ts=69aa890f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lDyTXvYnw_i6wWSIVMAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-ORIG-GUID: 6cOiNnDJocIINmB7Jb6B4rV8Pc7x5WiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0
 mlxlogscore=676 bulkscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060075
X-JNJ: AAAAAAAB7DAaP/lrW56/0Kj4sh18EXvvGBsQ9gmMWhffoZWDYnsRBfQLxY5yoSxOAJNJa5qJlTwIT44619avivRrw4z1YGCTqaTfUxYYdH20xfU8ILzeuUpK/KoCQxmnk3ttOy+rU4Rz1a1emVsIFL8/nZzLAP8LJBianPoWkEF9tYWGg47SHwT/prAqVs9LPbjRqaFMTRtCThh0gw0fdADsQ/Chl8Cg16kY4olS1QFucn08+der7JQFIbPRgJUpS+zUlxmzn+chO/EOlYAdfou/0R+beldzagz0B//Do+JE5XF1XZ1bdBnEzIiNipArRCwPXHgJSYcjEEyxyI12K+PAgAHCK5W4JzDIdINydYwi+llHYU9a5aBclih6RADDN/SupERW1GcxIasGfAfBH/4rbeqYZgCfe+OibiV1gCmSCZavOhYn3gUro6YJjNdQIEP7lQ2kSTQrLWIQNsHG0FS/fvauNxDg4hs6suZo5fC+34LqbPkh1CQgCHvVfBxZVD5CI+EOPox7ggt2ghYO9X7GYIqPzBBEEw/AwyyVAGaiprjqvXIhLBYgD/WMOMa48hyZE8IGlGMvPwHUTf/JNqCWnDeK/jI9mkPVyD1kPKnwf1Gc7WnlV0Kgb3rn99VTXQthP7eyiquJFKM2UdJQU5koAqwR1hkOZPPVUxNKce8CBfYN7K4Qt/uDA+OrLPvAw2TRP/Zf4/lVQ7tTq/5egKmMJV6df2Se8rnB9fAI/uqZ4YVjW1FAfNNWxg==
Received-SPF: pass client-ip=57.103.68.89;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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


