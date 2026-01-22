Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00257C44500
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqUR-0004Jx-1i; Thu, 22 Jan 2026 03:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqU2-0003bk-9y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:12 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqU0-0006KW-Mr
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:56:06 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so9377995e9.0
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072162; x=1769676962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jx2MTEh6sIqMM1OGINhFt99VXMr3lBlqUEdHP0I77/k=;
 b=gDyoYl+BJhTEeDGpT74HeeGPOSMI5MhSTg87j0kZrFs1Q4ryPPXGwnoxqcIRdkIBy5
 CxyxLp2EjoUy+g60X9C+qy7MT1oYnYbMx9WqwlmlLZMfDujfjBh93SE3Ekdg/jXwKZLq
 /CARKrbpozbc1cbMEDSZBT02m1h/QuH1xrCpJTziTLq7imdxbPbLzmRbpxN6PpIMff+Q
 qYyBebfqHEyL4QEv3D5Bc2P5gs7KosuVSac1By6VE4nAwXHazEO6f+kmyEGnwZcD02l6
 T7MacGF+puZobVWbIjVK8nlD17BiOhysH7/zUl2q/cdHP55n5egrufUdGv3Dz93TsuCx
 ijsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072162; x=1769676962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jx2MTEh6sIqMM1OGINhFt99VXMr3lBlqUEdHP0I77/k=;
 b=UvLTdjf65inP4LdvruiiJyH6ylfEBrXvBqaxDxabtrmCHa2SoVXeDO3DsOl1PCt4ET
 04hgF01B944gaS6taGGqbmnWoEOMiwaBXbc7A9nWvhU4U9CecHqz6LNgss/T+17sPcgE
 7vIRJKS3sDhoIt3S0bw6nHHFa0WGwhGMMt21FRS6FZU/2aeR+BUqytPznF+Z6Gkp/+Kf
 sxF4B/h/LTbX5BxKKAg+Arn/4SvWgIRy0zRfAAtkg0SJMTPrEVRUQ2I3o+vKoAYh/bLe
 hJpyJVppktSn+XImh3I29X2DJwSL2Njkiv7VIqju+k2BCQ3yOhHpEcoyPazIcJw0fVHv
 7rMw==
X-Gm-Message-State: AOJu0YxnuC1UkH5Dopuwcsu73mj8NCpLPwafH1iZ31hf4N0id0RIP7DR
 E9B/8z6fUco4TANpz/OeCdCIPfEfsoUYwAqSKovnCafq4SfhsDCnWVjfieYuFlvKZJYd+mbsn0z
 /xXLmKZk=
X-Gm-Gg: AZuq6aIdvqCrY9JWQKKUN3cNzotvrMgHSRUOTUdPIWanNzZwpY6RBul/DrnoeUId0bb
 exsw6i0ruS8XxZa4bC4TBahcxN4hfsgrYChym0s/P5X8vNba+7p0/PWuC4PqdqHESfC7mLAXkKW
 J8vrdLtwvlmqKQzfNQGC7dkt1LVjF8B2YLvomIf4Wng6aa2Xsg1Kn8KToLHzZLxy2SYIhbOF1yM
 Wzb6c7EJSAEzH7RoVgC32PRhKOBv/BD/IARidILEA/LgE/VRpKSOV1YkCdiCXHwdXJneAE+sKdf
 SDuQTvgfyLudgjQssJhL5y9tr3IhMXCiLXCL3g3Nuu2Aq51zL/AcjZh5aPV8F44H2EWWmxOcl2u
 8uZSOn/mZT/le5RjGv+JjJ1ZyeZjxF1RzyswngUTPRvElPpY47aHmTSF+4+xu/yfycaALICsGjy
 AbAO/HN41emO4bDg+IvZKLLxf7FE3/IpA5DvP9Wqa2GYRUKi38/1aDqo/dAxteE7QR7TIPIOE=
X-Received: by 2002:a05:600c:820b:b0:47a:9560:ec28 with SMTP id
 5b1f17b1804b1-4803e7a2d1dmr110270785e9.13.1769072162181; 
 Thu, 22 Jan 2026 00:56:02 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-480497035cdsm14497205e9.19.2026.01.22.00.56.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:56:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/31] target/arm: Initialize AS 0 first
Date: Thu, 22 Jan 2026 09:52:51 +0100
Message-ID: <20260122085255.95035-29-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Move the initialization of AS of index 0 (ARMASIdx_NS) so it happens
before the initialization of the other address spaces. This is purely a
code organization change with no effect on behavior.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20260116185814.108560-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 05fa3339b1a..8d5987397ad 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2159,6 +2159,8 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         cs->num_ases = 1 + has_secure;
     }
 
+    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
+
     if (has_secure) {
         if (!cpu->secure_memory) {
             cpu->secure_memory = cs->memory;
@@ -2176,8 +2178,6 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
         }
     }
 
-    cpu_address_space_init(cs, ARMASIdx_NS, "cpu-memory", cs->memory);
-
     /* No core_count specified, default to smp_cpus. */
     if (cpu->core_count == -1) {
         cpu->core_count = smp_cpus;
-- 
2.52.0


