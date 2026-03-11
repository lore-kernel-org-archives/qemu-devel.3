Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB40112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LGm-0005GO-O1; Wed, 11 Mar 2026 11:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCy-0003Y4-Sy
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:50 -0400
Received: from p-west2-cluster3-host10-snip4-10.eps.apple.com ([57.103.69.83]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0LCt-00069Z-4g
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 11:10:45 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPS id
 A3AED18015C4; Wed, 11 Mar 2026 15:10:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773241841; x=1775833841;
 bh=YQagLCwFmO4F67dvVU7R6YOfqGT2OsNatNHouVOdmCw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PiQKPxuDZP498Zz+8wkY5h+j81lGE0br5WLCfwJ2QleYOehn6e1aRY1mGxm2V4HPAoi+kWhdmAY0wjWX6Z8aonHYrDk1zUEaYjyH7btwboE55yY9vr77c8+04UmuLjhGbqi/LCt9jKdXkbau9SeX9h93ODKfTk157DABj/C1R2DagsE7eZWb5CRtgFoH4d5pi9ZNcWWigxhT4Cw9VBavDVn8csia2AVxzMIZhao+/q+IppQe6IAntgg9iisjyYMtD8y2R8KDwKpWFQoi+5npEVvbGjPYjoY4PS6Zxs9L3qTsJuhFLmuasgDxIVknKM3af9wnq0d2WEYBUkRFm9EAtw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-2 (Postfix) with ESMTPSA id
 B8C4E18015F9; Wed, 11 Mar 2026 15:10:23 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org
Subject: [PATCH v2 4/5] whpx: arm: remove comment bit that is no longer
 accurate
Date: Wed, 11 Mar 2026 16:10:13 +0100
Message-ID: <20260311151014.55915-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311151014.55915-1-mohamed@unpredictable.fr>
References: <20260311151014.55915-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyOCBTYWx0ZWRfXwmftUv4/EzwE
 KD3XzuPAs/ElgHGrhMi4iJlAaTqgHSCZJKkT2ToL9m+9b14A4pS+fRRMtJxPfUF4YUKXIaxK7jz
 hG7OiMMZXte8+D7KG7nmWfhTMdBXfpGNRO1z7IVytjlMcIfLUJd0FX9yPwGmPpPtdkwXKTDSO/6
 AAITjZJZRviq7BXNHwBSnKzyHh4OoQ3pIlFuYvxW5fkz6Ie0fcYnDPmndjZpVaZPW6Yb4X9hODd
 qA7ITfl49VzbA/pYtC9z1r95PG9Pvogx8k7pv8zAIQN0xhtf6J02chtwbICBWazub08zVxfVIJ0
 n3WT9t0E11UUxQzOTqJVuJA3mOeyTTQCqslxds9+hM9+3fIz9UbNudMhbqq6fo=
X-Authority-Info-Out: v=2.4 cv=PL0COPqC c=1 sm=1 tr=0 ts=69b185ee
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=91AnuRma_Mvq6p0JRGsA:9
X-Proofpoint-GUID: CqLuOZP1rlcq9M-AO_a2XDk-LHNbx3vf
X-Proofpoint-ORIG-GUID: CqLuOZP1rlcq9M-AO_a2XDk-LHNbx3vf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1030
 lowpriorityscore=0 suspectscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110128
X-JNJ: AAAAAAABBdqbsl5/geQC/BJo9nfit/0qZ6JDbQTjzTg4QxPcWWMy8dS/rD7jQgr0jyxDMxcdZIj6VF0DuWIZz6nKnPZG969UXawDERKZp9ABRBVNdwtXvdYt6a4O18Se+ZNPR4yttaRUo6EfrGcTloiSHIG65cYX2+2/FTklG+vfjVEZ1R+PhOsPz8McgOb4FPAKd4rHYT5TEGlcE8xFMnjSw4qgREMqnI22VyzjOXp683ajN8D6O1kDKDiACOrxabaUjplTvS2L8EU5m6h+ROafVbmlp8/iUkN7Pjij1ghw2n/9pYIlj5dY/cUkbMosptY1GSppJqIL9Ujz7dYzv2ILEPpyHhjyf8Nta+PNNh5hTTJWphA2aCr1J2FYkR2o0PZxIO1jUYWrdOCWbjJcYLPvScky9AwzsLPXPxbHoB/MH/9UDgOJZMZ8UPrzMQnj62tO7LcKqchG8ADNmfKB4vsAN8sB0F8nXjKDbkcmh7DYpSSZA/14ZqWVvmWv70/w8vgeIYAiiVBX1eIARriudJVorx/+K2nMGjiZNoxXxUmBIjzq4H6Wb19e1XD8GZVxhL4Vi38o4KC2hDUeXq7WuB6fAVvrL/4ixiqFNi6PJBG1YdTUQXPbuuT2T9vsFvglg1zay+VSCs9JwTk=
Received-SPF: pass client-ip=57.103.69.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As of Windows 11 version 26H1, SME support shipped. However the MIT-licensed headers aren't updated yet.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/arm/whpx/whpx-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 9e5bc03a21..8aa24f2adc 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -717,7 +717,7 @@ static bool whpx_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
      * Work needed for SVE support:
      * - SVE state save/restore
      * - any potentially needed VL management
-     * Also disable SME at the same time. (not currently supported by Hyper-V)
+     * Also disable SME at the same time.
      */
     SET_IDREG(&ahcf->isar, ID_AA64PFR0,
               GET_IDREG(&ahcf->isar, ID_AA64PFR0) & ~R_ID_AA64PFR0_SVE_MASK);
-- 
2.50.1 (Apple Git-155)


