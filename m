Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18E606A327
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xzU0Arct
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR5sP-0004ZZ-IU; Wed, 11 Nov 2026 05:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5sJ-0004Yj-Lf
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:48:21 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xR5sH-0005QG-Pz
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 05:48:19 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-491aaed7565so1817801f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 02:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794394096; x=1794998896; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nnfYJ7u/AVxfVNUFJ1NyWivMcqBN6zdRuXcVpR9KasI=;
 b=xzU0Arctg5GsdXbg73OPHqwLW4MB+8ZIeLnEJlrXMr4w1xff6SBz+h3z9KPjh4CAd+
 DEkcYDGr0PEkq0E4kIcDJiWUkHtixcH22bs8LH0osJpOdNF6SwlvnP5t5hdeWubFNk6r
 Fq3w3/7zNxVnnnKRWLvJLkjB6mDpPBLEwIDve5ZcMIelgOozmVK7/Bzb8jgPdA/ZAfvI
 30C+9GAzvVFdTynEL7ztO15Hkcqf2X2NGkr2W/8nnH9Cn2JlzyYpRgfh6QAOAJi3JSzO
 5tYGNkh6jNzIn4qqDTLc8TB3tnr/vsDYkskhdlEPaRNgaK6wrccNQqi8hw+3y+356ZXi
 Fq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794394096; x=1794998896;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=nnfYJ7u/AVxfVNUFJ1NyWivMcqBN6zdRuXcVpR9KasI=;
 b=Mi7AVuG2ANTPQH9sfF7fPtO1AVHapuFoM0yeSF3RwFwhM4FpsVGhk9P7Hlt0tUm6cI
 FF0qoEVBDmTiSuh2xxA3Pf23scCsLOHmVZdQHSV57UfkQRIT13OJO0FdoNAV4hYLaBaH
 UNWyJycTn2ABWDKq56aBnRTQe7uLxJBSqDa8QorjIsUTtiGJu+yVzT81TqcyK9vhXqiL
 GGhP2GJMP+N+So+1JNrFIVt6NGogSeZvBN5BNocAzYLUowWewUeix+bjHCfvtCg3Exfu
 8ECm5vh6EYGWKNWQtY1W+2GmxLxrwPoQIzSfkDkdgtg6PaXSOsVSykUt/bZd7BVzho7S
 zI0g==
X-Gm-Message-State: APuU4Z/J2H2xGcSlYEtg7qMuiONTLo5Mr4UzboEwW4kfl1212m56Xj69
 wqKpGBfpjLxIJ1teMvjgoTA1vRknK7gBB/iEPWGZju4xtZSCoGuCzgY3TCD6OnQQ30vXdhL0NOI
 pdF2IJUU=
X-Gm-Gg: AYBFou3ipCe0FKX5zUVJqGbxVn5qGSA+xcawrcZMQWGTnVFcQOhUuh/3HY70ESuiPBQ
 FW1jSFLXrA9A495j6Yh1HQp0BydmwD83uinhNqnHSGkTlF6Ajv9nnq1gtd77VI7db1eM+e0mvtr
 Sz1WZADKJc2Zh9avfYi7Wm3UYh9Hl6YssAZfMxaJBg7V9a8jmzZD+8F696kr71l5Y/VdRI6gb1C
 meIBgflPZmy+I3JWUVIEc5WS4QaJlLjjZYGRU+g+G9CTvjFH+CN8RT2GFi6BAXZVpfx0i55euOE
 ROP7bIHDC0eH6f4jolxoFCQGODWBcjBV8DtIArBo2rqvteNmJONwnSLYQjq5Cp69BPa7zMDmP50
 AGB1EBcd6JrGwFLyvm3YqX6tiwYh0ewm5yphTbMLuNwRrxnrGcottnRfyEoLkE0EGUc7xD5s8IW
 snwTLEwS1Ph/qHljo4RymCZRqepanZ0iU+Z34LOWviTjVSfuYSmCtVyO9VBKTQlikfToR0HiiQ+
 4EVH8DZv6dGrLIxmv3JGQdtZTwImFCkktqCPDGPwJewenSCdrSrYKWblqPq3S1Mc5IdFfOJ6+mx
 zR7hV9WIEPGlMN5D9wADlPYqiQK5jwC0
X-Received: by 2002:a05:6000:2007:b0:490:1358:2265 with SMTP id
 ffacd0b85a97d-499c80de903mr3202157f8f.34.1794394096052; 
 Wed, 11 Nov 2026 02:48:16 -0800 (PST)
Received: from linaro.org ([2a10:d582:31e:0:81bc:371c:5725:cc4d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbfc6sm10931966f8f.41.2026.11.11.02.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:48:15 -0800 (PST)
Date: Wed, 11 Nov 2026 10:48:13 +0000
From: Jim MacArthur <jim.macarthur@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 5/6] virtio-snd: cap maximum buffer_bytes to half a GiB
Message-ID: <avRH7Q2ghdJuSOjd@linaro.org>
References: <20261110-virtio-snd-fixes-v2-0-d5b654217676@linaro.org>
 <20261110-virtio-snd-fixes-v2-5-d5b654217676@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110-virtio-snd-fixes-v2-5-d5b654217676@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=jim.macarthur@linaro.org; helo=mail-wr1-x432.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 02:39:34PM +0200, Manos Pitsidianakis wrote:
> A faulty/malicious guest can try to exhaust host memory. Cap the buffer
> size to 500 MiB.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3587
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>  hw/audio/virtio-snd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index a7d749f24f..a6036d5b75 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -17,6 +17,7 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/iov.h"
> +#include "qemu/units.h"
>  #include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "system/runstate.h"
> @@ -24,6 +25,8 @@
>  #include "qapi/error.h"
>  #include "hw/audio/virtio-snd.h"
>  
> +#define MAX_BUFFER_MIB 500
> +
>  #define VIRTIO_SOUND_JACK_DEFAULT 0
>  #define VIRTIO_SOUND_STREAM_DEFAULT 2
>  #define VIRTIO_SOUND_CHMAP_DEFAULT 0
> @@ -368,6 +371,14 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>                       & ~(stream->info.features));
>          return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
>      }
> +    if (le32_to_cpu(params->buffer_bytes) > MAX_BUFFER_MIB * MiB) {
> +        error_report("%s: given buffer_bytes value %"PRIu32" "
> +                     "is too big: over %d MiB",
> +                     VIRTIO_DEVICE(s)->name,
> +                     le32_to_cpu(params->buffer_bytes),
> +                     MAX_BUFFER_MIB);
> +        return cpu_to_le32(VIRTIO_SND_S_BAD_MSG);
> +    }
>  
>      st_params = virtio_snd_pcm_get_params(s, stream_id);
>  
> @@ -1037,6 +1048,8 @@ static void virtio_snd_handle_tx_xfer(VirtIODevice *vdev, VirtQueue *vq)
>          }
>  
>          stream = &vsnd->streams[stream_id];
> +        size = MIN(stream->params.buffer_bytes, size);
> +
>          if (stream->info.direction != VIRTIO_SND_D_OUTPUT) {
>              goto tx_err;
>          }
> 
> -- 
> 2.56.0
> 
> 

Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>


