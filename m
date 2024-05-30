Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9733FC25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnv9-0007OS-0c; Thu, 30 May 2024 18:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnv7-0007Nu-5P
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:49 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnv5-0005LT-Bq
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:48 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso681744b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717106805; x=1717711605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pz2VzBU99inOzVYNe6AT4AW7Qf2QtGtPqfbSxBQQeT0=;
 b=u9mHm3L792xwOfg+hS5EKB2omUPpat0dGhgpKYLn2QXSbls+3IJ6ykyD32cdUazyMy
 Iki1Hy6CjDICJfoPJaY+aBd6H+uXP63XJ1yAgn80o6dxdP3/MuwRH2kmehY5bsHdpUWX
 sVB8Wjfa1KFeqFfkXmgWf+Dr67U0HSC3sIOUQTviNFL+hdLPwbeThLuhFosuRd/ZFrAg
 /C/B7qtBPypewWedpNyQ/n1HF9H5ATtP0ts7DCABkZs+FBhPfXmoOgpDqD6ifrbzpsU0
 zX3hH+yxuMYw2OTAn+9dT5GJ1KR/GcFYqtNP+lYAq3mrqtMetJEv0+zzeGj31nebytwF
 IpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717106805; x=1717711605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pz2VzBU99inOzVYNe6AT4AW7Qf2QtGtPqfbSxBQQeT0=;
 b=RIxvAgJYxn5qkj9Vv2iUAUfU57y1ORMxhGdkhOKi7atjDJqdARyIltdKhxl4R5a6vc
 vMOY6NCJ53PLLJ/ui12wtBAj0XFwcsWUn1uAEhy+0YZgXtDbu8YXX5+v/g8qzqlHsr4S
 zP3aJVp0PNgjvCpIPhrviMAwlZpFjAskPNLdKFnFNoiqGSBSRIOq+S3Zq2jHTtqykk+X
 JwX9kFY8CRc8JU5pbby9Rc3n1zvJ6hSscJ2SAjm0HOHb5mw1jGW/OFGBW/soqPu/PT6U
 utJYKs8eIylr0UJu5+zTZdWsUZEzYgG1gnGMe0Y2xS3RS54dSjDua0EgsVXQmROkBAEU
 zhMQ==
X-Gm-Message-State: AOJu0Ywdo/rN2Mm32eR8QgqddziyCRC3PRZf5++7NYVOczr1s8dQXYZU
 sZFqDy4pOeDFYUG9OK6wVe4J+HsHcbkp57bbu7Uq6j8z81DgRI88yN1IkKSKb+zUinGwJViS5PN
 z9Mc=
X-Google-Smtp-Source: AGHT+IFDE95sJdOPF/bOhzaoMqwf1MAdTLINz2J6Ikd/OSiWrlnV43ZhHaacAzgTE87YcFoZWiMD3w==
X-Received: by 2002:a17:903:2584:b0:1f3:29f1:76be with SMTP id
 d9443c01a7336-1f6370e5ff6mr906885ad.56.1717106804740; 
 Thu, 30 May 2024 15:06:44 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f632356aabsm2699715ad.78.2024.05.30.15.06.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 15:06:44 -0700 (PDT)
Message-ID: <a1929ada-a24c-41d5-a9a0-3898b8b2614a@linaro.org>
Date: Thu, 30 May 2024 15:06:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Implement icount=auto using TCG Plugins
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20240530174939.749163-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

QSB2MyB3YXMganVzdCBzZW50LCB3aXRoIGEgZml4IHRvIHRoZSBhbGdvcml0aG0gdXNlZC4N
Cg0KT24gNS8zMC8yNCAxMDo0OSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gVGhlIGdv
YWwgaGVyZSBpcyB0byBiZSBhYmxlIHRvIHNjYWxlIHRlbXBvcmFsbHkgZXhlY3V0aW9uIG9m
IHFlbXUtdXNlci9zeXN0ZW0sDQo+IHVzaW5nIGEgZ2l2ZW4gbnVtYmVyIG9mIGluc3RydWN0
aW9ucyBwZXIgc2Vjb25kLg0KPiANCj4gV2UgZGVmaW5lIGEgdmlydHVhbCBjbG9jaywgdGhh
dCBjYW4gYmUgbGF0ZSBvciBpbiBhZHZhbmNlIGNvbXBhcmVkIHRvIHJlYWwgdGltZS4NCj4g
V2hlbiB3ZSBhcmUgaW4gYWR2YW5jZSwgd2Ugc2xvdyBleGVjdXRpb24gKGJ5IHNsZWVwaW5n
KSB1bnRpbCBjYXRjaGluZyByZWFsDQo+IHRpbWUuDQo+IA0KPiBGaW5hbGx5LCB3ZSBzaG91
bGQgYmUgYWJsZSB0byBjbGVhbnVwIGljb3VudD1hdXRvIG1vZGUgY29tcGxldGVseSwgYW5k
IGtlZXANCj4gaWNvdW50IHVzYWdlIGZvciBkZXRlcm1pc3RpYyBwdXJwb3NlcyBvbmx5Lg0K
PiANCj4gSXQgaXMgYnVpbHQgdXBvbiBuZXcgVENHIFBsdWdpbnMgaW5saW5lIG9wcyAoc3Rv
cmUgKyBjb25kaXRpb25hbCBjYWxsYmFja3MpLCBub3cNCj4gbWVyZ2VkIG9uIG1hc3Rlci4N
Cj4gDQo+IEV4YW1wbGUgaW4gdXNlci1tb2RlOg0KPiANCj4gLSBSZXRyaWV2ZSBudW1iZXIg
b2YgaW5zdHJ1Y3Rpb25zIHRvIGV4ZWN1dGUgL2Jpbi90cnVlDQo+ICQgLi9idWlsZC9xZW11
LXg4Nl82NCAtcGx1Z2luIC4vYnVpbGQvdGVzdHMvcGx1Z2luL2xpYmluc24uc28gLWQgcGx1
Z2luIC9iaW4vdHJ1ZQ0KPiBjcHUgMCBpbnNuczogMTIwNTQ2DQo+IHRvdGFsIGluc25zOiAx
MjA1NDYNCj4gLSBTbG93IGV4ZWN1dGlvbiB0byBtYXRjaCA1IHNlY29uZHMNCj4gJCB0aW1l
IC4vYnVpbGQvcWVtdS14ODZfNjQgLXBsdWdpbiAuL2J1aWxkL2NvbnRyaWIvcGx1Z2lucy9s
aWJpcHMsaXBzPSQoKDEyMDU0Ni81KSkgL2Jpbi90cnVlDQo+IHJlYWwgICAgMG00Ljk4NXMN
Cj4gDQo+IHYyDQo+IC0tDQo+IA0KPiAtIEFkZGVkIG1pc3NpbmcgcGVyc29uYWwgU2lnbmVk
LW9mZi1ieSBmb3IgY29tbWl0cyBmcm9tIEFsZXgNCj4gLSBGaXggYmFkIHJlYmFzZSBpbiBz
dHVicy9tZXNvbi5idWlsZA0KPiAtIG1vdmUgcXRlc3Rfe2dldCxzZXR9X3ZpcnR1YWxfY2xv
Y2sgdG8gYWNjZWwvcXRlc3QvcXRlc3QuYw0KPiAtIEEgcmFjZSBjb25kaXRpb24gd2FzIGlk
ZW50aWZpZWQgZm9yIHBsdWdpbnMgaW5pdC9pZGxlL3Jlc3VtZSwgYnV0IGlzIG5vdA0KPiAg
ICByZWxhdGVkIHRvIHRoaXMgc2VyaWVzLCBhbmQgd2lsbCBiZSBmaXhlZCBpbiBhbm90aGVy
IG9uZToNCj4gICAgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI0MDUy
OTE1MjIxOS44MjU2ODAtMS1hbGV4LmJlbm5lZUBsaW5hcm8ub3JnLw0KPiANCj4gQWxleCBC
ZW5uw6llICg0KToNCj4gICAgc3lzZW11OiBhZGQgc2V0X3ZpcnR1YWxfdGltZSB0byBhY2Nl
bCBvcHMNCj4gICAgcXRlc3Q6IHVzZSBjcHUgaW50ZXJmYWNlIGluIHF0ZXN0X2Nsb2NrX3dh
cnANCj4gICAgc3lzZW11OiBnZW5lcmFsaXNlIHF0ZXN0X3dhcnBfY2xvY2sgYXMgcWVtdV9j
bG9ja19hZHZhbmNlX3ZpcnR1YWxfdGltZQ0KPiAgICBwbHVnaW5zOiBhZGQgdGltZSBjb250
cm9sIEFQSQ0KPiANCj4gUGllcnJpY2sgQm91dmllciAoMik6DQo+ICAgIHF0ZXN0OiBtb3Zl
IHF0ZXN0X3tnZXQsc2V0fV92aXJ0dWFsX2Nsb2NrIHRvIGFjY2VsL3F0ZXN0L3F0ZXN0LmMN
Cj4gICAgY29udHJpYi9wbHVnaW5zOiBhZGQgaXBzIHBsdWdpbiBleGFtcGxlIGZvciBjb3N0
IG1vZGVsaW5nDQo+IA0KPiAgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oICAgICAgICAg
ICAgICAgICAgICB8ICAyMyArKw0KPiAgIGluY2x1ZGUvcWVtdS90aW1lci5oICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxNSArKw0KPiAgIGluY2x1ZGUvc3lzZW11L2FjY2VsLW9w
cy5oICAgICAgICAgICAgICAgICAgICB8ICAxOCArLQ0KPiAgIGluY2x1ZGUvc3lzZW11L2Nw
dS10aW1lcnMuaCAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiAgIGluY2x1ZGUvc3lz
ZW11L3F0ZXN0LmggICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiAtDQo+ICAgYWNjZWwv
cXRlc3QvcXRlc3QuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEzICsNCj4gICBj
b250cmliL3BsdWdpbnMvaXBzLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMzkgKysr
KysrKysrKysrKysrKysrDQo+ICAgcGx1Z2lucy9hcGkuYyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDMxICsrKw0KPiAgIC4uLnQtdmlydHVhbC1jbG9jay5jID0+IGNw
dXMtdmlydHVhbC1jbG9jay5jfSB8ICAgNSArDQo+ICAgc3lzdGVtL2NwdXMuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDExICsNCj4gICBzeXN0ZW0vcXRlc3QuYyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzcgKy0tDQo+ICAgdXRpbC9xZW11
LXRpbWVyLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDI2ICsrDQo+ICAgY29u
dHJpYi9wbHVnaW5zL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4g
ICBwbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xzICAgICAgICAgICAgICAgICAgfCAgIDIg
Kw0KPiAgIHN0dWJzL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAgMiArLQ0KPiAgIDE1IGZpbGVzIGNoYW5nZWQsIDM4OSBpbnNlcnRpb25zKCspLCAzOSBk
ZWxldGlvbnMoLSkNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9wbHVnaW5zL2lw
cy5jDQo+ICAgcmVuYW1lIHN0dWJzL3tjcHVzLWdldC12aXJ0dWFsLWNsb2NrLmMgPT4gY3B1
cy12aXJ0dWFsLWNsb2NrLmN9ICg2OCUpDQo+IA0K

