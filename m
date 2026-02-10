Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DB1EA811B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 13:55:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpoAE-00028S-OI; Tue, 10 Feb 2026 08:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA8-00020L-CW
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:23 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vpoA6-0006LC-Fz
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 08:52:20 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so82574115e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 05:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770731537; x=1771336337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IM/zaN3DN3FDZg2qGJSyS3KoNBrzk/mO9OYYTNEvs3Q=;
 b=tws5eV5d6jd17tvoUn/cKBFMcP68LSePWK+/+xUY8ES6rXnuCISSl3LS7Ga6MiTXnM
 4KAy3TjZ9gMIFFzxrBtkpn7O1TwKIo3zXIQagyz4Pd8nnsaY4IQwOLaDhYOKdFyAHzV/
 FusyZgASpsRYN4llxamMT6xxMjkhCNt9UV2U68HyAuQzC81ruwi8HiI0NipsXnsK/i1J
 8IM5OeTch8WbVP39CdbJkvqtOTTZ3GEE1V3XS2Kh8iGFobFUlBaOiHVsH5E5Beno78eo
 d24Ui628/IaqP4vUVd3oNQU0hyHewZAe6PAE3DgemS1g3nL/0O8HGNq45V3qeYL331Mv
 Ltyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770731537; x=1771336337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IM/zaN3DN3FDZg2qGJSyS3KoNBrzk/mO9OYYTNEvs3Q=;
 b=tt5wThod1cW5HDh82m9rFftI9hS2POQaFg8j7mcNLYbGL2jwFMLxZQnmX48ssR7xMM
 cnJdLezz3/KPi+zmJMo5RNT181vvT0yot/8eJ2e/NDP43qUldZc65Lv6z8BVcbSYEqKy
 +2q53CLIWyRv11b+PptrTUUeGsLZa5vKGkYlPYJRjT55L4zXDoWMfGw86+AUb6WzILUS
 2u7IOmCqGL1wEWR9I4DgMa8fXPX4eCxbsVUgNLDD0IRNOVr7N0XbeUCWQoLYDSZexXz8
 N43TlUklqH6GRltoljptfm3tvjInTkD4DD3DQ6g2l3kLVCueguJl83aIy+cLuQiQn+jP
 D/5g==
X-Gm-Message-State: AOJu0YyABzjQdz0UzKZiDOt1XUPWLvywVv/blWj4Q//waCMIKyYYhxIg
 kXx2ANRyq6AYbK8peos9fQ1Kh7nA3DwbLJLZQm61reubP6luh7TbChRQqYiDAEe2YC2EdWQpUMn
 6WE2K
X-Gm-Gg: AZuq6aIsppRN+V94gzwvU0Hi/dhocOuIvJK2Sf1huwF2jsJ6gOGMI0PRRXLVu3IpB8H
 vOp4CfpN0FqMPScOt2yxinMKPuoyOfiKCHnj71BDv8bmcu0F7l+zK+6HvucufqVYRwnJKNpw6BK
 dsU3OSHXEWojfyRM8FRhBQoB84BrWY9BAqaZ8BlMTfkcKXImJZuB1WOzxmT2ePWgNIQ/+/Aswdx
 3+zOyyKQyHLSfBDm1frcW8k/0h7JpOk0NmYbr5bilua3oB3EoC23L+TPo2GU8r9aVyr53WC+X83
 /U1IglLt17isDYxc1MsAqDhmSRUKXgU+KY0vlevujPpQ3qquAFbTrU/YWXU9uFAVtgPSa1btJr/
 NRAKCIUWcjGKXhOkJNXzO2/F3KULSKWIkKcNC1NpkG2uB9jAzCvmIEKVIpmA/rJjlklaUJ1Eh7X
 fGM9aX+cm27GpO6lvN1XrhyuXkOcpNETLlYM+v/EuOaplkfF0l08LgjRIiw9rnO4ow9v1INev7p
 Z3TUsAEtUf8QjOK1R4Y0Ld/ZB2YT6w=
X-Received: by 2002:a05:600c:3487:b0:47d:3690:7490 with SMTP id
 5b1f17b1804b1-483507e16b1mr32351755e9.9.1770731536966; 
 Tue, 10 Feb 2026 05:52:16 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77f9sm64344875e9.3.2026.02.10.05.52.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 05:52:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/26] whpx: ifdef out winhvemulation on non-x86_64
Date: Tue, 10 Feb 2026 13:51:51 +0000
Message-ID: <20260210135206.229528-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210135206.229528-1-peter.maydell@linaro.org>
References: <20260210135206.229528-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

winhvemulation is x86_64 only.

In the future, we might want to get rid of winhvemulation usage
entirely.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/whpx/whpx-common.c       | 14 ++++++++++++--
 include/system/whpx-common.h   |  2 ++
 include/system/whpx-internal.h |  7 ++++++-
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 0a6068fdde..c58344cb61 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -37,7 +37,9 @@
 bool whpx_allowed;
 static bool whp_dispatch_initialized;
 static HMODULE hWinHvPlatform;
+#ifdef HOST_X86_64
 static HMODULE hWinHvEmulation;
+#endif
 
 struct whpx_state whpx_global;
 struct WHPDispatch whp_dispatch;
@@ -232,8 +234,10 @@ void whpx_destroy_vcpu(CPUState *cpu)
     struct whpx_state *whpx = &whpx_global;
 
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
+#ifdef HOST_X86_64
     AccelCPUState *vcpu = cpu->accel;
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
+#endif
     g_free(cpu->accel);
 }
 
@@ -408,8 +412,12 @@ static bool load_whp_dispatch_fns(HMODULE *handle,
         LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
         break;
     case WINHV_EMULATION_FNS_DEFAULT:
+#ifdef HOST_X86_64
         WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
         LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+#else
+        g_assert_not_reached();
+#endif
         break;
     case WINHV_PLATFORM_FNS_SUPPLEMENTAL:
         WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
@@ -535,11 +543,11 @@ bool init_whp_dispatch(void)
     if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-
+#ifdef HOST_X86_64
     if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-
+#endif
     assert(load_whp_dispatch_fns(&hWinHvPlatform,
         WINHV_PLATFORM_FNS_SUPPLEMENTAL));
     whp_dispatch_initialized = true;
@@ -549,9 +557,11 @@ error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+#ifdef HOST_X86_64
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+#endif
     return false;
 }
 
diff --git a/include/system/whpx-common.h b/include/system/whpx-common.h
index e549c7539c..8f171d1397 100644
--- a/include/system/whpx-common.h
+++ b/include/system/whpx-common.h
@@ -3,7 +3,9 @@
 #define SYSTEM_WHPX_COMMON_H
 
 struct AccelCPUState {
+#ifdef HOST_X86_64
     WHV_EMULATOR_HANDLE emulator;
+#endif
     bool window_registered;
     bool interruptable;
     bool ready_for_pic_interrupt;
diff --git a/include/system/whpx-internal.h b/include/system/whpx-internal.h
index 041fa958b4..609d0e1c08 100644
--- a/include/system/whpx-internal.h
+++ b/include/system/whpx-internal.h
@@ -4,8 +4,9 @@
 
 #include <windows.h>
 #include <winhvplatform.h>
+#ifdef HOST_X86_64
 #include <winhvemulation.h>
-
+#endif
 #include "hw/i386/apic.h"
 #include "exec/vaddr.h"
 
@@ -101,12 +102,16 @@ void whpx_apic_get(APICCommonState *s);
 
 /* Define function typedef */
 LIST_WINHVPLATFORM_FUNCTIONS(WHP_DEFINE_TYPE)
+#ifdef HOST_X86_64
 LIST_WINHVEMULATION_FUNCTIONS(WHP_DEFINE_TYPE)
+#endif
 LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DEFINE_TYPE)
 
 struct WHPDispatch {
     LIST_WINHVPLATFORM_FUNCTIONS(WHP_DECLARE_MEMBER)
+#ifdef HOST_X86_64
     LIST_WINHVEMULATION_FUNCTIONS(WHP_DECLARE_MEMBER)
+#endif
     LIST_WINHVPLATFORM_FUNCTIONS_SUPPLEMENTAL(WHP_DECLARE_MEMBER)
 };
 
-- 
2.43.0


