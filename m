Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A75F4C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqUP-0004Cx-E4; Thu, 22 Jan 2026 03:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqUI-0003pT-5w
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqUD-0006Lg-Bf
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:19 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso449602f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072175; x=1769676975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LNKT33zEGkCRJKUHLRKmVZXejn1uzwaCfyCS7sr6NYc=;
 b=tU0HbTcT7p8h50iWv2ezM49YohmJGoKSvlae/OCEhoj4r7zd8QJotPv4sNx476Ehuw
 hn3JVapbB3ajr1430AUO2MJBoPglfvAJb48TRGXYo/YXaCZdZ+kBnnXEKVjgMKSJ7m08
 2EJmhpXFQHRTGWNFjyg+g/zWAizwrNKiONpfkv4rCC7CwilW4dr9JdNGX3q/zG2w65eG
 qZn5zf0yYKaNda7GRZz/0lNMiFG/Qni084u0lFn7HXMseTulVhEkvC0eC8VhChMGK0D7
 7Ze/ft3lxnzBGs5k0n6ggt5HlDu9CxPkbu/Wyc6uuSsuadcMSUvxC5J0uTk5gEaRVPj6
 4yrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072175; x=1769676975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LNKT33zEGkCRJKUHLRKmVZXejn1uzwaCfyCS7sr6NYc=;
 b=oxEV+B/4Ole/00cyVdRipolJLjHFNpEQM+njBzgyQsAgOTZsQU9F+u0sosn3rIB8ZS
 N26nCrYalMz6DtdGG+SYPHjV3YRzAC6IN2kFCL2HfRuMohyMgMBLbbmoI0LE60t0pJk8
 uQhwJX7rx6U5mMTf/eWSA0inx+kL0OGkhEQpo7VHhM+iUT4MfVlB9xZ8HinhXuRwCePn
 9GgpH6H57npiqkQGv2Wm5ZTZPO2ttj6rgJa9OJ49eoJe7KiUEjl062gVRvmnylkpFZfr
 rsRo1mujFYqQa8hjJ5DylvyxIAJlGkVn6a2yAqvYuIFfh5J5fYNE2Ym16hlt/r8+cgkv
 UYUA==
X-Gm-Message-State: AOJu0YzzF1QUr25zKqS8TIax77tYyyY57slU1Ug6Z6AYkI6QFuzBRRNE
 Gfqfe+PQiGd2nnCbJNvQOyFVw0bsy6tikwJUu6Y8Nn1ALP6prDLT8BJ/C0NytbLMKjZvjifsCwZ
 Nfq3DBIA=
X-Gm-Gg: AZuq6aK3HZu6sTEvrrtKN0OBw0oSuqzgISVNjyAaPN3MnNzaAe/XF+UFwl1SVAYnFDB
 V3kKVaLIduIB7boFd0nMo78y/dHGbKzc+gGCY47IQwELEOYkYM+mQz542ixmaxkpRpQoWbeH7PQ
 vp7m+iELU3RV4TgUk0OxTypTeY0Bcip2OqdXudLwK4UTI8sQcW9GmEYYIivFMQmJniXNtLkXYG/
 u8TPgcScJfdG88x/ct2lIPnSG6bzG2uap0cE1YKbsSJBrhGegnjSnDyU2RYNmHkminBkBJhaxLy
 krQk052Wyjj8x/VRcFtonzSPAGGYPnDbDiXNVKhJUPbQ4LU/yNO9M5fPUCkuzeM5Sy3dUEppuXH
 ai1ke+cZvpfl2OoDCc9zNpVF46vWQiKJX0jKxpQUscz+oFpUHGjbBz1Ye+mfRSfk0p5BOsrHJkY
 YctSwr6clOUc/igtqC1RYEov/W6ziUR7hwSNk0f5iX864qijflrBDQY+YRLh01
X-Received: by 2002:a5d:5d02:0:b0:430:f97a:6f42 with SMTP id
 ffacd0b85a97d-43569bcd728mr31113925f8f.54.1769072175333; 
 Thu, 22 Jan 2026 00:56:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356997ed8bsm44085524f8f.36.2026.01.22.00.56.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:56:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/31] target/arm: Add a _MAX sentinel to ARMASIdx enum
Date: Thu, 22 Jan 2026 09:52:53 +0100
Message-ID: <20260122085255.95035-31-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a sentinel to the ARMASIdx enum so it can be used to compute the
total number of address spaces supported by the arch.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260116185814.108560-4-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2f124d1b157..1eaf5a3fddf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2347,6 +2347,7 @@ typedef enum ARMASIdx {
     ARMASIdx_S = 1,
     ARMASIdx_TagNS = 2,
     ARMASIdx_TagS = 3,
+    ARMASIdx_MAX = ARMASIdx_TagS
 } ARMASIdx;
 
 static inline ARMMMUIdx arm_space_to_phys(ARMSecuritySpace space)
-- 
2.52.0


