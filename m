Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826B2C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 12:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD0KJ-0006K9-8L; Thu, 08 May 2025 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0KB-0006Ab-W0
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:26:04 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uD0K7-0002nN-6X
 for qemu-devel@nongnu.org; Thu, 08 May 2025 08:26:01 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-30a99cff4feso1094151a91.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 05:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746707155; x=1747311955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pU/ZxDhCJzHZz6avlpYz2FzUTOirixtvN1XU436tyf4=;
 b=Y/1hikpaUMRazW5ZyhfwlpCZFtd8ZA40eAqRP5r5pd0ABksVrdWbmjuMuyjmK++0wL
 fLlK3ClyG7BwpfVAzv7qA0g2d8W2CjxZaL2RuvoGFTAZmxIlbKjnJmifRNaJEA6TPcAL
 gjfPK8kKzI9mSilBncUgClixMHR0KGQVgj/vb2nz0nC9XQfaJzX+XmmkBMG4KO0RiQ0H
 HBQTpzMt+nYMISI4fUKaR+wOhypgMyhPkMNDJeOSJPDIFGRT6d+iDw1McVYI2MCHGOZf
 iG/dJC9X+G7w3Ile2+VicGVSVDhd7XysrqXW40/QnB5HbwZrCb2KNkSeCD3mIzdlCBE7
 fMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746707155; x=1747311955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pU/ZxDhCJzHZz6avlpYz2FzUTOirixtvN1XU436tyf4=;
 b=XlM2l2r60SvQNxFvw6aYghyTGQ2kGvQj/IwI12jdmYo5Wd1KCCHqxA3FivvC+CweIO
 TGOfJwcKWVbfvdWXK8EmNXpD4ZBPFwRd9jYUqMLyAyKUxG+G3s3lVwv1jiL3CL1rYegK
 845yby8qnq1TxJOatuag1XJLThNICF0r5izQv5z5vvnu8CqnI3x3OShM0Sf1M6IPdOsT
 KE9KY4hcftGFoErLaKkS4YpjqvkXmWAttns/oZsE7Ya3a+QIMypEUzyVQiB+o8lXoT80
 41EluYGFES2Ng4iJZhJaPNS94vfwTFrscCW13JZmor4q/LxS/5QyuzhFnhB5r1IzrI4A
 ta7A==
X-Gm-Message-State: AOJu0YxFjEpSjyAAhw6dPQw/aTYLgomdQ58hQLHLNAyx7A6m+K6bQM/W
 taWvC7wtYVmVwhv3J7Auz4KSXTDvSmRdNVFMTwBLYeQNj0Y7Cwi8zcaxt/ERaJMBIawEuRDd9L3
 jf7eg9A==
X-Gm-Gg: ASbGnctb1ai1uw30Oejdf9i2G+efuzZYdE9JL32H7FKl9MkKEpVIUkgZt7PHDQv0EOi
 tkCuZdM2RL+1qIUUGIgZk1wDKZAiFuL9CEIgDFA3Bj8UqtxU1QSDlhxhmSjd6AssjeWb6zD0V9+
 4okuSxd00EhCHpim9CtYHN62n6YL3t5LBXszPXWlTMVvC1+WKrrG9msJL7zMfMHcNzqlSeGuqz3
 hDOnlfouTFdQDlZuLclI/1rJWm/DGwDixTz+a/29Q7yyqWDK0YdDrBWs/ifKOljbMN3mmeXsIXf
 JO/azzMwS68Cbyloouo71vWPWYTESRgB33YBdGbQFZSoO8pxh4yBs26lqffXlmSrydiBu8gjhpX
 urd3DBHnCot7MTS0=
X-Google-Smtp-Source: AGHT+IH+TntRxMjRaboxugs5qZV9JRhWfJ4hcI1BsdeTD2QEanc9PZfrdDclpBFRk9tM7TyvF0jwIg==
X-Received: by 2002:a17:90b:314e:b0:2ff:6fc3:79c3 with SMTP id
 98e67ed59e1d1-30b33105a54mr4704588a91.9.1746707143546; 
 Thu, 08 May 2025 05:25:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30ad474a0b0sm2087085a91.3.2025.05.08.05.25.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 08 May 2025 05:25:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <m.ynddal@samsung.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PULL 04/19] accel/hvf: Include missing 'hw/core/cpu.h' header
Date: Thu,  8 May 2025 14:25:21 +0200
Message-ID: <20250508122522.73786-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250508122522.73786-1-philmd@linaro.org>
References: <20250508122522.73786-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102c.google.com
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

Since commit d5bd8d8267e ("hvf: only update sysreg from owning
thread") hvf-all.c accesses the run_on_cpu_data type and calls
run_on_cpu(), both defined in the "hw/core/cpu.h" header.
Fortunately, it is indirectly included via:

  "system/hvf.h"
    -> "target/arm/cpu.h"
         -> "target/arm/cpu-qom.h"
              -> "hw/core/cpu.h"

"system/hvf.h" however doesn't need "target/arm/cpu.h" and we
want to remove it there. In order to do that we first need to
include it in hvf-all.c, otherwise we get:

  ../accel/hvf/hvf-all.c:61:54: error: unknown type name 'run_on_cpu_data'
   61 | static void do_hvf_update_guest_debug(CPUState *cpu, run_on_cpu_data arg)
      |                                                      ^
  ../accel/hvf/hvf-all.c:68:5: error: call to undeclared function 'run_on_cpu'
   68 |     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
      |     ^
  ../accel/hvf/hvf-all.c:68:48: error: use of undeclared identifier 'RUN_ON_CPU_NULL'
   68 |     run_on_cpu(cpu, do_hvf_update_guest_debug, RUN_ON_CPU_NULL);
      |                                                ^

Cc: Mads Ynddal <m.ynddal@samsung.com>
Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Message-Id: <20250507204401.45379-1-philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 3fc65d6b231..8c387fda24d 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -12,6 +12,7 @@
 #include "qemu/error-report.h"
 #include "system/hvf.h"
 #include "system/hvf_int.h"
+#include "hw/core/cpu.h"
 
 const char *hvf_return_string(hv_return_t ret)
 {
-- 
2.47.1


