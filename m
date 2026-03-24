Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BED8FEC0FC
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:50:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w58h9-0000wn-6g; Tue, 24 Mar 2026 16:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58h2-0000up-GQ
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:41 -0400
Received: from p-west2-cluster2-host11-snip4-10.eps.apple.com ([57.103.68.213]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w58gz-0004fH-PM
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:49:40 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPS id
 E61AC180047F; Tue, 24 Mar 2026 20:49:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774385373; x=1776977373;
 bh=uL7SH/8eLEnNDGttJV810T7r+i9fS8o6dskAKag2GG4=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=L2z0tQA50ZdzHoKykMWqunehkx5K21cXHlD3LZJZZhlIRvFSQE0NztBFSk+BpcZOep+E3YYMvkRJPS2qWc0l90jaWNdxZdM7F1K9Cr9rS2pUsh33tVyiUmULrFYFiWvCQhnA8D+RaCkdvPU+XWzVBZO071SHI6ZtZGR0tO8bJ+jttsHPuCUX0jC3Ijhx+dCPcpwapXzzE5IPBi3KQcEbDAvURGTfj7YNKncqil7+FLB9DTYmC13TY08FxeyVqbglmrgVHDEb6+86Mewo5/U2qV7ePZiZi/utnjEDAoXtCCnhc0ii4XSE/gPj6oCVHYzPwQcI+R0RNjB16u+IsAPEDA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-0 (Postfix) with ESMTPSA id
 DEED11800444; Tue, 24 Mar 2026 20:49:27 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [RFC PATCH v7 4/7] Revert "hw/arm: Do not build VMapple machine by
 default"
Date: Tue, 24 Mar 2026 21:48:52 +0100
Message-ID: <20260324204855.29759-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260324204855.29759-1-mohamed@unpredictable.fr>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ErvfbCcA c=1 sm=1 tr=0 ts=69c2f8dd
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XkhoILwbEVSdr8iLt8MA:9
X-Proofpoint-ORIG-GUID: iDfwkeRT30hhf_CtBJBZviDiAmBA3NND
X-Proofpoint-GUID: iDfwkeRT30hhf_CtBJBZviDiAmBA3NND
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX2sOCL3z9f+Se
 1+vhnDLoE88aDPo6kEfzJ/1rb/VV6YVwFLmOGmR+CI46j6PDRqkkmvkybVWCeW1ZjpiYGCNaGo6
 9EvYaiZEb5f/JnaGXCwnPCjUz4YRdbpw0jb24O96fVXSVdkr0dSc8PkVLLPMBq49RwYvMaFPTkE
 8CWT+Abg9rUPz7YahuqjY8hf4ENqzWko6BtUGZ5Kqi0tymhxvATHxYAsMVC9SuI30lvtX7Bd4Yx
 a6UOMI3QVyRqcW8vLp74ZuT/555Gtyqss2iWIDZI9ntbCTiMT3kyExbZDwS7qgGf2qxBnbU0cHn
 l8C4YKBJntgovwiITdtdstrf+x6qRhG1mcV3pwYxP2aJ/o0+gq3fVHb2xnPbwE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1030 spamscore=0 suspectscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=772 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240161
Received-SPF: pass client-ip=57.103.68.213;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


