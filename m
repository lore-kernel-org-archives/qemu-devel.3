Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6722E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 23:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWNyW-0002fa-Tk; Fri, 10 Jan 2025 17:59:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWNyU-0002ev-KD
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 17:59:30 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWNyT-0005ju-2b
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 17:59:30 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2163b0c09afso45970625ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 14:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736549966; x=1737154766; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xO1gZhEiz7qswTy1afo9NzQZly0JQn3J43Li6lQRGgU=;
 b=Fw08POUq4IXWvrQLJyhAh0cXZ9TX4+vpIEDoBr3wBGKQV+zb45gLm8MwHi9PqPaUbG
 HoPMwtxACuNx9JLEoe7tWNRRzb3cT2trTO/BfqikWv+JpTtWrlYpBXEjQCGBd8iJnpzJ
 jgIgkv6buTOoFpw9EUwJUX8nSm30KrtFGmnLUDvnkxVXciep4scXwr3gY2ylk2Yp3RlG
 6JdafPjbfo2FUPVkPZvKU03h1atMUI5FYLNbciMxId4EhVehXCxbcH5VbkCelT+tLfPL
 odq+KtRRjxfAza31i3lzoAEqvso845RTaLLwhtOtdVMoZ/FOzu6kk128mVXb6+n7tQjL
 qM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736549966; x=1737154766;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xO1gZhEiz7qswTy1afo9NzQZly0JQn3J43Li6lQRGgU=;
 b=UvHRqCDCa0YvTUoPuVs1Md11BGq+VT9X/dYB9UGM3Iq4MHnn8wHAr6oER1Nh3bHNLv
 T1uFHSVZU2YDOOx/E6W/J0hFT+0JL+SPnK1HmNvOBwaWY5ALwcZCK3P+D4gCRb0nreoY
 57kpXfrS5pwmDOt49x/9PJjTf2EFtiIqw9ub5uFmBS4oBy1C7+xNUjD4nL+4a3VLMMsd
 +bY2QO2slzp91Q9RAx/de5LKvQq0/5bcKj/y8tSQFofwmbc+vPJcTJi1gRVC8qqlRWj5
 jqdpVM2tBdbhYUltE+3fh603X4MR7c7WJvhQOcdtAWD3AEB1IHZHbWFmvXzVQNCpplMX
 5p8Q==
X-Gm-Message-State: AOJu0Yx5cYQjwmKv750NQTOB317UwXQ6vE3CbNdEfK/Cv3VlkLJHrAFD
 3LE9e7nooUSVwxwujjicDAG24+oyT1bjyQB/jfRSFO/gupV1PxU6/YZ/75hwOok=
X-Gm-Gg: ASbGncu4O2pOjyX48w5kBLoYSRkDfyguOfShTEa15WvHF1Lo4obsHV0qUzOcok7vv6+
 MVCP60k5NNT+63sh0nyV7bxOVQtsGEvftvczR1BER5CTAfB66DD/qfdNVLPqqd39XkBXXA2K/+Y
 qj5OdlUFqFMAaOk0mXSGIcBvg+EEOs50yQZWanph5+8oFcGjUx45DCwmrBBaTfFdrgfgp4x/jsw
 ghhtw+tY36myTPZmC/7pEV+MUaNAa3rnQZbPIR7mR+dFhO66fNaS+88Ut6zYUHZjDFoIA==
X-Google-Smtp-Source: AGHT+IFKiXzYwTNQwHK7rQsE2nt4Wqk3UwcViTRpJPGCy5KQeMMA9BWlgfROlFoMHuSc2b4Qngcp9g==
X-Received: by 2002:a17:903:1206:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-21a83f5d8c3mr165067195ad.27.1736549966338; 
 Fri, 10 Jan 2025 14:59:26 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f256b4csm17857425ad.215.2025.01.10.14.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 14:59:25 -0800 (PST)
Message-ID: <77f1cf6d-afba-4311-a15b-50594cb5fda0@linaro.org>
Date: Fri, 10 Jan 2025 14:59:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] docs/system/arm/virt: mention specific migration
 information
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <20241219183211.3493974-4-pierrick.bouvier@linaro.org>
 <CAFEAcA-LYWhtFaUanq_qS8nDEVdhDOhDR2kcKv8Ch_5fKSnv-Q@mail.gmail.com>
 <331d0b7b-40db-4a6b-80ba-178892f60506@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <331d0b7b-40db-4a6b-80ba-178892f60506@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gMS8xMC8yNSAxMzoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDEwLzEvMjUgMTc6MzAsIFBldGVyIE1heWRlbGwgd3JvdGU6DQo+PiBPbiBUaHUsIDE5IERl
YyAyMDI0IGF0IDE4OjMyLCBQaWVycmljayBCb3V2aWVyDQo+PiA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPiB3cm90ZToNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAg
ICBkb2NzL3N5c3RlbS9hcm0vdmlydC5yc3QgfCAxNCArKysrKysrKysrKy0tLQ0KPj4+ICAg
IDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+
DQo+Pj4gZGlmZiAtLWdpdCBhL2RvY3Mvc3lzdGVtL2FybS92aXJ0LnJzdCBiL2RvY3Mvc3lz
dGVtL2FybS92aXJ0LnJzdA0KPj4+IGluZGV4IGQyNTI3NWMyN2NlLi45ZjE0NTdjZjlhMiAx
MDA2NDQNCj4+PiAtLS0gYS9kb2NzL3N5c3RlbS9hcm0vdmlydC5yc3QNCj4+PiArKysgYi9k
b2NzL3N5c3RlbS9hcm0vdmlydC5yc3QNCj4gDQo+IA0KPj4+ICtWTSBtaWdyYXRpb24gaXMg
bm90IGd1YXJhbnRlZWQgd2hlbiB1c2luZyBgYC1jcHUgbWF4YGAsIGFzIGZlYXR1cmVzIHN1
cHBvcnRlZA0KPj4+ICttYXkgY2hhbmdlIGJldHdlZW4gUUVNVSB2ZXJzaW9ucy4gVG8gZW5z
dXJlIHlvdXIgVk0gY2FuIGJlIG1pZ3JhdGVkLCBpdCBpcw0KPj4+ICtyZWNvbW1lbmRlZCB0
byB1c2UgYW5vdGhlciBjcHUgbW9kZWwgaW5zdGVhZC4NCj4+DQo+PiBUaGlzIHBhcmFncmFw
aCBpcyBnb29kLCB0aG91Z2ggLS0gdGhhdCAnbWF4JyBkb2Vzbid0IHdvcmsgZm9yIG1pZ3Jh
dGlvbg0KPj4gaXMgaW1wb3J0YW50LCBhbmQgd2Ugc2hvdWxkIGRlZmluaXRlbHkgZG9jdW1l
bnQgdGhhdC4NCj4gDQo+IEFoIHllcywgSSd2ZSBiZWVuIHRoZXJlLiAyIGNsb3NlLWJ5IGNv
bW1lbnRzOg0KPiANCj4gLSAnbWF4JyBpcyBub3QgcmVzdHJpY3RlZCB0byB0aGUgJ3ZpcnQn
IEFSTSBtYWNoaW5lLCBidXQgdGhpcyBkb2N1bWVudA0KPiAgICAgaXMgYWJvdXQgaXQsIHdo
YXQgYWJvdXQgb3RoZXIgQVJNIG1hY2hpbmVzPw0KPiANCj4gLSBNb3JlIGdlbmVyYWxseSwg
Im1heCIgQ1BVIHdvbid0IG1pZ3JhdGUgZWFzaWx5IChpbiBkaWZmZXJlbnQgdmVyc2lvbnMp
DQo+ICAgICBvbiBhbGwgdGFyZ2V0IGFyY2hzLg0KPiANCj4gTm90IHN1cmUgd2hlcmUgdG8g
ZG9jdW1lbnQgdGhhdDsgbWF5YmUgYSBnZW5lcmljIGNoYXB0ZXIgdGhhdCBjYW4gYmUNCj4g
aW5jbHVkZWQgaW4gYSBib2FyZC5yc3QgdGVtcGxhdGU/DQoNCkl0J3MgYSBnb29kIHBvaW50
Lg0KTWF5YmUgc29tZXdoZXJlIGluIGRvY3MvZGV2ZWwvbWlncmF0aW9uLCB3aGVyZSB2ZXJz
aW9uaW5nIGlzIG1lbnRpb25lZD8NCg==

