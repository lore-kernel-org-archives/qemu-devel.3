Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92EEBC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 08:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQjjM-000534-L9; Mon, 08 Jul 2024 04:28:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQjjK-00051F-HX
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:28:14 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sQjjF-00038e-TB
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 04:28:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-36798e62aeeso2432089f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720427288; x=1721032088; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBGZHj3UrTmD8fF3K45bcYakWuwfyo8+G8B6Mndd7MY=;
 b=NyvveBBSE1q7AZB1qo5v0ZvvoTrMjr4zDP4A7gwBF8DLz9dUNUKxkphrFrfN6+DW8e
 Ob6rbSrad2h2soy4T6jajfg7Kg+WKZfVwslDqUI941ApqMgX4kyGuya0OX7xzuPq7xyb
 xoi9q+oR4YmyjxpAKo6RjG+JA4uwrCDyWCWi0ArZh7QK55OEj9zJQOqDAjkjpAvsGrDw
 73DhlG1XyY4dnQPi2TgQdcue+lRpBz1Su8aYtA4UifNxXrpDnzKqJwlF9zibOFjwyHz9
 KkXPttiwE2HNaQoDjaNJVJoNDczFmO/++w5l95HdgqoTxLnmhC/ke2ii0kzvP4Gv/NoU
 cXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720427288; x=1721032088;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XBGZHj3UrTmD8fF3K45bcYakWuwfyo8+G8B6Mndd7MY=;
 b=seJzm6TdQWR3mLVf5ZNZnBqF09uSX0nFkr0V9gFRIcHrXngLXdHb0Jx6XhS9bAm1o4
 shrbGfE3wOJhHW2DbJjyUX243/TyYzhytUesZUKiOdCvcqE1mkVJgFPjxT7z0AlhtAY7
 h3KTaYl3B/Lz5Pvr88XWTnCQ3w1Uw3BsmyDV3oFLcMC13gxjTs1zSVdf5gITfIxiEk9o
 cv7nAbzAdg7Idbop7du//0iP/rfY03mcovb0+r8xqLnYBm6wGK/4ANR8TJrFF0baKyPL
 BR3sTWghr6Tm77pP0lr29OG+Kk6SgiAnXBbPi75PTNqpztfQUYXopbu2NZ1Fk2F4uISH
 2N2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmkFw6maDGx9KfgDspxUK3bwT8SvSaf5hiTtfYj1Q9F8qsrVyOpI2nYe0z9weNfU+IJyyRjvBBq0lKE7nKGtsd1QghJA4=
X-Gm-Message-State: AOJu0YzHCZ4KjYCkUk/dFboOTsR1UfXInvS4hxBrnnI/l65ZAVi8xJfO
 DR7XgDpFvyRIpR4F04okmXIkrJrYfR9XCfBZp0w+4FxpxdWsjNv2/MGrsenfjFs=
X-Google-Smtp-Source: AGHT+IElwHbM2gpEGQOrhIrWBwz/YQiPgwjoOd6z7pbg8Cz+T2kIVqIP05YKnCvu84H+qUt2UHz9HQ==
X-Received: by 2002:a5d:4a85:0:b0:35f:cd7:5ba1 with SMTP id
 ffacd0b85a97d-3679de9628cmr6637713f8f.60.1720427288257; 
 Mon, 08 Jul 2024 01:28:08 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.169.151])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a43e9fbdsm8810295f8f.103.2024.07.08.01.28.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 01:28:07 -0700 (PDT)
Message-ID: <86e04959-4d48-49fd-b065-a9288a7b064a@linaro.org>
Date: Mon, 8 Jul 2024 10:28:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] virtio-snd: add max size bounds check in input cb
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <virtio-snd-fuzz-2427-fix-v1-manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 8/7/24 09:09, Manos Pitsidianakis wrote:
> When reading input audio in the virtio-snd input callback,
> virtio_snd_pcm_in_cb(), we do not check whether the iov can actually fit
> the data buffer. This is because we use the buffer->size field as a
> total-so-far accumulator instead of byte-size-left like in TX buffers.
> 
> This triggers an out of bounds write if the size of the virtio queue
> element is equal to virtio_snd_pcm_status, which makes the available
> space for audio data zero. This commit adds a check for reaching the
> maximum buffer size before attempting any writes.
> 
> Reported-by: Zheyu Ma <zheyuma97@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2427
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 5993f4f040..e6432ac959 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -1261,7 +1261,7 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>   {
>       VirtIOSoundPCMStream *stream = data;
>       VirtIOSoundPCMBuffer *buffer;
> -    size_t size;
> +    size_t size, max_size;
>   
>       WITH_QEMU_LOCK_GUARD(&stream->queue_mutex) {
>           while (!QSIMPLEQ_EMPTY(&stream->queue)) {
> @@ -1275,7 +1275,12 @@ static void virtio_snd_pcm_in_cb(void *data, int available)
>                   continue;
>               }
>   
> +            max_size = iov_size(buffer->elem->in_sg, buffer->elem->in_num);
>               for (;;) {
> +                if (buffer->size >= max_size) {
> +                    return_rx_buffer(stream, buffer);

return_rx_buffer() could be renamed
flush_input_stream_to_buffer() for clarity.

I suspect virtio_snd_pcm_in_cb() has a high complexity. Anyhow,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +                    break;
> +                }
>                   size = AUD_read(stream->voice.in,
>                           buffer->data + buffer->size,
>                           MIN(available, (stream->params.period_bytes -
> 
> base-commit: b9ee1387e0cf0fba5a73a610d31cb9cead457dc0


