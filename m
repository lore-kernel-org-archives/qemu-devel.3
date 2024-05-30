Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BE4C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjmi-00012d-Kl; Thu, 30 May 2024 13:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjme-00012H-Oh
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:41:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjmQ-000135-NN
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:41:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1f44b45d6abso7983035ad.0
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717090891; x=1717695691; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZVyzh+XQsyBO518b5aSiCYPZOb5HbySNClhYJPJuHY=;
 b=gzBRu0VRVdkUQQKFuj8d/HFTEx50+AcLnb/6tXrX7PCTl2WFcpV4iCl+C3a1sZsvMR
 1XGjO/MxuVwmumoZWeJf67OdUG18ldaqzO782zYHLRL22HLY+vS9OSuIjCzxoMDr9lOr
 InKu9wdQmyhzcBJEz6wtqtr/gxF05+azeGblhBvJQzEEk1ecmbRmygrALRJUtb8ccBy2
 mMMZJZeaRu1CCDXpCgUA/+ZWQ8rWLrjawUhTNBnY+Vc2l83lQZyJs6hrjQxKhEsjRb6N
 jy2HtI2pH0Pn8y6mJtjiupqamq2edpi+mgfhULzt9U0THkVAc4AyvMzL2jz/YvR1zRsQ
 N4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717090891; x=1717695691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZVyzh+XQsyBO518b5aSiCYPZOb5HbySNClhYJPJuHY=;
 b=YksEYxIhrJoemwA9I6jtE9gLD66lX8UgkcCvPOrFdUo5jddRU7haAFQm60T1O/e3rf
 2SoeE6EUZ6Qydzs1Zy1HBMOe7CJtmlU3fpOdZ7BpB5I6YghbqnmJ2eTHDxqrVoN5Qj9r
 PIYqW9RJV9IKV7aafc+qHSANslw6kTtxt77m3ywiyxfdk/y2hk2qkr3kw3ujwAozw0de
 INn0S46TOev1OZvgRtl6kkOWZ/ddWZQ3c2jtVm6++2OTXN0AJyI+MpXnNECd25ohoT2v
 9ykS8FjLFLq708jdFZJKs5rem2mKhYhukVIFYKnqL2OprjxeyOj9TaH8JRQ9llO+68cr
 4V8Q==
X-Gm-Message-State: AOJu0YzvR66mX6Hn9IwG1IltTHj6rMdaTHo0923lhCgzU+bEZpzoHX/1
 KvNhLFLQ3+HEBP2WNKZ0ljUwfv63H2v177kbxF6mqjL2G5PNn8ySaSarrkuCf1o=
X-Google-Smtp-Source: AGHT+IGnuB/tZhuLbexTwHfJWlq/0Y6Yqn6zijveC5kjaPZ8g4g2KLJHT7Y8Q8fLrfTKXa3lfjddEw==
X-Received: by 2002:a17:902:d2ce:b0:1f4:8372:db24 with SMTP id
 d9443c01a7336-1f619623557mr35910965ad.38.1717090891193; 
 Thu, 30 May 2024 10:41:31 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323decd2sm494095ad.175.2024.05.30.10.41.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 10:41:30 -0700 (PDT)
Message-ID: <1335bf72-dca2-4df3-bd03-cba2aa6ddfdb@linaro.org>
Date: Thu, 30 May 2024 10:41:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] qtest: use cpu interface in qtest_clock_warp
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-3-pierrick.bouvier@linaro.org>
 <CABgObfY-6KewmkYEPgucbJnyggNKV8XbG8chvW5OsTV_GLr=gA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfY-6KewmkYEPgucbJnyggNKV8XbG8chvW5OsTV_GLr=gA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gNS8yOS8yNCAyMzozMiwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gRnJpLCBNYXkg
MTcsIDIwMjQgYXQgMTI6MjHigK9BTSBQaWVycmljayBCb3V2aWVyDQo+IDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4NCj4+IEZyb206IEFsZXggQmVubsOpZSA8
YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4+DQo+PiBUaGlzIGdlbmVyYWxpc2VzIHRoZSBx
dGVzdF9jbG9ja193YXJwIGNvZGUgdG8gdXNlIHRoZSBBY2NlbE9wcw0KPj4gaGFuZGxlcnMg
Zm9yIHVwZGF0aW5nIGl0cyBvd24gc2Vuc2Ugb2YgdGltZS4gVGhpcyB3aWxsIG1ha2UgdGhl
IG5leHQNCj4+IHBhdGNoIHdoaWNoIG1vdmVzIHRoZSB3YXJwIGNvZGUgY2xvc2VyIHRvIHB1
cmUgY29kZSBtb3Rpb24uDQo+Pg0KPj4gRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJl
bm5lZUBsaW5hcm8ub3JnPg0KPj4gQWNrZWQtYnk6IFRob21hcyBIdXRoIDx0aHV0aEByZWRo
YXQuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvc3lzZW11L3F0ZXN0LmggfCAxICsNCj4+
ICAgYWNjZWwvcXRlc3QvcXRlc3QuYyAgICB8IDEgKw0KPj4gICBzeXN0ZW0vcXRlc3QuYyAg
ICAgICAgIHwgNiArKystLS0NCj4+ICAgMyBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzZW11
L3F0ZXN0LmggYi9pbmNsdWRlL3N5c2VtdS9xdGVzdC5oDQo+PiBpbmRleCBiNWQ1ZmQzNDYz
Ny4uNDVmM2I3ZTFkZjUgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3N5c2VtdS9xdGVzdC5o
DQo+PiArKysgYi9pbmNsdWRlL3N5c2VtdS9xdGVzdC5oDQo+PiBAQCAtMzYsNiArMzYsNyBA
QCB2b2lkIHF0ZXN0X3NlcnZlcl9zZXRfc2VuZF9oYW5kbGVyKHZvaWQgKCpzZW5kKSh2b2lk
ICosIGNvbnN0IGNoYXIgKiksDQo+PiAgIHZvaWQgcXRlc3Rfc2VydmVyX2lucHJvY19yZWN2
KHZvaWQgKm9wYXF1ZSwgY29uc3QgY2hhciAqYnVmKTsNCj4+DQo+PiAgIGludDY0X3QgcXRl
c3RfZ2V0X3ZpcnR1YWxfY2xvY2sodm9pZCk7DQo+PiArdm9pZCBxdGVzdF9zZXRfdmlydHVh
bF9jbG9jayhpbnQ2NF90IGNvdW50KTsNCj4gDQo+IFlvdSBjYW4gbW92ZSBxdGVzdF9nZXRf
dmlydHVhbF9jbG9jay9xdGVzdF9zZXRfdmlydHVhbF9jbG9jayB0bw0KPiBhY2NlbC9xdGVz
dC9xdGVzdC5jIGluc3RlYWQsIGFuZCBtYWtlIHRoZW0gc3RhdGljLg0KPiANCj4gVGhleSBh
cmUgbm90IHVzZWQgYW55bW9yZSBpbiBzeXN0ZW0vcXRlc3QuYywgYW5kIGl0IGFjdHVhbGx5
IG1ha2VzIGENCj4gbG90IG1vcmUgc2Vuc2UgdGhhdCB0aGV5IGFyZW4ndC4NCj4gDQoNCkNo
YW5nZWQgZm9yIG5leHQgcmV2aXNpb24sDQp0aGFua3MNCg0KPiBQYW9sbw0KPiANCj4+ICAg
I2VuZGlmDQo+Pg0KPj4gICAjZW5kaWYNCj4+IGRpZmYgLS1naXQgYS9hY2NlbC9xdGVzdC9x
dGVzdC5jIGIvYWNjZWwvcXRlc3QvcXRlc3QuYw0KPj4gaW5kZXggZjYwNTZhYzgzNjEuLjUz
MTgyZTZjMmFlIDEwMDY0NA0KPj4gLS0tIGEvYWNjZWwvcXRlc3QvcXRlc3QuYw0KPj4gKysr
IGIvYWNjZWwvcXRlc3QvcXRlc3QuYw0KPj4gQEAgLTUyLDYgKzUyLDcgQEAgc3RhdGljIHZv
aWQgcXRlc3RfYWNjZWxfb3BzX2NsYXNzX2luaXQoT2JqZWN0Q2xhc3MgKm9jLCB2b2lkICpk
YXRhKQ0KPj4NCj4+ICAgICAgIG9wcy0+Y3JlYXRlX3ZjcHVfdGhyZWFkID0gZHVtbXlfc3Rh
cnRfdmNwdV90aHJlYWQ7DQo+PiAgICAgICBvcHMtPmdldF92aXJ0dWFsX2Nsb2NrID0gcXRl
c3RfZ2V0X3ZpcnR1YWxfY2xvY2s7DQo+PiArICAgIG9wcy0+c2V0X3ZpcnR1YWxfY2xvY2sg
PSBxdGVzdF9zZXRfdmlydHVhbF9jbG9jazsNCj4+ICAgfTsNCj4+DQo+PiAgIHN0YXRpYyBj
b25zdCBUeXBlSW5mbyBxdGVzdF9hY2NlbF9vcHNfdHlwZSA9IHsNCj4+IGRpZmYgLS1naXQg
YS9zeXN0ZW0vcXRlc3QuYyBiL3N5c3RlbS9xdGVzdC5jDQo+PiBpbmRleCA2ZGE1OGIzODc0
ZS4uZWU4YjEzOWU5ODIgMTAwNjQ0DQo+PiAtLS0gYS9zeXN0ZW0vcXRlc3QuYw0KPj4gKysr
IGIvc3lzdGVtL3F0ZXN0LmMNCj4+IEBAIC0zMzIsMTQgKzMzMiwxNCBAQCBpbnQ2NF90IHF0
ZXN0X2dldF92aXJ0dWFsX2Nsb2NrKHZvaWQpDQo+PiAgICAgICByZXR1cm4gcWF0b21pY19y
ZWFkX2k2NCgmcXRlc3RfY2xvY2tfY291bnRlcik7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGlj
IHZvaWQgcXRlc3Rfc2V0X3ZpcnR1YWxfY2xvY2soaW50NjRfdCBjb3VudCkNCj4+ICt2b2lk
IHF0ZXN0X3NldF92aXJ0dWFsX2Nsb2NrKGludDY0X3QgY291bnQpDQo+PiAgIHsNCj4+ICAg
ICAgIHFhdG9taWNfc2V0X2k2NCgmcXRlc3RfY2xvY2tfY291bnRlciwgY291bnQpOw0KPj4g
ICB9DQo+Pg0KPj4gICBzdGF0aWMgdm9pZCBxdGVzdF9jbG9ja193YXJwKGludDY0X3QgZGVz
dCkNCj4+ICAgew0KPj4gLSAgICBpbnQ2NF90IGNsb2NrID0gcWVtdV9jbG9ja19nZXRfbnMo
UUVNVV9DTE9DS19WSVJUVUFMKTsNCj4+ICsgICAgaW50NjRfdCBjbG9jayA9IGNwdXNfZ2V0
X3ZpcnR1YWxfY2xvY2soKTsNCj4+ICAgICAgIEFpb0NvbnRleHQgKmFpb19jb250ZXh0Ow0K
Pj4gICAgICAgYXNzZXJ0KHF0ZXN0X2VuYWJsZWQoKSk7DQo+PiAgICAgICBhaW9fY29udGV4
dCA9IHFlbXVfZ2V0X2Fpb19jb250ZXh0KCk7DQo+PiBAQCAtMzQ4LDcgKzM0OCw3IEBAIHN0
YXRpYyB2b2lkIHF0ZXN0X2Nsb2NrX3dhcnAoaW50NjRfdCBkZXN0KQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VX1RJ
TUVSX0FUVFJfQUxMKTsNCj4+ICAgICAgICAgICBpbnQ2NF90IHdhcnAgPSBxZW11X3Nvb25l
c3RfdGltZW91dChkZXN0IC0gY2xvY2ssIGRlYWRsaW5lKTsNCj4+DQo+PiAtICAgICAgICBx
dGVzdF9zZXRfdmlydHVhbF9jbG9jayhxdGVzdF9nZXRfdmlydHVhbF9jbG9jaygpICsgd2Fy
cCk7DQo+PiArICAgICAgICBjcHVzX3NldF92aXJ0dWFsX2Nsb2NrKGNwdXNfZ2V0X3ZpcnR1
YWxfY2xvY2soKSArIHdhcnApOw0KPj4NCj4+ICAgICAgICAgICBxZW11X2Nsb2NrX3J1bl90
aW1lcnMoUUVNVV9DTE9DS19WSVJUVUFMKTsNCj4+ICAgICAgICAgICB0aW1lcmxpc3RfcnVu
X3RpbWVycyhhaW9fY29udGV4dC0+dGxnLnRsW1FFTVVfQ0xPQ0tfVklSVFVBTF0pOw0KPj4g
LS0NCj4+IDIuMzkuMg0KPj4NCj4gDQo=

