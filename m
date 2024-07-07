Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40472C41513
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 19:12:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQXIV-0000kW-5M; Sun, 07 Jul 2024 15:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIT-0000kN-LF
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <itachis6234@gmail.com>)
 id 1sQXIS-00057n-1D
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 15:11:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fb0d7e4ee9so20860715ad.3
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 12:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720379497; x=1720984297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x4Cvn0idnBY5rLrGLMI3XlTtjVp/Agnh7kMWDPo86Rw=;
 b=PLa7JlQOLmioJ54gM5ZRZ1mqmfr/lkr7lcmoovNMWANIxdS4J3f0zTDF602RV9yg+d
 nFrM1ecaLVbHplLAEKF4qYQZ0rwDh/MEjYIKbpsuEQGlVWt67sG3U8lYNpqdlVhzOIeO
 WkBotl9X7I1xCDNcsX0YoMi9Y9xJF/LUCjO+IgkmsK4Z9b5UVYrsvNLr2cdx7j9HvYbP
 HZRHZKz+cRTms50MTZjQPoCZFkvdoIMTLFDHQURGXDhtCXzd/c+/EI06IOGr/gRU9Dzh
 Iy9NPV0NS1lOCz7jPziC7SGdZdnsjOiAtGSjrJIE7KPyihCGAhU6tfyRQuUWLqxEFeZc
 LCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720379497; x=1720984297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4Cvn0idnBY5rLrGLMI3XlTtjVp/Agnh7kMWDPo86Rw=;
 b=hGpEnaj3KYRuZqAXHmlqXhPl9hs4aJkExCfMDypQPEbW+SHEAdLSzVqkYpCUwQ3asg
 iYR6pvTqiLCoroXtGz2w9ew/NLGz2QXDMkMFoAL4xZJs7puAWKmjOmxfLAJz2Wh7MMP5
 9nOF9EsEoo0wRvh7KVU/qXLryiLjWAjA/6qLSWbdXGl9LHIeG+sYG6beR5acjOllcBN9
 TkcHShi9Nk5W3PbJX/RRlsHIKbwfvgmj0Ya2HLZg3k7Lh7Dj/q+voeI4rMWQk22BuVyw
 fb4PB7zcqkLYY9qdBvBqKsA/z03fXNFjYrEtUwUV5BROhgKKLgmXVTYR43TDvPmmlMWd
 RwAQ==
X-Gm-Message-State: AOJu0Yym4NPpsUcy+ZLWzkKcN2kLZH+ZgE8hBbslF+LRi02V6zFsh19u
 UFwMRCixc133S28XFXGclotcASVfWdBHgmRerzXezVwQIf+b1OE+7D995Q==
X-Google-Smtp-Source: AGHT+IF+RcyIo1tHgE3j1jzmumWixBWug3zk7Cb6h4Ti8vzs3yVnSNKLTmJ5zPTMNaDR90wVf947kg==
X-Received: by 2002:a17:902:f70d:b0:1fb:80cf:fc95 with SMTP id
 d9443c01a7336-1fb80cffef0mr27078495ad.62.1720379496482; 
 Sun, 07 Jul 2024 12:11:36 -0700 (PDT)
Received: from localhost.localdomain ([106.222.220.84])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac11d8a70sm172156725ad.118.2024.07.07.12.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 12:11:36 -0700 (PDT)
From: Ajeet Singh <itachis6234@gmail.com>
X-Google-Original-From: Ajeet Singh <itachis@FreeBSD.org>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>,
	Ajeet Singh <itachis@FreeBSD.org>
Subject: [PATCH v2 0/8] ARM AArch64 Support for BSD
Date: Mon,  8 Jul 2024 00:41:20 +0530
Message-Id: <20240707191128.10509-1-itachis@FreeBSD.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=itachis6234@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Patch 1: Previous patches 1 to 5, which were reviewed and acked, have been folded into this patch.Some changes that were suggested,
         such as replacing "pstate &= ~PSTATE_C" with faster constructs like "env->CF = 0", have been addressed in patch 8.
Patch 2: In this patch, patches 6 to 11 have been folded. Changes such as using "ROUND_DOWN" for stack pointer calculation
         and replacing "__uint128_t" with "Int128" in the following patch 8 have been addressed. Also, "CPUARMState" will be
         changed to "CPUArchState" in the upcoming version, and the issue with "-R" is being worked on separately.
Patch 3: Patches 12 to 16 were reviewed and folded. The function "get_second_rval" will be used upstream.
Patch 4: Patches 17 to 19 were folded, and "__uint128_t" to "Int128" has been fixed in patch 8. Also, the suggestion to
         use "const_le32()" has been deferred for now.
Patch 5: Previously patch 20, the FP suggestion is being deferred, but the patch is ready for review.
Patch 6: Previously patch 21 has been reviewed.
Patch 7: Previously patch 22, same as patch 5.
Patch 8: Previously patch 23. For now, no changes, but issues of other patches have been addressed, such as updating
         AArch64 code to use CF directly and changing FP data structures to use Int128 instead of __uint128_t.

Stacey Son (6):
  bsd-user:Add CPU initialization and management functions
  bsd-user:Add AArch64 register handling and related functions
  bsd-user:Add ARM AArch64 signal handling support
  bsd-user:Add get_mcontext function for ARM AArch64
  bsd-user:Add set_mcontext function for ARM AArch64
  bsd-user:Add AArch64 improvements and signal handling functions

Warner Losh (2):
  bsd-user:Add ARM AArch64 support and capabilities
  bsd-user:Add setup_sigframe_arch function for ARM AArch64

 bsd-user/aarch64/signal.c               | 137 +++++++++++++++++
 bsd-user/aarch64/target_arch.h          |  28 ++++
 bsd-user/aarch64/target_arch_cpu.c      |  31 ++++
 bsd-user/aarch64/target_arch_cpu.h      | 188 ++++++++++++++++++++++++
 bsd-user/aarch64/target_arch_elf.h      | 165 +++++++++++++++++++++
 bsd-user/aarch64/target_arch_reg.h      |  56 +++++++
 bsd-user/aarch64/target_arch_signal.h   |  80 ++++++++++
 bsd-user/aarch64/target_arch_sigtramp.h |  48 ++++++
 bsd-user/aarch64/target_arch_sysarch.h  |  42 ++++++
 bsd-user/aarch64/target_arch_thread.h   |  61 ++++++++
 bsd-user/aarch64/target_arch_vmparam.h  |  74 ++++++++++
 bsd-user/aarch64/target_syscall.h       |  51 +++++++
 bsd-user/qemu.h                         |   3 +
 13 files changed, 964 insertions(+)
 create mode 100644 bsd-user/aarch64/signal.c
 create mode 100644 bsd-user/aarch64/target_arch.h
 create mode 100644 bsd-user/aarch64/target_arch_cpu.c
 create mode 100644 bsd-user/aarch64/target_arch_cpu.h
 create mode 100644 bsd-user/aarch64/target_arch_elf.h
 create mode 100644 bsd-user/aarch64/target_arch_reg.h
 create mode 100644 bsd-user/aarch64/target_arch_signal.h
 create mode 100644 bsd-user/aarch64/target_arch_sigtramp.h
 create mode 100644 bsd-user/aarch64/target_arch_sysarch.h
 create mode 100644 bsd-user/aarch64/target_arch_thread.h
 create mode 100644 bsd-user/aarch64/target_arch_vmparam.h
 create mode 100644 bsd-user/aarch64/target_syscall.h

-- 
2.34.1


