Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13F6C3DA7E
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYUZ9-0004y0-8h; Mon, 29 Jul 2024 13:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ6-0004nN-Pt
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:44 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sYUZ5-0000JT-5Y
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:53:44 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-264a12e05b9so2430360fac.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722275622; x=1722880422;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFgFtJisZmDduK/TVKWagBehgT0Nl+9kjWGTzeVvu0Q=;
 b=Yg+vus3gX9zFZwcQ4McID+YPWmPxsdvOkUva1jvMSIRa9wBq73SJcZk/DNQvR4SIdI
 SQsBsKM2f0o+rcMOx9jRssX8PrXlh1/GK/t9blKF787iUTaZMx2R/Tk9boxvV16GBwK2
 q3Ye9aaF5mcrZqEdcTnvLiLhM/qWVvfO75Nf0a+T9Buzim5xaxJGMwApGJ3ofx5iZWbi
 CR8fJuG491OlyyNG7R9cCqQKq/BmuKwWnbMHA16qOF0ujPtG4Rod31oVgW+wYLDXRE5y
 YE8lMFhx4nq8VTs7jhqcDFsMahpkiDM/C7RLlsAWnWVjYHWf/c2u9l0t0+EASKuI7Ry8
 Yjiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722275622; x=1722880422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hFgFtJisZmDduK/TVKWagBehgT0Nl+9kjWGTzeVvu0Q=;
 b=SNeM3FQ87pG+psQmopn02lXexQ7Ifot/0B/GBkc6bUqLIRWMtFrDSTmuMXrVmB+dAZ
 Fskrft8Ant1nuWaoDlPiT6xd9otC7jnc7BJCflXHr0ZzzwrrIfloo9Nxulg8KK5Pqkko
 bCz2GEHbh1/LGfu1kyDqzsKygfmwh11oI9FhDs4MErcXiXx2hTdx6MSd03Kgt3hOGIlc
 7tIjARosQKiDaIcshOin37DggwAlUDVDV2uwZvi3EIVXZDuPMgRurVkxVKil9RkdKDRK
 mIm2T0yL1I2lUri6hrSQHgkiomJV78YhnYIl1EWClfra7t2xzedT+MXgZDhcBzrhbUwb
 EfjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf125zCcCyLZUGkL64cYhSG8kFmLkab2C75NlOWPlYjrVXQ+pl3r2eYsOULGUZ+3qET8N78m2XqIa2B5tKpb3PE0jModE=
X-Gm-Message-State: AOJu0YxbJ46ESJCNTk8rtpOcksY9DO5Zf7HUrvA8S2jIzLn2ig12iWnH
 n5tCgcYUq1fol32GiFdpC+wyi1TznPNglEbpqCEh0OoLqaAep+2Kq5Zk08PEtm4=
X-Google-Smtp-Source: AGHT+IEEHsp/lmXmSHHovi1+fg0xRgYEy80myLMapMQmqibrBOgTbC812oSZx7NLC3nkkIiroz4yMA==
X-Received: by 2002:a05:6870:519:b0:25a:eca3:6b5e with SMTP id
 586e51a60fabf-267d4cdd92emr10312659fac.9.1722275621922; 
 Mon, 29 Jul 2024 10:53:41 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c71b15sm6303141a12.18.2024.07.29.10.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:53:41 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v2 09/24] linux-user/riscv: implement indirect branch tracking
 prctls
Date: Mon, 29 Jul 2024 10:53:11 -0700
Message-ID: <20240729175327.73705-10-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240729175327.73705-1-debug@rivosinc.com>
References: <20240729175327.73705-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=debug@rivosinc.com; helo=mail-oa1-x2e.google.com
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


