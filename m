Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43B6C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0Cq-0000rV-Po; Mon, 22 Jul 2024 17:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0Cp-0000mb-A9
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:04:27 -0400
Received: from mail-io1-xd35.google.com ([2607:f8b0:4864:20::d35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0Cm-0004lm-D5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:04:27 -0400
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7f70a708f8aso193335839f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682261; x=1722287061; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6nLJb7N3tCi8KVBa4iIQwt+e6N/HkGEFo0szuSgBsCY=;
 b=ZH972q1UiPUVsM1clk8oMmOSJxM/5pxfIddhbtzz+MJqEyVLTUZJcVbtkGDRFjMmWm
 W1AiCmywWK6BaIIER+cYfPLr4vQRJ7GRsZUftpjyG0JdMSa4jk7u+N9RxLcgEDrSWg6L
 hZIIzRMQH8HjzXINsg+SzXihvjAjBV3lhx2kXczDPjQ80rsd1FHdixDj0iGv7KwZ0rKt
 5sBLiCu/BhwedC+PfaC44ZAthcqELhMFRZLvVq6eSpUtGIrVCC9lt0ia5EOPlssF63bz
 47dpUp/jkzw3EP/bUQ/F3vBYy3k/KStZAtz/c8VOz823Xy7NVNumigrDdIMe/yPt1MEP
 0Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682261; x=1722287061;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6nLJb7N3tCi8KVBa4iIQwt+e6N/HkGEFo0szuSgBsCY=;
 b=cs2mC6GlQNJSlulJPBmY0+AxhTqnZ/TySwmHXusV6p/pr0wfRWrMq6mATgxTt6Cj2x
 nGoH0pawuuYNX8kgLQCgFoDEeyVJ5oUtC91bNARz6BtiCoNA01/q0vfb/uCVN3rW+4LB
 UOzLIrubmd53Hx/GKl4J14iJXoOEJvoP3mEf8FnExYAaWXpt9D6gNe695eI9MDsBKfOa
 FCDZWCIdEPe1XMHzZ2v3itOXtd6gql5L5whzJu+cojertVOh75/LVmDzi+oSfJ/+Kirp
 qenF3nOhqMmFJWFVRf8xoS5H04PsU/0PWqKUNLxhrVC8Ma47nWhHSpSzdmaYuWwnuiSc
 v7pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe/5ubDpFGzyzK4Ae4cCs2N8Ht2xQOGMOdBJI/i7qNEjCj9uSqM8+8PGfBsj6zRVQRIR6D+x7R3b9RCs21ya0P1AMMEp8=
X-Gm-Message-State: AOJu0YzCsyqna7kb1dsnNmYqqxZkv+SjxsPHb68L5m3DHyIwVkUH5ulN
 RmZJq6REBVIiwmuvazx+TS6glaQDH2E2EdOXSFPQAZml96CT2rr5sN8tSTCPs6o=
X-Google-Smtp-Source: AGHT+IHdvqAxQIAkfS3GC2lfDB+NkFaAIzJsBH5urxZmxW8c5V97a+XQfVxrJPT1TqMTl4rzK3soxQ==
X-Received: by 2002:a05:6602:400a:b0:7eb:89ba:44fe with SMTP id
 ca18e2360f4ac-81ea5349eb4mr139924639f.17.1721682261029; 
 Mon, 22 Jul 2024 14:04:21 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d23f325d1sm2636421b3a.25.2024.07.22.14.04.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:04:20 -0700 (PDT)
Message-ID: <07a4849e-aab4-4341-828b-ef4908da0ca9@linaro.org>
Date: Mon, 22 Jul 2024 14:04:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] util/fifo8: Fix style
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240722160745.67904-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::d35;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-io1-xd35.google.com
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

T24gNy8yMi8yNCAwOTowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFNp
Z25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9xZW11L2ZpZm84LmggfCAyMiArKysrKystLS0tLS0t
LS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2ZpZm84LmggYi9p
bmNsdWRlL3FlbXUvZmlmbzguaA0KPiBpbmRleCBjNjI5NWM2ZmYwLi4yNjkyZDZiZmRhIDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL3FlbXUvZmlmbzguaA0KPiArKysgYi9pbmNsdWRlL3Fl
bXUvZmlmbzguaA0KPiBAQCAtMTUsMTAgKzE1LDkgQEAgdHlwZWRlZiBzdHJ1Y3Qgew0KPiAg
ICAqIEBmaWZvOiBzdHJ1Y3QgRmlmbzggdG8gaW5pdGlhbGlzZSB3aXRoIG5ldyBGSUZPDQo+
ICAgICogQGNhcGFjaXR5OiBjYXBhY2l0eSBvZiB0aGUgbmV3bHkgY3JlYXRlZCBGSUZPDQo+
ICAgICoNCj4gLSAqIENyZWF0ZSBhIEZJRk8gb2YgdGhlIHNwZWNpZmllZCBzaXplLiBDbGll
bnRzIHNob3VsZCBjYWxsIGZpZm84X2Rlc3Ryb3koKQ0KPiArICogQ3JlYXRlIGEgRklGTyBv
ZiB0aGUgc3BlY2lmaWVkIGNhcGFjaXR5LiBDbGllbnRzIHNob3VsZCBjYWxsIGZpZm84X2Rl
c3Ryb3koKQ0KPiAgICAqIHdoZW4gZmluaXNoZWQgdXNpbmcgdGhlIGZpZm8uIFRoZSBGSUZP
IGlzIGluaXRpYWxseSBlbXB0eS4NCj4gICAgKi8NCj4gLQ0KPiAgIHZvaWQgZmlmbzhfY3Jl
YXRlKEZpZm84ICpmaWZvLCB1aW50MzJfdCBjYXBhY2l0eSk7DQo+ICAgDQo+ICAgLyoqDQo+
IEBAIC0yNiw5ICsyNSw4IEBAIHZvaWQgZmlmbzhfY3JlYXRlKEZpZm84ICpmaWZvLCB1aW50
MzJfdCBjYXBhY2l0eSk7DQo+ICAgICogQGZpZm86IEZJRk8gdG8gY2xlYW51cA0KPiAgICAq
DQo+ICAgICogQ2xlYW51cCBhIEZJRk8gY3JlYXRlZCB3aXRoIGZpZm84X2NyZWF0ZSgpLiBG
cmVlcyBtZW1vcnkgY3JlYXRlZCBmb3IgRklGTw0KPiAtICAqc3RvcmFnZS4gVGhlIEZJRk8g
aXMgbm8gbG9uZ2VyIHVzYWJsZSBhZnRlciB0aGlzIGhhcyBiZWVuIGNhbGxlZC4NCj4gKyAq
IHN0b3JhZ2UuIFRoZSBGSUZPIGlzIG5vIGxvbmdlciB1c2FibGUgYWZ0ZXIgdGhpcyBoYXMg
YmVlbiBjYWxsZWQuDQo+ICAgICovDQo+IC0NCj4gICB2b2lkIGZpZm84X2Rlc3Ryb3koRmlm
bzggKmZpZm8pOw0KPiAgIA0KPiAgIC8qKg0KPiBAQCAtMzksNyArMzcsNiBAQCB2b2lkIGZp
Zm84X2Rlc3Ryb3koRmlmbzggKmZpZm8pOw0KPiAgICAqIFB1c2ggYSBkYXRhIGJ5dGUgdG8g
dGhlIEZJRk8uIEJlaGF2aW91ciBpcyB1bmRlZmluZWQgaWYgdGhlIEZJRk8gaXMgZnVsbC4N
Cj4gICAgKiBDbGllbnRzIGFyZSByZXNwb25zaWJsZSBmb3IgY2hlY2tpbmcgZm9yIGZ1bGxu
ZXNzIHVzaW5nIGZpZm84X2lzX2Z1bGwoKS4NCj4gICAgKi8NCj4gLQ0KPiAgIHZvaWQgZmlm
bzhfcHVzaChGaWZvOCAqZmlmbywgdWludDhfdCBkYXRhKTsNCj4gICANCj4gICAvKioNCj4g
QEAgLTUyLDcgKzQ5LDYgQEAgdm9pZCBmaWZvOF9wdXNoKEZpZm84ICpmaWZvLCB1aW50OF90
IGRhdGEpOw0KPiAgICAqIENsaWVudHMgYXJlIHJlc3BvbnNpYmxlIGZvciBjaGVja2luZyB0
aGUgc3BhY2UgbGVmdCBpbiB0aGUgRklGTyB1c2luZw0KPiAgICAqIGZpZm84X251bV9mcmVl
KCkuDQo+ICAgICovDQo+IC0NCj4gICB2b2lkIGZpZm84X3B1c2hfYWxsKEZpZm84ICpmaWZv
LCBjb25zdCB1aW50OF90ICpkYXRhLCB1aW50MzJfdCBudW0pOw0KPiAgIA0KPiAgIC8qKg0K
PiBAQCAtNjQsNyArNjAsNiBAQCB2b2lkIGZpZm84X3B1c2hfYWxsKEZpZm84ICpmaWZvLCBj
b25zdCB1aW50OF90ICpkYXRhLCB1aW50MzJfdCBudW0pOw0KPiAgICAqDQo+ICAgICogUmV0
dXJuczogVGhlIHBvcHBlZCBkYXRhIGJ5dGUuDQo+ICAgICovDQo+IC0NCj4gICB1aW50OF90
IGZpZm84X3BvcChGaWZvOCAqZmlmbyk7DQo+ICAgDQo+ICAgLyoqDQo+IEBAIC03Myw3ICs2
OCw3IEBAIHVpbnQ4X3QgZmlmbzhfcG9wKEZpZm84ICpmaWZvKTsNCj4gICAgKiBAbWF4OiBt
YXhpbXVtIG51bWJlciBvZiBieXRlcyB0byBwb3ANCj4gICAgKiBAbnVtcHRyOiBwb2ludGVy
IGZpbGxlZCB3aXRoIG51bWJlciBvZiBieXRlcyByZXR1cm5lZCAoY2FuIGJlIE5VTEwpDQo+
ICAgICoNCj4gLSAqIFBvcCBhIG51bWJlciBvZiBlbGVtZW50cyBmcm9tIHRoZSBGSUZPIHVw
IHRvIGEgbWF4aW11bSBvZiBtYXguIFRoZSBidWZmZXINCj4gKyAqIFBvcCBhIG51bWJlciBv
ZiBlbGVtZW50cyBmcm9tIHRoZSBGSUZPIHVwIHRvIGEgbWF4aW11bSBvZiBAbWF4LiBUaGUg
YnVmZmVyDQo+ICAgICogY29udGFpbmluZyB0aGUgcG9wcGVkIGRhdGEgaXMgcmV0dXJuZWQu
IFRoaXMgYnVmZmVyIHBvaW50cyBkaXJlY3RseSBpbnRvDQo+ICAgICogdGhlIEZJRk8gYmFj
a2luZyBzdG9yZSBhbmQgZGF0YSBpcyBpbnZhbGlkYXRlZCBvbmNlIGFueSBvZiB0aGUgZmlm
bzhfKiBBUElzDQo+ICAgICogYXJlIGNhbGxlZCBvbiB0aGUgRklGTy4NCj4gQEAgLTgyLDcg
Kzc3LDcgQEAgdWludDhfdCBmaWZvOF9wb3AoRmlmbzggKmZpZm8pOw0KPiAgICAqIGFyb3Vu
ZCBpbiB0aGUgcmluZyBidWZmZXI7IGluIHRoaXMgY2FzZSBvbmx5IGEgY29udGlndW91cyBw
YXJ0IG9mIHRoZSBkYXRhDQo+ICAgICogaXMgcmV0dXJuZWQuDQo+ICAgICoNCj4gLSAqIFRo
ZSBudW1iZXIgb2YgdmFsaWQgYnl0ZXMgcmV0dXJuZWQgaXMgcG9wdWxhdGVkIGluICpudW1w
dHI7IHdpbGwgYWx3YXlzDQo+ICsgKiBUaGUgbnVtYmVyIG9mIHZhbGlkIGJ5dGVzIHJldHVy
bmVkIGlzIHBvcHVsYXRlZCBpbiAqQG51bXB0cjsgd2lsbCBhbHdheXMNCj4gICAgKiByZXR1
cm4gYXQgbGVhc3QgMSBieXRlLiBtYXggbXVzdCBub3QgYmUgMCBvciBncmVhdGVyIHRoYW4g
dGhlIG51bWJlciBvZg0KPiAgICAqIGJ5dGVzIGluIHRoZSBGSUZPLg0KPiAgICAqDQo+IEBA
IC05OSw3ICs5NCw3IEBAIGNvbnN0IHVpbnQ4X3QgKmZpZm84X3BvcF9idWYoRmlmbzggKmZp
Zm8sIHVpbnQzMl90IG1heCwgdWludDMyX3QgKm51bXB0cik7DQo+ICAgICogQG1heDogbWF4
aW11bSBudW1iZXIgb2YgYnl0ZXMgdG8gcGVlaw0KPiAgICAqIEBudW1wdHI6IHBvaW50ZXIg
ZmlsbGVkIHdpdGggbnVtYmVyIG9mIGJ5dGVzIHJldHVybmVkIChjYW4gYmUgTlVMTCkNCj4g
ICAgKg0KPiAtICogUGVlayBpbnRvIGEgbnVtYmVyIG9mIGVsZW1lbnRzIGZyb20gdGhlIEZJ
Rk8gdXAgdG8gYSBtYXhpbXVtIG9mIG1heC4NCj4gKyAqIFBlZWsgaW50byBhIG51bWJlciBv
ZiBlbGVtZW50cyBmcm9tIHRoZSBGSUZPIHVwIHRvIGEgbWF4aW11bSBvZiBAbWF4Lg0KPiAg
ICAqIFRoZSBidWZmZXIgY29udGFpbmluZyB0aGUgZGF0YSBwZWVrZWQgaW50byBpcyByZXR1
cm5lZC4gVGhpcyBidWZmZXIgcG9pbnRzDQo+ICAgICogZGlyZWN0bHkgaW50byB0aGUgRklG
TyBiYWNraW5nIHN0b3JlLiBTaW5jZSBkYXRhIGlzIGludmFsaWRhdGVkIG9uY2UgYW55DQo+
ICAgICogb2YgdGhlIGZpZm84XyogQVBJcyBhcmUgY2FsbGVkIG9uIHRoZSBGSUZPLCBpdCBp
cyB0aGUgY2FsbGVyIHJlc3BvbnNpYmlsaXR5DQo+IEBAIC0xMDksNyArMTA0LDcgQEAgY29u
c3QgdWludDhfdCAqZmlmbzhfcG9wX2J1ZihGaWZvOCAqZmlmbywgdWludDMyX3QgbWF4LCB1
aW50MzJfdCAqbnVtcHRyKTsNCj4gICAgKiBhcm91bmQgaW4gdGhlIHJpbmcgYnVmZmVyOyBp
biB0aGlzIGNhc2Ugb25seSBhIGNvbnRpZ3VvdXMgcGFydCBvZiB0aGUgZGF0YQ0KPiAgICAq
IGlzIHJldHVybmVkLg0KPiAgICAqDQo+IC0gKiBUaGUgbnVtYmVyIG9mIHZhbGlkIGJ5dGVz
IHJldHVybmVkIGlzIHBvcHVsYXRlZCBpbiAqbnVtcHRyOyB3aWxsIGFsd2F5cw0KPiArICog
VGhlIG51bWJlciBvZiB2YWxpZCBieXRlcyByZXR1cm5lZCBpcyBwb3B1bGF0ZWQgaW4gKkBu
dW1wdHI7IHdpbGwgYWx3YXlzDQo+ICAgICogcmV0dXJuIGF0IGxlYXN0IDEgYnl0ZS4gbWF4
IG11c3Qgbm90IGJlIDAgb3IgZ3JlYXRlciB0aGFuIHRoZSBudW1iZXIgb2YNCj4gICAgKiBi
eXRlcyBpbiB0aGUgRklGTy4NCj4gICAgKg0KPiBAQCAtMTI2LDcgKzEyMSw2IEBAIGNvbnN0
IHVpbnQ4X3QgKmZpZm84X3BlZWtfYnVmKEZpZm84ICpmaWZvLCB1aW50MzJfdCBtYXgsIHVp
bnQzMl90ICpudW1wdHIpOw0KPiAgICAqDQo+ICAgICogUmVzZXQgYSBGSUZPLiBBbGwgZGF0
YSBpcyBkaXNjYXJkZWQgYW5kIHRoZSBGSUZPIGlzIGVtcHRpZWQuDQo+ICAgICovDQo+IC0N
Cj4gICB2b2lkIGZpZm84X3Jlc2V0KEZpZm84ICpmaWZvKTsNCj4gICANCj4gICAvKioNCj4g
QEAgLTEzNyw3ICsxMzEsNiBAQCB2b2lkIGZpZm84X3Jlc2V0KEZpZm84ICpmaWZvKTsNCj4g
ICAgKg0KPiAgICAqIFJldHVybnM6IFRydWUgaWYgdGhlIGZpZm8gaXMgZW1wdHksIGZhbHNl
IG90aGVyd2lzZS4NCj4gICAgKi8NCj4gLQ0KPiAgIGJvb2wgZmlmbzhfaXNfZW1wdHkoRmlm
bzggKmZpZm8pOw0KPiAgIA0KPiAgIC8qKg0KPiBAQCAtMTQ4LDcgKzE0MSw2IEBAIGJvb2wg
ZmlmbzhfaXNfZW1wdHkoRmlmbzggKmZpZm8pOw0KPiAgICAqDQo+ICAgICogUmV0dXJuczog
VHJ1ZSBpZiB0aGUgZmlmbyBpcyBmdWxsLCBmYWxzZSBvdGhlcndpc2UuDQo+ICAgICovDQo+
IC0NCj4gICBib29sIGZpZm84X2lzX2Z1bGwoRmlmbzggKmZpZm8pOw0KPiAgIA0KPiAgIC8q
Kg0KPiBAQCAtMTU5LDcgKzE1MSw2IEBAIGJvb2wgZmlmbzhfaXNfZnVsbChGaWZvOCAqZmlm
byk7DQo+ICAgICoNCj4gICAgKiBSZXR1cm5zOiBOdW1iZXIgb2YgZnJlZSBieXRlcy4NCj4g
ICAgKi8NCj4gLQ0KPiAgIHVpbnQzMl90IGZpZm84X251bV9mcmVlKEZpZm84ICpmaWZvKTsN
Cj4gICANCj4gICAvKioNCj4gQEAgLTE3MCw3ICsxNjEsNiBAQCB1aW50MzJfdCBmaWZvOF9u
dW1fZnJlZShGaWZvOCAqZmlmbyk7DQo+ICAgICoNCj4gICAgKiBSZXR1cm5zOiBOdW1iZXIg
b2YgdXNlZCBieXRlcy4NCj4gICAgKi8NCj4gLQ0KPiAgIHVpbnQzMl90IGZpZm84X251bV91
c2VkKEZpZm84ICpmaWZvKTsNCj4gICANCj4gICBleHRlcm4gY29uc3QgVk1TdGF0ZURlc2Ny
aXB0aW9uIHZtc3RhdGVfZmlmbzg7DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVy
IDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

