Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4096AE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:50:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLwQ-0005NL-NK; Fri, 10 Jan 2025 15:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLwL-0005N0-1o
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:49:09 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLwJ-0007Ce-DH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:49:08 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so63193415ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542146; x=1737146946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qp1vw6LLgC4whnIzNwEDY2GDgmSmTaMvI5zKxITP+zo=;
 b=uA67yhr85sR25HU6kzSZL6KB3ySWuile7DaRPjBgO1xk4I1Kkjz5tlnKnR8qiDNfl4
 P8VOc6890OTe579rtZXdneGCz3uzN9w1cxkSn1QYEhPuXltjBzAIXZQNLHps5gaYY8aH
 qOpQTOvhZmFvekfP2Cy6x+VEeiJdxTamT2qgB6jxgeE8kugSJl0wS7rTzYRtOXEP+cLN
 sVOEhNj+H+zRT2fLc+ZbbknyPrrbVTVk4LQQdaymIlLt0+ugttXJCaEewpathESJRuIR
 6QHL0xTk/E/wiFGNLHQs9r7/8UE5/DBD2A7Y3Dhvfa9v2a2FpWj0xp8Rv7KUrH+MD1n5
 pJIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542146; x=1737146946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qp1vw6LLgC4whnIzNwEDY2GDgmSmTaMvI5zKxITP+zo=;
 b=Ewa0ZW+cRr8heRaQ8EPcj4VeaQhBDG6qd9LiYYDwG6dm56omHj1/6UNWaMx+SPcOUX
 hgYkjCe3kR47pk+lBJiDwNI2AKm7NvPW5F85ksjrmzgw7ORItNSRDloLRXnBXt1ooDkc
 ofgTbRax/JXIwabBblNCutGIojA2qfIWJteueb5FxXL2mzaRoRszIgCXH/ENxuQ+eFu8
 Tu/nd9ilLES5Kdd5pdyJwjmkfMV2WWHYCAx1ijoez+P73FMtH+1BwmJoS3C2Mi1Rwy+E
 JR4G0uj/gNuUGi/CJ6IQpEHew9ZxaMXfp1u9Eo6WLFWelsQOvpAUPO0IWlPJ05jH0CJL
 H2lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3snIj5BjOYYO56zhN7fJFZWkHysSP4jXgnYQPkTGqS+6ukLIaX9PmCyGPWTrXR+xF7nd6IVvpACqQ@nongnu.org
X-Gm-Message-State: AOJu0YyLvX1+1cVTL30413OW6T4DjbM4UTCLX8M8TGg5TJ0oN18RG854
 8uiye3pHAFLG7vqrGdI6OXAqcqW8L9bNH7tABO6+1CbKm2nMghCieDiIxrsqDzY=
X-Gm-Gg: ASbGncs5/4WRoZhc2QlaNpRE/qK0EHSMFvw6s0PBmk+sT+rlTbJyltfX7cNOOnAXBFt
 Sqe14ZsYdFxKn8osGxge27eShGLiqxIpxB2O8fQVNf33kiDC0dRpKrEsnFYKEY+/jWGammw5tPD
 KG8yVT4ytXDZfZ6Pf8ioHwjWe8A8Tym0Px1gfUyFrZdFtxDcZSVz+qA2k4tf/RecXzUGdeHf9vL
 ZpZPwjtxA7wcx8RS6bL75vKZ3n0VbjcBUvfUabMNOkqsxBIfIPYGgWdYRhxf4XEszsuPg==
X-Google-Smtp-Source: AGHT+IHU6SGqnyopo+eKbA4eW3fQrO2td3O3oiSdbsnI/3bgr8wugQpKRyaAm6N06w2lIRUtrBrPrw==
X-Received: by 2002:a05:6a00:39a5:b0:725:ce39:4516 with SMTP id
 d2e1a72fcca58-72d303449fdmr13095694b3a.7.1736542145735; 
 Fri, 10 Jan 2025 12:49:05 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d405489bdsm1908858b3a.33.2025.01.10.12.49.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 12:49:05 -0800 (PST)
Message-ID: <9846c61e-1b5d-4e20-bf5f-6101df641cc1@linaro.org>
Date: Fri, 10 Jan 2025 12:49:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] hw/char/serial: Ensure SerialState::irq is set
 when realizing
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250110182759.84071-1-philmd@linaro.org>
 <20250110182759.84071-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250110182759.84071-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

T24gMS8xMC8yNSAxMDoyNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNl
cmlhbFN0YXRlOjppcnEgbXVzdCBiZSBzZXQgYnkgcGFyZW50IHdoZW4gdGhlIG9iamVjdCBp
cyByZWFsaXplZC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogUGFvbG8gQm9uemluaSA8cGJvbnpp
bmlAcmVkaGF0LmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBody9jaGFyL3NlcmlhbC1wY2kt
bXVsdGkuYyB8IDIgKy0NCj4gICBody9jaGFyL3NlcmlhbC1wY2kuYyAgICAgICB8IDIgKy0N
Cj4gICBody9jaGFyL3NlcmlhbC5jICAgICAgICAgICB8IDIgKysNCj4gICAzIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9ody9jaGFyL3NlcmlhbC1wY2ktbXVsdGkuYyBiL2h3L2NoYXIvc2VyaWFsLXBjaS1t
dWx0aS5jDQo+IGluZGV4IDc1NzhlODYzY2ZlLi41YWQyYzBlODQ0MyAxMDA2NDQNCj4gLS0t
IGEvaHcvY2hhci9zZXJpYWwtcGNpLW11bHRpLmMNCj4gKysrIGIvaHcvY2hhci9zZXJpYWwt
cGNpLW11bHRpLmMNCj4gQEAgLTEwNiwxMSArMTA2LDExIEBAIHN0YXRpYyB2b2lkIG11bHRp
X3NlcmlhbF9wY2lfcmVhbGl6ZShQQ0lEZXZpY2UgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAg
IA0KPiAgICAgICBmb3IgKGkgPSAwOyBpIDwgbnBvcnRzOyBpKyspIHsNCj4gICAgICAgICAg
IHMgPSBwY2ktPnN0YXRlICsgaTsNCj4gKyAgICAgICAgcy0+aXJxID0gcGNpLT5pcnFzW2ld
Ow0KPiAgICAgICAgICAgaWYgKCFxZGV2X3JlYWxpemUoREVWSUNFKHMpLCBOVUxMLCBlcnJw
KSkgew0KPiAgICAgICAgICAgICAgIG11bHRpX3NlcmlhbF9wY2lfZXhpdChkZXYpOw0KPiAg
ICAgICAgICAgICAgIHJldHVybjsNCj4gICAgICAgICAgIH0NCj4gLSAgICAgICAgcy0+aXJx
ID0gcGNpLT5pcnFzW2ldOw0KPiAgICAgICAgICAgcGNpLT5uYW1lW2ldID0gZ19zdHJkdXBf
cHJpbnRmKCJ1YXJ0ICMlenUiLCBpICsgMSk7DQo+ICAgICAgICAgICBtZW1vcnlfcmVnaW9u
X2luaXRfaW8oJnMtPmlvLCBPQkpFQ1QocGNpKSwgJnNlcmlhbF9pb19vcHMsIHMsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNpLT5uYW1lW2ldLCA4KTsNCj4gZGlm
ZiAtLWdpdCBhL2h3L2NoYXIvc2VyaWFsLXBjaS5jIGIvaHcvY2hhci9zZXJpYWwtcGNpLmMN
Cj4gaW5kZXggNjY1OWNlZjVkNGIuLmQzMWEzY2NmMDNiIDEwMDY0NA0KPiAtLS0gYS9ody9j
aGFyL3NlcmlhbC1wY2kuYw0KPiArKysgYi9ody9jaGFyL3NlcmlhbC1wY2kuYw0KPiBAQCAt
NDksMTMgKzQ5LDEzIEBAIHN0YXRpYyB2b2lkIHNlcmlhbF9wY2lfcmVhbGl6ZShQQ0lEZXZp
Y2UgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICBQQ0lTZXJpYWxTdGF0ZSAqcGNpID0g
RE9fVVBDQVNUKFBDSVNlcmlhbFN0YXRlLCBkZXYsIGRldik7DQo+ICAgICAgIFNlcmlhbFN0
YXRlICpzID0gJnBjaS0+c3RhdGU7DQo+ICAgDQo+ICsgICAgcy0+aXJxID0gcGNpX2FsbG9j
YXRlX2lycSgmcGNpLT5kZXYpOw0KPiAgICAgICBpZiAoIXFkZXZfcmVhbGl6ZShERVZJQ0Uo
cyksIE5VTEwsIGVycnApKSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+ICAgICAgIH0NCj4g
ICANCj4gICAgICAgcGNpLT5kZXYuY29uZmlnW1BDSV9DTEFTU19QUk9HXSA9IHBjaS0+cHJv
Z19pZjsNCj4gICAgICAgcGNpLT5kZXYuY29uZmlnW1BDSV9JTlRFUlJVUFRfUElOXSA9IDB4
MDE7DQo+IC0gICAgcy0+aXJxID0gcGNpX2FsbG9jYXRlX2lycSgmcGNpLT5kZXYpOw0KPiAg
IA0KPiAgICAgICBtZW1vcnlfcmVnaW9uX2luaXRfaW8oJnMtPmlvLCBPQkpFQ1QocGNpKSwg
JnNlcmlhbF9pb19vcHMsIHMsICJzZXJpYWwiLCA4KTsNCj4gICAgICAgcGNpX3JlZ2lzdGVy
X2JhcigmcGNpLT5kZXYsIDAsIFBDSV9CQVNFX0FERFJFU1NfU1BBQ0VfSU8sICZzLT5pbyk7
DQo+IGRpZmYgLS1naXQgYS9ody9jaGFyL3NlcmlhbC5jIGIvaHcvY2hhci9zZXJpYWwuYw0K
PiBpbmRleCA3MDA0NGUxNGEwZi4uNTYyOTMxNjg1ZTcgMTAwNjQ0DQo+IC0tLSBhL2h3L2No
YXIvc2VyaWFsLmMNCj4gKysrIGIvaHcvY2hhci9zZXJpYWwuYw0KPiBAQCAtOTIzLDYgKzky
Myw4IEBAIHN0YXRpYyB2b2lkIHNlcmlhbF9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yICoqZXJycCkNCj4gICB7DQo+ICAgICAgIFNlcmlhbFN0YXRlICpzID0gU0VSSUFMKGRl
dik7DQo+ICAgDQo+ICsgICAgYXNzZXJ0KHMtPmlycSk7DQo+ICsNCj4gICAgICAgcy0+bW9k
ZW1fc3RhdHVzX3BvbGwgPSB0aW1lcl9uZXdfbnMoUUVNVV9DTE9DS19WSVJUVUFMLCAoUUVN
VVRpbWVyQ0IgKikgc2VyaWFsX3VwZGF0ZV9tc2wsIHMpOw0KPiAgIA0KPiAgICAgICBzLT5m
aWZvX3RpbWVvdXRfdGltZXIgPSB0aW1lcl9uZXdfbnMoUUVNVV9DTE9DS19WSVJUVUFMLCAo
UUVNVVRpbWVyQ0IgKikgZmlmb190aW1lb3V0X2ludCwgcyk7DQoNClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

