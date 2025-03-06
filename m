Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC534C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqK97-0006FE-93; Thu, 06 Mar 2025 17:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqK95-0006Eq-AJ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:56:51 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqK93-0006Za-JS
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:56:51 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-223a7065ff8so28588625ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741301808; x=1741906608; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tFHrc692Y8qh90DSYv2k4rkKWn77/70LUiREi1bmfTk=;
 b=iWmBdYfvzCXOW8xZa+RFgWl+4p2YAcOUb3uapoSrmhuWd47DuCnSSNQvePGuu3rEcB
 jC4a1RF2rlS7C42sjBxBVx5iNcWy7gpqAhm+BBNj00BtZHsK6O7pFpnkzWDpLq+QZkey
 qUV05jWlZwfm11z8q8UHB64hhaEuglne7z3nEWLbuaCNysxGWXIHCKKMLFI3CyZNZPpc
 +khpnywLYhIW5XT9IIAryeFzU27y418chf3gE4IspG43pEO+ZLeQVGARbHhcHlSXCaKW
 LT+ZWiMSp866U6SZBnHVVeKpKrD1dphROzdL+jzfjkyw6qnSTIpuMNVeKe44c28qMwdg
 +qbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741301808; x=1741906608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tFHrc692Y8qh90DSYv2k4rkKWn77/70LUiREi1bmfTk=;
 b=aNIo+SFIxlI6zHC/sHZksGCPsZt2x1KKOy/bju50hEGkSLwC0J0suDwzG0m9lWdilQ
 djfk50vbWktaUhPKaHoM5pBqibnXRrTgNOe8WYDcoKEQayq1VUx1lx3A+utAjk230Izn
 LpabU49LFUa8BBCJREJPczR+dRHiVZw1H+fKfBLPi0fp8nyuXO+DAJbATG43CoV3fktd
 QzBT5dDfRjLj++zFrfFwGQ7sHZ5guQtqzvL3+DQOJ/V//P6ba5bMp6cFPHMQxwX1sS8f
 gnz2nh2YcboM7QvYdppRWiLDmwPeT2TKPrJWNfV9OlSHQGcfyFbBTLc3G86qwjPXkxx5
 tMlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCULF2zsKNTpOfoOt0/W2gmZuXGh65CfYMpz/yQwHJd1ULhoss/6HktorglfH/9GyZGDjZqJMva6Yl4T@nongnu.org
X-Gm-Message-State: AOJu0Yy8V9b2kkdnueWXrOQIhushIcNRu+bXCS/I1Rw0o9nE0QTbnXel
 KN7X9Kb108XFC7Fhn6Jeg3ZqoEN6kVjLlmvNWFlANE/aBFRb7GOpUJMNbztY5gc=
X-Gm-Gg: ASbGncsnIItA2+UlDDdAkpkCJLnEnhp/etbsSbnaCSPH75GCiVgiyVh2AOcH1BeGB2u
 Wlf7/cLHZGvDP66DES1xlKh162PdmMGWOAFfp5+A3qx2vhFCV09nEC4OEGqCP/JUvur2Tb0DnLP
 7+ykcWlKKqEhQOjGQCZUuq3QM3MTjYOb63qc7RbxTvq4EaEOGRxkZadjzuLY8PYfy69vzJ3bomq
 AhIDzmd84tpUMcEytq3IK1XOaQOfxX2r9uZsOF2/L5LLgsa9kYLb0nKJqIhDxw7/KBW+UzGrpLV
 ERJGRl7oew7TNV8jRkq1NgpnUJcW85JpxO3JfPfoqfPwX3uCo46AI2G7aQ==
X-Google-Smtp-Source: AGHT+IFOJ1hF06oncnjzqkL9LiblvIpsOu4HzSGUo4HKzGxGg+Ah+gCd3U2ZhxwNyrKtxXO8Wt7zDQ==
X-Received: by 2002:a05:6a20:748e:b0:1ee:d418:f764 with SMTP id
 adf61e73a8af0-1f544c98cb0mr1855892637.38.1741301808110; 
 Thu, 06 Mar 2025 14:56:48 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698518e21sm1970732b3a.148.2025.03.06.14.56.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:56:47 -0800 (PST)
Message-ID: <6556fdd8-83ea-4cc6-9a3b-3822fdc8cb5d@linaro.org>
Date: Thu, 6 Mar 2025 14:56:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
 <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
 <35c2c7a5-5b12-4c21-a40a-375caae60d0c@linaro.org>
 <d62743f5-ca79-47c0-a72b-c36308574bdd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d62743f5-ca79-47c0-a72b-c36308574bdd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

T24gMy82LzI1IDA5OjU4LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gT24g
Ni8zLzI1IDE3OjIzLCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gMy82LzI1IDA4
OjE5LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBPbiAzLzUvMjUgMjI6NDEsIFBp
ZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+IFJlcGxhY2UgVEFSR0VUX1BBR0UuKiBieSBy
dW50aW1lIGNhbGxzDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+ICDCoMKg
IGh3L2h5cGVydi9zeW5kYmcuY8KgwqDCoCB8IDcgKysrKy0tLQ0KPj4+PiAgwqDCoCBody9o
eXBlcnYvbWVzb24uYnVpbGQgfCAyICstDQo+Pj4+ICDCoMKgIDIgZmlsZXMgY2hhbmdlZCwg
NSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0
IGEvaHcvaHlwZXJ2L3N5bmRiZy5jIGIvaHcvaHlwZXJ2L3N5bmRiZy5jDQo+Pj4+IGluZGV4
IGQzZTM5MTcwNzcyLi5mOTM4MjIwMmVkMyAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaHlwZXJ2
L3N5bmRiZy5jDQo+Pj4+ICsrKyBiL2h3L2h5cGVydi9zeW5kYmcuYw0KPj4+PiBAQCAtMTQs
NyArMTQsNyBAQA0KPj4+PiAgwqDCoCAjaW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCIN
Cj4+Pj4gIMKgwqAgI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIg0KPj4+PiAgwqDC
oCAjaW5jbHVkZSAiaHcvbG9hZGVyLmgiDQo+Pj4+IC0jaW5jbHVkZSAiY3B1LmgiDQo+Pj4+
ICsjaW5jbHVkZSAiZXhlYy90YXJnZXRfcGFnZS5oIg0KPj4+PiAgwqDCoCAjaW5jbHVkZSAi
aHcvaHlwZXJ2L2h5cGVydi5oIg0KPj4+PiAgwqDCoCAjaW5jbHVkZSAiaHcvaHlwZXJ2L3Zt
YnVzLWJyaWRnZS5oIg0KPj4+PiAgwqDCoCAjaW5jbHVkZSAiaHcvaHlwZXJ2L2h5cGVydi1w
cm90by5oIg0KPj4+PiBAQCAtMTg4LDcgKzE4OCw4IEBAIHN0YXRpYyB1aW50MTZfdCBoYW5k
bGVfcmVjdl9tc2coSHZTeW5EYmcgKnN5bmRiZywNCj4+Pj4gdWludDY0X3Qgb3V0Z3BhLA0K
Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDY0X3QgdGltZW91dCwgdWludDMyX3QNCj4+Pj4g
KnJldHJpZXZlZF9jb3VudCkNCj4+Pj4gIMKgwqAgew0KPj4+PiAgwqDCoMKgwqDCoMKgIHVp
bnQxNl90IHJldDsNCj4+Pj4gLcKgwqDCoCB1aW50OF90IGRhdGFfYnVmW1RBUkdFVF9QQUdF
X1NJWkUgLSBVRFBfUEtUX0hFQURFUl9TSVpFXTsNCj4+Pj4gK8KgwqDCoCBjb25zdCBzaXpl
X3QgYnVmX3NpemUgPSBxZW11X3RhcmdldF9wYWdlX3NpemUoKSAtDQo+Pj4+IFVEUF9QS1Rf
SEVBREVSX1NJWkU7DQo+Pj4+ICvCoMKgwqAgdWludDhfdCAqZGF0YV9idWYgPSBnX2FsbG9j
YShidWZfc2l6ZSk7DQo+Pj4+ICDCoMKgwqDCoMKgwqAgaHdhZGRyIG91dF9sZW47DQo+Pj4+
ICDCoMKgwqDCoMKgwqAgdm9pZCAqb3V0X2RhdGE7DQo+Pj4+ICDCoMKgwqDCoMKgwqAgc3Np
emVfdCByZWN2X2J5dGVfY291bnQ7DQo+Pj4NCj4+PiBXZSd2ZSBwdXJnZWQgdGhlIGNvZGUg
YmFzZSBvZiBWTEFzLCBhbmQgdGhvc2UgYXJlIHByZWZlcmFibGUgdG8gYWxsb2NhLg0KPj4+
IEp1c3QgdXNlIGdfbWFsbG9jIGFuZCBnX2F1dG9mcmVlLg0KPj4+DQo+Pg0KPj4gSSBoZXNp
dGF0ZWQsIGR1ZSB0byBwb3RlbnRpYWwgcGVyZm9ybWFuY2UgY29uc2lkZXJhdGlvbnMgZm9y
IHBlb3BsZQ0KPj4gcmV2aWV3aW5nIHRoZSBwYXRjaC4gSSdsbCBzd2l0Y2ggdG8gaGVhcCBi
YXNlZCBzdG9yYWdlLg0KPiANCj4gT1RPSCBoeXBlcnYgaXMgeDg2LW9ubHksIHNvIHdlIGNv
dWxkIGRvOg0KPiANCj4gI2RlZmluZSBCVUZTWiAoNCAqIEtpQikNCj4gDQo+IGhhbmRsZV9y
ZWN2X21zZygpDQo+IHsNCj4gICAgIHVpbnQ4X3QgZGF0YV9idWZbQlVGU1ogLSBVRFBfUEtU
X0hFQURFUl9TSVpFXTsNCj4gICAgIC4uLg0KPiANCj4gaHZfc3luZGJnX2NsYXNzX2luaXQo
KQ0KPiB7DQo+ICAgICBhc3NlcnQoQlVGU1ogPiBxZW11X3RhcmdldF9wYWdlX3NpemUoKSk7
DQo+ICAgICAuLi4NCj4gDQo+IGFuZCBjYWxsIGl0IGEgZGF5Lg0KDQpDb3VsZCBiZSBwb3Nz
aWJsZSBmb3Igbm93IHllcy4NCg0KQW55IG9waW5pb24gZnJvbSBjb25jZXJuZWQgbWFpbnRh
aW5lcnM/DQo=

