Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FE9E7FDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn2Lu-0008Bw-9u; Mon, 02 Feb 2026 17:25:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2Lr-0008Af-OL
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vn2Lq-0005in-0Y
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 17:24:59 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso41601745e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 14:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770071096; x=1770675896; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZgFsj41R73USHfnfxx9xHJU0fzw4Fgplcv6IOSKNfw=;
 b=pEhSDHraZuPV4N4cpIzVPCVpVoMaCsY8xHiwKgORCnCpxehDD7BSDIaQtU9CgUor7c
 RngIHjkj1RV1O7CK+SqoNyyeYGP/HOJN7i62h5WglFnXKxr0YLigdFpDg5MFPqdWKcGL
 1TZqXiEwNBnQ4yskIf4OmH2HU8Lw1sAMYwsGcA6oroAlufaekpbKNMEDLcTe3iY7i+SX
 bXb+eDsx++vn3sGAT1K0HWfRqbvyCl2qX2V+mFXCe8AZyi4ajycOV58s3sICuMbRmWpX
 N//tA880fqR8wFI5Ihx/3FLZPNd0sfrRPcBlSB/WGSj5lvf+iiBWNJjmS127vggzwHIi
 1ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770071096; x=1770675896;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ZgFsj41R73USHfnfxx9xHJU0fzw4Fgplcv6IOSKNfw=;
 b=dFFiWERFHChBODQBcZDfQ/x1HGQIVJ5LQCts+6Ug9c9QTfB5QnBWOlsHv64xGYjrD8
 aOl+J5ABOK6xuVSu8TXLWUSshmW8xHohrS/bAvXzp0IuYDVaWq7AzGuLXFUDhnKAbtCS
 h6J1WpP20/8t13j5E0TSg32+67bAxwPE0zsoR2YWgS8FXah+8nVqEzV+160ahNGAB8+s
 +DApdh4y4Ukz15Dy9jtXHfDWOQRguERZdPqaHfmBBcKS7nIl/XEU9Ey5HwCMQqaZb5HT
 KWNZXLqYDZj9ntgMe7r8KHKPmZdR5O8RX62AKbU26xecwpn67v7yC+zA7x8EKXZQ/wBr
 JxIA==
X-Gm-Message-State: AOJu0Yyx65QdL2d1bQ659YPndIrUFr1baFm3CfxJITny9eZ+wcBrJYxa
 ExyzDoZHa/NLcGQgvyVCl4Bh/l5iUdWFWK/TNJI7fl3cJXkAhUis5K7VhkzuCbgppBr5I6PoBab
 pMEMHa8eSOg==
X-Gm-Gg: AZuq6aJTJXNkPBKTe098v5D4VG0cutz+K5cP4Sd9XlLQhxQDwnuBSv3/gZlwhBtFGg4
 d0PxNsk6OsxeE7IzO2bV0Wf+cPh7t4PMGFzIdOzuJjz/o+V5nVC+oSL3hySNoEDywvrTalcBit/
 okV7eMQawHe2lLUBD+s5noF1vw3fwTrHF/J00dN0N+m7pliwbPcXMmKoIHqUwwxqZAQUh+YWyV6
 5rvjlcItN3kHeOnm1p4CqPh3Z1+dNiKhcQYHvgw3IUsSTolFBv6ONQyMBHXLYALJcx/1DJwXO8z
 Hvd6H83tu9+L+IRL2rLYprVZbBhivqWlH7uVYsDlmR9lyY2PJC7V6ZWklbTdjf1cYgh4wujbnUh
 nOQEwOrpDFzW0d7grnvdD3XN3F+n9OmdVDxCRs6tOtt90LXfM6sGC+3BkcDPX+u4OYJk+EbmXN9
 GJNMp7ohnODgxlZc8rrBJlvVk3qiR/CtyLOtZTykGLNXYvgqkx5taQHcs0ZeB3ozHvp51Qnnw=
X-Received: by 2002:a05:600c:818f:b0:47b:deb9:f8a with SMTP id
 5b1f17b1804b1-482db491bfbmr174416925e9.30.1770071095951; 
 Mon, 02 Feb 2026 14:24:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482dbcf9684sm119990765e9.5.2026.02.02.14.24.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Feb 2026 14:24:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/7] disas: Make disassemble_info::target_info field const
Date: Mon,  2 Feb 2026 23:24:11 +0100
Message-ID: <20260202222412.24923-7-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202222412.24923-1-philmd@linaro.org>
References: <20260202222412.24923-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x343.google.com
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

Disassemblers shouldn't need writeable context, so make the
disassemble_info::target_info field const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/disas/dis-asm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/disas/dis-asm.h b/include/disas/dis-asm.h
index 3b50ecfb540..911352703ea 100644
--- a/include/disas/dis-asm.h
+++ b/include/disas/dis-asm.h
@@ -397,7 +397,7 @@ typedef struct disassemble_info {
   bool show_opcodes;
 
   /* Field intended to be used by targets in any way they deem suitable.  */
-  void *target_info;
+  const void *target_info;
 
   /* Options for Capstone disassembly.  */
   int cap_arch;
-- 
2.52.0


