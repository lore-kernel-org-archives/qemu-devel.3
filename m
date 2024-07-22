Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4452C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:06:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0ET-0000Ym-Ea; Mon, 22 Jul 2024 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0ES-0000V8-DK
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:08 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0EP-00055k-8Y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fd70ba6a15so16588215ad.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682364; x=1722287164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+BC70SQOUCj32PwE09305E5qj3WqHU1ENkN4YcT/+k0=;
 b=m9H5rUoBsZ2I4nOF9CE4P5xVwDCFWP+n/M6I8VuVq1iFbFNFYiauUapURKHDX4jwYL
 Ikcwpe+nNPje1WBf0qFwnhRhcgd7/y5wXMj0qNgIxuc4nb7NzYNuzA+ACaLB4TEiVeoN
 ZS9Th0WNzWQiuaYjXAdvtEHyJK6UUwd1wMFeSxZCwq/VPNAQvg2+ztzPKCJ0H5qJMhEp
 tHM9fUlu1gZoaWTp2wVXnYus7lZyIqHB6wGcqll/Ik5puWaD/U/If5ZaGWAZ951fCdOn
 s9f0Jwx8O45rQza+kkq69ti8xV2X9PfSSajkKYfhModEFl/7cmY0XY2uxJW0A2QsmqB9
 vRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682364; x=1722287164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BC70SQOUCj32PwE09305E5qj3WqHU1ENkN4YcT/+k0=;
 b=tkf/Kd3iHDSdw/9VjULW2t1mKnoBJTycM7rcDklRBwxPEv1uunaDcoJy0Xokmaszkk
 x2OP7zvd5Sp1mEJC3jbRKq5K8m9gAuldTZVlMd537U1cXwOlsvvhQvvDYSoTXUtUpsdH
 HFUWlz4D35eR+esI/WeXjOZC8Otz47S9d2uKBqx/Z1am1OReGgjATRAaBE9DFBpDsbXb
 puaPfDKaczlQfZ4xzdE2In0UGJ+kKFNF1WwwfPy87NHXK1bkHnIU1efZ+Za8Tt27e1Bs
 Zk4RPukkDHkmZ4gaYneCEf5TpxOr3Wf5kuLR/CHmhZ3oeZObduF2pgd7WndfwWUT9xHo
 ln2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2v2aFlx/6cSQoIxV0JH323vMEb/pyGo1K/LhniaKM2kzBbgt3tUiMo7Ffu91LATeVkqUWiQKTne8z+7rR8oMbtPgT7b8=
X-Gm-Message-State: AOJu0YzdiCWp1J6mr13YCSbz98yX3Z7uKc5sFueW2VIVj8xYhchusjpn
 ztHuGjA5wpsm4+ZidH75GCAUcl4MInvaz4xWC3FIGenI2Iw/3AU6WzKBWDhmdkY=
X-Google-Smtp-Source: AGHT+IFWQ8EnmzSeBLlsabdH4ujh+qhOASXxd3CDyp3ZAM4WZDKML2+G0kZyk9AiPFV+1oVfZT4c4g==
X-Received: by 2002:a17:903:2285:b0:1fd:70c4:8389 with SMTP id
 d9443c01a7336-1fd745258dbmr66793345ad.7.1721682363728; 
 Mon, 22 Jul 2024 14:06:03 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f31bb8asm59780195ad.170.2024.07.22.14.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:06:03 -0700 (PDT)
Message-ID: <46f15897-da83-461d-b3bc-b0143fb1a4b0@linaro.org>
Date: Mon, 22 Jul 2024 14:06:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] util/fifo8: Expose fifo8_pop_buf()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240722160745.67904-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gNy8yMi8yNCAwOTowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEV4
dHJhY3QgZmlmbzhfcG9wX2J1ZigpIGZyb20gaHcvc2NzaS9lc3AuYyBhbmQgZXhwb3NlDQo+
IGl0IGFzIHBhcnQgb2YgdGhlIDxxZW11L2ZpZm84Lmg+IEFQSS4gVGhpcyBmdW5jdGlvbiB0
YWtlcw0KPiBjYXJlIG9mIG5vbi1jb250aWd1b3VzICh3cmFwcGVkKSBGSUZPIGJ1ZmZlciAo
d2hpY2ggaXMgYW4NCj4gaW1wbGVtZW50YXRpb24gZGV0YWlsKS4NCj4gDQo+IFN1Z2dlc3Rl
ZC1ieTogTWFyayBDYXZlLUF5bGFuZCA8bWFyay5jYXZlLWF5bGFuZEBpbGFuZGUuY28udWs+
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L2ZpZm84LmggfCAxNCArKysrKysr
KysrKysrKw0KPiAgIGh3L3Njc2kvZXNwLmMgICAgICAgIHwgMzYgKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgdXRpbC9maWZvOC5jICAgICAgICAgfCAyOSAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgNDYg
aW5zZXJ0aW9ucygrKSwgMzMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9xZW11L2ZpZm84LmggYi9pbmNsdWRlL3FlbXUvZmlmbzguaA0KPiBpbmRleCA2ODY5
MThhM2E0Li4yMWM3YTIyOTM3IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvZmlmbzgu
aA0KPiArKysgYi9pbmNsdWRlL3FlbXUvZmlmbzguaA0KPiBAQCAtNjIsNiArNjIsMjAgQEAg
dm9pZCBmaWZvOF9wdXNoX2FsbChGaWZvOCAqZmlmbywgY29uc3QgdWludDhfdCAqZGF0YSwg
dWludDMyX3QgbnVtKTsNCj4gICAgKi8NCj4gICB1aW50OF90IGZpZm84X3BvcChGaWZvOCAq
Zmlmbyk7DQo+ICAgDQo+ICsvKioNCj4gKyAqIGZpZm84X3BvcF9idWY6DQo+ICsgKiBAZmlm
bzogRklGTyB0byBwb3AgZnJvbQ0KPiArICogQGRlc3Q6IHRoZSBidWZmZXIgdG8gd3JpdGUg
dGhlIGRhdGEgaW50byAoY2FuIGJlIE5VTEwpDQo+ICsgKiBAZGVzdGxlbjogc2l6ZSBvZiBA
ZGVzdCBhbmQgbWF4aW11bSBudW1iZXIgb2YgYnl0ZXMgdG8gcG9wDQo+ICsgKg0KPiArICog
UG9wIGEgbnVtYmVyIG9mIGVsZW1lbnRzIGZyb20gdGhlIEZJRk8gdXAgdG8gYSBtYXhpbXVt
IG9mIEBkZXN0bGVuLg0KPiArICogVGhlIHBvcHBlZCBkYXRhIGlzIGNvcGllZCBpbnRvIHRo
ZSBAZGVzdCBidWZmZXIuDQo+ICsgKiBDYXJlIGlzIHRha2VuIHdoZW4gdGhlIGRhdGEgd3Jh
cHMgYXJvdW5kIGluIHRoZSByaW5nIGJ1ZmZlci4NCj4gKyAqDQo+ICsgKiBSZXR1cm5zOiBu
dW1iZXIgb2YgYnl0ZXMgcG9wcGVkLg0KPiArICovDQo+ICt1aW50MzJfdCBmaWZvOF9wb3Bf
YnVmKEZpZm84ICpmaWZvLCB1aW50OF90ICpkZXN0LCB1aW50MzJfdCBkZXN0bGVuKTsNCj4g
Kw0KPiAgIC8qKg0KPiAgICAqIGZpZm84X3BvcF9jb25zdGJ1ZjoNCj4gICAgKiBAZmlmbzog
RklGTyB0byBwb3AgZnJvbQ0KPiBkaWZmIC0tZ2l0IGEvaHcvc2NzaS9lc3AuYyBiL2h3L3Nj
c2kvZXNwLmMNCj4gaW5kZXggNjQzODRmOWIwZS4uY2VjODQ3YjU0YSAxMDA2NDQNCj4gLS0t
IGEvaHcvc2NzaS9lc3AuYw0KPiArKysgYi9ody9zY3NpL2VzcC5jDQo+IEBAIC0xOTcsMzkg
KzE5Nyw5IEBAIHN0YXRpYyB1aW50OF90IGVzcF9maWZvX3BvcChFU1BTdGF0ZSAqcykNCj4g
ICAgICAgcmV0dXJuIHZhbDsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgdWludDMyX3QgZXNw
X2ZpZm84X3BvcF9idWYoRmlmbzggKmZpZm8sIHVpbnQ4X3QgKmRlc3QsIGludCBtYXhsZW4p
DQo+IC17DQo+IC0gICAgY29uc3QgdWludDhfdCAqYnVmOw0KPiAtICAgIHVpbnQzMl90IG4s
IG4yOw0KPiAtICAgIGludCBsZW47DQo+IC0NCj4gLSAgICBpZiAobWF4bGVuID09IDApIHsN
Cj4gLSAgICAgICAgcmV0dXJuIDA7DQo+IC0gICAgfQ0KPiAtDQo+IC0gICAgbGVuID0gbWF4
bGVuOw0KPiAtICAgIGJ1ZiA9IGZpZm84X3BvcF9jb25zdGJ1ZihmaWZvLCBsZW4sICZuKTsN
Cj4gLSAgICBpZiAoZGVzdCkgew0KPiAtICAgICAgICBtZW1jcHkoZGVzdCwgYnVmLCBuKTsN
Cj4gLSAgICB9DQo+IC0NCj4gLSAgICAvKiBBZGQgRklGTyB3cmFwYXJvdW5kIGlmIG5lZWRl
ZCAqLw0KPiAtICAgIGxlbiAtPSBuOw0KPiAtICAgIGxlbiA9IE1JTihsZW4sIGZpZm84X251
bV91c2VkKGZpZm8pKTsNCj4gLSAgICBpZiAobGVuKSB7DQo+IC0gICAgICAgIGJ1ZiA9IGZp
Zm84X3BvcF9jb25zdGJ1ZihmaWZvLCBsZW4sICZuMik7DQo+IC0gICAgICAgIGlmIChkZXN0
KSB7DQo+IC0gICAgICAgICAgICBtZW1jcHkoJmRlc3Rbbl0sIGJ1ZiwgbjIpOw0KPiAtICAg
ICAgICB9DQo+IC0gICAgICAgIG4gKz0gbjI7DQo+IC0gICAgfQ0KPiAtDQo+IC0gICAgcmV0
dXJuIG47DQo+IC19DQo+IC0NCj4gICBzdGF0aWMgdWludDMyX3QgZXNwX2ZpZm9fcG9wX2J1
ZihFU1BTdGF0ZSAqcywgdWludDhfdCAqZGVzdCwgaW50IG1heGxlbikNCj4gICB7DQo+IC0g
ICAgdWludDMyX3QgbGVuID0gZXNwX2ZpZm84X3BvcF9idWYoJnMtPmZpZm8sIGRlc3QsIG1h
eGxlbik7DQo+ICsgICAgdWludDMyX3QgbGVuID0gZmlmbzhfcG9wX2J1Zigmcy0+Zmlmbywg
ZGVzdCwgbWF4bGVuKTsNCj4gICANCj4gICAgICAgZXNwX3VwZGF0ZV9kcnEocyk7DQo+ICAg
ICAgIHJldHVybiBsZW47DQo+IEBAIC0zMzUsNyArMzA1LDcgQEAgc3RhdGljIHZvaWQgZG9f
Y29tbWFuZF9waGFzZShFU1BTdGF0ZSAqcykNCj4gICAgICAgaWYgKCFjbWRsZW4gfHwgIXMt
PmN1cnJlbnRfZGV2KSB7DQo+ICAgICAgICAgICByZXR1cm47DQo+ICAgICAgIH0NCj4gLSAg
ICBlc3BfZmlmbzhfcG9wX2J1Zigmcy0+Y21kZmlmbywgYnVmLCBjbWRsZW4pOw0KPiArICAg
IGZpZm84X3BvcF9idWYoJnMtPmNtZGZpZm8sIGJ1ZiwgY21kbGVuKTsNCj4gICANCj4gICAg
ICAgY3VycmVudF9sdW4gPSBzY3NpX2RldmljZV9maW5kKCZzLT5idXMsIDAsIHMtPmN1cnJl
bnRfZGV2LT5pZCwgcy0+bHVuKTsNCj4gICAgICAgaWYgKCFjdXJyZW50X2x1bikgew0KPiBA
QCAtMzgxLDcgKzM1MSw3IEBAIHN0YXRpYyB2b2lkIGRvX21lc3NhZ2VfcGhhc2UoRVNQU3Rh
dGUgKnMpDQo+ICAgICAgIC8qIElnbm9yZSBleHRlbmRlZCBtZXNzYWdlcyBmb3Igbm93ICov
DQo+ICAgICAgIGlmIChzLT5jbWRmaWZvX2NkYl9vZmZzZXQpIHsNCj4gICAgICAgICAgIGlu
dCBsZW4gPSBNSU4ocy0+Y21kZmlmb19jZGJfb2Zmc2V0LCBmaWZvOF9udW1fdXNlZCgmcy0+
Y21kZmlmbykpOw0KPiAtICAgICAgICBlc3BfZmlmbzhfcG9wX2J1Zigmcy0+Y21kZmlmbywg
TlVMTCwgbGVuKTsNCj4gKyAgICAgICAgZmlmbzhfcG9wX2J1Zigmcy0+Y21kZmlmbywgTlVM
TCwgbGVuKTsNCj4gICAgICAgICAgIHMtPmNtZGZpZm9fY2RiX29mZnNldCA9IDA7DQo+ICAg
ICAgIH0NCj4gICB9DQo+IGRpZmYgLS1naXQgYS91dGlsL2ZpZm84LmMgYi91dGlsL2ZpZm84
LmMNCj4gaW5kZXggMzFmMGQzNGMwYy4uNjYxMGI3OTE4MiAxMDA2NDQNCj4gLS0tIGEvdXRp
bC9maWZvOC5jDQo+ICsrKyBiL3V0aWwvZmlmbzguYw0KPiBAQCAtMTAyLDYgKzEwMiwzNSBA
QCBjb25zdCB1aW50OF90ICpmaWZvOF9wb3BfY29uc3RidWYoRmlmbzggKmZpZm8sIHVpbnQz
Ml90IG1heCwgdWludDMyX3QgKm51bXB0cikNCj4gICAgICAgcmV0dXJuIGZpZm84X3BlZWtw
b3BfYnVmKGZpZm8sIG1heCwgbnVtcHRyLCB0cnVlKTsNCj4gICB9DQo+ICAgDQo+ICt1aW50
MzJfdCBmaWZvOF9wb3BfYnVmKEZpZm84ICpmaWZvLCB1aW50OF90ICpkZXN0LCB1aW50MzJf
dCBkZXN0bGVuKQ0KPiArew0KPiArICAgIGNvbnN0IHVpbnQ4X3QgKmJ1ZjsNCj4gKyAgICB1
aW50MzJfdCBuMSwgbjIgPSAwOw0KPiArICAgIHVpbnQzMl90IGxlbjsNCj4gKw0KPiArICAg
IGlmIChkZXN0bGVuID09IDApIHsNCj4gKyAgICAgICAgcmV0dXJuIDA7DQo+ICsgICAgfQ0K
PiArDQo+ICsgICAgbGVuID0gZGVzdGxlbjsNCj4gKyAgICBidWYgPSBmaWZvOF9wb3BfY29u
c3RidWYoZmlmbywgbGVuLCAmbjEpOw0KPiArICAgIGlmIChkZXN0KSB7DQo+ICsgICAgICAg
IG1lbWNweShkZXN0LCBidWYsIG4xKTsNCj4gKyAgICB9DQo+ICsNCj4gKyAgICAvKiBBZGQg
RklGTyB3cmFwYXJvdW5kIGlmIG5lZWRlZCAqLw0KPiArICAgIGxlbiAtPSBuMTsNCj4gKyAg
ICBsZW4gPSBNSU4obGVuLCBmaWZvOF9udW1fdXNlZChmaWZvKSk7DQo+ICsgICAgaWYgKGxl
bikgew0KPiArICAgICAgICBidWYgPSBmaWZvOF9wb3BfY29uc3RidWYoZmlmbywgbGVuLCAm
bjIpOw0KPiArICAgICAgICBpZiAoZGVzdCkgew0KPiArICAgICAgICAgICAgbWVtY3B5KCZk
ZXN0W24xXSwgYnVmLCBuMik7DQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICsNCj4gKyAg
ICByZXR1cm4gbjEgKyBuMjsNCj4gK30NCj4gKw0KPiAgIGJvb2wgZmlmbzhfaXNfZW1wdHko
RmlmbzggKmZpZm8pDQo+ICAgew0KPiAgICAgICByZXR1cm4gKGZpZm8tPm51bSA9PSAwKTsN
Cg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCg==

