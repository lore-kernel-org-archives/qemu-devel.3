Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5AF3F417F3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcvh-0006z8-BV; Mon, 09 Mar 2026 11:54:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcve-0006xq-Us
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:58 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcvd-0000Fs-8v
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so24417715e9.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071635; x=1773676435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PO1+Ml3mNJBa037aqT8Z2g6AbLpEBP5aH3yPV+0teXs=;
 b=IPLe7pGPF+k92gd/zOc3MrifIu3pdixu9hbQJ3Yr3jtbQZcM/9zUY2NxQI4TVZmc3d
 9+2WwXkFbckchfsblmxVFskjlz3T65K555oOUcf4QtluTBFs98462ShsbiYZo7VU2io4
 pLyUy0eDbcnGNYHx8LwrSDI9WkKozv0LN7NlBK99qaet0sVnRLee6UIgp4WJCBxC5aIa
 7XAb4UZFxckn+CUSvs2n1+mdkNIv1dmdBQjas9Bp8kMAvp4BYSMvQ97CCL0RE3WI8AmT
 oR5+8zVu35wpMROYz0eo7WBXc/VgDxV5O8KGLgGhQyOb2OaixkLjK3JAUCdTGN1cY6xU
 JdUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071635; x=1773676435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PO1+Ml3mNJBa037aqT8Z2g6AbLpEBP5aH3yPV+0teXs=;
 b=tbfvgalh7x+Ap0WmwFyLu3Ss1+JCj9pBMe2LRfRpyThimnMgR6BKkTajmeGb/dezSp
 uuFQi2ToA0azZNeNqD9JcfLayCWSfJW0w/oSws748sZuWbg7gj0z2b7HtIiQY38ftLac
 xO42xpw0533ll2ovd9WaP7Dhu/eK/cyfH6OoANtegdNu0XXSIC5Qy/cOJ8UZyxAdRhqp
 nTIkX4tDfhZA3IVl27Jhwha56DPalQZJXvwSjSVShEKGGPYQPoLN8nTaxK5PqGP+Q1Z6
 MXt4TXb7SA6QbKhjYnBdztKi5F9ZxWz339N9jkfYOP7ap6m+EHqfq1c7jht0aTfnk5Gj
 lSzQ==
X-Gm-Message-State: AOJu0Yz/f4+5T+M37f2c6rfBOLVJMDNIUk44s7ZZ4AB9VdZpfGteQr0F
 Rem+u4vNF/3v4bK9S8JtFKSq16hPRJZSAfPPeMepAqjaW4mLf3OWiJJAJuwSQWTIMWfd47+794y
 B4S/PYUQ=
X-Gm-Gg: ATEYQzwUJYXNwQLrRVrTTU0nQ2nJu/5hR22YNCBe/YHaBiIJvvU1iBeR5jx5+nPtilt
 lxjvmXlrw/stsqQlox3hcUSMkaKRiWE/iojOWw5imLXI1FpZMx6pHuslc1sBUPzqkFQN6ZXhUV6
 dJ3gLmqj/wfiverve1R/xNA+y2vhApw3QwQI5RMcnAMIJnrkQmT9Tk4bVXiTIUwJL4igadA4dIF
 Bulyhe/eBgG/o67PVygE3JIzqLQ8ZdhORcgaZNaegfF91OtsGI6B6eTc1XcIaMgAR8+bZUbSgpu
 DMPCvp7gUZW9Wms4IpFFgRO29Q0U1Y5CN91E3nfzLotkiLy123jzMdIa+JAU8CCNDqM0l6RkqY5
 9Eiloh5jLJKltSFlUthakB7feY/+CsOjJUL2yduYgv5/5bQeCXQEAgQ7DE784oFeOjT/K86pLoy
 M89LZMF7ee40vlv7+x9/n83xnR3RkN9vV60ioCIIB4DOaZ07zDl/n2gRzBQkjCPoMf0mQPpiql
X-Received: by 2002:a05:600c:3d90:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-485269304aamr176624885e9.11.1773071635217; 
 Mon, 09 Mar 2026 08:53:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bbcesm984865e9.3.2026.03.09.08.53.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:53:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/49] hw/virtio: Remove VirtIOBalloon::qemu_4_0_config_size
 field
Date: Mon,  9 Mar 2026 16:51:44 +0100
Message-ID: <20260309155219.62400-15-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

The VirtIOBalloon::qemu_4_0_config_size boolean was only set in
the hw_compat_4_0[] array, via the 'qemu-4-0-config-size=true'
property.  We removed all machines using that array, lets remove
that property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20260307154202.86309-6-philmd@linaro.org>
---
 include/hw/virtio/virtio-balloon.h | 1 -
 hw/virtio/virtio-balloon.c         | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 79ac194ccec..abbf3397188 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,7 +70,6 @@ struct VirtIOBalloon {
     int64_t stats_poll_interval;
     uint32_t host_features;
 
-    bool qemu_4_0_config_size;
     uint32_t poison_val;
 
     /* State of the resettable container */
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 38bf1e84a1d..4c5f486ba23 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -708,9 +708,6 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
 {
     uint64_t features = s->host_features;
 
-    if (s->qemu_4_0_config_size) {
-        return sizeof(struct virtio_balloon_config);
-    }
     if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
         return sizeof(struct virtio_balloon_config);
     }
@@ -1054,8 +1051,6 @@ static const Property virtio_balloon_properties[] = {
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
      */
-    DEFINE_PROP_BOOL("qemu-4-0-config-size", VirtIOBalloon,
-                     qemu_4_0_config_size, false),
     DEFINE_PROP_LINK("iothread", VirtIOBalloon, iothread, TYPE_IOTHREAD,
                      IOThread *),
 };
-- 
2.53.0


