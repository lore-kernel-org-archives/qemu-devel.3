Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CFDC36001
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLhl-00080E-W3; Thu, 20 Mar 2025 15:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLhd-0007vC-Uh
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:37:20 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLhb-0006sd-03
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:37:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so34163525ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499433; x=1743104233; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pxoi1cxH7cqoTKJk/DMMUrTd9x5TTW/12K/9Wy5+Zig=;
 b=U9qHQ2aHS9q/eIvODVa3Rw0S89/L4OJqmdX5qABuSInXJSbH4+S5nsHAZ6629FyQ83
 3mpBPBj6BVRfrXhIfKTQNGkMKoR/kpsApzchMoNe5iCuspCsodFCOSgDjgdQ10JAe5Mb
 DLcinY90tFqkivEFI1Wi2O/944TZF6Zkj+5XSQY7BekVvLU8XpPT65JVgDPH8J2UvuoP
 oSt1Hc2OKo6qh7lDQVM6t7CmVRFEeFzCaQMc/QZoHdV5FG0ntxYZ/Q8HaAbtraqCn+3S
 +eTpccGm1DTQhA5a273cfwvBf2lg32aclFwa95iR1NaXI01/Tx3c/1OtwYsVkbuuDYx0
 Syjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499433; x=1743104233;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pxoi1cxH7cqoTKJk/DMMUrTd9x5TTW/12K/9Wy5+Zig=;
 b=KEV+NVYHsjeuA3cBAiPPX2FF/NpfjMhu2ChTzv/EJ9CsO1mdCktlVfrNa20ju2ONME
 vGVpglvz/majC4eZ3uX5DGSIdywqFnamx8OaWRQJRxg2xlIo7cuMRPvvHwNnbbLNrpaQ
 ol3IUxoDXl9V9OBkZdsGzPxgn2WBZGSz+OYWM0umgLZAWm5XZyjNLIzqj5YtmFY+JKKn
 SU08ZcNiWNMKJbVKuUgV5KprOrD563rs5paUty3durwUe51uKjucKLUEJGvPO5iqwWYK
 RTFV//xfNJQPSZAI32AgPin+eSaKwVNTSmFIgtVnC0ioFq1kvkGAsVuMsacmpM83Vv71
 jM5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+cbsIbaT965tSP1ROmZ2pFHype1nMgyCq63fUbhqzpVojrElHtlYC5vWVbig649soqeTDvQE67X30@nongnu.org
X-Gm-Message-State: AOJu0YzoFK3EFYnDvVy5jLxo0hhh9zQBfF0QIo8A/MCAFAdtp7HlHiTZ
 we3BAkY5CeQ9BFLgR1jsOwVg3D2yxjmwmYRURwpnvGU0FDiyIgi2mt4qLVICLxM=
X-Gm-Gg: ASbGncvNBgQ2Qd7JDtY7IdRricrzvYJibykyj1ZYSfaEN8aoHHhheos0Y9wOoJjkXAB
 T6eFNyHay6QX51MnffeI3Yz/V85p1FGJuQjFIk501MMQfgtRNY5xIcSyJfP1Df2FkFiKhTfEhkK
 DMDAvTRsw+88FpoBJRvG3zm4d86A07oRz7hLrar+/MpE+tngECMnmcNTpQ8w5HMQnoq7kjJLP2d
 krcti0/D7PH2yMTXwuQmaIyeYGR+XKoh+84FSOR6MAmHSZVy63MCudpsLkZ51lDkJ409hXWrxum
 +nzDNAxaLzE8VoE7Mc9TD3jSJEj8y+mkjp8499fhUhIpmev49GxMrB6JDVvp12pJgeIU
X-Google-Smtp-Source: AGHT+IH1lpebtKCd0+yKJ8dIHs0gB7TfcagCkHawaZJtflaRzg+5Y61b5gt9mjCE3n2LzHet+2omcA==
X-Received: by 2002:a05:6a21:496:b0:1f5:6c94:2cc9 with SMTP id
 adf61e73a8af0-1fe42f9c5c7mr1092824637.22.1742499433346; 
 Thu, 20 Mar 2025 12:37:13 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a652a2sm273421a12.76.2025.03.20.12.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:37:12 -0700 (PDT)
Message-ID: <1b26f846-0e0a-425b-96c8-bf2a8b489421@linaro.org>
Date: Thu, 20 Mar 2025 12:37:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] gdbstub: introduce target independent gdb register
 helper
Content-Language: en-US
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250319182255.3096731-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMy8xOS8yNSAxMToyMiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgY3VycmVudCBo
ZWxwZXIuaCBmdW5jdGlvbnMgcmVseSBvbiBoYXJkIGNvZGVkIGFzc3VtcHRpb25zIGFib3V0
DQo+IHRhcmdldCBlbmRpYW5lc3MgdG8gdXNlIHRoZSB0c3dhcCBtYWNyb3MuIFdlIGFsc28g
ZW5kIHVwIGRvdWJsZQ0KPiBzd2FwcGluZyBhIGJ1bmNoIG9mIHZhbHVlcyBpZiB0aGUgdGFy
Z2V0IGNhbiBydW4gaW4gbXVsdGlwbGUgZW5kaWFuZXNzDQo+IG1vZGVzLiBBdm9pZCB0aGlz
IGJ5IGdldHRpbmcgdGhlIHRhcmdldCB0byBwYXNzIHRoZSBlbmRpYW5lc3MgYW5kIHNpemUN
Cj4gdmlhIGEgTWVtT3AgYW5kIGZpeGluZyB1cCBhcHByb3ByaWF0ZWx5Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAt
LS0NCj4gICBpbmNsdWRlL2dkYnN0dWIvcmVnaXN0ZXJzLmggfCAzMCArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gICBnZGJzdHViL2dkYnN0dWIuYyAgICAgICAgICAgfCAy
MiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNl
cnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZ2Ric3R1Yi9yZWdp
c3RlcnMuaA0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMu
aCBiL2luY2x1ZGUvZ2Ric3R1Yi9yZWdpc3RlcnMuaA0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiBpbmRleCAwMDAwMDAwMDAwLi40YWJjN2E2YWU3DQo+IC0tLSAvZGV2L251bGwNCj4g
KysrIGIvaW5jbHVkZS9nZGJzdHViL3JlZ2lzdGVycy5oDQo+IEBAIC0wLDAgKzEsMzAgQEAN
Cj4gKy8qDQo+ICsgKiBHREIgQ29tbW9uIFJlZ2lzdGVyIEhlbHBlcnMNCj4gKyAqDQo+ICsg
KiBDb3B5cmlnaHQgKGMpIDIwMjUgTGluYXJvIEx0ZA0KPiArICoNCj4gKyAqIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQo+ICsgKi8NCj4gKw0KPiArI2lm
bmRlZiBHREJfUkVHSVNURVJTX0gNCj4gKyNkZWZpbmUgR0RCX1JFR0lTVEVSU19IDQo+ICsN
Cj4gKyNpbmNsdWRlICJleGVjL21lbW9wLmgiDQo+ICsNCj4gKy8qKg0KPiArICogZ2RiX2dl
dF9yZWdpc3Rlcl92YWx1ZSgpIC0gZ2V0IHJlZ2lzdGVyIHZhbHVlIGZvciBnZGINCj4gKyAq
IG1vOiBzaXplIGFuZCBlbmRpYW4gTWVtT3ANCj4gKyAqIGJ1ZjogR0J5dGVBcnJheSB0byBz
dG9yZSBpbiB0YXJnZXQgb3JkZXINCj4gKyAqIHZhbDogcG9pbnRlciB0byB2YWx1ZSBpbiBo
b3N0IG9yZGVyDQo+ICsgKg0KPiArICogVGhpcyByZXBsYWNlcyB0aGUgcHJldmlvdXMgbGVn
YWN5IHJlYWQgZnVuY3Rpb25zIHdpdGggYSBzaW5nbGUNCj4gKyAqIGZ1bmN0aW9uIHRvIGhh
bmRsZSBhbGwgc2l6ZXMuIFBhc3NpbmcgQG1vIGFsbG93cyB0aGUgdGFyZ2V0IG1vZGUgdG8N
Cj4gKyAqIGJlIHRha2VuIGludG8gYWNjb3VudCBhbmQgYXZvaWRzIHVzaW5nIGhhcmQgY29k
ZWQgdHN3YXAoKSBtYWNyb3MuDQo+ICsgKg0KPiArICogUmV0dXJucyB0aGUgbnVtYmVyIG9m
IGJ5dGVzIHdyaXR0ZW4gdG8gdGhlIGFycmF5Lg0KPiArICovDQo+ICtpbnQgZ2RiX2dldF9y
ZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwgR0J5dGVBcnJheSAqYnVmLCB1aW50OF90ICp2YWwp
Ow0KPiArDQo+ICsjZW5kaWYgLyogR0RCX1JFR0lTVEVSU19IICovDQo+ICsNCj4gKw0KPiBk
aWZmIC0tZ2l0IGEvZ2Ric3R1Yi9nZGJzdHViLmMgYi9nZGJzdHViL2dkYnN0dWIuYw0KPiBp
bmRleCAyODJlMTNlMTYzLi4zZDdiMTAyOGU0IDEwMDY0NA0KPiAtLS0gYS9nZGJzdHViL2dk
YnN0dWIuYw0KPiArKysgYi9nZGJzdHViL2dkYnN0dWIuYw0KPiBAQCAtMzIsNiArMzIsNyBA
QA0KPiAgICNpbmNsdWRlICJleGVjL2dkYnN0dWIuaCINCj4gICAjaW5jbHVkZSAiZ2Ric3R1
Yi9jb21tYW5kcy5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHViL3N5c2NhbGxzLmgiDQo+ICsj
aW5jbHVkZSAiZ2Ric3R1Yi9yZWdpc3RlcnMuaCINCj4gICAjaWZkZWYgQ09ORklHX1VTRVJf
T05MWQ0KPiAgICNpbmNsdWRlICJhY2NlbC90Y2cvdmNwdS1zdGF0ZS5oIg0KPiAgICNpbmNs
dWRlICJnZGJzdHViL3VzZXIuaCINCj4gQEAgLTQ1LDYgKzQ2LDcgQEANCj4gICAjaW5jbHVk
ZSAic3lzdGVtL3J1bnN0YXRlLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvcmVwbGF5LWNvcmUu
aCINCj4gICAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCINCj4gKyNpbmNsdWRlICJleGVjL21l
bW9wLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgImludGVybmFscy5oIg0KPiAgIA0KPiBAQCAt
NTUxLDYgKzU1MywyNiBAQCBzdGF0aWMgaW50IGdkYl93cml0ZV9yZWdpc3RlcihDUFVTdGF0
ZSAqY3B1LCB1aW50OF90ICptZW1fYnVmLCBpbnQgcmVnKQ0KPiAgICAgICByZXR1cm4gMDsN
Cj4gICB9DQo+ICAgDQo+ICsvKg0KPiArICogVGFyZ2V0IGhlbHBlciBmdW5jdGlvbiB0byBy
ZWFkIHZhbHVlIGludG8gR0J5dGVBcnJheSwgdGFyZ2V0DQo+ICsgKiBzdXBwbGllcyB0aGUg
c2l6ZSBhbmQgdGFyZ2V0IGVuZGlhbmVzcyB2aWEgdGhlIE1lbU9wLg0KPiArICovDQo+ICtp
bnQgZ2RiX2dldF9yZWdpc3Rlcl92YWx1ZShNZW1PcCBvcCwgR0J5dGVBcnJheSAqYnVmLCB1
aW50OF90ICp2YWwpDQo+ICt7DQo+ICsgICAgc2l6ZV90IGJ5dGVzID0gbWVtb3Bfc2l6ZShv
cCk7DQo+ICsNCj4gKyAgICBpZiAob3AgJiBNT19CU1dBUCkgew0KPiArICAgICAgICBmb3Ig
KCBpbnQgaSA9IGJ5dGVzIDsgaSA+IDA7IGktLSkgew0KPiArICAgICAgICAgICAgZ19ieXRl
X2FycmF5X2FwcGVuZChidWYsICZ2YWxbaSAtIDFdLCAxKTsNCj4gKyAgICAgICAgfTsNCj4g
KyAgICB9IGVsc2Ugew0KPiArICAgICAgICBnX2J5dGVfYXJyYXlfYXBwZW5kKGJ1ZiwgdmFs
LCBieXRlcyk7DQo+ICsgICAgfQ0KPiArDQo+ICsgICAgcmV0dXJuIGJ5dGVzOw0KPiArfQ0K
PiArDQo+ICsNCj4gICBzdGF0aWMgdm9pZCBnZGJfcmVnaXN0ZXJfZmVhdHVyZShDUFVTdGF0
ZSAqY3B1LCBpbnQgYmFzZV9yZWcsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ2RiX2dldF9yZWdfY2IgZ2V0X3JlZywgZ2RiX3NldF9yZWdfY2Igc2V0X3JlZywN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBHREJGZWF0dXJl
ICpmZWF0dXJlKQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0KDQo=

