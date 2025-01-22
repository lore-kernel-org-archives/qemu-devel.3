Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3CEC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 00:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taOoA-0006Z4-TV; Tue, 21 Jan 2025 19:41:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOo9-0006Yr-Lp
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:41:25 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOo8-0007iy-4G
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:41:25 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2efd81c7ca4so8502698a91.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 16:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737506482; x=1738111282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KxHRqM22EWf8BAGXnVNAX2RwgmvGytex2KgoD7gx6X0=;
 b=F4V9G+yXF8nqlHyOnNnSuzoGIPJec/3ZpFbfL3vBe2b9SmycLTLv7Yu5wxIOmikpOK
 DQBY9iD26UnJstLG1cEvhhI/7PU+ZAqqdhe7NE/0RZ0yuPuQsHDvTRoHnop8ET88kQBB
 aOjc61snlw5s4qhSp6/9Xd1jMXdcCO4V3Dns8E10zeTAMyMEjI3Py7qC0W+sYPMXAjgH
 6jKWhE8G6TVPGAwVtaWQTkPj/e8avRbunrIx+EvnTUBnuSxOW6GzhPQJuSamN4jwP4oD
 PUt9QPcKLYVQIptesc430Xn51jOajMmOKQQ4Edz7yjxDQkVjF9g46fNylQTQSOGo19tj
 FsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737506482; x=1738111282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KxHRqM22EWf8BAGXnVNAX2RwgmvGytex2KgoD7gx6X0=;
 b=PfYSB+iIk5EQU0lXa3rnLTFrGQlvIUaBA4SLyEA2skLpa45bQPACBruVEyA6X6m3m8
 6SAjBaAZJVDgFlexZx1Kip1AfEsb2CHxgtmgYBbMe0ZFeu1Gfc7zxXf3v4j4zrI3pJuN
 JmDqvZhEBHWJH6yuPqKAhgRsBCrKy5dxloau3e6MWaObhw/Bj8cUzJGoM3FYbwMfs+u6
 Ov5oUZw15wsREADSl6/1Rkd8uHcIP2Rt7qj4IJaG0X71n686Hq9FZyuQgiYLlkuh9oI7
 PUzqt6NPfDgYBhfp1sL8tw/7Y2LqcDbxLGO+xasRhcJxFUUeW2t/fg4rblmXKgALqt0Y
 3jvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuK+BcROna1rBfCwJSByowISjSTtBx5j4aImBI4DCW1luFvC1v8yl8hrw3hKekFZ6qR51uYcYqxByP@nongnu.org
X-Gm-Message-State: AOJu0Ywty+c1w1Cyl3TAvZ+3hLagsCaDodZJhZsM7NDSzi4ff8nXxIlk
 TtLlN+gzMUKB2UeTs2AjgIel3Z4b6eX12TXwt8H/CUeuPkiFiX2R8KzrGRCrPok=
X-Gm-Gg: ASbGncsloCMbpHKJtgnHfk/a2q77tAwT0oEVQYOF3RbdNHTTCubkLqmAPFibDcA+jfT
 /ef1g5vews9b58utYn18vu5Iroo47MBD34jYqqU1aItZKKW37SpkqEglHb81d0nM0Z6w7zek8cT
 0+KqMNkv/U+PQC5yAqELuysV7nFUFEeVC/ZIMNn4u9CTQ0W4/6Osfe9o1FjhWPy3CT6iABupkIK
 mV1u3YEJHriL/qVs+kfIxlFg0uJEO1MwnMAnZFy3V3GXirxIE1Q201RoBLclm3scp6TL92JMbnG
 NzLZkoQ=
X-Google-Smtp-Source: AGHT+IEL9z3LN4MIj9CaGtPChrI0Gk6elODPX+6SgOfYs4nIt1BjuHST+73lx6v4ps0xNcG5hEYB5w==
X-Received: by 2002:a05:6a00:a0c:b0:726:41e:b321 with SMTP id
 d2e1a72fcca58-72dafbdacadmr29000654b3a.21.1737506482325; 
 Tue, 21 Jan 2025 16:41:22 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a9bca75d6fasm9640933a12.4.2025.01.21.16.41.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 16:41:21 -0800 (PST)
Message-ID: <6e577f6b-00bc-4482-b3cf-b0106edfe6e3@linaro.org>
Date: Tue, 21 Jan 2025 16:41:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] linux-user: Only include 'exec/tb-flush.h' header
 when necessary
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-2-philmd@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250102182521.65428-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1036.google.com
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

T24gMS8yLzI1IDEwOjI1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gVmVy
eSBmZXcgc291cmNlIGZpbGVzIHJlcXVpcmUgdG8gYWNjZXNzICJleGVjL3RiLWZsdXNoLmgi
DQo+IGRlY2xhcmF0aW9ucywgYW5kIGV4Y2VwdCBhIHBhaXIsIHRoZXkgYWxsIGluY2x1ZGUg
aXQNCj4gZXhwbGljaXRseS4gTm8gbmVlZCB0byBvdmVybG9hZCB0aGUgZ2VuZXJpYyAidXNl
ci1pbnRlcm5hbHMuaCIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1
LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGxpbnV4LXVzZXIvdXNl
ci1pbnRlcm5hbHMuaCB8IDEgLQ0KPiAgIGxpbnV4LXVzZXIvbW1hcC5jICAgICAgICAgICB8
IDEgKw0KPiAgIGxpbnV4LXVzZXIvc3lzY2FsbC5jICAgICAgICB8IDEgKw0KPiAgIDMgZmls
ZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvbGludXgtdXNlci91c2VyLWludGVybmFscy5oIGIvbGludXgtdXNlci91c2Vy
LWludGVybmFscy5oDQo+IGluZGV4IGI5YjA1YzFkMTFmLi40YWEyNTNiNTY2MyAxMDA2NDQN
Cj4gLS0tIGEvbGludXgtdXNlci91c2VyLWludGVybmFscy5oDQo+ICsrKyBiL2xpbnV4LXVz
ZXIvdXNlci1pbnRlcm5hbHMuaA0KPiBAQCAtMjAsNyArMjAsNiBAQA0KPiAgIA0KPiAgICNp
bmNsdWRlICJ1c2VyL3RodW5rLmgiDQo+ICAgI2luY2x1ZGUgImV4ZWMvZXhlYy1hbGwuaCIN
Cj4gLSNpbmNsdWRlICJleGVjL3RiLWZsdXNoLmgiDQo+ICAgI2luY2x1ZGUgInFlbXUvbG9n
LmgiDQo+ICAgDQo+ICAgZXh0ZXJuIGNoYXIgKmV4ZWNfcGF0aDsNCj4gZGlmZiAtLWdpdCBh
L2xpbnV4LXVzZXIvbW1hcC5jIGIvbGludXgtdXNlci9tbWFwLmMNCj4gaW5kZXggNjgyOGIx
N2E2M2YuLmQxZjM2ZTZmMTZiIDEwMDY0NA0KPiAtLS0gYS9saW51eC11c2VyL21tYXAuYw0K
PiArKysgYi9saW51eC11c2VyL21tYXAuYw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgICNp
bmNsdWRlICJ0cmFjZS5oIg0KPiAgICNpbmNsdWRlICJleGVjL2xvZy5oIg0KPiAgICNpbmNs
dWRlICJleGVjL3BhZ2UtcHJvdGVjdGlvbi5oIg0KPiArI2luY2x1ZGUgImV4ZWMvdGItZmx1
c2guaCINCj4gICAjaW5jbHVkZSAiZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oIg0KPiAgICNp
bmNsdWRlICJxZW11LmgiDQo+ICAgI2luY2x1ZGUgInVzZXIvcGFnZS1wcm90ZWN0aW9uLmgi
DQo+IGRpZmYgLS1naXQgYS9saW51eC11c2VyL3N5c2NhbGwuYyBiL2xpbnV4LXVzZXIvc3lz
Y2FsbC5jDQo+IGluZGV4IDc4YzdjMGIzNGVmLi5jYmJmY2YxMGQyOCAxMDA2NDQNCj4gLS0t
IGEvbGludXgtdXNlci9zeXNjYWxsLmMNCj4gKysrIGIvbGludXgtdXNlci9zeXNjYWxsLmMN
Cj4gQEAgLTI2LDYgKzI2LDcgQEANCj4gICAjaW5jbHVkZSAidGNnL3N0YXJ0dXAuaCINCj4g
ICAjaW5jbHVkZSAidGFyZ2V0X21tYW4uaCINCj4gICAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCINCj4gKyNpbmNsdWRlICJleGVjL3RiLWZsdXNoLmgiDQo+ICAgI2luY2x1
ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCINCj4gICAjaW5jbHVkZSA8ZWxmLmg+DQo+
ICAgI2luY2x1ZGUgPGVuZGlhbi5oPg0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

