Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 070A0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmZP-0005LE-J1; Wed, 20 May 2026 15:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZE-0005CG-Fw
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmZA-0002hQ-7z
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:26:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so26132535e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305210; x=1779910010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QQe8el8l0dZggGcXo3+tA+kFE0E6zkvuFFTrX++sfb0=;
 b=sniL1vUrC60VgzwUYg54eJ7fZPMxU7v6//8XWSrvl7on6j+cktTUwlZNMmFvbkT/Bz
 DU3CKcq3dMUmVBjmHAz+MbJQGKE3GW2P8dMAvU9CH+TF2V7DuLfLjErALcVkUx0qmjbE
 9ke4axpVC3xYSUt46YRJ1brYzsHEeOF7moeJfVbDzgBK3LlBKHpvqvO4wvyxKvCJcRxP
 ZmNWP4NsNVXSGVCSxxHunwpV58zarTVchoRbkXs8mGRTw7xZ4hQ5veu7A6ISUbQu/PwL
 JHCFUA1filxHwIixRe00R2kR+fdeOtD7padCxzWZoxOk+PktJXDRyulCfu9tdNDXq77E
 9xow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305210; x=1779910010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QQe8el8l0dZggGcXo3+tA+kFE0E6zkvuFFTrX++sfb0=;
 b=Z4jOPtrTb7RFajhmdQNDJhIA0/zbGbuY0aa6UaL5t7ZfhbuY8l7XUxj66G5eJ/Z6uM
 XhmkHs6e/AV5IG/T4EZUSapm/E4mvUGrLGQnpic591H7cKLhE/VfzprmZVhJ+MR/WAHT
 s+3hN1D/t9VveBHY+s88VBWYvHeCH687fSxzuiEf4EOH/V62vArKCy1SAT1/g1PY2wFz
 pKls58vxHvuL24bBidh38w77pLDKF2M9kFvLwqPqk+08ghg1iyFeWhcGkVkKT6Ic7j1Z
 CB32PXt/bWBhzWb2AvsGG9vjMaIufAvlgHyQWBbe3hxeZn7UTYpJRwQafQEwWnN6MOM9
 9o6Q==
X-Gm-Message-State: AOJu0Yw0vovUR9y2jojRce6lfT/bTuzV1jtyYfXwDriXS5Ox4u5yDlw2
 +vUiFst3smRUG0hEINJMM+bLPfFmoWikYXZ6G9YFfRP7pquf5rSDfoIUl+CAxLYJ+V/zf+UcVu+
 e9UMAUcQ=
X-Gm-Gg: Acq92OFvRcCvgliYWXdpYLLDl1omjolvRT47xoTqyGpou/6u5KduWwUGvYW6xYgW3Ap
 y4s8DGR6h7Q51o9ZkCRRjSLUMjx8lQe0rR96hhg+CtuYOGJPB86ZR0rFTrFOgK9xLm5WMzo4MSG
 ZBP6nZ7rhytXlxDCeXnFGlI9VZI8rbYbGrX9iKJ1X/vcv44gXE5Q6iSnzLJxit6f3Z7RIPKJq8G
 yDgP2fJvl9jo6tRYqKWrDGW7460XyyeTsmrexiN2oa8IaZgYRHpYnj8a+nQWMMm3Bc36JmkBC2K
 adxLb6CLj+LIY/R75CJ9ITvVwwrJyB++vIdj4gh87NJTux5E+gCiOlQnpEqRaDrPIBSK8LwlnFH
 2mo7DTlZ0jmeaSroknm2yTlq4oeZCeUJU9AR60GZbgihcpgDOrWmEiOmG3u/IyN24cqxDY5aQUW
 JIlfV4KstqHRopG2jZKZKenof99+z4lW74u77HqRR1eZ4fgMTJlFs/0XE72kyuTs8/Kpm5WWms
X-Received: by 2002:a05:600c:3104:b0:488:ab1d:dcc5 with SMTP id
 5b1f17b1804b1-48fe651b57fmr363829845e9.27.1779305210208; 
 Wed, 20 May 2026 12:26:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6faeasm138727165e9.26.2026.05.20.12.26.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:26:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/33] target/mips: add Octeon MTM instructions
Date: Wed, 20 May 2026 21:23:32 +0200
Message-ID: <20260520192338.40036-28-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

From: James Hilliard <james.hilliard1@gmail.com>

Add the MTM0, MTM1, and MTM2 forms that load the Octeon3 multiplier
operand pair from rs/rt into MPL[x] and MPL[x+3], then clear the partial
products. For MPL0, also set MPL[1] to zero for backward compatibility
with Octeon2 VMULU.

Legacy single-source encodings have rt encoded as $zero, so the same
translator path also preserves the older Octeon behavior.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20260520172313.23777-19-philmd@linaro.org>
---
 target/mips/tcg/octeon.decode      |  7 +++++++
 target/mips/tcg/octeon_translate.c | 32 ++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
index 01ed3b50beb..5139543b153 100644
--- a/target/mips/tcg/octeon.decode
+++ b/target/mips/tcg/octeon.decode
@@ -44,6 +44,13 @@ SNE          011100 ..... ..... ..... 00000 101011 @r3
 SEQI         011100 rs:5 rt:5 imm:s10 101110 &cmpi
 SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
 
+&r2          rs rt
+@r2          ...... rs:5 rt:5 ..... ..... ...... &r2
+
+MTM0         011100 ..... ..... 00000 00000 001000 @r2
+MTM1         011100 ..... ..... 00000 00000 001100 @r2
+MTM2         011100 ..... ..... 00000 00000 001101 @r2
+
 &saa         base rt
 @saa         ...... base:5 rt:5 ................ &saa
 SAA          011100 ..... ..... 00000 00000 011000 @saa
diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
index 5392fed08a8..26b918d649a 100644
--- a/target/mips/tcg/octeon_translate.c
+++ b/target/mips/tcg/octeon_translate.c
@@ -209,3 +209,35 @@ static bool trans_ZCB(DisasContext *ctx, arg_ZCB *a)
 
     return true;
 }
+
+static void octeon_zero_partial_product_state(void)
+{
+    for (int i = 0; i < OCTEON_MULTIPLIER_REGS; i++) {
+        tcg_gen_movi_i64(oct_p[i], 0);
+    }
+}
+
+static bool trans_mtm(DisasContext *ctx, arg_r2 *a, unsigned int index)
+{
+    /*
+     * Octeon3 two-source MTM forms load lane index from rs and lane index + 3
+     * from rt.  Legacy one-source forms encode rt as $zero.
+     */
+    gen_load_gpr(oct_mpl[index], a->rs);
+    gen_load_gpr(oct_mpl[index + 3], a->rt);
+
+    /*
+     * Octeon3 clears MPL1 with a write to MPL0 so that VMULU sequences remain
+     * backward compatible with Octeon2.
+     */
+    if (index == 0) {
+        tcg_gen_movi_i64(oct_mpl[1], 0);
+    }
+
+    octeon_zero_partial_product_state();
+    return true;
+}
+
+TRANS(MTM0, trans_mtm, 0);
+TRANS(MTM1, trans_mtm, 1);
+TRANS(MTM2, trans_mtm, 2);
-- 
2.53.0


