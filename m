Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4721FD6B6DD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 22:48:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6HTi-00041X-40; Wed, 30 Oct 2024 18:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6HTg-0003vJ-EM
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 18:47:48 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6HTe-0007QY-0o
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 18:47:47 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-72070d341e5so280250b3a.1
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 15:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730328464; x=1730933264; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9WG0L8L4pTSzdJPL1A8eXwluuMp3d1tLHV8dwbpgQ2M=;
 b=B4FRG/OcljqxMhJ4FVUcmt1fCTFOdWwcPG/ETvvO0YCfV25Q8FSAbzWrRJoxyH0+eL
 DbRuwEZQoAXDpJaJPVpBX5H351PU7GivxsneioD08Qdxv/FBe0oQBntwX5ahLhSABned
 EXc85+kE0iZZDiysv9lEO30xcSgMSkxex4+6ShyOBYB2xmmXrMcwsmNBpmQt7s88zkuq
 WV5xHBf04pWaDAnqJa+LnNohhJeKaBjAejTP1MVTFVgG7PRpX15mJniMF5xcMAduFJfm
 GpMtStTGo2cNjna9zLFhjzM9GvqUXXJ7k+JDKZlVjLqb1Ep5/i5+CJ0PapkemuMY74rA
 BnLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730328464; x=1730933264;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9WG0L8L4pTSzdJPL1A8eXwluuMp3d1tLHV8dwbpgQ2M=;
 b=VDKv/0DmHpp5EhTwmAg235LZhxGD0W0ZoI4GKCtdiMWsHzVrKxX20LCr6LE2FK25VP
 5tindKw66BNly7SFYwqyLeiPLVtBmcxmeokHVixy+I2RukEp4+qEPznY3orsCnslX2eu
 dBr4UomE3A7bn+h2n/2PoMrsxk9rIP9qPk5ymZ1it6tRAG3dwi3bCKTcHYYiZRhSH/kg
 bYH46AqoOir+jFB3unh5Tt8RB1EcV/I9G9PlqisIa5Q7cIRIB4v4o0YviDu2C6ffd9FB
 0/qxZ4DOoQrG1y6+bti/VniUamUrFGw4uiJoGFB0K71x/+gzgf0Q7efzDs2AGzO16v7b
 pyCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6NvZ++0sb5R8yOpeitmKyvtXbhJEcVSv1mQAwNMP1IE/35XqFycavT+uaIXZTHqlQmEIdCo0v58Wy@nongnu.org
X-Gm-Message-State: AOJu0Yyb4BkrQj7V1tTA30ZUKn506homKeoTv5JUtH2t8Fcz4vYuYj1k
 kpTkabHKfNp+tLPrPmVyLmpXx7EHZBu4XM7SbxD2QRvRkawoTcz20njQG7iTqmA=
X-Google-Smtp-Source: AGHT+IEwcz72Tj5S2eKqT5WAA4YrSp3uPRhIuGIdYciVM1J4zZ3qiicGc+jCjZzjci4gQN6YidktPg==
X-Received: by 2002:a05:6a21:2d8b:b0:1d9:28f8:f27d with SMTP id
 adf61e73a8af0-1db91e533camr1276968637.38.1730328464547; 
 Wed, 30 Oct 2024 15:47:44 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0dfe2sm94672a12.83.2024.10.30.15.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2024 15:47:44 -0700 (PDT)
Message-ID: <ca8c111c-7db4-45e2-940a-efc44d600467@linaro.org>
Date: Wed, 30 Oct 2024 15:47:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] target/mips: Remove unreachable 32-bit code on
 64-bit Loongson Ext
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20241026175349.84523-1-philmd@linaro.org>
 <20241026175349.84523-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241026175349.84523-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gMTAvMjYvMjQgMTA6NTMsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPiBM
b29uZ3NvbiBmaXhlZC1wb2ludCBtdWx0aXBsaWVzIGFuZCBkaXZpc2lvbnMgb3Bjb2RlcyBh
cmUNCj4gc3BlY2lmaWMgdG8gNjQtYml0IGNvcmVzIChMb29uZ3Nvbi0yIGFuZCBMb29uZ3Nv
bi0zIGZhbWlsaWVzKS4NCj4gU2ltcGxpZnkgYnkgcmVtb3ZpbmcgdGhlIDMyLWJpdCBjaGVj
a3MuDQo+IA0KPiBSZXBvcnRlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUt
RGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGFyZ2V0L21pcHMvdGNn
L2xvb25nX3RyYW5zbGF0ZS5jIHwgNDEgKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3RhcmdldC9taXBzL3RjZy9sb29uZ190cmFuc2xhdGUu
YyBiL3RhcmdldC9taXBzL3RjZy9sb29uZ190cmFuc2xhdGUuYw0KPiBpbmRleCBjMDJlNjBi
YjE1Yi4uYTAwNWMyNzlhM2UgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9taXBzL3RjZy9sb29u
Z190cmFuc2xhdGUuYw0KPiArKysgYi90YXJnZXQvbWlwcy90Y2cvbG9vbmdfdHJhbnNsYXRl
LmMNCj4gQEAgLTMxLDEzICszMSw2IEBAIHN0YXRpYyBib29sIGdlbl9sZXh0X0RJVl9HKERp
c2FzQ29udGV4dCAqcywgaW50IHJkLCBpbnQgcnMsIGludCBydCwNCj4gICAgICAgVENHdiB0
MCwgdDE7DQo+ICAgICAgIFRDR0xhYmVsICpsMSwgKmwyLCAqbDM7DQo+ICAgDQo+IC0gICAg
aWYgKGlzX2RvdWJsZSkgew0KPiAtICAgICAgICBpZiAoVEFSR0VUX0xPTkdfQklUUyAhPSA2
NCkgew0KPiAtICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiAtICAgICAgICB9DQo+IC0g
ICAgICAgIGNoZWNrX21pcHNfNjQocyk7DQo+IC0gICAgfQ0KPiAtDQo+ICAgICAgIGlmIChy
ZCA9PSAwKSB7DQo+ICAgICAgICAgICAvKiBUcmVhdCBhcyBOT1AuICovDQo+ICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gQEAgLTYxLDggKzU0LDcgQEAgc3RhdGljIGJvb2wgZ2VuX2xl
eHRfRElWX0coRGlzYXNDb250ZXh0ICpzLCBpbnQgcmQsIGludCBycywgaW50IHJ0LA0KPiAg
ICAgICB0Y2dfZ2VuX2JyKGwzKTsNCj4gICAgICAgZ2VuX3NldF9sYWJlbChsMSk7DQo+ICAg
DQo+IC0gICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX05FLCB0MCwgaXNfZG91Ymxl
ICYmIFRBUkdFVF9MT05HX0JJVFMgPT0gNjQNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICA/IExMT05HX01JTiA6IElOVF9NSU4sIGwyKTsNCj4gKyAgICB0
Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfTkUsIHQwLCBpc19kb3VibGUgPyBMTE9OR19N
SU4gOiBJTlRfTUlOLCBsMik7DQo+ICAgICAgIHRjZ19nZW5fYnJjb25kaV90bChUQ0dfQ09O
RF9ORSwgdDEsIC0xTEwsIGwyKTsNCj4gICAgICAgdGNnX2dlbl9tb3ZfdGwoY3B1X2dwclty
ZF0sIHQwKTsNCj4gICANCj4gQEAgLTkzLDEzICs4NSw2IEBAIHN0YXRpYyBib29sIGdlbl9s
ZXh0X0RJVlVfRyhEaXNhc0NvbnRleHQgKnMsIGludCByZCwgaW50IHJzLCBpbnQgcnQsDQo+
ICAgICAgIFRDR3YgdDAsIHQxOw0KPiAgICAgICBUQ0dMYWJlbCAqbDEsICpsMjsNCj4gICAN
Cj4gLSAgICBpZiAoaXNfZG91YmxlKSB7DQo+IC0gICAgICAgIGlmIChUQVJHRVRfTE9OR19C
SVRTICE9IDY0KSB7DQo+IC0gICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0gICAgICAg
IH0NCj4gLSAgICAgICAgY2hlY2tfbWlwc182NChzKTsNCj4gLSAgICB9DQo+IC0NCj4gICAg
ICAgaWYgKHJkID09IDApIHsNCj4gICAgICAgICAgIC8qIFRyZWF0IGFzIE5PUC4gKi8NCj4g
ICAgICAgICAgIHJldHVybiB0cnVlOw0KPiBAQCAtMTQ3LDEzICsxMzIsNiBAQCBzdGF0aWMg
Ym9vbCBnZW5fbGV4dF9NT0RfRyhEaXNhc0NvbnRleHQgKnMsIGludCByZCwgaW50IHJzLCBp
bnQgcnQsDQo+ICAgICAgIFRDR3YgdDAsIHQxOw0KPiAgICAgICBUQ0dMYWJlbCAqbDEsICps
MiwgKmwzOw0KPiAgIA0KPiAtICAgIGlmIChpc19kb3VibGUpIHsNCj4gLSAgICAgICAgaWYg
KFRBUkdFVF9MT05HX0JJVFMgIT0gNjQpIHsNCj4gLSAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsNCj4gLSAgICAgICAgfQ0KPiAtICAgICAgICBjaGVja19taXBzXzY0KHMpOw0KPiAtICAg
IH0NCj4gLQ0KPiAgICAgICBpZiAocmQgPT0gMCkgew0KPiAgICAgICAgICAgLyogVHJlYXQg
YXMgTk9QLiAqLw0KPiAgICAgICAgICAgcmV0dXJuIHRydWU7DQo+IEBAIC0xNzMsOCArMTUx
LDcgQEAgc3RhdGljIGJvb2wgZ2VuX2xleHRfTU9EX0coRGlzYXNDb250ZXh0ICpzLCBpbnQg
cmQsIGludCBycywgaW50IHJ0LA0KPiAgICAgICAgICAgdGNnX2dlbl9leHQzMnVfdGwodDEs
IHQxKTsNCj4gICAgICAgfQ0KPiAgICAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRf
RVEsIHQxLCAwLCBsMSk7DQo+IC0gICAgdGNnX2dlbl9icmNvbmRpX3RsKFRDR19DT05EX05F
LCB0MCwgaXNfZG91YmxlICYmIFRBUkdFVF9MT05HX0JJVFMgPT0gNjQNCj4gLSAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA/IExMT05HX01JTiA6IElOVF9NSU4s
IGwyKTsNCj4gKyAgICB0Y2dfZ2VuX2JyY29uZGlfdGwoVENHX0NPTkRfTkUsIHQwLCBpc19k
b3VibGUgPyBMTE9OR19NSU4gOiBJTlRfTUlOLCBsMik7DQo+ICAgICAgIHRjZ19nZW5fYnJj
b25kaV90bChUQ0dfQ09ORF9ORSwgdDEsIC0xTEwsIGwyKTsNCj4gICAgICAgZ2VuX3NldF9s
YWJlbChsMSk7DQo+ICAgICAgIHRjZ19nZW5fbW92aV90bChjcHVfZ3ByW3JkXSwgMCk7DQo+
IEBAIC0yMDUsMTMgKzE4Miw2IEBAIHN0YXRpYyBib29sIGdlbl9sZXh0X01PRFVfRyhEaXNh
c0NvbnRleHQgKnMsIGludCByZCwgaW50IHJzLCBpbnQgcnQsDQo+ICAgICAgIFRDR3YgdDAs
IHQxOw0KPiAgICAgICBUQ0dMYWJlbCAqbDEsICpsMjsNCj4gICANCj4gLSAgICBpZiAoaXNf
ZG91YmxlKSB7DQo+IC0gICAgICAgIGlmIChUQVJHRVRfTE9OR19CSVRTICE9IDY0KSB7DQo+
IC0gICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+IC0gICAgICAgIH0NCj4gLSAgICAgICAg
Y2hlY2tfbWlwc182NChzKTsNCj4gLSAgICB9DQo+IC0NCj4gICAgICAgaWYgKHJkID09IDAp
IHsNCj4gICAgICAgICAgIC8qIFRyZWF0IGFzIE5PUC4gKi8NCj4gICAgICAgICAgIHJldHVy
biB0cnVlOw0KPiBAQCAtMjU3LDEzICsyMjcsNiBAQCBzdGF0aWMgYm9vbCBnZW5fbGV4dF9N
VUxUX0coRGlzYXNDb250ZXh0ICpzLCBpbnQgcmQsIGludCBycywgaW50IHJ0LA0KPiAgIHsN
Cj4gICAgICAgVENHdiB0MCwgdDE7DQo+ICAgDQo+IC0gICAgaWYgKGlzX2RvdWJsZSkgew0K
PiAtICAgICAgICBpZiAoVEFSR0VUX0xPTkdfQklUUyAhPSA2NCkgew0KPiAtICAgICAgICAg
ICAgcmV0dXJuIGZhbHNlOw0KPiAtICAgICAgICB9DQo+IC0gICAgICAgIGNoZWNrX21pcHNf
NjQocyk7DQo+IC0gICAgfQ0KPiAtDQo+ICAgICAgIGlmIChyZCA9PSAwKSB7DQo+ICAgICAg
ICAgICAvKiBUcmVhdCBhcyBOT1AuICovDQo+ICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCg0K
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCg==

