Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E10CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBTpR-0007he-6n; Wed, 22 Oct 2025 04:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTpO-0007hO-Qd
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:04:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBTpM-0001OJ-FZ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:04:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3ecdf2b1751so3932918f8f.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 01:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761120250; x=1761725050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Mvry+m78wLjS3xG2HLg1gJnJN9aP8X25PCNMtTPet6c=;
 b=suRUmJjLxznKt4jiU/HcpTzgYUXe6iIcvwJt/rxcc+p2VCTmsPGRbjBiCCuyHwUfsU
 0qUbODCIZeSj3PiBuX6xgjuMktOwy67BjfXhactzvGNlcy/Rdg1b1pW9kM8vlAVWoGbT
 nvRzFq8cDQR3uQg1tsl/OmNn6ehSZkMvcHYLFknHTu+LqvrwEXvWRQHPhvFjOOac8wq+
 nG4yuPVTO7AjgB68BtJuOiGLCLJS2XwPqlkbusigJG3Tyx+cmsURKTyVonTNrpEQOe1X
 rtiEdGGKW8x5QOVTG/HGi8fLHuKuQgc6YhCvWixNAXNM3q0KRySLHmR/wIsBdtznutcP
 r1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761120250; x=1761725050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mvry+m78wLjS3xG2HLg1gJnJN9aP8X25PCNMtTPet6c=;
 b=SMgsaX3IkDmCskIlO36GH2Q55Sak7ozB27pvnztT1l1zskMXCBpMewrHZjXanfXqkE
 sh3OjS1rPIE+znPC1YudKzXKGJt/Bt1aQAi0dQvOkqkD8Vt65mT98m74qZqDriBzM71B
 vdz+i7Ykk3af+HId0+VZ9tW8dhx8OardIKXQZFfCN6PjtyPc89MRJs0ea0BdjMiNcMHZ
 WMH9axm0wMOBpnP+a6lJ9nrMPQZP6DrdVOHkXLwdZWNjJwqUv5JsR23m7oOHYdx/wK8Z
 eLzBRBwDRwF7k+GOrR77a3Hl78zT33/k6Re08WxSJEY4KvPIa4+Jl+IWff4UwH7zAxn9
 y2Jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/DEA+iKcQ6UJ5EiWEaV8nOqyUohd6QWNDQXezhqIbqG11/TiR+4XG0RwL6LRqPxRQ99j6dc38Jl+3@nongnu.org
X-Gm-Message-State: AOJu0YzxTub3wriaQqY0kBi48Pv4kQ+4Lqpfc4cLz0G6Rt9oFXsT4XBA
 hcML8S27wmOgSSym2Kxf2CebIbpSSG5N3tEM3iUH7tqHnX516u8R55xMP46EXgLT+tw=
X-Gm-Gg: ASbGnctn0tcoN4BolwUz3zdMwDvoQtZ3b1fnrpGCuI5fIzZrNjcrlKS06+0Bh5dp3Qd
 v5U86C1rv1r90xJV/KMDJDLIzRxYJRz7+nN6+A6LIBujMrAZzPY1pG52ewUewXIOPuv5GpIlS3p
 ucGelcFsE8E/CpK0LL9VYB4i6g+MlUC4jJaTuMPL2zCoSISUHu0Qg/lahg9TvvtFU212qVTk+b8
 UEVnphgTxOy+GrIHnn3k5Jv17/OKiMWM9YKcANJBF1TS3ELiBijbfFK7B0usGZB7ZVAK0SRQOqX
 tQzwkBqQ65Di8QVkFu7VtzDz5Hni2t5rRJkEyphgBfVNkPrg44danZ+b5nnY5rbg7XEqyrEEXv/
 CBspprHnpwY2zDqZUafz/tTXzr6gKJvHGCER19WczKCF2iWZgS194L9Wt5Sj4GVCyRBWl2g9e36
 OwEyH1tJmvMfmYYXX1LcSq0YzKqKUqQ0+LzS2W5aAEWWY=
X-Google-Smtp-Source: AGHT+IEbIjcq8R2vEYjVhpQLgR+Kv4l2G8tjxvo1oaoFacA4JaYFCs0yApsa5UHgbqTIS591W5bMuQ==
X-Received: by 2002:a05:6000:22c6:b0:427:15:ff3b with SMTP id
 ffacd0b85a97d-42704d145d4mr13262303f8f.13.1761120249986; 
 Wed, 22 Oct 2025 01:04:09 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b988dsm24406219f8f.35.2025.10.22.01.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Oct 2025 01:04:09 -0700 (PDT)
Message-ID: <88445f7d-dc78-4b66-8129-d8abe1e19a8c@linaro.org>
Date: Wed, 22 Oct 2025 10:04:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] hw/audio: use better naming for -audio model
 handling code
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Paolo Bonzini <pbonzini@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20251022065640.1172785-1-marcandre.lureau@redhat.com>
 <20251022065640.1172785-12-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251022065640.1172785-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 22/10/25 08:56, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> All the functions are about "-audio model=" handling, a simpler
> way to setup audio. Rename functions/variables to reflect this better.
> 
> audio_register_model_with_cb() dropped "pci" from the name, since it
> will be generalized next.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/audio/model.h                      | 13 +++++
>   include/hw/audio/soundhw.h                    | 13 -----
>   hw/audio/ac97.c                               |  5 +-
>   hw/audio/adlib.c                              |  4 +-
>   hw/audio/cs4231a.c                            |  4 +-
>   hw/audio/es1370.c                             |  5 +-
>   hw/audio/gus.c                                |  4 +-
>   hw/audio/intel-hda.c                          |  4 +-
>   hw/audio/{soundhw.c => model.c}               | 58 +++++++++----------
>   hw/audio/pcspk.c                              |  2 +-
>   hw/audio/sb16.c                               |  5 +-
>   hw/audio/virtio-snd-pci.c                     |  4 +-
>   system/vl.c                                   |  6 +-
>   hw/audio/meson.build                          |  2 +-
>   .../codeconverter/test_regexps.py             |  2 +-
>   15 files changed, 64 insertions(+), 67 deletions(-)
>   create mode 100644 include/hw/audio/model.h
>   delete mode 100644 include/hw/audio/soundhw.h
>   rename hw/audio/{soundhw.c => model.c} (68%)
> 
> diff --git a/include/hw/audio/model.h b/include/hw/audio/model.h
> new file mode 100644
> index 0000000000..27ae7dcc31
> --- /dev/null
> +++ b/include/hw/audio/model.h
> @@ -0,0 +1,13 @@
> +#ifndef HW_AUDIO_MODEL_H
> +#define HW_AUDIO_MODEL_H

Pre-existing, but add missing license tag?

> +
> +void audio_register_model_with_cb(const char *name, const char *descr,
> +                                  int (*init_pci)(PCIBus *bus, const char *audiodev));
> +void audio_register_model(const char *name, const char *descr,
> +                          int isa, const char *typename);
> +
> +void audio_model_init(void);
> +void audio_print_available_models(void);
> +void audio_set_model(const char *name, const char *audiodev);
> +
> +#endif
> diff --git a/include/hw/audio/soundhw.h b/include/hw/audio/soundhw.h
> deleted file mode 100644
> index 83b3011083..0000000000
> --- a/include/hw/audio/soundhw.h
> +++ /dev/null
> @@ -1,13 +0,0 @@
> -#ifndef HW_SOUNDHW_H
> -#define HW_SOUNDHW_H
> -
> -void pci_register_soundhw(const char *name, const char *descr,
> -                          int (*init_pci)(PCIBus *bus, const char *audiodev));
> -void deprecated_register_soundhw(const char *name, const char *descr,
> -                                 int isa, const char *typename);

Please mention in patch description why this interface is not
anymore deprecated.

Otherwise,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> -
> -void soundhw_init(void);
> -void audio_print_available_models(void);
> -void select_soundhw(const char *name, const char *audiodev);
> -
> -#endif


