Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AEA2E7FDD8
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 21:22:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn1Lp-0004Uf-5I; Mon, 02 Feb 2026 16:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Ln-0004Tv-D1
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:51 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn1Ll-0007Kf-L0
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 16:20:51 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-432d2c96215so4718856f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770067247; x=1770672047; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fnVEsqFli6BIdwPxt+cMr6vVYl3Hlh2AGSUbGnAGHvY=;
 b=uhpQgVcsvfYCzp83MaEGRjnkes5u7KctqVa7+vpGFpiohk+ieZH0Q0yRLZyh0hElRC
 4j1+tNdOW+eyL1cKdI6eQDXKLJDRABUCd6ZJRvLp8EjRFFiUKWtcGraJiPOs2PQQccWC
 qYRCR4mtJuWF6FVfYYL+NVroRaBgwdJpQNigSaJfEH0Lqx74wOncXpPYXELljL7iu4mu
 2AwwPTRJtxAUpuRZvbRqe9lq8U421Pvw5OoCbFhKxp8YYAfVuSW30XrRjLgWccYAqtWm
 eMiGOcn4kvi0BR2QRv0D9ih9NpFusHAJbOkX8oVrv4BcWy4YlAmseDlZiLAT0hbADG1t
 3R5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770067247; x=1770672047;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fnVEsqFli6BIdwPxt+cMr6vVYl3Hlh2AGSUbGnAGHvY=;
 b=XOGVcSobfgVhEohfNIU4cKgoxH5Jc75CLelpVNU5Z5mf0JlGZATxyHE2kPHuXvtbG5
 N01Z0CPtWro4ojute0NKfNixOxp1jFZJIttswwKp6JVc/gcvpKBZOTFV+8D0H3zSCFt1
 T1RXyoPMwsIWG+Bo5s6rGAaWhGA1q62/E+qRYosdBfU0zLx2hAJ5MML7uZBH+T8fxH3r
 rZBXCtuRgnNaSZjG2cTzAotiOCzZfw6+aqG7fDLmfx6up2i+4bBOOQjHCpe15zeQgk8F
 uNb6Fe5AKpiZEhwqW4SrICmkaDCBQmx/2NgcbvStE68JnQQD2sP94DLF9yP0VUo2qQc8
 6Mng==
X-Gm-Message-State: AOJu0YyqGNauFZSZ/Sklk31I7e8+M9vAHm06Sb4PL9h2cBkQ3/g16PvC
 e6ap/P7QU5ek4n+1MCZ+2NNqOdIb9L0y8vG1LMhUQt5aeZUSN7Ob9ZC9NXoUAyB1vLm3HMsawlg
 Dk407Zpg=
X-Gm-Gg: AZuq6aKLomWYqMc1mTdx+VLqcbM9cJlHv7eSkpoBUC5OcuBtzeoMjF7UeX2P1+Rttni
 VqjnR/XfLqfjkMrKvUTiAXnerWu42mxSG4FwsnJCSj3fcWxh5xwsxteBkK2GGCT7beTt36tL7RD
 tO1XOf1OtnDDiZz7x9jgMK2cYdoiPF7Xc4qXATIe5TLZ3EHtc3O/WKT+6HyyIX+3bp2VvKw3MC9
 YdpMhlFU9DspL2gDwlLD4qBsZKMHvW66/2eX0QtJbqOMzIYNXwjwb9TiDNMNY9cmWyR1KTK8uB6
 EFMz3PJoDujuAb//S1WsWj3Nf6WSfu/uKe3CQT7h+XghQ4O0zOvuZ2PPR+1Q3Nau5tWj21qpFBV
 dVFaRKOH6qBNsS3a63VGMXPDHWOQzmmvJzqT20wFEiwj1clhiXf2nqs1x+62Ew8+244DujiiPpp
 kPXFBsJc8JfQ6427twIrPq6BEP4D/Rfh3O5K1qHxNDRKH0zuOUtLA/VjuHGqKF9nwkJzfs1o8=
X-Received: by 2002:a05:6000:2689:b0:430:fa9a:74d with SMTP id
 ffacd0b85a97d-435f3a7bb17mr20639014f8f.24.1770067247445; 
 Mon, 02 Feb 2026 13:20:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1353ac2sm49339919f8f.38.2026.02.02.13.20.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 13:20:46 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] configs/targets: Forbid Alpha to use legacy native
 endianness APIs
Date: Mon,  2 Feb 2026 22:20:07 +0100
Message-ID: <20260202212019.94205-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202212019.94205-1-philmd@linaro.org>
References: <20260202212019.94205-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

All Alpha-related binaries are buildable without a single use
of the legacy "native endian" API. Unset the transitional
TARGET_USE_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251224160040.88612-6-philmd@linaro.org>
---
 configs/targets/alpha-linux-user.mak | 1 +
 configs/targets/alpha-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/alpha-linux-user.mak b/configs/targets/alpha-linux-user.mak
index aa25766236e..ee505e16ef4 100644
--- a/configs/targets/alpha-linux-user.mak
+++ b/configs/targets/alpha-linux-user.mak
@@ -3,3 +3,4 @@ TARGET_SYSTBL_ABI=common
 TARGET_SYSTBL=syscall.tbl
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/alpha-softmmu.mak b/configs/targets/alpha-softmmu.mak
index e31f059a52d..22fbbf0cb08 100644
--- a/configs/targets/alpha-softmmu.mak
+++ b/configs/targets/alpha-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=alpha
 TARGET_LONG_BITS=64
 TARGET_XML_FILES= gdb-xml/alpha-core.xml
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


