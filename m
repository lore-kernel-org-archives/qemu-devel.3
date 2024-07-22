Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E67C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0G7-0000C5-Gy; Mon, 22 Jul 2024 17:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0G0-00081G-VW
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:07:46 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0Fy-0005FT-MU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:07:43 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d9da46ca13so2641396b6e.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682461; x=1722287261; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8ZvVvX4ASDdz0l16oGL3z6D5T5GhEH+lvXkJHrnpwGY=;
 b=ELMZSQi+uG51v4FItabCfHoZI3QrQvxBHnXjElm0rKhH8Xj1kYNndvEFnFCd50CXyd
 eLrJkyTfY2dRarA9tXLOc860aOcLXlZErZ9tjIqOAOqPKKiSJD2DW9tCT2XkK2nAhElT
 oArEoFNPA3i32WiOAiVNrDoZtxfXlHSqmfjM6KqJjyu5uYKmuXgQtt9ghBPhtx72cIN/
 vprwcwjxHV73ahHuIISppSvnfEPovQI34/WhRCCQgTghOyC+IkuvuXOQJH/tqhQRMqAM
 gL7WjpCuZGz6QzeMueW5ipuZbZCc0LCiStY/3+S/d6G2k8oraz1iY5tqPNKWg3tntD0O
 A7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682461; x=1722287261;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8ZvVvX4ASDdz0l16oGL3z6D5T5GhEH+lvXkJHrnpwGY=;
 b=R+CkwAb8jL/C1SnXD0wc0hsM0PaUsT0fsBW6j6Z+5yxuRtBil3Za0p9zqP4UZC8baC
 34epzWugZXxuLsQ7G5/8RHySxJsC0QrpkcIJwdGRFssQK/CDQcqdGjgBlJac7DCej4qy
 YxKJlaHgxV17R65w+ylKolDF/hT0XOfF3ySdepHWXpbUI9xy0TOZviCj0YwkBU38sE5u
 Bush3WNE/sn6qmfSfWFYJZ7FD0IquFPGYWMne6cx7krnn3zPVXX+CluIjMkT98Yujbb/
 nvGFt78jRbWriIsE7MRMa+SNcaATsYfn2F6150TuYsBRuhMaRQmfF1rHw3MLG3blWXS7
 F2ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVESXJxDkiNzU57xeCu06st5Xyrn28XVn0vwMl0MQo4csIxM7ENXLPApsO/ZJhuC9VcN+ppykBmUj6bd32SYqeYQlK/EcY=
X-Gm-Message-State: AOJu0YxEG4H8hnbQooUN9VTiko2gAEYIRBKMQONy6i1IQhTFbpwxCa5U
 9IC7UlaLRARinXPg/f7bUTrQkWKi3FV4StQGGhsDqBUB3nKefB+iwJPl5xxlI/A=
X-Google-Smtp-Source: AGHT+IEfVlpeKXjBn4JwNfaaycIX6bXx6fz+qOI7HrfV85i9jehON6TbEII05AqYdqp59bXWdYDRIA==
X-Received: by 2002:a05:6808:f8b:b0:3d9:222e:40ac with SMTP id
 5614622812f47-3dafd43dfabmr1272378b6e.44.1721682460865; 
 Mon, 22 Jul 2024 14:07:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d21ab0cb4sm2768560b3a.130.2024.07.22.14.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:07:40 -0700 (PDT)
Message-ID: <acc83ab4-8787-481f-b5d8-a95cce98afea@linaro.org>
Date: Mon, 22 Jul 2024 14:07:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] util/fifo8: Introduce fifo8_discard()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-8-philmd@linaro.org>
 <18f7d975-617e-4791-b921-7df7c9ef2d1d@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <18f7d975-617e-4791-b921-7df7c9ef2d1d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::233;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x233.google.com
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

T24gNy8yMi8yNCAwOToxMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIyLzcvMjQgMTg6MDcsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gQWRk
IHRoZSBmaWZvOF9kaXNjYXJkKCkgaGVscGVyIGZvciBjbGFyaXR5Lg0KPj4gSXQgaXMgYSBz
aW1wbGUgd3JhcHBlciBvdmVyIGZpZm84X3BvcF9idWYoKS4NCj4+DQo+PiBTaWduZWQtb2Zm
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+PiAt
LS0NCj4+ICAgIGluY2x1ZGUvcWVtdS9maWZvOC5oIHwgOCArKysrKysrKw0KPj4gICAgaHcv
c2NzaS9lc3AuYyAgICAgICAgfCAyICstDQo+PiAgICB1dGlsL2ZpZm84LmMgICAgICAgICB8
IDYgKysrKysrDQo+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11L2ZpZm84Lmgg
Yi9pbmNsdWRlL3FlbXUvZmlmbzguaA0KPj4gaW5kZXggMjFjN2EyMjkzNy4uNTNiYWZhYmQy
NSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvcWVtdS9maWZvOC5oDQo+PiArKysgYi9pbmNs
dWRlL3FlbXUvZmlmbzguaA0KPj4gQEAgLTEyOSw2ICsxMjksMTQgQEAgY29uc3QgdWludDhf
dCAqZmlmbzhfcG9wX2NvbnN0YnVmKEZpZm84ICpmaWZvLCB1aW50MzJfdCBtYXgsIHVpbnQz
Ml90ICpudW1wdHIpOw0KPj4gICAgICovDQo+PiAgICBjb25zdCB1aW50OF90ICpmaWZvOF9w
ZWVrX2NvbnN0YnVmKEZpZm84ICpmaWZvLCB1aW50MzJfdCBtYXgsIHVpbnQzMl90ICpudW1w
dHIpOw0KPj4gICAgDQo+PiArLyoqDQo+PiArICogZmlmbzhfZGlzY2FyZDoNCj4+ICsgKiBA
ZmlmbzogRklGTyB0byBjb25zdW1lIGJ5dGVzDQo+PiArICoNCj4+ICsgKiBEaXNjYXJkIChj
b25zdW1lKSBieXRlcyBmcm9tIGEgRklGTy4NCj4+ICsgKi8NCj4+ICt2b2lkIGZpZm84X2Rp
c2NhcmQoRmlmbzggKmZpZm8sIHVpbnQzMl90IGxlbik7DQo+PiArDQo+PiAgICAvKioNCj4+
ICAgICAqIGZpZm84X3Jlc2V0Og0KPj4gICAgICogQGZpZm86IEZJRk8gdG8gcmVzZXQNCj4+
IGRpZmYgLS1naXQgYS9ody9zY3NpL2VzcC5jIGIvaHcvc2NzaS9lc3AuYw0KPj4gaW5kZXgg
Y2VjODQ3YjU0YS4uYzcwM2ZhNzM1MSAxMDA2NDQNCj4+IC0tLSBhL2h3L3Njc2kvZXNwLmMN
Cj4+ICsrKyBiL2h3L3Njc2kvZXNwLmMNCj4+IEBAIC0zNTEsNyArMzUxLDcgQEAgc3RhdGlj
IHZvaWQgZG9fbWVzc2FnZV9waGFzZShFU1BTdGF0ZSAqcykNCj4+ICAgICAgICAvKiBJZ25v
cmUgZXh0ZW5kZWQgbWVzc2FnZXMgZm9yIG5vdyAqLw0KPj4gICAgICAgIGlmIChzLT5jbWRm
aWZvX2NkYl9vZmZzZXQpIHsNCj4+ICAgICAgICAgICAgaW50IGxlbiA9IE1JTihzLT5jbWRm
aWZvX2NkYl9vZmZzZXQsIGZpZm84X251bV91c2VkKCZzLT5jbWRmaWZvKSk7DQo+PiAtICAg
ICAgICBmaWZvOF9wb3BfYnVmKCZzLT5jbWRmaWZvLCBOVUxMLCBsZW4pOw0KPj4gKyAgICAg
ICAgZmlmbzhfZGlzY2FyZCgmcy0+Y21kZmlmbywgbGVuKTsNCj4+ICAgICAgICAgICAgcy0+
Y21kZmlmb19jZGJfb2Zmc2V0ID0gMDsNCj4+ICAgICAgICB9DQo+PiAgICB9DQo+PiBkaWZm
IC0tZ2l0IGEvdXRpbC9maWZvOC5jIGIvdXRpbC9maWZvOC5jDQo+PiBpbmRleCA2NjEwYjc5
MTgyLi5lYTM5Y2EyNTUyIDEwMDY0NA0KPj4gLS0tIGEvdXRpbC9maWZvOC5jDQo+PiArKysg
Yi91dGlsL2ZpZm84LmMNCj4+IEBAIC0xMzEsNiArMTMxLDEyIEBAIHVpbnQzMl90IGZpZm84
X3BvcF9idWYoRmlmbzggKmZpZm8sIHVpbnQ4X3QgKmRlc3QsIHVpbnQzMl90IGRlc3RsZW4p
DQo+PiAgICAgICAgcmV0dXJuIG4xICsgbjI7DQo+PiAgICB9DQo+PiAgICANCj4+ICt2b2lk
IGZpZm84X2NvbnN1bWUoRmlmbzggKmZpZm8sIHVpbnQzMl90IGxlbikNCj4gDQo+IFNvcnJ5
LCBmb3Jnb3QgdG8gcy9maWZvOF9jb25zdW1lL2ZpZm84X2Rpc2NhcmQvLg0KPiANCj4+ICt7
DQo+PiArICAgIGxlbiAtPSBmaWZvOF9wb3BfYnVmKGZpZm8sIE5VTEwsIGxlbik7DQo+PiAr
ICAgIGFzc2VydChsZW4gPT0gMCk7DQo+PiArfQ0KPj4gKw0KPj4gICAgYm9vbCBmaWZvOF9p
c19lbXB0eShGaWZvOCAqZmlmbykNCj4+ICAgIHsNCj4+ICAgICAgICByZXR1cm4gKGZpZm8t
Pm51bSA9PSAwKTsNCj4gDQo+IA0KDQp3aXRoIHRoaXMgZml4LA0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

