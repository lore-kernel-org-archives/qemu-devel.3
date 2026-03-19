Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290C31091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:27:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MkT-0000et-2A; Thu, 19 Mar 2026 19:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkP-0000d7-FW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:49 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w3MkN-0007cI-Vn
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:25:49 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso12355995ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773962746; x=1774567546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bk82OHFtjEe8wWg85HAeHQIn5dp8uY1iPeCPq+1CvlM=;
 b=BDnMr2e1FNpt9IFW3E5u7kfl+igE6pies/po7XH1Ttt3qrEP0SHhr611duRA8ezXl0
 ZHzQyTgP8dUaf6qi9D//Ju4EY5zY99HqcmORn/yZGN89xWzC5E1NN+FKVnWcivxr//Gr
 MiRChQs1g2MPMQ4kUXfZ5gBg3i0NCrUc8stgOqE8yDZVUFCDcestucqKMf88ySUh2tND
 BVTfZpB+z/0nwRsVUx6rH+w2uwbVF8iqokyiQWMDKZzqPY0Wuex6Zrx9V+QHCpgt8Htx
 JueexNzHh/vVaXm24F9/SN3VwrVgk06aCLNKhpGNwtCeRbUmwahjGu2k91Tm4iBBJLMt
 VIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773962746; x=1774567546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bk82OHFtjEe8wWg85HAeHQIn5dp8uY1iPeCPq+1CvlM=;
 b=Qo7ekN6flDVFoExxlcA4669CBo8HGfY1FreMM5ifp5h/k7c53Po2p7SOi/j/ChXJwU
 JAZq6vBid2BtdAtAcJ5SMFKYFPWkilGoQ7iObc+rDbBXFowV9ly4raz7+B285d3a4N1A
 GWF/zKcPBMu9o5WKJVJ0braX+kd53fZGkDqEx5vzXv6dQFzgrX7L+HH1HxDMkzBw8MrQ
 g8P9H9mrr/3JhQEqBcU2WvTz+ixZ4t6LwUg48LB2wv/e7mEpsum3GyCVJqRlZsJyb3xT
 0KcZ+gvBjcNvZTDuHadCXVQrwAZmbDvcNGvWrBRuQkWYCcV6LuoFVO4zF/S4PlxmcPMM
 LKXQ==
X-Gm-Message-State: AOJu0YwNegrJwWrABlVjf5olrJZRhiS58qtqYlNV7NWjqpy5Nfpfc+L6
 cRTXWcyoupyzty0LFfa5Hlg9L5Bp/9j6bsthmCniCPHLwRib0jh21BXEyN01ow==
X-Gm-Gg: ATEYQzykJolqg+iDLDo+k1wtEOhNhqQlXViDlxcrXUyXo4EIQT0L0k0rLt4czyxTouY
 rmg4lj6kNPLulSu0Rjapt7ENh0NyNigHHv8wYaZQdu8ltlD6qRueXmRn69VUE/RKK5vdtAWOXp9
 Sh+KYwzVovrlCCsXe1ZLHhhZAoHDLiUUwnqUHwPU3rG/V9e/ik8V35SLgX3LsdUiYxG1W+GblO1
 bQ2+rj36hwcSowdWAaQBu8PiLz5iGPSAhxjrCy6KYROr7mTf09ee37ARUodz1DjslNgtyZJ9cQD
 XBad6sBLJ6jZbxR/Mmz1eq/VfoZx1JhGAkYXGGC6YFf0Rgp3kvzmY4izy8I480XXERrfkYr38mP
 T/TMCQNpK+SFoYAYmpp7aOiX8rWcBRuV0pOV9HtybUrfkKNVoHtOSeZq2ACqri9al9xn3YHLaL5
 iZ3wKmyP/vrQSvw47b6H2j23iD0ne7rAzuRyc7ra1Rdw==
X-Received: by 2002:a17:902:e5ce:b0:2b0:6365:217e with SMTP id
 d9443c01a7336-2b0827bd213mr7014975ad.15.1773962745930; 
 Thu, 19 Mar 2026 16:25:45 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083516ae1sm2979165ad.13.2026.03.19.16.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:25:45 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/17] MAINTAINERS: update my email
Date: Fri, 20 Mar 2026 09:25:08 +1000
Message-ID: <20260319232522.1867400-4-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319232522.1867400-1-alistair.francis@wdc.com>
References: <20260319232522.1867400-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Also add myself as a "RISC-V TCG target" reviewer.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251217191726.194767-1-daniel.barboza@oss.qualcomm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97f2759138..62fb18d125 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -341,7 +341,7 @@ RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <alistair.francis@wdc.com>
 R: Weiwei Li <liwei1518@gmail.com>
-R: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 R: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
 L: qemu-riscv@nongnu.org
 S: Supported
@@ -4134,6 +4134,7 @@ F: tcg/ppc64/
 RISC-V TCG target
 M: Palmer Dabbelt <palmer@dabbelt.com>
 M: Alistair Francis <Alistair.Francis@wdc.com>
+R: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
 L: qemu-riscv@nongnu.org
 S: Maintained
 F: tcg/riscv64/
-- 
2.53.0


