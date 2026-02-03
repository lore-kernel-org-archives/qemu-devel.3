Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37034E8B37E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 23:01:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnPOe-00061Z-9I; Tue, 03 Feb 2026 18:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOa-0005yi-WC
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:21 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnPOZ-0006B7-Fe
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 18:01:20 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so146953f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 15:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770159677; x=1770764477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cMPkVyK650njXsWAImuRdeZzNFIoTsC8s5V4QtgoJgg=;
 b=O6t9F3m27MxJNc5iNKfyYAaq2bW/gBlTEkvMlIsr9LeztT4RmqVtIGUmQoDNym50MJ
 i99JKsTMdnIqIC8K+0cv627sUHSuNy0i3Nsl1jdyt9TRL3P2FuLDNEYFIJvjQTIqnK+W
 gBNtYXXPvOG+/MjsfUMbuMzTBuLMp6pCYzQ7I06FDozUXn9DbHTDAd/Q0RueN5D+q8nx
 YrZMInBV8ncMG2iDxtwsC02aGjlU69TlGuv5yCmQhE8O4ooYpZwpu7FXKq6HRyOJoD76
 NabTkMLvXGdYMORX6LQF4aChUnOt/JqFCK06Zop1Cl/OWslbonAqOOkPZr4+x5TFYqyM
 qbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770159677; x=1770764477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cMPkVyK650njXsWAImuRdeZzNFIoTsC8s5V4QtgoJgg=;
 b=stsfzOkaadbEJ8quZV2UaycGjVd+uWqeWKPaocZjgu6ecubvKFD90+QAia4g6bUGRT
 4RiUAf8s56mx3SnQCrkhhIkQwi3rYLDi29cDa7B1e/nEV8mPEDmf120ejMv1aNwq2Qfq
 Tu158v6ztidHStA7mitrUNNUW9svSCoMGwygncVtt7YeDn8wEHukinlltsb9/mSEj16z
 q8Rc1Ts32/P8WWepWNqlu61nqDVr8+dZu320SbUVHHJhA1m8FmDo5DeWTwfO4lSH55MG
 kMC0OO+93ra36gx/x69aM2CB3X94/W33Y/adwlKwBG2QfEG3/WB32s/EGvlFx7B+95h6
 1+sA==
X-Gm-Message-State: AOJu0YxYyXYqdfo5KeADWAt72/wYsXHaUs9/GbP7/286fJS5EqJ0dBim
 Sa9MLYxtNiz5hYxsNFALdEJnhkF0Q5IEPLCfKW59eDx/yDhdSPB+8V2DN3qYHMobBPpX9jyEng5
 79dFiEho=
X-Gm-Gg: AZuq6aJJCOIwgUKjBI5WTStM5pXCd4GccR/zVZbpampBplSkrhcGoiXGeTPkG/pe654
 cbq9/l4Fq3TComSbMg6q1APUD7QYP+DX7mFychs3a8GvXgWcPWWEKirvAT052fQhj4vLCaoIHM2
 V3/t1ZcIekVKyfX8XbdeTg+KE0AnX7jklc2RKH6cdkGGPyBt0Tmb0irkwPI15T8Rw7WUph6/5Uw
 Zsu7jJUQP8Z1/u/Nx0rqwcFzg1I1sWR7Sf1RNaKhg/YKVv48d3fACG9f1F9PoThD0V9BxCiBBYf
 Wq3kwzF3Bu7RyuaaXDZhXib4gYaH1KB5tWr8wG8Qk6gVWMZ8ZEgzMpO6rmI07gMg29VVXXm4taf
 ImzC9U7T4y4li1B1ERzAw0HxhASiitqycDGy/ERNoylxWfJqRzvoU/Xq+uYWHbfSJ7p8t/lrLjN
 MqbvIx3oasJCzL9Q6sxXpGX5s60swTTLC1n6VNwNvexR91stO0vCA/AwIF4NxD
X-Received: by 2002:a05:6000:40cf:b0:435:9538:939b with SMTP id
 ffacd0b85a97d-43617c3933emr1432912f8f.8.1770159677419; 
 Tue, 03 Feb 2026 15:01:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805faf7sm1903528f8f.30.2026.02.03.15.01.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 15:01:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/5] target/sparc: Remove dubious swapping in LD_code()
 helper
Date: Wed,  4 Feb 2026 00:00:52 +0100
Message-ID: <20260203230054.23667-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203230054.23667-1-philmd@linaro.org>
References: <20260203230054.23667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

Since the endianness is contained in %oi, cpu_ld*_code_mmu() has
already honored it. Swapping again makes no sense. Remove the
bswap() calls.

Fixes: 2786a3f8d3a ("Use GET_ASI_CODE for ASI_KERNELTXT / ASI_USERTXT")
Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e1178e53d51..10746b3c0f1 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -1166,21 +1166,12 @@ uint64_t helper_ld_code(CPUSPARCState *env, target_ulong addr, uint32_t oi)
         break;
     case MO_16:
         ret = cpu_ldw_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap16(ret);
-        }
         break;
     case MO_32:
         ret = cpu_ldl_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap32(ret);
-        }
         break;
     case MO_64:
         ret = cpu_ldq_code_mmu(env, addr, oi, ra);
-        if ((mop & MO_BSWAP) != MO_TE) {
-            ret = bswap64(ret);
-        }
         break;
     default:
         g_assert_not_reached();
-- 
2.52.0


