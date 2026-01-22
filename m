Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98CAC44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 11:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visge-0002XH-Pu; Thu, 22 Jan 2026 06:17:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visgc-0002WV-Vh
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:15 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1visga-0001U3-NX
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 06:17:13 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-42fb6ce71c7so763117f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 03:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769080630; x=1769685430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=f40ZojiJMQajYUNmy7JnVRXNqhfXSx9g61MPFpN4rzA=;
 b=RXc4emPixckvt897LNCXJgqEq3xHj9B6esnhfVzCmmUN8Y3ItbVUOUhbsiXJdz1LNB
 mda2ifc22Oy7cyeRs5Onfmd3K7tM2wl5QZd5QJNrj/Lem0JlAWVpi/VatisCtpgurE37
 GPwADGJHqlJ9Xm2C28yhcp2mM0W9raZrK5tL37tTKcgfGI93XKWFArF/zMEx9vaB1IsS
 2m5NFQP20mzbUidS942q4jYH6UQ1azziUAs4nKElnmFfKPdYjqltmTT99K3W1QGL7K3s
 fY/mqgW+39mSRgTCiQXhtt8+yIWag+Keosgv39l7rIEeh3KiAIMkddJZtfYMgvT+oAtJ
 ix5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769080630; x=1769685430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f40ZojiJMQajYUNmy7JnVRXNqhfXSx9g61MPFpN4rzA=;
 b=M2B6T/EkyYNqvrtHIYnZjk5PhyThLMu2w6+BwxIeeNZYdCQq/IWD5io1V8iGQ0roP9
 274u5jhHn59JWGbe+V87H1i3cJ3JiXDEwj3CNNh4OXqpRLQz4DoSKRQGNWK8Aau2uWy9
 1setAb4DjMd/optVGsFqV3+2lYhEMoTIpeI38oOn8u3viK/RUtw+93sZdo269L/yCT55
 TuUqG30Rt3bFzapfWWn2pExl4rP0EHBgAvzUH98fNotDUpicQy5ta8Czw+uGXArp47Gy
 lMkwLXhKJ9Ef6Pog7p9LOxmQeZM6FrRhNOvH9UrucZ4ExbFdGjjnPVxki8gsvcs2WsNw
 7x0Q==
X-Gm-Message-State: AOJu0Yw9LzeI6aswFCqrvZ8ly5s40tZuSH4ydqtEHkFeWudV7ax4umqY
 m0QwmEBu1GlCVq1U0oBhU0VUgSi3saAbth1L72i4yJUMmNwGIJYHU/pDdYLul21r79qa5mjVoaJ
 n+qP+VJo=
X-Gm-Gg: AZuq6aKKiwStnknGujQ4v6xJ1CLzBqtfVVGxWQHk5A3Nl7OKQbBJsfgphq+dW7qPtmZ
 DRoEoJkzInDYCmHjEFBZbbrRKc9VJtoqzucI01wCzOVT3zLAVFjCYffcbuuFv28eIWnE95iSfIE
 IZOx6M8+64N0BAIWPJkor5ci7Nu3AtR96fQ0tYYu777DgVDHUyjxT8Qdghvmxj30I1eFXTS8vqc
 YV0u4qhn0cSbXSZ2fes6whyVEFofN/uXoOhrWSp6maqDF1yImt/+8wm+YgPOVHhfCzHIANoMWKz
 IWKWYBAcceMxWqlVPfX9O84m98NC4tdKkZytYf4+nMIijzTGk+ulYEAUvXrwKw0YplD5LVJYDgX
 pt22B+Lrz7abszb1CYeA0MpsVklhNZc6n6U4JkH/oZdDQNloGKg0SsOxzPu5AIU9TVD5ADjevNU
 72vXaLVRusxLMwJO3wXjvIopGMT0HYQ/m0WGkYafWwS3PiFMVeByJ4qfpVSD+BaYTdK8Grb6o=
X-Received: by 2002:a05:6000:2387:b0:430:fbad:687a with SMTP id
 ffacd0b85a97d-4356997f7bfmr34412518f8f.13.1769080630116; 
 Thu, 22 Jan 2026 03:17:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921f6esm43661172f8f.4.2026.01.22.03.17.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 03:17:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 04/37] target/sparc: Use big-endian variant of
 cpu_ld/st_data*()
Date: Thu, 22 Jan 2026 12:16:37 +0100
Message-ID: <20260122111639.32346-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122111639.32346-1-philmd@linaro.org>
References: <20260122111639.32346-1-philmd@linaro.org>
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

We only build the SPARC targets using big endianness order,
therefore the cpu_ld/st_data*() definitions expand to the big
endian declarations. Use the explicit big-endian variants.

Mechanical change running:

  $ tgt=sparc; \
    end=be; \
    for op in data mmuidx_ra; do \
      for ac in uw sw l q; do \
        sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
      for ac in w l q; do \
        sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
                  $(git grep -l cpu_ target/${tgt}/); \
      done;
    done

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251126202200.23100-10-philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index 881dbc96edd..3bc6a6827a4 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
             ret = cpu_ldub_data(env, addr);
             break;
         case 2:
-            ret = cpu_lduw_data(env, addr);
+            ret = cpu_lduw_be_data(env, addr);
             break;
         case 4:
-            ret = cpu_ldl_data(env, addr);
+            ret = cpu_ldl_be_data(env, addr);
             break;
         case 8:
-            ret = cpu_ldq_data(env, addr);
+            ret = cpu_ldq_be_data(env, addr);
             break;
         default:
             g_assert_not_reached();
-- 
2.52.0


