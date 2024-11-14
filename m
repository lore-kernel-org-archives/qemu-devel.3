Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCC3D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRDD-0004uG-8E; Wed, 13 Nov 2024 23:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRDB-0004qG-Kx
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:12:05 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRD9-0003j7-2t
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:12:05 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e5a62031aso102332b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557521; x=1732162321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U5xowOW/X8LNaHsNkXGFai5iT0WOJ2YHn8n6ZWYO4SI=;
 b=gT8rMUkk73EvAv3sewWIRwwaZmYpDl55tMrp1FNnuuV3CI0DT2DPjDhnP+zRsRT5zG
 eIPNCp4IantSnBmBZwWv9cjQNkqkxGJAOHkZZjyY3uY+6rNlHVcGin++VIzkOjic68Te
 aneUVorKXhGyMPbkG2E1RH1XVG2p8hql5dyo/6QNvIuwR9ctYq1rPqaqMw2vyKrNlxrH
 PRxirlFD+/mH8beL6Nu/YNOKEq7BTaRlhtj/ghYrpJcg+04aYSU61dTwNJddxseCm0ba
 RPMxT4eeKVS/ouNBCuuMkbKuelH/0zfKwHQgkj7lV4aeK0RM0E2Tib2Wpby9dkObR9Md
 f74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557521; x=1732162321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U5xowOW/X8LNaHsNkXGFai5iT0WOJ2YHn8n6ZWYO4SI=;
 b=RpSUjlcyKlh8VTsfiXWrCl++4UwfxehUJACNI+qj42isVwHoFySABJHXv6D6yEy1Xw
 YofNYLQpTgQEUUcvAuCA1NhNZQ3nAl6uWepaAHmsQvmLC40oLNG27dX5W5dp4y7nBsSX
 nsyOtmNwnJGwva7Wei7bqTxoR49qktg7IAsnvc/LYF6Kc2PAdgd68bFyO30CUZOm0nZj
 sfNqz0Wcy8NW9efwwyLO2CQjMSykjWxkwjVYC0oCsM0/5rvoG41h7/IkvQsIhAOebTob
 mKxQFtASyZefCvb5zXRQGcToeyQy7PQI/s6AaJM/vBRUS+WnO2qA+zmZmbrWXoh3JRlL
 1iug==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2v+5bBWhDZ8UMG1AezXeaFuW/2IAnSa8e6X55GYmdS+mZ1AToTrGzxivGP1ZXjj8KXoeUx7cOtArD@nongnu.org
X-Gm-Message-State: AOJu0Yw2TgNLEEct0fcJDLPll7wjXutbjyVVK4PJV4NOsbe8xvaqZOf4
 4YNU5hfnbpoO0u6PrnBAW/RbKWb5H7RD47KyAVE1rbyolA6BgW6EUUelqVPo4qk=
X-Google-Smtp-Source: AGHT+IG8SZRgP/EqiaNul+1oi2KZ+tQq8GWE3GmpdNTshl4psHJlLk7JxkkvTo0saA9tFsyYSc2J6g==
X-Received: by 2002:a05:6a00:b89:b0:71e:6eb:786e with SMTP id
 d2e1a72fcca58-72469cf6b3bmr908232b3a.13.1731557521577; 
 Wed, 13 Nov 2024 20:12:01 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a813d1dsm244950b3a.90.2024.11.13.20.12.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:12:01 -0800 (PST)
Message-ID: <976fdded-4ca7-4557-80d2-3fe4c54206d5@linaro.org>
Date: Wed, 13 Nov 2024 20:12:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] target/arm/cpu: Restrict cpu_untagged_addr() to
 user emulation
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-11-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gTW92ZSB0aGUgI2VuZGlmIGd1YXJkIHdoZXJlIGl0IGJlbG9uZ3MgdG8gcmVzdHJpY3QN
Cj4gdGhlIGNwdV91bnRhZ2dlZF9hZGRyKCkgaW1wbGVtZW50YXRpb24gdG8gdXNlcg0KPiBl
bXVsYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTD
qSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9hcm0vY3B1LmggfCA1
ICsrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvYXJtL2NwdS5oIGIvdGFyZ2V0L2Fy
bS9jcHUuaA0KPiBpbmRleCBkODZlNjQxMjgwLi4xMmI4NDY2NTQyIDEwMDY0NA0KPiAtLS0g
YS90YXJnZXQvYXJtL2NwdS5oDQo+ICsrKyBiL3RhcmdldC9hcm0vY3B1LmgNCj4gQEAgLTMz
NTUsOCArMzM1NSw4IEBAIGV4dGVybiBjb25zdCB1aW50NjRfdCBwcmVkX2Vzel9tYXNrc1s1
XTsNCj4gICAjZGVmaW5lIFRBR19HUkFOVUxFICAgICAgKDEgPDwgTE9HMl9UQUdfR1JBTlVM
RSkNCj4gICANCj4gICAjaWZkZWYgQ09ORklHX1VTRVJfT05MWQ0KPiArDQo+ICAgI2RlZmlu
ZSBUQVJHRVRfUEFHRV9EQVRBX1NJWkUgKFRBUkdFVF9QQUdFX1NJWkUgPj4gKExPRzJfVEFH
X0dSQU5VTEUgKyAxKSkNCj4gLSNlbmRpZg0KPiAgIA0KPiAgICNpZmRlZiBUQVJHRVRfVEFH
R0VEX0FERFJFU1NFUw0KPiAgIC8qKg0KPiBAQCAtMzM4Miw2ICszMzgyLDcgQEAgc3RhdGlj
IGlubGluZSB0YXJnZXRfdWxvbmcgY3B1X3VudGFnZ2VkX2FkZHIoQ1BVU3RhdGUgKmNzLCB0
YXJnZXRfdWxvbmcgeCkNCj4gICAgICAgfQ0KPiAgICAgICByZXR1cm4geDsNCj4gICB9DQo+
IC0jZW5kaWYNCj4gKyNlbmRpZiAvKiBUQVJHRVRfVEFHR0VEX0FERFJFU1NFUyAqLw0KPiAr
I2VuZGlmIC8qIENPTkZJR19VU0VSX09OTFkgKi8NCj4gICANCj4gICAjZW5kaWYNCg0KUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9y
Zz4NCg0K

