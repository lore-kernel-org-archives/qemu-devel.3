Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E015E9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eS-0002zc-Kk; Thu, 19 Feb 2026 14:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9e8-0002KV-Gj
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:08 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9e5-0000dQ-PK
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:08 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-483a233819aso8359575e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529104; x=1772133904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9OteUgf/09+ko5GX68lXkadYZUyVLKdfi6k6GY2WMzQ=;
 b=su6bWR6uMh7J8qYUmAnw06LkDTj9nCOWnQpE7cbkgPEhlQHHkwZqSTj1DrJqojDId5
 cH9RSNp3cIYQXa5Px52EUDU64rK4J0A0znfRmjCyad9UWMF85NkwOeYtdXcRyfKK40hM
 T7i4oM2j4fdBpkysrgXBHTX26zCghojVmxfidRv+mQXmQv5mSjVirrhtTK/wIJDurcNw
 J8ek+zhXIWBI5sgPhmzVR8vykdvxcPgDv9X/YLx2/oegxQu+EM6a/QeWTToA7E+Tlkiu
 9Gtg9Ukm/vhqQQAopXR/A7zp0YsRUzQ8wBHzdGBNJumdrpiMASYr7ekGKNhWEJSDRCCS
 +TEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529104; x=1772133904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9OteUgf/09+ko5GX68lXkadYZUyVLKdfi6k6GY2WMzQ=;
 b=hctNWtE42piGT2/0snHctkGFMT6B9rvI3S6kPcOti121I7F+EZ6o8JSma/lOLVLA4q
 o6ODn8SnglwD1xF7t/ATtLAifCK8GKp8aB8JauLU1hLC84YpCW8tiyL+eQfeF97P+cKq
 C0lXd6N1Wo9fd7fGqaGf9iwQGNckWs2Y0ICcs1Lha3zE8wH3XO3C2MhBooc7u7lg0Oge
 XiMQvYvmUFe5SjbYRx4jaf3WeumxlUvNPwur3xcWHGovTiVKuPqExrGQMyaemIwwO04T
 FQd/21lGmfMQLdc+GfZgwUX7j/gfgK2YA5HiScsOVzyOOkJWC5rd4buo0PY0ce3p5SrP
 8iTg==
X-Gm-Message-State: AOJu0YzE3cAi8RlqH9c3J0GTARbkSg6QJHNRj60CBrRcZ/ERDkEF+RfS
 8BxCsf1mr+ZpGRqDffJrlkpdYSNQ8XtWfdDNAC+Bxa9Su6BLHyIjBaq3KV7nZo1ND0/tTl7UPp8
 xq3VjmXvltA==
X-Gm-Gg: AZuq6aJdRPM/fs+AOuTwbvyWj/aHisq4xeUBMbg6rhj4ymq31J/syADoYJ0dLMXGV19
 CWCky6/och0y5raYYcjfHfCriyR9Fphts4GGE+DUfJev1Vlyt5VmIjIcmXetBbLGzsNq7QsvZYe
 wAoMRl8VIpaouxQYVlyxqAoU6PqoTCt2tzek93Za26j9vGtu/z0hm8fRTxyzHx3vtMIhDJK5fpK
 nru8gmbs9LeaiIA9rgANeIaxk6rKEpH+eiA4CVL7tqFrx1FV1jUrO0xCtUF75P7Pia51Q6Fkea8
 HaqAJkmyBL90M8lvN/ZDBkhC9a8BofoBgb/0HZewhfxKg1YfIQFSfW4JZoaRdzqzzQaWGq/alV8
 T/gBlyVzb6cCsScvMQzw9DU62kpayvznq2JIkZtQeXdcCYQpA5VU39EPrrqGUKLZQ240xgiAt9n
 CXIVJX8/RQDzO+8QOpa3Gd2OJLHPC0q+dFYVoIDG64d2MqbZUN/2ADJkhNQhOVHD7FqcjnA8eZ
X-Received: by 2002:a05:600c:5289:b0:483:71f7:2782 with SMTP id
 5b1f17b1804b1-48398b0990dmr98443465e9.12.1771529103948; 
 Thu, 19 Feb 2026 11:25:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a31f9af5sm20031175e9.12.2026.02.19.11.25.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 43/50] target/alpha: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:45 +0100
Message-ID: <20260219191955.83815-44-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

There is a single qemu-system-alpha binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/alpha/meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/target/alpha/meson.build b/target/alpha/meson.build
index 9447f8020be..818256a1c31 100644
--- a/target/alpha/meson.build
+++ b/target/alpha/meson.build
@@ -2,7 +2,6 @@ alpha_ss = ss.source_set()
 alpha_ss.add(files(
   'cpu.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'helper.c',
   'clk_helper.c',
   'int_helper.c',
@@ -11,11 +10,18 @@ alpha_ss.add(files(
   'vax_helper.c',
 ))
 
-alpha_system_ss = ss.source_set()
-alpha_system_ss.add(files(
+alpha_user_ss = ss.source_set()
+alpha_user_ss.add(files(
+  'gdbstub.c',
+))
+
+alpha_common_system_ss = ss.source_set()
+alpha_common_system_ss.add(files(
+  'gdbstub.c',
   'machine.c',
   'sys_helper.c',
 ))
 
 target_arch += {'alpha': alpha_ss}
-target_common_system_arch += {'alpha': alpha_system_ss}
+target_user_arch += {'alpha': alpha_user_ss}
+target_common_system_arch += {'alpha': alpha_common_system_ss}
-- 
2.52.0


