Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EB4C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZs-0002sA-Ci; Fri, 04 Apr 2025 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZK-0002Nk-Kr
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:03 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZI-0005oS-77
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:02 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30185d00446so1946741a91.0
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786658; x=1744391458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXxEqd1ZKi9MHejX/IbgiToBWYtrmN9E0A9bU2oQ8FQ=;
 b=q3tYKS8Z33y8BDpLmrVLQp0WrwubfMPc8hPUWDBilTHByUsNVhNK5jQtbUYsVwGmVw
 GvRTyikPjK9WJjtecAc41g576xA/iNkfOFtIPF4zDeq/4ktMLGMBlnxLNIr8j1FeLwwb
 FqkPAQkfbwAmFz2GqVI7B0JQ9LN3c5k4XQGgeDgi99m7YE+ImAp+H7trteXmAcsKKpi8
 F7Cp1hKSGYR6XfkNWYTMSU2oIKODqrCosPGhz4fRuvvcZmcUFR2+EOD9nk+uBKH6ks3M
 dP3casv5Fe1rDf1EUgDCkHdZSu7uRAivpPTI7QL6I/ArEP1x25vgzb+g8gd9rD+VedFV
 oI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786658; x=1744391458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nXxEqd1ZKi9MHejX/IbgiToBWYtrmN9E0A9bU2oQ8FQ=;
 b=nfe2zaZWEFRSCv8i/ckyBWkfpg20VffHKUCVHJ/cYPwhzy0aD/aIHpHZSVH5pQIFGZ
 seXmnHhfLCCr3tgN+mzBL7qLPGgioF5A0v2MmeOxfF//tWJHRnlXWJep8Qoj5TXWeket
 LRTKFm+tOcf+b/LSqQ0MpdNw+zgrL+UlL+A8QVylLfZOQ1JqRB2hapkXdOstBJjl0Dkt
 srqpqLrhFPqldUTxpu3kBLS0sTCMo4WEeXacN5E4Nohp94nNe+fjbgEbqWjBRH1ugeZl
 Trq3mf8hhmzZ3xcmpQ307B9xZYjk+vIOKM3ynWNVYA/JzcU9DiAV/r83VHVn0WBp1g5F
 7Zcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWh4Hxp0bNmGHP9YYx2WFhWqP82UPX5hahSkAjoj1iXQbefqL7TZdeMH+fDGN1R3PmAIQp2ZaO52Rf0@nongnu.org
X-Gm-Message-State: AOJu0YwhkcrI/VtbpZMN8HqO2Yusat6TBPey+IHdcOdDIv/D/upX8d72
 XtMH/txtipRSdsLV2u4TJiwF3SMPNY5rvnFZ5EXCQ5GLJE46cyI7m7RiFbWBupc=
X-Gm-Gg: ASbGnctGJNUxthcKaTP/jZK5oAdcb7G7WMHkkdSjHG687xZJDh2FgnQsd/HT1MvOeLH
 opY4eXDI6Ueap1OhYfQOSTGgPhPuL59gv83q69Z+diy3Jp/S2DAEKp3Uea3XsT3MQ4GVjRyMQV1
 wwckqAsMqlJUntRG/xijDo/9sk2lekbhkwdtc97I6guSdo9lZUaxKgZ8MhB63jJp6QBj5kWEGSV
 bc3arU6j+otpl85vQVowQi78ETTvSb2Ik1mgZDrw2OYbg/fADQrEVYFW82hRh5Wz728v5ZCXyzJ
 94PkcuU+b+pFQAyRURFPljQqtw9i65ub2bHsvOLBeg5+6XkfoQQmYRzoFQ==
X-Google-Smtp-Source: AGHT+IEXBh1MchWIiO0P3yORAS45Poq72qUsNwWc9IuM984zjLzrJuVUWIO8n/Zfg1+hLQtNyCeS3A==
X-Received: by 2002:a17:90b:2c83:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-3057a5bf3cfmr11773279a91.6.1743786658222; 
 Fri, 04 Apr 2025 10:10:58 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.10.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:57 -0700 (PDT)
Message-ID: <8eeb79aa-7794-41c0-aa93-7998ed0a0d64@linaro.org>
Date: Fri, 4 Apr 2025 09:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 14/19] accel: Implement
 accel_init_ops_interfaces() for both system/user mode
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBhY2NlbC97YWNjZWwtc3lzdGVtLmggPT4gYWNjZWwtaW50ZXJuYWwu
aH0gfCAgOCArKysrLS0tLQ0KPiAgIGFjY2VsL2FjY2VsLXN5c3RlbS5jICAgICAgICAgICAg
ICAgICAgICAgICB8ICA0ICsrLS0NCj4gICBhY2NlbC9hY2NlbC10YXJnZXQuYyAgICAgICAg
ICAgICAgICAgICAgICAgfCAxMCArKy0tLS0tLS0tDQo+ICAgYWNjZWwvYWNjZWwtdXNlci5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKysrDQo+ICAgNCBmaWxlcyBjaGFu
Z2VkLCAxNCBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gICByZW5hbWUgYWNj
ZWwve2FjY2VsLXN5c3RlbS5oID0+IGFjY2VsLWludGVybmFsLmh9ICg1NiUpDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYWNjZWwvYWNjZWwtc3lzdGVtLmggYi9hY2NlbC9hY2NlbC1pbnRlcm5h
bC5oDQo+IHNpbWlsYXJpdHkgaW5kZXggNTYlDQo+IHJlbmFtZSBmcm9tIGFjY2VsL2FjY2Vs
LXN5c3RlbS5oDQo+IHJlbmFtZSB0byBhY2NlbC9hY2NlbC1pbnRlcm5hbC5oDQo+IGluZGV4
IDJkMzdjNzNjOTdiLi4wMzQyNmFhMjFlZSAxMDA2NDQNCj4gLS0tIGEvYWNjZWwvYWNjZWwt
c3lzdGVtLmgNCj4gKysrIGIvYWNjZWwvYWNjZWwtaW50ZXJuYWwuaA0KPiBAQCAtMSw1ICsx
LDUgQEANCj4gICAvKg0KPiAtICogUUVNVSBTeXN0ZW0gRW11bGF0aW9uIGFjY2VsIGludGVy
bmFsIGZ1bmN0aW9ucw0KPiArICogUUVNVSBhY2NlbCBpbnRlcm5hbCBmdW5jdGlvbnMNCj4g
ICAgKg0KPiAgICAqIENvcHlyaWdodCAyMDIxIFNVU0UgTExDDQo+ICAgICoNCj4gQEAgLTcs
OSArNyw5IEBADQo+ICAgICogU2VlIHRoZSBDT1BZSU5HIGZpbGUgaW4gdGhlIHRvcC1sZXZl
bCBkaXJlY3RvcnkuDQo+ICAgICovDQo+ICAgDQo+IC0jaWZuZGVmIEFDQ0VMX1NZU1RFTV9I
DQo+IC0jZGVmaW5lIEFDQ0VMX1NZU1RFTV9IDQo+ICsjaWZuZGVmIEFDQ0VMX0lOVEVSTkFM
X0gNCj4gKyNkZWZpbmUgQUNDRUxfSU5URVJOQUxfSA0KPiAgIA0KPiAtdm9pZCBhY2NlbF9z
eXN0ZW1faW5pdF9vcHNfaW50ZXJmYWNlcyhBY2NlbENsYXNzICphYyk7DQo+ICt2b2lkIGFj
Y2VsX2luaXRfb3BzX2ludGVyZmFjZXMoQWNjZWxDbGFzcyAqYWMpOw0KPiAgIA0KPiAgICNl
bmRpZiAvKiBBQ0NFTF9TWVNURU1fSCAqLw0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvYWNjZWwt
c3lzdGVtLmMgYi9hY2NlbC9hY2NlbC1zeXN0ZW0uYw0KPiBpbmRleCA1ZGY0OWZiZTgzMS4u
YTBmNTYyYWU5ZmYgMTAwNjQ0DQo+IC0tLSBhL2FjY2VsL2FjY2VsLXN5c3RlbS5jDQo+ICsr
KyBiL2FjY2VsL2FjY2VsLXN5c3RlbS5jDQo+IEBAIC0yOSw3ICsyOSw3IEBADQo+ICAgI2lu
Y2x1ZGUgInN5c3RlbS9hY2NlbC1vcHMuaCINCj4gICAjaW5jbHVkZSAic3lzdGVtL2NwdXMu
aCINCj4gICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQuaCINCj4gLSNpbmNsdWRlICJh
Y2NlbC1zeXN0ZW0uaCINCj4gKyNpbmNsdWRlICJhY2NlbC1pbnRlcm5hbC5oIg0KPiAgIA0K
PiAgIGludCBhY2NlbF9pbml0X21hY2hpbmUoQWNjZWxTdGF0ZSAqYWNjZWwsIE1hY2hpbmVT
dGF0ZSAqbXMpDQo+ICAgew0KPiBAQCAtNjMsNyArNjMsNyBAQCB2b2lkIGFjY2VsX3NldHVw
X3Bvc3QoTWFjaGluZVN0YXRlICptcykNCj4gICB9DQo+ICAgDQo+ICAgLyogaW5pdGlhbGl6
ZSB0aGUgYXJjaC1pbmRlcGVuZGVudCBhY2NlbCBvcGVyYXRpb24gaW50ZXJmYWNlcyAqLw0K
PiAtdm9pZCBhY2NlbF9zeXN0ZW1faW5pdF9vcHNfaW50ZXJmYWNlcyhBY2NlbENsYXNzICph
YykNCj4gK3ZvaWQgYWNjZWxfaW5pdF9vcHNfaW50ZXJmYWNlcyhBY2NlbENsYXNzICphYykN
Cj4gICB7DQo+ICAgICAgIGNvbnN0IGNoYXIgKmFjX25hbWU7DQo+ICAgICAgIGNoYXIgKm9w
c19uYW1lOw0KPiBkaWZmIC0tZ2l0IGEvYWNjZWwvYWNjZWwtdGFyZ2V0LmMgYi9hY2NlbC9h
Y2NlbC10YXJnZXQuYw0KPiBpbmRleCA5ZTllNzBiZTg3Ni4uNmZhNWMzZWYwNGUgMTAwNjQ0
DQo+IC0tLSBhL2FjY2VsL2FjY2VsLXRhcmdldC5jDQo+ICsrKyBiL2FjY2VsL2FjY2VsLXRh
cmdldC5jDQo+IEBAIC0yOSwxMCArMjksNyBAQA0KPiAgIA0KPiAgICNpbmNsdWRlICJjcHUu
aCINCj4gICAjaW5jbHVkZSAiYWNjZWwvYWNjZWwtY3B1LXRhcmdldC5oIg0KPiAtDQo+IC0j
aWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gLSNpbmNsdWRlICJhY2NlbC1zeXN0ZW0uaCIN
Cj4gLSNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05MWSAqLw0KPiArI2luY2x1ZGUgImFjY2Vs
LWludGVybmFsLmgiDQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGFjY2VsX3R5
cGUgPSB7DQo+ICAgICAgIC5uYW1lID0gVFlQRV9BQ0NFTCwNCj4gQEAgLTEwNiwxMCArMTAz
LDcgQEAgc3RhdGljIHZvaWQgYWNjZWxfaW5pdF9jcHVfaW50ZXJmYWNlcyhBY2NlbENsYXNz
ICphYykNCj4gICANCj4gICB2b2lkIGFjY2VsX2luaXRfaW50ZXJmYWNlcyhBY2NlbENsYXNz
ICphYykNCj4gICB7DQo+IC0jaWZuZGVmIENPTkZJR19VU0VSX09OTFkNCj4gLSAgICBhY2Nl
bF9zeXN0ZW1faW5pdF9vcHNfaW50ZXJmYWNlcyhhYyk7DQo+IC0jZW5kaWYgLyogIUNPTkZJ
R19VU0VSX09OTFkgKi8NCj4gLQ0KPiArICAgIGFjY2VsX2luaXRfb3BzX2ludGVyZmFjZXMo
YWMpOw0KPiAgICAgICBhY2NlbF9pbml0X2NwdV9pbnRlcmZhY2VzKGFjKTsNCj4gICB9DQo+
ICAgDQo+IGRpZmYgLS1naXQgYS9hY2NlbC9hY2NlbC11c2VyLmMgYi9hY2NlbC9hY2NlbC11
c2VyLmMNCj4gaW5kZXggMjJiNmExYTFhODkuLjdkMTkyMzA2YTY1IDEwMDY0NA0KPiAtLS0g
YS9hY2NlbC9hY2NlbC11c2VyLmMNCj4gKysrIGIvYWNjZWwvYWNjZWwtdXNlci5jDQo+IEBA
IC05LDYgKzksMTIgQEANCj4gICANCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAg
ICNpbmNsdWRlICJxZW11L2FjY2VsLmgiDQo+ICsjaW5jbHVkZSAiYWNjZWwtaW50ZXJuYWwu
aCINCj4gKw0KPiArdm9pZCBhY2NlbF9pbml0X29wc19pbnRlcmZhY2VzKEFjY2VsQ2xhc3Mg
KmFjKQ0KPiArew0KPiArICAgIC8qIG5vdGhpbmcgKi8NCj4gK30NCj4gICANCj4gICBBY2Nl
bFN0YXRlICpjdXJyZW50X2FjY2VsKHZvaWQpDQo+ICAgew0KDQpUaGF0J3MgZ29vZCwgYW5k
IGl0J3MgaG93IHdlIHdhbnQgdG8gZ2V0IHJpZCBvZiB1c2VyL3N5c3RlbSBjb25kaXRpb25h
bHMuDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQoNCg==

