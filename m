Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBE5F0180A
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 08:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyQbQ-0007M2-3M; Fri, 06 Mar 2026 03:32:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQap-00077W-Jk
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:32 -0500
Received: from p-west2-cluster6-host5-snip4-10.eps.apple.com ([57.103.70.33]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyQao-0002SE-8s
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 03:31:31 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 4834418000BC; Fri,  6 Mar 2026 08:31:27 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772785889; x=1775377889;
 bh=/3uaaIje7wDLee3+Ab/ByFI0sYY5GPDIjmvN/qqkcrc=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WcxzUMgzclmMdsz+sofilrsGCQRlJVyC1kU3462o2/1dAz2F7vFbxasUo6Df/Ofac/E8VKNeh5D8Pz1HsyLPDhnptgytSSTdijdyXPlHlOuA7gW/2l1olhAmpb9yqrQFGf1skTIid+FhwNSP/GDnMtH0NNCOjizFmcSLTSnJZ++q9R2NnFXbRSBtkOp0ATwqm3uraaWUjSN/u2U6PUlxVZ3bL1BYFw5RumG8yZVWLAr4z99SrUpuuqLHRQBJqyckU5cdYWw3S6XdrJn+bv6KN+gqZK/KRsGo/8TlelYBx1NihkkejmX4sv1FRl4mQ4qBeg9etKUqDXHnInhhoxtAuA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 5AA0018001A6; Fri,  6 Mar 2026 08:31:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Mads Ynddal <mads@ynddal.dk>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v14 03/19] hvf: hvf-all: stop including hvf_arm.h
Date: Fri,  6 Mar 2026 09:30:57 +0100
Message-ID: <20260306083113.74177-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306083113.74177-1-mohamed@unpredictable.fr>
References: <20260306083113.74177-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Tf5hdhM3zkwK-j4Gdu6hrYWZDxPWmDO9
X-Proofpoint-GUID: Tf5hdhM3zkwK-j4Gdu6hrYWZDxPWmDO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA4MCBTYWx0ZWRfX7BRDy95/39gG
 NUjfI5vVYdpnkyEa4ooUSnfgdtwXsccgF3Pmi3i0+fIMS8hgATyHjCeKJ7wV2LGHrEVwVZEKCdC
 Ps/67Xo+5i9cmjpRRELVJ3iD+SJl8tmnzZOoJr/mQHSiUOwauYOE6WvZLruhhd1lJzngiejKx0v
 cUNwgjDF+vgj6TV1EGqLqsdtkBwmL7iDEqQVgxfOovyt6JNXars9CqndiMaTCUcsUWEafqidG4q
 Vp/IUy/CQevrfV5SczlCR3uestvFWZ0Tjo/xe9Dnu0h2JmxfQHml9IMLiJ8xdneoj9Y5m+Aw4qs
 tvNjmsOO6GtvfglT7vBx6ODXSU7rfbwOunFnGc2IsigEj6HEaDT4oU7oCzmwlU=
X-Authority-Info-Out: v=2.4 cv=DMeCIiNb c=1 sm=1 tr=0 ts=69aa90e0
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uNs1HyugXjh6PdyaFdwA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=611 phishscore=0 bulkscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603060080
X-JNJ: AAAAAAABgmC7yarFK4RT4zSF2zhRfxh+Vn4+w4QoSRPRQfdST4naec373Hb0TO5j+XD1ysAOHw7gvIIxRpJ/GhcBxEqdKC7wY8efJr4yOu//eOLkRLlStFkaUWORD/xvSQ/pDXhx4SpIJHNqBTk3pbN46UMOzSAYK84X2+avuhZlN/ejhNmPgxq/o0B0zjLaEMrkN7D11SjskGm2s6BOGqeOU0DpzRo2MMjSG83rC7NeCDB2pOPi+if7kPvdzAfT3en9LRZnz8ykWNTejNJ5pwGcvaoT306ISTk3e8Zz0nCzarXM+pC6o/J8i7FmrUlDQDhwmOSp+o9UgNfFEPPt7aLaOdzFUQeJQb58WlEmyL/HTn6XJIuQYWTLFBq37NtpW0dI1xtnoFzwL3SBTj5K9pXdos0Of2TMw1peuWdlu1+fVDey/ycAIm0mGmU5E0UJwlegqascXSsJayEV2GbgW6msDzs5411HPd7VO3IH9R8+Zttuq6mwenKQtmgYk9DgwNt9ZqhW4Kf+PJLoCLMvNVvC0R4vcU+y2dFui5uWjASdzQUU8flzP593ASeqpGzhsNJflScsNkdP6IjKhHCQ5zQ76BwveDeOXnF3R4TzWkVkdThTxqIAddgV/fnw9vFt1Fe96MyknGtSBSQgbxGQI+6HrKm1p9bqsumnSO+CzVaymuJxDSv0uUD/r/T6Za9XPACP08trGO5m23mn+KvwDgY4KuGo7ZAOQkvbQWSn6sUVmhekP+nZpxFsn1DpQhAV1GQL6D3oaXNiqbA=
Received-SPF: pass client-ip=57.103.70.33;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 accel/hvf/hvf-all.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 033c677b6f..5f357c6d19 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -18,7 +18,6 @@
 #include "system/hvf_int.h"
 #include "hw/core/cpu.h"
 #include "hw/core/boards.h"
-#include "target/arm/hvf_arm.h"
 #include "trace.h"
 
 bool hvf_allowed;
-- 
2.50.1 (Apple Git-155)


