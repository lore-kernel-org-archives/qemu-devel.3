Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9558B606A332
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHSlRZGU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTYlV-0005Cg-B4; Wed, 18 Nov 2026 01:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlK-0005Bi-9u
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:19 -0500
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTYlI-0003zL-J3
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 01:03:17 -0500
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-71aea92f666so387302eaf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 22:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794981795; x=1795586595; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xl2/uj5l9DlpnL9JicC2LIldYUr6zKoBKpkVXIT8Bo8=;
 b=lHSlRZGUHPxXWu7rDQfGOZmvehHbZQCq7aLmzk+7LqdtXr/3j2inbo79XmG+R2GV2I
 DHL5gEC0UZcKFUEGxPyQxfqOn4iod0qQnGyjDNrQ/k3WYpIJRdsJyzJwaeB9SE7iWGlh
 tVM2K0HZ2sphluHNTOHXK8FN8b2MJenZnwLD8Znivqyls031MldnB0oVctnRvJaIk//5
 XrdE1CCIGPXDtckDI3Zzls/XK2YdZGREJpMPzD4MyY//2ZTtQUaoUNXWCHl1HCkrtpyk
 i65TMQRmM7Cw0UHYuJAlrG0Vt5/UID3EoINtPz+t+uagc9ipKtjgi8sxYsYnIKyU+xTo
 ThjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794981795; x=1795586595;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xl2/uj5l9DlpnL9JicC2LIldYUr6zKoBKpkVXIT8Bo8=;
 b=W5TU2/nHpEoXDJDgq4sga0sTPk60wHNFnzuMcY0uSBxz7O4sB7fIG7jGoLQtFGLZwB
 BLq4RjY9vdBnwW5cNXLstVQcyiTss4Up2NM38fNlDVEXq7QdoNFJC2cO3sMtIfv3xpn3
 Li9jBBirWPKTecDLm4ElMcAi+2TkeB2KaGneONVUG5bkfyGreEQcbBvD6t0+W54SukXe
 /q9BpGa51ZIt+0Lq/FyYC7HJAop/8b+PEvTVHmJ/1qOqwqr76GM3H3nnV7xbmZWMKxxJ
 BtvUrpT5g73xVoGv1lNCigjUmZGx8qCuoiIDA+q6I/coiAPQOjWDi3fRVMS/ttbF+Lxz
 XYig==
X-Gm-Message-State: APuU4Z/Iqa3qCKm8OoCL93ViCO9+56+fNjb405KiHEnng1pZ/qmCh/5P
 afPODJImL8wZGogBxwM8M026v8RF3VCdBVfcmvZY9XH1eX5F1p0x0YID
X-Gm-Gg: AYBFou0G3YmX35X4BbDw+eWG+9IrDqMzXqlS6duCY8REMOIfV7Qeqkjwm1/kN2WcBR8
 xFbwns3hJYFRi4ptLnkEiLsYJ5CZp/UAP6dWw224SNzW+hutcQfhzceECjjtgyvR5rFG0tPhscV
 TC/NiVfHC+7RcsOjbSgfV27jJIAxM7j7KEItuG0elTLa2rgEOebpRCIgPAARq7Xgjv+Aq/+MBDb
 YIqDkKbk9IOc1bfr8kU4W6TLIlBrNtnK8QuA/elGrJPICmq8V1SyWaTh3YPxCAXUfK1XmiiLosZ
 pYKRZMuL4y0hlFy4qjZLjG/TlknYQ5y4j1bPTcNR60pGWfSg5S98R5oG5nGzNYoCVdUOxKYSKwP
 /LtydnPckt+7wCHpNvBq1i3OO/sqRcQCPx+IsrnWjb/GN70cUlNxv/TTOFIRp/46GJrVj/WtOyR
 H8m5GVvuuPSxsfbr3SFplA/M+8bixP0UkXPr+gEMQ9ekpHwsH/VMb9JB9HIwSI5aqhuoOWo7hgJ
 7z6f68mcVQIeNQwOMkHT+c2oLJwhRDC4iDST7SDl9I9nznY/anHrCdJMzZ+4uICN/SV0BHBqP10
 bdlTlTb0U36nEalOank3T0XBzFQ=
X-Received: by 2002:a05:6820:16a0:b0:71b:187f:1d05 with SMTP id
 006d021491bc7-71b187f2097mr1273431eaf.68.1794981795174; 
 Tue, 17 Nov 2026 22:03:15 -0800 (PST)
Received: from [127.0.1.1] ([2605:ad80:33:509c:ff29:6c8b:a81b:ce71])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4b74372cb6bsm1358721fac.4.2026.11.17.22.03.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 22:03:13 -0800 (PST)
From: Andrew Nguyen <xmphyr@gmail.com>
Date: Wed, 18 Nov 2026 00:02:53 -0600
Subject: [PATCH v2 2/2] target/i386: check hardware acceleration with -cpu
 host and scalable error
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-4836-cpu-host-error-v2-2-ba02bb640d9d@gmail.com>
References: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
In-Reply-To: <20261118-4836-cpu-host-error-v2-0-ba02bb640d9d@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Nguyen <xmphyr@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794981788; l=2033;
 i=xmphyr@gmail.com; s=20261115; h=from:subject:message-id;
 bh=IZ8lIXL26iA16ORR+IngSnn/rMP1mNzjWyTWSalCn8g=;
 b=ccqZBxRmI9IKEe09TTiGb50yzzMv6W0O/dW3Vh+8zjGESB9FpawhfruFHZkxCJj2oiQ7Ray0H
 b6i/ACP5xA9BfW4JnAL6O6qfrX1hFsmgBylJatylE5Q5gBjMvdl9g21
X-Developer-Key: i=xmphyr@gmail.com; a=ed25519;
 pk=NNmtCKBlfBcUb+tQiMXr0u4Z3W1r0gSDovSDVTzPWXE=
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=xmphyr@gmail.com; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Added an additional check with -cpu host: that a hardware accelerator is
enabled. The error message for when a hardware accelerator isn't used
gives a list of supported hardware accelerators. This list is made more
scalable in the form of a separate function that is substantially easier
to find and append later down the line.

Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
---
 include/system/hw_accel.h | 10 ++++++++++
 target/i386/cpu.c         |  8 +++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index f0c10b6d80..04608073f7 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -54,4 +54,14 @@ static inline bool hwaccel_enabled(void)
         || whpx_enabled();
 }
 
+/**
+ * hwaccel_names:
+ *
+ * Returns: String of supported hardware accelerators.
+ */
+static inline const char *hwaccel_names(void)
+{
+    return "kvm, hvf, whpx, or nvmm";
+}
+
 #endif /* QEMU_HW_ACCEL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7dd5535f80..375a4453e4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -25,6 +25,7 @@
 #include "cpu.h"
 #include "tcg/helper-tcg.h"
 #include "exec/translation-block.h"
+#include "system/hw_accel.h"
 #include "system/hvf.h"
 #include "system/mshv.h"
 #include "system/whpx.h"
@@ -10227,10 +10228,11 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
         return;
     }
 
-    if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
+    if (xcc->host_cpuid_required && (!accel_uses_host_cpuid() ||
+        !hwaccel_enabled())) {
         g_autofree char *name = x86_cpu_class_get_model_name(xcc);
-        error_setg(&local_err, "The '%s' CPU type can only be used with KVM,
-            HVF or WHPX", name);
+        error_setg(&local_err, "The '%s' CPU type can only be used with "
+            "hardware accelerators %s.", name, hwaccel_names());
         goto out;
     }
 

-- 
2.43.0


