Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52858C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twn9q-0003yQ-V3; Mon, 24 Mar 2025 15:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twn9X-0003Hv-5L
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:08:03 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twn9T-0002iH-Jf
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:08:02 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-227a8cdd241so14562785ad.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742843277; x=1743448077; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KYULLHmci7J6saJz0lZwny5ZsN0QDZcC1dqTD0PMTFc=;
 b=erKqtDy+NR+et9+RQA4QKwQFKALNG+33XSat8dab25CQ2LxZknz4+rlwHE/hI+W4pW
 c36OzCDZNFXy5yYCWj4KaPlSKl25fGUibus0HpF/9HWTZgBhGmBF6BiaIlHC8NaYad3K
 iX9VwPkkuPISR9v6GaIjAvJxjRJzrDvx7KUMemlnHa6UYxBmANoirfP8rdo8P46Wkj3a
 Bo0d1VGw/asSXXDlMNEwwNH6CCwCysYkCl6UbBkuhNBRZ+4Zp3r3HRbOcSjU6HRs+hSG
 jHE4PE6MMlM9y5nBXY0AKbs+S2WIePB32YRJx7FN3cI3N4rAAESV1QgxWt66OaX35fE6
 DNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742843277; x=1743448077;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KYULLHmci7J6saJz0lZwny5ZsN0QDZcC1dqTD0PMTFc=;
 b=Lx8Rf8zy4X0wAbPTZSUX3RKnvHEMPHj4nhpCQ8q5DdT8YPyQELtjEuM2enAPUamO2x
 KTpTFpjWDTPudvDNdQ0g8Is/pEi4/AzbaAXui+KX99nuxEs/kG3dQTUg43bkmhYLSzk+
 Ob+HEA/PjlO/VCyYCTr6xKtRF1dvsXlAT++/49lX+iMbQumvG4FOVXxAqDeF5YQjWGhx
 6W2Qi0VGZGZIovugptzzl3n0nwsoOhtzkA3FOM0+T2xlespMGiLMp3nAxwG9p6bsdk5S
 HMzb7N+HHO/nF9p7PIqj7S4w3OroXPf2lbNtoXKdxUM/3l+wWrbMZ9HzZaZzmeLABNuI
 5cug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7U5Kx2h9JvRiM4ULebnkf5Sk/x+MIZRRGhdgt4ZHNL32vinO30OwqyyI+UyCQCzStGz9wf5F/s29R@nongnu.org
X-Gm-Message-State: AOJu0YyNVAgtroeesApRKckSE8LBKGBc/baSy1X9CZ+smbIU2Z58CbkM
 ZGrl6UnygjHrIA5r0HNwnl56lr/3v8nDrQvbKDW37liLOa0w59pjJt7vnI/WeSQ=
X-Gm-Gg: ASbGncuwkNXJiiXTWMqcal6RV9rOv8RPzK61liCkvSMqhYDD1gP69D1Ug9RWYz3EeFU
 orEilwW65ujEE2kac01+n8tFxTfLMb13iR5Woz7mZx2ZgqjYmIE9D86giJQmgMr4LPCtyTSgDVG
 GU8J8kXpjxhUafpQZ3qK08Iw+AX/KdzPxesaEt7gxEghZDbVIlrCKVYXtMfD1JJCIDRZ3/0ouwu
 YNmCrOyY9ZIpocj4AP1Qalf85gz+9jjbHV1lwNoEcohfcTUnb+iqPp/XDrB4noDG3T1u/RfU19U
 FunwvOdoxBWFNYSMuG8IrO7AEfJYnUqza1vAqfzTCbaFPCeHlX01lsKb9hDeQwV34+1/
X-Google-Smtp-Source: AGHT+IH3OeqGyLK/mUcfWuVdjUyaybVyo/qYB1sU8cjWmg4J3sAZe5+HdaWKDBWZl+/KhFLMdeFuTg==
X-Received: by 2002:a05:6a21:b90:b0:1ee:dded:e5b with SMTP id
 adf61e73a8af0-1fe42f9bb33mr24008001637.24.1742843276970; 
 Mon, 24 Mar 2025 12:07:56 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611c8d1sm8668864b3a.105.2025.03.24.12.07.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:07:56 -0700 (PDT)
Message-ID: <310c7e87-a327-48cf-aaf9-b48dc39c2573@linaro.org>
Date: Mon, 24 Mar 2025 12:07:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/11] gdbstub: introduce target independent gdb
 register helper
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
 <20250324102142.67022-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250324102142.67022-5-alex.bennee@linaro.org>
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

T24gMy8yNC8yNSAwMzoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgY3VycmVudCBo
ZWxwZXIuaCBmdW5jdGlvbnMgcmVseSBvbiBoYXJkIGNvZGVkIGFzc3VtcHRpb25zIGFib3V0
DQo+IHRhcmdldCBlbmRpYW5lc3MgdG8gdXNlIHRoZSB0c3dhcCBtYWNyb3MuIFdlIGFsc28g
ZW5kIHVwIGRvdWJsZQ0KPiBzd2FwcGluZyBhIGJ1bmNoIG9mIHZhbHVlcyBpZiB0aGUgdGFy
Z2V0IGNhbiBydW4gaW4gbXVsdGlwbGUgZW5kaWFuZXNzDQo+IG1vZGVzLiBBdm9pZCB0aGlz
IGJ5IGdldHRpbmcgdGhlIHRhcmdldCB0byBwYXNzIHRoZSBlbmRpYW5lc3MgYW5kIHNpemUN
Cj4gdmlhIGEgTWVtT3AgYW5kIGZpeGluZyB1cCBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8u
b3JnPg0KPiANCj4gLS0tDQo+IHYyDQo+ICAgIC0gdXNlIHVuc2lnbmVkIGNvbnNpc3RlbnRs
eQ0KPiAgICAtIGZpeCBzb21lIHJvdWdlIHdoaXRlc3BhY2UNCj4gICAgLSBhZGQgdHlwZWQg
cmVnMzIvNjQgd3JhcHBlcnMNCj4gICAgLSBwYXNzIHZvaWQgKiB0byB1bmRlcmx5aW5nIGhl
bHBlciB0byBhdm9pZCBjYXN0aW5nDQo+IC0tLQ0KPiAgIGluY2x1ZGUvZ2Ric3R1Yi9yZWdp
c3RlcnMuaCB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4g
ICBnZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrDQo+
ICAgMiBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGluY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPiANCj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaCBiL2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3Rl
cnMuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwLi4yMjIw
ZjU4ZWZlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvaW5jbHVkZS9nZGJzdHViL3JlZ2lz
dGVycy5oDQo+IEBAIC0wLDAgKzEsNTUgQEANCj4gKy8qDQo+ICsgKiBHREIgQ29tbW9uIFJl
Z2lzdGVyIEhlbHBlcnMNCj4gKyAqDQo+ICsgKiBDb3B5cmlnaHQgKGMpIDIwMjUgTGluYXJv
IEx0ZA0KPiArICoNCj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9y
LWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBHREJfUkVHSVNURVJTX0gNCj4gKyNk
ZWZpbmUgR0RCX1JFR0lTVEVSU19IDQo+ICsNCj4gKyNpbmNsdWRlICJleGVjL21lbW9wLmgi
DQo+ICsNCj4gKy8qKg0KPiArICogZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpIC0gZ2V0IHJl
Z2lzdGVyIHZhbHVlIGZvciBnZGINCj4gKyAqIG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3AN
Cj4gKyAqIGJ1ZjogR0J5dGVBcnJheSB0byBzdG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAq
IHZhbDogcG9pbnRlciB0byB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+ICsgKg0KPiArICogVGhp
cyByZXBsYWNlcyB0aGUgcHJldmlvdXMgbGVnYWN5IHJlYWQgZnVuY3Rpb25zIHdpdGggYSBz
aW5nbGUNCj4gKyAqIGZ1bmN0aW9uIHRvIGhhbmRsZSBhbGwgc2l6ZXMuIFBhc3NpbmcgQG1v
IGFsbG93cyB0aGUgdGFyZ2V0IG1vZGUgdG8NCj4gKyAqIGJlIHRha2VuIGludG8gYWNjb3Vu
dCBhbmQgYXZvaWRzIHVzaW5nIGhhcmQgY29kZWQgdHN3YXAoKSBtYWNyb3MuDQo+ICsgKg0K
PiArICogVGhlcmUgYXJlIHdyYXBwZXIgZnVuY3Rpb25zIGZvciB0aGUgY29tbW9uIHNpemVz
IHlvdSBjYW4gdXNlIHRvDQo+ICsgKiBrZWVwIHR5cGUgY2hlY2tpbmcuDQo+ICsgKg0KPiAr
ICogUmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gdG8gdGhlIGFycmF5Lg0K
PiArICovDQo+ICtpbnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwgR0J5dGVB
cnJheSAqYnVmLCB2b2lkICp2YWwpOw0KPiArDQoNCkNvdWxkIGl0IGJlIG1hZGUgc3RhdGlj
LCBzbyBpdCdzIGhpZGRlbiBmcm9tIHRoZSBwdWJsaWMgaW50ZXJmYWNlPw0KWW91J2xsIG5l
ZWQgdG8gdW4taW5saW5lIGdkYl9nZXRfcmVnKl92YWx1ZSBmdW5jdGlvbnMuIEkgZG91YnQg
aXQncyANCnBlcmZvcm1hbmNlIGNyaXRpY2FsIGFuZCBuZWVkIHRvIGJlIGlubGluZS4NCg0K
PiArLyoqDQo+ICsgKiBnZGJfZ2V0X3JlZzMyX3ZhbHVlKCkgLSB0eXBlIGNoZWNrZWQgd3Jh
cHBlciBmb3IgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpDQo+ICsgKiBtbzogc2l6ZSBhbmQg
ZW5kaWFuIE1lbU9wDQo+ICsgKiBidWY6IEdCeXRlQXJyYXkgdG8gc3RvcmUgaW4gdGFyZ2V0
IG9yZGVyDQo+ICsgKiB2YWw6IHBvaW50ZXIgdG8gdWludDMyX3QgdmFsdWUgaW4gaG9zdCBv
cmRlcg0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIGludCBnZGJfZ2V0X3JlZzMyX3ZhbHVl
KE1lbU9wIG9wLCBHQnl0ZUFycmF5ICpidWYsIHVpbnQzMl90ICp2YWwpIHsNCj4gKyAgICBn
X2Fzc2VydCgob3AgJiBNT19TSVpFKSA9PSBNT18zMik7DQo+ICsgICAgcmV0dXJuIGdkYl9n
ZXRfcmVnaXN0ZXJfdmFsdWUob3AsIGJ1ZiwgdmFsKTsNCj4gK30NCj4gKw0KPiArLyoqDQo+
ICsgKiBnZGJfZ2V0X3JlZzY0X3ZhbHVlKCkgLSB0eXBlIGNoZWNrZWQgd3JhcHBlciBmb3Ig
Z2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpDQo+ICsgKiBtbzogc2l6ZSBhbmQgZW5kaWFuIE1l
bU9wDQo+ICsgKiBidWY6IEdCeXRlQXJyYXkgdG8gc3RvcmUgaW4gdGFyZ2V0IG9yZGVyDQo+
ICsgKiB2YWw6IHBvaW50ZXIgdG8gdWludDMyX3QgdmFsdWUgaW4gaG9zdCBvcmRlcg0KPiAr
ICovDQo+ICtzdGF0aWMgaW5saW5lIGludCBnZGJfZ2V0X3JlZzY0X3ZhbHVlKE1lbU9wIG9w
LCBHQnl0ZUFycmF5ICpidWYsIHVpbnQ2NF90ICp2YWwpIHsNCj4gKyAgICBnX2Fzc2VydCgo
b3AgJiBNT19TSVpFKSA9PSBNT182NCk7DQo+ICsgICAgcmV0dXJuIGdkYl9nZXRfcmVnaXN0
ZXJfdmFsdWUob3AsIGJ1ZiwgdmFsKTsNCj4gK30NCj4gKw0KPiArI2VuZGlmIC8qIEdEQl9S
RUdJU1RFUlNfSCAqLw0KPiArDQo+ICsNCj4gZGlmZiAtLWdpdCBhL2dkYnN0dWIvZ2Ric3R1
Yi5jIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4gaW5kZXggYjZkNWUxMWUwMy4uZTc5OWZkYzAx
OSAxMDA2NDQNCj4gLS0tIGEvZ2Ric3R1Yi9nZGJzdHViLmMNCj4gKysrIGIvZ2Ric3R1Yi9n
ZGJzdHViLmMNCj4gQEAgLTMyLDYgKzMyLDcgQEANCj4gICAjaW5jbHVkZSAiZXhlYy9nZGJz
dHViLmgiDQo+ICAgI2luY2x1ZGUgImdkYnN0dWIvY29tbWFuZHMuaCINCj4gICAjaW5jbHVk
ZSAiZ2Ric3R1Yi9zeXNjYWxscy5oIg0KPiArI2luY2x1ZGUgImdkYnN0dWIvcmVnaXN0ZXJz
LmgiDQo+ICAgI2lmZGVmIENPTkZJR19VU0VSX09OTFkNCj4gICAjaW5jbHVkZSAiYWNjZWwv
dGNnL3ZjcHUtc3RhdGUuaCINCj4gICAjaW5jbHVkZSAiZ2Ric3R1Yi91c2VyLmgiDQo+IEBA
IC00NSw2ICs0Niw3IEBADQo+ICAgI2luY2x1ZGUgInN5c3RlbS9ydW5zdGF0ZS5oIg0KPiAg
ICNpbmNsdWRlICJleGVjL3JlcGxheS1jb3JlLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvaHdh
ZGRyLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9tZW1vcC5oIg0KPiAgIA0KPiAgICNpbmNsdWRl
ICJpbnRlcm5hbHMuaCINCj4gICANCj4gQEAgLTU1MSw2ICs1NTMsMjcgQEAgc3RhdGljIGlu
dCBnZGJfd3JpdGVfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNwdSwgdWludDhfdCAqbWVtX2J1Ziwg
aW50IHJlZykNCj4gICAgICAgcmV0dXJuIDA7DQo+ICAgfQ0KPiAgIA0KPiArLyoNCj4gKyAq
IFRhcmdldCBoZWxwZXIgZnVuY3Rpb24gdG8gcmVhZCB2YWx1ZSBpbnRvIEdCeXRlQXJyYXks
IHRhcmdldA0KPiArICogc3VwcGxpZXMgdGhlIHNpemUgYW5kIHRhcmdldCBlbmRpYW5lc3Mg
dmlhIHRoZSBNZW1PcC4NCj4gKyAqLw0KPiAraW50IGdkYl9nZXRfcmVnaXN0ZXJfdmFsdWUo
TWVtT3Agb3AsIEdCeXRlQXJyYXkgKmJ1Ziwgdm9pZCAqdmFsKQ0KPiArew0KPiArICAgIHVu
c2lnbmVkIGJ5dGVzID0gbWVtb3Bfc2l6ZShvcCk7DQo+ICsNCj4gKyAgICBpZiAob3AgJiBN
T19CU1dBUCkgew0KPiArICAgICAgICB1aW50OF90ICpwdHIgPSAmKCh1aW50OF90ICopIHZh
bClbYnl0ZXMgLSAxXTsNCj4gKyAgICAgICAgZm9yICh1bnNpZ25lZCBpID0gYnl0ZXM7IGkg
PiAwOyBpLS0pIHsNCj4gKyAgICAgICAgICAgIGdfYnl0ZV9hcnJheV9hcHBlbmQoYnVmLCBw
dHItLSwgMSk7DQo+ICsgICAgICAgIH07DQo+ICsgICAgfSBlbHNlIHsNCj4gKyAgICAgICAg
Z19ieXRlX2FycmF5X2FwcGVuZChidWYsIHZhbCwgYnl0ZXMpOw0KPiArICAgIH0NCj4gKw0K
PiArICAgIHJldHVybiBieXRlczsNCj4gK30NCj4gKw0KPiArDQo+ICAgc3RhdGljIHZvaWQg
Z2RiX3JlZ2lzdGVyX2ZlYXR1cmUoQ1BVU3RhdGUgKmNwdSwgaW50IGJhc2VfcmVnLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdkYl9nZXRfcmVnX2NiIGdldF9y
ZWcsIGdkYl9zZXRfcmVnX2NiIHNldF9yZWcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgY29uc3QgR0RCRmVhdHVyZSAqZmVhdHVyZSkNCg0K

