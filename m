Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C3CC4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 21:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dni-0000ve-3c; Thu, 02 May 2024 17:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dnK-0000bW-Gu
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:16:53 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s2dnI-00037U-8v
 for qemu-devel@nongnu.org; Thu, 02 May 2024 17:16:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f44a2d1e3dso191064b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714684601; x=1715289401; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7nW8wWwhxosg+VAULOzhg+bzl+H+otSgm1Tg2j55OfY=;
 b=q80OB6fsmpvJ86x9UcsRx4F3wzPYUKHc0zREdoYDvoq2UV80tC7CuKMfpRiFOKxcdd
 t2E5XzUf1ixsOblOkxyoSp3yi4p5qcqB68KjjJABX4w24PeA8G/5JjQMqZSPh4tB3B1s
 ZDpyW68ja/CfCglgXc96gYCWFm4Vr+9qxa7uez/geJhVodAxRiiAr5o7cbiL+yXsO62U
 H6LzZ/uy0K1aPZPTAxlMddf+pTKKTKyXfj7LHQv8+TZ4hV4Wt2Wvk7l12NgLblSmxJIe
 im2wrO65DM+F7BMoSlkfzv9lW8mDldihCv0fyRL4GyIQM3uJMqkWeuNmUMDOupFhRL7o
 hXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714684601; x=1715289401;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7nW8wWwhxosg+VAULOzhg+bzl+H+otSgm1Tg2j55OfY=;
 b=T0wODZSOTpNku2fp2TjUP8dFz+t58HakkIROuQKzTBAX3McwF3PFAaYnuvXGobC3m7
 JaE+xH+gn9UoDzDZ3uZwAymhwUR1xhoXHrNwvGVXA4ukCAfIkLFSv4bexShCcauXrYff
 ZyiA6klX4lsOUv2CkFTpewo52g1vxBaeiLfJo17J6Cuebc9vtsHkhq2FuTy+oJAsDbtg
 fZvs9lXrvY+Hg/qbsjjwuKiWoTOUFkKR/Efq+/oxIVfFGt5B3GzVFMRjVqSpBxsxL1IT
 Ywrc7WZVCcpLEBNXi368fqdD1xTygfUoZMxg7aVRs8tR6cGlKbBWqSh8SEnltTkbH3t4
 cmCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPVNJVz5suor39fmcMJfhqpHt60EoeA1BXd0f1+pRrhTEbaTm6/KEpfzB8A5kQ8P8+FfyECqao9mUa1ajARGp2CN5XIEo=
X-Gm-Message-State: AOJu0YxaadFaYUDzgVs1+H/5PCTHrWHddn+6xBu/0FwcAUd/ZchWtFqa
 UqBgUJ0nDRL+N1gp0fRsY+X56KF9lXz59ufY0nmNgg/puoVaq6+Zd/SxvL5uKT1M1yj5wfBdeKj
 eYgI=
X-Google-Smtp-Source: AGHT+IE0jROmTQ/W0SOIMJU+PVfOyMtaM17KDCiF0veQxDb2jHe5SMqLs5txszH5CiqLZx2wk3Tnlg==
X-Received: by 2002:a05:6a00:148d:b0:6ed:d68d:948a with SMTP id
 v13-20020a056a00148d00b006edd68d948amr810056pfu.23.1714684600644; 
 Thu, 02 May 2024 14:16:40 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::ecd0? ([2604:3d08:9384:1d00::ecd0])
 by smtp.gmail.com with ESMTPSA id
 x16-20020a056a000bd000b006f3ef4e7551sm1711926pfu.217.2024.05.02.14.16.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 14:16:40 -0700 (PDT)
Message-ID: <38188b6e-fa36-4c14-9f0f-763826bc9363@linaro.org>
Date: Thu, 2 May 2024 14:16:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
 <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
 <b083716a-dd1e-4edb-ba57-530c7661305f@linaro.org>
 <b3474554-0333-27c2-df47-146e5ef317d9@linaro.org>
 <6f37fbce-9fcc-ab7d-08fc-cfd8bb470f9b@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <6f37fbce-9fcc-ab7d-08fc-cfd8bb470f9b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gNS8yLzI0IDEzOjQ4LCBHdXN0YXZvIFJvbWVybyB3cm90ZToNCj4gSGkgUGllcnJpY2ss
DQo+IA0KPiBPbiA1LzIvMjQgNTowOSBQTSwgR3VzdGF2byBSb21lcm8gd3JvdGU6DQo+PiBP
biA1LzIvMjQgNDo0NSBQTSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBIaSBHdXN0
YXZvLA0KPj4+DQo+Pj4gT24gNS8yLzI0IDEyOjE2LCBHdXN0YXZvIFJvbWVybyB3cm90ZToN
Cj4+Pj4gSGkgUGllcnJpY2ssDQo+Pj4+DQo+Pj4+IE9uIDUvMi8yNCAzOjA4IFBNLCBQaWVy
cmljayBCb3V2aWVyIHdyb3RlOg0KPj4+Pj4gVGhpcyBzZXJpZXMgaW1wbGVtZW50IHR3byBu
ZXcgb3BlcmF0aW9ucyBmb3IgcGx1Z2luczoNCj4+Pj4+IC0gU3RvcmUgaW5saW5lIGFsbG93
cyB0byB3cml0ZSBhIHNwZWNpZmljIHZhbHVlIHRvIGEgc2NvcmVib2FyZC4NCj4+Pj4+IC0g
Q29uZGl0aW9uYWwgY2FsbGJhY2sgZXhlY3V0ZXMgYSBjYWxsYmFjayBvbmx5IHdoZW4gYSBn
aXZlbiBjb25kaXRpb24gaXMgdHJ1ZS4NCj4+Pj4+ICDCoMKgwqAgVGhlIGNvbmRpdGlvbiBp
cyBldmFsdWF0ZWQgaW5saW5lLg0KPj4+Pj4NCj4+Pj4+IEl0J3MgcG9zc2libGUgdG8gbWl4
IHZhcmlvdXMgaW5saW5lIG9wZXJhdGlvbnMgKGFkZCwgc3RvcmUpIHdpdGggY29uZGl0aW9u
YWwNCj4+Pj4+IGNhbGxiYWNrcywgYWxsb3dpbmcgZWZmaWNpZW50ICJ0cmFwIiBiYXNlZCBj
b3VudGVycy4NCj4+Pj4+DQo+Pj4+PiBJdCBidWlsZHMgb24gdG9wIG9mIG5ldyBzY29yZWJv
YXJkIEFQSSwgaW50cm9kdWNlZCBpbiB0aGUgcHJldmlvdXMgc2VyaWVzLg0KPj4+Pj4NCj4+
Pj4+IE5PVEU6IFR3byBwYXRjaGVzIHN0aWxsIG5lZWQgcmV2aWV3DQo+Pj4+Pg0KPj4+Pj4g
djINCj4+Pj4+IC0tIA0KPj4+Pj4NCj4+Pj4+IC0gZml4ZWQgaXNzdWUgd2l0aCB1ZGF0YSBu
b3QgYmVpbmcgcGFzc2VkIHRvIGNvbmRpdGlvbmFsIGNhbGxiYWNrDQo+Pj4+PiAtIGFkZGVk
IHNwZWNpZmljIHRlc3QgZm9yIHRoaXMgaW4gdGVzdHMvcGx1Z2luL2lubGluZS5jICh1ZGF0
YSB3YXMgTlVMTCBiZWZvcmUpLg0KPj4+Pj4NCj4+Pj4+IHYzDQo+Pj4+PiAtLSANCj4+Pj4+
DQo+Pj4+PiAtIHJlYmFzZWQgb24gdG9wIG9mICJwbHVnaW5zOiBSZXdyaXRlIHBsdWdpbiBj
b2RlIGdlbmVyYXRpb24iOg0KPj4+Pj4gIMKgwqDCoCAyMDI0MDMxNjAxNTcyMC4zNjYxMjM2
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZw0KPj4+Pj4gLSBzaW5nbGUgcGFzcyBj
b2RlIGdlbmVyYXRpb24NCj4+Pj4+IC0gc21hbGwgY2xlYW51cHMgZm9yIGNvZGUgZ2VuZXJh
dGlvbg0KPj4+Pj4NCj4+Pj4+IHY0DQo+Pj4+PiAtLSANCj4+Pj4+DQo+Pj4+PiAtIHJlbW92
ZSBvcCBmaWVsZCBmcm9tIHFlbXVfcGx1Z2luX2lubGluZV9jYg0KPj4+Pj4gLSB1c2UgdGNn
X2NvbnN0YW50X2k2NCB0byBsb2FkIGltbWVkaWF0ZSB2YWx1ZSB0byBzdG9yZQ0KPj4+Pj4N
Cj4+Pj4+IHY1DQo+Pj4+PiAtLSANCj4+Pj4+DQo+Pj4+PiAtIHJlYmFzZSBvbiB0b3Agb2Yg
bWFzdGVyIG5vdyB0aGF0IFJpY2hhcmQncyBzZXJpZXMgd2FzIG1lcmdlZA0KPj4+Pj4NCj4+
Pj4+IFBpZXJyaWNrIEJvdXZpZXIgKDkpOg0KPj4+Pj4gIMKgwqDCoCBwbHVnaW5zOiBwcmVw
YXJlIGludHJvZHVjdGlvbiBvZiBuZXcgaW5saW5lIG9wcw0KPj4+Pj4gIMKgwqDCoCBwbHVn
aW5zOiBleHRyYWN0IGdlbmVyYXRlIHB0ciBmb3IgcWVtdV9wbHVnaW5fdTY0DQo+Pj4+PiAg
wqDCoMKgIHBsdWdpbnM6IGFkZCBuZXcgaW5saW5lIG9wIFNUT1JFX1U2NA0KPj4+Pj4gIMKg
wqDCoCB0ZXN0cy9wbHVnaW4vaW5saW5lOiBhZGQgdGVzdCBmb3IgU1RPUkVfVTY0IGlubGlu
ZSBvcA0KPj4+Pj4gIMKgwqDCoCBwbHVnaW5zOiBjb25kaXRpb25hbCBjYWxsYmFja3MNCj4+
Pj4+ICDCoMKgwqAgdGVzdHMvcGx1Z2luL2lubGluZTogYWRkIHRlc3QgZm9yIGNvbmRpdGlv
bmFsIGNhbGxiYWNrDQo+Pj4+PiAgwqDCoMKgIHBsdWdpbnM6IGRpc3RpbmN0IHR5cGVzIGZv
ciBjYWxsYmFja3MNCj4+Pj4+ICDCoMKgwqAgcGx1Z2luczogZXh0cmFjdCBjcHVfaW5kZXgg
Z2VuZXJhdGUNCj4+Pj4+ICDCoMKgwqAgcGx1Z2luczogcmVtb3ZlIG9wIGZyb20gcWVtdV9w
bHVnaW5faW5saW5lX2NiDQo+Pj4+Pg0KPj4+Pj4gIMKgwqAgaW5jbHVkZS9xZW11L3BsdWdp
bi5owqDCoMKgwqDCoMKgwqAgfMKgIDQyICsrKysrKystLS0tDQo+Pj4+PiAgwqDCoCBpbmNs
dWRlL3FlbXUvcWVtdS1wbHVnaW4uaMKgwqAgfMKgIDgwICsrKysrKysrKysrKysrKysrKysr
LQ0KPj4+Pj4gIMKgwqAgcGx1Z2lucy9wbHVnaW4uaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMTIgKysrLQ0KPj4+Pj4gIMKgwqAgYWNjZWwvdGNnL3BsdWdpbi1nZW4uY8KgwqDC
oMKgwqDCoCB8IDEzNiArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPj4+
Pj4gIMKgwqAgcGx1Z2lucy9hcGkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMzkgKysrKysrKysrKw0KPj4+Pj4gIMKgwqAgcGx1Z2lucy9jb3JlLmPCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgMTA5ICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0N
Cj4+Pj4+ICDCoMKgIHRlc3RzL3BsdWdpbi9pbmxpbmUuY8KgwqDCoMKgwqDCoMKgIHwgMTMw
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLQ0KPj4+Pj4gIMKgwqAgcGx1Z2lu
cy9xZW11LXBsdWdpbnMuc3ltYm9scyB8wqDCoCAyICsNCj4+Pj4+ICDCoMKgIDggZmlsZXMg
Y2hhbmdlZCwgNDY2IGluc2VydGlvbnMoKyksIDg0IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+
PiBUaGUgZGVzY3JpcHRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIG9mIHBhdGNoZXMgMS85
LCAyLzksIDYvOSwgNy85LCBhbmQgOC85IGlzIG1pc3NpbmcuDQo+Pj4+DQo+Pj4+IElzIHRo
aXMgaW50ZW50aW9uYWw/DQo+Pj4+DQo+Pj4NCj4+PiBEbyB5b3UgbWVhbiB0aGVyZSBpcyBu
byBtdWx0aWxpbmUgY29tbWl0IG1lc3NhZ2UgZm9yIHRob3NlIGNoYW5nZXM/DQo+Pj4gSW5k
ZWVkLCBmb3Igc29tZSBvZiB0aG9zZSBwYXRjaGVzLCB0aGUgY2hhbmdlIGlzIGEgc2luZ2xl
IGxpbmUgY29tbWl0IG1lc3NhZ2UuDQo+Pg0KPj4gSSBqdXN0IHNlZSBhIGNvbW1pdCB0aXRs
ZSBhbmQgdGhlIFNpZ25lZC1vZmYtYnkuIEZvciBleGFtcGxlLCBpbiA4LzkNCj4+IEkgc2Vl
IHRoZSBmb2xsb3dpbmcgb24gZ2l0IGxvZzoNCj4+DQo+PiBjb21taXQgZjUxODg5OGFhMDli
NDJlMzE3Yjg4NzIzN2JiNzVhNDMyYjQ3N2M2ZA0KPj4gQXV0aG9yOiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+PiBEYXRlOsKgwqAgVGh1IE1h
eSAyIDExOjA4OjQ2IDIwMjQgLTA3MDANCj4+DQo+PiAgIMKgwqDCoCBwbHVnaW5zOiBleHRy
YWN0IGNwdV9pbmRleCBnZW5lcmF0ZQ0KPj4gICDCoMKgwqAgUmV2aWV3ZWQtYnk6IFJpY2hh
cmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPj4gICDCoMKg
wqAgU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBs
aW5hcm8ub3JnPg0KPj4NCj4+IEl0IGhhcyBvbmx5IHRoZSB0aXRsZTogInBsdWdpbnM6IGV4
dHJhY3QgY3B1X2luZGV4IGdlbmVyYXRlIg0KPj4gYW5kIFItYiBhbmQgUy1iLCBzbyBubyBk
ZXNjcmlwdGlvbiBhYm91dCB0aGUgY2hhbmdlcy4NCj4gDQo+IFRoZSBkZXNjcmlwdGlvbiAo
dGhlIGJvZHkgb2YgdGhlIGNvbW1pdCBtZXNzYWdlKSBpcyBtZW50aW9uZWQgaGVyZToNCj4g
DQo+IGh0dHBzOi8vd3d3LnFlbXUub3JnL2RvY3MvbWFzdGVyL2RldmVsL3N1Ym1pdHRpbmct
YS1wYXRjaC5odG1sI3dyaXRlLWEtbWVhbmluZ2Z1bC1jb21taXQtbWVzc2FnZQ0KPiANCj4g
QWZ0ZXIgcXVpY2tseSBsb29raW5nIGF0IHRoZSBjb21taXR0ZWQgbG9ncywgSSBkbyBub3Rp
Y2Ugc29tZSBjb21taXRzIG1pc3NpbmcgaXQsDQo+IGJ1dCBJIHJlYWxseSBiZWxpZXZlIGl0
J3MgaW1wb3J0YW50IHRvIGhhdmUgaXQgZm9yIHRoZSByZWFzb25zIG91dGxpbmVkIGluIHRo
ZXNlDQo+IGd1aWRlbGluZXMuDQo+IA0KDQpZb3UncmUgcmlnaHQsIEkganVzdCBzZW50IGEg
djYgd2l0aCBtb3JlIGVsYWJvcmF0ZWQgY29tbWl0IG1lc3NhZ2VzLg0KDQpUaGFua3MsDQpQ
aWVycmljaw0KDQo+IA0KPiBDaGVlcnMsDQo+IEd1c3Rhdm8NCg==

