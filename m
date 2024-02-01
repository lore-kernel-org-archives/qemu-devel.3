Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E2DC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 05:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVPd9-0007ul-OZ; Thu, 01 Feb 2024 00:28:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rVPd8-0007uW-Np
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:28:54 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rVPd6-0008Vm-Te
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 00:28:54 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40efcb37373so4863285e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 21:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706765330; x=1707370130; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tAr/tZwqSl2PkjQRZ4VvN+ltwRiMNSLyUm0E0U0AuP8=;
 b=OjP6Tr8tDYmL2/FGkJ1jyrDT/23ugDXaLExWxWNkbGVL/2Hi6DsDoVfNDaTIiEMF4X
 8rY+uRx6a6Mzkm1M63oHRjcPB3FrcFUv0bD3fHIafqgVnTzW3QapCWjDoSFS+foc03BR
 +VS3VUySrLOebyUUbYOXCIdxOIRel3v8TCAn+0eTB+wyvOnot/M+1vTz4HD/8LJTBo00
 QclLUmg18plrfrPyAwadaoRs9840Qmh/nl8dh+njvUPtGvLBB5OGVxY0sUcF0xvjIA7p
 zGAeNUnqpwp4tIlCHjifX7IE6b2/i3dsVB2WuZAv4J1kL/GLAOA9PYLEb339tPj1Vm3N
 pxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706765330; x=1707370130;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tAr/tZwqSl2PkjQRZ4VvN+ltwRiMNSLyUm0E0U0AuP8=;
 b=l+esC1c32wnbmjQq1rqiPmWHxnqmcnr1YE1lMdVgGYY4U1WswtxS/moD7p6PG87kDn
 9cMJg4V5R8MyvjypuowKBV0zM1Xe+mJec3r8UqAhwDKDqVvR0YNMz4n03plEM9KH1bDS
 y/m7PteBCNBWeWcHnqQxti8PUEwnjTFGJHCIDJVjRHY3XQA8tFRIOO+CZkb5mlrAgxio
 J+xFqpsbIb5Jqon/6lFOqtBkeOAxMfL9o79obU9/sxrSv4m2dXbj2ZyAwDT2ApHeSYo9
 PzwjLRkSJAycU3DNzZfKvvjIJ9JT2qmP0yu1ZP5EfC2OzPpmiqo7kX9fVegS6TZv9r18
 3A0A==
X-Gm-Message-State: AOJu0YyyjZYInQqExU14uXP6DB8/KZE4kpJSjXEPPYY+6i++sW8M6i9C
 DVvGbE8YLMPA3kHfIj9uWHMJ5VyXnIdJqp1nkWXaZfuZ1YDvcrF72ooPuqF5CGU=
X-Google-Smtp-Source: AGHT+IH32Roq2AZHDyiRWmH0qmDPw47Igb6GTpma95mdghNz2Qo0wqf0gsMD/8pubJVgfT7KY1IT3A==
X-Received: by 2002:a05:600c:4fc6:b0:40e:fb90:207 with SMTP id
 o6-20020a05600c4fc600b0040efb900207mr2446186wmq.25.1706765330387; 
 Wed, 31 Jan 2024 21:28:50 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXuKi9jDrnyPnfhvkmq6Erj6fhZq2lx13HqYpkAJ1Pqi4FJe3sq7G6wTTKcN6S145v+jS3lavqmw5WRF/NpmgLqBbjoA7oPF2b/CaxEEjqXfYXPpPy6XLpxibqSQFnH+nqJvmCvY6DFViHjQgYfCDHI6KFSrd3Lg76i/Wcj/asT+Wk4UoQdZjBtIpeYa69xcFHPQjvADtcyK4R0x+ttdSX35X4QQqHOm8Y=
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 bo16-20020a056000069000b0033af49f5819sm8121536wrb.19.2024.01.31.21.28.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 31 Jan 2024 21:28:50 -0800 (PST)
Message-ID: <70aa5827-a68a-4759-a971-e6248afa21b0@linaro.org>
Date: Thu, 1 Feb 2024 09:28:45 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] plugins: scoreboard API
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20240118032400.3762658-1-pierrick.bouvier@linaro.org>
 <20240118032400.3762658-3-pierrick.bouvier@linaro.org>
 <87il3grut0.fsf@draig.linaro.org>
 <ebbd8949-fb51-4cd0-9fe0-0fbd765c8331@linaro.org>
Content-Language: en-US
In-Reply-To: <ebbd8949-fb51-4cd0-9fe0-0fbd765c8331@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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

T24gMS8zMS8yNCAxMTo0NCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMS8yNi8y
NCAxOToxNCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+ICsgICAgICAgIG5lZWRfcmVhbGxv
YyA9IFRSVUU7DQo+Pj4gKyAgICB9DQo+Pj4gKyAgICBwbHVnaW4uc2NvcmVib2FyZF9zaXpl
ID0gY3B1LT5jcHVfaW5kZXggKyAxOw0KPj4+ICsgICAgZ19hc3NlcnQocGx1Z2luLnNjb3Jl
Ym9hcmRfc2l6ZSA8PSBwbHVnaW4uc2NvcmVib2FyZF9hbGxvY19zaXplKTsNCj4+PiArDQo+
Pj4gKyAgICBpZiAoZ19oYXNoX3RhYmxlX3NpemUocGx1Z2luLnNjb3JlYm9hcmRzKSA9PSAw
KSB7DQo+Pj4gKyAgICAgICAgLyogbm90aGluZyB0byBkbywgd2UganVzdCB1cGRhdGVkIHNp
emVzIGZvciBmdXR1cmUgc2NvcmVib2FyZHMgKi8NCj4+PiArICAgICAgICByZXR1cm47DQo+
Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgaWYgKG5lZWRfcmVhbGxvYykgew0KPj4+ICsj
aWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPj4+ICsgICAgICAgIC8qKg0KPj4+ICsgICAgICAg
ICAqIGNwdXMgbXVzdCBiZSBzdG9wcGVkLCBhcyBzb21lIHRiIG1pZ2h0IHN0aWxsIHVzZSBh
biBleGlzdGluZw0KPj4+ICsgICAgICAgICAqIHNjb3JlYm9hcmQuDQo+Pj4gKyAgICAgICAg
ICovDQo+Pj4gKyAgICAgICAgc3RhcnRfZXhjbHVzaXZlKCk7DQo+Pj4gKyNlbmRpZg0KPj4N
Cj4+IEhtbSB0aGlzIHNlZW1zIHdyb25nIHRvIGJlIFVTRVJfT05MWS4gV2hpbGUgd2UgZG9u
J3QgZXhwZWN0IHRvIHJlc2l6ZSBpbg0KPj4gc3lzdGVtIG1vZGUgaWYgd2UgZGlkIHdlIGNl
cnRhaW5seSB3YW50IHRvIGRvIGl0IGR1cmluZyBleGNsdXNpdmUNCj4+IHBlcmlvZHMuDQo+
Pg0KPiANCj4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgY3VycmVudF9jcHUgVExTIHZhciBpcyBu
b3Qgc2V0IGluIGNwdXMtY29tbW9uLmMgYXQNCj4gdGhpcyBwb2ludC4NCj4gDQo+IEluZGVl
ZCB3ZSBhcmUgbm90IG9uIGFueSBjcHVfZXhlYyBwYXRoLCBidXQgaW4gdGhlIGNwdV9yZWFs
aXplX2ZuIHdoZW4NCj4gY2FsbGluZyB0aGlzICh0aHJvdWdoIHFlbXVfcGx1Z2luX3ZjcHVf
aW5pdF9ob29rKS4NCj4gDQo+IE9uZSBvYnZpb3VzIGZpeCBpcyB0byBjaGVjayBpZiBpdCdz
IE5VTEwgb3Igbm90LCBsaWtlOg0KPiAtLS0gYS9jcHUtY29tbW9uLmMNCj4gKysrIGIvY3B1
LWNvbW1vbi5jDQo+IEBAIC0xOTMsNyArMTkzLDcgQEAgdm9pZCBzdGFydF9leGNsdXNpdmUo
dm9pZCkNCj4gICAgICAgIENQVVN0YXRlICpvdGhlcl9jcHU7DQo+ICAgICAgICBpbnQgcnVu
bmluZ19jcHVzOw0KPiANCj4gLSAgICBpZiAoY3VycmVudF9jcHUtPmV4Y2x1c2l2ZV9jb250
ZXh0X2NvdW50KSB7DQo+ICsgICAgaWYgKGN1cnJlbnRfY3B1ICYmIGN1cnJlbnRfY3B1LT5l
eGNsdXNpdmVfY29udGV4dF9jb3VudCkgew0KPiAgICAgICAgICAgIGN1cnJlbnRfY3B1LT5l
eGNsdXNpdmVfY29udGV4dF9jb3VudCsrOw0KPiAgICAgICAgICAgIHJldHVybjsNCj4gICAg
ICAgIH0NCj4gDQo+IERvZXMgYW55b25lIHN1Z2dlc3QgYW5vdGhlciBwb3NzaWJsZSBmaXg/
IChsaWtlIGRlZmluZSBjdXJyZW50X2NwdQ0KPiBzb21ld2hlcmUsIG9yIG1vdmluZyBxZW11
X3BsdWdpbl92Y3B1X2luaXRfaG9vayBjYWxsKS4NCg0KUnVubmluZyBpbml0X2hvb2sgYXN5
bmNocm9ub3VzbHkgb24gY3B1IHdvcmtzIGFuZCBzb2x2ZXMgdGhlIHByb2JsZW0sIA0Kd2l0
aG91dCBhbnkgbmVlZCB0byBtb2RpZnkgc3RhcnQvZW5kIGV4Y2x1c2l2ZSBjb2RlLg0K

