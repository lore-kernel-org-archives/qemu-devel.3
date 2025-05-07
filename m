Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBFDC3ABBF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 May 2025 23:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCoQG-0000pX-E1; Wed, 07 May 2025 19:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPz-0000LR-5m
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:15 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uCoPx-0002b3-6Q
 for qemu-devel@nongnu.org; Wed, 07 May 2025 19:43:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22fa48f7cb2so332175ad.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 16:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746661391; x=1747266191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=fNe5dJdrs3cD03TMrVXyBIbe3a7OUeIpwTS43wnhzKeiuJD/dlT4Q7rWk0KicxTodX
 Px+dNERbzyrJQPcVFNXAplUP9p3ZX1fK+C/TVdRG+ST0cvwwagd4aAG2uCjOiEjJIO9P
 PIk59PK5+jmcNrbgCrgmJsZFe8e0zqvgBPz3fhqagSyn8oHJIJD4BLRyy9nF+yiSw3Iv
 8Snu53Oz7NzFUdP/XTmUltEf3N8xsaTDZIzLxrxRsxlu1SxtAg578MsYChdoG7xLOCcw
 4XpAafvYOF9BoutJcB84i7NczPpUiGw3Ak+xKaeTjTSq+7EC2YSuvi2CsR1ZSKaBokV0
 NoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746661391; x=1747266191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzXXutq4wGalZELe39I44dxOL/4dV/vBf09UEOe1qt8=;
 b=K2qJI8SpOA6K0nU5E6R2sNj/U2iqaKC1umpV5JAeG21aiVbcs6tuutDOuk7ppyc7xW
 +79ikjHrP/EqtnzVgPLsCGE47K2sQ3kjaTX/a+QBRznEFxmfVnZaeuerK/bX3APF/m/y
 WJ6zBYil1pBXDyk4HYMmG5+v9NqgwHqdc5NfD9eGtC+RjGdpYPYateFrZd/6sJ72u2bD
 rGyhT8hAhEqWspTBzYG/jHU3/yV9Lbyl59lRGjpvcTtQS+XkQ6R0KnSBdOtB7AjXftbP
 AjEw7fwyM+g64T+jvGeT/Ex3QajKuIkle7JIdwKVz20M+XuPs/yqJal7lNSCuw0SH4YW
 Vq8A==
X-Gm-Message-State: AOJu0YytVj21insal9MyoTW/C5xPtPjixNEe1qkc5iXN44jdDqZFYlGR
 QWA2XmyD9EPnY1WzPofIwJ8Br9nEZqjk/TC2oW35bEOhsevmwKQGya2xKqSBCYPKWbNaea+V8Bs
 Vkj/WaQ==
X-Gm-Gg: ASbGncsrXve65h6/DUFo1JF7/5rWq40GM1YnaLDEdzCeEe/aTDnEXOi+pY8Ida/yFRt
 bwdhi25l8RPysZxUhfvYBpADN9x8THWEhfMY7ftJ+Vn4C8XKVkH42EI4VRGmkPkuvIQpWA+pbEu
 jRhWhZqY6iFMysj/WAFqa3FFjMqKv5iQMFHaCpRu3wRsXoctlayXEXZvgtl6viRH+tFKsZStEFl
 4N7bwxa52i8/veluKApYM2qO2nlHKsdjKMFDCQFmpAX1HgFU7UOMGrC0CJpppcX16J3SyFDAh58
 1HaM7KS+/BqSFPdcXR2av5LJKs6M6qmcCYN0h3h0
X-Google-Smtp-Source: AGHT+IHHfhaE4ghnmTMiN28gxoqvv77AomE+VUqZxmC/QGbe+j45MBaR0QwIVVJeXMQ0iZnyM3zNjA==
X-Received: by 2002:a17:903:166e:b0:224:c47:cbd with SMTP id
 d9443c01a7336-22e5e98947fmr80627715ad.0.1746661391705; 
 Wed, 07 May 2025 16:43:11 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e815806fdsm6491325ad.17.2025.05.07.16.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 16:43:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, anjo@rev.ng, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 33/49] target/arm/meson: accelerator files are not needed
 in user mode
Date: Wed,  7 May 2025 16:42:24 -0700
Message-ID: <20250507234241.957746-34-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/meson.build | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/arm/meson.build b/target/arm/meson.build
index 151184da71c..29a36fb3c5e 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -5,9 +5,6 @@ arm_ss.add(files(
 ))
 arm_ss.add(zlib)
 
-arm_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
-arm_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
-
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
   'gdbstub64.c'))
@@ -18,6 +15,8 @@ arm_system_ss.add(files(
   'arm-qmp-cmds.c',
   'machine.c',
 ))
+arm_system_ss.add(when: 'CONFIG_KVM', if_true: files('hyp_gdbstub.c', 'kvm.c'), if_false: files('kvm-stub.c'))
+arm_system_ss.add(when: 'CONFIG_HVF', if_true: files('hyp_gdbstub.c'))
 
 arm_user_ss = ss.source_set()
 arm_user_ss.add(files('cpu.c'))
-- 
2.47.2


