Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6E0CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:47:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Vr-0006n8-FU; Wed, 29 Oct 2025 09:46:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Vl-0006cb-Hw
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:46:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Vb-0003EX-E7
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:46:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4710665e7deso38818155e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745594; x=1762350394; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z28ZgmiJC98xG744tnvm/mLyRQR8+/6a2JjELzwEK+8=;
 b=uDvUx0p6lKpAHEB3skcFw22s5kFji73b2XQ3oiQEFdQF7eWEdotxNnzRUNQTRk+DHy
 jdT9OatZWeSoI6U87Da/Ksn3Ukw3djylkUHk2CR45878tjHWDYFLv4rmXlTIVzKDpO/t
 boQaweBGStZMo/s9RO3TfTfSxPkpoEfVUhCimxP8ESY4nZBFLnk9NHpyu1jTW8+YjYEe
 3u+AUNpvnTU0aMVe5/yDinZJl+xLUwSTBycbmKqtmyqGEQGx3hyWRDvBHpMgUrp7NTee
 8yectzepwgIw5JmAuvrQnYNhQ/hjgawZKK5jmV1pb6WB75IbaY17T6gGn477smwLWpaH
 PZbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745594; x=1762350394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z28ZgmiJC98xG744tnvm/mLyRQR8+/6a2JjELzwEK+8=;
 b=S1WiiWtoiBG74iyIxcQkvieBJdHNjGe2OjCd+bl+KlHRtw+/JDrtuQ6mv8hKLRhElg
 hox+mPYB2i7ySmdYzbrhQAS0Sg/qjPqG2HhhUH2gmJNwswvjFti6i4qJGZ915FOo9lOx
 Qnajqie7/5prfwTGAe3VC3+VBceL4r1oeHdtSZifvSH1LPflUgMSTWT7i0isYq1zZfrk
 kKisz1ufVilil/+4VMfH+xP1fl63yM74NZeBXQyV5lamuuksCvtCYcWNOqmEeDOIMNsj
 wFDv1Lfx/QwlC75AM6EyQP1qXxmw5bhNhX7fNSGFVVE2JDpJen4OSwaCD8+4NLzgOWYk
 CKtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3V4GM0aq6bniAyrZjo1xSGLIpBkaDELoCQ/ov/Cxv/l37mdX9y1b//vOR+P5V2WjD5PA5y3a4UuYr@nongnu.org
X-Gm-Message-State: AOJu0Yz3Zr51FlOxQ6HcvoCtrs8U5+MAK43ijZC/5GuJPcmw5fs11rKn
 gGVCq2gUIMoMzo2HKNy5NuA89HPElypndvE7Dd6DkDojV+lAN5PK/SInw64kbCUtjuU=
X-Gm-Gg: ASbGnctTJPooppX6FdvzDEuWfUhpAnOgBa2qkXtZeWvJ+0ZfGOYxfFUyt+VRrRibZgi
 40tUQgay5tz46h7lmisd9xKodGwsXd4nxReLxu5U1j5gNWkuh4wSV0bRJuItKStVnOtOHv1M3hZ
 H1RcRBzUrlvgX20Dnmz6pD8c3ui7eUbC/2xNHcjkDEh8yXzF+QMKs00FIA5J8fXSdEKTJLzcqP7
 TAfWt9N/H3dxL8BHOlkb9vZya8n3HeXDfH+3Jq/Fah5RjW4cK2sD7J2oZ41d78Un1XmiZ7XFqmx
 Td8CDWwv5UmxUCFcZnkHTZ10sw7ksTgBxvE3L4lXW8DsocYFT6wpXBDaBslYnlvfnug/9wsLjNo
 BSEgAeiYzn9WAHQM2aHjeVl6IJ41gDw1H6/7NcghPoI8QLvirVcOWjfgVcxP3eNVZDLivwIKdHv
 KS5WBsk5/CN8Cea8AbE3uG7C+xPc/kBpQ4VH14W5pZYAU=
X-Google-Smtp-Source: AGHT+IFIu73iiIADnrroCFGtvADc8jRFxaiWtlWiDzbPB81VMgN4QXbSZR1uA8Q2DELznMuRB4CHTQ==
X-Received: by 2002:a05:600c:530e:b0:475:d8f3:71c1 with SMTP id
 5b1f17b1804b1-4771e1e01a2mr26474835e9.27.1761745594359; 
 Wed, 29 Oct 2025 06:46:34 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e20205esm48034695e9.12.2025.10.29.06.46.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:46:33 -0700 (PDT)
Message-ID: <75120e9b-9362-4898-96d3-dec9cd7e137d@linaro.org>
Date: Wed, 29 Oct 2025 14:46:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/35] audio: keep vmstate handle with AudioState
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-19-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-19-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> QOM-ification continues.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio_int.h |  1 +
>   audio/audio.c     | 12 ++++++++----
>   2 files changed, 9 insertions(+), 4 deletions(-)


> diff --git a/audio/audio.c b/audio/audio.c
> index 155809dee7..4c3c3fd52f 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -1622,6 +1622,9 @@ static void audio_state_init(Object *obj)
>       QLIST_INIT(&s->hw_head_in);
>       QLIST_INIT(&s->cap_head);
>       s->ts = timer_new_ns(QEMU_CLOCK_VIRTUAL, audio_timer, s);
> +
> +    s->vmse = qemu_add_vm_change_state_handler(audio_vm_change_state_handler, s);
> +    assert(s->vmse != NULL);
>   }
>   
>   static void audio_state_finalize(Object *obj)
> @@ -1671,6 +1674,11 @@ static void audio_state_finalize(Object *obj)
>           timer_free(s->ts);
>           s->ts = NULL;
>       }
> +
> +    if (s->vmse) {

Already asserted as non-NULL?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +        qemu_del_vm_change_state_handler(s->vmse);
> +        s->vmse = NULL;
> +    }
>   }


