Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6EEC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 22:42:37 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFcDR-0004uw-Ac; Fri, 07 Jun 2024 12:13:21 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFcDQ-0004uo-1W
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:13:20 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFcDO-0003Ve-9l
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 12:13:19 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c1ab9e17f6so2067281a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717776796; x=1718381596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+gG5L2LatsOvR+zbcsN7Vfd4DiDO8PJuhwwN1mATZJI=;
 b=vVxwt+cPSpvqllwGORRYEuJqxiHJENOtoWBdEjWezyQpCLbas+Hc7hzmzSNxWXcFPD
 /NM7G/1rTESB73uE/QFQhl3ISIFwkZJHYzystYCoSe9YM48eM6rNQbdpnfPDkC7X6hHG
 AUOthlMD+7uBle/rLz+9S9HQsUMefSg5zCezYDlmpUZk8kI0U/o1TOWxcxT6Oz8nDavs
 p+k2qz9NbZsfKRIpYO2wRekU+3h3qrCuairAEx4onZVFwUL7grL0eANNLLRijgT1SYrp
 RnDE90V7Tjyqm1BMN5sa7TMV1p3+SuAY915cqZZrBMcv+CDHO6K0LIJAlz1nkJifO6LU
 8AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717776796; x=1718381596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+gG5L2LatsOvR+zbcsN7Vfd4DiDO8PJuhwwN1mATZJI=;
 b=kLBYLsTXtB5h/Z1x7ObaDJ53aRh+Rp6X2ve/YNz/RdTCq70ozNkDziqBgW3go2vJAb
 PP0A+zQhR/CkLI13XgdT2hfaqtA1NcJG/MBSvRlf5tRtZTeGULC50t03d+HPv+XUplpZ
 3eJ+fk5F65vvq3hoIZtpeLOabK03D8tEnp0ZSAmPfpVFJLahxNYrFT57nfsiC2/v/eX9
 +55mS6zbRLHIZcROin4QjaA/7GLEFkxyWXkt5LOjp1LxaG4PMJYD+JbggxCMtitzV2Uu
 ek5Hq6H+5DNoM5hbAmdIPkPQmTzGdk0TJw3W/yQgKHE2hdHzi6lVzq0UEATmLR9makB0
 XaIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcIaa/UeGAQBi7BKSWQZGca0kTUfdr/7O3jj/DMitlB+/DIfjQCAUF2WzMuf8u7m2JDAVKmrLOKU4pwJhnGNDG1aZjaxk=
X-Gm-Message-State: AOJu0YyMXTXKj/3+hOHJqHDyITuu4h1ZLyyVarOfbEWY+mQO1ghrvp1y
 ygn2+F72OsZHsFZz7mmC5EAf1cMsMsOVFRZzCzwskdwkiz43whBDAI0M4Ix5sAg=
X-Google-Smtp-Source: AGHT+IHZX5XIH7emQ0K9EJDfhsBpeCUb1uq9e9WNQXI0Vh9DDRNBGbyqy2zR01WsraDGs05xKq/PRQ==
X-Received: by 2002:a17:90b:4b46:b0:2c2:d136:b0fb with SMTP id
 98e67ed59e1d1-2c2d136b355mr1135500a91.34.1717776796282; 
 Fri, 07 Jun 2024 09:13:16 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2806398easm5686120a91.10.2024.06.07.09.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 09:13:15 -0700 (PDT)
Message-ID: <5f3d272c-d6b9-4a7a-8230-fda4eb5be7e2@linaro.org>
Date: Fri, 7 Jun 2024 09:13:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] plugins: Free CPUPluginState before destroying vCPU
 state
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240606124010.2460-1-philmd@linaro.org>
 <20240606124010.2460-3-philmd@linaro.org>
 <26cb32be-d5a6-48b9-98c9-ca94ac6ceafd@linaro.org>
 <cc029923-bd07-4b48-ad8a-b68501a0e54d@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cc029923-bd07-4b48-ad8a-b68501a0e54d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

T24gNi82LzI0IDIxOjUzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ni82LzI0IDIzOjE0LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNi82LzI0IDA1
OjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBjcHU6OnBsdWdpbl9z
dGF0ZSBpcyBhbGxvY2F0ZWQgaW4gY3B1X2NvbW1vbl9pbml0Zm4oKSB3aGVuDQo+Pj4gdGhl
IHZDUFUgc3RhdGUgaXMgY3JlYXRlZC4gUmVsZWFzZSBpdCBpbiBjcHVfY29tbW9uX2ZpbmFs
aXplKCkNCj4+PiB3aGVuIHdlIGFyZSBkb25lLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
UGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0K
Pj4+ICDCoCBpbmNsdWRlL3FlbXUvcGx1Z2luLmggfCAzICsrKw0KPj4+ICDCoCBody9jb3Jl
L2NwdS1jb21tb24uY8KgIHwgNSArKysrKw0KPj4+ICDCoCAyIGZpbGVzIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS9wbHVn
aW4uaCBiL2luY2x1ZGUvcWVtdS9wbHVnaW4uaA0KPj4+IGluZGV4IGJjNWFlZjk3OWUuLmFm
NWY5ZGI0NjkgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4g
KysrIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4gQEAgLTE0OSw2ICsxNDksOSBAQCBz
dHJ1Y3QgQ1BVUGx1Z2luU3RhdGUgew0KPj4+ICDCoCAvKioNCj4+PiAgwqDCoCAqIHFlbXVf
cGx1Z2luX2NyZWF0ZV92Y3B1X3N0YXRlOiBhbGxvY2F0ZSBwbHVnaW4gc3RhdGUNCj4+PiAr
ICoNCj4+PiArICogVGhlIHJldHVybmVkIGRhdGEgbXVzdCBiZSByZWxlYXNlZCB3aXRoIGdf
ZnJlZSgpDQo+Pj4gKyAqIHdoZW4gbm8gbG9uZ2VyIHJlcXVpcmVkLg0KPj4+ICDCoMKgICov
DQo+Pj4gIMKgIENQVVBsdWdpblN0YXRlICpxZW11X3BsdWdpbl9jcmVhdGVfdmNwdV9zdGF0
ZSh2b2lkKTsNCj4+PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9jcHUtY29tbW9uLmMgYi9ody9j
b3JlL2NwdS1jb21tb24uYw0KPj4+IGluZGV4IGJmMWE3Yjg4OTIuLmNkMTU0MDI1NTIgMTAw
NjQ0DQo+Pj4gLS0tIGEvaHcvY29yZS9jcHUtY29tbW9uLmMNCj4+PiArKysgYi9ody9jb3Jl
L2NwdS1jb21tb24uYw0KPj4+IEBAIC0yODMsNiArMjgzLDExIEBAIHN0YXRpYyB2b2lkIGNw
dV9jb21tb25fZmluYWxpemUoT2JqZWN0ICpvYmopDQo+Pj4gIMKgIHsNCj4+PiAgwqDCoMKg
wqDCoCBDUFVTdGF0ZSAqY3B1ID0gQ1BVKG9iaik7DQo+Pj4gKyNpZmRlZiBDT05GSUdfUExV
R0lODQo+Pj4gK8KgwqDCoCBpZiAodGNnX2VuYWJsZWQoKSkgew0KPj4+ICvCoMKgwqDCoMKg
wqDCoCBnX2ZyZWUoY3B1LT5wbHVnaW5fc3RhdGUpOw0KPj4+ICvCoMKgwqAgfQ0KPj4+ICsj
ZW5kaWYNCj4+PiAgwqDCoMKgwqDCoCBnX2FycmF5X2ZyZWUoY3B1LT5nZGJfcmVncywgVFJV
RSk7DQo+Pj4gIMKgwqDCoMKgwqAgcWVtdV9sb2NrY250X2Rlc3Ryb3koJmNwdS0+aW5faW9j
dGxfbG9jayk7DQo+Pj4gIMKgwqDCoMKgwqAgcWVtdV9tdXRleF9kZXN0cm95KCZjcHUtPndv
cmtfbXV0ZXgpOw0KPj4NCj4+IFRvIGVuc3VyZSBJIGdldCBpdCByaWdodCwgb3JkZXIgb2Yg
Y3B1IGluaXQvZGVpbml0IGlzOg0KPj4gLSBpbml0DQo+PiAtIHJlYWxpemUNCj4+IC0gdW5y
ZWFsaXplDQo+PiAtIGZpbmFsaXplDQo+PiBJcyB0aGF0IGNvcnJlY3Q/DQo+IA0KPiBZZXMs
IHRoaXMgaXMgdmFsaWQgZm9yIGFsbCBRRGV2IChDUFUgaXMgYmFzZWQgb24gaXQpLg0KPiAN
Cj4gKyBpbml0OiBhbGxvY2F0ZSBzdGF0ZSwgZXhwb3NlIGNvbmZpZ3VyYWJsZSBwcm9wZXJ0
aWVzDQo+IC4gdXNlciBjb25maWd1cmUgcHJvcGVydGllcw0KPiArIHJlYWxpemU6IGNvbnN1
bWUgcHJvcGVydGllcyB0byB0dW5lIHRoZSBvYmplY3QNCj4gKyByZXNldDogc2V0IGRlZmF1
bHQgdmFsdWVzDQo+IC4gb2JqZWN0IGlzIHVzZWQNCj4gKyB1bnJlYWxpemU6IHVuZG8gc3R1
ZmYgZnJvbSByZWFsaXplIGJlY2F1c2UgdGhlIG9iamVjdA0KPiAgICAgbWlnaHQgYmUgcmVh
bGl6ZWQgYWdhaW4gKHVucGx1ZyAtIHBsdWcpDQo+ICsgZmluYWxpemU6IHJlbGVhc2UgcmVz
b3VyY2VzDQo+IA0KPiBTZWUNCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZl
bC8yMDI0MDIwOTEyMzIyNi4zMjU3Ni0xLXBoaWxtZEBsaW5hcm8ub3JnLw0KPiANCj4+IFJl
dmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQo+IA0KPiBUaGFua3MhDQoNClRoYW5rcywgaXQgZGVmaW5pdGVseSBoYXZlIGl0cyBw
bGFjZSBpbiB0aGUgb2ZmaWNpYWwgZG9jdW1lbnRhdGlvbiwgaWYgDQp5b3UgZmVlbCBsaWtl
IGFkZGluZyBpdC4NCg==

