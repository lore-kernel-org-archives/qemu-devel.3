Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0FCC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 21:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7KuF-0001NT-AK; Tue, 22 Apr 2025 17:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ku5-00013D-4L
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:41 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7Ktx-0000QC-4C
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 17:11:34 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2260c91576aso49569305ad.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745356290; x=1745961090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DUF+4Y4/PqO50T2IhlnvWA6B/DIxYokH9Y5du5vjVAo=;
 b=Kg19Xh/D1KY5PbcsnTi3QdbSAjma+/YQOdvfHLwc167i1A15NsJ+kD/rgIJs8qEFQQ
 Tm4ibXAddMLIUZ12i2/r7Y1kN7p+H0IyWuhY6wU2oxrIYUNQ9qneKzzeduZpM5VV/hJA
 XjOm7SAFQUhGGDD+2UyrSkIuz6Mw4+Lhs3HEBrmoMB5DIkthKyEi3WWwaMXDDGBGPYgs
 VtX5tqeK+bcr8E3ChYR0LE4abxzRb5PSXa3apcmmuEAadHtLZGGi/XqrN4KOw6wrjunk
 ndZp59OJ/0gel9z6B8eTO1+LFaSygAY2dvxLobvTQ5+Q/1Dhmqas36jBo28rtVE9vdgh
 sAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745356290; x=1745961090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DUF+4Y4/PqO50T2IhlnvWA6B/DIxYokH9Y5du5vjVAo=;
 b=uwxWqlCvKi0AZayV/Hx3mixvy/unNAVC2AiSbXsGMDIcfhitUuP6XWr28WRu3f1sZ/
 1/UR1eZG96emnMb/IS0667grAj4NCiohzMV+aZ2vYWrBTVwxekQViHY+yt41se0VZJJl
 jnRzySBYKDBBnaMoQPtHuK/6WZNsChztdEsacvMODtyemPQ5QBP+OKBlKdN012fpXm+9
 YAD728idTGGHYJbrdhZdZVHbNcIXpXD+A3w7RKGqPUFJjFQEP86DVU583k8ZxWJsQNn+
 CqTHAdDk1jpaEtolDB99BE9ZWQd0ytTSRjbZeeSUm26BmP/JxlxpiC/7/epwqKvSGZ33
 kcbw==
X-Gm-Message-State: AOJu0Yw2FwPMgrMGVB8JTUXvefVSsvZV+ZrgCTV16qn0JTQYQhwojjP/
 inivN/Q7xI8sjxqP18C5ls+1lisxBJIcshkFzwcFuju+6wuDySBffCiL9QQf8dj3YdsZpB0cFo2
 C
X-Gm-Gg: ASbGncuxyuQdRlpQh0cbc16nMOjoUDzb49856wsUJ/koFCyMXKCSH02MeKFmzJ1xL7y
 iX52rvfksB31g0eu8Bntpcfh++Ibg3iDv5z+ZD41xZPa0ggtAKC2XMt0KjbUDA77vXiKiCG5686
 0oGbFJVdEBxGnoWm5u+qTdOTINwtjppxsXBAJd/5m5TIIvzp0HgTeVx/E2wzrBw42v+VFsksZpx
 fJmiIF0XH5RsFqIfPLbW5tIfab1l86ZEFLHyInkeAC5zTIlT3CNUoL0ddqsqVE4DiB4zmcgln7Y
 70geWCtgHGyvd+gRDl5K2bIzmZ4/PPV/f+q6i7cBKV2/OTe8tJ901O6/XjwpVVC1v5E3eS7cxdY
 =
X-Google-Smtp-Source: AGHT+IFwofosnLaGa5ctNpth/ix1ATYCi4YSKHCWu1cajFapC19ohtwvKdNz9P9PfVezq4NFpkDKXw==
X-Received: by 2002:a17:902:f684:b0:224:194c:694c with SMTP id
 d9443c01a7336-22c535c03a1mr263373495ad.28.1745356290191; 
 Tue, 22 Apr 2025 14:11:30 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8e4932sm9448160b3a.55.2025.04.22.14.11.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 14:11:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 7/9] target/avr: Use do_stb in avr_cpu_do_interrupt
Date: Tue, 22 Apr 2025 14:11:22 -0700
Message-ID: <20250422211124.305724-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422211124.305724-1-richard.henderson@linaro.org>
References: <20250422211124.305724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/avr/helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/target/avr/helper.c b/target/avr/helper.c
index 7d6954ec26..f23fa3e8ba 100644
--- a/target/avr/helper.c
+++ b/target/avr/helper.c
@@ -88,14 +88,14 @@ void avr_cpu_do_interrupt(CPUState *cs)
     }
 
     if (avr_feature(env, AVR_FEATURE_3_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
-        cpu_stb_data(env, env->sp--, (ret & 0xff0000) >> 16);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
+        do_stb(env, env->sp--, ret >> 16, 0);
     } else if (avr_feature(env, AVR_FEATURE_2_BYTE_PC)) {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
-        cpu_stb_data(env, env->sp--, (ret & 0x00ff00) >> 8);
+        do_stb(env, env->sp--, ret, 0);
+        do_stb(env, env->sp--, ret >> 8, 0);
     } else {
-        cpu_stb_data(env, env->sp--, (ret & 0x0000ff));
+        do_stb(env, env->sp--, ret, 0);
     }
 
     env->pc_w = base + vector * size;
-- 
2.43.0


