Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F91CA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:07:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTIb-0003E1-G0; Fri, 22 Aug 2025 11:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGw-0001u7-70
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:02:02 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1upTGY-00050p-UW
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 11:01:41 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b47475cf8ecso1558572a12.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 08:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874875; x=1756479675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l2zHTZ6BcoGUiKxWVAKTw6l3A4hCrK5GgqF5hsYKgdc=;
 b=A7j4GvhCplGcL21yr5pbVeAdLmTc5Jprqb5cKkr7NkFoE6q7aEw284+thhUZg9FHUL
 aDvhfQ6EM+TEGCmzjLryff2wP+Gl44A9U7sR0KaLxZ04I4WEM9wfaJ53BMwouUezGhfa
 pkH/jVczOnWdHoU+BK8OVszUPdMvsAlAEOjDlBfvYnWo2q9/CkNgpc+Kn82f5rW7FJgT
 zwFqv1FzNJBNMU3VIBlFzRPovKxw3aFA4pYKP+wuERayxw/xMDtEP7kx0ichQRvCzn3g
 KW3jZHI3AGFMVCPpB/gF3L/iUHxlfIEApgoYYRy95ihCxmg/iYEwwegY9HSgvbvDMobt
 +d9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874875; x=1756479675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2zHTZ6BcoGUiKxWVAKTw6l3A4hCrK5GgqF5hsYKgdc=;
 b=VvIn9JnAn9sJSrNjGsS5TP3Z/GW6LVo0MTtuing1zgHjw2+KqRS0kJ4i3errqrdGR/
 M1heGD9fNNdewG2xQxrGu3SU+8OxzAVjpch3n3qrv45cto7/a6eCv0Qia3CYWDKKO+Bj
 UIStrtMHsVEUuA/1DGVY1pS1Ig+xR9aUEKifIcujFzz+qW1qVtBaxEuhXJBglYS4vk5p
 BBHlUwOr8j9oUR+xmsg1Qpppd5df5PZdF6ERnLQgotNXxvG0nfEKRq66SeDKKEHl0uoG
 lhxGF8GuDZ9QpvL6ZlgOt2O2nz05LwBKq5g2dJvprrHLuoX+0LC2SCRmVdH5A98IofJx
 4iuQ==
X-Gm-Message-State: AOJu0YxRrLFH3Xbnr8gACIjE2huUSPnF9A5EWDbPfe4ek7JNROkHrARS
 nYOs6rax47h2Ae5xVdPdaWfOb4xD25GdNCEmHaIgtf7FmAsgulWDo5CUSajyGRQHUPfl/VNS/gX
 KoKMMW1t+1A==
X-Gm-Gg: ASbGnctRTWDGD76F1oL/QFmJ2TIgaukDZHDaUh4Asl86W7qL9tVQJOiy9+qaxfnucS9
 YPUTekwSNLB0VRfbMy6s0knsE5mCws6xjT+dahTeewOD/E13YMSqRxumabeK9cI4CI5/CsKTFRy
 CY+fyBjI7/yZ1Ieaph1E6x/6rFUGsQtp4WodHSwgdU4ALJEYAY8YGaxaTtVP0mZnANnnuJrfA4a
 g1K/f8/xztTAwr2f7pKQiljnlWcO6NLBTkR3DUw+6V/qi10HEt97wIFilHT2yUJbcp6I0Om9bLa
 B0Ugi5c2pF4FCtMoWWBeXSsbKIa3yOi1dWKWmjJqYPapbnMipmIIUpDdnZeokYmffkDU8EytaWq
 pfHJpB5egbpfXwgOX/l2Yzei10hirDJXdDFFoBoBzoHo=
X-Google-Smtp-Source: AGHT+IF7q0bRwpOzZzwRXFmYsbSxbpUMKDnD/N7VrfpdmIkl8MTLY6Pl7H/TaevBXbXYHJV8Vgkeng==
X-Received: by 2002:a17:902:d592:b0:240:3f3d:fd37 with SMTP id
 d9443c01a7336-2462ee80b64mr41071155ad.27.1755874874553; 
 Fri, 22 Aug 2025 08:01:14 -0700 (PDT)
Received: from pc.taild8403c.ts.net ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-245ed5406e4sm85929495ad.165.2025.08.22.08.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 08:01:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 qemu-riscv@nongnu.org, richard.henderson@linaro.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 08/12] semihosting/arm-compat-semi: eradicate
 sizeof(target_ulong)
Date: Fri, 22 Aug 2025 08:00:54 -0700
Message-ID: <20250822150058.18692-9-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
References: <20250822150058.18692-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

No semantic change.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 semihosting/arm-compat-semi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 5877214c47d..c03096b253d 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -786,7 +786,7 @@ void do_common_semihosting(CPUState *cs)
 
     case TARGET_SYS_ELAPSED:
         elapsed = get_clock() - clock_start;
-        if (sizeof(target_ulong) == 8) {
+        if (is_64bit_semihosting(env)) {
             if (SET_ARG(0, elapsed)) {
                 goto do_fault;
             }
-- 
2.47.2


