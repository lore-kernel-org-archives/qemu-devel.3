Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C83D637DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRF7-0003bo-Oe; Wed, 13 Nov 2024 23:14:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRF4-0003Q9-JP
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:14:03 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRF2-00040B-5X
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:14:02 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-288c7567f5dso88426fac.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557639; x=1732162439; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NI0KtHErs1HVTioMiCY/gWkuMqjAo5vsgkCR/gkoAvI=;
 b=sGjzAGtxyT1CqBuLFb0BWFt55Q40quZXuzyVygQfKVlQc9egdk/efd9iTDSAfwYb5I
 BYTnO5ZkHEYBzhxDiO5wvRfMz4ScfRp/iWbsrgQMHXivAJd2R6Uq1NcL1iSvElkLxJ/O
 RXtXPCCe31nr3SBNIPCAOa73HuuKUaYr6IEctuacP6t7isbRpHTmigyQN+vsTtU4UZJx
 yRnm7h9zNUTr9XQvMf+YyyxBTJQ3T+a6BbvAqnhJSmxI3ZU674x53J125ub9racpAlcj
 7pDi/ekynuVBtZWGgH93vAPgH2t/cSpS7aXMBmsD347qBoJ2OxEP4MfSkyNH1EgCqVqd
 pwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557639; x=1732162439;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NI0KtHErs1HVTioMiCY/gWkuMqjAo5vsgkCR/gkoAvI=;
 b=pdcXxl57/9DfJekMpKdfkKIJx7CywMqABZdEOiCMizzLj9qHoNjUSoHcWg95GK6+DI
 Jkv2OuM/2WLF9uW519NGaaTCEqfj3WTj1APBtAXgmc54l1JB+MXwv5CAorgO0JRhgoPv
 KYy9P0nEwwmP3skgkc8hwd7JgUK8vgu66g5Qg2TZUHi87n8b+68ISPAwRj9zTS70Zi6F
 HueygwAeGbuaLp7EMMtTmFQLBXXs2gYDM4vxeXj66B2QLo3w6Xbq9ySggklyDenrpUDY
 l7UoIdm+5CUGHwyIuWOTu/gxI4KrfZwfwcg29e8vi5CRHbvQOpoX+S2nVcf9fUDwqrVu
 HcVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFzf6oXw6BH4F+wstNMRe/eWX9t4z6EQ+ev+Lt4gZU9fj40o4h2YhoCAy6sr34OE84KzyuIX/mkP4R@nongnu.org
X-Gm-Message-State: AOJu0YwkUFtPqiCKs3UHj/VuBiWC21jeQv9MdLBeYf2GejtSbBuaQWrl
 8QmBA0eBCqzui9VhHfaE1o0J0S1shMf8CAO4VCKCE2lyB98oL6O5JgtoAA1kwZQ=
X-Google-Smtp-Source: AGHT+IHYhmjsCgkzpWTEAK/fYsb6YpKUoFbLS2Hrlh1Lo3WdJNal1XB7y8TNYaoah7cc5fAS0a1AiQ==
X-Received: by 2002:a05:6870:40c2:b0:277:eb79:b4fb with SMTP id
 586e51a60fabf-29560043547mr18293308fac.1.1731557638663; 
 Wed, 13 Nov 2024 20:13:58 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b36da8d0sm117984a12.7.2024.11.13.20.13.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:13:58 -0800 (PST)
Message-ID: <509556a4-1e34-4db3-a7bf-3242896cf91b@linaro.org>
Date: Wed, 13 Nov 2024 20:13:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/24] exec: Declare tlb_set_page() in 'exec/cputlb.h'
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
 <20241114011310.3615-18-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-18-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x31.google.com
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

T24gMTEvMTMvMjQgMTc6MTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIENQVSBUTEIgcmVsYXRlZCBtZXRob2RzIHRvICJleGVjL2NwdXRsYi5oIi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdXRsYi5oICAgfCAxMSArKysrKysr
KysrKw0KPiAgIGluY2x1ZGUvZXhlYy9leGVjLWFsbC5oIHwgIDkgLS0tLS0tLS0tDQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHV0bGIuaCBiL2luY2x1ZGUvZXhlYy9j
cHV0bGIuaA0KPiBpbmRleCBhZTQ3OThhMDE3Li45MDc1ZDk0ZWM1IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2V4ZWMvY3B1dGxiLmgNCj4gKysrIGIvaW5jbHVkZS9leGVjL2NwdXRsYi5o
DQo+IEBAIC0xMDgsNCArMTA4LDE1IEBAIHZvaWQgdGxiX3NldF9wYWdlX3dpdGhfYXR0cnMo
Q1BVU3RhdGUgKmNwdSwgdmFkZHIgYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBwYWRkciwgTWVtVHhBdHRycyBhdHRycywNCj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBwcm90LCBpbnQgbW11X2lkeCwgdmFkZHIgc2l6ZSk7
DQo+ICAgDQo+ICsvKioNCj4gKyAqIHRsYl9zZXRfcGFnZToNCj4gKyAqDQo+ICsgKiBUaGlz
IGZ1bmN0aW9uIGlzIGVxdWl2YWxlbnQgdG8gY2FsbGluZyB0bGJfc2V0X3BhZ2Vfd2l0aF9h
dHRycygpDQo+ICsgKiB3aXRoIGFuIEBhdHRycyBhcmd1bWVudCBvZiBNRU1UWEFUVFJTX1VO
U1BFQ0lGSUVELiBJdCdzIHByb3ZpZGVkDQo+ICsgKiBhcyBhIGNvbnZlbmllbmNlIGZvciBD
UFVzIHdoaWNoIGRvbid0IHVzZSBtZW1vcnkgdHJhbnNhY3Rpb24gYXR0cmlidXRlcy4NCj4g
KyAqLw0KPiArdm9pZCB0bGJfc2V0X3BhZ2UoQ1BVU3RhdGUgKmNwdSwgdmFkZHIgYWRkciwN
Cj4gKyAgICAgICAgICAgICAgICAgIGh3YWRkciBwYWRkciwgaW50IHByb3QsDQo+ICsgICAg
ICAgICAgICAgICAgICBpbnQgbW11X2lkeCwgdmFkZHIgc2l6ZSk7DQo+ICsNCj4gICAjZW5k
aWYNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9leGVjLWFsbC5oIGIvaW5jbHVkZS9l
eGVjL2V4ZWMtYWxsLmgNCj4gaW5kZXggMmIzMTRkNjU4Yi4uMmU1ODU0MDAwNSAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS9leGVjL2V4ZWMtYWxsLmgNCj4gKysrIGIvaW5jbHVkZS9leGVj
L2V4ZWMtYWxsLmgNCj4gQEAgLTE3NCwxNSArMTc0LDYgQEAgdm9pZCB0bGJfZmx1c2hfcmFu
Z2VfYnlfbW11aWR4X2FsbF9jcHVzX3N5bmNlZChDUFVTdGF0ZSAqY3B1LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDE2X3QgaWR4
bWFwLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdW5zaWduZWQgYml0cyk7DQo+ICAgDQo+IC0vKiB0bGJfc2V0X3BhZ2U6DQo+IC0gKg0K
PiAtICogVGhpcyBmdW5jdGlvbiBpcyBlcXVpdmFsZW50IHRvIGNhbGxpbmcgdGxiX3NldF9w
YWdlX3dpdGhfYXR0cnMoKQ0KPiAtICogd2l0aCBhbiBAYXR0cnMgYXJndW1lbnQgb2YgTUVN
VFhBVFRSU19VTlNQRUNJRklFRC4gSXQncyBwcm92aWRlZA0KPiAtICogYXMgYSBjb252ZW5p
ZW5jZSBmb3IgQ1BVcyB3aGljaCBkb24ndCB1c2UgbWVtb3J5IHRyYW5zYWN0aW9uIGF0dHJp
YnV0ZXMuDQo+IC0gKi8NCj4gLXZvaWQgdGxiX3NldF9wYWdlKENQVVN0YXRlICpjcHUsIHZh
ZGRyIGFkZHIsDQo+IC0gICAgICAgICAgICAgICAgICBod2FkZHIgcGFkZHIsIGludCBwcm90
LA0KPiAtICAgICAgICAgICAgICAgICAgaW50IG1tdV9pZHgsIHZhZGRyIHNpemUpOw0KPiAg
ICNlbHNlDQo+ICAgc3RhdGljIGlubGluZSB2b2lkIHRsYl9mbHVzaF9wYWdlKENQVVN0YXRl
ICpjcHUsIHZhZGRyIGFkZHIpDQo+ICAgew0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

