Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDAFC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 04:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXCdr-0006xc-7h; Fri, 26 Jul 2024 00:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdf-0006oz-6M
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:33:12 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sXCdd-0004ns-7r
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 00:33:06 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fc4fccdd78so1945265ad.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1721968383; x=1722573183; darn=nongnu.org;
 h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5U4Ghw3305Ip1Uq39M/Dx9BFTMBWVjM3s+Sw3x7fAg4=;
 b=B+YZkZHTxSohpMDW8t1EqLGQYUC2dr4humAvjTsnpZJG+xVupOGr7A3QnArsaG1TZQ
 +7J2kgpf/5oqSnCeMu8f1ZIjZD78S9ymzdNX0cVk5NbOfpW+npglva8gzZXk7itLDZ11
 hepQUCmF2OQSHDcmGvh5bpNh7yqkQvBLFBQmL0g3+0jEnmHR+QlM93iTC1voh3YLxIpV
 ms6CBaerldfARhR+624yy15WUcU4Boz3H+eouMtXjKtqkAgwQRXbuP6pPxF4jgIJ30JV
 TTtwBdHVXZMIyvryuZye/B/OKf781vWEItldRaF0OP1LwHoTfBqccsAeufh4vm5qyXAT
 1XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721968383; x=1722573183;
 h=references:in-reply-to:message-id:date:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5U4Ghw3305Ip1Uq39M/Dx9BFTMBWVjM3s+Sw3x7fAg4=;
 b=WsBgBKsOD01iG4hB3SjQ4RgsmHBAW9+FCrdHUtfYeIoBk3UUBlkNxjQpYT/v+VBLzM
 JsK5e0GvRDUim3MAzeQZw1RGgXgqe+z49hImUE6nBYe1cD9ieoX6+Gf/hQQwCZFNtbS6
 IQ5CqKl+OKjDGxkrS7VTgM/1LqcqI3VU6tTCcCOLZ8ujzl1+sh2s1JYCci/veHehRZq2
 tZbtSmSRe+7fc8mW8vvWoCJ0wuOw3Zrj0M4EoWrvnlfHBKWwgSJAXQqggoBav9k4kNFX
 569OJ9vyBjjVEIfa0m3ys8H5DVhq4hTxTRndyfau18mWD0LK/lKKRk7S1ZGtlo22O5dJ
 TnWg==
X-Gm-Message-State: AOJu0YwQMRWLcxuvGgks4/O2ejZKG8Pd7Mqi/kgrw+gtuvxuI0i3NOIQ
 4VOEziVZ/R/a0hPVU6G7yipkY37EGxjbhARV6FYwFfLtnCFfxTOdA/ySw7dGcwN5J99vfWiRnc8
 tpuGPhu0qtw0NhyF/yK31rKxGUooJS4AAdg/C/03e2Zlq7x5TX/QoUlKvXvP5cDWo6E7vrZPhC0
 G8NPv9l76JP4cZzsnX24cRn4rBee8MXp4HhA==
X-Google-Smtp-Source: AGHT+IETII5npB9N/eaoMSzToBfFfk5IT6VQNZ1tROEfRRObvJ3ncDGmeLcsmQAK52b/111SPDF3gA==
X-Received: by 2002:a17:902:e882:b0:1fb:cffb:cfc1 with SMTP id
 d9443c01a7336-1fed35354c2mr57891775ad.4.1721968382557; 
 Thu, 25 Jul 2024 21:33:02 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com
 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f7b092sm22303015ad.246.2024.07.25.21.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 21:33:02 -0700 (PDT)
From: Jim Shu <jim.shu@sifive.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 2/2] linux-user: Add QEMU include path to vdso
Date: Fri, 26 Jul 2024 12:32:46 +0800
Message-Id: <20240726043246.10999-3-jim.shu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240726043246.10999-1-jim.shu@sifive.com>
References: <20240726043246.10999-1-jim.shu@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=jim.shu@sifive.com; helo=mail-pl1-x632.google.com
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

Add include path to 'gen-vdso.c' to get ELF header in QEMU source.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
---
 linux-user/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/linux-user/meson.build b/linux-user/meson.build
index bc41e8c3bc..ccce4f7e70 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -30,8 +30,11 @@ linux_user_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING', if_true: files('sem
 
 syscall_nr_generators = {}
 
+# It requires "include/elf.h"
+gen_vdso_inc = include_directories('..' / 'include')
 gen_vdso_exe = executable('gen-vdso', 'gen-vdso.c',
-                          native: true, build_by_default: false)
+                          native: true, build_by_default: false,
+                          include_directories: gen_vdso_inc)
 gen_vdso = generator(gen_vdso_exe, output: '@BASENAME@.c.inc',
                      arguments: ['-o', '@OUTPUT@', '@EXTRA_ARGS@', '@INPUT@'])
 
-- 
2.17.1


