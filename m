Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73EE5C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 19:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWL1C-0001j7-Op; Tue, 23 Jul 2024 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWL14-0001hV-MF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 15:17:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sWL12-0005Fz-FZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 15:17:41 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70aec66c936so3379753b3a.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 12:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721762259; x=1722367059; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IejhN5B2drk4iRCU8dya0Z/rjyTcDHqRG/dq1Ysdi2I=;
 b=IY9GxxaElo0mWak9lxY+/VXr6v4SdG656lwLHWaAHRAd53pco+uASlpk0kqMAB+FwP
 Ms/0zs/SpjQDBpQp0gxGFexzOT6ks/irdT3Liv3xMVsN71BavM0ArXXYXfUVOAyxEZtg
 wcjehsfszfqrt9sE8ZrIbaa62enQkoG5ys5+l3BJKH7hl0dCjvVVPOvV5ZYYMu/+fZ6U
 CdhwsDc46HxK7diLpNADrQ1NmdJwJD1Puw5WZLOGU55Jyj5lyYqL526Agqh/nZhWG4RQ
 B2KHCU+GrdFKVHhVqAZJuNouXHRgsDbOFeGui/dazynT2p/0x608yXqasLANSVAqznHE
 WV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721762259; x=1722367059;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IejhN5B2drk4iRCU8dya0Z/rjyTcDHqRG/dq1Ysdi2I=;
 b=w/QGY7jwUPCiR+UFhq/J/H2KXkwgWhJwAbwIWhr6XmZ0A89/Djq4mnQcUEegLAH9cP
 3y4o0b0fC0C2TTBdKhPaLi3Ni1WH66Soi7EBJCJ+/liqO2jmSTdBZhPYKu68iWSwoa7+
 UkHoMw7hPjynr1BE6uRmngFoUqQH/nMn6X6+Lb7CPte/G6yVQE5uaymfKlxEngmVTTwS
 VN8ba2xd/BhVgUCmKzQ7CoasxRVcjmI6hkcJ5iy0HZD8ea72WclHmIGaj9pV5uXKYNZl
 uFsyJqQlIfu62ByJ6K5dDMruH7/lg342SOXf1KAjZeMxe1niqiTeqgW+QV4Gg9brXLNr
 QPnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ZlzRZB727qUOTqYxyzUWmaELbaQrRq+u3uOSJllTWkU/45SehytWfrvhlFiwTz8O/Y2W8e/IFSgBuzjTo5lnbteTAcE=
X-Gm-Message-State: AOJu0YyEoK6qaPDgV3o2/QQu3Fx4rFIQoS2Z/xuvscoReBOzE0cFAPjS
 z0EgDf81Jx5I7zfdCQ34GLf1PDIiFdyNTLwf7P8Z84NaWTBb9KkGMI64saNXuA8=
X-Google-Smtp-Source: AGHT+IEacgo2QAbuj7F5QJIJeiWKaRUlIySvfxL8OYz+InlhLj19udzWbPoyucjNyJFROr3ojYcpKw==
X-Received: by 2002:a05:6a00:3c8a:b0:704:32dc:c4e4 with SMTP id
 d2e1a72fcca58-70d3a8745ecmr5241097b3a.1.1721762258633; 
 Tue, 23 Jul 2024 12:17:38 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d34a15d12sm2693897b3a.153.2024.07.23.12.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 12:17:38 -0700 (PDT)
Message-ID: <b0495043-8de9-49b5-aafb-3b74a19ca1c3@linaro.org>
Date: Tue, 23 Jul 2024 12:17:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/goldfish: Use DMA memory API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Laurent Vivier <laurent@vivier.eu>
References: <20240723181850.46000-1-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240723181850.46000-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

T24gNy8yMy8yNCAxMToxOCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJh
dGhlciB0aGFuIHVzaW5nIGFkZHJlc3Nfc3BhY2VfcncoLi4uLCAwIG9yIDEpLA0KPiB1c2Ug
dGhlIHNpbXBsZXIgRE1BIG1lbW9yeSBBUEkgd2hpY2ggZXhwYW5kIHRvDQo+IHRoZSBzYW1l
IGNvZGUuIFRoaXMgYWxsb3dzIHJlbW92aW5nIGEgY2FzdCBvbg0KPiB0aGUgJ2J1ZicgdmFy
aWFibGUgd2hpY2ggaXMgcmVhbGx5IGNvbnN0LiBTaW5jZQ0KPiAnYnVmJyBpcyBvbmx5IHVz
ZWQgaW4gdGhlIENNRF9SRUFEX0JVRkZFUiBjYXNlLA0KPiB3ZSBjYW4gcmVkdWNlIGl0cyBz
Y29wZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxw
aGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgaHcvY2hhci9nb2xkZmlzaF90dHkuYyB8
IDEyICsrKysrKy0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyks
IDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvY2hhci9nb2xkZmlzaF90
dHkuYyBiL2h3L2NoYXIvZ29sZGZpc2hfdHR5LmMNCj4gaW5kZXggZjhmZjA0M2MzOTYuLmNk
ZmY0NmJjMTNiIDEwMDY0NA0KPiAtLS0gYS9ody9jaGFyL2dvbGRmaXNoX3R0eS5jDQo+ICsr
KyBiL2h3L2NoYXIvZ29sZGZpc2hfdHR5LmMNCj4gQEAgLTE2LDYgKzE2LDcgQEANCj4gICAj
aW5jbHVkZSAicWVtdS9sb2cuaCINCj4gICAjaW5jbHVkZSAidHJhY2UuaCINCj4gICAjaW5j
bHVkZSAiZXhlYy9hZGRyZXNzLXNwYWNlcy5oIg0KPiArI2luY2x1ZGUgInN5c2VtdS9kbWEu
aCINCj4gICAjaW5jbHVkZSAiaHcvY2hhci9nb2xkZmlzaF90dHkuaCINCj4gICANCj4gICAj
ZGVmaW5lIEdPTERGSVNIX1RUWV9WRVJTSU9OIDENCj4gQEAgLTY5LDcgKzcwLDYgQEAgc3Rh
dGljIHVpbnQ2NF90IGdvbGRmaXNoX3R0eV9yZWFkKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIGFk
ZHIsDQo+ICAgc3RhdGljIHZvaWQgZ29sZGZpc2hfdHR5X2NtZChHb2xkZmlzaFRUWVN0YXRl
ICpzLCB1aW50MzJfdCBjbWQpDQo+ICAgew0KPiAgICAgICB1aW50MzJfdCB0b19jb3B5Ow0K
PiAtICAgIHVpbnQ4X3QgKmJ1ZjsNCj4gICAgICAgdWludDhfdCBkYXRhX291dFtHT0xGSVNI
X1RUWV9CVUZGRVJfU0laRV07DQo+ICAgICAgIGludCBsZW47DQo+ICAgICAgIHVpbnQ2NF90
IHB0cjsNCj4gQEAgLTk3LDggKzk3LDggQEAgc3RhdGljIHZvaWQgZ29sZGZpc2hfdHR5X2Nt
ZChHb2xkZmlzaFRUWVN0YXRlICpzLCB1aW50MzJfdCBjbWQpDQo+ICAgICAgICAgICB3aGls
ZSAobGVuKSB7DQo+ICAgICAgICAgICAgICAgdG9fY29weSA9IE1JTihHT0xGSVNIX1RUWV9C
VUZGRVJfU0laRSwgbGVuKTsNCj4gICANCj4gLSAgICAgICAgICAgIGFkZHJlc3Nfc3BhY2Vf
cncoJmFkZHJlc3Nfc3BhY2VfbWVtb3J5LCBwdHIsDQo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE1FTVRYQVRUUlNfVU5TUEVDSUZJRUQsIGRhdGFfb3V0LCB0b19jb3B5LCAw
KTsNCj4gKyAgICAgICAgICAgIGRtYV9tZW1vcnlfcmVhZF9yZWxheGVkKCZhZGRyZXNzX3Nw
YWNlX21lbW9yeSwgcHRyLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGF0YV9vdXQsIHRvX2NvcHkpOw0KPiAgICAgICAgICAgICAgIHFlbXVfY2hyX2ZlX3dy
aXRlX2FsbCgmcy0+Y2hyLCBkYXRhX291dCwgdG9fY29weSk7DQo+ICAgDQo+ICAgICAgICAg
ICAgICAgbGVuIC09IHRvX2NvcHk7DQo+IEBAIC0xMDksOSArMTA5LDkgQEAgc3RhdGljIHZv
aWQgZ29sZGZpc2hfdHR5X2NtZChHb2xkZmlzaFRUWVN0YXRlICpzLCB1aW50MzJfdCBjbWQp
DQo+ICAgICAgICAgICBsZW4gPSBzLT5kYXRhX2xlbjsNCj4gICAgICAgICAgIHB0ciA9IHMt
PmRhdGFfcHRyOw0KPiAgICAgICAgICAgd2hpbGUgKGxlbiAmJiAhZmlmbzhfaXNfZW1wdHko
JnMtPnJ4X2ZpZm8pKSB7DQo+IC0gICAgICAgICAgICBidWYgPSAodWludDhfdCAqKWZpZm84
X3BvcF9idWYoJnMtPnJ4X2ZpZm8sIGxlbiwgJnRvX2NvcHkpOw0KPiAtICAgICAgICAgICAg
YWRkcmVzc19zcGFjZV9ydygmYWRkcmVzc19zcGFjZV9tZW1vcnksIHB0ciwNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVELCBidWYsIHRv
X2NvcHksIDEpOw0KPiArICAgICAgICAgICAgY29uc3QgdWludDhfdCAqYnVmID0gZmlmbzhf
cG9wX2J1Zigmcy0+cnhfZmlmbywgbGVuLCAmdG9fY29weSk7DQo+ICsNCj4gKyAgICAgICAg
ICAgIGRtYV9tZW1vcnlfd3JpdGVfcmVsYXhlZCgmYWRkcmVzc19zcGFjZV9tZW1vcnksIHB0
ciwgYnVmLCB0b19jb3B5KTsNCj4gICANCj4gICAgICAgICAgICAgICBsZW4gLT0gdG9fY29w
eTsNCj4gICAgICAgICAgICAgICBwdHIgKz0gdG9fY29weTsNCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

