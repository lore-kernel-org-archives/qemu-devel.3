Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E3FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Ab-0000py-6i; Thu, 25 Jul 2024 19:46:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AQ-00005g-6C
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:39 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AO-0005LY-Gp
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:37 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-70938328a0aso212303a34.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951195; x=1722555995;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFgFtJisZmDduK/TVKWagBehgT0Nl+9kjWGTzeVvu0Q=;
 b=xj706uYh9ZCe2IEFcIETPrOvpjR7MDL0latOS4E1pSF6IqQN5G2jQBLsvq+ODFqFsc
 PEsEoiNmCsQnlUJHgFxXnjsnkHyvVg/kdY4fg83kt/94ZvRJ8kqf5B0ciV54fd1MSJ0J
 T0+uOGzqKp5bhl1jb4ZQonhIqf4TCm+Fg1VMhAymnjLw18ZjNesC6FIKnT5L5uBGRmEZ
 2+HzT/2jEQc7Pycux+eFc9hF46aYK57Kd24IFD9JF8TsRaEGnQ/m1qz5rvTNoSAiv7G8
 YuUgYW9ifpEuPwEG1cnH6EET3MSKT0c2PZK+e0tPIkk2v7JbaHDT+9WUdUZ4W86+BPWA
 oxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951195; x=1722555995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFgFtJisZmDduK/TVKWagBehgT0Nl+9kjWGTzeVvu0Q=;
 b=e8J2ttyAlehtOX7fgbY8njY6qZ5cTxYZXfZOnjuqEzAZx4ykDuZENJUOoizIZp2Yd8
 QinZgz3zdMYOsiIicHxuHjgDvU44m7g++B167199Q1WpWt29uXZrH43S6wR1oALJnP7k
 f2UEZVSqAN7A3X2HoNjov999ARxslHkUgccPqPa+d2GhWaU2KfDtCIKGigsBiCiq/Wks
 3Ma5c43pcG1ugmNBfVyXUJ8u4qAoaetYSI6p6HKv7CD3ulhxDTpnneufbXKRJqvDFV/F
 hkcJ0U8oNX1g0xdRSyzfDoNEQ1e2+nN52PjaX6DJKglnPZQcymTvJ4R5i8QKJXzQVs1X
 vbFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlKj6lmZO4KSM1rQToEiz/W3XuvHk1Ffz7nRIXuYB/NXOT7ry4cu6SNo/8veRDYSPI2TCjsfewa755MAG/emFBI5Tgm2I=
X-Gm-Message-State: AOJu0YyXYyxiHpxBRTHKLajglw2Dycq+Sk0HyYaw4OgYN+oUA49LJKy/
 WzWlS5qW4WMIzxYAFIEkCAY6nKmRGrdoE6AvmMw2i1Rdt0wLhh6E+U0Ts15V9HM=
X-Google-Smtp-Source: AGHT+IFbvynicoEyXFBjazSX2AbqmrA7N2ek8na4f8LxgVxjG3lJzvKH7r5eWOM2ZBLpc9vAC90DXg==
X-Received: by 2002:a05:6870:89a3:b0:261:1046:66fc with SMTP id
 586e51a60fabf-266cc0efd61mr4010498fac.4.1721951195155; 
 Thu, 25 Jul 2024 16:46:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:34 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 09/24] linux-user/riscv: implement indirect branch tracking
 prctls
Date: Thu, 25 Jul 2024 16:45:58 -0700
Message-ID: <20240725234614.3850142-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=debug@rivosinc.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Implements indirect branch tracking prctls for riscv. Setting and clearing
branch tracking prctl simply turns on/off `ufcfien` field in `env`.
tb flush is needed because branch tracking itself leverages tb creation
logic.

locking branch tracking (forward cfi) is not implemented yet (no need yet)
but added for completeness (kernel patches have this prctl)

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
---
 linux-user/riscv/target_prctl.h | 43 +++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/linux-user/riscv/target_prctl.h b/linux-user/riscv/target_prctl.h
index eb53b31ad5..d7f9f954c9 100644
--- a/linux-user/riscv/target_prctl.h
+++ b/linux-user/riscv/target_prctl.h
@@ -1 +1,44 @@
 /* No special prctl support required. */
+#ifndef RISCV_TARGET_PRCTL_H
+#define RISCV_TARGET_PRCTL_H
+
+/*
+ * -TARGET_EINVAL: Unsupported/Invalid flag for this architecture
+ * -TARGET_EACCES: try to set an already set CFI feature
+ * -TARGET_ENOENT: CFI feature is not supported by CPU
+ */
+static abi_long do_prctl_cfi(CPUArchState *env,
+                                 abi_long option, abi_long flag)
+{
+    if (env_archcpu(env)->cfg.ext_zicfilp) {
+
+        switch (option) {
+        case PR_GET_INDIR_BR_LP_STATUS:
+            abi_ulong fcfi_status = 0;
+            /* indirect branch tracking is enabled on the task or not */
+            fcfi_status |= (env->ufcfien ? PR_INDIR_BR_LP_ENABLE : 0);
+            return copy_to_user(flag, &fcfi_status, sizeof(fcfi_status)) ? \
+                   -EFAULT : 0;
+
+        case PR_SET_INDIR_BR_LP_STATUS:
+            /* if any other bit is set, its invalid param */
+            if (flag & ~PR_INDIR_BR_LP_ENABLE) {
+                return -TARGET_EINVAL;
+            }
+            /* set or clear branch tracking */
+            env->ufcfien = (flag & PR_INDIR_BR_LP_ENABLE);
+            tb_flush(env_cpu(env));
+            return 0;
+
+        /* locking not implemented (also not needed for qemu-user) yet */
+        case PR_LOCK_INDIR_BR_LP_STATUS:
+            return -TARGET_EINVAL;
+        }
+    }
+
+    return -TARGET_ENOENT;
+}
+
+#define do_prctl_cfi do_prctl_cfi
+
+#endif
-- 
2.44.0


