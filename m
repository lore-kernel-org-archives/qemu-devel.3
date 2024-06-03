Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21627C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 18:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sECu1-0007vG-Jy; Mon, 03 Jun 2024 14:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECu0-0007v7-DP
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:59:28 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sECty-0005Nx-9b
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 14:59:28 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7025c5e6b94so280184b3a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717441164; x=1718045964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MKcP5CY8hec7Bbe5ZyWVmNtplF+78D4RQ0phuPXzMKc=;
 b=p7OJ1w9RzY0GtdZGaF/WcZP3oAcxrVXkuFvwnkWK2HbI5hSz/nCRQ+lXUaZzGftJwV
 X3NNaXMU9rCA57Ek95ZMc2tEMeDslTb80wGZ0xnMouKjWtPMAyVzhNs67iPTTbAd3OAv
 Z30qZDkikhGRwaCJDfDzZs4cdnKLwasuN0efaXWA1tcBwCP5xbcGNWSK7/HwD4kXto29
 nE6v7VRgYwxbWRyvLRE8dpJtrUoEROKDLFeZqIpBGi+n1y1vxNLp93tl6VLoRlurypuN
 00Jh25DrxAfFBCmxs7Qiah2FPq8kjQVn+VWA3vx7ZiWWoLZHc5z6s2uOzsCmYWXyykMj
 08Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717441164; x=1718045964;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MKcP5CY8hec7Bbe5ZyWVmNtplF+78D4RQ0phuPXzMKc=;
 b=O/Dmkud/o07/8iGd+asdQ0Zj+zwKJo0lm3CjJfebfKzT4dHD2dz0bBcFYauvLChUZO
 FAdxtj9zauZmirz2iN4PD95oSpGwa3qfMkSoBFmqnWbZtcGD97S9NmLGguFFfpQ22Ama
 wTnWAoVQL6VNxLvFJOdiXnTXrdmpbPwpQiDLskfHPYQZlec+NbYrH2zFEbwyUAqdMhZL
 U3aaMeXw1LPs2W7A2eXHBBrxms5xWBDcPXllsamkZSQEFSkf3sZ3zJTOEBBNE3vRgIWv
 VIU8iV39/skJc6BH1hkrO8TNzCPWaO3c/bW5NkrBMRUGjaa08kD1n9uOF5czBn7Lu2sP
 JOlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJeVAE6mYfcmHvGAQBWnGU9MfzZpqRDLA71ad1T3KPqH/aOyj87esOxnt+wp/Aya817o3FB/EghzYpK5DlKXd1FRfV1bQ=
X-Gm-Message-State: AOJu0YyafHyrBGYbyz+YHTJC+RV6woKoZeg7vY0fucT62Y4FFtfDMtML
 mGvi5OqTUDNPZl56hStgocasGy58jh/e2dW9TLYsJh80dUgCZrngi4/VqeGM+oM=
X-Google-Smtp-Source: AGHT+IFTZyITMbJrJR2tHrIl1XQ/D0cauFv6BA6phBrko5Yl5ngaGlmYBRM2PwM9tMVMdCVXUya9Ig==
X-Received: by 2002:a05:6a00:23c5:b0:6f4:56d1:2fbe with SMTP id
 d2e1a72fcca58-702477e5dc9mr10796993b3a.11.1717441164470; 
 Mon, 03 Jun 2024 11:59:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-702423c8376sm5800509b3a.44.2024.06.03.11.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 11:59:24 -0700 (PDT)
Message-ID: <5996d7ef-6dc6-4d11-8efd-c3b4fadeff62@linaro.org>
Date: Mon, 3 Jun 2024 11:59:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/27] hw/dma/pl330: Use qemu_hexdump_line to avoid
 sprintf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-11-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
aGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGh3L2RtYS9wbDMzMC5jIHwgMjMg
KysrKysrKystLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9kbWEvcGwz
MzAuYyBiL2h3L2RtYS9wbDMzMC5jDQo+IGluZGV4IDcwYTUwMmQyNDUuLjVmODkyOTVhZjMg
MTAwNjQ0DQo+IC0tLSBhL2h3L2RtYS9wbDMzMC5jDQo+ICsrKyBiL2h3L2RtYS9wbDMzMC5j
DQo+IEBAIC0xNSw2ICsxNSw3IEBADQo+ICAgICovDQo+ICAgDQo+ICAgI2luY2x1ZGUgInFl
bXUvb3NkZXAuaCINCj4gKyNpbmNsdWRlICJxZW11L2N1dGlscy5oIg0KPiAgICNpbmNsdWRl
ICJody9pcnEuaCINCj4gICAjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVzLmgiDQo+ICAg
I2luY2x1ZGUgImh3L3N5c2J1cy5oIg0KPiBAQCAtMzE3LDIyICszMTgsMTQgQEAgdHlwZWRl
ZiBzdHJ1Y3QgUEwzMzBJbnNuRGVzYyB7DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgcGwzMzBf
aGV4ZHVtcCh1aW50OF90ICpidWYsIHNpemVfdCBzaXplKQ0KPiAgIHsNCj4gLSAgICB1bnNp
Z25lZCBpbnQgYiwgaSwgbGVuOw0KPiAtICAgIGNoYXIgdG1wYnVmWzgwXTsNCj4gKyAgICBn
X2F1dG9wdHIoR1N0cmluZykgc3RyID0gZ19zdHJpbmdfc2l6ZWRfbmV3KDY0KTsNCj4gKyAg
ICBzaXplX3QgYiwgbGVuOw0KPiAgIA0KPiAtICAgIGZvciAoYiA9IDA7IGIgPCBzaXplOyBi
ICs9IDE2KSB7DQo+IC0gICAgICAgIGxlbiA9IHNpemUgLSBiOw0KPiAtICAgICAgICBpZiAo
bGVuID4gMTYpIHsNCj4gLSAgICAgICAgICAgIGxlbiA9IDE2Ow0KPiAtICAgICAgICB9DQo+
IC0gICAgICAgIHRtcGJ1ZlswXSA9ICdcMCc7DQo+IC0gICAgICAgIGZvciAoaSA9IDA7IGkg
PCBsZW47IGkrKykgew0KPiAtICAgICAgICAgICAgaWYgKChpICUgNCkgPT0gMCkgew0KPiAt
ICAgICAgICAgICAgICAgIHN0cmNhdCh0bXBidWYsICIgIik7DQo+IC0gICAgICAgICAgICB9
DQo+IC0gICAgICAgICAgICBzcHJpbnRmKHRtcGJ1ZiArIHN0cmxlbih0bXBidWYpLCAiICUw
MngiLCBidWZbYiArIGldKTsNCj4gLSAgICAgICAgfQ0KPiAtICAgICAgICB0cmFjZV9wbDMz
MF9oZXhkdW1wKGIsIHRtcGJ1Zik7DQo+ICsgICAgZm9yIChiID0gMDsgYiA8IHNpemU7IGIg
Kz0gbGVuKSB7DQo+ICsgICAgICAgIGxlbiA9IE1JTigxNiwgc2l6ZSAtIGIpOw0KPiArICAg
ICAgICBnX3N0cmluZ190cnVuY2F0ZShzdHIsIDApOw0KPiArICAgICAgICBxZW11X2hleGR1
bXBfbGluZShzdHIsIGJ1ZiArIGIsIGxlbiwgMSwgNCk7DQo+ICsgICAgICAgIHRyYWNlX3Bs
MzMwX2hleGR1bXAoYiwgc3RyLT5zdHIpOw0KPiAgICAgICB9DQo+ICAgfQ0KPiAgIA0KDQpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPg0K

