Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF8E7C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAn-0005wW-P0; Tue, 01 Jul 2025 10:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAm-0005sk-1s
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAk-0006tZ-7l
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:23 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450ce671a08so22554605e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380880; x=1751985680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af2GPZo5Jp9qdPnKPAF/APVL/x4FGZ5cIgr1W/DbocY=;
 b=H1l/7Zo12Sg1emHT01QrTVOvmhVBU4x/XdVssQnKxI2U/Njucitqw2tLTrJbyjpvGr
 6gsTzDGJhZcbIg9eOWfwwU3byLV7glFSSHrheSfjlej28MKFTaqkX91ILjuzKZycMM7d
 Z3Y02nRTX/1WcBy2sJArgJBBl3O7IS2OEZ/bQe+gBesMJS97BGkiDGAbXBw7jbVeVuxT
 oe4rfH9rtZi6qY4mfkP/ko+mt5za+Acx/Iwz7MO4NWnAklSz9k2AY1oImWQANp7Z5qlN
 PbQ2UO9hB6ecRl5YP0KVK1pwZusyFS3CMbjF3hnsb6CtXxoag/s1RGNBKUjDffCJ0u0v
 s31g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380880; x=1751985680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=af2GPZo5Jp9qdPnKPAF/APVL/x4FGZ5cIgr1W/DbocY=;
 b=bcV0ASQkQHFSPGiY5m6zbkS/t06Tb9DGy0+1Ua2eVqHSimvYVIkgNZ6kBxgkTpP4MU
 2WQEGWVAVXYojrYqBe3Fp+RtPlsLZadEULR/1zclkZKx4C90mDYGdVWCj+Z1YiWEy6BH
 YuIZ9WJs1jdTEvSXeemntNamwi2QY7HPAwzrzesajAHojC/xbwXYba2F+k6FLJxLpuf9
 /Qd8XG3Bxc+9W44CIAaRfZwUO4ArvwUdR0W8GuY0A+qw5xi06o4b93R1j3noUNsOIRK/
 gBML4rMO7bMv2N6oRIBD/DGRNJ1U4wcRW2P7r7pKapFDl0pU+a/WFgRHZgai7IQGplUH
 kuXA==
X-Gm-Message-State: AOJu0YyJWvPZa2PNGGNTZvbb1RXpMv6XMQhI8tLIyjJU5/nT2DaCU2dN
 UDf2a5mNJkNS8Rz3AWC+WizAerKCjge+O0YxgWVtG+sTyD++YvlAOe6wHJd7czC/EX9E/XoMg7o
 JqmIo
X-Gm-Gg: ASbGncv5RFbgcTXfRlLKtys+UMnA9xUpcwikgS1qb92xhasn8iAIQ175espySYgb2dU
 aalQlQuCC7BG0KRrfh6jHJRuNXQTeanA9BHBeFfHUx842xabkv+f+BZx/1bnhiHmTmBEJmnOdF9
 K59zrzgiFhCrnXlz7P1xVICVhNmpOkoobSM2BjsXEBNfVT+DsauHZmvmT6UQiXzgg0KgsW6lrPg
 sqXuQav84tctCq0HszXlCQjTGI/dTvRhL9mkHc9MunNlUwdESQVlCoMLlEbS2D57Hawrd0orMFc
 2ynO7TOJZTK3PulEh5D0Lev/W0WYKvRSiTll1EiUEMn9etRLmoXkbroGg71ojJZidSpl8AKxP09
 vN1hk2PMAYDyXjYd2+b2DeUkeW4LyFsijVUGy
X-Google-Smtp-Source: AGHT+IG6Gyq4jlY2tl3YubLFdGEwiKMGZklvh0L3jiWylM4uyTztqqdKfcKpEizw0VMm673DFAQvXA==
X-Received: by 2002:a05:600c:138d:b0:442:f482:c429 with SMTP id
 5b1f17b1804b1-453a84069b7mr34447715e9.8.1751380880135; 
 Tue, 01 Jul 2025 07:41:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a3fe587sm171408545e9.19.2025.07.01.07.41.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 11/68] accel/hvf: Re-use QOM allocated state
Date: Tue,  1 Jul 2025 16:39:19 +0200
Message-ID: <20250701144017.43487-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/hvf/hvf-accel-ops.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index 24c21c582f8..c24bc1e9c28 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -319,7 +319,7 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
 {
     int x;
     hv_return_t ret;
-    HVFState *s;
+    HVFState *s = HVF_STATE(as);
     int pa_range = 36;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
 
@@ -333,8 +333,6 @@ static int hvf_accel_init(AccelState *as, MachineState *ms)
     ret = hvf_arch_vm_create(ms, (uint32_t)pa_range);
     assert_hvf_ok(ret);
 
-    s = g_new0(HVFState, 1);
-
     s->num_slots = ARRAY_SIZE(s->slots);
     for (x = 0; x < s->num_slots; ++x) {
         s->slots[x].size = 0;
-- 
2.49.0


