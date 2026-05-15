Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7192ECD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtGV-0005xy-4L; Fri, 15 May 2026 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGT-0005tB-UO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGR-00048K-OX
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:11:45 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-452169ae568so7133257f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854302; x=1779459102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mPHHkuT68LQ8THDPOQM1jypUgrX1zdRt0XHWxhQhz5I=;
 b=T61bIlh26ZAWb4Ox/oMXW/yaFzl256ZJNd27NvY3iB1XcqNAE/yWXAvmB1l1UQD4k3
 hQV/YTz1a5kQ7KOEccCfPuEjgFhHESDZDMBPRznAkxqvNq7IQTnOJgbJqxr86B2rHszR
 1HjDjkg/ps+QsULzqFXACZUa77WT++VUUHGfDbrHV13Gn84rICl332KQDPAaT87fg2gb
 Gahpl6BTKNOGyx75dZaGfQuEk4EK2icmYQSSxE5Tkmy3D1F6GuW/if3z8LPrPgYnFrQ8
 LZE7yT9ubgBqEp/1p4seAltk/NpfTNxzLmLwx/2orNrnFCqhMr++6BMh7X8ceJYahtsr
 k/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854302; x=1779459102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mPHHkuT68LQ8THDPOQM1jypUgrX1zdRt0XHWxhQhz5I=;
 b=p60TKtYpCeCt5+YMLPLtweMmXUF4Wf8ZBuIe+9uiR9USCuDolckN2VM6g2qMozJzxA
 Y5CSiwPVKeyZfPQMPRi294LzSBamXmyBAibJrXl2HSAh7d6s1n51HbKYWAkuLWZbyz0j
 dJHl2XSXEfkPKjorAQMa4C4VSEQVSn851r6SSfyO7IuDfuqXs0ZI0i4uqzSFWsli0Ss3
 494KtTewVCGKFSgxX/RXK9q66UpQLrUGZXQFqtJlkYGd3O94Dx9xZ41/O+f1BFoR4fKp
 PkSgRqP6IFnieUZJraWnMXSL/5byWj0vjgZNEr3jb0yVSshG5lGY7MZQjVXpawvBzs3y
 fczg==
X-Gm-Message-State: AOJu0Yy9HR5tZQMq0+FGac5KEI8NDu/8ZUer4vui5ESJYOKkvBZ+VJ9m
 lFI7cg+oxAo00tSFM/uOwyz4Prp0F+4uWdXicJ4CSZyfZsWqdN+BzojxfmKPIGKeGXoYQCTFWJL
 POTHaAJU=
X-Gm-Gg: Acq92OErqxc+MOgZSwmaNhVAkCNXJVTrUoR+hclROZj1tu1rAZa9r8L4yM3rIlBWse4
 yPbqQy7aElqTj2jgsUaGSrCWNmK/PzAFBfPNL5Lb5d+233R/JS4sdxXvScGUsecjCOhL8s3yRnK
 dq/5nwTlbmClq0fB61K6Ct1i40PdjICYSGaRfRja+NrNuZf752uqT9Cl/HQXuWSeEcVkztz2ufm
 yHXznFccKY+C1/JU6O4KYACy80lCLu9igfAM1op0on9eX2rznvd+rq5j4Y823M/Ed3Q6bqJsMqM
 SHk5j5O0T1dQczHAoZN7xl18yLFPOyz+UbreHgSlfSFeY/Q98IERbRBeiaZzcyB6uWCqT2FHUhf
 pmGi7603Mwrh/Glgfad0C8PuwQ2xiekQIcb1NQ//ilAd6aESh/MkTKDH1MLbs8a8IPuqzfLtouR
 4LrqCxG5xkFfozsSNbJsv/l/48L+/Y0j90cofk28ck3tI/5uZQ3wZqNtl4Tm/5BbCfaviYdZEyG
 OB4TMc0u5k=
X-Received: by 2002:a5d:5d01:0:b0:452:a293:4d91 with SMTP id
 ffacd0b85a97d-45e5c34b279mr6122960f8f.0.1778854301916; 
 Fri, 15 May 2026 07:11:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13484679f8f.36.2026.05.15.07.11.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:11:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 09/20] target/arm: Build cpu64.o as common object
Date: Fri, 15 May 2026 16:10:20 +0200
Message-ID: <20260515141032.3271-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

While gdbstub64.o is already built once, build it as
common object, reducing target-specific set in arm_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/tcg/meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 9eeccb2adca..f821331fbee 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -27,15 +27,13 @@ translate32_d = [
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
 ]
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
 ))
 
-arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
-  'cpu64.c',
+arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64 + files(
   'gengvec64.c',
   'translate-a64.c',
   'translate-sve.c',
@@ -79,6 +77,9 @@ arm_common_user_system_ss.add(
   'vec_helper.c',
   'vfp_helper.c',
 ))
+arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
+  'cpu64.c',
+))
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-- 
2.53.0


