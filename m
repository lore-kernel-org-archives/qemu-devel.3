Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEC7C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 09:27:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYMeu-0006wC-7Q; Mon, 29 Jul 2024 05:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMes-0006oe-Cq
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:27:10 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYMeq-0001Ov-Iy
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 05:27:10 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-428178fc07eso11944405e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 02:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722245227; x=1722850027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g8XAPiWH2FqbGvRy29sLzAUdq0CY3h/biDYe/igYx4k=;
 b=gred+ViP6nAY8He6N+mY/K5lU1cjczf5jyjqCKi845gvwXmEaEJ1J4en6vt0jxawUn
 r6unZQvzdUhOrsCyk/iJA63Qh2dAD/XvQsuRjbvjPB2bvMTAkZrypoB5UKluFHjVUcMD
 Mgvj3anjBRyDKqgSi1CKHezJNZyBdISR/HYFKvHOCr6a0BlYvrPkg/wQrR77IbHngrub
 Ib1yaklbJ2TsVLQtrzCZcmHXQ624Zu83Y7/cuTw72pr9gAClRYcNLVpiLREiqo0+/pXB
 O2tUFQM6Gnm06fOBYSXo9qYmUW1pCQv4aKYBsYMpjmP96I3eFMRAbPrBIQIdAdy8mV/k
 Z0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722245227; x=1722850027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g8XAPiWH2FqbGvRy29sLzAUdq0CY3h/biDYe/igYx4k=;
 b=gYeaLo5ZfkOHap0iQNrXw30TaU0C+KcicdoAkIpDyN3f2g3vTzX926zgrB3DAJjbNQ
 2txvHlwvJaVE/IONoz1QmpqyQ0M8Brx3X8Mkmr8MPw+r5pemqmZqAmRvIoc2anB+gIEZ
 IwBcrpL1XoHA6+VpywDJQanZfNgmRTIiiJvKQR1GCBzRE+zughYZlPMHIbRBjBBj23ub
 oyjhyz+nCIIztInm7UgoxQ43DR1FSb54jKXU54fuNWzfY96QXur+GDBBU0RjjtabEnJg
 JNcwOrZstJ0W+dWYb4yAYT2HZL03sFMZKTq+enpKMuA3/VyC0isChAmHcnxsnJ84kdbD
 jf2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVY43mmeVQbA9oaD2O1svtSdisMc3u5gH4LeNoaQNTTlYJQdyIJCgBSGqq+0uFBXEXlefQJ6N05kS6gQVHTduTr9xWj78Q=
X-Gm-Message-State: AOJu0Yy0XaB7Xz7dyTqKJ8epqXC40UazVn7dMb/kJRqR7G5bZBP0+9h1
 yxGTFChoSMhJCGtEHYPOHh0cU8FkAo99Mw2g5IW2NQ7dcG+2QUCxC/CTVcUbEUs=
X-Google-Smtp-Source: AGHT+IFO+41JqucrdvEIVNnc/4rveZUI8xpBzr4AfTfdu9aRnA2CxQSQ7xOc7vdVZp+frc9QlAzq4Q==
X-Received: by 2002:a05:600c:468d:b0:425:649b:60e8 with SMTP id
 5b1f17b1804b1-42811d9cb9bmr51906095e9.18.1722245226750; 
 Mon, 29 Jul 2024 02:27:06 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280574003bsm167702425e9.17.2024.07.29.02.27.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 02:27:06 -0700 (PDT)
Message-ID: <73127b3f-7a56-46f3-892f-a7ffd542b4dd@linaro.org>
Date: Mon, 29 Jul 2024 11:27:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/11] hw/isa/vt82c686: Implement relocation and
 toggling of SuperI/O functions
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20240114123911.4877-1-shentey@gmail.com>
 <20240114123911.4877-12-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240114123911.4877-12-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 14/1/24 13:39, Bernhard Beschow wrote:
> The VIA south bridges are able to relocate and toggle (enable or disable) their
> SuperI/O functions. So far this is hardcoded such that all functions are always
> enabled and are located at fixed addresses.
> 
> Some PC BIOSes seem to probe for I/O occupancy before activating such a function
> and issue an error in case of a conflict. Since the functions are currently
> enabled on reset, conflicts are always detected. Prevent that by implementing
> relocation and toggling of the SuperI/O functions.
> 
> Note that all SuperI/O functions are now deactivated upon reset (except for
> VT82C686B's serial ports where Fuloong 2e's rescue-yl seems to expect them to be
> enabled by default). Rely on firmware to configure the functions accordingly.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/isa/vt82c686.c | 65 +++++++++++++++++++++++++++++++++++++++--------
>   1 file changed, 55 insertions(+), 10 deletions(-)


> +static void via_superio_devices_enable(ViaSuperIOState *s, uint8_t data)
> +{
> +    ISASuperIOClass *ic = ISA_SUPERIO_GET_CLASS(s);
> +

        memory_region_transaction_begin();

> +    isa_parallel_set_enabled(s->superio.parallel[0], (data & 0x3) != 3);
> +    for (int i = 0; i < ic->serial.count; i++) {
> +        isa_serial_set_enabled(s->superio.serial[i], data & BIT(i + 2));
> +    }
> +    isa_fdc_set_enabled(s->superio.floppy, data & BIT(4));

        memory_region_transaction_commit();

> +}
> +


