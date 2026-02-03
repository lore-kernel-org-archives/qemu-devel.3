Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DD4E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHzm-0006U8-Aw; Tue, 03 Feb 2026 10:07:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzh-000670-1f
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHzf-0002OL-0o
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:07:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so61139955e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131225; x=1770736025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Wg3kzQERP1Tgs5FiNcwJ1071cd3u0gLKnJSMnOg+67o=;
 b=LtTAXhu+HA7gIK9EredfIHL+AZ4/jJdrbHaonA1boRTNBx+X1+HresBys4qHmYA3fx
 pintEZa0GqnHl55bShO3lJBYp89PEM5uefp9hMMAUCWI5EDr2n3lU11vgXpjIQpUD/aN
 +mwBX6Ibd3JCNFVvcndVaCv2IvEv0cXF0+zrcuagMCAdlCQ4nvbaE7vVp3JLhwuuli7Y
 zzUmcWzn2whzZxu87lI9oVATH1czV1XMJ+CW8UNKPqHNs4C86oD9ACocGlvk2A077fS9
 kNUjS+66ENJO+UwDDXRMQDjXp/Hnt8dTTkgpVJghgoRY7YaIIPbABjiA+InQAiXuwFbG
 eM+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131225; x=1770736025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wg3kzQERP1Tgs5FiNcwJ1071cd3u0gLKnJSMnOg+67o=;
 b=ECZlnRRiXgfAVO54IFB9VpCLT8+I73kF32QQ6Bdb029SxmEIPb/NsVkLO0s0bOYS/H
 UHOI2LGGqBwISWvvuq7nDtbD02qf+KzIPeIaFpx2jc873h7i6ctsB9rKDmYrp+PlAzbR
 sbqEfH60yAfonWrD/U4eLfTwEIM6tfHFqXDquEp1Uf4NXgKsE1tRU6AZzaYgtAyLcvT+
 v5N/zV/L6BBrm5y++4JNlT71+5asL4kMvLbtBgF4tO79Yu6Q0zFzRghB/EHE2iacYGNo
 kUyFaSfM2Ky4H2VGMm6JgS3Gz0TzRrDl3ebV+pNnGYvc56y+0wx10Z6KlArCrqA+mxK4
 SVOw==
X-Gm-Message-State: AOJu0YxO4Wr3LDOh6GplG9tetT2bcop+IWoB+6b0sPM3zkAOubcTdn1N
 5yfPbq2EW1o1Et3DfzWV3r273/dYy75iPjviTrL/VLHdV+7eVa6l0/wqUObpjjnxmUcPX6gdEbK
 V0/akCP4=
X-Gm-Gg: AZuq6aJ0xnXk7SMWRuF6SDrBbf/sgCHOJIarSwa7LUy9MKXXSLvM6XV1v7x2OFU5HDF
 oTzEbviZ8RBicmhj9INEhl/ydGB4M4O9YQBaLHwg3CqgX/q7RwhinL8wzVFQXAq8mp4phHaYDa7
 sYyDOKRps0vkFquSW+qWKDmx7GKqMmuYEkzELPGEX5NwUxwyiZfJZhrSozan7c6iWPz4CGG8FzG
 dguNTNDL0tjBsawRYlemGWx0CiC9zDe2brhOV6OaU09DNK03TqDtzcWP0RWiPVLfNPYkilMKoDM
 cr1aKWLwJfyfMVIzupolWVXOF7ah/lmsEWHy2n29YzJwm5AYONtBB6ngIivu6IPQZKwK+e/uqKw
 nU1SZG10bGd96QiqNhrGcONCUrJYw9+LC0TeHME5jvejWSFeli1vUK86EzGCZ8dqiFAxj/DIJWq
 kTLGy7KUyZTvDiTfgAJ3c/Chu+YkeO/VSzMu58m7HGaALHLxx3TiLJ1c06dxe8
X-Received: by 2002:a05:600c:4ed0:b0:479:1ac2:f9b8 with SMTP id
 5b1f17b1804b1-482db481b45mr186650405e9.21.1770131224945; 
 Tue, 03 Feb 2026 07:07:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483051372cdsm110909775e9.13.2026.02.03.07.07.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:07:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/30] target/alpha: Do not use target_ulong for page table
 entries / indexes
Date: Tue,  3 Feb 2026 16:04:26 +0100
Message-ID: <20260203150436.71907-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

%L[123]pte are loaded calling ldq_le_phys() which returns
a uint64_t. %pt is loaded with @ptbr, declared as uint64_t
in target/alpha/cpu.h:

  236    uint64_t ptbr;

%index is at most 1024 so can fit in uint16_t.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260202234550.34156-6-philmd@linaro.org>
---
 target/alpha/helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 2dc52cc4465..d6200d101cc 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -173,8 +173,9 @@ static int get_physical_address(CPUAlphaState *env, target_ulong addr,
     CPUState *cs = env_cpu(env);
     target_long saddr = addr;
     target_ulong phys = 0;
-    target_ulong L1pte, L2pte, L3pte;
-    target_ulong pt, index;
+    uint64_t L1pte, L2pte, L3pte;
+    uint64_t pt;
+    uint16_t index;
     int prot = 0;
     int ret = MM_K_ACV;
     MemTxResult txres;
-- 
2.52.0


