Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65625CED63D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 19:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQy7-00019i-Oa; Tue, 18 Nov 2025 14:02:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy4-00013T-Ev
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQy0-000648-0f
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 14:02:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso41154235e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 11:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763492525; x=1764097325; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+qt8vwVa1HZgU3pdePfudr37pK0aeUekWhl0ULV6H2k=;
 b=oQcndevZam6h3O8c4XqxYl7suZlVmIsOO8tQ29dt/VHB2kygr4Q5PrNs5D6N1IJ+jF
 POAVeZmO8WGkPCrTQNa2QpaeqRtHx7eQD4RukmQMKMoOrfLbHYnNsC5Cw5QxK7Rwx9M5
 0V9nm2w9eF28DfAHqA46FWt9qv2sbWktIwIYu4huuVkbFvd061jPZZuePfFflOjezW7K
 JYzIY+6jMKF89ueKtpmMQh0ZSw8DA3kAES7LEMHVr1PJZDBmMb9HJIcFMs0XomDURd8U
 sN0pxq45R+hwggKFGEqUYjo8xvq2KnWySbhPSAel0WmNHaKRXix8pdvubqvtJvTf+e6I
 GzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763492525; x=1764097325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+qt8vwVa1HZgU3pdePfudr37pK0aeUekWhl0ULV6H2k=;
 b=is0AqQYHbM8tDnOC1qGHeM1seGRQVTidIn48z3TZ2NMn+Du8yBFqGVKbT/tkAqlSKl
 3ZFnkO5TtgQTWTkYnAJ6Rf69Q9XnyT15zJ1nQgX44NGCnBA7Hqqrkd2EgBahkUzJ11oc
 NI5NAZLAMqgUn25Lv+BkieQxPUpvj6sBvVsAyt/Z/3zsi8bcewoO5Lko1llkmfWwNhDt
 QJhbFhy06Xvaid0DMjwTeSR5/1vuhkVdySTxCcOmNXtR5rC37RKjnmH700yBh3ifcIJr
 7wFk3bk+xo+AEXjO1CR2KOsTIvwe1mUL5z5XiLu9YpX27ULXUODSgMboO2WM5IdiXVvy
 XGHg==
X-Gm-Message-State: AOJu0YwpE6dQYisRy52F1NqfunycpARKyLXX1rUU0IITTfCVblO+dRul
 BvH2cX3t/0rt5ulwo6Nup9Id7Rz3YTLqJb7cOOnHRsa3u1MWqvt9DNiv8So6vio76ReLpDykP3T
 /SO9mpouzaw==
X-Gm-Gg: ASbGncvp8oQyUZo1bLKvegTc9g2/XQQOHel5qKtaVKsT2z9Lwhwmqra7MTXGVsgWGV5
 tDx+NlfVZIAWBlCsgtO8wRMtIpkoVfWdLezks65N2FfPQrzkHPYQZs8Jk0onUHmGgwIQTJkjpzP
 FyAxf7SCjZQFXWcMFwVZ8ZFHLHa/jeuM0deKOLrsRvg7m43VXnyemyLfHKW7tLcJaOYySl62wEE
 vTAOBM/FQMvj0eXs4hp3Z6Hla0dDwI0FEI3Hq1PeihJZg4AHzBDxbYu2+Eqv3foZ1vf+CQZ9L7s
 ouRdaFeyvdo+oj54rthDyKnj0S8Nz8sd3RUlJiEjpS60zoSknogDYHifBZnisaKDR5QceHyIUKL
 V8uxRv+81QPbFFYIAfSsyyEP2HfLqOAlQw3ei3wVYTiLbgYBwci+kfC+mKu/5oEnKUk41D2cRAh
 MqSOSGSD/4dk79IocdZx+OZGbstAq29W2eND5tzxbw8OFI6ZVV1GwkaYFX740o8/k4EbucKkY=
X-Google-Smtp-Source: AGHT+IEaq365Tu8QIb33dokgmONZs2Px9DMjMP4er9cLNKpsYcyhpmBiolKNGRzkDkSt7fEv4UR8Wg==
X-Received: by 2002:a05:600c:45d4:b0:477:df7:b020 with SMTP id
 5b1f17b1804b1-4778fe7f6d4mr169725905e9.18.1763492524783; 
 Tue, 18 Nov 2025 11:02:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53f19664sm34722822f8f.36.2025.11.18.11.02.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 18 Nov 2025 11:02:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/18] qga/commands: Include proper Solaris header for
 getloadavg()
Date: Tue, 18 Nov 2025 20:00:44 +0100
Message-ID: <20251118190053.39015-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118190053.39015-1-philmd@linaro.org>
References: <20251118190053.39015-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Solaris declares getloadavg() in <sys/loadavg.h>:

    getloadavg(3C)       Standard C Library Functions       getloadavg(3C)

    NAME
           getloadavg - get system load averages

    SYNOPSIS
           #include <sys/loadavg.h>

           int getloadavg(double loadavg[], int nelem);

    [...]

    Oracle Solaris 11.4           23 Jul 2020               getloadavg(3C)

Include it in order to avoid:

  ../qga/commands-posix.c: In function 'qmp_guest_get_load':
  ../qga/commands-posix.c:1408:9: error: implicit declaration of function 'getloadavg' [-Wimplicit-function-declaration]
   1408 |     if (getloadavg(loadavg, G_N_ELEMENTS(loadavg)) < 0) {
      |         ^~~~~~~~~~
  ../qga/commands-posix.c:1408:9: warning: nested extern declaration of 'getloadavg' [-Wnested-externs]

../configure relevant output:

  C compiler for the host machine: gcc (gcc 14.2.0 "gcc (GCC) 14.2.0")
  C linker for the host machine: gcc ld.solaris 5.11-1.3315

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251117203834.83713-2-philmd@linaro.org>
---
 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index c7059857e44..66f3e6f6733 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -43,6 +43,9 @@
 #include <net/ethernet.h>
 #endif
 #ifdef CONFIG_SOLARIS
+#ifdef CONFIG_GETLOADAVG
+#include <sys/loadavg.h>
+#endif
 #include <sys/sockio.h>
 #endif
 #endif
-- 
2.51.0


