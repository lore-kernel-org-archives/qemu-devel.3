Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A947E9A05A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9fo-0005ga-ES; Thu, 19 Feb 2026 14:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9ep-0004Nh-8d
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:54 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9em-0000sR-DH
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:51 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48378136adcso8202875e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529146; x=1772133946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPHwJ14d8QfT4gnGois680xmQQMotLsL72Vb2Wzxqpw=;
 b=aL7GVTcsUDD6mmkV7Y5TcVNgMtZe5B8KG0RFbAtQ3keOMI/p8/Nhx/xbrRGP80ZxGc
 v+yjy8tDwoR7cyjUIWeN9ag06JrUAoHD2tZh0WplfOIfqP3KYW/iWg05KNaFWv0pJe5r
 5HWMXB/nZCP2arwBgu/MlcoDyY7MX1c/+Xl1MLknckM/usJaseCfJ0oI8OUvKvQc4qPj
 D9FvvWWt+ln/WYVTD4lvgNqhtLaYSpOzbDnxEV4At1095AWjufc0Rg8bR+3Ho1WdDMYN
 X6ENE49LZLdQpnjm+/xfyk5DjscUg4jtFk28tgefeEP6aNVYB0y1YslhAOAbegTMJ7zM
 MtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529146; x=1772133946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TPHwJ14d8QfT4gnGois680xmQQMotLsL72Vb2Wzxqpw=;
 b=DoZ58OmpjPHf8rV9HfwyfYThV1VsO1BaI/5GelrEONGGyQQ++FYrvN9BubsL22+cUJ
 JG6TWuQ3F1HFL6AZSuRrN0bhx5C3b50uoZ0z1SqgBHA9jMothc9yqlZsx6En5L83Itoa
 8gGkCVJugMVRWfe5+LpQ54k7Mi7i3hXh0+ynjkTibuxxO4euQLrJc1IuBtTnrIRG3emN
 qM7aXmjmGLAlPi+ofwg/g7viVHxKOvJXTTlSqjRHZDONJzgMfH+Kw4IOxUprG2YMiKRS
 eRUmzsOttdcQI9U14eiti6KP7a49JnztyyhmhO6sAMOKE11OJm9i8S/5GhMOHbNTtuji
 CJtQ==
X-Gm-Message-State: AOJu0Yz3vHMjk1jrIzuvJGzybHpNhgKiO8q1/t3lYLRlTfce5xeVpVxZ
 km2MRW6rUg0LWyDi69NrpOYuj3ZL+NSJDpw8kAcZ2h0sGue+rafqzv7j9V4sVrceSaPVvLCcpoI
 3xAdmKdYoaA==
X-Gm-Gg: AZuq6aLbyx0e7enC1YWCIAREBdgjCvX0AbtcAAUo7KL/j+U1FBu3iuwjbYgGseKcluR
 pH6dGxojAydUSFRUywA8IHfHtEvdJDw2779UCXn4kPkiHndYHorTrlajyRtHAhkMLghjrxbjoUT
 /moXHdun3QNxknoYdYGcuZHGJjAEUkRRYX2P52fFZ7XgvdeU5NzNFLTfQDrQW/FCogwbR6KUHLq
 XcXCgo+bibe1fTPjMLqYNvgj6VSuTui2gvm0jZmbhSCHBQ81WSsTT4UcZhP9VzixrFr56jNsz/c
 vpuqf0Rz4SwoYe4/6MYTehdUhPOUb3DHuzKBa/DDf2BjiuEFxjvxc1tOCvWtSOIogNa03+wx2EY
 n0huj/0JUfnGF6+HvIMbHA5UCVhkawfGm26zkvwZNmhQZQVM8kgFSsuZdvaNgAGrRxE3Hn3dGHA
 Y+OuqwnKT9djJ4+iE27IUKbozeL27mn7ufw7iotIv0e1bVLD5WiVVg6xYqp4GvSFXd9VWsfAjS
X-Received: by 2002:a05:600c:8189:b0:483:6f37:1b61 with SMTP id
 5b1f17b1804b1-48379bac876mr298929425e9.4.1771529146609; 
 Thu, 19 Feb 2026 11:25:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796abc21dsm53588324f8f.20.2026.02.19.11.25.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:25:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>
Subject: [PATCH v2 49/50] target/tricore: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:51 +0100
Message-ID: <20260219191955.83815-50-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

There is a single qemu-system-tricore binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/tricore/meson.build b/target/tricore/meson.build
index f40daee61ed..76cd78e990e 100644
--- a/target/tricore/meson.build
+++ b/target/tricore/meson.build
@@ -5,11 +5,15 @@ tricore_ss.add(files(
   'helper.c',
   'op_helper.c',
   'translate.c',
-  'gdbstub.c',
 ))
 tricore_ss.add(zlib)
 
-tricore_system_ss = ss.source_set()
+tricore_user_ss = ss.source_set()
+tricore_user_ss.add(files('gdbstub.c'))
+
+tricore_common_system_ss = ss.source_set()
+tricore_common_system_ss.add(files('gdbstub.c'))
 
 target_arch += {'tricore': tricore_ss}
-target_common_system_arch += {'tricore': tricore_system_ss}
+target_user_arch += {'tricore': tricore_user_ss}
+target_common_system_arch += {'tricore': tricore_common_system_ss}
-- 
2.52.0


