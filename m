Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 255EDC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 17:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0kZj-0002Ro-5l; Fri, 04 Apr 2025 13:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZC-0002KS-Eu
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:57 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u0kZA-0005mZ-9s
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 13:10:54 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2295d78b433so23522815ad.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 10:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743786650; x=1744391450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IVDJLpbw9A2nnL3Wh78KLQxQFSJsS6c27WqeoOaOowE=;
 b=tGNzyjkSBHrtUBBrQxSwJXeR/m0j4IIe7BBF+x0FHBPnOFVO/EL0zimlAg5Hr/dOQ8
 5aQqLtvjC4SXLeFtEP2JuMF0FQZJEUSiqdISsBsxpJAncQ4tIgirPfYB/pOmcZtShMCz
 W2PRsEjcSkSJFGZYdAumShdCZ2PKS/m03gVkV9cdQXO4awtMu8vg2I9A8dmkOBBxQplB
 LI3qNoUoEZVTwZbL1869roXg6oa59cau/DsNZnzDihe1TdPUg7Oc9ZbuhZGusEFKjY3i
 uPy2loAA+RstAKrlBl0Mx3lH6wV6DBJ657SB9w1fV0k3kcsKEx0kEknx8MUKgP3kfjV7
 58JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743786650; x=1744391450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IVDJLpbw9A2nnL3Wh78KLQxQFSJsS6c27WqeoOaOowE=;
 b=GgEzuYP24rvJpOEL0yIRtCcHP7GQgZRqfS7VuZV1f+H8yH9FZxJmryg10ZeDgwXik7
 WCdyvG0nMCOqetNPkG5FZxBhu+Lj8Htuvsqmk2dSAP7No4C20ABwUKUl8+RaeRXtBwUW
 CBD4+8KkupIxJADvSCkL6uw4/uwpEKAOeB2orqETgfEUKFgbMMZEdAg8d5PtgCN9xjU2
 X9RTNTX7PnUo76LYWZcUDXLuVjeEPQyhfgu0qcmQSi1VQMZVWbS6c2+rceRrt74oI/yi
 CX08wdeMOPt0eyk7SyV1Tf5wX3bg+wYDfIVSifE316Qe0xAJVFvNlXjo9EkVXurXPYua
 QuNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI6OAO6dTI+v8TElhx9OSeA/xJBnPceORgsap4+4o6Rt9KuZJqsex35uEVIc5o39C8dJ02/7TlUi8z@nongnu.org
X-Gm-Message-State: AOJu0YzJZSUOhZhX0fzy47PEq9BBUMdyTlsU2LAkEX5WG4mrDCRAVIv/
 5Y/f6bmF43k5bXp8pfEf+exDBNINPXBCxwAqQ+NBcZq2uAhuNywVwzMouN/VOAed143RM7Vfjxe
 S
X-Gm-Gg: ASbGnct/WCwoOq7h6zrwIB95LzDcnR6D77g3vA8EJCJOZwfK2JL67+C5pZiH6u+uixI
 vPhk4cFIG5PyulqcnUCmWeAJYF5SOLEJJXkMmS2Vq5OYrDr83ztH8vBv05+CUG1faRkRzq16c3v
 WQqY1Aww2d86E/N7G7GG+IG/xw29YMC95wr/eOSBni3fHQ/9pWtaL+QjxbIOvzZVyVuMFVXQj8X
 4Ti/MGWxfrtVxjEF50W/tKgjZZC23FmtNzWbGSZZJ5QoSaa6w/l2nfEjHuUZu5BDKYqwHAyIl+j
 sRqHk4eDVFUuipkrwkES/AN4jvCxHJkHj9bj1OBsvNXa9127S0oveBJULDQkpKiyo2GK
X-Google-Smtp-Source: AGHT+IFkfNV6gNtAp5j4PIDwBWPc5ewFFdR9LtKehtJejQzrsHdZyzV/x6KWXiB66CjWDoxVefSx8Q==
X-Received: by 2002:a17:903:22cc:b0:224:26f2:97d6 with SMTP id
 d9443c01a7336-22a8a06b139mr58753515ad.28.1743786650646; 
 Fri, 04 Apr 2025 10:10:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-229785c0153sm34730435ad.65.2025.04.04.10.10.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Apr 2025 10:10:50 -0700 (PDT)
Message-ID: <2fd3d997-156e-4af8-8461-6d03c5e5a9ba@linaro.org>
Date: Fri, 4 Apr 2025 09:48:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 08/19] target/riscv: Replace TARGET_LONG_BITS
 -> target_long_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
 <20250403234914.9154-9-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250403234914.9154-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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
Pg0KPiAtLS0NCj4gICBody9yaXNjdi9yaXNjdi1pb21tdS5jIHwgMyArKy0NCj4gICBody9y
aXNjdi9yaXNjdl9oYXJ0LmMgIHwgMyArKy0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9yaXNj
di9yaXNjdi1pb21tdS5jIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUuYw0KPiBpbmRleCA2NTQx
MWIzZTRjMC4uMzc1NjNiMjEwMmYgMTAwNjQ0DQo+IC0tLSBhL2h3L3Jpc2N2L3Jpc2N2LWlv
bW11LmMNCj4gKysrIGIvaHcvcmlzY3YvcmlzY3YtaW9tbXUuYw0KPiBAQCAtMjYsNiArMjYs
NyBAQA0KPiAgICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPiAgICNpbmNsdWRl
ICJxYXBpL2Vycm9yLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCj4gKyNpbmNs
dWRlICJxZW11L3RhcmdldF9pbmZvLmgiDQo+ICAgDQo+ICAgI2luY2x1ZGUgImNwdV9iaXRz
LmgiDQo+ICAgI2luY2x1ZGUgInJpc2N2LWlvbW11LmgiDQo+IEBAIC0zOTMsNyArMzk0LDcg
QEAgc3RhdGljIGludCByaXNjdl9pb21tdV9zcGFfZmV0Y2goUklTQ1ZJT01NVVN0YXRlICpz
LCBSSVNDVklPTU1VQ29udGV4dCAqY3R4LA0KPiAgICAgICAgICAgICAgIGlmIChwYXNzID09
IFNfU1RBR0UgJiYgdmFfbGVuID4gMzIpIHsNCj4gICAgICAgICAgICAgICAgICAgdGFyZ2V0
X3Vsb25nIG1hc2ssIG1hc2tlZF9tc2JzOw0KPiAgIA0KPiAtICAgICAgICAgICAgICAgIG1h
c2sgPSAoMUwgPDwgKFRBUkdFVF9MT05HX0JJVFMgLSAodmFfbGVuIC0gMSkpKSAtIDE7DQo+
ICsgICAgICAgICAgICAgICAgbWFzayA9ICgxTCA8PCAodGFyZ2V0X2xvbmdfYml0cygpIC0g
KHZhX2xlbiAtIDEpKSkgLSAxOw0KPiAgICAgICAgICAgICAgICAgICBtYXNrZWRfbXNicyA9
IChhZGRyID4+ICh2YV9sZW4gLSAxKSkgJiBtYXNrOw0KPiAgIA0KPiAgICAgICAgICAgICAg
ICAgICBpZiAobWFza2VkX21zYnMgIT0gMCAmJiBtYXNrZWRfbXNicyAhPSBtYXNrKSB7DQo+
IGRpZmYgLS1naXQgYS9ody9yaXNjdi9yaXNjdl9oYXJ0LmMgYi9ody9yaXNjdi9yaXNjdl9o
YXJ0LmMNCj4gaW5kZXggYTU1ZDE1NjY2ODcuLjY2N2QzYjBhNTA3IDEwMDY0NA0KPiAtLS0g
YS9ody9yaXNjdi9yaXNjdl9oYXJ0LmMNCj4gKysrIGIvaHcvcmlzY3YvcmlzY3ZfaGFydC5j
DQo+IEBAIC0yMSw2ICsyMSw3IEBADQo+ICAgI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4g
ICAjaW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiAgICNpbmNsdWRlICJxZW11L21vZHVsZS5o
Ig0KPiArI2luY2x1ZGUgInFlbXUvdGFyZ2V0X2luZm8uaCINCj4gICAjaW5jbHVkZSAic3lz
dGVtL3Jlc2V0LmgiDQo+ICAgI2luY2x1ZGUgInN5c3RlbS9xdGVzdC5oIg0KPiAgICNpbmNs
dWRlICJxZW11L2N1dGlscy5oIg0KPiBAQCAtNzIsNyArNzMsNyBAQCBzdGF0aWMgdm9pZCBj
c3JfY2FsbChjaGFyICpjbWQsIHVpbnQ2NF90IGNwdV9udW0sIGludCBjc3JubywgdWludDY0
X3QgKnZhbCkNCj4gICAgICAgICAgIHJldCA9IHJpc2N2X2NzcnIoZW52LCBjc3JubywgKHRh
cmdldF91bG9uZyAqKXZhbCk7DQo+ICAgICAgIH0gZWxzZSBpZiAoc3RyY21wKGNtZCwgInNl
dF9jc3IiKSA9PSAwKSB7DQo+ICAgICAgICAgICByZXQgPSByaXNjdl9jc3JydyhlbnYsIGNz
cm5vLCBOVUxMLCAqKHRhcmdldF91bG9uZyAqKXZhbCwNCj4gLSAgICAgICAgICAgICAgICBN
QUtFXzY0QklUX01BU0soMCwgVEFSR0VUX0xPTkdfQklUUykpOw0KPiArICAgICAgICAgICAg
ICAgIE1BS0VfNjRCSVRfTUFTSygwLCB0YXJnZXRfbG9uZ19iaXRzKCkpKTsNCj4gICAgICAg
fQ0KPiAgIA0KPiAgICAgICBnX2Fzc2VydChyZXQgPT0gUklTQ1ZfRVhDUF9OT05FKTsNCg0K
VGhlIHRlbXB0YXRpb24gaXMgZ29vZCwgYnV0IHBsZWFzZSBkbyBub3QgdG91Y2ggYW55IHRh
cmdldCBjb2RlIGF0IHRoaXMgDQpwb2ludC4gV2Ugd2FudCB0byBmb2N1cyBvbiBkZWZpbmlu
ZyB0aGUgQVBJIGZpcnN0LCBhbmQgd2UgY2FuIHBlcmZvcm0gDQpjb2RlYmFzZSBjaGFuZ2Vz
IGFzIGEgc2Vjb25kIHN0ZXAsIHdpdGhvdXQgbGV0dGluZyBhbnkgb2NjdXJyZW5jZXMgb2Yg
DQp0aGUgb2xkIG1hY3Jvcy9mdW5jdGlvbnMsIGluc3RlYWQgb2YganVzdCBhZGRpbmcgImFu
b3RoZXIgd2F5IHRvIGRvIGl0Ii4NCg==

