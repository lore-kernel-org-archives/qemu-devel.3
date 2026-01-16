Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53041C79FBE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:58:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkHb-0005ay-Od; Fri, 16 Jan 2026 08:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGr-0003lM-MU
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:54 -0500
Received: from ci-2004a-snip4-7.eps.apple.com ([57.103.89.10]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkGq-0002N9-7G
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:53:49 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 30A5018000A4; Fri, 16 Jan 2026 13:53:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WYkLiGieWVZ89cLWDDOX8F8k1/0JpGD5pIYxHLMKcmQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ajPUFs39tKM0mdhD+roQQCcUkbtT6QSNrGNBwYQIV4bfCzuq6dBz+w5eaC3JElLow1VvITQwyoK9UFUKZNuA8v9OaqgLOdgG5+b7fwnpedvCnRmXXgIJPQmfHOG61o6kP1j2Ap9hlgYvK8HJswIk+RjnJZF+OdBg9c1Ms2WDZ9DxQ6gYjcJvoT5uYUqiUW6pTfTIavHqoH0X3QZU58J22obNWaUIvTycadspCMF81pEJJwAWW49HB7LU/19ChNym3C/IPeGhYnU+KaRUhAhB4UIn44zi8Gx1WGccB9YOMyH5/mfpTHWHYcE/PMIWQ57+TIgM7nilhqfubaNTwdumeA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 A5C7D1800132; Fri, 16 Jan 2026 13:53:40 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 26/26] MAINTAINERS: update the list of maintained files
 for WHPX
Date: Fri, 16 Jan 2026 14:52:35 +0100
Message-ID: <20260116135235.38092-27-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX4oE9eqJ8IxZ9
 1GEIo3f2aGWc/3GBkRnJnXMtphhR1PoY85ep90ArBn1+q2IueYJs52QNEjiheEatRWRJJCkk+O2
 4ea70LLXXDu9/tLWYl3w1RiYBMQc9OTvpsg9rQSFgYugsl4mtwvjwh9muQjU5a9iFllve7ghwzP
 HZG0XlnGtIij/fVAI215PK8WiJHc3bfJizRq3++wHGk5+Hh/16SxDIOBv0n8Q8iDuZbUFKD+s1z
 V0E7p5ugJpv6h1rkt6eswScxKBAxZd2KzG+4FBcWWSR/NU4TC/RBv4BItHD6eyg7ywJ0Puxem7w
 SdehCIr3HlpQf6WJDCw
X-Authority-Info: v=2.4 cv=LtqfC3dc c=1 sm=1 tr=0 ts=696a42e8
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=t-S863UTctjxRPX8:21 a=vUbySO9Y5rIA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=hdCJvu6vi-O6ykQZt0QA:9
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0ienPZMSI4yrwLN8PYhBJXYqjE2BOeM_
X-Proofpoint-GUID: 0ienPZMSI4yrwLN8PYhBJXYqjE2BOeM_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030 bulkscore=0 spamscore=0
 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=937 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABaZrIDeS0qXl1cebtGU62cQOB+hhphCTUCf7GEkwUo4t+KnRYMRqmLKnZaMMc9rLeAUxcMjOufbNv4jXepOaJAJgxiua6qaeMWH+Bdj+n6qF1aecfvTvoUbX2rWPcRTDa2BH5ro3Yi97lj5aJprh1XPr+xd93QRg2Dy/Svp+vaCTJHm/0JA1Y2B4j2w47lrX8Ws5hjvn5wI26XMOH2RxSt7hCIDbXVfEvc0HWDtAVIQwOQuayaMmR271ZbRgZ/KwNjsy+AKiK4gE9pyH0MC2rMO53DdM2ips7TCVooO8DNrdE/9YQSfLClXrm6shzKp13gKiNT6tRt2AaVnAp8uTA3icaAeqynjU9pdXkbexb0UaiGpETFVSrDS19LEGg4noVbFzab+YBP/+ToVYpJ13vJlNQxzK1NobxinZWnVCis964r/fVXO2gg2XcTuTP8AkqW0bsiWP4ReWZjQZ9H1gsLwbf0FVGfJ2C3D2tKNE9vs3wQDTx+GjrxxNEGf8vHJDW37Rv125j9IQUR8OYgq1yZIP4wWj7ixoAD7Ob1/l8A5/HVpeoCAf0x219NCqQa2miK2js08RU9sCbG81cmKFSw7kVPJctsC/R0u/Ipl0d2kNKT0ywDFJlp7vygASokXkA8hOPpQEolh+Oosc7wt1l941vLHftydmz6CjjlFC+ddUVgr7/B6Xe9moJcs8TS891KZLx01KPI/uiFYxvwyStnBqj9POlZPBQ763/ae5NeM1kgE5uqtw9Wx99IfHMmJeA8WkaZ7ALPxkpJh9C4wCcsuCgBc3pZQZPc8d3i07zbzd3Obqqwb97shIgvZX2
Received-SPF: pass client-ip=57.103.89.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Add arm64-specific files.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9127a82ec3..f03ffe907d 100644
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


