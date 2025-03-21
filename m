Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E765BC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 17:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvg9J-0003CS-1k; Fri, 21 Mar 2025 13:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvg9H-0003C2-KU
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:27:11 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvg9E-0006ba-90
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 13:27:10 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225477548e1so44194085ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 10:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742578026; x=1743182826; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o6I8nyQ9gqpWyx44GJvrBO4kg+s2Z+LLTtP7XWhvVXc=;
 b=GzTJiR/qoHDav59DoYq6BFS5dQAGUkfpaD422Buwnph3nbrO9P/HwYun5NQ9q4lH9j
 Wkl9Rek0PQI+cUn9pcoeptFDRAooI/2X6EWi63w8RWJEEvyYkohPngwCJ2z3LFnUBjYE
 FeP0IGqhXk9oWQK70JoGx48fXwd+WQNdE2E74Xg88vqlDfaLIm98JrlBoCSvOqq/uS+j
 zRV9ScpNukGrNeV8rpJIbvbz1zUjUyABxBDeZ1iW+eHnxTjgpOtcy/bhrLL4wZgvIFXI
 QffsBd73CNPi/QZnfiaXSBl4iVkGr9HOWkGIEVLE5uWyk9ebRJMTlHlYAP196O+uUiOy
 17Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742578026; x=1743182826;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o6I8nyQ9gqpWyx44GJvrBO4kg+s2Z+LLTtP7XWhvVXc=;
 b=I4x9GGbAhOqb6jzN8BBBr7A6v1y/fyvIQsjvk6vplmOsMCBrpCdn151ZEs/oQz0hbU
 3MjJsToHYGgOaRZ8Cas0IqNE/OM0vAVX6r5UhkSEexqxNPYEJpAfmuVb5TRZdib+MYVe
 yeuyrmAGAp2Ce0I9qFxh4kI8w3yOUkJ8F1544UjKScAJKJFq8aet77MY+BCnzgAaBe0Y
 0TIEUajMebMGM8vGyaxte7qhoTCpGepJ+qHTTuX9NVNarRZ4r81ZihotHYIi2bplvQNm
 haWMjL2PrPMtNuERrH/10iO5ay0nzd+Yij9/IGYBgpuUWGFldslBz7W/PqsVMg/Milah
 endg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYfVVPfH0+5j0nEW2yswY8gMHNtklYOy/TruTVQRm8W1vDtk+CO6hTuUn0VMK00t9rh5dLNLekLw/H@nongnu.org
X-Gm-Message-State: AOJu0Yzn/lgrJ8bEp/W3BbIUA7Jazhem73pYxxx735/EUzkNbYWbT1kl
 QDK6MiHKSfb5rKHh6pamtvhgmbrf79Wm+fK71p4LhsTs/P058wgzVjOq7/8Z/Lg=
X-Gm-Gg: ASbGncveQUM3JzFvnnYwreQ61vMKme1tc20zxbVkyFtLxZTIst3IYbvLgyAynAcBLKE
 AktoM5Yj9yqN15/By4EyInkbG+c6OpmJX86YDWYtVrY9WXLrGoOp1gQGxXLvj0XujVIvd2hPxL1
 Z1l77Quh+wg7KBPw79EkypHuggF4plL2eAru2eBtzr44yUw/+I/7hReAp/G8E9wGRLYUSbaVZSE
 BV+Rfsd1qxCYAimWlLfonATSZt6HcONXbPBBCx+qqh2iGiurGAsh6HS4t53tLWs9NKmZWD/CVdv
 WAgE2Idf9m9CQ2mUiWHT+pjeQ8Kdq1TQ9IlJt1CC1Z2ALDupkFrTtujxuSs=
X-Google-Smtp-Source: AGHT+IEXi1KfiVBZOqIRAbtHwX7MVtyEsaTSGgdYWyfqQi8F0DMmOf4evIlQ/lofZMY+CjZ7fEPddA==
X-Received: by 2002:a05:6a00:ac8:b0:736:4ebd:e5a with SMTP id
 d2e1a72fcca58-73905a63bd5mr7527830b3a.20.1742578026384; 
 Fri, 21 Mar 2025 10:27:06 -0700 (PDT)
Received: from [172.16.224.217] ([209.53.90.26])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7390611d21dsm2219619b3a.118.2025.03.21.10.27.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 10:27:05 -0700 (PDT)
Message-ID: <1b4ab8fa-c106-4161-ab25-39589a495564@linaro.org>
Date: Fri, 21 Mar 2025 10:27:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] gdbstub: conversion to runtime endianess helpers
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, qemu-arm@nongnu.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <0bc36324-4fb7-41ee-a9f1-3a7de4ad7fa4@linaro.org>
 <7444c007-d8f1-4c55-ab4a-15becdf1c932@linaro.org>
 <fd9ecec4-cfa9-4605-aa14-264284f6afb6@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <fd9ecec4-cfa9-4605-aa14-264284f6afb6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gMy8yMS8yNSAwNjowMiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDIwLzMvMjUgMjE6MTYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzIwLzI1
IDEyOjUyLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDMvMTkvMjUgMTE6MjIs
IEFsZXggQmVubsOpZSB3cm90ZToNCj4+Pj4gVGhlIGFpbSBvZiB0aGlzIHdvcmsgaXMgdG8g
Z2V0IHJpZCBvZiB0aGUgZW5kaWFuIGF3YXJlIGhlbHBlcnMgaW4NCj4+Pj4gZ2Ric3R1Yi9o
ZWxwZXJzLmggd2hpY2ggZHVlIHRvIHRoZWlyIHVzZSBvZiB0c3dhcCgpIG1lYW4gdGFyZ2V0
DQo+Pj4+IGdkYnN0dWJzIG5lZWQgdG8gYmUgYnVpbHQgbXVsdGlwbGUgdGltZXMuIFdoaWxl
IHRoaXMgc2VyaWVzIGRvZXNuJ3QNCj4+Pj4gYWN0dWFsbHkgYnVpbGQgZWFjaCBzdHViIG9u
Y2UgaXQgaW50cm9kdWNlcyBhIG5ldyBoZWxwZXIgLQ0KPj4+PiBnZGJfZ2V0X3JlZ2lzdGVy
X3ZhbHVlKCkgd2hpY2ggdGFrZXMgYSBNZW1PcCB3aGljaCBjYW4gZGVzY3JpYmUgdGhlDQo+
Pj4+IGN1cnJlbnQgZW5kaWFuIHN0YXRlIG9mIHRoZSBzeXN0ZW0uIFRoaXMgd2lsbCBiZSBh
IGxvdCBlYXNpZXIgdG8NCj4+Pj4gZHluYW1pY2FsbHkgZmVlZCBmcm9tIGEgaGVscGVyIGZ1
bmN0aW9uLg0KPj4+Pg0KPj4+PiBUaGUgbW9zdCBjb21wbGV4IGV4YW1wbGUgaXMgUFBDIHdo
aWNoIGhhcyBhIGhlbHBlciBjYWxsZWQNCj4+Pj4gcHBjX21heWJlX2Jzd2FwX3JlZ2lzdGVy
KCkgd2hpY2ggd2FzIGRvaW5nIHRoaXMuDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgc3RpbGwgYW4g
UkZDIHNvIEknbSBpbnRlcmVzdGVkIGluIGZlZWRiYWNrOg0KPj4+Pg0KPj4+PiAgwqDCoMKg
IC0gaXMgdGhlIEFQSSBzYW5lDQo+Pj4+ICDCoMKgwqAgLSBjYW4gd2UgYXZvaWQgbG90cyBv
ZiAodWludDhfdCAqKSBjYXN0aW5nPw0KPj4+DQo+Pj4gRXZlbiB0aG91Z2ggdGhlIHNlcmll
cyBoYXMgYSBnb29kIGludGVudCwgdGhlIGZhY3Qgd2UgbWFrZSBldmVyeXRoaW5nDQo+Pj4g
ImdlbmVyaWMiIG1ha2VzIHRoYXQgd2UgbG9zZSBhbGwgZ3VhcmFudGVlcyB3ZSBjb3VsZCBn
ZXQgYnkgcmVseWluZyBvbg0KPj4+IHN0YXRpYyB0eXBpbmcsIGFuZCB0aGF0IHdlIGhhZCBw
b3NzaWJpbGl0eSBvZiBtaXN0YWtlcyB3aGVuIHBhc3Npbmcgc2l6ZQ0KPj4+ICh3aGljaCBo
YXBwZW5lZCBpbiBwYXRjaCA0IGlmIEknbSBjb3JyZWN0KS4gQW5kIGV4cGxpY2l0IGNhc3Rp
bmcgY29tZXMNCj4+PiBhcyBhICpzdHJvbmcqIHdhcm5pbmcgYWJvdXQgdGhhdC4NCj4+Pg0K
Pj4+IEJ5IHBhdGNoIDcsIEkgd2FzIHJlYWxseSBmZWVsaW5nIGl0J3Mgbm90IGEgd2luIHZz
IGV4cGxpY2l0IGZ1bmN0aW9ucw0KPj4+IHBlciBzaXplLg0KPj4+DQo+Pj4gSWYgdGhlIGdv
YWwgb2YgdGhlIHNlcmllcyBpcyB0byBnZXQgcmlkIG9mIGVuZGlhbiBhd2FyZSBoZWxwZXJz
LCB3ZWxsLA0KPj4+IHRoaXMgY2FuIGJlIGZpeGVkIGluIHRoZSBoZWxwZXJzIHRoZW1zZWx2
ZXMsIHdpdGhvdXQgbmVlZGluZyB0bw0KPj4+IGludHJvZHVjZSBhICJnZW5lcmljIiBzaXpl
IGhlbHBlci4gTWF5YmUgd2UgYXJlIHRyeWluZyB0byBzb2x2ZSB0d28NCj4+PiBkaWZmZXJl
bnQgcHJvYmxlbXMgaGVyZT8NCj4+Pg0KPj4+PiAgwqDCoMKgIC0gc2hvdWxkIHdlIGhhdmUg
YSByZXZlcnNlIGhlbHBlciBmb3Igc2V0dGluZyByZWdpc3RlcnMNCj4+Pj4NCj4+Pj4gSWYg
dGhpcyBzZWVtcyBsaWtlIHRoZSByaWdodCBhcHByb2FjaCBJIGNhbiBoYXZlIGEgZ28gYXQg
bW9yZSBvZiB0aGUNCj4+Pj4gZnJvbnRlbmRzIGxhdGVyLg0KPj4+Pg0KPj4NCj4+IExvb2tp
bmcgYXQgaW5jbHVkZS9nZGJzdHViL2hlbHBlcnMuaCwgZ2RiX2dldF9yZWcxMjggY2FuIGJl
IHNvbHZlZCBieQ0KPj4gdXNpbmcgdGFyZ2V0X3dvcmRzX2JpZ2VuZGlhbigpIGluc3RlYWQg
b2YgVEFSR0VUX0JJR19FTkRJQU4sIHdoaWNoIGlzDQo+PiBhbHJlYWR5IHdoYXQgdHN3YXAg
cHJpbWl0aXZlcyBhcmUgZG9pbmcuDQo+IA0KPiBXZSdsbCBuZWVkIHRvIGV2ZW50dWFsbHkg
cmVtb3ZlIHRhcmdldF93b3Jkc19iaWdlbmRpYW4oKSwgc28gdGhhdCdkIGp1c3QNCj4gYmUg
cG9zdHBvbmluZyB0aGF0Lg0KPiANCg0KSXQgc2VlbWVkIHRvIG1lIHRoYXQgb25lIG9mIHRo
ZSBnb2FsIG9mIGN1cnJlbnQgc2hhcmVkIHdvcmsgb24gc2luZ2xlIA0KYmluYXJ5IGlzIHRv
IGJlIGFibGUgdG8gY2hlY2sgdGhvc2Uga2luZCBvZiB0aGluZ3MgYXQgcnVudGltZS4gU28g
SSANCmRvbid0IHNlZSBob3cgd2UgY2FuIHBsYW4gdG8gcmVtb3ZlIHRhcmdldF93b3Jkc19i
aWdlbmRpYW4oKSwgb3IgYW4gDQplcXVpdmFsZW50Lg0KDQpJZiB5b3UgbWVhbiB3ZSdsbCBy
ZXBsYWNlIHRoaXMgY2FsbCB3aXRoIGFub3RoZXIgbmFtZS9hcGksIEkgZG9uJ3Qgc2VlIA0K
aXQgYXMgYSBwcm9ibGVtIHRvIHVzZSBpdCBmb3Igbm93LiBJdCdzIHVwc3RyZWFtIGFuZCB3
b3Jrcy4NCg==

