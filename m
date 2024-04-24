Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BCEDC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdOG-0001Wc-KS; Wed, 24 Apr 2024 10:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdOC-0001TX-GL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:25 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzdO9-0007r4-4P
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:14:24 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so73995865e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 07:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713968057; x=1714572857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFN9ZRHpXYuHJrEfnbsQ/4a0t3x6EAHi8QMCdOzZ3Qk=;
 b=nb52bnta9BpFS+nkUSMyIG5JwQFBK4GLxt1EJ9N3LBGReXK3SdlFGGnE0fGGymDwUS
 HsWCvPJNvcaLtNZtGmHSWhz38QMZtMJzxOTemGmRFfoYn1AmSd/sGtaRMvEDhvOLv3vR
 PeM5nj8Jn5mpP32M0n14P+/5JbmRqqULBDxYRc6tq/SJ6awqo5+kSN2iOwVK0Uebtwcb
 JvI7OQdE7Ntf5MvfVo0VjQ6IrlQgvXxPdHpM6za8+jB0GufgUGcZW7/Zh8T8wm0mX68G
 mdk6tk2bM8M2RRpn1WUS1YE8TbNG0Bo1LKgQ8vvhK0xiDZNvtcPQ4l2iT+hfsu2sQi4B
 2Hgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713968057; x=1714572857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KFN9ZRHpXYuHJrEfnbsQ/4a0t3x6EAHi8QMCdOzZ3Qk=;
 b=tZz1TAtMbQgUfpRguUTxFmhUGFdu6pJn36vQ3Lsx6t+F4nglvqFzHCYbVbYAUaGTCS
 rdfGVLLt+QmUD2xyGQjtd3dPqTKJ1J7wxDkbdbZYd9OZhIn0pxw62njaLNyzRwjGIOXT
 t+tIkEArYq8HsWBbXg+Dt3nq0IdCdeV6gGIpnxxPBQt4VApHtE4XK/ibwY7l6FRB9EdH
 44G+h1KFd+wLdd+La+EnfF7phKE733bUKbVhavQZoAHSUUMv2kRfb8lHDhl6FdUp1WMo
 PFLm5TuTdrTxwx1SfnOcLQGM7MSFvZ0MyHzajosXLxD2XTUFgCvrtICSW1/131XLRY3d
 gzyw==
X-Gm-Message-State: AOJu0Yw+9+LED1POCC6Mr4WA9N47+I5xK5uGtrpNTOj9sePctS2jxNJ0
 /LIBR047vVnnEoiEmoO1yBmZ815bypDHpuHhRGI51PGOH9L9HrW+2eBvkhO2BuGYFUpmI2q47u4
 0AN0=
X-Google-Smtp-Source: AGHT+IH6f7cbtbG+2ONdrqxFAV6pGaG4sVgGZPZP0Wv6RPN6o0EBjeyhBZRss9Gliax1Fkcvzg7eyQ==
X-Received: by 2002:adf:f751:0:b0:347:f26d:c183 with SMTP id
 z17-20020adff751000000b00347f26dc183mr1916298wrp.45.1713968056774; 
 Wed, 24 Apr 2024 07:14:16 -0700 (PDT)
Received: from localhost.localdomain
 (mon75-h03-176-184-51-42.dsl.sta.abo.bbox.fr. [176.184.51.42])
 by smtp.gmail.com with ESMTPSA id
 q12-20020adfcd8c000000b00343cad2a4d3sm17169452wrj.18.2024.04.24.07.14.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Apr 2024 07:14:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org, qemu-block@nongnu.org,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] MAINTAINERS: Update Sriram Yagnaraman mail address
Date: Wed, 24 Apr 2024 16:14:03 +0200
Message-ID: <20240424141408.87779-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240424141408.87779-1-philmd@linaro.org>
References: <20240424141408.87779-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>

Due to company policies, I have changed my mail address. Updating
MAINTAINERS and .mailmap to show my latest mail address.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Message-ID: <20240228080625.2412372-1-sriram.yagnaraman@ericsson.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS | 2 +-
 .mailmap    | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f1f6922025..3a49b1433c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2478,7 +2478,7 @@ F: tests/qtest/libqos/e1000e.*
 
 igb
 M: Akihiko Odaki <akihiko.odaki@daynix.com>
-R: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
+R: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
 S: Maintained
 F: docs/system/devices/igb.rst
 F: hw/net/igb*
diff --git a/.mailmap b/.mailmap
index 88fb68143e..ef1b8a53f4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -100,6 +100,7 @@ Philippe Mathieu-Daudé <philmd@linaro.org> <f4bug@amsat.org>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@redhat.com>
 Philippe Mathieu-Daudé <philmd@linaro.org> <philmd@fungible.com>
 Roman Bolshakov <rbolshakov@ddn.com> <r.bolshakov@yadro.com>
+Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> <sriram.yagnaraman@est.tech>
 Stefan Brankovic <stefan.brankovic@syrmia.com> <stefan.brankovic@rt-rk.com.com>
 Stefan Weil <sw@weilnetz.de> Stefan Weil <stefan@weilnetz.de>
 Taylor Simpson <ltaylorsimpson@gmail.com> <tsimpson@quicinc.com>
-- 
2.41.0


