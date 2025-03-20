Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9348EC36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:37:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLh5-0007ik-NB; Thu, 20 Mar 2025 15:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLgx-0007eE-2R
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:36:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLgs-0006nZ-55
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:36:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so36610875ad.0
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499387; x=1743104187; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TpF7et11Cx87OlsvQUvvY3RH1yF9ugGZeGJrN3A7upI=;
 b=tH7WbBkbtxIP3TbxNaRTHmPPJJgeTO01PLsNP4/XQIO1M2mSPbAQYskqdHcFXm0RGR
 hJbC5UlVaaUiRXQIwtxrvEitcUGxcgv8fAR04pPuz95i0L+xX+jN6jtmZG1HXnsBMks4
 uRsQeif7zt6m0P7bwmLuXHs0dxvw4fGJc4n1m4xCufmPYRJ8mu8I6M812ZZXeiV5D1H/
 NzRCz3KGKPRYxTEhjD/9BPr1XF0B2HF7lvNezr+I7Wk/I7QbdR1HyR3Zd6CeOUqWbJHg
 BR+xR8hHyxwmvB6xtGOlwunsUUROuDNQ8gWWOQBr0eCmYYgZ6eOM1r1uYO3iK8lf/mfR
 zKHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499387; x=1743104187;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TpF7et11Cx87OlsvQUvvY3RH1yF9ugGZeGJrN3A7upI=;
 b=oXS+C2F5k4dSL23XtmpwlBRATvY6KAJsS1HqED9REwdET00zlO2fvLpNc63VidgrRj
 C+r0bp3ju+v1LXaNlCmSVht5v4qHFvWCjn+r7xwENI/tIPgZXyRoL1nkRGoCri5TIVN0
 0r7W7Fz8LkDnMZ8ed3jD9Y5HNlf4wYrWTShdLqze9sYnviN658bnH3Lb4axgggLNl4Hh
 wmTvbFr7BgNqdHB5+IAKk+lkPx6zolQIIUA8EJm6X5IiI+dta/5Uj4DjO8G50sc0dNMe
 trlDUX0Ayz9uYL5L3V+hfddlwENoEyKlFZjJ6/m50+v4v+kN0acC6m9mwOAuTPdYZsuV
 750w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXijX08eojjrwX75gYOe779zVhB1Hp0YVfhA8bb5SwhaB2xyxwFo19QKvl4udMRnLopO9B2DncS2XTb@nongnu.org
X-Gm-Message-State: AOJu0YyQEYd4YvNIk865XjPTzf4AiqB8/7BV8xU8l3hl+r1bI367k1dW
 v/mCakVfSlHqre9X1TM0/NhxQsyy25UYRAYbJyE4gs41QThfFRHjEBtmuNefUqE=
X-Gm-Gg: ASbGncvQb7o0O1aTAkFu2zxlpip3PHQ4yeIFUE7ZngZxxIruzLMbZbWalrc9gsg/hQz
 qAG4cN9X+e81e5z6vv119sBa5DEI4W55rei221wnLLB57Yha6ZnD9Em4q1FcUt59C2jdZKpn2f1
 9PmpchyAgy99Dvw3s+k1B8WgWJ6usU9ii4w+ZFrfBjlCGiHz+t4cOPH5ObhBThHBZz8e+CSdcEb
 ViczZ7C4Cwaftab9O7mJocswdPoiRv5DBo9mcGZr7zK19P3E56rJ0ckM+1NcGYChPycDPQTvIPt
 UvF+Nf6ybxfqFKNk62P4TZFz6V2ahGMkNBpg6h4WkbDrFSnS38YMhL3eug==
X-Google-Smtp-Source: AGHT+IGqeJgxmMwaHS8+WqPUmMVg89q9mOSC8W6m260dbGfzpYHHaXHnXB8h73kdnlitnTRbkYvI8A==
X-Received: by 2002:a17:903:2348:b0:21f:7e12:5642 with SMTP id
 d9443c01a7336-22780d787a0mr7339645ad.18.1742499387333; 
 Thu, 20 Mar 2025 12:36:27 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811f14dfsm1691635ad.220.2025.03.20.12.36.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:36:26 -0700 (PDT)
Message-ID: <1bc5463d-1e37-4a92-b43d-2d4b61cc19ff@linaro.org>
Date: Thu, 20 Mar 2025 12:36:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
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
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20250319182255.3096731-1-alex.bennee@linaro.org>
 <20250319182255.3096731-3-alex.bennee@linaro.org>
 <2c441f75-8fd8-4792-a4e4-1ae7c78754ba@linaro.org>
In-Reply-To: <2c441f75-8fd8-4792-a4e4-1ae7c78754ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMy8yMC8yNSAxMjozMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMy8xOS8y
NSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gVGhlIGN1cnJlbnQgaGVscGVyLmgg
ZnVuY3Rpb25zIHJlbHkgb24gaGFyZCBjb2RlZCBhc3N1bXB0aW9ucyBhYm91dA0KPj4gdGFy
Z2V0IGVuZGlhbmVzcyB0byB1c2UgdGhlIHRzd2FwIG1hY3Jvcy4gV2UgYWxzbyBlbmQgdXAg
ZG91YmxlDQo+PiBzd2FwcGluZyBhIGJ1bmNoIG9mIHZhbHVlcyBpZiB0aGUgdGFyZ2V0IGNh
biBydW4gaW4gbXVsdGlwbGUgZW5kaWFuZXNzDQo+PiBtb2Rlcy4gQXZvaWQgdGhpcyBieSBn
ZXR0aW5nIHRoZSB0YXJnZXQgdG8gcGFzcyB0aGUgZW5kaWFuZXNzIGFuZCBzaXplDQo+PiB2
aWEgYSBNZW1PcCBhbmQgZml4aW5nIHVwIGFwcHJvcHJpYXRlbHkuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPj4gLS0t
DQo+PiAgICBpbmNsdWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmggfCAzMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4+ICAgIGdkYnN0dWIvZ2Ric3R1Yi5jICAgICAgICAgICB8
IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4+ICAgIDIgZmlsZXMgY2hhbmdlZCwgNTIg
aW5zZXJ0aW9ucygrKQ0KPj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZ2Ric3R1
Yi9yZWdpc3RlcnMuaA0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2dkYnN0dWIvcmVn
aXN0ZXJzLmggYi9pbmNsdWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmgNCj4+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi40YWJjN2E2YWU3DQo+PiAtLS0gL2Rl
di9udWxsDQo+PiArKysgYi9pbmNsdWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmgNCj4+IEBAIC0w
LDAgKzEsMzAgQEANCj4+ICsvKg0KPj4gKyAqIEdEQiBDb21tb24gUmVnaXN0ZXIgSGVscGVy
cw0KPj4gKyAqDQo+PiArICogQ29weXJpZ2h0IChjKSAyMDI1IExpbmFybyBMdGQNCj4+ICsg
Kg0KPj4gKyAqIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+
PiArICovDQo+PiArDQo+PiArI2lmbmRlZiBHREJfUkVHSVNURVJTX0gNCj4+ICsjZGVmaW5l
IEdEQl9SRUdJU1RFUlNfSA0KPj4gKw0KPj4gKyNpbmNsdWRlICJleGVjL21lbW9wLmgiDQo+
PiArDQo+PiArLyoqDQo+PiArICogZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZSgpIC0gZ2V0IHJl
Z2lzdGVyIHZhbHVlIGZvciBnZGINCj4+ICsgKiBtbzogc2l6ZSBhbmQgZW5kaWFuIE1lbU9w
DQo+PiArICogYnVmOiBHQnl0ZUFycmF5IHRvIHN0b3JlIGluIHRhcmdldCBvcmRlcg0KPj4g
KyAqIHZhbDogcG9pbnRlciB0byB2YWx1ZSBpbiBob3N0IG9yZGVyDQo+PiArICoNCj4+ICsg
KiBUaGlzIHJlcGxhY2VzIHRoZSBwcmV2aW91cyBsZWdhY3kgcmVhZCBmdW5jdGlvbnMgd2l0
aCBhIHNpbmdsZQ0KPj4gKyAqIGZ1bmN0aW9uIHRvIGhhbmRsZSBhbGwgc2l6ZXMuIFBhc3Np
bmcgQG1vIGFsbG93cyB0aGUgdGFyZ2V0IG1vZGUgdG8NCj4+ICsgKiBiZSB0YWtlbiBpbnRv
IGFjY291bnQgYW5kIGF2b2lkcyB1c2luZyBoYXJkIGNvZGVkIHRzd2FwKCkgbWFjcm9zLg0K
Pj4gKyAqDQo+PiArICogUmV0dXJucyB0aGUgbnVtYmVyIG9mIGJ5dGVzIHdyaXR0ZW4gdG8g
dGhlIGFycmF5Lg0KPj4gKyAqLw0KPj4gK2ludCBnZGJfZ2V0X3JlZ2lzdGVyX3ZhbHVlKE1l
bU9wIG9wLCBHQnl0ZUFycmF5ICpidWYsIHVpbnQ4X3QgKnZhbCk7DQo+PiArDQo+PiArI2Vu
ZGlmIC8qIEdEQl9SRUdJU1RFUlNfSCAqLw0KPj4gKw0KPj4gKw0KPj4gZGlmZiAtLWdpdCBh
L2dkYnN0dWIvZ2Ric3R1Yi5jIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+IGluZGV4IDI4MmUx
M2UxNjMuLjNkN2IxMDI4ZTQgMTAwNjQ0DQo+PiAtLS0gYS9nZGJzdHViL2dkYnN0dWIuYw0K
Pj4gKysrIGIvZ2Ric3R1Yi9nZGJzdHViLmMNCj4+IEBAIC0zMiw2ICszMiw3IEBADQo+PiAg
ICAjaW5jbHVkZSAiZXhlYy9nZGJzdHViLmgiDQo+PiAgICAjaW5jbHVkZSAiZ2Ric3R1Yi9j
b21tYW5kcy5oIg0KPj4gICAgI2luY2x1ZGUgImdkYnN0dWIvc3lzY2FsbHMuaCINCj4+ICsj
aW5jbHVkZSAiZ2Ric3R1Yi9yZWdpc3RlcnMuaCINCj4+ICAgICNpZmRlZiBDT05GSUdfVVNF
Ul9PTkxZDQo+PiAgICAjaW5jbHVkZSAiYWNjZWwvdGNnL3ZjcHUtc3RhdGUuaCINCj4+ICAg
ICNpbmNsdWRlICJnZGJzdHViL3VzZXIuaCINCj4+IEBAIC00NSw2ICs0Niw3IEBADQo+PiAg
ICAjaW5jbHVkZSAic3lzdGVtL3J1bnN0YXRlLmgiDQo+PiAgICAjaW5jbHVkZSAiZXhlYy9y
ZXBsYXktY29yZS5oIg0KPj4gICAgI2luY2x1ZGUgImV4ZWMvaHdhZGRyLmgiDQo+PiArI2lu
Y2x1ZGUgImV4ZWMvbWVtb3AuaCINCj4+ICAgIA0KPj4gICAgI2luY2x1ZGUgImludGVybmFs
cy5oIg0KPj4gICAgDQo+PiBAQCAtNTUxLDYgKzU1MywyNiBAQCBzdGF0aWMgaW50IGdkYl93
cml0ZV9yZWdpc3RlcihDUFVTdGF0ZSAqY3B1LCB1aW50OF90ICptZW1fYnVmLCBpbnQgcmVn
KQ0KPj4gICAgICAgIHJldHVybiAwOw0KPj4gICAgfQ0KPj4gICAgDQo+PiArLyoNCj4+ICsg
KiBUYXJnZXQgaGVscGVyIGZ1bmN0aW9uIHRvIHJlYWQgdmFsdWUgaW50byBHQnl0ZUFycmF5
LCB0YXJnZXQNCj4+ICsgKiBzdXBwbGllcyB0aGUgc2l6ZSBhbmQgdGFyZ2V0IGVuZGlhbmVz
cyB2aWEgdGhlIE1lbU9wLg0KPj4gKyAqLw0KPj4gK2ludCBnZGJfZ2V0X3JlZ2lzdGVyX3Zh
bHVlKE1lbU9wIG9wLCBHQnl0ZUFycmF5ICpidWYsIHVpbnQ4X3QgKnZhbCkNCj4+ICt7DQo+
PiArICAgIHNpemVfdCBieXRlcyA9IG1lbW9wX3NpemUob3ApOw0KPj4gKw0KPj4gKyAgICBp
ZiAob3AgJiBNT19CU1dBUCkgew0KPj4gKyAgICAgICAgZm9yICggaW50IGkgPSBieXRlcyA7
IGkgPiAwOyBpLS0pIHsNCj4+ICsgICAgICAgICAgICBnX2J5dGVfYXJyYXlfYXBwZW5kKGJ1
ZiwgJnZhbFtpIC0gMV0sIDEpOw0KPj4gKyAgICAgICAgfTsNCj4+ICsgICAgfSBlbHNlIHsN
Cj4+ICsgICAgICAgIGdfYnl0ZV9hcnJheV9hcHBlbmQoYnVmLCB2YWwsIGJ5dGVzKTsNCj4+
ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByZXR1cm4gYnl0ZXM7DQo+PiArfQ0KPj4gKw0KPj4g
Kw0KPj4gICAgc3RhdGljIHZvaWQgZ2RiX3JlZ2lzdGVyX2ZlYXR1cmUoQ1BVU3RhdGUgKmNw
dSwgaW50IGJhc2VfcmVnLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZ2RiX2dldF9yZWdfY2IgZ2V0X3JlZywgZ2RiX3NldF9yZWdfY2Igc2V0X3JlZywNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IEdEQkZlYXR1cmUg
KmZlYXR1cmUpDQo+IA0KPiBJdCBjb3VsZCBiZSBwcmVmZXJhYmxlIHRvIHNldCBidWYgd2l0
aCB0aGUgdmFsdWUsIGluc3RlYWQgb2Ygc2ltcGx5DQo+IGFwcGVuZGluZyB0aGUgdmFsdWUu
IFRoaXMgd2F5LCB0aGVyZSBpcyBubyBuZWVkIHRvIHJldHVybiB0aGUgc2l6ZSwgYXMNCj4g
aXQncyBjb250YWluZWQgaW4gYnVmZmVyIHNpemUgaXRzZWxmLg0KPiANCj4gSWYgd2UgaW5z
aXN0IG9uIHJldHVybmluZyB0aGUgc2l6ZSwgaXQncyBiZXR0ZXIgdG8gbWFrZSBpdCBhIHBh
cmFtZXRlcg0KPiAoYW5kIHVzZSBhIHZvaWQgcGFyYW1ldGVyIHR5cGUpLCBiZWNhdXNlIGF0
IHRoZSBtb21lbnQsIGl0IGdpdmVzIHRoZQ0KPiBpbXByZXNzaW9uIHRoZSBmdW5jdGlvbiBp
dHNlbGYgcmV0dXJucyB0aGUgdmFsdWUsIHdoaWNoIG1heSBiZSBjb25mdXNpbmcuDQoNClNl
ZW1zIGxpa2UgaXQncyB0aGUgZXhpc3RpbmcgY29udmVudGlvbiB0aHJvdWdoIA0KZ2RiX3Nl
dF9yZWdfY2IvZ2RiX2dldF9yZWdfY2IsIHNvIHdlIGhhdmUgdG8gZm9sbG93IHRoaXMuDQo=


