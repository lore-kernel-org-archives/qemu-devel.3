Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A54C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 23:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuftX-00029K-T2; Tue, 18 Mar 2025 18:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuftS-00026O-Il
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:58:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuftP-0007a0-OA
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 18:58:42 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224341bbc1dso119049655ad.3
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742338715; x=1742943515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W93rpVZsHi97qPuHO/U/FnMIMFGbqK6KiMYoGPhb3pA=;
 b=m0bSxVXMSafamky8N/ERHvnX0vuONIWivbo/+znDQ90tsrQFqsnPK/59Liprbg4H5l
 LuO+Fb+ls+ngD8d9xKPATrYqpvY/9qmKAugGyrPMpBWTHsrJJCfohqgTaQwW8jNZju7k
 hmNmotTi3VBNZXTaJXBZPWUL2okbM0bZSmZavtiH5rJRrtpXV81GR5S6i6nUdVMFwalM
 QJ7Nf3O7tMBSMW9DRdsiJVoHbxgnIRyNyBRGFCGFl+TAXufSePqrciWcMGYo55VWs9cS
 nrBIPvbJ2/U8bub8RQ3I0sLfMk/4UdIWnJWR4MMGkK47ehFl6yHWYV1W6oPq8+EV0PqZ
 y55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742338715; x=1742943515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W93rpVZsHi97qPuHO/U/FnMIMFGbqK6KiMYoGPhb3pA=;
 b=B+LBvASsPZg8gmnclI1yw4AUUilnpEhDtl1X1YKJUwiq1XSYIwR5a2FMWjVW19LMEi
 JAGIN+BVAbaAQ57ZZB8L4QtTFIiqCBUContGmpAvf7JTfuZ65m4jNPzsR3oB7gJ6xoa+
 7Vfg3hSL3KBsaJURS3KmUH3VPXZQOKFgQYEeaODukki+h7gxqkp0ADPHtJmW7wRDHI0L
 JvevyH87as6sVRysmWd+x71D5J6v+VKy5cAKsccMcTDmWe9c50pjMBq5/t5hOSdlyRuu
 Ymvyi7/QtRBm9K0LaYrmNtrSgyngos6G80reXfVXYw/BRwX/GmZkQgI6I3QbUU/jkLWs
 iQfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4Zbj6T65jgal1X8zbAM/7IizWN1RkEnWiYKfltAC6sIPwSz0CGznaEbbgplj1wL2ncrdoWoiEoHcY@nongnu.org
X-Gm-Message-State: AOJu0Yx579hSz9ug3EGgJZHbL0w2ZQIzD+ctWGcp0SLJrU7CnMUSLUtC
 LZUeT75m8JjiCZuS7mWeLcSlHjIRmdvsVw9ZhflssEvUHAGh3yv8gb02leprock=
X-Gm-Gg: ASbGncvZex1AQHfC+dUROirDH63W/DXe4FO6l6vPtxeF+E8yohVi6Dt/z2TKpW0IzAG
 md+lG0aY+AbG1jdOANwrrin9tOs1XPrtiYclzSekfrdGxkZ8YlWYX5v/OeBU5tq/JPb+giVHVsw
 Ac9rlvsCzUCUWyxzv0G2SSiQAuvlugRM4iS9J0ZuoK8E72YXhyYmjcyBgqmd3+yDhiCZQR3SZvW
 k+gNmt0zx18ZvLqNHVwfqf5Qhe9tEUnMMgBKPU6uKBgOAhpb/T7jujB91UBX/4aWYRMWB2Kxrg3
 N3H3fK9DbS2XMUy8HrZo5r9l6omkwTm7tn7AnV5Toc2l8IGpOtdV5ZYJbQ==
X-Google-Smtp-Source: AGHT+IGgATHzA5mk2h2ZORMhsVXPw1HXuieiJoAjLgmzG5rkU4wbf2UiZAhgaj9NQ6le0L1eNMvUqw==
X-Received: by 2002:a05:6a20:1605:b0:1f3:388b:3b4b with SMTP id
 adf61e73a8af0-1fbeb4ab598mr756431637.15.1742338715563; 
 Tue, 18 Mar 2025 15:58:35 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9fed33sm9684412a12.37.2025.03.18.15.58.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 15:58:35 -0700 (PDT)
Message-ID: <b107adfe-83fa-4e56-a26d-3c8a7eb3ac49@linaro.org>
Date: Tue, 18 Mar 2025 15:58:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] exec/cpu-all: allow to include specific cpu
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-5-pierrick.bouvier@linaro.org>
 <35c90e78-2c2c-4bbb-9996-4031c9eef08a@linaro.org>
 <7202c9e9-1002-4cdc-9ce4-64785aac5de4@linaro.org>
 <0c6f23d5-d220-4fa7-957e-8721f1aa732f@linaro.org>
 <172a10d0-f479-4d6c-9555-a9060bdf744e@linaro.org>
 <ac79c5f1-d7ea-4079-b042-3805063fddba@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ac79c5f1-d7ea-4079-b042-3805063fddba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMy8xOC8yNSAxNTozNiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTU6MjUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE4LzI1IDE1OjIx
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzE4LzI1IDE1OjE2LCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gVGhpcyBkb2Vzbid0IG1ha2UgYW55IHNlbnNl
IHRvIG1lLsKgIENQVV9JTkNMVURFIGlzIGRlZmluZWQgd2l0aGluIHRoZSB2ZXJ5IGZpbGUg
dGhhdA0KPj4+Pj4geW91J3JlIHRyeWluZyB0byBpbmNsdWRlIGJ5IGF2b2lkaW5nICJjcHUu
aCIuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBFdmVyeSB0YXJnZXQvWC9jcHUuaCBpbmNsdWRlcyBj
cHUtYWxsLmgsIHdoaWNoIGluY2x1ZGVzICJjcHUuaCIgaXRzZWxmLCByZWx5aW5nIG9uIHBl
cg0KPj4+PiB0YXJnZXQgaW5jbHVkZSBwYXRoIHNldCBieSBidWlsZCBzeXN0ZW0uDQo+Pj4N
Cj4+PiBTbywgYW5vdGhlciBzb2x1dGlvbiB3b3VsZCBiZSB0byBmaXggdGhlIHNpbGx5IGlu
Y2x1ZGUgbG9vcD8NCj4+Pg0KPj4NCj4+IElmIHlvdSdyZSBvayB3aXRoIGl0LCBJJ20gd2ls
bGluZyB0byByZW1vdmUgY3B1LWFsbC5oIGNvbXBsZXRlbHkgKG1vdmluZyB0bGIgZmxhZ3Mg
Yml0cyBpbg0KPj4gYSBuZXcgaGVhZGVyKSwgYW5kIGZpeGluZyBtaXNzaW5nIGluY2x1ZGVz
IGV2ZXJ5d2hlcmUuDQo+Pg0KPj4gSSBqdXN0IHdhbnRlZCB0byBtYWtlIHN1cmUgaXQncyBh
biBhY2NlcHRhYmxlIHBhdGggYmVmb3JlIHNwZW5kaW5nIHRvbyBtdWNoIHRpbWUgb24gaXQu
DQo+IA0KPiBJIHdvdWxkIHZlcnkgbXVjaCBsaWtlIGNwdS1hbGwuaCB0byBnbyBhd2F5Lg0K
PiANCg0KRGVhbCwgSSB3aWxsIGNvbXBsZXRlIHRoZSB3b3JrLCB3aGlsZSBiZWluZyBiYXNl
ZCBvbiB5b3VyIGN1cnJlbnQgc2VyaWVzIA0KKHYyKS4NCg0KPiBJdCBsb29rcyBsaWtlIHdl
IGhhdmUsIG9uIHRjZy1uZXh0Og0KPiANCj4gKDEpIGNwdV9jb3B5IGlzIGxpbnV4LXVzZXIg
b25seSwgYW5kIHNob3VsZCBnbyBpbiBsaW51eC11c2VyL3FlbXUuaC4NCj4gDQo+ICgyKSB0
aGUgVExCIGZsYWdzIGNlcnRhaW5seSBkZXNlcnZlIHRoZWlyIG93biBoZWFkZXIuDQo+IA0K
PiAoMykgVGhlIFFFTVVfQlVJTERfQlVHX09OIGFzc2VydGlvbnMgbmVlZCBub3QgYmUgZG9u
ZSBpbiBhIGhlYWRlciwNCj4gICAgICAgc28gbG9uZyBhcyB0aGVyZSBpcyAqc29tZSogZmls
ZSB0aGF0IHdvbid0IGJ1aWxkIGlmIHRoZSBhc3NlcnRpb25zIGZhaWwuDQo+ICAgICAgIFBl
cmhhcHMgY3B1LXRhcmdldC5jIGlzIGFzIGdvb2QgYXMgYW55Lg0KPiANCg0KWWVzLCBJIG5v
dGljZWQgaXQsIGFuZCBjaG9zZSAjaWZkZWYgQ09NUElMSU5HX1BFUl9UQVJHRVQgd29ya2Fy
b3VuZCB0byANCm5vdCBtYWtlIGEgY2hvaWNlIG9mIHdoZXJlIHRvIG1vdmUgaXQuDQoNCj4g
DQo+IHJ+DQoNCg==

