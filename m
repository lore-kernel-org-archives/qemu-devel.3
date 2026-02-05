Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7715E9129A
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1Dy-0003js-WD; Thu, 05 Feb 2026 10:24:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Dw-0003jR-Ur
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:52 -0500
Received: from p-west2-cluster1-host1-snip4-10.eps.apple.com ([57.103.68.13]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1Dv-0001Rm-Fc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:24:52 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 4FF531800748; Thu,  5 Feb 2026 15:24:48 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305090; x=1772897090;
 bh=JM+IS+u2FhSUs+ag940jtQKtrbvFK486Oy66aTDOb2E=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme;
 b=R+jAW1keaiQc1b8J7Kvo5z47QJj/W8okAy4cwLI0uXZ37efkzWG+MU8pKgqCkhfP4oKQXzwQGvUjIeFw0BXi9zbYZSudHdTY9EIV2gnz6vJSdFiLoziY9pahrYFE1sHUYEaYfk+iSWnZjp/HZoHCsLlXbQZwIhb/BeXkbMjPEG7J3Z5UViECvxOdZb9ttpP+KfK9D9rLRmLqlr4AIZZ8irJuM47quZ+dW6gU8UtWfp5qD8pGZf21sBjDOslHrBI3J0I2OxkMf/afnGGDa2vhMyG1GyX1xVelD0S9XSsgkbfvMRRW6Z5i0I2TXEJE1v2JyNsR4p/umfk5kaTXsi8T1A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 E21CD180063A; Thu,  5 Feb 2026 15:24:42 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v22 01/22] target/arm/kvm: add constants for new PSCI versions
Date: Thu,  5 Feb 2026 16:24:04 +0100
Message-ID: <20260205152432.78208-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HgjpAjuBAmwnJvqAGtBNWStxm3CYxbvG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX4hXlCQeAXnk/
 WFyb8xUFpUDt+cyZVvLIP7qEw/xShLx5wrW4iQ2ZPu2pXhfJJ8sOJb93bjwuTRrR0afj9zsZkg8
 0Q2wS69C3ve6VuX8TapNoju8W2Y5xk4JFD6VW4Vn8s9P3MBmHXb7hukiWuFmFe2WmnAAlezFFc5
 +OUboOpu9xBvSs0wr+0dXssbnj05xGAY4zcd55EfAWeESZvJAZ07xtPyTFJsIctjRLBzo4S8iSa
 Ua/lFjcw7TAZcNWu44XJKeYVrjF7rChEHF2kOXKOuC6aS9+gWEKZZT4nbsyiJe+KCz/8X7kfZvT
 77VLieK/jcK+VlFgYdqDR7Gw1MvHQRFwL+C3qHX8jX7p3SW5PWFBdNnuS+hc+0=
X-Proofpoint-ORIG-GUID: HgjpAjuBAmwnJvqAGtBNWStxm3CYxbvG
X-Authority-Info-Out: v=2.4 cv=E/3AZKdl c=1 sm=1 tr=0 ts=6984b642
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8
 a=JzSzn-WSbtI0XTK35wMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1030 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABTSHYYiNi40qeJckwI88rvNYJ7b1sT75PFDao2hcWMM1bGt8cdpre0MwE8pw6uhCaE882ZZUTjwUfdx13ybJmdTZnHy5pDZaRVvQhC25E/J8MXiBFfY1v43C5hgLq2bhGZzee5Yxz7M8m2O0a663hHwXcENRFm7Kx0/u/VPzCo/0hbIqwKCaovFvLkrNVLFA6iQ3fFseyQVnLT1BDUwTEE8OQ09F9F0EGqzSnpqZA5hKIU1eKxh97fs7bBzOjg1fE7n4DkYNEZteQ7mZiVcY7M+Sp7v9W+wsFnBWcoDME2FUjqj7Zgy4G4ChK1kND8BkB0r4buI6xkPuDU6ARDefoswMy6ukerqbFaf5UrMPPUCwRTd4lnpO2BaHV3NdB5xhJM6BwlybVSk74c8J2Emms9Jg/IR+gOG762r8pkKeQ+h9xrjZWDMVjjDbgLHENeUA30k01vkWqGJuQ3Lj6z9Ps6qo0dXEZV+CZVHiBb2nA+YYN6Cpq7CiXXtUfS9GY4nOYORHnQaa2mfH4rvycHBBs9w0aYLcUdMNp9k4V+awU96X2dbfXY3OjYChSCEBx/PQOjzfU2Yvk2/ADLMkXXZWjQjfPA+HT9dcdkhfjTe/kx9h2VT0Na82dQOXS/ELfN+tjhXVIpaRR1f37ULMyl7ZEJhpbeaZRV6t4k5L1MXsZpBpvC5mpKcoNN3koqnMDtukfHtxo5E1sBtNiOeUQOUALChHEPpRmZiZoi9DvXpbHMs5/pIYVkIt6vLwlN6gYeRHNqzUpiiOt1aYz6UW2OhJ06JBv1pGPU3W668R6KItt+ZC382O7krlXPlxtgjtnBCr0l57lTuQRPhCNwbdoTlb5+XUpM5UmgIockR5GJhu9YxP7DNvC9BimW1dgEn2Bruvwnavk0toFwlJA0Pg+ho0GbliXuYuSx+E1Cu8u6IB5QEWQ4tqfPV80SOTtZSAPTZFwvnmikE6Tiw==
Received-SPF: pass client-ip=57.103.68.13;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sebastian Ott <sebott@redhat.com>

Add constants for PSCI version 1_2 and 1_3.

Signed-off-by: Sebastian Ott <sebott@redhat.com>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..9fba3e886d 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -97,6 +97,8 @@ MISMATCH_CHECK(QEMU_PSCI_1_0_FN_PSCI_FEATURES, PSCI_1_0_FN_PSCI_FEATURES);
 #define QEMU_PSCI_VERSION_0_2                     0x00002
 #define QEMU_PSCI_VERSION_1_0                     0x10000
 #define QEMU_PSCI_VERSION_1_1                     0x10001
+#define QEMU_PSCI_VERSION_1_2                     0x10002
+#define QEMU_PSCI_VERSION_1_3                     0x10003
 
 MISMATCH_CHECK(QEMU_PSCI_0_2_RET_TOS_MIGRATION_NOT_REQUIRED, PSCI_0_2_TOS_MP);
 /* We don't bother to check every possible version value */
-- 
2.50.1 (Apple Git-155)


