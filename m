Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8DCC5B542
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 09:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJU7l-0004or-2R; Mon, 26 May 2025 05:28:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU7e-0004lz-8r
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:27:55 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJU7Z-00047V-L5
 for qemu-devel@nongnu.org; Mon, 26 May 2025 05:27:52 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a363d15c64so1432374f8f.3
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 02:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748251667; x=1748856467; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Myt/jBehPwPRp6X9I6p32CvetV1l1ax0nwJ92+Q51dE=;
 b=QNioxcAwGBT+y+WDHjwhuGdrT8UJlllxad6hHiqnL63GPRHLf8zbxhSY8yzgKPFkr3
 lZBNcx0c4rhITCyMQlOYoWqlkrPhrJCK7WY4F9DFIavXGgMdsCGHgL5WMiCyyboN3Wi1
 DJNMQP/sqLBR6ykIYr8TCQKslEpSF5sGVmhAaQvaIGyuDeYq6BVDhIedxCLf5l0KfiLv
 EdS+a77qPAM18MT+qVSUMzlIYpmY6qOoQrynXaB1Sd6OHddOP6F1/9c6D/7eYJ/kDbMH
 4+lmC7GebouN+0KYoJvUuz0x0gmgNP0onhec1cfoKvE1gXIkCwfuhp5qXHwRYW7eOs2m
 D5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748251667; x=1748856467;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Myt/jBehPwPRp6X9I6p32CvetV1l1ax0nwJ92+Q51dE=;
 b=GuWGP2t/Sr8Ck+5D4WZEEyLMmMtsoTgx0/O5k54ZoBZd2lc6LNoFpSGRx/jRLzxzpg
 3mdpnqpOu9H0WY/eqwDrOVT9EXC7sxefLg6BLJle3664kvyOw7S7ingdBkbJhM80zFL1
 XBJyT99DA2jWNkJovKFafKAq2hj9xDAlbyBVdKm3xYDkgxM5usq/Z1p9pn37SMeUgbZU
 q5TeB6nbEIRk73+Ha0QvjXm814a+6us8POf6y5yzd8qgGI3b30epmDvECNkzzsaPPRja
 1v/HuSSvhCp0GTxxjujT2vVunlTJW3vcb3x5EH440rb+TcAubZSXlLJzTuijCc5XDsjS
 O+BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Avh8I0o7CezEDtIv6kZLhX2prd9wtz2YcAqND9PkzX6nN58bFAEPU35VPbsfARSTH0Xy+gOgTopx@nongnu.org
X-Gm-Message-State: AOJu0YxRbe7B/sF0lIMq4+P1v2BcB9n3Gw8Y0rerc+Dto6VYugunprMV
 6vuy/0Ggh9kJS3wgTAx5hqynUKsc+RcMzDAnYFAaL72BdTY82x4P0852mZmtTENKYYk=
X-Gm-Gg: ASbGnctK7BgbfHmWwmmgpCYvtmgABEvUEEvRh1gjLCfQ7P3do72EGn1AERT0x01jzpV
 8Ywnwg3TdFYmqDsMNoqCaj/j1ZpZG1LUfD8mvcLw2YKqB1V5VGKwHh1uSA2jLu/4yUQs47oHWRa
 jtlRkW4guXFuqyKMKg4PXLXv5o28Pd+khzQsLHycNDlfeRaPpL+amsLW0AQtEo9uf/uRqCVnstk
 6mFRgcMBm7zhzXsloJIBly1CJ1gfzKieG9yf9Znu2m1eThOseOnDnhkIzHx+rfvRmmf7uxq1cr0
 ITUO0H94+uIL/wXLZ5fDezBOgHFfcknKeesIRjBW+KLh0G16wZNccARF5txVVwKtK/MiNcAbF+G
 ZMb6tP74ZgqOor1d756UQqRpY
X-Google-Smtp-Source: AGHT+IH5MOufIDe+zoy9S0iKWQxFKGrv7O67ECEcl4ALhTN7Bn8H5XbISfYOJXcziglAj1n8IXGLeA==
X-Received: by 2002:a05:6000:2287:b0:3a4:d41d:8f40 with SMTP id
 ffacd0b85a97d-3a4d41d92b2mr3503434f8f.46.1748251667159; 
 Mon, 26 May 2025 02:27:47 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4d0bb54e6sm5536691f8f.97.2025.05.26.02.27.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 02:27:46 -0700 (PDT)
Message-ID: <8905dbb0-a6b0-42e3-98e6-095ac2b9e8d7@linaro.org>
Date: Mon, 26 May 2025 11:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/11] hw/display/apple-gfx: Replace QemuSemaphore with
 QemuEvent
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20250526-event-v4-0-5b784cc8e1de@daynix.com>
 <20250526-event-v4-11-5b784cc8e1de@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250526-event-v4-11-5b784cc8e1de@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 26/5/25 07:29, Akihiko Odaki wrote:
> sem in AppleGFXReadMemoryJob is an one-shot event so it can be converted
> into QemuEvent, which is more specialized for such a use case.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/display/apple-gfx.m | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


