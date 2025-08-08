Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E704C87FDA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 06:55:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukH06-0001C4-Rd; Fri, 08 Aug 2025 02:54:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH05-0001AP-1u
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:54:49 -0400
Received: from p-east3-cluster2-host8-snip4-3.eps.apple.com ([57.103.87.204]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1ukH03-00043d-2t
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 02:54:48 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id
 18205180012B; Fri,  8 Aug 2025 06:54:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=iQ3TVXPKkyYCckoEHfHW5WGMl0C9BPtHVBT6EEzqMgE=;
 h=From:To:Subject:Date:Message-Id:MIME-Version:x-icloud-hme;
 b=QhzlZp47K+TFHiBKttHv18V3Tfw7B4EtahAWtvN7fT9JIffO2qownX28ZY2nCBRbKn7wPxoiyknqYkICw3qh9m60tf9KzWVhnPS8T4U4liU+0lqLC3+G0efJMmDwxpTlaMM/CeWHPUEf7N+azmC0k56o3JyWXLWdbM0PVhbkLNilTOrM1rXBX0Ml5RmmpWQ6Ak9myjOhqXwjxeyXUEqc4QPjJPtQ6tGLrw+uHaTnQVyIAS86utsf4dDn58YS5OuS1wo0X76wXgmarRDO4UOwfMoXhe27HyrLZqdS0ML5qdCpcykqPCJnW874sj28hHZEPz3+PJA07rcmzhjzgOwqdQ==
X-Client-IP: 46.189.47.18
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id
 DBCC11800124; Fri,  8 Aug 2025 06:54:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 06/18] whpx: common: add WHPX_INTERCEPT_DEBUG_TRAPS define
Date: Fri,  8 Aug 2025 08:54:07 +0200
Message-Id: <20250808065419.47415-7-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250808065419.47415-1-mohamed@unpredictable.fr>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 56HByCUNDtnz2HkHuVwfmID4eA65sS2M
X-Proofpoint-ORIG-GUID: 56HByCUNDtnz2HkHuVwfmID4eA65sS2M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA1NiBTYWx0ZWRfXzezscCfpBppw
 y/j7H/S2mSDmQl22ESwF41UOqIU2fZBy7/TmVnoMtle8eaKSroIe3UtnNI1aBYmaFrwX7Y8maQp
 yjyEQRPe94xWgypDJwuIuL3JZaLTlBHjyTlG92nR2i6XoEAE08jaBC1YcOZUZv3W4Fn7/t0vOwk
 D+WswzUiHVjFz3u6tuXiOQQAXnqhkaxR2BCMLuf8UVEB1Yv6RU4Ehzer2A9I0M6tCW9qJl8yKNV
 6HIFKf2g6yzPydul5fshkz+REGwnWnZ9KQ245hkgY4wt3oWZ/bv1IQfibRVNN66IDCuFc5xC0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0
 adultscore=0 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2508080056
Received-SPF: pass client-ip=57.103.87.204;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As of why: WHPX on arm64 doesn't have debug trap support as of today.

Keep the exception bitmap interface for now - despite that being entirely unavailable on arm64 too.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 accel/whpx/whpx-common.c     | 2 +-
 include/system/whpx-common.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index e2d692126a..5c2da9de4d 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -123,7 +123,7 @@ int whpx_first_vcpu_starting(CPUState *cpu)
          * have one or more breakpoints enabled. Both require intercepting
          * the WHvX64ExceptionTypeBreakpointTrap exception.
          */
-        exception_mask = 1UL << WHvX64ExceptionTypeDebugTrapOrFault;
+        exception_mask = 1UL << WHPX_INTERCEPT_DEBUG_TRAPS;
     } else {
         /* Let the guest handle all exceptions. */
         exception_mask = 0;
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index 7a7c607e0a..73b9f7c119 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -20,4 +20,7 @@ int whpx_first_vcpu_starting(CPUState *cpu);
 int whpx_last_vcpu_stopping(CPUState *cpu);
 void whpx_memory_init(void);
 struct whpx_breakpoint *whpx_lookup_breakpoint_by_addr(uint64_t address);
+
+/* On x64: same as WHvX64ExceptionTypeDebugTrapOrFault */
+#define WHPX_INTERCEPT_DEBUG_TRAPS 1
 #endif
-- 
2.39.5 (Apple Git-154)


