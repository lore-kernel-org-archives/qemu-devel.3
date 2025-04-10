Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CC1C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 17:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2viF-0002v0-OW; Thu, 10 Apr 2025 13:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2vi8-0002uM-Jh
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 13:29:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u2vi5-0005Nl-MN
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 13:29:08 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7376dd56eccso1256161b3a.0
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 10:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744306144; x=1744910944; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lVK7zEI/NEqvDhlkvkMJWHt7xsoqpIy9D4t/fu7tOqQ=;
 b=ulhPRv25SjoMRhnl5SaIK4l4i+8vXbrPEi0gXxA32sCwYfghFjn5UNFHATl2858Wft
 oYKnfyyQBHKmdDzAiTJxAkEmehTOKjrArygJIkdPzj2qD9vZ3WFBYjOjuNIznct38Tov
 v+Ki50kGQdimX8OwRbsLoGar57i1HixBS2givh8ErMc/SgmHlUqJaod4T3OiQQzQk0ti
 sj25u9hZwjNIbR3bNgAa/fHi4+K+gIM6kvvnZ9wkIWbTQIfgqzStMV+qyqa1f1ilBCmg
 3QWwKFU543MVq2pk42SntRAnikx4bjRdfWA8UI6KUZK2eLcgvD5NaEL905idPufUEGlV
 jyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744306144; x=1744910944;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lVK7zEI/NEqvDhlkvkMJWHt7xsoqpIy9D4t/fu7tOqQ=;
 b=TNHNxHbDn6Y5mJvL8Iy1hankaX616P8intUdr1jX7xVEaNnCNRB2Y9QQnGlIJQGpCx
 j57NEy6wxpdiecWXWzvTMZDbfhqmjuSRF0sNuQWTz639ewSQg+hzG2p4BhlxM8dunyX9
 Y+aKxuMzWf18gYEDpnAFmp5ia2WWHtjgoXJ+F3XiQXjlturdRENKRCjapAL6oAn7QAhS
 cSrsPFOlMrDrDxfDgLTcAP4dtsOXTDQeKUX4LscPvJdDlXu0UJAtFKnaFOi0+WxuNGq4
 /aQUzBRYw7eTaqZ3EDyMePqorsgFBGfisa01yy9IJhFKpF7J4a7YSkfCBQREqDaK4gfk
 tPZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnO/T5djA2RBG3VdshzIPBXuZcX29ghG2YbOByrZWp4hHZ54ImMGVgbXbkg1TCD1ZqCmVMjnAufCXZ@nongnu.org
X-Gm-Message-State: AOJu0Yy6MY3M/0VrEpyxyPZTSpwMLAVTWM5d8lyF6B9ESINElnqY0zXv
 ZlKd4JYhr8XM42wAOLQgCRgmTSquJQrvb7Y3AZDRPZ4K0jrcNB+m4CZYF8PKbEo=
X-Gm-Gg: ASbGncvRxouBN3+xQOv6atKaue+ymyuKu0TPoMdXXvUFLj3NilyPH0OHYQYU/1a22fg
 1eGDJyrYHWw2+n3BuvcIzQffwfu159zMbx+clYEVRY6HKwFEB0N7l16wnrzef3HvMFb8SjgykUl
 85L0cLteEa48hWqVYhRfgDWnJ3je8ENpRaPprVVVKZaTnUgx0SgU4OUB+8t09MqyUkxzz3Dv8QH
 to7FNHRjc7p/6ovyDdviA8QAbNqIR6rSW+ytGTY/NEdAReDA07LxqjVrt/NVW4EG65ZNujvGYDT
 5F4rLjyXpIOcC5pI2bn6uneD5OM61amgck+UPPBtRi5swQtIvEvixw==
X-Google-Smtp-Source: AGHT+IG+b7H+tWVQXjTq03yYaVEnuLNkdom8RgOBVlwgxjTmyyBthNgzp42TUJQCNfZW5hx8t43uTA==
X-Received: by 2002:a05:6a21:3a4b:b0:1f3:2c55:8d8a with SMTP id
 adf61e73a8af0-2016cd1e4c1mr4551534637.12.1744306143773; 
 Thu, 10 Apr 2025 10:29:03 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bb1d50cb7sm3669938b3a.69.2025.04.10.10.29.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Apr 2025 10:29:03 -0700 (PDT)
Message-ID: <2336ff13-f329-46f5-95b6-e847b012328e@linaro.org>
Date: Thu, 10 Apr 2025 10:29:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-8.0 09/10] hw/virtio: Extract
 vhost_user_ram_slots_max() to vhost-user-target.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Hanna Reitz <hreitz@redhat.com>
References: <20221212230517.28872-1-philmd@linaro.org>
 <20221212230517.28872-10-philmd@linaro.org>
 <84b2bcf7-9df7-43e2-83d8-cae9d34ca541@linaro.org>
 <d4ecd6c2-73db-4c28-828c-bfa84ca90084@linaro.org>
 <0edf086b-18f1-4c75-a794-1c957b20bf19@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <0edf086b-18f1-4c75-a794-1c957b20bf19@linaro.org>
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

T24gNC8xMC8yNSAxMDoyMSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEwLzQvMjUgMTY6MzYsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiA0LzEwLzI1
IDA1OjE0LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBIaSBQaWVycmlj
aywNCj4+Pg0KPj4+IE9uIDEzLzEyLzIyIDAwOjA1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSB3cm90ZToNCj4+Pj4gVGhlIGN1cnJlbnQgZGVmaW5pdGlvbiBvZiBWSE9TVF9VU0VSX01B
WF9SQU1fU0xPVFMgaXMNCj4+Pj4gdGFyZ2V0IHNwZWNpZmljLiBCeSBjb252ZXJ0aW5nIHRo
aXMgZGVmaW5pdGlvbiB0byBhIHJ1bnRpbWUNCj4+Pj4gdmhvc3RfdXNlcl9yYW1fc2xvdHNf
bWF4KCkgaGVscGVyIGRlY2xhcmVkIGluIGEgdGFyZ2V0DQo+Pj4+IHNwZWNpZmljIHVuaXQs
IHdlIGNhbiBoYXZlIHRoZSByZXN0IG9mIHZob3N0LXVzZXIuYyB0YXJnZXQNCj4+Pj4gaW5k
ZXBlbmRlbnQuDQo+Pj4+DQo+Pj4+IFRvIGF2b2lkIHZhcmlhYmxlIGxlbmd0aCBhcnJheSBv
ciB1c2luZyB0aGUgaGVhcCB0byBzdG9yZQ0KPj4+PiBhcnJheXMgb2Ygdmhvc3RfdXNlcl9y
YW1fc2xvdHNfbWF4KCkgZWxlbWVudHMsIHdlIHNpbXBseQ0KPj4+PiBkZWNsYXJlIGFuIGFy
cmF5IG9mIHRoZSBiaWdnZXN0IFZIT1NUX1VTRVJfTUFYX1JBTV9TTE9UUywNCj4+Pj4gYW5k
IGVhY2ggdGFyZ2V0IHVzZXMgdXAgdG8gdmhvc3RfdXNlcl9yYW1fc2xvdHNfbWF4KCkNCj4+
Pj4gZWxlbWVudHMgb2YgaXQuIEVuc3VyZSBhcnJheXMgYXJlIGJpZyBlbm91Z2ggYnkgYWRk
aW5nIGFuDQo+Pj4+IGFzc2VydGlvbiBpbiB2aG9zdF91c2VyX2luaXQoKS4NCj4+Pj4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5h
cm8ub3JnPg0KPj4+PiAtLS0NCj4+Pj4gUkZDOiBTaG91bGQgSSBhZGQgVkhPU1RfVVNFUl9N
QVhfUkFNX1NMT1RTIHRvIHZob3N0LXVzZXIuaA0KPj4+PiAgwqDCoMKgwqDCoMKgIG9yIGNy
ZWF0ZSBhbiBpbnRlcm5hbCBoZWFkZXIgZm9yIGl0Pw0KPj4+PiAtLS0NCj4+Pj4gIMKgwqAg
aHcvdmlydGlvL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4+Pj4g
IMKgwqAgaHcvdmlydGlvL3Zob3N0LXVzZXItdGFyZ2V0LmPCoCB8IDI5ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+Pj4+ICDCoMKgIGh3L3ZpcnRpby92aG9zdC11c2VyLmPC
oMKgwqDCoMKgwqDCoMKgIHwgMjYgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+Pj4g
IMKgwqAgaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtdXNlci5oIHzCoCA3ICsrKysrKysNCj4+
Pj4gIMKgwqAgNCBmaWxlcyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAyMSBkZWxldGlv
bnMoLSkNCj4+Pj4gIMKgwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGh3L3ZpcnRpby92aG9zdC11
c2VyLXRhcmdldC5jDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vbWVzb24u
YnVpbGQgYi9ody92aXJ0aW8vbWVzb24uYnVpbGQNCj4+Pj4gaW5kZXggZWI3ZWU4ZWE5Mi4u
YmY3ZTM1ZmE4YSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvdmlydGlvL21lc29uLmJ1aWxkDQo+
Pj4+ICsrKyBiL2h3L3ZpcnRpby9tZXNvbi5idWlsZA0KPj4+PiBAQCAtMTEsNiArMTEsNyBA
QCBpZiBoYXZlX3Zob3N0DQo+Pj4+ICDCoMKgwqDCoCBzcGVjaWZpY192aXJ0aW9fc3MuYWRk
KGZpbGVzKCd2aG9zdC5jJywgJ3Zob3N0LWJhY2tlbmQuYycsDQo+Pj4+ICd2aG9zdC1pb3Zh
LXRyZWUuYycpKQ0KPj4+PiAgwqDCoMKgwqAgaWYgaGF2ZV92aG9zdF91c2VyDQo+Pj4+ICDC
oMKgwqDCoMKgwqAgc3BlY2lmaWNfdmlydGlvX3NzLmFkZChmaWxlcygndmhvc3QtdXNlci5j
JykpDQo+Pj4+ICvCoMKgwqAgc3BlY2lmaWNfdmlydGlvX3NzLmFkZChmaWxlcygndmhvc3Qt
dXNlci10YXJnZXQuYycpKQ0KPj4+PiAgwqDCoMKgwqAgZW5kaWYNCj4+Pj4gIMKgwqDCoMKg
IGlmIGhhdmVfdmhvc3RfdmRwYQ0KPj4+PiAgwqDCoMKgwqDCoMKgIHNwZWNpZmljX3ZpcnRp
b19zcy5hZGQoZmlsZXMoJ3Zob3N0LXZkcGEuYycsICd2aG9zdC1zaGFkb3ctDQo+Pj4+IHZp
cnRxdWV1ZS5jJykpDQo+Pj4+IGRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmhvc3QtdXNlci10
YXJnZXQuYyBiL2h3L3ZpcnRpby92aG9zdC11c2VyLQ0KPj4+PiB0YXJnZXQuYw0KPj4+PiBu
ZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAwMDAwLi42YTBkMGY1M2Qw
DQo+Pj4+IC0tLSAvZGV2L251bGwNCj4+Pj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXVzZXIt
dGFyZ2V0LmMNCj4+Pj4gQEAgLTAsMCArMSwyOSBAQA0KPj4+PiArLyoNCj4+Pj4gKyAqIHZo
b3N0LXVzZXIgdGFyZ2V0LXNwZWNpZmljIGhlbHBlcnMNCj4+Pj4gKyAqDQo+Pj4+ICsgKiBD
b3B5cmlnaHQgKGMpIDIwMTMgVmlydHVhbCBPcGVuIFN5c3RlbXMgU2FybC4NCj4+Pj4gKyAq
DQo+Pj4+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0K
Pj4+PiArICovDQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlICJxZW11L29zZGVwLmgiDQo+Pj4+
ICsjaW5jbHVkZSAiaHcvdmlydGlvL3Zob3N0LXVzZXIuaCINCj4+Pj4gKw0KPj4+PiArI2lm
IGRlZmluZWQoVEFSR0VUX1g4NikgfHwgZGVmaW5lZChUQVJHRVRfWDg2XzY0KSB8fCBcDQo+
Pj4+ICvCoMKgwqAgZGVmaW5lZChUQVJHRVRfQVJNKSB8fCBkZWZpbmVkKFRBUkdFVF9BUk1f
NjQpDQo+Pj4+ICsjaW5jbHVkZSAiaHcvYWNwaS9hY3BpLmgiDQo+Pj4+ICsjZWxpZiBkZWZp
bmVkKFRBUkdFVF9QUEMpIHx8IGRlZmluZWQoVEFSR0VUX1BQQzY0KQ0KPj4+PiArI2luY2x1
ZGUgImh3L3BwYy9zcGFwci5oIg0KPj4+PiArI2VuZGlmDQo+Pj4+ICsNCj4+Pj4gK3Vuc2ln
bmVkIGludCB2aG9zdF91c2VyX3JhbV9zbG90c19tYXgodm9pZCkNCj4+Pj4gK3sNCj4+Pj4g
KyNpZiBkZWZpbmVkKFRBUkdFVF9YODYpIHx8IGRlZmluZWQoVEFSR0VUX1g4Nl82NCkgfHwg
XA0KPj4+PiArwqDCoMKgIGRlZmluZWQoVEFSR0VUX0FSTSkgfHwgZGVmaW5lZChUQVJHRVRf
QVJNXzY0KQ0KPj4+PiArwqDCoMKgIHJldHVybiBBQ1BJX01BWF9SQU1fU0xPVFM7DQo+Pj4+
ICsjZWxpZiBkZWZpbmVkKFRBUkdFVF9QUEMpIHx8IGRlZmluZWQoVEFSR0VUX1BQQzY0KQ0K
Pj4+PiArwqDCoMKgIHJldHVybiBTUEFQUl9NQVhfUkFNX1NMT1RTOw0KPj4+PiArI2Vsc2UN
Cj4+Pj4gK8KgwqDCoCByZXR1cm4gNTEyOw0KPj4+DQo+Pj4gU2hvdWxkIHZob3N0X3VzZXJf
cmFtX3Nsb3RzX21heCBiZSBhbm90aGVyIFRhcmdldEluZm8gZmllbGQ/DQo+Pj4NCj4+DQo+
PiBJIGRvbid0IHRoaW5rIHNvLCBpdCB3b3VsZCBiZSBiZXR0ZXIgdG8gdHJhbnNmb3JtIHRo
ZSBleGlzdGluZyBmdW5jdGlvbg0KPj4gaW4gc29tZXRoaW5nIGxpa2U6DQo+Pg0KPj4gc3dp
dGNoICh0YXJnZXRfY3VycmVudCgpKSB7DQo+PiBjYXNlIFRBUkdFVF9YODY6DQo+PiBjYXNl
IFRBUkdFVF9BUk06DQo+PiBjYXNlIFRBUkdFVF9YODZfNjQ6DQo+PiBjYXNlIFRBUkdFVF9B
Uk1fNjQ6DQo+PiAgIMKgwqDCoMKgcmV0dXJuIEFDUElfTUFYX1JBTV9TTE9UUzsNCj4+IGNh
c2UgVEFSR0VUIFBQQzoNCj4+IGNhc2UgVEFSR0VUIFBQQzY0Og0KPj4gICDCoMKgwqDCoHJl
dHVybiBTUEFQUl9NQVhfUkFNX1NMT1RTOw0KPj4gZGVmYXVsdDoNCj4+ICAgwqDCoMKgwqBy
ZXR1cm4gNTEyOw0KPj4gfQ0KPiANCj4gQ2xldmVyLCBJIGxpa2UgaXQsIHRoYW5rcyENCg0K
SXQncyBhIHBhdHRlcm4gd2UgY2FuIHJldXNlIGluIGFsbCBwbGFjZXMgd2hlcmUgaXQnbGwg
YmUgbmVlZGVkLg0KSXQncyBiZXR0ZXIgaWYgd2Uga2VlcCBpbiBUYXJnZXRJbmZvIG9ubHkg
Z2xvYmFsIGluZm9ybWF0aW9uLCB0aGF0IGlzIA0KdXNlZCB0aHJvdWdoIGFsbCB0aGUgY29k
ZWJhc2UsIGFuZCBub3Qgc3BlY2lmaWNzIGFib3V0IGEgZ2l2ZW4gDQpzdWJzeXN0ZW0vZGV2
aWNlL2ZpbGUuDQoNCkJ5IHRoZSB3YXksIFRBUkdFVF9BUk1fNjQgaXMgcHJvYmFibHkgVEFS
R0VUX0FBUkNINjQuDQo=

