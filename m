Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46209606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=q4f8xgEx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPzbV-0005U4-Ua; Sun, 08 Nov 2026 04:54:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbM-0005QV-90
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:16 -0500
Received: from st-2004d-snip6-4.eps.apple.com ([2a01:b747:3001:201::23]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xPzbJ-0005y8-B3
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 04:54:16 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 A876018000ED; Sun, 08 Nov 2026 09:54:09 +0000 (UTC)
X-ICL-RepId: 01a1ba94-6417-7fef-ad09-2730305d381a
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQtIBUMGWgReC0wHQwJZEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQRNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FSgNfAVoDQAFIClgDWwFeDkgLXARGAV1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIHWEcURw4PE0wLRwJaNFYfVBlaAw==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1794131652; x=1825667652;
 bh=x6QpE31YHSYm3IN5HGzUQG5BULloTc4Z+l5HgHvxa6Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=q4f8xgExoiOwvGMxhedSd1np6okaeThoWuWR3CSQJvegAVXZW7IDM2carSB8kqUDEsRV8dQ9smqMvNonNO9/Yf8l+nccTHiFvssEiZhtw0TxgXBW0fxek1qX+HcrQHYRvssX6RrApJm/qBlp2StR8Y8WeSytr06ouerjmkWwVvG/TODOVDxuv+pzPo48XXttfTuKhHm1KS6pBCzyL1R0mvVizIeJbQwjRMyUDpn+7OmVvgOpXo+HbjBWRri+rns+bQmD8/xabzjeU8/T8LMBzuPSdt3y0mbN7TJzxCiIIOTjsa4YChhUtUDfE328+iqbwlueU1zjOAB3f864lE+PIA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 1993018000D6; Sun, 08 Nov 2026 09:54:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Doug Cook (WINDOWS)" <dcook@microsoft.com>
Subject: [PULL 02/13] target/i386/whpx: whpx_get_xsave_state error handling
Date: Sun,  8 Nov 2026 02:53:52 -0700
Message-ID: <20261108095403.70813-3-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261108095403.70813-1-mohamed@unpredictable.fr>
References: <20261108095403.70813-1-mohamed@unpredictable.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BEB1jVwQB54CnLYgCGCqmco6zCmWPaub
X-Authority-Info-Out: v=2.4 cv=VLLQXtPX c=1 sm=1 tr=0 ts=6af046c2
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=CyeGX34NJn-RfCE8euUA:9
X-Proofpoint-ORIG-GUID: BEB1jVwQB54CnLYgCGCqmco6zCmWPaub
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA4MDAzOSBTYWx0ZWRfX+qqowpRm8AeO
 s8wq9Kawme0METtJ8gF+60QP8lZiTBAUbBsrvsDYiWJUiUyN3b8dAQcLmYgOBKC70v9b56GeQgz
 c29BYOcwdvUDhBVc42GOvediglQ5eqvSgjZ+KXnVGHwWqmK5nKI2pfyoJ2GMhf4EsmuM2odgIXJ
 G/drqvVl0/RCoEGRembA8zmxbyFaqQpKea6I0WmSKApvJF1sr7rBKqOQ7XRB6r3PP/5xZ8lW5l1
 4IoWsW3ASIR56sdGtnZ+4UNgvW/mKXa1+hlGC9uQEsaLvWy/E5zWJ7iSV2t3a/mDvh34qmYAzeg
 QVcMedGbHDFrxBjtznznNpcMcjnhaDL4mTc0oGbKsi2pu3MI0daZQ4OhWv6RZ8=
X-JNJ: AAAAAAABpC7efIPx2JzibChvC2xRhc2c1mLsqDhV0O4wO2YglJGfpJxNItJVkuESoxGJAd
 rzmKlTwVP3w7qqpu4FYNLz5x94kk9mbG9V8yRMg4eI3bTwb9AaWMSpu50XK3yTxGpT0Emp
 66vFfmto/Ph3vviVGr6vvT1HLFj55Wy95BEXHAn9PJ+vLT9y/WXRj5Zg5yZ18ffc4eOQz/
 n8wLVb8FC4Uk0p9Qbane3ruymlf4iYZQBmuqHJlg7W3NzzBrWGGSAl+8xPi6Re545U/LbC
 Yo8My/pcqT/RIaOLSZHvj7lJS5k+WOa1C5MYCNoeOwyjam53j8YdqzgPC8isXNIHh7eoAy
 knD6DXhD+UmmQ+fS0xdUcpfrxMAW6x6BrovW6HMS6Zj250hJGTaTf0L+BJIzfRmwY/xHSQ
 2o+Cki1r0gKxnoOvbNWF+BkOVE4HtmgUVdRbWYKdo4yimKSKc7t6kfj+l2s2U1X6NMBaKl
 K9Guk6lT/IovLBB0ZyVk6i9fmc3sUvI8Ao+FNU5R491y0d4RZaDh/h8D6w+Jwuh09/8WpT
 ZNHL20qTbs+N3+Hmvb2vd6t6OROMyd4y0va6JwyWmiHPFNbDI4fW9j5Br1VS9r6NNOzMQl
 dztQMTsokj0o1X17Gfss2owQczVJXfOGutxAFNRwu2hoEhWEEEJXSHN+UUyjCQGUuarzZv
 9Fiyp6FZ1zHaYU0vKKj3uZoHSghcGckigvPY/Sn031Gzc4aN7CkMeoEwOiWY3+m3yh1lbo
 bqeCSjU28qUVBwOI2xw4Xu4p/JnRFZ7hN9SEyTtSOJcdD9Gkg7xBgDllk=
Received-SPF: pass client-ip=2a01:b747:3001:201::23;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 1386affa9c..68272c5657 100644
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


