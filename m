Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5D64CDDE7D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dAi-0003Fl-CE; Wed, 23 Oct 2024 11:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3dAg-0003FO-Sm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:21:14 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3dAf-0004Lp-2E
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:21:14 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e18293a5efso4650310a91.3
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729696871; x=1730301671; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pma820h/udrnuyqL42rfM5cse48rj0H2UR3XlJNJfiA=;
 b=eob2OV2kra97qTX9RYnjCpYApHvR7WmqnuH0ixr6NkQDAaHd30sMFnXOtRPHhx1ZRs
 PkXnXveSbDs2awLPajpX41aS3bUHC86BYINKXKW7pSgIOpo5+3534BbOYyMBgKvAxxno
 nBSXGOkHzcnLQEE6E2d+8/sF8YG5YoQjqGAVD0XWh0SL7DtJIWA0TWPAD+FBoBPh8kPh
 S7+Xi2RHCN1MzlfS1m9v1HTIN1VvtktC7jTnosLo95hskWepR2kSrfCLlFvB1ba9zEk9
 VeTEscJVL6m+wIIaYF2t9eUyZAWXfiUbEGF6D0s2HWWvlUc78mKS8puQA+x7iQbTSt3H
 RB6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729696871; x=1730301671;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pma820h/udrnuyqL42rfM5cse48rj0H2UR3XlJNJfiA=;
 b=DzeHb2Qk1OkJKtOuHvEUoQbvfJnBkbvgVeQG1fJAHC+2SXehDxRcvmJZPl1n2lWTwh
 ZJzyT2t6G3Bf37+1FlO0r3zD+gfNZ6i95brZFzi9OI5J/RmqAoWMgHqtq2ErBLOotBRm
 AFYFzt4SrSN9Ap4qkTfkbmxaIQ7kFnOh+kKsXCGF4BPe+KKCmET2tQhnB89Oer1LLqrx
 BIi7DHJsG90AF6OLwYg6orhfg/3m6t5iKgq21TGTcnbE5aApPEZnpUcH02N2edv7oQtD
 DNnig4+rhhnwYCj/d7hm08lhjWmzapblgkZaMV9FhdFiSLUg+KRN1rD+3WVgpbRp35VP
 gEPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbs4ab1WMojfNrh/ObL8bS739Q+Vf9E0c/uni/qZOdROWQ2qNA28cjyREr9lvBuMhzo8n3ekngPVGv@nongnu.org
X-Gm-Message-State: AOJu0Yz1AzwrtRwbmjJzPKsdMabZQtyFygNAMzvOhrOXM2wBemVEC+UI
 Q/QcBlqNWkuFotM3TBeXCwxGcn/VUpCxPU7Kcbi9itG47Y09bo0q6XyaRWayvSw=
X-Google-Smtp-Source: AGHT+IGYqO63cB9dIrjqcU0XSFhfEWqMsvM8/NRh9DhJXo8zYZAN/0KQh0e5PCfmPrgZ/N64y5qi/A==
X-Received: by 2002:a17:90b:3c47:b0:2e2:cef9:8f68 with SMTP id
 98e67ed59e1d1-2e76b5b9470mr2955462a91.4.1729696871164; 
 Wed, 23 Oct 2024 08:21:11 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e76e088f1fsm1538341a91.56.2024.10.23.08.21.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 08:21:10 -0700 (PDT)
Message-ID: <55418913-8504-494a-8448-5230c4740181@linaro.org>
Date: Wed, 23 Oct 2024 08:21:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Julian Ganz <nenut@skiff.uberspace.de>
Cc: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <8929cd79ce653b55e7cb166300782cb13727da3b@skiff.uberspace.de>
 <f7e574bb-a780-4f5b-a511-ab9f0aa86f31@linaro.org>
 <ab29d100610abcc59ce2305a1ace1ac0b53340a3@skiff.uberspace.de>
 <2419ec6e-3d4e-4d6d-a738-7615c99ed60c@linaro.org>
 <0696c7fc52d1d58002f0a8be7e7502f57fd61d24@skiff.uberspace.de>
 <87h692ly55.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h692ly55.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

T24gMTAvMjMvMjQgMDY6NTcsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gIkp1bGlhbiBHYW56
IiA8bmVudXRAc2tpZmYudWJlcnNwYWNlLmRlPiB3cml0ZXM6DQo+IA0KPj4gSGksIFBpZXJy
aWNrLA0KPj4NCj4+IHJlc2VudCBhcyBJIHdhcyB0b28gc3R1cGlkIHRvIGhpdCByZXBseSBp
bnN0ZWFkIG9mIHJlcGx5LWFsbC4NCj4+DQo+PiBPY3RvYmVyIDIyLCAyMDI0IGF0IDExOjE1
IFBNLCAiUGllcnJpY2sgQm91dmllciIgd3JvdGU6DQo+Pj4NCj4+PiBPbiAxMC8yMi8yNCAw
MToyMSwgSnVsaWFuIEdhbnogd3JvdGU6DQo+Pj4NCj4+Pj4NCj4+Pj4gSGksIFBpZXJyaWNr
LA0KPj4+PiAgIE9jdG9iZXIgMjEsIDIwMjQgYXQgMTE6NTkgUE0sICJQaWVycmljayBCb3V2
aWVyIiB3cm90ZToNCj4+Pj4NCj4gPHNuaXA+DQo+Pj4+ICAgSSBkb24ndCB0aGluayB0aGlz
IGlzIGEgZ29vZCBpZGVhLg0KPj4+PiAgIFRyYXBzIGFyZSBqdXN0IHRvbyBkaXZlcnNlLCBp
bW8gdGhlcmUgaXMgdG9vIGxpdHRsZSBvdmVybGFwIGJldHdlZW4NCj4+Pj4gICBkaWZmZXJl
bnQgYXJjaGl0ZWN0dXJlcywgd2l0aCB0aGUgc29sZSBleGNlcHRpb24gbWF5YmUgYmVpbmcg
dGhlIFBDDQo+Pj4+ICAgcHJpb3IgdG8gdGhlIHRyYXAuICJJbnRlcnJ1cHQgaWQiIHNvdW5k
cyBsaWtlIGEgcmVhc29uYWJseSBjb21tb24NCj4+Pj4gICBjb25jZXB0LCBidXQgdGhlbiB5
b3Ugd291bGQgbmVlZCB0byBkZWZpbmUgYSBtYXBwaW5nIGZvciBlYWNoIGFuZCBldmVyeQ0K
Pj4+PiAgIGFyY2hpdGVjdHVyZS4gV2hhdCBpbnRlZ2VyIHR5cGUgZG8geW91IHVzZT8gSW4g
UklTQy1WLCBmb3IgZXhhbXBsZSwNCj4+Pj4gICBleGNlcHRpb25zIGFuZCBpbnRlcnJ1cHQg
ImlkcyIgYXJlIGRpZmZlcmVudGlhdGVkIHZpYSB0aGUgbW9zdA0KPj4+PiAgIHNpZ25pZmlj
YW50IGJpdC4gRG91IGtlZXAgdGhhdCBvciBkbyB5b3UgemVybyBpdD8gQW5kIHRoZW4gdGhl
cmUncw0KPj4+PiAgIHJpbmcvcHJpdmlsYWdlIG1vZGUsIGNhdXNlIChzb21ldGltZXMgZm9y
IGVhY2ggbW9kZSksIC4uLg0KPj4+Pg0KPj4+IEkgZGlkbid0IHdhbnQgdG8gb3BlbiB0aGUg
cGVyIGFyY2hpdGVjdHVyZSBwYW5kb3JhIGJveCA6KS4NCj4+PiBJIGRvbid0IHRoaW5rIHRo
ZSBwbHVnaW4gQVBJIGl0c2VsZiBzaG91bGQgZGVhbCB3aXRoIHBlciBhcmNoaXRlY3R1cmUN
Cj4+PiBkZXRhaWxzIGxpa2UgbWVhbmluZyBvZiBhIGdpdmVuIGlkLiBJIHdhcyBqdXN0IHRo
aW5raW5nIHRvIHB1c2ggdGhpcw0KPj4+ICJyYXciIGluZm9ybWF0aW9uIHRvIHRoZSBwbHVn
aW4sIHRoYXQgbWF5L21heSBub3QgdXNlIGFyY2hpdGVjdHVyZQ0KPj4+IHNwZWNpZmljIGtu
b3dsZWRnZSB0byBkbyBpdHMgd29yay4gV2UgYWxyZWFkeSBoYXZlIHBsdWdpbnMgdGhhdCBo
YXZlDQo+Pj4gc2ltaWxhciBwZXIgYXJjaGl0ZWN0dXJlIGtub3dsZWRnZSAoY29udHJpYi9w
bHVnaW5zL2hvd3ZlYy5jKSBhbmQNCj4+PiBpdCdzIG9rIGluIHNvbWUgc3BlY2lmaWMgY2Fz
ZXMuDQo+Pg0KPj4gQnV0IGhvdyB3b3VsZCBzdWNoIGFuIGludGVyZmFjZSBsb29rPyBUaGUg
bGFzdCBQQyBhc2lkZSwgd2hhdCB3b3VsZCB5b3UNCj4+IGluY2x1ZGUsIGFuZCBob3c/IEEg
R0FycmF5IHdpdGggbmFtZWQgaXRlbXMgdGhhdCBhcmUgaXRzZWxmIGp1c3Qgb3BhcXVlDQo+
PiBibG9icz8NCj4+DQo+PiBBbmQgd2hhdCB3b3VsZCBiZSB0aGUgYmVuZWZpdCBjb21wYXJl
ZCB0byBqdXN0IHF1ZXJ5aW5nIHRoZSByZXNwZWN0aXZlDQo+PiB0YXJnZXQgc3BlY2lmaWMg
cmVnaXN0ZXJzIHRocm91Z2ggcWVtdV9wbHVnaW5fcmVhZF9yZWdpc3Rlcj8gV2hpY2ggYnR3
Lg0KPj4gaXMgd2hhdCB3ZSB3ZXJlIGdvaW5nIHRvIGRvIGZvciBvdXIgdXNlLWNhc2UuIEV2
ZW4gdGhlIGV4YW1wbGUgeW91DQo+PiBicm91Z2h0IHVwIChob3d2ZWMpIHVzZXMgcXVlcnlp
bmcgZnVuY3Rpb25zIGFuZCBkb2Vzbid0IGV4cGVjdCB0byBnZXQNCj4+IGFsbCB0aGUgaW5m
byB2aWEgcGFyYW1ldGVycy4NCj4gDQo+IEkgdGhpbmsgdGhlIHJlZ2lzdGVyIGFjY2VzcyBw
cm9iYWJseSBwcm92aWRlcyBldmVyeXRoaW5nIHlvdSBuZWVkLiBTb21lDQo+IHRhcmdldHMg
cHJvdmlkZSBhIHdpZGVyIGFjY2VzcyB0aGFuIG90aGVyIHRob3VnaC4gSSBoYXZlbid0IGxv
b2tlZCBhdA0KPiB0aGUgUmlzYyBWIGNvZGUgYnV0IGNlcnRhaW5seSB0aGUgQXJtIGNvZGUg
ZXhwb3NlcyBwcmV0dHkgbXVjaCBhbGwNCj4gc3lzdGVtIHJlZ2lzdGVycyB0byB0aGUgZ2Ri
c3R1YiAoYW5kIGhlbmNlIHRoZSBwbHVnaW4gaW50ZXJmYWNlKS4NCj4gDQo+IElmIHRoZXJl
IGlzIGV4YW1wbGUgb2Ygc3RhdGUgdGhhdCBpc24ndCBhY2Nlc3NpYmxlIHRoaXMgd2F5IHRo
ZW4gSSdkDQo+IGxpa2UgdG8ga25vdyBpdC4NCj4gDQo+Pj4gQnV0IGhhdmluZyBzb21ldGhp
bmcgbGlrZSBmcm9tL3RvIGFkZHJlc3Mgc2VlbXMgdXNlZnVsIHRvIHN0YXJ0LiBFdmVuIGlm
IHdlIGRvbid0IHByb3ZpZGUgaXQgZm9yIGFsbCBldmVudHMgeWV0LCBpdCdzIG9rLg0KPj4N
Cj4+IFllcywgSSBjZXJ0YWlubHkgc2VlIHRoZSBhZHZhbnRhZ2VzIG9mIGhhdmluZyBlaXRo
ZXIgdGhlIGxhc3QgUEMgb3IgdGhlDQo+PiB3b3VsZC1iZS1uZXh0IFBDIGFzIHRoZXkgYXJl
IHN1ZmZpY2llbnRseSB1bml2ZXJzYWwuIFlvdSBjYW4gdXN1YWxseQ0KPj4gcmV0cmlldmUg
dGhlbSBmcm9tIHRhcmdldC1zcGVjaWZpYyByZWdpc3RlcnMsIGJ1dCB0aGF0IG1heSBiZSBt
b3JlDQo+PiBjb21wbGljYXRlZCBpbiBwcmFjdGljZS4gSW4gdGhlIGNhc2Ugb2YgUklTQy1W
IGZvciBleGFtcGxlLCB0aGUgdmFsdWUNCj4+IG9mIHRoZSBFUEMgZGlmZmVycyBiZXR3ZWVu
IGludGVycnVwdHMgYW5kIGV4Y2VwdGlvbnMuDQo+Pg0KPj4gVGhhdCBQQyB2YWx1ZSBzaG91
bGQgYWxzbyBiZSBlYXN5IGVub3VnaCB0byBvYnRhaW4gYXQgdGhlIGhvb2sgY2FsbA0KPj4g
c2l0ZXMuIFdlIG9ubHkgbmVlZCB0byBzdG9yZSB0aGUgKG9sZCkgUEMgYmVmb3JlIGRvaW5n
IHRoZSBzZXR1cC4gVGhlDQo+PiAidG8tYWRkcmVzcyIgaXMgdGhlIGN1cnJlbnQgUEMgYXQg
dGhlIHRpbWUgdGhlIGNhbGxiYWNrIGlzIGludm9rZWQuDQo+PiBBbnl0aGluZyBlbHNlIHdv
dWxkIGJlIGEgYnVnLiBJIHdhcyBnb2luZyB0byB3cml0ZSB0aGF0IHlvdSBjYW4NCj4+IGFs
cmVhZHkgcXVlcnkgdGhhdCBpbiBhIHBsdWdpbiB0aHJvdWdoIGEgZGVkaWNhdGVkIGhlbHBl
ciBmdW5jdGlvbg0KPj4gYnV0IGFwcGFyZW50bHkgSSBtaXNyZW1lbWJlcmVkLg0KPj4NCj4+
IEknbGwgaW5jbHVkZSB0aGlzIGluIHRoZSBuZXh0IGl0ZXJhdGlvbi4NCj4gDQo+IFRoZXJl
IGFyZSBzb21lIGRyYWdvbnMgd2l0aCBwYy9ucGMgYXMgZWFjaCBmcm9udC1lbmQgZGVhbHMg
d2l0aCBpdCBpdHMNCj4gb3duIHdheSBhbmQgc29tZSB0YXJnZXRzIGhhdmUgZGVsYXkgc2xv
dHMgd2hpY2ggbWFrZXMgdGhpbmdzIGV2ZW4NCj4gbWVzc2llci4NCj4gDQoNClllcywgaWYg
aXQgZ2V0cyB0b28gY29tcGxpY2F0ZWQgZm9yIGN1cnJlbnQgc2VyaWVzLCB3ZSBjYW4ganVz
dCBoYXZlIHRoZSANCmV2ZW50IHBhc3NlZCB0byB0aGUgY2FsbGJhY2ssIGFuZCBubyBtb3Jl
IGluZm9ybWF0aW9uLg0KQXMgcG9pbnRlZCBpbiBteSBwcmV2aW91cyBtZXNzYWdlLCBJIGp1
c3Qgd2FudCB0byBhdm9pZCB0aGUgbXVsdGlwbGUgDQpjYWxsYmFja3Mgcm91dGUgZm9yIHRo
aXMgc3BlY2lmaWMgYXJlYS4gSXQncyBmaW5lIGlmIHdlIGRvbid0IGhhdmUgYW55IA0KYXR0
YWNoZWQgZGF0YSBmb3Igbm93Lg0KDQo+Pg0KPj4+PiBJdCB3b3VsZCBhbHNvIGNvbXBsaWNh
dGUgY2FsbCBzaXRlcyBmb3IgaG9va3MgaW4gdGFyZ2V0IGNvZGUuIFlvdSdkDQo+Pj4+ICAg
ZWl0aGVyIG5lZWQgYXdrd2FyZGx5IGxvbmcgZnVuY3Rpb24gc2lnbml0dXJlcyBvciBzZXR1
cCBjb2RlIGZvciB0aGF0DQo+Pj4+ICAgc3RydWN0LiBCb3RoIGFyZSB0aGluZ3MgeW91IGRv
bid0IHdhbnQsIGFzIGEgaG9vayBjYWxsIHNpdGUgc2hvdWxkDQo+Pj4+ICAgbmV2ZXIgZGlz
dHJhY3QgZnJvbSB0aGUgYWN0dWFsIGxvZ2ljIHN1cnJvdW5kaW5nIHRoZW0uIFlvdSBjb3Vs
ZA0KPj4+PiAgIHByb2JhYmx5IGhhdmUgc29tZXRoaW5nIHJlYXNvbmFibGUgaW4gUnVzdCwg
dXNpbmcgYSBidWlsZGVyL2NvbW1hbmQNCj4+Pj4gICBwYXR0ZXJuLiBCdXQgaW4gQyB0aGlz
IHdvdWxkIHJlcXVpcmUgdG9vIG11Y2ggYm9pbGVyIHBsYXRlIGNvZGUgdGhhbg0KPj4+PiAg
IEknZCBiZSBjb21mb3J0YWJsZSB3aXRoLg0KPj4+Pg0KPj4+IFdlIGNhbiBoYXZlIG9uZSAi
YnVpbGRlciIgZnVuY3Rpb24gcGVyIGRhdGEgdHlwZSwgd2l0aCBmaXhlZCBwYXJhbWV0ZXJz
IChubyB2YXJhcmdzKSwgaXQncyByZWFzb25hYmxlIGFuZCB3b3VsZCBzY2FsZSB3ZWxsIHdp
dGggbmV3IGVudHJpZXMvZGF0YSBpbmZvcm1hdGlvbi4NCj4+DQo+PiBJJ20gc3RpbGwgbm90
IG9uIGJvYXJkIG9uIHByZXBhcmluZyBhIG1vcmUgY29tcGxleCBkYXRhIHR5cGUuIEZvciB0
aGUNCj4+IG5leHQgaXRlcmF0aW9uIEknZCByYXRoZXIgc3RpY2sgdG8gYSBzaW1wbGUgZnVu
Y3Rpb24gcmVjZWl2aW5nIHRoZQ0KPj4gInR5cGUiIG9mIGV2ZW50IGFuZCB0aGUgUENzLiBU
aGF0IG1heSBub3QgYmUgZXh0ZW5zaWJsZSwgYnV0IEkgZG9uJ3Qgc2VlDQo+PiBhbnkgYmVu
ZWZpdCBpbiBzaG9laG9ybmluZyBpbmhlcml0ZWxudGx5IHRhcmdldC1zcGVjaWZjIGluZm9y
bWF0aW9uIGludG8NCj4+IGEgY29tcGxleCBzdHJ1Y3QuDQo+Pg0KPj4gSWYgdGhpcyBpcyBh
IGhhcmQgcmVxdWlyZW1lbnQsIEknbGwgb2YgY291cnNlIHN0aWxsIGRvIHNvLg0KPiANCj4g
Tm8gbGV0cyBrZWVwIGl0IHNpbXBsZSBmb3IgdGhlIGZpcnN0IGl0ZXJhdGlvbi4gV2UgY2Fu
IGFsc28gZXhwYW5kIHRoZQ0KPiBBUEkgbGF0ZXIgYW5kIGJ1bXAgdGhlIEFQSSB2ZXJzaW9u
cyBhcyBhcHByb3ByaWF0ZS4NCj4NCg0KVGhlIHR5cGUgb2YgZXZlbnQsIGV2ZW50dWFsbHkg
d2l0aCBwY3MgaWYgeW91IGNhbiBnZXQgdGhlbSBpcyBhbHJlYWR5IA0Kc2F0aXNmeWluZywg
YW5kIHNpbXBsZSBlbm91Z2guDQoNCj4+DQo+PiBSZWdhcmRzLA0KPj4gSnVsaWFuDQo+IA0K


