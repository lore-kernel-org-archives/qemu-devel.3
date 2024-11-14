Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54DBD637DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBREV-00011P-Ie; Wed, 13 Nov 2024 23:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRES-0000nj-5X
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:24 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBREQ-0003tW-8K
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:23 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7246c8c9b1cso16324b3a.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557600; x=1732162400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7L7hggnNWHYxci88srbhFxnlBX1PYwIpz8QPRVwqhCo=;
 b=EW1syacjLGUc3Z4Ti0u2GLhJE6U5GtPMzzoTlMLIGkfkinEjImPFTrxYgFBxoANLfP
 7/I1hzI1SbOHQT2aUvjnkPmnP+GGmIdap7bZmXeoAHKkp4/wX5cxQrtPDdeMN5YqZw68
 g7aCn4lvmr2WLNouVLBW8Ml16uaKGSENObQobIJiIA83XwcvpLRwowW0GzsEQ6Rcig/9
 U/M7qtp5kidUIzcw5iodEhfcqwMy8p+Jx/3WwsT+Sk29a7AVayCvoL1aT2NK7VypFM/5
 7MlxrTy38DQgeZVzGkkC3BtzCj102xZGP9EiZH2FUq4dxp8xE4FQ8nm5tBhR0RksmMu2
 Qt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557600; x=1732162400;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7L7hggnNWHYxci88srbhFxnlBX1PYwIpz8QPRVwqhCo=;
 b=s2F1w27i2fonzLnq0xwfCLem52ognIogP/dVTPv5DrmqmgxT/7tSoPl719NkR876vV
 3I2REF9Zrg+K16q9V6tzvG2hI3Wl8K3c/edw9GJJAxjjZeG/SJpV/eDlUeZsdD9S/Drm
 IXj+TVQek8PSPmEdeGIGPoxajgwrLr3hGto8ksF0uennys06xbpL2ksB6MMe4kUtaDMN
 hSZjcQ/Z9luEYk0xuQFULuB3nrj7HvYxxHqGO4uUjq1Sntbff2UZcE96nR0/fJ83IV9F
 Siz9RQHdEDgeJ1b8SKkRZcyqjro4q6u3S3V/mtaRIo2RKnwYl2GintpT7RgXZcmy4t9M
 4XXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJi0wgd41kZGt1ORMFBrC9cBj9w+fYdDYdt1fDJ5zbADw1vlxYbU101svrd5hK5uCrsL4BpjmJUFRI@nongnu.org
X-Gm-Message-State: AOJu0YxGWTQb/0FrAUOyZkNwniKe5BOraCoTNkX8THDGImXTO/QSWjv0
 78AvjK7Z22uAj+u8v0qBHajf9k7xBreoK90zPfOqH8PORQNq5IQKM6b44SnG7P8=
X-Google-Smtp-Source: AGHT+IFTF16A1X9jKJcosfG0RWzU+DgL2mKVN3EYn9fB+OquNcg2LrMwBQJgt+F3MurCw/HqPF45dg==
X-Received: by 2002:a05:6a00:21cd:b0:71d:eb7d:20e4 with SMTP id
 d2e1a72fcca58-72469ca52a5mr947185b3a.8.1731557600056; 
 Wed, 13 Nov 2024 20:13:20 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9d3c6esm240465b3a.194.2024.11.13.20.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:13:19 -0800 (PST)
Message-ID: <1f277f46-f09a-4713-a9c1-1de739871d24@linaro.org>
Date: Wed, 13 Nov 2024 20:13:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/24] exec: Declare tlb_init/destroy() in 'exec/cputlb.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-15-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-15-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gMTEvMTMvMjQgMTc6MTIsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIENQVSBUTEIgcmVsYXRlZCBtZXRob2RzIHRvICJleGVjL2NwdXRsYi5oIi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdXRsYi5oICAgfCAyOCArKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tDQo+ICAgaW5jbHVkZS9leGVjL2V4ZWMtYWxsLmggfCAx
NyAtLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFjY2VsL3RjZy9jcHUtZXhlYy5jICAgIHwgIDEg
Kw0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL2NwdXRsYi5oIGIvaW5jbHVk
ZS9leGVjL2NwdXRsYi5oDQo+IGluZGV4IDZjYWM3ZDUzMGYuLjUzODZlNTM4MDYgMTAwNjQ0
DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9jcHV0bGIuaA0KPiArKysgYi9pbmNsdWRlL2V4ZWMv
Y3B1dGxiLmgNCj4gQEAgLTIyLDE1ICsyMiwzMyBAQA0KPiAgIA0KPiAgICNpbmNsdWRlICJl
eGVjL2NwdS1jb21tb24uaCINCj4gICANCj4gLSNpZmRlZiBDT05GSUdfVENHDQo+ICsjaWYg
ZGVmaW5lZChDT05GSUdfVENHKSAmJiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQ0KPiAr
DQo+ICsvKioNCj4gKyAqIHRsYl9pbml0IC0gaW5pdGlhbGl6ZSBhIENQVSdzIFRMQg0KPiAr
ICogQGNwdTogQ1BVIHdob3NlIFRMQiBzaG91bGQgYmUgaW5pdGlhbGl6ZWQNCj4gKyAqLw0K
PiArdm9pZCB0bGJfaW5pdChDUFVTdGF0ZSAqY3B1KTsNCj4gKw0KPiArLyoqDQo+ICsgKiB0
bGJfZGVzdHJveSAtIGRlc3Ryb3kgYSBDUFUncyBUTEINCj4gKyAqIEBjcHU6IENQVSB3aG9z
ZSBUTEIgc2hvdWxkIGJlIGRlc3Ryb3llZA0KPiArICovDQo+ICt2b2lkIHRsYl9kZXN0cm95
KENQVVN0YXRlICpjcHUpOw0KPiAgIA0KPiAtI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09O
TFkpDQo+IC0vKiBjcHV0bGIuYyAqLw0KPiAgIHZvaWQgdGxiX3Byb3RlY3RfY29kZShyYW1f
YWRkcl90IHJhbV9hZGRyKTsNCj4gICB2b2lkIHRsYl91bnByb3RlY3RfY29kZShyYW1fYWRk
cl90IHJhbV9hZGRyKTsNCj4gLSNlbmRpZg0KPiAgIA0KPiAtI2VuZGlmIC8qIENPTkZJR19U
Q0cgKi8NCj4gKyNlbHNlDQo+ICsNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB0bGJfaW5pdChD
UFVTdGF0ZSAqY3B1KQ0KPiArew0KPiArfQ0KPiArc3RhdGljIGlubGluZSB2b2lkIHRsYl9k
ZXN0cm95KENQVVN0YXRlICpjcHUpDQo+ICt7DQo+ICt9DQo+ICsNCj4gKyNlbmRpZiAvKiBD
T05GSUdfVENHICYmICFDT05GSUdfVVNFUl9PTkxZICovDQo+ICAgDQo+ICAgI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZDQo+ICAgDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvZXhl
Yy1hbGwuaCBiL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oDQo+IGluZGV4IDJjMDZlNTQzODcu
LmQ3OTIyMDM3NzMgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oDQo+
ICsrKyBiL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oDQo+IEBAIC00NywxNyArNDcsNiBAQCBz
dGF0aWMgaW5saW5lIGJvb2wgY3B1X2xvb3BfZXhpdF9yZXF1ZXN0ZWQoQ1BVU3RhdGUgKmNw
dSkNCj4gICB9DQo+ICAgDQo+ICAgI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpICYm
IGRlZmluZWQoQ09ORklHX1RDRykNCj4gLS8qIGNwdXRsYi5jICovDQo+IC0vKioNCj4gLSAq
IHRsYl9pbml0IC0gaW5pdGlhbGl6ZSBhIENQVSdzIFRMQg0KPiAtICogQGNwdTogQ1BVIHdo
b3NlIFRMQiBzaG91bGQgYmUgaW5pdGlhbGl6ZWQNCj4gLSAqLw0KPiAtdm9pZCB0bGJfaW5p
dChDUFVTdGF0ZSAqY3B1KTsNCj4gLS8qKg0KPiAtICogdGxiX2Rlc3Ryb3kgLSBkZXN0cm95
IGEgQ1BVJ3MgVExCDQo+IC0gKiBAY3B1OiBDUFUgd2hvc2UgVExCIHNob3VsZCBiZSBkZXN0
cm95ZWQNCj4gLSAqLw0KPiAtdm9pZCB0bGJfZGVzdHJveShDUFVTdGF0ZSAqY3B1KTsNCj4g
ICAvKioNCj4gICAgKiB0bGJfZmx1c2hfcGFnZToNCj4gICAgKiBAY3B1OiBDUFUgd2hvc2Ug
VExCIHNob3VsZCBiZSBmbHVzaGVkDQo+IEBAIC0yNDIsMTIgKzIzMSw2IEBAIHZvaWQgdGxi
X3NldF9wYWdlKENQVVN0YXRlICpjcHUsIHZhZGRyIGFkZHIsDQo+ICAgICAgICAgICAgICAg
ICAgICAgaHdhZGRyIHBhZGRyLCBpbnQgcHJvdCwNCj4gICAgICAgICAgICAgICAgICAgICBp
bnQgbW11X2lkeCwgdmFkZHIgc2l6ZSk7DQo+ICAgI2Vsc2UNCj4gLXN0YXRpYyBpbmxpbmUg
dm9pZCB0bGJfaW5pdChDUFVTdGF0ZSAqY3B1KQ0KPiAtew0KPiAtfQ0KPiAtc3RhdGljIGlu
bGluZSB2b2lkIHRsYl9kZXN0cm95KENQVVN0YXRlICpjcHUpDQo+IC17DQo+IC19DQo+ICAg
c3RhdGljIGlubGluZSB2b2lkIHRsYl9mbHVzaF9wYWdlKENQVVN0YXRlICpjcHUsIHZhZGRy
IGFkZHIpDQo+ICAgew0KPiAgIH0NCj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHUtZXhl
Yy5jIGIvYWNjZWwvdGNnL2NwdS1leGVjLmMNCj4gaW5kZXggODE2MzI5NWYzNC4uODc3MDQ5
MzU5MCAxMDA2NDQNCj4gLS0tIGEvYWNjZWwvdGNnL2NwdS1leGVjLmMNCj4gKysrIGIvYWNj
ZWwvdGNnL2NwdS1leGVjLmMNCj4gQEAgLTI0LDYgKzI0LDcgQEANCj4gICAjaW5jbHVkZSAi
aHcvY29yZS90Y2ctY3B1LW9wcy5oIg0KPiAgICNpbmNsdWRlICJ0cmFjZS5oIg0KPiAgICNp
bmNsdWRlICJkaXNhcy9kaXNhcy5oIg0KPiArI2luY2x1ZGUgImV4ZWMvY3B1dGxiLmgiDQo+
ICAgI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCINCj4gICAjaW5jbHVkZSAidGNnL3RjZy5o
Ig0KPiAgICNpbmNsdWRlICJxZW11L2F0b21pYy5oIg0KDQpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

