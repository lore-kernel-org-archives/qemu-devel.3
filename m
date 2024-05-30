Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AE6C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjcy-0005tS-3g; Thu, 30 May 2024 13:31:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjcw-0005o0-EX
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:31:46 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjcu-0007Ip-6O
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:31:46 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-6bff93fac37so812792a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717090302; x=1717695102; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wb0NTG1vw2vb5wjEZn4MFLvVMWpCzba/1AJqZKryk24=;
 b=ezisRNMfaukR07gAQxqBsIHl3VpW5wTOw+Q72+7iiIACn8f81HHfxoOlsq9gs94sGA
 zpOiW2fkozK37+b+kbKhsN79a0Hjwqk7qJhXQFiUw7mwLxZ0NeKFMcrIzV3aNtJbmhLo
 7MZkurpUBWir5jqQrozPaXjnIaXljdAyshz3yDeciWbgNbfzhdE7vhU0CsLlbmz430k+
 tib6EUdynuNRBOtf4/c02mymqqGVd8elGvCJzBTSaC/+Qo3lxwrQOzuE3Jr9QCmTiaQ2
 LDrVS0POIwx6PnEfmDKoKCpQcWmAJcj+9e8CL4emw0qnJKA3Bfmm0GlI7c+7YvvKCkQI
 FxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717090302; x=1717695102;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wb0NTG1vw2vb5wjEZn4MFLvVMWpCzba/1AJqZKryk24=;
 b=mb93+VsrJx+1oo9iCsSgtz+mRefin3iUsq9sL+u9V9PYoZ4EXLH/JOiKfEizySFrx1
 ve8Ye2MnUVu8yKIi1axOpTrHDPLC38n9qAFz2S0d6Wr1TajQ9IwIZF6lITRhLKofFFc2
 eZ/yCqqQbnTmOEv8jOVdlyUxAV41KGLSO8rSLBfc4zR2I4C+RatRcWo01hMC+7Xxw/KZ
 GGw4NpYSp4+aJR1eRCSQrpNORd44t08cIr9e+km+IX063CrptRok8DGKhJ/xS5zp80/W
 vcwQunhyXLTkfon3Qf8W44QMxdnmJ5mK4OS6NkVoDSi5au0pn0IVHOgfb9jUwsz6Rew4
 1wFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfPAzeona9qG0AFztq3WOarKyVk0fEzfzDFkr/WAg27hjvZinaD0mwI4jkDP8alf5DcIuLXFmQn4q7hZLMHOtHWUzTNr4=
X-Gm-Message-State: AOJu0Yw8bJbdj87f4gsSmIs2ovGp8UNDUBerDUr4xTLfdz1oMXACJpgw
 HRwEveUQKcwJnoQfsdG5zqnPCXpgyjJxKUtEn8oKaF97I1HbmDh3iAOAYcounD0=
X-Google-Smtp-Source: AGHT+IHQh9lxsG/BdPMfD3E6iqq7LGuXky4PsqrQ6WPUEe9C12hlw4iNjT26pT38Y6DimxMSStnmMQ==
X-Received: by 2002:a17:90b:270b:b0:2bd:92d9:65ee with SMTP id
 98e67ed59e1d1-2c1abc4d0d4mr2488449a91.45.1717090302214; 
 Thu, 30 May 2024 10:31:42 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a776e173sm1924757a91.17.2024.05.30.10.31.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 10:31:41 -0700 (PDT)
Message-ID: <c5803a9f-c30b-4b9e-b3ce-75db38f555c4@linaro.org>
Date: Thu, 30 May 2024 10:31:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cpus: split qemu_init_vcpu and delay vCPU thread
 creation
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240529152219.825680-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240529152219.825680-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

T24gNS8yOS8yNCAwODoyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGlzIGVuc3VyZXMg
d2UgZG9uJ3Qgc3RhcnQgdGhlIHRocmVhZCB1bnRpbCBjcHVfY29tbW9uX3JlYWxpemVmbiBo
YXMNCj4gZmluaXNoZWQuIFRoaXMgZW5zdXJlcyB0aGF0IHBsdWdpbnMgd2lsbCBhbHdheXMg
cnVuDQo+IHFlbXVfcGx1Z2luX3ZjcHVfaW5pdF9fYXN5bmMgZmlyc3QgYmVmb3JlIGFueSBv
dGhlciBzdGF0ZXMuIEl0IGRvZXNuJ3QNCj4gdG90YWxseSBlbGltaW5hdGUgdGhlIHJhY2Ug
dGhhdCBwbHVnaW5fY3B1X3VwZGF0ZV9fbG9ja2VkIGhhcyB0byB3b3JrDQo+IGFyb3VuZCB0
aG91Z2guIEkgZm91bmQgdGhpcyB3aGlsZSByZXZpZXdpbmcgdGhlIGlwcyBwbHVnaW4gd2hp
Y2ggbWFrZXMNCj4gaGVhdnkgdXNlIG9mIHRoZSB2Y3B1IHBoYXNlIGNhbGxiYWNrcy4NCj4g
DQo+IEFuIGFsdGVybmF0aXZlIG1pZ2h0IGJlIHRvIG1vdmUgdGhlIGV4cGxpY2l0IGNyZWF0
aW9uIG9mIHZDUFUgdGhyZWFkcw0KPiB0byBxZGV2X21hY2hpbmVfY3JlYXRpb25fZG9uZSgp
PyBJdCBkb2Vzbid0IGFmZmVjdCB1c2VyLW1vZGUgd2hpY2gNCj4gYWxyZWFkeSBoYXMgYSB0
aHJlYWQgdG8gZXhlY3V0ZSBpbiBhbmQgZW5zdXJlcyB0aGUgUU9NIG9iamVjdCBoYXMNCj4g
Y29tcGxldGVkIGNyZWF0aW9uIGluIGNwdV9jcmVhdGUoKSBiZWZvcmUgY29udGludWluZy4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJv
Lm9yZz4NCj4gQ2M6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCj4gQ2M6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9y
Zz4NCj4gLS0tDQo+ICAgaW5jbHVkZS9ody9jb3JlL2NwdS5oICAgICAgfCAgOCArKysrKysr
Kw0KPiAgIGFjY2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5jIHwgIDUgKysrKysNCj4gICBody9j
b3JlL2NwdS1jb21tb24uYyAgICAgICB8ICA3ICsrKysrKy0NCj4gICBwbHVnaW5zL2NvcmUu
YyAgICAgICAgICAgICB8ICA1ICsrKysrDQo+ICAgc3lzdGVtL2NwdXMuYyAgICAgICAgICAg
ICAgfCAxNSArKysrKysrKysrLS0tLS0NCj4gICA1IGZpbGVzIGNoYW5nZWQsIDM0IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9o
dy9jb3JlL2NwdS5oIGIvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+IGluZGV4IGJiMzk4ZTgy
MzcuLjY5MjA2OTk1ODUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0K
PiArKysgYi9pbmNsdWRlL2h3L2NvcmUvY3B1LmgNCj4gQEAgLTEwNDEsNiArMTA0MSwxNCBA
QCB2b2lkIGVuZF9leGNsdXNpdmUodm9pZCk7DQo+ICAgICovDQo+ICAgdm9pZCBxZW11X2lu
aXRfdmNwdShDUFVTdGF0ZSAqY3B1KTsNCj4gICANCj4gKy8qKg0KPiArICogcWVtdV9zdGFy
dF92Y3B1Og0KPiArICogQGNwdTogVGhlIHZDUFUgdG8gc3RhcnQuDQo+ICsgKg0KPiArICog
Q3JlYXRlIHRoZSB2Q1BVIHRocmVhZCBhbmQgc3RhcnQgaXQgcnVubmluZy4NCj4gKyAqLw0K
PiArdm9pZCBxZW11X3N0YXJ0X3ZjcHUoQ1BVU3RhdGUgKmNwdSk7DQo+ICsNCj4gICAjZGVm
aW5lIFNTVEVQX0VOQUJMRSAgMHgxICAvKiBFbmFibGUgc2ltdWxhdGVkIEhXIHNpbmdsZSBz
dGVwcGluZyAqLw0KPiAgICNkZWZpbmUgU1NURVBfTk9JUlEgICAweDIgIC8qIERvIG5vdCB1
c2UgSVJRIHdoaWxlIHNpbmdsZSBzdGVwcGluZyAqLw0KPiAgICNkZWZpbmUgU1NURVBfTk9U
SU1FUiAweDQgIC8qIERvIG5vdCBUaW1lcnMgd2hpbGUgc2luZ2xlIHN0ZXBwaW5nICovDQo+
IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdXNlci1leGVjLXN0dWIuYyBiL2FjY2VsL3RjZy91
c2VyLWV4ZWMtc3R1Yi5jDQo+IGluZGV4IDRmYmUyZGJkYzguLjE2MmJiNzJiYmUgMTAwNjQ0
DQo+IC0tLSBhL2FjY2VsL3RjZy91c2VyLWV4ZWMtc3R1Yi5jDQo+ICsrKyBiL2FjY2VsL3Rj
Zy91c2VyLWV4ZWMtc3R1Yi5jDQo+IEBAIC0xOCw2ICsxOCwxMSBAQCB2b2lkIGNwdV9leGVj
X3Jlc2V0X2hvbGQoQ1BVU3RhdGUgKmNwdSkNCj4gICB7DQo+ICAgfQ0KPiAgIA0KPiArdm9p
ZCBxZW11X3N0YXJ0X3ZjcHUoQ1BVU3RhdGUgKmNwdSkNCj4gK3sNCj4gKyAgICAvKiBOT1Ag
Zm9yIHVzZXItbW9kZSwgd2UgYWxyZWFkeSBoYXZlIGEgdGhyZWFkICovDQo+ICt9DQo+ICsN
Cj4gICAvKiBVc2VyIG1vZGUgZW11bGF0aW9uIGRvZXMgbm90IHN1cHBvcnQgcmVjb3JkL3Jl
cGxheSB5ZXQuICAqLw0KPiAgIA0KPiAgIGJvb2wgcmVwbGF5X2V4Y2VwdGlvbih2b2lkKQ0K
PiBkaWZmIC0tZ2l0IGEvaHcvY29yZS9jcHUtY29tbW9uLmMgYi9ody9jb3JlL2NwdS1jb21t
b24uYw0KPiBpbmRleCAwZjBhMjQ3ZjU2Li42ODg5NWRkZDU5IDEwMDY0NA0KPiAtLS0gYS9o
dy9jb3JlL2NwdS1jb21tb24uYw0KPiArKysgYi9ody9jb3JlL2NwdS1jb21tb24uYw0KPiBA
QCAtMjMwLDcgKzIzMCwxMiBAQCBzdGF0aWMgdm9pZCBjcHVfY29tbW9uX3JlYWxpemVmbihE
ZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQo+ICAgICAgIH0NCj4gICAjZW5kaWYN
Cj4gICANCj4gLSAgICAvKiBOT1RFOiBsYXRlc3QgZ2VuZXJpYyBwb2ludCB3aGVyZSB0aGUg
Y3B1IGlzIGZ1bGx5IHJlYWxpemVkICovDQo+ICsgICAgLyoNCj4gKyAgICAgKiBXaXRoIGV2
ZXJ5dGhpbmcgc2V0IHVwIHdlIGNhbiBmaW5hbGx5IHN0YXJ0IHRoZSB2Q1BVIHRocmVhZC4N
Cj4gKyAgICAgKiBUaGlzIGlzIGEgTk9QIGZvciBsaW51eC11c2VyLg0KPiArICAgICAqIE5P
VEU6IGxhdGVzdCBnZW5lcmljIHBvaW50IHdoZXJlIHRoZSBjcHUgaXMgZnVsbHkgcmVhbGl6
ZWQNCj4gKyAgICAgKi8NCj4gKyAgICBxZW11X3N0YXJ0X3ZjcHUoY3B1KTsNCj4gICB9DQo+
ICAgDQo+ICAgc3RhdGljIHZvaWQgY3B1X2NvbW1vbl91bnJlYWxpemVmbihEZXZpY2VTdGF0
ZSAqZGV2KQ0KPiBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9jb3JlLmMgYi9wbHVnaW5zL2NvcmUu
Yw0KPiBpbmRleCAwNzI2YmM3ZjI1Li4xZTVkYTc4NTNiIDEwMDY0NA0KPiAtLS0gYS9wbHVn
aW5zL2NvcmUuYw0KPiArKysgYi9wbHVnaW5zL2NvcmUuYw0KPiBAQCAtNjUsNiArNjUsMTEg
QEAgc3RhdGljIHZvaWQgcGx1Z2luX2NwdV91cGRhdGVfX2xvY2tlZChncG9pbnRlciBrLCBn
cG9pbnRlciB2LCBncG9pbnRlciB1ZGF0YSkNCj4gICAgICAgQ1BVU3RhdGUgKmNwdSA9IGNv
bnRhaW5lcl9vZihrLCBDUFVTdGF0ZSwgY3B1X2luZGV4KTsNCj4gICAgICAgcnVuX29uX2Nw
dV9kYXRhIG1hc2sgPSBSVU5fT05fQ1BVX0hPU1RfVUxPTkcoKnBsdWdpbi5tYXNrKTsNCj4g
ICANCj4gKyAgICAvKg0KPiArICAgICAqIFRoZXJlIGlzIGEgcmFjZSBjb25kaXRpb24gYmV0
d2VlbiB0aGUgc3RhcnRpbmcgb2YgdGhlIHZDUFUNCj4gKyAgICAgKiB0aHJlYWQgYXQgdGhl
IGVuZCBvZiBjcHVfY29tbW9uX3JlYWxpemVmbiBhbmQgd2hlbiByZWFsaXplZCBpcw0KPiAr
ICAgICAqIGZpbmFsbHkgc2V0Lg0KPiArICAgICAqLw0KDQpDb3VsZCB3ZSBzaW1wbHkgaGF2
ZSBhbiBhY3RpdmUgd2FpdCBoZXJlPw0Kd2hpbGUgKCFERVZJQ0UoY3B1KS0+cmVhbGl6ZWQp
IHt9DQoNCldlIGhhdmUgYSBndWFyYW50ZWUgaXQgd2lsbCBiZSByZWFsaXplZCBzaG9ydGx5
LCBhbmQgaWYgaXQncyB0b28gaGFyZCB0byANCmhhdmUgYSBwcm9wZXIgc3luY2hyb25pemF0
aW9uIG1lY2hhbmlzbSAoaW50cm9kdWNlIGEgcmVhbGl6ZV9jb25kPyksIA0KdGhlbiB3YWl0
aW5nIGZvciB0aGUgcHJvcGVyIHN0YXRlIGRvZXMgbm90IHNlZW0gdG9vIGJhZC4NCg0KSXQn
cyBhIGJpdCBzdHJhbmdlIGZvciBtZSB0byBkb2N1bWVudCBhbiBleGlzdGluZyByYWNlIGNv
bmRpdGlvbiwgDQppbnN0ZWFkIG9mIGZpbmRpbmcgYSBzb2x1dGlvbi4NCg0KPiAgICAgICBp
ZiAoREVWSUNFKGNwdSktPnJlYWxpemVkKSB7DQo+ICAgICAgICAgICBhc3luY19ydW5fb25f
Y3B1KGNwdSwgcGx1Z2luX2NwdV91cGRhdGVfX2FzeW5jLCBtYXNrKTsNCj4gICAgICAgfSBl
bHNlIHsNCj4gZGlmZiAtLWdpdCBhL3N5c3RlbS9jcHVzLmMgYi9zeXN0ZW0vY3B1cy5jDQo+
IGluZGV4IGQzNjQwYzk1MDMuLjdkZDg0NjRjNWUgMTAwNjQ0DQo+IC0tLSBhL3N5c3RlbS9j
cHVzLmMNCj4gKysrIGIvc3lzdGVtL2NwdXMuYw0KPiBAQCAtNDg4LDExICs0ODgsMTMgQEAg
dm9pZCBjcHVzX2tpY2tfdGhyZWFkKENQVVN0YXRlICpjcHUpDQo+ICAgDQo+ICAgdm9pZCBx
ZW11X2NwdV9raWNrKENQVVN0YXRlICpjcHUpDQo+ICAgew0KPiAtICAgIHFlbXVfY29uZF9i
cm9hZGNhc3QoY3B1LT5oYWx0X2NvbmQpOw0KPiAtICAgIGlmIChjcHVzX2FjY2VsLT5raWNr
X3ZjcHVfdGhyZWFkKSB7DQo+IC0gICAgICAgIGNwdXNfYWNjZWwtPmtpY2tfdmNwdV90aHJl
YWQoY3B1KTsNCj4gLSAgICB9IGVsc2UgeyAvKiBkZWZhdWx0ICovDQo+IC0gICAgICAgIGNw
dXNfa2lja190aHJlYWQoY3B1KTsNCj4gKyAgICBpZiAoY3B1LT5oYWx0X2NvbmQpIHsNCj4g
KyAgICAgICAgcWVtdV9jb25kX2Jyb2FkY2FzdChjcHUtPmhhbHRfY29uZCk7DQo+ICsgICAg
ICAgIGlmIChjcHVzX2FjY2VsLT5raWNrX3ZjcHVfdGhyZWFkKSB7DQo+ICsgICAgICAgICAg
ICBjcHVzX2FjY2VsLT5raWNrX3ZjcHVfdGhyZWFkKGNwdSk7DQo+ICsgICAgICAgIH0gZWxz
ZSB7IC8qIGRlZmF1bHQgKi8NCj4gKyAgICAgICAgICAgIGNwdXNfa2lja190aHJlYWQoY3B1
KTsNCj4gKyAgICAgICAgfQ0KPiAgICAgICB9DQo+ICAgfQ0KPiAgIA0KPiBAQCAtNjc0LDcg
KzY3NiwxMCBAQCB2b2lkIHFlbXVfaW5pdF92Y3B1KENQVVN0YXRlICpjcHUpDQo+ICAgICAg
ICAgICBjcHUtPm51bV9hc2VzID0gMTsNCj4gICAgICAgICAgIGNwdV9hZGRyZXNzX3NwYWNl
X2luaXQoY3B1LCAwLCAiY3B1LW1lbW9yeSIsIGNwdS0+bWVtb3J5KTsNCj4gICAgICAgfQ0K
PiArfQ0KPiAgIA0KPiArdm9pZCBxZW11X3N0YXJ0X3ZjcHUoQ1BVU3RhdGUgKmNwdSkNCj4g
K3sNCj4gICAgICAgLyogYWNjZWxlcmF0b3JzIGFsbCBpbXBsZW1lbnQgdGhlIEFjY2VsT3Bz
Q2xhc3MgKi8NCj4gICAgICAgZ19hc3NlcnQoY3B1c19hY2NlbCAhPSBOVUxMICYmIGNwdXNf
YWNjZWwtPmNyZWF0ZV92Y3B1X3RocmVhZCAhPSBOVUxMKTsNCj4gICAgICAgY3B1c19hY2Nl
bC0+Y3JlYXRlX3ZjcHVfdGhyZWFkKGNwdSk7DQo=

