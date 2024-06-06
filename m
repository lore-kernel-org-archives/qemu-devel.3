Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78234C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 21:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFKRZ-0006A4-LV; Thu, 06 Jun 2024 17:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFKRX-00066o-S2
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 17:14:43 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFKRW-0001Ih-A6
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 17:14:43 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-704090c1204so463038b3a.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 14:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717708481; x=1718313281; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4qWPn1KwcSMmko1eDXpfkC2UD7Swf+LZyCVjNyEhdnQ=;
 b=UnCEalBtYbSm9wGkdKxkERdgK3ri9AWd3u066rMC4XkS9Hy/pDNDeqsvwcKVgL6uZE
 lPsz6rN29nKnnfgo0YGbwisHwCypzcBku+K17kWYA5wrZzw+WTqTlZ2q01d2HgVKxDkO
 mcy4BLlzhKnlXvPWCNCdF2KtYgUn8k0akgaFKa+AA/tmEJCEQDSDaKZ8rXTbVBoWo0lr
 kUb0giq/afDEIM3EqdAbTpht6OIgHTwaGFQvVRCZUolzDHT4/tU8QkXAJkuEpzK8DnNX
 CRJmHcvzTySAl8vx+HTkr+W44zqiRnW7XEjglGvFtTKGiiX2eZdChfOEu/4rPW67e5sT
 QmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717708481; x=1718313281;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4qWPn1KwcSMmko1eDXpfkC2UD7Swf+LZyCVjNyEhdnQ=;
 b=uPRTl+/3NBHfVuGA2d74u8y42YBETnjhdmnIAiQmFu6aQC0zGUwbEdFbm6yycImrst
 tXH3YGzfh8HwPoatCQYyNTR3w2mi0CLzzQl34mgA5YJUx9PH8zEs7/5pGRh3LU7nt1tU
 VvlYOfBQjqU2BmXSYWrwF+zPH+v61UKIelZhkW3gpRttjCrYhTw2jesIMIE+fREXeYH1
 Wq1liBvXl3W+1S19dkz301ZB7DsrjZ9+wIsALkRTLpWPpH3a8H7v0AxrRNvv8oW/rhX1
 ZmQMGS3TN/gK+wTcLHrMjQDE+3Hfo3BJFBJkjPP/opFpSPnUL/hpKlDk589ZzEYxCzSQ
 VJXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJGNhPni9gcarNqts16OboUPDmtaSMdgyqwYW5ORJ53KYFUD6jB2kpcfe91Ygp5g2bsojrfweBgPf/tXS2EK03/sLCGLA=
X-Gm-Message-State: AOJu0YxyqHljJxP34m1VImhVT/nms6Pi27IoORY+gfSleHFDlpZkOylm
 9du4xLyaXLpCZA4PuU7AG1Y1Wov6fwMootMfoLdy0AUURphfvccIOQwl5ilkfrM=
X-Google-Smtp-Source: AGHT+IFunTwbiRd3G+mXLm0KRlwO3Mv+9hmb8AZRAqVYPAt/Jow9EU27mM3jFaedOafCa0hkK3foww==
X-Received: by 2002:a05:6a00:cc5:b0:6ea:f351:1df9 with SMTP id
 d2e1a72fcca58-7040c739f0fmr747091b3a.23.1717708480801; 
 Thu, 06 Jun 2024 14:14:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd52b623sm1514273b3a.207.2024.06.06.14.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 14:14:40 -0700 (PDT)
Message-ID: <26cb32be-d5a6-48b9-98c9-ca94ac6ceafd@linaro.org>
Date: Thu, 6 Jun 2024 14:14:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] plugins: Free CPUPluginState before destroying vCPU
 state
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240606124010.2460-1-philmd@linaro.org>
 <20240606124010.2460-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240606124010.2460-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gNi82LzI0IDA1OjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gY3B1
OjpwbHVnaW5fc3RhdGUgaXMgYWxsb2NhdGVkIGluIGNwdV9jb21tb25faW5pdGZuKCkgd2hl
bg0KPiB0aGUgdkNQVSBzdGF0ZSBpcyBjcmVhdGVkLiBSZWxlYXNlIGl0IGluIGNwdV9jb21t
b25fZmluYWxpemUoKQ0KPiB3aGVuIHdlIGFyZSBkb25lLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0N
Cj4gICBpbmNsdWRlL3FlbXUvcGx1Z2luLmggfCAzICsrKw0KPiAgIGh3L2NvcmUvY3B1LWNv
bW1vbi5jICB8IDUgKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9wbHVnaW4uaCBiL2luY2x1ZGUv
cWVtdS9wbHVnaW4uaA0KPiBpbmRleCBiYzVhZWY5NzllLi5hZjVmOWRiNDY5IDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3FlbXUvcGx1Z2luLmgNCj4gKysrIGIvaW5jbHVkZS9xZW11L3Bs
dWdpbi5oDQo+IEBAIC0xNDksNiArMTQ5LDkgQEAgc3RydWN0IENQVVBsdWdpblN0YXRlIHsN
Cj4gICANCj4gICAvKioNCj4gICAgKiBxZW11X3BsdWdpbl9jcmVhdGVfdmNwdV9zdGF0ZTog
YWxsb2NhdGUgcGx1Z2luIHN0YXRlDQo+ICsgKg0KPiArICogVGhlIHJldHVybmVkIGRhdGEg
bXVzdCBiZSByZWxlYXNlZCB3aXRoIGdfZnJlZSgpDQo+ICsgKiB3aGVuIG5vIGxvbmdlciBy
ZXF1aXJlZC4NCj4gICAgKi8NCj4gICBDUFVQbHVnaW5TdGF0ZSAqcWVtdV9wbHVnaW5fY3Jl
YXRlX3ZjcHVfc3RhdGUodm9pZCk7DQo+ICAgDQo+IGRpZmYgLS1naXQgYS9ody9jb3JlL2Nw
dS1jb21tb24uYyBiL2h3L2NvcmUvY3B1LWNvbW1vbi5jDQo+IGluZGV4IGJmMWE3Yjg4OTIu
LmNkMTU0MDI1NTIgMTAwNjQ0DQo+IC0tLSBhL2h3L2NvcmUvY3B1LWNvbW1vbi5jDQo+ICsr
KyBiL2h3L2NvcmUvY3B1LWNvbW1vbi5jDQo+IEBAIC0yODMsNiArMjgzLDExIEBAIHN0YXRp
YyB2b2lkIGNwdV9jb21tb25fZmluYWxpemUoT2JqZWN0ICpvYmopDQo+ICAgew0KPiAgICAg
ICBDUFVTdGF0ZSAqY3B1ID0gQ1BVKG9iaik7DQo+ICAgDQo+ICsjaWZkZWYgQ09ORklHX1BM
VUdJTg0KPiArICAgIGlmICh0Y2dfZW5hYmxlZCgpKSB7DQo+ICsgICAgICAgIGdfZnJlZShj
cHUtPnBsdWdpbl9zdGF0ZSk7DQo+ICsgICAgfQ0KPiArI2VuZGlmDQo+ICAgICAgIGdfYXJy
YXlfZnJlZShjcHUtPmdkYl9yZWdzLCBUUlVFKTsNCj4gICAgICAgcWVtdV9sb2NrY250X2Rl
c3Ryb3koJmNwdS0+aW5faW9jdGxfbG9jayk7DQo+ICAgICAgIHFlbXVfbXV0ZXhfZGVzdHJv
eSgmY3B1LT53b3JrX211dGV4KTsNCg0KVG8gZW5zdXJlIEkgZ2V0IGl0IHJpZ2h0LCBvcmRl
ciBvZiBjcHUgaW5pdC9kZWluaXQgaXM6DQotIGluaXQNCi0gcmVhbGl6ZQ0KLSB1bnJlYWxp
emUNCi0gZmluYWxpemUNCklzIHRoYXQgY29ycmVjdD8NCg0KUmV2aWV3ZWQtYnk6IFBpZXJy
aWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

