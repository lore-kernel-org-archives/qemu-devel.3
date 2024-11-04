Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC32D1CA03
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 22:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t85Iz-0001vq-PP; Mon, 04 Nov 2024 17:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Iw-0001vX-Jb
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:12:11 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t85Iu-0002tZ-4x
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 17:12:09 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-723db2798caso1298728b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 14:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730758326; x=1731363126; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kl04a44MzPAjym4WGALzjhxFFCLJY49OBrCfKc1iHDU=;
 b=ftiKSmgOtslPWeMgDsaQoCnp0mUx3JMft6tFkxzuNmCrVNV7oEA7jFvhplaI7jElsd
 dwfJqNdM9PXuSkzj42CBM60KCRUvVUYB/ltbSdglqtpBZTDCLxgLu+hOy3PZBFCp8Whp
 N/jYaPixDuECqQ9cIRsn4YXiJDbY4G9zjB4mdwLV4BmGzWXXH3702PZMYA1S/ZaXiJFV
 phG/DNIy1KWDXJj/CUjpKYNBxYqPdqVnDANdnWcWIGcUC+Fu7k4YHhF7IEGXpF3E7nnA
 wLAVUakQxZa1l0LD1oi2gcnr7bxqLMOuINTN0CKsnGTdbjmx9Q5dkLVc00gFl0IHSnu8
 fodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730758326; x=1731363126;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kl04a44MzPAjym4WGALzjhxFFCLJY49OBrCfKc1iHDU=;
 b=oDZGJXIc+sE0YAbsoyJACqu9aHbGPw0xm7Jw6zaXhR56izUclEvz796ahb1RK09zhL
 YDvqyjlIrgXhb7AJdaxfEXjuV8fgq3rx+nz0koadrSKEeAbCehIrx2lQ4psOd4Jk+ypY
 +cFWc2CgAnZk2ARX5KUn+tLR5sA1Q7tnKT6QU0vRJpxYh5wMhqwkpafBF+jk1xb8VgG9
 pGW2yYP7Soaj/c4OCWfJ1bNeIQ7sya98GNS5ne5ZQK9JelDSASHNs6kzfWtxqa85M+dK
 EbmpME5wm4MZIJ1SQoICDtsTOp4gQ4OsfSs6nOle1SSVdWIldy2KgiYTbEHALw3gWBOa
 SAuw==
X-Gm-Message-State: AOJu0Yzln3f5r80dKnPelVwysj/TEb+IyYU8i3iHbdMlRpEsJzsJS1AX
 0hU4vRPYPNcMUoZrYrbpabyF2MrLJY6ElzfpH9Ey2S1uymZG5DRxkhCR0Gnhebo=
X-Google-Smtp-Source: AGHT+IHaL5t5e3Od6JAxCngFvAEdEOgw/IdxskbnklnvhtSMtCimr6xIq0sHPNirWb6qE8J2xJjmGQ==
X-Received: by 2002:a05:6a20:7f8c:b0:1db:de53:6143 with SMTP id
 adf61e73a8af0-1dbde536180mr6457938637.33.1730758326581; 
 Mon, 04 Nov 2024 14:12:06 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb57bsm8309622b3a.173.2024.11.04.14.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 14:12:06 -0800 (PST)
Message-ID: <4ad075ef-c14c-465c-99b4-de00390dabb1@linaro.org>
Date: Mon, 4 Nov 2024 14:12:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: remove unused but set variable
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20241023182922.1040964-1-pierrick.bouvier@linaro.org>
 <87zfmuk34y.fsf@draig.linaro.org>
 <0b140b1c-7174-4108-b504-98f9506f3fb8@linaro.org>
In-Reply-To: <0b140b1c-7174-4108-b504-98f9506f3fb8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

T24gMTAvMjMvMjQgMTM6MDQsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+IE9uIDEwLzIz
LzI0IDEyOjUzLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+PiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+DQo+Pj4gZml4ZXMgYXNz
b2NpYXRlZCB3YXJuaW5nIHdoZW4gYnVpbGRpbmcgb24gTWFjT1MuDQo+Pj4NCj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5v
cmc+DQo+Pj4gLS0tDQo+Pj4gICAgdGFyZ2V0L2kzODYvaHZmL3g4Nl90YXNrLmMgfCAxMCAr
KysrKy0tLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgNSBk
ZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90YXJnZXQvaTM4Ni9odmYveDg2
X3Rhc2suYyBiL3RhcmdldC9pMzg2L2h2Zi94ODZfdGFzay5jDQo+Pj4gaW5kZXggZjA5YmZi
ZGRhNWIuLmNkZWEyZWE2OWQ5IDEwMDY0NA0KPj4+IC0tLSBhL3RhcmdldC9pMzg2L2h2Zi94
ODZfdGFzay5jDQo+Pj4gKysrIGIvdGFyZ2V0L2kzODYvaHZmL3g4Nl90YXNrLmMNCj4+PiBA
QCAtMTIyLDcgKzEyMiw2IEBAIHZvaWQgdm14X2hhbmRsZV90YXNrX3N3aXRjaChDUFVTdGF0
ZSAqY3B1LCB4Njhfc2VnbWVudF9zZWxlY3RvciB0c3Nfc2VsLCBpbnQgcmVhDQo+Pj4gICAg
ICAgIGxvYWRfcmVncyhjcHUpOw0KPj4+ICAgIA0KPj4+ICAgICAgICBzdHJ1Y3QgeDg2X3Nl
Z21lbnRfZGVzY3JpcHRvciBjdXJyX3Rzc19kZXNjLCBuZXh0X3Rzc19kZXNjOw0KPj4+IC0g
ICAgaW50IHJldDsNCj4+PiAgICAgICAgeDY4X3NlZ21lbnRfc2VsZWN0b3Igb2xkX3Rzc19z
ZWwgPSB2bXhfcmVhZF9zZWdtZW50X3NlbGVjdG9yKGNwdSwgUl9UUik7DQo+Pj4gICAgICAg
IHVpbnQ2NF90IG9sZF90c3NfYmFzZSA9IHZteF9yZWFkX3NlZ21lbnRfYmFzZShjcHUsIFJf
VFIpOw0KPj4+ICAgICAgICB1aW50MzJfdCBkZXNjX2xpbWl0Ow0KPj4+IEBAIC0xMzgsNyAr
MTM3LDcgQEAgdm9pZCB2bXhfaGFuZGxlX3Rhc2tfc3dpdGNoKENQVVN0YXRlICpjcHUsIHg2
OF9zZWdtZW50X3NlbGVjdG9yIHRzc19zZWwsIGludCByZWENCj4+PiAgICAgICAgaWYgKHJl
YXNvbiA9PSBUU1JfSURUX0dBVEUgJiYgZ2F0ZV92YWxpZCkgew0KPj4+ICAgICAgICAgICAg
aW50IGRwbDsNCj4+PiAgICANCj4+PiAtICAgICAgICByZXQgPSB4ODZfcmVhZF9jYWxsX2dh
dGUoY3B1LCAmdGFza19nYXRlX2Rlc2MsIGdhdGUpOw0KPj4+ICsgICAgICAgIHg4Nl9yZWFk
X2NhbGxfZ2F0ZShjcHUsICZ0YXNrX2dhdGVfZGVzYywgZ2F0ZSk7DQo+Pg0KPj4gSWYgd2Ug
ZG9uJ3QgY2FyZSBhbmQgdGhpcyBpcyB0aGUgb25seSBjYWxsZXIgd2UgZml4IHVwDQo+PiB4
ODZfcmVhZF9jYWxsX2dhdGUgbm90IHRvIHJldHVybiBhIHZhbHVlLiBJdCBsb29rcyBsaWtl
IGl0IGZhaWxzIHNhZmUNCj4+IHdpdGggYW4gZW1wdHkgZW50cnkgKGJ1dCBhbHNvIHRoZSBm
dW5jdGlvbiB4ODZfcmVhZF9jYWxsX2dhdGUgbmVlZHMgdGhlDQo+PiBwcmludGYgcmVtb3Zp
bmcpLg0KPj4NCj4gWWVzLCBvciBtYXliZSB3ZSBzaG91bGQgY2hlY2sgaWYgdGhlIHJlYWQg
d2FzIGEgc3VjY2Vzcywgb3IgZWxzZSBjYWxsDQo+IFZNX1BBTklDKCJ4ODZfcmVhZF9jYWxs
X2dhdGUiKS4NCj4gQW55IGFkdmljZSBmcm9tIGh2ZiBtYWludGFpbmVycz8NCj4gDQoNCldl
IGRpZG4ndCBoYXZlIGFueSBmZWVkYmFjayB5ZXQuDQoNCldvdWxkIHRoYXQgYmUgcG9zc2li
bGUgZm9yIGEgbWFpbnRhaW5lciB0byBwdWxsIHRoZSBjdXJyZW50IHNlcmllcyBhcyBpdCBp
cz8NCkl0J3MgZnVuY3Rpb25uYWxseSBlcXVpdmFsZW50LCBhbmQgcmVtb3ZlIHRoaXMgd2Fy
bmluZyB0byBoYXZlIGEgY2xlYW4gDQo5LjIgcmVsZWFzZSBvbiB0aGlzIHBsYXRmb3JtLg0K
DQo+Pj4gICAgDQo+Pj4gICAgICAgICAgICBkcGwgPSB0YXNrX2dhdGVfZGVzYy5kcGw7DQo+
Pj4gICAgICAgICAgICB4Njhfc2VnbWVudF9zZWxlY3RvciBjcyA9IHZteF9yZWFkX3NlZ21l
bnRfc2VsZWN0b3IoY3B1LCBSX0NTKTsNCj4+PiBAQCAtMTY3LDExICsxNjYsMTIgQEAgdm9p
ZCB2bXhfaGFuZGxlX3Rhc2tfc3dpdGNoKENQVVN0YXRlICpjcHUsIHg2OF9zZWdtZW50X3Nl
bGVjdG9yIHRzc19zZWwsIGludCByZWENCj4+PiAgICAgICAgICAgIHg4Nl93cml0ZV9zZWdt
ZW50X2Rlc2NyaXB0b3IoY3B1LCAmbmV4dF90c3NfZGVzYywgdHNzX3NlbCk7DQo+Pj4gICAg
ICAgIH0NCj4+PiAgICANCj4+PiAtICAgIGlmIChuZXh0X3Rzc19kZXNjLnR5cGUgJiA4KQ0K
Pj4+IC0gICAgICAgIHJldCA9IHRhc2tfc3dpdGNoXzMyKGNwdSwgdHNzX3NlbCwgb2xkX3Rz
c19zZWwsIG9sZF90c3NfYmFzZSwgJm5leHRfdHNzX2Rlc2MpOw0KPj4+IC0gICAgZWxzZQ0K
Pj4+ICsgICAgaWYgKG5leHRfdHNzX2Rlc2MudHlwZSAmIDgpIHsNCj4+PiArICAgICAgICB0
YXNrX3N3aXRjaF8zMihjcHUsIHRzc19zZWwsIG9sZF90c3Nfc2VsLCBvbGRfdHNzX2Jhc2Us
ICZuZXh0X3Rzc19kZXNjKTsNCj4+PiArICAgIH0gZWxzZSB7DQo+Pj4gICAgICAgICAgICAv
L3JldCA9IHRhc2tfc3dpdGNoXzE2KGNwdSwgdHNzX3NlbCwgb2xkX3Rzc19zZWwsIG9sZF90
c3NfYmFzZSwgJm5leHRfdHNzX2Rlc2MpOw0KPj4+ICAgICAgICAgICAgVk1fUEFOSUMoInRh
c2tfc3dpdGNoXzE2Iik7DQo+Pj4gKyAgICB9DQo+Pj4gICAgDQo+Pj4gICAgICAgIG1hY3Zt
X3NldF9jcjAoY3B1LT5hY2NlbC0+ZmQsIHJ2bWNzKGNwdS0+YWNjZWwtPmZkLCBWTUNTX0dV
RVNUX0NSMCkgfA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQ1Iw
X1RTX01BU0spOw0KPj4NCg==

