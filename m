Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E6CC3ABA3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 06:30:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uANLr-0005t9-1u; Thu, 01 May 2025 02:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLN-0005IH-U3
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:26 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uANLI-0007PL-9J
 for qemu-devel@nongnu.org; Thu, 01 May 2025 02:24:25 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso813374b3a.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 23:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746080655; x=1746685455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C6DezxTsq/qsXh84VFmp7K8Dht2SMC+Ysjj9VaUYBm4=;
 b=bHRwSsEHP1EG3gdH2Qh8hEtU80ygvpba9cY42ibYJp9ZkjaSVX04ub1QlBc/CM6Qul
 9l2MPmdYAF4QdfMZoWSXgKlOGTz0iVFXGqadP+hm482oOIJF1DHqEdJna3swxEHaWbSx
 d0HxMuc9GtjprDxqIZySZ+E0eWOjRdDvWIWFVb8EX0Q55p60sEiISlGh6SrAgSoMWcas
 ghj5zj0nctfS48AT3mgV5hND9UubKZNgKpsrT0KW6To0ugX1QhZPWRcO8G/7aL+9uD7R
 DtrpsDjz2mhzM1RCMKrdzop7rL2jJt19VURR6hn+U6PgH+ttvw12YjNahtsN0Lvc/Vdk
 YSwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746080655; x=1746685455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6DezxTsq/qsXh84VFmp7K8Dht2SMC+Ysjj9VaUYBm4=;
 b=aI92AWT9clsKv6Iq7uP04S7+DSZF+qi2PPs1tsgx7WvPj7Rzh8eFkDKnuMP+H/NjWe
 QokgVEj8uWEFCKZ7WycTEqrwUPDrl6PVKMV1bsUN7s4QPpvAikfIRoLNn7ejdfks0iMc
 XvfCaC/tKkOveB7Rps2tT7aZSyhXlIzbfolBZBynhMC2oyLQ4uLS8OYGfPacdQnVj0GP
 arfIScLSeceN3JUGymsWY/jf4VY2W2UniGqeG4+chM9iS97IsM/sBdW8JoGsRQ6pRq5U
 0WSy39f2J0xttdyf6NNhmwi9n5izHF2hiLmyj7AWRpaLcNnOT4pz6MKP20VyWa512F9V
 v+0w==
X-Gm-Message-State: AOJu0Yy1PDkZ1T9eAR8pKbdpHDJrDchYf6BRzQtLrZa/aBA3Fy6is6yy
 7kK+qaYjESjXrGao4y1M2ENTDG2hKN5d5VtLGe0O3eDF+cqCHePtnRjp/Yws2oITldo2rEaxneO
 S
X-Gm-Gg: ASbGncsa3iSh/nWfXZOKCrVruT/UtkRQKx8gSxHM5K8pEzogHjiQ9k9dw/0GMDxZRAi
 QKFZkNhCcWeUMj/1eU3bgEovqZNZHvXyuadeRuF8/1gRt1JcqhldZiShD7TgaWMtdtpVCM6cW5o
 08hg2zt3sKAkN9X0duKi+AFdZYJYR4LLCH9EtUpWiTm4utVQV1/4eaeZmDmUyeHNegAYTfStWho
 /eNUwqmyzhaF21OxSibBCt0Rq4sgNYEMeN2CBDqdIc9MfUzVNpmE5zZv3welkIC6/B13RRris0h
 GhgiXTw0lrhHTF9enMQ+e379liddX1kEHEs9hSi4
X-Google-Smtp-Source: AGHT+IEmLnzJSDHKNiPbTs6xdmLnJGuNIaAbjxHyHGNgoSlitEKO8yt6BGj1kETTeGFLW9EC424X6w==
X-Received: by 2002:a05:6a00:21c6:b0:73e:23bd:fb9c with SMTP id
 d2e1a72fcca58-7404926c836mr2286289b3a.23.1746080655598; 
 Wed, 30 Apr 2025 23:24:15 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7404f9fed21sm108134b3a.93.2025.04.30.23.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 23:24:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 27/33] target/arm/arm-powerctl: compile file once (system)
Date: Wed, 30 Apr 2025 23:23:38 -0700
Message-ID: <20250501062344.2526061-28-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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
index 95a2b077dd6..7db573f4a97 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
 arm_system_ss.add(files(
-  'arm-powerctl.c',
   'arm-qmp-cmds.c',
   'cortex-regs.c',
   'machine.c',
@@ -38,6 +37,7 @@ arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
+  'arm-powerctl.c',
   'debug_helper.c',
   'helper.c',
   'vfp_fpscr.c',
-- 
2.47.2


