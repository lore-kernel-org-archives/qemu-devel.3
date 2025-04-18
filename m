Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB372C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 17:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5pSj-00087s-LH; Fri, 18 Apr 2025 13:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pSd-00085U-IC
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:25:07 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5pSa-0007nu-8w
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 13:25:06 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-22c33e4fdb8so23177465ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 10:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744997103; x=1745601903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zLliFcwA9VSLrvOE5uPTbFkoOGS9VbPodshOtSJMIm8=;
 b=DI0VT2EvPk+wm347hrIXfnnCpUy/qvFu/S64kuOTKYvaEnodPF+xl55H67Kznftzvs
 95x1rDlkS4MD/5H/+pUF0AelueDGcGkl+9takmN7XxaU3k07jVSfVYyZhjCj8q4Ry3pk
 NBLOMbGnW4rSZCD6TzzV1w4tWiKJK8fUoGq+eoybXTBE5PtApGuLAg/z/eOuZ9fdAsF/
 MSi2jMnCEaOwKbtMdNUUesE6Tx6g9lqEEQ860i+vPloXFPYNySLQgUHgAiTcnkmGUd85
 hMMQoN2wKK1DeeaGb/cQAIPAVTQ+IcWHCJN6mQ4sXoufrOJ80EuvQh0hI6mXUZeHATCF
 ok6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744997103; x=1745601903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zLliFcwA9VSLrvOE5uPTbFkoOGS9VbPodshOtSJMIm8=;
 b=EcxzabCdh6BhltiDNqEmuT1+0J/yQLvfJb26PAWDdiIIAahfz4Lca5tL3FYX6mW6ej
 6+FU+7BiRUoYca5k5QPksIy7Qxdx0rJ72ShiY2LGzJwHMnij7wEi/kiANNoKCNrnTVrj
 SJWN7ZMQGK4FEeXsMFAuQ3Xu30Bes5ZMi0DUxdMuSCCkmNdaK9zAJaHuicpMGsppVsxa
 fV6r9qb+0owaVbhrT2MLi2ZGEGG7fonjDF8op/+n9nLuvwzN5X5ERZ6xMdz/avzKL5re
 eiTfQJrDDcQ9ceG8Gu8WfFIu+XtnhaLw5o80E5pgwrTxRXZ2R9NdjWSBNHhQxvDeYX+K
 Hazg==
X-Gm-Message-State: AOJu0YzRa/pzpTCf8idRX9o0skl00mbLkfj6qd/4RqVncqDt/cbIuHIK
 lqXGP9V2G7+matv54fwz5EEsmYUP0vBNfy/7FD10/vkcKcK1G38HiTJLskz4a8s=
X-Gm-Gg: ASbGncvlynzshzsJicB5uwCdQk+HY5X5LfnJY2TB0OEivPR1G6k4ijjG4fmnSR6BzTc
 1mB7iTVWsHHg+tYBr8Rs2sv8FOEfmW5vD9hHJ0oT+47KVmUvQyRF2GiSGuoJxjnLvV6CR2I6iYz
 uVVHwJVOM14qBZD1PeCMOXDhYjZtfyhLCGy7W+izwdCaVEV4dpwTufXa+erFJjRY0x9nkBPFR7Q
 VBCdMW63k26OSNDaB+btkPaESnE4awOeYlBWmiwtRLgPoXXU41BnzrFa6vqyTS0of3A7CPMG0s3
 Py//gq22mpJh5A+k13IXIy1J5rfxy97b0VXM4CDWO17valNrj0u2BQ==
X-Google-Smtp-Source: AGHT+IGwzIkoMroxRSOfF6drgT1j4fB5t5AhL167nJ3JiTFV9O98GckVsXOsJn594kn5GWe0AEeGHg==
X-Received: by 2002:a17:903:1cf:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-22c53611146mr52212765ad.35.1744997102869; 
 Fri, 18 Apr 2025 10:25:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ecec0esm19274625ad.163.2025.04.18.10.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 10:25:02 -0700 (PDT)
Message-ID: <a0d9ed9a-7b97-43a5-a380-0bb607163661@linaro.org>
Date: Fri, 18 Apr 2025 10:25:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] hw/arm: Define machines as generic QOM types
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Felipe Balbi
 <balbi@kernel.org>, Bernhard Beschow <shentey@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Jan Kiszka <jan.kiszka@web.de>, Alistair Francis <alistair@alistair23.me>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Maydell
 <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250417235814.98677-1-philmd@linaro.org>
 <a302fb91-e2d8-ef36-ac53-5e460476c2d0@eik.bme.hu>
 <25a82a76-cd63-4a42-bb68-5dcf826bd948@linaro.org>
 <26c2b844-dc96-448e-8978-e536ed1e61f6@linaro.org>
 <35ae8633-4195-446b-9a22-0c131b9cab88@linaro.org>
 <ee3c9b11-4c4e-41c7-8029-7e5c153215d7@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ee3c9b11-4c4e-41c7-8029-7e5c153215d7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gNC8xOC8yNSAxMDowNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDE4LzQvMjUgMTk6MDMsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzE4LzI1
IDA5OjU5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBPbiAxOC80LzI1
IDE4OjMzLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBPbiA0LzE4LzI1IDAxOjUz
LCBCQUxBVE9OIFpvbHRhbiB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgMTggQXByIDIwMjUsIFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4+Pj4+IFdoaWxlIERFRklORV9NQUNI
SU5FKCkgaXMgYSBzdWNjaW5jdCBtYWNybywgaXQgZG9lc24ndA0KPj4+Pj4+IGFsbG93IHJl
Z2lzdGVyaW5nIFFPTSBpbnRlcmZhY2VzIHRvIHRoZSBkZWZpbmVkIG1hY2hpbmUuDQo+Pj4+
Pj4gQ29udmVydCB0byB0aGUgZ2VuZXJpYyBERUZJTkVfVFlQRVMoKSBpbiBwcmVwYXJhdGlv
biB0bw0KPj4+Pj4+IHJlZ2lzdGVyIGludGVyZmFjZXMuDQo+Pj4+Pj4NCj4+Pj4+PiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSAoMTEpOg0KPj4+Pj4+ICDCoMKgIGh3L2NvcmUvbnVsbC1t
YWNoaW5lOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+Pj4gIMKg
wqAgaHcvYXJtL2JhbmFuYXBpOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBl
DQo+Pj4+Pj4gIMKgwqAgaHcvYXJtL2N1YmllYm9hcmQ6IERlZmluZSBtYWNoaW5lIGFzIGdl
bmVyaWMgUU9NIHR5cGUNCj4+Pj4+PiAgwqDCoCBody9hcm0vZGlnaWM6IERlZmluZSBtYWNo
aW5lIGFzIGdlbmVyaWMgUU9NIHR5cGUNCj4+Pj4+PiAgwqDCoCBody9hcm0vaW14OiBEZWZp
bmUgbWFjaGluZXMgYXMgZ2VuZXJpYyBRT00gdHlwZXMNCj4+Pj4+PiAgwqDCoCBody9hcm0v
aW50ZWdyYXRvcmNwOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+
Pj4gIMKgwqAgaHcvYXJtL2t6bTogRGVmaW5lIG1hY2hpbmUgYXMgZ2VuZXJpYyBRT00gdHlw
ZQ0KPj4+Pj4+ICDCoMKgIGh3L2FybS9tc2YyOiBEZWZpbmUgbWFjaGluZSBhcyBnZW5lcmlj
IFFPTSB0eXBlDQo+Pj4+Pj4gIMKgwqAgaHcvYXJtL211c2ljcGFsOiBEZWZpbmUgbWFjaGlu
ZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+Pj4gIMKgwqAgaHcvYXJtL29yYW5nZXBpOiBE
ZWZpbmUgbWFjaGluZSBhcyBnZW5lcmljIFFPTSB0eXBlDQo+Pj4+Pj4gIMKgwqAgaHcvYXJt
L3N0bTMyOiBEZWZpbmUgbWFjaGluZXMgYXMgZ2VuZXJpYyBRT00gdHlwZXMNCj4+Pj4+Pg0K
Pj4+Pj4+IGh3L2FybS9iYW5hbmFwaV9tMnUuY8KgwqDCoMKgwqAgfCAxMyArKysrKysrKysr
Ky0tDQo+Pj4+Pj4gaHcvYXJtL2N1YmllYm9hcmQuY8KgwqDCoMKgwqDCoMKgIHwgMTMgKysr
KysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9kaWdpY19ib2FyZHMuY8KgwqDCoMKgwqAgfCAx
NCArKysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9pbXgyNV9wZGsuY8KgwqDCoMKgwqDC
oMKgwqAgfCAxNCArKysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9pbXg4bXAtZXZrLmPC
oMKgwqDCoMKgwqDCoCB8IDE1ICsrKysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9pbnRl
Z3JhdG9yY3AuY8KgwqDCoMKgwqAgfCAxNiArKysrKysrKysrKysrLS0tDQo+Pj4+Pj4gaHcv
YXJtL2t6bS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE0ICsrKysrKysrKysr
Ky0tDQo+Pj4+Pj4gaHcvYXJtL21jaW14NnVsLWV2ay5jwqDCoMKgwqDCoCB8IDE1ICsrKysr
KysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9tY2lteDdkLXNhYnJlLmPCoMKgwqDCoCB8IDE1
ICsrKysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9tc2YyLXNvbS5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9tdXNpY3BhbC5jwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMTYgKysrKysrKysrKysrKy0tLQ0KPj4+Pj4+IGh3L2FybS9u
ZXRkdWlubzIuY8KgwqDCoMKgwqDCoMKgwqAgfCAxMyArKysrKysrKysrKy0tDQo+Pj4+Pj4g
aHcvYXJtL25ldGR1aW5vcGx1czIuY8KgwqDCoMKgIHwgMTMgKysrKysrKysrKystLQ0KPj4+
Pj4+IGh3L2FybS9vbGltZXgtc3RtMzItaDQwNS5jIHwgMTMgKysrKysrKysrKystLQ0KPj4+
Pj4+IGh3L2FybS9vcmFuZ2VwaS5jwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTMgKysrKysrKysr
KystLQ0KPj4+Pj4+IGh3L2FybS9zYWJyZWxpdGUuY8KgwqDCoMKgwqDCoMKgwqAgfCAxNCAr
KysrKysrKysrKystLQ0KPj4+Pj4+IGh3L2FybS9zdG0zMnZsZGlzY292ZXJ5LmPCoCB8IDEz
ICsrKysrKysrKysrLS0NCj4+Pj4+PiBody9jb3JlL251bGwtbWFjaGluZS5jwqDCoMKgwqAg
fCAxNCArKysrKysrKysrKystLQ0KPj4+Pj4+IDE4IGZpbGVzIGNoYW5nZWQsIDIxMyBpbnNl
cnRpb25zKCspLCAzOCBkZWxldGlvbnMoLSkNCj4+Pj4+DQo+Pj4+PiBUaGlzIGlzIG11Y2gg
bG9uZ2VyIGFuZCBleHBvc2luZyBib2lsZXIgcGxhdGUgY29kZS4gSXMgaXQgcG9zc2libGUN
Cj4+Pj4+IGluc3RlYWQNCj4+Pj4+IHRvIGNoYW5nZSBERUZJTkVfTUFDSElORSBvciBhZGQg
YW5vdGhlciBzaW1pbGFyIG1hY3JvIHRoYXQgYWxsb3dzDQo+Pj4+PiBzcGVjaWZ5aW5nIG1v
cmUgZGV0YWlscyBzdWNoIGFzIGNsYXNzIHN0YXRlIHR5cGUgYW5kIGludGVyZmFjZXMgbGlr
ZSB3ZQ0KPj4+Pj4gYWxyZWFkeSBoYXZlIGZvciBPQkpFQ1RfREVGSU5FIG1hY3JvcyB0byBr
ZWVwIHRoZSBib2lsZXIgcGxhdGUgY29kZQ0KPj4+Pj4gaGlkZGVuDQo+Pj4+PiBhbmQgbm90
IGJyaW5nIGl0IGJhY2s/DQo+Pj4+Pg0KPj4+Pg0KPj4+PiBXZSBjYW4gZXZlbnR1YWxseSBt
b2RpZnkgREVGSU5FX01BQ0hJTkVTLCB0byB0YWtlIGFuIGFkZGl0aW9uYWwNCj4+Pj4gaW50
ZXJmYWNlcyBwYXJhbWV0ZXIsIGFuZCByZXBsYWNlIGFsbCBjYWxsIHNpdGVzLCB3aXRoIGFu
IGVtcHR5IGxpc3QgZm9yDQo+Pj4+IGFsbCBib2FyZHMgb3V0IG9mIGh3L2FybS4NCj4+Pj4N
Cj4+Pj4gQXMgbG9uZyBhcyB3ZSBhdm9pZCBzb21ldGhpbmcgbGlrZToNCj4+Pj4gREVGSU5F
X01BQ0hJTkVTX1dJVEhfSU5URVJGQUNFXzEoLi4uKQ0KPj4+PiBERUZJTkVfTUFDSElORVNf
V0lUSF9JTlRFUkZBQ0VfMiguLi4pDQo+Pj4+IERFRklORV9NQUNISU5FU19XSVRIX0lOVEVS
RkFDRV8zKC4uLikNCj4+Pj4gSSdtIG9rIHdpdGgga2VlcGluZyB0aGUgbWFjcm8uDQo+Pj4+
DQo+Pj4+IFdvdWxkIHRoYXQgd29yayBmb3IgeW91IGZvbGtzPw0KPj4+DQo+Pj4gQnV0IHRo
ZW4gd2UnbGwgd2FudCBERUZJTkVfUFBDMzJfTUFDSElORSgpIC0+DQo+Pj4gREVGSU5FX01B
Q0hJTkVTX1dJVEhfSU5URVJGQUNFXzEoKSBldGMuLi4NCj4+Pg0KPj4NCj4+IFdlIGNhbiBz
ZWUgdGhhdCBsYXRlciB3aGVuIHRvdWNoaW5nIG90aGVyIHRhcmdldHMuIEZvciBub3csDQo+
PiBERUZJTkVfTUFDSElORSBpcyBub3QgdXNlZCBpbiBhIGxvdCBvZiBwbGFjZXMsIHNvIHJl
cGxhY2luZyBjYWxsIHNpdGVzDQo+PiBzaG91bGQgYmUgZWFzeSwgYW5kIGl0IHdpbGwgY292
ZXIgaHcvYXJtLCB3aGljaCBpcyBvdXIgcG9pbnQgb2YgaW50ZXJlc3QNCj4+IG5vdy4NCj4g
DQo+IEkgY29uY3VyIGFuZCBzaGFyZSB0aGUgc2FtZSBnb2FsLCBidXQgaGVyZSBab2x0YW4g
aXMgY29uY2VybmVkIGFib3V0DQo+IGNvbnZlcnRpbmcgREVGSU5FX01BQ0hJTkUgdG8gREVG
SU5FX1RZUEVTIGFkZHMgMTIgbGluZXMgb2YgYm9pbGVycGxhdGUNCj4gY29kZS4NCg0KSWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSwgWm9sdGFuIGlzc3VlIGlzIHRoYXQgd2UgcmVtb3Zl
IHVzYWdlIG9mIA0KREVGSU5FX01BQ0hJTkUsIGFuZCBwdXQgYm9pbGVycGxhdGUgZm9yIHR5
cGUgZGVmaW5pdGlvbiBpbnN0ZWFkLg0KU28gaGlkaW5nIGJvaWxlcnBsYXRlIGJlaGluZCB0
aGUgbWFjcm8gd291bGQgYmUgb2ssIHRodXMgbXkgcHJvcG9zYWwuDQoNClpvbHRhbiwgY291
bGQgeW91IHBsZWFzZSBjb25maXJtIGluIHdoaWNoIHdheSB5b3Ugd2VyZSBxdWFsaWZ5aW5n
IHRoaXMgDQphcyBib2lsZXJwbGF0ZT8NCg0KVGhhbmtzLA0KUGllcnJpY2sNCg==

