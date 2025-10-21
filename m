Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B26ECCD1AA
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 10:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB99P-0001Dd-NE; Tue, 21 Oct 2025 05:59:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB99C-0001DI-2a
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:59:19 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vB997-0002yf-1Y
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:59:15 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso4143057f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761040751; x=1761645551; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d5uaF7+pUnU3aSevWsBmpC+HpDp4hJZMzzoI7TT8nSY=;
 b=hj0kI8RujDd5SG8QNCFREzgFUSydt0x7dtk2abSwGYrwxTtenloBKwbBzsaaPBeaaY
 B5/h6jI3vrtcm37DsiVzL8bQLTXHZqI4AJ6fG8YKqcSGU4wA3pUlZ0/4rQPtdFMm7T28
 K/eerFRnCb+ZrTEzQQfmPIz9ZKdKeHGanfbe+K+c79YpVoP/MzqXOSI9UTItkSQlluUH
 Cv1GIgf8c/M3tzEdP96uvP5RW+3NnMUzd+ARsImCgQ/bO3zbJU+17NHfBUk3wEUQGDgt
 E+8KdXe0MlVVyhX3veqNP3OMqaUM2rro2IFB8nc3OrCFcWQXecIyXYFtG62Ut4KZ4yiZ
 62aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761040751; x=1761645551;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d5uaF7+pUnU3aSevWsBmpC+HpDp4hJZMzzoI7TT8nSY=;
 b=Zxk0Cyx1AFcVa9usjlHOXVFN85Yk8FHfrCq8XZiTDNlAXHE2Fbgfye+I3q0VuWks3C
 PmTnbPPzwFXxC4s6AALM9KSv0G4Ze70dXx7EkF1aDU85wkeiyEk/gOm76wY5s7mqZZuo
 rsRW+tl91971wCjzlVGx1C7gDkqZZ8XNOLtmdeCWEOeY5kSF6U1Y6lpQ8bwbJFRwEDS8
 Xz9n5iyPnX6+dSZYyk9NGW06iMmnkS7pWJ4hZ55pfyOftj+nRWkzn4Bat/Emh38182Gu
 jx+JqRC2KsSmLSUVpuOstfA6h39hmSCSbtJdcmpln6tDEVyRD9rT1Rdsa6ySkF+xFKi+
 Qo+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW2HWwI4qmLi+tGr+TXtcfWE+CJRyKqo0+PfY4rOGEbZQFfyO7dyr2GUlS6cj+S4xQmLGzT6YvIjD9@nongnu.org
X-Gm-Message-State: AOJu0Yy2PNSiCEmISsE6c8dyxNzHq0LpRiM7LeRENLi9GRHnApViBLwn
 EnnkIDHo7ECyxG5s+rRTWcoQ1hRiR1shGCKzNXm7ovx9ON9+9B5j/JaQScBfxz4xd1M=
X-Gm-Gg: ASbGncvIoRiymLUYDQG0DBsUpS2NfcJOCVH3oObCzWcxqycENCzJzVGb0iv8gcR161k
 CYx+aEPy7W9gmXgGuuPC5R6OFc9+eYZ4oDTrk03lFZFgFTI2yAWI6DuNRjqkegowpT4+FGWC41W
 +wamEtWt1mbVK348/VxBm7Vk/LU6SZWjH3AXpIoYfHHSo0Q/UoLWTj5P664OPud9yMRsaNOBHzw
 DOgGr5QR3ONaJYb6K+yIMocB5Eul0/hPyLm0496gQjUCGQwJY9BbiGh5FfKYDo6CWVRKYSsGnUQ
 KL4/xjBePyfuHjYpBpAdPnRmNvCCnX8sFlWF94NolCM3LNrZjYxqHJ6D7oH5yPj5F/PByhaLVFX
 hz4KwnBVWoG9frKq1iksxFtJTRc4xB5JDhJU4GJV7XRcLDDyRmIBoH5FvlsRZ+HTG75iTvjLryZ
 rc5tdPgQnyEZMgpFJpvs1Wcbk9xthHJLEjYm6YTMKtRXAz0d3sDeqAng==
X-Google-Smtp-Source: AGHT+IGJy8UDTUjDUl/JEKOt1ASrmp/wL63Ng0lsxfHT7V+SP9tJjsNsUgT6kLl/GAt25nFwm2j0IA==
X-Received: by 2002:a05:6000:2f83:b0:427:4b0:b3e5 with SMTP id
 ffacd0b85a97d-42704d99d9cmr12136964f8f.47.1761040751179; 
 Tue, 21 Oct 2025 02:59:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00ce08asm19395822f8f.44.2025.10.21.02.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 02:59:10 -0700 (PDT)
Message-ID: <05aa8f94-06f2-465d-939b-5db6eb607e0d@linaro.org>
Date: Tue, 21 Oct 2025 11:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/43] audio: register backends in /audiodevs container
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-18-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-18-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> QOM tree now has /audiodevs objects.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.c | 8 ++++++++
>   qom/object.c  | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/audio/audio.c b/audio/audio.c
> index 754952ce58..4714ed0b9f 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1726,6 +1726,11 @@ void audio_create_default_audiodevs(void)
>       }
>   }
>   
> +static Object *get_audiodevs_root(void)
> +{
> +    return object_get_container("audiodevs");
> +}

Move before audio_cleanup() to avoid next patch churn.


