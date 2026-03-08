Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81444EA8548
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMkz-0007su-SQ; Sun, 08 Mar 2026 18:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkv-0007kn-SQ
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMkt-0003Yy-WC
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:37:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-439c6fc2910so3360724f8f.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009466; x=1773614266; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i20vJNc5d6p6GTvYkEwQZHERtzs5jfNRGw8++gGe1Qs=;
 b=DGOnJmLXX/ABFBHwggaqwP2je1bFeHRuNOvHwkhjN4CM2X+Tkpy91526AGnAlSXUql
 OuKpbvXUxmqPjFlhDEq2kJbkEIJH+rYJQKNUeAu5d23kLfimSAQy/aKFoAC1oTTW/fVO
 CrZDixkO3W2ZdSy6bWmnwiqow+IcmwsQm5B2Vbyn+77weJq4csfi77oPDlMFRFfEK7c9
 fwOcvbChFsxbJ8MVxDcWGQW8kvaKdUZ2n2BhhaG2/cVIBnSNgN1MRNaqQQRuF9qmgwCJ
 G22wjQsQLh2PsQCL4bC1pXRQ0ip/1/Fz/THFQ/ml/tPHzsUxOYjSRWCPj5C2uZ56kxqK
 RQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009466; x=1773614266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i20vJNc5d6p6GTvYkEwQZHERtzs5jfNRGw8++gGe1Qs=;
 b=qfGB6NQDpBjfHwwwGD1DBNBsBo+p1yLVNyoFxmpNINr+0I+0xwbyUwC/+9eky3pexJ
 lBnIKE/rZWfv3WetUeIeh5jw0qUvwaWrjcMzM2EXZRtJnPglH5kZEvRg8remFz08x1f1
 8B7/xhWyPHWzC8nUdzG5RR5LC54/doRKsc360eq/VfZUdAAJmwj28js1mZ3mEQGRHYf+
 ClxhvFL0PtPM0OOuM3XNKjquYy9diilF2t9UOWQyO6nCTlaOZpih9jeEUmernx2HGQZZ
 ndL7YKJIEtVrBIj6sy75vCyMqStfKlEddHgPnQazmYnn786l29s1JOWBvgbXyKI4zUPP
 jPKA==
X-Gm-Message-State: AOJu0YxK01LlGR4DP10IUIY+t2vqSIoi7ck+GBp2jIgGoXt3UN/sQ4B3
 xY77l/IsXOIzG6Z5uG0rCwwB220mZeuWAzZqQwVKUuQ1RhV8GUWwPxNx48Z5YPwVHLp9fdH7wF2
 pW9gw4Qc=
X-Gm-Gg: ATEYQzwCrukS3j0FRskZFDBCiANIJHA935Hg7u0R5DTNHh/dWfttEdPCxgtVNnxLcZy
 wIiBU6ZjUohh8BeiFLKScE5SMamItuR6pYqdVZdJ+PtvUncjmYn/dS469IN5hxguvK1oADX+mZ8
 bUUNldxizKWK2MOap8Sj+t1r94k3fWoAQW2+qPN57fizzKtzC/p+g2r+aZBAaPShiYlHzepCkih
 5/sr51cUY1raWCyfeEbJPXMOC43yjYoWdjCOmLl7JDOs1+Opx+c1kVNGb5Ys71X5RtfnN0oRBqh
 aKW0zRwDSdYg7w/+cKlBgBGxvRVctYNWVc5DN9d2NIFY/jvdQYSAl8972Mwk9OOa1IMpHWtYQ3V
 r6htiGBmnA++5faWI9I5Zn6+LSvC45PnwMcVlfojpgzQRRAmPb9eXPght5y5PxAE2wTV9OVr4jl
 8QjH/foL8Ceh8F4nlMHldU4Nqly56ImXzOHE8c2Zvnl026d1WNcoV37iJVYfuFss2139mZg4r/N
 Kx43Q==
X-Received: by 2002:a05:6000:61e:b0:439:cbf3:4a8f with SMTP id
 ffacd0b85a97d-439da67a8c4mr17863014f8f.41.1773009466117; 
 Sun, 08 Mar 2026 15:37:46 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8dbb3sm19132623f8f.4.2026.03.08.15.37.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:37:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/49] hw/uefi: add variable digest to vmstate
Date: Sun,  8 Mar 2026 23:34:12 +0100
Message-ID: <20260308223433.25503-29-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Gerd Hoffmann <kraxel@redhat.com>

Add digest to vmstate if needed.  Clear digest before
loading vmstate to make sure it is initialized.

Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260304075954.584423-1-kraxel@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/uefi/var-service-vars.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index 94f40ef2368..5e3907118d4 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -37,8 +37,41 @@ const VMStateDescription vmstate_uefi_time = {
     },
 };
 
+static int uefi_vars_pre_load(void *opaque)
+{
+    uefi_variable *var = opaque;
+
+    /* clear digest which is optional in the live migration data stream */
+    var->digest = NULL;
+    var->digest_size = 0;
+    return 0;
+}
+
+static bool uefi_vars_digest_is_needed(void *opaque)
+{
+    uefi_variable *var = opaque;
+
+    if ((var->attributes & EFI_VARIABLE_TIME_BASED_AUTHENTICATED_WRITE_ACCESS)
+        && !uefi_vars_is_sb_any(var)) {
+        return true;
+    }
+    return false;
+}
+
+const VMStateDescription vmstate_uefi_variable_digest = {
+    .name = "uefi-variable-digest",
+    .needed = uefi_vars_digest_is_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(digest_size, uefi_variable),
+        VMSTATE_VBUFFER_ALLOC_UINT32(digest, uefi_variable,
+                                     0, NULL, digest_size),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 const VMStateDescription vmstate_uefi_variable = {
     .name = "uefi-variable",
+    .pre_load = uefi_vars_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
         VMSTATE_UINT32(name_size, uefi_variable),
@@ -49,6 +82,10 @@ const VMStateDescription vmstate_uefi_variable = {
         VMSTATE_STRUCT(time, uefi_variable, 0, vmstate_uefi_time, efi_time),
         VMSTATE_END_OF_LIST()
     },
+    .subsections = (const VMStateDescription * const []) {
+        &vmstate_uefi_variable_digest,
+        NULL
+    }
 };
 
 uefi_variable *uefi_vars_find_variable(uefi_vars_state *uv, QemuUUID guid,
-- 
2.53.0


