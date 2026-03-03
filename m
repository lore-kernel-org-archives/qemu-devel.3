Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBFAEC1433
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 11:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxO8s-0005LX-Lx; Tue, 03 Mar 2026 06:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8R-00050Y-9H
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:58 -0500
Received: from p-west1-cluster6-host3-snip4-10.eps.apple.com ([57.103.67.53]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vxO8N-0001Ss-EN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 06:41:52 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPS id
 90BC8180018A; Tue,  3 Mar 2026 11:41:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772538105; x=1775130105;
 bh=lzVINNT5dNTScTGwuScliay43tI/X0v4AHzPG11q4ZI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:x-icloud-hme;
 b=cFzwCcM/C7jR1rBHlfWnYk9DcXXJUsekgBwuXWrTtyHosYzoDB8rc0rsX/MN89Yh8tKCX9VdbRZMbutv7M8LJty/jB84VszGITKBK/EgB+XcHnDLL6nss9HO3v6nYzmeZrRNSFchaRWWio/DDm91zBh3oy35urfjBlA1XZifeVlGIQBvRRzt/xp0oTmsq+k6kQKop3ahqepqV2qhuGECY2ABmlzZiNO7NPjxMq6eam6Ny6mO3GSOoxAuBnJiW7Me/AjslO/fBlYte3+Da1VlK7aV/OnAtqIJI71f0Ei1UUp/isVznAMTGJZ5U8trgRcRq1+S59B9lchw56XgrIhGpw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-20-percent-3 (Postfix) with ESMTPSA id
 7CEB71800090; Tue,  3 Mar 2026 11:41:38 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 0/6] whpx: i386: small random fixes
Date: Tue,  3 Mar 2026 12:41:29 +0100
Message-ID: <20260303114135.15390-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAzMDA5MSBTYWx0ZWRfX7qlklcKCdmMq
 n1FglYHEZxFxmGDguAop16JsVOPje1JLB0juN6FRBbrKUOhaZ8wjgiVD8YVb9S7z1yLN3X6BiLJ
 wF9P2Nhy6sXyG/hGsl8IxaCZ2aV3Y1Ps7VkyPmf34MkUA9QKSm3GC/gZD97Mv7s+0ga9MV+rxxY
 ouEozxTjWOnCWxqiO9iYl2i2JApdaNvW5QmaQ6jnLoNFAnMBXPddLuvED/ZmXm/wwQ3QGYxrEuu
 EbHn7qmHMqTGUakNzbAUEm1LwHKmzyIqRA73Lz736Pz31cys2gJStxnGLY/Dyf1tLcEExD1qbl5
 ELMmoSc9uvExG5UgBrdNU17YEwoGaFk63Ba6+Fv882JBJQr8OpLlXITyOmKiZw=
X-Proofpoint-GUID: yumLMeblbpqpdpUkMZ2A8XpiIIbgSNu7
X-Authority-Info-Out: v=2.4 cv=dL+rWeZb c=1 sm=1 tr=0 ts=69a6c8f6
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=CpWa7Qf6LdvcYEgAOqkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yumLMeblbpqpdpUkMZ2A8XpiIIbgSNu7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 bulkscore=0 mlxlogscore=323 phishscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603030091
X-JNJ: AAAAAAABVtgCFP+7CLw00o9f6fns9R8k3if4cHSU/ItQgizAU2oTSTwn1u8rb7mKxLe+K3NWUIu6Q6+durh34S8a+vo1PQXaTYQm5STiWajBPn/vs6Goz5cE9rl1FvD4btfBPsQ/HP5frdwOcsJzXYuhdBW9GErsGj6LVoX4vUjYN8bX4qQqpzx68/SoKZ9RNZuUWK973K97nBNigBCIMVaj2Ldn9x0/RWHPH/sCZc0WIZMIo3KahmfLQyvrsscfJYzH4EmgnsQYxS2nH5z1cak3oMd2wwk2BtPPcLd73DqIAEOzSET2Ts16qFyDARZoJq4VngYye+Hs19zMZ9oM0z2C/A1rcGdegfMlce1TK0aXJKEnRuJ/mynKMBKxb6I7DFhgQjw04dUGfl9ejy9jIW2h75LiLtM3bKUsnX988ueyvnfwcq+7y1it9BITIWVLRpmD/r7kwwM9zSNG3uTSLwB9qjpi9BQW04E6f7yZFiVZE0q3G4waa07V3+5h9S6v7qo3dX68KfXAVGer+MvIQArLwg8kGbMwlKZP3BL2XUNZ4FUq/oDzRX+BISOl4wlsmt43UnLLykz8b+UjBGybB9EDzCHPg7IIJG3ozKIIpqLJ5B3m9/bgM/IkPWUqIzV/XTIg0WiIpGlmkAOlZKlnJsBTmoYqqrUm6AV7wbcuZXykaWafT4+LrQBBHv7FOkGATtMrnq2s5zqk
Received-SPF: pass client-ip=57.103.67.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495,
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

Also has a small arm64 patch for enabling Hyper-V enlightenments if asked
for, which depends on another (common code) patch in the series

Mohamed Mediouni (6):
  whpx: i386: do not enable nested virt when kernel-irqchip=off
  target/i386: emulate: LA57 fix
  whpx: i386: enable some more enlightenments
  whpx: make Hyper-V enlightenments configurable
  whpx: arm64: enable enlightenments if asked for
  whpx: i386: remove SIPI trapping

 accel/whpx/whpx-common.c       |  43 ++++++++++++
 include/system/whpx-internal.h |   4 ++
 target/arm/whpx/whpx-all.c     |  37 ++++++++++
 target/i386/emulate/x86_mmu.c  |   2 +-
 target/i386/whpx/whpx-all.c    | 122 ++++-----------------------------
 5 files changed, 100 insertions(+), 108 deletions(-)

-- 
2.50.1 (Apple Git-155)


