Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9468D6B6DA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 22:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6HSd-0003bJ-NV; Wed, 30 Oct 2024 18:46:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6HSZ-0003am-NI
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 18:46:40 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6HSY-0007MQ-5O
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 18:46:39 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-7ea68af2f62so328845a12.3
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 15:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730328393; x=1730933193; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2579xJtxKaAkYw3IpR8jJ1sJ06OcM1BYTUKIrYbMtts=;
 b=MRvR/33RAl+9zngTE6YwDjHZ1RdHorg1iP9+FIIaJfKAAMUnh9HSoFjuyLt3nvmzKx
 c5rfcxX2L5G0Rsq38XFuJqSHh6yyEWylwJmtgv2NGQMpXEPFsinWJm801Mce6vcmDrQY
 EfL80KzJd7t/cBEmzJRp6EDYfJxi79sobdgXlDVg8JouKrOL9FV0Xgt7Q5Tx9lONMP/K
 YMlhZBL3WY2tgBDGq34wa3ADVhMH4M1Q8rrE5L43/8mxKAyFJkxcnb2fBLEGDzdGuWXy
 ae6j0FI4u3aJhWAQ5kbihZ+2PG/pvsbkwTE6Z6PYvHFcqCGbeBO9rGGNLM5birkAqPUL
 VjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730328393; x=1730933193;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2579xJtxKaAkYw3IpR8jJ1sJ06OcM1BYTUKIrYbMtts=;
 b=w/H/KpQOgTdRiOFZD9UJZg77Y+SJtMdr1fbKmb62floDnIUT71EB17Lwjoj6LiSgSp
 meG8xwYtyWzhqFPDnU/wFO19ijv/Yy7Z0k/iXQXTGSLig1fD4n5InbwY/kMuzGndvfoN
 okc2xeIGyjC931eU8g9vBEtvGH4dyjm6E9u0TiVGvJ+WSzTmZwZlrJvNcCddmD6uRilW
 w7/zCtjPBNgIXRUYnrnKED+b4jl7peundR6ZP/aqapJkX8qJQ/ZuNjEjTHuUz7pz5e4g
 zoDWqK4+tXNpT94/7ZEDfzqRTe94NAlJtGXbZhuVJHBL02+P2bzp2k1zUtKhVBjDsPik
 8fLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD+0g55GyOI7AvMZP6pWt91y9kaDiSCcZA8iwPsqtEY2K4vXlS+zyjnKDRzdDGoGW5GWseDZPBnqoE@nongnu.org
X-Gm-Message-State: AOJu0YyeYVo73SNS/4fCWBU0u9hedbBIsBCnF7dDzQPfwHR31awZ3zCD
 DkRYsa4ASaP8ScEkWDwzatzN9jaXFbx26+q5aFB/D2Bp1utIZhZlvByu53yKJ5w=
X-Google-Smtp-Source: AGHT+IHAqxvJqWmKwNFQz4MFGLNQwPeFlv4IlQj6W4lecHgNYCTGFwwPnDSuV8DJlAMRwV2RjUzrDQ==
X-Received: by 2002:a05:6a20:c998:b0:1d8:a3ab:720d with SMTP id
 adf61e73a8af0-1d9a81c64abmr23746609637.0.1730328392877; 
 Wed, 30 Oct 2024 15:46:32 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc31c5cdsm143599b3a.211.2024.10.30.15.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 15:46:32 -0700 (PDT)
Message-ID: <01f61fd9-d46d-48bd-bc2c-4b3cb78ac17c@linaro.org>
Date: Wed, 30 Oct 2024 15:46:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] target/mips: Extract decode_64bit_enabled() helper
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20241026175349.84523-1-philmd@linaro.org>
 <20241026175349.84523-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20241026175349.84523-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
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

T24gMTAvMjYvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBF
eHRyYWN0IHRoZSBkZWNvZGVfNjRiaXRfZW5hYmxlZCgpIGhlbHBlciB3aGljaCBkZXRlY3Rz
DQo+IHdoZXRoZXIgQ1BVcyBjYW4gcnVuIDY0LWJpdCBpbnN0cnVjdGlvbnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9taXBzL3RjZy90cmFuc2xhdGUuaCB8IDIgKysNCj4g
ICB0YXJnZXQvbWlwcy90Y2cvdHJhbnNsYXRlLmMgfCA3ICsrKysrKy0NCj4gICAyIGZpbGVz
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3RhcmdldC9taXBzL3RjZy90cmFuc2xhdGUuaCBiL3RhcmdldC9taXBzL3RjZy90
cmFuc2xhdGUuaA0KPiBpbmRleCA1ZDE5NmU2OWFjNC4uYWU2YzI1YWEwYzQgMTAwNjQ0DQo+
IC0tLSBhL3RhcmdldC9taXBzL3RjZy90cmFuc2xhdGUuaA0KPiArKysgYi90YXJnZXQvbWlw
cy90Y2cvdHJhbnNsYXRlLmgNCj4gQEAgLTIxNyw2ICsyMTcsOCBAQCB2b2lkIG1zYV90cmFu
c2xhdGVfaW5pdCh2b2lkKTsNCj4gICB2b2lkIG14dV90cmFuc2xhdGVfaW5pdCh2b2lkKTsN
Cj4gICBib29sIGRlY29kZV9hc2VfbXh1KERpc2FzQ29udGV4dCAqY3R4LCB1aW50MzJfdCBp
bnNuKTsNCj4gICANCj4gK2Jvb2wgZGVjb2RlXzY0Yml0X2VuYWJsZWQoRGlzYXNDb250ZXh0
ICpjdHgpOw0KPiArDQo+ICAgLyogZGVjb2RldHJlZSBnZW5lcmF0ZWQgKi8NCj4gICBib29s
IGRlY29kZV9pc2FfcmVsNihEaXNhc0NvbnRleHQgKmN0eCwgdWludDMyX3QgaW5zbik7DQo+
ICAgYm9vbCBkZWNvZGVfYXNlX21zYShEaXNhc0NvbnRleHQgKmN0eCwgdWludDMyX3QgaW5z
bik7DQo+IGRpZmYgLS1naXQgYS90YXJnZXQvbWlwcy90Y2cvdHJhbnNsYXRlLmMgYi90YXJn
ZXQvbWlwcy90Y2cvdHJhbnNsYXRlLmMNCj4gaW5kZXggZDkyZmM0MThlZGQuLjZjODgxYWY1
NjE4IDEwMDY0NA0KPiAtLS0gYS90YXJnZXQvbWlwcy90Y2cvdHJhbnNsYXRlLmMNCj4gKysr
IGIvdGFyZ2V0L21pcHMvdGNnL3RyYW5zbGF0ZS5jDQo+IEBAIC0xNjQ1LDEzICsxNjQ1LDE4
IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjaGVja19wcyhEaXNhc0NvbnRleHQgKmN0eCkNCj4g
ICAgICAgY2hlY2tfY3AxXzY0Yml0bW9kZShjdHgpOw0KPiAgIH0NCj4gICANCj4gK2Jvb2wg
ZGVjb2RlXzY0Yml0X2VuYWJsZWQoRGlzYXNDb250ZXh0ICpjdHgpDQo+ICt7DQo+ICsgICAg
cmV0dXJuIGN0eC0+aGZsYWdzICYgTUlQU19IRkxBR182NDsNCj4gK30NCj4gKw0KPiAgIC8q
DQo+ICAgICogVGhpcyBjb2RlIGdlbmVyYXRlcyBhICJyZXNlcnZlZCBpbnN0cnVjdGlvbiIg
ZXhjZXB0aW9uIGlmIGNwdSBpcyBub3QNCj4gICAgKiA2NC1iaXQgb3IgNjQtYml0IGluc3Ry
dWN0aW9ucyBhcmUgbm90IGVuYWJsZWQuDQo+ICAgICovDQo+ICAgdm9pZCBjaGVja19taXBz
XzY0KERpc2FzQ29udGV4dCAqY3R4KQ0KPiAgIHsNCj4gLSAgICBpZiAodW5saWtlbHkoKFRB
UkdFVF9MT05HX0JJVFMgIT0gNjQpIHx8ICEoY3R4LT5oZmxhZ3MgJiBNSVBTX0hGTEFHXzY0
KSkpIHsNCj4gKyAgICBpZiAodW5saWtlbHkoKFRBUkdFVF9MT05HX0JJVFMgIT0gNjQpIHx8
ICFkZWNvZGVfNjRiaXRfZW5hYmxlZChjdHgpKSkgew0KPiAgICAgICAgICAgZ2VuX3Jlc2Vy
dmVkX2luc3RydWN0aW9uKGN0eCk7DQo+ICAgICAgIH0NCj4gICB9DQoNClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

