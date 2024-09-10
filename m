Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA4ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so2A4-0005I8-5Y; Tue, 10 Sep 2024 10:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so2A1-00057G-Ql
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:48:05 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1so2A0-00034Q-7E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:48:05 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2055a3f80a4so41137535ad.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725979683; x=1726584483; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8q1rq2n40D9q1EKnvg/RWcRBljAzsrp/yedunpNS2bY=;
 b=DnDJXmT0rh28Z5Q7VyAeFTGwC7Ys8UQqMq5fApbA2zaOgZgKiXq9JCuQAHD2bT51gC
 0Gnyy4kzrUQ9hURfjxxY6hJvxbGRxeR+K0SGNuC4TiRB8L1stLZCbW1ugshsytY5Eswb
 udHUgoC47yCT3I8ofcei6vZvl6kWP+mayvMUO3RDjFO9pwkBKFBoEjv/bK9u5r5GN/6E
 cqtXTHTCkaKvv9GgXQbJteeb9EXPAKqDqadnuydro1gbN/GptjPV+Dc+bQC38G7Acb2N
 p1qsrqJ8benDIR5AI8F/wdYCLqrObMFw7Ulied0OkrN/jIPY3vrW/ansiHdGD7rH7g23
 Btlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725979683; x=1726584483;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8q1rq2n40D9q1EKnvg/RWcRBljAzsrp/yedunpNS2bY=;
 b=euhTkXQMX69eqamPrqs4+GCE38ZRUaKs9GhYLH4Lrqc4h+ncDlj0xf5lcqrL/KL/k0
 SFb2vEZZgyddcUM/LhXKa61NSKLHj4kZ02S72oU23W44iHoGt30zh2EraU3kaWcw/OVv
 nJNRqxRDEGWLviaP7xLkcJ6uoFcoUpVVW1FtDGUwXXbikHNQUP3es+nGeU7P6ShqnObH
 7Wc8U/IINnM/sOTnx7je7CMhsU4QsNQTg4FGROydVyNrJnmPxWYzwMjktzSbP9O+Pgof
 8DZ51EGCA0g1ra7Efcc7IAyoKs+dvapFpuuTO8cBC3PuLuQwzMqSki0yZ+50oVSZ525G
 0njg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjY2ii+Mkxr0ms+ZDlC4t8guOHMEaRKexLVRDsexKDCUujH5m8sK/3wreKrOjKeqADYFur1oOQCuYq@nongnu.org
X-Gm-Message-State: AOJu0Yx0GAleP6LnWDVYA/Hmij0zoZpZUP7GVH6aOvBndge2Fxvqn4A6
 fVxMnPzFeo5MWk35LGIu2IjOcuyYhJXQnxxA3Ya86V8wmi/H9UhXKWmPeE6clUEgFm/lr49D+Mt
 nc2y6eg==
X-Google-Smtp-Source: AGHT+IE+qQGW3MthsDPKf4RQyCYi4lD/13W7SJohSfwKMsVzzu7jEcyFv+hRY9iGVbL0GBXdEIADAQ==
X-Received: by 2002:a17:903:2287:b0:206:b960:2e97 with SMTP id
 d9443c01a7336-2074c6aeacfmr15435325ad.45.1725979682660; 
 Tue, 10 Sep 2024 07:48:02 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::9633? ([2604:3d08:9384:1d00::9633])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e0f489sm49981995ad.18.2024.09.10.07.48.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 07:48:02 -0700 (PDT)
Message-ID: <937206c3-5d32-4566-a516-b860d3089a92@linaro.org>
Date: Tue, 10 Sep 2024 07:48:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/26] tests/tcg: only read/write 64 bit words on 64 bit
 systems
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Maydell
 <peter.maydell@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
 <20240910140733.4007719-21-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240910140733.4007719-21-alex.bennee@linaro.org>
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

T24gOS8xMC8yNCAwNzowNywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXaGlsZSB0aGUgY29t
cGlsZXJzIHdpbGwgZ2VuZXJhbGx5IGhhcHBpbHkgc3ludGhlc2lzZSBhIDY0IGJpdCB2YWx1
ZQ0KPiBmb3IgeW91IG9uIDMyIGJpdCBzeXN0ZW1zIGl0IGRvZXNuJ3QgZXhlcmNpc2UgYW55
dGhpbmcgb24gUUVNVS4gSXQNCj4gYWxzbyBtYWtlcyBpdCBoYXJkIHRvIGFjY3VyYXRlbHkg
Y29tcGFyZSB0aGUgYWNjZXNzZXMgdG8gdGVzdF9kYXRhDQo+IHdoZW4gaW5zdHJ1bWVudGlu
Zy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGlu
YXJvLm9yZz4NCj4gLS0tDQo+ICAgdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5
LmMgfCAyNiArKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAxOSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3Rlc3RzL3RjZy9tdWx0aWFyY2gvc3lzdGVtL21lbW9yeS5jIGIvdGVzdHMvdGNnL211bHRp
YXJjaC9zeXN0ZW0vbWVtb3J5LmMNCj4gaW5kZXggOGYyMzcxOTc1ZC4uNjgwZGQ0ODAwYiAx
MDA2NDQNCj4gLS0tIGEvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5LmMNCj4g
KysrIGIvdGVzdHMvdGNnL211bHRpYXJjaC9zeXN0ZW0vbWVtb3J5LmMNCj4gQEAgLTE2Myw2
ICsxNjMsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3Rlc3RfZGF0YV91MzIoaW50IG9mZnNldCkN
Cj4gICAgICAgbWxfcHJpbnRmKCJkb25lICVkIEAgJXBcbiIsIGksIHB0cik7DQo+ICAgfQ0K
PiAgIA0KPiArI2lmIF9fU0laRU9GX1BPSU5URVJfXyA9PSA4DQo+ICAgc3RhdGljIHZvaWQg
aW5pdF90ZXN0X2RhdGFfdTY0KGludCBvZmZzZXQpDQo+ICAgew0KPiAgICAgICB1aW50OF90
IGNvdW50ID0gMDsNCj4gQEAgLTE4Nyw2ICsxODgsNyBAQCBzdGF0aWMgdm9pZCBpbml0X3Rl
c3RfZGF0YV91NjQoaW50IG9mZnNldCkNCj4gICAgICAgfQ0KPiAgICAgICBtbF9wcmludGYo
ImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICB9DQo+ICsjZW5kaWYNCj4gICANCj4g
ICBzdGF0aWMgYm9vbCByZWFkX3Rlc3RfZGF0YV91MTYoaW50IG9mZnNldCkNCj4gICB7DQo+
IEBAIC0yNTQsNiArMjU2LDcgQEAgc3RhdGljIGJvb2wgcmVhZF90ZXN0X2RhdGFfdTMyKGlu
dCBvZmZzZXQpDQo+ICAgICAgIHJldHVybiB0cnVlOw0KPiAgIH0NCj4gICANCj4gKyNpZiBf
X1NJWkVPRl9QT0lOVEVSX18gPT0gOA0KPiAgIHN0YXRpYyBib29sIHJlYWRfdGVzdF9kYXRh
X3U2NChpbnQgb2Zmc2V0KQ0KPiAgIHsNCj4gICAgICAgdWludDY0X3Qgd29yZCwgKnB0ciA9
ICh1aW50NjRfdCAqKSZ0ZXN0X2RhdGFbb2Zmc2V0XTsNCj4gQEAgLTMwNywxMSArMzEwLDE2
IEBAIHN0YXRpYyBib29sIHJlYWRfdGVzdF9kYXRhX3U2NChpbnQgb2Zmc2V0KQ0KPiAgICAg
ICBtbF9wcmludGYoImRvbmUgJWQgQCAlcFxuIiwgaSwgcHRyKTsNCj4gICAgICAgcmV0dXJu
IHRydWU7DQo+ICAgfQ0KPiArI2VuZGlmDQo+ICAgDQo+ICAgLyogUmVhZCB0aGUgdGVzdCBk
YXRhIGFuZCB2ZXJpZnkgYXQgdmFyaW91cyBvZmZzZXRzICovDQo+IC1yZWFkX3VmbiByZWFk
X3VmbnNbXSA9IHsgcmVhZF90ZXN0X2RhdGFfdTE2LA0KPiAtICAgICAgICAgICAgICAgICAg
ICAgICAgIHJlYWRfdGVzdF9kYXRhX3UzMiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICByZWFkX3Rlc3RfZGF0YV91NjQgfTsNCj4gK3JlYWRfdWZuIHJlYWRfdWZuc1tdID0gew0K
PiArICAgIHJlYWRfdGVzdF9kYXRhX3UxNiwNCj4gKyAgICByZWFkX3Rlc3RfZGF0YV91MzIs
DQo+ICsjaWYgX19TSVpFT0ZfUE9JTlRFUl9fID09IDgNCj4gKyAgICByZWFkX3Rlc3RfZGF0
YV91NjQNCj4gKyNlbmRpZg0KPiArfTsNCj4gICANCj4gICBib29sIGRvX3Vuc2lnbmVkX3Jl
YWRzKGludCBzdGFydF9vZmYpDQo+ICAgew0KPiBAQCAtNDc2LDEwICs0ODQsMTQgQEAgYm9v
bCBkb19zaWduZWRfcmVhZHMoYm9vbCBuZWdfZmlyc3QpDQo+ICAgICAgIHJldHVybiBvazsN
Cj4gICB9DQo+ICAgDQo+IC1pbml0X3VmbiBpbml0X3VmbnNbXSA9IHsgaW5pdF90ZXN0X2Rh
dGFfdTgsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgaW5pdF90ZXN0X2RhdGFfdTE2
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgIGluaXRfdGVzdF9kYXRhX3UzMiwNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICBpbml0X3Rlc3RfZGF0YV91NjQgfTsNCj4gK2lu
aXRfdWZuIGluaXRfdWZuc1tdID0gew0KPiArICAgIGluaXRfdGVzdF9kYXRhX3U4LA0KPiAr
ICAgIGluaXRfdGVzdF9kYXRhX3UxNiwNCj4gKyAgICBpbml0X3Rlc3RfZGF0YV91MzIsDQo+
ICsjaWYgX19TSVpFT0ZfUE9JTlRFUl9fID09IDgNCj4gKyAgICBpbml0X3Rlc3RfZGF0YV91
NjQNCj4gKyNlbmRpZg0KPiArfTsNCj4gICANCj4gICBpbnQgbWFpbih2b2lkKQ0KPiAgIHsN
Cg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCg==

