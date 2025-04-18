Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A37C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 03:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5c3f-0004TZ-RP; Thu, 17 Apr 2025 23:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5c3e-0004TM-EY
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:06:26 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5c3X-0001WJ-1O
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:06:26 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-226185948ffso16471275ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744945577; x=1745550377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hb6quvPpMwY60xZnW8sNupoJsxlHePRt7L5pv+P8His=;
 b=ojr8SPq28I+z7WpCg/bOsUR9LOwRnYHgG4wRTcL+zBXuE+Kh9VhURfQ0L7lOxr/cQ0
 jMlvUCcQDLtUM7uwEQIjhv6nWXRGrsEhEN0fAkBvQ/D1zfgpYbL0WVxin2RTX0Kcfwh7
 vGlKjEZWWSzCNbfHjdYrbhJKoJWCRJhEcOhCryVfsjQ3oz+F69N2P4lb5iAuver+mphu
 5f1UC81VhgcTfADrH+q1vdi4XY47gRP3K6K3sHa0gRCjGbnjOnkw8JQ+RlRZ/tNVqxzu
 eKdfMO6tijyRj0nKyHITwCKdS1eww9HzkD+LRk9MJjeCkfWodrti7BOD7TJgX2mx4XVf
 QoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744945577; x=1745550377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hb6quvPpMwY60xZnW8sNupoJsxlHePRt7L5pv+P8His=;
 b=g+nJQkUAPup/dE7zy/jWt+BwlYfIflk8QbZb2X/xwTIyqwRJh4lt8WGZHR8t1KeFUo
 /gNf748BtLrOGAfiFRCH+bBciyLHRVwxq2//j2+mKs4V7suUA7pEjUcJK0aqvSXkORh8
 TA7A4Q1Uxm0MzXUu8DCfl21MHnaJ2n3eDvApgBH4x0xYO5h+xjc1LNPaLOvNx0A3hwLH
 5XZQWcEvM7DZRwmB1Y623XOtuyFHbkdirbrMAet3B2mymWt2i9/a9xeCzPJcDIyD6+3f
 FKwGfUE7QL8hW+eDSYbqt+KNs47/6dkzwngkDmi8lYAOEtYBfMlsddsJdBxr30HX3z1B
 CFcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlaDzIW0cuPYYPcXRyro8WNRgyANVdcA/bW58cCUyG5SCCamZ/5VdatpL/WPoAwsuJVDR3t+HgushV@nongnu.org
X-Gm-Message-State: AOJu0Yy0nsN8k8bIMJrO+52THvNFO+ZnJdWNlI3F5myP4m8VcyxpVLFj
 6Ony7+6bt/pztcEZaN9EdLhp6rUs028w7g4uO/45bpD4taIzbzg3I/a1oeeY3VbLa3kv59PtRcE
 g
X-Gm-Gg: ASbGncusTQDn5n+Rjy2d+NnI+03eK1lE2yFcKfMj2M5GBiVYO0nCNO2c3eWf/ExogGi
 Pb+mzviZ1EGAn8KeGGZ0jrSq4ien6ZW/zLfR3rT1q4oI7+2X3k7NBoQ86qGOZEvPmSGnjAbWoyi
 oCgpLP/hksDt72VU2DvT6Ps9LR+jGr+mlZvPRtc2Ed1p7exUlsiPMDDwNus8BElVcCFtVzmBPCd
 WuE4V0nRZ4FirGf5bo3I/+sjry7+0S4tT8LPRsJxA+T9xmyiHWj6qmXlone9CFeN5LVP3GGsd3F
 Q9YLeiqP587cf3WEeon84ScYeUP73Zq4UB47ruWXvOfqgC4PyXQUcA==
X-Google-Smtp-Source: AGHT+IFFgaGwQmnSOPV/bRQ1JRmQORb1SfXdr+VaWwzv64LZfybpQqb18P5az72N7SWWa1ZfB+JqOA==
X-Received: by 2002:a17:903:1a24:b0:223:47d9:1964 with SMTP id
 d9443c01a7336-22c53607709mr21020885ad.34.1744945577128; 
 Thu, 17 Apr 2025 20:06:17 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdac04sm7845845ad.32.2025.04.17.20.06.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 20:06:16 -0700 (PDT)
Message-ID: <fc3312bf-2a79-405a-bed9-72078cd7e5f2@linaro.org>
Date: Thu, 17 Apr 2025 20:06:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/11] system/vl: Filter machine list available for
 a particular target binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEJp
bmFyaWVzIGNhbiByZWdpc3RlciBhIFFPTSB0eXBlIHRvIGZpbHRlciB0aGVpciBtYWNoaW5l
cw0KPiBieSBmaWxsaW5nIHRoZWlyIFRhcmdldEluZm86Om1hY2hpbmVfdHlwZW5hbWUgZmll
bGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhp
bG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1p
bXBsLmggfCAgMyArKysNCj4gICBpbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaCAgICAgIHwg
IDggKysrKysrKysNCj4gICBzeXN0ZW0vdmwuYyAgICAgICAgICAgICAgICAgICAgIHwgMTQg
KysrKysrKysrKysrKysNCj4gICB0YXJnZXRfaW5mby5jICAgICAgICAgICAgICAgICAgIHwg
IDUgKysrKysNCj4gICA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8taW1wbC5oIGIvaW5jbHVk
ZS9xZW11L3RhcmdldF9pbmZvLWltcGwuaA0KPiBpbmRleCBkNWM5NGVkNTI5Ni4uOTkwZmIw
NjdkMjAgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby1pbXBsLmgN
Cj4gKysrIGIvaW5jbHVkZS9xZW11L3RhcmdldF9pbmZvLWltcGwuaA0KPiBAQCAtMTYsNiAr
MTYsOSBAQCB0eXBlZGVmIHN0cnVjdCBUYXJnZXRJbmZvIHsNCj4gICAgICAgLyogcnVudGlt
ZSBlcXVpdmFsZW50IG9mIFRBUkdFVF9OQU1FIGRlZmluaXRpb24gKi8NCj4gICAgICAgY29u
c3QgY2hhciAqY29uc3QgbmFtZTsNCj4gICANCj4gKyAgICAvKiBRT00gdHlwZW5hbWUgbWFj
aGluZXMgZm9yIHRoaXMgYmluYXJ5IG11c3QgaW1wbGVtZW50ICovDQo+ICsgICAgY29uc3Qg
Y2hhciAqY29uc3QgbWFjaGluZV90eXBlbmFtZTsNCj4gKw0KPiAgIH0gVGFyZ2V0SW5mbzsN
Cj4gICANCj4gICBjb25zdCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2b2lkKTsNCj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvcWVtdS90YXJnZXRfaW5mby5oIGIvaW5jbHVkZS9xZW11L3Rh
cmdldF9pbmZvLmgNCj4gaW5kZXggM2Y2Y2JiYmQzMDAuLmU5ZmQyZmRkN2IwIDEwMDY0NA0K
PiAtLS0gYS9pbmNsdWRlL3FlbXUvdGFyZ2V0X2luZm8uaA0KPiArKysgYi9pbmNsdWRlL3Fl
bXUvdGFyZ2V0X2luZm8uaA0KPiBAQCAtMTYsNCArMTYsMTIgQEANCj4gICAgKi8NCj4gICBj
b25zdCBjaGFyICp0YXJnZXRfbmFtZSh2b2lkKTsNCj4gICANCj4gKy8qKg0KPiArICogdGFy
Z2V0X21hY2hpbmVfaW50ZXJmYWNlX3R5cGVuYW1lOg0KPiArICoNCj4gKyAqIFJldHVybnM6
IE5hbWUgb2YgdGhlIFFPTSBpbnRlcmZhY2UgaW1wbGVtZW50ZWQgYnkgbWFjaGluZXMNCj4g
KyAqICAgICAgICAgIHVzYWJsZSBvbiB0aGlzIHRhcmdldCBiaW5hcnkuDQo+ICsgKi8NCj4g
K2NvbnN0IGNoYXIgKnRhcmdldF9tYWNoaW5lX2ludGVyZmFjZV90eXBlbmFtZSh2b2lkKTsN
Cj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3ZsLmMgYi9zeXN0ZW0v
dmwuYw0KPiBpbmRleCBkOGEwZmU3MTNjOS4uNGU0M2U1NWFmZTcgMTAwNjQ0DQo+IC0tLSBh
L3N5c3RlbS92bC5jDQo+ICsrKyBiL3N5c3RlbS92bC5jDQo+IEBAIC0yNyw2ICsyNyw3IEBA
DQo+ICAgI2luY2x1ZGUgInFlbXUvZGF0YWRpci5oIg0KPiAgICNpbmNsdWRlICJxZW11L3Vu
aXRzLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+ICsjaW5jbHVkZSAicWVt
dS90YXJnZXRfaW5mby5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24uaCINCj4g
ICAjaW5jbHVkZSAiZXhlYy9wYWdlLXZhcnkuaCINCj4gICAjaW5jbHVkZSAiaHcvcWRldi1w
cm9wZXJ0aWVzLmgiDQo+IEBAIC04MzYsMTEgKzgzNywxNyBAQCBzdGF0aWMgYm9vbCB1c2Jf
cGFyc2UoY29uc3QgY2hhciAqY21kbGluZSwgRXJyb3IgKiplcnJwKQ0KPiAgIHN0YXRpYyBN
YWNoaW5lQ2xhc3MgKmZpbmRfbWFjaGluZShjb25zdCBjaGFyICpuYW1lLCBHU0xpc3QgKm1h
Y2hpbmVzKQ0KPiAgIHsNCj4gICAgICAgR1NMaXN0ICplbDsNCj4gKyAgICBjb25zdCBjaGFy
ICpxb21fdHlwZW5hbWVfZmlsdGVyID0gdGFyZ2V0X21hY2hpbmVfaW50ZXJmYWNlX3R5cGVu
YW1lKCk7DQo+ICAgDQo+ICAgICAgIGZvciAoZWwgPSBtYWNoaW5lczsgZWw7IGVsID0gZWwt
Pm5leHQpIHsNCj4gICAgICAgICAgIE1hY2hpbmVDbGFzcyAqbWMgPSBlbC0+ZGF0YTsNCj4g
ICANCj4gICAgICAgICAgIGlmICghc3RyY21wKG1jLT5uYW1lLCBuYW1lKSB8fCAhZ19zdHJj
bXAwKG1jLT5hbGlhcywgbmFtZSkpIHsNCj4gKyAgICAgICAgICAgIGlmIChxb21fdHlwZW5h
bWVfZmlsdGVyDQo+ICsgICAgICAgICAgICAgICAgJiYgIW9iamVjdF9jbGFzc19keW5hbWlj
X2Nhc3QoZWwtPmRhdGEsIHFvbV90eXBlbmFtZV9maWx0ZXIpKSB7DQo+ICsgICAgICAgICAg
ICAgICAgLyogTWFjaGluZSBpcyBub3QgZm9yIHRoaXMgYmluYXJ5OiBmYWlsICovDQo+ICsg
ICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7DQo+ICsgICAgICAgICAgICB9DQo+ICAgICAg
ICAgICAgICAgcmV0dXJuIG1jOw0KPiAgICAgICAgICAgfQ0KPiAgICAgICB9DQo+IEBAIC0x
NTYzLDYgKzE1NzAsNyBAQCBzdGF0aWMgdm9pZCBtYWNoaW5lX2hlbHBfZnVuYyhjb25zdCBR
RGljdCAqcWRpY3QpDQo+ICAgICAgIGdfYXV0b3B0cihHU0xpc3QpIG1hY2hpbmVzID0gTlVM
TDsNCj4gICAgICAgR1NMaXN0ICplbDsNCj4gICAgICAgY29uc3QgY2hhciAqdHlwZSA9IHFk
aWN0X2dldF90cnlfc3RyKHFkaWN0LCAidHlwZSIpOw0KPiArICAgIGNvbnN0IGNoYXIgKnFv
bV90eXBlbmFtZV9maWx0ZXIgPSB0YXJnZXRfbWFjaGluZV9pbnRlcmZhY2VfdHlwZW5hbWUo
KTsNCj4gICANCj4gICAgICAgbWFjaGluZXMgPSBvYmplY3RfY2xhc3NfZ2V0X2xpc3QoVFlQ
RV9NQUNISU5FLCBmYWxzZSk7DQoNCldlIGNhbiByZXBsYWNlIGNoYW5nZSB0byBzeXN0ZW0v
dmwuYyB3aXRoOg0KDQpjb25zdCBjaGFyICptYWNoaW5lX3R5cGUgPSB0YXJnZXRfbWFjaGlu
ZV9pbnRlcmZhY2VfdHlwZW5hbWUoKTsNCm1hY2hpbmVzID0gb2JqZWN0X2NsYXNzX2dldF9s
aXN0KG1hY2hpbmVfdHlwZSwgZmFsc2UpOw0KDQo+ICAgICAgIGlmICh0eXBlKSB7DQo+IEBA
IC0xNTc3LDYgKzE1ODUsMTIgQEAgc3RhdGljIHZvaWQgbWFjaGluZV9oZWxwX2Z1bmMoY29u
c3QgUURpY3QgKnFkaWN0KQ0KPiAgICAgICBtYWNoaW5lcyA9IGdfc2xpc3Rfc29ydChtYWNo
aW5lcywgbWFjaGluZV9jbGFzc19jbXApOw0KPiAgICAgICBmb3IgKGVsID0gbWFjaGluZXM7
IGVsOyBlbCA9IGVsLT5uZXh0KSB7DQo+ICAgICAgICAgICBNYWNoaW5lQ2xhc3MgKm1jID0g
ZWwtPmRhdGE7DQo+ICsNCj4gKyAgICAgICAgaWYgKHFvbV90eXBlbmFtZV9maWx0ZXINCj4g
KyAgICAgICAgICAgICYmICFvYmplY3RfY2xhc3NfZHluYW1pY19jYXN0KGVsLT5kYXRhLCBx
b21fdHlwZW5hbWVfZmlsdGVyKSkgew0KPiArICAgICAgICAgICAgLyogTWFjaGluZSBpcyBu
b3QgZm9yIHRoaXMgYmluYXJ5OiBza2lwICovDQo+ICsgICAgICAgICAgICBjb250aW51ZTsN
Cj4gKyAgICAgICAgfQ0KPiAgICAgICAgICAgaWYgKG1jLT5hbGlhcykgew0KPiAgICAgICAg
ICAgICAgIHByaW50ZigiJS0yMHMgJXMgKGFsaWFzIG9mICVzKVxuIiwgbWMtPmFsaWFzLCBt
Yy0+ZGVzYywgbWMtPm5hbWUpOw0KPiAgICAgICAgICAgfQ0KPiBkaWZmIC0tZ2l0IGEvdGFy
Z2V0X2luZm8uYyBiL3RhcmdldF9pbmZvLmMNCj4gaW5kZXggODc3YTZhMTUwMTQuLjIyNmVl
ZDFmZDdkIDEwMDY0NA0KPiAtLS0gYS90YXJnZXRfaW5mby5jDQo+ICsrKyBiL3RhcmdldF9p
bmZvLmMNCj4gQEAgLTE0LDMgKzE0LDggQEAgY29uc3QgY2hhciAqdGFyZ2V0X25hbWUodm9p
ZCkNCj4gICB7DQo+ICAgICAgIHJldHVybiB0YXJnZXRfaW5mbygpLT5uYW1lOw0KPiAgIH0N
Cj4gKw0KPiArY29uc3QgY2hhciAqdGFyZ2V0X21hY2hpbmVfaW50ZXJmYWNlX3R5cGVuYW1l
KHZvaWQpDQo+ICt7DQo+ICsgICAgcmV0dXJuIHRhcmdldF9pbmZvKCktPm1hY2hpbmVfdHlw
ZW5hbWU7DQoNCkFuZCBoZXJlOg0KDQpjb25zdCBjaGFyICptYWNoaW5lX3R5cGUgPSB0YXJn
ZXRfaW5mbygpLT5tYWNoaW5lX3R5cGVuYW1lOw0KaWYgKCFtYWNoaW5lX3R5cGUpIHsNCglt
YWNoaW5lX3R5cGUgPSBUWVBFX01BQ0hJTkU7DQp9DQpyZXR1cm4gbWFjaGluZV90eXBlOw0K
DQo+ICt9DQoNClRoaXMgd2F5LCB0aGVyZSBpcyBubyBzcGVjaWFsIGNhc2UgdG8gaGFuZGxl
IGFueXdoZXJlLCBhbmQgd2UgY2FuIHNhZmVseSANCnJlcGxhY2Ugb2NjdXJyZW5jZXMgb2Yg
VFlQRV9NQUNISU5FIHF1ZXJpZXMgd2l0aCANCnRhcmdldF9tYWNoaW5lX2ludGVyZmFjZV90
eXBlbmFtZSgpLg0KDQpBcyB3ZWxsLCBqdXN0IGEgbml0LCBidXQgaXQncyBub3QgaW1wb3J0
YW50IHRvIGtub3cgaXQncyBhbiBpbnRlcmZhY2UsIEkgDQp3b3VsZCBwcmVmZXIgYSBzaW1w
bGVyIG5hbWU6IHRhcmdldF9tYWNoaW5lX3R5cGUoKTsNCg==

