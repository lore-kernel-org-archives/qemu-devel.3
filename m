Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C80CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:02:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcoC-0005X6-5t; Wed, 06 May 2026 10:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnz-0005Iq-Is
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wKcnx-0000bD-Tl
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:00:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488b0046078so57235365e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076047; x=1778680847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T/xOKwF2KGrNc/2lU7g/yWrNS/80ccjkH0et3qNQ7FI=;
 b=ZGx6r33dqiViKv+6qz1EYPVYuhFlh/Nu26iZnziOjdiM725kvIFh7hkf5Ec6jk9rke
 QMGHatCtsOCJ9jTDqd5akdY/n8HBWAukHJVZkAVhUk5Sis21Kwl1e5RMqv7DIl+vOcMe
 sxufMSdiKp6Ywh/phJrF52wkzTmRjbvvr8UxW6PYMaM59Yq1CjrkyVZSp3eI3l1qCqSz
 pBGKhpuCuItUlvhC3aIelVfvgLYI3JruJLla+dWeJipN0aBzmyHz0EW5qEA+zyr9NNb9
 uJVbOiqcq7rY+SSuh5bgvBUzpHZq+EohvFqzIRQbBqGCuvE/DW9X6TN8R6RWjGGoX3IO
 Gxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076047; x=1778680847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=T/xOKwF2KGrNc/2lU7g/yWrNS/80ccjkH0et3qNQ7FI=;
 b=mhT8KvmVzIu4J2M2GqWuo5+ONjeBiMdqHLxDbmBOqV8grpkwEkN3aHxU5oUV8emC1d
 fAN2xXtqpksM5YNnkp0oN7VFNP44GxoDbzCDrxRfzk6B/wFdgN/HUh7yZJyuRQBPy1EH
 Ht7PY0H9V70rGaLm3RGRmg0latJL3hNmdQh1sstDEBxmYzPwytX7iOWbTcOpytmW3DvJ
 M8IaiTMm1iWUBecelWCjNfF9cWayfO/EFE+W6Aw/QXo3HZzSdY9TjdXsM6Q29nLgv8tq
 maYAlwjdviW7Cngant0TzejKFWy+Iki9LNOR0YRmw0B0lQ5KJhqWQvP96n++1lJULb2i
 Qdyw==
X-Gm-Message-State: AOJu0Yz6d1KQyVmGeil4bpQWoup86Nsy9Ab2qzjMsKuYL5geDnSSmpGt
 IXUfQDoZ3lrFWdTomw1pP79ENx6Rvh7Jg8AzSZ2Q8DGFOaR6EIeunIJFEPbErSH46EDOGPJDGwK
 FgrL2qcA=
X-Gm-Gg: AeBDiesqcUQ9cmnGWb7a78lZ4bG+vkEIEw86J0hL/ip2DNhcRa5RNETCJGXOeoPT7Cd
 YcHwFXhEoxwEzlJ/ScXCoWeFVoELxCKcAUm4t2CjJZH1LVLj6dab/yyEUssGPgoSNTR3nM+sltq
 9Hn2e8swuTpWSjt/ftNK4tZEq3bSKjbNol9fWHeW5DSGJeNGDf6r5KhuoEeaQp2JnMFibE8Q0q/
 cUkXEXwqTOBdX2xgMuLo0F4n4l7AjijnCRn6u0vQOQehmsNcfvFoDDjxoUFooUDLldL2dp40RK+
 VzmcpR0LTU+JLgnTfHrEq+q/4Z26rNoEsfwIY9CjiFg20P3MSXVlBTwjvCZe+/43DDLYjno4k8Y
 dQH7qZ1o/19t3X+jq0dtnJs/YNKjMNbT5srVvde5qiaJ2UyY1XpgohwWG7qVw4PkvZy+MQpEXmI
 o85Ddvok5GblaqEh2+iP8vTqPQOdwXRvp6uFUE6p9MWUMWBCM9HddDyYCWAMpQ5NFjD6Q4j1buu
 Q0A5Z8MZi0=
X-Received: by 2002:a05:600c:4512:b0:488:c744:49b with SMTP id
 5b1f17b1804b1-48e51f539b0mr59558085e9.7.1778076047024; 
 Wed, 06 May 2026 07:00:47 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5389da63sm49400835e9.4.2026.05.06.07.00.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 06 May 2026 07:00:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 042/110] monitor/meson: Use SPICE with migration HMP commands
Date: Wed,  6 May 2026 15:54:14 +0200
Message-ID: <20260506135524.20617-43-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506135524.20617-1-philmd@linaro.org>
References: <20260506135524.20617-1-philmd@linaro.org>
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

When moving code around in commit 27be86351ec ("migration: Move
the QMP command from monitor/ to migration/") we forgot to update
the meson rule about SPICE pkg-config flags.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20260427080738.77138-7-philmd@linaro.org>
---
 migration/meson.build | 2 +-
 monitor/meson.build   | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index c9f0f5f9f21..e583822dec6 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -23,7 +23,6 @@ system_ss.add(files(
   'fd.c',
   'file.c',
   'global_state.c',
-  'migration-hmp-cmds.c',
   'migration.c',
   'multifd.c',
   'multifd-device-state.c',
@@ -37,6 +36,7 @@ system_ss.add(files(
   'socket.c',
   'tls.c',
 ), gnutls, zlib)
+system_ss.add([spice_headers, files('migration-hmp-cmds.c'), spice])
 
 if get_option('replication').allowed()
   system_ss.add(files('colo-failover.c', 'colo.c', 'multifd-colo.c'))
diff --git a/monitor/meson.build b/monitor/meson.build
index 2647100e04c..585251804e4 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -5,8 +5,8 @@ system_ss.add(files(
   'hmp-cmds.c',
   'hmp.c',
   'qemu-config-qmp.c',
+  'qmp-cmds.c',
 ))
-system_ss.add([spice_headers, files('qmp-cmds.c')])
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: [files('hmp-target.c'), spice])
+                if_true: [files('hmp-target.c')])
-- 
2.53.0


