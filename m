Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCEBFC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2024 07:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0cVR-00045H-Os; Sat, 27 Apr 2024 03:29:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cVQ-00044p-92
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:29:56 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0cVO-0006ZE-TQ
 for qemu-devel@nongnu.org; Sat, 27 Apr 2024 03:29:56 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2a2d248a2e1so2916590a91.0
 for <qemu-devel@nongnu.org>; Sat, 27 Apr 2024 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714202993; x=1714807793;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XKy6fmMs4iP30kgtlzlihIZr/vsOZU/fzqqjAR3na/M=;
 b=JtsufhA1r7wC/HCQflm1XwNMR11g/YrWDjaKmM52igkIdJS6rEujs2ciGHYRpZPK+a
 a8eo69WF4OGv3zYANtCIczPxvIT89T8nVHew6ZfR1Odr01S54dXEcLRHBfd7uavM3gAr
 GYaohsag7DMrF8SttA3GbGMlCwR1G2pDh2SuYvKUszSnPjypkSJOhXQSm4Pd7IAj2SjV
 lFv2dGA0vDEk5ylwhZZUvY8xpqB52CPvQbrfeenNAmH38T8KnkXHLoGUOLOTA1YAYkF2
 hG4YPBA0KPHrKhAoNEYKvd3vjKuWjd25WTCDsGMJmplRBJMn9JfHzkpCujdtWOD34rxU
 +4kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714202993; x=1714807793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XKy6fmMs4iP30kgtlzlihIZr/vsOZU/fzqqjAR3na/M=;
 b=lYGtmwhyZ/mlpMUNVsx9QVPEU96BRV2l4hy1xz7NhFRpG0gc4x/R7jcabOUKSYaak2
 7tB7FmbxcagF8X0y9ZXk0otIIyOlHZEXghccldCRwxiYO+9FtdubTUq20gDJttSqBD36
 DKpwq3gM5IG69jDD9HZiWzJ1HUM9a4AiJdIne3fY951ZhbvVdtygvMq4TeFV7G/f3GkW
 xbDG8fjtlatMfjR50PBreauBdnTSR9DVn9mS3FaUpGBMnI5n6Au9Mb6wqhHkYj9G9rJy
 se3PaA8sKIURQjG6YXgE/PFGu3KAnLGaoHukHrubz2pGMpXpR0vjp0VmSqMOXGwaDwP1
 l4/g==
X-Gm-Message-State: AOJu0Ywz4h+EXDS6ZJqSipw565IuDx/OyLaQfmpjuj60hmGzPc6kdvbW
 WERSNrFZvPf2S50y/JjgFH+Abg6b+PyHeb7sRADZWEV5vB/gk6P5PG9oexM0GqA=
X-Google-Smtp-Source: AGHT+IH2N5A+zUbaosrdkg8bO2tJbDH9BikduMCyD2xqC4vbQ8BWHqIa7+LaQI7SLuBUBLasdzEjmw==
X-Received: by 2002:a17:90b:895:b0:2af:de3:f0e3 with SMTP id
 bj21-20020a17090b089500b002af0de3f0e3mr6560288pjb.23.1714202993273; 
 Sat, 27 Apr 2024 00:29:53 -0700 (PDT)
Received: from [157.82.202.162] ([157.82.202.162])
 by smtp.gmail.com with ESMTPSA id
 ck16-20020a17090afe1000b002a2f6da006csm15646850pjb.52.2024.04.27.00.29.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Apr 2024 00:29:53 -0700 (PDT)
Message-ID: <02330b56-da79-49b6-8916-74c3bf68fd75@daynix.com>
Date: Sat, 27 Apr 2024 16:29:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/11] virtio-gpu: Support Venus context
Content-Language: en-US
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony.perard@citrix.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Robert Beckett <bob.beckett@collabora.com>,
 Gert Wollny <gert.wollny@collabora.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Gurchetan Singh <gurchetansingh@chromium.org>,
 ernunes@redhat.com, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Yiwei Zhang <zzyiwei@chromium.org>
References: <20240425154539.2680550-1-dmitry.osipenko@collabora.com>
 <20240425154539.2680550-11-dmitry.osipenko@collabora.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240425154539.2680550-11-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1036;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/04/26 0:45, Dmitry Osipenko wrote:
> From: Antonio Caggiano <antonio.caggiano@collabora.com>
> 
> Request Venus when initializing VirGL and if vulkan=true flag is set for
> virtio-gpu device.

Naming it vulkan is a bit confusing as there is also GFXSTREAM_VULKAN 
capset though virgl does not support it. I think you can just name it venus.

