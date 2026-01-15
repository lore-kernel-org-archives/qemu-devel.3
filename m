Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB59AD46621
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 20:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgTmv-0002iK-Ln; Thu, 15 Jan 2026 15:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgTmb-0002hU-3L
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:17:29 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgTmX-0005Z7-VD
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 15:17:28 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-bc29d64b39dso454846a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 12:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768508244; x=1769113044; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UQZwIKAYZC4LW5zF1gWIMFUQiSDcTZ+f3FblLwjd6Us=;
 b=SnydGFmvg4WJnyid9TWAzg06i1FL1Ea50BN721orMQTK95xYFkgJl/1gqOeEQRYe63
 pyEfIOEoCZZaNFCq4zHfLnzq4zrq8xswgbuKGuIosukzBHkqQy5s4D2KvIJEPpjg3fMJ
 uDuYA1tbvI2fE2jMtc56DZiMr0jjeLKRhrvfuD+HiGks+tDerXZ7sE4f+Bh5YvuiXi7R
 YNVD9tv02PUzpaUHneLeoHMGepSnRyjufNbmp0e46LGdN/bOTVO8tG8MS+3QefqF8JuQ
 Wdf7C0kOWEVy8IPuplVdSMskX5hOJTAot1FL41W/B78bFM5/6OwNthO2v9DLe7MnwdmQ
 DG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768508244; x=1769113044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UQZwIKAYZC4LW5zF1gWIMFUQiSDcTZ+f3FblLwjd6Us=;
 b=fCt4HIqd+XufEF3SWNnADUjAxBdOB3lyfF1qloHI3Gl4QxkXtnGKXA22M6DyPn67g5
 QtaDtZoEIhTh1bqQsZHKl0nI6AS3oCz52GvnuFdeHLBdGZcYMtS8JHEFnxc4yPcnW1b9
 hx/VfBhHIf6+huPhrMWNFI3HpPdEk/auzKZWTbgyJisJZz+yrbXWPCvg8tekXKqzBBcC
 tOFenKoI6pf6DZayAKL35TKPACdv4CkgZkdgprm1ASqrzQ+Ojh9ElVDwQHzNYrlj07Lt
 FZsz5Fo5WAW7deH+hUtSq0EGG1mvVaIBro2UcWgPBsfi0iNbEVq7he8NVzVNwpospy+u
 CuQQ==
X-Gm-Message-State: AOJu0YzApg3kPFxQi9w9N7RAInbtFK2KUXytXvsyozrjChhqAMqOX5ls
 d6Fi63s+zA0mPdwNTkhTsZr/e9A/LlAluuidBAVTTIupDjSjk/0mzaYTqXbJTdkdl2a+/0FuPn2
 r/vXv
X-Gm-Gg: AY/fxX7d/9dskwBmofbaR5QmOLooj/NfsYrKhG4RRYZhPiHp3goF0kGAWnPEmMqqkVM
 HJ827ibjIA8uMF+exJ/EnDPfIo3Qbt8/ezQMTCwFOL+DEa1qh8cnuHvbBlOJZ6MlyDlvBoB1s7X
 eK6mSbXrirWHJNhuulaUfQajfchPNHF1ADENNZb0edfm+Qv81w4JTRONgZoSgRXEk9vclSUxQjO
 wTz9UrQsJUj8P3NY/Ixtm/Xxwkblbig9jQsz9+rbJ9eONwmn+BDU7lchHlnPJOS9UWnwu73kBoO
 mBjT2zT9YLk+uN0tBDgXOGdooC5IBknGtY/1NMTZJ2RjtbsUN9Wp1e8UqQTJnl86WGbmOkwsfOy
 QXaRScZzDFbCsFHAUnBozobNTPv4HoEoHoEZIZY3MANdS6hTK/M/kVdDsSGRj4GJrxscPEbY53+
 5w8Sg0tEUN2PIb1J6yiXUAWvxFC8cB1M7kk//e2lHZvIS4YvmZk6ZYfs3fhNe3Xzbm
X-Received: by 2002:a17:90b:4d11:b0:340:bb56:79de with SMTP id
 98e67ed59e1d1-35273275054mr423592a91.30.1768508243948; 
 Thu, 15 Jan 2026 12:17:23 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35274225d45sm20303a91.5.2026.01.15.12.17.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 12:17:23 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Phil=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] MAINTAINERS: add reviewer for linux-user
Date: Thu, 15 Jan 2026 12:17:12 -0800
Message-ID: <20260115201712.2706663-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

I had interest in this area for some time, and would like to help
reviewing it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ddbfba9f01..4ef0c10f63a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4021,6 +4021,7 @@ T: git https://github.com/qemu-bsd-user/qemu-bsd-user bsd-user-rebase-3.1
 
 Linux user
 M: Laurent Vivier <laurent@vivier.eu>
+R: Pierrick Bouvier <pierrick.bouvier@linaro.org>
 S: Maintained
 F: linux-user/
 F: configs/targets/*linux-user.mak
-- 
2.47.3


