Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF06AEF99F0
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Feb 2026 02:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vr59L-0003aO-LF; Fri, 13 Feb 2026 21:12:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59K-0003a7-Lp
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:12:46 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vr59J-0004Ut-1f
 for qemu-devel@nongnu.org; Fri, 13 Feb 2026 21:12:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-483703e4b08so11202705e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Feb 2026 18:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771035163; x=1771639963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L/H41P44wntjvDWr4WQHsGwGyuyPivCyDnvceRc0MRw=;
 b=fqYKBvyXn01ETnJq3haV3NVxPfA9W1Qxs2rM+lGxwTgumIIPsllM524JcBtmswEAjH
 Z8vIbVNPDNf+Z6t1hlZeEDIGRL13CeB2rTGdRqE4Sp2WexE3RFKJz54kZMOLG+G+PK6l
 Z6A+4iCzuMJXxdUDIdJaRl6Aer4+sISQGfV0wWhi8HJIMNR5AtAGI7nmVD/C15cCK535
 AwqQDUXEoHlZwZmsVuir67Cp2n7azvOg0Wd2DpPqVVFruIuC9C1IIa3F5DOdQgpTquUb
 JkwBF29lairroN0WfV1OO8bDThs+tyOZD/QsYf8oq79rYiNJgVblXHNMoS0aHS0kyaLo
 bx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771035163; x=1771639963;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/H41P44wntjvDWr4WQHsGwGyuyPivCyDnvceRc0MRw=;
 b=G4bUZlqBL88Ct59Ih+xNAFC64JMtPp5T0LXwKZORhDf36Er2su9znTLv4GhVc2y5lO
 Tgaw/hbA0H0fG7wjNkpUdrqtTmBvElRWJT/9ZJ5QtiazLHq7WPLBv0PtbiOwsBK05qT+
 iPkbUckjmS9X3sMsbKMBUh4eDPplAclygDcpKKrPesc4+5Qa1t92UwqdA2pq9c16jBMR
 BXxfFSJ5K/SF6B0tZZiYlOKS3myjS1QTkI4eZ1KmzuI23uIFH03dOdI+lazh0BJtrl1V
 xrZUPjNG5WgI1dz1cf2MZDqkXfRz9BXeOnxkGzgrTzPa0un44Iq3TupGgtHxgfE8zOw/
 uwjQ==
X-Gm-Message-State: AOJu0YyMqrOPTc6CatmHeFj8XXJQ2oPRDKCgid9ko+qYk7f8l4eUSw4e
 bo7Rs1idt2bg+BHv2Fw3sffL1OjcK63zZABPBNfgfrlaAQ4A3U9MSTDNCfBEtKhyAhf6K2Olqdq
 GfAGYPK4=
X-Gm-Gg: AZuq6aK3nvHoXBLDaZVlwZ+lm4daKPBe3n9blBGToQkDrep5s0pQnzfecah7Q/CTE1l
 3/kRRWzwDvmLqGQUmrj5q/LZFna/Crcff9tFD7hO/IQQx9Jnurrz3qvsLRYUWCBlBofZivoqz0L
 xukkeKx3JxAwEjJHbLPv03q2VCEhdcS9OthZXvEiLVaGyD999GMVLmkv4I0rdHoU7rh1vYrjMMV
 pP1Y/mXwOOtmYwuFS//N7U8F1RYFu1lIEMAPx/J3W0xPuJgwTYsyHIJMAciVEikRrZ39tx5lQQs
 WmwhwyTYUB3rry0I/rzFyFmUmt0qFMbjSCnKZOmOiuhz+6OX9o+YbrV54LfJpj8kizA6veeZVPC
 ZILHtVCbGxuysgmrtEq1pwNm4gCH8F2GJ0CE+8sz65JuA58DDu2T3EY1HnEP69uihFgt7wcp4tp
 6qSDKYO56TcLEaZMlEi357k2C65HIDza6CiRQPjmLNz1R1jO0yhKvJo9Cx0UzweUPp6FlqOjZN
X-Received: by 2002:a05:600c:6b6b:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-48378d62cb2mr24269335e9.8.1771035162928; 
 Fri, 13 Feb 2026 18:12:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48378b5196esm19389245e9.8.2026.02.13.18.12.41
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Feb 2026 18:12:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/8] system: Absorb globals-target.c within common globals.c
Date: Sat, 14 Feb 2026 03:12:31 +0100
Message-ID: <20260214021240.58657-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Slightly rework how the graphic dimension variables for
the M68k / PPC / SPARC targets are initialized, removing
the need for the target-specific globals-target.c file.

Philippe Mathieu-Daudé (8):
  hw/display/macfb: Constify macfb_sense_table[] array
  hw/display/macfb: Constify macfb_mode_table[] array
  hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
  hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
  hw/m68k: Set graphic display dimensions generically
  hw/sparc: Set graphic display dimensions generically
  hw/ppc: Set graphic display dimensions generically
  system/globals: Build as common code

 include/hw/display/macfb.h |  2 +-
 include/hw/ppc/ppc.h       |  2 ++
 hw/display/macfb.c         | 18 +++++++++++-------
 hw/m68k/q800.c             | 17 ++++++-----------
 hw/ppc/mac_newworld.c      | 10 ++++++----
 hw/ppc/mac_oldworld.c      | 10 ++++++----
 hw/ppc/ppc.c               |  8 ++++++++
 hw/ppc/prep.c              |  4 ++++
 hw/ppc/spapr.c             |  4 ++++
 hw/sparc/sun4m.c           |  9 +++++++++
 hw/sparc64/sun4u.c         | 10 ++++++++++
 system/globals-target.c    | 24 ------------------------
 system/globals.c           |  3 +++
 system/meson.build         |  4 ----
 14 files changed, 70 insertions(+), 55 deletions(-)
 delete mode 100644 system/globals-target.c

-- 
2.52.0


