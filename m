Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF77ECF884F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 22:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swr09-0001u7-H1; Fri, 04 Oct 2024 18:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swr05-0001tt-PA
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:42:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1swr02-00051F-De
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 18:42:15 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7db299608e7so1701566a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 15:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728081733; x=1728686533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hy3/4Rwt5pbo6EXaA+jpjbUkW3KL7Cp9tldQVTy2+Q0=;
 b=P0eb38dO2a7pGY6Bm3AUDH8VFNn6w/VE1y428HhlsHsOTyG+GfiJ1bs+cDeh4mWlk4
 HsWQz/ezheT/uKQx91aM97Hcfy2jSNHw5LzC+y+jMAlqKuf4D5AkehDT5MJmmu5xi9yr
 UKpP55c+pKrASEvvErMPtMYKG6IcTlisq/o4Y1aBsBDVj2l7jmQaxmuxiyGUYVuTdcbk
 w0D5mYGQ8X3ZnFppqee0rqO8sEz3mxxuNkVAn2L1QgXixcODFQZe6pNop8DsEjEVpqxW
 yynCkFIdNQYBUjLWKz1lA4WJ6D4ImA2fkCexqqt6rAkDvOIteXmh4DXOmWsPB+uMYn9/
 Y3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728081733; x=1728686533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hy3/4Rwt5pbo6EXaA+jpjbUkW3KL7Cp9tldQVTy2+Q0=;
 b=V1ZmWXDC549iL7uCoPZVdVfKr0Cz3zJvLzGMw09zx/8NfXPy0+0kmSy9flTm/blPe/
 nHk8aPWIKpjpJa7or3dSWmd2GT2dtfqsx4Myz7mL5w6t5UMx7iHJM1cahnDVp7EfFe8m
 VM0LlIW+JSnBxbkKxS4DpiZKg59jURrro9pv6lmOZLUnLfLNJo5FbvFUVBhz4uiyOQML
 wsctHRmZDFtNzC+FdhcEwXrnbkmVxI3FThnU/q4NLcDfa8tAOdGkJUpWHL/05oEgrkKb
 Mdktdy5LS6nDa6ET2J5YLVtnyygJ4M0uMc7pEONw5XfMC1++GBZPp2+jYv98O+1x74xv
 aghw==
X-Gm-Message-State: AOJu0YwVygNvpSYoGP5FGjGxeB2uPqWq0FEzIe7fcQMg9x6jpIpkj18Z
 oBPFRdrPqCVKrKchnEC2QkfUNfFY2ywSjWvLkBcgZIzwyACrykGj8h4saXKKy4s=
X-Google-Smtp-Source: AGHT+IHCUGvotYlMmrRU/KW1qsdcO+w7jg9hOnCvmRTteBnF7+alhvOQ0TxjVLvJzP/vuURKeRVh/g==
X-Received: by 2002:a05:6a20:6aa4:b0:1d6:e1a4:21ae with SMTP id
 adf61e73a8af0-1d6e1a4227dmr4735848637.28.1728081732640; 
 Fri, 04 Oct 2024 15:42:12 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d452ddsm380297b3a.136.2024.10.04.15.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 15:42:12 -0700 (PDT)
Message-ID: <6471aa21-1c2a-42c8-8c68-d53d0e4e5343@linaro.org>
Date: Fri, 4 Oct 2024 15:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/24] configure: move -mcx16 flag out of CPU_CFLAGS
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Artyom Kunakovsky <artyomkunakovsky@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240525113332.1404158-1-pbonzini@redhat.com>
 <20240525113332.1404158-2-pbonzini@redhat.com>
 <87cykflul2.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87cykflul2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

T24gMTAvNC8yNCAwOTowOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQYW9sbyBCb256aW5p
IDxwYm9uemluaUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gRnJvbTogQXJ0eW9tIEt1
bmFrb3Zza3kgPGFydHlvbWt1bmFrb3Zza3lAZ21haWwuY29tPg0KPj4NCj4+IFRoZSBwb2lu
dCBvZiBDUFVfQ0ZMQUdTIGlzIHJlYWxseSBqdXN0IHRvIHNlbGVjdCB0aGUgYXBwcm9wcmlh
dGUgbXVsdGlsaWIsDQo+PiBmb3IgZXhhbXBsZSBmb3IgbGlicmFyeSBsaW5raW5nIHRlc3Rz
LCBhbmQgLW1jeDE2IGlzIG5vdCBuZWVkZWQgZm9yDQo+PiB0aGF0IHB1cnBvc2UuDQo+Pg0K
Pj4gRnVydGhlcm1vcmUsIGlmIC1tY3gxNiBpcyBwYXJ0IG9mIFFFTVUncyBjaG9pY2Ugb2Yg
YSBiYXNpYyB4ODZfNjQNCj4+IGluc3RydWN0aW9uIHNldCwgaXQgc2hvdWxkIGJlIGFwcGxp
ZWQgdG8gY3Jvc3MtY29tcGlsZWQgeDg2XzY0IGNvZGUgdG9vOw0KPj4gaXQgaXMgcGxhdXNp
YmxlIHRoYXQgdGVzdHMvdGNnIHdvdWxkIHdhbnQgdG8gY292ZXIgY21weGNoZzE2YiBhcyB3
ZWxsLA0KPj4gZm9yIGV4YW1wbGUuICBJbiB0aGUgZW5kIHRoaXMgbWFrZXMganVzdCBhcyBt
dWNoIHNlbnNlIGFzIGEgcGVyIHN1Yi1idWlsZA0KPj4gdHdlYWssIHNvIG1vdmUgdGhlIGZs
YWcgdG8gbWVzb24uYnVpbGQgYW5kIGNyb3NzX2NjX2NmbGFnc194ODZfNjQuDQo+Pg0KPj4g
VGhpcyBsZWF2ZXMgb3V0IGNvbnRyaWIvcGx1Z2lucywgd2hpY2ggd291bGQgZmFpbCB3aGVu
IGF0dGVtcHRpbmcgdG8gdXNlDQo+PiBfX3N5bmNfdmFsX2NvbXBhcmVfYW5kX3N3YXBfMTYg
KG5vdGUgaXQgZG9lcyBub3QgZG8geWV0KTsgd2hpbGUgbWlub3IsDQo+PiB0aGlzICppcyog
YSBkaXNhZHZhbnRhZ2Ugb2YgdGhpcyBjaGFuZ2UuICBCdXQgYnVpbGRpbmcgY29udHJpYi9w
bHVnaW5zDQo+PiB3aXRoIGEgTWFrZWZpbGUgaW5zdGVhZCBvZiBtZXNvbi5idWlsZCBpcyBz
b21ldGhpbmcgc2VsZi1pbmZsaWN0ZWQganVzdA0KPj4gZm9yIHRoZSBzYWtlIG9mIHNob3dp
bmcgdGhhdCBpdCBjYW4gYmUgZG9uZSwgYW5kIGlmIHRoaXMga2luZCBvZiBwYXBlcmN1dA0K
Pj4gc3RhcnRlZCBiZWNvbWluZyBhIHByb2JsZW0gd2UgY291bGQgbWFrZSB0aGUgZGlyZWN0
b3J5IHBhcnQgb2YgdGhlIG1lc29uDQo+PiBidWlsZC4gIFVudGlsIHRoZW4sIHdlIGNhbiBs
aXZlIHdpdGggdGhlIGxpbWl0YXRpb24uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXJ0eW9t
IEt1bmFrb3Zza3kgPGFydHlvbWt1bmFrb3Zza3lAZ21haWwuY29tPg0KPj4gTWVzc2FnZS1J
RDogPDIwMjQwNTIzMDUxMTE4LjI5MzY3LTEtYXJ0eW9ta3VuYWtvdnNreUBnbWFpbC5jb20+
DQo+PiBbcmV3cml0ZSBjb21taXQgbWVzc2FnZSwgcmVtb3ZlIGZyb20gY29uZmlndXJlLiAt
IFBhb2xvXQ0KPj4gU2lnbmVkLW9mZi1ieTogUGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVk
aGF0LmNvbT4NCj4+IC0tLQ0KPj4gICBjb25maWd1cmUgICB8IDcgKystLS0tLQ0KPj4gICBt
ZXNvbi5idWlsZCB8IDcgKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDkgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvY29uZmlndXJl
IGIvY29uZmlndXJlDQo+PiBpbmRleCAzOGVlMjU3NzAxMy4uNGQwMWE0MmJhNjUgMTAwNzU1
DQo+PiAtLS0gYS9jb25maWd1cmUNCj4+ICsrKyBiL2NvbmZpZ3VyZQ0KPj4gQEAgLTUxMiwx
MCArNTEyLDcgQEAgY2FzZSAiJGNwdSIgaW4NCj4+ICAgICAgIGNwdT0ieDg2XzY0Ig0KPj4g
ICAgICAgaG9zdF9hcmNoPXg4Nl82NA0KPj4gICAgICAgbGludXhfYXJjaD14ODYNCj4+IC0g
ICAgIyA/Pz8gT25seSBleHRyZW1lbHkgb2xkIEFNRCBjcHVzIGRvIG5vdCBoYXZlIGNtcHhj
aGcxNmIuDQo+PiAtICAgICMgSWYgd2UgdHJ1bHkgY2FyZSwgd2Ugc2hvdWxkIHNpbXBseSBk
ZXRlY3QgdGhpcyBjYXNlIGF0DQo+PiAtICAgICMgcnVudGltZSBhbmQgZ2VuZXJhdGUgdGhl
IGZhbGxiYWNrIHRvIHNlcmlhbCBlbXVsYXRpb24uDQo+PiAtICAgIENQVV9DRkxBR1M9Ii1t
NjQgLW1jeDE2Ig0KPj4gKyAgICBDUFVfQ0ZMQUdTPSItbTY0Ig0KPj4gICAgICAgOzsNCj4+
ICAgZXNhYw0KPj4gICANCj4+IEBAIC0xMjAzLDcgKzEyMDAsNyBAQCBmaQ0KPj4gICA6ICR7
Y3Jvc3NfY2NfY2ZsYWdzX3NwYXJjNjQ9Ii1tNjQgLW1jcHU9dWx0cmFzcGFyYyJ9DQo+PiAg
IDogJHtjcm9zc19jY19zcGFyYz0iJGNyb3NzX2NjX3NwYXJjNjQifQ0KPj4gICA6ICR7Y3Jv
c3NfY2NfY2ZsYWdzX3NwYXJjPSItbTMyIC1tY3B1PXN1cGVyc3BhcmMifQ0KPj4gLTogJHtj
cm9zc19jY19jZmxhZ3NfeDg2XzY0PSItbTY0In0NCj4+ICs6ICR7Y3Jvc3NfY2NfY2ZsYWdz
X3g4Nl82ND0iLW02NCAtbWN4MTYifQ0KPj4gICANCj4+ICAgY29tcHV0ZV90YXJnZXRfdmFy
aWFibGUoKSB7DQo+PiAgICAgZXZhbCAiJDI9Ig0KPj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1
aWxkIGIvbWVzb24uYnVpbGQNCj4+IGluZGV4IGE5ZGU3MWQ0NTA2Li43ZmQ4MmI1ZjQ4YyAx
MDA2NDQNCj4+IC0tLSBhL21lc29uLmJ1aWxkDQo+PiArKysgYi9tZXNvbi5idWlsZA0KPj4g
QEAgLTMzNiw2ICszMzYsMTMgQEAgaWYgaG9zdF9hcmNoID09ICdpMzg2JyBhbmQgbm90IGNj
LmxpbmtzKCcnJw0KPj4gICAgIHFlbXVfY29tbW9uX2ZsYWdzID0gWyctbWFyY2g9aTQ4Nidd
ICsgcWVtdV9jb21tb25fZmxhZ3MNCj4+ICAgZW5kaWYNCj4+ICAgDQo+PiArIyA/Pz8gT25s
eSBleHRyZW1lbHkgb2xkIEFNRCBjcHVzIGRvIG5vdCBoYXZlIGNtcHhjaGcxNmIuDQo+PiAr
IyBJZiB3ZSB0cnVseSBjYXJlLCB3ZSBzaG91bGQgc2ltcGx5IGRldGVjdCB0aGlzIGNhc2Ug
YXQNCj4+ICsjIHJ1bnRpbWUgYW5kIGdlbmVyYXRlIHRoZSBmYWxsYmFjayB0byBzZXJpYWwg
ZW11bGF0aW9uLg0KPj4gK2lmIGhvc3RfYXJjaCA9PSAneDg2XzY0Jw0KPj4gKyAgcWVtdV9j
b21tb25fZmxhZ3MgPSBbJy1tY3gxNiddICsgcWVtdV9jb21tb25fZmxhZ3MNCj4+ICtlbmRp
Zg0KPj4gKw0KPj4gICBpZiBnZXRfb3B0aW9uKCdwcmVmZXJfc3RhdGljJykNCj4+ICAgICBx
ZW11X2xkZmxhZ3MgKz0gZ2V0X29wdGlvbignYl9waWUnKSA/ICctc3RhdGljLXBpZScgOiAn
LXN0YXRpYycNCj4+ICAgZW5kaWYNCj4gDQo+IFRoaXMgYnJlYWtzIGF0b21pYyBkZXRlY3Rp
b24gcmVzdWx0aW5nIGluOg0KPiANCj4gI3VuZGVmIENPTkZJR19BVE9NSUMxMjgNCj4gI3Vu
ZGVmIENPTkZJR19BVE9NSUMxMjhfT1BUDQo+ICN1bmRlZiBDT05GSUdfQ01QWENIRzEyOA0K
PiANCj4gd2hpY2ggbWFrZXMgdGhlIFRDRyBhdG9taWMgaGFuZGxpbmcgY29kZSBmYWxsYmFj
ayB0byBjcHVfc3RlcF9hdG9taWMsDQo+IGtpbGxpbmcgcGVyZm9ybWFuY2UuDQo+IA0KDQpQ
b3N0ZWQgdGhpcyBwYXRjaCB0byBzb2x2ZSBpc3N1ZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL3FlbXUtZGV2ZWwvMjAyNDEwMDQyMjAxMjMuOTc4OTM4LTEtcGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnL1QvI3UNCg==

