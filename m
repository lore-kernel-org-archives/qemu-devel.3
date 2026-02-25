Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0676DF55452
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:50:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6rE-0002nw-UJ; Tue, 24 Feb 2026 23:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6rC-0002nN-5N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:50:42 -0500
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6rA-0000a8-Gy
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:50:41 -0500
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-79495b1aaa7so57514867b3.1
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771995039; x=1772599839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6RX4s8WBI9SExT6DUdlQabeu5HIVJuzhQgn9TiqQ9BM=;
 b=OiWnYyNJDMwstr/SauM7pksbkwtEe9ui2gy+T0pwEjTvyN2EIcAb92c34jd4EvY285
 cfuy8KZi0pf2dzXA6eDi5hwDbwuLrnNb0qJ7Iv2VUAhJNMOK64pBA85FV6lBVNm/8EpE
 ORkDtP6JNBLhA60/nXSXGO2nhxWCOaPtP9I0fbhfKefPgrOvljqdeAYScZN9lmZUTjQN
 z74A+alA7hgB4OVOisi9H3gpp0Gm1Ki9yZhJ7+WxQ/EHnJ8CCWEL4mTeef1QJqRg3zoM
 xSVianzrLhodW+NNb6qj8Fkz5ot3oTCjcP0CO5r1041c69EvmOFOMZBM1OxDDtoi/nyZ
 rCKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771995039; x=1772599839;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6RX4s8WBI9SExT6DUdlQabeu5HIVJuzhQgn9TiqQ9BM=;
 b=QTQ/MFx/jDrCeEMtRhRgHexxaB8dT/NgZTjg5kcdy8pLsna0Hi59T9U0aLDGOAVTCg
 kVrKQBCvRas07lZoqbUL1542TRbwIXuejUd6uWvZLqASyFxq2goZc4bJtCgTfL92IxkB
 Pn+nux2/66cUBCg8Om1w0gkCHNjPh/d5r7nuzeGqmmt+l1+9HbSzIXAo5HaTijn4ORqx
 c940aP6enPdx8Gs+1kIZxVFxyEMEJTPRsHtJbYSMpHy5xomIqFrdxpIKPZ7zDEZDOj15
 vZK9Fj6QUq4/IkU5HyK0iikrmm7hvULh7wMCgJQXynj2nn+OPXVNyfLEfs4SsNmxr38t
 gVuw==
X-Gm-Message-State: AOJu0YyqEUpqnFJYYksjwsdDBW862U8ZwdSSuXpF6b5NBVCDCPVUfuta
 dgx+59kEole/4aye+CJHNKnb9338hhu/zYxnigKO2iWAzJrPe8TApU6IEMzRBrlzzrvvEgC0/rK
 YbpOleKM=
X-Gm-Gg: ATEYQzz3N02oIVVlKEpQtsUVT2lpsgOw1VgaBXs6VfU2590xUkfthHKLY9R0NIXslzd
 ZLcYWTE4MZsUtfW/bSYcA9LcFvJ9RgP+VsCIh38MP3gqGw02ReSWoiqNSad762yhvX54wkv6NOn
 nUiyka++hdAk7+os+f8YDys2V0d7F/mTk4ZcdX3ZZ1AXbdgcU72cjb1ZfJ4jTvihFGaksdSmEOk
 2Qam0s5LWN0+OTNnpd10BBHXA18wkW4VLf1OQPk+z0xvxWDPxUwKWG5qS/VWqfWz+vLKDdD125W
 DsFghevimCMF/p/NK+4x60Q1+78X5AvYK2qgkQaFghPWOHuMQko8JZ79E6Zyns4acrGzlclYvfx
 cdbdVPtDPj3jEst56EuyKIZrJAS+EG5/jMJdyKV+Ym7ViWDv6v/ynGP5Oqxe8GIxPCmHkj+j5Z5
 ZOsL8SNnMRuyjCtgLVBOHttBoPmBVdV/veb3PDA1GMYEIQR6UW+6pigdkgNuqUkWc=
X-Received: by 2002:a05:690c:9a87:b0:797:afeb:de55 with SMTP id
 00721157ae682-79828ffdd98mr131092627b3.32.1771995038590; 
 Tue, 24 Feb 2026 20:50:38 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79867bf0275sm4380937b3.8.2026.02.24.20.50.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:50:38 -0800 (PST)
Message-ID: <80a0d51b-9bc9-4395-88ec-11f32c823f92@linaro.org>
Date: Wed, 25 Feb 2026 15:50:32 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] hw/virtio: Simplify virtio_access_is_big_endian()
To: qemu-devel@nongnu.org
References: <20260225041948.52929-1-philmd@linaro.org>
 <20260225041948.52929-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225041948.52929-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112a.google.com
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

On 2/25/26 15:19, Philippe Mathieu-Daudé wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Thanks to previous refactoring, we can see more easily it is strictly
> equivalent to always call virtio_vdev_is_big_endian.
> 
> static inline bool virtio_vdev_is_big_endian(VirtIODevice *vdev)
> {
>      if (virtio_vdev_is_legacy(vdev)) {
>          assert(vdev->device_endian != VIRTIO_DEVICE_ENDIAN_UNKNOWN);
>          return vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG;
>      }
>      /* Devices conforming to VIRTIO 1.0 or later are always LE. */
>      return false;
> }
> 
> The key is to understand that vdev->device_endian is initialized as
> expected. It always contains cpu endianness, and not
> device endianness, ignoring if device is legacy or not.
> 
> By default, it's initialized to vdev->device_endian =
> virtio_default_endian(), which matches target default endianness.
> Then, on virtio_reset, it will be initialized with current_cpu
> endianness (if there is one current_cpu).
> 
> void virtio_reset() {
>      ...
>      if (current_cpu) {
>          /* Guest initiated reset */
>          vdev->device_endian = virtio_current_cpu_endian();
>      } else {
>          /* System reset */
>          vdev->device_endian = virtio_default_endian();
>      }
> 
> Now, we can see how existing virtio_access_is_big_endian is equivalent
> to virtio_vdev_is_big_endian. Let's break the existing function in its 3
> variants, and compare that to virtio_vdev_is_big_endian.
> 
> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> - #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>      return virtio_vdev_is_big_endian(vdev);
>    This is the exact replacement we did, so equivalent.
> - #elif TARGET_BIG_ENDIAN
>      if (!virtio_vdev_is_legacy(vdev)) {
>          return false;
>      }
>      return true;
> 
>    we know target_is_big_endian(), so
>    vdev->device_endian == VIRTIO_DEVICE_ENDIAN_BIG.
>    if (virtio_vdev_is_legacy(vdev)) {
>        return VIRTIO_DEVICE_ENDIAN_BIG == VIRTIO_DEVICE_ENDIAN_BIG;
>    }
>    return false;
>    It's written in opposite style compared to existing code (if legacy vs
>    if modern), but it's strictly equivalent.
> - #else
>      return false;
>    we know !target_is_big_endian(), so
>    vdev->device_endian == VIRTIO_DEVICE_ENDIAN_LITTLE.
>    if virtio_vdev_is_legacy(vdev) {
>      return VIRTIO_DEVICE_ENDIAN_LITTLE == VIRTIO_DEVICE_ENDIAN_BIG;
>    }
>    return false;
>    So it always return false, as expected.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 14 --------------
>   1 file changed, 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/include/hw/virtio/virtio-access.h b/include/hw/virtio/virtio-access.h
> index b8aa7a520f5..e3148c23881 100644
> --- a/include/hw/virtio/virtio-access.h
> +++ b/include/hw/virtio/virtio-access.h
> @@ -21,23 +21,9 @@
>   #include "hw/virtio/virtio.h"
>   #include "hw/virtio/virtio-bus.h"
>   
> -#if defined(TARGET_PPC64) || defined(TARGET_ARM)
> -#define LEGACY_VIRTIO_IS_BIENDIAN 1
> -#endif
> -
>   static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
>   {
> -#if defined(LEGACY_VIRTIO_IS_BIENDIAN)
>       return virtio_vdev_is_big_endian(vdev);
> -#elif TARGET_BIG_ENDIAN
> -    if (!virtio_vdev_is_legacy(vdev)) {
> -        /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> -        return false;
> -    }
> -    return true;
> -#else
> -    return false;
> -#endif
>   }
>   
>   static inline void virtio_stw_p(VirtIODevice *vdev, void *ptr, uint16_t v)


