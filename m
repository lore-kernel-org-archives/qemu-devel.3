Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E47C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 18:57:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECru-0006ik-B1; Mon, 03 Jun 2024 14:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECrs-0006hg-RZ
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:57:16 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECrr-0005Ac-7e
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:57:16 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6818eea9c3aso2700680a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 11:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717441033; x=1718045833; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v7X3aljSKsKWUbDQb9mGHUMYJeaKWpFH0yskXzXZQEo=;
 b=K18RZg+sHkVVO9mffSw3zqnt4xawFx9+VMn25iWLDDUQ619EmBYNR6itvRm4JiaTKf
 4ScnVOhaJz4dEYPFQ+KDi+kgc0RA0k/OhFVq1RrH8oGwKz9E5q4+JsEzqXVkaZNmNpGQ
 /PGrrySsn65EhGr65vzvPg5j2IDS8LxqBPGjM0dhogTeXQlmI3tzglG06CVSikKT+4dV
 Nyn2imPEGvS19ZALBPs89BC3FoDmaS3DWXLShHbVwdP7YLBALvmZHllQucEM/z0LhGYP
 mr7iAkuEg81XNK0qkb4ZyT3y/CNN9aJNbWvgmKxqEm4IcUAjuusnC5m0mTuQI2pkYPM3
 lsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717441033; x=1718045833;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7X3aljSKsKWUbDQb9mGHUMYJeaKWpFH0yskXzXZQEo=;
 b=hEEsnKWsZIqQD2Nrjn33mA6COYLJ8//BdFxZ0IP6sZuGMp9zAyPC4FZyh/qkGy77Wm
 1AMgInRQ/7SU6a0i/K6YgIc+HPB1g25xqKzKQ1GP6G9UgeRPGwgaYeEfVNPcFka7sXqo
 DluKMMGS0dYO2dGYukdBEp09Q4sffKukKAvHpqL+jGgF+76byENEdn7EVCIO+D/gZ0/+
 yzvTAuMxFYLr+B2yyU3Z6HjmklcTihQE+8OqmgJgY15vjZSHE8c7aiHVtnQPWGJxJCJo
 NfZugqWJ5O9q/tnSrn2TBMDzZ/KFZnubT5/V91Y++OXQTHfeaBd01qSNw0YZDsh2fV4+
 cEIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/unXqGJUa8YYaKgFQoc55cIJiW/F703HZqWEnMMqQhmgd7+QAdrlTGqmag39sYdWaLBsVtgcaqRH5eRnbM4NCgUdRzKA=
X-Gm-Message-State: AOJu0YxhLVc50zUbTodHlnbb7WxKxZdhyhL53BDr2YPf4MRc6KP5H97q
 5ze3Naxu6o6NP2jbvY3k5LPiuB0atYhPRsAvesV7Z37JwfcTsDzL5AESN+cEd5o=
X-Google-Smtp-Source: AGHT+IEInLhXMwmijNnZFxxZLNjbxt45h0aV279HYigZOR+KYP7gV/ilfJmMrfwbiHFTeA2avkzwGA==
X-Received: by 2002:a05:6a20:9147:b0:1af:f92c:de8e with SMTP id
 adf61e73a8af0-1b26f30e502mr10110740637.52.1717441033553; 
 Mon, 03 Jun 2024 11:57:13 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1a775f8cbsm8399543a91.11.2024.06.03.11.57.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 11:57:13 -0700 (PDT)
Message-ID: <1369a16b-d764-4d2d-842c-64be3f494705@linaro.org>
Date: Mon, 3 Jun 2024 11:57:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/27] hw/ide/atapi: Use qemu_hexdump_line to avoid
 sprintf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

DQoNCk9uIDQvMTIvMjQgMDA6MzMsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBGcm9t
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IA0KPiBz
cHJpbnRmKCkgaXMgZGVwcmVjYXRlZCBvbiBEYXJ3aW4gc2luY2UgbWFjT1MgMTMuMCAvIFhD
b2RlIDE0LjEuDQo+IFVzaW5nIHFlbXVfaGV4ZHVtcF9saW5lIGJvdGggZml4ZXMgdGhlIGRl
cHJlY2F0aW9uIHdhcm5pbmcgYW5kDQo+IHNpbXBsaWZpZXMgdGhlIGNvZGUgYmFzZS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGlu
YXJvLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQu
aGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L2lkZS9hdGFwaS5jIHwgMTIg
KysrKy0tLS0tLS0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgOCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9pZGUvYXRhcGkuYyBiL2h3L2lk
ZS9hdGFwaS5jDQo+IGluZGV4IDczZWMzNzMxODQuLmZjYjZjY2ExNTcgMTAwNjQ0DQo+IC0t
LSBhL2h3L2lkZS9hdGFwaS5jDQo+ICsrKyBiL2h3L2lkZS9hdGFwaS5jDQo+IEBAIC0yNCw2
ICsyNCw3IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCIN
Cj4gKyNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiAgICNpbmNsdWRlICJody9zY3NpL3Nj
c2kuaCINCj4gICAjaW5jbHVkZSAic3lzZW11L2Jsb2NrLWJhY2tlbmQuaCINCj4gICAjaW5j
bHVkZSAic2NzaS9jb25zdGFudHMuaCINCj4gQEAgLTEzMDksMTQgKzEzMTAsOSBAQCB2b2lk
IGlkZV9hdGFwaV9jbWQoSURFU3RhdGUgKnMpDQo+ICAgICAgIHRyYWNlX2lkZV9hdGFwaV9j
bWQocywgcy0+aW9fYnVmZmVyWzBdKTsNCj4gICANCj4gICAgICAgaWYgKHRyYWNlX2V2ZW50
X2dldF9zdGF0ZV9iYWNrZW5kcyhUUkFDRV9JREVfQVRBUElfQ01EX1BBQ0tFVCkpIHsNCj4g
LSAgICAgICAgLyogRWFjaCBwcmV0dHktcHJpbnRlZCBieXRlIG5lZWRzIHR3byBieXRlcyBh
bmQgYSBzcGFjZTsgKi8NCj4gLSAgICAgICAgY2hhciAqcHBhY2tldCA9IGdfbWFsbG9jKEFU
QVBJX1BBQ0tFVF9TSVpFICogMyArIDEpOw0KPiAtICAgICAgICBpbnQgaTsNCj4gLSAgICAg
ICAgZm9yIChpID0gMDsgaSA8IEFUQVBJX1BBQ0tFVF9TSVpFOyBpKyspIHsNCj4gLSAgICAg
ICAgICAgIHNwcmludGYocHBhY2tldCArIChpICogMyksICIlMDJ4ICIsIGJ1ZltpXSk7DQo+
IC0gICAgICAgIH0NCj4gLSAgICAgICAgdHJhY2VfaWRlX2F0YXBpX2NtZF9wYWNrZXQocywg
cy0+bGN5bCB8IChzLT5oY3lsIDw8IDgpLCBwcGFja2V0KTsNCj4gLSAgICAgICAgZ19mcmVl
KHBwYWNrZXQpOw0KPiArICAgICAgICBnX2F1dG9wdHIoR1N0cmluZykgc3RyID0NCj4gKyAg
ICAgICAgICAgIHFlbXVfaGV4ZHVtcF9saW5lKE5VTEwsIGJ1ZiwgQVRBUElfUEFDS0VUX1NJ
WkUsIDEsIDApOw0KPiArICAgICAgICB0cmFjZV9pZGVfYXRhcGlfY21kX3BhY2tldChzLCBz
LT5sY3lsIHwgKHMtPmhjeWwgPDwgOCksIHN0ci0+c3RyKTsNCj4gICAgICAgfQ0KPiAgIA0K
PiAgICAgICAvKg0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBsaW5hcm8ub3JnPg0K

