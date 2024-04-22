Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8614C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rythU-0000oj-T8; Mon, 22 Apr 2024 09:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rythO-0000n0-I0
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:27:13 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rythL-0004dS-SZ
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:27:10 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-41a7ae25d53so4520875e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713792423; x=1714397223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9KaQ6yHjZllPDqJMSOEy8UUEvFpcXYG2YK89IKG5exA=;
 b=NugctTtwvnFnEwy9LTh3NSVa76B5+De0ltpL97jdErGvmjoDJuNPqAgjNTZK9R3O/k
 Y+OA7oU30D69/a7a7rqBulOFohIpU6uhV4Oi0/7iCGdD6nmBRmYmF9IC3dlwjPSwiouB
 YV4KiH/GQomrohCb+TDuVRnSnDcoHA36ujR+Hpl4+C/3s3bFk+50fEeWV02F1UI3JAXy
 x/EqZiPgevxh4i/5Uuw7t2DIc7nLdWZw88eLhbI5uzQl6zELd2RzOrudjIcCW4LJgpWR
 Dz8Je1jzD2RP4inU3Rhbu2kKcY8Vz1vPeKYogYFUogNHy1cUqJGsfqZvU1Sd0Wbd3trh
 S+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713792423; x=1714397223;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9KaQ6yHjZllPDqJMSOEy8UUEvFpcXYG2YK89IKG5exA=;
 b=uKJXk4OSIMQmJkCbVqzaT7qwpA+jfLBMmtRsPHgqpYuKS3sS/+fqf8u+eR40koqT1S
 OxaT/S3s4AogeaiXPlNb8qmUCAJH3Hd6y+jQ8jhr1oy3Fbg5ntRIijLJacalrKgi+g2q
 lQl5H8n9nHrYTbd5obtAqy+GW0oXqr+OF5WWdepy7KZRyHJMpR4pY16HzeuDl6FgYyCF
 bvkcHJOvJb5WFU/NpVZko7dNLAsJLprIaJnD/M3uWIlaNZtKnNhJHVYTSRejSQthpTx5
 pZpxB2t1Nyl6+wLeWDfllPim1nlxg+4M3tCLyYu+QsHMlUAtok64ltxHppFGt1QpdtRg
 ecxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL7RIFKB+976F9UxXnJ5dBVoXAvFuRG70KstQhLkcw2csmTFAXyrGFXBj58pkFzOO+0oIrZFFLX2fKoDgVnKWYJXiEQGI=
X-Gm-Message-State: AOJu0YwXlZPISGXmHo0o/zYyaWc2Dg+J+4sjVD6omRxjE4L82YMZAj4p
 fQ18ExtrgmMP46C77zhJHBlGZAehXOL0kx6LmZzeulHkjOhhpyZP1iYODwoOthhkNOABPRdaK/G
 l
X-Google-Smtp-Source: AGHT+IHPreg33lXalOo8VlUYmeFbGCchXIaSwXoQwJEDA6fVhJucMbYhWIIr3ly52g+bAbed6k1xuA==
X-Received: by 2002:a05:600c:4ed1:b0:418:2ccf:cbc7 with SMTP id
 g17-20020a05600c4ed100b004182ccfcbc7mr6439528wmq.2.1713792423330; 
 Mon, 22 Apr 2024 06:27:03 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 e5-20020adfe385000000b003455e5d2569sm12262383wrm.0.2024.04.22.06.27.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:27:02 -0700 (PDT)
Message-ID: <2ebc4f49-4d50-4ad8-9d44-eb6ef2ff0066@linaro.org>
Date: Mon, 22 Apr 2024 15:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] virtio-snd: factor card removal out of unrealize()
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zheyu Ma <zheyuma97@gmail.com>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
 <2231ee9229ba7259763c9814e6ec119d8954b81c.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2231ee9229ba7259763c9814e6ec119d8954b81c.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 22/4/24 14:52, Manos Pitsidianakis wrote:
> Extract audio card removal logic out of the device unrealize callback so
> that it can be re-used in follow up commits.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 20 ++++++++++++++------
>   1 file changed, 14 insertions(+), 6 deletions(-)


> -static void virtio_snd_unrealize(DeviceState *dev)
> +/* Remove audio card and cleanup streams. */
> +static void virtio_snd_unsetup(VirtIOSound *vsnd)

Maybe s/unsetup/cleanup/?

>   {
> -    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> -    VirtIOSound *vsnd = VIRTIO_SND(dev);
>       VirtIOSoundPCMStream *stream;
>   
> -    qemu_del_vm_change_state_handler(vsnd->vmstate);
> -    trace_virtio_snd_unrealize(vsnd);
> -
>       if (vsnd->pcm) {
>           if (vsnd->pcm->streams) {
>               for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> @@ -1370,6 +1366,18 @@ static void virtio_snd_unrealize(DeviceState *dev)
>           vsnd->pcm = NULL;
>       }
>       AUD_remove_card(&vsnd->card);
> +}

