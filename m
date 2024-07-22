Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F444C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:05:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0DS-0003s0-R6; Mon, 22 Jul 2024 17:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0DQ-0003jb-Ie
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:05:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0DO-0004q1-A2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:05:04 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso706885ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682299; x=1722287099; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9qmfNrHaKBw+kkqdhiPfGzqCKdhrY9ABzwwKoXLFk7U=;
 b=Rb5vIzR1tLPKkrxogaLDV6kAd7d1s8gaYHdal3kq+66VQ1FPMx8aBX1uL/A0QQiRyQ
 +Nbh2DMFkyL6QSw/PEFbvy9v61iS9wnh2v2WmhZbC9CjnIB2EwTmlg+iAKAQejfOpIbi
 CYxT94RE5ylS1lzpCKX2KRkhTCTHwnlv+MLkxBzo5LTOjw7FeQlYg4bCpi0xmZuFO/Na
 oLUPKEIsq0XXre1iMzYQ/0Hxx8Fzdh6bRBUEpZS5zATca1SigQzHJp5y0XSIPlnjoSHb
 LGWxcAuybeUJNHrYg0JzF2XJdO0D4nOWscCSmxVbyCj9l07yuiefaQnPfRUtEIXbz5+0
 ViQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682299; x=1722287099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9qmfNrHaKBw+kkqdhiPfGzqCKdhrY9ABzwwKoXLFk7U=;
 b=vsTZG2mIu0Z5cafm3SIPIQw64eAGxyxl8OvZ70Yy0QhQgt0kHc1y0my8BFSTDhCkjw
 Nn45BGelhsNwVE5VrNQtoTVBIxDGqvKalnJggyHGXYlupvHbSNMrv6h2E3ouNN/NZviH
 1LhneWpwvaRqe2OpveVeyYMo6J/OdmY29OUiHLt+Ci0N09BGqtHmHrz3Q5BpDJtD4Tpk
 LUV1wOtRvfavab3v/moVNDumaouRQWkKTutsjZpS8qCRrybUr3NWVrC4n4M0KWRIpSeI
 nEPuiZFNlPrXOXjs2yZYI9aXbn83QHEarOxK7n5AQxzAGTiN/JRhjmQpzMofnmx+X0KG
 ltWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtYBm9m/86hFqe/ShInnlng9RnxT7duM4jKCHOfo344JEAlkxl0ZuActH9AycSN3XkDaP7CgbhsHoCwksg/RmZ0+bBS0w=
X-Gm-Message-State: AOJu0YyJ2KKakXiFZ2D97cR8CH5L5e23iwUJ4oDeDMV4Se1nFpNXZ+Hv
 Ki68avBeqJvD2ASoUFeemupBFZ5KNQO6/rCHZ5qlka6XOJoj3n4ogAvbPfYMibcEBIv+Ld25Tzj
 nY34=
X-Google-Smtp-Source: AGHT+IE8mxVdNz7i88gCtkW98zDoaS5PzBomPUYXN29WjO9vxvbgwoZxMIChzGfR4LfeN6xTOITLiw==
X-Received: by 2002:a17:903:1108:b0:1fd:aa8d:ad00 with SMTP id
 d9443c01a7336-1fdb5ec0061mr8513645ad.18.1721682299282; 
 Mon, 22 Jul 2024 14:04:59 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f28c210sm59824895ad.80.2024.07.22.14.04.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:04:58 -0700 (PDT)
Message-ID: <e9d1a4c3-1374-4268-92ec-c18e0f00baaf@linaro.org>
Date: Mon, 22 Jul 2024 14:04:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] util/fifo8: Rename fifo8_peek_buf() ->
 fifo8_peek_constbuf()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240722160745.67904-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNy8yMi8yNCAwOTowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
bmNlIGZpZm84X3BlZWtfYnVmKCkgcmV0dXJuIGEgY29uc3QgYnVmZmVyICh3aGljaCBwb2lu
dHMNCj4gZGlyZWN0bHkgaW50byB0aGUgRklGTyBiYWNraW5nIHN0b3JlKSwgcmVuYW1lIGl0
IHVzaW5nIHRoZQ0KPiAnY29uc3RidWYnIHN1ZmZpeC4gVGhpcyB3aWxsIGhlbHAgZGlmZmVy
ZW50aWF0ZSB3aXRoIG1ldGhvZHMNCj4gKmNvcHlpbmcqIHRoZSBGSUZPIGRhdGEuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvcWVtdS9maWZvOC5oIHwgNCArKy0tDQo+ICAg
aHcvc2NzaS9lc3AuYyAgICAgICAgfCAyICstDQo+ICAgdXRpbC9maWZvOC5jICAgICAgICAg
fCAyICstDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2ZpZm84LmggYi9pbmNs
dWRlL3FlbXUvZmlmbzguaA0KPiBpbmRleCAyNjkyZDZiZmRhLi43OTQ1MGY0NTgzIDEwMDY0
NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvZmlmbzguaA0KPiArKysgYi9pbmNsdWRlL3FlbXUv
ZmlmbzguaA0KPiBAQCAtODksNyArODksNyBAQCB1aW50OF90IGZpZm84X3BvcChGaWZvOCAq
Zmlmbyk7DQo+ICAgY29uc3QgdWludDhfdCAqZmlmbzhfcG9wX2J1ZihGaWZvOCAqZmlmbywg
dWludDMyX3QgbWF4LCB1aW50MzJfdCAqbnVtcHRyKTsNCj4gICANCj4gICAvKioNCj4gLSAq
IGZpZm84X3BlZWtfYnVmOiByZWFkIHVwdG8gbWF4IGJ5dGVzIGZyb20gdGhlIGZpZm8NCj4g
KyAqIGZpZm84X3BlZWtfY29uc3RidWY6IHJlYWQgdXB0byBtYXggYnl0ZXMgZnJvbSB0aGUg
Zmlmbw0KPiAgICAqIEBmaWZvOiBGSUZPIHRvIHJlYWQgZnJvbQ0KPiAgICAqIEBtYXg6IG1h
eGltdW0gbnVtYmVyIG9mIGJ5dGVzIHRvIHBlZWsNCj4gICAgKiBAbnVtcHRyOiBwb2ludGVy
IGZpbGxlZCB3aXRoIG51bWJlciBvZiBieXRlcyByZXR1cm5lZCAoY2FuIGJlIE5VTEwpDQo+
IEBAIC0xMTMsNyArMTEzLDcgQEAgY29uc3QgdWludDhfdCAqZmlmbzhfcG9wX2J1ZihGaWZv
OCAqZmlmbywgdWludDMyX3QgbWF4LCB1aW50MzJfdCAqbnVtcHRyKTsNCj4gICAgKg0KPiAg
ICAqIFJldHVybnM6IEEgcG9pbnRlciB0byBwZWVrYWJsZSBkYXRhLg0KPiAgICAqLw0KPiAt
Y29uc3QgdWludDhfdCAqZmlmbzhfcGVla19idWYoRmlmbzggKmZpZm8sIHVpbnQzMl90IG1h
eCwgdWludDMyX3QgKm51bXB0cik7DQo+ICtjb25zdCB1aW50OF90ICpmaWZvOF9wZWVrX2Nv
bnN0YnVmKEZpZm84ICpmaWZvLCB1aW50MzJfdCBtYXgsIHVpbnQzMl90ICpudW1wdHIpOw0K
PiAgIA0KPiAgIC8qKg0KPiAgICAqIGZpZm84X3Jlc2V0Og0KPiBkaWZmIC0tZ2l0IGEvaHcv
c2NzaS9lc3AuYyBiL2h3L3Njc2kvZXNwLmMNCj4gaW5kZXggODUwNGRkMzBhMC4uNTI2ZWQ5
MWJlZiAxMDA2NDQNCj4gLS0tIGEvaHcvc2NzaS9lc3AuYw0KPiArKysgYi9ody9zY3NpL2Vz
cC5jDQo+IEBAIC00ODYsNyArNDg2LDcgQEAgc3RhdGljIGJvb2wgZXNwX2NkYl9yZWFkeShF
U1BTdGF0ZSAqcykNCj4gICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gICAgICAgfQ0KPiAg
IA0KPiAtICAgIHBidWYgPSBmaWZvOF9wZWVrX2J1Zigmcy0+Y21kZmlmbywgbGVuLCAmbik7
DQo+ICsgICAgcGJ1ZiA9IGZpZm84X3BlZWtfY29uc3RidWYoJnMtPmNtZGZpZm8sIGxlbiwg
Jm4pOw0KPiAgICAgICBpZiAobiA8IGxlbikgew0KPiAgICAgICAgICAgLyoNCj4gICAgICAg
ICAgICAqIEluIG5vcm1hbCB1c2UgdGhlIGNtZGZpZm8gc2hvdWxkIG5ldmVyIHdyYXAsIGJ1
dCBpbmNsdWRlIHRoaXMgY2hlY2sNCj4gZGlmZiAtLWdpdCBhL3V0aWwvZmlmbzguYyBiL3V0
aWwvZmlmbzguYw0KPiBpbmRleCAyOTI1ZmU1NjExLi4yMTk0M2M2MDMyIDEwMDY0NA0KPiAt
LS0gYS91dGlsL2ZpZm84LmMNCj4gKysrIGIvdXRpbC9maWZvOC5jDQo+IEBAIC05Miw3ICs5
Miw3IEBAIHN0YXRpYyBjb25zdCB1aW50OF90ICpmaWZvOF9wZWVrcG9wX2J1ZihGaWZvOCAq
ZmlmbywgdWludDMyX3QgbWF4LA0KPiAgICAgICByZXR1cm4gcmV0Ow0KPiAgIH0NCj4gICAN
Cj4gLWNvbnN0IHVpbnQ4X3QgKmZpZm84X3BlZWtfYnVmKEZpZm84ICpmaWZvLCB1aW50MzJf
dCBtYXgsIHVpbnQzMl90ICpudW1wdHIpDQo+ICtjb25zdCB1aW50OF90ICpmaWZvOF9wZWVr
X2NvbnN0YnVmKEZpZm84ICpmaWZvLCB1aW50MzJfdCBtYXgsIHVpbnQzMl90ICpudW1wdHIp
DQo+ICAgew0KPiAgICAgICByZXR1cm4gZmlmbzhfcGVla3BvcF9idWYoZmlmbywgbWF4LCBu
dW1wdHIsIGZhbHNlKTsNCj4gICB9DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

