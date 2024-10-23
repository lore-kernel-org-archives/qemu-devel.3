Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED94D2E01E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3W9b-0003VC-T1; Wed, 23 Oct 2024 03:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3W9Z-0003UC-Fk
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:51:37 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3W9X-0001JN-GL
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:51:37 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20c70abba48so54342005ad.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729669894; x=1730274694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MepkjDJ2ngcxljXy3snTzhEiovBpyY4ILIqybTz6Vcw=;
 b=UDvHNX3PaTMabz26e1IcVtNkYw1T5T09dqSRv8xhlEGRChL5nzWfOPGlRYoXGoCrL9
 fyMILmykP1Ie8MWlwr2SKK7g+vRK39dN3rEh1hSy/GWD/E2Q5UdMDWYmHIGM9kEZiGTs
 uHD3bNcECVcSd9+PJ2OZzXPxh19CIA7SboWSRh7XTXNr/bBO18nG1ekUBX4BmYodY5nx
 6A6ytKpogVERAGq4GhbjZDciGPG5i0SW+kcg6L8SDZhqvauNU38nlxodKu90ebRo3JfB
 23G/9vCfA7rkf0jb6jVVby68bwsr+1ppTvB1K+t4w3KXaRzrMcUYasK6phfc+GutMa8K
 KVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729669894; x=1730274694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MepkjDJ2ngcxljXy3snTzhEiovBpyY4ILIqybTz6Vcw=;
 b=axWMnluyAozwcL21zN72Qat0lhI61YWBsa93cX8d/jaeOjNhz3X4CfyvKJ867jhD0+
 uY5wNK5+moLbswYIG3DTsOTJDHIB1qKZis0OeHrrLl3Dw+wekO1vALWr6tss6GL28JRF
 NWrqc4a08tYjBb159IXJAt9Q9whtBERW+8DniVgzRMGHaLCn7M29stE/wHAhVvfCKmOu
 CaTjUvXGvlbVGtt5I9j10eLDokWN/Zt8umrqzL0C3Sl9BJMkaEK2+1SsbSdGbc4Dx0I1
 HtUmAKF2myMo5PR4bSii7wmDocdySfygSyCACko7+flFbfvZ1ne0yHEzkLo0X2bDP5YT
 XrDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsgapY6mK3YDmFUgxHCzC2xqt9pTcdJ02h17fhAWDjJY5pFfaOIFUiTrQWTKd0oARmrHvUXBsZcOZR@nongnu.org
X-Gm-Message-State: AOJu0Yyn5Yc2epkBCr7aiB1RlwPM7+V3UOU99sslTOvGdywe3/PKVvKB
 Ns6idpoL3WIMYNfk2KhuwHtKmeYINwMtyL45v/x5/jT/5FzWW5WNq9CdB1ggaDs=
X-Google-Smtp-Source: AGHT+IGNBB4bbKqXJ3Wb1+fBO9LhwIz0J+plK6Cd2LbsP0Eo4zu0cRnOrM5NJnHjCVrMqBXhu4NedQ==
X-Received: by 2002:a17:903:22ce:b0:20c:ce9c:bbb0 with SMTP id
 d9443c01a7336-20fa7074a94mr22409375ad.0.1729669893937; 
 Wed, 23 Oct 2024 00:51:33 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef0cc12sm52872905ad.95.2024.10.23.00.51.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 00:51:33 -0700 (PDT)
Message-ID: <fe33c996-3241-4706-9ac1-85f00cb8f388@linaro.org>
Date: Wed, 23 Oct 2024 00:51:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/20] meson: build contrib/plugins with meson
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-19-alex.bennee@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gRnJvbTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiANCj4gVHJpZWQg
dG8gdW5pZnkgdGhpcyBtZXNvbi5idWlsZCB3aXRoIHRlc3RzL3RjZy9wbHVnaW5zL21lc29u
LmJ1aWxkIGJ1dA0KPiB0aGUgcmVzdWx0aW5nIG1vZHVsZXMgYXJlIG5vdCBvdXRwdXQgaW4g
dGhlIHJpZ2h0IGRpcmVjdG9yeS4NCj4gDQo+IE9yaWdpbmFsbHkgcHJvcG9zZWQgYnkgQW50
b24gS29jaGtvdiwgdGhhbmsgeW91IQ0KPiANCj4gU29sdmVzOiBodHRwczovL2dpdGxhYi5j
b20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMTcxMA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+IE1lc3Nh
Z2UtSWQ6IDwyMDI0MDkyNTIwNDg0NS4zOTA2ODktMi1waWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgbWVzb24uYnVpbGQgICAgICAgICAgICAgICAgIHwgIDQg
KysrKw0KPiAgIGNvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZCB8IDIzICsrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+
ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQNCj4gaW5kZXggYmRk
NjdhMmQ2ZC4uM2VhMDNjNDUxYiAxMDA2NDQNCj4gLS0tIGEvbWVzb24uYnVpbGQNCj4gKysr
IGIvbWVzb24uYnVpbGQNCj4gQEAgLTM2NzgsNiArMzY3OCwxMCBAQCBzdWJkaXIoJ2FjY2Vs
JykNCj4gICBzdWJkaXIoJ3BsdWdpbnMnKQ0KPiAgIHN1YmRpcignZWJwZicpDQo+ICAgDQo+
ICtpZiAnQ09ORklHX1RDRycgaW4gY29uZmlnX2FsbF9hY2NlbA0KPiArICBzdWJkaXIoJ2Nv
bnRyaWIvcGx1Z2lucycpDQo+ICtlbmRpZg0KPiArDQo+ICAgY29tbW9uX3VzZXJfaW5jID0g
W10NCj4gICANCj4gICBzdWJkaXIoJ2NvbW1vbi11c2VyJykNCj4gZGlmZiAtLWdpdCBhL2Nv
bnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZCBiL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWls
ZA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi5hMGUwMjZk
MjVlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvY29udHJpYi9wbHVnaW5zL21lc29uLmJ1
aWxkDQo+IEBAIC0wLDAgKzEsMjMgQEANCj4gK3QgPSBbXQ0KPiAraWYgZ2V0X29wdGlvbign
cGx1Z2lucycpDQo+ICsgIGZvcmVhY2ggaSA6IFsnY2FjaGUnLCAnZHJjb3YnLCAnZXhlY2xv
ZycsICdob3RibG9ja3MnLCAnaG90cGFnZXMnLCAnaG93dmVjJywNCj4gKyAgICAgICAgICAg
ICAgICdod3Byb2ZpbGUnLCAnaXBzJywgJ2xvY2tzdGVwJywgJ3N0b3B0cmlnZ2VyJ10NCg0K
bG9ja3N0ZXAgZG9lcyBub3QgYnVpbGQgdW5kZXIgV2luZG93cyAoaXQgdXNlcyBzb2NrZXRz
KSwgc28gaXQgc2hvdWxkIGJlIA0KY29uZGl0aW9ubmFsbHkgbm90IGJ1aWx0IG9uIHRoaXMg
cGxhdGZvcm0uDQpAQWxleCwgaWYgeW91IGZlZWwgbGlrZSBtb2RpZnlpbmcgdGhpcywgeW91
IGNhbi4gSWYgbm90LCB5b3UgY2FuIGRyb3AgDQp0aGUgbWVzb24gYnVpbGQgcGF0Y2hlcyBm
cm9tIHRoaXMgc2VyaWVzIHRvIG5vdCBibG9jayBpdC4NCg0KPiArICAgIGlmIGhvc3Rfb3Mg
PT0gJ3dpbmRvd3MnDQo+ICsgICAgICB0ICs9IHNoYXJlZF9tb2R1bGUoaSwgZmlsZXMoaSAr
ICcuYycpICsgJ3dpbjMyX2xpbmtlci5jJywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
IGluY2x1ZGVfZGlyZWN0b3JpZXM6ICcuLi8uLi9pbmNsdWRlL3FlbXUnLA0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgbGlua19kZXBlbmRzOiBbd2luMzJfcWVtdV9wbHVnaW5fYXBp
X2xpYl0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICBsaW5rX2FyZ3M6IFsnLUxwbHVn
aW5zJywgJy1scWVtdV9wbHVnaW5fYXBpJ10sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICBkZXBlbmRlbmNpZXM6IGdsaWIpDQo+ICsNCj4gKyAgICBlbHNlDQo+ICsgICAgICB0ICs9
IHNoYXJlZF9tb2R1bGUoaSwgZmlsZXMoaSArICcuYycpLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgaW5jbHVkZV9kaXJlY3RvcmllczogJy4uLy4uL2luY2x1ZGUvcWVtdScsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IGdsaWIpDQo+ICsgICAg
ZW5kaWYNCj4gKyAgZW5kZm9yZWFjaA0KPiArZW5kaWYNCj4gK2lmIHQubGVuZ3RoKCkgPiAw
DQo+ICsgIGFsaWFzX3RhcmdldCgnY29udHJpYi1wbHVnaW5zJywgdCkNCj4gK2Vsc2UNCj4g
KyAgcnVuX3RhcmdldCgnY29udHJpYi1wbHVnaW5zJywgY29tbWFuZDogZmluZF9wcm9ncmFt
KCd0cnVlJykpDQo+ICtlbmRpZg0K

