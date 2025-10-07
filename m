Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510B2CCD186
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 20:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6E99-0004qe-Vl; Tue, 07 Oct 2025 16:18:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E96-0004oT-1y
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:52 -0400
Received: from p-east2-cluster4-host8-snip4-10.eps.apple.com ([57.103.78.251]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v6E94-0007Oc-Eg
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 16:18:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 24E3F18016CC; Tue,  7 Oct 2025 20:18:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=OSfJsyCDwAqS7oFBBDNRe2fV3jYPTUsP549HW/w547Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=gj8kMHNmaVH7YcV2iB1Kvz54B4KzLgouWDqEMn/0B+LEvdUy25/VR8hzGoHCBTDtse0GpIlr12FrURTGCzbHgc9/cQcwZx1yd0sgGnZb24QIYtpmVdwwXAa77enRsCKFyYLJUr5CFhZnD2+MsKX4EXxVk/x2ESFLRj+LJT4KmTxBTokEFqqDzqkPLBjV5A8gxGuFCvHhQ4Fcn2YMPZHsq6eqqaPbnC9AAYegTSWRE7OWQmGqKFNLLBqpf4h5HUlIvWT3jG/vn5ZAzULthiZBeZeE2z6rpfJ8XkNjgjtguCvtE/Gc4+6qRk3RJHC6tL6DrApQqm3+Z71iQZBODg+65Q==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 52C5D1800E99; Tue,  7 Oct 2025 20:18:47 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC 4/4] Revert "hw/arm: Do not build VMapple machine by default"
Date: Tue,  7 Oct 2025 22:18:37 +0200
Message-ID: <20251007201837.28992-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007201837.28992-1-mohamed@unpredictable.fr>
References: <20251007201837.28992-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDE1OSBTYWx0ZWRfXz8Lcnf3pmn0h
 b3xtaVPlAekeSJ6WoSIJXL3DQpW5Re8sCSz4RDRk30TGql7PxbGq3yqvaMkcXNxTTeGlaFAHt1I
 S9KWx9p/yeaa5mXwTZpHKRP9t8a1i2pbrY/LiPsVbYR44DCEAmV6vUFjbNXNHP1+/PekX90h9Wv
 JZD7CgIFuZYWlHURSeyC8uOlOr3C96T57aSYMPn7jsnpRDfcFsJSVN+XK1tIGFUohz0OSrvfCIt
 nYcY8vWZYjzgn8JyFl+Rcr/rxwZrewqR2eH93BPTt/yCTN55HHXD+vLzS8DCoZqh74dRFUOwU=
X-Proofpoint-GUID: LVkzgvITID59dIGjGnLrk4iEIQw_X8U-
X-Proofpoint-ORIG-GUID: LVkzgvITID59dIGjGnLrk4iEIQw_X8U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1030 bulkscore=0 mlxlogscore=620 malwarescore=0 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510070159
Received-SPF: pass client-ip=57.103.78.251;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This reverts commit 49551752e860f5e403cdacac11ee1d218141fd3d.

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


