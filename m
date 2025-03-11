Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42178C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1P5-0006gI-Qd; Tue, 11 Mar 2025 11:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Oz-0006fk-A6
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:20:17 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ts1Ox-0006p0-Hd
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:20:17 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so11883503a91.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741706414; x=1742311214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lQ1DlCBUIbAraI/JTg1m2qqamEpgEFznt1TObYD6Os0=;
 b=U219LnqTLlP9mJA+oTeaqoNjEPFrRcn1rIvVt8EPbQhdMwM9BJGdWJqzrUPhCZrt8e
 evUxQSR+0KXjTBg9+/BqU46WEGDYQfnFCMC4hRYi29SmWObZK5/L3KxJHEJ6NPYau1x1
 Vip3If/jOayK6mlEkxhNKenBFgrbDPpvhpGcdTi+qMlOR9vw/elhHoJz6PfBpQstolgT
 MbQYZFfLNc+ymxlFGvo/C7YhMgml3EsAFYBIO7tTIDzcjmRodKS5eTyETh/7Faae2cG3
 R3uN5jUeAMOmeoJu11mgS6UpcH/fLCdvA5cVr0Xf2t2/uRiqoD1b8UxnGn4UeRQ+HlVG
 a5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706414; x=1742311214;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lQ1DlCBUIbAraI/JTg1m2qqamEpgEFznt1TObYD6Os0=;
 b=iucF46fX9jAPj+lRb9IBIBY9VmP2u85LadPqe9zfdDBojLIw4xt+AN76bszFD06I33
 ewY9iDv89MX34Ascy4rTIwEoI8j5L/ynW2wAihGc7tY/NHUgUvA3vyVB183pMzBRrRon
 E3p+k3ERjOqju/I6siScplmb2/JCb3UkMyoMPuPyWuiFHdsM4iBGr6PDzxUmlTt/K2Ji
 gliBxLo0rxFr4ApqmpME+PyMqSYTpCCyNeu3retdqeFPt6C1do5/mRwoUPeYT6C6fhCu
 CAhOTswzX/54f5/we6FYE3DhptltGsb30q0dVAzWWW2ZaFNMFucEg6CV9o9X2npGRBTR
 5q/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKgm/G6fktpSL8w5v3rsDRAdIBkqjkF7VdaZvQU3mmKjfnkW+sa1b+LUQefMlyViJxTabTd68UHuZr@nongnu.org
X-Gm-Message-State: AOJu0Yzj2xwWABd7dBaV38AmtKzJAIDFH5jXyXXX1wxWb2ITS+yPl52K
 e+lfsFwyR1e4ll8oYKEQUYMnBMoQUJmrCGtJKlY03Nf7AAc5Mk2CSP2FrLlM/1Y=
X-Gm-Gg: ASbGncvWdEhY7w0Aah8Y27XBIXbRMPNE61V1Mjayd0q/m9sW9pPa2SIlbum/DmWekJt
 izUzl2el+PhFJ4YmyrL+VVLiW5P3RDGHMgD4ki6doMtWvi3IsBIcHoU0BRcdJ3jKksjDiT+SYH/
 aVZtYW3N6m6WnHOt8KxkpRUx6TwlKchfGO7t2tuLtXSwLEzNgv4HJv88cbHEn4ssWFP+VWzo9Vi
 Xbo5sTBVVBNyahy9TIGg5UGjzDUhiqkzdpr0j/s6Z9q32nwGKwWfe/j/PGqY/XfXzh/P4Btv3jk
 ElNiirGMX48ozaCjbIda8iKbGl6nTewpeQDDJ8vchkRQSScMiW3uFGhlIw==
X-Google-Smtp-Source: AGHT+IHB6/PW0IHKkK7wGI9UOrKJJD3Du6pkJ5/gnIg+/UfsjtLDQjkMRqgvo/n5/5r2fsfdUad9Yg==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-2ff7cf128acmr27929118a91.24.1741706413718; 
 Tue, 11 Mar 2025 08:20:13 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff53eda418sm11565063a91.45.2025.03.11.08.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:20:13 -0700 (PDT)
Message-ID: <42184de6-5484-4e5a-b502-48db0e6d2cf5@linaro.org>
Date: Tue, 11 Mar 2025 08:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/16] include/exec/memory: extract devend_big_endian
 from devend_memop
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 David Hildenbrand <david@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, alex.bennee@linaro.org,
 qemu-riscv@nongnu.org, manos.pitsidianakis@linaro.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
References: <20250311040838.3937136-1-pierrick.bouvier@linaro.org>
 <20250311040838.3937136-15-pierrick.bouvier@linaro.org>
 <b8073e25-ae8a-462b-b085-84c471a4bf5e@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b8073e25-ae8a-462b-b085-84c471a4bf5e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

T24gMy8xMS8yNSAwMDozNiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDExLzMvMjUgMDU6MDgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiB3ZSdsbCB1c2Ug
aXQgaW4gc3lzdGVtL21lbW9yeS5jLg0KPiANCj4gSGF2aW5nIHBhcnQgb2YgdGhlIGNvbW1p
dCBkZXNjcmlwdGlvbiBzZXBhcmF0ZWQgaW4gaXRzIHN1YmplY3QgaXMgYQ0KPiBiaXQgYW5u
b3lpbmcuIEJ1dCB0aGVuIEknbSBwcm9iYWJseSB1c2luZyAyMC15ZWFycyB0b28gb2xkIHRv
b2xzIGluDQo+IG15IHBhdGNoIHdvcmtmbG93Lg0KPiANCj4gT25seSB1c2VkIGluIHN5c3Rl
bS97bWVtb3J5LHBoeXNtZW19LmMsIHdvcnRoIG1vdmUgdG8gYSBsb2NhbA0KPiBzeXN0ZW0v
bWVtb3J5LWludGVybmFsLmggaGVhZGVyPyBPciBldmVuIHNpbXBsZXIsIG1vdmUNCj4gaW5j
bHVkZS9leGVjL21lbW9yeS1pbnRlcm5hbC5oIC0+IGV4ZWMvbWVtb3J5LWludGVybmFsLmgg
Zmlyc3QuDQo+IA0KDQpHb29kIHBvaW50LCBJJ2xsIG1vdmUgdGhlbSB0byB0aGUgZXhpc3Rp
bmcgZXhlYy9tZW1vcnktaW50ZXJuYWwuaCBpbiBhbiANCmFkZGl0aW9uYWwgY29tbWl0Lg0K
DQo+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQo+PiAtLS0NCj4+ICAgIGluY2x1ZGUvZXhlYy9tZW1vcnkuaCB8IDE4
ICsrKysrKysrKysrKy0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhl
Yy9tZW1vcnkuaCBiL2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPj4gaW5kZXggNjBjMGZiNmNj
ZDQuLjU3NjYxMjgzNjg0IDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5o
DQo+PiArKysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+IEBAIC0zMTM4LDE2ICszMTM4
LDIyIEBAIGFkZHJlc3Nfc3BhY2Vfd3JpdGVfY2FjaGVkKE1lbW9yeVJlZ2lvbkNhY2hlICpj
YWNoZSwgaHdhZGRyIGFkZHIsDQo+PiAgICBNZW1UeFJlc3VsdCBhZGRyZXNzX3NwYWNlX3Nl
dChBZGRyZXNzU3BhY2UgKmFzLCBod2FkZHIgYWRkciwNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHVpbnQ4X3QgYywgaHdhZGRyIGxlbiwgTWVtVHhBdHRycyBhdHRy
cyk7DQo+PiAgICANCj4+IC0vKiBlbnVtIGRldmljZV9lbmRpYW4gdG8gTWVtT3AuICAqLw0K
Pj4gLXN0YXRpYyBpbmxpbmUgTWVtT3AgZGV2ZW5kX21lbW9wKGVudW0gZGV2aWNlX2VuZGlh
biBlbmQpDQo+PiArLyogcmV0dXJucyB0cnVlIGlmIGVuZCBpcyBiaWcgZW5kaWFuLiAqLw0K
Pj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBkZXZlbmRfYmlnX2VuZGlhbihlbnVtIGRldmljZV9l
bmRpYW4gZW5kKQ0KPj4gICAgew0KPj4gICAgICAgIFFFTVVfQlVJTERfQlVHX09OKERFVklD
RV9IT1NUX0VORElBTiAhPSBERVZJQ0VfTElUVExFX0VORElBTiAmJg0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgIERFVklDRV9IT1NUX0VORElBTiAhPSBERVZJQ0VfQklHX0VORElB
Tik7DQo+PiAgICANCj4+IC0gICAgYm9vbCBiaWdfZW5kaWFuID0gKGVuZCA9PSBERVZJQ0Vf
TkFUSVZFX0VORElBTg0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgPyB0YXJnZXRfd29y
ZHNfYmlnZW5kaWFuKCkNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgIDogZW5kID09IERF
VklDRV9CSUdfRU5ESUFOKTsNCj4+IC0gICAgcmV0dXJuIGJpZ19lbmRpYW4gPyBNT19CRSA6
IE1PX0xFOw0KPj4gKyAgICBpZiAoZW5kID09IERFVklDRV9OQVRJVkVfRU5ESUFOKSB7DQo+
PiArICAgICAgICByZXR1cm4gdGFyZ2V0X3dvcmRzX2JpZ2VuZGlhbigpOw0KPj4gKyAgICB9
DQo+PiArICAgIHJldHVybiBlbmQgPT0gREVWSUNFX0JJR19FTkRJQU47DQo+PiArfQ0KPj4g
Kw0KPj4gKy8qIGVudW0gZGV2aWNlX2VuZGlhbiB0byBNZW1PcC4gICovDQo+PiArc3RhdGlj
IGlubGluZSBNZW1PcCBkZXZlbmRfbWVtb3AoZW51bSBkZXZpY2VfZW5kaWFuIGVuZCkNCj4+
ICt7DQo+PiArICAgIHJldHVybiBkZXZlbmRfYmlnX2VuZGlhbihlbmQpID8gTU9fQkUgOiBN
T19MRTsNCj4+ICAgIH0NCj4+ICAgIA0KPj4gICAgLyoNCj4gDQo=

