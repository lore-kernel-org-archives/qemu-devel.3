Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757B7CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgZV-0007rU-So; Tue, 12 May 2026 02:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYu-0007b0-7Q
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:54 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgYq-0007Cp-8s
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:25:46 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48d102471a4so50241095e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778567141; x=1779171941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dKbUh8UPNvo4Yd3qJ+VE+MguhwOizfDZglByQHiHicY=;
 b=Bxi6NF6uGPeZOF+Wpscik16xYyYsRkBrIs65S4Id9zMh4C3oWOEThal9A8k2ztruQC
 eCpEPyv1JrND+ushnQxrZl4hCIrBNTWxwR+s88wawfMJ2I0JFRR0mQmZIhw/LSAAeL2x
 YPJ8o9sgCwXAYbpTZCwLPVKek3HfwGqn6J7xFuDBvq7oZ+Y+M0UTUw81XMLZDFyaFMvN
 FIWNbVMdaRumDQpnYOqTKZibxUqKrPzWvO26jVVJ+wX+pTlo02ekMdfyLu1fnBSDlxI+
 oIf5r6UEJUbI6QL4akc6vFkLOagei3KWPjRtJLg5XRIVMRt1h7C4ZDm99o5GYxeE0M9H
 a7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778567141; x=1779171941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dKbUh8UPNvo4Yd3qJ+VE+MguhwOizfDZglByQHiHicY=;
 b=sG/2YuDjnl9iF6HeFrm4fuqjBk94MHMfOpEN/xjoBifF5pZCE2kiOD5zuAzvLKL242
 0D1PGWUeqoCj3ZJLp6clxDuETKL7WtCT+mjb5mKLeG8P7x2VUCNAk9eWbDpC7Nbd791o
 MtzPu2Rm0j1KLeYXv8+SkVijJb1KCg8iVlcKs1dKhH/+0pJOKrLOfXhR3rBF7QxdInrv
 7g0bqR7+DECKfF/mHnOfhxP8o4tBTE+u2Df7tqP7hOpndYMTXZJDZ/PyE+3RPONLG4P6
 TRXARyP6Eyi70rMbl47uqjHOgWyllIA7U4gvh9TPL80DrZrxIlloQ7xDYUzF20BQe1ma
 OBJQ==
X-Gm-Message-State: AOJu0YyggTIwEKUVSQMViVi5/XAV5xCglsO5BDi1L5/QHawmDsnoDTSF
 5tBabLQRYvMvpnpOKq9qhc8TJwyZhPpFEd5kIvzC3gr5F/Kiv3tyjRePAgoU+iT/JpT6rilKFWU
 u9enhacQ=
X-Gm-Gg: Acq92OEUoAxGWsd1UyDjRbOprkuP8mWMJRkT2pJ9g6tKN1SSZtO1Ei2izY1Fgw0DxKm
 cONCJSqqDTzEUdPcPNEvFawLW2bqdAi23D5J4lg450seCydir3pUC5T9CPRIG7GmmddZ4GeKia0
 XWJd4LjZVSfMBOcENik0CQ19553LPbMnv95uEPX4gTlR66HIiJvszloT10EdWW+5zHJlJJ6g2zd
 n2i/N9MY+hqGYuKOSjnGr2xi2j3iPKCtdY/6tXsGuvim3acKwRaMACdqHVGbeUohSXIdGheLq0Z
 bfPzEwBg9R4Lq3CVMW3yLpwcQGvKJT4W221EJzNIWHXlS5o3oJACEUb6haxe2SUT/8nIemHxMvh
 W2FBE1QfoC6y2iQSlflfVUHRt/EpkZPthu2TzMsCA9eqHTi7cp011+Vq9vEyqSCJEvJdlgw51iD
 KEAyEt1mVh1x5o7oqbObXBsYJABkKTstn6aujdmEH2gKkZJVP8Vv05VGU5FTU3k/h/o6fn35Cj
X-Received: by 2002:a05:600c:8b62:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e6748afe8mr252407775e9.5.1778567141279; 
 Mon, 11 May 2026 23:25:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491e94c0fsm31388259f8f.32.2026.05.11.23.25.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:25:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/41] plugins/api.c: Use cpu_translate_for_debug()
Date: Tue, 12 May 2026 08:21:34 +0200
Message-ID: <20260512062142.67998-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

We want to remove the cpu_get_phys_addr_debug() function; update the
plugin code to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260430093810.2762539-25-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/api.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/api.c b/plugins/api.c
index c97cc688825..2d5fe9327f7 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -617,15 +617,15 @@ qemu_plugin_write_memory_hwaddr(hwaddr addr, GByteArray *data)
 bool qemu_plugin_translate_vaddr(uint64_t vaddr, uint64_t *hwaddr)
 {
 #ifdef CONFIG_SOFTMMU
+    TranslateForDebugResult tres;
+
     g_assert(current_cpu);
 
-    uint64_t res = cpu_get_phys_addr_debug(current_cpu, vaddr);
-
-    if (res == (uint64_t)-1) {
+    if (!cpu_translate_for_debug(current_cpu, vaddr, &tres)) {
         return false;
     }
 
-    *hwaddr = res;
+    *hwaddr = tres.physaddr;
 
     return true;
 #else
-- 
2.53.0


