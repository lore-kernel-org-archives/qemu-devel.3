Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E98C25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCoGh-0007D4-14; Thu, 30 May 2024 18:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoGf-0007CP-4G
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:29:05 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoGc-0000bZ-GT
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:29:03 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-702442afa7dso195492b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717108141; x=1717712941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SujEfHIJ+IAcJHimyI8x8Y47L6eCMAuBqrwtxm9g4t4=;
 b=PC2NQ0WKGRWS5qZYYQNwLUl+UsBIQarAPcZSCnx55DaL2+7IdAyIt9ai4+RNsgfzTg
 4HAJ/iqShFYPQwE5RsmT35Jv71U9KP1byZm86DNdUsFUuU1gL3mfKP0cQPKZmDQhfXS+
 a5nMcqt419g87OgOAHQ4CHdzhsQj+VWaZEherJWNy4BlO9oZBqHGBUB0nNbN1bc9fIik
 x2Sn3a9jfFNKHGbB9M40ELQfGISmlhH34Ndf2CKxbZbfgU3styzYGdynduA0YQkiJLcl
 bkTLjgxA14u/NiqS9MXnE7sStoiLeL8FOEkxvgHhdrLgprWQYvk1SJiZme/esyK/jPoL
 CIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717108141; x=1717712941;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SujEfHIJ+IAcJHimyI8x8Y47L6eCMAuBqrwtxm9g4t4=;
 b=DrovzHsasNhlFg0YXC67bj9wolal0gY5hXJMZgodzUqZ++689C6hqMbW1EPb8VR3VQ
 dsMRAlX5e8AVkuZPoIyToQuUsFjDNu/ncHnVQ3Zx+7GVt1hDzqlIqsSYAIj9dZvWh1qe
 ET7spsA7w0WjEevFsX+mBFPFZQpSLBo5qE7zk+EV58xPptO1aG6eIbwGOIEaGBrGcxSZ
 48VRBESsZ4uC6dJ7h7d75eCXyuqadYYhZjjs971ZO67JMCmpxAdq7/pdhjIJtca6csTt
 z8DrRo2JGrO46M3ozswEW2lAqitAfz/FgR1Kk+lKs7OjKH9HHJVw4NwO0XF5u8WHO2g1
 P/IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu9poquQUBIBfo94DjMAqZg9frcQjLC7HwroFTaRigdSyzT+mNZuUcy8T/ZQNLNZ7aDgoN+sg4kkN2/aFPuL1dew0W96s=
X-Gm-Message-State: AOJu0Yzzrn+gphOn5y8QvD5yb2x8ew98DnVXDBDl9pWFIdm0I4NlAJwR
 tBBb/fqWUpocM11GBpjXCU7aCNm3l/MkciT1p6BTk3IrHiBOYyVEURsx8AxQehknTkEGMytCAqw
 WlCE=
X-Google-Smtp-Source: AGHT+IHiG3IoqS6XYzHziaHGZ7QHZB2ubAA5Lfx9rBCHBDlqcK91cXZTSgG4RTcZwGikKa649x4wbw==
X-Received: by 2002:a05:6a00:18a7:b0:6f3:f062:c09b with SMTP id
 d2e1a72fcca58-702477bbc5cmr164851b3a.6.1717108140909; 
 Thu, 30 May 2024 15:29:00 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b09c71sm233929b3a.181.2024.05.30.15.28.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 15:29:00 -0700 (PDT)
Message-ID: <b1f82476-1cbf-4e25-84b4-66abfb406b2c@linaro.org>
Date: Thu, 30 May 2024 15:28:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/core: expand on the alignment of CPUState
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-2-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240530194250.1801701-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gNS8zMC8yNCAxMjo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBNYWtlIHRoZSByZWxh
dGlvbnNoaXAgYmV0d2VlbiBDUFVTdGF0ZSwgQXJjaENQVSBhbmQgY3B1X2VudiBhIGJpdA0K
PiBjbGVhcmVyIGluIHRoZSBrZG9jIGNvbW1lbnRzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
QWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBpbmNs
dWRlL2h3L2NvcmUvY3B1LmggfCAxNCArKysrKysrKysrLS0tLQ0KPiAgIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvaHcvY29yZS9jcHUuaCBiL2luY2x1ZGUvaHcvY29yZS9jcHUuaA0KPiBp
bmRleCBiYjM5OGU4MjM3Li4zNWQzNDUzNzFiIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2h3
L2NvcmUvY3B1LmgNCj4gKysrIGIvaW5jbHVkZS9ody9jb3JlL2NwdS5oDQo+IEBAIC0zOTEs
NyArMzkxLDggQEAgc3RydWN0IHFlbXVfd29ya19pdGVtOw0KPiAgICNkZWZpbmUgQ1BVX1VO
U0VUX05VTUFfTk9ERV9JRCAtMQ0KPiAgIA0KPiAgIC8qKg0KPiAtICogQ1BVU3RhdGU6DQo+
ICsgKiBzdHJ1Y3QgQ1BVU3RhdGUgLSBjb21tb24gc3RhdGUgb2Ygb25lIENQVSBjb3JlIG9y
IHRocmVhZC4NCj4gKyAqDQo+ICAgICogQGNwdV9pbmRleDogQ1BVIGluZGV4IChpbmZvcm1h
dGl2ZSkuDQo+ICAgICogQGNsdXN0ZXJfaW5kZXg6IElkZW50aWZpZXMgd2hpY2ggY2x1c3Rl
ciB0aGlzIENQVSBpcyBpbi4NCj4gICAgKiAgIEZvciBib2FyZHMgd2hpY2ggZG9uJ3QgZGVm
aW5lIGNsdXN0ZXJzIG9yIGZvciAibG9vc2UiIENQVXMgbm90IGFzc2lnbmVkDQo+IEBAIC00
MzksMTAgKzQ0MCwxNSBAQCBzdHJ1Y3QgcWVtdV93b3JrX2l0ZW07DQo+ICAgICogQGt2bV9m
ZXRjaF9pbmRleDogS2VlcHMgdGhlIGluZGV4IHRoYXQgd2UgbGFzdCBmZXRjaGVkIGZyb20g
dGhlIHBlci12Q1BVDQo+ICAgICogICAgZGlydHkgcmluZyBzdHJ1Y3R1cmUuDQo+ICAgICoN
Cj4gLSAqIFN0YXRlIG9mIG9uZSBDUFUgY29yZSBvciB0aHJlYWQuDQo+ICsgKiBAbmVnX2Fs
aWduOiBUaGUgQ1BVU3RhdGUgaXMgdGhlIGNvbW1vbiBwYXJ0IG9mIGEgY29uY3JldGUgQXJj
aENQVQ0KPiArICogd2hpY2ggaXMgYWxsb2NhdGVkIHdoZW4gYW4gaW5kaXZpZHVhbCBDUFUg
aW5zdGFuY2UgaXMgY3JlYXRlZC4gQXMNCj4gKyAqIHN1Y2ggY2FyZSBpcyB0YWtlbiBpcyBl
bnN1cmUgdGhlcmUgaXMgbm8gZ2FwIGJldHdlZW4gYmV0d2Vlbg0KPiArICogQ1BVU3RhdGUg
YW5kIENQVUFyY2hTdGF0ZSB3aXRoaW4gQXJjaENQVS4NCj4gICAgKg0KPiAtICogQWxpZ24s
IGluIG9yZGVyIHRvIG1hdGNoIHBvc3NpYmxlIGFsaWdubWVudCByZXF1aXJlZCBieSBDUFVB
cmNoU3RhdGUsDQo+IC0gKiBhbmQgZWxpbWluYXRlIGEgaG9sZSBiZXR3ZWVuIENQVVN0YXRl
IGFuZCBDUFVBcmNoU3RhdGUgd2l0aGluIEFyY2hDUFUuDQo+ICsgKiBAbmVnOiBUaGUgYXJj
aGl0ZWN0dXJhbCByZWdpc3RlciBzdGF0ZSAoImNwdV9lbnYiKSBpbW1lZGlhdGVseSBmb2xs
b3dzIENQVVN0YXRlDQo+ICsgKiBpbiBBcmNoQ1BVIGFuZCBpcyBwYXNzZWQgdG8gVENHIGNv
ZGUuIFRoZSBAbmVnIHN0cnVjdHVyZSBob2xkcyBzb21lDQo+ICsgKiBjb21tb24gVENHIENQ
VSB2YXJpYWJsZXMgd2hpY2ggYXJlIGFjY2Vzc2VkIHdpdGggYSBuZWdhdGl2ZSBvZmZzZXQN
Cj4gKyAqIGZyb20gY3B1X2Vudi4NCj4gICAgKi8NCj4gICBzdHJ1Y3QgQ1BVU3RhdGUgew0K
PiAgICAgICAvKjwgcHJpdmF0ZSA+Ki8NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

