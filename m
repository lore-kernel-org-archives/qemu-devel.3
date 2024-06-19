Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EDDC27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 15:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJwtR-0008AS-9w; Wed, 19 Jun 2024 11:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sJwtL-00089V-Mh
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:06:31 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sJwtI-0001vq-5B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 11:06:31 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f64ecb1766so48121175ad.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 08:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718809586; x=1719414386; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53ccK+CjnnoeqgwrzL2MP2JpY9KmQHqgB9vFIPTJVYc=;
 b=XwMrwN5f2oJs/znbh13g8ST+P3g2QBsWj/iDyq+NfzGGGOplRGMYArKi2o+X1TMLnC
 MijZkr/h8g2WlgqfD7eDzjNPYAiqZpOhvx1tlyRkSRc6CHRTdAhV4qYTeGz/m+zy0DEy
 tzP3ggTi0TRLW7Xx64izTCGBdTwRcmtZCzUoxyfnGyvvbo8VrLRxqtWgq+v3e2yvevMS
 MXJjsqpnU4prcYSHnhZH3qce81zjRtIck0Z7CTQHNLgh1MGg4PMwXU6dOJ9cibgvBp1L
 012+RRa95rsO5iKOoQIdbLflVI1P5Gdn8j92WAt3FOyEqk5eNWgDsynaFlNrOTjo3gHN
 BjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718809586; x=1719414386;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53ccK+CjnnoeqgwrzL2MP2JpY9KmQHqgB9vFIPTJVYc=;
 b=bIHNKiABWsPLJnQAmb97Sk1Tq1GqJaSg0vzuZtRupxOAvabtKbv2/W9DVp4+G+1Ky8
 aRHIS1L2ioyfloPbDDF4LdqQImK2BIsNORD/i0dvqJa7NMLu9CbxifKsVRZgZyM5hPTP
 BhwPV78sQPqvopJPqJNBZZdnZFzmwinMie1YuIxl/Ca6XSD4GJSRd2tiKbbJRhJ4oVy5
 BPwZBURQ/C1HC5+igZeIvZjDboDhxneaE5f8tYfH3+KPlsgypkPZyihGsjal6ZYJFOMy
 Eg4w/fcmCTP7pIlHuULKhcXXoJxOOhxa6OTD1nHAGYZLtsEfuGhGT+OfrdI0TznrYSNU
 IPzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMtLRHI7/BjKpHDgzkVZqyye7ObMUy1NLPGLuQ1ag9LussHyOTmE/YgLGz9xwiho6Oy/By2szZ+hSvxFzK79RsVzs5+BM=
X-Gm-Message-State: AOJu0YwS0hvpYxjf4sfUiJGj1xilNaxD7hnXTvAT2sbg4KOfuF8nTcdU
 9FX6GQQkpXJcpxAkq3shGFvgcxtsXhYSz5BWtwWrYKgUBZMelAA27P/j2//EoR8=
X-Google-Smtp-Source: AGHT+IEKSMPfsUN7rJwC84JD0vEhzz1T9Cqgy0kPSP6eSjrW7wTRT3cMKKmdmSZQ03B2BtAQgWO1yg==
X-Received: by 2002:a17:902:dac6:b0:1f7:ff:b477 with SMTP id
 d9443c01a7336-1f9aa44fc25mr23739125ad.55.1718809583896; 
 Wed, 19 Jun 2024 08:06:23 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e55e48sm118123385ad.37.2024.06.19.08.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 08:06:23 -0700 (PDT)
Message-ID: <b2975c54-2752-4375-a5ad-13a21f8dde14@linaro.org>
Date: Wed, 19 Jun 2024 08:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] contrib/plugins: add ips plugin example for cost
 modeling
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-10-alex.bennee@linaro.org>
 <ZmoM2Sac97PdXWcC@gallifrey>
 <777e1b13-9a4f-4c32-9ff7-9cedf7417695@linaro.org>
 <Zmy9g1U1uP1Vhx9N@gallifrey>
 <616df287-a167-4a05-8f08-70a78a544929@linaro.org>
 <ZnCi4hcyR8wMMnK4@gallifrey>
 <4e5fded0-d1a9-4494-a66d-6488ce1bcb33@linaro.org>
 <874j9qefv0.fsf@draig.linaro.org>
 <78003bee-08f7-4860-a675-b09721955e60@linaro.org>
 <87jzilcleh.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87jzilcleh.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

T24gNi8xOS8yNCAwMjo0OSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiA2
LzE4LzI0IDAyOjUzLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4NCj4+Pj4gT24g
Ni8xNy8yNCAxMzo1NiwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCj4+Pj4+ICog
UGllcnJpY2sgQm91dmllciAocGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnKSB3cm90ZToN
Cj4+Pj4+PiBPbiA2LzE0LzI0IDE1OjAwLCBEci4gRGF2aWQgQWxhbiBHaWxiZXJ0IHdyb3Rl
Og0KPj4+Pj4+PiAqIFBpZXJyaWNrIEJvdXZpZXIgKHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZykgd3JvdGU6DQo+Pj4+Pj4+PiBIaSBEYXZlLA0KPj4+Pj4+Pj4NCj4+Pj4+Pj4+IE9u
IDYvMTIvMjQgMTQ6MDIsIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+Pj4+Pj4+
Pj4gKiBBbGV4IEJlbm7DqWUgKGFsZXguYmVubmVlQGxpbmFyby5vcmcpIHdyb3RlOg0KPj4+
Pj4+Pj4+PiBGcm9tOiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFy
by5vcmc+DQo+Pj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4+IFRoaXMgcGx1Z2luIHVzZXMgdGhlIG5l
dyB0aW1lIGNvbnRyb2wgaW50ZXJmYWNlIHRvIG1ha2UgZGVjaXNpb25zDQo+Pj4+Pj4+Pj4+
IGFib3V0IHRoZSBzdGF0ZSBvZiB0aW1lIGR1cmluZyB0aGUgZW11bGF0aW9uLiBUaGUgYWxn
b3JpdGhtIGlzDQo+Pj4+Pj4+Pj4+IGN1cnJlbnRseSB2ZXJ5IHNpbXBsZS4gVGhlIHVzZXIg
c3BlY2lmaWVzIGFuIGlwcyByYXRlIHdoaWNoIGFwcGxpZXMNCj4+Pj4+Pj4+Pj4gcGVyIGNv
cmUuIElmIHRoZSBjb3JlIHJ1bnMgYWhlYWQgb2YgaXRzIGFsbG9jYXRlZCBleGVjdXRpb24g
dGltZSB0aGUNCj4+Pj4+Pj4+Pj4gcGx1Z2luIHNsZWVwcyBmb3IgYSBiaXQgdG8gbGV0IHJl
YWwgdGltZSBjYXRjaCB1cC4gRWl0aGVyIHdheSB0aW1lIGlzDQo+Pj4+Pj4+Pj4+IHVwZGF0
ZWQgZm9yIHRoZSBlbXVsYXRpb24gYXMgYSBmdW5jdGlvbiBvZiB0b3RhbCBleGVjdXRlZCBp
bnN0cnVjdGlvbnMNCj4+Pj4+Pj4+Pj4gd2l0aCBzb21lIGFkanVzdG1lbnRzIGZvciBjb3Jl
cyB0aGF0IGlkbGUuDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBBIGZldyByYW5kb20gdGhvdWdo
dHM6DQo+Pj4+Pj4+Pj4gICAgICAgIGEpIEFyZSB0aGVyZSBhbnkgZGVmaW5pdGlvbnMgb2Yg
d2hhdCBhIHBsdWdpbiB0aGF0IGNvbnRyb2xzIHRpbWUNCj4+Pj4+Pj4+PiAgICAgICAgICAg
c2hvdWxkIGRvIHdpdGggYSBsaXZlIG1pZ3JhdGlvbj8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+PiBJ
dCdzIG5vdCBzb21ldGhpbmcgdGhhdCB3YXMgY29uc2lkZXJlZCBhcyBwYXJ0IG9mIHRoaXMg
d29yay4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVGhhdCdzIE9LLCB0aGUgb25seSB0aGluZyBpcyB3
ZSBuZWVkIHRvIHN0b3AgYW55b25lIGZyb20gaGl0dGluZyBwcm9ibGVtcw0KPj4+Pj4+PiB3
aGVuIHRoZXkgZG9uJ3QgcmVhbGlzZSBpdCdzIG5vdCBiZWVuIGFkZHJlc3NlZC4NCj4+Pj4+
Pj4gT25lIHdheSBtaWdodCBiZSB0byBhZGQgYSBtaWdyYXRpb24gYmxvY2tlcjsgc2VlIGlu
Y2x1ZGUvbWlncmF0aW9uL2Jsb2NrZXIuaA0KPj4+Pj4+PiB0aGVuIHlvdSBtaWdodCBwcmlu
dCBzb21ldGhpbmcgbGlrZSAnTWlncmF0aW9uIG5vdCBhdmFpbGFibGUgZHVlIHRvIHBsdWdp
biAuLi4uJw0KPj4+Pj4+Pg0KPj4+Pj4+DQo+Pj4+Pj4gU28gYmFzaWNhbGx5LCB3ZSBjb3Vs
ZCBtYWtlIGEgY2FsbCB0byBtaWdyYXRlX2FkZF9ibG9ja2VyKCksIHdoZW4gc29tZW9uZQ0K
Pj4+Pj4+IHJlcXVlc3QgdGltZV9jb250cm9sIHRocm91Z2ggcGx1Z2luIEFQST8NCj4+Pj4+
Pg0KPj4+Pj4+IElNSE8sIGl0J3Mgc29tZXRoaW5nIHRoYXQgc2hvdWxkIGJlIHBhcnQgb2Yg
cGx1Z2luIEFQSSAoaWYgYW55IHBsdWdpbiBjYWxscw0KPj4+Pj4+IHFlbXVfcGx1Z2luX3Jl
cXVlc3RfdGltZV9jb250cm9sKCkpLCBpbnN0ZWFkIG9mIHRoZSBwbHVnaW4gY29kZSBpdHNl
bGYuIFRoaXMNCj4+Pj4+PiB3YXksIGFueSBwbHVnaW4gZ2V0dGluZyB0aW1lIGNvbnRyb2wg
YXV0b21hdGljYWxseSBibG9ja3MgYW55IHBvdGVudGlhbA0KPj4+Pj4+IG1pZ3JhdGlvbi4N
Cj4+Pj4+IE5vdGUgbXkgcXVlc3Rpb24gYXNrZWQgZm9yIGEgJ2FueSBkZWZpbml0aW9ucyBv
ZiB3aGF0IGEgcGx1Z2luIC4uJyAtDQo+Pj4+PiBzbw0KPj4+Pj4geW91IGNvdWxkIGRlZmlu
ZSBpdCB0aGF0IHdheSwgYW5vdGhlciBvbmUgaXMgdG8gdGhpbmsgdGhhdCBpbiB0aGUgZnV0
dXJlDQo+Pj4+PiB5b3UgbWF5IGFsbG93IGl0IGFuZCB0aGUgcGx1Z2luIHNvbWVob3cgaW50
ZXJhY3RzIHdpdGggbWlncmF0aW9uIG5vdCB0bw0KPj4+Pj4gY2hhbmdlIHRpbWUgYXQgY2Vy
dGFpbiBtaWdyYXRpb24gcGhhc2VzLg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gSSB3b3VsZCBiZSBp
biBmYXZvciB0byBmb3JiaWQgdXNhZ2UgZm9yIG5vdyBpbiB0aGlzIGNvbnRleHQuIEknbSBu
b3QNCj4+Pj4gc3VyZSB3aHkgcGVvcGxlIHdvdWxkIHBsYXkgd2l0aCBtaWdyYXRpb24gYW5k
IHBsdWdpbnMgZ2VuZXJhbGx5IGF0DQo+Pj4+IHRoaXMgdGltZSAodGhlcmUgbWlnaHQgYmUg
ZXhwZXJpbWVudHMgb3IgdXNlIGNhc2VzIEknbSBub3QgYXdhcmUgb2YpLA0KPj4+PiBzbyBh
IHNpbXBsZSBiYXJyaWVyIHByZXZlbnRpbmcgdGhhdCBzZWVtcyBvay4NCj4+Pj4NCj4+Pj4g
VGhpcyBwbHVnaW4gaXMgcGFydCBvZiBhbiBleHBlcmltZW50IHdoZXJlIHdlIGltcGxlbWVu
dCBhIHFlbXUgZmVhdHVyZQ0KPj4+PiAoaWNvdW50PWF1dG8gaW4gdGhpcyBjYXNlKSBieSB1
c2luZyBwbHVnaW5zLiBJZiBpdCB0dXJucyBpbnRvIGENCj4+Pj4gc3VjY2Vzc2Z1bCB1c2Fn
ZSBhbmQgdGhpcyBwbHVnaW4gYmVjb21lcyBwb3B1bGFyLCB3ZSBjYW4gYWx3YXlzIGxpZnQN
Cj4+Pj4gdGhlIGxpbWl0YXRpb24gbGF0ZXIuDQo+Pj4+DQo+Pj4+IEBBbGV4LCB3b3VsZCB5
b3UgbGlrZSB0byBhZGQgdGhpcyBub3cgKGljb3VudD1hdXRvIGlzIHN0aWxsIG5vdA0KPj4+
PiByZW1vdmVkIGZyb20gcWVtdSksIG9yIHdhaXQgZm9yIGludGVncmF0aW9uLCBhbmQgYWRk
IHRoaXMgYXMgYW5vdGhlcg0KPj4+PiBwYXRjaD8NCj4+PiBJIHRoaW5rIHdlIGZvbGxvdyB0
aGUgZGVwcmVjYXRpb24gcHJvY2VzcyBzbyBvbmNlIGludGVncmF0ZWQgd2UgcG9zdA0KPj4+
IGENCj4+PiBkZXByZWNhdGlvbiBub3RpY2UgaW46DQo+Pj4gICAgIGh0dHBzOi8vcWVtdS5y
ZWFkdGhlZG9jcy5pby9lbi9tYXN0ZXIvYWJvdXQvZGVwcmVjYXRlZC5odG1sDQo+Pj4gYW5k
IHRoZW4gcmVtb3ZlIGl0IGFmdGVyIGEgY291cGxlIG9mIHJlbGVhc2VzLg0KPj4+DQo+Pg0K
Pj4gU29ycnksIEkgd2FzIG5vdCBjbGVhci4gSSBtZWFudCBkbyB3ZSBhZGQgYSBibG9ja2Vy
IGluIGNhc2Ugc29tZW9uZQ0KPj4gdHJpZXMgdG8gbWlncmF0ZSBhIHZtIHdoaWxlIHRoaXMg
cGx1Z2luIGlzIHVzZWQ/DQo+IA0KPiBPaCB5ZXMgLSBJIGNhbiBhZGQgdGhhdCBpbiB0aGUg
Y29yZSBwbHVnaW4gY29kZS4NCj4gDQoNClRoYW5rcyENCg==

