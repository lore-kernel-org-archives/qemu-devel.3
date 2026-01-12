Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23A6FCF45D5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 22:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfQn0-0005oH-Mw; Mon, 12 Jan 2026 17:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmV-0004So-JX
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:05 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfQmU-0003SX-5T
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 17:53:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so66074365e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 14:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768258380; x=1768863180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fkCk3ooqp4kftbFYAk6+ZpkTFJFn9MspF0xuqqcckj0=;
 b=Por31/zqWOcItAVihcEAkASTAEcc3XIS7QIKRHBgeFyK20NrM2r8IUfGnNsZUQywPq
 L5hklZ71ZKimdzywvnmy12VTnDTldprNfAN+W2qUBjYs/ECJjpkgini44UPLlbFwwLUx
 laP3jfNegueJtg3UvYsz6QDNmd1Q7Q4DffVctrMx7VbwZOHKMLov86PjccW1SUwP/I7x
 Rj7O7+z9j424w6xVR+dTa8QQVfvN6qQNB3QB4/cZV/9fs5Btqop37RRzoQL939TpyGk3
 io4LtUeLV1fh8ccYUI89HnE3AWW3T46XKxdv1SYMaIElBhgdPvxrBs8312XOrJwTL+BA
 RQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768258380; x=1768863180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fkCk3ooqp4kftbFYAk6+ZpkTFJFn9MspF0xuqqcckj0=;
 b=NoexLbnbfWdduKLfHychqgWpJnjpX0MlyLJR1xvqHfLDGOpgQMon121gvPcoL6nURZ
 CM/DpAamnjt8OT1HMzi8u18jddJ8egi7/ZLdm5xsK/ONKfjQyUVO7wAvIOfpn3DvDNt1
 TEhhgV+OSI7uy1i6bHbhKsnPzGjZY6a53w2Ax4IYkKcTUCQRyE7/C/oxGrisj/qh6dCy
 GN7kXDGtf5gsCqx75cn5F070QWbWpyMRgsT5Vq+E5ZOnoShFSMChXblLFEH2+pDW2A1z
 NsBleZW/pHB+jouBkrgwSVaS3Yil4DMLKk8Kgm3MsbVCUeUFHbEP5i/D2KbNj6UPEf6H
 YhIA==
X-Gm-Message-State: AOJu0Yy9YKtebJt8QHXU1J6ulUyOsZM1IVr5e4BjWmHpPrbsaxk7I88x
 LRzMPLeQaU/ZpVVKqegAb3S/S98hF7KfSBKmJiyiWnYMFuqZBS4kzSdLpuMoagRAgyFjEkTtCgU
 zCISjhf0=
X-Gm-Gg: AY/fxX5QKH6djeI+nnvColKUAS2znMrTRNALvNHdbnS1m4j1kj5FPIED/kEK9JYAxUU
 AUtHNJce8IW6eg7uwcqqpIjIsFUNYmBmW3L24iPpyUzju5CM4aIY3zJr+NGbZnb4ghGUSH0lrUP
 n09hYeqKMUX88iTmhIWjCL0OVo7RAxRLEAl7RP8z+fghd0OE9tUTCr34GNZFQKig7/huQOzZRq/
 aC0l7nmPg74BjdBoEfsVh2uppQO1aJ9s4woXvZrNM6pwQ1Q2Kc9mVEYvvH4ctbLu2XdFcZw9EO2
 QcXpQdo3EJBd2iOAD/UDOX4LAxWvSWT9pB05uvdMUkPRSnfRtBc3Xc1RJYs0RpMQlgRd2hIV22v
 IaiCMFht5YOZB4RlmzCm5d9SBEpUsTY1X2KyIpoQb1WZIO03VBXVa4eQHSS/qLCMO0b91LyCl6q
 IvQQVdMU4bbOa1Qjhfnbt/O4R4L4H7Lv8goKn8VtZT6I+SMqclVQpAxjrmWW24eR/wvsDMxNo=
X-Google-Smtp-Source: AGHT+IE0e3I9JFapSQUlNYaDNIo+ZQJqRiMivZWXWz4TW2AtZoXu1x8bYkf9bL28uS/yCEagVkatOQ==
X-Received: by 2002:a05:600c:4ed1:b0:47d:18b0:bb9a with SMTP id
 5b1f17b1804b1-47d84b54031mr229692105e9.33.1768258380335; 
 Mon, 12 Jan 2026 14:53:00 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd0e16ffsm41905576f8f.12.2026.01.12.14.52.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 Jan 2026 14:52:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/61] target/microblaze: Build system files once
Date: Mon, 12 Jan 2026 23:48:30 +0100
Message-ID: <20260112224857.42068-36-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112224857.42068-1-philmd@linaro.org>
References: <20260112224857.42068-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Previous commit removed the last target-specific use in
system units, we can now build them once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260106235333.22752-5-philmd@linaro.org>
---
 target/microblaze/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index 3ed4fbb67a7..b30b8f70ace 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -17,4 +17,4 @@ microblaze_system_ss.add(files(
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-target_system_arch += {'microblaze': microblaze_system_ss}
+target_common_system_arch += {'microblaze': microblaze_system_ss}
-- 
2.52.0


