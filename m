Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C073D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRCb-0003aY-3P; Wed, 13 Nov 2024 23:11:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCT-0003WP-9g
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:22 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCP-0003a7-Dg
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:19 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7ea7e250c54so105873a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557475; x=1732162275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0XxgsVbh6WLMBu6c5e3A7oFTEFNkwa2SFFQqmoidBOw=;
 b=D4LIqlYkT2kElfBuA+cpFxaCbyCIzxnaQZDTelp8myMjqxU/x1dXGZwx7qbJABOtMP
 iIPWXC1kTdpJ785xwDi3b/fXi9U7JuWV5eTJRtTT/8IHQiS+IAH4F9CEyyRQdKkiG1cZ
 atjmKgdvWJxhuqYtipL/Sf9B8dGtcuJW+QnwcUMIcVKWyC17MfO3fqetKCtcT8U29O8s
 YnQ19jc5lkkTN3I0xJSbrbTXGwdzxFdAMqGhKWoEL8vPDp1XRA0pUWPNarVFeRzIj/dl
 k2WekjYsT63XIRtTWMYpinai1uA1gKStpp4s9RUmQ7jOKDzH0VWNhPATeNY/SZKM4QaQ
 hM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557475; x=1732162275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0XxgsVbh6WLMBu6c5e3A7oFTEFNkwa2SFFQqmoidBOw=;
 b=JTXKR1F3dppLDMdl/vp+QOc3c/BboHFNCe2FqlNPv4psxBqWtZH5k1CKBbsSJiGS0G
 2dgXhhUcw1TRxBWE7/3ENUnuHY38FXKhSIHOQ1l0cC+aOUrxCzdJJSwaDdct6xywo2Md
 DgSgjal/pA0S0YZdONPNeMRvYMpYEAaYcFTXhTjvbyxEFWLkAbzYX4+Mq5hgEfBGHTMX
 JrHGTTeUYZnn8XzHs+Z2PN2xqTMq7tpgxOieNlvw3VYakqJ56l9zvYwL48TQdYSnzyK1
 PI7I8R4ZyXUAUludIlR2e88q6577BClD2e8PaYIn1MAcXg5OLpVudYEzF5mbYJgDDh40
 qj+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOgvxewkNQ+HFOZOqf5dcybc3ARDeZi+LgfgFpjmUVlOoWaFxQx44kSyK0joV5TrbVK0Qxu7fXoJuT@nongnu.org
X-Gm-Message-State: AOJu0YzRsktCBT39oUXPcYYOaqLTPy0JVfGSpnK4fLtx1aO5qJBCTcTt
 /t/rvdusRAsnw16jIKTe+N8DgSe/xbmfGQ8HBOgC+1uJuaTLGB8Gz+mBLh3oYIc=
X-Google-Smtp-Source: AGHT+IHTgPfiUUJx4xE6zTpq/2sJPjH4HXxH8Yh8JVcZAsQWRP08Jl1HxMSx4513W9vccQZdRIIKeQ==
X-Received: by 2002:a05:6a20:72a5:b0:1db:e883:e055 with SMTP id
 adf61e73a8af0-1dc832a5e90mr1247753637.7.1731557474748; 
 Wed, 13 Nov 2024 20:11:14 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7246a9bcfc0sm242604b3a.163.2024.11.13.20.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:14 -0800 (PST)
Message-ID: <2d6b8b11-60cd-4484-a930-f43b215fbc97@linaro.org>
Date: Wed, 13 Nov 2024 20:11:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/24] accel/tcg: Include missing
 'exec/translation-block.h' header
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
 <20241114011310.3615-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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
Cj4gVEIgY29tcGlsZSBmbGFncyBhcmUgZGVmaW5lZCBpbiAiZXhlYy90cmFuc2xhdGlvbi1i
bG9jay5oIi4NCj4gSW5jbHVkZSBpdCBpbiBvcmRlciB0byBhdm9pZCB3aGVuIHJlZmFjdG9y
aW5nOg0KPiANCj4gICAgYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYzo2MjozNjogZXJyb3I6
IHVzZSBvZiB1bmRlY2xhcmVkIGlkZW50aWZpZXIgJ0NGX0NMVVNURVJfU0hJRlQnDQo+ICAg
ICAgIDYyIHwgICAgIGNmbGFncyA9IGNwdS0+Y2x1c3Rlcl9pbmRleCA8PCBDRl9DTFVTVEVS
X1NISUZUOw0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXg0KPiAgICBhY2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5jOjY0OjI2OiBlcnJvcjogdXNl
IG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnQ0ZfUEFSQUxMRUwnDQo+ICAgICAgIDY0IHwg
ICAgIGNmbGFncyB8PSBwYXJhbGxlbCA/IENGX1BBUkFMTEVMIDogMDsNCj4gICAgICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgXg0KPiAgICBhY2NlbC90Y2cvdGNnLWFjY2Vs
LW9wcy5jOjY1OjM0OiBlcnJvcjogdXNlIG9mIHVuZGVjbGFyZWQgaWRlbnRpZmllciAnQ0Zf
VVNFX0lDT1VOVCcNCj4gICAgICAgNjUgfCAgICAgY2ZsYWdzIHw9IGljb3VudF9lbmFibGVk
KCkgPyBDRl9VU0VfSUNPVU5UIDogMDsNCj4gICAgICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBeDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGFjY2VsL3RjZy90
Y2ctYWNjZWwtb3BzLmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykNCj4gDQo+IGRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5jIGIvYWNj
ZWwvdGNnL3RjZy1hY2NlbC1vcHMuYw0KPiBpbmRleCAzYzE5ZTY4YTc5Li4yMjQ4NmM1ZGZm
IDEwMDY0NA0KPiAtLS0gYS9hY2NlbC90Y2cvdGNnLWFjY2VsLW9wcy5jDQo+ICsrKyBiL2Fj
Y2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMNCj4gQEAgLTM1LDYgKzM1LDcgQEANCj4gICAjaW5j
bHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiAgICNpbmNsdWRlICJleGVjL2h3YWRkci5oIg0K
PiAgICNpbmNsdWRlICJleGVjL3RiLWZsdXNoLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy90cmFu
c2xhdGlvbi1ibG9jay5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHViL2VudW1zLmgiDQo+ICAg
DQo+ICAgI2luY2x1ZGUgImh3L2NvcmUvY3B1LmgiDQoNClJldmlld2VkLWJ5OiBQaWVycmlj
ayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoNCg==

