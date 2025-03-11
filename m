Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83ACC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Ss-0000uR-Ij; Tue, 11 Mar 2025 11:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1So-0000tC-2t
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:24:16 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Sj-0007Lb-Rz
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:24:13 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2feae794508so8460490a91.0
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741706643; x=1742311443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9SkM+QBVMzm9A6N98427a8lsiY/0Sg+B4uvqfE1GeA4=;
 b=Ya28SmOC/I9tEsXTSuWONdKCNwAplzfsYnpLTQQR0rzzR1YY5xz7yxc7xer7UYGC8N
 shJ2g4416wn/6LWa/kx5fSWhU1aduFiuaKJ7v1Ktt8wnAsxXOPXBdnx7aROSMF18geUk
 vh1ax4mVcF8q+DRvkWEA8WB+UPemnHr8UrkeWZVbz0tm8zEMjtaBRSKynTbgaFZ1Nr95
 hISIhdaYJNsQpAQHaeuJrSjL3aM2sX2YLo55DPPgfkU4iA8MSaG8/Kbb4cvGuc7mw5j3
 QKJdfQLcdlUoM21OOg8HCdEekEXaMwPjfpcxjgyQQ7QwCN/ot7k1RDMJvoHICXErAIoo
 1M+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706643; x=1742311443;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9SkM+QBVMzm9A6N98427a8lsiY/0Sg+B4uvqfE1GeA4=;
 b=j+X+dYrxSQ/cYcljRb/Ygj5FF21JVbmjwK/Fzq2VZ80x6+LSPYiVvPgnbSoY08Djcx
 HqaCMGcQu0RAunIICmPLzrdvTCRJYsThIYxjWGCLUQsDVdTqy38GYFZLp5k+RP1pqSDV
 rxPoLmCPVwLirvPjtG/aOAMTiFuROaqzZJJXlsaTeteyTeXUoUMPxkvMgfihv9h4m+z3
 5HiN8O0IbV7SPmUMIiD/8WwMWleuEA1a6aehGcUh4lmUC62+7PKOqhDJnuU3rRZfd9Yv
 zGTG1j+B5NC3Mf6eFfeb5ebWz7DB54Zohm/pKeD1Jot+B+TkqbreKR4+n8KqtpnS3AuP
 1nFw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwCwLkF4a3ij60phr/hLD8ST2ED+9/bdByPzlr8Ts1dvi+mhuogTRC5bjpaXixZWZWvtIEBphcgDT0@nongnu.org
X-Gm-Message-State: AOJu0Yw95egVTtUj4Vl+pW1Y0clrzfxG2oTj0IQc30lztcsTLAc6HrG8
 KEQioXxqCbJL+j5WIBBFRDT9hKugheS66uc4u8SU15dBTPavQYu352dIMFiaEL8=
X-Gm-Gg: ASbGncuU3u2aFBTxo19397CuZcyD/Zrm3FZJqJ+tv/LbYSu1mgXMzNZl3yhdzrJZ0/2
 fkFQyP8AeBai9gEsb7vphYeXmTPO8kzZEWGEDddd7CIoH7OfZEqgPg5t7l1fQXU8IrslsHDAf+c
 +aDmKr9tGtmKtAsRTSZHROfcHI2JM0zHCa+4yxjWBrgSQsDn8UJsHLJav5HFbhAMCZf2p14YUoG
 yzs9z5fcbuKGfLGznLMCJbBYEcL8Z+Pdi5i8CLDMpScjHrJXcNDQCPjsYiE5/oCcSdlSpXcs5oo
 2KBYaHu7dI5V+Vp6IeE+YiSBkdi+2AqabtnZZIAZMAMNfae9tzNfIiPnkwG9X/NlVSzX
X-Google-Smtp-Source: AGHT+IFBs0+S+LkojiDrxva0/M3wYEnbIAEG3pIneKNxcshy9ERSmJz3RFAr2j7Us8awjWxYZcw3Bg==
X-Received: by 2002:a17:90b:1c05:b0:2ee:a583:e616 with SMTP id
 98e67ed59e1d1-2ff7ce6d543mr28614081a91.9.1741706643713; 
 Tue, 11 Mar 2025 08:24:03 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773c7csm12057570a91.15.2025.03.11.08.24.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:24:03 -0700 (PDT)
Message-ID: <dbe403b1-a90a-4e32-a773-680539ce5550@linaro.org>
Date: Tue, 11 Mar 2025 08:24:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] include/exec/memory: extract devend_big_endian
 from devend_memop
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-15-pierrick.bouvier@linaro.org>
 <b8073e25-ae8a-462b-b085-84c471a4bf5e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b8073e25-ae8a-462b-b085-84c471a4bf5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

T24gMy8xMS8yNSAwMDozNiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDExLzMvMjUgMDU6MDgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiB3ZSdsbCB1c2Ug
aXQgaW4gc3lzdGVtL21lbW9yeS5jLg0KPiANCj4gSGF2aW5nIHBhcnQgb2YgdGhlIGNvbW1p
dCBkZXNjcmlwdGlvbiBzZXBhcmF0ZWQgaW4gaXRzIHN1YmplY3QgaXMgYQ0KPiBiaXQgYW5u
b3lpbmcuIEJ1dCB0aGVuIEknbSBwcm9iYWJseSB1c2luZyAyMC15ZWFycyB0b28gb2xkIHRv
b2xzIGluDQo+IG15IHBhdGNoIHdvcmtmbG93Lg0KDQpDYW4geW91IHBsZWFzZSBzaGFyZSB3
aGF0IHdvdWxkIGJlIHRoZSBtZXNzYWdlIHlvdSAob3IgdGhlIHRvb2wpIHdvdWxkIA0KcHJl
ZmVyIGluIHRoaXMgY2FzZT8NCg0KSXQncyBqdXN0IGEgc2luZ2xlIGxpbmUgc3ViamVjdCAo
c2F5aW5nICJ3ZSBleHRyYWN0IHRoZSBmdW5jdGlvbiIpICsgYW4gDQphZGRpdGlvbmFsIGxp
bmUganVzdGlmeWluZyB3aHkgaXQncyBuZWVkZWQuDQoNCj4gDQo+IE9ubHkgdXNlZCBpbiBz
eXN0ZW0ve21lbW9yeSxwaHlzbWVtfS5jLCB3b3J0aCBtb3ZlIHRvIGEgbG9jYWwNCj4gc3lz
dGVtL21lbW9yeS1pbnRlcm5hbC5oIGhlYWRlcj8gT3IgZXZlbiBzaW1wbGVyLCBtb3ZlDQo+
IGluY2x1ZGUvZXhlYy9tZW1vcnktaW50ZXJuYWwuaCAtPiBleGVjL21lbW9yeS1pbnRlcm5h
bC5oIGZpcnN0Lg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgaW5jbHVkZS9leGVj
L21lbW9yeS5oIHwgMTggKysrKysrKysrKysrLS0tLS0tDQo+PiAgICAxIGZpbGUgY2hhbmdl
ZCwgMTIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQo+PiBp
bmRleCA2MGMwZmI2Y2NkNC4uNTc2NjEyODM2ODQgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRl
L2V4ZWMvbWVtb3J5LmgNCj4+ICsrKyBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPj4gQEAg
LTMxMzgsMTYgKzMxMzgsMjIgQEAgYWRkcmVzc19zcGFjZV93cml0ZV9jYWNoZWQoTWVtb3J5
UmVnaW9uQ2FjaGUgKmNhY2hlLCBod2FkZHIgYWRkciwNCj4+ICAgIE1lbVR4UmVzdWx0IGFk
ZHJlc3Nfc3BhY2Vfc2V0KEFkZHJlc3NTcGFjZSAqYXMsIGh3YWRkciBhZGRyLA0KPj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDhfdCBjLCBod2FkZHIgbGVuLCBN
ZW1UeEF0dHJzIGF0dHJzKTsNCj4+ICAgIA0KPj4gLS8qIGVudW0gZGV2aWNlX2VuZGlhbiB0
byBNZW1PcC4gICovDQo+PiAtc3RhdGljIGlubGluZSBNZW1PcCBkZXZlbmRfbWVtb3AoZW51
bSBkZXZpY2VfZW5kaWFuIGVuZCkNCj4+ICsvKiByZXR1cm5zIHRydWUgaWYgZW5kIGlzIGJp
ZyBlbmRpYW4uICovDQo+PiArc3RhdGljIGlubGluZSBib29sIGRldmVuZF9iaWdfZW5kaWFu
KGVudW0gZGV2aWNlX2VuZGlhbiBlbmQpDQo+PiAgICB7DQo+PiAgICAgICAgUUVNVV9CVUlM
RF9CVUdfT04oREVWSUNFX0hPU1RfRU5ESUFOICE9IERFVklDRV9MSVRUTEVfRU5ESUFOICYm
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgREVWSUNFX0hPU1RfRU5ESUFOICE9IERF
VklDRV9CSUdfRU5ESUFOKTsNCj4+ICAgIA0KPj4gLSAgICBib29sIGJpZ19lbmRpYW4gPSAo
ZW5kID09IERFVklDRV9OQVRJVkVfRU5ESUFODQo+PiAtICAgICAgICAgICAgICAgICAgICAg
ICA/IHRhcmdldF93b3Jkc19iaWdlbmRpYW4oKQ0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgOiBlbmQgPT0gREVWSUNFX0JJR19FTkRJQU4pOw0KPj4gLSAgICByZXR1cm4gYmlnX2Vu
ZGlhbiA/IE1PX0JFIDogTU9fTEU7DQo+PiArICAgIGlmIChlbmQgPT0gREVWSUNFX05BVElW
RV9FTkRJQU4pIHsNCj4+ICsgICAgICAgIHJldHVybiB0YXJnZXRfd29yZHNfYmlnZW5kaWFu
KCk7DQo+PiArICAgIH0NCj4+ICsgICAgcmV0dXJuIGVuZCA9PSBERVZJQ0VfQklHX0VORElB
TjsNCj4+ICt9DQo+PiArDQo+PiArLyogZW51bSBkZXZpY2VfZW5kaWFuIHRvIE1lbU9wLiAg
Ki8NCj4+ICtzdGF0aWMgaW5saW5lIE1lbU9wIGRldmVuZF9tZW1vcChlbnVtIGRldmljZV9l
bmRpYW4gZW5kKQ0KPj4gK3sNCj4+ICsgICAgcmV0dXJuIGRldmVuZF9iaWdfZW5kaWFuKGVu
ZCkgPyBNT19CRSA6IE1PX0xFOw0KPj4gICAgfQ0KPj4gICAgDQo+PiAgICAvKg0KPiANCg0K


