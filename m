Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9AA109C029
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5PzM-0004aE-Nu; Wed, 25 Mar 2026 11:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzK-0004Xo-IL
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5PzI-0007ps-Vp
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:17:42 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4852afd42ceso19662095e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451859; x=1775056659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hy+9vnQWvKgE9rUbjn7FvRJO+e6ousybrt19G3s47M0=;
 b=LDAQme2VOHwjgebU1CL+uUAQie8G7/E14yoKWgYYb8pAXK8FQ/lBEryvWwTiEmEn9+
 donmSHqQgbSpr0HxVfSZKz7UHU9tmSR9mnVhlLw5Rds9O8EgFwSb1qhzGOJc8NDSXfFr
 H6wu+7froYJTnc4q+HJvfZBavc/kfGAj1CY4p3vVKX9iK6Kt4G4vaVREZCxOzLqtQJWW
 kxDQ/EN1NUmnmudW3/UnCHd6GVbilo9ijAyZaFt27sDTcd5YQLeYv7uXTeoUnsrsk406
 Z60szEM0LG2iRDTG561uKXbQQqoBmuYfbapMfEIikSMAprNcFiW9HA3QCFn2qCJREUI7
 QQcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451859; x=1775056659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hy+9vnQWvKgE9rUbjn7FvRJO+e6ousybrt19G3s47M0=;
 b=nWl5p+PDBFSMsTrarOq+RwaDt+bS2Ye6rAjl0wdX1RhAYaESh/JgxllqFo7t7uUMcV
 7turGsJplaYZmy3EbKvRNXy8xVFgV+l0spbTgMLbJoRucPsrtr+NqLIu8J2PXOm6uBtT
 ytnYgnY8VYXh6qDBcF7nwpcaAoK8a0EhnB9tTbF9mXLovKI9Jsw23lL7fEkdJ0/FomyJ
 clwCiVECDraeOtQgbqKsJ8UjkgtyLF3EAe7SxfjIwgVJTV25hik0HYAkRMdcN1HcPMBo
 bF7LV3ELVTCE4844UzXu3LrHDsJmiwdSFg2AA/JEY7Xs9J4fL7iVYlQF7QLzg8a86xcs
 LlSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjImZPD1ufcYTaa/l9C9SKHNen3kf3ILM9QY83iucUTulvCihhvTkZQ71LCDiNhU1farlBVPCcacSe@nongnu.org
X-Gm-Message-State: AOJu0Yy9jA1n0tTZlPRzRW9WNxn34lSge/8XDBUI9rpeX862TOJayQam
 IXEKEm0UA28+PuUPk0jTHz22VVFj8IDT4rPmtqdgF248Z2eUe00nvMV7UawvXXWxn7k=
X-Gm-Gg: ATEYQzyepcFDc1F9N834rDLE/T1F9/N6/tTtXRJyEzHpAV845WhTTSFiX08R8oDM5B8
 hhV7/tz8DlIBcLRjkllTi4WxePxCRp4yfeSFNYReIv4Z4NVdRosUZ7dVZg/kiO5D+QuJ0G0LyjW
 QtDmo2QHIgLPyS80aZkMXqs9C4/PBJdrkC0f/O1I/nGZ9r9dvxZkBbtJx2SavEpIzWiZzNFlz4s
 RgKhkCIBl3aPpdWU6DuNXUcC27hJ8vtH6k2jhUC5dJCvY8Flp0sDkNxnJLGd3EADfZAmFzcw5H8
 Z3+hvS5xqw0BVslgt9OewjUPTYA/aRKUXUehYVrzbGVMtHQ6BCpFsW4Z+GnIOWrLakqEF+pcaAw
 U99pKMYZwKFyxmUspSFx3eYqqWAdg3Wlp7Q1DT36MKj36TCA6x5KuIQZXaL4nQwM9Jgp9Idftsc
 fr8zecUW9YuydZvMTwxxNQ5vzjz0REe+W59/TtrCdhvPbG2A2uQZsgC5YqZlfqSSLX+eI9wOs3
X-Received: by 2002:a05:600c:8b2a:b0:485:379b:57bb with SMTP id
 5b1f17b1804b1-48715fc3793mr56408115e9.3.1774451859292; 
 Wed, 25 Mar 2026 08:17:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871738c16dsm22045995e9.30.2026.03.25.08.17.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 25 Mar 2026 08:17:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Michael Tokarev <mjt@tls.msk.ru>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 kvm@vger.kernel.org
Subject: [PATCH-for-11.0? 1/6] MAINTAINERS: Separate QDev section from QOM one
Date: Wed, 25 Mar 2026 16:17:23 +0100
Message-ID: <20260325151728.45378-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325151728.45378-1-philmd@linaro.org>
References: <20260325151728.45378-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

QDev is about QEMU devices model API, while
QOM is about QEMU object model in plain C.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba144506..64466cf4082 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3546,24 +3546,29 @@ M: Paolo Bonzini <pbonzini@redhat.com>
 R: Daniel P. Berrange <berrange@redhat.com>
 S: Supported
 F: docs/devel/qom.rst
+F: include/qom/
+F: qapi/qom.json
+F: scripts/coccinelle/qom-parent-type.cocci
+F: scripts/qom-cast-macro-clean-cocci-gen.py
+F: qom/
+F: tests/unit/check-qom-interface.c
+F: tests/unit/check-qom-proplist.c
+F: tests/qtest/qom-test.c
+
+QDev
+M: Paolo Bonzini <pbonzini@redhat.com>
+R: Daniel P. Berrange <berrange@redhat.com>
+S: Supported
 F: docs/qdev-device-use.txt
 F: hw/core/qdev*
 F: hw/core/bus.c
 F: hw/core/sysbus.c
 F: include/hw/qdev*
 F: include/monitor/qdev.h
-F: include/qom/
-F: qapi/qom.json
 F: qapi/qdev.json
-F: scripts/coccinelle/qom-parent-type.cocci
-F: scripts/qom-cast-macro-clean-cocci-gen.py
 F: system/qdev-monitor.c
 F: stubs/qdev.c
-F: qom/
-F: tests/unit/check-qom-interface.c
-F: tests/unit/check-qom-proplist.c
 F: tests/unit/test-qdev-global-props.c
-F: tests/qtest/qom-test.c
 
 QOM boilerplate conversion script
 S: Orphan
-- 
2.53.0


