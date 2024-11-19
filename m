Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 927EED44161
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 14:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDP8k-0005xo-9P; Tue, 19 Nov 2024 09:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8g-0005vb-Ks
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:34 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tDP8f-0006Ew-13
 for qemu-devel@nongnu.org; Tue, 19 Nov 2024 09:23:34 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ff64e5d31bso10607191fa.0
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2024 06:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732026211; x=1732631011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RzMX04CUUuh+Xk+AH/1AGddH04IQDU5JSslwP2URJ/o=;
 b=qeYmDOEc7ejATPqx8Z2uIolzsAaO8pwGap4GLwgqurxuxTbYpDyqWM2Es7+ZzSmYey
 TOQEeF/gwjVr7/WwJ0QSHjj6cHAevwFII52GzANWyUCefhaatu6DvW3Efjptcjnu95hT
 u8lbijgRIMvEegwNjSjaAUC3YL1gh11XQZbU7Lfhm3F6VAew5rAKH476B/08bM8GlJAV
 ju9nuf7JuBZqMMiFsGBBPVPrvPmPNXH1dwOA+6n6XkqqTl+v+CJfVjEz8iuZ3Z/D1lb2
 ul4upaRzBMOLdX+jAekMdrt/OAxGbm7moIGKuJJGFr0fulmzqHn2IMYLy33F8q5ohZZK
 d4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732026211; x=1732631011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RzMX04CUUuh+Xk+AH/1AGddH04IQDU5JSslwP2URJ/o=;
 b=eJeI5XuyjfibFt4o006nFH6hGOEIZGhueuKu8k+9x7LQ6wg7i1+euS7gIT2DUSW3mc
 MjHsLBamml9qBjPtRjIJUjdsZ2PVAnferiOmuttbXEcbuPQzEdU03fZn/mNvc4CLQMr/
 p8QQb9wtdNmjlHaionA4MKWy8XTOjq827h9OoA9LQEa27/vvUD2I7vri8OQIDYAu+OS3
 7F7V4JUHGA/5l6cWXiLn/vVYtdCh1wH0M8Rjl9bOtYhPIPtrbyJ2SGEprDGE7h9H5/dD
 M2XIZI89J53A0A5XtiypRM+VVSEcIAAnWa+fYTQemaLP/Pq3DVSOvgXB8Xn5OMoTODSm
 Vc/g==
X-Gm-Message-State: AOJu0YwjSVNS3RdYOML8nU2yFBtNI2nzvtnipTBYimwMSMW+WEo1YtAf
 VCpiCln5f+SBXn/0Xfs9lf3YKYqVF/Ci2gtWctYLOWu6XX5aMeumXwRQgGE3fFqQ3FKNgA+gwqs
 U
X-Google-Smtp-Source: AGHT+IEItgd53g80BFWTfVdXFqaz8GKCYkQ/4NvlXSD67hWelK1/ulc9orJGzn5e8pQ1NJBITuonFw==
X-Received: by 2002:a05:6512:2316:b0:53b:20a1:1c4a with SMTP id
 2adb3069b0e04-53dab3b99c6mr6962141e87.42.1732026211081; 
 Tue, 19 Nov 2024 06:23:31 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432dac21a15sm193049985e9.38.2024.11.19.06.23.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:23:30 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] trace: Don't include trace-root.h in control.c or
 control-target.c
Date: Tue, 19 Nov 2024 14:23:21 +0000
Message-Id: <20241119142321.1853732-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119142321.1853732-1-peter.maydell@linaro.org>
References: <20241119142321.1853732-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

The trace-root.h file has the definitions of trace events for
the top-level trace-events file (i.e. for those events which are
used in source files in the root of the source tree). There's
no particular need for trace/control.c or trace/control-target.c
to include this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20241108162909.4080314-4-peter.maydell@linaro.org
---
 trace/control-target.c | 1 -
 trace/control.c        | 1 -
 2 files changed, 2 deletions(-)

diff --git a/trace/control-target.c b/trace/control-target.c
index 97f21e476d2..d58e84f6dd8 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -10,7 +10,6 @@
 #include "qemu/osdep.h"
 #include "qemu/lockable.h"
 #include "cpu.h"
-#include "trace/trace-root.h"
 #include "trace/control.h"
 
 
diff --git a/trace/control.c b/trace/control.c
index ef107829ac0..1c8c50064af 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -27,7 +27,6 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace/trace-root.h"
 
 int trace_events_enabled_count;
 
-- 
2.34.1


