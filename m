Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A44BCC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZs-0002sB-Dc; Fri, 04 Apr 2025 13:11:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZI-0002Mi-0D
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:11:00 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZE-0005nM-4k
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:59 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af548cb1f83so2054284a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786654; x=1744391454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KwRUGGdnMPMLzK2/WC78g5Gvk6943Ub7Zi5Vg0J6THc=;
 b=j0PZJASKK5+xR4tb1Nm6ptlcSF6o5WDe1KlFVj+yYRzblqj/wRCwm+0R7c4livvctD
 OUIXjpZ/0uUtY3WSuGA21lNUk09VUqzCiG9GqT1xHMqItbtibCDZhzVQOshxeHqCErOS
 fVkrecEmNtX2THJzYHvqPgNG6fnqgjwPKjghujw62tYKDxmIvLLRoOmvVgPQA/Xvu3pj
 f6xUgjibiDeHM5hS6Yv56/LYVR0qf2YkDXIDXPi6EDsD27V7rV+gW77eZjomPvPsXjde
 0xYnWNNljm/gYwR6dPFmVmiSzOfu8Vd4DlTCfZGdeojPrOsCMM/yfaN0Khv9lLGr1J15
 27Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786654; x=1744391454;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KwRUGGdnMPMLzK2/WC78g5Gvk6943Ub7Zi5Vg0J6THc=;
 b=Wk52aJttYzgt5NefrSCHb03Y5cHj5hL5p9Mk7+IDNZo/MCvdiU/VAHSdCVYUgkFu0h
 o+GxhUEZWH6pDoKnZsbriTuik4SXEdhk4PvngSvto4FyTCQqE2SN/vNND8kWxMM6Ym46
 1zEJolk0YzihtAcm7gfjAvS9pvUdIWa1hqw7wtE1Ef36PTrqWk07fGADE7RcVqM/j8+h
 7+lLNPP9arpeUaxuR8WsEYxVkJxKUfkhBJ5UcIVRyqrwJeP2qNgZdNE5zLSBMeEdD6E2
 Q/NB3g8y9EG4CdU8Qal+WOTk6aWe6p/l1iJjeVzyFHuJ2fXEakIZK6neBBLmhlHrwL8o
 1iGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjF7YagImL6X2/M1EjI/GqzgCE+TGRPu/LDV/EVGOchnocWnXI/YSZxFZvqZLI3le/fepLZNLV/zoB@nongnu.org
X-Gm-Message-State: AOJu0YwaTE33W04zhBw9KnLob7c2zXt2bUI0e7XdMotTuUc7Vi+6+Hwp
 QQ/AmueMbsKmkR2h/iL4OFsX0/d1Fz5+52wxZL9oh6qpVmfDMbyZImGVCACu1pE=
X-Gm-Gg: ASbGncs17b1Co+g8qwMfu02GYZX4ZYKOefEuvS/YjeJGbE0IbTZSkPxGvsH05lY3DzE
 x9FT9qxWutCyXE8m8K5uhKph6ACLic1MSnxYx4ZihvarkleAOGOtS6cUu1xoH086Ftn80sIeK3v
 fgmvinSbVKfPL2FZjZWu3ByMe1UWEdumTw3mRsE0JYm3yBb4JigI/kMe97tOqV5hVCECo+sNZaP
 t157UtzxIOYS7Bu7dot6blGxEBTzqreDx+Mzpxn0WQDzhEqvWqXbNziRW0dd0rgq8yRT/fBlBv+
 jR5ZbjOj5PfQNowIHFLyCbB8U+aSWnGgALmB711x4gUnrRJKkE/GFYk0qA==
X-Google-Smtp-Source: AGHT+IG4uC5K825enyd1p0rlg7ssR1PO3po+aus3KuzupXV5O14+84zojWF5/PWq1iI2j5hEvCqr6Q==
X-Received: by 2002:a17:90b:3d4c:b0:301:1c11:aa83 with SMTP id
 98e67ed59e1d1-306a489284emr5748133a91.28.1743786654200; 
 Fri, 04 Apr 2025 10:10:54 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3057ca498c6sm4357416a91.13.2025.04.04.10.10.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:53 -0700 (PDT)
Message-ID: <86fe4d7f-f0cd-42b9-99f0-b802337657b2@linaro.org>
Date: Fri, 4 Apr 2025 09:51:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 11/19] accel/tcg: Replace CPU_RESOLVING_TYPE
 -> target_cpu_type()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-12-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

T24gNC8zLzI1IDE2OjQ5LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2ln
bmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBhY2NlbC90Y2cvdGNnLWFsbC5jIHwgNCArKy0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hY2NlbC90Y2cvdGNnLWFsbC5jIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0KPiBp
bmRleCBiZjI3YzVjMGZiMy4uYTEzY2IzOTY0NGYgMTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3Rj
Zy90Y2ctYWxsLmMNCj4gKysrIGIvYWNjZWwvdGNnL3RjZy1hbGwuYw0KPiBAQCAtMzUsNiAr
MzUsNyBAQA0KPiAgICNpbmNsdWRlICJxYXBpL3FhcGktdHlwZXMtY29tbW9uLmgiDQo+ICAg
I2luY2x1ZGUgInFhcGkvcWFwaS1idWlsdGluLXZpc2l0LmgiDQo+ICAgI2luY2x1ZGUgInFl
bXUvdW5pdHMuaCINCj4gKyNpbmNsdWRlICJxZW11L3RhcmdldF9pbmZvLmgiDQo+ICAgI2lm
IGRlZmluZWQoQ09ORklHX1VTRVJfT05MWSkNCj4gICAjaW5jbHVkZSAiaHcvcWRldi1jb3Jl
LmgiDQo+ICAgI2Vsc2UNCj4gQEAgLTQ0LDcgKzQ1LDYgQEANCj4gICAjaW5jbHVkZSAiYWNj
ZWwvdGNnL2NwdS1vcHMuaCINCj4gICAjaW5jbHVkZSAiaW50ZXJuYWwtY29tbW9uLmgiDQo+
ICAgI2luY2x1ZGUgImNwdS1wYXJhbS5oIg0KPiAtI2luY2x1ZGUgImNwdS5oIg0KPiAgIA0K
PiAgIA0KPiAgIHN0cnVjdCBUQ0dTdGF0ZSB7DQo+IEBAIC03Myw3ICs3Myw3IEBAIGJvb2wg
cWVtdV90Y2dfbXR0Y2dfZW5hYmxlZCh2b2lkKQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIG10
dGNnX2luaXQoVENHU3RhdGUgKnMpDQo+ICAgew0KPiAtICAgIENQVUNsYXNzICpjYyA9IENQ
VV9DTEFTUyhvYmplY3RfY2xhc3NfYnlfbmFtZShDUFVfUkVTT0xWSU5HX1RZUEUpKTsNCj4g
KyAgICBDUFVDbGFzcyAqY2MgPSBDUFVfQ0xBU1Mob2JqZWN0X2NsYXNzX2J5X25hbWUodGFy
Z2V0X2NwdV90eXBlKCkpKTsNCj4gICAgICAgYm9vbCBtdHRjZ19zdXBwb3J0ZWQgPSBjYy0+
dGNnX29wcy0+bXR0Y2dfc3VwcG9ydGVkOw0KPiAgIA0KPiAgICAgICBpZiAocy0+bXR0Y2df
ZW5hYmxlZCA9PSBPTl9PRkZfQVVUT19BVVRPKSB7DQoNCkl0IGNhbiBiZSBzcXVhc2hlZCB3
aXRoIHByZXZpb3VzIGNvbW1pdC4NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg0K

