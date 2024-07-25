Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0F9C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8AZ-0000jn-KJ; Thu, 25 Jul 2024 19:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AQ-00005H-2s
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:39 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sX8AN-0005LJ-F8
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 19:46:37 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-70eb73a9f14so301642b3a.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 16:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721951194; x=1722555994;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k622JqYymJR6YovQS6GBPxe8YFj6SVEYXb2hrEdnpy0=;
 b=ssX27QBWv1EcvDr569E8HIWIgoa2bWV+prhTZSfhxJ2JIisZjOvUwNR8WHLyARDnd8
 wLYsPokYkhXesFV4H2vzdI+Tz9u3OPJ3UFB/910Qjqy72B2h5f43lvNVPdBGE+JL3G6w
 Vhq2DgMWIKUCrXjN+AwSoHqyWtYY7EF9Ty6W4JJ2Fu2bWGylS5+rB3bqoialIUt2dsUA
 8MxnjzVUqE+y+J5iK28g+/CEz9cBqBMmAO89s5l9/VCvjh0s6lHg3Cpp5XHhz8OP0jV2
 mDXZt3ftGQvU0yKNITq+KNU/b9LqeCw11mWZtT5fOkIDawbreiFTc0OVsAeWeqOl8I/x
 Iu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951194; x=1722555994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k622JqYymJR6YovQS6GBPxe8YFj6SVEYXb2hrEdnpy0=;
 b=ddVkOTidaLANQc74QnqAuCwP9PVVTVrvmW/gGIdiqbGIYj7uQsTyMrNtK87tDMOYMD
 2XFbsCAtt8AOc4reZoJ5rbRScSUJqo1Wi4gQJKBfoD0QVfPpH+9W4MIv644butYGlu1D
 vQ3dvshUzeB7w+IRTFz6mJXdsEHge2kKAwD5DqqHyoDEUhXVtD2RSQZ81j9nxsPTDm6A
 tux0WB3UE9tkVP4cdt3zAU2dxcinE8G/ofgxbDMpxgquWrxSmYizIgjDq+nwJnQnQ3aP
 rwajLu+QWbV81vLpz1oh+lBaftM+XvvOn2X6RyOZ3oMjtCr5JLYIb58SCgLGO2ebzydX
 uWeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUT9p596ErP4YMDGxtncQKQZfltD24Mfu/SIYYmfyZrs1LfFHw9yCv4mTNaEcZxjqgvbaquWLHModZLe7CgGaVLyM4DK+Q=
X-Gm-Message-State: AOJu0YzkJOHyQno/5G6tqMaIiPX11PQe2wtKPH38pL1jw+10C7doOb0h
 r68QadpGZ9m0A2IPrSmQdpBMsUgdsl3o8njsz/t61349I0xV/G8DTBOupTad2FM=
X-Google-Smtp-Source: AGHT+IEvtpHaRjG9vqci9o+djDXEMZUe2E28G56G9bBW4+u6HXW7p7I30OaVN2eqvYQFcTAZFxpyTQ==
X-Received: by 2002:a05:6a00:1ac7:b0:705:97b3:4605 with SMTP id
 d2e1a72fcca58-70eae98fd23mr4511273b3a.25.1721951193897; 
 Thu, 25 Jul 2024 16:46:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8128d0sm1647565b3a.118.2024.07.25.16.46.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:46:33 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, jim.shu@sifive.com,
 andy.chiu@sifive.com, jesse.huang@sifive.com, kito.cheng@sifive.com
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 08/24] linux-user/syscall: introduce prctl for indirect branch
 tracking
Date: Thu, 25 Jul 2024 16:45:57 -0700
Message-ID: <20240725234614.3850142-9-debug@rivosinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240725234614.3850142-1-debug@rivosinc.com>
References: <20240725234614.3850142-1-debug@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x432.google.com
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

Each application enables indirect branch tracking (forward cfi) for itself
via prctl. Adding branch tracking prctl in linux-user/syscall.

Using same prctl code as proposed in cfi patches in kernel mailing list [1]

[1] - https://lore.kernel.org/all/20240403234054.2020347-1-debug@rivosinc.com/

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
Co-developed-by: Jim Shu <jim.shu@sifive.com>
Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
Co-developed-by: Jesse Huang <jesse.huang@sifive.com>
---
 linux-user/syscall.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index b8c278b91d..ec157c1088 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -6295,6 +6295,17 @@ abi_long do_arch_prctl(CPUX86State *env, int code, abi_ulong addr)
 # define PR_SME_VL_INHERIT   (1 << 17)
 #endif
 
+#ifndef PR_GET_INDIR_BR_LP_STATUS
+# define PR_GET_INDIR_BR_LP_STATUS      74
+#endif
+#ifndef PR_SET_INDIR_BR_LP_STATUS
+# define PR_SET_INDIR_BR_LP_STATUS      75
+# define PR_INDIR_BR_LP_ENABLE          (1UL << 0)
+#endif
+#ifndef PR_LOCK_INDIR_BR_LP_STATUS
+# define PR_LOCK_INDIR_BR_LP_STATUS     76
+#endif
+
 #include "target_prctl.h"
 
 static abi_long do_prctl_inval0(CPUArchState *env)
@@ -6477,6 +6488,14 @@ static abi_long do_prctl(CPUArchState *env, abi_long option, abi_long arg2,
     case PR_SET_TSC:
         /* Disable to prevent the target disabling stuff we need. */
         return -TARGET_EINVAL;
+    case PR_GET_INDIR_BR_LP_STATUS:
+    case PR_SET_INDIR_BR_LP_STATUS:
+    case PR_LOCK_INDIR_BR_LP_STATUS:
+#ifndef do_prctl_cfi
+        return do_prctl_inval1(env, arg2);
+#else
+        return do_prctl_cfi(env, option, arg2);
+#endif
 
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported prctl: " TARGET_ABI_FMT_ld "\n",
-- 
2.44.0


