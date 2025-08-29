Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9CE8CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 16:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNme-0000II-Q9; Sat, 30 Aug 2025 11:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fP-0005w7-DX
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:55 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1us7fN-0004lB-MJ
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 18:33:55 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-76e4f2e4c40so2303419b3a.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 15:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756506832; x=1757111632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+fMdc66z+1eXUdLndIT85qIQpM1j8AYTmXXRdsfc7RE=;
 b=HAu8iDM0jYa5tEIA/Q8YNLxncwMEWL+SK+p205CtHZ0yQOH9/lZ7MstDTMOEVgov3N
 eHinGo5uztPRY05X9iGZoIz2ujKCbMAaqzFnU8mGpWoRqpxrdnbwkVTOsCCdFhQtJYFy
 3lOXQSrD+Nn3NRtHpQJ/GDFFkEvZ22JOjgRuAtEbAT7GuNkDP4sbr8VqeW8VCd4LlOa/
 Sv/SGXgUqYmSNa458N2q2vt1K30a4f8JTxl6Z0rS/p4I/+zRLuEsk+Q9pEMJV+eNP7eV
 OW91MdhSaM8rMWtHhuaVGPRYR9t96U9tMX4gNqkO7rdqfQXd0ESAVjRteSRBu5QU90IW
 Oy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756506832; x=1757111632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+fMdc66z+1eXUdLndIT85qIQpM1j8AYTmXXRdsfc7RE=;
 b=MVU/iBCxlkZH1W/JaYH4HPoVt9h9jUInrY5uB5DDz7h+Ml+x7E61IU3xn6NjzwlHJu
 fm4iW+SP1UmDIZojiaQyG3cOAhbVYRi0UfpdGLmDLwyyimvGD1uFP3iJ7D7XgMhtshh0
 n+WVUQT6hBoCYjKWyrvf3yZRi6adiB92Dw7WAejXYH9ozIKAHWYrJok3YydTU+ZAHg9G
 DxZvo7+EWAowz+VMFatRNoDy9nNkRi6f4dRNo42cZ5Ajs3Jt6HCYElMDQGnAhF/Ftm07
 RgY3rtxq/PKAmW9ET/vqkdesSEYCDgIPn8b+7J6hb5aox+sMncK1LoK/LMNr5scbJdA2
 7w2g==
X-Gm-Message-State: AOJu0YwynTLua7hVBnVBHTHHeyGgbxpuGwH9q5gQXzA+7Z9PCWE5tAo5
 sSjA680ZVumDi5PJY/92npZXvxLcUaniCBENUdKGzotAyzxHCcfckzBPVEWAIjOCH5Zi/r65yrS
 j2XB/R7E=
X-Gm-Gg: ASbGncveRN4dsjCBssqW/zGu2WZW4PptsFQ+SOPnyyumdZHwn78c2rUumGUOBUjKxi1
 CgiQ5QOXZYOnQeZq+kiWCgadd9JFpiAIZW9rPtOOEosR7zeusNaJzvLHXTzZ/XPkdP0Lnua8Dyu
 qPJfPsUbu+8zwsQqLg0yQyMSH04PlDOPlQtnVoyLrBahIdt+iGryk9DJbF9ouS+1ZZM9aV/q1m1
 R0mGZb/cUn0JJX3gURK5Zthq+ALVGCRiZ3Rr8luFazRbZ20+jdn/zU80rR6PxLmszpCx/DRVOD7
 Cdlo4levD9iFxqaZ7d2sBJjYdpaAIa9H/fg6l5cqBrT+5chJq/hl0lbdbe3x32QkIsXOBZDjWBa
 cwAPUC4ae85F4WQA0/FVjw7z2tD58PQ1aYMFAHIx1saAyon0sZ6HoNR2B3fyO
X-Google-Smtp-Source: AGHT+IFpRBdEX9Yv/4QZkNROckNsLzQmKMPuN0vO4L3eMt8Ze280X7zxJ5Px6ETw7WPsfYEzTdhlnQ==
X-Received: by 2002:a05:6a20:938e:b0:243:969d:a7f2 with SMTP id
 adf61e73a8af0-243d6f42133mr316867637.45.1756506832043; 
 Fri, 29 Aug 2025 15:33:52 -0700 (PDT)
Received: from stoup.. (122-150-204-12.dyn.ip.vocus.au. [122.150.204.12])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7722a269f27sm3449728b3a.12.2025.08.29.15.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 15:33:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 81/91] linux-user: Move elf parameters to hppa/target_elf.h
Date: Sat, 30 Aug 2025 08:24:17 +1000
Message-ID: <20250829222427.289668-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250829222427.289668-1-richard.henderson@linaro.org>
References: <20250829222427.289668-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/target_elf.h |  6 ++++++
 linux-user/elfload.c         | 11 -----------
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/linux-user/hppa/target_elf.h b/linux-user/hppa/target_elf.h
index b654758afa..9b6363a0a7 100644
--- a/linux-user/hppa/target_elf.h
+++ b/linux-user/hppa/target_elf.h
@@ -8,8 +8,14 @@
 #ifndef HPPA_TARGET_ELF_H
 #define HPPA_TARGET_ELF_H
 
+#define ELF_CLASS               ELFCLASS32
+#define ELF_ARCH                EM_PARISC
+
 #define HAVE_ELF_PLATFORM       1
 
 #define LO_COMMPAGE             0
+#define STACK_GROWS_DOWN        0
+#define STACK_ALIGNMENT         64
+#define VDSO_HEADER             "vdso.c.inc"
 
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 6e476d5308..6732011332 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -130,17 +130,6 @@ typedef abi_uint        target_gid_t;
 #endif
 typedef abi_int         target_pid_t;
 
-#ifdef TARGET_HPPA
-
-#define ELF_CLASS       ELFCLASS32
-#define ELF_ARCH        EM_PARISC
-#define STACK_GROWS_DOWN 0
-#define STACK_ALIGNMENT  64
-
-#define VDSO_HEADER "vdso.c.inc"
-
-#endif /* TARGET_HPPA */
-
 #ifdef TARGET_XTENSA
 
 #define ELF_CLASS       ELFCLASS32
-- 
2.43.0


