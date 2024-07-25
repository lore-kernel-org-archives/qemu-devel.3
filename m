Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C622C52CD8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:49:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Af-00018h-Ff; Thu, 25 Jul 2024 19:46:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8Ab-0000qO-6X
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:49 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AZ-0005OZ-Cs
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:48 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d23caf8ddso378224b3a.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951206; x=1722556006;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=266neMCz6T2Ay7h8fQ0tNZU+3Glrf37EuuzFIpKJGMw=;
 b=V40ovafz2wZW7akzOmpRyHCleewJ91KSgIJRblUXFYMDWVi02hGh7AR8K5kRkR/q93
 mr4OM3L3bIGfpc+wYmbiRUrlwY456UA1ed3sXMnhX7XgF+AHtqjMGAXWCnOq7oT8rbBa
 iRcm13Sk/Z+JiY80PONbStuHtoyAJeN90JxDf4nJ9KKG4tVte0KSvdXTQlkN4zF3mkKm
 fOL/wEElNs1aieieuzUE1B/Y8aVvETRaFzBDKU9W8Nt53zOpLvNnUOHeRkt0+LTh2DeW
 XLMW+lSO/Izix0Nn+5Ufr+eXd4JlQQzHqDK1nmXY4Im1o344BTxx9BMug7k8vqbhisZ6
 /1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951206; x=1722556006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=266neMCz6T2Ay7h8fQ0tNZU+3Glrf37EuuzFIpKJGMw=;
 b=tNTTd+q6jgdWWIfiQdFYe+cFuUn1lquy7fssprGtgv9VQa5KlWgEPnzCyC56GjJqcN
 6KQkX5Pph1lESP3aJ749/V0vXUeprZCddQmD0VTF0Oy6hRbqf0loc5YK6b+hTQ8+s1rO
 eqQxR68G7CMKEWKwVW3TOykQRS7/kC3vVVaZ8iOFeLS5OlvAROuo7lGBsLGS9ww60AJD
 CJL6cKfFMyplh8tHV8L3yRCDGW0wcqSmAbZs3bG4OkbJXqijcqrVQP3mUG3vjOUvZqsx
 Xk9CRMEpqS36D8FE4l/+RpGY6lhj68E4oSTMEmAzpPQP6ZLs3IZi3rUFGlxoppOgtJFY
 oyYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVajzvoGRFdv5//eUYXjTb7RYFP1DUGePsXz0/r/DHXebVJrqAxdV73RHQwlU25Cl6D/w54Vw/d/1BY+Uy8iAmVwOCXhl8=
X-Gm-Message-State: AOJu0YworJgMSG89qgP2yYTrkciw9bHABGqseot3eY7+7aVub2gdWEnK
 JQ1+O7BizPH4sisgnrStjaUZrtcUHdcwScsFw4l/le/iZvCHc6TWHufq7+7PM5k=
X-Google-Smtp-Source: AGHT+IGR+8jNZStWg61YEuAhAHicYqabmloH5slM50NZuNqDWNNWS20+SNGQsneM0/ca3rQERQzNdA==
X-Received: by 2002:a05:6a00:21d2:b0:706:5d85:61a5 with SMTP id
 d2e1a72fcca58-70eae8e4676mr4146460b3a.8.1721951205860; 
 Thu, 25 Jul 2024 16:46:45 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:45 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 17/24] linux-user/syscall: introduce prctl for shadow stack
 enable/disable
Date: Thu, 25 Jul 2024 16:46:06 -0700
Message-ID: <20240725234614.3850142-18-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42d.google.com
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

Each application enables shadow stack for itself via prctl. Using prctl
codes as proposed in riscv cfi patches on kernel mailing list [1]

[1] - https://lore.kernel.org/all/20240403234054.2020347-1-debug@rivosinc.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
---
 linux-user/syscall.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index ec157c1088..f879be7cfe 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6295,6 +6295,18 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
 
+#ifndef PR_GET_SHADOW_STACK_STATUS
+# define PR_GET_SHADOW_STACK_STATUS     71
+#endif
+#ifndef PR_SET_SHADOW_STACK_STATUS
+# define PR_SET_SHADOW_STACK_STATUS     72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+# define PR_SHADOW_STACK_WRITE          (1UL << 1)
+# define PR_SHADOW_STACK_PUSH           (1UL << 2)
+#endif
+#ifndef PR_LOCK_SHADOW_STACK_STATUS
+# define PR_LOCK_SHADOW_STACK_STATUS    73
+#endif
 #ifndef PR_GET_INDIR_BR_LP_STATUS
 # define PR_GET_INDIR_BR_LP_STATUS      74
 #endif
@@ -6488,6 +6500,9 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_TSC:
         /* Disable to prevent the target disabling stuff we need. */
         return -TARGET_EINVAL;
+    case PR_GET_SHADOW_STACK_STATUS:
+    case PR_SET_SHADOW_STACK_STATUS:
+    case PR_LOCK_SHADOW_STACK_STATUS:
     case PR_GET_INDIR_BR_LP_STATUS:
     case PR_SET_INDIR_BR_LP_STATUS:
     case PR_LOCK_INDIR_BR_LP_STATUS:
-- 
2.44.0


