Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792D4C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 17:19:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tux3o-0008Uk-7n; Wed, 19 Mar 2025 13:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux3c-0008Qx-OQ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:18:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tux3Z-0005jx-NQ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 13:18:19 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223fb0f619dso125370615ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742404696; x=1743009496; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uIXVIL+Ih7xGBvBKWnvUeWieh7lj5R2sxnvdwBBnJMw=;
 b=noc0NySQLx7RVmzTydHVbMf9NMSYF36GmQi29EDRybrR4zlm195iM4/aB0cxdckrMY
 6YPQefOQUBU0/ZaGsFfzEow0itB/wXTuqpLeHUrv7lO+hpSDEs/j82gFEQMNiNIv0MwN
 T/VFYirrJNjQbRKDiE4bnYptHKP/xZwmAmo07K16jo38udVPiwFiMmXhbqOt6Wq/rhWd
 p/+V3dGaquVgLCoT5R2pFoF4sZqyKmDY9SR9/KZU3NkI6Gtvi3T7yllkHoNkEMxO1l1Y
 X07xq/RFwfKZq2RWGPF6QpuLqjKQlTP7tRMWzTs3GK9HYLZ3z855nkPtQTUlk8gEz3bA
 cxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742404696; x=1743009496;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uIXVIL+Ih7xGBvBKWnvUeWieh7lj5R2sxnvdwBBnJMw=;
 b=kC5nx6LVloI+5NAup/DslmOBpExO5VVHH3It35cLNSxLm6sMH6WXUDrijLFxskTJEm
 CLi8MS56I7rs2F5wkzBs0Ur/Am9lFZIHb7p8cn5MOWxB0BNvsOpVJf+kwV0Xp5XzTRPe
 4bqS7pxDcUc8uWKaWwRghApH3Jdp3oaOexFyDMILQXAkFMGMtwzMi6Ypyg5eoL66mKod
 gXTWdFVoY8PcDR75mAiOxmkzPysOOJDZnJ8HEnylcWWW09coHMZvtpkiTDRIscm0RxFZ
 YWwj8SP/ZQeih+aHFbJHFEQs/tsH5RwXJYDWb+GJrhOBVzdE1qQ/TyGvwqzxlBBaCDpD
 fDoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAkkLv2/ra7Wxd3baESp4zTFIyXUaFyOVe0Lw/h3pKKFUyUsGWgpHVE7jvMvUY/aGgdx7vy2gXqEa9@nongnu.org
X-Gm-Message-State: AOJu0Yzci5A/KX6QMGgjs9iUPDQr0Yt/knkHLkmCa9KjcDilvYxILwIy
 sY5fOOqOrcH9KcZ3spyOS8MhncLLxZRZao/+zAx7a9N9eVBi214jXzEDwzx157o=
X-Gm-Gg: ASbGncs6s/jrixhA4s7wfdV8xAMrn+vL0BgZIOBr2a6gFxGBQ+x5ez/nEBGQtr/j8A8
 VXJM9RhswdXplaZyvCPIKncqrj5+ZvMGW+T68l6A1P8YMTbKVRGPGqGbNNdpWl01VbNAza9U258
 FoGyltNVzFPdY7jbDj8u3trhpCDYWPwi7OxN/R6EpkWRvxF/lZ5X6vhWdNGAmQmVq9PSzoQoOHi
 777alUP90U+zlxNu8eAQBbv7ueYLAS3T3AB2YMum9OzRhi9DyFK9ZSFtq18ltt3W0Dc1olYXu8g
 F4/qfrHvAbD3YT3G4evlKrOk7dyHAlLO+XtA2TvXrK8KoKu2mzp2FPDNtkgqpVgwi5EM
X-Google-Smtp-Source: AGHT+IHfGi83VI3uswk54gQLcYVypZoSbHu8umEqNq8AHyMihSm6lWFvb7pi60NEndRmEZ9LMejYqQ==
X-Received: by 2002:a17:903:178b:b0:21a:8300:b9ce with SMTP id
 d9443c01a7336-22649c9580dmr52656585ad.49.1742404696016; 
 Wed, 19 Mar 2025 10:18:16 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-737116b3798sm12275530b3a.174.2025.03.19.10.18.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 10:18:15 -0700 (PDT)
Message-ID: <5ad9242f-7397-404c-a1de-a9652fb15274@linaro.org>
Date: Wed, 19 Mar 2025 10:18:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/42] accel/tcg: Perform aligned atomic reads in
 translator_ld
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-12-richard.henderson@linaro.org>
 <2fe37412-dc19-4e32-9f97-1cdcf71fb720@linaro.org>
 <5d665b08-f79d-4559-83ca-9f4faaaaeb12@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <5d665b08-f79d-4559-83ca-9f4faaaaeb12@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy8xOC8yNSAxODoyOCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTc6MTUsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gQEAgLTMyOSw3ICszMzEs
MzkgQEAgc3RhdGljIGJvb2wgdHJhbnNsYXRvcl9sZChDUFVBcmNoU3RhdGUgKmVudiwgRGlz
YXNDb250ZXh0QmFzZSAqZGIsDQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoCBob3N0ID0gZGIt
Pmhvc3RfYWRkclsxXTsNCj4+PiAgwqDCoMKgwqDCoCB9DQo+Pj4gLcKgwqDCoCBtZW1jcHko
ZGVzdCwgaG9zdCArIChwYyAtIGJhc2UpLCBsZW4pOw0KPj4+ICsgZG9fcmVhZDoNCj4+PiAr
wqDCoMKgIC8qDQo+Pj4gK8KgwqDCoMKgICogQXNzdW1lIGFsaWduZWQgcmVhZHMgc2hvdWxk
IGJlIGF0b21pYywgaWYgcG9zc2libGUuDQo+Pj4gK8KgwqDCoMKgICogV2UncmUgbm90IGlu
IGEgcG9zaXRpb24gdG8ganVtcCBvdXQgd2l0aCBFWENQX0FUT01JQy4NCj4+PiArwqDCoMKg
wqAgKi8NCj4+PiArwqDCoMKgIGhvc3QgKz0gcGMgLSBiYXNlOw0KPj4+ICvCoMKgwqAgc3dp
dGNoIChsZW4pIHsNCj4+DQo+PiBTaG91bGQgd2UgaGF2ZSBhIGNhc2UgZm9yOg0KPj4gY2Fz
ZSAxOg0KPj4gICDCoMKgwqDCoHVpbnQ4X3QgdCA9ICoodWludDhfdCAqKWhvc3Q7DQo+PiAg
IMKgwqDCoMKgc3RiX2hlX3AoZGVzdCwgdCk7DQo+PiAgIMKgwqDCoMKgcmV0dXJuIHRydWU7
DQo+Pg0KPj4gVG8gc2tpcCB0aGUgbWVtY3B5IGZvciBhIHNpbmdsZSBieXRlPw0KPiANCj4g
SSBndWVzcyBvbmx5IHRoZSBpMzg2IHRyYW5zbGF0b3IgaXMgZ29pbmcgdG8gYmUgaXNzdWlu
ZyBieXRlIGNvZGUgbG9hZHMuICBJIHdvbmRlciBpZiBpdCdzDQo+IG1lYXN1cmFibGU/ICBN
eSBndXQgcmVhY3Rpb24gaXMgdGhhdCBpdCBpc24ndC4NCj4gDQoNCklmIHdlIHNlZSBhIG1l
bWNweSBhdCB0aGlzIHNwb3QgaW4gYSBwcm9maWxpbmcgb25lIGRheSwgaXQgd2lsbCBhbHdh
eXMgDQpiZSB0aW1lIHRvIHJldmlzaXQuDQpGb3Igbm93LCBpdCdzIG9rIGZvciBtZS4gSnVz
dCB3b25kZXIgd2h5IHRoZSBjYXNlIGZvciBsZW4gPT0gMSB3YXMgbm90IA0KZXhwbGljaXRl
bHkgYWRkZWQuDQoNCj4gDQo+IHJ+DQoNCg==

