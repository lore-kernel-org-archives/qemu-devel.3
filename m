Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7140CC27C43
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:32:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCoJW-0001p3-4N; Thu, 30 May 2024 18:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoJU-0001oJ-9y
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:32:00 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoJR-0001C5-4Q
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:32:00 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-70244776719so147239b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717108315; x=1717713115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1JxSua5tIhIMFRj7DIoOkLpqa/U0TWnELnntr8zZWYQ=;
 b=atorlu5rbgXLDJM31zFciymGmBa5Jj2AROjFDu9azA7F2Tb1H5XasBNmGisNMc9QNg
 XyoaAWUx82wS8AkWbgBzipVJlh3j23O2L8tJS1F8UlquNQDcm3kueI15L404y/XsAQbr
 5DRDHOvb3pvWrjxcvYXr231F7l0msI5SAmyuIlPuTjZmFvI1fWsJDDixmvMJipEXj1v/
 6UKvplHOz90nLVh761diNaVrakdV2x5oS3pf6JhcULVtjxlpf36/3pmecVbv6G2pHrw2
 yfuNg+UzokWCRloDuAC9jroD2G1ndHW2wkPQH6epAPEt3dLsAg4ghY+ipGa6ie3RkTFa
 0CdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717108315; x=1717713115;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1JxSua5tIhIMFRj7DIoOkLpqa/U0TWnELnntr8zZWYQ=;
 b=AF/D6G1zGmb/QfoYTHBh62fhq35xy8Pon8c9lvek3PDUEQ2feYxCi92dMhT4BZUvMt
 RUikWnTer6jn2xiZX86MxGhqY9VeZBH4Gfd7uAspqkF+OQGkFrBaqvxcIxe3NCQIcO/X
 OlhuMMoW7OmeEIRZpTMZi5FYt4TwBgneDk5/adcuewkBRCPt0IEW4Xlv9r/+Koo2/YAz
 V5linoafNPPDR7HTkXcmQrxl55Tz8y4wW/acxf/AdIUX6sVAU+cvCU/b9qWzq718ZhLK
 RdwMPMvsGmr/qf7JkNN4tZRIR5IejjDQjkI0gTp1gXkRhj7LovZi0nAg51xUyHeIwksq
 2O1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvvG5YX01S9kLokqkfc6iQ9kv7fpBXLAz7P3TLw5X3Hq83WlhDv/XrtCDhIVMqOshLKs6UX02/Zi2gyzx3G08l6bTMJO0=
X-Gm-Message-State: AOJu0YxnfwzRWcjRSdmpdvKqSjtUlM/AehZdS2V+9BGz7h7dZ0tT9Q3W
 JjwqS0r8lRhwWGqT5IYUxXLjdzXZofkOEMW2aV/DxrbFkFniYmqLjeDVN6payJs=
X-Google-Smtp-Source: AGHT+IGUeCwbiAx6qjfHTnUtm8xXH583AcCLVxl3qyPVWWsbDXZhlCtX44C8wnstnbVpR5X7uaz+Jg==
X-Received: by 2002:a05:6a21:788a:b0:1af:59b9:e3ed with SMTP id
 adf61e73a8af0-1b26f0e60eamr419228637.5.1717108315295; 
 Thu, 30 May 2024 15:31:55 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c35a88d096sm214861a12.93.2024.05.30.15.31.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 15:31:54 -0700 (PDT)
Message-ID: <23926d03-b55f-448f-82b1-99e4bc9d76dd@linaro.org>
Date: Thu, 30 May 2024 15:31:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] core/cpu-common: initialise plugin state before
 thread creation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-6-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240530194250.1801701-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

T24gNS8zMC8yNCAxMjo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBPcmlnaW5hbGx5IEkg
dHJpZWQgdG8gbW92ZSB3aGVyZSB2Q1BVIHRocmVhZCBpbml0aWFsaXNhdGlvbiB0byBsYXRl
cg0KPiBpbiByZWFsaXplLiBIb3dldmVyIHB1bGxpbmcgdGhhdCB0aHJlYWQgKHNpYykgZ290
IGduYXJseSByZWFsbHkNCj4gcXVpY2tseS4gSXQgdHVybnMgb3V0IHNvbWUgc3RlcHMgb2Yg
Q1BVIHJlYWxpemF0aW9uIG5lZWQgdmFsdWVzIHRoYXQNCj4gY2FuIG9ubHkgYmUgZGV0ZXJt
aW5lZCBmcm9tIHRoZSBydW5uaW5nIHZDUFUgdGhyZWFkLg0KPiANCj4gSG93ZXZlciBoYXZp
bmcgbW92ZWQgZW5vdWdoIG91dCBvZiB0aGUgdGhyZWFkIGNyZWF0aW9uIHdlIGNhbiBub3cN
Cj4gcXVldWUgd29yayBiZWZvcmUgdGhlIHRocmVhZCBzdGFydHMgKGF0IGxlYXN0IGZvciBU
Q0cgZ3Vlc3RzKSBhbmQNCj4gYXZvaWQgdGhlIHJhY2UgYmV0d2VlbiB2Y3B1X2luaXQgYW5k
IG90aGVyIHZjcHUgc3RhdGVzIGEgcGx1Z2luIG1pZ2h0DQo+IHN1YnNjcmliZSB0by4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgaHcvY29yZS9jcHUtY29tbW9uLmMgfCAyMCArKysrKysrKysrKyst
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L2NvcmUvY3B1LWNvbW1vbi5jIGIvaHcv
Y29yZS9jcHUtY29tbW9uLmMNCj4gaW5kZXggNmNmYzAxNTkzYS4uYmYxYTdiODg5MiAxMDA2
NDQNCj4gLS0tIGEvaHcvY29yZS9jcHUtY29tbW9uLmMNCj4gKysrIGIvaHcvY29yZS9jcHUt
Y29tbW9uLmMNCj4gQEAgLTIyMiwxNCArMjIyLDYgQEAgc3RhdGljIHZvaWQgY3B1X2NvbW1v
bl9yZWFsaXplZm4oRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KPiAgICAgICAg
ICAgY3B1X3Jlc3VtZShjcHUpOw0KPiAgICAgICB9DQo+ICAgDQo+IC0gICAgLyogUGx1Z2lu
IGluaXRpYWxpemF0aW9uIG11c3Qgd2FpdCB1bnRpbCB0aGUgY3B1IHN0YXJ0IGV4ZWN1dGlu
ZyBjb2RlICovDQo+IC0jaWZkZWYgQ09ORklHX1BMVUdJTg0KPiAtICAgIGlmICh0Y2dfZW5h
YmxlZCgpKSB7DQo+IC0gICAgICAgIGNwdS0+cGx1Z2luX3N0YXRlID0gcWVtdV9wbHVnaW5f
Y3JlYXRlX3ZjcHVfc3RhdGUoKTsNCj4gLSAgICAgICAgYXN5bmNfcnVuX29uX2NwdShjcHUs
IHFlbXVfcGx1Z2luX3ZjcHVfaW5pdF9fYXN5bmMsIFJVTl9PTl9DUFVfTlVMTCk7DQo+IC0g
ICAgfQ0KPiAtI2VuZGlmDQo+IC0NCj4gICAgICAgLyogTk9URTogbGF0ZXN0IGdlbmVyaWMg
cG9pbnQgd2hlcmUgdGhlIGNwdSBpcyBmdWxseSByZWFsaXplZCAqLw0KPiAgIH0NCj4gICAN
Cj4gQEAgLTI3Myw2ICsyNjUsMTggQEAgc3RhdGljIHZvaWQgY3B1X2NvbW1vbl9pbml0Zm4o
T2JqZWN0ICpvYmopDQo+ICAgICAgIFFUQUlMUV9JTklUKCZjcHUtPndhdGNocG9pbnRzKTsN
Cj4gICANCj4gICAgICAgY3B1X2V4ZWNfaW5pdGZuKGNwdSk7DQo+ICsNCj4gKyAgICAvKg0K
PiArICAgICAqIFBsdWdpbiBpbml0aWFsaXphdGlvbiBtdXN0IHdhaXQgdW50aWwgdGhlIGNw
dSBzdGFydCBleGVjdXRpbmcNCj4gKyAgICAgKiBjb2RlLCBidXQgd2UgbXVzdCBxdWV1ZSB0
aGlzIHdvcmsgYmVmb3JlIHRoZSB0aHJlYWRzIGFyZQ0KPiArICAgICAqIGNyZWF0ZWQgdG8g
ZW5zdXJlIHdlIGRvbid0IHJhY2UuDQo+ICsgICAgICovDQo+ICsjaWZkZWYgQ09ORklHX1BM
VUdJTg0KPiArICAgIGlmICh0Y2dfZW5hYmxlZCgpKSB7DQo+ICsgICAgICAgIGNwdS0+cGx1
Z2luX3N0YXRlID0gcWVtdV9wbHVnaW5fY3JlYXRlX3ZjcHVfc3RhdGUoKTsNCj4gKyAgICAg
ICAgYXN5bmNfcnVuX29uX2NwdShjcHUsIHFlbXVfcGx1Z2luX3ZjcHVfaW5pdF9fYXN5bmMs
IFJVTl9PTl9DUFVfTlVMTCk7DQo+ICsgICAgfQ0KPiArI2VuZGlmDQo+ICAgfQ0KPiAgIA0K
PiAgIHN0YXRpYyB2b2lkIGNwdV9jb21tb25fZmluYWxpemUoT2JqZWN0ICpvYmopDQoNCkNv
dWxkIHlvdSBjaGVjayBpdCB3b3JrcyBmb3IgYWxsIGNvbWJpbmF0aW9uPw0KLSB1c2VyLW1v
ZGUNCi0gc3lzdGVtLW1vZGUgdGNnDQotIHN5c3RlbS1tb2RlIG10dGNnDQoNCldoZW4gSSB0
cmllZCB0byBtb3ZlIHRoaXMgY29kZSBhcm91bmQsIG9uZSBvZiB0aGVtIGRpZG4ndCB3b3Jr
IGNvcnJlY3RseS4NCg0KRWxzZSwNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

