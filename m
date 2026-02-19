Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8CAE9A054
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 19:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9eQ-0002pD-Mv; Thu, 19 Feb 2026 14:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9e1-0001mD-GN
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vt9dz-0000QI-Gn
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 14:25:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48375f1defeso9559165e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 11:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771529097; x=1772133897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NHtEGuGBX8pbqY4qNZfToJq6bZazwGt6hUpwsy1gtCM=;
 b=ZC8yUMPmAWGw3u4W/hlIw1znYbqO10HupDc2bCyTVEIc2pqAwT0hUsgE6LYeTHbaRi
 R7FzbYaJ/l2wNJHCw7JH1if/5JUcRPWmZfwtr35b2ripKiV71mkNTObDCxakYOFOjEi+
 xfZBvRo9xUnEuTXRMU8daGewyfaD5RN0OV3ue9H+VOKlWFEDkoVJ+qDepA1pS6Nv9VoZ
 4KzM6yZUryPlH3Wqoj71ce5L4h+RW87ycdqV0P+7mVRoypOTkQ0Buvlwcmh4ijhEgfbx
 Ac9hIvMmettayrcZ8TS97QkGAGOejm4liegyAekGs0fU4z8MBfsyzrNnt6cvkbfUIHoK
 Xk2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771529097; x=1772133897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NHtEGuGBX8pbqY4qNZfToJq6bZazwGt6hUpwsy1gtCM=;
 b=PpTwUXFOZtNrY4GnaANzJeA15qk4usa48iy9ReDQlRS3/FO0M6ALo8Y/z+JYGT5MX1
 ckutYKzXkOJIctrGZMz5+M06IW6PTPi/7mnsLTRR8xaoC568Lth2TxXEw6uF2kQBdFKs
 y2b64sED7/0IHmBimhgVnqajSfyUA5UsdBzPV4wduBcpQMdEA4N3gFO/KqKXI87A4qdK
 Qz00pxDVRRJtIFJC6pqB6MdCxWgXxS1ZQTR9nbya1ysn0CDximZj+E3dHBFOZ7QQCyGi
 Ru3mj5tDwk95g2B4fpgprCV/f/ZcDIVVuDtviNzoldsqsTUhDThTVG5PzRHwZVp5Fh1c
 nK/A==
X-Gm-Message-State: AOJu0YysKzBctINgtUScZ1ZSI7Bupx7GA7KpzHboM9UomrW+Uo2o6DOy
 0Y83BlbWZQQOnkwmEpdy5ACTchwqgcVrVn1U0cYFdgCtIraXW5g2tJOaLOtULgdM6JltKI+gVNA
 7uWtYZWfCDg==
X-Gm-Gg: AZuq6aLoNqBr2+2gDZB/8yej+1vmJLIIAYDGb7vQi2yYSiq/7Hf8SJJB39XC65gQnjP
 wB+UPQ037wcSjwm2nbz2HEQ7EYYyfj1zx1kOxIF/s2mJb3zFhcaVZlcD+fgpuemDipiudzJf73Q
 qRFjj2Vb8KxCXoqse6/BAXtWFbyFp/ufdefNE5BZ9d7iVI/uwEqk9dJtdYMfJVk5Or/vLHWIqqj
 wfB8ww6PSlM/DzstPr+leSyley6673EimODhkiuEDdJGDZZjcJyhWBC3Hrr9PcgLH/L7LhJtOSx
 /wqe8U/WBVjVDo3tV9my5DMy0KR5qLThUesvTPPBtUwdIyQYXYmJhmBwmJBPoIidB0bHYvdowNg
 JfenxLkhgKuqVzlByzIDbDktKmNmlaz1eUDQ3VktkMEFi7HfeoBVGZu4lggfPgIaCPPcys1kIgZ
 RD6L8bjGi3F5hgIin+4j3d1peN9HOR2s4ksnixh+5gb00ngWe/QFcMju8eiRJDZ0B+U8UTPXR5
X-Received: by 2002:a05:6000:40cd:b0:437:6c2b:2f52 with SMTP id
 ffacd0b85a97d-43958e0063fmr11530416f8f.14.1771529097043; 
 Thu, 19 Feb 2026 11:24:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ad009bsm49547385f8f.39.2026.02.19.11.24.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Feb 2026 11:24:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 42/50] target/or1k: Build 'gdbstub.c' once for system
 single binary
Date: Thu, 19 Feb 2026 20:19:44 +0100
Message-ID: <20260219191955.83815-43-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260219191955.83815-1-philmd@linaro.org>
References: <20260219191955.83815-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

There is a single qemu-system-or1k binary, but by moving
'gdbstub.c' in the target_common_system_arch[] source set
the resulting object can be linked into a single qemu-sytem
binary.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/or1k/meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/or1k/meson.build b/target/or1k/meson.build
index cc912ee6cf9..7cea45287a2 100644
--- a/target/or1k/meson.build
+++ b/target/or1k/meson.build
@@ -8,18 +8,25 @@ or1k_ss.add(files(
   'exception.c',
   'exception_helper.c',
   'fpu_helper.c',
-  'gdbstub.c',
   'interrupt_helper.c',
   'sys_helper.c',
   'translate.c',
 ))
 
+or1k_user_ss = ss.source_set()
+or1k_user_ss.add(files('gdbstub.c'))
+
 or1k_common_system_ss = ss.source_set()
-or1k_common_system_ss.add(files(
+or1k_common_system_ss.add(files('gdbstub.c'))
+
+or1k_system_ss = ss.source_set()
+or1k_system_ss.add(files(
   'interrupt.c',
   'machine.c',
   'mmu.c',
 ))
 
 target_arch += {'or1k': or1k_ss}
+target_user_arch += {'or1k': or1k_user_ss}
+target_system_arch += {'or1k': or1k_system_ss}
 target_common_system_arch += {'or1k': or1k_common_system_ss}
-- 
2.52.0


