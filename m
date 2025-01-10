Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7110E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 21:03:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWM9m-0005AI-AQ; Fri, 10 Jan 2025 16:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM9g-00056o-IB
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:02:57 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWM9e-0000gS-Hg
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:02:56 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216281bc30fso49418355ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 13:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736542973; x=1737147773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ab0TcCSvOXkoq8H8HNG8ShTvbQS/Fp04XQKPGq8qSo8=;
 b=aGkUDO3aQgTYe4YKZfwbOmwPJtcETyNTvARasi2VZwkOlwefXoDPq+KFSundgFZIgN
 Nw+Cn0CjKh1m5o2Bnx+AQaqNIwUrbMvCtB7l3L+NH/f6VBbBjy9HcJ0+9yd+d7uX9CcC
 i02qh8iTYAOiux2B1h9GBoF+tVJlLvhrIWfH0dYIqsw/hxuho06semG/zMm1BBAkbIF0
 X8I80j2k9DtC6nTEZ56uC4naS1Rnyvap8FbrhyerYOG0xR/d0HNQdTNIX9uOUfsAmp1m
 +w9iZ40FJpND+7m5m0AkHzqRKk23IFc4PT4lJLR/QAWhSGuisZM4ExQv5xyQGJQSxjVZ
 kbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736542973; x=1737147773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ab0TcCSvOXkoq8H8HNG8ShTvbQS/Fp04XQKPGq8qSo8=;
 b=avtJY6I8O3zn4nd9wbIahA4U9vMuDWcdki01K4P7BxmjpFBC+2HHeB/0PqRqnhCojx
 Owz3sjiudqvyB/592jWO2+qQj8tg3YTk6CNk/o/Y+YzlJSUxjXPdBFRrGO82PcUHdI9b
 DinN8NqMz/aJqUvc7yLEj6WCRZGQx61F86guwf0aiHI4WRk7PLrnBxKZ9LktxlSEfZ0b
 HqYj7pDdfODRgXvasdsKEK1N85D0aPTXJBOp6ZH1QP5mCQ6w5nCdevxZWs6BSU2fzMR4
 ngdtUiESx4vHMxAQQHXOY1Jl4/BLIavdyK+FQBzQctQMu2lgKcWw+TiT4CYQntjth14b
 zYOA==
X-Gm-Message-State: AOJu0Yw0j44zxtpHgCYEer5wS54cFNpyAaqrDZwIOiE5dI3vsr2TSNTT
 V+eP7M6LexnPFXAtRbRxILd8LFoi+89Qijsva+g2b2Iv/vsKrGOW5Q5UtpPbHIVRyKLv6Ck8UsT
 3TxoQ9Q==
X-Gm-Gg: ASbGnctnRivPiQWdt8TprMrsEbYtkmvzjFoZlvwFL3zcyENm7gS5wSeU2a32VS9tMRa
 QSN4CBGa0udU0XNCQOIa6hC8jfFltLlzX2HX/9kDb6t0zIDW85XCg+IHvcy+Kw1a8GSdj6L2uy9
 lPacM++0z5JHJrqqd7fZalCVm4/Hoqi1trgPes+baDMDqkoJgbt6gvWiyj2eT5qEHXPTNVhYUCY
 FLd+X6zDEQ5Ix33syC2BNZc0knc/WYuYWY7ozb/UjXp6PQKuQJS3uBp7oO9/FEymlC5FA==
X-Google-Smtp-Source: AGHT+IHuFDKMZ0B70X7RypoufTIxVv61VRLFxmtztmZxlN8ey+xcWRB/o3vXId0h3vPN4FJSkUE5DA==
X-Received: by 2002:a17:902:d2c2:b0:21a:87d1:168a with SMTP id
 d9443c01a7336-21a87d11b43mr166788495ad.41.1736542972848; 
 Fri, 10 Jan 2025 13:02:52 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f21a032sm17453925ad.135.2025.01.10.13.02.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 13:02:52 -0800 (PST)
Message-ID: <0369698c-0fbe-45f8-bad9-1e6a7b1ed410@linaro.org>
Date: Fri, 10 Jan 2025 13:02:51 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 04/11] contrib/plugins: add plugin showcasing new
 dicontinuity related API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <neither@nut.email>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <fa02142d349ceb6c95e80301a7f5c57ae5df6329.1733063076.git.neither@nut.email>
 <87frls6q2m.fsf@draig.linaro.org>
 <957c8754b588a3355e18519d644d9bb05d58645f@nut.email>
 <87cygu4s4a.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87cygu4s4a.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NEW_PRODUCTS=1.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

T24gMS8xMC8yNSAwNzoxNSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiAiSnVsaWFuIEdhbnoi
IDxuZWl0aGVyQG51dC5lbWFpbD4gd3JpdGVzOg0KPiANCj4+IEhpIEFsZXgsDQo+Pg0KPj4g
SmFudWFyeSA5LCAyMDI1IGF0IDM6MDQgUE0sICJBbGV4IEJlbm7DqWUiIHdyb3RlOg0KPj4+
IEp1bGlhbiBHYW56IDxuZWl0aGVyQG51dC5lbWFpbD4gd3JpdGVzOg0KPj4+PiBXZSByZWNl
bnRseSBpbnRyb2R1Y2VkIG5ldyBwbHVnaW4gQVBJIGZvciByZWdpc3RyYXRpb24gb2YgZGlz
Y29udGludWl0eQ0KPj4+PiAgIHJlbGF0ZWQgY2FsbGJhY2tzLiBUaGlzIGNoYW5nZSBpbnRy
b2R1Y2VzIGEgbWluaW1hbCBwbHVnaW4gc2hvd2Nhc2luZw0KPj4+PiAgIHRoZSBuZXcgQVBJ
LiBJdCBzaW1wbHkgY291bnRzIHRoZSBvY2N1cmFuY2VzIG9mIGludGVycnVwdHMsIGV4Y2Vw
dGlvbnMNCj4+Pj4gICBhbmQgaG9zdCBjYWxscyBwZXIgQ1BVIGFuZCByZXBvcnRzIHRoZSBj
b3VudHMgd2hlbiBleGl0dGluZy4NCj4+Pj4gICAtLS0NCj4+Pj4gICBjb250cmliL3BsdWdp
bnMvbWVzb24uYnVpbGQgfCAzICstDQo+Pj4+ICAgY29udHJpYi9wbHVnaW5zL3RyYXBzLmMg
fCA5NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+Pj4+ICAgMiBm
aWxlcyBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+ICAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGNvbnRyaWIvcGx1Z2lucy90cmFwcy5jDQo+Pj4+DQo+Pj4+
ICAgZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZCBiL2NvbnRyaWIv
cGx1Z2lucy9tZXNvbi5idWlsZA0KPj4+PiAgIGluZGV4IDYzYTMyYzJiNGYuLjlhMzAxNWUx
YzEgMTAwNjQ0DQo+Pj4+ICAgLS0tIGEvY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkDQo+
Pj4+ICAgKysrIGIvY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkDQo+Pj4+ICAgQEAgLTEs
NSArMSw2IEBADQo+Pj4+ICAgY29udHJpYl9wbHVnaW5zID0gWydiYnYnLCAnY2FjaGUnLCAn
Y2Zsb3cnLCAnZHJjb3YnLCAnZXhlY2xvZycsICdob3RibG9ja3MnLA0KPj4+PiAgIC0gJ2hv
dHBhZ2VzJywgJ2hvd3ZlYycsICdod3Byb2ZpbGUnLCAnaXBzJywgJ3N0b3B0cmlnZ2VyJ10N
Cj4+Pj4gICArICdob3RwYWdlcycsICdob3d2ZWMnLCAnaHdwcm9maWxlJywgJ2lwcycsICdz
dG9wdHJpZ2dlcicsDQo+Pj4+ICAgKyAndHJhcHMnXQ0KPj4+Pg0KPj4+IEkgd29uZGVyIGlm
IHRoaXMgaXMgYmV0dGVyIGluIHRlc3RzL3RjZy9wbHVnaW5zPyBXZSBuZWVkIHRvIGRvIHNv
bWV0aGluZw0KPj4+IHRvIGVuc3VyZSBpdCBnZXRzIGNvdmVyZWQgYnkgQ0kgYWx0aG91Z2gg
d2UgbWlnaHQgd2FudCB0byBiZSBzbWFydGVyDQo+Pj4gYWJvdXQgcnVubmluZyBpdCB0b2dl
dGhlciB3aXRoIGEgdGVzdCBiaW5hcnkgdGhhdCB3aWxsIGFjdHVhbGx5IHBpY2sgdXANCj4+
PiBzb21ldGhpbmcuDQo+Pg0KPj4gVGhlIGNhbGxiYWNrIGlzIGludGVuZGVkIGFzIGFuIGV4
YW1wbGUuIFRoZSBwYXRjaC1zZXJpZXMgZG9lcyBjb250YWluIGENCj4+IGRlZGljYXRlZCB0
ZXN0aW5nIHBsdWdpbi4gQW5kIGlpcmMgdGhlIGNvbnRyaWIgcGx1Z2lucyBhcmUgbm93IGJ1
aWx0DQo+PiB3aXRoIHRoZSByZXN0IG9mIHFlbXUgYW55d2F5Pw0KPiANCj4gVGhleSBkbyAt
IGhvd2V2ZXIgd2UgZ2VuZXJhdGUgYWRkaXRpb25hbCB0ZXN0cyB3aXRoIHRlc3RzL3RjZy9w
bHVnaW5zDQo+IHdpdGggdGhlIGV4aXN0aW5nIG11bHRpYXJjaCBsaW51eC11c2VyIGFuZCBz
b2Z0bW11IGNoZWNrLXRjZyB0ZXN0cy4gSXRzDQo+IGEgZmFpcmx5IGR1bWIgZXhwYW5zaW9u
IHRob3VnaDoNCj4gDQo+ICAgICMgV2UgbmVlZCB0byBlbnN1cmUgZXhwYW5kIHRoZSBydW4t
cGx1Z2luLVRFU1Qtd2l0aC1QTFVHSU4NCj4gICAgIyBwcmUtcmVxdWlzdGVzIG1hbnVhbGx5
IGhlcmUgYXMgd2UgY2FuJ3QgdXNlIHN0ZW1zIHRvIGhhbmRsZSBpdC4gV2UNCj4gICAgIyBv
bmx5IGV4cGFuZCBNVUxUSUFSQ0hfVEVTVFMgd2hpY2ggYXJlIGNvbW1vbiBvbiBtb3N0IG9m
IG91ciB0YXJnZXRzDQo+ICAgICMgdG8gYXZvaWQgYW4gZXhwb25lbnRpYWwgZXhwbG9zaW9u
IGFzIG5ldyB0ZXN0cyBhcmUgYWRkZWQuIFdlIGFsc28NCj4gICAgIyBhZGQgc29tZSBzcGVj
aWFsIGhlbHBlcnMgdGhlIHJ1bi1wbHVnaW4tIHJ1bGVzIGNhbiB1c2UgYmVsb3cuDQo+ICAg
ICMgSW4gbW9yZSwgZXh0cmEgdGVzdHMgY2FuIGJlIGFkZGVkIHVzaW5nIEFERElUSU9OQUxf
UExVR0lOU19URVNUUyB2YXJpYWJsZS4NCj4gDQo+ICAgIGlmbmVxICgkKE1VTFRJQVJDSF9U
RVNUUyksKQ0KPiAgICAkKGZvcmVhY2ggcCwkKFBMVUdJTlMpLCBcDQo+ICAgICAgICAgICAg
JChmb3JlYWNoIHQsJChNVUxUSUFSQ0hfVEVTVFMpICQoQURESVRJT05BTF9QTFVHSU5TX1RF
U1RTKSxcDQo+ICAgICAgICAgICAgICAgICAgICAkKGV2YWwgcnVuLXBsdWdpbi0kKHQpLXdp
dGgtJChwKTogJHQgJHApIFwNCj4gICAgICAgICAgICAgICAgICAgICQoZXZhbCBSVU5fVEVT
VFMrPXJ1bi1wbHVnaW4tJCh0KS13aXRoLSQocCkpKSkNCj4gICAgZW5kaWYgIyBNVUxUSUFS
Q0hfVEVTVFMNCj4gICAgZW5kaWYgIyBDT05GSUdfUExVR0lODQo+IA0KPiBXZSBhbHNvIGhh
dmUgYSBoYW5kLWhhY2tlZCB0ZXN0IGZvciB2YWxpZGF0aW5nIG1lbW9yeSBpbnN0cnVtZW50
YXRpb246DQo+IA0KPiAgICAjIFRlc3QgcGx1Z2luIG1lbW9yeSBhY2Nlc3MgaW5zdHJ1bWVu
dGF0aW9uDQo+ICAgIHJ1bi1wbHVnaW4tdGVzdC1wbHVnaW4tbWVtLWFjY2Vzcy13aXRoLWxp
Ym1lbS5zbzogXA0KPiAgICAgICAgICAgIFBMVUdJTl9BUkdTPSQoQ09NTUEpcHJpbnQtYWNj
ZXNzZXM9dHJ1ZQ0KPiAgICBydW4tcGx1Z2luLXRlc3QtcGx1Z2luLW1lbS1hY2Nlc3Mtd2l0
aC1saWJtZW0uc286IFwNCj4gICAgICAgICAgICBDSEVDS19QTFVHSU5fT1VUUFVUX0NPTU1B
TkQ9IFwNCj4gICAgICAgICAgICAkKFNSQ19QQVRIKS90ZXN0cy90Y2cvbXVsdGlhcmNoL2No
ZWNrLXBsdWdpbi1vdXRwdXQuc2ggXA0KPiAgICAgICAgICAgICQoUUVNVSkgJDwNCj4gDQo+
ICAgIHRlc3QtcGx1Z2luLW1lbS1hY2Nlc3M6IENGTEFHUys9LXB0aHJlYWQgLU8wDQo+ICAg
IHRlc3QtcGx1Z2luLW1lbS1hY2Nlc3M6IExERkxBR1MrPS1wdGhyZWFkIC1PMA0KPiANCj4g
VGhhdCBzYWlkIGFzIEkgbWVudGlvbiBpbiB0aGUgcmVwbHkgdG8gdGhlIGNvdmVyIGxldHRl
ciB0aGUgdHJhcHMgc3R1ZmYNCj4gbWlnaHQgYmUgYmV0dGVyIGV4ZXJjaXNlZCB3aXRoIHRo
ZSBmdW5jdGlvbmFsIHRlc3Qgc28gY291bGQgdXRpbGlzZSBhDQo+IHBsdWdpbiBidWlsdCBp
biBjb250cmliIGp1c3QgYXMgZWFzaWx5Lg0KPiANCg0KSSBhZ3JlZSwgYXMgaXQgd2FzIGRp
c2N1c3NlZCBpbiBwcmV2aW91cyB2ZXJzaW9ucywgd2Ugc2hvdWxkIGFkZCBhIA0KZnVuY3Rp
b25hbCB0ZXN0IGZvciB0aGlzLiBJJ20gbm90IHN1cmUgaWYgd2Ugc2hvdWxkIHdyaXRlIGEg
Y3VzdG9tIGFuZCANCmNvbXBsaWNhdGVkIHRlc3QsIG9yIHNpbXBseSBib290IGFuZCBzaHV0
ZG93biBhbiBleGlzdGluZyBpbWFnZSwgYW5kIA0KY2FsbCBpdCBhIGRheS4NCg0KRG8geW91
IGhhdmUgYW55IG9waW5pb24gb24gdGhpcyBBbGV4Pw0KDQo+Pg0KPj4+PiArUUVNVV9QTFVH
SU5fRVhQT1JUDQo+Pj4+ICAgK2ludCBxZW11X3BsdWdpbl9pbnN0YWxsKHFlbXVfcGx1Z2lu
X2lkX3QgaWQsIGNvbnN0IHFlbXVfaW5mb190ICppbmZvLA0KPj4+PiAgICsgaW50IGFyZ2Ms
IGNoYXIgKiphcmd2KQ0KPj4+PiAgICt7DQo+Pj4+ICAgKyBpZiAoIWluZm8tPnN5c3RlbV9l
bXVsYXRpb24pIHsNCj4+Pj4gICArIGZwdXRzKCJ0cmFwIHBsdWdpbiBjYW4gb25seSBiZSB1
c2VkIGluIHN5c3RlbSBlbXVsYXRpb24gbW9kZS5cbiIsDQo+Pj4+ICAgKyBzdGRlcnIpOw0K
Pj4+PiAgICsgcmV0dXJuIC0xOw0KPj4+PiAgICsgfQ0KPj4+PiAgICsNCj4+Pj4gICArIG1h
eF92Y3B1cyA9IGluZm8tPnN5c3RlbS5tYXhfdmNwdXM7DQo+Pj4+ICAgKyB0cmFwcyA9IHFl
bXVfcGx1Z2luX3Njb3JlYm9hcmRfbmV3KHNpemVvZihUcmFwQ291bnRlcnMpKTsNCj4+Pj4g
ICArIHFlbXVfcGx1Z2luX3JlZ2lzdGVyX3ZjcHVfaW5pdF9jYihpZCwgdmNwdV9pbml0KTsN
Cj4+Pj4gICArIHFlbXVfcGx1Z2luX3ZjcHVfZm9yX2VhY2goaWQsIHZjcHVfaW5pdCk7DQo+
Pj4+DQo+Pj4gSG1tIGF0IGZpcnN0IGdsYW5jZXMgdGhpcyBzZWVtcyByZWR1bmRhbnQgLSBo
b3dldmVyIEkgZ3Vlc3MgdGhpcyBpcw0KPj4+IGNvdmVyaW5nIHRoZSB1c2UgY2FzZSB5b3Ug
bG9hZCB0aGUgcGx1Z2luIGFmdGVyIHRoZSBzeXN0ZW0gaXMgdXAgYW5kDQo+Pj4gcnVubmlu
Zy4NCj4+DQo+PiBZZXAsIGJ1dCByZWFsbHkgdGhhdCB3YXMganVzdCBtZSBiZWluZyBwYXJh
bm9pZC4NCj4+DQo+Pj4gSSB3b25kZXIgaWYgeW91IGhhdmUgdW5lYXJ0aGVkIGEgZm9vdC1n
dW4gaW4gdGhlIEFQSSB0aGF0IGlzIGVhc3kgdG8NCj4+PiBmYWxsIGludG8/IE1heWJlIHdl
IHNob3VsZCBleHBhbmQgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9pbml0X2NiIHRvDQo+
Pj4gY2FsbCB0aGUgY2FsbCBiYWNrIGltbWVkaWF0ZWx5IGZvciBleGlzdGluZyB2Y3B1cz8N
Cj4+DQo+PiBXb3VsZCBwcm9iYWJseSBub3QgaHVydC4NCj4+DQo+PiBSZWdhcmRzLA0KPj4g
SnVsaWFuDQo+IA0KDQo=

