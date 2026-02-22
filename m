Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC9FE68179
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 23:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuIWr-0001Re-DF; Sun, 22 Feb 2026 18:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWq-0001RW-SO
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuIWp-0005vY-BG
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 18:06:20 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4837907f535so33151855e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 15:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771801577; x=1772406377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XHXaASfkbWM1l9xUlj4XeLmv/SGeaBdPv/Pbmq3J3VE=;
 b=r98sZmJXi0x+e6S18zyxOLoT75bSlLP/cEehTAiXCkq+6Jy1V/WlUDS9wEZJzRFXQW
 lQl5+QiTORzfO1q8rUR9r3YXmXCcdTPdRoUmeP4dImYQhVGb/nVearXRUPjFx1H3jVH4
 H8/fJVGCcIUcOG4v/0c30BpvLV5D7cxr6W5tqH8E9gb83dmxfKj0UTAJQXoKKhZdEPWb
 E/5smryhboWjbR3Mge2j1Isst44vKZXIYEdC0P75pcGQzDtw7/q1FdfG1hGPdzlFZhBV
 si1rluS6cIJTMdLh2Zph1ZsR1+S4Hmouw4lqReFy6SFSjvolpFDAGoLT9LEZiQzSnHQT
 0E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771801577; x=1772406377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XHXaASfkbWM1l9xUlj4XeLmv/SGeaBdPv/Pbmq3J3VE=;
 b=hHa1qvxcFE7So5a41YQ0VoOMFq+zoU9gzMud97XCz9tU31W+op6YtixustvGrbHzHR
 t8dyES6bgtg9VG8hwjPpYG/3hGHSHMIG3oifzxSp7JRjaADVou2GVFloPKOSvTEQz4O0
 ijN5+Rln8uU/PBgIoA3K6yPPLTNhw1WUq05MruAbvf2arRc4aQFdfSEfj2SyT3bdbZqw
 fNpBmQx4o4MDqZpESUPywXBi/4AJRj4lzL8ToyIHWR9dyLEmNqBIy2rBU5TkoFjvB9Xp
 7b7F6USZcmEMzFw7VVw6VB3cWAxSx/wPWpjJ6cFVMvzyJAvRLtNJdrKKRou4UKragmJX
 QUaQ==
X-Gm-Message-State: AOJu0Yxr4Mb97xEcs/lJZ9kUEJ+w/5AoJvT2fLJR1RfuuxhuR91328de
 uWrf+H3cV6MW/cfxl2yoRj4BIdTWcGQSL+Kg3VS9ON9eONfBcotX7cCKu+tS8XFxBSRGZ/+Rjbg
 YdSH6SoI=
X-Gm-Gg: AZuq6aIE+85432H+x0m2WCCv2m6uKPBODcMpOUuwQIJiEW+5FadSWTzjkvZcANpZJhU
 AKrSIZy6DHNoGBMMJFPG4zd7WTFFuqYY4yezLCQZyj6jLkl3mnLu9oYwNWDonnbBp7F2WabVxzV
 7aWBa7DCXhedpJar5Gf8TsktF6Vo8dJABvqAVnYpF5/idJqyA6YFruezoIzviaZoM5gzCdLuY7l
 RAT0GL1or7eU2XZPwFZE3Tm/6QBRWb5A1run2+DAeib9xSqQJ2QG8MaUI+5ba+HyGdBhxdIPRRF
 MuMDM6YwbvMzV53po/CrupHmU/EzPrpioijYTwfF4UI4u3oKYj+R2BtH8opSbDfJ5zeVYVsutD+
 SULEttI7pSOTZMi8dDgUhsPfXAUfPEkkmEo7o9wNrzYmscijdFAi2E8n0syr7mDUdDu+qP6tWev
 hmeyddRhu5xjltuMsQ1ShcK8Bw3c9sjbwuHcpvb6WL70SJ8/OcpGrfcFsGXLH35BZzYeBrtQ7T
X-Received: by 2002:a05:600c:314e:b0:482:f12f:f35e with SMTP id
 5b1f17b1804b1-483a95c710bmr107438455e9.12.1771801577494; 
 Sun, 22 Feb 2026 15:06:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a42b4d5asm109931275e9.5.2026.02.22.15.06.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 22 Feb 2026 15:06:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/20] hw/virtio: Constify virtio_is_big_endian() argument
Date: Mon, 23 Feb 2026 00:05:43 +0100
Message-ID: <20260222230602.5756-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260222230602.5756-1-philmd@linaro.org>
References: <20260222230602.5756-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

VirtIODevice argument is accessed read-only, make it const.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260206221908.1451528-2-pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 27cd98d2fe1..65872f2c54c 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -468,7 +468,7 @@ static inline bool virtio_host_has_feature(VirtIODevice *vdev,
     return virtio_has_feature(vdev->host_features, fbit);
 }
 
-static inline bool virtio_is_big_endian(VirtIODevice *vdev)
+static inline bool virtio_is_big_endian(const VirtIODevice *vdev)
 {
     if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
         assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-- 
2.52.0


