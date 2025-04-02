Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D7CC28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 15:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzzy2-0002wM-VA; Wed, 02 Apr 2025 11:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzzxp-0002uE-Ox
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:25:14 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tzzxn-00025r-Ug
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 11:25:13 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso340991b3a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743607510; x=1744212310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cx8+TpYzNRgjiV6IWF30R39Lr38y3gIFRuMPt3h82Vs=;
 b=GCluyxgU7AHXLj/MDUalndpCyWc14WWrleUsZbqjVq8CgeaSOiRVTfqCnYKndXZbHn
 RR8oBewgLGzeUaezXbGswnV455cvgtcvDdEN1uLX203bDFfwcXElcV5gkCr1NpLVF3VA
 NR5KD0OtxYPkufMVCcaOhanQQQ1kQk9eV8P4LtucTosfNpTqvIlgezPzR56crKnMSHXE
 s8ibMAEXOwe0FGnt7LFe84SPacDAplEXC0pxPgut5WM9KH/5ShHXbBA9PtKcRJH/IEJc
 0U7Ia/fGokN7dUc8IpSZZL8H865bSPwwz6n/UU1MVYlsyp+EaTBm3h+Ldig8P2bcny6e
 D4pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743607510; x=1744212310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cx8+TpYzNRgjiV6IWF30R39Lr38y3gIFRuMPt3h82Vs=;
 b=Sn/2juaGC/hunyVwfcKVN8dEfPTbITKfH47GWCPo89qP0MO5/Ynrd6wMP+s4T/cKB4
 7KGbEYTHcrGTjY3BM86w8tEom9LEPJ3qMb2Qdh6n1U4PdacRFy30tZhdUrArmpbtTCzj
 ZBVP5JTUqDu78bx8BSwhE99SN7LnsT1Rr1SPfBwglobqlIokybPFvl3F7PsomAvkNldS
 O4sVkQjlXbS0FpI/CZzDeKTRWWOV2KkGK3mki4TDmp5pjmBd4Vqp18MjOcWnM4Yhkfzl
 PCcPaGGkpLiJEPHS/hb9H5efzEFSoejgOJ9Io0/LIA6R4h/rCDOD+GuRVkDPydg6ZeQZ
 i5jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCU0AbjhvnSCNR74ZX/dgFYTDr9q0sFLAaV2JhuI0dz/e9OtR7zQIIGShjFS8r+vqxd2ufAQx+C8jr@nongnu.org
X-Gm-Message-State: AOJu0YwpTy7QJoLTCNfwB2qUz4UxPkt7BHJmAzYpBaH7ZnscIT8dRSfr
 K+r0YN5AQrbEGAFzWpDqtSkSgTBWiA8UmPsyePqE2FfDRBOQqEeWvucOs82sr9o=
X-Gm-Gg: ASbGncuubVZzPEuOLqvgiH0kA2HjcAMpm5pZCTNLZwo6DTPsNtZxwTAo9E43fAEkzAh
 Q+K1+Intsh8LNrru2l7y5fzGcTGeP6BOVhN8EJIcaxrhXCB2N4fIHePP5EPv4WPCyK1WRbmxZTp
 Jx1pL+cCb2XJ211qf9IYQR9uhUje0G9CYub5mQ5WDeUaeOo+qz5TxTzM4ilTT+NjDDVLZMACFYK
 teQfdCPBvp6Dygy8PK6O7Au8PA8EO7pk3G8kQ31nMHzJedK3v6voEHnc+eqqEWHDOWOU3XSR1JG
 EpH6uNTupKNnFcSHH1B3t/66+gc+Ik+lf11jaaTNQ8h++UJt33uuEy3WZw==
X-Google-Smtp-Source: AGHT+IHKMqp53wunIMnK9HnaQVXKKO/uyWdrxdLYqEqNY5EMIwtYdBJ37QQg4k9gyF9l6HILW7KIkg==
X-Received: by 2002:a05:6a21:150e:b0:1f5:83da:2f9f with SMTP id
 adf61e73a8af0-2009f609015mr27159264637.12.1743607510247; 
 Wed, 02 Apr 2025 08:25:10 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b8b1aa6sm10090857a12.52.2025.04.02.08.25.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 08:25:09 -0700 (PDT)
Message-ID: <319fd6a2-93c1-42ec-866b-86e4d01b4b39@linaro.org>
Date: Wed, 2 Apr 2025 08:25:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/29] include/exec/cpu-all: move compile time check
 for CPUArchState to cpu-target.c
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
 <20250325045915.994760-4-pierrick.bouvier@linaro.org>
 <e11f5f2e-0838-4f28-88c1-a7241504d28a@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e11f5f2e-0838-4f28-88c1-a7241504d28a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

T24gNC8xLzI1IDIwOjMxLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
MjUvMy8yNSAwNTo1OCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+IFJldmlld2VkLWJ5
OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4+
IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCj4+IC0tLQ0KPj4gICAgaW5jbHVkZS9leGVjL2NwdS1hbGwuaCB8IDQgLS0t
LQ0KPj4gICAgY3B1LXRhcmdldC5jICAgICAgICAgICB8IDQgKysrKw0KPj4gICAgMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9jcHUtYWxsLmggYi9pbmNsdWRlL2V4ZWMvY3B1LWFs
bC5oDQo+PiBpbmRleCA3NDAxN2E1Y2U3Yy4uYjEwNjcyNTllNmIgMTAwNjQ0DQo+PiAtLS0g
YS9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5oDQo+PiArKysgYi9pbmNsdWRlL2V4ZWMvY3B1LWFs
bC5oDQo+PiBAQCAtMzQsOCArMzQsNCBAQA0KPj4gICAgDQo+PiAgICAjaW5jbHVkZSAiY3B1
LmgiDQo+IA0KPiBUaGlzIGluY2x1ZGUgXl5eXl5eIC4uLg0KPiANCj4+ICAgIA0KPj4gLS8q
IFZhbGlkYXRlIGNvcnJlY3QgcGxhY2VtZW50IG9mIENQVUFyY2hTdGF0ZS4gKi8NCj4+IC1R
RU1VX0JVSUxEX0JVR19PTihvZmZzZXRvZihBcmNoQ1BVLCBwYXJlbnRfb2JqKSAhPSAwKTsN
Cj4+IC1RRU1VX0JVSUxEX0JVR19PTihvZmZzZXRvZihBcmNoQ1BVLCBlbnYpICE9IHNpemVv
ZihDUFVTdGF0ZSkpOw0KPj4gLQ0KPj4gICAgI2VuZGlmIC8qIENQVV9BTExfSCAqLw0KPj4g
ZGlmZiAtLWdpdCBhL2NwdS10YXJnZXQuYyBiL2NwdS10YXJnZXQuYw0KPj4gaW5kZXggNTE5
YjBmODkwMDUuLjU4N2YyNGIzNGU1IDEwMDY0NA0KPj4gLS0tIGEvY3B1LXRhcmdldC5jDQo+
PiArKysgYi9jcHUtdGFyZ2V0LmMNCj4+IEBAIC0yOSw2ICsyOSwxMCBAQA0KPj4gICAgI2lu
Y2x1ZGUgImFjY2VsL2FjY2VsLWNwdS10YXJnZXQuaCINCj4+ICAgICNpbmNsdWRlICJ0cmFj
ZS90cmFjZS1yb290LmgiDQo+IA0KPiAuLi4gaXMgYWxzbyBuZWVkZWQgaGVyZSwgb3RoZXJ3
aXNlIHdlIGdldDoNCj4gDQo+IC4uLy4uL2NwdS10YXJnZXQuYzozMDoxOTogZXJyb3I6IG9m
ZnNldG9mIG9mIGluY29tcGxldGUgdHlwZSAnQXJjaENQVScNCj4gKGFrYSAnc3RydWN0IEFy
Y2hDUFUnKQ0KPiAgICAgIDMwIHwgUUVNVV9CVUlMRF9CVUdfT04ob2Zmc2V0b2YoQXJjaENQ
VSwgcGFyZW50X29iaikgIT0gMCk7DQo+ICAgICAgICAgfCAgICAgICAgICAgICAgICAgICBe
DQo+IA0KPj4gICAgDQo+ICAgPiArLyogVmFsaWRhdGUgY29ycmVjdCBwbGFjZW1lbnQgb2Yg
Q1BVQXJjaFN0YXRlLiAqLz4NCj4gK1FFTVVfQlVJTERfQlVHX09OKG9mZnNldG9mKEFyY2hD
UFUsIHBhcmVudF9vYmopICE9IDApOw0KPj4gK1FFTVVfQlVJTERfQlVHX09OKG9mZnNldG9m
KEFyY2hDUFUsIGVudikgIT0gc2l6ZW9mKENQVVN0YXRlKSk7DQo+PiArDQo+PiAgICBjaGFy
ICpjcHVfbW9kZWxfZnJvbV90eXBlKGNvbnN0IGNoYXIgKnR5cGVuYW1lKQ0KPj4gICAgew0K
Pj4gICAgICAgIGNvbnN0IGNoYXIgKnN1ZmZpeCA9ICItIiBDUFVfUkVTT0xWSU5HX1RZUEU7
DQo+IA0KPiBXaXRoICJjcHUuaCIgaW5jbHVkZToNCj4gUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gVGVzdGVkLWJ5OiBQaGls
aXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IA0KDQpJIGNhbid0
IHJlcHJvZHVjZSB0aGlzIGVycm9yLg0KV2l0aCB0aGlzIHNlcmllcywgY3B1LmggaXMgcHVs
bGVkIHRyYW5zaXRpdmVseSBmcm9tIA0KImFjY2VsL2FjY2VsLWNwdS10YXJnZXQuaCIuIElk
ZWFsbHksIGl0IHdvdWxkIGJlIGJldHRlciB0byBhZGQgaXQgDQpleHBsaWNpdGVseSB5ZXMu
DQoNCkBSaWNoYXJkLCBjb3VsZCB5b3UgcGxlYXNlIGFtZW5kIHRoaXMgY29tbWl0IG9uIHRj
Zy1uZXh0IGFuZCBhZGQgYSANCmRpcmVjdCBpbmNsdWRlIHRvIGNwdS5oPw0KDQpUaGFua3Ms
DQpQaWVycmljaw0K

