Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A051049515
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GmE-0002Nx-Ey; Wed, 11 Mar 2026 06:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm6-0002IM-1x
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:51 -0400
Received: from ci-2004l-snip4-1.eps.apple.com ([57.103.89.114]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm2-0001ma-4u
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:45 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 7F5F61800126; Wed, 11 Mar 2026 10:26:30 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773224794; x=1775816794;
 bh=BvNd770jug/w8jYxp90dgvip1ACZVHLac9SVOSCAF4w=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=afbUY9Eewuf7KQqfES82u6gtZdqO1WmrOGkZMpha+ewNMB7FjWoT8paSNuSRsti1cYQjDSnWOEKNuejzFEMhNeaj7VIA6s1/ZOsudximGV5+IVlfnSVU0XcHJ2MkDjx5yYstJUVXUjIVDJzhyyylk59oGqpPn80LyZytCV3+Pjqo81MXVbvQpLArynZXZWZy56MqEEaMXjeagSjnG35Yfkl5iEhD5KXKCBaGzM3Q56tNQmT9pLqH9r1ShFOX7GLzMjnQYh014f7x/y9V/qVPMfF8ppqdcvRN8tx2s66zEg5tmvX6na5z1DOlhmpgMScbdCFEfr5KYxQHEotbea8JHw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 2031F18000A3; Wed, 11 Mar 2026 10:26:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 0/3] docs: some doc updates
Date: Wed, 11 Mar 2026 11:26:23 +0100
Message-ID: <20260311102626.46546-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=GsNPO01C c=1 sm=1 tr=0 ts=69b14356
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-WPUQ5mZ83Ir-Yp9aOEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX6ZI1nVgi+B25
 VW+308317Qnas/LK6bDbDoyN4iLBl/midMtj6yogjPYPjjk0xHMg1U1MvOBtaILvLuY4PawTcVU
 nshOnxmXll4wNC30Fs+ZlaQ6OypHIsOYvJfp33py5MSVBo+rRuNbO/2Z7lg6DLBby/JgoBPColP
 mXYihOCi7e3eKBqJKkEOBHkPiFWcclfKIFI8gKl6Pq7qXzFZZIZ2nOetVocrY9aCkGidePC8QsU
 1VwJjmIcqRrs9kbzeTGTGLOWPjYFLT/NciDYjAQm/6Hyc9NJPq4RtOspETVXn5bLN754/83x3rU
 hJ9m6Dv614vSNws/b2yLvoOKElE6uzR9kyAZAeaQD9jGqMG25QuovDtTIAq0pI=
X-Proofpoint-ORIG-GUID: eZOAiGGo1qlo7WnvDN5LdWZ_Z2Ba8LrR
X-Proofpoint-GUID: eZOAiGGo1qlo7WnvDN5LdWZ_Z2Ba8LrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=703 spamscore=0 malwarescore=0
 suspectscore=0 clxscore=1030 phishscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603110087
X-JNJ: AAAAAAABYVF130rf69iuNaz7VsDBXyrNKJovH9JRd1qqEhidMn7RqTg0sqt36RIx9/EzmDufHtr+qLsAgAiwNfNxzpO+wq8DoK2vAXqLSyhbu4A6Da/TggvrgMyaYAEX9JLUHGOkaI2orATvluNrLWTcv7edzv1IEpb8LOkKyaE4rk5eueEyGi3toNm5ng6v8fWerVnas840jz4qkOsv8oB4wR6X1y5tVbvOIW8zugdJfwOrN2++iB3ew7p/Qz9DaYaCjyNeDbANZkfl8f+OfL2+fHeoRzIoMUZoFYmMdGCGXcvpcFTYE9pZRyDxLYCMHKDRWSta4EDVr9vzOh6AUFd7+rmZM/RYTTZr4feOKpgc/Z0oOKWZ8UykQio5x2YKot46NGy5qzJ0DJRriZcHAfu1IZJPzWW0l5tq7uFlNmC1rzLDi+tNI42GCa0JtcszeFVr7EBU2XQvZc5EyKme1Juf2eCRtTnl0580IfMlfUtjEayTQXPzgIkOc5rPJhqnbTmsR/bG/agfkxqVBi3h9BM1rTL2xHnHV5261TXsrikAd9ZwSEfMCRz5PpIK8eRD1ZmONoO/holCfsvQpx6GlowKICQpoSYO8hr1Dx32EsBYbR5mHGNMogEB8OoyqYg83TM=
Received-SPF: pass client-ip=57.103.89.114;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A documentation update, no code.

Mohamed Mediouni (3):
  docs: remove 64-bit only mentions for accelerators
  qemu-options.hx: document Hyper-V enlightenments accelerator option
  docs: mention that WHPX supports Arm too

 docs/about/build-platforms.rst | 4 ++--
 docs/system/introduction.rst   | 6 +++---
 qemu-options.hx                | 5 +++++
 3 files changed, 10 insertions(+), 5 deletions(-)

-- 
2.50.1 (Apple Git-155)


