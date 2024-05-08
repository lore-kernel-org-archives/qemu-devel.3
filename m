Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E7DC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 10:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4eVO-0005to-KX; Wed, 08 May 2024 06:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eVG-0005Y5-5P
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:26:26 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4eVC-0001zg-0Z
 for qemu-devel@nongnu.org; Wed, 08 May 2024 06:26:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59b81d087aso920470366b.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 03:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715163971; x=1715768771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D0Q5oiPM7dyDgAaCwWu0Ce4QGeAt0o1QFTACahbJUjY=;
 b=C79jdEFX+bE47ASgtds8Zm69YcoCBJ8RNNIn/M76SmILxiyglk1sIvWaY98cvupEUU
 Ja86boaspuNFGIbpujDbJB91CZbT5QR8EEt0UjUgKPl/znuTu8CgQKEYruc8DLJkd7kM
 5mr3qce9h5/2RPFbEM/EK1qbtFTR6y2CWp9AaW3JFHlqFUdlAVI0UXHMLrmhzDI0m3Q0
 yp0VACVEN02Bvnl9LHZE4ZugFhxPVjzr1MPDIgJ6aKQkFbbch0Bso2ZT9UO5UMzzaVqD
 T5TrTxQTOpqEs0idAZhkRpHiPaPisVkZqgvALV2ErULItPjpICU0GRaVwwF5rnt6bILR
 IgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715163971; x=1715768771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D0Q5oiPM7dyDgAaCwWu0Ce4QGeAt0o1QFTACahbJUjY=;
 b=YJovzJsea8rIoZodGvt11lY+ZeO7UdvpkEJ6b5rVId7nuqZ84QbDvcmN4J6FjPACCx
 SgfUoa97Jl1lNBnj+TEFRbAqLkqw4QbDHtKfrVzy8LwzIQ7w0UjcsQzZ3xGt97s1K5H1
 gx6bBH3S7ewRqHH1uNT+kO07BA5N2w8xQnCO1u8nAjFt3s0Bz3r4jSbOAICDM0jUBNiN
 /T/gk2xnGqKBQT0hOcGA2i84DNSltoQ3tcRMdy9QHMJhQuKIWLr7b2il8+5O/rt4u+qJ
 ppt4NjfliPfSXozMgoJmRZo1XfM4tjg6r50iKKAXdTqw+esCLeenqX8DhvYmcFbnGEre
 r8DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4QtDhts66AqxI9MY3mE/MW5HhdsbargmTGjUC/HDnBg0sp6eaIGtpVi29JME3Iabu0Ox3QL8CT25XTLBpwJlp5ZqiqC8=
X-Gm-Message-State: AOJu0YzQRBNrgiKIGDWgcvV4lV/3BFqpNRbXjbH7wd/UNDBsnsUphyqY
 X2+40M1j8/Ms6/B4Cw9TewGEIE67jDXBu/1O1PXFun2SNAcX6cT4USAnIh5/wDQ=
X-Google-Smtp-Source: AGHT+IHHKIXcimh00JAmeGj7k9XC4p9bJwUYUyTxVpw6YQTV3zbWEmizf+2WM3HRFxIDj+lmuMOlvA==
X-Received: by 2002:a50:9359:0:b0:570:d85:f296 with SMTP id
 4fb4d7f45d1cf-5731da68d0amr1926583a12.26.1715163971753; 
 Wed, 08 May 2024 03:26:11 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 df13-20020a05640230ad00b00572300f0768sm7545969edb.79.2024.05.08.03.26.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 03:26:11 -0700 (PDT)
Message-ID: <e4a5e4a4-9f0e-4512-afb2-b2f5ea20cd4a@linaro.org>
Date: Wed, 8 May 2024 12:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/12] vhost-user: enable frontends on any POSIX system
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-8-sgarzare@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508074457.12367-8-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 8/5/24 09:44, Stefano Garzarella wrote:
> The vhost-user protocol is not really Linux-specific so let's enable
> vhost-user frontends for any POSIX system.
> 
> In vhost_net.c we use VHOST_FILE_UNBIND which is defined in a Linux
> specific header, let's define it for other systems as well.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   meson.build        | 1 -
>   hw/net/vhost_net.c | 5 +++++
>   hw/block/Kconfig   | 2 +-
>   3 files changed, 6 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

on macOS:
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


