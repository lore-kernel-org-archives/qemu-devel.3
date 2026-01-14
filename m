Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF97D37E37
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg1AV-00049T-CG; Wed, 14 Jan 2026 08:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg1A1-0002WK-7y
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:45 -0500
Received: from p-east2-cluster1-host4-snip4-1.eps.apple.com ([57.103.76.14]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg19z-0000vf-Dt
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:43:44 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 D25691800744; Wed, 14 Jan 2026 13:43:41 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=tKQ/4xbc6eQJ5bc3AgtiWrCRgVv5jEGUZv6XVNIKmZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WfDwiyLdYX8fsOMQjc9QZ6lvepUdVxsVuOU6dgCRwJa0jCIwMbz6w9NetT6CUpqpcZazacZGhJsBFVlsRXCyh/iGueCprlTmM6hNk7/1s7S+da5IcDUxIpd2PATVabBXKs567bjBwkQNQJ1VmKKyxAzyyuS8omGKj95fpHoEqa6S6YtDPjtpbAy47qE0ADuPRTvme8yvMUfX/U0YUOMXFUCUugr83oJlFrw5mcNbm85Twa+WNnbtgk+w1hID+YZmJRRjcG1Ied6IjN+4sblLJ2PjwpzxigpMnMqF3SgZZ13K2GPtKtvVjEE3xnhbJzo/r9RSKA9pFX7v5NaHetV/Bg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 9F2CC1800315; Wed, 14 Jan 2026 13:43:34 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 26/26] MAINTAINERS: update the list of maintained files
 for WHPX
Date: Wed, 14 Jan 2026 14:41:43 +0100
Message-ID: <20260114134143.26198-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=HdAZjyE8 c=1 sm=1 tr=0 ts=69679d8e
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=t-S863UTctjxRPX8:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: vadbpc9UKoKdWXcGhVeZYg8eJ3ueCo9t
X-Proofpoint-GUID: vadbpc9UKoKdWXcGhVeZYg8eJ3ueCo9t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX+JvxvjSInc+o
 1HqBqSgNmYwV+tHprfSnIPo0N8Sje1w16Pbrutng7I+tzNM8bpAV9zefRR0hg2KDTRoyTaFpu1E
 NSaJGFzjr6BUDWMxa++QByiutv/yhuKcrzSb66PXgQMlETNXRXHGLjNc1UqIahm3L/DXd5VEtJO
 Tsz+4D+M1oBASTdbg0FH3WqU/fq/q0J0x3wEfx6uati2LGrgTi5hoTGDQ1PRE6A3tQTU46+dfN9
 dSIxqoJt3AM4//YXv+NaLzgYSmQq2oosHtIgBBBQg4dcWTzv6/jSGYt3/gpXsUuvR0FDyKg/jW+
 S1RkZ/Qz11U1sYGOJ9J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABR9ENd9/TpcvK/SsPe1GK/xPDa3wVuXcSN5RG1bxlqZ0klWHgUYRSl+q2CRfu9fl7i3V1AvNY0jSE1eNJSJjdOf7wrUDSnz6Rnm1ZCut9iFr45+VSV9+SE8BPD1nuozHooHTk0AdoyrVRCPN4BEq2YwwIsHa/I1/npzMKb867+ODSYgkHW7788TQgFu1hhXi59/Be1CDM+2VZ4GuB244R9Ozs+lLs1TSjJTclwc6IbuXJOIExKWM/iO/RRfUYvHDrOiTU8lJyZCRz/aZaYuSdXmkIPzTEH+tSEOVpyBqZGMqPQTCySin4GzW2iuhs5F4r7dEb+hcKBZqd1tfPPO1ROOTpu2YJQM5uCdjPMYoES3xVc9p1qqSo56JpwbbZweGW4Tze0ExaltRdG6Jag7f8muZFKOP3LTOmNPUZs4NZxZq/4zWrV3XQtYVIToBMFVEU0Yr9I/4nvn+4/4YRD+fIozOEnWrWF7xZUtHsNPTkp5YYh046/BApzDoFY0VR2qO6ZEBiTMs8caGZN2kwp18+fKiQ5JNkV+YW9th30yFteEEsPXO9Moe5oQGYqOuqcU8oaeajF/fqOw3Re99+VQNNrGq/UzIZBWDj20k/VHbSEmmTltQtXLc/VQ2OZ59ndfH7w9ZNa4zEerIdyJRuZZND0iWdj8Js+J9xBpCiHIAm5JYTcStDgqU5nCyvVstw7KRCrapRWQ1Ze/OBnypbVvIMhKQpa39oHqz9yGO7pdPiDmP1MOtlQFj036xwtS0Nqel+nxrq16QMGlcf7dE1FkUBCJuyzep+FHu1+wy+HYwiHkr/xqxgFHg41EosUHTqYABGJSPK/GKJIShAjXWr99SZBV1743frC5ezPjeZM4pGIP20Jtk5jNAZPh44HeSvY9MfLle5pmBspFoEkFFAVJrQ0ODH43UL09NfSx9Sm9y+huJmFg==
Received-SPF: pass client-ip=57.103.76.14;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Add arm64-specific files.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e66c764167..3190f1f354 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -565,6 +565,8 @@ M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx/
+F: hw/intc/arm_gicv3_whpx.c
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.50.1 (Apple Git-155)


