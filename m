Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F0DC369B4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Lff-0004xp-Iu; Mon, 14 Apr 2025 11:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4LfZ-0004xW-SH
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:24:21 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4LfX-00036S-9E
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:24:21 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ff6a98c638so4765204a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644257; x=1745249057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HzvqK6YymbM4o0u6qZOeVcB1dMhwU3Mq64hbUyd2dno=;
 b=Pcz+uaehpI5kEhp9eSG8WAgPqr/VhsSU37glPOznhl1i1O3wEbUh2ZtBlYKkR8vl+f
 B3vb9RvY6kJdcbBwIm0dQz/u/MAnTJZ0udLmWLrUT//oda1HnIC1TRr7KhiH7ey1y9HN
 8uQdtFa+7cCUGQqnNolW402i30Dau3BIKCTkop0Agx3F8eOtV7pHeSKl4elF9jmKJRGR
 qtBNvZ1BYFFmQCLJ/dJq2JtRiUOVtr13lv5nERB1M6LtfQ3ZaGfPj5vg6zRpzeUC2vnl
 BCSk1UL2Fd8gXzcBQGkc3W5yq633gfW4QebiOxv9RfzHDIXMFVYypjcjHohMM6apxUKu
 K6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644257; x=1745249057;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HzvqK6YymbM4o0u6qZOeVcB1dMhwU3Mq64hbUyd2dno=;
 b=LQFIJBCEhHaU/K48yj1wuRiJXQgSdIoz2iFt4OUyOHKeImTbU6VbTFXH0fmY9AkYnd
 gl9vlSJVDESJu8cxw2WWFbQkc3eCy23pzsZKqjksdLw72HWrFNw0XBdmvHaC8I8nsVYE
 5dBs7Da+MrckqCAH7HRj3HxJle4ngW38g6j92B2kaOiLwkLdP94zHXfEAHhv+TnhMhoF
 4bhm82w7bIPoAYyQByb8e6WxPy2XOr22csnaQZX+ZeXVA1UWBkfmlVVAvNA6po2CeEb2
 i3RqsLir1tUzmBpDDoUgFcmrLifqbVknXWtQNZD6hLbhYM1FIM6RdfzKlJjZaqOO4vVy
 RK/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMs8CBQuJOyJNUyPQPs02+bB3uUHSdkuHos4E+pmxPKnmRSX0soXnqqmWes5sssLn714AYkBNtLfg5@nongnu.org
X-Gm-Message-State: AOJu0YyWLhWz7pbdpgK8S6yOpGMgHxMdsFQkerPwdUF3TpmjteaUCha1
 hQZLdPTGSS2IdG5lG1Kmo4YzsAc6eCSJc1LTeqCeT2apHGgtxne4nblKRaCgGBQ=
X-Gm-Gg: ASbGncuPiUr5MFaBpkjUN37eBUhn3wJm2oMCfITaRQm8SRBL96M57/7nHp7OKG2ypif
 IDlQulTElyNtzUe12K8vB0BmNdB/9P79Ir5f/bpvIafBXbtF2absO2/tfH6fvBCPlADCG1HVfdq
 BeZex4qlr4s8BExOe+cUuaEAdUcYir/MTRf7JS46v+Hmy+dDtkpGi3ADYv1sG95i/iWcnLaxJZN
 gvwfJ3c9ebKRsXbojkMdxHIEfDlWnfwHgmZjWY7wuUbK/R4/L71Z331U8gOPEk1tLRqaZSvSOqE
 ZjLqMCOqJzDqKRXya60ps9Mtcs9Q5O3CmCRocsqcmRuQqigXx07gVlsYP3pfObqr
X-Google-Smtp-Source: AGHT+IHt7gd8FygCWFT7wpV6iV5N6nUaS501oFsuukpAnobX3OKSLhAt+6MnoN/wjOjHoDqAogj9JA==
X-Received: by 2002:a17:90b:2704:b0:2f9:cf97:56a6 with SMTP id
 98e67ed59e1d1-30823646dfdmr21359510a91.14.1744644256821; 
 Mon, 14 Apr 2025 08:24:16 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df2fae27sm11172533a91.31.2025.04.14.08.24.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 08:24:16 -0700 (PDT)
Message-ID: <5cac93d4-e5a6-42b0-8f7b-5a273168a450@linaro.org>
Date: Mon, 14 Apr 2025 08:24:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/main: transfer replay mutex ownership from
 main thread to main loop thread
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250410225550.46807-2-pierrick.bouvier@linaro.org>
 <D94EWG4QRMFP.123EPDW889YVC@gmail.com>
 <7e760e04-0571-48f3-9aa7-e71c631dcaff@linaro.org>
 <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <dee088aa-436f-48dc-8a28-f675de42767b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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

T24gNC8xNC8yNSAwMzoyNSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEyLzQvMjUgMTk6MjQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzExLzI1
IDIyOjMwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6DQo+Pj4gT24gRnJpIEFwciAxMSwgMjAy
NSBhdCA4OjU1IEFNIEFFU1QsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IE9uIE1h
Y09TLCBVSSBldmVudCBsb29wIGhhcyB0byBiZSByYW4gaW4gdGhlIG1haW4gdGhyZWFkIG9m
IGEgcHJvY2Vzcy4NCj4+Pj4gQmVjYXVzZSBvZiB0aGF0IHJlc3RyaWN0aW9uLCBvbiB0aGlz
IHBsYXRmb3JtLCBxZW11IG1haW4gZXZlbnQgbG9vcCBpcw0KPj4+PiByYW4gb24gYW5vdGhl
ciB0aHJlYWQgWzFdLg0KPj4+Pg0KPj4+PiBUaGlzIGJyZWFrcyByZWNvcmQvcmVwbGF5IGZl
YXR1cmUsIHdoaWNoIGV4cGVjdHMgdGhyZWFkIHJ1bm5pbmcNCj4+Pj4gcWVtdV9pbml0DQo+
Pj4+IHRvIGluaXRpYWxpemUgaG9sZCB0aGlzIGxvY2ssIGJyZWFraW5nIGFzc29jaWF0ZWQg
ZnVuY3Rpb25hbCB0ZXN0cyBvbg0KPj4+PiBNYWNPUy4NCj4+Pj4NCj4+Pj4gVGh1cywgYXMg
YSBnZW5lcmFsaXphdGlvbiwgYW5kIHNpbWlsYXIgdG8gaG93IEJRTCBpcyBoYW5kbGVkLCB3
ZSByZWxlYXNlDQo+Pj4+IGl0IGFmdGVyIGluaXQsIGFuZCByZWFjcXVpcmUgdGhlIGxvY2sg
YmVmb3JlIGVudGVyaW5nIG1haW4gZXZlbnQgbG9vcCwNCj4+Pj4gYXZvaWRpbmcgYSBzcGVj
aWFsIGNhc2UgaWYgYSBzZXBhcmF0ZSB0aHJlYWQgaXMgdXNlZC4NCj4+Pj4NCj4+Pj4gVGVz
dGVkIG9uIE1hY09TIHdpdGg6DQo+Pj4+ICQgbWVzb24gdGVzdCAtQyBidWlsZCAtLXNldHVw
IHRob3JvdWdoIC0tcHJpbnQtZXJyb3Jsb2dzIFwNCj4+Pj4gZnVuYy14ODZfNjQteDg2XzY0
X3JlcGxheSBmdW5jLWFybS1hcm1fcmVwbGF5IGZ1bmMtYWFyY2g2NC0NCj4+Pj4gYWFyY2g2
NF9yZXBsYXkNCj4+Pj4gJCAuL2J1aWxkL3FlbXUtc3lzdGVtLXg4Nl82NCAtbm9ncmFwaGlj
IC1pY291bnQNCj4+Pj4gc2hpZnQ9YXV0byxycj1yZWNvcmQscnJmaWxlPXJlcGxheS5sb2cN
Cj4+Pj4gJCAuL2J1aWxkL3FlbXUtc3lzdGVtLXg4Nl82NCAtbm9ncmFwaGljIC1pY291bnQN
Cj4+Pj4gc2hpZnQ9YXV0byxycj1yZXBsYXkscnJmaWxlPXJlcGxheS5sb2cNCj4+Pj4NCj4+
Pj4gWzFdIGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2NvbW1pdC8N
Cj4+Pj4gZjVhYjEyY2FiYTRmMTY1NjQ3OWMxZmViNTI0OGJlYWMxYzgzMzI0Mw0KPj4+Pg0K
Pj4+PiBGaXhlczogaHR0cHM6Ly9naXRsYWIuY29tL3FlbXUtcHJvamVjdC9xZW11Ly0vaXNz
dWVzLzI5MDcNCj4+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJp
Y2suYm91dmllckBsaW5hcm8ub3JnPg0KPj4+PiAtLS0NCj4+Pj4gIMKgIHN5c3RlbS9tYWlu
LmMgfCA0ICsrKysNCj4+Pj4gIMKgIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykN
Cj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9tYWluLmMgYi9zeXN0ZW0vbWFpbi5j
DQo+Pj4+IGluZGV4IGVjYjEyZmQzOTdjLi4xYzAyMjA2NzM0OSAxMDA2NDQNCj4+Pj4gLS0t
IGEvc3lzdGVtL21haW4uYw0KPj4+PiArKysgYi9zeXN0ZW0vbWFpbi5jDQo+Pj4+IEBAIC0y
NSw2ICsyNSw3IEBADQo+Pj4+ICDCoCAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPj4+PiAg
wqAgI2luY2x1ZGUgInFlbXUtbWFpbi5oIg0KPj4+PiAgwqAgI2luY2x1ZGUgInFlbXUvbWFp
bi1sb29wLmgiDQo+Pj4+ICsjaW5jbHVkZSAic3lzdGVtL3JlcGxheS5oIg0KPj4+PiAgwqAg
I2luY2x1ZGUgInN5c3RlbS9zeXN0ZW0uaCINCj4+Pj4gIMKgICNpZmRlZiBDT05GSUdfU0RM
DQo+Pj4+IEBAIC00NCwxMCArNDUsMTIgQEAgc3RhdGljIHZvaWQgKnFlbXVfZGVmYXVsdF9t
YWluKHZvaWQgKm9wYXF1ZSkNCj4+Pj4gIMKgIHsNCj4+Pj4gIMKgwqDCoMKgwqAgaW50IHN0
YXR1czsNCj4+Pj4gK8KgwqDCoCByZXBsYXlfbXV0ZXhfbG9jaygpOw0KPj4+PiAgwqDCoMKg
wqDCoCBicWxfbG9jaygpOw0KPj4+PiAgwqDCoMKgwqDCoCBzdGF0dXMgPSBxZW11X21haW5f
bG9vcCgpOw0KPj4+PiAgwqDCoMKgwqDCoCBxZW11X2NsZWFudXAoc3RhdHVzKTsNCj4+Pj4g
IMKgwqDCoMKgwqAgYnFsX3VubG9jaygpOw0KPj4+PiArwqDCoMKgIHJlcGxheV9tdXRleF91
bmxvY2soKTsNCj4+Pj4gIMKgwqDCoMKgwqAgZXhpdChzdGF0dXMpOw0KPj4+PiAgwqAgfQ0K
Pj4+PiBAQCAtNjcsNiArNzAsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3Yp
DQo+Pj4+ICDCoCB7DQo+Pj4+ICDCoMKgwqDCoMKgIHFlbXVfaW5pdChhcmdjLCBhcmd2KTsN
Cj4+Pj4gIMKgwqDCoMKgwqAgYnFsX3VubG9jaygpOw0KPj4+PiArwqDCoMKgIHJlcGxheV9t
dXRleF91bmxvY2soKTsNCj4+Pj4gIMKgwqDCoMKgwqAgaWYgKHFlbXVfbWFpbikgew0KPj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgIFFlbXVUaHJlYWQgbWFpbl9sb29wX3RocmVhZDsNCj4+
Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBxZW11X3RocmVhZF9jcmVhdGUoJm1haW5fbG9vcF90
aHJlYWQsICJxZW11X21haW4iLA0KPj4+DQo+Pj4gRG8gd2UgYWN0dWFsbHkgbmVlZCB0byBo
b2xkIHJlcGxheSBtdXRleCAob3IgZXZlbiBicWwpIG92ZXIgcWVtdV9pbml0KCk/DQo+Pj4g
Qm90aCBzaG91bGQgZ2V0IGRyb3BwZWQgYmVmb3JlIHdlIHJldHVybiBoZXJlLiBCdXQgYXMg
YSBzaW1wbGUgZml4LCBJDQo+Pj4gZ3Vlc3MgdGhpcyBpcyBva2F5Lg0KPj4+DQo+Pg0KPj4g
Rm9yIHRoZSBicWwsIEkgZG9uJ3Qga25vdyB0aGUgZXhhY3QgcmVhc29uLg0KPj4gRm9yIHJl
cGxheSBsb2NrLCB3ZSBuZWVkIHRvIGhvbGQgaXQgYXMgY2xvY2sgZ2V0cyBzYXZlZCBhcyBz
b29uIGFzIHRoZQ0KPj4gZGV2aWNlcyBhcmUgaW5pdGlhbGl6ZWQsIHdoaWNoIGhhcHBlbnMg
YmVmb3JlIGVuZCBvZiBxZW11X2luaXQuDQo+IA0KPiBDb3VsZCBiZSB3b3J0aCBhZGRpbmcg
YSBjb21tZW50IHdpdGggdGhhdCBpbmZvcm1hdGlvbi4NCj4gDQoNCkluIGNhc2Ugc29tZW9u
ZSBpcyBjdXJpb3VzIGFib3V0IGl0LCBjaGFuZ2luZyBkZWZhdWx0IHN0YXRlIG9mIGxvY2sg
Y2FuIA0KYW5zd2VyIHdoeSBpdCdzIG5lZWRlZCwgYXMgaXQgY3Jhc2hlcyBpbW1lZGlhdGVs
eSBvbiBhbiBhc3NlcnQuDQoNCj4+DQo+Pj4gUmV2aWV3ZWQtYnk6IE5pY2hvbGFzIFBpZ2dp
biA8bnBpZ2dpbkBnbWFpbC5jb20+DQo+Pg0KPiANCg0K

