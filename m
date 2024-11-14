Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4386D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRE9-0007yh-8N; Wed, 13 Nov 2024 23:13:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRE6-0007re-8H
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:02 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRE3-0003qf-HL
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:00 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-723f37dd76cso137160b3a.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557578; x=1732162378; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8GxiMmfNCd6JoJv9qmjUXMyJ8YC4n8TxjdnfgVceKS8=;
 b=WX9bwzC+uZOVLAMe2sT0zptOI0Y/s6n6ldNjw0wAy7mk4KGQn6S3SH0An7/NxbmKOe
 9Y8mDw/g48rXco158YIkwl1JuyA23moBmH9bc1ghkED0W63udpjc8W2Rw2zisbuAsDwS
 Xzjink0pix3/wFLMXXG/XESIMUW6C8HNcwEsbwiENJYC+H0j2lwP9x/iB3mF+WgRh7Y7
 KNefBUkotvq7hab6Xr2zqvHTq9RP3ckvQpH3++3VlvTGZSUQeLpXFAS5E8zUd7KsjCYH
 dtCk5zCfBoRnO3fbT3oC01zp7rFbiG6ijbXKR+p5lZcNuqbPCvmGYljGt5+ZSfwKxi8K
 t04w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557578; x=1732162378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8GxiMmfNCd6JoJv9qmjUXMyJ8YC4n8TxjdnfgVceKS8=;
 b=l+e1mwdEHE1ea3VhxQZ1Pq2GXUV6HLv9qJ9PYAp5n734gAsqC1ymF9C2eRDNV73uEZ
 3TEYRKmiljiqmAXvvdkzRWOBqkz6FmvOPP90oYZP1fKbtLgdF8Sum61Obd6l3GQjPO4i
 ty3dm5nb1lKxHjXy55ecq1B7V8vox5UBPgcFkaqGcHtWdPHwU4vWfysKN4nwwh7iDPzE
 /kt+LwbY57lFqxAClhrk9lRDLGDAZMgFGFfSK5RootbdmkUbXAwl5au383ek4DvMiqvc
 EUTyh2DtLKFDo0XoJuxTYwkwg9b79bH2sZJ2GKHFyJkaKOJtrqub9/LZwwCmsep0ClNH
 5FGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8BsazO0t/uDhrCJ3gUKINY9Vl+cr/t7x26UJccbEhPuSeggxNQZ+fI/9BcygbTYbMdHnqquri+yMb@nongnu.org
X-Gm-Message-State: AOJu0YyV0PB8yXFaPrO6Oc8kj5qh8Y93siyGRm5Ms0TPM7DW/wgSL+nz
 HAPQv8iGZN5MpqwruOncGhWX1HDUyGSM8KKJ1Q0ow6G8FD8DxlFkxy+PFlfzVUA=
X-Google-Smtp-Source: AGHT+IHeyx1jbQyvVuldRgcF7U/onPNGHJ+FhW6qOfh5UbRsKkwgTE5UPe5BD2eTF99BuZ7DWSt7rA==
X-Received: by 2002:a05:6a00:3a06:b0:71e:6743:7599 with SMTP id
 d2e1a72fcca58-7245799e2damr6585758b3a.7.1731557578268; 
 Wed, 13 Nov 2024 20:12:58 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a5ce39bsm250836b3a.35.2024.11.13.20.12.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:12:57 -0800 (PST)
Message-ID: <86769558-7f36-4875-9453-707339937d49@linaro.org>
Date: Wed, 13 Nov 2024 20:12:55 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/24] exec: Declare tlb_reset_dirty*() in 'exec/cputlb.h'
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
 <20241114011310.3615-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
Lm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdXRsYi5oICAgfCA3ICsrKysrKysN
Cj4gICBpbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaCB8IDMgLS0tDQo+ICAgaW5jbHVkZS9leGVj
L3JhbV9hZGRyLmggfCAxICsNCj4gICBzeXN0ZW0vcGh5c21lbS5jICAgICAgICB8IDEgKw0K
PiAgIDQgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHV0bGIuaCBiL2luY2x1ZGUvZXhl
Yy9jcHV0bGIuaA0KPiBpbmRleCBlZjE4NjQyYTMyLi42Y2FjN2Q1MzBmIDEwMDY0NA0KPiAt
LS0gYS9pbmNsdWRlL2V4ZWMvY3B1dGxiLmgNCj4gKysrIGIvaW5jbHVkZS9leGVjL2NwdXRs
Yi5oDQo+IEBAIC0zMiw0ICszMiwxMSBAQCB2b2lkIHRsYl91bnByb3RlY3RfY29kZShyYW1f
YWRkcl90IHJhbV9hZGRyKTsNCj4gICANCj4gICAjZW5kaWYgLyogQ09ORklHX1RDRyAqLw0K
PiAgIA0KPiArI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+ICsNCj4gK3ZvaWQgdGxiX3Jl
c2V0X2RpcnR5KENQVVN0YXRlICpjcHUsIHJhbV9hZGRyX3Qgc3RhcnQxLCByYW1fYWRkcl90
IGxlbmd0aCk7DQo+ICt2b2lkIHRsYl9yZXNldF9kaXJ0eV9yYW5nZV9hbGwocmFtX2FkZHJf
dCBzdGFydCwgcmFtX2FkZHJfdCBsZW5ndGgpOw0KPiArDQo+ICsjZW5kaWYNCj4gKw0KPiAg
ICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL2V4ZWMtYWxsLmggYi9pbmNs
dWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiBpbmRleCAyZTRjNGNjNGI0Li4yYzA2ZTU0Mzg3IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiArKysgYi9pbmNsdWRl
L2V4ZWMvZXhlYy1hbGwuaA0KPiBAQCAtNTg5LDkgKzU4OSw2IEBAIHN0YXRpYyBpbmxpbmUg
dm9pZCBtbWFwX2xvY2sodm9pZCkge30NCj4gICBzdGF0aWMgaW5saW5lIHZvaWQgbW1hcF91
bmxvY2sodm9pZCkge30NCj4gICAjZGVmaW5lIFdJVEhfTU1BUF9MT0NLX0dVQVJEKCkNCj4g
ICANCj4gLXZvaWQgdGxiX3Jlc2V0X2RpcnR5KENQVVN0YXRlICpjcHUsIHJhbV9hZGRyX3Qg
c3RhcnQxLCByYW1fYWRkcl90IGxlbmd0aCk7DQo+IC12b2lkIHRsYl9yZXNldF9kaXJ0eV9y
YW5nZV9hbGwocmFtX2FkZHJfdCBzdGFydCwgcmFtX2FkZHJfdCBsZW5ndGgpOw0KPiAtDQo+
ICAgTWVtb3J5UmVnaW9uU2VjdGlvbiAqDQo+ICAgYWRkcmVzc19zcGFjZV90cmFuc2xhdGVf
Zm9yX2lvdGxiKENQVVN0YXRlICpjcHUsIGludCBhc2lkeCwgaHdhZGRyIGFkZHIsDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciAqeGxhdCwgaHdhZGRy
ICpwbGVuLA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVjL3JhbV9hZGRyLmggYi9pbmNs
dWRlL2V4ZWMvcmFtX2FkZHIuaA0KPiBpbmRleCA4OTFjNDRjZjJkLi5iNmQ1NTUxNTQ5IDEw
MDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvcmFtX2FkZHIuaA0KPiArKysgYi9pbmNsdWRl
L2V4ZWMvcmFtX2FkZHIuaA0KPiBAQCAtMjMsNiArMjMsNyBAQA0KPiAgICNpbmNsdWRlICJj
cHUuaCINCj4gICAjaW5jbHVkZSAic3lzZW11L3hlbi5oIg0KPiAgICNpbmNsdWRlICJzeXNl
bXUvdGNnLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9jcHV0bGIuaCINCj4gICAjaW5jbHVkZSAi
ZXhlYy9yYW1saXN0LmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvcmFtYmxvY2suaCINCj4gICAj
aW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiBkaWZmIC0tZ2l0IGEvc3lzdGVtL3BoeXNt
ZW0uYyBiL3N5c3RlbS9waHlzbWVtLmMNCj4gaW5kZXggZGMxZGIzYTM4NC4uM2Y5MzdhNWU1
OCAxMDA2NDQNCj4gLS0tIGEvc3lzdGVtL3BoeXNtZW0uYw0KPiArKysgYi9zeXN0ZW0vcGh5
c21lbS5jDQo+IEBAIC0zMiw2ICszMiw3IEBADQo+ICAgI2VuZGlmIC8qIENPTkZJR19UQ0cg
Ki8NCj4gICANCj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiArI2luY2x1ZGUg
ImV4ZWMvY3B1dGxiLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvcGFnZS1wcm90ZWN0aW9uLmgi
DQo+ICAgI2luY2x1ZGUgImV4ZWMvdGFyZ2V0X3BhZ2UuaCINCj4gICAjaW5jbHVkZSAiaHcv
cWRldi1jb3JlLmgiDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmlj
ay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

