Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0999D4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSW2-0002PN-Nh; Thu, 15 Jan 2026 13:56:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVQ-0000jF-CA
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:41 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0005w7-VI
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:40 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee301a06aso11660055e9.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503328; x=1769108128; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DUH5FjK7b2EIsIIQmTzRC8PsiEQGFhbRDC16YQhe6Bo=;
 b=RHJmFFjGOMUoN8xir+PTHuNagJIG4ExpBSq71IqWGKGQm5c+ll71RSKfkk6awXzHPh
 XOHBWXJqsXFAdMWNB2OucowogKX0ft0BQR59Mwf9XUWpNeCjXaHWav4TZGxATrLH6RSE
 8zbdee9eb1N1lItaPF1Vw7p8x2LLoD7VaJ8Xbw7Ja1gBrwiqN048ih789CQk3Pxu+I12
 IBPyhSVLIl4kjNDOI7lqfw1Y6kaq/Enzc+GVhCJECAM9gyWxxs1YsPXTh/n31wMxfd3P
 JOMz0Abwoj5b7oriIgFJ7UoYrUIO/L9l9he26+52oKBWyMC3rJjBiEJXcgK8A6oPHc9a
 LYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503328; x=1769108128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DUH5FjK7b2EIsIIQmTzRC8PsiEQGFhbRDC16YQhe6Bo=;
 b=OcKqFYqVapsSLI60yGvH+34IEkhk1Al54P2zCFrZ+h7I6c3U9WR+TowbPhkw9jVhEQ
 A7EE54xIdzPER8GvTJnsqk9YTWqOOpVo3meQirrH14tupASJXlo+OphjgiHESzGBKfLH
 9iB9vwTpwfP400x1xnXFsJYVXUawOfJR/RZcKhNMgAspDYBcN/KdK8cw+Lt9bQRzuWWd
 zywnCaXts6UPS5JLHDnoJuWYj6oMHSVU8MdXNcBqIzMWxYe8/I+kOJ2mmK3rpY5MPq2w
 mjdRv8XmUAHOeLzj+rIrc3BwfkNRJ4CAOtHnkjOGqNWuJ201iMgyomBERPh1k6+qmGeB
 FGtA==
X-Gm-Message-State: AOJu0Yybvdh9hw7POOoovh1M3EbNURDPAQYFU7yzKleE85Y1u10Yq0/c
 AjVjDLe8Ts0jD2Lfu1CR/AXvAus3YHl9U73TZMuriImaMK0/BAL02O+PMwJcuO3LomMBzlS2P/v
 kUef4
X-Gm-Gg: AY/fxX52JOhx1m9S/9xdrSQHntpc+RvzcW/Zk9Lfl6PFLNmbkLg0jzKRr4I5zpTzSFZ
 7A3FxjQ1GtKLiKZOdfGXFuC0aInfsvPFObt5SA7NkSO7CdJoTLa+9Ragmo1xMRe5qfF1qEmAQr6
 FpFwn2xvnism5YMfv90mPONiArdXuYrNcmEpteVIhjhr+k0jBeNCRQh+MYoiAksHe9MPkHAmOTH
 Ml7HaVti4g15pNB/7f6PPYUQAV9tnhsXmsI8m/q1ZEzUp//lpyAu2rxr0oy0bxHqtFoQtGMGl5m
 Hhc37EYUF4qDoLT1nQrDb8Chb5ybRDgi515nzPN+Xd5q50n/lxZofAFnHLmlSH6QYorsewwriG6
 tToAW915Eig3uFsTdyh4l/9Z5C9DQVDE+W0EUvLMiAE3koIZ+Fh25J44TcQd+40abKLnMkmKWD2
 zG4BgfdKS4A9HPMjJVBVw6hb5CYSOtdfXNRyANz9Z6Jw0hEq9MAhcSerUQiOnUPPGvg/AbZw3Vq
 nHu8BTIHoeOjMq5p9y5wv2ACWY9OnnLyBDFFUR4Iv6HUw==
X-Received: by 2002:a05:600c:8710:b0:471:14f5:126f with SMTP id
 5b1f17b1804b1-4801eb142famr2253005e9.33.1768503328060; 
 Thu, 15 Jan 2026 10:55:28 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/25] docs/system/generic-loader: move TODO to source code
Date: Thu, 15 Jan 2026 18:55:02 +0000
Message-ID: <20260115185508.786428-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Currently we have a "Restrictions and ToDos" section at the bottom of
the document which notes that there's no way to specify a CPU to load
a file through that doesn't also set that CPU's PC.  This is written
as a developer-facing note.  Move this to a TODO comment in the
source code, and provide a shorter user-facing statement of the
current restriction under the specific sub-option that it applies to.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/system/generic-loader.rst | 14 +++-----------
 hw/core/generic-loader.c       | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 11 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index d5416711e9..0df9b66976 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -99,6 +99,9 @@ shown below:
   If this option is not specified, then the data will be loaded via
   the address space of the first CPU, and no CPU will have its PC set.
 
+  Note that there is currently no way to specify the address space to
+  load the data without also causing that CPU's PC to be set.
+
   Since it sets the starting PC, this option should only be used for the boot
   image.
 
@@ -111,14 +114,3 @@ shown below:
 An example of loading an ELF file which CPU0 will boot is shown below::
 
     -device loader,file=./images/boot.elf,cpu-num=0
-
-Restrictions and ToDos
-^^^^^^^^^^^^^^^^^^^^^^
-
-At the moment it is just assumed that if you specify a cpu-num then
-you want to set the PC as well. This might not always be the case. In
-future the internal state 'set_pc' (which exists in the generic loader
-now) should be exposed to the user so that they can choose if the PC
-is set or not.
-
-
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index 24f3908b1c..66a24f7b2a 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -30,6 +30,24 @@
  * separate backend.
  */
 
+/*
+ * TODO: currently the "load a file" functionality provides no way
+ * for the user to specify which CPU address space to load the data
+ * into without also causing that CPU's PC to be set to the start
+ * address of the file.
+ *
+ * We could fix this by having a new suboption set-pc (default: true)
+ * so the user can say
+ *  -device loader,file=<file>,cpu-num=<cpu-num>
+ * for the current "use this address space and set the PC" behaviour
+ * or
+ *  -device loader,file=<file>,cpu-num=<cpu-num>,set-pc=off
+ * to just pick the address space and not set the PC.
+ *
+ * Using set-pc without file= should be handled as an error; otherwise
+ * it can feed through to what we set s->set_pc to.
+ */
+
 #include "qemu/osdep.h"
 #include "system/dma.h"
 #include "system/reset.h"
-- 
2.47.3


