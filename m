Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63942CF3196
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:54:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsH3-0005fN-Bz; Wed, 02 Oct 2024 01:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGv-0005cy-T1
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:39 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsGt-0004rT-9v
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:51:37 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b5fb2e89dso26945255ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848291; x=1728453091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ajDbHk7shUsQVc2F/OV25BbITNqZTsS8ZCU4Ra5gkh8=;
 b=XF3V1K5+hBQNIMeRqKIUslO/FULrcZfoWMdwbmm7zueKo6e5gXLp+3gbtgiLSlkMBh
 rZYA5ZZhh+fUua3S2kNaBlQajlG1jnPNO6sENruJxc2axIFKtvJQpDCvqmZJzKAkGGwF
 CcoAf3zR4N7N0QZcsYTOMyKy4UE4o3o2XdrZzKYX5UQzlYTBhZen3cZxRymJaheWkoxO
 Z9jO3yUtZy8wUXo+mdDHi3JvtCnETFr7k1IOahDUURTSSxmSs2uS6p5gittZ+1+yCBPZ
 6j5pjsP/xo7/Qir/A0DZDMAXVBohkw1dDLhF0dgbbYK9wXtqsyRra//nx1kj3c9YnaS0
 ZLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848291; x=1728453091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ajDbHk7shUsQVc2F/OV25BbITNqZTsS8ZCU4Ra5gkh8=;
 b=Qk2beeDtP+F6Cw9vChUKPVPyFuT5wA4dMztLKOHfh3qFYqhluuUqhEcLv55jdASWnM
 RZayefL2/xDMaTHQYEtSbnw7BZ/TaAZTwaCgN9ETN+9xWGU+l/36xPZTNIjePjdulYfV
 tAO9xKTGoZ6USF82YtoTVBzZ8SIQ2jsHyPO8/FWPl9e1VLhLvAMMqA5apzf+hCzzjm7v
 k1v0VxwlKxuNZoZqOxHsyurbki0hojjFhefVAY89vzSW5AsSM7hcPifYxS6ipdzvEaGz
 3jQv2zxPILDHz2wKo6DcpjB/TxG0H4QEAnwoStCbRVhbNSF31YYEA00b6+/zbH7dgGei
 +9uw==
X-Gm-Message-State: AOJu0YwS7yHNEplzdtt3hm0eugc85TCG2y13J/8VoF03OE4JAflrEJTC
 oOv2HuMPauU0VVgZiN4o8GpGEXJQzTpp8UeooGVK9LA5NBfAi4dKwZmCl5in
X-Google-Smtp-Source: AGHT+IEbnug43zh0TRYO8ZHfDw8K5pF/j/3ZGAmHW2ODYPjEdVxuK43XJB8akSNhNl9FwbbaV1n+cg==
X-Received: by 2002:a17:903:22c2:b0:20b:b75d:e8c0 with SMTP id
 d9443c01a7336-20bc5a5d408mr32072505ad.45.1727848291517; 
 Tue, 01 Oct 2024 22:51:31 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:51:31 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 =?UTF-8?q?Milan=20P=2E=20Stani=C4=87?= <mps@arvanta.net>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 11/35] util/util/cpuinfo-riscv.c: fix riscv64 build on musl
 libc
Date: Wed,  2 Oct 2024 15:50:24 +1000
Message-ID: <20241002055048.556083-12-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
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
2.46.2


