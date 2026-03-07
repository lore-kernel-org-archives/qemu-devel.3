Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1606EF5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytvc-0001yN-Kc; Sat, 07 Mar 2026 10:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vytvY-0001wX-Hk
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:50:52 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vytvW-0003Zp-9V
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:50:52 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-439b97a8a8cso6303156f8f.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898648; x=1773503448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i2IkRMpl1Z18XiGK9Xxl4D2j1zExB9q/jQYoMYTB6+I=;
 b=opbvM+4HpdvdIESESBZg3uVpLuzZYXS9Y2TuUjK3sdsKSmAaHdFespwBEP884QGa++
 lTQiHLs9uAznT/xVAFoNxLnuCf+9y5VqP06Dna8DHvh6ETTVaQMg3VGZBlQcKfgKVmFl
 9AYDyNhdBHIlB6wTNZ0TFXmXPx5y3BzsRbHQft/jyc7IW7EDlTeGdpiFuL+odtXdWbA+
 VO4AmCJpT1FCLreRjRXKOChZeiQI8swxUgZuksjaTEhoeUPYqUYp3CRYOlV+9v7fpf2j
 ch3zX9+0PwkH2grEnsh8gILaUUcjUvh2XjciJ54GrBhHLQ9bu6JGsgvcYCR7GUHCdgDv
 bPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898648; x=1773503448;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i2IkRMpl1Z18XiGK9Xxl4D2j1zExB9q/jQYoMYTB6+I=;
 b=XCw+01h4+DV98+tecKkS6j2TCjRI0f113RZ0b4T3IUCV2wE7mmPhUXoW3Xmcx+/Fgh
 D3LKp6hDkWjfcxCW+q7rr5UuPJ0uvL96CE0hb+/yE2XiuB6KF6ClJa15WMX54zygQJiC
 Tlbu/bmv8KlYtgs0hh0HiyWY6OwfoEb5HkJHA82J/Haod+d6UjWjm+PFkLps7IMp8+Xh
 bVVDEEZKwIvA5+d0mz177L8HI4Q54LelYGtNCRl1A90hQyiVoDzxUh4+R8t8n7gjNKSJ
 tcISnyj1P/CvBfBtVVGvD/ZJLHcI1m+Jl+B9vSEBcGrBUOwAnnqqa4E9RqAC5zCXW++w
 dsUQ==
X-Gm-Message-State: AOJu0YwoL7GSBz1cKXAbSN2/nRMQtXbbWrJdvdAfyC3bLOrpMbnWsNW7
 0/VPjyxJybOSyAfhkPoLgE4srzkjW3kt/HdNQIkwfqao2oNy1NegE1sUMFcBoxDclqibc+W+P3x
 FyZPc
X-Gm-Gg: ATEYQzz/pfafiDG5sSVaDC62VqDuoTLCfvGUOOHAUQrKBxHCuxJ+pQk4G6viRiVt35Z
 aNhIpqF1ceObdH+NcUu1RPoQmIt+Y7ZikBpgOHiudd0c4KJQxPWq4w+xq0G2Raz8qwQgMdoQTdZ
 ZivJhLCaI9N1GJVbxOeuWAW5QGeuHLgHs9TBJdjoenov7gOS17EsGsDs6saTOo+UWO5/+3PYauV
 Ng+hMG6ntYYTLHZi1EB9oaBnxwo4N8ynXTSLbXEP/KoQF+yVjEEw1+486S/aweM4Z/AY6F0ZBLL
 sW+wh3R4Bmbhhr4QaryaYEVGTqQQwrTnUMAtMelpgO4sB/CQnoCI3aeaC77wdUQdO2mhE5orfFP
 QT13YnesWxIea+i1ctlhBrvhj227usivYKUAtv1zkDEAgrrTlBa5N02yKaoyMdBu+R5XjvEMueA
 O6P6OZ2x+6FNLi0Lej/tig0FF3hXMLdQqpIehhupIH1EYhLY+kS1eZeOXtU37bcEn2YXNLq3VZh
 AEZd7+YdJCEbLQDAaf8vHlmWh5XLfM=
X-Received: by 2002:a5d:5f84:0:b0:439:bc8a:78ac with SMTP id
 ffacd0b85a97d-439da89b707mr10362570f8f.40.1772898648420; 
 Sat, 07 Mar 2026 07:50:48 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad8ec97sm13121750f8f.5.2026.03.07.07.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Mar 2026 07:50:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alessandro Ratti <alessandro@0x65c.net>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 0/2] hw: fix qdev_get_printable_name() leak
Date: Sat,  7 Mar 2026 15:50:44 +0000
Message-ID: <20260307155046.3940197-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The qdev_get_printable_name() function is currently unusable without
leaking memory, because sometimes it returns a string that must be
freed and sometimes a string that must not be freed.

Fix this by making it always return a string that the caller must
free.

Patch 1 addresses an underlying cause of this -- we didn't document
qdev_get_dev_path() and in particular didn't document that its
return value is a string the caller must free.

thanks
-- PMM

Peter Maydell (2):
  hw/qdev: Document qdev_get_dev_path()
  hw: Make qdev_get_printable_name() consistently return freeable string

 hw/core/qdev.c         |  4 ++--
 hw/virtio/virtio.c     | 12 +++++++++---
 include/hw/core/qdev.h | 39 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.43.0


