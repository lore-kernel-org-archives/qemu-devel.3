Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D1BC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmoPN-0006fS-8f; Wed, 20 Mar 2024 01:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmoPG-0006eV-H6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:22:32 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmoPE-0005XX-Qn
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:22:30 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-513da1c1f26so7425167e87.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 22:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912146; x=1711516946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FMfVGWUdCdf6bpzdODMVqE2aq/LqTLtctv7DjEvE/SU=;
 b=WLHo2b9p2IF2CbL2rQKomx/hbzuGU9SpJGwq2p5oAfWpYoTWHObeonri61owNtfEb3
 z6uwJlTBvgilOW7mAC1t9PBvY+fRQkrKtLIDkeBe49GaX7vovyk8nzyeUpSrXaaobdaf
 a7wUEIBQmYOSnBKbTpOmS4dsHeH8PjGkA9zk1fC6ECrEjvcATVnRC+qKLxD6syOZDjiM
 rjKubr3fwbKiCKt7IIXfJaUuJWd3ijc3JZ/svr6cFywn0GtWHLlt0L5o6ETkZs2QDXkN
 sf0IktNnmVj2v1pH6gl2bSJjO2g5u9CW+f5y9gilDRDqlJlkyH0rl8Ve399sW7JQRp+7
 0o7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912146; x=1711516946;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FMfVGWUdCdf6bpzdODMVqE2aq/LqTLtctv7DjEvE/SU=;
 b=jUA1mgyndHaHSlqlLQfG1IRQOGwv4xDo/7YdbssW5IRPzR7t3AnMcx9wKfcLPGqVGZ
 /6Oj3ZiLMqn2/EcVAbbcMpEAQUkdDHOa6daJBMhwkaSj1H6sru9DEqkermYo+b8EjFM5
 TF5nvwWWYA/XU7pQzuYgi3o8MPecDzdtkrzX7NS+i0VRa08vvl1ZOKl1czCRUJJaPzfK
 FEnpahYwtBTr3enqJwMVZ/6LT8r3zChtHwb1Jh+9AYNI23baJl6IUVVyEMzRBX5yDy/g
 TWeX0dKNlQQC1WPt2O9BAP74jf2fdw5lNXd7HWOXNHQNvanbmsbkVyfZ9HmbBa13eKQZ
 lFwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgT0d312c9B1K4Oorx8DJxEJGQAjarSS48L57OOucA3np08dvpm1LaMl3GGTyBmIhIU1vN7KG1kAWfcZ2XeX5KofCOf9g=
X-Gm-Message-State: AOJu0YyInaPsbYfTyCiSuIpAvmN6rkYMymh37qZKKEoAGhG0ABDOdvmU
 xdnCnnaGgNPG+HQS1Vwpun+JrbjH/z6HMIoONcL/9Xdfmkld6uicAA0YTK6KPU8=
X-Google-Smtp-Source: AGHT+IE59K9ySe4KcM1ong3PzHFhsnoHsGcNyj944m3Zu41qNq75qwcg3JTmxZe2W9HnosTyKhv+iw==
X-Received: by 2002:a19:4353:0:b0:513:cc91:9ed7 with SMTP id
 m19-20020a194353000000b00513cc919ed7mr10629639lfj.11.1710912146060; 
 Tue, 19 Mar 2024 22:22:26 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 w16-20020adfcd10000000b0033e5c54d0d9sm13895613wrm.38.2024.03.19.22.22.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:22:25 -0700 (PDT)
Message-ID: <1352d739-418c-44fe-bd20-deae875bca4a@linaro.org>
Date: Wed, 20 Mar 2024 09:22:20 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/22] plugins: Create TCGHelperInfo for all out-of-line
 callbacks
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-7-richard.henderson@linaro.org>
 <9eec79a8-6ebd-4d41-af8f-459c1a83499f@linaro.org>
 <baa46f6d-52df-41fa-92f5-2767884746d1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <baa46f6d-52df-41fa-92f5-2767884746d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x129.google.com
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

T24gMy8xOS8yNCAyMzo1MSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTkv
MjQgMDM6MTIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE2LzI0IDA1OjU3
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBUQ0dIZWxwZXJJbmZvIGluY2x1ZGVz
IHRoZSBBQkkgZm9yIGV2ZXJ5IGZ1bmN0aW9uIGNhbGwuDQo+Pj4NCj4+PiBTaWduZWQtb2Zm
LWJ5OiBSaWNoYXJkIEhlbmRlcnNvbiA8cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZz4N
Cj4+PiAtLS0NCj4+PiAgwqAgaW5jbHVkZS9xZW11L3BsdWdpbi5oIHzCoCAxICsNCj4+PiAg
wqAgcGx1Z2lucy9jb3JlLmPCoMKgwqDCoMKgwqDCoCB8IDUxICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4+PiAgwqAgMiBmaWxlcyBjaGFuZ2VkLCA0
NiBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvcWVtdS9wbHVnaW4uaCBiL2luY2x1ZGUvcWVtdS9wbHVnaW4uaA0KPj4+IGlu
ZGV4IDE0MzI2MmRjYTguLjc5M2M0NGYxZjIgMTAwNjQ0DQo+Pj4gLS0tIGEvaW5jbHVkZS9x
ZW11L3BsdWdpbi5oDQo+Pj4gKysrIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4gQEAg
LTkyLDYgKzkyLDcgQEAgc3RydWN0IHFlbXVfcGx1Z2luX2R5bl9jYiB7DQo+Pj4gIMKgwqDC
oMKgwqAgdW5pb24gew0KPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHsNCj4+PiAg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5pb24gcWVtdV9wbHVnaW5fY2Jfc2lnIGY7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgVENHSGVscGVySW5mbyAqaW5mbzsNCj4+
PiAgwqDCoMKgwqDCoMKgwqDCoMKgIH0gcmVndWxhcjsNCj4+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgIHN0cnVjdCB7DQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHFlbXVfcGx1
Z2luX3U2NCBlbnRyeTsNCj4+PiBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9jb3JlLmMgYi9wbHVn
aW5zL2NvcmUuYw0KPj4+IGluZGV4IDgzN2MzNzM2OTAuLmIwYTJlODA4NzQgMTAwNjQ0DQo+
Pj4gLS0tIGEvcGx1Z2lucy9jb3JlLmMNCj4+PiArKysgYi9wbHVnaW5zL2NvcmUuYw0KPj4+
IEBAIC0zMzgsMTIgKzMzOCwyNiBAQCB2b2lkIHBsdWdpbl9yZWdpc3Rlcl9keW5fY2JfX3Vk
YXRhKEdBcnJheSAqKmFyciwNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudW0gcWVtdV9w
bHVnaW5fY2JfZmxhZ3MgZmxhZ3MsDQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lkICp1
ZGF0YSkNCj4+PiAgwqAgew0KPj4+IC3CoMKgwqAgc3RydWN0IHFlbXVfcGx1Z2luX2R5bl9j
YiAqZHluX2NiID0gcGx1Z2luX2dldF9keW5fY2IoYXJyKTsNCj4+PiArwqDCoMKgIHN0YXRp
YyBUQ0dIZWxwZXJJbmZvIGluZm9bM10gPSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgIFtRRU1V
X1BMVUdJTl9DQl9OT19SRUdTXS5mbGFncyA9IFRDR19DQUxMX05PX1JXRyB8IFRDR19DQUxM
X1BMVUdJTiwNCj4+PiArwqDCoMKgwqDCoMKgwqAgW1FFTVVfUExVR0lOX0NCX1JfUkVHU10u
ZmxhZ3MgPSBUQ0dfQ0FMTF9OT19XRyB8IFRDR19DQUxMX1BMVUdJTiwNCj4+PiArwqDCoMKg
wqDCoMKgwqAgW1FFTVVfUExVR0lOX0NCX1JXX1JFR1NdLmZsYWdzID0gVENHX0NBTExfUExV
R0lOLA0KPj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
TWF0Y2ggcWVtdV9wbHVnaW5fdmNwdV91ZGF0YV9jYl90Og0KPj4+ICvCoMKgwqDCoMKgwqDC
oMKgICrCoMKgIHZvaWQgKCopKHVpbnQzMl90LCB2b2lkICopDQo+Pj4gKw0KPj4NCj4+IEFu
eSBjaGFuY2Ugd2UgY291bGQgaGF2ZSBhIHN0YXRpYyBhc3NlcnQgZW5zdXJpbmcgdGhpcz8N
Cj4+IEkga25vdyBpdCdzIHBvc3NpYmxlIGluIEMxMSwgYnV0IEkgZG9uJ3Qga25vdyBpZiBn
bGliIG9mZmVycyBzb21ldGhpbmcgZm9yIHRoaXMuDQo+IA0KPiBJIGRvbid0IHNlZSBob3cu
ICBXaGlsZSB5b3UgY291bGQgYXNrIHF1ZXN0aW9ucyBhYm91dCB0aGUgcG9pbnRlciB0eXBl
DQo+IHFlbXVfcGx1Z2luX3ZjcHVfdWRhdGFfY2JfdCwgeW91IGNhbid0IGFzayBxdWVzdGlv
bnMgYWJvdXQgdGhlIGZ1bmN0aW9uIGFyZ3VtZW50cy4NCj4gDQoNCkkgd2FzIHRoaW5raW5n
IGFib3V0IHNvbWV0aGluZyBzaW1pbGFyIHRvOg0Kc3RhdGljX2Fzc2VydCh0eXBlb2YocWVt
dV9wbHVnaW5fdmNwdV91ZGF0YV9jYl90KSA9PSB2b2lkICgqKSh1aW50MzJfdCwgDQp2b2lk
ICopKTsNCg0KQnV0IEkgZG9uJ3QgdGhpbmsgaXQncyBwb3NzaWJsZSB0byBleHByZXNzIHRo
aXMgaW4gQyBzdGFuZGFyZCBiZWZvcmUgMTEuDQoNCj4gDQo+IHJ+DQo=

