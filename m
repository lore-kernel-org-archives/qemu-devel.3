Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89ECEC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQKk-0008Fi-TL; Wed, 12 Jun 2024 11:56:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQKi-0008Ev-VI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:56:21 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQKf-00008T-Fj
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:56:20 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c2c9199568so4474695a91.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718207775; x=1718812575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4LtFCU0OaqID7yg77vJPhZn4oHg5DdiD9TxoARUTdz0=;
 b=pETUoFZe/yyznCBqAbAxrI0op/v8QhwmFDYkIBEq8OjUFy8WjgmHDAr242X9HnFN+G
 6xwUDt/qhRTboByUATEhdJrB1w+laNs+2DqqxztT5agdGUi14JY0ZmbqJL/fzJNhHLvt
 PR/vSEjM819CUfhFkjmEZQ9OQ6b27JIJBVO3Gm7FMrioH/Rzs/zzz6T72RLANdRS+FUj
 6nMA2U0HyjqKKGiVXcqYphHbVRs7g0yx0nfFC9g2ERsMYyYu5O8pd9U45Ol7dT75mdOF
 9BIvAlI8dAPXqE9ZPSXAt1zkDGgVYJNof8RajP4IaGJ5es9uhQfeV4zQ9f9KbuwR7KUZ
 E2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718207775; x=1718812575;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LtFCU0OaqID7yg77vJPhZn4oHg5DdiD9TxoARUTdz0=;
 b=q4wUiSRBaannds90cVixH+d8Gkxqyq4GutO/K63JYk73pZy09h8EplJ5EjML51Jo5w
 Ke7tGqto1HkD3p+Tp4Fv+gfaOzfKkarOPBnPdnQ3J5PCD97xY3Zqi5iewumr0nqm6XNL
 oQUztstt2o04FGxiWJNneT5muNsEFOg9W4UlgDThkKV3lLSAFaUwNEgouxgMxhjf7rWT
 r8iRHOpIe23PHRhs3BOnTHA0IWkzjifFD6jknRoxllgkWjVzI1xajG9SAOpa7p4ci3hT
 gqAganKypoTzbdOFRPKfRSLNCvb8LamAhfyIihWfIgUCzb7+DbubePiTZQjWY3zV9g5B
 aUgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGgST5nGvx/ZyegbMyXtqaydpCb2CSlAPR10Fldv3tJX8OHpdsQsYdpGrbYzzwiLceRBCGG3lPfVBrO2Va3l/IALLAhLg=
X-Gm-Message-State: AOJu0Yz2wJM0PdLP8Jk+gBFsrlE/wjXAiyrx7vhkHUSKj78GAMsB6YUJ
 kjzhpNAMbalIRDkpN0wEGJWy7rp8Gp5G3O9pIdeEBZ0w69HJcz6P8CVjWNYbKR4=
X-Google-Smtp-Source: AGHT+IGVcaSBJlCHExD1W9Gu9M4SAY6gJcEtzhfoBdpGma9zpWI7MEzivtPw3zBsz+xTPZz63bFXOA==
X-Received: by 2002:a17:90a:c83:b0:2c3:236e:473c with SMTP id
 98e67ed59e1d1-2c4a7643085mr2419168a91.21.1718207775372; 
 Wed, 12 Jun 2024 08:56:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a769bc48sm1941009a91.38.2024.06.12.08.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 08:56:14 -0700 (PDT)
Message-ID: <abe88b9b-621a-4956-877d-dd311a7fd58b@linaro.org>
Date: Wed, 12 Jun 2024 08:56:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] plugins: add time control API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240612153508.1532940-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

SGkgQWxleCwNCg0KSSBub3RpY2VkIHRoZSBuZXcgc3ltYm9scyBsYWNrIFFFTVVfUExVR0lO
X0FQSSBxdWFsaWZpZXIgaW4gDQppbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaDoNCi0gcWVt
dV9wbHVnaW5fdXBkYXRlX25zDQotIHFlbXVfcGx1Z2luX3JlcXVlc3RfdGltZV9jb250cm9s
DQoNClNvIGl0IHdvdWxkIGJlIGltcG9zc2libGUgdG8gdXNlIHRob3NlIHN5bWJvbHMgb24g
d2luZG93cy4NCg0KSSBrZXB0IGEgcmVtaW5kZXIgdG8gc2VuZCBhIG5ldyBwYXRjaCBhZnRl
ciB5b3UgcHVsbGVkIHRoaXMsIGJ1dCBpZiB3ZSANCmdvIHRvIGEgbmV3IHNlcmllcywgaXQg
Y291bGQgYmUgYXMgZmFzdCBmb3IgeW91IHRvIGp1c3QgYWRkIHRoaXMgZGlyZWN0bHkuDQoN
ClRoYW5rcywNClBpZXJyaWNrDQoNCk9uIDYvMTIvMjQgMDg6MzUsIEFsZXggQmVubsOpZSB3
cm90ZToNCj4gRXhwb3NlIHRoZSBhYmlsaXR5IHRvIGNvbnRyb2wgdGltZSB0aHJvdWdoIHRo
ZSBwbHVnaW4gQVBJLiBPbmx5IG9uZQ0KPiBwbHVnaW4gY2FuIGNvbnRyb2wgdGltZSBzbyBp
dCBoYXMgdG8gcmVxdWVzdCBjb250cm9sIHdoZW4gbG9hZGVkLg0KPiBUaGVyZSBhcmUgcHJv
YmFibHkgbW9yZSBjb3JuZXIgY2FzZXMgdG8gY2F0Y2ggaGVyZS4NCj4gDQo+IEZyb206IEFs
ZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTog
UGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KPiBbQUpC
OiB0d2Vha2VkIHVzZXItbW9kZSBoYW5kbGluZ10NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBC
ZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBNZXNzYWdlLUlkOiA8MjAyNDA1
MzAyMjA2MTAuMTI0NTQyNC02LXBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4gDQo+
IC0tLQ0KPiBwbHVnaW5zL25leHQNCj4gICAgLSBtYWtlIHFlbXVfcGx1Z2luX3VwZGF0ZV9u
cyBhIE5PUCBpbiB1c2VyLW1vZGUNCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L3FlbXUtcGx1
Z2luLmggICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICBwbHVnaW5zL2Fw
aS5jICAgICAgICAgICAgICAgIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICBwbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzIHwgIDIgKysNCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDYyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCBiL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5o
DQo+IGluZGV4IDk1NzAzZDhmZWMuLmRiNGQ2NzUyOWUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvcWVtdS9xZW11LXBsdWdpbi5oDQo+ICsrKyBiL2luY2x1ZGUvcWVtdS9xZW11LXBsdWdp
bi5oDQo+IEBAIC02NjEsNiArNjYxLDMxIEBAIHZvaWQgcWVtdV9wbHVnaW5fcmVnaXN0ZXJf
dmNwdV9tZW1faW5saW5lX3Blcl92Y3B1KA0KPiAgICAgICBxZW11X3BsdWdpbl91NjQgZW50
cnksDQo+ICAgICAgIHVpbnQ2NF90IGltbSk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIHFlbXVf
cGx1Z2luX3JlcXVlc3RfdGltZV9jb250cm9sKCkgLSByZXF1ZXN0IHRoZSBhYmlsaXR5IHRv
IGNvbnRyb2wgdGltZQ0KPiArICoNCj4gKyAqIFRoaXMgZ3JhbnRzIHRoZSBwbHVnaW4gdGhl
IGFiaWxpdHkgdG8gY29udHJvbCBzeXN0ZW0gdGltZS4gT25seSBvbmUNCj4gKyAqIHBsdWdp
biBjYW4gY29udHJvbCB0aW1lIHNvIGlmIG11bHRpcGxlIHBsdWdpbnMgcmVxdWVzdCB0aGUg
YWJpbGl0eQ0KPiArICogYWxsIGJ1dCB0aGUgZmlyc3Qgd2lsbCBmYWlsLg0KPiArICoNCj4g
KyAqIFJldHVybnMgYW4gb3BhcXVlIGhhbmRsZSBvciBOVUxMIGlmIGZhaWxzDQo+ICsgKi8N
Cj4gK2NvbnN0IHZvaWQgKnFlbXVfcGx1Z2luX3JlcXVlc3RfdGltZV9jb250cm9sKHZvaWQp
Ow0KPiArDQo+ICsvKioNCj4gKyAqIHFlbXVfcGx1Z2luX3VwZGF0ZV9ucygpIC0gdXBkYXRl
IHN5c3RlbSBlbXVsYXRpb24gdGltZQ0KPiArICogQGhhbmRsZTogb3BhcXVlIGhhbmRsZSBy
ZXR1cm5lZCBieSBxZW11X3BsdWdpbl9yZXF1ZXN0X3RpbWVfY29udHJvbCgpDQo+ICsgKiBA
dGltZTogdGltZSBpbiBuYW5vc2Vjb25kcw0KPiArICoNCj4gKyAqIFRoaXMgYWxsb3dzIGFu
IGFwcHJvcHJpYXRlbHkgYXV0aG9yaXNlZCBwbHVnaW4gKGkuZS4gaG9sZGluZyB0aGUNCj4g
KyAqIHRpbWUgY29udHJvbCBoYW5kbGUpIHRvIG1vdmUgc3lzdGVtIHRpbWUgZm9yd2FyZCB0
byBAdGltZS4gRm9yDQo+ICsgKiB1c2VyLW1vZGUgZW11bGF0aW9uIHRoZSB0aW1lIGlzIG5v
dCBjaGFuZ2VkIGJ5IHRoaXMgYXMgYWxsIHJlcG9ydGVkDQo+ICsgKiB0aW1lIGNvbWVzIGZy
b20gdGhlIGhvc3Qga2VybmVsLg0KPiArICoNCj4gKyAqIFN0YXJ0IHRpbWUgaXMgMC4NCj4g
KyAqLw0KPiArdm9pZCBxZW11X3BsdWdpbl91cGRhdGVfbnMoY29uc3Qgdm9pZCAqaGFuZGxl
LCBpbnQ2NF90IHRpbWUpOw0KPiArDQo+ICAgdHlwZWRlZiB2b2lkDQo+ICAgKCpxZW11X3Bs
dWdpbl92Y3B1X3N5c2NhbGxfY2JfdCkocWVtdV9wbHVnaW5faWRfdCBpZCwgdW5zaWduZWQg
aW50IHZjcHVfaW5kZXgsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
aW50NjRfdCBudW0sIHVpbnQ2NF90IGExLCB1aW50NjRfdCBhMiwNCj4gZGlmZiAtLWdpdCBh
L3BsdWdpbnMvYXBpLmMgYi9wbHVnaW5zL2FwaS5jDQo+IGluZGV4IDZiZGIyNmJiZTMuLjQ0
MzFhMGVhN2UgMTAwNjQ0DQo+IC0tLSBhL3BsdWdpbnMvYXBpLmMNCj4gKysrIGIvcGx1Z2lu
cy9hcGkuYw0KPiBAQCAtMzksNiArMzksNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIg0KPiAgICNpbmNsdWRlICJxZW11L3BsdWdpbi5oIg0KPiAgICNpbmNsdWRlICJx
ZW11L2xvZy5oIg0KPiArI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCj4gICAjaW5jbHVkZSAi
dGNnL3RjZy5oIg0KPiAgICNpbmNsdWRlICJleGVjL2V4ZWMtYWxsLmgiDQo+ICAgI2luY2x1
ZGUgImV4ZWMvZ2Ric3R1Yi5oIg0KPiBAQCAtNTgzLDMgKzU4NCwzNyBAQCB1aW50NjRfdCBx
ZW11X3BsdWdpbl91NjRfc3VtKHFlbXVfcGx1Z2luX3U2NCBlbnRyeSkNCj4gICAgICAgfQ0K
PiAgICAgICByZXR1cm4gdG90YWw7DQo+ICAgfQ0KPiArDQo+ICsvKg0KPiArICogVGltZSBj
b250cm9sDQo+ICsgKi8NCj4gK3N0YXRpYyBib29sIGhhc19jb250cm9sOw0KPiArDQo+ICtj
b25zdCB2b2lkICpxZW11X3BsdWdpbl9yZXF1ZXN0X3RpbWVfY29udHJvbCh2b2lkKQ0KPiAr
ew0KPiArICAgIGlmICghaGFzX2NvbnRyb2wpIHsNCj4gKyAgICAgICAgaGFzX2NvbnRyb2wg
PSB0cnVlOw0KPiArICAgICAgICByZXR1cm4gJmhhc19jb250cm9sOw0KPiArICAgIH0NCj4g
KyAgICByZXR1cm4gTlVMTDsNCj4gK30NCj4gKw0KPiArI2lmZGVmIENPTkZJR19TT0ZUTU1V
DQo+ICtzdGF0aWMgdm9pZCBhZHZhbmNlX3ZpcnR1YWxfdGltZV9fYXN5bmMoQ1BVU3RhdGUg
KmNwdSwgcnVuX29uX2NwdV9kYXRhIGRhdGEpDQo+ICt7DQo+ICsgICAgaW50NjRfdCBuZXdf
dGltZSA9IGRhdGEuaG9zdF91bG9uZzsNCj4gKyAgICBxZW11X2Nsb2NrX2FkdmFuY2Vfdmly
dHVhbF90aW1lKG5ld190aW1lKTsNCj4gK30NCj4gKyNlbmRpZg0KPiArDQo+ICt2b2lkIHFl
bXVfcGx1Z2luX3VwZGF0ZV9ucyhjb25zdCB2b2lkICpoYW5kbGUsIGludDY0X3QgbmV3X3Rp
bWUpDQo+ICt7DQo+ICsjaWZkZWYgQ09ORklHX1NPRlRNTVUNCj4gKyAgICBpZiAoaGFuZGxl
ID09ICZoYXNfY29udHJvbCkgew0KPiArICAgICAgICAvKiBOZWVkIHRvIGV4ZWN1dGUgb3V0
IG9mIGNwdV9leGVjLCBzbyBicWwgY2FuIGJlIGxvY2tlZC4gKi8NCj4gKyAgICAgICAgYXN5
bmNfcnVuX29uX2NwdShjdXJyZW50X2NwdSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICBhZHZhbmNlX3ZpcnR1YWxfdGltZV9fYXN5bmMsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgUlVOX09OX0NQVV9IT1NUX1VMT05HKG5ld190aW1lKSk7DQo+ICsgICAgfQ0KPiAr
I2VuZGlmDQo+ICt9DQo+IGRpZmYgLS1naXQgYS9wbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1i
b2xzIGIvcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scw0KPiBpbmRleCBhYTBhNzdhMzE5
Li5jYTc3M2Q4ZDlmIDEwMDY0NA0KPiAtLS0gYS9wbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1i
b2xzDQo+ICsrKyBiL3BsdWdpbnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMNCj4gQEAgLTM4LDYg
KzM4LDcgQEANCj4gICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfdGJfZXhlY19jb25k
X2NiOw0KPiAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV90Yl9leGVjX2lubGluZV9w
ZXJfdmNwdTsNCj4gICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfdGJfdHJhbnNfY2I7
DQo+ICsgIHFlbXVfcGx1Z2luX3JlcXVlc3RfdGltZV9jb250cm9sOw0KPiAgICAgcWVtdV9w
bHVnaW5fcmVzZXQ7DQo+ICAgICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX2ZyZWU7DQo+ICAg
ICBxZW11X3BsdWdpbl9zY29yZWJvYXJkX2ZpbmQ7DQo+IEBAIC01MSw1ICs1Miw2IEBADQo+
ICAgICBxZW11X3BsdWdpbl91NjRfc2V0Ow0KPiAgICAgcWVtdV9wbHVnaW5fdTY0X3N1bTsN
Cj4gICAgIHFlbXVfcGx1Z2luX3VuaW5zdGFsbDsNCj4gKyAgcWVtdV9wbHVnaW5fdXBkYXRl
X25zOw0KPiAgICAgcWVtdV9wbHVnaW5fdmNwdV9mb3JfZWFjaDsNCj4gICB9Ow0K

