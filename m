Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81B81FD45FA
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 23:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvOAJ-0007K8-3l; Wed, 25 Feb 2026 18:19:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAH-0007Fr-2E
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:33 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvOAF-0003SW-H5
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 18:19:32 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-483770e0b25so2521525e9.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 15:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772061569; x=1772666369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LYYfPvBKJeHUWebt5+j9ST6av3ymDgSZUVvb01/rGEE=;
 b=iXAIEQ+EBQm+b4vzvQClAtF9RJHEhQV2mgtxMVWK/yPBCJGzbHXB8xQbC0eS8dXV2o
 Qdf5SsVHoeMhnwHRz//BRceJZloddReYvbL6ZLYhDhxFIUBSd9jEigtPtwc62vm19T3f
 J1tN5JkwkEIduKe4UnpzRq1tVi321wVkVcQ2rULINpE+agaAO3Xoph2ZB3U1MlJ9wqHu
 pqYd4XGRLWf1NoBzY7hbl2FCJSxM3y2kl2CgE2oybEG7wrzOFDGhJAatiW5GViKWtdjP
 b1KWUtn95DrxlG9R6ZixLtU+uNFt7dF5YWgq6me1BwDEdp0M8Qa/ay9ByaiBNmK+fgQb
 vHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772061569; x=1772666369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LYYfPvBKJeHUWebt5+j9ST6av3ymDgSZUVvb01/rGEE=;
 b=dz5j5GUOUmOSuUJi8LaB2KTAEJ35AJUChJm0tjs+6BTHIEVkurrE3deJz6aS0uvUKC
 s9HEI78xee0JxSRCTQ79LoD2+I2QS9CNmHdAP6Fu3Nztr8aqErrEP/Egb5r+IKBGI3wW
 ZBBVXGrW+ZFOFrhkC0Omi6rg8jMgAck3Gh/fReNr8yevdqzlP2RVMolq5WhEldCGGqRa
 zpghS9CnvVHC+7Mdphn7O858+Hy6GYNArA4NAT31wei/6pQL3YZTyBEF/Dbm+WbRIWiU
 0JUcsmXEuS0HAOnSo+pMyg/2WcP7ZRXj3W4bXs7gX8ary4ZJqRZo6jPqR8bvxKETi4nq
 0ocA==
X-Gm-Message-State: AOJu0YwYydVBwiRcveizExqHJ4ie4VIOYOLRmO2RwQI2ncgyANB5/zju
 jX6SZ8Vaj8mqwb7RnKn9Ng8Cpeem5SoBJ6fRIEa2fhqSPHorKWJr6V+qWbpLlySwSaRxQ2Kmy79
 yJf0Eir0=
X-Gm-Gg: ATEYQzzm1NHztN01b8rflXpDBD3ZvfTiaoP8rZJ4hJ2qdpCnwyxTCp/GRBxHWSNgueG
 MC0ZAmnS6FKN2Tmep7rkG5+LcCyKJkrDmWxgKYtum1a0MAC2KqVTxakOBXjrrPkkfDXcLwse1+f
 z0vea6t/GYvxKf7+KRZxClWSkGj2R/yLyNzHWIs/NlvF53MgxpEgV1DuGEib2g1d1DAbPxV/z47
 fzj41KbbFFbAxMpuj+RpJZz+4K2Q0rl92Q6lxaIovc2+PrVJ2LYJDT0PVdWX2X//XeCcWB29Zea
 B/RS5AA4DwDxJVpho88djp1JneYUVH+c62HN13oAxcwLPrmk+MGzFxkWsBO2X+Cu97eG6bX6CB4
 qbtqdWolWjkbGGKJGgv/dYKNcAK4yBQ6FOfHEUXc00TBL9UpHE7Xe+eBJvqA1bO5pVw1TAsre1/
 IZESoU4LcXmkeBgmSx+aB1cFOXJZWxZwvY8HZ4ZgGHeuLl37QifaBEKFgLg6cAHaidj+5pvMUw
X-Received: by 2002:a05:600c:4057:b0:483:c12b:fe46 with SMTP id
 5b1f17b1804b1-483c12bff6cmr36169825e9.10.1772061569374; 
 Wed, 25 Feb 2026 15:19:29 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfccff00sm22773025e9.25.2026.02.25.15.19.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Feb 2026 15:19:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/70] target/microblaze: Build 'gdbstub.c' once for system
 binaries
Date: Thu, 26 Feb 2026 00:13:46 +0100
Message-ID: <20260225231411.96482-47-philmd@linaro.org>
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

'gdbstub.c' can now be built once for all qemu-system-microblaze*
binaries.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260219191955.83815-39-philmd@linaro.org>
---
 target/microblaze/meson.build | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/target/microblaze/meson.build b/target/microblaze/meson.build
index b30b8f70ace..b86b37d9238 100644
--- a/target/microblaze/meson.build
+++ b/target/microblaze/meson.build
@@ -4,12 +4,17 @@ microblaze_ss = ss.source_set()
 microblaze_ss.add(gen)
 microblaze_ss.add(files(
   'cpu.c',
-  'gdbstub.c',
   'helper.c',
   'op_helper.c',
   'translate.c',
 ))
 
+microblaze_user_ss = ss.source_set()
+microblaze_user_ss.add(files('gdbstub.c'))
+
+microblaze_common_system_ss = ss.source_set()
+microblaze_common_system_ss.add(files('gdbstub.c'))
+
 microblaze_system_ss = ss.source_set()
 microblaze_system_ss.add(files(
   'mmu.c',
@@ -17,4 +22,6 @@ microblaze_system_ss.add(files(
 ))
 
 target_arch += {'microblaze': microblaze_ss}
-target_common_system_arch += {'microblaze': microblaze_system_ss}
+target_user_arch += {'microblaze': microblaze_user_ss}
+target_system_arch += {'microblaze': microblaze_system_ss}
+target_common_system_arch += {'microblaze': microblaze_common_system_ss}
-- 
2.52.0


