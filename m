Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F3A5D743E3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 21:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDsVd-0005C9-4u; Wed, 20 Nov 2024 16:45:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDsVX-000595-S0
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:45:09 -0500
Received: from mail-ot1-x334.google.com ([2607:f8b0:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tDsVV-0004Mv-Do
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 16:45:07 -0500
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-71808b6246bso94677a34.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732139104; x=1732743904; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TJla3E3VDFFTN5aiOh6fW6EvLvRgDPOxGQ6cFC1p1Kc=;
 b=eJfLRkYfKtM5fyigX5Yx1vxejesJr0t1ndiuFkmpEYaYukzmUOsqAlPa01DCEspI1x
 GiZqzMCpBUzXWlLLNvRQ3ihfOOumaULBmSCSvfci+J7FcjhaVBV4ZvE4eJhprSIvY1f1
 cNOcIveR2xjchtQMfjt5ThraeKaY2llZsQWJPQj0RXODF3c2Pv5I4dJoVfhBboP6BksM
 nL1N5lnkJani2HDlUoPTbFzXTBaXT3Kx2Zm+N513aT+Md4uKLP75Xlq9Lhupla+nVTsz
 K7H94ndMhx341mnrSi96PNCKwr8iy4PrIS81q6eclow5jIrXeleZQZsSDBNdAXq8qgw9
 9QJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732139104; x=1732743904;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TJla3E3VDFFTN5aiOh6fW6EvLvRgDPOxGQ6cFC1p1Kc=;
 b=N0x9d6fXjdLP3yqo6WZFBIlvIiEdx1u+5S/4HnetrNwdKwnpRabXShWf4iqM9FZcdL
 4gE607kCma8O7BsT1BJQaaOkWhq8m3UFBZueNYnSd7O+4ruS9CPYpVTS+EzaKouM4nyK
 PaEDlK+McAgJMpdsvoV3dFf7uxgi6nmC63uycyKwMNsuys8y9AA0yj7Z7VRTBZ2oOcaa
 bbSHfumlsSd2tnv9zgoGG5B9SSAa/IJ0y5fk/1h1iNxPgIqSqK49W90vtl1wCEZIfPHi
 RQaN2Fkvc56RjxjUuXKaTlz2MpgXSWkBHXe8UIzGOvYLsonlM+cXcO1NFZEQ2kXhnUFX
 Fu6g==
X-Gm-Message-State: AOJu0YzF3eZ+VzXImMWbq5wN7S4at0Q8/oRGgvOFXohUqqLFXp6ksJkY
 h5++XBUtA9iRo2XmOkbQudqHR4rnIi1SZfMTiI+gNq92uaGjwkRJNVOpmpx7zQk=
X-Google-Smtp-Source: AGHT+IErPeFBjMpL5ETlyT9kF3tUsdjau2FQOJeVrBaUhVTCY56Gz4+PVGcx/4wBiXEXeY34qNzCPw==
X-Received: by 2002:a9d:6553:0:b0:710:f879:a15a with SMTP id
 46e09a7af769-71ab31d8ba8mr4131033a34.27.1732139103846; 
 Wed, 20 Nov 2024 13:45:03 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fbb65821b8sm21973a12.68.2024.11.20.13.45.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Nov 2024 13:45:03 -0800 (PST)
Message-ID: <94ead9ab-e290-4469-931a-d447d26f27aa@linaro.org>
Date: Wed, 20 Nov 2024 13:45:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] docs/devel: add git-publish for patch submitting
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Andrew Melnychenko <andrew@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Thomas Huth <thuth@redhat.com>, alex.bennee@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-arm@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 manos.pitsidianakis@linaro.org, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, gustavo.romero@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241118172357.475281-1-pierrick.bouvier@linaro.org>
 <20241118172357.475281-3-pierrick.bouvier@linaro.org>
 <ZzxUeTxHBHKlEhwN@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ZzxUeTxHBHKlEhwN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::334;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x334.google.com
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

T24gMTEvMTkvMjQgMDE6MDQsIERhbmllbCBQLiBCZXJyYW5nw6kgd3JvdGU6DQo+IE9uIE1v
biwgTm92IDE4LCAyMDI0IGF0IDA5OjIzOjUyQU0gLTA4MDAsIFBpZXJyaWNrIEJvdXZpZXIg
d3JvdGU6DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgZG9jcy9kZXZlbC9zdWJtaXR0aW5n
LWEtcGF0Y2gucnN0IHwgMTQgKysrKysrKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQs
IDE0IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZG9jcy9kZXZlbC9zdWJt
aXR0aW5nLWEtcGF0Y2gucnN0IGIvZG9jcy9kZXZlbC9zdWJtaXR0aW5nLWEtcGF0Y2gucnN0
DQo+PiBpbmRleCAzNDljMzJlZTNhOS4uOTUzNjgyZjIwY2IgMTAwNjQ0DQo+PiAtLS0gYS9k
b2NzL2RldmVsL3N1Ym1pdHRpbmctYS1wYXRjaC5yc3QNCj4+ICsrKyBiL2RvY3MvZGV2ZWwv
c3VibWl0dGluZy1hLXBhdGNoLnJzdA0KPj4gQEAgLTIzNyw2ICsyMzcsMjAgQEAgYXR0YWNo
bWVudHMgY2FuIGJlIHVzZWQgYXMgYSBsYXN0IHJlc29ydCBvbiBhIGZpcnN0LXRpbWUgc3Vi
bWlzc2lvbi4NCj4+ICAgDQo+PiAgIC4uIF9pZl95b3VfY2Fubm90X3NlbmRfcGF0Y2hfZW1h
aWxzOg0KPiANCj4gVGhpcyBuZWVkcyB0byByZW1haW4gYXNzb2NpYXRlZCB3aXRoIHRoZSBo
ZWFkaW5nIHRoYXQgaXMgKmFmdGVyKg0KPiB5b3VyIG5ldyBibG9jayBvZiB0ZXh0LCB3aGls
ZSBoZXJlIHlvdSBuZWVkIHRvIGFkZCBhIG5ldyBhbmNob3INCj4gDQoNCk9vcHMsIHRoYXQg
d2FzIG5vdCBpbnRlbnRpb25hbCwgdGhhbmtzIGZvciBwb2ludGluZyB0aGlzLg0KRml4ZWQg
YW5kIGFkZGVkIHRoZSBuZXcgYW5jaG9yIGluIGNhc2Ugc29tZW9uZSBuZWVkcyBpdC4NCg0K
PiAgICAgLi4gX3VzZV9naXRfcHVibGlzaDoNCj4gDQo+PiAgIA0KPj4gK1VzZSBnaXQtcHVi
bGlzaA0KPj4gK35+fn5+fn5+fn5+fn5+fg0KPj4gKw0KPj4gK0lmIHlvdSBhbHJlYWR5IGNv
bmZpZ3VyZWQgZ2l0IHNlbmQtZW1haWwsIHlvdSBjYW4gc2ltcGx5IHVzZSBgZ2l0LXB1Ymxp
c2gNCj4+ICs8aHR0cHM6Ly9naXRodWIuY29tL3N0ZWZhbmhhL2dpdC1wdWJsaXNoPmBfXyB0
byBzZW5kIHNlcmllcy4NCj4+ICsNCj4+ICs6Og0KPj4gKw0KPj4gKyAgICAkIGdpdCBjaGVj
a291dCBtYXN0ZXIgLWIgbXktZmVhdHVyZQ0KPj4gKyAgICAkICMgd29yayBvbiBuZXcgY29t
bWl0cywgYWRkIHlvdXIgJ1NpZ25lZC1vZmYtYnknIGxpbmVzIHRvIGVhY2gNCj4+ICsgICAg
JCBnaXQgcHVibGlzaA0KPj4gKyAgICAkIC4uLiBtb3JlIHdvcmssIHJlYmFzZSBvbiBtYXN0
ZXIsIC4uLg0KPj4gKyAgICAkIGdpdCBwdWJsaXNoICMgd2lsbCBzZW5kIGEgdjINCj4gDQo+
IEFsc28gYWRkIGEgbm90ZQ0KPiANCj4gICAiRWFjaCB0aW1lIHlvdSBwb3N0IGEgc2VyaWVz
LCBnaXQtcHVibGlzaCB3aWxsIGNyZWF0ZSBhIGxvY2FsIHRhZw0KPiAgICB3aXRoIHRoZSBm
b3JtYXQgYGA8YnJhbmNobmFtZT4tdjx2ZXJzaW9uPmBgIHRvIHJlY29yZCB0aGUgcGF0Y2gN
Cj4gICAgc2VyaWVzLiINCj4gDQoNCkFkZGVkIHRoaXMg8J+RjS4NCg0KPj4gKw0KPj4gICBJ
ZiB5b3UgY2Fubm90IHNlbmQgcGF0Y2ggZW1haWxzDQo+PiAgIH5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn4NCj4+ICAgDQo+PiAtLSANCj4+IDIuMzkuNQ0KPj4NCj4gDQo+IFdp
dGggcmVnYXJkcywNCj4gRGFuaWVsDQoNCg==

