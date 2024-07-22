Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18508C3DA64
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 21:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW0F8-0003ft-FH; Mon, 22 Jul 2024 17:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0F2-00038s-Dg
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:49 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sW0Ey-000597-P2
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 17:06:42 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2cb56c2c30eso2820916a91.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721682399; x=1722287199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UB6eO4FcPoJrCez5ip8Kw5mmYIX9y2zndxgDFU+HaPQ=;
 b=UXXVXjn2IEEgm/R/AoPpOHx7lmf/UffqGKFYwL8S1PwP07q9j4mTnRCBhi6Y6G/4RH
 CsZ293bB+QdIEX79Jc6ynTkvvf2Owa+nX/VYJtnyteVHj55CNXQhP3i9Py6Q6mW0zH51
 l82lzeZprPaGNZvchFaKoJv5nndDKHsOAtSlSL9ZJ/KniZMWpsLxPhlpIGTlArkz4N05
 jsfZbZw0GopF/TiI1FVHNOlFA4wlLAxD+UCxqrxQSz3cDLIh/GPdiMpnBGspYvAPaJuJ
 8awXK34767bkwRZQ6lz/u6hjBMgjMxU7QTQ/VRNbEqzwV55GnCHVeGQ04CCEzYIJnoAo
 fRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721682399; x=1722287199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UB6eO4FcPoJrCez5ip8Kw5mmYIX9y2zndxgDFU+HaPQ=;
 b=IXHDH/5LtE/tLAVR9XoNZYLOa12ikvKVfq8nLRid+5guV3Y2EtbjAWEA+JsfKGvsoG
 OuWJNx/GpZ7E4AwojaKwO5dUpYApPl4VrrbICOZlwakiJJw2lZ5VIP4kedIKW/8I73DJ
 acj8Gz6AD71Hr2Csbu0OaNT1rZihivxeXRCf3mOf4rHUHNJhxX362eVx8rBHHNWfRhxv
 FmFLgoLJHE26k5jvn/w3gFg4AZOvvRL7JUMV0flxDWwkJh/LSPo0Pw3yKjIwGKAr7XZl
 JzHHoD69huTM/RB+kzF+h9/Xf1K4D0GT+CXsMVibEQae3LocXHVDYRCRxacHW9Rmd5WU
 TSxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpM0pvRHCQ2VCyEwYygX4yynANNoVJycmUzhq7zROTHLS53ABsBL5cbNAlflBDH0NNaywnaNNddRkmVVQYY5IhPnUvyZI=
X-Gm-Message-State: AOJu0YwyocI9hTDPVitkYSyyKYBk/ZjI4T7+DMnwepcJupHPGhRXo5KC
 JrJ49guwhnXlrDkzbJZE3cazxBdqjfj2JBuCiVcd+9MipfXmZYESA5eOxkIloVk=
X-Google-Smtp-Source: AGHT+IEHq+xmtrwaQfWd2GC52kSOwzJKbP2pNFkVJovKk68Ta78eMziWAdz8AlA9Uo+CUAwg7B2IMA==
X-Received: by 2002:a17:90a:dd88:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2cd8d10950bmr161112a91.14.1721682399086; 
 Mon, 22 Jul 2024 14:06:39 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb77540a6esm8596504a91.54.2024.07.22.14.06.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 14:06:38 -0700 (PDT)
Message-ID: <03c5a36d-1bf8-40ae-ae8e-fc3f825af903@linaro.org>
Date: Mon, 22 Jul 2024 14:06:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] util/fifo8: Use fifo8_reset() in fifo8_create()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20240722160745.67904-1-philmd@linaro.org>
 <20240722160745.67904-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240722160745.67904-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

T24gNy8yMi8yNCAwOTowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IEF2
b2lkIG9wZW4tY29kaW5nIGZpZm84X3Jlc2V0KCkgaW4gZmlmbzhfY3JlYXRlKCkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+IFJldmlld2VkLWJ5OiBNYXJrIENhdmUtQXlsYW5kIDxtYXJrLmNhdmUtYXls
YW5kQGlsYW5kZS5jby51az4NCj4gLS0tDQo+ICAgdXRpbC9maWZvOC5jIHwgMTUgKysrKysr
Ky0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS91dGlsL2ZpZm84LmMgYi91dGlsL2ZpZm84
LmMNCj4gaW5kZXggNGUwMWI1MzJkOS4uMjkyNWZlNTYxMSAxMDA2NDQNCj4gLS0tIGEvdXRp
bC9maWZvOC5jDQo+ICsrKyBiL3V0aWwvZmlmbzguYw0KPiBAQCAtMTYsMTIgKzE2LDE3IEBA
DQo+ICAgI2luY2x1ZGUgIm1pZ3JhdGlvbi92bXN0YXRlLmgiDQo+ICAgI2luY2x1ZGUgInFl
bXUvZmlmbzguaCINCj4gICANCj4gK3ZvaWQgZmlmbzhfcmVzZXQoRmlmbzggKmZpZm8pDQo+
ICt7DQo+ICsgICAgZmlmby0+bnVtID0gMDsNCj4gKyAgICBmaWZvLT5oZWFkID0gMDsNCj4g
K30NCj4gKw0KPiAgIHZvaWQgZmlmbzhfY3JlYXRlKEZpZm84ICpmaWZvLCB1aW50MzJfdCBj
YXBhY2l0eSkNCj4gICB7DQo+ICAgICAgIGZpZm8tPmRhdGEgPSBnX25ldyh1aW50OF90LCBj
YXBhY2l0eSk7DQo+ICAgICAgIGZpZm8tPmNhcGFjaXR5ID0gY2FwYWNpdHk7DQo+IC0gICAg
Zmlmby0+aGVhZCA9IDA7DQo+IC0gICAgZmlmby0+bnVtID0gMDsNCj4gKyAgICBmaWZvOF9y
ZXNldChmaWZvKTsNCj4gICB9DQo+ICAgDQo+ICAgdm9pZCBmaWZvOF9kZXN0cm95KEZpZm84
ICpmaWZvKQ0KPiBAQCAtOTcsMTIgKzEwMiw2IEBAIGNvbnN0IHVpbnQ4X3QgKmZpZm84X3Bv
cF9idWYoRmlmbzggKmZpZm8sIHVpbnQzMl90IG1heCwgdWludDMyX3QgKm51bXB0cikNCj4g
ICAgICAgcmV0dXJuIGZpZm84X3BlZWtwb3BfYnVmKGZpZm8sIG1heCwgbnVtcHRyLCB0cnVl
KTsNCj4gICB9DQo+ICAgDQo+IC12b2lkIGZpZm84X3Jlc2V0KEZpZm84ICpmaWZvKQ0KPiAt
ew0KPiAtICAgIGZpZm8tPm51bSA9IDA7DQo+IC0gICAgZmlmby0+aGVhZCA9IDA7DQo+IC19
DQo+IC0NCj4gICBib29sIGZpZm84X2lzX2VtcHR5KEZpZm84ICpmaWZvKQ0KPiAgIHsNCj4g
ICAgICAgcmV0dXJuIChmaWZvLT5udW0gPT0gMCk7DQoNClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

