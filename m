Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CBC7D637DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:14:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRF1-00036S-Df; Wed, 13 Nov 2024 23:14:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBREt-0002vI-EW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:52 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBREr-0003yl-No
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:13:51 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20c9978a221so1540695ad.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557628; x=1732162428; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wPP6b3sPI2k6/U3XzNPA80vBqsJNCfFk9v6LNhDhx1s=;
 b=saI5FI9jhG5UJihZ7ndCz2/NikOSdUj0dzcDJx8Mqb8i2exshj19udYsTrQOBrsb6t
 uoJ8cTZmlIu2FM7BZVtqdFYJiZx1yK3ivgcYzpTCDWEgLcsSnL++WQ89YTzersovdsm9
 hmDqrxPnNCjsUYRHHjz2du9Jwm2O6yMVgwUb84imfn80b5BUh/CgvI9ahlYMfA1y7upK
 lsfyT29stnEZL9/Q6U31Y7rX1/0nBaLBRTytEDZxlIJGCgyJShg0NcnSJxl3oyl0cNH8
 /McFO70JxpmHNRH0R+St0L3X5j5qGHpeKRvSJ8LdiVb1ratNPutiVjWtoO1DnvwwxoNl
 2lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557628; x=1732162428;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wPP6b3sPI2k6/U3XzNPA80vBqsJNCfFk9v6LNhDhx1s=;
 b=QRoDOGoUhzAhABmrnB8XipYb5Txuz9QTRjs0lkWCggKdy9dP5TenmKFUvelfXGBsgP
 97vgYAmUfY1RSQ1zubWAkiR2o/yAaQYa84ntIJQAYFuAugFOCumA2ZwGnpQ3EmjS1o/V
 CDC7LYfvkGy0L/ODRJgGALU07o3vrBuUYh/HzKkqJv3wtjy8BDP5cX+ecmXKks8Ugw9w
 YLLNf66U9mImKgVNce0co8PaEN/F+L+W71JrTdCU6Aii+OIlsU1pkHR5hHdALV2l7fiY
 HmBoFfgVSLk/0jePAIQhm3E5ZOhmE+nTDkBRABiWUl67A5uUQ2z+Mf6q9K/HFJlege9C
 nHoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVPqsVx+CP5P6oa4RziXjM6oab9fZ+DhF/YVXiaH+8IA/DZ3UtpFnH/0Ty614vemHvSGc/aJfpmWQu@nongnu.org
X-Gm-Message-State: AOJu0Yzta7nLSDqWdiLjaViq2d0Ko19B5nlJUX4ngut1j3E0VxerzXGr
 KQwRxWByhJPaTcEOdejQieJji2UZApC8B1NCH1ZdQZvmY5ellgKe6a25jGLYzCs=
X-Google-Smtp-Source: AGHT+IEodgKJLRHLHp1GLbFJJuZaXTaGa8EVeIuELBaN9zcmM+UDFe7j0m29Mmq+36NfL+1D6apVkg==
X-Received: by 2002:a17:902:f541:b0:20c:d072:c899 with SMTP id
 d9443c01a7336-21183cea4b2mr310864175ad.24.1731557628444; 
 Wed, 13 Nov 2024 20:13:48 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7ce9776sm1417415ad.121.2024.11.13.20.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:13:48 -0800 (PST)
Message-ID: <04909a60-48b9-46a4-bbb6-6e4fe027b6e8@linaro.org>
Date: Wed, 13 Nov 2024 20:13:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/24] exec: Declare tlb_set_page_with_attrs() in
 'exec/cputlb.h'
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
 <20241114011310.3615-17-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-17-philmd@linaro.org>
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

T24gMTEvMTMvMjQgMTc6MTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBN
b3ZlIENQVSBUTEIgcmVsYXRlZCBtZXRob2RzIHRvICJleGVjL2NwdXRsYi5oIi4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJv
Lm9yZz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9leGVjL2NwdXRsYi5oICAgICAgICAgICAgICAg
IHwgMjggKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvZXhlYy9l
eGVjLWFsbC5oICAgICAgICAgICAgICB8IDI1IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gICB0YXJnZXQvaTM4Ni90Y2cvc3lzZW11L2V4Y3BfaGVscGVyLmMgfCAgMiArLQ0KPiAg
IHRhcmdldC9taWNyb2JsYXplL2hlbHBlci5jICAgICAgICAgICB8ICAyICstDQo+ICAgNCBm
aWxlcyBjaGFuZ2VkLCAzMCBpbnNlcnRpb25zKCspLCAyNyBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2V4ZWMvY3B1dGxiLmggYi9pbmNsdWRlL2V4ZWMvY3B1
dGxiLmgNCj4gaW5kZXggZjYyMDVkNTMwNi4uYWU0Nzk4YTAxNyAxMDA2NDQNCj4gLS0tIGEv
aW5jbHVkZS9leGVjL2NwdXRsYi5oDQo+ICsrKyBiL2luY2x1ZGUvZXhlYy9jcHV0bGIuaA0K
PiBAQCAtMjEsNiArMjEsOCBAQA0KPiAgICNkZWZpbmUgQ1BVVExCX0gNCj4gICANCj4gICAj
aW5jbHVkZSAiZXhlYy9jcHUtY29tbW9uLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9od2FkZHIu
aCINCj4gKyNpbmNsdWRlICJleGVjL21lbWF0dHJzLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMv
dmFkZHIuaCINCj4gICANCj4gICAjaWYgZGVmaW5lZChDT05GSUdfVENHKSAmJiAhZGVmaW5l
ZChDT05GSUdfVVNFUl9PTkxZKQ0KPiBAQCAtODAsNCArODIsMzAgQEAgdm9pZCB0bGJfcmVz
ZXRfZGlydHlfcmFuZ2VfYWxsKHJhbV9hZGRyX3Qgc3RhcnQsIHJhbV9hZGRyX3QgbGVuZ3Ro
KTsNCj4gICB2b2lkIHRsYl9zZXRfcGFnZV9mdWxsKENQVVN0YXRlICpjcHUsIGludCBtbXVf
aWR4LCB2YWRkciBhZGRyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgQ1BVVExCRW50
cnlGdWxsICpmdWxsKTsNCj4gICANCj4gKy8qKg0KPiArICogdGxiX3NldF9wYWdlX3dpdGhf
YXR0cnM6DQo+ICsgKiBAY3B1OiBDUFUgdG8gYWRkIHRoaXMgVExCIGVudHJ5IGZvcg0KPiAr
ICogQGFkZHI6IHZpcnR1YWwgYWRkcmVzcyBvZiBwYWdlIHRvIGFkZCBlbnRyeSBmb3INCj4g
KyAqIEBwYWRkcjogcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgcGFnZQ0KPiArICogQGF0dHJz
OiBtZW1vcnkgdHJhbnNhY3Rpb24gYXR0cmlidXRlcw0KPiArICogQHByb3Q6IGFjY2VzcyBw
ZXJtaXNzaW9ucyAoUEFHRV9SRUFEL1BBR0VfV1JJVEUvUEFHRV9FWEVDIGJpdHMpDQo+ICsg
KiBAbW11X2lkeDogTU1VIGluZGV4IHRvIGluc2VydCBUTEIgZW50cnkgZm9yDQo+ICsgKiBA
c2l6ZTogc2l6ZSBvZiB0aGUgcGFnZSBpbiBieXRlcw0KPiArICoNCj4gKyAqIEFkZCBhbiBl
bnRyeSB0byB0aGlzIENQVSdzIFRMQiAoYSBtYXBwaW5nIGZyb20gdmlydHVhbCBhZGRyZXNz
DQo+ICsgKiBAYWRkciB0byBwaHlzaWNhbCBhZGRyZXNzIEBwYWRkcikgd2l0aCB0aGUgc3Bl
Y2lmaWVkIG1lbW9yeQ0KPiArICogdHJhbnNhY3Rpb24gYXR0cmlidXRlcy4gVGhpcyBpcyBn
ZW5lcmFsbHkgY2FsbGVkIGJ5IHRoZSB0YXJnZXQgQ1BVDQo+ICsgKiBzcGVjaWZpYyBjb2Rl
IGFmdGVyIGl0IGhhcyBiZWVuIGNhbGxlZCB0aHJvdWdoIHRoZSB0bGJfZmlsbCgpDQo+ICsg
KiBlbnRyeSBwb2ludCBhbmQgcGVyZm9ybWVkIGEgc3VjY2Vzc2Z1bCBwYWdlIHRhYmxlIHdh
bGsgdG8gZmluZA0KPiArICogdGhlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIGF0dHJpYnV0ZXMg
Zm9yIHRoZSB2aXJ0dWFsIGFkZHJlc3MNCj4gKyAqIHdoaWNoIHByb3Zva2VkIHRoZSBUTEIg
bWlzcy4NCj4gKyAqDQo+ICsgKiBBdCBtb3N0IG9uZSBlbnRyeSBmb3IgYSBnaXZlbiB2aXJ0
dWFsIGFkZHJlc3MgaXMgcGVybWl0dGVkLiBPbmx5IGENCj4gKyAqIHNpbmdsZSBUQVJHRVRf
UEFHRV9TSVpFIHJlZ2lvbiBpcyBtYXBwZWQ7IHRoZSBzdXBwbGllZCBAc2l6ZSBpcyBvbmx5
DQo+ICsgKiB1c2VkIGJ5IHRsYl9mbHVzaF9wYWdlLg0KPiArICovDQo+ICt2b2lkIHRsYl9z
ZXRfcGFnZV93aXRoX2F0dHJzKENQVVN0YXRlICpjcHUsIHZhZGRyIGFkZHIsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBwYWRkciwgTWVtVHhBdHRycyBhdHRy
cywNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IHByb3QsIGludCBtbXVf
aWR4LCB2YWRkciBzaXplKTsNCj4gKw0KPiAgICNlbmRpZg0KPiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9leGVjL2V4ZWMtYWxsLmggYi9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiBpbmRl
eCA3OTY0OTUzN2IwLi4yYjMxNGQ2NThiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMv
ZXhlYy1hbGwuaA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiBAQCAtMTc0
LDMxICsxNzQsNiBAQCB2b2lkIHRsYl9mbHVzaF9yYW5nZV9ieV9tbXVpZHhfYWxsX2NwdXNf
c3luY2VkKENQVVN0YXRlICpjcHUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50MTZfdCBpZHhtYXAsDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBiaXRzKTsNCj4g
ICANCj4gLS8qKg0KPiAtICogdGxiX3NldF9wYWdlX3dpdGhfYXR0cnM6DQo+IC0gKiBAY3B1
OiBDUFUgdG8gYWRkIHRoaXMgVExCIGVudHJ5IGZvcg0KPiAtICogQGFkZHI6IHZpcnR1YWwg
YWRkcmVzcyBvZiBwYWdlIHRvIGFkZCBlbnRyeSBmb3INCj4gLSAqIEBwYWRkcjogcGh5c2lj
YWwgYWRkcmVzcyBvZiB0aGUgcGFnZQ0KPiAtICogQGF0dHJzOiBtZW1vcnkgdHJhbnNhY3Rp
b24gYXR0cmlidXRlcw0KPiAtICogQHByb3Q6IGFjY2VzcyBwZXJtaXNzaW9ucyAoUEFHRV9S
RUFEL1BBR0VfV1JJVEUvUEFHRV9FWEVDIGJpdHMpDQo+IC0gKiBAbW11X2lkeDogTU1VIGlu
ZGV4IHRvIGluc2VydCBUTEIgZW50cnkgZm9yDQo+IC0gKiBAc2l6ZTogc2l6ZSBvZiB0aGUg
cGFnZSBpbiBieXRlcw0KPiAtICoNCj4gLSAqIEFkZCBhbiBlbnRyeSB0byB0aGlzIENQVSdz
IFRMQiAoYSBtYXBwaW5nIGZyb20gdmlydHVhbCBhZGRyZXNzDQo+IC0gKiBAYWRkciB0byBw
aHlzaWNhbCBhZGRyZXNzIEBwYWRkcikgd2l0aCB0aGUgc3BlY2lmaWVkIG1lbW9yeQ0KPiAt
ICogdHJhbnNhY3Rpb24gYXR0cmlidXRlcy4gVGhpcyBpcyBnZW5lcmFsbHkgY2FsbGVkIGJ5
IHRoZSB0YXJnZXQgQ1BVDQo+IC0gKiBzcGVjaWZpYyBjb2RlIGFmdGVyIGl0IGhhcyBiZWVu
IGNhbGxlZCB0aHJvdWdoIHRoZSB0bGJfZmlsbCgpDQo+IC0gKiBlbnRyeSBwb2ludCBhbmQg
cGVyZm9ybWVkIGEgc3VjY2Vzc2Z1bCBwYWdlIHRhYmxlIHdhbGsgdG8gZmluZA0KPiAtICog
dGhlIHBoeXNpY2FsIGFkZHJlc3MgYW5kIGF0dHJpYnV0ZXMgZm9yIHRoZSB2aXJ0dWFsIGFk
ZHJlc3MNCj4gLSAqIHdoaWNoIHByb3Zva2VkIHRoZSBUTEIgbWlzcy4NCj4gLSAqDQo+IC0g
KiBBdCBtb3N0IG9uZSBlbnRyeSBmb3IgYSBnaXZlbiB2aXJ0dWFsIGFkZHJlc3MgaXMgcGVy
bWl0dGVkLiBPbmx5IGENCj4gLSAqIHNpbmdsZSBUQVJHRVRfUEFHRV9TSVpFIHJlZ2lvbiBp
cyBtYXBwZWQ7IHRoZSBzdXBwbGllZCBAc2l6ZSBpcyBvbmx5DQo+IC0gKiB1c2VkIGJ5IHRs
Yl9mbHVzaF9wYWdlLg0KPiAtICovDQo+IC12b2lkIHRsYl9zZXRfcGFnZV93aXRoX2F0dHJz
KENQVVN0YXRlICpjcHUsIHZhZGRyIGFkZHIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGh3YWRkciBwYWRkciwgTWVtVHhBdHRycyBhdHRycywNCj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgaW50IHByb3QsIGludCBtbXVfaWR4LCB2YWRkciBzaXplKTsN
Cj4gICAvKiB0bGJfc2V0X3BhZ2U6DQo+ICAgICoNCj4gICAgKiBUaGlzIGZ1bmN0aW9uIGlz
IGVxdWl2YWxlbnQgdG8gY2FsbGluZyB0bGJfc2V0X3BhZ2Vfd2l0aF9hdHRycygpDQo+IGRp
ZmYgLS1naXQgYS90YXJnZXQvaTM4Ni90Y2cvc3lzZW11L2V4Y3BfaGVscGVyLmMgYi90YXJn
ZXQvaTM4Ni90Y2cvc3lzZW11L2V4Y3BfaGVscGVyLmMNCj4gaW5kZXggZGExODdjODc5Mi4u
Y2RhMDE1MmI4MCAxMDA2NDQNCj4gLS0tIGEvdGFyZ2V0L2kzODYvdGNnL3N5c2VtdS9leGNw
X2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9pMzg2L3RjZy9zeXNlbXUvZXhjcF9oZWxwZXIu
Yw0KPiBAQCAtMjAsNyArMjAsNyBAQA0KPiAgICNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+
ICAgI2luY2x1ZGUgImNwdS5oIg0KPiAgICNpbmNsdWRlICJleGVjL2NwdV9sZHN0LmgiDQo+
IC0jaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiArI2luY2x1ZGUgImV4ZWMvY3B1dGxi
LmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvcGFnZS1wcm90ZWN0aW9uLmgiDQo+ICAgI2luY2x1
ZGUgInRjZy9oZWxwZXItdGNnLmgiDQo+ICAgDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvbWlj
cm9ibGF6ZS9oZWxwZXIuYyBiL3RhcmdldC9taWNyb2JsYXplL2hlbHBlci5jDQo+IGluZGV4
IDVkMzI1OWNlMzEuLjI3ZmM5MjliZWUgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taWNyb2Js
YXplL2hlbHBlci5jDQo+ICsrKyBiL3RhcmdldC9taWNyb2JsYXplL2hlbHBlci5jDQo+IEBA
IC0yMCw3ICsyMCw3IEBADQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4g
ICAjaW5jbHVkZSAiY3B1LmgiDQo+IC0jaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiAr
I2luY2x1ZGUgImV4ZWMvY3B1dGxiLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvcGFnZS1wcm90
ZWN0aW9uLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvaG9zdC11dGlscy5oIg0KPiAgICNpbmNs
dWRlICJleGVjL2xvZy5oIg0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGll
cnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

