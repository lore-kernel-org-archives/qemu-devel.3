Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC548FD45F1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:22:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOBE-0007g4-GF; Wed, 25 Feb 2026 18:20:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOB8-0007f2-PX
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOB6-0004AC-63
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:20:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483a233819aso2865685e9.3
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061622; x=1772666422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qaAvp9O61RMQK1Z/bnAQSwlz2Q5ZRUD5Jl/BPlPtMsg=;
 b=Ib2s+XRxWNGOwURoydZxe5Kqgmj6OVn9EmaelnHzo8BZeb30L0Pzgz2PEalYIfE0hH
 kU/STMlzC1L7MfJnINBSIv9TXXfHksTokZ6QIq/Rkn29W3vEyXFj/Yb9pIPOE3rjgZe6
 cisAL00PSsGt8HZ8nxdPKK3niWPvUasJFz3ocTPVe3c+ba0v3UiSx3qXZN9SiE9zRJTi
 sQ1CkZQz54/1nPs5Or/vmt0YWb2HA7hYq6DvKf9Re8BD8dul7GHO0dX0/wXRrjBPNR4C
 vU1aoGKy1P3av9yr9KoSmkuhtkU6ydwnk3EMZay5mujYyUID61aSTMerr/YY9oeaWVYp
 OpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061622; x=1772666422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qaAvp9O61RMQK1Z/bnAQSwlz2Q5ZRUD5Jl/BPlPtMsg=;
 b=kgAav1Mmac1NxJHfUBxBueH/IVl4mJ+yZLNUNQWqLYpVPZywOSDMXWaXwmpHE1bmyc
 946UsnbRSfIw2pizcdhLu31L2lShWpS7dqILz38vTo3LpwwMS65G26uAVgCuW5ZvTH1L
 iGCfPryfDWycPpITm7NGhwgojxAHMxP4/CU0HGFnYQecdX/wZesvRBGTPYM8wlzgh8vh
 ZLHyDwSgZw9es/yMisivxgLV3awQxlfwywUGB2CkLKqjtRgLwkUfOZIjU3om6WxbIUHi
 c9mvy5nym6AlErUDeLThaYrSBgt/fR/Xrhuif4a6iK6myYAbKcrmwrMjbvTFPl2sJf8e
 krfQ==
X-Gm-Message-State: AOJu0Yw7VNOljefK0/Ezo1iBrl9bnaVrHmaKXAipCopOMxmVbN/pXBUG
 8k4lieePgHEDQGu0BdotWyWL9LkX2inJBIKIJnkdYcUCMRJIK9EhoqZBYbbdA+Pe+SWlqwptprk
 pM6spPVc=
X-Gm-Gg: ATEYQzxHbJNf4fJQY9diZnsI0jfcxYDKlyvFRCjHiEzphY0pDVHlEZuzjcJ0KNVjj6k
 JKdOcPYboysHqjoIIV992hBfdRKOBHHfIxQsRrIHj1a5lOpQ3O7Qm1M3L8tvMNwlEDiMC2gVXDZ
 wYGZhyW6tWyTVptMybbG8wik1tkeg/TVw515AljaDvwQqK6s/oosxEPwoaVzGaAxOj4E7k7lEnt
 frGKBJZSTjMTihX6+vcfmaVBnzS968uixAmNmcz6Jtuc2bFn1+YiU+bfUyHSyIDiXvlekQbteNV
 p0I56+a3MBADA6yZLzH6yer/TN8B78omlQN4sJDWljW8TLn6szheFahZ7COyKEN0GBrLPzLzkhY
 irMv8wThZv1ChKDLeuRZcH3dFgUgLS1bnv15LrWl8IcOcgb1cuszj+5ZYxnPKpCSBW71umgxWYm
 RAPQs1nyeUWujOYu+06pmMVDVN70SBGfAaxIhgUnh8b3ziYJ2nuB7H9mQGCmiQKjl0kKt4U/DP1
 82a/2M4pTg=
X-Received: by 2002:a05:600c:1396:b0:483:a8e9:201b with SMTP id
 5b1f17b1804b1-483c3c5a655mr2338695e9.0.1772061621625; 
 Wed, 25 Feb 2026 15:20:21 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf5fbsm20478205e9.18.2026.02.25.15.20.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:20:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 54/70] target/m68k: Build 'gdbstub.c' once for system single
 binary
Date: Thu, 26 Feb 2026 00:13:54 +0100
Message-ID: <20260225231411.96482-55-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225231411.96482-1-philmd@linaro.org>
References: <20260225231411.96482-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

There is a single qemu-system-m68k binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-47-philmd@linaro.org>
---
 target/m68k/meson.build | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/target/m68k/meson.build b/target/m68k/meson.build
index 4d213daaf67..c36d817134b 100644
--- a/target/m68k/meson.build
+++ b/target/m68k/meson.build
@@ -2,13 +2,18 @@ m68k_ss = ss.source_set()
 m68k_ss.add(files(
   'cpu.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'softfloat.c',
   'translate.c',
 ))
 
+m68k_user_ss = ss.source_set()
+m68k_user_ss.add(files('gdbstub.c'))
+
+m68k_common_system_ss = ss.source_set()
+m68k_common_system_ss.add(files('gdbstub.c'))
+
 m68k_system_ss = ss.source_set()
 m68k_system_ss.add(files(
   'monitor.c'
@@ -19,4 +24,6 @@ m68k_system_ss.add(when: ['CONFIG_SEMIHOSTING'],
 )
 
 target_arch += {'m68k': m68k_ss}
+target_user_arch += {'m68k': m68k_user_ss}
 target_system_arch += {'m68k': m68k_system_ss}
+target_common_system_arch += {'m68k': m68k_common_system_ss}
-- 
2.52.0


