Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E0E8D59F59
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jy2-00015w-BV; Wed, 06 Nov 2024 12:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jy0-000146-IO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:37:16 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jxy-0004ha-Jl
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:37:16 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4316cce103dso643915e9.3
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914632; x=1731519432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bbNwb/eSDAbfgrKD9f2e8ZtlheGa1CD2fgCLWI8MlQ8=;
 b=hVaI7pIHmzPT96XQikZoCJS6I2Tvc2OYajW0xyPCBhYgyLj4L1PnpclLJM1X8g77Bg
 l/bi1Z7tqhX3+D97POOcVVkoAmpnJJRmfgOSgXVbP9H5ca+HA0fovQWFfGZiQJ4aeQSl
 HPWqUuQAqO02LtLvPIUVXkwkXDvTOXBzYj0Fws+HCGlqpCyQS46iTRC5vVJnf1RnNmxd
 2V1uhz6SLROvgQVatTMnnDOr6Vt7VfPAUTxYK/Puv+BLyX4oOxRYHY7pCtl9luQmJgDs
 QSTxOiiYhhhBT/Bi9qnI6GfIl5Np+teauY5X+NyWWrG+0dLSM2Hp1z4fL2tUSQS7LIJ9
 5cKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914632; x=1731519432;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbNwb/eSDAbfgrKD9f2e8ZtlheGa1CD2fgCLWI8MlQ8=;
 b=j7B09Rtib6fofh4KFTC1oRwxd2S5aP8qMmw41/4xQv+tc0OFqUw2OTZxM9Puyxadno
 zskSY/ScwckCX5OzU97GFwOn6Phwu2KupmHVpePjFjoCab/htIKVaBY+M1xRJyxgklFs
 XSnLVaqEWxoQCz2IFndQb1s4m0ZVbWTzFDUBs2BuRLS1fOxSPIZAPXZ4cQvGplKlAblw
 GNThW6Q0UNmW/PYA+5UqYONmMYeimU9Mog1/NqRvW9rIwSNGkYaOQ88DzwLhiQv64a9f
 yMUL/PblfB4ujlnoNFUL1gTh+XDD9eiOw3B3TdHo94IVFkXNSFFZP7xB7RvXFl3jk3Cf
 KEeg==
X-Gm-Message-State: AOJu0YzlM3qtg3ez634t+b4NZBbGzU755ehTSU3GzchU1v3cHZCsOjlR
 2AQBTyHagGFlaXL3oXHbWWllpo2MCSQipjeqUaTlQoiCvF8ij+8quh/l6d+1EnGHNf6Hb92Y63j
 QmG0Q/vth
X-Google-Smtp-Source: AGHT+IGHiU5Chxfxo31KjQmyjpRsFD47fx/DnOCotUUBLuvlWdF4ENE5RJ/icRYytvuVlzUG+8EDlw==
X-Received: by 2002:a05:600c:22d3:b0:431:b264:bad9 with SMTP id
 5b1f17b1804b1-432849fa045mr224600185e9.14.1730914632138; 
 Wed, 06 Nov 2024 09:37:12 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e885sm19913029f8f.89.2024.11.06.09.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:37:11 -0800 (PST)
Message-ID: <fd5826c3-6067-47d3-a315-495f1da7250f@linaro.org>
Date: Wed, 6 Nov 2024 09:37:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] plugins: add missing export for
 qemu_plugin_num_vcpus
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241106170923.2976750-1-pierrick.bouvier@linaro.org>
 <20241106170923.2976750-2-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241106170923.2976750-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32b.google.com
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

T24gMTEvNi8yNCAwOTowOSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gRml4ZXM6IDRh
NDQ4YjE0OGNhICgicGx1Z2luczogYWRkIHFlbXVfcGx1Z2luX251bV92Y3B1cyBmdW5jdGlv
biIpDQo+IFJldmlld2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNr
LmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L3FlbXUtcGx1
Z2luLmggfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCBiL2luY2x1ZGUvcWVt
dS9xZW11LXBsdWdpbi5oDQo+IGluZGV4IDYyMmM5YTAyMzI3Li4wZmJhMzZhZTAyOCAxMDA2
NDQNCj4gLS0tIGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gKysrIGIvaW5jbHVk
ZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4gQEAgLTgwMyw2ICs4MDMsNyBAQCB2b2lkIHFlbXVf
cGx1Z2luX3JlZ2lzdGVyX2F0ZXhpdF9jYihxZW11X3BsdWdpbl9pZF90IGlkLA0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFlbXVfcGx1Z2luX3VkYXRhX2Ni
X3QgY2IsIHZvaWQgKnVzZXJkYXRhKTsNCj4gICANCj4gICAvKiByZXR1cm5zIGhvdyBtYW55
IHZjcHVzIHdlcmUgc3RhcnRlZCBhdCB0aGlzIHBvaW50ICovDQo+ICtRRU1VX1BMVUdJTl9B
UEkNCj4gICBpbnQgcWVtdV9wbHVnaW5fbnVtX3ZjcHVzKHZvaWQpOw0KPiAgIA0KPiAgIC8q
Kg0KDQpUaGlzIHBhdGNoIGNhbiBiZSBhcHBsaWVkIHRvIHFlbXUtc3RhYmxlLCBhcyBpdCdz
IGEgc2ltcGxlIGJ1ZyBmaXguDQo=

