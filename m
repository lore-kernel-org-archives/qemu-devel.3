Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB77F01804
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQal-00075X-RI; Fri, 06 Mar 2026 03:31:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQak-00074w-E2
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:26 -0500
Received: from p-west2-cluster6-host2-snip4-10.eps.apple.com ([57.103.70.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQai-0002RE-UQ
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:26 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 0F94218003E2; Fri,  6 Mar 2026 08:31:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785883; x=1775377883;
 bh=9oCqgkLy0DFJ4Z9S9ppARUIR4xtUYlH2rZkEz4wFBJQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JXdd+73xgx4DKlj8kHLiG7NB1LbaJ+vvs13Qu+Mh/wb9WA1lhQ+iKDSxfP5+pznaHQxszyDVSH8DG0MoDVE7DFPwhOCxSuh+EdDonZLM4yvrcTofLSaVOuEr4eaTpb+pWjeqvLVPmOi8yXkeB87lKWzoK2cHLmK7xQQ7hEFK8RcM1RZksrgtLAB0UYWu7GJaQKFJXhP1KMZPfyXlbIzTKgWq15FRISqHvnCdxnqUa/N5uG7JH2A62AY8/pJeeSmjwdSJBireEp763+vMPcuSHy2B09cDTgG+e9SJ0a62l0bB+EnYrXN7kHedP2onCfgxJq1iX9GCmIER69ZLwh0QpA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 215FD18001A6; Fri,  6 Mar 2026 08:31:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 01/19] hw/arm: virt: remove hvf_arm.h include
Date: Fri,  6 Mar 2026 09:30:55 +0100
Message-ID: <20260306083113.74177-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=EPwLElZC c=1 sm=1 tr=0 ts=69aa90db
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=lDyTXvYnw_i6wWSIVMAA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-GUID: KIj1ml9nkwWl7DUwkWUpqT1IWQxg9zOV
X-Proofpoint-ORIG-GUID: KIj1ml9nkwWl7DUwkWUpqT1IWQxg9zOV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfXyXSedWLWL2JP
 bOJUNLDkeETRSIYwm2JnXqpClzSQAN28DcOB44A1KRo+plw2IYL8aJcEqOwU54MIh58qW4JyFUg
 EwJ/L8TLPwu4Amz8umMENbIV6YT+3ypmC04Qhn/3WGcCnH+aN0JlhPgBSuSk2RYKc4gNTVvRgr9
 siJ0C4LPHWDMmIJPGtOiOuaMbE8xhn6V3GHT0tkmHubwoFIkr+SsEi6PSJ+CwE+40T6s+W/YzFi
 b/RwfZcz+tSMJP5PET1rJ0Q9ptidA3aUxO7uBdX442zHBbaU8vWDTQsZ/h6uVgbx1VhhSiO2kSg
 hsrIs1yFU2l97TUHt+xYA72Xedwi2faRnzvKcYinRxKhqlZK53pUNJKOqQYcZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxlogscore=666
 suspectscore=0 lowpriorityscore=0 clxscore=1030 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060080
X-JNJ: AAAAAAABR1EWtAI+moYx6ZKIWzRERu+Cvlc+4et2mrpZtvF/BHBOCJhSqRmu/DoK+4rIo+X8udIY6DWqy7xdNkImsayICqHAj4kaR2jJU+EJrQJgoR+Xr4xYKAUVJbgQa0yT0oWiSWDTM1isjfMgm0aKdSzNAeJgzgFImQGkTqS3ymqJlPSGJZvxISOIm6/ZLBqaJIYnKZLVScAwfRsdopKT3e6PfnOGTTZUPvb+bL1rUaFXWvch4AiJk2q8Jdc+cD0AXHBW0z0z52UNjcWlHFpTHqmCT/VO2X9HXPvE0MqUwUjodFpANtmpO4nNfJlbKPqgHj1FJllimx4YRyluWZHFat702eWkznYLRpA6QFcCJGIf5Oj2N4fdAIGCcHpR2akxPjSHeY3H29PddEJ6R8YojXpviLNRVaS62yXZJqJc8rmkomEXm9smGI9qX2CUkYF9w0pY4+yyRo6uPT8J3jdNFu42iWowiov5pFN4cx72fIyyn0jNrFipooC4f5B1j7uud+oPU/CFVuYkUME8tJ7Lc0Y8fXb69c9pEuE4OIj8bfPHSKiVdW7MYv1m8tLGrOSO3oFuqqMGF3qA4vUsbSe1AzI0lHTbzRpgQeqUMtor8+hZNPG1Y8iBeHa3svYgUD2v63+G9gakSrG1k1K17sdRhZzef2EawCC++OgWPcmUgoAoluaa2Lg12cfwJsa1x1WCcQqI8hNohI/obarXVo809N5ChNfR01cikrDZkMWePozm+EcMKfdLuy8neqx6j7jdAo53jl5Frm+K
Received-SPF: pass client-ip=57.103.70.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


