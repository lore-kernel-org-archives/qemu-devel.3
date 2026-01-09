Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3758D26D71
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 16:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veFjT-0007r4-La; Fri, 09 Jan 2026 11:53:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjQ-0007dV-3j
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:53:00 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1veFjM-0007Xw-40
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 11:52:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4775895d69cso22529525e9.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 08:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767977569; x=1768582369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZDayLa9IHiaG4d3i6+piUlKioZqcrfCwHQyt+SfPnIE=;
 b=hz6esLKsc32Uw8TRArYI8xYfJXKhDa65fP+b3H6+a9mSaUbZ4nbTW3/upE0II2oiiC
 gcgzM+IITO+FJk+PFvFSr9UYUpDZP5gIP23zjTch0ieaX2h/y2dCMRIoQaP+o1e8qCt3
 enYuVa4oNhmvp+HcUNzuQYwuB/UbqxiS1EDij3yK3I0S8QNaJHFrywAKZQaTIv+RIM5Y
 IBGtlYIOUnXe0b5EoteFZ9bPS/6dppSeV/WljOM75nKLnn8u5LyeIvwatD13XaJc8bfW
 gIFriK3Uh8Uqc9v9il/2+fFq/R7f1rDPN49AvTgpZrKkC0ORQXINGTQ1/+7d4XMrZ5gk
 Rc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767977569; x=1768582369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZDayLa9IHiaG4d3i6+piUlKioZqcrfCwHQyt+SfPnIE=;
 b=TjcMM9EmtAYKNKUaXIa2oqfNDjO59y9z2N96+ofE8qo8YG+aCWCsozubmAbyYKHNiK
 JOimNqLygc69SsXvZAWa2PBZj+uPXytXRgAtctkO1Cu2EbZL7PWqPQz1t0lh/cS6FxcB
 IW/LCKpUK1x/pIG88SLa/GVjEkurhkGHZ1PC9heQkAfx1TkWXai7vzEt+fOaki9u1xPY
 t3uNG+uol+sBx/qjUCl1pWPMpbnUoo/JQH8qfcOzv1XjKvp+OQpg5NYVIvI0BeA5upTM
 hheymTSI1P1E1mWBn1RowiSXNxqWpCeW5J8SvB5QRQ3Tvp6+wfh+Gz6Jq3sseA6sjoz3
 240A==
X-Gm-Message-State: AOJu0YyaXgsK6JsW/AbtwSbaZTRXmB5e+nWwlc0aqETNvP4kTcf55N29
 xXAr3R3wY/BGbseNC0ZysaBppHqwDcBYDgKXYZxiEiv8AjMrKUrETMVvUPwcl0eIIdI5LqDn2iz
 wo8J8TU4=
X-Gm-Gg: AY/fxX40KEkbWS1p1VmBRKYrEIitQbEtNUViiXHYNLiORbNE9tOS/Hq4SN0x43B0ag8
 vVecuhWbYnV3CFPsd0HautE+sFT8l5MlnwW4K8rNdKfLpERP4Va3Skxfy/VHCT54pTKLC06uT04
 AE9p82aoqFjXb/9UiUzFClacjszZg2AFPyHSzrnAFZGT6+VcCVwAEavtrgXPjeY+6enkjM8sopH
 r5OzXjPAEBKX9WIk23qc6JTj7cHKOot2BceXAxj5YG9QsQWqgODOL99pXSSvo/mhJx15qA/U886
 YY5eQDrsnKN/IGBr5XPVeyo4dEF0rRGS00cngEO8e4599Ux0Jo1sg0DA1hBtOCn0RPsxDiFUDNQ
 vWmcf3ymtyLWCG7buC2epDa2rDA+lbevX7xrPPKfKrfe3uUeQS0KJs/1mF+20WSb1xAUtO9Jb17
 H0CO69ECmlVMjdM7qBKTTXy/jHfbnOdhVx/5xIu+V5tgApUMIfDamXCs6r4cMI
X-Google-Smtp-Source: AGHT+IG3EmAvxSEzq4YllUvTBKi30NMsA6v9Z70RghDbrHcPvFL4W9VDIr6w2UEZ6jmeAIJF+SdrEg==
X-Received: by 2002:a05:600c:3b19:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d84b3b645mr124464745e9.21.1767977568833; 
 Fri, 09 Jan 2026 08:52:48 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f695225sm217994415e9.4.2026.01.09.08.52.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Jan 2026 08:52:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v5 16/22] system: Allow restricting the legacy cpu_ld/st()
 'native-endian' API
Date: Fri,  9 Jan 2026 17:50:52 +0100
Message-ID: <20260109165058.59144-17-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109165058.59144-1-philmd@linaro.org>
References: <20260109165058.59144-1-philmd@linaro.org>
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

Guard the native endian APIs we want to remove by surrounding
them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.

Once a target gets cleaned we'll set the definition in the
target config, then the target won't be able to use the legacy
API anymore.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/accel/tcg/cpu-ldst.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/accel/tcg/cpu-ldst.h b/include/accel/tcg/cpu-ldst.h
index 0de7f5eaa6b..a5711bc15a6 100644
--- a/include/accel/tcg/cpu-ldst.h
+++ b/include/accel/tcg/cpu-ldst.h
@@ -428,6 +428,7 @@ cpu_stq_le_data(CPUArchState *env, abi_ptr addr, uint64_t val)
     cpu_stq_le_data_ra(env, addr, val, 0);
 }
 
+#ifndef TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API
 #if TARGET_BIG_ENDIAN
 # define cpu_lduw_data        cpu_lduw_be_data
 # define cpu_ldsw_data        cpu_ldsw_be_data
@@ -501,5 +502,6 @@ static inline uint64_t cpu_ldq_code(CPUArchState *env, abi_ptr addr)
     MemOpIdx oi = make_memop_idx(MO_TEUQ, cpu_mmu_index(cs, true));
     return cpu_ldq_code_mmu(env, addr, oi, 0);
 }
+#endif /* TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API */
 
 #endif /* ACCEL_TCG_CPU_LDST_H */
-- 
2.52.0


