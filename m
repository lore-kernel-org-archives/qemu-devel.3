Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B446D17120
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 18:01:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2whf-0008Hm-PY; Mon, 21 Oct 2024 14:00:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2whd-0008GO-TE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:00:25 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2whc-0007Y0-4Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 14:00:25 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20caccadbeeso52440045ad.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 11:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729533621; x=1730138421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q7l2f5ZtoZLNdDaDH6/GJIwWz+zWS+Fu8QClvAFeefA=;
 b=tatq9XUSqyzhO33E4XHCRyTvwStm8VulB5KzbL/HTaSsiPrmbKltblns77oGx4gpyj
 eEIDQXuFjzy3Wx6goOayAzyPXZjibxWcGdCQeksC9ovgHOnWsB4f8pR3Md/yR4zUcfxt
 xejOm9hHuWp9KGz2AHBiIpaNr0Ve0tByxoEzQq0FMWsPbyTNhVTJlZ3HKhBUJ68ocKlD
 +0BT7gcwxyV/CEz0IoIWN9ZIEbRpwtkjg8KCX/3nKsNHztnf3sGhm3VIDo5gMVgcUBAD
 cCK2vx7xNmGz4LjQKK1h1exwqijBdNQ4SKGpiJjyUXsuAuok39TCWrrkPjghR8zm/AnP
 PJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729533621; x=1730138421;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q7l2f5ZtoZLNdDaDH6/GJIwWz+zWS+Fu8QClvAFeefA=;
 b=G0N6tmoPxPaK5DHYX4oFxEZ0902Ac56umNA8uwHn9eJa34/GsY0pueDnGX/rw3sWQk
 lI+wInyGtJ9/K2XilmzD00Qss+E0jm9UB2CWRtzhdC5dxJxw5BPRVE1UszgSQOtHsN93
 d1vrvRM3Q0kfAHtlY6kE7iHsLp5QawMflpRR69U78gqHBr063bbkk9/sGejURuRcYCb9
 PrIutwdpBInSRCxPoo9lfH10X9MXK3Db3DYR6DWbIK2s4rOAFw8rU1VkJAT5S0ECClh4
 z7L627My6jR2ZbFKPZO2ZcoowS5ATnb4ctntITYWa0xFi6kUBNgeV5dCuy8rqMZ0LFyl
 2/bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQw5ZPss9RYADbgMuQgYydGf6aX1jRYpav3Uv/n1QsIrv0HKWtw1/meTEuYyZQv45ecdEpBWPMZ0J2@nongnu.org
X-Gm-Message-State: AOJu0Yz7Ka5bSSmyyEFut7AgcUGzdnWgmiyLMJqCQXJTEoXD8vWNSB+J
 o13I1T6JEvJdgMykbwdy1WG9DPFsOtO/70UWwHoVWxXbsu7BM+14l3jrWIKbaXA=
X-Google-Smtp-Source: AGHT+IH6E8ybIsq39feX5hr3nvxHlHPKQV4ZUKcGjqSCzahs65H6L+PTrHpblF8jDsaekBZgsMcaEw==
X-Received: by 2002:a17:902:ce89:b0:20c:aed1:813a with SMTP id
 d9443c01a7336-20e9840c3cfmr231355ad.14.1729533621240; 
 Mon, 21 Oct 2024 11:00:21 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7ef181e2sm28740585ad.114.2024.10.21.11.00.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 11:00:20 -0700 (PDT)
Message-ID: <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
Date: Mon, 21 Oct 2024 11:00:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <cover.1729355735.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

SGkgSnVsaWFuLA0KDQpPbiAxMC8xOS8yNCAwOTozOSwgSnVsaWFuIEdhbnogd3JvdGU6DQo+
IFNvbWUgYW5hbHlzaXMgZ3JlYXRseSBiZW5lZml0cywgb3IgZGVwZW5kcyBvbiwgaW5mb3Jt
YXRpb24gYWJvdXQNCj4gaW50ZXJydXB0cy4gRm9yIGV4YW1wbGUsIHdlIG1heSBuZWVkIHRv
IGhhbmRsZSB0aGUgZXhlY3V0aW9uIG9mIGEgbmV3DQo+IHRyYW5zbGF0aW9uIGJsb2NrIGRp
ZmZlcmVudGx5IGlmIGl0IGlzIG5vdCB0aGUgcmVzdWx0IG9mIG5vcm1hbCBwcm9ncmFtDQo+
IGZsb3cgYnV0IG9mIGFuIGludGVycnVwdC4NCj4gDQo+IEV2ZW4gd2l0aCB0aGUgZXhpc3Rp
bmcgaW50ZXJmYWNlcywgaXQgaXMgbW9yZSBvciBsZXNzIHBvc3NpYmxlIHRvDQo+IGRpc2Nl
cm4gdGhlc2Ugc2l0dWF0aW9ucywgZS5nLiBhcyBkb25lIGJ5IHRoZSBjZmxvdyBwbHVnaW4u
IEhvd2V2ZXIsDQo+IHRoaXMgcHJvY2VzcyBwb3NlcyBhIGNvbnNpZGVyYWJsZSBvdmVyaGVh
ZCB0byB0aGUgY29yZSBhbmFseXNpcyBvbmUgbWF5DQo+IGludGVuZCB0byBwZXJmb3JtLg0K
Pg0KDQpJIGFncmVlIGl0IHdvdWxkIGJlIHVzZWZ1bC4gQmV5b25kIHRoZSBzY29wZSBvZiB0
aGlzIHNlcmllcywgaXQgd291bGQgYmUgDQpuaWNlIGlmIHdlIGNvdWxkIGFkZCBhIGNvbnRy
b2wgZmxvdyByZWxhdGVkIEFQSSBpbnN0ZWFkIG9mIGFza2luZyB0byANCnBsdWdpbnMgdG8g
ZG8gaXQgdGhlbXNlbHZlcy4NCg0KSWYgd2Ugd291bGQgcHJvdmlkZSBzb21ldGhpbmcgbGlr
ZSB0aGlzLCBpcyB0aGVyZSBzdGlsbCBhIHZhbHVlIHRvIGFkZCANCmFuIEFQSSB0byBkZXRl
Y3QgaW50ZXJydXB0L2V4Y2VwdGlvbnMvdHJhcHMgZXZlbnRzPw0KDQpOb3RlOiBJdCdzIG5v
dCBhIGNyaXRpYyBhZ2FpbnN0IHdoYXQgeW91IHNlbnQsIGp1c3QgYW4gb3BlbiBxdWVzdGlv
biBvbiANCip3aHkqIGl0J3MgdXNlZnVsIHRvIGFjY2VzcyB0aGlzIFFFTVUgaW1wbGVtZW50
YXRpb24gcmVsYXRlZCBpbmZvcm1hdGlvbiANCnZzIHNvbWV0aGluZyBtb3JlIGdlbmVyaWMu
DQoNCj4gVGhlc2UgY2hhbmdlcyBpbnRyb2R1Y2UgYSBnZW5lcmljIGFuZCBlYXN5LXRvLXVz
ZSBpbnRlcmZhY2UgZm9yIHBsdWdpbg0KPiBhdXRob3JzIGluIHRoZSBmb3JtIG9mIGNhbGxi
YWNrcyBmb3IgZGlmZmVyZW50IHR5cGVzIG9mIHRyYXBzLiBQYXRjaCAxDQo+IGRlZmluZXMg
dGhlIGNhbGxiYWNrIHJlZ2lzdHJhdGlvbiBmdW5jdGlvbnMgYW5kIHN1cHBsaWVzIGEgc29t
ZXdoYXQNCj4gbmFycm93IGRlZmluaXRpb24gb2YgdGhlIGV2ZW50IHRoZSBjYWxsYmFja3Mg
YXJlIGNhbGxlZC4gUGF0Y2ggMiBhZGRzDQo+IHNvbWUgaG9va3MgZm9yIHRyaWdnZXJpbmcg
dGhlIGNhbGxiYWNrcy4gUGF0Y2ggMyBhZGRzIGFuIGV4YW1wbGUgcGx1Z2luDQo+IHNob3dj
YXNpbmcgdGhlIG5ldyBBUEkuIFRoZSByZW1haW5pbmcgcGF0Y2hlcyBjYWxsIHRoZSBob29r
cyBmb3IgYQ0KPiBzZWxlY3Rpb24gb2YgYXJjaGl0ZWN0dXJlcywgbWFwcGluZyBhcmNoaXRl
Y3R1cmUgc3BlY2lmaWMgZXZlbnRzIHRvIHRoZQ0KPiB0aHJlZSBjYXRlZ29yaWVzIGRlZmlu
ZWQgaW4gcGF0Y2ggMS4gRnV0dXJlIG5vbi1SRkMgcGF0Y2hzZXRzIHdpbGwgY2FsbA0KPiB0
aGVzZSBob29rcyBmb3IgYWxsIGFyY2hpdGVjdHVyZXMgKHRoYXQgaGF2ZSBzb21lIGNvbmNl
cHQgb2YgdHJhcCBvcg0KPiBpbnRlcnJ1cHQpLg0KPiANCj4gU2lkZW5vdGU6IEknbSBsaWtl
bHkgZG9pbmcgc29tZXRoaW5nIHdyb25nIGZvciBvbmUgYXJjaGl0ZWN0dXJlIG9yDQo+IHRo
ZSBvdGhlci4gRm9yIGV4YW1wbGUsIHdpdGggdGhlIG9sZCB2ZXJzaW9uIEFsZXggQmVubsOp
ZSBzdWdnZXN0ZWQNCj4gcmVnaXN0ZXJpbmcgYSBoZWxwZXIgZnVuY3Rpb24gd2l0aCBhcm1f
cmVnaXN0ZXJfZWxfY2hhbmdlX2hvb2soKSBmb3INCj4gYXJtLCB3aGljaCBpcyBub3Qgd2hh
dCBJIGVuZGVkIHVwIGRvaW5nLiBBbmQgZm9yIEFWUiBteSBhcHByb2FjaCB0byBqdXN0DQo+
IGFzc3VtZSBvbmx5IChhc3luY2hyb25lb3VzKSBpbnRlcnJ1cHRzIGV4aXN0IGlzIGFsc28g
bGlrZWx5IHRvbyBuYcOvdmUuDQo+IA0KPiBTaW5jZSB2MToNCj4gICAgLSBTcGxpdCB0aGUg
b25lIGNhbGxiYWNrIGludG8gbXVsdGlwbGUgY2FsbGJhY2tzDQo+ICAgIC0gQWRkZWQgYSB0
YXJnZXQtYWdub3N0aWMgZGVmaW5pdGlvbiBvZiB0aGUgcmVsZXZhbnQgZXZlbnQocykNCj4g
ICAgLSBDYWxsIGhvb2tzIGZyb20gYXJjaGl0ZWN0dXJlLWNvZGUgcmF0aGVyIHRoYW4gYWNj
ZWwvdGNnL2NwdS1leGVjLmMNCj4gICAgLSBBZGRlZCBhIHBsdWdpbiBzaG93Y2FzaW5nIEFQ
SSB1c2FnZQ0KPiANCj4gSnVsaWFuIEdhbnogKDcpOg0KPiAgICBwbHVnaW5zOiBhZGQgQVBJ
IGZvciByZWdpc3RlcmluZyB0cmFwIHJlbGF0ZWQgY2FsbGJhY2tzDQo+ICAgIHBsdWdpbnM6
IGFkZCBob29rcyBmb3IgbmV3IHRyYXAgcmVsYXRlZCBjYWxsYmFja3MNCj4gICAgY29udHJp
Yi9wbHVnaW5zOiBhZGQgcGx1Z2luIHNob3djYXNpbmcgbmV3IHRyYXAgcmVsYXRlZCBBUEkN
Cj4gICAgdGFyZ2V0L2FybTogY2FsbCBwbHVnaW4gdHJhcCBjYWxsYmFja3MNCj4gICAgdGFy
Z2V0L2F2cjogY2FsbCBwbHVnaW4gdHJhcCBjYWxsYmFja3MNCj4gICAgdGFyZ2V0L3Jpc2N2
OiBjYWxsIHBsdWdpbiB0cmFwIGNhbGxiYWNrcw0KPiAgICB0YXJnZXQvc3BhcmM6IGNhbGwg
cGx1Z2luIHRyYXAgY2FsbGJhY2tzDQo+IA0KPiAgIGNvbnRyaWIvcGx1Z2lucy9NYWtlZmls
ZSAgICAgfCAgMSArDQo+ICAgY29udHJpYi9wbHVnaW5zL3RyYXBzLmMgICAgICB8IDg5ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvcWVtdS9w
bHVnaW4tZXZlbnQuaCAgfCAgMyArKw0KPiAgIGluY2x1ZGUvcWVtdS9wbHVnaW4uaCAgICAg
ICAgfCAxMiArKysrKw0KPiAgIGluY2x1ZGUvcWVtdS9xZW11LXBsdWdpbi5oICAgfCA0NSAr
KysrKysrKysrKysrKysrKysNCj4gICBwbHVnaW5zL2NvcmUuYyAgICAgICAgICAgICAgIHwg
NDIgKysrKysrKysrKysrKysrKysNCj4gICBwbHVnaW5zL3FlbXUtcGx1Z2lucy5zeW1ib2xz
IHwgIDMgKysNCj4gICB0YXJnZXQvYXJtL2hlbHBlci5jICAgICAgICAgIHwgMjMgKysrKysr
KysrKw0KPiAgIHRhcmdldC9hdnIvaGVscGVyLmMgICAgICAgICAgfCAgMyArKw0KPiAgIHRh
cmdldC9yaXNjdi9jcHVfaGVscGVyLmMgICAgfCAgOCArKysrDQo+ICAgdGFyZ2V0L3NwYXJj
L2ludDMyX2hlbHBlci5jICB8ICA3ICsrKw0KPiAgIHRhcmdldC9zcGFyYy9pbnQ2NF9oZWxw
ZXIuYyAgfCAxMCArKysrDQo+ICAgMTIgZmlsZXMgY2hhbmdlZCwgMjQ2IGluc2VydGlvbnMo
KykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29udHJpYi9wbHVnaW5zL3RyYXBzLmMNCj4g
DQo=

