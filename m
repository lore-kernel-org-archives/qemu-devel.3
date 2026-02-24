Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6313CF4BB6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 18:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuxDx-0001uV-Q8; Tue, 24 Feb 2026 13:33:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuxDm-0001u3-3A
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:33:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuxDj-0006eG-Ph
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 13:33:21 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48373a4bca3so35787325e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 10:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771957996; x=1772562796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vY+Vb78ClWedqYO21AEBT0yuU4jDxK82HYKheHh2XJ8=;
 b=PL6T8s04cql67nL6r9zEe2spu8dnFu9T/0qI+yfP/wsd7QxDped3n6K6upAdBZKpkC
 bgxsqHNuFTmPv1EeCqo+XVxh5brjW7gKb3Y/pLk643BtK42mNOJnhIqnHLy1WVjWxC8M
 c5sIPDbVZoMq5jbIhC20PqGz4LC/xYhzbYDSPlh2AfnvbqQeRVsTzNjXNoM4oaaNUzMA
 QwwVK9SAVaA7mxpm/cppo5DfROClUyR/SqUdm2aJ/SV+MFjzLN4dD1ABmvM6/IL+lFLt
 8NGKY8dgetfgFCNu9CeEV1QpzwhyZIZat7oTT/OJ/Zfx0G4Rc7wMWPDBJkxh/40FHEJu
 inzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957996; x=1772562796;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vY+Vb78ClWedqYO21AEBT0yuU4jDxK82HYKheHh2XJ8=;
 b=bV3nCpk7xerGp0YjftjWLzb0sAYE0SokwNquCyP/ibRXtIvldqzhGmbPn3MfOLXcWF
 s7IWhasw9bgLiO9YtrQved1kBIMofjAutRg4mHXUcXSt5PQ7LjowhZ6udFmYqagF0+j/
 4p9FDoU6GN+WM7wwz2z+zWc9MYB1FgbeyoCIlJ6uMVnsVzlq3ov9jnjp0b/t01YwvLDx
 xtGfR8CPnATvKYf2l2FUpKfEOYVmWAKKAvh2lnuGL0Z6Gs2DnM38U5F6n76MnjJUB+F0
 wzAh5ulKfsSIc+G+o609ev718O60WLtSVv8+1RS09Uu1GT+7B4EaWN8jxzeJFMi7Irky
 NcGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYk+1/++JJNXYLXpdXGjp+DuxDL3Cn4E7sxR/i/ufuRn96mI8Ia4O0daGd9TJcr4DzdNuXCkrshFK/@nongnu.org
X-Gm-Message-State: AOJu0YxDhu2U7s8iFJtBf5ehVj/yLvDnwxtj3Q4a4J2pgjdkC6k6cPCa
 hV/u3LIDsEraHXbdet5xEzQbCIjx16FMlgrfAJJtA3NTRjyQeJuY7ktPLp4fc87LtCFM0A44buY
 yTicwjTY=
X-Gm-Gg: AZuq6aIyB0RNQA5zNMtmKuHYABgANRiDUikVmqKCISYdEstno2QEf47EDs/9ceumXDK
 +Gfg87qUgz2o4CP1QwIEtaHU9pUSFZ9zUN4tkeBSsrxHbcUDtCBgwzMKQjBPkZMAwtO5lMGL6Ur
 0pk6QPFhA/UlSp5KQk/yRTJHVeiAEsVc9Dq3lmlM0Xw6xP+u8WvzSQPwJHdNSaJPBsfQfJK79xG
 hEwbXgA9bGP/RohpTMJJssGWlCeoAF8MV4EvfQymvN6j6uQjET1t8NtphxpGSNrqhp8BK2Q/R0+
 5GujbXRV5xro3hOSGcL9ZUxcacs2ePRMW/QbwZ1KaFdSbVUPx4hF+NS1lryoQdBBlCmClk05EMZ
 TbCjDufDYJxJL5x2KGaLpEDLAXt9VghsUN4OIAoAVHi8MqBNtHtLPbmPYcXSMYQ+bnYIPw8c1sJ
 1+l+mzY35LWKRuEByFAYn1dKU2kIihwA+kbNP4Ygg0nA8IBorJK+8fqdnHWfm+3xCqZw==
X-Received: by 2002:a05:600c:3484:b0:483:7f4e:fef6 with SMTP id
 5b1f17b1804b1-483a95fa4e7mr175480215e9.26.1771957996014; 
 Tue, 24 Feb 2026 10:33:16 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd7009f5sm12519805e9.4.2026.02.24.10.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 10:33:15 -0800 (PST)
Message-ID: <967c35ff-0630-4ca7-847e-04a918c93e7d@linaro.org>
Date: Tue, 24 Feb 2026 19:33:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] hw/virtio/virtio-access.h: remove target specific code
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, stefanha@redhat.com,
 richard.henderson@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
References: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260212234602.338131-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

Hi Pierrick,

On 13/2/26 00:45, Pierrick Bouvier wrote:
> This series eliminates some target specifics in hw/virtio and replace them with
> runtime functions where needed, to be able to link virtio code in single-binary.
> After a first try on a series [0] doing this change and making all virtio files
> common, Richard asked to refactor this part, thus this independent series.

> Pierrick Bouvier (3):
>    hw/virtio: add virtio_vdev_is_{modern, legacy}
>    hw/virtio: rename virtio_is_big_endian to virtio_vdev_is_big_endian
>    hw/virtio: remove virtio_access_is_big_endian

Patch #2 has been merged as commit 6325407f67d.

Since we don't have feedback from the maintainers Cc'ed, I took
the liberty to rebase your series, trying to address Zoltan's
concerns on patch #1. Patch #3 is split between the complex and
trivial changes. The patches look like:

-- >8 --
commit 817ee1acda278b484b750b6abbba7d829bb124bc
Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Date:   Tue Feb 24 13:00:28 2026 +0100

     hw/virtio: Add virtio_vdev_is_legacy()

     This simplifies code compared to having
     virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) or
     !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1).

     Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index 9dd93cf965a..42d20899390 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -470,5 +470,10 @@ static inline bool 
virtio_host_has_feature(VirtIODevice *vdev,

+static inline bool virtio_vdev_is_legacy(const VirtIODevice *vdev)
+{
+    return !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1);
+}
+
  static inline bool virtio_vdev_is_big_endian(const VirtIODevice *vdev)
  {
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
          assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index b4cdb7762f9..b9dc4ed13ba 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1170,10 +1170,8 @@ static inline bool 
vhost_needs_vring_endian(VirtIODevice *vdev)
  {
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return false;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return vdev->device_endian == (HOST_BIG_ENDIAN
+                                       ? VIRTIO_DEVICE_ENDIAN_LITTLE
+                                       : VIRTIO_DEVICE_ENDIAN_BIG);
      }
-#if HOST_BIG_ENDIAN
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE;
-#else
-    return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
-#endif
+    return false;
  }
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index c7b5a79b936..31b566c6ae3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1451,7 +1451,7 @@ static bool virtio_pci_queue_enabled(DeviceState 
*d, int n)

-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        return proxy->vqs[n].enabled;
+    if (virtio_vdev_is_legacy(vdev)) {
+        return virtio_queue_enabled_legacy(vdev, n);
      }

-    return virtio_queue_enabled_legacy(vdev, n);
+    return proxy->vqs[n].enabled;
  }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index e9d55329525..c0c4599b586 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2755,3 +2755,3 @@ static bool virtio_device_endian_needed(void *opaque)
      assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+    if (virtio_vdev_is_legacy(vdev)) {
          return vdev->device_endian != virtio_default_endian();
@@ -3462,6 +3462,6 @@ virtio_load(VirtIODevice *vdev, QEMUFile *f, int 
version_id)
               */
-            if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-                virtio_init_region_cache(vdev, i);
-            } else {
+            if (virtio_vdev_is_legacy(vdev)) {
                  virtio_queue_update_rings(vdev, i);
+            } else {
+                virtio_init_region_cache(vdev, i);
              }

commit 2beb9dea190039355af8a8fa16c389eed45491ca
Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Date:   Tue Feb 24 13:07:02 2026 +0100

     hw/virtio: Simplify virtio_access_is_big_endian()

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
     to virtio_vdev_is_big_endian. Let's break the existing function in 
its 3
     variants, and compare that to virtio_vdev_is_big_endian.

     static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
     - #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
         return virtio_vdev_is_big_endian(vdev);
       This is the exact replacement we did, so equivalent.
     - #elif TARGET_BIG_ENDIAN
         if (virtio_vdev_is_modern(vdev)) {
             return false;
         }
         return true;

       we know target_is_big_endian(), so
       vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG.
       if (virtio_vdev_is_legacy(vdev)) {
           return VIRTIO_DEVICE_ENDIAN_BIG == VIRTIO_DEVICE_ENDIAN_BIG;
       }
       return false;
       It's written in opposite style compared to existing code (if 
legacy vs
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
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/include/hw/virtio/virtio-access.h 
b/include/hw/virtio/virtio-access.h
index b58fb6ed7ea..e3148c23881 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -23,19 +23,5 @@

-#if defined(TARGET_PPC64) || defined(TARGET_ARM)
-#define LEGACY_VIRTIO_IS_BIENDIAN 1
-#endif
-
  static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
  {
-#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
      return virtio_vdev_is_big_endian(vdev);
-#elif TARGET_BIG_ENDIAN
-    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
-        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
-        return false;
-    }
-    return true;
-#else
-    return false;
-#endif
  }

commit 8f907ce751e9922ede323af8d63a21c42392a7d1
Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Date:   Thu Feb 12 15:46:02 2026 -0800

     hw/virtio: Inline virtio_access_is_big_endian()

     Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
     Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
     Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/include/hw/virtio/virtio-access.h 
b/include/hw/virtio/virtio-access.h
index e3148c23881..506be642c9f 100644
--- a/include/hw/virtio/virtio-access.h
+++ b/include/hw/virtio/virtio-access.h
@@ -23,10 +23,5 @@

-static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
-{
-    return virtio_vdev_is_big_endian(vdev);
-}
-
  static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          stw_be_p(ptr, v);
@@ -39,3 +34,3 @@ static inline void virtio_stl_p(VirtIODevice *vdev, 
void *ptr, uint32_t v)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          stl_be_p(ptr, v);
@@ -48,3 +43,3 @@ static inline void virtio_stq_p(VirtIODevice *vdev, 
void *ptr, uint64_t v)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          stq_be_p(ptr, v);
@@ -57,3 +52,3 @@ static inline int virtio_lduw_p(VirtIODevice *vdev, 
const void *ptr)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          return lduw_be_p(ptr);
@@ -66,3 +61,3 @@ static inline int virtio_ldl_p(VirtIODevice *vdev, 
const void *ptr)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          return ldl_be_p(ptr);
@@ -75,3 +70,3 @@ static inline uint64_t virtio_ldq_p(VirtIODevice 
*vdev, const void *ptr)
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          return ldq_be_p(ptr);
@@ -85,5 +80,5 @@ static inline uint16_t virtio_tswap16(VirtIODevice 
*vdev, uint16_t s)
  #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap16(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap16(s);
  #else
-    return virtio_access_is_big_endian(vdev) ? bswap16(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap16(s) : s;
  #endif
@@ -99,5 +94,5 @@ static inline uint32_t virtio_tswap32(VirtIODevice 
*vdev, uint32_t s)
  #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap32(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap32(s);
  #else
-    return virtio_access_is_big_endian(vdev) ? bswap32(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap32(s) : s;
  #endif
@@ -113,5 +108,5 @@ static inline uint64_t virtio_tswap64(VirtIODevice 
*vdev, uint64_t s)
  #if HOST_BIG_ENDIAN
-    return virtio_access_is_big_endian(vdev) ? s : bswap64(s);
+    return virtio_vdev_is_big_endian(vdev) ? s : bswap64(s);
  #else
-    return virtio_access_is_big_endian(vdev) ? bswap64(s) : s;
+    return virtio_vdev_is_big_endian(vdev) ? bswap64(s) : s;
  #endif
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index c0c4599b586..22d798e6cdd 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -224,3 +224,3 @@ static inline uint16_t 
virtio_lduw_phys_cached(VirtIODevice *vdev,
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          return lduw_be_phys_cached(cache, pa);
@@ -234,3 +234,3 @@ static inline void 
virtio_stw_phys_cached(VirtIODevice *vdev,
  {
-    if (virtio_access_is_big_endian(vdev)) {
+    if (virtio_vdev_is_big_endian(vdev)) {
          stw_be_phys_cached(cache, pa, value);
---

Do you want me to post as v2 for easier review?

Regards,

Phil.

