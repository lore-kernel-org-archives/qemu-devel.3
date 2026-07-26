Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D3C531CC
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 06:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnsfJ-0006tn-Uo; Sun, 26 Jul 2026 02:48:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1wnqop-00064b-UJ
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 00:50:32 -0400
Received: from mail-qk1-x72c.google.com ([2607:f8b0:4864:20::72c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tripprobins@gmail.com>)
 id 1wnqoo-0001of-Ec
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 00:50:31 -0400
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-92e533aacf2so88006385a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 21:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785041429; x=1785646229; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MCR9rqx+DA5+S1U5xN9tVj6ZdwR/9XiG2O1a1CRj1wo=;
 b=OZj2AgNPgG/OekxmlBl/lY27bSIUOC+UmT8LDvMThFOkurUFYS9rDtPhOh/Bjl3Ayf
 WpEv80FSDIp0vHszIgyEMeAYOq5h6NVfXUGhya9Egg0NeQ5x5HzWH6uWkWAcO5HFSq+q
 bAmMQdhuAGi9neD7HJuUDlo3U9MGkIbGrX3g8NhE0pUhf3b6UtiMMkbC+N/slrE1ynCp
 B7K6xyH1dYWv4aeuwvzyX234oLvBXc0CtJkEU8Mreh3VoLsbMEU+//LjWE/lcaJo431k
 js6rIAs6K1jgKPACrVnurFDzX4xMwlQXqWSDITjDLSpw262OUSFtxamHad/W7JkVmw4G
 0pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785041429; x=1785646229;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MCR9rqx+DA5+S1U5xN9tVj6ZdwR/9XiG2O1a1CRj1wo=;
 b=OCpM4Az9yv0Zbrl0CbMPF9fiAqlTLdfS/xuBDDOnjmmBZUBzNW0rgrJjB1Lv6vPjg7
 pocw8Jw4uUxIXQN2PVTEQbsiN0VBRKYeh+GH46Dy6L0fiBWHmlolUcEBl2hk2Bhv8c9j
 h3TnBuCAbfT2hb4WgCm7N8yLPWza3VswpENerNYXADZO6vHaKqcbpWXHR/tVCqLJl8L4
 SbdrTe7hd9BOWiLiRI9kaoGpk7mgCM6dGNkR2ueiFJqkvV7o9SUWhjsTq8I0HZGBlnRx
 C5z6f2ietx3wn9j2ZIAUfplBffb61fOShyyZk2FhDfeelpYWFY12VhgrRExTXY9MJtGb
 cvEg==
X-Gm-Message-State: AOJu0YznmRrGbErX2eWq0SBrHWZzYPu6nCBk0ygCW1CI0qidkd5nA3T5
 KiPWu47dHTXyvX2HQv4BD3EWhOmgmxUDcBe8icbGVFt64bLLPRnoyPZ2
X-Gm-Gg: AR+sD12srh6VeJTouSdI7ma09YV/f/9d8o4V5i4Hpa2FDiKdss1ixkFMTJ6iLjYV25N
 7xPvQ7rZZKGEYEtm8Lvmco+Hf08nhB0+DZMoaQ6iWKhfmfqT90+sne/LPuoDOu/ip4rwWvMd33v
 zg7v4NZSbBcKOyfE4qo0bggI+tC82FAJgf/rO353CZMNdx9OKa6krIlDMmN2Bl87UhbKKcI2UV9
 ClDwZnM6eigDV0NcLzLFWPlFk+4p4/ecGN4DhNExf1MmTDdFrVQDw1qRThQQJ8AUl/BZ2xVKcFH
 5pkmxrXKpHVMZBEzO02SypFw/DWXVmt7MB3nplH9tK0ZMpMVkmzNDNQ2P/xWVuSMzrpBHBs3bhc
 00Ut3wMhNtfRE6RmaB4EkC7VK9KvHkU89VlUVAOrE0IMtzSWfOIg/l8qiFrysnqEPXToQBE+oDR
 4eQ/dfhYU=
X-Received: by 2002:a05:620a:450f:b0:92b:67e6:8ac7 with SMTP id
 af79cd13be357-932df7169bamr405219785a.65.1785041428967; 
 Sat, 25 Jul 2026 21:50:28 -0700 (PDT)
Received: from [127.0.1.1] ([2600:4040:5aa1:a000:518c:a25b:44d3:2a05])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-932de66ae46sm289853585a.40.2026.07.25.21.50.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 21:50:28 -0700 (PDT)
From: Tripp R <tripprobins@gmail.com>
Date: Sun, 26 Jul 2026 00:48:12 -0400
Subject: [PATCH] clarify address type in 'xb' cmd
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-xbhmpcmd-v1-1-45d79d0f28b4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIuRZWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMz3YqkjNyC5NwU3VSLZAsjIwvzRANjUyWg8oKi1LTMCrBR0bG1tQB
 LjGwjWgAAAA==
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Tripp R <tripprobins@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785041427; l=1113;
 i=tripprobins@gmail.com; h=from:subject:message-id;
 bh=NkSDZQxL4cR5i8rPLB0sxyfP8xpY/oAREp7aCXYfGzM=;
 b=8uB2OM/KHi6XZMR4B3bzdv1Q8rsiPQ93kkZXxqEep1hO1Vd2sEzI66WuARtYFuNyXnMwCG8CP
 74neP7ekouHDZeFj16eoTiu4iwIYlVhoQttFbVoAa3kqpoQYP/yD5RM
X-Developer-Key: i=tripprobins@gmail.com; a=ed25519;
 pk=qwr69xU8AQT+ZZ9TxMEd/Vlg8k8ovtJrkXWQKAiMMNw=
Received-SPF: pass client-ip=2607:f8b0:4864:20::72c;
 envelope-from=tripprobins@gmail.com; helo=mail-qk1-x72c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 26 Jul 2026 02:48:46 -0400
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



---
Implemented the xb (examine block) command to print the contents of a block     device to the console.
  
It is effectively a clone of the x/xp commands (examine memory / examine        physical memory), having the same arguments for those commands, albeit preceded by the name of a block driver. 

e.g. usage
	 xd floppy0 /510c 0

Signed-off-by: Tripp R <tripprobins@gmail.com>
---
 hmp-commands.hx | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index db63b58a47..26b7cadcf2 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -481,7 +481,7 @@ ERST
         .name       = "xb",
         .args_type  = "device:s, fmt:/,addr:l",
         .params     = "device /fmt addr",
-        .help       = "block memory dump starting at 'addr'",
+        .help       = "block memory dump starting at 'addr', in units of bytes.",
         .cmd        = hmp_block_dump,
     },
 

---
base-commit: bcc42fe49f7aae8982604900e307d783615bc79c
change-id: 20260726-xbhmpcmd-e8c82287a035

Best regards,
-- 
Tripp R <tripprobins@gmail.com>


