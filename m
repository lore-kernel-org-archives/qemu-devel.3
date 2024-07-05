Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AA3C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 19:37:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPojE-0008O5-Vn; Fri, 05 Jul 2024 15:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPojD-0008Lf-A6
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 15:36:19 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sPojB-0002lx-EI
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 15:36:19 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-383e7a29808so7381485ab.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 12:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720208175; x=1720812975; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HoEJyhzB0qzjTPq1Izjm8mPRjMTVyKksqxbhzIg0juU=;
 b=H2hchYHMY0++Trq+NdTIjz+JyYxSfdn3nlk8FJ8I65mYydIKqJZa9IjnhNKP0JmLfO
 EUhpU9PnJUndiWXZ0CW+1K+KQZtq7/Uo3u2h29W1ZXvdXtKyJC/1pCzp8CdaMHE2UZF1
 Ptr1sPoQOKlME5ljzrPixzrcWjvVkNqeJytezlG87hqCs+rEt5EgMELp+lm3rROuiDKe
 1Y4K/ILOM4lGviieTTxTJkon676FTTXwbwEiVuPIrW/d9Ts5M5x276bxkzxg/RlJ1f+l
 NgdpToYU2FrHYuZsKN5ssjL0dlkf7vJlZgg7mRfr3nEb1SUvmAZfJOw7MT65GP7RxOPi
 hdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720208175; x=1720812975;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HoEJyhzB0qzjTPq1Izjm8mPRjMTVyKksqxbhzIg0juU=;
 b=XII6AixNuObjVgYbDjIdjIzL4ShlywfaWz2fawifwhb6MazzvuB4Cbu0YoqNmfx0IQ
 MvODA5f6xU9FY9N31rAb3N7RlIK70MeZauIy5YadJaiHClVPqf/4lMH60jQ1mHBEotvj
 ChZ16ewPumh/a3aRpAy3xRUqooaxdjzxVmUZM1HofEz/0K4+92/Nkhe7dlkR+hfPz0oL
 jch7kkbYD1dRAN0z4aGsc4xFU6YUfxtPPMO3xfe9Hg6Dhi+JaHY6xGc/OcKcDM4nRrB3
 aY6HkwiJyruUIrWk6XFvmcnt8tP8wQ8C6IsPjZvt71TxQ3yLPiD9NBfUP5nN76jBeZuF
 9S6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaG9xGC9wi8aWVL2oqkW4pMI5UDDsOBQVsQJCepnQ758lsWcULmnpRvcEs2/zuimMv2ntIPvCNzYMFsheyUwLoc78440Y=
X-Gm-Message-State: AOJu0YzuxPMsUgE1FMlKCbnLHc7KNLSrw+nSUcWCEAh84KzuuJjZCAra
 MuWD0LTYuqT/ZKeC2KYFrNzLi15B6+wYjLQRLuLKGIpefEFDTqIPUqB2Eyxeh9s=
X-Google-Smtp-Source: AGHT+IFFKi1T5G/fM7bcc0oRNOEIJePEfNvQYSp1uIc0XIB8AH6O8+2LhDPJGkUmRfqk7w8ZU92ieQ==
X-Received: by 2002:a05:6e02:1b0e:b0:374:a286:7b3f with SMTP id
 e9e14a558f8ab-383990c997dmr58708725ab.14.1720208175012; 
 Fri, 05 Jul 2024 12:36:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b1086d32dsm1512771b3a.46.2024.07.05.12.36.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 12:36:14 -0700 (PDT)
Message-ID: <0ea431ff-f0c0-422f-b1d4-86eb83c945ec@linaro.org>
Date: Fri, 5 Jul 2024 12:36:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] system: Sort QEMU_ARCH_VIRTIO_PCI definition
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240705124528.97471-1-philmd@linaro.org>
 <20240705124528.97471-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240705124528.97471-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-il1-x130.google.com
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

T24gNy81LzI0IDA1OjQ1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU29y
dCB0aGUgUUVNVV9BUkNIX1ZJUlRJT19QQ0kgdG8gc2ltcGxpZnkgYWRkaW5nL3JlbW92aW5n
IGVudHJpZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHN5c3RlbS9xZGV2LW1vbml0b3Iu
YyB8IDE3ICsrKysrKysrKysrLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3Fk
ZXYtbW9uaXRvci5jIGIvc3lzdGVtL3FkZXYtbW9uaXRvci5jDQo+IGluZGV4IDZhZjZlZjdk
NjYuLmFjZGM4YjczYTMgMTAwNjQ0DQo+IC0tLSBhL3N5c3RlbS9xZGV2LW1vbml0b3IuYw0K
PiArKysgYi9zeXN0ZW0vcWRldi1tb25pdG9yLmMNCj4gQEAgLTU1LDEyICs1NSwxNyBAQCB0
eXBlZGVmIHN0cnVjdCBRRGV2QWxpYXMNCj4gICB9IFFEZXZBbGlhczsNCj4gICANCj4gICAv
KiBkZWZhdWx0IHZpcnRpbyB0cmFuc3BvcnQgcGVyIGFyY2hpdGVjdHVyZSAqLw0KPiAtI2Rl
ZmluZSBRRU1VX0FSQ0hfVklSVElPX1BDSSAoUUVNVV9BUkNIX0FMUEhBIHwgUUVNVV9BUkNI
X0FSTSB8IFwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfQVJDSF9I
UFBBIHwgUUVNVV9BUkNIX0kzODYgfCBcDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBRRU1VX0FSQ0hfTUlQUyB8IFFFTVVfQVJDSF9QUEMgfCAgXA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgUUVNVV9BUkNIX1JJU0NWIHwgUUVNVV9BUkNIX1NINCB8
IFwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfQVJDSF9TUEFSQyB8
IFFFTVVfQVJDSF9YVEVOU0EgfCBcDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBRRU1VX0FSQ0hfTE9PTkdBUkNIKQ0KPiArI2RlZmluZSBRRU1VX0FSQ0hfVklSVElPX1BD
SSAoUUVNVV9BUkNIX0FMUEhBIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUUVNVV9BUkNIX0FSTSB8IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IFFFTVVfQVJDSF9IUFBBIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UUVNVV9BUkNIX0kzODYgfCBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBR
RU1VX0FSQ0hfTE9PTkdBUkNIIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgUUVNVV9BUkNIX01JUFMgfCBcDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBRRU1VX0FSQ0hfUFBDIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UUVNVV9BUkNIX1JJU0NWIHwgXA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
UUVNVV9BUkNIX1NINCB8IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFF
TVVfQVJDSF9TUEFSQyB8IFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFF
TVVfQVJDSF9YVEVOU0EpDQo+ICAgI2RlZmluZSBRRU1VX0FSQ0hfVklSVElPX0NDVyAoUUVN
VV9BUkNIX1MzOTBYKQ0KPiAgICNkZWZpbmUgUUVNVV9BUkNIX1ZJUlRJT19NTUlPIChRRU1V
X0FSQ0hfTTY4SykNCj4gICANCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBp
ZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

