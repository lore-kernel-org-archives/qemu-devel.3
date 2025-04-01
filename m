Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD1AC36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:59:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzd57-0004d1-Qf; Tue, 01 Apr 2025 10:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd54-0004ZO-HQ
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:59:11 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzd52-0002I1-Oj
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 10:59:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227aaa82fafso108806715ad.2
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 07:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743519547; x=1744124347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5Cqj8Lcf/c3B2S7eBbcpAncqej5LO1ZHIwamDwXEe8=;
 b=c2zr8IMgR2W6jeXyClnDx3F42mPM00ZrFTWN/L7hP8Iq/tkfBAdswYLtzgt92y56VB
 OGkwy65GcEwTlPCdKQIjOUPvclnKo6VwZCgirA+TcCXMWvPFgdNTCKzQ+DcZge8JUq7n
 9JRkSsfHadRAzCTU7eqDg/oRzp86m+YKrb4ywNF+nXF+BMydj5G15U6sVVgtjAQOS8Qn
 H/Q8ZPYg0ynhQwrY1Zm75gJjmaRrVIikRrYgHnhYo8vcX4HI8BHHERZ+lTOlmwfl6Ax2
 4O67mYPQ51+uut3JgxfAYJQE1uuhY7TUwyqkZRXcRvq5IhKlt1eA8Ic2gYskt91ZhcQm
 X7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743519547; x=1744124347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T5Cqj8Lcf/c3B2S7eBbcpAncqej5LO1ZHIwamDwXEe8=;
 b=XEUtRaMXGlxQ8MqFyZ/4lhXTeAlWsoPNfaY5XVkKGtuarnvbY/up9NIRxYu61Xence
 nosCZHFeQLxJFmlltRRDaXH6zzwuYrd+4IYTFNertuXbyWtURyQN1NH7FgAZ03SpcOSa
 VSv6Q8kpu9j+uDipP6VSnjQRahvdfpVt+RzAyj7y6opprIZ7CNxZT2xgczNHOKeKUFkb
 FDK3w7Oi6iunJ01fvATTo5qvZtTVQLmzBWmk1nB5tS6/x+1lIl8GsnCATBQZ5w9B4gbI
 zlJaVuoahyldE/P1HNJaUU0I0sn3Y8MH6pSejoWz8BPXskaeX++HOD9DY5ZsF1x0RE6a
 h8dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdXvPXC5YAhvDxOnGVMFG9IlZ79LxXbLmP+VtTHtSFuvZQMX1WWZdtfZXwmA2igLjWFBrEhrLwwBwA@nongnu.org
X-Gm-Message-State: AOJu0Yxe8BO6rcuiDkr7oCz2mpxdfYfW5K5OJ1SLVbTaZCEuOzwRaFs7
 0/mhlgLD5lfReqee4+bKo28txm3D2CUr0dVwJPuCXtDOY0lUSQINrQH8NlvHFS0=
X-Gm-Gg: ASbGnct6YGiPHci5sIGewMlQmVm35YBwZ5GwSiI/FSUmzbE773Kpk1SzdDAvIB0yUkD
 xRif2BSMP0NwjhCu2ree1r90I6aFM4mTiM7SzFYhKXQeN245MVDTp/nCCz9DO0fXcoQypi+/xKA
 GoTq5jETl1Nb0oOSbD5s+l2giUXjEfhT4eCSO0bXeTqua2dE4l2/Mf230ur1Hp1plFd6tw7zG0Q
 DBdLpdkGr9Qr9N+hrcbvymUaRu/n2tTOGhrbw0vkQfLIG6Vhr92dy8yuHs9JycrduiOqUusVzIX
 sPYfXklrEoFhP8xgNg5Fk13YgP87gED6QaU6xYUCPHUS1qfHSESXHRk4WA==
X-Google-Smtp-Source: AGHT+IFFJUX2tLrYfmqstHjUTjKaq0mk+ai58QU89psS7qcT4QoBsCp4EdDZ3QXoi+M7u7//ATOgLw==
X-Received: by 2002:a05:6a20:2d20:b0:1fe:90c5:7ceb with SMTP id
 adf61e73a8af0-2009f79c468mr24718638637.40.1743519547152; 
 Tue, 01 Apr 2025 07:59:07 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73970e52306sm8964433b3a.83.2025.04.01.07.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 07:59:06 -0700 (PDT)
Message-ID: <0c042bd1-7ff9-4ac9-8c75-0f0c63d43132@linaro.org>
Date: Tue, 1 Apr 2025 07:59:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bsd-user: add option to enable plugins
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, richard.henderson@linaro.org,
 alex.bennee@linaro.org, Kyle Evans <kevans@freebsd.org>
References: <20250331234228.3475706-1-pierrick.bouvier@linaro.org>
 <a2907212-feef-407f-bc2d-03667aaae174@linaro.org>
 <c474f845-3d3b-4060-94c2-0d7b5f044d82@linaro.org>
 <5f5f280c-34a5-4961-a9c0-74df5e0b0387@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5f5f280c-34a5-4961-a9c0-74df5e0b0387@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gNC8xLzI1IDA3OjQ0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
MS80LzI1IDE2OjMzLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gMy8zMS8yNSAy
MzoxNSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+Pj4gSGkgUGllcnJpY2ss
DQo+Pj4NCj4+PiBPbiAxLzQvMjUgMDE6NDIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+
Pj4+IE5vdGhpbmcgcHJldmVudCBwbHVnaW5zIHRvIGJlIGVuYWJsZWQgb24gdGhpcyBwbGF0
Zm9ybSBmb3IgdXNlcg0KPj4+PiBiaW5hcmllcywgb25seSB0aGUgb3B0aW9uIGluIHRoZSBk
cml2ZXIgaXMgbWlzc2luZy4NCj4+Pg0KPj4+IFBlciBjb21taXQgOTAzZTg3MGYyNDUgKCJw
bHVnaW5zL2FwaTogc3BsaXQgb3V0IGJpbmFyeQ0KPj4+IHBhdGgvc3RhcnQvZW5kL2VudHJ5
IGNvZGUiKSB0aGlzIGlzIGRlbGliZXJhdGU6DQo+Pj4NCj4+PiAgwqDCoMKgwqDCoCBUaGUg
QlNEIHVzZXItbW9kZSBjb21tYW5kIGxpbmUgaXMgc3RpbGwgbWlzc2luZyAtcGx1Z2luLg0K
Pj4+ICDCoMKgwqDCoMKgIFRoaXMgY2FuIGJlIGVuYWJsZWQgb25jZSB3ZSBoYXZlIHJlbGlh
YmxlIGNoZWNrLXRjZyB0ZXN0cw0KPj4+ICDCoMKgwqDCoMKgIHdvcmtpbmcgZm9yIHRoZSBC
U0RzLg0KPj4+DQo+Pj4gU2hvdWxkIHdlIGVuYWJsZSB0aGlzIHdpdGhvdXQgdGVzdCBoYXJu
ZXNzaW5nPw0KPj4+DQo+Pg0KPj4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlzLg0KPj4NCj4+
IEhvd2V2ZXIsIEkgZG9uJ3QgZ2V0IHRoZSBhcmd1bWVudCwgYXMgdGhlIHNhbWUgY291bGQg
YmUgc2FpZCBhYm91dA0KPj4gc3lzdGVtIG1vZGUsIHdoaWNoIHJ1bnMgb24gQlNEIGFsc28s
IGFuZCBhbHJlYWR5IGhhcyBwbHVnaW5zIGVuYWJsZWQuDQo+PiBUaGUgY291cGxpbmcgYmV0
d2VlbiB1c2VyIHJlbGF0ZWQgY29kZSBhbmQgcGx1Z2lucyBpcyB2ZXJ5IGxvdyAoanVzdA0K
Pj4gb3B0aW9ucyBwYXJzaW5nIGFuZCBpbml0IGNvZGUpLCBzbyBJIGRvbid0IHNlZSB3aHkg
d2UgY291bGQgaGF2ZSBhIGJ1Zw0KPj4gcmVsYXRlZCB0byBhIHNwZWNpZmljIHBsYXRmb3Jt
IG9ubHkgZm9yIHVzZXIgYmluYXJpZXMuDQo+Pg0KPj4gU28gZWl0aGVyIHdlIGRlYWN0aXZh
dGUgcGx1Z2lucyBjb21wbGV0ZWx5IGZvciBic2QgYmluYXJpZXMsIG9yIHdlIHRha2UNCj4+
IGEgbGVhcCBvZiBmYWl0aCB0aGF0IGl0IHdvcmtzIGZvciB0aGVtLg0KPj4NCj4+IEBBbGV4
LCBhbnkgZnVydGhlciBpbnNpZ2h0IG9uIHRoaXM/DQo+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+
IC0tLQ0KPj4+PiAgwqDCoCBic2QtdXNlci9tYWluLmMgfCAxMiArKysrKysrKysrKysNCj4+
Pj4gIMKgwqAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4+Pg0KPj4+IElk
ZWFsbHkgd2UnZCBoYXZlIGhlbHBlcnMgZm9yIGNvbW1vbiB1c2VyIGNvZGUgaW4gY29tbW9u
LXVzZXIvLi4uDQo+Pj4NCj4+DQo+PiBFdmVyeXRoaW5nIGlzIGFscmVhZHkgY29tbW9uIGZv
ciBwbHVnaW5zLCBleGNlcHQgYWRkaW5nIHRoZSBjYWxsIHRvDQo+PiBwbHVnaW4gY29tbWFu
ZCBsaW5lIG9wdGlvbiBwYXJzaW5nIGZ1bmN0aW9uLg0KPiANCj4gWWVhaCwgSSBtZWFuIHRo
ZSByZXN0IG9mIG1haW4oKSA7KQ0KPiANCg0KSXQncyBub3QgYSBwcmlvcml0eSBhdCB0aGUg
bW9tZW50LCBhbmQgbm90IGJsb2NraW5nIGFueXRoaW5nIG9uIG91ciANCnBhdGgsIGJ1dCB5
ZXMsIGl0IHdvdWxkIGJlIG5pY2UgdG8gc2hhcmUgbW9yZSBpZGVhbGx5Lg0KDQo+Pj4gQW55
d2F5LCBzaW5jZSB0aGlzIHBhdGNoIGRvZXMgd2hhdCBpdCBzYXlzOg0KPj4+IFJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+Pj4N
Cj4+DQo+PiBUaGFua3MsDQo+PiBQaWVycmljaw0KPj4NCj4gDQoNCg==

