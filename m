Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2214DC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 18:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCOUx-0004zQ-5v; Wed, 29 May 2024 14:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCOUv-0004yh-BT
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:58:05 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCOUt-0005o5-Li
 for qemu-devel@nongnu.org; Wed, 29 May 2024 14:58:05 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f480624d10so806075ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717009081; x=1717613881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ofAugN4DnCJ6esfLziGOeNRSgGsezOIdCUVBjPVLM3M=;
 b=ihNtJhq500ShbYIXmR/NC5SduegOlLXCxPR0owmnPp6C+LWRmXO+sfInFZQy6mNcqq
 6R0HKVnG7FWUA2XJ8uZG5Ijh5Mq4rTepHTH4XCNlKkJpgxRQr/sDXpaBh8orqyclg2Hv
 MxJn4oQwn9D1rlW0oKcTEKI/L8XNuzb03hPu3eLVob6BBdsVQrGbNDgU4boq2zJEKpon
 vEe3yk5SP6i2jbcxF8xrdFRcPLB62A2kmtze+EYzgGYlmmqO+kvRivGk+7NRoht9VzUQ
 2PQQRp4qoe+oW4DylVrs1zko4M2o2jfNc5qYGO/DWS6qK2FBmya1atY3nt53yrywUMyM
 zcqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717009081; x=1717613881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ofAugN4DnCJ6esfLziGOeNRSgGsezOIdCUVBjPVLM3M=;
 b=erUS6Rymg2r2nNfXicbYS9cMqo74KahqFDM8Okd3PuM6PcM15DeR8XaqmjS45WUyyq
 VoDRTNjtEiS5tV0Uvp7THSkj2S0t2jCx7okoBR1//DyIBVJOKwOqb3AqZcZxFjzmPSwP
 pLry6fED4LmmQuy78JKJO812kP7LVq8WX/b74HkUUitbvjn6nZcfHxFOGwAwrrl3WBrZ
 xd9Eawa4fTOkE550Jjha6eXp9U67K3nFDqclAZVYXKnrP2jjEiom+NCdJmp/HwqpjIBj
 GKVrNOc1slgiuhNglfkyqZ2EuLtN4JLJIj8mFIHPJBEy1gTOnxPzQW7Rs5CaUb1cJ2ZA
 2YaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmIcfG1vr9B2OtAkTIY7VFA52PyyPLRLqONGGisKk1ph+w34jnDx3NST91Zdlh8LTEHR36B9jespTez85dyeEJ0CZ3G34=
X-Gm-Message-State: AOJu0Yxcu44F8/qWMQXje+n1jZBASEV/vXVoW1Fd6/ZjUWafW5kfeV+A
 XUoQ/mNkUL07Zxo3gmSu2TNv9DwltTwEi8C9GhgF+yCuvIX96jGFlqITbk9uG5k=
X-Google-Smtp-Source: AGHT+IEYW5ZizoqhPd1JYImWYiVzZT136hKz1gE0XC7rteTzSpvVqlDki/nzgstdwSIQ4SaoB5CvKg==
X-Received: by 2002:a17:903:230b:b0:1ef:35d5:e3ea with SMTP id
 d9443c01a7336-1f4497dc950mr204770795ad.59.1717009081408; 
 Wed, 29 May 2024 11:58:01 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f45ad4444csm95925245ad.274.2024.05.29.11.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 11:58:01 -0700 (PDT)
Message-ID: <45d10745-6f87-4ee6-8e76-0da7a841b295@linaro.org>
Date: Wed, 29 May 2024 11:57:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
 <c5caf29e-33a3-4d63-ad45-c0622675d74e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <c5caf29e-33a3-4d63-ad45-c0622675d74e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gNS8yOS8yNCAwNToyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE3LzUvMjQgMDA6MjAsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBGcm9tOiBBbGV4
IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+DQo+Pg0KPj4gV2UgYXJlIGFib3V0
IHRvIHJlbW92ZSBkaXJlY3QgY2FsbHMgdG8gaW5kaXZpZHVhbCBhY2NlbGVyYXRvcnMgZm9y
DQo+PiB0aGlzIGluZm9ybWF0aW9uIGFuZCB3aWxsIG5lZWQgYSBjZW50cmFsIHBvaW50IGZv
ciBwbHVnaW5zIHRvIGhvb2sNCj4+IGludG8gdGltZSBjaGFuZ2VzLg0KPj4NCj4+IEZyb206
IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+IFJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+PiAt
LS0NCj4+ICAgIGluY2x1ZGUvc3lzZW11L2FjY2VsLW9wcy5oICAgICAgICAgICAgICAgICAg
ICAgfCAxOCArKysrKysrKysrKysrKysrKy0NCj4+ICAgIGluY2x1ZGUvc3lzZW11L2NwdS10
aW1lcnMuaCAgICAgICAgICAgICAgICAgICAgfCAgMyArKy0NCj4+ICAgIC4uLmV0LXZpcnR1
YWwtY2xvY2suYyA9PiBjcHVzLXZpcnR1YWwtY2xvY2suY30gfCAgNSArKysrKw0KPj4gICAg
c3lzdGVtL2NwdXMuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDExICsr
KysrKysrKysrDQo+PiAgICBzdHVicy9tZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDYgKysrKystDQo+PiAgICA1IGZpbGVzIGNoYW5nZWQsIDQwIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiANCj4+IGRpZmYgLS1naXQgYS9zdHVi
cy9tZXNvbi5idWlsZCBiL3N0dWJzL21lc29uLmJ1aWxkDQo+PiBpbmRleCAzYjlkNDIwMjNj
Yi4uNjcyMjEzYjc0ODIgMTAwNjQ0DQo+PiAtLS0gYS9zdHVicy9tZXNvbi5idWlsZA0KPj4g
KysrIGIvc3R1YnMvbWVzb24uYnVpbGQNCj4+IEBAIC0zLDYgKzMsMTEgQEANCj4+ICAgICMg
YmVsb3csIHNvIHRoYXQgaXQgaXMgY2xlYXIgd2hvIG5lZWRzIHRoZSBzdHViYmVkIGZ1bmN0
aW9uYWxpdHkuDQo+PiAgICANCj4+ICAgIHN0dWJfc3MuYWRkKGZpbGVzKCdjcHUtZ2V0LWNs
b2NrLmMnKSkNCj4+ICtzdHViX3NzLmFkZChmaWxlcygnY3B1cy12aXJ0dWFsLWNsb2NrLmMn
KSkNCj4gDQo+IEFyZSB0aGVzZSBsaW5lcyA8Li4uDQo+IA0KPj4gK3N0dWJfc3MuYWRkKGZp
bGVzKCdxZW11LXRpbWVyLW5vdGlmeS1jYi5jJykpDQo+PiArc3R1Yl9zcy5hZGQoZmlsZXMo
J2ljb3VudC5jJykpDQo+PiArc3R1Yl9zcy5hZGQoZmlsZXMoJ2R1bXAuYycpKQ0KPj4gK3N0
dWJfc3MuYWRkKGZpbGVzKCdlcnJvci1wcmludGYuYycpKQ0KPiANCj4gLi4uPiBkdWUgdG8g
YSBmYWlsZWQgZ2l0LXJlYmFzZT8NCj4gDQoNCllvdSdyZSByaWdodCwgZml4ZWQgdGhpcyEN
Cg0KPj4gICAgc3R1Yl9zcy5hZGQoZmlsZXMoJ2Zkc2V0LmMnKSkNCj4+ICAgIHN0dWJfc3Mu
YWRkKGZpbGVzKCdpb3RocmVhZC1sb2NrLmMnKSkNCj4+ICAgIHN0dWJfc3MuYWRkKGZpbGVz
KCdpcy1kYWVtb25pemVkLmMnKSkNCj4+IEBAIC0yOCw3ICszMyw2IEBAIGVuZGlmDQo+PiAg
ICBpZiBoYXZlX2Jsb2NrIG9yIGhhdmVfZ2ENCj4+ICAgICAgc3R1Yl9zcy5hZGQoZmlsZXMo
J3JlcGxheS10b29scy5jJykpDQo+PiAgICAgICMgc3R1YnMgZm9yIGhvb2tzIGluIHV0aWwv
bWFpbi1sb29wLmMsIHV0aWwvYXN5bmMuYyBldGMuDQo+PiAtICBzdHViX3NzLmFkZChmaWxl
cygnY3B1cy1nZXQtdmlydHVhbC1jbG9jay5jJykpDQo+PiAgICAgIHN0dWJfc3MuYWRkKGZp
bGVzKCdpY291bnQuYycpKQ0KPj4gICAgICBzdHViX3NzLmFkZChmaWxlcygnZ3JhcGgtbG9j
ay5jJykpDQo+PiAgICAgIGlmIGxpbnV4X2lvX3VyaW5nLmZvdW5kKCkNCj4gDQo=

