Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384B0D41C27
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBREn-0002kx-WA; Wed, 13 Nov 2024 23:13:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBREi-0002Ua-VM
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:41 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBREh-0003wn-3K
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:40 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7f4325168c8so81098a12.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557618; x=1732162418; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8uDsC5HYEN4LMUpFD6Js0X22bzIkQyLv9O6arsIpmOE=;
 b=keIlq6rhL3tAaKHiHn37UFejKK97BkvnE1YI0XSIfFaf52m/84r9aFnNx40J/Nuncr
 /QbdM07FUE02rrJM8hNGUEumjNXmOVGaUozxbAv0M+QSytVSdImcLLe//gCPX8k1w60n
 bj3dpFdbnvj9zsB3ZhyDgxhnquoWK4Et/M3SWc2Xmg8du+gnSo8/OBH3x4LWdnS2v47E
 XYpZWnnzsIrR+3TrYa5yM/ZtkSTcwvVv7Y8zF7syy9pWGVhcqgiT5YVidcgXrkQmJRRm
 LG6rqUzLNxAwC5lgqw/kzuZ4x2PJbBdmQld7vawMy+CPqAJARXBv7F+o2ivtsCFmPEhx
 jLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557618; x=1732162418;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8uDsC5HYEN4LMUpFD6Js0X22bzIkQyLv9O6arsIpmOE=;
 b=FCxMan4OVhf3yc/IZGY7L8r2p900cae8Uu5gEEpQN00K/OqaEQxv1Fgsr6hoQM2IrV
 Sep9DIX8zY6kSmSr73YlSDiDkb5izYhabcXNDuq9y4ursNr6QFdld7Op8mcQeQ5V3nlu
 PKEZjR//5bQyEBNDjwPL6r8TXAtYiySMMM+VWMBob1WZYIiFp07bUB67mdh9B3I6uNUk
 +RR+c5Ic1LxEo9RSCupD4yyhuHra53MydO3/9yEIRIySv0U2f9sSRqzxzUurtvlBqZ9P
 OiGW/RKntvLWmlsuN5BaOQEazh04Y9+/v5ewDt08Av1I9/EeljwIh07cag7oChZA/rLg
 Z05g==
X-Forwarded-Encrypted: i=1;
 AJvYcCURPfiOzFY0EXZfC3ppf8JLRGYJVvVnEwaE5yWSVqoOlnuiLUqHz7eURx41hdTPzOvJokOsOJCiaYdU@nongnu.org
X-Gm-Message-State: AOJu0YysuYuSOj1SXrVPfvM100UCSrC5fX/zSiXqViOqpFD1qU9BCI+B
 F7CjPG37/4+PfMFyJXJUdiJqLm5WSLpWE3EcJX71OXPviHV2NU89xtM6bXaJpUM=
X-Google-Smtp-Source: AGHT+IHBzQj2j/wYBez7Gm4MKcCxgkSeXlWt4tgwuFEcMmnshM5OpMbdungsYJH6jEkk56vj/Eo9ZQ==
X-Received: by 2002:a05:6a20:e607:b0:1db:92e5:d2a7 with SMTP id
 adf61e73a8af0-1dc7037e46emr7740980637.15.1731557617617; 
 Wed, 13 Nov 2024 20:13:37 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39766dfsm137544a12.58.2024.11.13.20.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:13:37 -0800 (PST)
Message-ID: <6567c939-8c09-4fa0-8851-5252bf8e7955@linaro.org>
Date: Wed, 13 Nov 2024 20:13:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/24] exec: Declare tlb_set_page_full() in 'exec/cputlb.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-16-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMTEvMTMvMjQgMTc6MTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIENQVSBUTEIgcmVsYXRlZCBtZXRob2RzIHRvICJleGVjL2NwdXRsYi5oIi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdXRsYi5oICAgICB8IDIzICsrKysr
KysrKysrKysrKysrKysrKysrDQo+ICAgaW5jbHVkZS9leGVjL2V4ZWMtYWxsLmggICB8IDIy
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICB0YXJnZXQvc3BhcmMvbW11X2hlbHBlci5j
IHwgIDIgKy0NCj4gICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDIzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHV0bGIuaCBi
L2luY2x1ZGUvZXhlYy9jcHV0bGIuaA0KPiBpbmRleCA1Mzg2ZTUzODA2Li5mNjIwNWQ1MzA2
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvY3B1dGxiLmgNCj4gKysrIGIvaW5jbHVk
ZS9leGVjL2NwdXRsYi5oDQo+IEBAIC0yMSw2ICsyMSw3IEBADQo+ICAgI2RlZmluZSBDUFVU
TEJfSA0KPiAgIA0KPiAgICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24uaCINCj4gKyNpbmNs
dWRlICJleGVjL3ZhZGRyLmgiDQo+ICAgDQo+ICAgI2lmIGRlZmluZWQoQ09ORklHX1RDRykg
JiYgIWRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCj4gICANCj4gQEAgLTU3LDQgKzU4LDI2
IEBAIHZvaWQgdGxiX3Jlc2V0X2RpcnR5X3JhbmdlX2FsbChyYW1fYWRkcl90IHN0YXJ0LCBy
YW1fYWRkcl90IGxlbmd0aCk7DQo+ICAgDQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsvKioNCj4g
KyAqIHRsYl9zZXRfcGFnZV9mdWxsOg0KPiArICogQGNwdTogQ1BVIGNvbnRleHQNCj4gKyAq
IEBtbXVfaWR4OiBtbXUgaW5kZXggb2YgdGhlIHRsYiB0byBtb2RpZnkNCj4gKyAqIEBhZGRy
OiB2aXJ0dWFsIGFkZHJlc3Mgb2YgdGhlIGVudHJ5IHRvIGFkZA0KPiArICogQGZ1bGw6IHRo
ZSBkZXRhaWxzIG9mIHRoZSB0bGIgZW50cnkNCj4gKyAqDQo+ICsgKiBBZGQgYW4gZW50cnkg
dG8gQGNwdSB0bGIgaW5kZXggQG1tdV9pZHguICBBbGwgb2YgdGhlIGZpZWxkcyBvZg0KPiAr
ICogQGZ1bGwgbXVzdCBiZSBmaWxsZWQsIGV4Y2VwdCBmb3IgeGxhdF9zZWN0aW9uLCBhbmQg
Y29uc3RpdHV0ZQ0KPiArICogdGhlIGNvbXBsZXRlIGRlc2NyaXB0aW9uIG9mIHRoZSB0cmFu
c2xhdGVkIHBhZ2UuDQo+ICsgKg0KPiArICogVGhpcyBpcyBnZW5lcmFsbHkgY2FsbGVkIGJ5
IHRoZSB0YXJnZXQgdGxiX2ZpbGwgZnVuY3Rpb24gYWZ0ZXINCj4gKyAqIGhhdmluZyBwZXJm
b3JtZWQgYSBzdWNjZXNzZnVsIHBhZ2UgdGFibGUgd2FsayB0byBmaW5kIHRoZSBwaHlzaWNh
bA0KPiArICogYWRkcmVzcyBhbmQgYXR0cmlidXRlcyBmb3IgdGhlIHRyYW5zbGF0aW9uLg0K
PiArICoNCj4gKyAqIEF0IG1vc3Qgb25lIGVudHJ5IGZvciBhIGdpdmVuIHZpcnR1YWwgYWRk
cmVzcyBpcyBwZXJtaXR0ZWQuIE9ubHkgYQ0KPiArICogc2luZ2xlIFRBUkdFVF9QQUdFX1NJ
WkUgcmVnaW9uIGlzIG1hcHBlZDsgQGZ1bGwtPmxnX3BhZ2Vfc2l6ZSBpcyBvbmx5DQo+ICsg
KiB1c2VkIGJ5IHRsYl9mbHVzaF9wYWdlLg0KPiArICovDQo+ICt2b2lkIHRsYl9zZXRfcGFn
ZV9mdWxsKENQVVN0YXRlICpjcHUsIGludCBtbXVfaWR4LCB2YWRkciBhZGRyLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBDUFVUTEJFbnRyeUZ1bGwgKmZ1bGwpOw0KPiArDQo+ICAg
I2VuZGlmDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaCBiL2luY2x1
ZGUvZXhlYy9leGVjLWFsbC5oDQo+IGluZGV4IGQ3OTIyMDM3NzMuLjc5NjQ5NTM3YjAgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oDQo+ICsrKyBiL2luY2x1ZGUv
ZXhlYy9leGVjLWFsbC5oDQo+IEBAIC0xNzQsMjggKzE3NCw2IEBAIHZvaWQgdGxiX2ZsdXNo
X3JhbmdlX2J5X21tdWlkeF9hbGxfY3B1c19zeW5jZWQoQ1BVU3RhdGUgKmNwdSwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQxNl90
IGlkeG1hcCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVuc2lnbmVkIGJpdHMpOw0KPiAgIA0KPiAtLyoqDQo+IC0gKiB0bGJfc2V0X3Bh
Z2VfZnVsbDoNCj4gLSAqIEBjcHU6IENQVSBjb250ZXh0DQo+IC0gKiBAbW11X2lkeDogbW11
IGluZGV4IG9mIHRoZSB0bGIgdG8gbW9kaWZ5DQo+IC0gKiBAYWRkcjogdmlydHVhbCBhZGRy
ZXNzIG9mIHRoZSBlbnRyeSB0byBhZGQNCj4gLSAqIEBmdWxsOiB0aGUgZGV0YWlscyBvZiB0
aGUgdGxiIGVudHJ5DQo+IC0gKg0KPiAtICogQWRkIGFuIGVudHJ5IHRvIEBjcHUgdGxiIGlu
ZGV4IEBtbXVfaWR4LiAgQWxsIG9mIHRoZSBmaWVsZHMgb2YNCj4gLSAqIEBmdWxsIG11c3Qg
YmUgZmlsbGVkLCBleGNlcHQgZm9yIHhsYXRfc2VjdGlvbiwgYW5kIGNvbnN0aXR1dGUNCj4g
LSAqIHRoZSBjb21wbGV0ZSBkZXNjcmlwdGlvbiBvZiB0aGUgdHJhbnNsYXRlZCBwYWdlLg0K
PiAtICoNCj4gLSAqIFRoaXMgaXMgZ2VuZXJhbGx5IGNhbGxlZCBieSB0aGUgdGFyZ2V0IHRs
Yl9maWxsIGZ1bmN0aW9uIGFmdGVyDQo+IC0gKiBoYXZpbmcgcGVyZm9ybWVkIGEgc3VjY2Vz
c2Z1bCBwYWdlIHRhYmxlIHdhbGsgdG8gZmluZCB0aGUgcGh5c2ljYWwNCj4gLSAqIGFkZHJl
c3MgYW5kIGF0dHJpYnV0ZXMgZm9yIHRoZSB0cmFuc2xhdGlvbi4NCj4gLSAqDQo+IC0gKiBB
dCBtb3N0IG9uZSBlbnRyeSBmb3IgYSBnaXZlbiB2aXJ0dWFsIGFkZHJlc3MgaXMgcGVybWl0
dGVkLiBPbmx5IGENCj4gLSAqIHNpbmdsZSBUQVJHRVRfUEFHRV9TSVpFIHJlZ2lvbiBpcyBt
YXBwZWQ7IEBmdWxsLT5sZ19wYWdlX3NpemUgaXMgb25seQ0KPiAtICogdXNlZCBieSB0bGJf
Zmx1c2hfcGFnZS4NCj4gLSAqLw0KPiAtdm9pZCB0bGJfc2V0X3BhZ2VfZnVsbChDUFVTdGF0
ZSAqY3B1LCBpbnQgbW11X2lkeCwgdmFkZHIgYWRkciwNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgQ1BVVExCRW50cnlGdWxsICpmdWxsKTsNCj4gLQ0KPiAgIC8qKg0KPiAgICAqIHRs
Yl9zZXRfcGFnZV93aXRoX2F0dHJzOg0KPiAgICAqIEBjcHU6IENQVSB0byBhZGQgdGhpcyBU
TEIgZW50cnkgZm9yDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvc3BhcmMvbW11X2hlbHBlci5j
IGIvdGFyZ2V0L3NwYXJjL21tdV9oZWxwZXIuYw0KPiBpbmRleCA5ZmYwNjAyNmI4Li43NTQ4
ZDAxNzc3IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvc3BhcmMvbW11X2hlbHBlci5jDQo+ICsr
KyBiL3RhcmdldC9zcGFyYy9tbXVfaGVscGVyLmMNCj4gQEAgLTIwLDcgKzIwLDcgQEANCj4g
ICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAgICNpbmNsdWRlICJxZW11L2xvZy5oIg0K
PiAgICNpbmNsdWRlICJjcHUuaCINCj4gLSNpbmNsdWRlICJleGVjL2V4ZWMtYWxsLmgiDQo+
ICsjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCINCj4gICAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiDQo+ICAgI2lu
Y2x1ZGUgInRyYWNlLmgiDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVy
cmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

