Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E52C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:05:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4bz-0004Qr-L2; Tue, 12 Mar 2024 12:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rk4bw-0004QZ-0p
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:04:16 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rk4bs-0005ym-BD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:04:15 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-5135e8262e4so6125117e87.0
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 09:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710259450; x=1710864250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+b6cAAolU/i926Twe32MQlIKJEcMyLRnNmmtBfTuUOU=;
 b=cRUXNUKOUkdXWUM69DFlcwkhEM+yD0SKVzWq0Nn1SOYTJJvnbJ0IVQi2CDUW0Uvb3e
 IxuN/mSibyLMTuA4OK6o4r0nPdmklcvK7u3/uyIcDP3E1YKg94lstqg/FRKyQY7FPslZ
 BCMHcRpa+Hr3c3IizxGQ2tCcIWj2p+kBDXyzAnWSjqcjtysh2QHZB7Wc5JNU9wB6p+PD
 U30fxybDSiQtExDXvI4MNWf8EO/xA0bR1ZJRk1hsY9lWql1pnjnfk0f7UX8mPgZiNM86
 WBGGTVi7W5llw1zKy0CwA9EqOSCV5yQ/iZR9+2lPcdn7JPy4gMK5jw8DWx1eBYPbvigx
 kJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710259450; x=1710864250;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+b6cAAolU/i926Twe32MQlIKJEcMyLRnNmmtBfTuUOU=;
 b=D07nQjzJpFtEqHdw4NvUB2oBTsLS/24H7K0vI8OHeRqh9zm29MnbWlWyvRMvk1Otag
 dOCVRTNU8MlYxK/ELp0j9BlPrgzUTpZ4MzGLVVwRreg5wGx7KMmTZcy/iSoLyf+eAASL
 mQ3kk2/3+NSxOIX8qL5PsMY07LI4t2fN8KhIRwQGBqbCGyEpxIvNDbQfFbv2Umv7PEEA
 ytN9L+UtsfZkBsGPoW3ivCW53oRGgmnT6V2yp14aG+9NZM9E96gwiSwud0DdTS5Gafkt
 YZRCiMDrUPtFyX6I5rIkdOvRKLgPWZ6CnEby/in/8r1xNuNiecaWTa8KXtuhR4MNDk5b
 loLA==
X-Gm-Message-State: AOJu0YzpPTWySFJ0D4EJ1k7kw3NiZH7xOSs0Tl4ytBg67AU1YPENWWZM
 3w+qZlkBcETwT/4vLcssa7DgBC8lSNryv2imQwr5zwjvVholEiA+2DUaOc4Hvfk=
X-Google-Smtp-Source: AGHT+IEMI9qBNREEMndpGeeWR8fqTLf3uYcTmEZTUHjxVxAx0bK6GOT31uB3p+6TmJgHHuS41tJ+eA==
X-Received: by 2002:a05:6512:10d4:b0:513:a8d4:1548 with SMTP id
 k20-20020a05651210d400b00513a8d41548mr5944150lfg.39.1710259449528; 
 Tue, 12 Mar 2024 09:04:09 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 fb7-20020a05600c520700b0041328d0440csm8148628wmb.31.2024.03.12.09.04.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 09:04:09 -0700 (PDT)
Message-ID: <426db335-cf37-48ba-aad4-aa0c9aa73bf0@linaro.org>
Date: Tue, 12 Mar 2024 20:04:04 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: conditional callbacks
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240229055359.972151-1-pierrick.bouvier@linaro.org>
 <20240229055359.972151-5-pierrick.bouvier@linaro.org>
 <87bk7lqdw0.fsf@draig.linaro.org>
 <eb665792-5250-40f6-8bb5-9ca5b2d8c6f8@linaro.org>
 <87edcfo5j1.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87edcfo5j1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x133.google.com
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

T24gMy8xMi8yNCAxOTowNCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAz
LzExLzI0IDE0OjA4LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gRXh0
ZW5kIHBsdWdpbnMgQVBJIHRvIHN1cHBvcnQgY2FsbGJhY2sgY2FsbGVkIHdpdGggYSBnaXZl
biBjcml0ZXJpYQ0KPj4+PiAoZXZhbHVhdGVkIGlubGluZSkuDQo+Pj4+DQo+Pj4+IEFkZGVk
IGZ1bmN0aW9uczoNCj4+Pj4gLSBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNf
Y29uZF9jYg0KPj4+PiAtIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW5zbl9leGVjX2Nv
bmRfY2INCj4+Pj4NCj4+Pj4gVGhleSBleHBlY3QgYXMgcGFyYW1ldGVyIGEgY29uZGl0aW9u
LCBhIHFlbXVfcGx1Z2luX3U2NF90IChvcDEpIGFuZCBhbg0KPj4+PiBpbW1lZGlhdGUgKG9w
MikuIENhbGxiYWNrIGlzIGNhbGxlZCBpZiBvcDEgfGNvbmR8IG9wMiBpcyB0cnVlLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+DQo+Pj4+IC0tLQ0KPj4+PiAgICBpbmNsdWRlL3FlbXUvcGx1Z2lu
LmggICAgICAgIHwgICA3ICsrDQo+Pj4+ICAgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5o
ICAgfCAgNzYgKysrKysrKysrKysrKysrDQo+Pj4+ICAgIHBsdWdpbnMvcGx1Z2luLmggICAg
ICAgICAgICAgfCAgIDggKysNCj4+Pj4gICAgYWNjZWwvdGNnL3BsdWdpbi1nZW4uYyAgICAg
ICB8IDE3NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgICBw
bHVnaW5zL2FwaS5jICAgICAgICAgICAgICAgIHwgIDUxICsrKysrKysrKysNCj4+Pj4gICAg
cGx1Z2lucy9jb3JlLmMgICAgICAgICAgICAgICB8ICAxOSArKysrDQo+Pj4+ICAgIHBsdWdp
bnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMgfCAgIDIgKw0KPj4+PiAgICA3IGZpbGVzIGNoYW5n
ZWQsIDMzNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9xZW11L3BsdWdpbi5oIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5o
DQo+Pj4+IGluZGV4IGQ5MmQ2NDc0NGU2Li4wNTYxMDJiMjM2MSAxMDA2NDQNCj4+Pj4gLS0t
IGEvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4+ICsrKyBiL2luY2x1ZGUvcWVtdS9wbHVn
aW4uaA0KPj4+PiBAQCAtNzQsNiArNzQsOCBAQCBlbnVtIHBsdWdpbl9keW5fY2JfdHlwZSB7
DQo+Pj4+ICAgIGVudW0gcGx1Z2luX2R5bl9jYl9zdWJ0eXBlIHsNCj4+Pj4gICAgICAgIFBM
VUdJTl9DQl9SRUdVTEFSLA0KPj4+PiAgICAgICAgUExVR0lOX0NCX1JFR1VMQVJfUiwNCj4+
Pj4gKyAgICBQTFVHSU5fQ0JfQ09ORCwNCj4+Pj4gKyAgICBQTFVHSU5fQ0JfQ09ORF9SLA0K
Pj4+PiAgICAgICAgUExVR0lOX0NCX0lOTElORV9BRERfVTY0LA0KPj4+PiAgICAgICAgUExV
R0lOX0NCX0lOTElORV9TVE9SRV9VNjQsDQo+Pj4+ICAgICAgICBQTFVHSU5fTl9DQl9TVUJU
WVBFUywNCj4+Pj4gQEAgLTk3LDYgKzk5LDExIEBAIHN0cnVjdCBxZW11X3BsdWdpbl9keW5f
Y2Igew0KPj4+PiAgICAgICAgICAgICAgICBlbnVtIHFlbXVfcGx1Z2luX29wIG9wOw0KPj4+
PiAgICAgICAgICAgICAgICB1aW50NjRfdCBpbW07DQo+Pj4+ICAgICAgICAgICAgfSBpbmxp
bmVfaW5zbjsNCj4+Pj4gKyAgICAgICAgc3RydWN0IHsNCj4+Pj4gKyAgICAgICAgICAgIHFl
bXVfcGx1Z2luX3U2NCBlbnRyeTsNCj4+Pj4gKyAgICAgICAgICAgIGVudW0gcWVtdV9wbHVn
aW5fY29uZCBjb25kOw0KPj4+PiArICAgICAgICAgICAgdWludDY0X3QgaW1tOw0KPj4+PiAr
ICAgICAgICB9IGNvbmRfY2I7DQo+Pj4+ICAgICAgICB9Ow0KPj4+PiAgICB9Ow0KPj4+PiAg
ICBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L3FlbXUtcGx1Z2luLmgNCj4+Pj4gYi9pbmNs
dWRlL3FlbXUvcWVtdS1wbHVnaW4uaA0KPj4+PiBpbmRleCBjNWNhYzg5N2EwYi4uMzM3ZGUy
NWVjZTcgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oDQo+
Pj4+ICsrKyBiL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oDQo+Pj4+IEBAIC0yNjIsNiAr
MjYyLDI5IEBAIGVudW0gcWVtdV9wbHVnaW5fbWVtX3J3IHsNCj4+Pj4gICAgICAgIFFFTVVf
UExVR0lOX01FTV9SVywNCj4+Pj4gICAgfTsNCj4+Pj4gICAgKy8qKg0KPj4+PiArICogZW51
bSBxZW11X3BsdWdpbl9jb25kIC0gY29uZGl0aW9uIHRvIGVuYWJsZSBjYWxsYmFjaw0KPj4+
PiArICoNCj4+Pj4gKyAqIEBRRU1VX1BMVUdJTl9DT05EX05FVkVSOiBmYWxzZQ0KPj4+PiAr
ICogQFFFTVVfUExVR0lOX0NPTkRfQUxXQVlTOiB0cnVlDQo+Pj4+ICsgKiBAUUVNVV9QTFVH
SU5fQ09ORF9FUTogaXMgZXF1YWw/DQo+Pj4+ICsgKiBAUUVNVV9QTFVHSU5fQ09ORF9ORTog
aXMgbm90IGVxdWFsPw0KPj4+PiArICogQFFFTVVfUExVR0lOX0NPTkRfTFQ6IGlzIGxlc3Mg
dGhhbj8NCj4+Pj4gKyAqIEBRRU1VX1BMVUdJTl9DT05EX0xFOiBpcyBsZXNzIHRoYW4gb3Ig
ZXF1YWw/DQo+Pj4+ICsgKiBAUUVNVV9QTFVHSU5fQ09ORF9HVDogaXMgZ3JlYXRlciB0aGFu
Pw0KPj4+PiArICogQFFFTVVfUExVR0lOX0NPTkRfR0U6IGlzIGdyZWF0ZXIgdGhhbiBvciBl
cXVhbD8NCj4+Pj4gKyAqLw0KPj4+PiArZW51bSBxZW11X3BsdWdpbl9jb25kIHsNCj4+Pj4g
KyAgICBRRU1VX1BMVUdJTl9DT05EX05FVkVSLA0KPj4+PiArICAgIFFFTVVfUExVR0lOX0NP
TkRfQUxXQVlTLA0KPj4+PiArICAgIFFFTVVfUExVR0lOX0NPTkRfRVEsDQo+Pj4+ICsgICAg
UUVNVV9QTFVHSU5fQ09ORF9ORSwNCj4+Pj4gKyAgICBRRU1VX1BMVUdJTl9DT05EX0xULA0K
Pj4+PiArICAgIFFFTVVfUExVR0lOX0NPTkRfTEUsDQo+Pj4+ICsgICAgUUVNVV9QTFVHSU5f
Q09ORF9HVCwNCj4+Pj4gKyAgICBRRU1VX1BMVUdJTl9DT05EX0dFLA0KPj4+PiArfTsNCj4+
Pj4gKw0KPj4+PiAgICAvKioNCj4+Pj4gICAgICogdHlwZWRlZiBxZW11X3BsdWdpbl92Y3B1
X3RiX3RyYW5zX2NiX3QgLSB0cmFuc2xhdGlvbiBjYWxsYmFjaw0KPj4+PiAgICAgKiBAaWQ6
IHVuaXF1ZSBwbHVnaW4gaWQNCj4+Pj4gQEAgLTMwMSw2ICszMjQsMzIgQEAgdm9pZCBxZW11
X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNfY2Ioc3RydWN0IHFlbXVfcGx1Z2luX3Ri
ICp0YiwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZW51bSBxZW11X3BsdWdpbl9jYl9mbGFncyBmbGFncywNCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdm9pZCAqdXNlcmRhdGEpOw0KPj4+
PiAgICArLyoqDQo+Pj4+ICsgKiBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNf
Y29uZF9jYigpIC0gcmVnaXN0ZXIgY29uZGl0aW9uYWwgY2FsbGJhY2sNCj4+Pj4gKyAqIEB0
YjogdGhlIG9wYXF1ZSBxZW11X3BsdWdpbl90YiBoYW5kbGUgZm9yIHRoZSB0cmFuc2xhdGlv
bg0KPj4+PiArICogQGNiOiBjYWxsYmFjayBmdW5jdGlvbg0KPj4+PiArICogQGNvbmQ6IGNv
bmRpdGlvbiB0byBlbmFibGUgY2FsbGJhY2sNCj4+Pj4gKyAqIEBlbnRyeTogZmlyc3Qgb3Bl
cmFuZCBmb3IgY29uZGl0aW9uDQo+Pj4+ICsgKiBAaW1tOiBzZWNvbmQgb3BlcmFuZCBmb3Ig
Y29uZGl0aW9uDQo+Pj4+ICsgKiBAZmxhZ3M6IGRvZXMgdGhlIHBsdWdpbiByZWFkIG9yIHdy
aXRlIHRoZSBDUFUncyByZWdpc3RlcnM/DQo+Pj4+ICsgKiBAdXNlcmRhdGE6IGFueSBwbHVn
aW4gZGF0YSB0byBwYXNzIHRvIHRoZSBAY2I/DQo+Pj4+ICsgKg0KPj4+PiArICogVGhlIEBj
YiBmdW5jdGlvbiBpcyBjYWxsZWQgd2hlbiBhIHRyYW5zbGF0ZWQgdW5pdCBleGVjdXRlcyBp
Zg0KPj4+PiArICogZW50cnkgQGNvbmQgaW1tIGlzIHRydWUuDQo+Pj4+ICsgKiBJZiBjb25k
aXRpb24gaXMgUUVNVV9QTFVHSU5fQ09ORF9BTFdBWVMsIGNvbmRpdGlvbiBpcyBuZXZlciBp
bnRlcnByZXRlZCBhbmQNCj4+Pj4gKyAqIHRoaXMgZnVuY3Rpb24gaXMgZXF1aXZhbGVudCB0
byBxZW11X3BsdWdpbl9yZWdpc3Rlcl92Y3B1X3RiX2V4ZWNfY2IuDQo+Pj4+ICsgKiBJZiBj
b25kaXRpb24gUUVNVV9QTFVHSU5fQ09ORF9ORVZFUiwgY29uZGl0aW9uIGlzIG5ldmVyIGlu
dGVycHJldGVkIGFuZA0KPj4+PiArICogY2FsbGJhY2sgaXMgbmV2ZXIgaW5zdGFsbGVkLg0K
Pj4+PiArICovDQo+Pj4+ICtRRU1VX1BMVUdJTl9BUEkNCj4+Pj4gK3ZvaWQgcWVtdV9wbHVn
aW5fcmVnaXN0ZXJfdmNwdV90Yl9leGVjX2NvbmRfY2Ioc3RydWN0IHFlbXVfcGx1Z2luX3Ri
ICp0YiwNCj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcWVtdV9wbHVnaW5fdmNwdV91ZGF0YV9jYl90IGNiLA0KPj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnVtIHFlbXVfcGx1Z2lu
X2NiX2ZsYWdzIGZsYWdzLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBlbnVtIHFlbXVfcGx1Z2luX2NvbmQgY29uZCwNCj4+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWVtdV9wbHVn
aW5fdTY0IGVudHJ5LA0KPj4+IElzIHRoaXMgYSBmaXhlZCBlbnRyeSBvciBwYXJ0IG9mIGEg
c2NvcmVib2FyZD8NCj4+Pg0KPj4NCj4+IGVudHJ5IGlzIGFuIGVudHJ5IG9mIHNjb3JlYm9h
cmQgKGF1dG9tYXRpY2FsbHkgYXNzb2NpYXRlZCB0byBlYWNoIHZjcHUNCj4+IHVzaW5nIHZj
cHVfaW5kZXgpIGFuZCBjYW4gYmUgbW9kaWZpZWQgYnkgYW55IG90aGVyIGlubGluZSBvcCwg
b3INCj4+IGNhbGxiYWNrLiBAaW1tIChuZXh0IHBhcmFtZXRlcikgaXMgZml4ZWQgeWVzLg0K
Pj4NCj4+IGNhbGxiYWNrIHdpbGwgYmUgY2FsbGVkIG9ubHkgaWYgZW50cnkgPGNvbmQ+IGlt
bSB0cnVlLg0KPiANCj4gSSB3b25kZXIgaWYgaGF2aW5nIGFuIGFsdGVybmF0ZSBmb3JtIGZv
ciBjb21wYXJpbmcgdHdvIHNjb3JlYm9hcmQNCj4gZW50cmllcyB3b3VsZCBiZSB1c2VmdWw/
DQo+IA0KDQpXZSBjYW4gYWx3YXlzIGFkZCBhIG5ldyBBUEkgZm9yIHRoYXQgaW4gdGhlIGZ1
dHVyZSBpZiBhIHNwZWNpZmljIG5lZWQgaXMgDQppZGVudGlmaWVkLiBJbiBvdXIgY3VycmVu
dCB1c2UgY2FzZXMsIHRoaXMgbmVlZCB3YXMgbm90IHJldmVhbGVkLg0K

