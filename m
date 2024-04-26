Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7680C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 19:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0RT3-0000cr-Mv; Fri, 26 Apr 2024 15:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RT1-0000bT-U5
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:43 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0RSz-0002vc-9F
 for qemu-devel@nongnu.org; Fri, 26 Apr 2024 15:42:43 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56e6acb39d4so3272355a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Apr 2024 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714160559; x=1714765359; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X/VhmwXvkdhIQuo7rHVj9w7BkqzRhVw95Tx0jafh5o=;
 b=l9DqV5US4XkYQL/ZnZc0L9FJ61xIS7vuMqTfa7mzfRLeohtqgjPS9ATJzwIkSvJfKC
 bQcqvM8U4/mVaNOeei/kl+dRPTE8aeV6JM4KkeOfTKyDfJnacmFXj+4PGsnn+9jn9fEG
 VatWhEfItd20RGFa6E9sy6/2YY+R9bCssHVMGWAtJprHvlq2vrw7PlKp9DZZtbK5aQuN
 PO4VJG4KzUGrbHrZH3Q29CaJBoQIo850T8wEdjbP3COASE2+23OUT6ImGfYNnzu9/ZsY
 JuLEw32lXebkM2Iuah7oPowiYuzN6V5SSIh9TPl9TvSzlK8ttRnVdLkAn2xu8CVjy0J+
 lVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714160559; x=1714765359;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4X/VhmwXvkdhIQuo7rHVj9w7BkqzRhVw95Tx0jafh5o=;
 b=dMs27XVVJ6/qJU5ZdKOOfhbZBlO5nj1TC/fLwyBlSl95OLxLvjMO05hELzY43fA0LQ
 PgqSwGAHCW6okFb+3OsAHup+yqkTGkQHTurCIygJCJQ7VeCRkiXzLvzPMyzSuVhho3sf
 eeoLlCF4wzUrPAU+sVDo4fVZuHR/PgwMotPDvF+pvcCXZdYHINHKVGEhukHFiBT6yFrR
 CJutrS4nWzZ32Go8q7XKN5Pu+fqosB26IvFmnLa59zLqcXGjL5IQBGLDRLFXNjsqATDv
 GA7kTSXdagacrsGvkkDcq+xaoJxvHSXJZfMMpSpY+1k0pfvEf1hBUt2MXOrYnBjhsVsc
 TC6Q==
X-Gm-Message-State: AOJu0YxlHMWldyp3s5Bsxc/j4HIuh9dnS/M2DlUULxfmzs1Fzntfenvq
 UIknir35Hc5z903FHE9Ga/51iJ6gGFIjYCPh2ikfDaG266CNoQw506Gbyt9r01TqeaCiPTq2Bin
 hZyg=
X-Google-Smtp-Source: AGHT+IGxJBhgvUwhhWCAgenYBiSIUi2w5crKR0/10WrNMXoZqN9Fol3uSvd/ZTOG18vXH6erYN0+GQ==
X-Received: by 2002:a17:906:28d9:b0:a55:63de:9aa9 with SMTP id
 p25-20020a17090628d900b00a5563de9aa9mr2581937ejd.49.1714160559645; 
 Fri, 26 Apr 2024 12:42:39 -0700 (PDT)
Received: from m1x-phil.lan (aul93-h02-176-184-11-147.dsl.sta.abo.bbox.fr.
 [176.184.11.147]) by smtp.gmail.com with ESMTPSA id
 n11-20020a170906b30b00b00a5242e285aesm10798927ejz.184.2024.04.26.12.42.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 26 Apr 2024 12:42:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 06/38] gdbstub: Include missing 'hw/core/cpu.h' header
Date: Fri, 26 Apr 2024 21:41:26 +0200
Message-ID: <20240426194200.43723-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240426194200.43723-1-philmd@linaro.org>
References: <20240426194200.43723-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Functions such gdb_get_cpu_pid() dereference CPUState so
require the structure declaration from "hw/core/cpu.h":

  static uint32_t gdb_get_cpu_pid(CPUState *cpu)
  {
    ...
    return cpu->cluster_index + 1;
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20231211212003.21686-15-philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 9c23d44baf..9c2b8b5d0a 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -37,6 +37,7 @@
 #include "hw/cpu/cluster.h"
 #include "hw/boards.h"
 #endif
+#include "hw/core/cpu.h"
 
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
-- 
2.41.0


