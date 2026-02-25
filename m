Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC258F55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:21:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6Ne-0005QH-7F; Tue, 24 Feb 2026 23:20:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Nd-0005Og-1U
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:09 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vv6Nb-0004kJ-AC
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:20:08 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48375f10628so40005565e9.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771993206; x=1772598006; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FyyQGCdvNlXMpJGQDM6PgsdMvaL+DbEDtXb1NotW1AQ=;
 b=NP2gotJckQwxITjfT3XSlST6if4nnYzub+acOaJ0FwVxNaq0MMcuDbBhXy5qNf1qCT
 aMnn8thVxP2koFtTR8CyH6jxutukjkHiflR+8FalQitlOt1JIzjXzX3HZNr/1qk263p1
 epmLzioMUj2DnlJj6OwPD5TpE0FK39Yr0OJjX8b5KadLmEF1xiGJw0g4Fd9SGndfh4X7
 3vJqHNoY21DZcDhb7fRKEbBOyW82EirB3EoxNe9NJfCGt0739SZsdx8z9jxGCvV17KpS
 1s3i7+fa5lbZeBZzdXTEaZHJ0LbEm0SZ+ZLvnNr5uuV6jFjAlE998WCISV7PXyIsU9BY
 I6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771993206; x=1772598006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FyyQGCdvNlXMpJGQDM6PgsdMvaL+DbEDtXb1NotW1AQ=;
 b=eT6EQrYZxT346FYoRsY+B+ahbgiBgPiof5bBdBH82MIAobz4JTG5eBU2eR2totpfMX
 Ha1cakSYXhPtdfutv27jVoNKDcjO5smpnYvQUlvw3U9jVMd9P82KBnpkTS5uXQncloaL
 oQV+c/P25pqk0t5jI2Bk/jAzHqztR+icDydjWwGpsc47a+j03xUp61a2a07UkrP11RcZ
 Y9r+D7ah+9AEXZOJmC1te/2/tR+41zhqV7JPMDVCKaBOmOMP/CRNst3uZXgx4AF3br4v
 mfG4Jwm4R8ojOoN+Ec7j+SlT0cWNWw8z89DfzsLEsU4D6nxeNyB8ltNjh7RCAOlkK2xe
 1Gkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXjXBWbBr8SWGm7CES6MrCuHGGS4VZ2/VNUxcbJKaG6BE8QW3e1gk+jqWgn8r/xkcJjTMzWP/2xYi6@nongnu.org
X-Gm-Message-State: AOJu0YxfWdltlPnVGXlvxenb6O+5G0hFH12IY8lHAmkNgNdAPUKTGF1M
 tuhY5ljBy8zRuEeyW/bFPspaipltoQ/PX+nHgyEOBYOzar8lkDx2qERSew5lu7xAn9w=
X-Gm-Gg: ATEYQzxBz/WoZzxzhRBkn1gW0nrCXa0KFKBnqqWU9Nb99ZSbO7QLv2aBQFdpKCMznpm
 6g1PqgeegbFiq4bwYgkLiDtDttEKlQqZ4JSXc0vM99FEP5++Ohb3F9VTF+A/sY9j4t8vjziMtia
 Bu7Mp8f3z/3JBM8h2MGqmGPqLCm2SGln8qU6F+1bf3svkLi12K31hnnphLh854AEcj4IOV8Oknp
 nzekF8MH8rwnNqrImy0JoM3msbXjo/HfU0H38J88VSCHkQmzcCAhcm2guyIwbCrfQzEN7ZmBF2K
 fUGIqmTNvXejdXN4yNyUknJAkM1uOiJOkaeSsACrs5lZUZ04GiASpXw6qLjqFb86y2wOBtoLn26
 CHFx0DkCRxFcTrr0P7G4yJCSHfABSANF/HGouAC3INUOA8aNLadt4KHVHpx9h/xrCWP+KVbPtbf
 Lg0gnGtUPVDhVNif1gqvc88n7hnY9zWbCVM+/wYZt3BI18Iy5VmiifeekU0ga8/X0ZsT+u0We7+
 gzLU6i2ZAM=
X-Received: by 2002:a05:600c:1c22:b0:483:79ad:f3b9 with SMTP id
 5b1f17b1804b1-483a95eada4mr249411955e9.28.1771993205837; 
 Tue, 24 Feb 2026 20:20:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb1390bsm3827485e9.1.2026.02.24.20.20.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Feb 2026 20:20:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Fam Zheng <fam@euphon.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/6] hw/virtio: Simplify virtio_access_is_big_endian()
Date: Wed, 25 Feb 2026 05:19:43 +0100
Message-ID: <20260225041948.52929-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260225041948.52929-1-philmd@linaro.org>
References: <20260225041948.52929-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.52.0


