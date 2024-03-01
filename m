Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD8BC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 09:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzOl-00027G-Au; Fri, 01 Mar 2024 04:41:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzOk-00022l-84
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:41:46 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzOi-0006yJ-Jy
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:41:45 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4129ed6f514so13459175e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 01:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709286103; x=1709890903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BYTrKBOOc/tov+EMDwZyxoUAvKKesT7oXYbWqIYldPY=;
 b=L5vSlWSNIrB2Qb54nS0Xg+YMXEFW+JTzHm8/aBL54KQVvAGRtr+0rnnztVzhoS+603
 DHhELwfkyaKQkYTEsU7S5JAErGHj3xHfAPLnHr4I8mKFsuV/fZGpimGQqhfR6v3cpUkk
 SAhJfI58rZN+Nw1olVwZ7KzVslqR1eKrKAvDcNPqDidwe426qzLL29A1wdbNtv1DQH88
 moEQXu/9NbiTjnED/Y3gLk8pQyLHsPWEkPD97LVZ1VtC2lNVHKJQ2ze2g0rvFnWdhsyH
 g4nMjZHir4Q1Mv4xJDSEr0JSOoUm6wxeiBPaoFJxjyxRWKTmP8LYiacYt8kY/tvYdg0c
 OwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709286103; x=1709890903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BYTrKBOOc/tov+EMDwZyxoUAvKKesT7oXYbWqIYldPY=;
 b=nki31BUS2Yqf05lRcG9UMXesoTSTF+uI2m3yrBoxH+BAPJMjq9c3e0v3SZQHvoeuv+
 RtABjAinf+0wq7ESj4KITecwhzfS1giGfHlM92pvaYB3j9FxSRwFM0fkJbyTKxsKnhZD
 t4iqeuQTl7iRsZNgQi12XA5NJ2+ifv5At33hASA8v7lOkJrcWamKHS9hZiPCt66c5soU
 tXYinqoAjMLGpFN99Erw2EGnmmUrX2ORtxzaoVAWokT24jcQp+x9qBpTe7TARLmelGfP
 vjiXOy22laErLXx3cEcW6inZNxGdA1FahzdNsugVc4k4WYeVmGAMkuUmv0xwVhuW/acn
 mUpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGMAzP762kW7aG2QM97SBTxQUwhBwyIpJA2zRXqfFWxis0sw1f274oxS4aPosRrp6HcozYadEN9QCQvA7SuQaHWXR3ILY=
X-Gm-Message-State: AOJu0YzUI6TCbZNVjSbz9s8swcaONsRjO5vXVHgBnCveCX89mUHnhgMp
 wpNFcB7CZ+LtmgZF5Cb+iFxkPLwi+aD2LkCwwO/L5++yAjJBg19ME/Pd/PDIuYA=
X-Google-Smtp-Source: AGHT+IEE6zemrfecTTfkMmQuWmY29aP0zuHR9zOQy831eY32rRyD24dRDbzQI67A9YHLTDVYEvzS6A==
X-Received: by 2002:a05:600c:19cf:b0:412:c219:6206 with SMTP id
 u15-20020a05600c19cf00b00412c2196206mr886617wmq.39.1709286102917; 
 Fri, 01 Mar 2024 01:41:42 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b00412a31d2e2asm4860695wmq.32.2024.03.01.01.41.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 01:41:42 -0800 (PST)
Message-ID: <03859aea-5bd6-4fd2-86f3-c30d24a75a8c@linaro.org>
Date: Fri, 1 Mar 2024 13:41:39 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm> <875xy8b5sg.fsf@draig.linaro.org>
 <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org>
 <87zfvjagse.fsf@draig.linaro.org>
 <03ce19fb-0b82-4819-aaa4-a2241517090e@linaro.org>
 <87ttlr9ycv.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87ttlr9ycv.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32c.google.com
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

T24gMi8yOS8yNCA1OjQ2IFBNLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IE9u
IDIvMjkvMjQgMTE6MDggQU0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4+Pg0KPj4+
PiBPbiAyLzI5LzI0IDI6MDggQU0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4+Pj4+IEx1YyBN
aWNoZWwgPGx1Yy5taWNoZWxAYW1kLmNvbT4gd3JpdGVzOg0KPj4+Pj4NCj4+Pj4+PiBIaSBQ
aWVycmljaywNCj4+Pj4+Pg0KPj4+IDxzbmlwPg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gTXkgYmFk
LiBPdGhlciBwbHVnaW5zIGVuYWJsZSBvbmx5IGlubGluZSB3aGVuIGJvdGggYXJlIHN1cHBs
aWVkLCBzbyBJDQo+Pj4+IG1pc3NlZCB0aGlzIGhlcmUuDQo+Pj4+IEkgYWRkZWQgYW4gZXhw
bGljaXQgZXJyb3Igd2hlbiB1c2VyIGVuYWJsZSBjYWxsYmFjayBhbmQgaW5saW5lIGF0IHRo
ZQ0KPj4+PiBzYW1lIHRpbWUgb24gdGhpcyBwbHVnaW4uDQo+Pj4gV2UgY291bGQgZGVmYXVs
dCB0byBpbmxpbmUgdW5sZXNzIHdlIG5lZWQgdGhlIG1vcmUgZmVhdHVyZXMgb2YNCj4+PiBj
YWxsYmFja3M/DQo+Pj4NCj4+DQo+PiBUaGlzIHJlbWFyayBhcHBsaWVzIGZvciBhbGwgcGx1
Z2lucyBpbiBnZW5lcmFsLiBOb3cgd2UgaGF2ZSBzYWZlIGFuZA0KPj4gY29ycmVjdCBpbmxp
bmUgb3BlcmF0aW9ucywgY2FsbGJhY2tzIGFyZSBub3QgbmVlZGVkIGluIHNvbWUgY2FzZS4N
Cj4+DQo+PiBXb3VsZCB0aGF0IGJlIGFjY2VwdGFibGUgZm9yIHlvdSB0aGF0IHdlIGRlbGF5
IHRoaXMgImNsZWFudXAiIHRvDQo+PiBleGlzdGluZyBwbHVnaW5zIGFmdGVyIHNvZnQgZnJl
ZXplPyBTbyB3ZSBjYW4gZm9jdXMgb24gbWVyZ2luZyBjdXJyZW50DQo+PiBBUEkgY2hhbmdl
cyBuZWVkZWQuDQo+IA0KPiBBcyBsb25nIGFzIHdlIGZpeCB0aGUgZG91YmxlIHJlcG9ydGlu
ZyBidWcgc3VyZS4NCj4gDQoNClllcywgZml4ZWQgaW4gdjYuDQo=

