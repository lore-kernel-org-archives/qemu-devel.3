Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501A8606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 13:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=KEQM8Qwy
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQPSr-0004eJ-K7; Mon, 09 Nov 2026 08:31:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPSX-0004cy-8C
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:58 -0500
Received: from st-2001h-snip6-3.eps.apple.com ([2a01:b747:3001:206::53]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xQPST-0004Ye-6k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 08:30:52 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 E7F141800147; Mon, 09 Nov 2026 13:30:40 +0000 (UTC)
X-ICL-RepId: 01a1c080-fb4b-79ff-808b-e75625beb4db
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQdNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQABJAF4HWAdeDkELWBpYHx1WEFIAUg9yBVcIQQhTAlEEWBpfCBkNQE4ZDEodUlZRBUoMXABoD10dWBFd
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794231043; x=1825767043;
 bh=h06E3zBebDGKkNiR0+MMIDzb/mlZpYU2o+KvSJo9YoI=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=KEQM8Qwy5CrvG/b1CLOAE5anYXHfGo3rlkg6fOv7Jc1jRchWfK67fNeojAWieLunjkdNyk4OKr+a2zdiZGnrERYKqGPyK6jpk/V5VApPq/hAXykq3C1eCQ5nJo66cMZZw3PPcxz5vRyAIDFZa04aQSIrRDr7WE2lpx5yG7mv9MqM21zACJLaiIty1JmVuw/Je5sJj1XRJiBptHfotZEc8TsWZduZPnQkTeLGVkVo/IaciYLm+pUoqad3ZIBSVtKD2zbMHhmb65oigB82JPwq0OYke6kdY7rV/glfU+T4Z0zsJbIL5mCw1l3Jd7NyRbrwlgJfnWLLZ6baM9MCRHXQPw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 A3F821800128; Mon, 09 Nov 2026 13:30:39 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 2/7] target/i386/whpx: whpx_get_xsave_state error handling
Date: Mon,  9 Nov 2026 06:30:30 -0700
Message-ID: <20261109133035.7985-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109133035.7985-1-mohamed@unpredictable.fr>
References: <20261109133035.7985-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: osuTtvIFSquNkYai71ZtPVBQpEhcrfBm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX/7DsGqPwg32s
 Q9m25D9pcUXabLw+jkz9udz7GE2vxOiWs4Ciogd9yhQftOIyY2R8yhYT1qYfRLxajvGjfJuYU6J
 KK+xi666lbM9GhQBKmx7/pLEO9ZRBW223dzW+JHoOVQN8aklf/671xIqfo1W3AnJuKBqTxlPAWo
 QJksjeHsv8tQRnaxVU9knv6qXLKwIcHnVfYlJos+vrLxEhgFakSziTDUuMePSkCaQ2KQKnPuSTS
 mhS9aHLedslzHR2xDmDM15gmT7F95rLi9oqc5GNhaYWoOhrvM12I6YtA9bOzqCbUuvxj7BQ9m+n
 lbFvb7w3av9KwnF8hrjW+SGQE6QtQAw2EeavqKgxFep/FBLjvNasVYNqkEZrDA=
X-Proofpoint-ORIG-GUID: osuTtvIFSquNkYai71ZtPVBQpEhcrfBm
X-Authority-Info-Out: v=2.4 cv=LtmfC3dc c=1 sm=1 tr=0 ts=6af1cb01
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=CyeGX34NJn-RfCE8euUA:9
X-JNJ: AAAAAAABvQXlP8CSlOprIMdNvX6ADO2oOTYu7y00IKeW/hG61mWwoiMw7FSAWgbxkJWqvO
 aHDmmEdAjBN/Dl+12G/ThbNor6sKfafL9sAvY+pNUM1SUUBMyL+1+c17pLJfnnXhrq8pfS
 zapNGIfQhNgvi4/DB/BJGisN1W50P1i0Jf1Zt/HsOTUzTRXRAu8reT4J7QKv3RXp3yaEY9
 EhCFTtsR8aTHsAWa2hC2MccqZreGDAxnwpBTSTJDXYkxDRXyiCm6/g6l4F+sdjjSeEmQDC
 YycDN97Mhyeb6irbxNwmZY6B3Jw4kgKjg/11nc0enNjpvgyx98Loz8kBIjkE594jZ3aokq
 WvmtZPmSfqk/em6CwqwHKWTA1zgvg0/t+VIbmESBbyVzrXwTI0QVUpFDyyjFpXYBJkp1WJ
 cplPFoSjrkHI+8vGSmDbo8cdzM4dC+KAnLvTG4z9IoycOWAdreu1CjxbDyICeC0isTXnPD
 8uIayAE57z5gWecxB5AjYDF7vm4xMcLme8ImCMomTLF3V96iv+G9kcFED8uON61TBpL0GW
 N7HlMaPSoB3IOCBZ8idLuFWq0p9IvYLiJVpI7wtdbJDgXRiaUG1maAL9DWe0z7PAXEvXob
 kwWUM851n5HdxtEytFS6pZzyHVluGMajqFeCgPttESXuclzQEDINQAbwgY4G3FT35wOCNq
 mo7iJWyoecLBmYaQifvXAx8W1VdLsvwCKaK6p4vpm4j2P1YicNXWL2TY+DkrgmI/9de+bS
 w=
Received-SPF: pass client-ip=2a01:b747:3001:206::53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Doug Cook (WINDOWS)" <dcook@microsoft.com>

Several problems with error handling in whpx_get_xsave_state:

- Does not handle WHV_E_INSUFFICIENT_BUFFER, which occurs frequently
  in practice for XSAVE state.
- Does not free xsavec_buf when an error occurs.
- Error message and return code use errno where they should use hr.

Fixes: cfaa3b6c9597 ("whpx: xsave support")

Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/whpx-internal.h |  5 ++-
 target/i386/whpx/whpx-all.c    | 73 +++++++++++++++++++++++++---------
 2 files changed, 57 insertions(+), 21 deletions(-)

diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index c295c5a529..b15f3d8faf 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -58,8 +58,9 @@ void whpx_apic_get(APICCommonState *s);
 
 #define WHV_E_UNKNOWN_CAPABILITY 0x80370300L
 
-/* This should eventually come from the Windows SDK */
-#define WHV_E_UNKNOWN_PROPERTY 0x80370302
+/* These should eventually come from the Windows SDK */
+#define WHV_E_INSUFFICIENT_BUFFER 0x80370301L
+#define WHV_E_UNKNOWN_PROPERTY 0x80370302L
 
 #define LIST_WINHVPLATFORM_FUNCTIONS(X) \
   X(HRESULT, WHvGetCapability, (WHV_CAPABILITY_CODE CapabilityCode, VOID* CapabilityBuffer, UINT32 CapabilityBufferSizeInBytes, UINT32* WrittenSizeInBytes)) \
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 3312dd8593..f5f5c3b462 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -442,8 +442,8 @@ static int whpx_set_xsave_state(const CPUState *cpu)
 
     qemu_vfree(xsavec_buf);
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to get virtual processor context, hr=%08lx",
-                     hr);
+        error_report("WHPX: Failed to set xsave state, hr=%08lx", hr);
+        return -EIO;
     }
 
     return 0;
@@ -809,9 +809,28 @@ static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel level)
     idx += 1;
 }
 
-static int whpx_get_xsave_state(CPUState *cpu)
+static HRESULT whpx_get_xsave_state_buffer(const CPUState *cpu, void *buf,
+                                           size_t buf_len,
+                                           UINT32 *bytes_written)
 {
     struct whpx_state *whpx = &whpx_global;
+
+    if (!whpx_is_legacy_os()) {
+        return whp_dispatch.WHvGetVirtualProcessorState(
+            whpx->partition, cpu->cpu_index,
+            WHvVirtualProcessorStateTypeXsaveState,
+            buf,
+            buf_len, bytes_written);
+    } else {
+        return whp_dispatch.WHvGetVirtualProcessorXsaveState(
+            whpx->partition, cpu->cpu_index,
+            buf,
+            buf_len, bytes_written);
+    }
+}
+
+static int whpx_get_xsave_state(CPUState *cpu)
+{
     X86CPU *x86cpu = X86_CPU(cpu);
     CPUX86State *env = &x86cpu->env;
     int ret;
@@ -824,27 +843,43 @@ static int whpx_get_xsave_state(CPUState *cpu)
     xsavec_buf = qemu_memalign(page, xsavec_buf_len);
     memset(xsavec_buf, 0, xsavec_buf_len);
 
-    if (!whpx_is_legacy_os()) {
-        hr = whp_dispatch.WHvGetVirtualProcessorState(
-            whpx->partition, cpu->cpu_index,
-            WHvVirtualProcessorStateTypeXsaveState,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
-    } else {
-        hr = whp_dispatch.WHvGetVirtualProcessorXsaveState(
-            whpx->partition, cpu->cpu_index,
-            xsavec_buf,
-            xsavec_buf_len, &bytes_written);
+    bytes_written = 0;
+    hr = whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len,
+                                     &bytes_written);
+
+    /*
+     * whpx_get_xsave_max_len() returns the size of user state components
+     * enabled in XCR0. The hypervisor returns an XSAVES image, which also
+     * contains the supervisor state, so the whpx_get_xsave_max_len() size
+     * may be too small.
+     */
+    if (hr == WHV_E_INSUFFICIENT_BUFFER && bytes_written > xsavec_buf_len) {
+        qemu_vfree(xsavec_buf);
+        xsavec_buf_len = bytes_written;
+        xsavec_buf = qemu_memalign(page, xsavec_buf_len);
+        memset(xsavec_buf, 0, xsavec_buf_len);
+
+        bytes_written = 0;
+        hr = whpx_get_xsave_state_buffer(cpu, xsavec_buf, xsavec_buf_len,
+                                         &bytes_written);
     }
-    if (FAILED(hr) || bytes_written == 0) {
-        error_report("failed to get xsave state: %s", strerror(errno));
-        return -errno;
+
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to get xsave state, hr=%08lx", hr);
+        qemu_vfree(xsavec_buf);
+        return -EIO;
+    }
+
+    if (bytes_written == 0) {
+        error_report("WHPX: Failed to get xsave state, no data returned");
+        qemu_vfree(xsavec_buf);
+        return -EIO;
     }
 
-    ret = decompact_xsave_area(xsavec_buf, xsavec_buf_len, env);
+    ret = decompact_xsave_area(xsavec_buf, bytes_written, env);
     qemu_vfree(xsavec_buf);
     if (ret < 0) {
-        error_report("failed to decompact xsave area");
+        error_report("WHPX: Failed to decompact xsave area");
         return ret;
     }
     x86_cpu_xrstor_all_areas(x86cpu, env->xsave_buf, env->xsave_buf_len);
-- 
2.54.0 (Apple Git-157)


