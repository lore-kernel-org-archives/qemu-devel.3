Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8066CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 17:53:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tub7u-0000yO-Ip; Tue, 18 Mar 2025 13:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tub7j-0000mw-9U
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:53:13 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tub7c-0002ih-LB
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 13:53:04 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-225d66a4839so75838875ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742320378; x=1742925178; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E9yUCUro9/6dtE85RT/r5RnqitV+tJ76OF97vhv+iRY=;
 b=vFxY9lFu/Vkh1maxp+JoWASRdijneu9ZlsnUeEJ9mrvFNWctsNnvra4p0EQIyMK6b6
 GFmu+8ykm/NA7LMZhyP4yvqSwSi8mVNMR9qQjlVAEk5uUjp6rm0O1tkHpLgIFZX9Z7UK
 csP4CsiIKO41SxX+qW4S7vEuwcjis1ab2uN8jy++9hn/1NrxJeN/xvAS7P5uXqm82xDX
 A39sDXfdY3Hu0F4UJ6HehsDX9XcmHH/ErUL3MNpQ5ala9O1gWc6EHit+KrapSlfwrUQs
 OXBL+5+NIzrEHKtf3BOwnhM6VTVZaDm5EvPHN0wxDoIt4UHK7qZKLf8yvmYeNoT42UuV
 JFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742320378; x=1742925178;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E9yUCUro9/6dtE85RT/r5RnqitV+tJ76OF97vhv+iRY=;
 b=P9DMBXdIEDdGi6MigJp4ZkkS2tnCo+3jdpSKqJQ3YKwxuuNpJvMkLl3t3M4cVrUMrt
 GDc34oPpLcbz8RBwIJG7p4wsMEb3wg4LPBibfCVzMpcpqo5FLVj52JVnaWVO/rRI1fR+
 w1Rz036eX5Myk/NqmKgN/ljX0jc4MIz3OvnsWBmo7VtAi/0Rl/nhsIl84UXXQem3223l
 XsUPRqSSlCqj0HQp3wL3D818lTo0PLM28E6av9MLdTfwJG6rBX/mNMEE4pCaS0sSTRwe
 NfnxIuXmMcfa/vsIcPHxgnfOhoB9e/4nqOhKpCdTb+sU493o5flTqUCfUPIbskVR2PKP
 +Pfg==
X-Gm-Message-State: AOJu0YyOcUP6pltwaraDfwlNIQx/zNiIDuFeU4f4ZuuF9gb08e5VQfQt
 bWzsmPUJmYFgHq7P78DSY28vmf0hcnHkE2E+Xq6TAKRtkr6uS//fqgdVckunEGk=
X-Gm-Gg: ASbGncsCxXFN9hxtuqSFp+mu+l9z8O8FalPqSKLsWc71hfFzP/KdvGZYnCnWHq1oRrm
 Kb7FOISOCiiW3lrizAchoOFvAKzMNw0ck/pYX8r0E7/5lB+8bBMeCnzOxMaRbwiVpCSCVTK3NeC
 SQZk/HGxgNyNSKpc8veELBe0CRPh5MUBuaFh4uqy8gP8X/Ks8LFQ0vtNH+ubmak+Rl7EleYK2dH
 TNZe9qoq9+rqs3j190YS1lwZFBOJqaztqOu/UnwTtr1v4Q/WHUs74MyjV1pd0JEUG57Rcp9XUUn
 wKD0Z4RS1yNnuUv+i7KgISo2kfa/0QtH64dx+RESaFnrFaT3UkRAz+BGzQ==
X-Google-Smtp-Source: AGHT+IGaMme6I4SSWbEnoXoKG8OoitAHBPbvXRICDZMqDDARtTS6S6zcjn70eDe1QiVVIjQrBjyhiA==
X-Received: by 2002:a05:6a00:398d:b0:732:1ce5:4a4c with SMTP id
 d2e1a72fcca58-737577765b2mr5112478b3a.1.1742320377790; 
 Tue, 18 Mar 2025 10:52:57 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711550fe1sm10193587b3a.53.2025.03.18.10.52.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 10:52:57 -0700 (PDT)
Message-ID: <a3b61916-2466-4ec8-a4e1-567581be7a2b@linaro.org>
Date: Tue, 18 Mar 2025 10:52:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] target/arm/cpu: remove inline stubs for aarch32
 emulation
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250318045125.759259-1-pierrick.bouvier@linaro.org>
 <20250318045125.759259-12-pierrick.bouvier@linaro.org>
 <8a24a29c-9d2a-47c9-a183-c92242c82bd9@linaro.org>
 <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA--jw3GmS70NTwviAEhdWeJ1UXE+ucNSkR60BXk6G8B6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

T24gMy8xOC8yNSAxMDo1MCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVHVlLCAxOCBN
YXIgMjAyNSBhdCAxNzo0MiwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5h
cm8ub3JnPiB3cm90ZToNCj4+DQo+PiBPbiAxOC8zLzI1IDA1OjUxLCBQaWVycmljayBCb3V2
aWVyIHdyb3RlOg0KPj4+IERpcmVjdGx5IGNvbmRpdGlvbiBhc3NvY2lhdGVkIGNhbGxzIGlu
IHRhcmdldC9hcm0vaGVscGVyLmMgZm9yIG5vdy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAt
LS0NCj4+PiAgICB0YXJnZXQvYXJtL2NwdS5oICAgIHwgOCAtLS0tLS0tLQ0KPj4+ICAgIHRh
cmdldC9hcm0vaGVscGVyLmMgfCA2ICsrKysrKw0KPj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L3RhcmdldC9hcm0vY3B1LmggYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4gaW5kZXggNTFiNjQy
OGNmZWMuLjkyMDVjYmRlYzQzIDEwMDY0NA0KPj4+IC0tLSBhL3RhcmdldC9hcm0vY3B1LmgN
Cj4+PiArKysgYi90YXJnZXQvYXJtL2NwdS5oDQo+Pj4gQEAgLTEyMjIsNyArMTIyMiw2IEBA
IGludCBhcm1fY3B1X3dyaXRlX2VsZjMyX25vdGUoV3JpdGVDb3JlRHVtcEZ1bmN0aW9uIGYs
IENQVVN0YXRlICpjcywNCj4+PiAgICAgKi8NCj4+PiAgICB2b2lkIGFybV9lbXVsYXRlX2Zp
cm13YXJlX3Jlc2V0KENQVVN0YXRlICpjcHVzdGF0ZSwgaW50IHRhcmdldF9lbCk7DQo+Pj4N
Cj4+PiAtI2lmZGVmIFRBUkdFVF9BQVJDSDY0DQo+Pj4gICAgaW50IGFhcmNoNjRfY3B1X2dk
Yl9yZWFkX3JlZ2lzdGVyKENQVVN0YXRlICpjcHUsIEdCeXRlQXJyYXkgKmJ1ZiwgaW50IHJl
Zyk7DQo+Pj4gICAgaW50IGFhcmNoNjRfY3B1X2dkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0
ZSAqY3B1LCB1aW50OF90ICpidWYsIGludCByZWcpOw0KPj4+ICAgIHZvaWQgYWFyY2g2NF9z
dmVfbmFycm93X3ZxKENQVUFSTVN0YXRlICplbnYsIHVuc2lnbmVkIHZxKTsNCj4+PiBAQCAt
MTI1NCwxMyArMTI1Myw2IEBAIHN0YXRpYyBpbmxpbmUgdWludDY0X3QgKnN2ZV9ic3dhcDY0
KHVpbnQ2NF90ICpkc3QsIHVpbnQ2NF90ICpzcmMsIGludCBucikNCj4+PiAgICAjZW5kaWYN
Cj4+PiAgICB9DQo+Pj4NCj4+PiAtI2Vsc2UNCj4+PiAtc3RhdGljIGlubGluZSB2b2lkIGFh
cmNoNjRfc3ZlX25hcnJvd192cShDUFVBUk1TdGF0ZSAqZW52LCB1bnNpZ25lZCB2cSkgeyB9
DQo+Pj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBhYXJjaDY0X3N2ZV9jaGFuZ2VfZWwoQ1BVQVJN
U3RhdGUgKmVudiwgaW50IG8sDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaW50IG4sIGJvb2wgYSkNCj4+PiAteyB9DQo+Pj4gLSNlbmRpZg0KPj4+
IC0NCj4+PiAgICB2b2lkIGFhcmNoNjRfc3luY18zMl90b182NChDUFVBUk1TdGF0ZSAqZW52
KTsNCj4+PiAgICB2b2lkIGFhcmNoNjRfc3luY182NF90b18zMihDUFVBUk1TdGF0ZSAqZW52
KTsNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2hlbHBlci5jIGIvdGFyZ2V0
L2FybS9oZWxwZXIuYw0KPj4+IGluZGV4IGI0NmIyYmZmY2YzLi43NzRlMWVlMDI0NSAxMDA2
NDQNCj4+PiAtLS0gYS90YXJnZXQvYXJtL2hlbHBlci5jDQo+Pj4gKysrIGIvdGFyZ2V0L2Fy
bS9oZWxwZXIuYw0KPj4+IEBAIC02NTYyLDcgKzY1NjIsOSBAQCBzdGF0aWMgdm9pZCB6Y3Jf
d3JpdGUoQ1BVQVJNU3RhdGUgKmVudiwgY29uc3QgQVJNQ1BSZWdJbmZvICpyaSwNCj4+PiAg
ICAgICAgICovDQo+Pj4gICAgICAgIG5ld19sZW4gPSBzdmVfdnFtMV9mb3JfZWwoZW52LCBj
dXJfZWwpOw0KPj4+ICAgICAgICBpZiAobmV3X2xlbiA8IG9sZF9sZW4pIHsNCj4+PiArI2lm
ZGVmIFRBUkdFVF9BQVJDSDY0DQo+Pg0KPj4gV2hhdCBhYm91dCB1c2luZyBydW50aW1lIGNo
ZWNrIGluc3RlYWQ/DQo+Pg0KPj4gICAgaWYgKGFybV9mZWF0dXJlKCZjcHUtPmVudiwgQVJN
X0ZFQVRVUkVfQUFSQ0g2NCkgJiYgbmV3X2xlbiA8IG9sZF9sZW4pIHsNCj4+DQo+IA0KPiBU
aGF0IHdvdWxkIGJlIGEgZGVhZCBjaGVjazogaXQgaXMgbm90IHBvc3NpYmxlIHRvIGdldCBo
ZXJlDQo+IHVubGVzcyBBUk1fRkVBVFVSRV9BQVJDSDY0IGlzIHNldC4NCj4gDQoNCldlIGNh
biB0aGVuIGFzc2VydCBpdCwgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG5vIHJlZ3Jlc3Npb24g
YXJvdW5kIHRoYXQuDQoNCldlIG5vdyBoYXZlIGFub3RoZXIgY29udmVyc2F0aW9uIGFuZCBz
b21ldGhpbmcgdG8gZGVjaWRlIGluIGFub3RoZXIgDQpmaWxlLCBhbmQgdGhhdCdzIHdoeSBJ
IGNob3NlIHRvIGRvIHRoZSBtaW5pbWFsIGNoYW5nZSAoImlmZGVmIHRoZSANCmlzc3VlIikg
aW5zdGVhZCBvZiB0cnlpbmcgdG8gZG8gYW55IGNoYW5nZS4NCg0KPiB0aGFua3MNCj4gLS0g
UE1NDQoNCg==

