Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE4AF01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:02:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyUoI-0001Ai-Ud; Fri, 06 Mar 2026 08:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoF-00019F-2J
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:39 -0500
Received: from p-west2-cluster5-host4-snip4-2.eps.apple.com ([57.103.71.95]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyUoD-0006zr-MH
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:01:38 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 503791802E5C; Fri,  6 Mar 2026 13:01:35 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772802096; x=1775394096;
 bh=IzVSt1aVpyTkgRI+sV6HgtQSQ/A0iOy/FaOFV8C9G40=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=N33zhOxvJ5cIJHUW20eKbvAApI8FXOZYqJ7F1SPmpnJbAWoL9wx//3xdL7jwuBCNPy8u5thiy1R+mWSDurUjcafMZbA7p82gB9XJ2x48fiiUxZKXd6knsjkeCMRKRyRRW3xSlZy2v88WkQ+94nM6KTEkkAsBp6MsZ6K6xYwfJnhF/DtQiYrPCbDOliUtUhjLdTFCuOyiO7aKw3Qr3DDH13C66fk/C6JueqpA2KVLqaH6t1C7IRBRTJfnR9Lz80C4Yrxk/oIYqZZWKJlLZsDSw31+opQP3GV8hDyw+LOGhBd1E3GVS/MNXPfaiFBiqz19S6Zvjcj1hQfEeFL47SYv7A==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 DF7D21800859; Fri,  6 Mar 2026 13:01:20 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v15 04/17] hvf: hvf-all: stop including hvf_arm.h
Date: Fri,  6 Mar 2026 14:00:54 +0100
Message-ID: <20260306130107.35359-5-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260306130107.35359-1-mohamed@unpredictable.fr>
References: <20260306130107.35359-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=T7iBjvKQ c=1 sm=1 tr=0 ts=69aad02f
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=uNs1HyugXjh6PdyaFdwA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: k2vaSFakcYZDnX5l7PtvjTA4ohEWIX4S
X-Proofpoint-ORIG-GUID: k2vaSFakcYZDnX5l7PtvjTA4ohEWIX4S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEyNSBTYWx0ZWRfX79/NpwEgpRZ6
 g+IYNUN+rI7kIaOpWtWF1lQfxyaPJcYgI4RapvamT58QSPRkzb8dIM2MfWdArBFGQXjmEwfokKC
 LnotQIzD224YrQ3lUixptyPdUP1bjfjfrD1SESQRaMZCTGMr/f8zPAyHuLNOIVtIwID+nwSGW9s
 1U3ydwwn9WU8bKRFwaDXOU+QWmVcOpXaOGEWZ61UVfqEiiOyZHTye4RglNHkiV0JUIeMG0XukNx
 N7bI7zATq8np4t1zfRQLARqdBAThavCObxZE9xt5+C0b1nN7zFemTbFwHeWXkBLc/+7+n/YEJgV
 mpKE2J9RIPlKtdpWmkPxRNudSu0tsACPNbwkz+MXxNu1GbPbrE+lfcKW4uEEGs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=660 suspectscore=0
 lowpriorityscore=0 mlxscore=0 phishscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603060125
X-JNJ: AAAAAAABdMORiN5fBp1tSvQzvEG9bpMEr6I62Az21jg8BxTv3+3QEf0mHbhwz6RDDCSEtY1G4+ja87Dwerri6mvjsr65mVTqXHNVVOHiLqfkijQaU0GuKnNOzvXRSUvYZMa4B+DU7Mn6yGOrBoxVOYOanCV5ViiJ3eIwJBOxF+FYKi5H1CktQe/mpWzkFLiTWVX6L15EKYZqOL5YsrXSel9PEOQ81IusAkfb95kD/Bm6Oi1OxeQ/nQmufZ0h2K7JzW2sdO+iyG7X9D47L68sDI2kPavzqDkGqzRPvUDB7erBYVfnCdt0ATSAtK5MHHqqjw15vW2eCMb3AjnTCb83QcNNsvnKJ35Zj/YD2nik4F550Jmy3aILZJY4P9M9OLzzZcrRBT5yX48o35vuNLJOOHf0YVT9OX+mWKgQYkjzxwdXvzQD0BlKXEp0Lep/8Lc4EVCaZii+iTwAJ8bhGfdWrT4330ja82haaxqPNTIwbuoPl42sVui0c26Ib3agOkX/V2W1v64BuGQTsmKwhJ38F0o89v17IMG8W9W6Vk+ZaJXziDePHsfbesyt5+Px9KVM/76PO/zn/XGTurcRt9zSbE5C6NjfboDOEObUSa57gIw3RHs5tQ0zKfe4nnOijTaRxqTXX6IEnBLogHKWAk6xUx5yr2x99TZ/YsXNyadBhiX4koXurwsW44EJy44m5MFHsAy+nc0UTxPTX9J2AwxXHGSym4rA78GmdlBPJF2AKtD60EP0JJI9dQ5tOYIsvTYA1vR0PcUH0cCALK0=
Received-SPF: pass client-ip=57.103.71.95;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


