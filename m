Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4B1FC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdQh-0006Qj-6e; Tue, 04 Mar 2025 20:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpdQe-0006Ot-4K
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:20:08 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tpdQb-0005Sh-Vt
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:20:07 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so12878933a91.1
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137604; x=1741742404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a08+CMVSkrVQqdjIQFbt+JNO3ZoRw2bzVW6YV0WXNfk=;
 b=FCfbBjfN6yM4GtJo4klqzd4B2nqoIJOamct6YFAds0qY7mUqDr6X46R9jKe8uyUWhT
 qhAPazJthA4iLaFH4stLsTY8vT/jhXCVOhStvzsyhpqLXfJoSrRwOK70Gh9P4aAYsa1K
 xeCAUlV4G+j0lVPj/HGvQKQwJNnbWXp5dHPWKswL74rU6hPmWllkAlzeLf2hG/pAY/6h
 af2K8Oo7LD/GHeCx4oExJVhTNuwSYK8CQJNKCL9DKa46+iEA5UaNWouOpvhwdzRjiUVC
 3T3MxMo6/hHRg/DaPojjVCuGO1qBRzPELWEMJ3DMIPEDPvrd05LtZSLz0TRwyfMVLoxJ
 TghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137604; x=1741742404;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a08+CMVSkrVQqdjIQFbt+JNO3ZoRw2bzVW6YV0WXNfk=;
 b=C4kdYyjqLMM+KX8uzJef6m2DEzM0PkSNy3/ZVDnlyOf1YTW6T7QRaWTMFGQ41r6cK9
 JqFer7r87tS+QRF5cyGqi+wpuYJ5oIXqipagR8pd0iqZ4w5+4c++Q2ZxlhY/YCp0DJJq
 2gV7ENpstYUlLoNX+31q4bjRhPTp1e8cIsFynLs7hRZDlQ+W6kkMPpYP1kxv1BLv0hpx
 hOFzxcvrMff/uRZz+zuN43t/AIbqLbuLUM7Ij7X6RkXAaO2a2pK/52M7BBXdQkRZUWg+
 VAm/t4NL0kESyTpgJywpt8Ub6F5SKkrZPMZELgoXY9JeeYSwXl1e48vPTQ9rz+P0RDlC
 Q9Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZXI0doLAKYn1ybfgsOMzpAoze9dFcDSHkcsJKLgBrUboWe/vR3eePnmtZLeAPGtdzfpZ8rmEkKaOT@nongnu.org
X-Gm-Message-State: AOJu0YwreZpX1ejEcPxrqOg0F01r4rwr9wN+N+m2UyWxiho4W9NrWSMo
 DEXUHTCCRQeAA3WzD1oMrOEZSD5rky3tLjmx3u7e6CYKUhcC83JpBCS8jbBWgqX4VGjWmzgjGtD
 G
X-Gm-Gg: ASbGncsgQQrOdAOm7zfY9T1yZf/+g1TH6HXxRaobQoOr9s8hjlTzLGxSWoPLJxvyhAl
 bcddYTaCk2R7dvKojeR13HZJG208YfB13za/EBe9y6KwmdkkGldIiQp1YTO8yEEVzeoi9CJwMJY
 vLEanLaOsa+AuwMkp8KGLpq8DNM4MVPjp4FA0oDGmyqUtluGykdqceKHn0qownmSdShxxtoWXrR
 F2KYbmB7p5eMEudKqzojfLlVHxYjNbKqq7ZPSzOTw1G7+TqOvaKrt9LFULrXANFYPWW86nPfLMs
 48YkvgorEu6oEhcHWIuks5npxVUPONZGw/XO9uowbQQwiYroYSjsUInfxg==
X-Google-Smtp-Source: AGHT+IFeU5qD5Hblf+R1eSpU/GEEsX+LrTdTqk5H7vrrlPMQXnRcPBU/sdlQeTbKbYhrntzUXy1r+w==
X-Received: by 2002:a17:90b:2d8f:b0:2ea:77d9:6345 with SMTP id
 98e67ed59e1d1-2ff497e3bbbmr1981693a91.22.1741137603902; 
 Tue, 04 Mar 2025 17:20:03 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e760dadsm104631a91.8.2025.03.04.17.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 17:20:03 -0800 (PST)
Message-ID: <539de40b-de27-4781-bcb0-46986fc2f28f@linaro.org>
Date: Tue, 4 Mar 2025 17:20:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 01/11] system: Extract target-specific globals to
 their own compilation unit
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305005225.95051-1-philmd@linaro.org>
 <20250305005225.95051-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305005225.95051-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

T24gMy80LzI1IDE2OjUyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gV2Ug
c2hvdWxkbid0IHVzZSB0YXJnZXQgc3BlY2lmaWMgZ2xvYmFscyBmb3IgbWFjaGluZSBwcm9w
ZXJ0aWVzLg0KPiBUaGVzZSBvbmVzIGNvdWxkIGJlIGRlc3VnYXJpemVkLCBhcyBleHBsYWlu
ZWQgaW4gWypdLiBXaGlsZQ0KPiBjZXJ0YWlubHkgZG9hYmxlLCBub3QgdHJpdmlhbCBub3Ig
bXkgcHJpb3JpdHkgZm9yIG5vdy4gSnVzdCBtb3ZlDQo+IHRoZW0gdG8gYSBkaWZmZXJlbnQg
ZmlsZSB0byBjbGFyaWZ5IHRoZXkgYXJlICpnbG9iYWxzKiwgbGlrZSB0aGUNCj4gZ2VuZXJp
YyBnbG9iYWxzIHJlc2lkaW5nIGluIHN5c3RlbS9nbG9iYWxzLmMuDQo+IA0KDQpNYXliZSB0
aG9zZSBjb3VsZCBiZSBzZXQgZ2xvYmFsbHkgdG8gdGhlIGRlZmF1bHQ6DQppbnQgZ3JhcGhp
Y193aWR0aCA9IDgwMDsNCmludCBncmFwaGljX2hlaWdodCA9IDYwMDsNCmludCBncmFwaGlj
X2RlcHRoID0gMzI7DQoNCkFuZCBvdmVycmlkZSB0aGVtIGZvciBzcGFyYyBhbmQgbTY4ayBp
biBxZW11X2luaXRfYXJjaF9tb2R1bGVzIGZ1bmN0aW9uLCANCnVzaW5nIHFlbXVfYXJjaF9u
YW1lKCkuDQpUaGlzIHdheSwgbm8gbmVlZCB0byBoYXZlIGEgbmV3IGZpbGUgdG8gaG9sZCB0
aGVtLg0KDQo+IFsqXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2U1MTRk
NmRiLTc4MWQtNGFmZS1iMDU3LTkwNDZjNzAwNDRkY0ByZWRoYXQuY29tLw0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBzeXN0ZW0vYXJjaF9pbml0LmMgICAgICB8IDE0IC0tLS0tLS0tLS0t
LS0tDQo+ICAgc3lzdGVtL2dsb2JhbHMtdGFyZ2V0LmMgfCAyNCArKysrKysrKysrKysrKysr
KysrKysrKysNCj4gICBzeXN0ZW0vbWVzb24uYnVpbGQgICAgICB8ICAxICsNCj4gICAzIGZp
bGVzIGNoYW5nZWQsIDI1IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQ0KPiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBzeXN0ZW0vZ2xvYmFscy10YXJnZXQuYw0KPiANCj4gZGlmZiAt
LWdpdCBhL3N5c3RlbS9hcmNoX2luaXQuYyBiL3N5c3RlbS9hcmNoX2luaXQuYw0KPiBpbmRl
eCBkMmMzMmY4NDg4Ny4uZWEwODQyYjc0MTAgMTAwNjQ0DQo+IC0tLSBhL3N5c3RlbS9hcmNo
X2luaXQuYw0KPiArKysgYi9zeXN0ZW0vYXJjaF9pbml0LmMNCj4gQEAgLTI1LDIwICsyNSw2
IEBADQo+ICAgI2luY2x1ZGUgInFlbXUvbW9kdWxlLmgiDQo+ICAgI2luY2x1ZGUgInN5c3Rl
bS9hcmNoX2luaXQuaCINCj4gICANCj4gLSNpZmRlZiBUQVJHRVRfU1BBUkMNCj4gLWludCBn
cmFwaGljX3dpZHRoID0gMTAyNDsNCj4gLWludCBncmFwaGljX2hlaWdodCA9IDc2ODsNCj4g
LWludCBncmFwaGljX2RlcHRoID0gODsNCj4gLSNlbGlmIGRlZmluZWQoVEFSR0VUX002OEsp
DQo+IC1pbnQgZ3JhcGhpY193aWR0aCA9IDgwMDsNCj4gLWludCBncmFwaGljX2hlaWdodCA9
IDYwMDsNCj4gLWludCBncmFwaGljX2RlcHRoID0gODsNCj4gLSNlbHNlDQo+IC1pbnQgZ3Jh
cGhpY193aWR0aCA9IDgwMDsNCj4gLWludCBncmFwaGljX2hlaWdodCA9IDYwMDsNCj4gLWlu
dCBncmFwaGljX2RlcHRoID0gMzI7DQo+IC0jZW5kaWYNCj4gLQ0KPiAgIGNvbnN0IHVpbnQz
Ml90IGFyY2hfdHlwZSA9IFFFTVVfQVJDSDsNCj4gICANCj4gICB2b2lkIHFlbXVfaW5pdF9h
cmNoX21vZHVsZXModm9pZCkNCj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9nbG9iYWxzLXRhcmdl
dC5jIGIvc3lzdGVtL2dsb2JhbHMtdGFyZ2V0LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAuLjk4OTcyMDU5MWU3DQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvc3lzdGVtL2dsb2JhbHMtdGFyZ2V0LmMNCj4gQEAgLTAsMCArMSwyNCBAQA0KPiAr
LyoNCj4gKyAqIEdsb2JhbCB2YXJpYWJsZXMgdGhhdCBzaG91bGQgbm90IGV4aXN0ICh0YXJn
ZXQgc3BlY2lmaWMpDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChjKSAyMDAzLTIwMDggRmFi
cmljZSBCZWxsYXJkDQo+ICsgKg0KPiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IE1J
VA0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+ICsjaW5jbHVk
ZSAic3lzdGVtL3N5c3RlbS5oIg0KPiArDQo+ICsjaWZkZWYgVEFSR0VUX1NQQVJDDQo+ICtp
bnQgZ3JhcGhpY193aWR0aCA9IDEwMjQ7DQo+ICtpbnQgZ3JhcGhpY19oZWlnaHQgPSA3Njg7
DQo+ICtpbnQgZ3JhcGhpY19kZXB0aCA9IDg7DQo+ICsjZWxpZiBkZWZpbmVkKFRBUkdFVF9N
NjhLKQ0KPiAraW50IGdyYXBoaWNfd2lkdGggPSA4MDA7DQo+ICtpbnQgZ3JhcGhpY19oZWln
aHQgPSA2MDA7DQo+ICtpbnQgZ3JhcGhpY19kZXB0aCA9IDg7DQo+ICsjZWxzZQ0KPiAraW50
IGdyYXBoaWNfd2lkdGggPSA4MDA7DQo+ICtpbnQgZ3JhcGhpY19oZWlnaHQgPSA2MDA7DQo+
ICtpbnQgZ3JhcGhpY19kZXB0aCA9IDMyOw0KPiArI2VuZGlmDQo+IGRpZmYgLS1naXQgYS9z
eXN0ZW0vbWVzb24uYnVpbGQgYi9zeXN0ZW0vbWVzb24uYnVpbGQNCj4gaW5kZXggNDk1MmY0
YjJjN2QuLjE4MTE5NTQxMGZiIDEwMDY0NA0KPiAtLS0gYS9zeXN0ZW0vbWVzb24uYnVpbGQN
Cj4gKysrIGIvc3lzdGVtL21lc29uLmJ1aWxkDQo+IEBAIC0xLDYgKzEsNyBAQA0KPiAgIHNw
ZWNpZmljX3NzLmFkZCh3aGVuOiAnQ09ORklHX1NZU1RFTV9PTkxZJywgaWZfdHJ1ZTogW2Zp
bGVzKA0KPiAgICAgJ2FyY2hfaW5pdC5jJywNCj4gICAgICdpb3BvcnQuYycsDQo+ICsgICdn
bG9iYWxzLXRhcmdldC5jJywNCj4gICAgICdtZW1vcnkuYycsDQo+ICAgICAncGh5c21lbS5j
JywNCj4gICAgICd3YXRjaHBvaW50LmMnLA0KDQo=

