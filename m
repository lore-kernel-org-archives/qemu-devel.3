Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF24C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:31:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC57R-0006hg-IA; Mon, 05 May 2025 19:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57G-0006VF-K1
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:54 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC57E-0003gZ-Sz
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fd89d036so56058115ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487251; x=1747092051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=YejZeZaSEGZl1FuBCwoZYGTqVPleGuGajqtzVclxP7vYSwW77pwa47qOBHMjDoI+H3
 GWnsHZ3oCCtsAGpGz32MYEDO14WbObxgQlessDavXjtM3HJvL3AdzhivLjcMtmzI5TI9
 FVDEYfB8FiaHrAzt6Htx/v1SAU/zC7tSCfja1HzuW3s5i+EW7UOecCYMjgNILW2descI
 GApTWwON/n1lMHOMm/u5DUzELt3/PvyAnJglKIql4LIWtegNMJvUXB9hleOSmT+9DfUK
 boMmOESPq9FLIy33Hrzz+gD75jLxJu68r8qV2NIoJFi1DFmFr3jMjTJu4qdkvgpG/0yG
 Xbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487251; x=1747092051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rXLXuVNGEyfjK9Yd01QUJZvt/uyYRhxbr8cOAxNhYLE=;
 b=NZrf9bJCRPK3UAXnPwOrMGzN3Yye5S6qr+Dp4aCTlKiwcBhaZrLGK5eZtYoKMd7i45
 8dNf28WTbFd8JA/L1Z/C93aQF2sqw0ObmBRiGq66/mKAb3mo+QDKc61GiD4N8uYBtrPQ
 KjjVTPH0Kp8ppC8NeGySw925DiXBTRBigeOcWG0B0KpMVNettxn3YxRKTA7Ocmvs2BX8
 4CGlmWDaym8bZyzG8VltiJjSX2/DD7KMJndXBgd3RL42OGRB6zn3Z+MPdbmctg5sRckk
 8BUINeDOmv+bLL9PerhVl/D7qqHdxQFESSazhaqiYuPq/3zWnUv8V49Xz9IaPzfSSdXk
 xRwg==
X-Gm-Message-State: AOJu0YxifVFZpWIisx6rId00G6Ri8jT5/f5VxsGXw1ViZ06JwiHW7IDY
 /WinNblfUGmWEvWvXveRbWkDAuOsXlnI4bPn7LxkFPjcvdg5SvxMp+wFB+24wVxV3G8Svt4tE1a
 KgCI=
X-Gm-Gg: ASbGncvOHbjKfKOyTZ5uRXQdpxNa5kZ/tQS2zKVVJqNDqsuDYFLXdcXQ2L0xWVoOAeL
 Tn8R/w2NnldznC3i65DO4APsEj3MuKtGBTgBQwY/ld4GNLrM7JHaU21zr0KTLICu/sd2atvTQ4b
 xWMQEtWIRxCEKkx7s4gutQiC/h1m+mbeiCOFjazcqVkRVJq8qQTTJ3bIH+Jj2JJyZAJyrgRHdMG
 tyKpYXytNj9po90O9C5QRrS7/q/V3JVDOPSzy5iI4jzwElL1LxYXf1Z6fcfgPok+IuAhP2b/jQP
 R49gewJkSovxMGiocMKS2bFKBns5wRtJXNnL7XZf
X-Google-Smtp-Source: AGHT+IEsUBiJC/ed4EmIFp4CMdEt2kVOvqBf+kcMrtQEGptIGUO9Gn+sgYxrtYlliG0ZSCN4Z64t6A==
X-Received: by 2002:a17:903:fb0:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-22e32a50fa5mr15676655ad.16.1746487251596; 
 Mon, 05 May 2025 16:20:51 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:51 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 35/50] target/arm/kvm-stub: compile file once (system)
Date: Mon,  5 May 2025 16:20:00 -0700
Message-ID: <20250505232015.130990-36-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 29a36fb3c5e..bb1c09676d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -15,7 +15,7 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
-arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'))
 arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
@@ -32,6 +32,7 @@ arm_user_ss.add(files(
 arm_common_system_ss.add(files('cpu.c'), capstone)
 arm_common_system_ss.add(when: 'TARGET_AARCH64', if_false: files(
   'cpu32-stubs.c'))
+arm_common_system_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 arm_common_system_ss.add(files(
   'arch_dump.c',
   'arm-powerctl.c',
-- 
2.47.2


