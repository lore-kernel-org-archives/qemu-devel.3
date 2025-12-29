Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AC0E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 15:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaF1p-0001Yh-BH; Mon, 29 Dec 2025 10:19:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1n-0001XW-5u
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:23 -0500
Received: from p-west1-cluster3-host8-snip4-3.eps.apple.com ([57.103.66.56]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaF1l-0004ev-Lm
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 10:19:22 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPS id
 1A2951800954; Mon, 29 Dec 2025 15:19:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=uL7SH/8eLEnNDGttJV810T7r+i9fS8o6dskAKag2GG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=MBf/3yvnf+VFahpeiDnbESlGAcAsVdsvlGiX03gxBD7X7u7NEhdnidMX/EEuvQ4i2M1B4wEbeyTuQrW7Ldp3CzxaOsFDPxobIYC0MYygPpuCcvUVebMFkADIVzseRpi4HSiSXNgkFTtKqkVxSci1HbIynrFoic7j5WWHWwYbVDhP9Bn4GspvlYTEwyxktSafdtKiW2NyZIkPFBMAxG690BXKVWK9fVv5BDFYBeecxyNolpvn0s7qnC7urOJTCPWhQdVorZzAgXp27s2aL1Ha/++1Wop8XkdjwSCiLFg3OkMTLvhzM4VTyPvTvUORxa0kzP/i82MnwlKgKd71s0AP/w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-10-percent-1 (Postfix) with ESMTPSA id
 58BD21800941; Mon, 29 Dec 2025 15:19:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC v3 3/4] Revert "hw/arm: Do not build VMapple machine by default"
Date: Mon, 29 Dec 2025 16:18:49 +0100
Message-ID: <20251229151850.96852-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251229151850.96852-1-mohamed@unpredictable.fr>
References: <20251229151850.96852-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: N6D747HQFlNLkDwW5PGYPXr9R5bWp5Jz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE0MCBTYWx0ZWRfX0XJX/j9dqz3/
 exfw6WkvSf+O+IlEocJQTx9dvhivIQipKBu7rCKfPxflGAv58fyUDYj6xpjJXPbPVyRazC9m394
 bbgJeKHd4BeI4NjYqB/bDZhez0HBwEB7Fv3FvdFOdL1J5gaOYXkaBnWUBQaaVEeiRhbuj5+cOGg
 Yr9GHgu+HGaKtse7ainaJBShEcZk+PyJhs1SQUTrTbAomGeZ+KBM8gfJA75GA7aAO+uPxABOQZQ
 bMK6LdQqRQAiqWpAGeWDCGgBotyPe/nbaZ/aN6E1yL8wDOEs6skwvpc55fhxPo4XJY287Ok5HJD
 yFRkKbvTrUYXKBU6eVu
X-Authority-Info: v=2.4 cv=SLJPlevH c=1 sm=1 tr=0 ts=69529bf5 cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-GUID: N6D747HQFlNLkDwW5PGYPXr9R5bWp5Jz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_04,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=756 suspectscore=0
 clxscore=1030 spamscore=0 phishscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290140
X-JNJ: AAAAAAABMVgA1w67tcE7Ds/X035+v6zi7zq5qvuef2OrEh9WbSOB6+yb4BTkxD+6mnXGjRJxL3P5MI1Ue3CNvUX8g5xEHjckvDO+zbMzTMWOuwy7juMfhUXLKEs7QXKF8i3BkywWntbVehIxeu6Exhns/z85JOQ7ybB5CdcdvaQNRXDnPEI9Ec08BsxJqDjmFAhg8d+PZQCgSrzvEhsUSfEuHXJe3WpswwjQTDlSU2qlpjN4xrgWf6Z//94eFq680RYsKnDAztewTL5fEtYRCgQdK5LTFcFkd+4Afj9GAKMSaAna28sW4BY4C4p1r/eHu9+QEvFpbEvWeL32828JsBt02hH/rvpqHPX5/NfbaBC0ZuECLDhW2WAtdgzhzvwSKV5sWjgzA/Vk1xZkHNU27CLzVE28UcK16u4J7rePfUTR36SfwoEyYENeNJlBfLD+zGed15XHKQeQMpmxRiaY9BQzid7XyQvbwZKcdJNA1et+CRcdPVw/mHjyuDIZQPMUHR/Fgr4zD2nGsB9+6oWRmTQU/FxLRCjZKg8Rf9PWg4+CYC5I1GBa9R2nnxSEzFLnZ8ncKSpt3CJ/5kfMt8p8RglYdcDxaGJJQVq1mhf5x9s18yftQak9ge8QKaCXUgDe0o7B3uUE06uFpObmzfCym+bqgXU87QpQWJZJCNi6Sy9y/HEPeFkoIjrtW4rqZ9/rB0tRk+m/T/2mxNGYssiF3i4=
Received-SPF: pass client-ip=57.103.66.56;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


