Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3558C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 09:58:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfzei-0004K8-Td; Fri, 01 Mar 2024 04:58:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzeh-0004K0-Tq
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:58:15 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfzeg-0001WV-86
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 04:58:15 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-512bd533be0so2358446e87.0
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 01:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709287092; x=1709891892; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p7Nz36NxR8qvY2H7jEW3v72OWco5samcr05svY3dMww=;
 b=ix7ZpYR6mW+P5bZvFYi5+zS2mXmdPjuBDciDofQVY23ut41iuVJy3TJKiy1Xiz4ztv
 EeEKukbHYORIG3vPYqMndRPLvE0Vpa8i6FOj9BTemf1Fc05RuDKGb5ZQzxW1iG7MXh9c
 NmXNrZxyriFQQOyrPiBHwH0ogpXL4fBtzgOBVTDcUSJ+bWmwcHjE/FWnqnA/apQjBTPF
 4L7tRceDe7NMwkLt8syDnfVQdRBOHqpuA8Q0NsOg5vGbhWyAo494+iUsEURsMsdGlrJ2
 +2KbB0xGjL3gG1wPqG5AxCmS4vH9SmiwD8VFvjhGGpWSUN58PViU7xmfHqA7g+3j4I7b
 6xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709287092; x=1709891892;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7Nz36NxR8qvY2H7jEW3v72OWco5samcr05svY3dMww=;
 b=k9v/SkjJOMeEKidyslr6XpI//RD07AkYHkicSJFTJ711hlZVQqGcEhJiNEs8RuDYF/
 koX0Qfthxos2z0kA0keSfSeDRlQbJpSJYs04aOAH+3tQ+GeUF6L6V4NLlGAxtnCRset3
 Od20pppu4mXTAFDmSwoNFsnuY4YSffCrJWqry6sN0od6DT73y1Bf4gQF0Ts0zSF7r9K/
 gAm5XdynKat3alWnaKoiKPiVggj4J36m6VoId6wL5zgRH3WnhwGy3tXA91qk8aVN6KV4
 ZXFQywuodx1SKPZoxbIAQ954VQR11jhcoVTFUtZPMlQ27kJyLMIcG0Y3CbpLJm8UTaJA
 3+AQ==
X-Gm-Message-State: AOJu0YwiOYZoXFCFMRZp7HQA4agXuSw5fPXKAYgJkmTU4mKi+qZ8h1BX
 lWm7Yi9/fz5qyqiw66Cp02V2ddAktMc4bwJS8nN21RewWRdHn/qVhYoHohOvilYimJYCgrl/VP7
 RLmE=
X-Google-Smtp-Source: AGHT+IEP6q5465mOvSeTkU8p+Xvt7+yYBMhPmYE2Y1B1HNVddTVUQFMyuopFWYtksFDqQWSRjygTGQ==
X-Received: by 2002:ac2:5508:0:b0:512:bdd3:1539 with SMTP id
 j8-20020ac25508000000b00512bdd31539mr934579lfk.37.1709287092313; 
 Fri, 01 Mar 2024 01:58:12 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 m17-20020a056000009100b0033e17341ebesm2614549wrx.117.2024.03.01.01.58.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 01:58:12 -0800 (PST)
Message-ID: <349de033-c966-4b99-a852-78b93a41e555@linaro.org>
Date: Fri, 1 Mar 2024 13:58:07 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/12] tests/plugin/bb: migrate to new per_vcpu API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-9-pierrick.bouvier@linaro.org>
 <87o7bz9wrn.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87o7bz9wrn.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x134.google.com
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

T24gMi8yOS8yNCA2OjIxIFBNLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IFNp
Z25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4gDQo+IEkgZGlkIG5vdGljZSB0aGVyZSBpcyBhIGRpc2NyZXBhbmN5IGJldHdl
ZW4gd2hhdCBsaWJpc25zIGFuZCBsaWJiDQo+IHJlcG9ydC4gVGhlIGxpYmIgbG9va3MgbGlr
ZSBhbiBvdmVyY291bnQgc28gSSB3b25kZXIgaWYgdGhlcmUgYXJlIHNvbWUNCj4gaW5zdHJ1
Y3Rpb25zIHdlIGFyZSBub3QgcGlja2luZyB1cCBidXQgSSBjYW4ndCBzZWUgd2hlcmUgdGhh
dCB3b3VsZCBiZS4NCj4gDQo+ICAgIOKenCAgLi9xZW11LWhwcGEgLXBsdWdpbiAuL3Rlc3Rz
L3BsdWdpbi9saWJpbnNuLnNvIC1wbHVnaW4gLi90ZXN0cy9wbHVnaW4vbGliYmIuc28saW5s
aW5lPXRydWUgLWQgcGx1Z2luICAuL3Rlc3RzL3RjZy9ocHBhLWxpbnV4LXVzZXIvc2hhNTEy
DQo+ICAgIDEuLjEwDQo+ICAgIG9rIDEgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sg
MiAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayAzIC0gZG9fdGVzdCgmdGVzdHNbaV0p
DQo+ICAgIG9rIDQgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgNSAtIGRvX3Rlc3Qo
JnRlc3RzW2ldKQ0KPiAgICBvayA2IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDcg
LSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgOCAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0K
PiAgICBvayA5IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDEwIC0gZG9fdGVzdCgm
dGVzdHNbaV0pDQo+ICAgIENQVTA6IGJiJ3M6IDU0MjgyLCBpbnNuczogNzc1Njk3DQo+ICAg
IFRvdGFsOiBiYidzOiA1NDI4MiwgaW5zbnM6IDc3NTY5Nw0KPiAgICBjcHUgMCBpbnNuczog
Nzc0ODI3DQo+ICAgIHRvdGFsIGluc25zOiA3NzQ4MjcNCj4gDQo+IEFsdGhvdWdoIHdlaXJk
bHkgbWF5YmUgb25seSBhbiBocHBhIHRoaW5nLiBSaWNoYXJkPw0KPiANCg0KRG8geW91IG9i
c2VydmUgdGhlIGV4YWN0IHNhbWUgbnVtYmVyIGlmIHlvdSBydW4gb25seSBvbmUgb2YgdGhl
IHBsdWdpbj8NCg0KYmIgY291bnQgbnVtYmVyIG9mIGluc3RydWN0aW9ucyBpbiBhbiBleGVj
dXRlZCBibG9jaywgd2hpbGUgaW5zbiANCmVmZmVjdGl2ZWx5IGNvdW50IGV2ZXJ5IGluc3Ry
dWN0aW9ucyByYW4uDQpNYXliZSB0aGVyZSBpcyBocHBhIHNwZWNpZml0eSB0aGF0IG1ha2Vz
IHNvbWUgdGIgZXhpdCBpbiB0aGUgbWlkZGxlLCANCnRodXMgZXhlY3V0aW5nIGxlc3MgaW5z
dHJ1Y3Rpb25zIHRoYW4gZXhwZWN0ZWQgZnJvbSBiYiBjb3VudC4NCg0KSSBkb24ndCBrbm93
IGhvdyB0byByZXByb2R1Y2UgdGhpcyB0ZXN0LiBEaWQgeW91IHJ1biBpdCBmcm9tIGEgc3Bl
Y2lmaWMgDQpkb2NrZXIgZW52Pw0KDQo+ICAgIOKenCAgLi9xZW11LWFhcmNoNjQgLXBsdWdp
biAuL3Rlc3RzL3BsdWdpbi9saWJpbnNuLnNvIC1wbHVnaW4gLi90ZXN0cy9wbHVnaW4vbGli
YmIuc28saW5saW5lPXRydWUgLWQgcGx1Z2luICAuL3Rlc3RzL3RjZy9hYXJjaDY0LWxpbnV4
LXVzZXIvc2hhNTEyDQo+ICAgIDEuLjEwDQo+ICAgIG9rIDEgLSBkb190ZXN0KCZ0ZXN0c1tp
XSkNCj4gICAgb2sgMiAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayAzIC0gZG9fdGVz
dCgmdGVzdHNbaV0pDQo+ICAgIG9rIDQgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sg
NSAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayA2IC0gZG9fdGVzdCgmdGVzdHNbaV0p
DQo+ICAgIG9rIDcgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgOCAtIGRvX3Rlc3Qo
JnRlc3RzW2ldKQ0KPiAgICBvayA5IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDEw
IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIENQVTA6IGJiJ3M6IDQxNTEzLCBpbnNuczog
MzAyNjcxDQo+ICAgIFRvdGFsOiBiYidzOiA0MTUxMywgaW5zbnM6IDMwMjY3MQ0KPiAgICBj
cHUgMCBpbnNuczogMzAyNjcxDQo+ICAgIHRvdGFsIGluc25zOiAzMDI2NzENCj4gDQo+IEFu
eXdheToNCj4gDQo+IFJldmlld2VkLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxp
bmFyby5vcmc+DQo+IA0K

