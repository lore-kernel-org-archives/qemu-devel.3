Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CBB5D11190
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 20:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7hA8-0006BR-Px; Sun, 03 Nov 2024 15:25:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7hA0-0006AZ-AD
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 15:25:20 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7h9y-0001nt-88
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 15:25:19 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a998a5ca499so472671766b.0
 for <qemu-devel@nongnu.org>; Sun, 03 Nov 2024 12:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730665515; x=1731270315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9TO72BhcoqjDvsGnFAHcCIAG7XdTsEpDaHkOPHIanKE=;
 b=OgGzDzx4g6E8zA+2PuM3I9ZlWRkb9Ja40auM7nX4QCh5j+0AwwuzmZoZ1NrY7FaE8r
 9xAIehcNbZh7hpOLdX1uvWRLuNZ8n8xkyMfdqOwa4vPf+JoQLJRhJdDgYRKIKF1wKSlW
 ScVVx8KOtpBWntvt0852Sf6X60llE6+1tDMLhgBZ3PtUhyBiQAf4L/U6jyZ48Pni0/v3
 fMxIMbJwaAPJSS0AHNbbJvu+CZd9whAIP9clc47qoVwTAXw7qzmQ1CF9qJscdyhfmR5e
 7qdctycGmHtUSsNNu0h5IzVWph9JAlNHdqLJX1cSoA/tP1tw3q1i3y92ekQtB6Wr00NY
 xcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730665515; x=1731270315;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9TO72BhcoqjDvsGnFAHcCIAG7XdTsEpDaHkOPHIanKE=;
 b=W/vJ86r0is6u1BCePv5GJp7Cv/xB/FmpHsTBqC5tQ258IDSyFkoU+FBJxneqwUND04
 +T01WE2Zambn9zSUp3LMfJlu5Yt/PQO3cKhcJ79f/7SPjE3H/D2Ktv85rbsL+RtM9/V/
 AvVY/BolxKt6qIzCVT62KAK41AMOWz+Z+wtkYHMY6UMWONRevRh6e19oMKK0x3ikYf7R
 vz10+AAKrBjlcxI7lZgIsbOx47SHGlbWlHsssg8Uz1hQOygXw4lVQ5ss8mJKhnPvi/D4
 IhOQP4fdNJ6xtF+gDuxNKimtcUhePhPGLmvDhDGEBLgF/w0YaQbjYi7JkHEiWglPguUB
 vFSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJcPuU/ke6eDgTwIAPdDjo6lzcacm4Ej2A2mqxYjboW8A/R2oFA3vNq3i793Z6LosATq/0s7XYFKkg@nongnu.org
X-Gm-Message-State: AOJu0YyQdgd3gLqUMqsHBLbfiIc67/oMLEjRf1GGsn/Q8qCgvA307JFi
 VAXkzHTcklLX+guB7a9b94NwobK3XsDq/hJFWQrkjScFQUbsPCjHbJk+bulE63Y=
X-Google-Smtp-Source: AGHT+IGG5i24eklpfWj2+Dc6PM5O/iffRCVoUt457LJWODf8lSDey6LeeWk2dpevT/SA8yYP3clBxQ==
X-Received: by 2002:a17:907:72ce:b0:a99:35eb:1301 with SMTP id
 a640c23a62f3a-a9e654cdcd7mr988323366b.18.1730665515234; 
 Sun, 03 Nov 2024 12:25:15 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e564c4f12sm458172866b.55.2024.11.03.12.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 12:25:14 -0800 (PST)
Message-ID: <07c00f31-508d-4a43-a0ca-0ee31ae7409a@linaro.org>
Date: Sun, 3 Nov 2024 21:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] hw/sensor/tmp105: Convert printf() to trace event, 
 add tracing for read/write access
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-trivial@nongnu.org
References: <20241103143330.123596-1-shentey@gmail.com>
 <20241103143330.123596-5-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241103143330.123596-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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

On 3/11/24 11:33, Bernhard Beschow wrote:
> printf() unconditionally prints to the console which disturbs `-serial stdio`.
> Fix that by converting into a trace event. While at it, add some tracing for
> read and write access.
> 
> Fixes: 7e7c5e4c1ba5 "Nokia N800 machine support (ARM)."
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   meson.build            | 1 +
>   hw/sensor/trace.h      | 1 +
>   hw/sensor/tmp105.c     | 7 ++++++-
>   hw/sensor/trace-events | 6 ++++++
>   4 files changed, 14 insertions(+), 1 deletion(-)
>   create mode 100644 hw/sensor/trace.h
>   create mode 100644 hw/sensor/trace-events

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


