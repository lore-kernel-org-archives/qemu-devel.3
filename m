Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2265D4660D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVf-00019b-TX; Thu, 15 Jan 2026 13:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV7-0000dQ-05
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSV4-0005t4-7w
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:19 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43277900fb4so1099657f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503316; x=1769108116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Tw/4WFwwimCPloBHy1pZS+5uugfLv7VltlAhw1gKOiY=;
 b=mVjq/mMzZzKnL+gCHJhAOzMZI72QjEJT/6kBm8uAtxa2A5zhcExr1xHWfJcnsc882A
 rqzhpmIMWUSEviBJVk041t6X75HP1emOqSGp3lVi53i12fe9T4B19yfIN3Qm2SvGhx41
 M5MG8vG948SArPRyuPgIj7kaLmWQht1tNWEK5uWYqtJGshAqDsOFu6xbFc1VKGU2CCqQ
 OI/XKSFs0/T39bQV8jFmwgsvKCzGsd3EWyCgBj1DFXNVn5B/1gM4CklMvJvCLhIFyUtS
 HUoL1VJMpr4eOx1dJeFyz7r3Ysmfx/I2DFvYCGUeZj9HXM3IRVxvOtR9zzL0xqAQsHD/
 SvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503316; x=1769108116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tw/4WFwwimCPloBHy1pZS+5uugfLv7VltlAhw1gKOiY=;
 b=LO/un/x9RVgfQCKhH/jUKLiDLwlbSfflvM+uzcbmHrEBmeULTuLuhUoP9o8WWYEKVi
 droEX3XbHFvlAcad3lH+upY4pqJcHqRwRbPj158itFpZ0ia3dvZzJR0hSy6jtE18KxMV
 mxZtODRGU1hP+C7Wzwm1noQuifo/ffI6bJx7YCYXV/L85FhVhkWv+xQTnlu6tlNbLjrz
 owpai98PCH7BlmcYW/P17jy/b4jlDpEbL98x59Ofe8/LJPtkEOMkFu0lXQFahDOpe4av
 O7Z0RarIB4XcGeeKRKrt/vAYIg11KAQ808y3G81ymuTZCYw7AKrEkMZ/E/NC2Ly027PF
 Xxyg==
X-Gm-Message-State: AOJu0Yx2nePmPQi2VqIAMMMfGpxgByEb3P/w2Rh7yYOwsHt+hfSjvPmX
 Kyq3CZhGn3GsGXLE3EM2Ipo55rGowHrXlM2kHoLOBjj4IT5LV6WEt7/5N3/YVtLCaT0kQPBh/5s
 uDAoQ
X-Gm-Gg: AY/fxX7YzALggbHEjPGcK8DKsGztDNsYujC+60R7B3wRYDgApVP9Wr1PVrmlZnKWgUJ
 p/EZIm3yhqI16uKG9Kncoo7hHPzCPeYj06y2/Fzl+nBW0RknkfplYW2s2SWjioASSxFgvHSkVyM
 RmEB8yEO0JS6lSRh9qf/obp1wTyx211zSFOlwiefVnn86t/7jri6CIIp18uAuqg1xYsSX/VjdSa
 ZMRR3cJuc1CUBnstRRujfWU+2pJC9BgAz7Qq9fiw+nrrnEmkBKXbufRe4qpUxXVtnzu7j8dZp7r
 Rmu+2KPlDHV/98fuW6BRd1YatAYixbVHOYvxaL/Ta1ZkdWR3pVP7UWceLS7DKC20G6kIqHTfBL3
 az7iETaTrHfSekR6Ju7H2DkvP3rxi3IdAH9kMODXNuO8MwPDJ0t3Qz/QXbu3nz3k3kUWGz3sVSD
 LWzyPTSsW32CxbzMGpw76p/7N6h53qjyQpJHdjtUPV0Yee3tUAVrgy5InD3xvv7j/XSIIE/gs1T
 nLWksXeyH0T87vrvnDsqpKgrzzBeXWp4kUv1yL5GqOkynsoevf24kiZ
X-Received: by 2002:a5d:5f51:0:b0:430:fd0e:a502 with SMTP id
 ffacd0b85a97d-434df0ed345mr5126340f8f.22.1768503316040; 
 Thu, 15 Jan 2026 10:55:16 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:15 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/25] hw/arm: Re-enable the MAX78000FTHR machine in
 qemu-system-arm/aarch64
Date: Thu, 15 Jan 2026 18:54:49 +0000
Message-ID: <20260115185508.786428-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Unfortunately while rebasing the series registering the
ARM/Aarch64 machine interfaces and getting it merged as
commit 38c5ab40031 ("hw/arm: Filter machine types for
qemu-system-arm/aarch64 binaries") we missed the recent
addition of the MAX78000FTHR machine in commit 51eb283dd0e.
Correct that.

The effect is that the machine was accidentally disabled.

Cc: qemu-stable@nongnu.org
Reported-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Tested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251218214306.63667-1-philmd@linaro.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3248
Fixes: 38c5ab40031 ("hw/arm: Filter machine types for single binary")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/max78000fthr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index ed50bb9197..530ca9dd96 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -12,6 +12,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
+#include "hw/arm/machines-qom.h"
 #include "hw/arm/max78000_soc.h"
 #include "hw/arm/boot.h"
 
@@ -47,4 +48,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init)
+DEFINE_MACHINE_ARM("max78000fthr", max78000_machine_init)
-- 
2.47.3


