Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC998C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 17:24:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSK02-0007DA-OX; Fri, 12 Jul 2024 13:24:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSJzv-0007Bz-0U
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:23:55 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sSJzr-00045v-A7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 13:23:53 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-78512d44a17so1699919a12.3
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720805028; x=1721409828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vFd1FBff2wcsqJNGxsG1QUnBJIaVK5x1jwLTChzDNMs=;
 b=EYVCfJdNwLtm4cVebtLAIne0SW8JZ4NlSu6unoLU9J6E9B+/bhL78fWHXH/dh7xPaf
 EtfI9CH47NPkOTyng0wMlc9PKCT+metD4d4p3A5eIv8WFGSMakj7PRqLTcxNZtAx3hhX
 4xUDGOwJZlGBHRuuiPMXDPdiR/qKmlsA5D7zQetjpN2hVzdWvPQioAOk8SCtXrlRJ5dW
 5FcE18i9+5GreHPI69v/kQ6fHBlenhkOFiALAQKk4hCYrwoMQh4FmThHT/HDowkaO3lS
 SqIjozWzDKgcUBJSz0ohp1BCy4f9VhgFJdxZJhGy+1jAel15DLta0Vo4eGrTQzJHTFr4
 IVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720805028; x=1721409828;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vFd1FBff2wcsqJNGxsG1QUnBJIaVK5x1jwLTChzDNMs=;
 b=Q1XniMu/cxb1NhA45K9qAzbsvX2jRgAjjm9iGxSZ3Qa+vr5areM36f8Fr/F3PGH1DS
 kZFdfobzMuPAMWjtOIUVo1lt2f6hbLnlmyvzPtCO3YB+HcHCAv5KHay8+lNGWFkNGdSe
 Ichke7/fKO3kHxdOryHOM3oF4w1c/timKMf6GOJqNytSQ7vCbmjsgYiJxpXkuRYl0tHO
 hEsLb/CAQOSTK6IEBfaccGEDlmUqsDRUS/sgIoL1sAaKU8a0SdCTovcDWdy3i7fKbl0Z
 BJl6QqwhzSiX44N50hNyKHExXN2A98m1r8mW49+qAojAE9kHbu8qVb4lsWftKI6xe3YR
 RMTA==
X-Gm-Message-State: AOJu0YxGHgkwsEpUvsMD4XV00MS8VryxM/DAHM7vgEgu4SGyVIIX19qp
 sA86ucb3L6xny2oW05n1lRkS2jRzm6SSXIDjo5mSzjfUm8Z2qjqyj5O+iSXocak=
X-Google-Smtp-Source: AGHT+IEOUw/GqlmZiO91yW3h8yKDYA24R73ztAtUjP9UlKJpoR2H1hgj9is+WUyzZyIicr8++2qeTA==
X-Received: by 2002:a05:6a20:a11a:b0:1c0:e53f:62d8 with SMTP id
 adf61e73a8af0-1c29820d1c6mr14993034637.18.1720805028426; 
 Fri, 12 Jul 2024 10:23:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438993c0sm7765012b3a.29.2024.07.12.10.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 10:23:48 -0700 (PDT)
Message-ID: <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
Date: Fri, 12 Jul 2024 10:23:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
Content-Language: en-US
To: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

SGVsbG8gU2ltb24sDQoNCk9uIDcvMTIvMjQgMDA6NTMsIFNpbW9uIEhhbWVsaW4gd3JvdGU6
DQo+IA0KPiANCj4gT24gNy8xMS8yNCAxMjowMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+
ICtzdGF0aWMgdm9pZCBleGl0X2VtdWxhdGlvbihpbnQgcmV0dXJuX2NvZGUpDQo+Pj4gK3sN
Cj4+PiArICAgIGV4aXQocmV0dXJuX2NvZGUpOw0KPj4+ICt9DQo+Pj4gKw0KPj4+ICtzdGF0
aWMgdm9pZCBleGl0X2ljb3VudF9yZWFjaGVkKHVuc2lnbmVkIGludCBjcHVfaW5kZXgsIHZv
aWQgKnVkYXRhKQ0KPj4+ICt7DQo+Pj4gKyAgICBxZW11X3BsdWdpbl9vdXRzKCJpY291bnQg
cmVhY2hlZCwgZXhpdGluZ1xuIik7DQo+Pj4gKyAgICBleGl0X2VtdWxhdGlvbihpY291bnRf
ZXhpdF9jb2RlKTsNCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIHZvaWQgZXhpdF9hZGRy
ZXNzX3JlYWNoZWQodW5zaWduZWQgaW50IGNwdV9pbmRleCwgdm9pZCAqdWRhdGEpDQo+Pj4g
K3sNCj4+PiArICAgIHVpbnQ2NF90IGluc25fdmFkZHIgPSBHUE9JTlRFUl9UT19VSU5UKHVk
YXRhKTsNCj4+PiArICAgIGdfbXV0ZXhfbG9jaygmYWRkcnNfaHRfbG9jayk7DQo+Pj4gKyAg
ICBpbnQgZXhpdF9jb2RlID0gR1BPSU5URVJfVE9fSU5UKA0KPj4+ICsgICAgICAgIGdfaGFz
aF90YWJsZV9sb29rdXAoYWRkcnNfaHQsIEdVSU5UX1RPX1BPSU5URVIoaW5zbl92YWRkcikp
KTsNCj4+PiArICAgIGdfbXV0ZXhfdW5sb2NrKCZhZGRyc19odF9sb2NrKTsNCj4+PiArICAg
IGNoYXIgKm1zZyA9IGdfc3RyZHVwX3ByaW50ZigiMHglIiBQUkl4NjQgIiByZWFjaGVkLCBl
eGl0aW5nXG4iLA0KPj4+IGluc25fdmFkZHIpOw0KPj4NCj4+IERvbnQgaW50ZXJtaXggdmFy
aWFibGUgZGVjbGFyYXRpb25zLCBwdXQgdGhlbSBhdCB0aGUgdG9wIG9mIHRoZSBibG9jay4N
Cj4+DQo+Pj4gKyAgICBxZW11X3BsdWdpbl9vdXRzKG1zZyk7DQo+Pj4gKyAgICBleGl0X2Vt
dWxhdGlvbihleGl0X2NvZGUpOw0KPj4+ICt9DQo+Pg0KPj4gSG93IGFib3V0IHNvbWV0aGlu
ZyBsaWtlOg0KPj4NCj4+ICAgICBzdGF0aWMgdm9pZCBleGl0X2VtdWxhdGlvbihpbnQgcmV0
dXJuX2NvZGUsIGNoYXIgKm1lc3NhZ2UpDQo+PiAgICAgew0KPj4gICAgICAgICBxZW11X3Bs
dWdpbl9vdXRzKG1lc3NhZ2UpOw0KPj4gICAgICAgICBnX2ZyZWUobWVzc2FnZSk7DQo+PiAg
ICAgICAgIGV4aXQocmV0dXJuX2NvZGUpOw0KPj4gICAgIH0NCj4+DQo+PiAgICAgc3RhdGlj
IHZvaWQgZXhpdF9pY291bnRfcmVhY2hlZCh1bnNpZ25lZCBpbnQgY3B1X2luZGV4LCB2b2lk
ICp1ZGF0YSkNCj4+ICAgICB7DQo+PiAgICAgICAgIHVpbnQ2NF90IGluc25fdmFkZHIgPSBH
UE9JTlRFUl9UT19VSU5UKHVkYXRhKTsNCj4+ICAgICAgICAgY2hhciAqbXNnID0gZ19zdHJk
dXBfcHJpbnRmKCJpY291bnQgcmVhY2hlZCBhdCAweCUiIFBSSXg2NCAiLCBleGl0aW5nXG4i
LCBpbnNuX3ZhZGRyKTsNCj4+DQo+PiAgICAgICAgIGV4aXRfZW11bGF0aW9uKGljb3VudF9l
eGl0X2NvZGUsIG1zZyk7DQo+PiAgICAgfQ0KPj4NCj4+ICAgICBzdGF0aWMgdm9pZCBleGl0
X2FkZHJlc3NfcmVhY2hlZCh1bnNpZ25lZCBpbnQgY3B1X2luZGV4LCB2b2lkICp1ZGF0YSkN
Cj4+ICAgICB7DQo+PiAgICAgICAgIHVpbnQ2NF90IGluc25fdmFkZHIgPSBHUE9JTlRFUl9U
T19VSU5UKHVkYXRhKTsNCj4+ICAgICAgICAgY2hhciAqbXNnID0gZ19zdHJkdXBfcHJpbnRm
KCIweCUiIFBSSXg2NCAiIHJlYWNoZWQsIGV4aXRpbmdcbiIsIGluc25fdmFkZHIpOw0KPj4g
ICAgICAgICBpbnQgZXhpdF9jb2RlOw0KPj4NCj4+ICAgICAgICAgZ19tdXRleF9sb2NrKCZh
ZGRyc19odF9sb2NrKTsNCj4+ICAgICAgICAgZXhpdF9jb2RlID0gR1BPSU5URVJfVE9fSU5U
KA0KPj4gICAgICAgICAgICAgZ19oYXNoX3RhYmxlX2xvb2t1cChhZGRyc19odCwgR1VJTlRf
VE9fUE9JTlRFUihpbnNuX3ZhZGRyKSkpOw0KPj4gICAgICAgICBnX211dGV4X3VubG9jaygm
YWRkcnNfaHRfbG9jayk7DQo+Pg0KPj4gICAgICAgICBleGl0X2VtdWxhdGlvbihleGl0X2Nv
ZGUsIG1zZyk7DQo+PiAgICAgfQ0KPj4NCj4+DQo+IA0KPiBMb29rcyBnb29kIHRvIG1lLCB3
aWxsIGRlZmluaXRseSBwdXQgdGhhdCBpbiB0aGUgbmV4dCBwYXRjaCAhDQo+IA0KPj4+ICtR
RU1VX1BMVUdJTl9FWFBPUlQgaW50IHFlbXVfcGx1Z2luX2luc3RhbGwocWVtdV9wbHVnaW5f
aWRfdCBpZCwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGNvbnN0IHFlbXVfaW5mb190ICppbmZvLCBpbnQgYXJnYywNCj4+PiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNoYXIgKiphcmd2KQ0KPj4+ICt7
DQo+Pj4gKyAgICBhZGRyc19odCA9IGdfaGFzaF90YWJsZV9uZXcoTlVMTCwgZ19kaXJlY3Rf
ZXF1YWwpOw0KPj4+ICsNCj4+PiArICAgIGluc25fY291bnRfc2IgPSBxZW11X3BsdWdpbl9z
Y29yZWJvYXJkX25ldyhzaXplb2YoSW5zdHJ1Y3Rpb25zQ291bnQpKTsNCj4+PiArICAgIGlu
c25fY291bnQgPSBxZW11X3BsdWdpbl9zY29yZWJvYXJkX3U2NF9pbl9zdHJ1Y3QoDQo+Pj4g
KyAgICAgICAgaW5zbl9jb3VudF9zYiwgSW5zdHJ1Y3Rpb25zQ291bnQsIGluc25fY291bnQp
Ow0KPj4+ICsNCj4+PiArICAgIGZvciAoaW50IGkgPSAwOyBpIDwgYXJnYzsgaSsrKSB7DQo+
Pj4gKyAgICAgICAgY2hhciAqb3B0ID0gYXJndltpXTsNCj4+PiArICAgICAgICBnX2F1dG8o
R1N0cnYpIHRva2VucyA9IGdfc3Ryc3BsaXQob3B0LCAiPSIsIDIpOw0KPj4+ICsgICAgICAg
IGlmIChnX3N0cmNtcDAodG9rZW5zWzBdLCAiaWNvdW50IikgPT0gMCkgew0KPj4+ICsgICAg
ICAgICAgICBnX2F1dG8oR1N0cnYpIGljb3VudF90b2tlbnMgPSBnX3N0cnNwbGl0KHRva2Vu
c1sxXSwgIjoiLCAyKTsNCj4+PiArICAgICAgICAgICAgaWNvdW50ID0gZ19hc2NpaV9zdHJ0
b3VsbChpY291bnRfdG9rZW5zWzBdLCBOVUxMLCAwKTsNCj4+DQo+Pg0KPj4NCj4+PiArICAg
ICAgICAgICAgaWYgKGljb3VudCA8IDEgfHwgZ19zdHJyc3RyKGljb3VudF90b2tlbnNbMF0s
ICItIikgIT0NCj4+PiBOVUxMKSB7DQo+Pg0KPj4gSSBkb24ndCB0aGluayBzdHJzdG91bGwg
d291bGQgZXZlbiBwYXJzZSBzb21ldGhpbmcgd2l0aCAtIGluIGl0IHNvIEkNCj4+IHdvdWxk
IGp1c3QgZG86DQo+Pg0KPj4gICAgIGlmIChpY291bnQgPT0gMCkgew0KPj4gICAgICAgIC8q
IGZhaWwgKi8NCj4+ICAgICB9DQo+Pg0KPiANCj4gQWNjb3JkaW5nIHRvIHRoZSBHTGliIGRv
Y3VtZW50YXRpb246ICJOb3RlIHRoYXQgaW5wdXQgd2l0aCBhIGxlYWRpbmcNCj4gbWludXMg
c2lnbiAoLSkgaXMgYWNjZXB0ZWQsIGFuZCB3aWxsIHJldHVybiB0aGUgbmVnYXRpb24gb2Yg
dGhlIHBhcnNlZA0KPiBudW1iZXIsIHVubGVzcyB0aGF0IHdvdWxkIG92ZXJmbG93IGEgZ3Vp
bnQ2NCIuIFNvIGkgZ3Vlc3Mgd2UgbmVlZCB0bw0KPiBrZWVwIHRoaXMgY2hlY2suDQo+IA0K
Pj4+IGRpZmYgLS1naXQgYS9kb2NzL2RldmVsL3RjZy1wbHVnaW5zLnJzdCBiL2RvY3MvZGV2
ZWwvdGNnLXBsdWdpbnMucnN0DQo+Pj4gaW5kZXggZjdkN2I5ZTNhNC4uOTU0NjIzZjliZiAx
MDA2NDQNCj4+PiAtLS0gYS9kb2NzL2RldmVsL3RjZy1wbHVnaW5zLnJzdA0KPj4+ICsrKyBi
L2RvY3MvZGV2ZWwvdGNnLXBsdWdpbnMucnN0DQo+Pj4gQEAgLTY0Miw2ICs2NDIsMjggQEAg
VGhlIHBsdWdpbiBoYXMgYSBudW1iZXIgb2YgYXJndW1lbnRzLCBhbGwgb2YgdGhlbSBhcmUg
b3B0aW9uYWw6DQo+Pj4gICAgICBjb25maWd1cmF0aW9uIGFyZ3VtZW50cyBpbXBsaWVzIGBg
bDI9b25gYC4NCj4+PiAgICAgIChkZWZhdWx0OiBOID0gMjA5NzE1MiAoMk1CKSwgQiA9IDY0
LCBBID0gMTYpDQo+Pj4gICAgDQo+Pj4gKy0gY29udHJpYi9wbHVnaW5zL3N0b3B0cmlnZ2Vy
LmMNCj4+PiArDQo+Pj4gK1RoZSBzdG9wdHJpZ2dlciBwbHVnaW4gYWxsb3dzIHRvIHNldHVw
IHRyaWdnZXJzIHRvIHN0b3AgZW11bGF0aW9uLg0KPj4+ICtJdCBjYW4gYmUgdXNlZCBmb3Ig
cmVzZWFyY2ggcHVycG9zZXMgdG8gbGF1bmNoIHNvbWUgY29kZSBhbmQgcHJlY2lzZWx5IHN0
b3AgaXQNCj4+PiArYW5kIHVuZGVyc3RhbmQgd2hlcmUgaXRzIGV4ZWN1dGlvbiBmbG93IHdl
bnQuDQo+Pj4gKw0KPj4+ICtUd28gdHlwZXMgb2YgdHJpZ2dlcnMgY2FuIGJlIGNvbmZpZ3Vy
ZWQ6IGEgY291bnQgb2YgaW5zdHJ1Y3Rpb25zIHRvIHN0b3AgYXQsDQo+Pj4gK29yIGFuIGFk
ZHJlc3MgdG8gc3RvcCBhdC4gTXVsdGlwbGUgdHJpZ2dlcnMgY2FuIGJlIHNldCBhdCBvbmNl
Lg0KPj4+ICsNCj4+PiArQnkgZGVmYXVsdCwgUUVNVSB3aWxsIGV4aXQgd2l0aCByZXR1cm4g
Y29kZSAwLiBBIGN1c3RvbSByZXR1cm4gY29kZSBjYW4gYmUNCj4+PiArY29uZmlndXJlZCBm
b3IgZWFjaCB0cmlnZ2VyIHVzaW5nIGBgOkNPREVgYCBzeW50YXguDQo+Pj4gKw0KPj4+ICtG
b3IgZXhhbXBsZSwgdG8gc3RvcCBhdCB0aGUgMjAtdGggaW5zdHJ1Y3Rpb24gd2l0aCByZXR1
cm4gY29kZSA0MSwgYXQgYWRkcmVzcw0KPj4+ICsweGQ0IHdpdGggcmV0dXJuIGNvZGUgMCBv
ciBhdCBhZGRyZXNzIDB4ZDggd2l0aCByZXR1cm4gY29kZSA0Mjo6DQo+Pj4gKw0KPj4+ICsg
ICQgcWVtdS1zeXN0ZW0tYWFyY2g2NCAkKFFFTVVfQVJHUykgXA0KPj4+ICsgICAgLXBsdWdp
biAuL2NvbnRyaWIvcGx1Z2lucy9saWJzdG9wdHJpZ2dlci5zbyxpY291bnQ9MjA6NDEsYWRk
cj0weGQ0LGFkZHI9MHhkODo0MiAtZCBwbHVnaW4NCj4+PiArDQo+Pj4gK1RoZSBwbHVnaW4g
d2lsbCBsb2cgdGhlIHJlYXNvbiBvZiBleGl0LCBmb3IgZXhhbXBsZTo6DQo+Pj4gKw0KPj4+
ICsgIDB4ZDQgcmVhY2hlZCwgZXhpdGluZw0KPj4+ICsNCj4+PiAgICBQbHVnaW4gQVBJDQo+
Pj4gICAgPT09PT09PT09PQ0KPj4NCj4+IE90aGVyd2lzZSBpdCBsb29rcyBnb29kIHRvIG1l
LiBVbmxlc3MgeW91IHdhbnQgdG8gdGFja2xlIGFkZGl0aW9uYWwgZXhpdA0KPj4gbW9kZXM/
DQo+Pg0KPj4gV2hhdCBpcyB5b3VyIGN1cnJlbnQgdXNlIGNhc2UgZm9yIHRoaXM/DQo+Pg0K
PiANCj4gSSdtIGN1cnJlbnRseSB1c2luZyB0aGlzIHBsdWdpbiB0byBkZXRlcm1pbmUgd2hl
cmUgbXkgcHJvZ3JhbW0gc3RvcA0KPiBhZnRlciBhIGdpdmVuIG51bWJlciBvZiBpbnN0cnVj
dGlvbnMgZXhlY3V0ZWQuDQo+IA0KDQpDb3VsZCB5b3Ugc2hhcmUgYSBiaXQgbW9yZSBpbmZv
cm1hdGlvbiBvbiB0aGUgZmluYWwgZ29hbCwgaWYgcG9zc2libGU/DQpJcyB0aGF0IHVzZWQg
Zm9yIGZ1enppbmcgYmluYXJpZXMsIHNlY3VyaXR5IGFuYWx5c2lzLCBvciBvdGhlciB0aGlu
Z3M/DQo=

