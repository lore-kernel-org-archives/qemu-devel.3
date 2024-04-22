Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDF3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 13:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryteD-0008HJ-5f; Mon, 22 Apr 2024 09:23:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryteA-0008GK-9F
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:23:50 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryte4-0003nx-9d
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 09:23:49 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-346b96f1483so2302600f8f.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713792212; x=1714397012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hc4R+lZ3Hhrne5kZXr/KB8X2diK7U5N0ETAlZ9ofwpk=;
 b=bmEeg+54Xfo4xq3E8z32Pu85BZn2E7E1vPHVfxINzaWhw1GKotCdtMUtiR0QBOFOO9
 +fahuIdU6XGWnyZJXMB8igrUY+Htef+omBiTFu/ADS+uZUIO5mzBphBe1YaBaOvFeQ1f
 yEa0Yp4VjPhXfFEpJyQ0KxwwSd2Wg9IpmEk8+iqae0YAZVIishEdgjDuKEyhRAQde4rp
 M1STcBWJRpy5VsR7HOkOg5YwR1Rzq2fQlmQpvHE9sjwDGyrEEIC1Fwi0G98zUT5bi6lH
 7iT0ADs43wU1QYO/tTqqYaVVtAAvlX2Io8eTMEUrxzOA5Ifhmt2uiK2yCJz3k/jmWfAd
 dj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713792212; x=1714397012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hc4R+lZ3Hhrne5kZXr/KB8X2diK7U5N0ETAlZ9ofwpk=;
 b=kLHLUFzp2Qzoz1ZUNYKP43X3zznxYLlvNdTSMmKtz0DU/fAIj8mxYiDxfHD2n158p7
 I8gar+St1yMBcFPXoW4vQuiSZ4k5iWzceCleRD69rIkAPzKI+7xyGs93kGzVIFP+b9Za
 3VTINqj8i+JWyCbGgcOeBS259CqmqbKUZyjXF/UU+rZc2LAqa8Hw4oKJ3QhUFtdv4+am
 P53WZDCuU9tzoFUYKF011XHDBHqNgppqpi4zMnYI90gucDgPOMpegKJbcOgXAhUF3jUN
 obz38sKLhjIx7ahF27pF8rWiMxL2FHMN79Q1BHKAmi53WzA/SspaA6v2BSD0I3pRfD90
 HHog==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY5nmUISezbL/elfhR58F+dGp8V31oyR7Kj8SGlddra8AosGYDy94feSOFaTYfZZmYgmGFyPSAO/7IK90S/glyx8RPvjM=
X-Gm-Message-State: AOJu0Yy+nauUfHXuPZOlgOfyUL7ogZwe0Cv4Do7SJgY7Tc1YHxiVE2+5
 RRylmRfQ4xZv8DAnLbRQ3ePnFpj1sa+m14tjY8SEBZuZpc7T8pw9HLjgKsG9nis=
X-Google-Smtp-Source: AGHT+IFQhIRRdnPcPET5wQHEdkKiU6hud1PdEzxs1vbbYZH29j0hwOBAN1kd4CBQGMp+UBrC9q3R/Q==
X-Received: by 2002:a5d:4a8e:0:b0:343:ce15:fd3f with SMTP id
 o14-20020a5d4a8e000000b00343ce15fd3fmr10691996wrq.29.1713792212084; 
 Mon, 22 Apr 2024 06:23:32 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 u18-20020a05600c19d200b0041896d2a05fsm16541432wmq.5.2024.04.22.06.23.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 06:23:31 -0700 (PDT)
Message-ID: <095032a6-df77-44b3-85e5-750993332a26@linaro.org>
Date: Mon, 22 Apr 2024 15:23:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/4] virtio-snd: factor card setup out of realize func
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zheyu Ma <zheyuma97@gmail.com>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
 <62de737e3320e647454a306bb87c6eb20a2c0cfb.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <62de737e3320e647454a306bb87c6eb20a2c0cfb.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> Extract audio card setup logic out of the device realize callback so
> that it can be re-used in follow up commits.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   hw/audio/virtio-snd.c | 72 ++++++++++++++++++++++++-------------------
>   1 file changed, 41 insertions(+), 31 deletions(-)


> +static void virtio_snd_realize(DeviceState *dev, Error **errp)
> +{
> +    ERRP_GUARD();
> +    VirtIOSound *vsnd = VIRTIO_SND(dev);
> +    VirtIODevice *vdev = VIRTIO_DEVICE(dev);
> +
> +    trace_virtio_snd_realize(vsnd);
> +
> +    vsnd->vmstate =
> +        qemu_add_vm_change_state_handler(virtio_snd_vm_state_change, vsnd);
> +
> +    virtio_init(vdev, VIRTIO_ID_SOUND, sizeof(virtio_snd_config));
> +    virtio_add_feature(&vsnd->features, VIRTIO_F_VERSION_1);
> +
>       vsnd->queues[VIRTIO_SND_VQ_CONTROL] =
>           virtio_add_queue(vdev, 64, virtio_snd_handle_ctrl);
>       vsnd->queues[VIRTIO_SND_VQ_EVENT] =
> @@ -1123,26 +1149,10 @@ static void virtio_snd_realize(DeviceState *dev, Error **errp)
>       QTAILQ_INIT(&vsnd->cmdq);
>       QSIMPLEQ_INIT(&vsnd->invalid);
>   
> -    for (uint32_t i = 0; i < vsnd->snd_conf.streams; i++) {
> -        status = virtio_snd_set_pcm_params(vsnd, i, &default_params);
> -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't initialize stream params, device responded with %s.",
> -                       print_code(status));
> -            goto error_cleanup;
> -        }
> -        status = virtio_snd_pcm_prepare(vsnd, i);
> -        if (status != cpu_to_le32(VIRTIO_SND_S_OK)) {
> -            error_setg(errp,
> -                       "Can't prepare streams, device responded with %s.",
> -                       print_code(status));
> -            goto error_cleanup;
> -        }
> +    if (virtio_snd_setup(vsnd, errp)) {
> +        return;
>       }
>   
> -    return;
> -
> -error_cleanup:
>       virtio_snd_unrealize(dev);

We usually handle failure as:

   if (!virtio_snd_setup(vsnd, errp)) {
     virtio_snd_unrealize(dev);
   }

>   }
>   

Otherwise LGTM.

