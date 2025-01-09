Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E742E7719D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 22:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tW0ja-00033h-R4; Thu, 09 Jan 2025 17:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW0jQ-000336-A2
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:10:24 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tW0jO-00026i-3A
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 17:10:24 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2164b662090so21984515ad.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 14:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736460620; x=1737065420; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x0x1hNjK83S+IF8rwfc/j1FErOyJUdImRq15txlrzcA=;
 b=ATaImqksfKaoKHdST+n/5pTYaDtGBfUmDepgDXMfq4b23V9oZkNTjBoo+tYws+SWZZ
 kUaUgV6goGntgD35VYGEfyixSBkIbqPdPuZruQUtopAVKVYkwuWcQxa0WZDCp3ek5Dor
 nBAlDblnACM/sPNxZwgbsG1fq9nguZaDsTMCCy7/M9KvrASdMJZMjdWvXDoYiIQGPRLl
 qUHdvRanepHAjVKJKZZk8UcbSIaxPRcN4UPp7Ok73M4YIrJlsY3g+iTjlBpeUhj/+LyK
 Qjzh9StYWcl4+pppqWLxvglvh6dUD0L0QqDoXqmIcA73x53MBguxV7hQRfNvNhrcdndX
 rksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736460620; x=1737065420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x0x1hNjK83S+IF8rwfc/j1FErOyJUdImRq15txlrzcA=;
 b=tRqeW+njfBcJdBOddD3+U2yYTNlgdwPmsMYcDgIynGzdYsFnM+sI7IssfSGhyV2h9f
 LX9EeDOVrda5suNIOKkXUXTVg7PaI5ISYW9ANnbn+ihSu53igCEhpMK5PSVhAY7V6dFu
 H/z+oSCHHqv6effQsFPakUeVmP3O5MqaSOuiCLseW9KaJj3UlUqiz8g1pqkFRBxhY+IS
 7Vq1o7JXQLD5VSx4YTEhI7ZJzbO8AgMQbR1mgO/5Suz2WxZsfJ9KwdZyPLHOqWcdY/Hi
 O8ynuLLv0uA3yQsEr6yT0Qf0/NzZpUkTbkUsqeCCbEm8qzmOCCQYdlhNTsQ4rFVJyuko
 n1rw==
X-Gm-Message-State: AOJu0YxoF5k/kkMpBtLtZZDRD5RKFce5zusOd6JPG47fqlei4B3qG1Ga
 TMMfpHLXIyE4vUze0HpA4y2sODvRBF3FghM5gns3RDy8lrRTvaVT8ohvbMte694=
X-Gm-Gg: ASbGncsD/6vPBdQGRfJsnpwFyhaF/OyP0wwRgL3JLDTrJo2sYJdCsWGyJ9XMIHoZfxF
 icSVvXqKAmqrohHyTOmklrRa2jlAOZyvWuUWKeSMJvMNogWTwuybcw6wnaHJRvhdQRWqCiPg3Qn
 z5U/0dpFn2s5MsEXQnhAvfVi0gmkPj2A4UJWgPE8FzAcwwbM53irExocv5SVByrW+7TViKxcP7x
 yTOYsw6LXSq/AbbUgHWn6tS8Dk2CuCgMcZ1pn3RoyCNf3FU/WSLK1oMQYuianTYdNBt+A==
X-Google-Smtp-Source: AGHT+IEPVZ1m4kL74KUBrEUQObY1I8PKliVhfd60jzJe8vJZvlX11fxNpaegPz+oriFuYfA3bMNfxw==
X-Received: by 2002:a05:6a20:438d:b0:1e5:ddac:1ed7 with SMTP id
 adf61e73a8af0-1e88cfa6a2cmr12615282637.12.1736460620211; 
 Thu, 09 Jan 2025 14:10:20 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31de806694sm1768182a12.69.2025.01.09.14.10.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 14:10:19 -0800 (PST)
Message-ID: <ab5b964b-2a51-49b9-8fdb-a7abea973c5d@linaro.org>
Date: Thu, 9 Jan 2025 14:10:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <87frls6q2m.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87frls6q2m.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

T24gMS85LzI1IDA2OjA0LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IEp1bGlhbiBHYW56IDxu
ZWl0aGVyQG51dC5lbWFpbD4gd3JpdGVzOg0KPiANCj4+IFdlIHJlY2VudGx5IGludHJvZHVj
ZWQgbmV3IHBsdWdpbiBBUEkgZm9yIHJlZ2lzdHJhdGlvbiBvZiBkaXNjb250aW51aXR5DQo+
PiByZWxhdGVkIGNhbGxiYWNrcy4gVGhpcyBjaGFuZ2UgaW50cm9kdWNlcyBhIG1pbmltYWwg
cGx1Z2luIHNob3djYXNpbmcNCj4+IHRoZSBuZXcgQVBJLiBJdCBzaW1wbHkgY291bnRzIHRo
ZSBvY2N1cmFuY2VzIG9mIGludGVycnVwdHMsIGV4Y2VwdGlvbnMNCj4+IGFuZCBob3N0IGNh
bGxzIHBlciBDUFUgYW5kIHJlcG9ydHMgdGhlIGNvdW50cyB3aGVuIGV4aXR0aW5nLg0KPj4g
LS0tDQo+PiAgIGNvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZCB8ICAzICstDQo+PiAgIGNv
bnRyaWIvcGx1Z2lucy90cmFwcy5jICAgICB8IDk2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBjb250cmliL3BsdWdp
bnMvdHJhcHMuYw0KPj4NCj4+IGRpZmYgLS1naXQgYS9jb250cmliL3BsdWdpbnMvbWVzb24u
YnVpbGQgYi9jb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQNCj4+IGluZGV4IDYzYTMyYzJi
NGYuLjlhMzAxNWUxYzEgMTAwNjQ0DQo+PiAtLS0gYS9jb250cmliL3BsdWdpbnMvbWVzb24u
YnVpbGQNCj4+ICsrKyBiL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KPj4gQEAgLTEs
NSArMSw2IEBADQo+PiAgIGNvbnRyaWJfcGx1Z2lucyA9IFsnYmJ2JywgJ2NhY2hlJywgJ2Nm
bG93JywgJ2RyY292JywgJ2V4ZWNsb2cnLCAnaG90YmxvY2tzJywNCj4+IC0gICAgICAgICAg
ICAgICAgICAgJ2hvdHBhZ2VzJywgJ2hvd3ZlYycsICdod3Byb2ZpbGUnLCAnaXBzJywgJ3N0
b3B0cmlnZ2VyJ10NCj4+ICsgICAgICAgICAgICAgICAgICAgJ2hvdHBhZ2VzJywgJ2hvd3Zl
YycsICdod3Byb2ZpbGUnLCAnaXBzJywgJ3N0b3B0cmlnZ2VyJywNCj4+ICsgICAgICAgICAg
ICAgICAgICAgJ3RyYXBzJ10NCj4gDQo+IEkgd29uZGVyIGlmIHRoaXMgaXMgYmV0dGVyIGlu
IHRlc3RzL3RjZy9wbHVnaW5zPyBXZSBuZWVkIHRvIGRvIHNvbWV0aGluZw0KPiB0byBlbnN1
cmUgaXQgZ2V0cyBjb3ZlcmVkIGJ5IENJIGFsdGhvdWdoIHdlIG1pZ2h0IHdhbnQgdG8gYmUg
c21hcnRlcg0KPiBhYm91dCBydW5uaW5nIGl0IHRvZ2V0aGVyIHdpdGggYSB0ZXN0IGJpbmFy
eSB0aGF0IHdpbGwgYWN0dWFsbHkgcGljayB1cA0KPiBzb21ldGhpbmcuDQo+IA0KPj4gICBp
ZiBob3N0X29zICE9ICd3aW5kb3dzJw0KPj4gICAgICMgbG9ja3N0ZXAgdXNlcyBzb2NrZXQu
aA0KPj4gICAgIGNvbnRyaWJfcGx1Z2lucyArPSAnbG9ja3N0ZXAnDQo+IDxzbmlwPg0KPj4g
K1FFTVVfUExVR0lOX0VYUE9SVA0KPj4gK2ludCBxZW11X3BsdWdpbl9pbnN0YWxsKHFlbXVf
cGx1Z2luX2lkX3QgaWQsIGNvbnN0IHFlbXVfaW5mb190ICppbmZvLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgIGludCBhcmdjLCBjaGFyICoqYXJndikNCj4+ICt7DQo+PiArICAg
IGlmICghaW5mby0+c3lzdGVtX2VtdWxhdGlvbikgew0KPj4gKyAgICAgICAgZnB1dHMoInRy
YXAgcGx1Z2luIGNhbiBvbmx5IGJlIHVzZWQgaW4gc3lzdGVtIGVtdWxhdGlvbiBtb2RlLlxu
IiwNCj4+ICsgICAgICAgICAgICAgIHN0ZGVycik7DQo+PiArICAgICAgICByZXR1cm4gLTE7
DQo+PiArICAgIH0NCj4+ICsNCj4+ICsgICAgbWF4X3ZjcHVzID0gaW5mby0+c3lzdGVtLm1h
eF92Y3B1czsNCj4+ICsgICAgdHJhcHMgPSBxZW11X3BsdWdpbl9zY29yZWJvYXJkX25ldyhz
aXplb2YoVHJhcENvdW50ZXJzKSk7DQo+PiArICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3Zj
cHVfaW5pdF9jYihpZCwgdmNwdV9pbml0KTsNCj4+ICsgICAgcWVtdV9wbHVnaW5fdmNwdV9m
b3JfZWFjaChpZCwgdmNwdV9pbml0KTsNCj4gDQo+IEhtbSBhdCBmaXJzdCBnbGFuY2VzIHRo
aXMgc2VlbXMgcmVkdW5kYW50IC0gaG93ZXZlciBJIGd1ZXNzIHRoaXMgaXMNCj4gY292ZXJp
bmcgdGhlIHVzZSBjYXNlIHlvdSBsb2FkIHRoZSBwbHVnaW4gYWZ0ZXIgdGhlIHN5c3RlbSBp
cyB1cCBhbmQNCj4gcnVubmluZy4NCj4gDQo+IEkgd29uZGVyIGlmIHlvdSBoYXZlIHVuZWFy
dGhlZCBhIGZvb3QtZ3VuIGluIHRoZSBBUEkgdGhhdCBpcyBlYXN5IHRvDQo+IGZhbGwgaW50
bz8gTWF5YmUgd2Ugc2hvdWxkIGV4cGFuZCBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X2lu
aXRfY2IgdG8NCj4gY2FsbCB0aGUgY2FsbCBiYWNrIGltbWVkaWF0ZWx5IGZvciBleGlzdGlu
ZyB2Y3B1cz8NCj4gDQoNCkknbSBub3Qgc3VyZSB0byBzZWUgaG93IHdlIGNhbiBsb2FkIGEg
cGx1Z2luIGFmdGVyIHRoZSBjcHVzIGhhdmUgYmVlbiANCmluaXRpYWxpemVkPw0KSW4gY2Fz
ZSBzb21lb25lIHdhbnRzIHRvIGR5bmFtaWNhbGx5IGNyZWF0ZSBhIG5ldyB2Y3B1X2luaXQg
Y2FsbGJhY2sgDQooYWZ0ZXIgc29tZSBldmVudCBvciB0cmFuc2xhdGlvbiBmb3IgaW5zdGFu
Y2UpLCBpdCBzaG91bGQgYmUgdGhlIA0KcmVzcG9uc2liaWxpdHkgb2YgcGx1Z2luIHRvIGNh
bGwgaXQgZm9yIGV4aXN0aW5nIHZjcHVzLg0KDQpxZW11X3BsdWdpbl92Y3B1X2Zvcl9lYWNo
IGlzIHN0aWxsIHVzZWZ1bCBpbiBjYXNlIHlvdSB3YW50IHRvIG9ubHkgDQppdGVyYXRlIGN1
cnJlbnRseSBhY3RpdmUgY3B1cyAoYW5kIG5vdCB0aGUgb25lIHdobyBleGl0ZWQgYWxyZWFk
eSBpbiANCnVzZXIgbW9kZSkuDQoNCj4+ICsNCj4+ICsgICAgcWVtdV9wbHVnaW5fcmVnaXN0
ZXJfdmNwdV9kaXNjb25fY2IoaWQsIFFFTVVfUExVR0lOX0RJU0NPTl9UUkFQUywNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmNwdV9kaXNjb24pOw0K
Pj4gKw0KPj4gKyAgICBxZW11X3BsdWdpbl9yZWdpc3Rlcl9hdGV4aXRfY2IoaWQsIHBsdWdp
bl9leGl0LCBOVUxMKTsNCj4+ICsNCj4+ICsgICAgcmV0dXJuIDA7DQo+PiArfQ0KPiANCg0K


