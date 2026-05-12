Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8515CD484E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 06:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMgWK-00014J-5b; Tue, 12 May 2026 02:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgWE-0000zw-8h
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:02 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMgW9-0004gF-Na
 for qemu-devel@nongnu.org; Tue, 12 May 2026 02:23:01 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso44284685e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 23:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778566975; x=1779171775; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vwo87tkNpgYg6uZPVSFE7rtPPjY0Aoz+JdJG9zLwI60=;
 b=tl9ggBMJn7R7N8USK1MHfdIRL4se8/14CwY8y0bnEHw2HkGOD/b9CYLIzlew/FFYHA
 1F5c7b8dJYH2zY1UIh0jxnRcBVLwFh4Chz1qCsJdecR6FitAIisiJexeWmbJb4boAD7D
 TJBQPNVj2h8wvyNGpcJoflfXWZdmaxZpWKieO3bCh04yzr+ZgNq4PkMeriKeq4O67dcN
 s/9a20KUoKkj9Hp6WRPFIc6d98kWuu1UsxmTMoqMlOsGrhCiDtBusosr3z8dqg9r7jZ0
 mRyQUIY4J6W+WhQvHb/gTaEdYKmSSim5nBtdRYuzt2e0dWWuba1Hp84cfxOny6TSG0Y0
 w5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778566975; x=1779171775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vwo87tkNpgYg6uZPVSFE7rtPPjY0Aoz+JdJG9zLwI60=;
 b=h0+yYtxFOVp3/S+3LtVF6C6kA6EKwok7x+7xi+t/GoUODQA4NOhc1T94sUb64xDwPg
 r5zppM6cHWcLc/QoDDKc2cTKNr67grQVgMuVoSvyafMkUmH6WmHs94K/MJuJgXtT4qsm
 F0Sfs6STNKg3uSqwlVTtrzdz7ewZVOg7ScDkv63zO8Aq/AgqeUhvMY/vDtbQ5y1ZkxLE
 D0UEFkbmsTLkr/OCeOyVFxh+KFtqzpaNsBe1BRp/Jt/Z9CmPTK/yS9QOXUCVoElNeB3Q
 yNIDR0fbBmuuS/Hpu1nmihPfXm5GEukegPw9WeepUigE6obGywOfPkiXbAS98VgfQ4j9
 Ezxg==
X-Gm-Message-State: AOJu0YyZNQpTP1WlKlQ8G8IxLV1za24IB+O8s/JT4wF9BWvFtgE8HAgK
 7RnVrtMiWvv4PdglM1moSj6ZSXtdgq04DLfzXPqvnPZXXe4UfoWlacqMxpsgSjWRTbVVakWNTWP
 lrAfHpZw=
X-Gm-Gg: Acq92OFI0SVQ5DoD/xehFzHMmaGEcdxkD/r2QBChSzMuSjbskkovPJsTVbRwrV9k/kb
 Q3D228fyRR3QdmMEl9QVjyySdm8N9pVFIZVuZasvRD/cFXShp9iXgxIOTvBNTRNbqE6ETGfqGvR
 X1hQj6rkF/2PsjU+4qTxJKDyFy6sWZru40/mq5w33RNAl4cqM6uUAamEP3JFRx8yZyoGf3CSi9c
 EA/IerHbLngmnugdtvPB0Li8bn1z5ey5v+ARaI377jjLNMam/nAz7c0bhsqAJxjdr2DpIv899mn
 pBw/tbeMNBDkYi8NPvtWN0cc1k5zXKawufxyMtVaWYwvq2017ULPkWyvl8GUw78Ct1THpsH4VTw
 IlBy9+ZYLvMUTWvIJ7Pkpc31tBwiwerrXrMlfBjCNeUTPUrHVpgM0ncXpYwuPAzF+iPtQrCDVIk
 6hOXkRvYsJA0BZQ93SvQMVwo1PQmoTLyOmh5upZMLh9kLlb2hu4ZJlT4Xc7ZWXhPyZdI2Igsxf
X-Received: by 2002:a05:600c:c091:b0:488:a977:8de with SMTP id
 5b1f17b1804b1-48e706b264cmr152181685e9.16.1778566975202; 
 Mon, 11 May 2026 23:22:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e4bb87bsm29283169f8f.2.2026.05.11.23.22.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 23:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] hw/i386/vapic: Cope with non-page-aligned return from
 cpu_get_phys_page_debug()
Date: Tue, 12 May 2026 08:21:11 +0200
Message-ID: <20260512062142.67998-11-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512062142.67998-1-philmd@linaro.org>
References: <20260512062142.67998-1-philmd@linaro.org>
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

From: Peter Maydell <peter.maydell@linaro.org>

Currently the i386 implementation of get_phys_page_debug() always
returns an address aligned to a page boundary, and the vapic.c code
assumes this: it adds back in the page offset after the call.  Change
this to OR in the page offset, so that it works whether
cpu_get_phys_page_debug() returns the page address or the exact
physical address. This will mean the code continues to work when
we change the semantics to standardize on "return exact
physical address".

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260430093810.2762539-2-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/vapic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 1acb9f91b2a..3738031a055 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -309,7 +309,7 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
     if (paddr == -1) {
         return -1;
     }
-    paddr += rom_state_vaddr & ~TARGET_PAGE_MASK;
+    paddr |= rom_state_vaddr & ~TARGET_PAGE_MASK;
     if (paddr != s->rom_state_paddr) {
         return -1;
     }
-- 
2.53.0


