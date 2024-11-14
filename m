Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF33D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:12:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRCu-00041D-N4; Wed, 13 Nov 2024 23:11:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCs-000406-HA
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:46 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCp-0003fv-S9
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-720aa3dbda5so94900b3a.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557502; x=1732162302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l9dXBdm7BssboJS703vUyvBvvYyv8Ly8Z+LfP38IxVw=;
 b=gOxAptEd889hMjf7hqWdIpWRVofauqRRYP0J7OZcYQZ/AoyM6g7mZP0BJ733ynhj9a
 IAj0c4McbP13DKz1B8YP8Wk1qD3s7CEscVWxvwdukWQq1J1DSYG8PuCJdS4Oy2sPXJJr
 ELVtoU6medHJscRm3oVsjAREvWcnfznpAPspfG8XGWyfho7WT41VW3U50BhTjvoNCxn2
 dC+OUm+MwcaCI1UPwA6wAjy+h7RiPFA2me9uT12fr4gcmZ6p2rnGBnKAreOdI2m/N5kk
 cIhZkMnL3HFRWwrNU0t8j1XZGE6phYilo28XdbCU6VaU9qgtErUcRThGWYx42CnYL0l2
 bVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557502; x=1732162302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l9dXBdm7BssboJS703vUyvBvvYyv8Ly8Z+LfP38IxVw=;
 b=cY62exOXjrSIPOhk+WNiNmmmWggIaW+7n6A3x7KxhiKlRUjsKVjetA2EshvC7b8tkx
 Yp5O1fPfHZNDtA8iDl76WASkBC8TdUxXVRhiEcrBfN+hwtg8Kq7QKGCnzov+wBkCipux
 skGcRRrXX90+xwgr7OT60K/CwdqYi/nOgaKVninoitoPtH+SVRWu8DrHM1laaGR7yE+/
 LSOhyiAe4c7Af1RjvsjRQsIf/OHMn2FyO/LwoXpF88StZ5DwFOu78izKWvNYkDtosTwX
 +diL8yBw8rk9Dk6UGFadCGSTd9hTM8ahUxRdxPE0fN7cHcHqrgimrMKhGHhYxIGBFL02
 TDrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsScAOmH3OBDUJiSXU1TY8yFiUHbZCn3xLAcEbojQgewUosWTdI2RdOnMZN9ybKr/7FJ4MFKsRt6V3@nongnu.org
X-Gm-Message-State: AOJu0Yx6kOA+Kl/WE6D6KRvk0cbQKHSP5fGefhZgxEdDiftfU9ppAKl2
 QxrHM/NfJZtLUpzCt+FANjBCgrIFm8QirM2JpnqmfMQzxgujcjoXsACdA4HEihs=
X-Google-Smtp-Source: AGHT+IHdSwCp1o24hvpDHYsmPBHWKP0jROnp9Hy+GAkM/TB0ZhZEoQZp5+raWShC01JXnl31H5Q3/g==
X-Received: by 2002:a05:6a00:3c93:b0:71e:4c2f:5bed with SMTP id
 d2e1a72fcca58-7244a5a1581mr11777297b3a.20.1731557502301; 
 Wed, 13 Nov 2024 20:11:42 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9d3af6sm240759b3a.191.2024.11.13.20.11.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:41 -0800 (PST)
Message-ID: <75446b0b-5b49-437c-bd2d-36f8461fd1d0@linaro.org>
Date: Wed, 13 Nov 2024 20:11:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] linux-user/aarch64/mte: Include missing
 'user/abitypes.h' header
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
 <20241114011310.3615-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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
Cj4gYWJpX2xvbmcgdHlwZSBpcyBkZWZpbmVkIGluICJ1c2VyL2FiaXR5cGVzLmgiLg0KPiBJ
bmNsdWRlIGl0IGluIG9yZGVyIHRvIGF2b2lkIHdoZW4gcmVmYWN0b3Jpbmc6DQo+IA0KPiAg
ICBsaW51eC11c2VyL2FhcmNoNjQvbXRlX3VzZXJfaGVscGVyLmg6MzA6NDI6IGVycm9yOiB1
bmtub3duIHR5cGUgbmFtZSDigJhhYmlfbG9uZ+KAmTsgZGlkIHlvdSBtZWFuIOKAmHVfbG9u
Z+KAmT8NCj4gICAgICAgMzAgfCB2b2lkIGFybV9zZXRfbXRlX3RjZjAoQ1BVQXJjaFN0YXRl
ICplbnYsIGFiaV9sb25nIHZhbHVlKTsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+DQo+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1X2xvbmcNCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4N
Cj4gLS0tDQo+ICAgbGludXgtdXNlci9hYXJjaDY0L210ZV91c2VyX2hlbHBlci5oIHwgMiAr
Kw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1n
aXQgYS9saW51eC11c2VyL2FhcmNoNjQvbXRlX3VzZXJfaGVscGVyLmggYi9saW51eC11c2Vy
L2FhcmNoNjQvbXRlX3VzZXJfaGVscGVyLmgNCj4gaW5kZXggODY4NWU1MTc1YS4uMGM1M2Fi
ZGEyMiAxMDA2NDQNCj4gLS0tIGEvbGludXgtdXNlci9hYXJjaDY0L210ZV91c2VyX2hlbHBl
ci5oDQo+ICsrKyBiL2xpbnV4LXVzZXIvYWFyY2g2NC9tdGVfdXNlcl9oZWxwZXIuaA0KPiBA
QCAtOSw2ICs5LDggQEANCj4gICAjaWZuZGVmIEFBUkNINjRfTVRFX1VTRVJfSEVMUEVSX0gN
Cj4gICAjZGVmaW5lIEFBUkNINjRfTVRFIFVTRVJfSEVMUEVSX0gNCj4gICANCj4gKyNpbmNs
dWRlICJ1c2VyL2FiaXR5cGVzLmgiDQo+ICsNCj4gICAjaWZuZGVmIFBSX01URV9UQ0ZfU0hJ
RlQNCj4gICAjIGRlZmluZSBQUl9NVEVfVENGX1NISUZUICAgICAgIDENCj4gICAjIGRlZmlu
ZSBQUl9NVEVfVENGX05PTkUgICAgICAgICgwVUwgPDwgUFJfTVRFX1RDRl9TSElGVCkNCg0K
UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJv
Lm9yZz4NCg0K

