Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D594CD3442
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcuN-0008Gy-3B; Wed, 06 May 2026 10:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcuB-00070v-0N
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:16 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcu8-0001tR-Fs
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:07:14 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so2257770f8f.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076430; x=1778681230; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dOa6f8yuz5bo2eIZzKe9+Aig/0vO8+i13l4uPJEsyUg=;
 b=qqvY1nhb4irpatC3f4bFiZpJuTj2NLT38jZ6cqYgGa1ol5P+U/XchN/h3Y3COmFc9R
 uvY0tQ2cK9HhgWZfc7zuFV9UFRYs/GjsX+0IGxF+1kXxi3FwoTWUIrCW6lbNASY1U62p
 c60gw9hUJI5RogkHL27oW/hKSX3LHnjUPZaqkX14ltX3h+HBrqj8eXOpQkS9MpYrGzAY
 pynAkXGW6QdDjQYi82Ue7Wh+QbGlJvfBd6Jx7wZFFuzxfzkuHNfKGgnWdRpLa8dM+s+J
 Hn88oKHyJSpvaYWmVSWnNbmeUviUI/tG7TEp3lW85A7zBn+Vl0K8AIBfC6JkcuqnPx0E
 BxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076430; x=1778681230;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dOa6f8yuz5bo2eIZzKe9+Aig/0vO8+i13l4uPJEsyUg=;
 b=QDL8732HVXoPgVtLgseW8Y/ZQ1YSetIuFuqFKHhFROXi4f/vCmW20Fcpk5lKk9Tsl/
 E3GWknUDd3OeqdkDJ/2bYGoJ7t6zf7xIP9dU89TsDCluz95qw+gfxQBPcM9jvGYO4w53
 GiecesTwhXEWXcg/fA7vs6tnJqISyJ4ra1X7H828ScYUqj4s6iSqVntgK6ortQjS0UHP
 0+2EwXIzB9yGJAO+hSvhBRbd06MNP2trm6y0MTj5bWAHDgnuplCPXkXqzuytdwV/aJB2
 CWw7HG3a72rsWWZ8/bZBgKw+0w6fIBl2Y6bJsi2LJCia1y72K+rMyxrJSL0O9MBdvf6p
 9TVg==
X-Gm-Message-State: AOJu0Ywmi2Cg4FPTmx5I+5KrqYzTVSoSC+gB6od0a9kRLBwB54ykdgJm
 1f3kQK4mz/wbujb1dq0KaCjQSz6B+NeZuGYSVEUKNwqLYL8MvHY3cKKukx6MIL4DQsdrTz/nItW
 +y2MBOqA=
X-Gm-Gg: AeBDieuaIQ3ZCMZT0WYnzpQTWorcC6d9K78Tcj4d2qYiI7E1UchQcZ1xDfA6M/szHB2
 uFmQRUIsflVTqrTTD+C2QiKLmWLyPuhR0SDl0Hvpi4BFCnbiH5SAa5usdYYBTUbeIl+osEsCSvf
 J8Asp1LKSTmCELZCZFq+iQt0G6VRta+Ma1iwsb+SNrHWSuPf3VOjQy4SVYNEqHxQ2PDZy9pfPbW
 WlJ3ENp2fh5yTH5Sl3BikPAMxlDf7Qy4/0Ff0rjbgBJFxAGF+q4x/iYhzlOr48kFgnNGVZHeL5s
 qVn7l9GnkHYbvAKBuF5CZl/A7cbtrCrA7IjzAmqyIdHSCskzq+elg2i4zqPcnM/1k5B93+15Cre
 UztxaPiDCf8wIvLMg1e74u4TV5EmIJnUo5zooTFa8sUz/ZOZeSENQiLP7i2myCfEdUXHPLkbzHB
 jS3tAv5CZimWHtPIBb4ucl22YNMG7XASBR0OLf+JTTasMyGs/9h3vAgcW6diEvqoFlWLtk4AazA
 KF0ZDVtyQpQC6KhmoLD+w==
X-Received: by 2002:a05:6000:40da:b0:43c:fb48:6856 with SMTP id
 ffacd0b85a97d-4515ad7678fmr6969865f8f.13.1778076429594; 
 Wed, 06 May 2026 07:07:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45055960022sm12843724f8f.26.2026.05.06.07.07.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:07:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
Date: Wed,  6 May 2026 15:55:01 +0200
Message-ID: <20260506135524.20617-90-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Introduce a source set common to system / user. Start it
with the files built in both sets: 'cpu_models_user.c'
and 'gdbstub.c' No logical change intended.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <20260423135035.50126-4-philmd@linaro.org>
---
 target/s390x/meson.build | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/target/s390x/meson.build b/target/s390x/meson.build
index 6f98ce34d73..44f58ac2919 100644
--- a/target/s390x/meson.build
+++ b/target/s390x/meson.build
@@ -1,4 +1,9 @@
 s390x_ss = ss.source_set()
+s390x_common_ss = ss.source_set()
+s390x_common_system_ss = ss.source_set()
+s390x_system_ss = ss.source_set()
+s390x_user_ss = ss.source_set()
+
 s390x_ss.add(files(
   'cpu.c',
   'cpu_features.c',
@@ -15,15 +20,16 @@ gen_features_h = custom_target('gen-features.h',
                                capture: true,
                                command: gen_features)
 
-s390x_ss.add(gen_features_h)
+s390x_common_ss.add(gen_features_h)
+s390x_common_ss.add(files(
+  'cpu_models_user.c',
+  'gdbstub.c',
+))
 
-s390x_system_ss = ss.source_set()
 s390x_system_ss.add(files(
   'ioinst.c',
 ))
 
-s390x_common_system_ss = ss.source_set()
-s390x_common_system_ss.add(gen_features_h)
 s390x_common_system_ss.add(files(
   'helper.c',
   'arch_dump.c',
@@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
   'mmu_helper.c',
   'sigp.c',
   'cpu-system.c',
-  'cpu_models_system.c',
-  'gdbstub.c',
-))
-
-s390x_user_ss = ss.source_set()
-s390x_user_ss.add(files(
-  'cpu_models_user.c',
-  'gdbstub.c',
 ))
 
 subdir('tcg')
 subdir('kvm')
 
+s390x_common_system_ss.add_all(s390x_common_ss)
+s390x_user_ss.add_all(s390x_common_ss)
+
 target_arch += {'s390x': s390x_ss}
 target_system_arch += {'s390x': s390x_system_ss}
 target_common_system_arch += {'s390x': s390x_common_system_ss}
-- 
2.53.0


