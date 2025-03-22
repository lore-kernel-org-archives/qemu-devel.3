Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C032C36001
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Mar 2025 00:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvmb8-0007th-Pl; Fri, 21 Mar 2025 20:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvmb3-0007pl-80
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 20:20:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvmb1-0005zd-H7
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 20:20:16 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-225b5448519so52003045ad.0
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 17:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742602814; x=1743207614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gmihTeepoM01G32VwMRKIpoRxTtCyWjhxO8/HlXx56w=;
 b=zA1qCiz3g9uAI7hYDD3n5U0OfSZce+bml+npVJos6ENYcrsoHbCf5v6SLcM7fdW0NI
 V+HCCMv0zs3+K85GTDMHyLHQ0zdg5u1ZSwxG8ODu6W1Cd7VkhOofaQ2dfKFv0i/WsHw2
 DLQqIaTI4LaEPJfN7qpUbKPKkowY6B5RhbW3XNZkmHSyToVQA/blwcTRm46fzM1Fz4oj
 2sECgQAqH0UZp+Fw/p1Tl9FLIjvt+cuxwztZOpqjMExSZh1HBVUXQ94HzVBHVxXeE5T2
 GAzP7nAD31uRVqhexeA34/oXHJb/rCdOnK413JPRYpirpeBsFazdcAhh9nmd5/iN4d+i
 S3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742602814; x=1743207614;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmihTeepoM01G32VwMRKIpoRxTtCyWjhxO8/HlXx56w=;
 b=aNt82p2gqKutINHJwQB5I7ykcG2dvD2DbQD30I49vlACnIR0p/Q4BwPjxFbQb1mzdd
 KpgDt9hudEmYqhIxHsRlFqgOw7H/5/4xcheDJvN7qiz4/n/CmCaR5+jL9K43f19UPg0d
 BufyxxsUp1Z3Bg6IsHkSOlnNh0SuchUI6rjJAVPu8sWwl/gP8x9sq5CNdPmHR5slvuzD
 k22Pv19MVR3RE8QRNpXkdpHSI4pgMDzwwrtLQbLfAY4Brvx/2doNrJqwD0Lky1hH1JYo
 eOVjI+OyzvuZLRb+IcSGR9hJHpAsEvCrpt5D1J0pX8M62hqXoqusOxQiAf0X+IKwUHn/
 YJTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVV5n+W5a10IZi2TYKEfFGoULPUnLiYo3UM5vEsjYbgjmHQ7cbwZeAf8TxwW0XB+zWYtmTwMxUlTJk@nongnu.org
X-Gm-Message-State: AOJu0YxvqaB8lMTnupaBu7xqgl5+XxMHjyuuxiMMAppcsS7Pa+XJnsUT
 vwZpVRWwJd4bAgmGbmOMER7vXp+iwEtc/mr1Ab++nuDTri9w1upkdGjejLgKS5s=
X-Gm-Gg: ASbGncsml7b3FRCixHSzmSkBO+1TfYxZpZuvtUuwT3YuMVMNF1B8plvMGVlop2K4qjC
 OsQdXDzu9mWD0vSOYwlJiVVZspwXeu5TKPd4d3uKzYzht+Y92XjCC0mGSOU/DALZi/mU4HPE+27
 v1Lo45DNF1srXFMz89dTVlPvyREiZP5ZVpOHKzODqN0h2izbEFeQt9O91e4+NPSiD+lfo3QWndF
 mz/umWjL+VWiuWPGZuD+1mc8JEirTWogS49pcZ54Ut1Q/NlYtw2kXDaKtM9fVmAhrPtppLsac+6
 OfMsKNi/k+rIeHrVRNOH09uG3GRKKSr1DkgtviiStmoKXHkStOS1gx59fsZMaD4COB2w
X-Google-Smtp-Source: AGHT+IEiwshH0mEB0ml11+5ohr1OVAQK1GvcSU9JeTsnEj9XYL0ycGei7ChHq5z6xhuvXYlP6cdGKQ==
X-Received: by 2002:a17:903:18c:b0:220:d909:1734 with SMTP id
 d9443c01a7336-22780c7a955mr74702015ad.14.1742602814010; 
 Fri, 21 Mar 2025 17:20:14 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf576aa7sm6892181a91.4.2025.03.21.17.20.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 17:20:13 -0700 (PDT)
Message-ID: <c1b7b73e-0a59-46cf-bf33-5712df5d9b75@linaro.org>
Date: Fri, 21 Mar 2025 17:20:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 17/30] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-18-pierrick.bouvier@linaro.org>
 <2e667bb0-7357-4caf-ab60-4e57aabdceeb@linaro.org>
 <e738b8b8-e06f-48d0-845e-f263adb3dee5@linaro.org>
 <a67d17bb-e0dc-4767-8a43-8f057db70c71@linaro.org>
 <216a39c6-384d-4f9e-b615-05af18c6ef59@linaro.org>
 <c0e338f5-6592-4d83-9f17-120b9c4f039e@linaro.org>
 <ebd25730-1947-4360-af36-cf1131f4155c@linaro.org>
Content-Language: en-US
In-Reply-To: <ebd25730-1947-4360-af36-cf1131f4155c@linaro.org>
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

T24gMy8yMS8yNSAxNzowMSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gMy8yMS8y
NSAxNToxOSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+PiBPbiAzLzIxLzI1IDEzOjEx
LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IE9uIDMvMjEvMjUgMTI6MjcsIFJpY2hh
cmQgSGVuZGVyc29uIHdyb3RlOg0KPj4+PiBPbiAzLzIxLzI1IDExOjA5LCBQaWVycmljayBC
b3V2aWVyIHdyb3RlOg0KPj4+Pj4+IE1tbSwgb2sgSSBndWVzcy7CoCBZZXN0ZXJkYXkgSSB3
b3VsZCBoYXZlIHN1Z2dlc3RlZCBtZXJnaW5nIHRoaXMgd2l0aCBwYWdlLXZhcnkuaCwgYnV0
DQo+Pj4+Pj4gdG9kYXkgSSdtIGFjdGl2ZWx5IHdvcmtpbmcgb24gbWFraW5nIFRBUkdFVF9Q
QUdFX0JJVFNfTUlOIGEgZ2xvYmFsIGNvbnN0YW50Lg0KPj4+Pj4+DQo+Pj4+Pg0KPj4+Pj4g
V2hlbiB5b3UgbWVudGlvbiB0aGlzLCBkbyB5b3UgbWVhbiAiY29uc3RhbnQgYWNjcm9zcyBh
bGwgYXJjaGl0ZWN0dXJlcyIsIG9yIGEgZ2xvYmFsDQo+Pj4+PiAoY29uc3QpIHZhcmlhYmxl
IHZzIGhhdmluZyBhIGZ1bmN0aW9uIGNhbGw/DQo+Pj4+IFRoZSBmaXJzdCAtLSBjb25zdGFu
dCBhY3Jvc3MgYWxsIGFyY2hpdGVjdHVyZXMuDQo+Pj4+DQo+Pj4NCj4+PiBUaGF0J3MgZ3Jl
YXQuDQo+Pj4gRG9lcyBjaG9vc2luZyB0aGUgbWluKHNldF9vZihUQVJHRVRfUEFHRV9CSVRT
X01JTikpIGlzIHdoYXQgd2Ugd2FudCB0aGVyZSwgb3IgaXMgdGhlDQo+Pj4gYW5zd2VyIG1v
cmUgc3VidGxlIHRoYW4gdGhhdD8NCj4+DQo+PiBJdCB3aWxsIGJlLCB5ZXMuDQo+Pg0KPj4g
VGhpcyBpc24ndCBhcyBoYXJkIGFzIGl0IHNlZW1zLCBiZWNhdXNlIHRoZXJlIGFyZSBleGFj
dGx5IHR3byB0YXJnZXRzIHdpdGgNCj4+IFRBUkdFVF9QQUdFX0JJVFMgPCAxMjogYXJtIGFu
ZCBhdnIuDQo+Pg0KPj4gQmVjYXVzZSB3ZSBzdGlsbCBzdXBwb3J0IGFybXY0LCBUQVJHRVRf
UEFHRV9CSVRTX01JTiBtdXN0IGJlIDw9IDEwLg0KPj4NCj4+IEFWUiBjdXJyZW50bHkgaGFz
IFRBUkdFVF9QQUdFX0JJVFMgPT0gOCwgd2hpY2ggaXMgYSBiaXQgb2YgYSBwcm9ibGVtLg0K
Pj4gTXkgZmlyc3QgdGFzayBpcyB0byBhbGxvdyBhdnIgdG8gY2hvb3NlIFRBUkdFVF9QQUdF
X0JJVFNfTUlOID49IDEwLg0KPj4NCj4+IFdoaWNoIHdpbGwgbGVhdmUgdXMgd2l0aCBUQVJH
RVRfUEFHRV9CSVRTX01JTiA9PSAxMC4NCj4+DQo+IA0KPiBPay4NCj4gDQo+ICAgRnJvbSB3
aGF0IEkgdW5kZXJzdGFuZCwgd2UgbWFrZSBzdXJlIHRsYiBmbGFncyBhcmUgc3RvcmVkIGlu
IGFuDQo+IGltbXV0YWJsZSBwb3NpdGlvbiwgd2l0aGluIHZpcnR1YWwgYWRkcmVzc2VzIHJl
bGF0ZWQgdG8gZ3Vlc3QsIGJ5IHVzaW5nDQo+IGxvd2VyIGJpdHMgYmVsb25naW5nIHRvIGFk
ZHJlc3MgcmFuZ2UgaW5zaWRlIGEgZ2l2ZW4gcGFnZSwgc2luY2UgcGFnZQ0KPiBhZGRyZXNz
ZXMgYXJlIGFsaWduZWQgb24gcGFnZSBzaXplLCBsZWF2aW5nIHRob3NlIGJpdHMgZnJlZS4N
Cj4gDQo+IGJpdHMgWzAuLjIpIGFyZSBic3dhcCwgd2F0Y2hwb2ludCBhbmQgY2hlY2tfYWxp
Z25lZC4NCj4gYml0cyBbVEFSR0VUX1BBR0VfQklUU19NSU4gLSA1Li5UQVJHRVRfUEFHRV9C
SVRTX01JTikgYXJlIHNsb3csDQo+IGRpc2NhcmRfd3JpdGUsIG1taW8sIG5vdGRpcnR5LCBh
bmQgaW52YWxpZCBtYXNrLg0KPiBBbmQgdGhlIGNvbXBpbGUgdGltZSBjaGVjayB3ZSBoYXZl
IGlzIHRvIG1ha2Ugc3VyZSB3ZSBkb24ndCBvdmVybGFwDQo+IHRob3NlIHNldHMgKHdvdWxk
IGhhcHBlbiBpbiBUQVJHRVRfUEFHRV9CSVRTX01JTiA8PSA3KS4NCj4gDQo+IEkgd29uZGVy
IHdoeSB3ZSBjYW4ndCB1c2UgYml0cyBbMy4uOCkgZXZlcnl3aGVyZSwgbGlrZSBpdCdzIGRv
bmUgZm9yDQo+IEFWUiwgZXZlbiBmb3IgYmlnZ2VyIHBhZ2Ugc2l6ZXMuIEkgbm90aWNlZCB0
aGUgY29tbWVudCBhYm91dCAiYWRkcmVzcw0KPiBhbGlnbm1lbnQgYml0cyIsIGJ1dCBJJ20g
Y29uZnVzZWQgd2h5IGJpdHMgWzAuLjIpIGNhbiBiZSB1c2VkLCBhbmQgbm90DQo+IHVwcGVy
IG9uZXMuDQo+IA0KPiBBcmUgd2Ugc3RvcmluZyBzb21ldGhpbmcgZWxzZSBpbiB0aGUgbWlk
ZGxlIG9uIG90aGVyIGFyY2hzLCBvciBkaWQgSQ0KPiBtaXNzIHNvbWUgcGllY2Ugb2YgdGhl
IHB1enpsZT8NCj4gDQoNCkFmdGVyIGxvb2tpbmcgYmV0dGVyLCBUTEJfU0xPV19GTEFHUyBh
cmUgbm90IHBhcnQgb2YgYWRkcmVzcywgc28gd2UgDQpkb24ndCB1c2UgYml0cyBbMC4uMiku
DQoNCkZvciBhIGdpdmVuIFRBUkdFVF9QQUdFX1NJWkUsIGhvdyBkbyB3ZSBkZWZpbmUgYWxp
Z25tZW50IGJpdHM/DQoNCj4gVGhhbmtzLA0KPiBQaWVycmljaw0KPiANCj4+DQo+PiByfg0K
PiANCg0K

