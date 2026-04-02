Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4C9D6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LUX-00012y-NM; Thu, 02 Apr 2026 13:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTx-0000Xu-M9
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:34 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTq-0000vg-RT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso10899095e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149514; x=1775754314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
 b=zrbY38HJ4ifyD7ILAMD92ecXLoIL1lkZqoxV5kf5pDBT36zKjIlTZMCaB/38MHFTpx
 f5UrLt0wykIrQwTnE301owDX1Xz6QLkxQm4779qq+xaOsegpLkr2Wls68iujXoWbcMnp
 gg5BxW5OcLhAPdjza4HqQikc4DIoyR0C7P6yHj3s8qhdMrS1IPYtOlgXIK5GlyZ0Dzmm
 zLQxX7vdBTAsYjwpZ8MzRJH0SrdqCBR/Ovw8DVPRP/I2u6pXVJKsqWzz49Ug0wNvQoGB
 D0PdnUWHjPL9Kq+25jVh7tA4jarh4YbZrNrvQvnhD7Cm3r9in1/yndiQRE62zKnJsUpr
 1fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149514; x=1775754314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5zFCy2/f6gXgpLVosgl6P0mdggO0d7nONWw8yr+5Eo4=;
 b=mp777KFfqcZdSvPLIEAKsBbYmBmH+eHhIa/yJ3NkDoVRSDVD/x6Xt6RL0xc+ellBmm
 /6tkPpaNEV7317qmeMAlGeaNkKUyrfwzkGRIm/kzgIrC1cPiHK5L2+gFAe8fHKR+nVF2
 IQVH1Q06NH1OvV8l54tiL26HzzTUUngtQlxcv+DlPVHxgNveb7jBlwrZ5HVs+V/KtFrx
 6+o0f3r7J/9nKJhEcKd2P1tDiaVQ/wtmpdwYLu46vWob6BE929i8hYQ/BmyAUd59kYXU
 ysl588uqNTvvTuwz7mZx8O1f2nScJ4aV8N8lxAT8qmzXxjOKc4Cd/M4QoTy2jeJnHQV4
 7kww==
X-Gm-Message-State: AOJu0YwNKf7THrvcbRVS19RC/JKvv75JXB04zKYBtujgnMQrHJJYE25f
 4pRXPzSJwDJlWqF0SC13uwpTU9c9q5pv/MSo9HFsS+rGqjV4NPbYP2gHall52cUVY2zl900B22w
 nV6TrLYo=
X-Gm-Gg: ATEYQzzTKCtboXrd4Koh9HLO/DSMddtqUEf5MZePa6jKLmRGVugrnQI/72zbZQjcMOh
 Po6Ks9xu/oKrsnJ8L3uKgkaAkW2nkAEY99GqivpdcNlm6RYlTrWoPZzKBPeF/nSAn3xoKjkz7ya
 EVYbybawbcNT0IQmh77P8+y6wcAnalcgb5kcXRoqh67yLn5c7injx3UcCjtVETLcIu9BFAVX+R8
 b0BWh0iiXlIO2THyJeLa8BvXYUqKI80mIJNHW00g1bMxWgqCU0Ceud57AMiTHYj6eAyQSf8fOc4
 Wkugyr1HR5dugWQUfvX4deBCWcSEW0iKxbJj2MY39Ji86jnONPZdaoq49+dDNCQwzVJY1r/AfNJ
 tc0pwRbmVdj7L5cYvRJZETcTaykYvsTo6x/WKvpVvdKHaLcXlwfx+tQM/TRxcfHau8IgyzcNhVB
 et3oLpcMq8vT7N+9wcfz5naKeZBUxc3jzPzseQCI3lvSfFi7fFtTELhMX0P0X4NqPKVmcjodxQ
X-Received: by 2002:a05:600c:a4c:b0:487:1c2:6a56 with SMTP id
 5b1f17b1804b1-4888356844bmr156661445e9.3.1775149514437; 
 Thu, 02 Apr 2026 10:05:14 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48897fd5680sm666205e9.1.2026.04.02.10.05.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:05:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH-for-11.1 v2 5/9] target/arm: Compile WHPX as common object
Date: Thu,  2 Apr 2026 19:04:30 +0200
Message-ID: <20260402170434.94783-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

whpx-all.c doesn't use target-specific code, move it from
arm_system_ss[] to arm_common_system_ss[] to compile it once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/whpx/meson.build | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/whpx/meson.build b/target/arm/whpx/meson.build
index 3df632c9d30..db31e928012 100644
--- a/target/arm/whpx/meson.build
+++ b/target/arm/whpx/meson.build
@@ -1,5 +1,5 @@
-arm_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
+arm_common_system_ss.add(when: 'CONFIG_WHPX', if_true: files(
   'whpx-all.c',
+), if_false: files(
+  'whpx-stub.c'
 ))
-
-arm_common_system_ss.add(when: 'CONFIG_WHPX', if_false: files('whpx-stub.c'))
-- 
2.53.0


