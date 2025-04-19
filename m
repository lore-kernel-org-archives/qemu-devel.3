Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BEFC369AB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 01:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5wZL-0007CV-5s; Fri, 18 Apr 2025 21:00:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wYy-00070y-0Y
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:00:12 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5wYu-0001TP-W4
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 21:00:07 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so2020220a12.2
 for <qemu-devel@nongnu.org>; Fri, 18 Apr 2025 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745024403; x=1745629203; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/6an4aGOR8TG4W8HRS6mUNkOPHyMhM33Ny/y8nkKSxY=;
 b=lV6wlIBmRw9JNYu4GiwX/RwyLlvxtj7iNGgTMgNqF5N6nm4gV5HlRDEUnEUnMMTTcw
 KFXjPaDNb96AM8yW1s9Mqaa+CtXvaNpogdo5Gs4B4zxaYS0Jy2QO4FfSZVjcYgchIvqm
 zQLolzWqxABVOmhv2A7iWSna0G0YowgLvlIrO2ksFCYmvU4GRmrK+gxFHaug9U5bCIhr
 yS2YrGbDn/8lrahctFZkkTKO7xSz0K3Mrgi//LET1Ryee7p976fBVZRhSqFUq/O/dfjk
 Jsg+qjTgDi4dJ940BGoJ2l8ubXvG96Ss9pb1pWF326rR5SypZ0en5TetWPlbNz28QYM2
 qrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745024403; x=1745629203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/6an4aGOR8TG4W8HRS6mUNkOPHyMhM33Ny/y8nkKSxY=;
 b=gsPSt6VneL09DDJ+zzo4f7EQDcqi+mXZNP4Wtd7ZGHYgnov22XF4Vm9RZyJ/tc0it+
 uAYUJz8Kc+az4gJjh/8pWuEcv4E8MAcDcVea58Re8FPYILeVjpiOE3tsCGQXGukG0cNW
 SFEtKw34FAY9tg8VU8guwe3Dxfwkjfp+9b5hjZsek693bmCmpP3nkJwlRW10b67/7+u/
 i0SwSJO7q7JqrAm0mRT/XA2vHi9I1JJc4Nzw4i3AWpn9WS1eFoFQBa5tRVz1k7ePMDct
 n6LutpAG9YeJLpeyQ4BHfe2EmV20dG6vOSvgBNR7i3Vr2ocMYX0s6MexIuYsGlrAN2xA
 v9Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeC9nKiiNK7BpDlqAjlDfsK6zKFy61le5BTBXniUjv1JAMfXoBuOzaYFpHwCJLS1ywYqydfZI58nNg@nongnu.org
X-Gm-Message-State: AOJu0Yy+wWxTNi3Uquxq572472B2uJx1LI34Y1Wq8UAYT0Qx6d3yr4nP
 0YwfuPsP9DOcHE92ErunRQLGTVE3VvdYyyy1jg/wIpSocgCf+Q+PHif+bztuDks=
X-Gm-Gg: ASbGnctURE4TwUjO6meb4qhdsbU7dXktIHr4IrPOratdwMlR/sTiu/UKZGRu+1jf+O8
 5QE9GRvO9PKO6UC/cbUPietJYrJA396Yn2j/vZNhDTp1xssRqgpppXYjXl3eZ+eLf0HcGQM2P6F
 eJB95/23cXPBG8kL9nqv2CY3E4qVeApjF68uN1ji3OQhmwB7K/vksLNdPw+63X9ByMz/hOabQXY
 v6HFJjzLM6akAEA32b0WxMH6FaLr4Uh96iWkibrWeIjQO47Q8dwFvMoLZ9nwFSJLuFHkdH1mWei
 L9sCVHX6Ng8eeI6C/EEN3jlFe00Z33zBCh8VLgnooP803qDR8q4P4pdNATxNEnki
X-Google-Smtp-Source: AGHT+IGj21f+DiTaa5dzZ0zFo7CTjc7/ywYuFugWFy99ZQWhXnTGPQWg333sc28e/E4r74EAiSUZIg==
X-Received: by 2002:a17:90b:1c0a:b0:2fe:994d:613b with SMTP id
 98e67ed59e1d1-3087bbcb45dmr6411549a91.35.1745024402693; 
 Fri, 18 Apr 2025 18:00:02 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df25d80sm1906051a91.25.2025.04.18.18.00.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Apr 2025 18:00:02 -0700 (PDT)
Message-ID: <715e5231-4ef4-47e0-bd4f-467028401eb4@linaro.org>
Date: Fri, 18 Apr 2025 18:00:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/14] config/target: Implement per-binary
 TargetInfo structure (ARM, AARCH64)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418172908.25147-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

T24gNC8xOC8yNSAxMDoyOSwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElt
cGxlbWVudCB0aGUgVGFyZ2V0SW5mbyBzdHJ1Y3R1cmUgZm9yIHFlbXUtc3lzdGVtLWFybQ0K
PiBhbmQgcWVtdS1zeXN0ZW0tYWFyY2g2NCBiaW5hcmllcy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0t
DQo+ICAgY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgIGNvbmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jICAgICB8
IDIyICsrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ0IGlu
c2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29uZmlncy90YXJnZXRzL2Fh
cmNoNjQtc29mdG1tdS5jDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGNvbmZpZ3MvdGFyZ2V0
cy9hcm0tc29mdG1tdS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy90YXJnZXRzL2Fh
cmNoNjQtc29mdG1tdS5jIGIvY29uZmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi4wM2Y0OGJhZDMy
Ng0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmZpZ3MvdGFyZ2V0cy9hYXJjaDY0LXNv
ZnRtbXUuYw0KPiBAQCAtMCwwICsxLDIyIEBADQo+ICsvKg0KPiArICogUUVNVSBiaW5hcnkv
dGFyZ2V0IEFQSSAocWVtdS1zeXN0ZW0tYWFyY2g2NCkNCj4gKyAqDQo+ICsgKiAgQ29weXJp
Z2h0IChjKSBMaW5hcm8NCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpbmNsdWRlICJxZW11L29zZGVw
LmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1pbXBsLmgiDQo+ICsjaW5jbHVk
ZSAiaHcvYXJtL21hY2hpbmVzLXFvbS5oIg0KPiArI2luY2x1ZGUgInRhcmdldC9hcm0vY3B1
LXFvbS5oIg0KPiArDQo+ICtzdGF0aWMgY29uc3QgVGFyZ2V0SW5mbyB0YXJnZXRfaW5mb19h
YXJjaDY0X3N5c3RlbSA9IHsNCj4gKyAgICAudGFyZ2V0X25hbWUgPSAiYWFyY2g2NCIsDQo+
ICsgICAgLm1hY2hpbmVfdHlwZW5hbWUgPSBUWVBFX1RBUkdFVF9BQVJDSDY0X01BQ0hJTkUs
DQo+ICt9Ow0KPiArDQo+ICtjb25zdCBUYXJnZXRJbmZvICp0YXJnZXRfaW5mbyh2b2lkKQ0K
PiArew0KPiArICAgIHJldHVybiAmdGFyZ2V0X2luZm9fYWFyY2g2NF9zeXN0ZW07DQo+ICt9
DQo+IGRpZmYgLS1naXQgYS9jb25maWdzL3RhcmdldHMvYXJtLXNvZnRtbXUuYyBiL2NvbmZp
Z3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwLi4wNzI4NWY3ZjNiMw0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBi
L2NvbmZpZ3MvdGFyZ2V0cy9hcm0tc29mdG1tdS5jDQo+IEBAIC0wLDAgKzEsMjIgQEANCj4g
Ky8qDQo+ICsgKiBRRU1VIGJpbmFyeS90YXJnZXQgQVBJIChxZW11LXN5c3RlbS1hcm0pDQo+
ICsgKg0KPiArICogIENvcHlyaWdodCAoYykgTGluYXJvDQo+ICsgKg0KPiArICogU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4gKyAqLw0KPiArDQo+ICsj
aW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8t
aW1wbC5oIg0KPiArI2luY2x1ZGUgImh3L2FybS9tYWNoaW5lcy1xb20uaCINCj4gKyNpbmNs
dWRlICJ0YXJnZXQvYXJtL2NwdS1xb20uaCINCj4gKw0KPiArc3RhdGljIGNvbnN0IFRhcmdl
dEluZm8gdGFyZ2V0X2luZm9fYXJtX3N5c3RlbSA9IHsNCj4gKyAgICAudGFyZ2V0X25hbWUg
PSAiYXJtIiwNCj4gKyAgICAubWFjaGluZV90eXBlbmFtZSA9IFRZUEVfVEFSR0VUX0FSTV9N
QUNISU5FLA0KPiArfTsNCj4gKw0KPiArY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8o
dm9pZCkNCj4gK3sNCj4gKyAgICByZXR1cm4gJnRhcmdldF9pbmZvX2FybV9zeXN0ZW07DQo+
ICt9DQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVy
QGxpbmFyby5vcmc+DQoNCg==

