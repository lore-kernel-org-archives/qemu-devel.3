Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0979BD3CC84
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 00:18:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgB3w-0006OX-J6; Wed, 14 Jan 2026 19:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3u-00060x-5m
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:18:06 -0500
Received: from p-west3-cluster4-host2-snip4-4.eps.apple.com ([57.103.74.185]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgB3s-0002Ku-MY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 19:18:05 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 9A87218000B5; Thu, 15 Jan 2026 00:18:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=tKQ/4xbc6eQJ5bc3AgtiWrCRgVv5jEGUZv6XVNIKmZw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WKCRshI/0Tkx4mHs6VsXWO3UIRVF4wL3ZtTk44GHxyke3xtjzqAs7aK76BIEEveFNDu5EKms8vRteEWlIp6u9N1/2SuYkP43UPFKZCiTwI5d9OiY0yyAtkH+Pkh1jvc9MnmFkFd1orhxcEKWzKcT+hs1hC8uVSk3ZxgBR36Xrb/eJG8uh9LLTHgf6bQCRe1Cdprc2qFVyeI1wU954Yi/RR6VVObpiFQDLd/BiRoCeNgn1q/HPN/3qtzEkR3BthxTq7TpPaJDwzsIn/3gZHWNAj95roxI9tswOySXh6du58rauNpAuHyOqM4D1QKGemXaZmqRkVYF3UMiClqCvBva0A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 EF0E918000CC; Thu, 15 Jan 2026 00:17:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Cameron Esfahani <dirty@apple.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v15 26/26] MAINTAINERS: update the list of maintained files
 for WHPX
Date: Thu, 15 Jan 2026 01:15:05 +0100
Message-ID: <20260115001505.57237-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260115001505.57237-1-mohamed@unpredictable.fr>
References: <20260115001505.57237-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=NcvrFmD4 c=1 sm=1 tr=0 ts=6968323b
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=t-S863UTctjxRPX8:21
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=hdCJvu6vi-O6ykQZt0QA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: gAdJBJTaPBeK40LzObMOhpECS6YEvoQE
X-Proofpoint-GUID: gAdJBJTaPBeK40LzObMOhpECS6YEvoQE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDAwMCBTYWx0ZWRfX5nw/kcZ7/SS7
 JYQS//+2DA8qBStq08+hwc/CcX2py0E5jSQfXQ5JgwTsquArZFJvBRfPLMwKK8rrHquCMpLjv58
 4NDQmuMBZILxp4GU/K2nprge6yF78IN/PXa8yOR01dSQAW8NBSrIG1raUpNTWtiIZpx67I/Nbnc
 nsgJ5NhigeFUHBlnMuexEIXjGAWzK47CaMXUSBaIZ3vt77g9MBPXcQSVufbAE78YbScNYpSmC/n
 ExNywciGf9BAKMrvRonPn+7cAaXCNBfykua6xm5K2HGA24qFqQ7D8hlmfEOZkYRdoIFG5xYkyRq
 o8WQ3ApJd3lBvcVQ2Ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_07,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 clxscore=1030 malwarescore=0 phishscore=0
 mlxscore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601150000
X-JNJ: AAAAAAABe7vZduSPEjPt5y+WZ1izOfnYwcHUu6yKSmBzHlkHX9Gpd3byLZ+47vsdS28Dv10ITHgogaRIqyJkt/n2D21FOmqOOlB0bu2ryFReNrWG+VqoljEbbD6VvIO/TIgsBMz2noVN/M75TQbANwQnqFTtVGznO/B6SNGUsHE2jV145Va5a/UWxKzjzeTq8g5rcQ4hL5QHyUi94+9DkmBYg7g+Mc7KhXcMcvFHaMIA/4AE/bjybOdVIrJp6Tw3BrLMKQkruS48yahVZ0iy8OcRHUAoAATl5hsgQqYJ8e/eiZvWONb9WOagDPWcTZaXGORRYlufffNAIobsT3C8kyBM8KJvSZlqCl5zAh058Aq7yfYwraysF1fzSEu4OcQLrZnKZcOV9h46dbE7ddMuiX2bCQqp9h/6+t7QftfCXo6Ovcim0eMx64hJC9CfUoaiZXk3Y3gW9DbO6GL3uPsrT80UyvUj5H/A/QV1GzQxkNmTpWAqFCfZ9mKMrEYapHgM14kbF8tfr1FYpsHY6qcFy+H59DGz8wVTBG4ll+jdsH8rjzkjeHFOwbYap7PoOfSUo2oLt3sx8Vsq57HMm88L7Nzji2V8DRf6kOVHubJHMl3v2EtM1sSMajv9Zr+T5LzG66k2lmVL0+NdkMoXSRG4QMa/M+uKiYVxf/krJTlSm8XsiEInxptHdg44g+xt4MHvHS/AAXxaBfc9miouH7FYN6wN97jVN3nYePkyaOKh75+nXgdK18O9wfhKQcHwrf+U0kIOvjfjY8kp8XrG2a41jZjA1BdJDIe1Ja9mJ8v/DOX883RroCbSS25GAO0WvqKEzckolT+RDRzIRTg5ICirAT89coL7lA4s2ShcjyqVjWQn0AjHE5SXeyZiyQo1UOZiOCOwlyIJ0MjpAGwD864Y+PPe4RCPZOZ2cuBSvOjGv6+QRQHWdZZ/RJK7xFmAjZIWJ7vWewtlqlq6Gyg=
Received-SPF: pass client-ip=57.103.74.185;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


