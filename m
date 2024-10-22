Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5680CDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LfW-0003kb-2L; Tue, 22 Oct 2024 16:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LfT-0003kC-NE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:39:51 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LfS-00009M-4U
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:39:51 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20c714cd9c8so60763405ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629588; x=1730234388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8716lgN4vd3OakIyJc2Ibs0xllERoZjKZIQIBT2RF3o=;
 b=XOtE+4xwQOYymJnLvRFXpuMbaoPhElGynqT0YjUfwm+buUBv6mRBbLJPED2gFaXR6v
 zlkPsdD6TrCrN7CAHPakTvrL0YBwdJATejsekPHlBjiG0Q5F8cBOypQFzt6CTJMn8xcF
 328xT961r0Z0oYKAsk4QjBcqArhZcUhXZx0NLyjEb+SyHobLmfUoAZs1mUAguOg+FPR9
 ep2IJXkNe8E94ijGBLejzLvXZQjb8Yk1RPdi2fhRGHWpOVe+Kb0m4pgzQBmL7iDylfLy
 853dpPgcevfVKVT5mzZey/3IZ3cOAeR1LWu8dY5fueuoJc0K08cwuTF62dOESGIQwlbK
 Scpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629588; x=1730234388;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8716lgN4vd3OakIyJc2Ibs0xllERoZjKZIQIBT2RF3o=;
 b=dCS7QgLf47Un457EsiGEAGh+yCoVg8x8fYWsRNFkhm0UMECk1oJDxc1GebBmD/pSy5
 k0sFT0RHtDOCvi4vHAnhSWqReODU+M5eaEJ1XC8Rn1rGdr8Y3zbzYkBZm1qzRJkNEklG
 O2Ob2ETp+ITfKnn3egSGk6KH84SG2nfxk/dB2HvHAfFb1enajCP5YGPI457ouwvtLkln
 yVI8lrHi8lsq9NGbC8y5zoCdLFp4gXsjcgEEU3vV/GE7qsTBjBN2+2tmyPSCvogMmVfr
 ZORXZ0NdPMPaMq0M8spujzrSKGWsLkDtnBlBVglzdeW86dcwGyWe/JxEI5fn/nf6iBE2
 Cr+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU1U/XorQzootgS6QDZOBTebFssb6TrEUiwzvwNOh4ZZJ3Kz5gyU6XKrYazfwKkNz7VEjqewc6y7jY@nongnu.org
X-Gm-Message-State: AOJu0YxPtHMohxqEOkT0pihKZXJ7d38DR5HuLcgYWoY0eG/et9AwoswN
 IfTDJlAb3UMDKr8YLhE0UQ9PzlZc2PwGI83vEcjzkQnZ80nTiCRVD51KytOMIGI=
X-Google-Smtp-Source: AGHT+IF1OaRSF/uO0aEsCCNn9rL9J/Dcu/AyvZOh73bRHQ8pyrVuOGOlGXYGIiRXLfzK3teLBdcL9A==
X-Received: by 2002:a17:90b:4b0d:b0:2c8:65cf:e820 with SMTP id
 98e67ed59e1d1-2e76b5b6b34mr236574a91.2.1729629588547; 
 Tue, 22 Oct 2024 13:39:48 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad389146sm6646573a91.26.2024.10.22.13.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:39:48 -0700 (PDT)
Message-ID: <244addee-9fa0-4476-aa40-a4a316336e61@linaro.org>
Date: Tue, 22 Oct 2024 13:39:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/20] testing: Enhance gdb probe script
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-16-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gRnJvbTogR3VzdGF2
byBSb21lcm8gPGd1c3Rhdm8ucm9tZXJvQGxpbmFyby5vcmc+DQo+IA0KPiBVc2UgbGlzdCBh
bmQgc2V0IGNvbXByZWhlbnNpb24gdG8gc2ltcGxpZnkgY29kZS4gQWxzbywgZ2VudGx5IGhh
bmRsZQ0KPiBpbnZhbGlkIGdkYiBmaWxlbmFtZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBH
dXN0YXZvIFJvbWVybyA8Z3VzdGF2by5yb21lcm9AbGluYXJvLm9yZz4NCj4gTWVzc2FnZS1J
ZDogPDIwMjQxMDE1MTQ1ODQ4LjM4NzI4MS0xLWd1c3Rhdm8ucm9tZXJvQGxpbmFyby5vcmc+
DQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgc2NyaXB0cy9wcm9iZS1nZGItc3VwcG9ydC5weSB8IDc1ICsrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAz
OSBpbnNlcnRpb25zKCspLCAzNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9z
Y3JpcHRzL3Byb2JlLWdkYi1zdXBwb3J0LnB5IGIvc2NyaXB0cy9wcm9iZS1nZGItc3VwcG9y
dC5weQ0KPiBpbmRleCA2ZGM1OGQwNmM3Li42YmNhZGNlMTUwIDEwMDY0NA0KPiAtLS0gYS9z
Y3JpcHRzL3Byb2JlLWdkYi1zdXBwb3J0LnB5DQo+ICsrKyBiL3NjcmlwdHMvcHJvYmUtZ2Ri
LXN1cHBvcnQucHkNCj4gQEAgLTE5LDU4ICsxOSw2MSBAQA0KPiAgIA0KPiAgIGltcG9ydCBh
cmdwYXJzZQ0KPiAgIGltcG9ydCByZQ0KPiAtZnJvbSBzdWJwcm9jZXNzIGltcG9ydCBjaGVj
a19vdXRwdXQsIFNURE9VVA0KPiArZnJvbSBzdWJwcm9jZXNzIGltcG9ydCBjaGVja19vdXRw
dXQsIFNURE9VVCwgQ2FsbGVkUHJvY2Vzc0Vycm9yDQo+ICtpbXBvcnQgc3lzDQo+ICAgDQo+
IC0jIG1hcHBpbmdzIGZyb20gZ2RiIGFyY2ggdG8gUUVNVSB0YXJnZXQNCj4gLW1hcHBpbmdz
ID0gew0KPiAtICAgICJhbHBoYSIgOiAiYWxwaGEiLA0KPiArIyBNYXBwaW5ncyBmcm9tIGdk
YiBhcmNoIHRvIFFFTVUgdGFyZ2V0DQo+ICtNQVAgPSB7DQo+ICsgICAgImFscGhhIiA6IFsi
YWxwaGEiXSwNCj4gICAgICAgImFhcmNoNjQiIDogWyJhYXJjaDY0IiwgImFhcmNoNjRfYmUi
XSwNCj4gLSAgICAiYXJtdjciOiAiYXJtIiwNCj4gKyAgICAiYXJtdjciOiBbImFybSJdLA0K
PiAgICAgICAiYXJtdjgtYSIgOiBbImFhcmNoNjQiLCAiYWFyY2g2NF9iZSJdLA0KPiAtICAg
ICJhdnIiIDogImF2ciIsDQo+ICsgICAgImF2ciIgOiBbImF2ciJdLA0KPiAgICAgICAjIG5v
IGhleGFnb24gaW4gdXBzdHJlYW0gZ2RiDQo+IC0gICAgImhwcGExLjAiIDogImhwcGEiLA0K
PiAtICAgICJpMzg2IiA6ICJpMzg2IiwNCj4gLSAgICAiaTM4Njp4ODYtNjQiIDogIng4Nl82
NCIsDQo+IC0gICAgIkxvb25nYXJjaDY0IiA6ICJsb29uZ2FyY2g2NCIsDQo+IC0gICAgIm02
OGsiIDogIm02OGsiLA0KPiAtICAgICJNaWNyb0JsYXplIiA6ICJtaWNyb2JsYXplIiwNCj4g
KyAgICAiaHBwYTEuMCIgOiBbImhwcGEiXSwNCj4gKyAgICAiaTM4NiIgOiBbImkzODYiXSwN
Cj4gKyAgICAiaTM4Njp4ODYtNjQiIDogWyJ4ODZfNjQiXSwNCj4gKyAgICAiTG9vbmdhcmNo
NjQiIDogWyJsb29uZ2FyY2g2NCJdLA0KPiArICAgICJtNjhrIiA6IFsibTY4ayJdLA0KPiAr
ICAgICJNaWNyb0JsYXplIiA6IFsibWljcm9ibGF6ZSJdLA0KPiAgICAgICAibWlwczppc2E2
NCIgOiBbIm1pcHM2NCIsICJtaXBzNjRlbCJdLA0KPiAtICAgICJvcjFrIiA6ICJvcjFrIiwN
Cj4gLSAgICAicG93ZXJwYzpjb21tb24iIDogInBwYyIsDQo+ICsgICAgIm9yMWsiIDogWyJv
cjFrIl0sDQo+ICsgICAgInBvd2VycGM6Y29tbW9uIiA6IFsicHBjIl0sDQo+ICAgICAgICJw
b3dlcnBjOmNvbW1vbjY0IiA6IFsicHBjNjQiLCAicHBjNjRsZSJdLA0KPiAtICAgICJyaXNj
djpydjMyIiA6ICJyaXNjdjMyIiwNCj4gLSAgICAicmlzY3Y6cnY2NCIgOiAicmlzY3Y2NCIs
DQo+IC0gICAgInMzOTA6NjQtYml0IiA6ICJzMzkweCIsDQo+ICsgICAgInJpc2N2OnJ2MzIi
IDogWyJyaXNjdjMyIl0sDQo+ICsgICAgInJpc2N2OnJ2NjQiIDogWyJyaXNjdjY0Il0sDQo+
ICsgICAgInMzOTA6NjQtYml0IiA6IFsiczM5MHgiXSwNCj4gICAgICAgInNoNCIgOiBbInNo
NCIsICJzaDRlYiJdLA0KPiAtICAgICJzcGFyYyI6ICJzcGFyYyIsDQo+IC0gICAgInNwYXJj
OnY4cGx1cyI6ICJzcGFyYzMycGx1cyIsDQo+IC0gICAgInNwYXJjOnY5YSIgOiAic3BhcmM2
NCIsDQo+ICsgICAgInNwYXJjIjogWyJzcGFyYyJdLA0KPiArICAgICJzcGFyYzp2OHBsdXMi
OiBbInNwYXJjMzJwbHVzIl0sDQo+ICsgICAgInNwYXJjOnY5YSIgOiBbInNwYXJjNjQiXSwN
Cj4gICAgICAgIyBubyB0cmljb3JlIGluIHVwc3RyZWFtIGdkYg0KPiAgICAgICAieHRlbnNh
IiA6IFsieHRlbnNhIiwgInh0ZW5zYWViIl0NCj4gICB9DQo+ICAgDQo+ICsNCj4gICBkZWYg
ZG9fcHJvYmUoZ2RiKToNCj4gLSAgICBnZGJfb3V0ID0gY2hlY2tfb3V0cHV0KFtnZGIsDQo+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIi1leCIsICJzZXQgYXJjaGl0ZWN0dXJl
IiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAiLWV4IiwgInF1aXQiXSwgc3Rk
ZXJyPVNURE9VVCkNCj4gKyAgICB0cnk6DQo+ICsgICAgICAgIGdkYl9vdXQgPSBjaGVja19v
dXRwdXQoW2dkYiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiLWV4Iiwg
InNldCBhcmNoaXRlY3R1cmUiLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICItZXgiLCAicXVpdCJdLCBzdGRlcnI9U1RET1VULCBlbmNvZGluZz0idXRmLTgiKQ0KPiAr
ICAgIGV4Y2VwdCAoT1NFcnJvcikgYXMgZToNCj4gKyAgICAgICAgc3lzLmV4aXQoZSkNCj4g
KyAgICBleGNlcHQgQ2FsbGVkUHJvY2Vzc0Vycm9yIGFzIGU6DQo+ICsgICAgICAgIHN5cy5l
eGl0KGYne2V9LiBPdXRwdXQ6XG5cbntlLm91dHB1dH0nKQ0KPiArDQo+ICsgICAgZm91bmRf
Z2RiX2FyY2hzID0gcmUuc2VhcmNoKHInVmFsaWQgYXJndW1lbnRzIGFyZSAoLiopJywgZ2Ri
X291dCkNCj4gICANCj4gLSAgICBtID0gcmUuc2VhcmNoKHIiVmFsaWQgYXJndW1lbnRzIGFy
ZSAoLiopIiwNCj4gLSAgICAgICAgICAgICAgICAgIGdkYl9vdXQuZGVjb2RlKCJ1dGYtOCIp
KQ0KPiArICAgIHRhcmdldHMgPSBzZXQoKQ0KPiArICAgIGlmIGZvdW5kX2dkYl9hcmNoczoN
Cj4gKyAgICAgICAgZ2RiX2FyY2hzID0gZm91bmRfZ2RiX2FyY2hzLmdyb3VwKDEpLnNwbGl0
KCIsICIpDQo+ICsgICAgICAgIG1hcHBlZF9nZGJfYXJjaHMgPSBbYXJjaCBmb3IgYXJjaCBp
biBnZGJfYXJjaHMgaWYgYXJjaCBpbiBNQVBdDQo+ICAgDQo+IC0gICAgdmFsaWRfYXJjaGVz
ID0gc2V0KCkNCj4gKyAgICAgICAgdGFyZ2V0cyA9IHt0YXJnZXQgZm9yIGFyY2ggaW4gbWFw
cGVkX2dkYl9hcmNocyBmb3IgdGFyZ2V0IGluIE1BUFthcmNoXX0NCj4gICANCj4gLSAgICBp
ZiBtLmdyb3VwKDEpOg0KPiAtICAgICAgICBmb3IgYXJjaCBpbiBtLmdyb3VwKDEpLnNwbGl0
KCIsICIpOg0KPiAtICAgICAgICAgICAgaWYgYXJjaCBpbiBtYXBwaW5nczoNCj4gLSAgICAg
ICAgICAgICAgICBtYXBwaW5nID0gbWFwcGluZ3NbYXJjaF0NCj4gLSAgICAgICAgICAgICAg
ICBpZiBpc2luc3RhbmNlKG1hcHBpbmcsIHN0cik6DQo+IC0gICAgICAgICAgICAgICAgICAg
IHZhbGlkX2FyY2hlcy5hZGQobWFwcGluZykNCj4gLSAgICAgICAgICAgICAgICBlbHNlOg0K
PiAtICAgICAgICAgICAgICAgICAgICBmb3IgZW50cnkgaW4gbWFwcGluZzoNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgIHZhbGlkX2FyY2hlcy5hZGQoZW50cnkpDQo+ICsgICAgIyBR
RU1VIHRhcmdldHMNCj4gKyAgICByZXR1cm4gdGFyZ2V0cw0KPiAgIA0KPiAtICAgIHJldHVy
biB2YWxpZF9hcmNoZXMNCj4gICANCj4gICBkZWYgbWFpbigpIC0+IE5vbmU6DQo+ICAgICAg
IHBhcnNlciA9IGFyZ3BhcnNlLkFyZ3VtZW50UGFyc2VyKGRlc2NyaXB0aW9uPSdQcm9iZSBH
REIgQXJjaGl0ZWN0dXJlcycpDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxw
aWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

