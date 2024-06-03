Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73178C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 18:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECr9-0006E8-5M; Mon, 03 Jun 2024 14:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECr7-0006Bo-7H
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:56:29 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECr5-00054K-Ct
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:56:28 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-24c9f73ccaaso2754219fac.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 11:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717440985; x=1718045785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gIkTJxh2QlSLCsSwqp0raz9m/lE0MujGqpd1YakGjRY=;
 b=JWB/2kCvHpx3zLrq0KyeQp25tCpAxezuBLyRn8wxQr6UIC7GnujScYS91IJLJ3fpPL
 MS7vWudzRQ4TFCTQUQBVb/UdmrqyZ4o3cGMCdyfMA7cIt9Aey2pADe+Do2aXMh+2GbPL
 09WliWdOcNc3fED4+odrMHTDYvHQSuvoNf1gE5u/exPt5GeaAtAV4Pir0FTCNOfUxyIo
 ++a5NaoFXHe41a2uX4ObyKZaMGdRD9xoATtaVQgA0VCYGcQVMMwHnBZqGewHM+tZnZ7u
 XmeqpAbYPtTPNbhZptM3jfaNKsTEknaqHOn6qqs7RWsXn5GZ1sRlOZVdjVqgKe7NZZ5S
 iCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717440985; x=1718045785;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gIkTJxh2QlSLCsSwqp0raz9m/lE0MujGqpd1YakGjRY=;
 b=JCA8g5fvGGpTSgNqBR0T6cDt70OsvGuzsiQ8/CuLyLGnHW9r6e5BjwBsG0QZwiljqD
 dw5Knv1keNBDqgfpBQdV2mtXzAD4ezw2F4bGeckn1AJ0oRhBdN7FLmqs+f2XibeNa9lX
 YB9KSi0gP1aMyad3Nu6uUp6LoofYJRR/mnabhWeCjb4jGfRqL3zcVfIRhW3HzoGltiAX
 5REowRvymBHETuJwJKi58zkG86SUewegliSZaIXdEAHdOdKMZvUGE2bbuSvl+u0q47xn
 tavqAbfvBF23R300EwWtjeFjFymIv85sQtoPHSSuoLTe1aNCi4w0nkaEP1noTPWmexoy
 YxfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZbKha94EEUpQsUAexUap+eKLYpE6Q4BOUXT0Eex3V+3A9CcrJF9HrN9vtw8VLKZpqJiBil2Bs6PimVmtfGHWlsfEbMOg=
X-Gm-Message-State: AOJu0YzRPf3Dmn5Ipz6UeF1G360O/k+u3dLcQofAgfxEugt2dBBERr+a
 A1fsHyFqJsZwYTchaHaNSdoiOn+J0m7FJrQ5NlLFYcXcBowAWQRZITWHXZbHuQU=
X-Google-Smtp-Source: AGHT+IFqCWulEyxiiFnKLA7XRsufyN4sMvtqpHJ568ouZl5lleBYVPI70BFzWv4exXYY3Ofj+Yy6CQ==
X-Received: by 2002:a05:6870:b52b:b0:24f:d227:1186 with SMTP id
 586e51a60fabf-2508bb11285mr11916532fac.34.1717440984953; 
 Mon, 03 Jun 2024 11:56:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6c355cd8896sm5715621a12.48.2024.06.03.11.56.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 11:56:24 -0700 (PDT)
Message-ID: <9f2f8d33-def2-41c8-a8fd-2cc018f67061@linaro.org>
Date: Mon, 3 Jun 2024 11:56:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/27] hw/mips/malta: Add re-usable rng_seed_hex_new()
 method
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x33.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gNC8xMi8yNCAwMDozMywgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IEZyb206IFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gDQo+IHNwcmlu
dGYoKSBpcyBkZXByZWNhdGVkIG9uIERhcndpbiBzaW5jZSBtYWNPUyAxMy4wIC8gWENvZGUg
MTQuMS4NCj4gDQo+IEV4dHJhY3QgY29tbW9uIGNvZGUgZnJvbSByZWluaXRpYWxpemVfcm5n
X3NlZWQgYW5kIGxvYWRfa2VybmVsDQo+IHRvIHJuZ19zZWVkX2hleF9uZXcuICBVc2luZyBx
ZW11X2hleGR1bXBfbGluZSBib3RoIGZpeGVzIHRoZQ0KPiBkZXByZWNhdGlvbiB3YXJuaW5n
IGFuZCBzaW1wbGlmaWVzIHRoZSBjb2RlIGJhc2UuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQ
aGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IFtydGg6IFVz
ZSBxZW11X2hleGR1bXBfbGluZS5dDQo+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVy
c29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBody9taXBz
L21hbHRhLmMgfCAyNSArKysrKysrKysrKysrLS0tLS0tLS0tLS0tDQo+ICAgMSBmaWxlIGNo
YW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L21pcHMvbWFsdGEuYyBiL2h3L21pcHMvbWFsdGEuYw0KPiBpbmRleCBhZjc0
MDA4YzgyLi42NjRhMmFlMGE5IDEwMDY0NA0KPiAtLS0gYS9ody9taXBzL21hbHRhLmMNCj4g
KysrIGIvaHcvbWlwcy9tYWx0YS5jDQo+IEBAIC0yNiw2ICsyNiw3IEBADQo+ICAgI2luY2x1
ZGUgInFlbXUvdW5pdHMuaCINCj4gICAjaW5jbHVkZSAicWVtdS9iaXRvcHMuaCINCj4gICAj
aW5jbHVkZSAicWVtdS9kYXRhZGlyLmgiDQo+ICsjaW5jbHVkZSAicWVtdS9jdXRpbHMuaCIN
Cj4gICAjaW5jbHVkZSAicWVtdS9ndWVzdC1yYW5kb20uaCINCj4gICAjaW5jbHVkZSAiaHcv
Y2xvY2suaCINCj4gICAjaW5jbHVkZSAiaHcvc291dGhicmlkZ2UvcGlpeC5oIg0KPiBAQCAt
ODUwLDE1ICs4NTEsMTggQEAgc3RhdGljIHZvaWQgR19HTlVDX1BSSU5URigzLCA0KSBwcm9t
X3NldCh1aW50MzJfdCAqcHJvbV9idWYsIGludCBpbmRleCwNCj4gICAgICAgdmFfZW5kKGFw
KTsNCj4gICB9DQo+ICAgDQo+IC1zdGF0aWMgdm9pZCByZWluaXRpYWxpemVfcm5nX3NlZWQo
dm9pZCAqb3BhcXVlKQ0KPiArc3RhdGljIEdTdHJpbmcgKnJuZ19zZWVkX2hleF9uZXcodm9p
ZCkNCj4gICB7DQo+IC0gICAgY2hhciAqcm5nX3NlZWRfaGV4ID0gb3BhcXVlOw0KPiAgICAg
ICB1aW50OF90IHJuZ19zZWVkWzMyXTsNCj4gICANCj4gICAgICAgcWVtdV9ndWVzdF9nZXRy
YW5kb21fbm9mYWlsKHJuZ19zZWVkLCBzaXplb2Yocm5nX3NlZWQpKTsNCj4gLSAgICBmb3Ig
KHNpemVfdCBpID0gMDsgaSA8IHNpemVvZihybmdfc2VlZCk7ICsraSkgew0KPiAtICAgICAg
ICBzcHJpbnRmKHJuZ19zZWVkX2hleCArIGkgKiAyLCAiJTAyeCIsIHJuZ19zZWVkW2ldKTsN
Cj4gLSAgICB9DQo+ICsgICAgcmV0dXJuIHFlbXVfaGV4ZHVtcF9saW5lKE5VTEwsIHJuZ19z
ZWVkLCBzaXplb2Yocm5nX3NlZWQpLCAwLCAwKTsNCj4gK30NCj4gKw0KPiArc3RhdGljIHZv
aWQgcmVpbml0aWFsaXplX3JuZ19zZWVkKHZvaWQgKm9wYXF1ZSkNCj4gK3sNCj4gKyAgICBn
X2F1dG9wdHIoR1N0cmluZykgaGV4ID0gcm5nX3NlZWRfaGV4X25ldygpOw0KPiArICAgIG1l
bWNweShvcGFxdWUsIGhleC0+c3RyLCBoZXgtPmxlbik7DQo+ICAgfQ0KPiAgIA0KPiAgIC8q
IEtlcm5lbCAqLw0KPiBAQCAtODcwLDggKzg3NCw2IEBAIHN0YXRpYyB1aW50NjRfdCBsb2Fk
X2tlcm5lbCh2b2lkKQ0KPiAgICAgICB1aW50MzJfdCAqcHJvbV9idWY7DQo+ICAgICAgIGxv
bmcgcHJvbV9zaXplOw0KPiAgICAgICBpbnQgcHJvbV9pbmRleCA9IDA7DQo+IC0gICAgdWlu
dDhfdCBybmdfc2VlZFszMl07DQo+IC0gICAgY2hhciBybmdfc2VlZF9oZXhbc2l6ZW9mKHJu
Z19zZWVkKSAqIDIgKyAxXTsNCj4gICAgICAgc2l6ZV90IHJuZ19zZWVkX3Byb21fb2Zmc2V0
Ow0KPiAgIA0KPiAgICAgICBrZXJuZWxfc2l6ZSA9IGxvYWRfZWxmKGxvYWRlcnBhcmFtcy5r
ZXJuZWxfZmlsZW5hbWUsIE5VTEwsDQo+IEBAIC05NDYsMTQgKzk0OCwxMyBAQCBzdGF0aWMg
dWludDY0X3QgbG9hZF9rZXJuZWwodm9pZCkNCj4gICAgICAgcHJvbV9zZXQocHJvbV9idWYs
IHByb21faW5kZXgrKywgIm1vZGV0dHkwIik7DQo+ICAgICAgIHByb21fc2V0KHByb21fYnVm
LCBwcm9tX2luZGV4KyssICIzODQwMG44ciIpOw0KPiAgIA0KPiAtICAgIHFlbXVfZ3Vlc3Rf
Z2V0cmFuZG9tX25vZmFpbChybmdfc2VlZCwgc2l6ZW9mKHJuZ19zZWVkKSk7DQo+IC0gICAg
Zm9yIChzaXplX3QgaSA9IDA7IGkgPCBzaXplb2Yocm5nX3NlZWQpOyArK2kpIHsNCj4gLSAg
ICAgICAgc3ByaW50Zihybmdfc2VlZF9oZXggKyBpICogMiwgIiUwMngiLCBybmdfc2VlZFtp
XSk7DQo+IC0gICAgfQ0KPiAgICAgICBwcm9tX3NldChwcm9tX2J1ZiwgcHJvbV9pbmRleCsr
LCAicm5nc2VlZCIpOw0KPiAgICAgICBybmdfc2VlZF9wcm9tX29mZnNldCA9IHByb21faW5k
ZXggKiBFTlZQX0VOVFJZX1NJWkUgKw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHNpemVvZih1aW50MzJfdCkgKiBFTlZQX05CX0VOVFJJRVM7DQo+IC0gICAgcHJvbV9zZXQo
cHJvbV9idWYsIHByb21faW5kZXgrKywgIiVzIiwgcm5nX3NlZWRfaGV4KTsNCj4gKyAgICB7
DQo+ICsgICAgICAgIGdfYXV0b3B0cihHU3RyaW5nKSBoZXggPSBybmdfc2VlZF9oZXhfbmV3
KCk7DQo+ICsgICAgICAgIHByb21fc2V0KHByb21fYnVmLCBwcm9tX2luZGV4KyssICIlcyIs
IGhleC0+c3RyKTsNCj4gKyAgICB9DQo+ICAgDQo+ICAgICAgIHByb21fc2V0KHByb21fYnVm
LCBwcm9tX2luZGV4KyssIE5VTEwpOw0KPiAgIA0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sg
Qm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

