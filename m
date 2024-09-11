Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77283EE57D0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 19:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soTTJ-00031k-UI; Wed, 11 Sep 2024 15:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soTTI-00030f-3Z
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:57:48 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1soTTG-0007MU-FM
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:57:47 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7178df70f28so123057b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726084665; x=1726689465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NhQkRNn2489AG65GZUCKuAxWACvek5J6HCcgPNqE+Tk=;
 b=Fc+rXChWDm4QAbTzVB1Z0jhhsqafgXzNjleC58fOhn6C/KZF0akW7Ink90qyuZxoow
 qOfs5kKSw/hFOy2+y5a6VyzVdU/NrCdHbitcFAtYCBRhFtpAoSAwCMceUfwfqpzMA4Wh
 NpTBaTBNKgilCd6ukDe5XK6zKR8Syb3daJ46ctR4wYcapQmvrVxX3Ol+9nwsCUcycuQc
 23V4VwFlT8c7whxrBCopxbIqAeQ76+bh2FLDg4Y1hcTRmTqKsnIv2S+1vHanOdL9+WYi
 da9qqtuhAhSiSx9nmwF/EriRhVMC6audtvmOJoBw6WMiR/IBbla251U/afu+LRbVnRTA
 fjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726084665; x=1726689465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NhQkRNn2489AG65GZUCKuAxWACvek5J6HCcgPNqE+Tk=;
 b=qpXlFWdtrISsgrnvX59pp2v0ba+632yNZZ4skFRmFLdHWWIZmGNXJp9gFJK3AI6jp1
 zHlyV1eE36gozRRaRuwfAAtvSsnW7Tc9aFHX7XOOL99PIhwhD8QjyxCNBc85FlKvEqon
 IjfqKMntrslN60995XkjrsMOJfLL0vXYhKNe1zFVMhf/u838XNqUx2kmQKsICRlQ9yqV
 92Nl8/57bPHclLUWoEFJn3GwqaacJVoVVnnFQeM5DZmaG26UEsRNn0BOXib84Qa6C8fR
 VCF9him4KjF9rQX19Vk25hOhAYDRRyV+Tq0OWbJEGLOa9n3p+hQ1mLA+VFVS3cuk2qdX
 z79g==
X-Gm-Message-State: AOJu0Yw1Ne4tBb4AhGjwd/nXaxSg00oNKPQxmqy5cTfYcUwGum77FgK2
 Eibj8C+44/PSO7iSB9h9GVKu0ULPt4Uq9Kd4yfnAfsh4fcQbdfdsOCk3UZgUa84=
X-Google-Smtp-Source: AGHT+IHWGy7W0hb9kaXy89z7QcNDUrZOQkrDWX9sMCq1obtkMklAfVS1soTbxB2O1Fa7bm/8h8/+Pg==
X-Received: by 2002:a05:6a00:3cd1:b0:714:1d15:663 with SMTP id
 d2e1a72fcca58-71926202c98mr735039b3a.24.1726084664642; 
 Wed, 11 Sep 2024 12:57:44 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71909095177sm3345413b3a.112.2024.09.11.12.57.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 12:57:44 -0700 (PDT)
Message-ID: <79e798a1-f567-4c0f-99ce-f1c0f52c85e0@linaro.org>
Date: Wed, 11 Sep 2024 12:57:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] tests/tcg/multiarch: add test for plugin memory
 access
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org, Zhao Liu
 <zhao1.liu@intel.com>, Xingtao Yao <yaoxt.fnst@fujitsu.com>
References: <20240910172033.1427812-1-pierrick.bouvier@linaro.org>
 <20240910172033.1427812-7-pierrick.bouvier@linaro.org>
 <874j6mw1ty.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <874j6mw1ty.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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

T24gOS8xMS8yNCAxMDoxMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBBZGQg
YW4gZXhwbGljaXQgdGVzdCB0byBjaGVjayBleHBlY3RlZCBtZW1vcnkgdmFsdWVzIGFyZSBy
ZWFkL3dyaXR0ZW4uDQo+PiA4LDE2LDMyIGxvYWQvc3RvcmUgYXJlIHRlc3RlZCBmb3IgYWxs
IGFyY2guDQo+PiA2NCwxMjggbG9hZC9zdG9yZSBhcmUgdGVzdGVkIGZvciBhYXJjaDY0L3g2
NC4NCj4+IGF0b21pYyBvcGVyYXRpb25zICg4LDE2LDMyLDY0KSBhcmUgdGVzdGVkIGZvciB4
NjQgb25seS4NCj4+DQo+PiBCeSBkZWZhdWx0LCBhdG9taWMgYWNjZXNzZXMgYXJlIG5vbiBh
dG9taWMgaWYgYSBzaW5nbGUgY3B1IGlzIHJ1bm5pbmcsDQo+PiBzbyB3ZSBmb3JjZSBjcmVh
dGlvbiBvZiBhIHNlY29uZCBvbmUgYnkgY3JlYXRpbmcgYSBuZXcgdGhyZWFkIGZpcnN0Lg0K
Pj4NCj4+IGxvYWQvc3RvcmUgaGVscGVycyBjb2RlIHBhdGggY2FuJ3QgYmUgdHJpZ2dlcmVk
IGVhc2lseSBpbiB1c2VyIG1vZGUgKG5vDQo+PiBzb2Z0bW11KSwgc28gd2UgY2FuJ3QgdGVz
dCBpdCBoZXJlLg0KPj4NCj4+IE91dHB1dCBvZiB0ZXN0LXBsdWdpbi1tZW0tYWNjZXNzLmMg
aXMgdGhlIGxpc3Qgb2YgZXhwZWN0ZWQgcGF0dGVybnMgaW4NCj4+IHBsdWdpbiBvdXRwdXQu
IEJ5IHJlYWRpbmcgc3Rkb3V0LCB3ZSBjYW4gY29tcGFyZSB0byBwbHVnaW5zIG91dHB1dCBh
bmQNCj4+IGhhdmUgYSBtdWx0aWFyY2ggdGVzdC4NCj4+DQo+PiBDYW4gYmUgcnVuIHdpdGg6
DQo+PiBtYWtlIC1DIGJ1aWxkL3Rlc3RzL3RjZy8kQVJDSC1saW51eC11c2VyDQo+PiBydW4t
cGx1Z2luLXRlc3QtcGx1Z2luLW1lbS1hY2Nlc3Mtd2l0aC1saWJtZW0uc28NCj4gDQo+IFF1
ZXVlZCB0byBwbHVnaW5zL25leHQsIHRoYW5rcy4NCj4gDQoNClRoYW5rcyBBbGV4Lg0K

