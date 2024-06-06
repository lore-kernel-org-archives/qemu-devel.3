Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B29DC27C52
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 21:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFKQa-0005kv-Tp; Thu, 06 Jun 2024 17:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFKQZ-0005kS-Ec
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 17:13:43 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sFKQX-0001DJ-MV
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 17:13:43 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso13886855ad.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 14:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717708419; x=1718313219; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=80uzure4422jDN1fftKZB2VC5uF9FDtdhmFEw1+ltno=;
 b=fPxqL3xQqOInmiWbzlad2boQEOGBvI6OEP+892XBEuMWE+3dZ+T4w+utjK8Evholu9
 Qao6Zr6l5J+hHN+mvxGJ4hBIBORWrZ6DrOJSHNUw6xVLDfHEKrGWKV+qPRCtfGoGhNhW
 1ovgGHxkJsvZtdQ09kw/P6dH5VfTMmSGZ845dUsXTWbGeNh7voEqADSMmkIauckxasz0
 hD0UgeymbKwrhcwVaCTdRYwk+o9numqkd9baKo1yCVAJBUR0K7SqGTtZyvH5WJ1bjlnZ
 ozYY1HGTGEI+YMuOrySc6LbRNM7m117Jv2Xv5Mms5q1gHJZGXAZMJmlzSB0uH9edlD3h
 bDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717708419; x=1718313219;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=80uzure4422jDN1fftKZB2VC5uF9FDtdhmFEw1+ltno=;
 b=XBix4uq6S3XlJKoMU90G0jFivdWDhbcuOdKshshkvgcreJR/g5MEobcINW3PqJsPNm
 KbWD5Lmx9HWd0Bp+W8rpRX3JCEOTsIiHk9dRTO9IC+Yi0OotF3o2BNPjgfB7Ipe4antt
 w23ZnECBM7OIG+A3LkzqsdsOKICP/Bk167R60RT6FjpvqO3/zFP938uFfSMPOs5fUCUU
 iku3mNh6Ib7eLkGhSc1k2DWaooQmo5klvsflsBbM97Gw84NLM4x3NozB7qTSl8TJJemu
 Llm8jFa8nAMNhmdEJ6gS7pItF24drdUovUOr2ntMhUNZAlmQMx/w+WEIHiGMdKIFGdtm
 aWpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvmSpuFtGxm8Ajhf1w9qCs7rxFcA8yJLTRAoGsxtrPw42bS9cEukrClUwNW3XAz2VNPEQqnA/+et5jJziz9Mv7PzsyBq8=
X-Gm-Message-State: AOJu0YzDp9souLR6URdcILhqKAqb89FNc3GJx61co5USjJMzusgr5HQV
 cjM8zc3/oW5/pFKfNccB4Irsm6kMG36bO5cSWVREy8tfNaPCtlnMvbq60tCcmio=
X-Google-Smtp-Source: AGHT+IGtOtAFDl6N8oUbWhGIXYLvX9WyU9Dq7Ht+Qy1CEjE5RG/qJGDGsgWz8qq/KY6Lxbucw1Musw==
X-Received: by 2002:a17:902:ce85:b0:1f6:7dd6:8d95 with SMTP id
 d9443c01a7336-1f6d02f734emr8927185ad.39.1717708419207; 
 Thu, 06 Jun 2024 14:13:39 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76bda8sm19995845ad.81.2024.06.06.14.13.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 14:13:38 -0700 (PDT)
Message-ID: <3921f885-a75d-4506-a0a7-f1dfdf7e892f@linaro.org>
Date: Thu, 6 Jun 2024 14:13:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] plugins: Ensure vCPU index is assigned in init/exit
 hooks
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240606124010.2460-1-philmd@linaro.org>
 <20240606124010.2460-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240606124010.2460-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gNi82LzI0IDA1OjQwLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2lu
Y2UgdkNQVXMgYXJlIGhhc2hlZCBieSB0aGVpciBpbmRleCwgdGhpcyBpbmRleCBjYW4ndA0K
PiBiZSB1bmluaXRpYWxpemVkIChVTkFTU0lHTkVEX0NQVV9JTkRFWCkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIHBsdWdpbnMvY29yZS5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9wbHVnaW5zL2NvcmUuYyBi
L3BsdWdpbnMvY29yZS5jDQo+IGluZGV4IGJhZGVkZTI4Y2YuLmQzMzliM2RiNGQgMTAwNjQ0
DQo+IC0tLSBhL3BsdWdpbnMvY29yZS5jDQo+ICsrKyBiL3BsdWdpbnMvY29yZS5jDQo+IEBA
IC0yNDUsNiArMjQ1LDcgQEAgdm9pZCBxZW11X3BsdWdpbl92Y3B1X2luaXRfaG9vayhDUFVT
dGF0ZSAqY3B1KQ0KPiAgIHsNCj4gICAgICAgYm9vbCBzdWNjZXNzOw0KPiAgIA0KPiArICAg
IGFzc2VydChjcHUtPmNwdV9pbmRleCAhPSBVTkFTU0lHTkVEX0NQVV9JTkRFWCk7DQo+ICAg
ICAgIHFlbXVfcmVjX211dGV4X2xvY2soJnBsdWdpbi5sb2NrKTsNCj4gICAgICAgcGx1Z2lu
Lm51bV92Y3B1cyA9IE1BWChwbHVnaW4ubnVtX3ZjcHVzLCBjcHUtPmNwdV9pbmRleCArIDEp
Ow0KPiAgICAgICBwbHVnaW5fY3B1X3VwZGF0ZV9fbG9ja2VkKCZjcHUtPmNwdV9pbmRleCwg
TlVMTCwgTlVMTCk7DQo+IEBAIC0yNjMsNiArMjY0LDcgQEAgdm9pZCBxZW11X3BsdWdpbl92
Y3B1X2V4aXRfaG9vayhDUFVTdGF0ZSAqY3B1KQ0KPiAgIA0KPiAgICAgICBwbHVnaW5fdmNw
dV9jYl9fc2ltcGxlKGNwdSwgUUVNVV9QTFVHSU5fRVZfVkNQVV9FWElUKTsNCj4gICANCj4g
KyAgICBhc3NlcnQoY3B1LT5jcHVfaW5kZXggIT0gVU5BU1NJR05FRF9DUFVfSU5ERVgpOw0K
PiAgICAgICBxZW11X3JlY19tdXRleF9sb2NrKCZwbHVnaW4ubG9jayk7DQo+ICAgICAgIHN1
Y2Nlc3MgPSBnX2hhc2hfdGFibGVfcmVtb3ZlKHBsdWdpbi5jcHVfaHQsICZjcHUtPmNwdV9p
bmRleCk7DQo+ICAgICAgIGdfYXNzZXJ0KHN1Y2Nlc3MpOw0KDQpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

