Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0802C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 16:51:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tprxX-0006Q0-4S; Wed, 05 Mar 2025 11:51:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tprxV-0006Ol-2W
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:51:01 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tprxT-0005gM-7Y
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 11:51:00 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff087762bbso5868824a91.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 08:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741193457; x=1741798257; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xeT3l/cI6dYhk6CCWxAR99Ty24erewOyRJArRv3oOMI=;
 b=JBr3XNVPFbbnVy/K+CZZ8NVmFJUGS8lvu/rY+HnxaPkI4ux9oU7OP3t1xAfv2aXPdG
 VRkyZkAnQ/QXniAaYAIrBJ2SUurQGUd1PNUlLYySxjvc0U3eTLLoOrJmbt0Y/p+MGjQi
 mdmMKC38s9jtnahSwPYBqEcA6XZ3vcL47WeOSaIj/LQ7P/MnB30X8TpYiGBkSh+skGAW
 ZdMAZyE7x74QFaHV+S5ZKzTDFr9sQcf0wFvOB5uUlK+NLQTJd+SGm3qG0h2pm2OTgopP
 uNiBmLICZ2njNwd8hRD65gmE0sSnOyzOTW0YzlcVWlxAuVr9DsHGJV2GGJKvjUHXjZFJ
 1N0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741193457; x=1741798257;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xeT3l/cI6dYhk6CCWxAR99Ty24erewOyRJArRv3oOMI=;
 b=iPj4YSgSfqm70OD63kWBWSfntB8baC079er1BrV+VBCQTXaxCzQOJbllaeqiAT+g+O
 akJ4EXrtiN/r3nRDszvwkDYwmJZZqmBYHmHpqpI1iKBzDlzTAEOpgd7UFwnNSqvA/lW+
 sV+s2LfbuyLMSi5RwXg3zTnAFvnqcePy8/CWy9mNCCe+0UB+Z+ntS2EBNwRDAUYgqeKJ
 5IFW6RR0ol4MbacCupSWbyDuEWTqjcqUxfrIGQ9xL0lrjZkxbYqeqiaJmIcaICKTbRox
 PzTfddK4c5OOpp4NZRHb5L5ay0S7qc8jo7hoqZXRG8cgfxXwtimSLVTNPNIbzqc2SlQi
 hBMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzi9hTRwkCqacEiTL16VFbIaoT5v2wfEaJONMUBwk2JFWabdOeMQwXI05RRQAIObRWnN3+qiDRDLsF@nongnu.org
X-Gm-Message-State: AOJu0YwvCh2n2pGYSipZ5VFDA/ervzlsHXC6WBJlZvHDD/Wn4BEeOwN9
 wgyAbVIzbsvMzszo53PPynvEJ5K/XZ9jyh/G6Rzi14fWDSbQ+3dvrcgrZJy7M6I=
X-Gm-Gg: ASbGncue4lxbofSeeI6YHe+C1Slhw8kq5C2vCh4/bIL6AERWV4wG8zykwekBUsXZQP8
 YV07t02IqUAwZaAF53WCJGzl3BqxDYtgoYORgDNL9SWz2vcu1TP+HZMTPUz7hOwEoUUBLxw3Fk0
 kbmVBRxxzIxajk9Wcr4/xP9roeRYiBhsXWTmK1sSwovx2klADxoFOVxboPzMA5kk6AW89pVBArC
 tc/mFTLI16dSXHdIrWUAEl74+4DRx+i7lu8W8MMThRTL5dYbqHQiyGsrnRrixHgYuGif3LXX8Aq
 Lz6xq7pVgLlZXYHd2ECVsY5DFlPkgRO3T2PSqkuIJLPQNkmjK6RjSnMvlw==
X-Google-Smtp-Source: AGHT+IGRuXzFQV5pln0jUWmCxuqDp+LEAu9oAFQQ+G/hbWQPwQvqx2wLBnx8nePa/B8GokbSf9yaCg==
X-Received: by 2002:a17:90b:390f:b0:2fe:b016:a6a1 with SMTP id
 98e67ed59e1d1-2ff497fec8fmr6416674a91.29.1741193457592; 
 Wed, 05 Mar 2025 08:50:57 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm1570256a91.12.2025.03.05.08.50.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 08:50:57 -0800 (PST)
Message-ID: <391c4a7d-8dae-497b-b5f4-975d41b3252a@linaro.org>
Date: Wed, 5 Mar 2025 08:50:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/4] hw/arm/raspi: Replace TARGET_AARCH64 by
 legacy_binary_is_64bit()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305161248.54901-1-philmd@linaro.org>
 <20250305161248.54901-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305161248.54901-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102c.google.com
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

T24gMy81LzI1IDA4OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gRm9y
IGxlZ2FjeSBBUk0gYmluYXJpZXMsIGxlZ2FjeV9iaW5hcnlfaXNfNjRiaXQoKSBpcw0KPiBl
cXVpdmFsZW50IG9mIHRoZSBjb21waWxlIHRpbWUgVEFSR0VUX0FBUkNINjQgZGVmaW5pdGlv
bi4NCj4gDQoNCkknbSBub3Qgc3VyZSB3aGVyZSB0aGlzIGZ1bmN0aW9uIGNvbWVzIGZyb20u
DQoNCkFueXdheSwgdG8gY29tcGxldGVseSByZXBsYWNlIFRBUkdFVF9BQVJDSDY0LCB3aGF0
IHdlIHdhbnQgaXMgc29tZXRoaW5nIA0KbGlrZTogdGFyZ2V0X2lzX2FhcmNoNjQoKSwgYmVj
YXVzZSBhbGwgdGhlIG9iamVjdHMgaW4gdGhpcyBmaWxlIHNob3VsZCANCm5vdCBiZSBlbmFi
bGVkIGZvciA2NCBiaXRzIHRhcmdldHMgd2hvIGFyZSBub3QgYXJtIGJhc2VkLg0KDQpTbyBp
dCdzIG1vcmUgZWFzeSB0byBpbnRyb2R1Y2UgYSBzcGVjaWZpYyBmdW5jdGlvbiAqcGVyKiB0
YXJnZXQsIGFuZCANCmVuYWJsZSBvYmplY3RzIG9uIGEgcGVyIG5lZWQgYmFzaXMuIFNvbWUg
d2lsbCBiZSBlbmFibGVkIGZvciBhbGwgDQp0YXJnZXRzLCBzb21lIGZvciBvbmx5IG9uZSwg
c29tZSBmb3IgYSBzcGVjaWZpYyBzZWxlY3Rpb24uDQoNCj4gVXNlIGl0IGFzIFR5cGVJbmZv
OjpyZWdpc3RlcmFibGUoKSBjYWxsYmFjayB0byBkeW5hbWljYWxseQ0KPiBhZGQgQWFyY2g2
NCBzcGVjaWZpYyB0eXBlcyBpbiBxZW11LXN5c3RlbS1hYXJjaDY0IGJpbmFyeSwNCj4gcmVt
b3ZpbmcgdGhlIG5lZWQgb2YgVEFSR0VUX0FBUkNINjQgI2lmZGVmJ3J5Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBody9hcm0vYmNtMjgzNi5jIHwgNiArKy0tLS0NCj4gICBody9hcm0v
cmFzcGkuYyAgIHwgNyArKystLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvYXJtL2JjbTI4
MzYuYyBiL2h3L2FybS9iY20yODM2LmMNCj4gaW5kZXggOTVlMTY4MDZmYTEuLjg4YTMyZTVm
YzIwIDEwMDY0NA0KPiAtLS0gYS9ody9hcm0vYmNtMjgzNi5jDQo+ICsrKyBiL2h3L2FybS9i
Y20yODM2LmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICAjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIg0KPiAgICNpbmNsdWRlICJxYXBpL2Vycm9yLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUv
bW9kdWxlLmgiDQo+ICsjaW5jbHVkZSAicWVtdS9sZWdhY3lfYmluYXJ5X2luZm8uaCINCj4g
ICAjaW5jbHVkZSAiaHcvYXJtL2JjbTI4MzYuaCINCj4gICAjaW5jbHVkZSAiaHcvYXJtL3Jh
c3BpX3BsYXRmb3JtLmgiDQo+ICAgI2luY2x1ZGUgImh3L3N5c2J1cy5oIg0KPiBAQCAtMTk1
LDcgKzE5Niw2IEBAIHN0YXRpYyB2b2lkIGJjbTI4MzZfY2xhc3NfaW5pdChPYmplY3RDbGFz
cyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIGRjLT5yZWFsaXplID0gYmNtMjgzNl9yZWFs
aXplOw0KPiAgIH07DQo+ICAgDQo+IC0jaWZkZWYgVEFSR0VUX0FBUkNINjQNCj4gICBzdGF0
aWMgdm9pZCBiY20yODM3X2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRh
KQ0KPiAgIHsNCj4gICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKG9jKTsN
Cj4gQEAgLTIwOCw3ICsyMDgsNiBAQCBzdGF0aWMgdm9pZCBiY20yODM3X2NsYXNzX2luaXQo
T2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpkYXRhKQ0KPiAgICAgICBiYy0+Y2x1c3RlcmlkID0g
MHgwOw0KPiAgICAgICBkYy0+cmVhbGl6ZSA9IGJjbTI4MzZfcmVhbGl6ZTsNCj4gICB9Ow0K
PiAtI2VuZGlmDQo+ICAgDQo+ICAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIGJjbTI4M3hfdHlw
ZXNbXSA9IHsNCj4gICAgICAgew0KPiBAQCAtMjE5LDEyICsyMTgsMTEgQEAgc3RhdGljIGNv
bnN0IFR5cGVJbmZvIGJjbTI4M3hfdHlwZXNbXSA9IHsNCj4gICAgICAgICAgIC5uYW1lICAg
ICAgICAgICA9IFRZUEVfQkNNMjgzNiwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9
IFRZUEVfQkNNMjgzWCwNCj4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9IGJjbTI4MzZf
Y2xhc3NfaW5pdCwNCj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2NA0KPiAgICAgICB9LCB7DQo+
ICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSBUWVBFX0JDTTI4MzcsDQo+ICAgICAgICAg
ICAucGFyZW50ICAgICAgICAgPSBUWVBFX0JDTTI4M1gsDQo+ICsgICAgICAgIC5yZWdpc3Rl
cmFibGUgICA9IGxlZ2FjeV9iaW5hcnlfaXNfNjRiaXQsDQo+ICAgICAgICAgICAuY2xhc3Nf
aW5pdCAgICAgPSBiY20yODM3X2NsYXNzX2luaXQsDQo+IC0jZW5kaWYNCj4gICAgICAgfSwg
ew0KPiAgICAgICAgICAgLm5hbWUgICAgICAgICAgID0gVFlQRV9CQ00yODNYLA0KPiAgICAg
ICAgICAgLnBhcmVudCAgICAgICAgID0gVFlQRV9CQ00yODNYX0JBU0UsDQo+IGRpZmYgLS1n
aXQgYS9ody9hcm0vcmFzcGkuYyBiL2h3L2FybS9yYXNwaS5jDQo+IGluZGV4IGRjZTM1Y2Ex
MWFhLi5mN2U2NDdhOWNiZiAxMDA2NDQNCj4gLS0tIGEvaHcvYXJtL3Jhc3BpLmMNCj4gKysr
IGIvaHcvYXJtL3Jhc3BpLmMNCj4gQEAgLTE1LDYgKzE1LDcgQEANCj4gICAjaW5jbHVkZSAi
cWVtdS9vc2RlcC5oIg0KPiAgICNpbmNsdWRlICJxZW11L3VuaXRzLmgiDQo+ICAgI2luY2x1
ZGUgInFlbXUvY3V0aWxzLmgiDQo+ICsjaW5jbHVkZSAicWVtdS9sZWdhY3lfYmluYXJ5X2lu
Zm8uaCINCj4gICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAgICNpbmNsdWRlICJody9h
cm0vYm9vdC5oIg0KPiAgICNpbmNsdWRlICJody9hcm0vYmNtMjgzNi5oIg0KPiBAQCAtMzY3
LDcgKzM2OCw2IEBAIHN0YXRpYyB2b2lkIHJhc3BpMmJfbWFjaGluZV9jbGFzc19pbml0KE9i
amVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4gICAgICAgcmFzcGlfbWFjaGluZV9jbGFz
c19pbml0KG1jLCBybWMtPmJvYXJkX3Jldik7DQo+ICAgfTsNCj4gICANCj4gLSNpZmRlZiBU
QVJHRVRfQUFSQ0g2NA0KPiAgIHN0YXRpYyB2b2lkIHJhc3BpM2FwX21hY2hpbmVfY2xhc3Nf
aW5pdChPYmplY3RDbGFzcyAqb2MsIHZvaWQgKmRhdGEpDQo+ICAgew0KPiAgICAgICBNYWNo
aW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7DQo+IEBAIC0zODcsNyArMzg3LDYg
QEAgc3RhdGljIHZvaWQgcmFzcGkzYl9tYWNoaW5lX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3Mg
Km9jLCB2b2lkICpkYXRhKQ0KPiAgICAgICBybWMtPmJvYXJkX3JldiA9IDB4YTAyMDgyOw0K
PiAgICAgICByYXNwaV9tYWNoaW5lX2NsYXNzX2luaXQobWMsIHJtYy0+Ym9hcmRfcmV2KTsN
Cj4gICB9Ow0KPiAtI2VuZGlmIC8qIFRBUkdFVF9BQVJDSDY0ICovDQo+ICAgDQo+ICAgc3Rh
dGljIGNvbnN0IFR5cGVJbmZvIHJhc3BpX21hY2hpbmVfdHlwZXNbXSA9IHsNCj4gICAgICAg
ew0KPiBAQCAtNDAyLDE2ICs0MDEsMTYgQEAgc3RhdGljIGNvbnN0IFR5cGVJbmZvIHJhc3Bp
X21hY2hpbmVfdHlwZXNbXSA9IHsNCj4gICAgICAgICAgIC5uYW1lICAgICAgICAgICA9IE1B
Q0hJTkVfVFlQRV9OQU1FKCJyYXNwaTJiIiksDQo+ICAgICAgICAgICAucGFyZW50ICAgICAg
ICAgPSBUWVBFX1JBU1BJX01BQ0hJTkUsDQo+ICAgICAgICAgICAuY2xhc3NfaW5pdCAgICAg
PSByYXNwaTJiX21hY2hpbmVfY2xhc3NfaW5pdCwNCj4gLSNpZmRlZiBUQVJHRVRfQUFSQ0g2
NA0KPiAgICAgICB9LCB7DQo+ICAgICAgICAgICAubmFtZSAgICAgICAgICAgPSBNQUNISU5F
X1RZUEVfTkFNRSgicmFzcGkzYXAiKSwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9
IFRZUEVfUkFTUElfTUFDSElORSwNCj4gKyAgICAgICAgLnJlZ2lzdGVyYWJsZSAgID0gbGVn
YWN5X2JpbmFyeV9pc182NGJpdCwNCj4gICAgICAgICAgIC5jbGFzc19pbml0ICAgICA9IHJh
c3BpM2FwX21hY2hpbmVfY2xhc3NfaW5pdCwNCj4gICAgICAgfSwgew0KPiAgICAgICAgICAg
Lm5hbWUgICAgICAgICAgID0gTUFDSElORV9UWVBFX05BTUUoInJhc3BpM2IiKSwNCj4gICAg
ICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVfUkFTUElfTUFDSElORSwNCj4gKyAgICAg
ICAgLnJlZ2lzdGVyYWJsZSAgID0gbGVnYWN5X2JpbmFyeV9pc182NGJpdCwNCj4gICAgICAg
ICAgIC5jbGFzc19pbml0ICAgICA9IHJhc3BpM2JfbWFjaGluZV9jbGFzc19pbml0LA0KPiAt
I2VuZGlmDQo+ICAgICAgIH0sIHsNCj4gICAgICAgICAgIC5uYW1lICAgICAgICAgICA9IFRZ
UEVfUkFTUElfTUFDSElORSwNCj4gICAgICAgICAgIC5wYXJlbnQgICAgICAgICA9IFRZUEVf
UkFTUElfQkFTRV9NQUNISU5FLA0KDQo=

