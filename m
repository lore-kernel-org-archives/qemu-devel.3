Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546C0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 05:38:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLcOu-0006ol-EY; Mon, 24 Jun 2024 01:38:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcOr-0006d8-8g
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:57 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sLcOo-0005ZH-SM
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 01:37:57 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6fa0d077694so1859297a34.0
 for <qemu-devel@nongnu.org>; Sun, 23 Jun 2024 22:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719207473; x=1719812273;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OKqECE3QQhpisdRYBLXwvGk6jmgmUU6sLJN/OKW97Lg=;
 b=hN2P9SrANWHqXc4U4s0LDh113A15Fty+i/eHhQbHZdJ/gySCEhOBCQlcpRQ8MDecmi
 65fjCX3yp6jRxaQ9IVEIcb51n5LAda5QFjxV2qeCUgiLIL1Gqzj5267Esxdd1Iaw1M1M
 VtQN0EEgEjw+mNWzVWj1IDdnhj+b6jrJXUGfdpKzElZtOW9pgLcosaU5FPRBoj5RUw1g
 RW1m55sRu5q6cuA8OTdJnxBUPUcxN0TTxV7D3SkL1+kXgNs95asL4t0rZmhNh3JLEVXf
 4xvUpYrqAaYxWFJgJiEp8L6Gp6+ocYotngqWTe9hA7fKNNmIRxE0cSdvculAbzuSeaE4
 AU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719207473; x=1719812273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OKqECE3QQhpisdRYBLXwvGk6jmgmUU6sLJN/OKW97Lg=;
 b=DjeA1NRmsYwHqeuYnmSZ6Jezwxn3fEM4cxfrauR1GywMSEk4GFrKBQ+/63bnHYPIFV
 7rUQvZmoaNrd+vfVpuFFCkkKgfEIDvqvOoxU+gEU+0ZnNXDYO5GtcuUbm2g03YrePuAt
 0zuf+IfSoJ3A9x+AZpvMo8poBEzMECfI2ikB9I0ZQVVuHbwDE+30pW8cIZHHWYLcYg5T
 SZekqJlgQsjGAYofQQjDT0cb2hhXtp9lhRYfMkOr3Oaz/+y4LnfrRPl1glidbO5Kxdyj
 iSRhTsx7vjNHqyre+o2EOnOz5AX0bolTsMp9+ixesOJFJazOFfNugCdQ0SFg5nEDv+xk
 rS3A==
X-Gm-Message-State: AOJu0Yy63e3/baVvs2SgwVQEC1yBpQZq+A78owJRkfw5cxJlkPhIf2w5
 3czkEDJaTmgRT2yyskwxickk8UN+1cjTL5+4EBNzESp0C75rLRBZniYYVvSU4m4=
X-Google-Smtp-Source: AGHT+IEJPlcOfKtjEPo3gicun2ZFI1rBP5KrnfniFx1TNZlmP0HPOUyYr9FuG1nWPig+HX1cg2jjdg==
X-Received: by 2002:a9d:69c7:0:b0:6f9:90de:c67f with SMTP id
 46e09a7af769-700b11c68f2mr4519230a34.10.1719207473550; 
 Sun, 23 Jun 2024 22:37:53 -0700 (PDT)
Received: from [157.82.204.135] ([157.82.204.135])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b4a7319bsm4803508a12.50.2024.06.23.22.37.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Jun 2024 22:37:53 -0700 (PDT)
Message-ID: <30447bda-dc0f-4b56-a65c-c38de1915f45@daynix.com>
Date: Mon, 24 Jun 2024 14:37:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/13] virtio-gpu: Add virgl resource management
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Huang Rui <ray.huang@amd.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
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
References: <20240623152343.328436-1-dmitry.osipenko@collabora.com>
 <20240623152343.328436-10-dmitry.osipenko@collabora.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240623152343.328436-10-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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

On 2024/06/24 0:23, Dmitry Osipenko wrote:
> From: Huang Rui <ray.huang@amd.com>
> 
> In a preparation to adding host blobs support to virtio-gpu, add virgl
> resource management that allows to retrieve resource based on its ID
> and virgl resource wrapper on top of simple resource that will be contain
> fields specific to virgl.
> 
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

