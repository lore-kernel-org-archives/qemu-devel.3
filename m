Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A275C27C53
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEonJ-0005YU-0k; Wed, 05 Jun 2024 07:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEonH-0005YI-7y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:27:03 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEonF-0003NT-Ej
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:27:02 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-57a31d63b6bso2890090a12.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586820; x=1718191620;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uQY2cD/0GprlA87LnBKBQ1RwhiZWI8cYgU0dNAemlU4=;
 b=QKChFFyIiXUn0wrYxiYnAeIJDA0EOvRDnPK7T4jSeq34W96PAwwX91Gc0pNBXuvZYu
 lvHB7/2XY4EGOzhXzB0kkt5pIJ1Cj9CrFiF49LMzjpcfFPYAunOkXBshAglZZglKEt53
 sU80J3D9fecbKejWu30kqfAaF16NbW6716ny4CS+Q9o3zWgtRTunsxWaWPnTE3ol+lFV
 jTVymrkDuYLWSMhnxCQ1MFPv/nDWJajDoK1BZjo4Me+zWgnBRjjx0OJQ3sT+TD2JznJr
 anJ7SdM9XiNOu6zut2lG4qdxfkrgIQnljgvIXwCVC5m5CLNOhRaTXf26yrukcVgAG+xh
 UgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586820; x=1718191620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uQY2cD/0GprlA87LnBKBQ1RwhiZWI8cYgU0dNAemlU4=;
 b=DW1p0RGgGGX35iIpbwyzuqUlHo2k0+c9UgFRpG+5WDeZww2Hk0yDdNYJ5adoTR01sf
 uWOl6laPt/gPbCGod370XIum05h6Jkowfy2qNHwvimA0RrSRql38MkrPL/Y4mpgcAQ7O
 cO/G0nBJO6OQjstTYRK+APWwwsCBxFVuoeOzlWwBXAHNUm+4w/O77Or4KFq3bbfCIBJN
 tGmZKzadhYXenQvuYHVvEFqqhh1i/aqwb7k2BKD73ZyJuo7kxdoVSEG7W+Mooc2sAQhq
 d3X/mteCnpSCYfk+0ZVLBfd3IFAC/GEosoW2+VxqFNeWy77320PX4moE9QsQz8XoG3U+
 p9Rg==
X-Gm-Message-State: AOJu0Yy7dBHmzEj6rXGllb22ZX2xHc0B0j+3bKd1O6RpM2r2BvMuCSpq
 DWxUqhD8+nZyiKM9j0V65a3cpa1cLgrsf5kalH7tYG5BvvvXFWjauAUjTSH+Djxbg3ozoOiSMdc
 =
X-Google-Smtp-Source: AGHT+IFH/01QCtamGICFCw0b56PQUC7P70H51nnXXui4HqnCm+hSOuApTn6THfeCGWBqk9dCgpV6ZA==
X-Received: by 2002:a50:d6d8:0:b0:578:5771:dc2c with SMTP id
 4fb4d7f45d1cf-57a8b69d84amr1867720a12.3.1717586819693; 
 Wed, 05 Jun 2024 04:26:59 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:59 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v3 6/7] i386/hvf: Updates API usage to use modern vCPU run
 function
Date: Wed,  5 Jun 2024 13:25:55 +0200
Message-Id: <20240605112556.43193-7-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::529;
 envelope-from=phil@philjordan.eu; helo=mail-ed1-x529.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

macOS 10.15 introduced the more efficient hv_vcpu_run_until() function
to supersede hv_vcpu_run(). According to the documentation, there is no
longer any reason to use the latter on modern host OS versions, especially
after 11.0 added support for an indefinite deadline.

Observed behaviour of the newer function is that as documented, it exits
much less frequently - and most of the original function’s exits seem to
have been effectively pointless.

Another reason to use the new function is that it is a prerequisite for
using newer features such as in-kernel APIC support. (Not covered by
this patch.)

This change implements the upgrade by selecting one of three code paths
at compile time: two static code paths for the new and old functions
respectively, when building for targets where the new function is either
not available, or where the built executable won’t run on older
platforms lacking the new function anyway. The third code path selects
dynamically based on runtime detected availability of the weakly-linked
symbol.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 106ac5cbf6..2d0eef6cd9 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -427,6 +427,27 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+static hv_return_t hvf_vcpu_run(hv_vcpuid_t vcpu_id)
+{
+    /*
+     * hv_vcpu_run_until is available and recommended from macOS 10.15+,
+     * HV_DEADLINE_FOREVER from 11.0. Test for availability at runtime and fall
+     * back to hv_vcpu_run() only where necessary.
+     */
+#ifndef MAC_OS_VERSION_11_0
+    return hv_vcpu_run(vcpu_id);
+#elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
+    return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+#else /* MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0 */
+    /* 11.0 SDK or newer, but could be < 11 at runtime */
+    if (__builtin_available(macOS 11.0, *)) {
+        return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+    } else {
+        return hv_vcpu_run(vcpu_id);
+    }
+#endif
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -455,7 +476,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
-        hv_return_t r  = hv_vcpu_run(cpu->accel->fd);
+        hv_return_t r = hvf_vcpu_run(cpu->accel->fd);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
-- 
2.36.1


