Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D6DA10AB83B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 01:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5vkD-0005Hw-1Q; Thu, 26 Mar 2026 21:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vkA-0005Gg-4m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:10 -0400
Received: from ci-2006j-snip4-11.eps.apple.com ([57.103.90.231]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5vk6-0006KT-9m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 21:12:09 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 DF87918000B4; Fri, 27 Mar 2026 01:11:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774573919; x=1777165919;
 bh=bhpzqF9f0sxVadieDFAu/pO43zamcXvwDEg98SWPzgo=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=cG6Eu3jWKzCOW8t6k/nWqwAwpSRwtBszWmo5qGZYxG1P6J0byacw/mSgB2yIdHpD9G4d2VdUR1COv9QPciHeA74Bbp59NxuxrEleU1dlYVLzb8S8UvYHjGQZzitSI269UpPkQdpnHitemYdQNz0+Kj6XdW9vjxwhFG/i9cfC0nnSKBISbVckE60uShzG4fcxPnm5qmlicSXbe3I9FIK7czEvO6+l05bRCXfDD4UanYkcwTfft3qMozOv4D4ZCDpABjYTWjEHAnJ9W3234aVksE8nv1amBo1sH53FWlwMA+DMhQsTXf0rSn3N+QZg3a3PB7ofKXqbcJDwZ1qVv8dgbw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 59BDA180017B; Fri, 27 Mar 2026 01:11:56 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 1/4] meson.build: remove i386-softmmu WHPX support
Date: Fri, 27 Mar 2026 02:11:49 +0100
Message-ID: <20260327011152.4126-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260327011152.4126-1-mohamed@unpredictable.fr>
References: <20260327011152.4126-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=PaTyRyhd c=1 sm=1 tr=0 ts=69c5d95e
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=rusTielndRi_gjT-Gq0A:9
X-Proofpoint-GUID: jk4L4hqcMayKqjXI_X5j8Bo1hDV8eczC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwOCBTYWx0ZWRfX0/UyKLe2RDAr
 R55senIbwLZKD/qs9Q6nziUCuaYaMaFAXcnOotCbauiuCG93Mv4EUwOfUKLTFSO45cS/SOJnPFK
 UcAuExJ9Da0oZCaruRoO0Uphd3NPqVFIwRjJADgkH+iS5PZXgtb7OBBHH8qD5qdR3iSPPJkIWcP
 xBsutvpeviYRMPqTAGqeQiy4nClKSXlozIBEEsC7DrtCInfMgROwrBRm1WzsReeeJZtl4aYMWTF
 GSfWB8UkaG4wGsxXlAEX6JEROYOfL1qk0BxUqgu1WyEND8KrCiiWuDlhknPOKd/JI5coeI0V9nN
 ZED3ncsmH/iwrq2P2nvpjdPLntWNIUwow5RWB8oad4nrn88dASfla42vsgLYTw=
X-Proofpoint-ORIG-GUID: jk4L4hqcMayKqjXI_X5j8Bo1hDV8eczC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 clxscore=1030 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=823 bulkscore=0 lowpriorityscore=0 spamscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603270008
Received-SPF: pass client-ip=57.103.90.231;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

target/i386/emulate is pretty much incompatible
with i386-softmmu and fixing that doesn't look
worthwhile given the binary unification goals...

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index e6f17dd5f7..6f77309075 100644
--- a/meson.build
+++ b/meson.build
@@ -314,7 +314,7 @@ elif cpu == 'x86_64'
     'CONFIG_HVF': ['x86_64-softmmu'],
     'CONFIG_NITRO': ['x86_64-softmmu'],
     'CONFIG_NVMM': ['i386-softmmu', 'x86_64-softmmu'],
-    'CONFIG_WHPX': ['i386-softmmu', 'x86_64-softmmu'],
+    'CONFIG_WHPX': ['x86_64-softmmu'],
     'CONFIG_MSHV': ['x86_64-softmmu'],
   }
 endif
-- 
2.50.1 (Apple Git-155)


