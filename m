Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804A7F0182F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUoI-00019v-Np; Fri, 06 Mar 2026 08:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoD-000179-1H
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:37 -0500
Received: from p-west2-cluster5-host2-snip4-10.eps.apple.com ([57.103.71.123]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoB-0006y6-8m
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:36 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4B49C180085C; Fri,  6 Mar 2026 13:01:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802094; x=1775394094;
 bh=uN8lJoU61mvTYRaLVzoXbtKJ70njqQPJMrPpFOc3RPE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TD8hr8EkuYvLBGQAgYpkO40Sk4YyKJjNeHxUIz9974+dd6FQvubID3AZ/3Yi+GOkyFQE2at7v203r3wyUuCsggAdFf76mCoCZMjhWcvFOqwNR1piqsuDTCSnu/xm2XqDvkPNJuKH7xK9qjweVrIykEcWskRtuOiKK04YdyAd0jOMSGd9RDFvSvx3jBWEqA0noCreQk4L0ucTIuNmweKJZ3uVvtQmSLlejOVpciNgZ6WUBvi+jbEfa1WPnAERJTe3Syj/qtdwJY7xEGwBgVbPhjBQMf8c3Syj4AgpqHgcc19w7WSOJjX2zyX1ei0YhkSvJmt7THy1seubS11qS4jLag==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 4265C1802E56; Fri,  6 Mar 2026 13:01:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 03/17] hw/arm: virt: remove hvf_arm.h include
Date: Fri,  6 Mar 2026 14:00:53 +0100
Message-ID: <20260306130107.35359-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DJrTPqENAk0JjhExwLFyrt4Lc79vBI1N
X-Authority-Info-Out: v=2.4 cv=PZzyRyhd c=1 sm=1 tr=0 ts=69aad02d
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=lDyTXvYnw_i6wWSIVMAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: DJrTPqENAk0JjhExwLFyrt4Lc79vBI1N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX4ITeqDnQnjFm
 Eknlwf0hR66wRTWmqhF5/tXfhu2+CHu4FZhXvUy/eh+yaaW8iTt5nmzfVoUmfrCh9m8iwEulugA
 DA+NNJdZMLNQV5pVFrZL8WAiwwcKS2KBP01E29oilFM37vbhQ+m+g0cRYCg06v6uR6XkUQJPHG/
 lJ2OQsgHqlW9fDmuK7ZMMgBz5JtPC+8roQ1ssPkb4ZhueBwClqg0GaEKJiXIj6hd1ow4FW2jSlP
 eCNXIMOUKX5uUEEpnuz7vqdvW7Yoj2UhGnHh6Za/5wDATokrtRT1bOkLQpRnWCW+loogHGIxoVt
 CH1aLmSewusI83JuCr/ozNDEfoy1SySxEZzV+OAsumnn5Hs7cnWDmkFieeITi0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=715 phishscore=0 suspectscore=0
 spamscore=0 clxscore=1030 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABZD7PgNqUpXsnP/2Dew1CuWMCDceFuLS9urYMziNLnMi2QiAwcTZQbuyd7q6mI/XQ1FnQRlhsPJoeXDmX+cU095Bfw5CIjtM+Ha5gLZubUGwu7NcekT4PeObvpmlUtw1lyiJOg38m2VcWJKi48btSzuUduuMiiBJSpBMt17f2/pQdTbsFWKeUECUj48hCYuQY76Po7uF2eDyN55yvg/CqCES+mV7jXKPxk6NWzV/YI16TXaJKSfFPV4FNl/q8+ll+iWx/alwaaJYpbryr9D0M5ArbnpqA1er2I64liqhEOSqu3Q9KsZOihr+XcuSxIiKz/Y1j9X401PQNzoGVeQ7WpZjDmgGsgmJl4I+Xo8lP588qoitQWwX15ESkOrH4pQ4b61+TsCDxC4DPJJJrGTMAaIzJYt2JE4DFCTiDs4PUbLWBtSdVlMPcUFu+mxi475SGvkQlIiBYI0z0VL9vvm9UIP8lRgozGyro2cppGhsla5jzuSMl3UzsQkaqu6rm8kw7EXwuWonnsXUI6Ot32gHdPzLFbq9z9vzdG2+xb3rULRgIC7C3sFQtTVO4TC8GYccQh6u4GqRJBeHb5efGHF6roCBA+90H8bn2BnK8nXWM0rRTgsGkuGneLX5imflNm9LznvAF5Noje2u+nqG6PTqv9pkctbjie3y13h+nstsk2vuU817qnmxU6Owm1f1OJXRFX+Od5bw7TyrSKFWN1W9bSg6qTXiwD1OElTpWJND544madeIJ/7n+xSwpGXSAborWyD/zGyoGpA==
Received-SPF: pass client-ip=57.103.71.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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


