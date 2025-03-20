Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D630C28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 19:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvLbO-0005l1-QR; Thu, 20 Mar 2025 15:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLb5-0005W5-QD
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:30:36 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvLb1-0005zJ-Lj
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 15:30:31 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-3018e2d042bso1545674a91.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 12:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742499025; x=1743103825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XMnc2L2EAy40CJ8xVLo6A7B0ZrYWBj245grBIfbUMYE=;
 b=ahG2YehrNwyiPockpR6c/5AEs3O5MWJaOR+7BauhVGID1k64YNjyiWPkmsx+cej2rO
 P7k7Q9D5Kf+Bj3AGKshvIIXPyUs+ph7x+cD8aE00NuVDynWvzCxS9dU84SHUAyCFO+S+
 J9DIHUPwwJIDx9BkABecv35RCOCcJpXJcvLHmRxKDK7Qsk6TBym7OU3whi7V4ckPPj08
 3dPEpXgGNHdNjeIqil6wtmHadDkbgRKR8lPPsk7q2/4Xt45KAxvk+ywVdWEFO+D+yg9+
 rEEW0jsE6tVRC0WhCf6xvi4IxSHLzPVHsDz2gmxMxcBzrmd8zlzRiiaMt1atAG5dst1r
 pGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742499025; x=1743103825;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XMnc2L2EAy40CJ8xVLo6A7B0ZrYWBj245grBIfbUMYE=;
 b=ju6fj4Va1JgIUwTnoqWqIQFHALhzI3SRzOimPq0EhMfZR9XHOoD40nFYJ72scvRMqc
 C7asCCB+7fK6vFh3Sm08Nbd0h0nRXSuq4l5lQAcTg6QmkEcnoeC9GRp8pIpC6k5Gxx7S
 PT4s+tolBltbUfWNtyBYZF2QFZeADq+KfAqg9LrVPg3j5aymxUDO01LW4D0MIJaCrjeZ
 wVsBbfT86kOGYgOhaERtAuNtCVTtxiID3OzcIohryWK9LyalY55M0APezYLlMp+EEx8P
 CPx8LqDo5+DD7EV+IXA6RakpgJ6sScGNP7+BULPqHG58Mj9oxsNeCONuQiM7uVV1DkH0
 leFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlBUkg3RnDV/vhNotxnrUTrRQixyIbBLQrq53g+eKQv8Ibl8go6HzDK7eSnRVBFUdtJeUX17eMjSnR@nongnu.org
X-Gm-Message-State: AOJu0Yy8rWmHZxy4unloXrFA5ARhjOlQaLDFfGJS+EvcTFGl0RRUKx/v
 Y8x097FYmrLTsAqOh7GKRAMBCQGt7wFMNhPZ5suFlO3ysfFE0u/Fh8pdMUSCqH4=
X-Gm-Gg: ASbGncuBTdthgH7hNINVt1fp+FbZxMT8CEQ/tYKOJ8wxOGuRGnraxKLT51m+KFJJX6h
 Pi+NQ/hwK3EZPvEZRx/ntUsz06DR7hTvvrgo4LwacFLQr5yh/e596bei9dmePksWhuzCkSBlkQi
 a2fQoR7hlqkrUl16Jn3s7qV+I1bO9S7X58cpb4Bj1HRoSo2BOtxRF1GeCpb/++Yh+JJyAjJYq/t
 AoBk9zUppbp1uIKNSU7YKlbv4jeEZ/EMPN1d/gpR+BM+tkgPCgoIybHncZHQOA6gqoJ1CgwmzPv
 zcFwIVTuFAfNrLV5giHeWXCt7cNV6kb507lZIJmIYOGNEQhJp659y1zrBg==
X-Google-Smtp-Source: AGHT+IEtcnNV5vRTPYEeAlzPTts09QQ79Tb8ei5he44d4LM/nKeia1R6Wh6BC3sxmEj/7IZoVq0Sbw==
X-Received: by 2002:a17:90b:1fce:b0:2fe:a8b1:7d8 with SMTP id
 98e67ed59e1d1-3030fef097cmr672299a91.25.1742499024726; 
 Thu, 20 Mar 2025 12:30:24 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3030f5d245dsm254702a91.13.2025.03.20.12.30.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 12:30:24 -0700 (PDT)
Message-ID: <2c441f75-8fd8-4792-a4e4-1ae7c78754ba@linaro.org>
Date: Thu, 20 Mar 2025 12:30:23 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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
ICpmZWF0dXJlKQ0KDQpJdCBjb3VsZCBiZSBwcmVmZXJhYmxlIHRvIHNldCBidWYgd2l0aCB0
aGUgdmFsdWUsIGluc3RlYWQgb2Ygc2ltcGx5IA0KYXBwZW5kaW5nIHRoZSB2YWx1ZS4gVGhp
cyB3YXksIHRoZXJlIGlzIG5vIG5lZWQgdG8gcmV0dXJuIHRoZSBzaXplLCBhcyANCml0J3Mg
Y29udGFpbmVkIGluIGJ1ZmZlciBzaXplIGl0c2VsZi4NCg0KSWYgd2UgaW5zaXN0IG9uIHJl
dHVybmluZyB0aGUgc2l6ZSwgaXQncyBiZXR0ZXIgdG8gbWFrZSBpdCBhIHBhcmFtZXRlciAN
CihhbmQgdXNlIGEgdm9pZCBwYXJhbWV0ZXIgdHlwZSksIGJlY2F1c2UgYXQgdGhlIG1vbWVu
dCwgaXQgZ2l2ZXMgdGhlIA0KaW1wcmVzc2lvbiB0aGUgZnVuY3Rpb24gaXRzZWxmIHJldHVy
bnMgdGhlIHZhbHVlLCB3aGljaCBtYXkgYmUgY29uZnVzaW5nLg0K

