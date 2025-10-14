Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E176CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJp-0002US-LY; Tue, 14 Oct 2025 16:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJX-0002IR-FN
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:11 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIz-0005MO-Qf
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:08:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b62ed9c3e79so3704276a12.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472451; x=1761077251; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N1IVZ3uKrUQIbWrbAymlLjmz7cA3vDbPNt0Sr7mJiz8=;
 b=HX5G3EH65WbipBL2h6yotLPa2ZTg1YCdgapj8OFc0vi0oQKEP4Mi9UWViG9NoizA0Z
 /nKi4hPb46oxQOVjH67F4WcfyiYu1GiZbnFlcGXIkzi1REizgobLx0aGW8G2zw/LRwJf
 NCB2/tuqH5Fb2WooxmpsWimKaw/9CvX41dV0aCWo/n1r8G1QkUtV3kOidxOt/UBrUP+H
 SFEFTz2rYriZGob9AkLOtnuQLakdr24DGgTe4Q0iHym7GFKBpGA0jeFrK98LE6JxWYEy
 Tp8Ont5AXDykwQuiu46SIpr1KjAwtiNs47zPDy/HNpt+CYqZsWPj2iVQ/TeQbQxxF3Vm
 LyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472451; x=1761077251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N1IVZ3uKrUQIbWrbAymlLjmz7cA3vDbPNt0Sr7mJiz8=;
 b=wBuqdvd8JTam6Ebwcsnqulpt3beB3alA/2a4dyRYIC4OLZNOV56eSgd/MIYL3/GDUN
 NHSD/UtOdPIzKsvL+8YNrnV0KailJDMFWjj56MbQnF6DCmyTmhKERt1JjFMgtwtH/Cyq
 1f2dNu4zEYEFdni+kUhpr0HqAJxi0GkI4qSKHi3mXzkEzaPStA/BgwojJCoypE/WVakS
 HQiDV6LIBEpO+MymD3yvsLj+rTFnoJxWu/g8igZQOkP+Frtc+tZLUP8Vb27Suc4hacfM
 QCAb203u430OXHvNp+UVMkdOINp6cToYTp1b0kovHv8xafTmCgOlWz9mdtktne6+upMM
 oGgQ==
X-Gm-Message-State: AOJu0Yxbore0AbMBka3WxAO3HX0Q0EZC6l6ituMERuzGS9vI7taLRgTD
 P1KfoKt3Bupq8SLtAl53qDrVloDGi1o4ch2u3H41g1b6e8ybmBSXHVdRus+q2MjTcoUw4h8g1N7
 3e67cWeQ=
X-Gm-Gg: ASbGncswjLYb+mHrojsFNk4uMusfBexjuilFpESk6zKnJ0ER0SispDw2hdW4X9tnYdb
 KKFrAeXRmAmi+Wx+LW5QAtvYeAekVLn8MLdleAJH4sc7nQCZUh1qIFklV4pmt8pxp/3KsBExBwQ
 KMSfHMxKY8RiPkHmYYArGjFiYreMaFcZa97/ZCL5v1049Nd4YHklKo9oUiyPFDCs7TIsnS6SGY8
 HdcFC20n1c1A2FZd/jQGkSnyDdPev/t7FOYai6E0uiwQ+/aj+fYCf19vOOuQYJkzjpvXyHb1L9m
 WYFO5zQYFRvsLXf+nUI1c+18kw/+OcyipslHHetjdT1FtgIX6u2lvQDhLQMVgN21dd3J6lYkEwQ
 9YxnGbP3wFgoi+F64kyUKD+b1I8NHuC7ulFK+nr0o39RXRFtNJJiibG0BLW/QMg==
X-Google-Smtp-Source: AGHT+IFDvHlok2zQd1PsQyuJO3an2yvn5qXNTLDLWg61gzibz7gIzHKbVNSKvIBF9a2+K9A5sMIhYw==
X-Received: by 2002:a17:903:1ae3:b0:266:9c1a:6def with SMTP id
 d9443c01a7336-2902724dc87mr288760855ad.0.1760472450832; 
 Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 16/37] target/arm: Migrate cpreg128 registers
Date: Tue, 14 Oct 2025 13:06:57 -0700
Message-ID: <20251014200718.422022-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/machine.c | 50 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 44a0cf844b..2cc6234832 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -939,6 +939,34 @@ static const VMStateDescription vmstate_syndrome64 = {
     },
 };
 
+static bool sysreg128_needed(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+    return cpu->cpreg128_array_len != 0;
+}
+
+static const VMStateDescription vmstate_sysreg128 = {
+    .name = "cpu/sysreg128",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sysreg128_needed,
+    .fields = (const VMStateField[]) {
+        /*
+         * The length-check must come before the arrays to avoid
+         * incoming data possibly overflowing the array.
+         */
+        VMSTATE_INT32_POSITIVE_LE(cpreg128_vmstate_array_len, ARMCPU),
+        VMSTATE_VARRAY_INT32(cpreg128_vmstate_indexes, ARMCPU,
+                             cpreg128_vmstate_array_len,
+                             0, vmstate_info_uint64, uint64_t),
+        VMSTATE_VARRAY_INT32(cpreg128_vmstate_values, ARMCPU,
+                             cpreg128_vmstate_array_len,
+                             0, vmstate_info_int128, Int128),
+
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int cpu_pre_save(void *opaque)
 {
     ARMCPU *cpu = opaque;
@@ -971,6 +999,12 @@ static int cpu_pre_save(void *opaque)
     memcpy(cpu->cpreg_vmstate_values, cpu->cpreg_values,
            cpu->cpreg_array_len * sizeof(uint64_t));
 
+    cpu->cpreg128_vmstate_array_len = cpu->cpreg128_array_len;
+    memcpy(cpu->cpreg128_vmstate_indexes, cpu->cpreg128_indexes,
+           cpu->cpreg128_array_len * sizeof(uint64_t));
+    memcpy(cpu->cpreg128_vmstate_values, cpu->cpreg128_values,
+           cpu->cpreg128_array_len * sizeof(Int128));
+
     return 0;
 }
 
@@ -1065,6 +1099,21 @@ static int cpu_post_load(void *opaque, int version_id)
         v++;
     }
 
+    for (i = 0, v = 0; i < cpu->cpreg128_array_len
+             && v < cpu->cpreg128_vmstate_array_len; i++) {
+        if (cpu->cpreg128_vmstate_indexes[v] > cpu->cpreg128_indexes[i]) {
+            /* register in our list but not incoming : skip it */
+            continue;
+        }
+        if (cpu->cpreg128_vmstate_indexes[v] < cpu->cpreg128_indexes[i]) {
+            /* register in their list but not ours: fail migration */
+            return -1;
+        }
+        /* matching register, copy the value over */
+        cpu->cpreg128_values[i] = cpu->cpreg128_vmstate_values[v];
+        v++;
+    }
+
     if (kvm_enabled()) {
         if (!kvm_arm_cpu_post_load(cpu)) {
             return -1;
@@ -1209,6 +1258,7 @@ const VMStateDescription vmstate_arm_cpu = {
         &vmstate_wfxt_timer,
         &vmstate_syndrome64,
         &vmstate_pstate64,
+        &vmstate_sysreg128,
         NULL
     }
 };
-- 
2.43.0


