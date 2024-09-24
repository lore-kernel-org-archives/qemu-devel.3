Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040FFCF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 22:20:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stDri-0004eg-HM; Tue, 24 Sep 2024 18:18:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrh-0004ab-Fq
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:37 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1stDrf-0001e8-T2
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 18:18:37 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71970655611so5392053b3a.0
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 15:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727216314; x=1727821114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n92lSS7nLnvvFV+djWi3tX7M+BTT1mwMiaSPH8ytfJc=;
 b=YTJdjfmMkN3ZkbtISNdLELSaGkklovdczH2V0jGy4PUTMYIRStIlkhRfcO4opE0F2Y
 YAn2d+WmtyZ9QQ4QTeoi5QAg/1UUILkDu5bbutO6gKxDchpz6t+wX+NmE5whU6KLJIaW
 Py3u1jsjpfmsXuN9TCDXvzx4dwtUu4Zcc7MF/2IZPdzzhdJO3S2fmELTNF/O6JJnCvHg
 SHmNM3k919wp6AHfQhuZZTBY6lprzkh6Bagxf34J6108nqclqp11iUjDV158He9MEzWp
 OTlnG7ZU8BgLNpdy4V93RfSQaP5KgCurVDP1TYaNkHzi1Sz0BbbZ84QqdJ0ticUymtfX
 h5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727216314; x=1727821114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n92lSS7nLnvvFV+djWi3tX7M+BTT1mwMiaSPH8ytfJc=;
 b=aAiOLyLohXzC+FnoASI29dUe87haLAzoFF9to/CNKFc8BKn9IcODC8wm6YejM6oQ0X
 Cdo9xyGpA2bgBOKVypQEhTZDdCDm6y4p5IIFf8zrurm4iLcBINI/I5jpt3SOhQIBGeY4
 UvSe7YaFstrRp1IhYpny/cGpIpG5azu+DCNJznM9bp+01FcZ6QGQ3PBWIPZ/UhzxOdFt
 4sm5QawUk+GaBZoElFk3afzqPGLtLUmLlNvDHJJB2ZAwobhZGMc0xRS46pLh0KAfP13h
 SBrzCJPzagTcKUL7r1EajGLHmDMkJe8HvNBA3oBcGL2hLoSqDE/H2reuq6GnN8Mchqee
 JzOQ==
X-Gm-Message-State: AOJu0YwDmy7TiU/XMfX34Q7RaP77v8oodZmy63hogXE330tTILrYUQe4
 o3q4hhXGO169th5I0ajBez2hyEQAKeFmtf5P2GnF59Rt5SP7Qfep1WmuyQ==
X-Google-Smtp-Source: AGHT+IGEdTIqKnAy6AcCF3XhuLh/qcv1EjH88nOLl4I22D0zzXCOuSQxbi58sEnH1EVBcQrUaXGroQ==
X-Received: by 2002:a05:6a00:b4e:b0:717:8da8:6ec1 with SMTP id
 d2e1a72fcca58-71b0ac56ff2mr1126534b3a.17.1727216313642; 
 Tue, 24 Sep 2024 15:18:33 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71afc8342easm1665310b3a.11.2024.09.24.15.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 15:18:33 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 11/47] util/util/cpuinfo-riscv.c: fix riscv64 build on musl
 libc
Date: Wed, 25 Sep 2024 08:17:12 +1000
Message-ID: <20240924221751.2688389-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240924221751.2688389-1-alistair.francis@wdc.com>
References: <20240924221751.2688389-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x434.google.com
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

From: Milan P. Stanić <mps@arvanta.net>

build fails on musl libc (alpine linux) with this error:

../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (first use in this function); did you mean 'riscv_hwprobe'?
   63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) == 0
      |                     ^~~~~~~~~~~~~~~~~~
      |                     riscv_hwprobe
../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is reported only once for each function it appears in
ninja: subcommand failed

add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build

Signed-off-by: Milan P. Stanić <mps@arvanta.net>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20240905150702.2484-1-mps@arvanta.net>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 util/cpuinfo-riscv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
index 497ce12680..8cacc67645 100644
--- a/util/cpuinfo-riscv.c
+++ b/util/cpuinfo-riscv.c
@@ -9,6 +9,7 @@
 #ifdef CONFIG_ASM_HWPROBE_H
 #include <asm/hwprobe.h>
 #include <sys/syscall.h>
+#include <asm/unistd.h>
 #endif
 
 unsigned cpuinfo;
-- 
2.46.1


