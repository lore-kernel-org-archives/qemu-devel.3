Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106FBC35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 12:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tusrd-0000KI-E0; Wed, 19 Mar 2025 08:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1tujCn-0001OY-0m
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:30:53 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1tujCl-0000qd-4x
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 22:30:52 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-225a28a511eso108399805ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 19:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742351446; x=1742956246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1Gh4ZIghkWg/wQzaqUUKT6KEkn1st8k6xmiH7pRpD0w=;
 b=cESCf9RIBs/Ad2q7O1/pLqrvRkvEYk1+HxR8zbwJqAouwSSL6YZg7wnG7mVAPI/SG3
 f6pvY0yOD2496BmPD2d51m+eepNHTts0eXWHXgpVwUV7Pht13nIehA7RWc8WjPzWC7O6
 wusmb29oLnAns3lwG0viQqy8tFwa9vwMTk4SS7DtcVq0X8GPhgXCGne9WO1uzRQ3I+qm
 C6u1gn26ur4wp7Tc4elvefApL9max62vMgouVSrle5CH0GyPvlN001EIcUKGrgk+iJHB
 trmP5FzrY1BnXTMLC1HyW0+KVxFw7X4+/EqgULdg7YBHhGPdMLaK5anud6IPGxLC1pfu
 Zwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742351446; x=1742956246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1Gh4ZIghkWg/wQzaqUUKT6KEkn1st8k6xmiH7pRpD0w=;
 b=unlRM7ffJHHBx9fr0YLfe41OyA36bnZHZTl6c/kkX32B2GIRY/zMl66az+a18QOuUi
 8BilQrEWiOAA1yM9vh8cgFg0K+zNmsUroSd2sYiDk4nud+zoGMLkNXLSYo8ssggVNwl2
 FxpE8DQpvtEVknnEnGrI5vCghTfclS9bYWlrpgpTR47TM8VAWZhsX7V0hHnWSbti42GN
 cZwhQ+7FnUzbpsEsnaN5ID7f5hzGLpCIj9r/Dzvh/jvbKM1UNlFdvvL3xwLi0l5m0Zd1
 xoGAVVTvpWhJLc97a9/gGdWPwv1hFX3eAMePCZa6DbO/RCPSEns4MUQs3wS4XGb+zhZT
 gWBw==
X-Gm-Message-State: AOJu0YzsTHJDtPrtoL1RBeqeCNpyFsyyczpMGrKix9JfFq0U5PpIJXjl
 FZdrz/iKjgZQHN+vN8vrjGHHKP7ZH5h1pqvNkoMMXuRBwdGcMOqP3hWh0XM1
X-Gm-Gg: ASbGnct4AvqQsonigx0Uh5xdmymfdu4Dv1bNkWq0WQuXQ2vb9CHCx4wB7LzP23TbbIg
 NENerWkMCPPW/Y0DQ2k83EeE3t2ejqztB3DNz4wcecUyey3+8mqw/tLwIdGOvXLjK1k3BBLyx5w
 B/Fv3cnVfL4Gxi/aKFyU9Us6tqIWhFdwnTIdhXMD3IEPDpcpKORFwP56381Hq35SPyoh7m9gRtQ
 VZrldeXuVcphvYLi1gV23kRkdLJUzco8fFMgyBXDY+B8Va7aHVVnnhdssFTTkjzrOhevi/Rmia9
 cn2glv3nQJdnKGH1vNygJYPWahV4qZh1QSIqppTXrsQWDH0/7Rd8Ow+ZWt2rS3JaUqVNVNNWMw=
 =
X-Google-Smtp-Source: AGHT+IGKDgB9auNTjteDQ9/WHstCw6ywbSUihElbcrtnjd5KwoQvmf6rlO9RgnvyxcL3swc20h2GFg==
X-Received: by 2002:a05:6a00:c8b:b0:736:491b:536d with SMTP id
 d2e1a72fcca58-7376d6fa36bmr1751175b3a.20.1742351446354; 
 Tue, 18 Mar 2025 19:30:46 -0700 (PDT)
Received: from localhost.localdomain ([103.210.49.131])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7371167d764sm10712578b3a.98.2025.03.18.19.30.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Mar 2025 19:30:45 -0700 (PDT)
From: Tanish Desai <tanishdesai37@gmail.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>
Subject: [PATCH] Fix duplicate symbol error on MacOS build
Date: Wed, 19 Mar 2025 08:00:36 +0530
Message-ID: <20250319023036.71493-1-tanishdesai37@gmail.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=tanishdesai37@gmail.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 19 Mar 2025 08:49:26 -0400
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

The issue started after commit https://github.com/qemu/qemu/commit/59f4d65584bd3372070e2484876436c8d02505e4

Reproduction:
  1. In the build directory on MacOS (haven't tried on other OS), run:
       ../configure --enable-rust --target-list=aarch64-softmmu
  2. Then run either:
       ninja -C .
       OR
       make
  3. At the end, you will encounter the error:
       duplicate symbol '_pl011_create' in:
           /Users/tanishdesai37/Downloads/qemu-master/build/libcommon.a.p/hw_char_pl011.c.o
           librust_aarch64_softmmu.a[5](pl011.pl011.390d424367e209af-cgu.1.rcgu.o)
       ld: 1 duplicate symbols

Root cause:
  Both CONFIG_PL011 and X_PL011_RUST are selected, causing C++ and Rust to produce the same object.
  This is due to the commit above where 'select PL011' forces a true condition instead of checking if HAVE_RUST is true.
  If HAVE_RUST is true, X_PL011_RUST should be selected instead of CONFIG_PL011.

Signed-off-by: Tanish Desai <tanishdesai37@gmail.com>
---
 hw/vmapple/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 2382b297672..01bcbf40e00 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -22,7 +22,8 @@ config VMAPPLE
     select PLATFORM_BUS
     select PCI_EXPRESS
     select PCI_EXPRESS_GENERIC_BRIDGE
-    select PL011 # UART
+    select PL011 if !HAVE_RUST # UART
+    select X_PL011_RUST if HAVE_RUST # UART
     select PL031 # RTC
     select PL061 # GPIO
     select GPIO_PWR
-- 
2.48.1


