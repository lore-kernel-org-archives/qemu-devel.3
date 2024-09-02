Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9850CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 16:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl9bU-00073u-66; Mon, 02 Sep 2024 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sl9bS-00073K-G3
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 12:08:30 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sl9bQ-0007NU-KD
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 12:08:30 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2d877e9054eso2125565a91.3
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725293306; x=1725898106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/XjIh43d3iGZWu8Xj5nkS1nAsQMmUqNm613u8eqfJZE=;
 b=TXoeKKhI5kXpGm+WCHeUbS9TwIrkVq+I57BMebBW6hmEyQpLmOCf4T69ZuNG0/K0xH
 xzOs0+NDLjJe8prTcFrckNJSndkew2uer3ZNFf9/jPRDi6Xgn8UWbZg7oFPYtDQ+Yz+C
 W8bsREgxzrF4ji91Md7CbmPH2GjWbhvdkS1EsU25TZ5eZBA5N6JrFmSowPt+/PZT+1lC
 j5CQWXnILRFsBd6bITBepksfdTabERq5BGKHijUdAHrLSdWPJcEXAImI7wWpjsz4wphr
 hcyQoeMg6MfRlrpfmukRyvRip5otSPQhcYlvhfX0xhNxi2N3KbfebBxKMcWpldTXvBWo
 uYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725293306; x=1725898106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/XjIh43d3iGZWu8Xj5nkS1nAsQMmUqNm613u8eqfJZE=;
 b=araoR9yfAHAsnmCzjeJeG2VNR10+aUFJuVhF0CQ1XyxW7PE4ME5Pq2ImiHAZZSjvkB
 zBFJyzG9DONubuyHVo8GM3K5JsTfgYVUNiBf+e6wyHqBrukJUUB3e3DKtdq7TTIpjb0C
 Khf3Q/GRKc/g3DGAjmUZacME9l5oNp/S7zeBmpBUjuNOPuqQ+u0WoD8vcojSA//8c0Gj
 vZdqCmz7UEOMLE95vvx8gnRH2p3VHow/40ZrIxP4rVeJhP2bBdBXwP/jAJIPfvZXzLKS
 6C/g4qvO3PmWrFEW7DE3kRqUHQ2/XKAv93Z5BVemSkSJ41DAhTxZw11W97xiVKDjVVbI
 oTcA==
X-Gm-Message-State: AOJu0YwO0dGg63xQDRo+QoDmtUL+c/mng3Q15FZMYMWAe1e48r+2FkFD
 Kaxyl2ntmYrqvUM5cb5WOWQDxec6zQLZ2DXDEo7bV2rYP79OSQlf6gqHgtYKXuI=
X-Google-Smtp-Source: AGHT+IHB6cIwCd7MFFMCAP87JrzwSIq/qjP0ygozA+cHlN0eNVQu9ti2CtxWncpJ7dobXBjoNPQVRQ==
X-Received: by 2002:a17:90b:1083:b0:2d8:840d:d9f2 with SMTP id
 98e67ed59e1d1-2d8840ddbb7mr10226931a91.24.1725293305936; 
 Mon, 02 Sep 2024 09:08:25 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d8df40a2a4sm2308663a91.29.2024.09.02.09.08.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 09:08:25 -0700 (PDT)
Message-ID: <592a0bc6-fbf0-4189-bd47-7b7cc6fc7681@linaro.org>
Date: Mon, 2 Sep 2024 09:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: add two events for cpu_restore_state_from_tb()
 and cpu_io_recompile()
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Xingran Wang <wangxingran123456@outlook.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <SY8P282MB4322879DBA2E5E3E3B72B383A1912@SY8P282MB4322.AUSP282.PROD.OUTLOOK.COM>
 <87mskqcp5n.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87mskqcp5n.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102b.google.com
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

SGkgWGluZ3JhbiwNCg0KT24gOS8yLzI0IDAzOjQyLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+
IFhpbmdyYW4gV2FuZyA8d2FuZ3hpbmdyYW4xMjM0NTZAb3V0bG9vay5jb20+IHdyaXRlczoN
Cj4gDQo+PiBDdXJyZW50bHksIHRoZSBpbnN0cnVjdGlvbiBjb3VudCBvYnRhaW5lZCBieSBw
bHVnaW5zIHVzaW5nIHRoZSB0cmFuc2xhdGlvbg0KPj4gYmxvY2sgZXhlY3V0aW9uIGNhbGxi
YWNrIGlzIGxhcmdlciB0aGFuIHRoZSBhY3R1YWwgdmFsdWUuIEFkZGluZyBjYWxsYmFja3MN
Cj4+IGluIGNwdV9yZXN0b3JlX3N0YXRlX2Zyb21fdGIoKSBhbmQgY3B1X2lvX3JlY29tcGls
ZSgpIGFsbG93cyBwbHVnaW5zIHRvDQo+PiBjb3JyZWN0IHRoZSBpbnN0cnVjdGlvbiBjb3Vu
dCB3aGVuIGV4aXRpbmcgYSB0cmFuc2xhdGlvbiBibG9jaw0KPj4gbWlkLWV4ZWN1dGlvbiwg
cHJvcGVybHkgc3VidHJhY3RpbmcgdGhlIGV4Y2VzcyB1bmV4ZWN1dGVkDQo+PiBpbnN0cnVj
dGlvbnMuDQo+IA0KPiBUaGlzIHNtZWxscyBsaWtlIGV4cG9zaW5nIHR3byBtdWNoIG9mIHRo
ZSBUQ0cgaW50ZXJuYWxzIHRvIHRoZSBwbHVnaW4NCj4gbWVjaGFuaXNtLiBZb3UgY2FuIGFs
cmVhZHkgZGV0ZWN0IHdoZW4gd2UgZG9uJ3QgcmVhY2ggdGhlIGVuZCBvZiBhIGJsb2NrDQo+
IG9mIGluc3RydWN0aW9ucyBieSBpbnN0cnVtZW50YXRpb24gYXMgSSBkaWQgaW46DQo+IA0K
DQpJIGFncmVlIHRoYXQgdGhpcyBpcyBkZWZpbml0ZWx5IGEgUUVNVSBpbXBsZW1lbnRhdGlv
biAiZGV0YWlsIiwgYW5kIA0Kc2hvdWxkIG5vdCBiZSBhIGNvbmNlcm4gZm9yIGVuZCB1c2Vy
cy4NCg0KVGhlIGRvY3VtZW50YXRpb24gYWxyZWFkeSB3YXJucyB0aGF0IGFsbCBpbnN0cnVj
dGlvbnMgbWF5IG5vdCBleGVjdXRlLCANCmFuZCB0aGF0IGluIHRoaXMgY2FzZSwgaXQncyBi
ZXR0ZXIgdG8gaW5zdHJ1bWVudCB0aGVtIGRpcmVjdGx5LCBpbnN0ZWFkIA0Kb2YgVEI6IA0K
aHR0cHM6Ly93d3cucWVtdS5vcmcvZG9jcy9tYXN0ZXIvZGV2ZWwvdGNnLXBsdWdpbnMuaHRt
bCN0cmFuc2xhdGlvbi1ibG9ja3MuDQoNCkZpbmFsbHksIGV2ZW4gaWYgd2UgaW50ZWdyYXRl
ZCBhbiBBUEkgbGlrZSB3aGF0IHlvdSBwcm9wb3NlIGluIHRoaXMgDQpwYXRjaCwgSSB0aGlu
ayBpdCB3b3VsZCBiZSB2ZXJ5IGVhc3kgZm9yIHBsdWdpbnMgd3JpdGVycyB0byBtYWtlIGEg
DQptaXN0YWtlIHVzaW5nIGl0LCBhcyB5b3UgbmVlZCB0byBrZWVwIHRyYWNrIG9mIGV2ZXJ5
dGhpbmcgeW91cnNlbGYuDQoNCklmIHdlIHdhbnQgdG8gc3RheSBvbiB0aGUgdG9waWMgb2Yg
dGhpcyBwYXRjaCwgb25lIGRpcmVjdGlvbiB0aGF0IHdvdWxkIA0KYmUgYmV0dGVyIGluIG15
IG9waW5pb24gaXMgYSAiYWZ0ZXJfdGJfZXhlYyIgQVBJLCB3aGVyZSB0aGUgVEIgcGFzc2Vk
IGluIA0KcGFyYW1ldGVyIGlzIGd1YXJhbnRlZWQgdG8gaGF2ZSBhbGwgaXRzIGluc3RydWN0
aW9ucyB0aGF0IHdlcmUgZXhlY3V0ZWQgDQoobm90IGludGVycnVwdGVkKS4NCg0KPiAgICBN
ZXNzYWdlLUlkOiA8MjAyNDA3MTgxNDU5NTguMTMxNTI3MC0xLWFsZXguYmVubmVlQGxpbmFy
by5vcmc+DQo+ICAgIERhdGU6IFRodSwgMTggSnVsIDIwMjQgMTU6NTk6NTggKzAxMDANCj4g
ICAgU3ViamVjdDogW1JGQyBQQVRDSCB2M10gY29udHJpYi9wbHVnaW5zOiBjb250cm9sIGZs
b3cgcGx1Z2luDQo+ICAgIEZyb206ID0/VVRGLTg/cT9BbGV4PTIwQmVubj1DMz1BOWU/PSA8
YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gDQo+IFNvIHdoYXQgZXhhY3RseSBhcmUgd2Ug
dHJ5aW5nIHRvIGFjaGlldmUgaGVyZT8gQSBtb3JlIGVmZmljaWVudA0KPiBkZXRlY3Rpb24g
b2Ygc2hvcnQgYmxvY2tzPw0KPiANCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBYaW5ncmFuIFdh
bmcgPHdhbmd4aW5ncmFuMTIzNDU2QG91dGxvb2suY29tPg0KPj4gLS0tDQo+PiAgIGFjY2Vs
L3RjZy90cmFuc2xhdGUtYWxsLmMgICAgfCAgMjcgKysrKysrKysNCj4+ICAgaW5jbHVkZS9x
ZW11L3BsdWdpbi1ldmVudC5oICB8ICAgMiArDQo+PiAgIGluY2x1ZGUvcWVtdS9wbHVnaW4u
aCAgICAgICAgfCAgMjQgKysrKysrKw0KPj4gICBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4u
aCAgIHwgMTMxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+PiAgIHBs
dWdpbnMvYXBpLmMgICAgICAgICAgICAgICAgfCAgNzggKysrKysrKysrKysrKysrKysrKysr
DQo+PiAgIHBsdWdpbnMvY29yZS5jICAgICAgICAgICAgICAgfCAgNDIgKysrKysrKysrKysN
Cj4+ICAgcGx1Z2lucy9xZW11LXBsdWdpbnMuc3ltYm9scyB8ICAxMCArKysNCj4+ICAgdGVz
dHMvdGNnL3BsdWdpbnMvYmIuYyAgICAgICB8ICAyNSArKysrKysrDQo+PiAgIDggZmlsZXMg
Y2hhbmdlZCwgMzM5IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYWNjZWwv
dGNnL3RyYW5zbGF0ZS1hbGwuYyBiL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxsLmMNCj4+IGlu
ZGV4IGZkZjZkOGFjMTkuLjY0MmY2ODQzNzIgMTAwNjQ0DQo+PiAtLS0gYS9hY2NlbC90Y2cv
dHJhbnNsYXRlLWFsbC5jDQo+PiArKysgYi9hY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jDQo+
PiBAQCAtNjUsNiArNjUsNyBAQA0KPj4gICAjaW5jbHVkZSAiaW50ZXJuYWwtdGFyZ2V0Lmgi
DQo+PiAgICNpbmNsdWRlICJ0Y2cvcGVyZi5oIg0KPj4gICAjaW5jbHVkZSAidGNnL2luc24t
c3RhcnQtd29yZHMuaCINCj4+ICsjaW5jbHVkZSAicWVtdS9wbHVnaW4uaCINCj4+ICAgDQo+
PiAgIFRCQ29udGV4dCB0Yl9jdHg7DQo+PiAgIA0KPj4gQEAgLTIxOCw2ICsyMTksMTkgQEAg
dm9pZCBjcHVfcmVzdG9yZV9zdGF0ZV9mcm9tX3RiKENQVVN0YXRlICpjcHUsIFRyYW5zbGF0
aW9uQmxvY2sgKnRiLA0KPj4gICAgICAgICAgIGNwdS0+bmVnLmljb3VudF9kZWNyLnUxNi5s
b3cgKz0gaW5zbnNfbGVmdDsNCj4+ICAgICAgIH0NCj4+ICAgDQo+PiArI2lmZGVmIENPTkZJ
R19QTFVHSU4NCj4+ICsgICAgLyoNCj4+ICsgICAgICogTm90aWZ5IHRoZSBwbHVnaW4gd2l0
aCB0aGUgcmVsZXZhbnQgaW5mb3JtYXRpb24NCj4+ICsgICAgICogd2hlbiByZXN0b3Jpbmcg
dGhlIGV4ZWN1dGlvbiBzdGF0ZSBvZiBhIFRCLg0KPj4gKyAgICAgKi8NCj4+ICsgICAgc3Ry
dWN0IHFlbXVfcGx1Z2luX3RiX3Jlc3RvcmUgcHRiX3Jlc3RvcmU7DQo+PiArICAgIHB0Yl9y
ZXN0b3JlLmNwdV9pbmRleCA9IGNwdS0+Y3B1X2luZGV4Ow0KPj4gKyAgICBwdGJfcmVzdG9y
ZS5pbnNuc19sZWZ0ID0gaW5zbnNfbGVmdDsNCj4+ICsgICAgcHRiX3Jlc3RvcmUudGJfbiA9
IHRiLT5pY291bnQ7DQo+PiArICAgIHB0Yl9yZXN0b3JlLnRiX3BjID0gdGItPnBjOw0KPj4g
KyAgICBxZW11X3BsdWdpbl90Yl9yZXN0b3JlX2NiKGNwdSwgJnB0Yl9yZXN0b3JlKTsNCj4+
ICsjZW5kaWYNCj4+ICsNCj4gDQo+IFNlZSBhbHNvIHRoZSB1bndpbmQgcGF0Y2hlcyB3aGlj
aCBpcyBhIG1vcmUgZ2VuZXJpYyBhcHByb2FjaCB0byBlbnN1cmluZw0KPiAic3BlY2lhbCIg
cmVnaXN0ZXJzIGFyZSBzeW5jZWQgYXQgbWlkcG9pbnQgd2hlbiB1c2luZyB0aGUgcmVnaXN0
ZXIgQVBJOg0KPiANCj4gICAgTWVzc2FnZS1JZDogPDIwMjQwNjA2MDMyOTI2LjgzNTk5LTEt
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4NCj4gICAgRGF0ZTogV2VkLCAgNSBKdW4g
MjAyNCAyMDoyOToxNyAtMDcwMA0KPiAgICBTdWJqZWN0OiBbUEFUQ0ggdjIgMC85XSBwbHVn
aW5zOiBVc2UgdW53aW5kIGluZm8gZm9yIHNwZWNpYWwgZ2RiIHJlZ2lzdGVycw0KPiAgICBG
cm9tOiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4N
Cj4gDQo+IDxzbmlwPg0KPiANCg0KVGhhbmtzLA0KUGllcnJpY2sNCg==

