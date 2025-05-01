Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9003EC3ABA9
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLs-0005vo-VJ; Thu, 01 May 2025 02:24:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLP-0005JS-F7
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:28 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0007Pv-OC
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:27 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736c062b1f5so757756b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080656; x=1746685456; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z22S85haL/KF7qK35umsJwcCPzG3sLDPMH83wLAS3JI=;
 b=lzkJAJ1as1+ot9f3UN4HMVREAAJGax0PklfcOchKIGPQrtDccJEVG2upgo4hqJe1AU
 kdouB3E+OmHksKyeT8DwrQE3Kuz6W6E2vgxl5NAKRgG/b+n6XvrcYmGsCsXFwgjXv4FP
 AiabFu4r3+TeG9ZCgsCbOdltj8SvCpbcvl3BO9nUzmEZNiraMMQWbq/1j+I0krPT5INC
 G1lCH3YxT8xNLnRNpbCz5rQLuj6yDbZZ30R/eyq7By2UeCXFDp1YzHVONUvzC9K8mR38
 CDXYzeBNFpQwiviDXw6ahz1+sx6sNSQGMSLJS1DvTyrXMIBko9XpKKwtBht8Jmn0ohQW
 zdwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080656; x=1746685456;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z22S85haL/KF7qK35umsJwcCPzG3sLDPMH83wLAS3JI=;
 b=bBX+b+pKYCYlxeV56L4DqGzM41Pljev9DhzdAXKaZTseLrkGtRozeeGAYbSR7ITOCM
 zvTWJbxWG1X4U6UUHKVQgfXsUvYxH6z3iw5sx8ZPs7orn8IJNDM5djjuxvjAQOVZZ5Ln
 jcmNBVZlC4mkHYi93FQ7ESLqfrEtJDRlIkgOtVhKixCs4PtwDwPfVZTfNG0KRoJBVBan
 /6i36lXhDmASqMEhUmwVMzDzEQX/VlKTtoQ2omPEryDkqQnef33vz6XS4/kdFINVbJk2
 lgfEdLrBLyLjr5MgstOE9v27Cs4enOO/PvSpnHyLOWz8CbIHCdYbwQlOlB7Yedww5OJV
 aeGQ==
X-Gm-Message-State: AOJu0YykRncWwRG4nBlnY+Jct6229g9HmsUHOukR06cC8xRYpAPjn6Se
 /0zfnTC9LQbVr2Kp4lYf5PZDkt3I9dDMqVTsLRmkIQrNuVNn496yl3qxjc88MWVHQFNKjyZlLCI
 s
X-Gm-Gg: ASbGncvummNNYsAanSLubaslcNd2yThk57UXDpc2b+7N57GmmVs+lGKSCib/DTWf+jD
 IiXOv2kOOMr5w8GsJ1iUp28yVf/1L6OZMty328/rqtMdySpwvkxT3IyM794sMzPzXItl3hhkFu8
 /uaD4+SPPA1SeUXUWgyGrreBaaUuCD40bitNFqpa619InNoKrOfvVTqnSzH27v+l2SmI3Ntz7il
 Ja2Mbu0P9wWXsfyIowxmsHQ/hIoT6iIzV7FSsijQpDAP5KPeb+KxAyIdyGIZNe9bGEWj7ckMQvm
 qCwYNqJxuFNZ9YVaG/s/AI3Yvo5WUGRUDYA2Ce40
X-Google-Smtp-Source: AGHT+IGliq3ReuCnpBopZwRu0exFB8q6L3+dRZknQKd9EToD7dD/BV9xUglJOlu94RB9QZb/pidXAw==
X-Received: by 2002:a05:6a21:101a:b0:1f5:8605:9530 with SMTP id
 adf61e73a8af0-20bd804956dmr2006315637.28.1746080656445; 
 Wed, 30 Apr 2025 23:24:16 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 28/33] target/arm/cortex-regs: compile file once (system)
Date: Wed, 30 Apr 2025 23:23:39 -0700
Message-ID: <20250501062344.2526061-29-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 7db573f4a97..6e0327b6f5b 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -16,7 +16,6 @@ arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
   'arm-qmp-cmds.c',
-  'cortex-regs.c',
   'machine.c',
   'ptw.c',
 ))
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
+  'cortex-regs.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


