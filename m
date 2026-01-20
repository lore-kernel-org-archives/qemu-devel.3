Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1F1D2628A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 18:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viGeJ-0000Bu-Lw; Tue, 20 Jan 2026 13:40:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdd-00087A-Vq
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:38 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viGdc-00060b-Gb
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 13:39:37 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so976345e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768934374; x=1769539174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bggCs3F8lakcGV/xgvsKOfncSaOjQlaK7c4RhIG7iho=;
 b=CYomyB/SAaD25aQtjZ2m3QIvch0dRmj5uvo9+0wemloHn2/qOhJRySz8hDQjyXAzR5
 TOAqIB3w/NqIGi3+3OKhTSYvmV/Cj1WbdzjPPKbAWdPJS/BdcNkbL1nUp+wzoHbSkneF
 Agec+2/vZ5pD9VMlYLH6JYtojd4lw+c9324UlXoqDr430FosAz6xi/D7ZzlJ/zRJPFqg
 hno3deyRoa4Dr2YflrZ9BgYx3K2r2yiD7U8Ro2RgFBSRWYmG7xDgxM/SLbASdkWt6IKD
 GuR8t0YxsXoLckcfG/2rgue5JBH2saMnVnD6doGH/SGMpX4/+KK/mWZ2a2JWvTXMDJXC
 00UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768934374; x=1769539174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bggCs3F8lakcGV/xgvsKOfncSaOjQlaK7c4RhIG7iho=;
 b=Jf1iLnfOv2UVCZg72fAcCkCp0CMKqtt6kZ6NKbhJjl3Z9o3tDSqx8cLt/U0WmI76ZE
 MH7AxaKk8zo0VZksmL++U0xmURP9Ez6EkVM8UWxixKI/kZE9gnN1Gtfsc+JbwEV1QFPe
 vP6ukVDh1ppnm2+t9A5+WOGjhC/9LwCeBjUZAvRUbbSq9VXN2d5IcY96tbUxd1hjT03k
 V2RnMN5WV1Y+AsppZPZH9AfpfMH0NqZ+XHvipqg5jD0p9L6soNRUo3TAzy69tdSCgmNw
 WE9Q6r8tzmDijfc+T7PqI5SJGVfyidMeiplorXd8PsaPMOREBCH0HwoE4ATsIcQ3sTnG
 F1yg==
X-Gm-Message-State: AOJu0Yw8PQpcUaYpvy5ayA5D5BsQnLjSB9n5hRLXKZpreJH+KwU734uh
 kgB1pRadIwTL1aA7ZfOUhDN8OQm4PpaV2tj9sTKfM/g+8pybFpLWuUrrJvaYoqLMf2z8fgBbMP8
 o2BTdHro=
X-Gm-Gg: AY/fxX5qYgq0HXFRg6UKfQ2/IEq/A5wVMCpfU7uy4FR9I8Rhgsg1pxTcQvhaELj7IG4
 oagjA+GJhbsi6G3UA4liT0qRQF+E0TAKldo/rY6X6KzIhNOrK0L8Z6xr99f1FjpKpKF1CCWLUEb
 I3bA2hDzTpcF/UHU9H0y2RpD9NA1FUEC0j5j7kKsW1xpcQXgbz4LwUkn3Jz9EVYLilsFJiPzMXC
 pRenIu+2gEWkbE1qy3Zuh+eTUCHlvgGx9WQZFpKMuqFn7M5xNmN1qSbYIMIYo7d53+SFQZKft0W
 +cK7JBsz1yhNle7gxoC66Ma/YgJiIp7Hkd3oOwoNu4ZU5+uq3rArO0Aj4YxTRBvGCCfS32rMc5z
 tQXvSoakvNRAVkyHxHVd93WV61xw8Zd+T4pKiLTG6xwjnyyVhPCb7L2YPRgjiqd/S5/FwY1kV/B
 TK7CsOamdaPug2FXcB1kUx6YLGK4MnxaYbaYNmBd0XRwRO+uksESTFRGcKU9W4
X-Received: by 2002:a05:600c:1c24:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-4802590e305mr206894065e9.14.1768934374443; 
 Tue, 20 Jan 2026 10:39:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c0475sm310070555e9.10.2026.01.20.10.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Jan 2026 10:39:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/29] hw/arm/smmuv3-common: Add NSCFG bit definition for CD
Date: Tue, 20 Jan 2026 19:38:37 +0100
Message-ID: <20260120183902.73845-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120183902.73845-1-philmd@linaro.org>
References: <20260120183902.73845-1-philmd@linaro.org>
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

From: Tao Tang <tangtao1634@phytium.com.cn>

Add NSCFG bit definition for CD structure. This allows proper
configuration of non-secure access settings in CD.

Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-ID: <20260119161112.3841386-5-tangtao1634@phytium.com.cn>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/smmuv3-common.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
index f0e1dd85715..e8e7746d1fa 100644
--- a/include/hw/arm/smmuv3-common.h
+++ b/include/hw/arm/smmuv3-common.h
@@ -123,11 +123,13 @@ REG32(CD_1, 4)
     FIELD(CD_1, A, 14, 1)
     FIELD(CD_1, ASID, 16, 16)
 REG32(CD_2, 8)
+    FIELD(CD_2, NSCFG0, 0, 1)
     FIELD(CD_2, HAD0, 1, 1)
     FIELD(CD_2, TTB0_LO, 4, 28)
 REG32(CD_3, 12)
     FIELD(CD_3, TTB0_HI, 0, 20)
 REG32(CD_4, 16)
+    FIELD(CD_4, NSCFG1, 0, 1)
     FIELD(CD_4, HAD1, 1, 1)
     FIELD(CD_4, TTB1_LO, 4, 28)
 REG32(CD_5, 20)
@@ -155,6 +157,9 @@ REG32(CD_5, 20)
 #define CD_R(x)          FIELD_EX32((x)->word[1], CD_1, R)
 #define CD_A(x)          FIELD_EX32((x)->word[1], CD_1, A)
 #define CD_ASID(x)       FIELD_EX32((x)->word[1], CD_1, ASID)
+#define CD_NSCFG(x, sel) ((sel) ?                                         \
+    FIELD_EX32((x)->word[4], CD_4, NSCFG1) :                              \
+    FIELD_EX32((x)->word[2], CD_2, NSCFG0))
 #define CD_HAD(x, sel)   ((sel) ?                                         \
     FIELD_EX32((x)->word[4], CD_4, HAD1) :                                \
     FIELD_EX32((x)->word[2], CD_2, HAD0))
-- 
2.52.0


