Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA54FCB604
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWY1-0008M9-PW; Fri, 06 Mar 2026 09:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXy-0008L6-NF
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:58 -0500
Received: from qs-2007d-snip4-11.eps.apple.com ([57.103.84.171]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyWXx-0001JD-8f
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:52:58 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id
 B06891800166; Fri,  6 Mar 2026 14:52:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772808776; x=1775400776;
 bh=uL7SH/8eLEnNDGttJV810T7r+i9fS8o6dskAKag2GG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gsWeg5+hVeHc4hq5rHx4sE8997XJ1Ok5gVEj6+i+04wm+7yY5uInBk1HB/oVaVebhAn81fKBfeK2zLjuqMsnaRK50MViFh7sGkVCeg2Mp78Dc8nPUL5F/WgGnPpTfzXgLBBc3f/pv4BfoPvxvZRvRdQydr/8adUqK+D2wcpKZ1mWwXG+VhZ9I6Q2YTRsbTZ8KfoPs6c3StpdzXRmZJRhUcRdZxgrcU6O6wxUuIOGdTPZaTXry+VNizK+slKNdbobk8NncN0JXbJEzwVpxsiY7dIcC+yysQyrrZDtx8ifZ8pLohsJ+CVXVqejOD6BPBCs7ACWBjm81T7/SXLJvoPVNA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id
 D6DB8180024A; Fri,  6 Mar 2026 14:52:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v5 2/2] Revert "hw/arm: Do not build VMapple machine by
 default"
Date: Fri,  6 Mar 2026 15:52:46 +0100
Message-ID: <20260306145246.10274-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306145246.10274-1-mohamed@unpredictable.fr>
References: <20260306145246.10274-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=CcYFJbrl c=1 sm=1 tr=0 ts=69aaea46
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-GUID: xbeQw6JQUvYINrpXWEjblvz0Rt7J8ruB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0MyBTYWx0ZWRfX+nxGDF421Wfz
 unJG/GNfQlIRSAljWdP9JYXDfaddTHeGPMj9ArTPQSAK08gdu7h8BSpn67/mQxz7b3nhdb52UyC
 hZUlRyGisFFEzuqyETFrd/u6DJ8MUnmJW19qhc3NfE5/tTfSU1f260IEdxGIeHKwmMgah8CMjVr
 nEqNL7VQKJuoKKtgArqsSF+r3bBrCbAB0QcGTyozXidN9N1P19ODiDFlIRmamw++LstWUKqRNCr
 DX1LkMAJm8Ks0DKMfLzHa/4zy9ZDUQ0jSUO3rhXqHCfwaCTHwvVSzk/TMibscn6TyN4aRlXZiwk
 1yB+5S0wSMTNt5HFSgFppCvzE6quPhwdpOp+tzxH+lrrxquqsymH6Z1Mzdhoew=
X-Proofpoint-ORIG-GUID: xbeQw6JQUvYINrpXWEjblvz0Rt7J8ruB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 mlxlogscore=812 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060143
X-JNJ: AAAAAAABNivQ0YSQq18/DkR6ob5OxLAu+xCG1Pq9z+3uNVLdGeBHav4u+lHhz0uM3818fRT0OLMj0MHicIO7lG0VHxNwWg42oRx06DLfFc/nYWia0XsJelz+LymfCSnZRhvgzb+AFQWdpoAA05no6W6zmMbMvLYfJH57Wb9JsLP6kyCfcznPOGSeQVGdq6zAo/krNmRkiiLLkfj7xlyay9fF5T1Xz7eRXhCuzAbNb+QI6OGv5HnyFXqUvLKEcW7JyYzom6MPZLf5lp9yYAl/lkhxJ8Sz3iqyeHW9JjBwkADxzB0OFifbxamDY2puzbMW5V/JrcCqi+Lb5AhgSqSViJzS4R1gtrTMUPWOFcInaIQvwy/djWIhhNlUJgzpdwgaphciHlc1aGxV8+u3H3t8qmUYiWrRJl1sOT/w4sCvC0RfDpgBt4MFB9XAxg3sxg9dfsOAGfEmjhOfnPi7jEIIBN4gZn8AxthNuXmS9fzyRxxUgg17d5rUERlaU1kii2/Lwce8GoHPQW6NR9YFh7EGnouiu73jetvRMmAg9qtZPzRZVU5qYFe6fJq1Gq9I0yHLbFdnrT9uY+fmDX/yXkpN7kU1hcZdyTjUEJqAj8zueyUmV75oVo2OCNRIlkm8+lH5xQcisFAk5eRE/c40yOuSDvXWLsmHx9HAbkIbIQP3nUYuTHLifw4BaE97xrbBtEiU0SfmaBk9qukdq8X3KLYymXDIIOsZidFRIL+TeUGYOt/O0USNN2yphkBptSBN3Acg0u7P
Received-SPF: pass client-ip=57.103.84.171;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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

The vmapple virtual machine is now functional on newer macOS host releases.
Revert commit 49551752e860f5e403cdacac11ee1d218141fd3d.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 configs/devices/aarch64-softmmu/default.mak | 1 -
 1 file changed, 1 deletion(-)

diff --git a/configs/devices/aarch64-softmmu/default.mak b/configs/devices/aarch64-softmmu/default.mak
index ad8028cfd4..93f4022ad6 100644
--- a/configs/devices/aarch64-softmmu/default.mak
+++ b/configs/devices/aarch64-softmmu/default.mak
@@ -9,4 +9,3 @@ include ../arm-softmmu/default.mak
 # CONFIG_XLNX_VERSAL=n
 # CONFIG_SBSA_REF=n
 # CONFIG_NPCM8XX=n
-CONFIG_VMAPPLE=n
-- 
2.50.1 (Apple Git-155)


