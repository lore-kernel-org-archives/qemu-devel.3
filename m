Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB98ED73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyN-0004WJ-3n; Thu, 29 Jan 2026 12:38:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyK-0004Nx-7o
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:24 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyH-0000dO-Qr
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:23 -0500
Received: by mail-pf1-x444.google.com with SMTP id
 d2e1a72fcca58-81f39438187so667162b3a.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708300; x=1770313100; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rl24eVwM8VDKwNGbTY8imqXSq1p2xBTKgWYXW2mu/sQ=;
 b=NPcFm+RuGH+m8Oy90l3sr/6bUq8bqsv5HjbzHB0Am+ohj2t/z8EGhV62n8D23Iyw+l
 Kz20r3/WM05ZI8cepddiIi4tfpLp3Q+ojMmhN+o4hgDnQjV/9x0UgugX+4Jgb1+xr0LU
 +DO7zZOVL153jJbQLTCUG2YSRUiLrzNeIYxxNfjWnny4XOq1W9yg0nIWdLQfTaWiTRXU
 oZ/OFqihaMbSJlu4Jk88UijpkUhJhMVfHS4M7UluNihcP8x0o11USDq0ahzwgFhAqhaG
 JZ1XhyRwm2V5gJUhSYkEVVWXwAsjVYbA1/Qirmrv7K0yLCVX//LFJzqJkdI6qcKt5SLY
 KJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708300; x=1770313100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rl24eVwM8VDKwNGbTY8imqXSq1p2xBTKgWYXW2mu/sQ=;
 b=W6NzNAhF88hNkT02y/PINnUmkMCUJuk6sfVZFFbNSrUlM7TBzKfBK+l0hq/RnGD0PC
 N6cdXBfoIR9yzXQlPcGIX6XgnZTOO0i2/YYJFLU3Rvi9Q/fz3GY+NZMMm1TyTKItLoHF
 50fapJEtYFb30sUgMyCdNZfxF3jtcVuqIWGQ8DkxNLVCqQVd5fGZfx7lkB3JRdFYeJzn
 /V90cxQgt2gU3T9Unmk7siQkCxlfOHZ0U+Iepq4wQpHRipDqmi0v88psQvLUqcPsnORj
 ztQLNKS29glhxCpczCm28V6XQW5SYrSYGHyLwlHLLPoudFJNqOzmWJEofbUr1gt/+GxQ
 6Myw==
X-Gm-Message-State: AOJu0YxslM6yhFktNkA/lsMJ8823HKYRJUGCSD8B7h6O9E6GuSUYwcpX
 GFhlQlrzYDIPM3VGHcW/3ksRLVaV2qxBCuv3R9ejmeSe/8mEnROIpE9/ThTXrXNOBnJweWI1hr4
 7MEe4jXY=
X-Gm-Gg: AZuq6aIWdPxM3b1Ot+AUe6vVnYjDioWHMok8xaiCr0DFOJluc+UgxCo94S8t7aB97/i
 si6pfzZYa30a4N7PA8qLY86BFrdoC18fMku1rmlTR39CN1JigwvEUe0n/4ofznFnJQNYNwBXAwg
 gfzsnitG/HwC46rEehb4t9G4/2ruTBspB9+/fgk9p/OE0Ggu0aHXoKtbjwEh3bERC14fkp+jzAH
 C/28iuTyMsHJ1u6yPU1URTdKZaxfTg+JLLGyOa24/Q/SVv267k694bcriTwFtR7lmo/6Xa4EEoB
 5N+DYfwVKFHCLUIvi7wTcrVXvVwbeXen7Lqk4eWzsNBHwqhajNK0JSuWnzXH4cYQYIEuy/1//e3
 3jcSImicYKJKGUIe6t0LaeWwLBNLBWOm7M3w5tM3ujp1UsNofgD3JVRQfWf8w6ztH1ujWx3XM3J
 fn9/2rxBHbuHc0S3nocm/nqW6iaY+OlBh8cuxty6dMM0o/atpdWQx++HrrAzl7s9hI
X-Received: by 2002:a05:6a00:1992:b0:81f:3a05:8a7a with SMTP id
 d2e1a72fcca58-8236918218emr9167557b3a.19.1769708300284; 
 Thu, 29 Jan 2026 09:38:20 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:19 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Bradbury <asb@igalia.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/21] docs/about/emulation: Add documentation for hotblocks
 plugin arguments
Date: Thu, 29 Jan 2026 09:37:50 -0800
Message-ID: <20260129173811.138036-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x444.google.com
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

From: Alex Bradbury <asb@igalia.com>

Currently just 'inline'.

Signed-off-by: Alex Bradbury <asb@igalia.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Link: https://lore.kernel.org/qemu-devel/35128cc5a86a0c18418f9d3150fb8771c54ef7d8.1753857212.git.asb@igalia.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 4a7d1f41780..543efc4d7dc 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -463,6 +463,16 @@ Example::
   0x000000004002b0, 1, 4, 66087
   ...
 
+Behaviour can be tweaked with the following arguments:
+
+.. list-table:: Hot Blocks plugin arguments
+  :widths: 20 80
+  :header-rows: 1
+
+  * - Option
+    - Description
+  * - inline=true|false
+    - Use faster inline addition of a single counter.
 
 Hot Pages
 .........
-- 
2.47.3


