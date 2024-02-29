Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EC9C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 05:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfYq5-0007W6-Rn; Thu, 29 Feb 2024 00:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYq1-0007VZ-9B
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:20:10 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfYpy-0003A6-UU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 00:20:08 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-412bf4030daso349305e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 21:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709184004; x=1709788804; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nb51Icq/XpfQ9bgHck5+LGIsKq559gyPTObNavRzO9U=;
 b=GR7TDxO0t/1RNAorFnDQJ0gzFztSqaewKgZgv5o64GA+jPm4cNPpn6bBcMxo9FkA9R
 YQHePCMR0ml4G7wi6XkPbSHXKgaC1p0DMZE+bIhp0d0FzMDJMxMQhN2RKxNdFVqPnxKt
 Gm3/oh0IkDXoXa1dy5jMLL0+cJONXq7sLVtdKPreLV56E2YPi4KFS1gSymnE8Cg96jeO
 GTC83Bg99TuTrNeVb1B5TJicwNp1gXQZMsDui0UJrh7BKl4caajiG2GpX1XOHZrOqqqZ
 A3A5HUoEh07iLOyxpSNhY3fvtVi87gPBEBEWTHZVqbs1ADioz610YuYn7tX3qIWq36DA
 H5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709184004; x=1709788804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nb51Icq/XpfQ9bgHck5+LGIsKq559gyPTObNavRzO9U=;
 b=oRY69pa2pSQt1c9KR1y4xerSjuUiLoBZ0OKxrj8ffYfchtXMi/GkgYz+UpjzvmKZij
 sH6xHVd4A6MzKMvSSqEtbAUl8wSr0GlmmGHFi9xap/xeTNNJwOctnzYJIg6h0JApmTkq
 r0jw9nOsrpDlzA2a5MyOYMtjsCe5Cha9ms7rzYTl7VYVG8G1OPQwc3l/wtVYY/n6yyLi
 RZcYPTmjoegI1ET1hdX+QCg8cFOPRaKFdb5QQukebdUT9OyMppyCX1jGVSWV4Yfdotyn
 L13cYs9Kw6ktEI58yD2fZCu+bCqGd8WT1uHU2Do0JNCUOadaQc2UNuUZOa7TMZolwsbQ
 MjvQ==
X-Gm-Message-State: AOJu0YwrEuPjThcV1YOZ0VdY2jcCHLqWvz533lHRFnD6GrQd+Y0MlUXs
 ieQSZZyonRqc2fPLzNCcincWHBru573o7haxIk+TdJMr7xZPpAUsSbqfMKY+hPo=
X-Google-Smtp-Source: AGHT+IHe6tDdLKDW0Hoys+MdSKqHEdv53Ai00HWg8ECnfyBdcl9sdklGuiyacnWUbv+WCL8YSaS8ag==
X-Received: by 2002:adf:9ccc:0:b0:33d:afea:17ea with SMTP id
 h12-20020adf9ccc000000b0033dafea17eamr700620wre.39.1709184003758; 
 Wed, 28 Feb 2024 21:20:03 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056000022900b0033cf2063052sm635198wrz.111.2024.02.28.21.20.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 21:20:03 -0800 (PST)
Message-ID: <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org>
Date: Thu, 29 Feb 2024 09:19:58 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm> <875xy8b5sg.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <875xy8b5sg.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x335.google.com
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

T24gMi8yOS8yNCAyOjA4IEFNLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IEx1YyBNaWNoZWwg
PGx1Yy5taWNoZWxAYW1kLmNvbT4gd3JpdGVzOg0KPiANCj4+IEhpIFBpZXJyaWNrLA0KPj4N
Cj4+IE9uIDEzOjE0IE1vbiAyNiBGZWIgICAgICwgUGllcnJpY2sgQm91dmllciB3cm90ZToN
Cj4+PiBTaWduZWQtb2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQo+Pj4gLS0tDQo+Pj4gICB0ZXN0cy9wbHVnaW4vbWVtLmMgfCA0MCAr
KysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+Pj4gICAxIGZpbGUg
Y2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBk
aWZmIC0tZ2l0IGEvdGVzdHMvcGx1Z2luL21lbS5jIGIvdGVzdHMvcGx1Z2luL21lbS5jDQo+
Pj4gaW5kZXggNDRlOTEwNjViYTcuLmQ0NzI5ZjVlMDE1IDEwMDY0NA0KPj4+IC0tLSBhL3Rl
c3RzL3BsdWdpbi9tZW0uYw0KPj4+ICsrKyBiL3Rlc3RzL3BsdWdpbi9tZW0uYw0KPj4+IEBA
IC0xNiw5ICsxNiwxNCBAQA0KPj4+DQo+Pj4gICBRRU1VX1BMVUdJTl9FWFBPUlQgaW50IHFl
bXVfcGx1Z2luX3ZlcnNpb24gPSBRRU1VX1BMVUdJTl9WRVJTSU9OOw0KPj4+DQo+Pj4gLXN0
YXRpYyB1aW50NjRfdCBpbmxpbmVfbWVtX2NvdW50Ow0KPj4+IC1zdGF0aWMgdWludDY0X3Qg
Y2JfbWVtX2NvdW50Ow0KPj4+IC1zdGF0aWMgdWludDY0X3QgaW9fY291bnQ7DQo+Pj4gK3R5
cGVkZWYgc3RydWN0IHsNCj4+PiArICAgIHVpbnQ2NF90IG1lbV9jb3VudDsNCj4+PiArICAg
IHVpbnQ2NF90IGlvX2NvdW50Ow0KPj4+ICt9IENQVUNvdW50Ow0KPj4+ICsNCj4+PiArc3Rh
dGljIHN0cnVjdCBxZW11X3BsdWdpbl9zY29yZWJvYXJkICpjb3VudHM7DQo+Pj4gK3N0YXRp
YyBxZW11X3BsdWdpbl91NjQgbWVtX2NvdW50Ow0KPj4+ICtzdGF0aWMgcWVtdV9wbHVnaW5f
dTY0IGlvX2NvdW50Ow0KPj4NCj4+IEkgc2VlIHRoYXQgeW91IG1lcmdlZCBpbmxpbmUgYW5k
IGNhbGxiYWNrIGNvdW50cyBpbnRvIHRoZSBzYW1lIHZhcmlhYmxlLg0KPj4NCj4+IEkgd29u
ZGVyLi4uIEZvciB0aGlzIHRlc3QgZG9uJ3QgeW91IHdhbnQgdG8ga2VlcCBhIHBsYWluIHVp
bnQ2NF90IGZvcg0KPj4gY2FsbGJhY2sgY291bnRzPyBJIGhhdmUgdGhlIGZlZWxpbmcgdGhh
dCB0aGlzIHRlc3Qgd2FzIG1hZGUgc28gb25lIGNhbg0KPj4gbWFrZSBzdXJlIGlubGluZSBh
bmQgY2FsbGJhY2sgY291bnRzIG1hdGNoLg0KPiANCj4gSW5kZWVkIHRoZSBwcm9ibGVtIG5v
dyBpcyBkb3VibGUgY291bnRpbmc6DQo+IA0KPiAgICDinpwgIC4vcWVtdS1ocHBhIC1wbHVn
aW4gLi90ZXN0cy9wbHVnaW4vbGlibWVtLnNvLGlubGluZT10cnVlIC1kIHBsdWdpbiAgLi90
ZXN0cy90Y2cvaHBwYS1saW51eC11c2VyL3NoYTUxMg0KPiAgICAxLi4xMA0KPiAgICBvayAx
IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDIgLSBkb190ZXN0KCZ0ZXN0c1tpXSkN
Cj4gICAgb2sgMyAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayA0IC0gZG9fdGVzdCgm
dGVzdHNbaV0pDQo+ICAgIG9rIDUgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgNiAt
IGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayA3IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+
ICAgIG9rIDggLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgOSAtIGRvX3Rlc3QoJnRl
c3RzW2ldKQ0KPiAgICBvayAxMCAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBtZW0gYWNj
ZXNzZXM6IDI2MjkxNw0KPiAgICDwn5WZMjI6MDY6NTcgYWxleEBkcmFpZzpxZW11LmdpdC9i
dWlsZHMvYWxsICBvbiDugqAgcGx1Z2lucy9uZXh0IFskP10NCj4gICAg4p6cICAuL3FlbXUt
aHBwYSAtcGx1Z2luIC4vdGVzdHMvcGx1Z2luL2xpYm1lbS5zbyxpbmxpbmU9dHJ1ZSxjYWxs
YmFjaz10cnVlIC1kIHBsdWdpbiAgLi90ZXN0cy90Y2cvaHBwYS1saW51eC11c2VyL3NoYTUx
Mg0KPiAgICAxLi4xMA0KPiAgICBvayAxIC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9r
IDIgLSBkb190ZXN0KCZ0ZXN0c1tpXSkNCj4gICAgb2sgMyAtIGRvX3Rlc3QoJnRlc3RzW2ld
KQ0KPiAgICBvayA0IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDUgLSBkb190ZXN0
KCZ0ZXN0c1tpXSkNCj4gICAgb2sgNiAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayA3
IC0gZG9fdGVzdCgmdGVzdHNbaV0pDQo+ICAgIG9rIDggLSBkb190ZXN0KCZ0ZXN0c1tpXSkN
Cj4gICAgb2sgOSAtIGRvX3Rlc3QoJnRlc3RzW2ldKQ0KPiAgICBvayAxMCAtIGRvX3Rlc3Qo
JnRlc3RzW2ldKQ0KPiAgICBtZW0gYWNjZXNzZXM6IDUyNTgzNA0KPiANCj4gYWx0aG91Z2gg
cGVyaGFwcyBpdCB3b3VsZCBqdXN0IGJlIHNpbXBsZXIgZm9yIHRoZSBwbHVnaW4gdG8gb25s
eSBhY2NlcHQNCj4gb25lIG9yIHRoZSBvdGhlciBtZXRob2QuDQo+IA0KDQpNeSBiYWQuIE90
aGVyIHBsdWdpbnMgZW5hYmxlIG9ubHkgaW5saW5lIHdoZW4gYm90aCBhcmUgc3VwcGxpZWQs
IHNvIEkgDQptaXNzZWQgdGhpcyBoZXJlLg0KSSBhZGRlZCBhbiBleHBsaWNpdCBlcnJvciB3
aGVuIHVzZXIgZW5hYmxlIGNhbGxiYWNrIGFuZCBpbmxpbmUgYXQgdGhlIA0Kc2FtZSB0aW1l
IG9uIHRoaXMgcGx1Z2luLg0KDQo+Pg0KPj4gTHVjDQo+Pg0KPj4+ICAgc3RhdGljIGJvb2wg
ZG9faW5saW5lLCBkb19jYWxsYmFjazsNCj4+PiAgIHN0YXRpYyBib29sIGRvX2hhZGRyOw0K
Pj4+ICAgc3RhdGljIGVudW0gcWVtdV9wbHVnaW5fbWVtX3J3IHJ3ID0gUUVNVV9QTFVHSU5f
TUVNX1JXOw0KPj4+IEBAIC0yNywxNiArMzIsMTYgQEAgc3RhdGljIHZvaWQgcGx1Z2luX2V4
aXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdm9pZCAqcCkNCj4+PiAgIHsNCj4+PiAgICAgICBn
X2F1dG9wdHIoR1N0cmluZykgb3V0ID0gZ19zdHJpbmdfbmV3KCIiKTsNCj4+Pg0KPj4+IC0g
ICAgaWYgKGRvX2lubGluZSkgew0KPj4+IC0gICAgICAgIGdfc3RyaW5nX3ByaW50ZihvdXQs
ICJpbmxpbmUgbWVtIGFjY2Vzc2VzOiAlIiBQUkl1NjQgIlxuIiwgaW5saW5lX21lbV9jb3Vu
dCk7DQo+Pj4gLSAgICB9DQo+Pj4gLSAgICBpZiAoZG9fY2FsbGJhY2spIHsNCj4+PiAtICAg
ICAgICBnX3N0cmluZ19hcHBlbmRfcHJpbnRmKG91dCwgImNhbGxiYWNrIG1lbSBhY2Nlc3Nl
czogJSIgUFJJdTY0ICJcbiIsIGNiX21lbV9jb3VudCk7DQo+Pj4gKyAgICBpZiAoZG9faW5s
aW5lIHx8IGRvX2NhbGxiYWNrKSB7DQo+Pj4gKyAgICAgICAgZ19zdHJpbmdfcHJpbnRmKG91
dCwgIm1lbSBhY2Nlc3NlczogJSIgUFJJdTY0ICJcbiIsDQo+Pj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIHFlbXVfcGx1Z2luX3U2NF9zdW0obWVtX2NvdW50KSk7DQo+Pj4gICAgICAg
fQ0KPj4+ICAgICAgIGlmIChkb19oYWRkcikgew0KPj4+IC0gICAgICAgIGdfc3RyaW5nX2Fw
cGVuZF9wcmludGYob3V0LCAiaW8gYWNjZXNzZXM6ICUiIFBSSXU2NCAiXG4iLCBpb19jb3Vu
dCk7DQo+Pj4gKyAgICAgICAgZ19zdHJpbmdfYXBwZW5kX3ByaW50ZihvdXQsICJpbyBhY2Nl
c3NlczogJSIgUFJJdTY0ICJcbiIsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBxZW11X3BsdWdpbl91NjRfc3VtKGlvX2NvdW50KSk7DQo+Pj4gICAgICAgfQ0KPj4+
ICAgICAgIHFlbXVfcGx1Z2luX291dHMob3V0LT5zdHIpOw0KPj4+ICsgICAgcWVtdV9wbHVn
aW5fc2NvcmVib2FyZF9mcmVlKGNvdW50cyk7DQo+Pj4gICB9DQo+Pj4NCj4+PiAgIHN0YXRp
YyB2b2lkIHZjcHVfbWVtKHVuc2lnbmVkIGludCBjcHVfaW5kZXgsIHFlbXVfcGx1Z2luX21l
bWluZm9fdCBtZW1pbmZvLA0KPj4+IEBAIC00NiwxMiArNTEsMTIgQEAgc3RhdGljIHZvaWQg
dmNwdV9tZW0odW5zaWduZWQgaW50IGNwdV9pbmRleCwgcWVtdV9wbHVnaW5fbWVtaW5mb190
IG1lbWluZm8sDQo+Pj4gICAgICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9od2FkZHIgKmh3
YWRkcjsNCj4+PiAgICAgICAgICAgaHdhZGRyID0gcWVtdV9wbHVnaW5fZ2V0X2h3YWRkciht
ZW1pbmZvLCB2YWRkcik7DQo+Pj4gICAgICAgICAgIGlmIChxZW11X3BsdWdpbl9od2FkZHJf
aXNfaW8oaHdhZGRyKSkgew0KPj4+IC0gICAgICAgICAgICBpb19jb3VudCsrOw0KPj4+ICsg
ICAgICAgICAgICBxZW11X3BsdWdpbl91NjRfYWRkKGlvX2NvdW50LCBjcHVfaW5kZXgsIDEp
Ow0KPj4+ICAgICAgICAgICB9IGVsc2Ugew0KPj4+IC0gICAgICAgICAgICBjYl9tZW1fY291
bnQrKzsNCj4+PiArICAgICAgICAgICAgcWVtdV9wbHVnaW5fdTY0X2FkZChtZW1fY291bnQs
IGNwdV9pbmRleCwgMSk7DQo+Pj4gICAgICAgICAgIH0NCj4+PiAgICAgICB9IGVsc2Ugew0K
Pj4+IC0gICAgICAgIGNiX21lbV9jb3VudCsrOw0KPj4+ICsgICAgICAgIHFlbXVfcGx1Z2lu
X3U2NF9hZGQobWVtX2NvdW50LCBjcHVfaW5kZXgsIDEpOw0KPj4+ICAgICAgIH0NCj4+PiAg
IH0NCj4+Pg0KPj4+IEBAIC02NCw5ICs2OSwxMCBAQCBzdGF0aWMgdm9pZCB2Y3B1X3RiX3Ry
YW5zKHFlbXVfcGx1Z2luX2lkX3QgaWQsIHN0cnVjdCBxZW11X3BsdWdpbl90YiAqdGIpDQo+
Pj4gICAgICAgICAgIHN0cnVjdCBxZW11X3BsdWdpbl9pbnNuICppbnNuID0gcWVtdV9wbHVn
aW5fdGJfZ2V0X2luc24odGIsIGkpOw0KPj4+DQo+Pj4gICAgICAgICAgIGlmIChkb19pbmxp
bmUpIHsNCj4+PiAtICAgICAgICAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1f
aW5saW5lKGluc24sIHJ3LA0KPj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgUUVNVV9QTFVHSU5fSU5MSU5FX0FERF9VNjQsDQo+Pj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmaW5saW5l
X21lbV9jb3VudCwgMSk7DQo+Pj4gKyAgICAgICAgICAgIHFlbXVfcGx1Z2luX3JlZ2lzdGVy
X3ZjcHVfbWVtX2lubGluZV9wZXJfdmNwdSgNCj4+PiArICAgICAgICAgICAgICAgIGluc24s
IHJ3LA0KPj4+ICsgICAgICAgICAgICAgICAgUUVNVV9QTFVHSU5fSU5MSU5FX0FERF9VNjQs
DQo+Pj4gKyAgICAgICAgICAgICAgICBtZW1fY291bnQsIDEpOw0KPj4+ICAgICAgICAgICB9
DQo+Pj4gICAgICAgICAgIGlmIChkb19jYWxsYmFjaykgew0KPj4+ICAgICAgICAgICAgICAg
cWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV9tZW1fY2IoaW5zbiwgdmNwdV9tZW0sDQo+Pj4g
QEAgLTExNyw2ICsxMjMsMTAgQEAgUUVNVV9QTFVHSU5fRVhQT1JUIGludCBxZW11X3BsdWdp
bl9pbnN0YWxsKHFlbXVfcGx1Z2luX2lkX3QgaWQsDQo+Pj4gICAgICAgICAgIH0NCj4+PiAg
ICAgICB9DQo+Pj4NCj4+PiArICAgIGNvdW50cyA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRf
bmV3KHNpemVvZihDUFVDb3VudCkpOw0KPj4+ICsgICAgbWVtX2NvdW50ID0gcWVtdV9wbHVn
aW5fc2NvcmVib2FyZF91NjRfaW5fc3RydWN0KA0KPj4+ICsgICAgICAgIGNvdW50cywgQ1BV
Q291bnQsIG1lbV9jb3VudCk7DQo+Pj4gKyAgICBpb19jb3VudCA9IHFlbXVfcGx1Z2luX3Nj
b3JlYm9hcmRfdTY0X2luX3N0cnVjdChjb3VudHMsIENQVUNvdW50LCBpb19jb3VudCk7DQo+
Pj4gICAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfdmNwdV90Yl90cmFuc19jYihpZCwgdmNw
dV90Yl90cmFucyk7DQo+Pj4gICAgICAgcWVtdV9wbHVnaW5fcmVnaXN0ZXJfYXRleGl0X2Ni
KGlkLCBwbHVnaW5fZXhpdCwgTlVMTCk7DQo+Pj4gICAgICAgcmV0dXJuIDA7DQo+Pj4gLS0N
Cj4+PiAyLjQzLjANCj4+Pg0KPj4+DQo+IA0K

