Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CD606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=m93TdaKW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4n-0005AC-Jq; Wed, 28 Oct 2026 16:16:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4h-00055v-Ka
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:43 -0400
Received: from mail-dy1-x1330.google.com ([2607:f8b0:4864:20::1330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4g-0002Gb-38
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:43 -0400
Received: by mail-dy1-x1330.google.com with SMTP id
 5a478bee46e88-36661f953e4so2232841eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218600; x=1793823400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=obAwicYQArWnw8mdM95mb/RZp67/7GPYWgLKlbu+5L4=;
 b=m93TdaKWpxlq1SrL06/yZi3GhlLaT46g/ce3U12RM5aCmVTZ3LFuUEwbhCANuuO9GH
 4fvcXB/rOavcCzaHhmbsAKZhE7Mz1f6gVeAmCgQRPwChGhZWL1uqPPl9uka356ZE8kb6
 a2mAFe5uLjV5Lhv2LxHR5dVQO1rHCfWAEXIQY3OzMnjBZUMppuVPCs8YI9QTF64KWMCs
 Th/pQKSP8vCaxDjEfHvV7d0h0dq992102eDbR43GS30F61P7cmT2ht3JIODjBZPHd1OG
 FnGTpFjY7ekY9M73Fgs+wPLQmKzpwFfIuFcV/V7cLm3TJ1EOyp4kEysacE59chgNPAlx
 KERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218600; x=1793823400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=obAwicYQArWnw8mdM95mb/RZp67/7GPYWgLKlbu+5L4=;
 b=e7m5juUIDD9APBmuOoMW4TCZMHoUQNvAppX5le1MDMhVVmGDQ37JpUoVjfyoDmzERi
 gHHUBa9DUH2JHPl+PAHySAy7gbwpP9I8GTGeORGrW+Qp2r7/gnmLiaOo6LbUELVw5CuE
 7PmakJ0StDtMv7jQ4DmA+QMvAZ0cybb14pyblyYyY+9F/kHH0+zVva5KR4P6PlJnwgrq
 YgGc0rvMTMnRY3db44ZDE4zLiLyMEN+WFOtdx7oG5zi5KNN8Leu5Uur+nAT0jx2EgMOR
 8juTdGSzEvYhAdirBAeKW3BLBjvELpgDgex4fnm+15BUYJQYom2AxH77yZGlKChot1WP
 cXKw==
X-Gm-Message-State: AFq9FYIdcmSullFCOsUaJT6aiAMKi3GqqByri1qFM7KOoLgcL0jPT8Dn
 paCgqohse1sYzA4Qc+qHcO3kKZO80jgLh2Y56UnyHvUcvfo7psF2+Mq3kw6+H48g
X-Gm-Gg: AYBFou124bMyTe1SETgubsusz3JjldutZOcemH7jN5YmU1drZMnvrL5HNR9gVQUnrXD
 Ju76w/RLGQYNq9IcPQqe3zmFiBdMpiMMhMTK7R2GIEZxBez4z7tj7rdsM8KIdrJueHzg2ocv05e
 AvAoGRSt23TaLQESPswMuWQoTy7vPdwve8jT8Se1frqVy+yUtCzuJgY6tnBQEBeFCnrIGxNksvM
 CfVS9mxLx/dEm2zfQiit9K4ubr9AXJ8pbrk6No/vxeLUQTBr7xnCcKlqgKXP0S9ZaztFkZgbOA2
 N0tlGgZfE5p+Smu/oHsYViEwY1BG0ZAy3ROEHQ2kpAXXUruvckXGtD6Y2DNBApBXm98VxDlgsqu
 /Rd1zCzaTfrJ6HuoCVGIGlG4t1x23TYY2UtyEVMFUoX9Amaa+GDxq0xnH2uSG3F5qS0DGrtS6+I
 vDL5kPK/7n/61ssSJIe8SXSz/6r/ResOVPWE0W4bUQBZexJ5vhPao3a9B1bKm4E847zSCrTE31V
 a2Mx6c0VUuZW7J0LhObm7xWSi8u0JuxSBDk3REXTNdcEAVz4flDaG5CM8+g1buH5IauqzrNcunz
 ol4nYvMpez+wR0yWn0+mOAiShL7jcjCHeImFN6LUKZk6FiAu
X-Received: by 2002:a05:7300:7312:b0:358:ec5c:bef1 with SMTP id
 5a478bee46e88-36a204773c0mr6758751eec.39.1793218599863; 
 Wed, 28 Oct 2026 13:16:39 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:38 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 05/12] target/arm: register separate max-v8 CPU types for arm
 and aarch64
Date: Thu, 29 Oct 2026 04:15:49 +0800
Message-ID: <20261028201557.2688-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261028201557.2688-1-luoyonggang@gmail.com>
References: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1330;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

max-v8 was one TypeInfo whose instance initializer was chosen from the
selected target at registration. Register both initializers, and let
target_arm() and target_aarch64() select which type is available.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 target/arm/cpu.c            |  1 +
 target/arm/cpu.h            |  1 +
 target/arm/tcg/cpu-max-v8.c | 16 ++++++++++++----
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 510fc9eeb3b..6eb55242980 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2695,6 +2695,7 @@ void arm_cpu_register(const ARMCPUInfo *info)
         .instance_init = arm_cpu_instance_init,
         .class_init = info->class_init ?: cpu_register_class_init,
         .class_data = info,
+        .is_available = info->is_available,
     };
 
     type_info.name = g_strdup_printf("%s-" TYPE_ARM_CPU, info->name);
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index add993ef101..3240a8633ee 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1203,6 +1203,7 @@ typedef struct ARMCPUInfo {
     const char *deprecation_note;
     void (*initfn)(Object *obj);
     void (*class_init)(ObjectClass *oc, const void *data);
+    bool (*is_available)(void);
 } ARMCPUInfo;
 
 /**
diff --git a/target/arm/tcg/cpu-max-v8.c b/target/arm/tcg/cpu-max-v8.c
index 65f851f2006..e819d07e6ce 100644
--- a/target/arm/tcg/cpu-max-v8.c
+++ b/target/arm/tcg/cpu-max-v8.c
@@ -121,10 +121,18 @@ void aarch32_max_v8_tcg_initfn(Object *obj)
 
 static void cpu_max_v8_register_type(void)
 {
-    static const ARMCPUInfo max_v8[2] = {
-        { .name = "max-v8", .initfn = aarch32_max_v8_tcg_initfn },
-        { .name = "max-v8", .initfn = aarch64_max_v8_tcg_initfn },
+    static const ARMCPUInfo max_v8_aarch32 = {
+        .name = "max-v8",
+        .initfn = aarch32_max_v8_tcg_initfn,
+        .is_available = target_arm,
     };
-    arm_cpu_register(&max_v8[target_aarch64()]);
+    static const ARMCPUInfo max_v8_aarch64 = {
+        .name = "max-v8",
+        .initfn = aarch64_max_v8_tcg_initfn,
+        .is_available = target_aarch64,
+    };
+
+    arm_cpu_register(&max_v8_aarch32);
+    arm_cpu_register(&max_v8_aarch64);
 }
 type_init(cpu_max_v8_register_type)
-- 
2.55.0.windows.3


