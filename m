Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B6FF47CDA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 21:07:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyFuZ-0000na-Vm; Thu, 05 Mar 2026 16:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuY-0000n3-Bw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:10 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyFuW-0008O7-Aw
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 16:07:10 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso2992739a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 13:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772744827; x=1773349627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QAo6ofbgTbHTQLqhku7tbhHK2r8k4onc7bjEitYzIus=;
 b=cNFXH+8wVDpCOtXCLnuorNIR+OtB0nLXlFuQvTxg7605KGam/jPVA0jjnaTBzfUuck
 Cf94acxGBRbcQIlDJtgal4rhEQtUoEJpKHdgZ07MdkGWZVN3M9HMY2fMf3gEpOFqCa8E
 OSAkSiY1U2Oy62LoF+txdqr4uqDY//5OSwp9fiwXj5BNQ0FDOqRzkwK3OKy88LyKeOFp
 PimrOUvEmR7icgumysND5phfhoVAuOaoJhYbBI0wh+CNMp3e0eVw/TNKre39XWFICzbK
 RIwfDUjD0pALoo5iQ/9P+fI34ix+wzi3/r7DLU2Z2YOGL9Mra7W8BzXq6DFb/GbeQ31/
 dWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772744827; x=1773349627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QAo6ofbgTbHTQLqhku7tbhHK2r8k4onc7bjEitYzIus=;
 b=w5w7Nbiy0XdOJ4axrGE9Y92jRtxR7gwN0WbSsViWCr5ANOWxVXbkMYMZAsJuWTIg/6
 /RpLAje6WdJ9l/Ds4x89uszpKOWmPu2xAvvV/uX5VtTvX2aLJYFQa0+mTChaocDXA4mB
 M51Y9Z3exv66oiV3bJB851BTvyPZJrKVeqZC9N0QGhCgPYiSLLdEvfMGaC6szbAqDxSx
 F0Z6jwUGGE5LpmQ7VACTuQ7+y1qn99U6ZxmNwtUsbCfJR/22DW4ohCsjcR7GD16LoPt3
 7hE83esXoWxkTsYQ72INl+9/Ga+lBTfIvhWKzuzne8Ox66jd/mew/IxJnb0aSs0/2p4v
 D/Ew==
X-Gm-Message-State: AOJu0YzPQcRaRxI243NN1Cn2W1Qi0HjC1hty9vTE0Uylc1Ig26Ykm+pq
 NK8w0cYM1Nz03ehjeY5KP2iKYxgkH9sz6Nrv+oHkk9eKNxOW6S03+PNUGwkPtY6xdXsLLBtjyvG
 Xr/Us
X-Gm-Gg: ATEYQzyFw3cHQcVPuvTlgJhb827M0Bh1ij0Vp9ZL9YnlPAa10yt7xnU4H1i+YZXD8H0
 Q0VttD8KcVHTzwhyyUfzxZFlTedMehqpLU+1mdfsi7Ni9sVFSiL4uYB7AhNRm888UlUhcno6xXC
 yJi0cwYzMxF1Oh+jd/ciZ3sGa2mJPhk1ihMqXDyMT8jTlDx9LFh9FOGHPn5EZabK3iz6A964va4
 QIp/uRtAqcGi0Jt1KJAebYve7S7NLFLeCX5WYo//kmpPZOLeBx0WZwwq1f5SBIccQI1mLQdReOr
 ONjUzkMgGQ77RpT5yW/6XQxSMRcmmw/uRDpB3v2YgKthQDNc8H18NTjeAb9nVmiHYI8i2TsBJuw
 2RYD77Zz7Mx7e3G/02eveUnygZBf5gY318QGXM9iTQx8MtI41hr+E6lowSNs17TFbpuoz9cVaJZ
 V3jVj1hXcW14PqiF4V2ZaneT2IcapwJAOak4BGTwsf5nfGy2lG66umjAv2iakupROV54W42qQ8a
 WXp
X-Received: by 2002:a17:903:1a67:b0:2ae:478f:2e2 with SMTP id
 d9443c01a7336-2ae6ab0f4a6mr59455985ad.27.1772744826834; 
 Thu, 05 Mar 2026 13:07:06 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6b5813sm236992505ad.63.2026.03.05.13.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 13:07:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 2/6] hw/virtio: Simplify virtio_access_is_big_endian()
Date: Thu,  5 Mar 2026 13:06:52 -0800
Message-ID: <20260305210656.2140206-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
References: <20260305210656.2140206-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52f.google.com
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

Thanks to previous refactoring, we can see more easily it is strictly
equivalent to always call virtio_vdev_is_big_endian.

static inline bool virtio_vdev_is_big_endian(VirtIODevice *vdev)
{
    if (virtio_vdev_is_legacy(vdev)) {
        assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
        return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
    }
    /* Devices conforming to VIRTIO 1.0 or later are always LE. */
    return false;
}

The key is to understand that vdev->device_endian is initialized as
expected. It always contains cpu endianness, and not
device endianness, ignoring if device is legacy or not.

By default, it's initialized to vdev->device_endian =
virtio_default_endian(), which matches target default endianness.
Then, on virtio_reset, it will be initialized with current_cpu
endianness (if there is one current_cpu).

void virtio_reset() {
    ...
    if (current_cpu) {
        /* Guest initiated reset */
        vdev->device_endian = virtio_current_cpu_endian();
    } else {
        /* System reset */
        vdev->device_endian = virtio_default_endian();
    }

Now, we can see how existing virtio_access_is_big_endian is equivalent
to virtio_vdev_is_big_endian. Let's break the existing function in its 3
variants, and compare that to virtio_vdev_is_big_endian.

static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
- #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
    return virtio_vdev_is_big_endian(vdev);
  This is the exact replacement we did, so equivalent.
- #elif TARGET_BIG_ENDIAN
    if (!virtio_vdev_is_legacy(vdev)) {
        return false;
    }
    return true;

  we know target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG.
  if (virtio_vdev_is_legacy(vdev)) {
      return VIRTIO_DEVICE_ENDIAN_BIG == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  It's written in opposite style compared to existing code (if legacy vs
  if modern), but it's strictly equivalent.
- #else
    return false;
  we know !target_is_big_endian(), so
  vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE.
  if virtio_vdev_is_legacy(vdev) {
    return VIRTIO_DEVICE_ENDIAN_LITTLE == VIRTIO_DEVICE_ENDIAN_BIG;
  }
  return false;
  So it always return false, as expected.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260225041948.52929-3-philmd@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/virtio/virtio-access.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
index b8aa7a520f5..e3148c23881 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -21,23 +21,9 @@
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-bus.h"
 
-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
 static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
 {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
     return virtio_vdev_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (!virtio_vdev_is_legacy(vdev)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
 }
 
 static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
-- 
2.47.3


