Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B233D6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:06:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LUj-0001Rw-AZ; Thu, 02 Apr 2026 13:06:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LU1-0000dH-6L
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:37 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTx-0000wb-J1
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:05:28 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486fb14227cso15015145e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149522; x=1775754322; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
 b=G9TeWzQA1BbVbPctZ+4nyUt+ffMBiVUsvJRVaAooOOqrN5ySehVYvN9+dPcgGUIPXQ
 uGgOh+r48cbV1lTkYyCm3fmTprHmUhiK5YATvsRNikE8dm/EHhHOzXHwzKZpymZSYdLQ
 uGwgUD66EsGgFQqdNOiCZbilNnuLwBDrGXiB8d8nRVyKkaj0SacGBYZQH7jzbyKX8Osd
 QCfPEJtPZ9Xntyra7wWo4cJhX3EHedMoFApHqjU0hSHeiUQOf587A2f5Z1YYr9b62fx6
 9X7VV8JEvbvU+dXy81/K7lPKsMdlr3J1hQjdz9WEOxzsXSN7jqSyLYV/2BBw64vHeEQe
 u+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149522; x=1775754322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G5um0Hkp4gUlr+ZAZ+thc8PXoevdikb9WS1n3IueTF8=;
 b=plDaEG/PKLDJMyQXS3ubsU8X8G+lUkeEQUk2zScuWdwg9JiZHJ3fdUZt6qNokXbpug
 2Sr8fnzA9sUrrZTJlc+uLHKGluGmxjRd/PFYbiRgnxaI0vuxB0v6C8a7h/C5VvV0dtC6
 16xv4Wjbk7R+FMlTO0/hpcLz/8p3nvKHJ18wOtf3EfFTPBvqz6r0dd1ks5iY8+i6qpzi
 YYdrhLWTCXSbTkxbtppd647IvBpMeD6rvZ/+A/4e8plyY98qyM5HFUt3Tp9G+BzVbhiL
 yCwCnSViDo4Be345BgbTNj3bqy+YZ0HCmvr7uUDhG2TRxOXUIAHmXByaepbeiWvlXCWl
 u7Zw==
X-Gm-Message-State: AOJu0YwAx47bZDM4vatAK6S1g/OAT0rI80d9xYLz+GlXowzB+/jyzE3N
 S7Tr0vAcsPPxjTO6HI5lIdE2mjTKlXlZa348CykrxSWU055MbW5DI7ye20ynbwPVlmiGBxqzm9H
 Ai7lNirY=
X-Gm-Gg: ATEYQzwVl5enxC2XJ0JHLs0Eyx38JrrN3OqNhQvbee3iLS2awOP0hX8GmnbPgEDg+UR
 5+TbWW75T3+wUPM5DcskDNjmrtEBf8zArTAkBCeEvErCY8dPpPoAdnKdopfddCG0JWobk3gWBxC
 3I+sLHSbl4mLUooHh5GqegXdTYGXbGp0L7a8FZcZnd+VVkGBQpFWpTw5SgGETYj77MgWfMtIRJf
 77K7q9iUbcCfynwVloRt0RI86MAbxm6BJ432QGrzH26vLYAdBNlwVnRwm3wBWOdBIflKjiapYfV
 LkQR0oEUnMdc4f6HwMxtcCzurh3tmjB7wH7w+Pph6klNJ1SX2YPJLt4YceO58OuZOcxlFuWtpM+
 WatFCoPvvYg8z+qI/UcCUKMe4bOhg6hL1i21yRzSuxq5lj2h6+WL6lBuJR+zGjMA/ZQCGkvbkVb
 7IOrso68gJY+tyDhCSnAaqoMmnFkm7J7bX6expKKx7MMLdDDI6MZ/rm0PRA0RZorEbzG6JVcC2
X-Received: by 2002:a05:600c:3515:b0:477:76bf:e1fb with SMTP id
 5b1f17b1804b1-4888359cee3mr152160325e9.16.1775149521759; 
 Thu, 02 Apr 2026 10:05:21 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e832585sm385581555e9.6.2026.04.02.10.05.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:05:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>
Subject: [PATCH-for-11.1 v2 6/9] target/arm: Remove target_ulong use in
 hvf_handle_psci_call()
Date: Thu,  2 Apr 2026 19:04:31 +0200
Message-ID: <20260402170434.94783-7-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
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

Similarly to commit 3580aa03547 ("target/arm/tcg/psci.c: make
compilation unit common") which replaced the target_ulong use in
arm_handle_psci_call(), replace the one in hvf_handle_psci_call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/hvf/hvf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5fc8f6bbbd9..678afe5c8e1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
     bool target_aarch64 = true;
     CPUState *target_cpu_state;
     ARMCPU *target_cpu;
-    target_ulong entry;
+    uint64_t entry;
     int target_el = 1;
     int32_t ret = 0;
 
-- 
2.53.0


