Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D512C0218B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 00:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taOoT-0006aP-H8; Tue, 21 Jan 2025 19:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOoQ-0006Zy-NQ
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:41:42 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1taOoO-0007lC-Mk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 19:41:42 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso113079915ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737506498; x=1738111298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=d2WWoCSi93xbSFJkWksip3uPa/t+1E0Eir5NeiRZfUM=;
 b=layGZrpc/iVMkha/AgZjmxOtl2Fd4FyWAtaEgoiFXGM3l5hWfjj21WwFEaL8Zy9GHT
 IjDEY72S/0PW5HNYlh4njZ9JemuRo/UkonyU0q2l2/ALgalsWAbxiJK9hkJQZnOwugbY
 PnSgS+hqgu4nYUQrxI2p0JSvRTnaynLuD7JlNZnnhjUPb/U/ihH7uTHYH7MWZtUiI0aZ
 0jbw3VcVcEekYBnIXkFll4Z4BgckZtcZvppcVPQt6mBtnon7tQprSbdoJzdudMW9clH/
 b1r0E123DZLgXjDz0wXHjsaJZBrajshP6jqOjIt9eq8ExpuX9ZAyYSFNtnYToRfzh7cO
 9SnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737506498; x=1738111298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d2WWoCSi93xbSFJkWksip3uPa/t+1E0Eir5NeiRZfUM=;
 b=RFQ1pHwXuV26CKPZQ+q6FaVCLIvTFWF2I8S6zmHhzNOFDRp2HfKLiaMD8+13eGrTKx
 Bvlq4PO3wS34JhqiskFeNjTCsxB7mlWIUK/fROQjFX2pPPidT87eY9kaRaJcJmVSHHvX
 yPmaJntiL5g/SHFy4A8SvGVZ4Ys2b4PskP+LYvzJcrRD9GZvAElTs2M6jelXL90cy2OA
 b0/DkME0ONtPpva0PsASpPbsfuottE1zn2oTT7O75qvRRoRdMfFzGcTNWgC2YKmRDviQ
 Wpye7B+cW/rSLi4G4qCzDMEzIt+fLowISkPl0+buQvAVE69PvhLdXTPYvp3+j/e0eMGr
 RNaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwYkfTSvUu3f8RziXhKiTeD60+e3UMnni4ir9aJ0sUJW8C7BXu1tdnb80M38g00dxfwYTLCQhISsld@nongnu.org
X-Gm-Message-State: AOJu0YwoHwmhBOih2T4egJ0cmn8XlRCQLhMUpxRQUor+QkcZunG90jj4
 1CVCy+OZOoIrCgHvQRkpOcpkkl7wA79FMKNpqnbw6NUqCZv3fHAX3BaZ42Dc/lY=
X-Gm-Gg: ASbGncuxzZwzrH04LXY5TSnyIEi7SEVRq/GD8+FwvkWd5es5F856Gwl7x11YuQhqv0M
 3U1jqgOzJ8scM5/NdWfwEcvaWKvQHaOCXEnWHxl8aokeaa0+n9pOydbWWKx/CI4LywYTnZ57fSp
 1vKRbcfEl+oqOAvQftHq9QziPbsZp+2HezDvfMvtO6TbBv0CwfO1kVyFx1GbCmAAb6XD4Z7Fypo
 XziDGQmz7g8uzrdncf0ErHQ2v4Z756ryTFnXFWl9wMK/74pcXVwpcWzLryEa8JXcaowfv8IxFT2
 C5VO0C4=
X-Google-Smtp-Source: AGHT+IE4sCmpsElIDJftdHbv6cfQfIjQcT4hp66B679TE/8F+VpL3YuZVWkmGl/z+2OvbvNGK6Fd7A==
X-Received: by 2002:a17:902:d50c:b0:21a:8dec:e59f with SMTP id
 d9443c01a7336-21c355c28f0mr230947815ad.39.1737506498169; 
 Tue, 21 Jan 2025 16:41:38 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0a82sm83245735ad.11.2025.01.21.16.41.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 16:41:37 -0800 (PST)
Message-ID: <cf3ccf51-443a-4f89-93b7-ff1548eb76c2@linaro.org>
Date: Tue, 21 Jan 2025 16:41:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] accel/tcg: Factor out common tcg_exec_reset() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <20250102182521.65428-1-philmd@linaro.org>
 <20250102182521.65428-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250102182521.65428-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMS8yLzI1IDEwOjI1LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gU2lu
Y2UgdGNnX2NwdV9yZXNldF9ob2xkKCkgaXMgYSBzeXN0ZW0gZW11bGF0aW9uIHNwZWNpZmlj
DQo+IGhlbHBlciwgZmFjdG9yIHRjZ19leGVjX3Jlc2V0KCkgb3V0IHNvIHdlIGNhbiB1c2Ug
aXQgZnJvbQ0KPiB1c2VyIGVtdWxhdGlvbiwgc2ltaWxhcmx5IHRvIHRoZSBbdW5dcmVhbGl6
ZSgpIGhhbmRsZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBhY2NlbC90Y2cvaW50ZXJu
YWwtY29tbW9uLmggfCAxICsNCj4gICBhY2NlbC90Y2cvY3B1LWV4ZWMtY29tbW9uLmMgfCA2
ICsrKysrKw0KPiAgIGFjY2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMgICB8IDQgKystLQ0KPiAg
IDMgZmlsZXMgY2hhbmdlZCwgOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9pbnRlcm5hbC1jb21tb24uaCBiL2FjY2VsL3Rj
Zy9pbnRlcm5hbC1jb21tb24uaA0KPiBpbmRleCBjOGQ3MTQyNTZjYi4uOGI0NzRmYzEyNTYg
MTAwNjQ0DQo+IC0tLSBhL2FjY2VsL3RjZy9pbnRlcm5hbC1jb21tb24uaA0KPiArKysgYi9h
Y2NlbC90Y2cvaW50ZXJuYWwtY29tbW9uLmgNCj4gQEAgLTU1LDYgKzU1LDcgQEAgdm9pZCBj
cHVfcmVzdG9yZV9zdGF0ZV9mcm9tX3RiKENQVVN0YXRlICpjcHUsIFRyYW5zbGF0aW9uQmxv
Y2sgKnRiLA0KPiAgIA0KPiAgIGJvb2wgdGNnX2V4ZWNfcmVhbGl6ZWZuKENQVVN0YXRlICpj
cHUsIEVycm9yICoqZXJycCk7DQo+ICAgdm9pZCB0Y2dfZXhlY191bnJlYWxpemVmbihDUFVT
dGF0ZSAqY3B1KTsNCj4gK3ZvaWQgdGNnX2V4ZWNfcmVzZXQoQ1BVU3RhdGUgKmNwdSk7DQo+
ICAgDQo+ICAgLyogY3VycmVudCBjZmxhZ3MgZm9yIGhhc2hpbmcvY29tcGFyaXNvbiAqLw0K
PiAgIHVpbnQzMl90IGN1cnJfY2ZsYWdzKENQVVN0YXRlICpjcHUpOw0KPiBkaWZmIC0tZ2l0
IGEvYWNjZWwvdGNnL2NwdS1leGVjLWNvbW1vbi5jIGIvYWNjZWwvdGNnL2NwdS1leGVjLWNv
bW1vbi5jDQo+IGluZGV4IDZlY2ZjNGU3YzIxLi43MmFiOWMzZDk3NyAxMDA2NDQNCj4gLS0t
IGEvYWNjZWwvdGNnL2NwdS1leGVjLWNvbW1vbi5jDQo+ICsrKyBiL2FjY2VsL3RjZy9jcHUt
ZXhlYy1jb21tb24uYw0KPiBAQCAtMjEsNiArMjEsNyBAQA0KPiAgICNpbmNsdWRlICJzeXN0
ZW0vY3B1cy5oIg0KPiAgICNpbmNsdWRlICJzeXN0ZW0vdGNnLmgiDQo+ICAgI2luY2x1ZGUg
InFlbXUvcGx1Z2luLmgiDQo+ICsjaW5jbHVkZSAiZXhlYy90Yi1mbHVzaC5oIg0KPiAgICNp
bmNsdWRlICJpbnRlcm5hbC1jb21tb24uaCINCj4gICANCj4gICBib29sIHRjZ19hbGxvd2Vk
Ow0KPiBAQCAtNTYsMyArNTcsOCBAQCB2b2lkIGNwdV9sb29wX2V4aXRfYXRvbWljKENQVVN0
YXRlICpjcHUsIHVpbnRwdHJfdCBwYykNCj4gICAgICAgY3B1LT5leGNlcHRpb25faW5kZXgg
PSBFWENQX0FUT01JQzsNCj4gICAgICAgY3B1X2xvb3BfZXhpdF9yZXN0b3JlKGNwdSwgcGMp
Ow0KPiAgIH0NCj4gKw0KPiArdm9pZCB0Y2dfZXhlY19yZXNldChDUFVTdGF0ZSAqY3B1KQ0K
PiArew0KPiArICAgIHRjZ19mbHVzaF9qbXBfY2FjaGUoY3B1KTsNCj4gK30NCj4gZGlmZiAt
LWdpdCBhL2FjY2VsL3RjZy90Y2ctYWNjZWwtb3BzLmMgYi9hY2NlbC90Y2cvdGNnLWFjY2Vs
LW9wcy5jDQo+IGluZGV4IDZlM2YxZmE5MmIyLi40ZmU2ODIxYjAxNyAxMDA2NDQNCj4gLS0t
IGEvYWNjZWwvdGNnL3RjZy1hY2NlbC1vcHMuYw0KPiArKysgYi9hY2NlbC90Y2cvdGNnLWFj
Y2VsLW9wcy5jDQo+IEBAIC0zNCw3ICszNCw2IEBADQo+ICAgI2luY2x1ZGUgInFlbXUvdGlt
ZXIuaCINCj4gICAjaW5jbHVkZSAiZXhlYy9leGVjLWFsbC5oIg0KPiAgICNpbmNsdWRlICJl
eGVjL2h3YWRkci5oIg0KPiAtI2luY2x1ZGUgImV4ZWMvdGItZmx1c2guaCINCj4gICAjaW5j
bHVkZSAiZXhlYy90cmFuc2xhdGlvbi1ibG9jay5oIg0KPiAgICNpbmNsdWRlICJnZGJzdHVi
L2VudW1zLmgiDQo+ICAgDQo+IEBAIC00NCw2ICs0Myw3IEBADQo+ICAgI2luY2x1ZGUgInRj
Zy1hY2NlbC1vcHMtbXR0Y2cuaCINCj4gICAjaW5jbHVkZSAidGNnLWFjY2VsLW9wcy1yci5o
Ig0KPiAgICNpbmNsdWRlICJ0Y2ctYWNjZWwtb3BzLWljb3VudC5oIg0KPiArI2luY2x1ZGUg
ImludGVybmFsLWNvbW1vbi5oIg0KPiAgIA0KPiAgIC8qIGNvbW1vbiBmdW5jdGlvbmFsaXR5
IGFtb25nIGFsbCBUQ0cgdmFyaWFudHMgKi8NCj4gICANCj4gQEAgLTgzLDcgKzgzLDcgQEAg
aW50IHRjZ19jcHVfZXhlYyhDUFVTdGF0ZSAqY3B1KQ0KPiAgIA0KPiAgIHN0YXRpYyB2b2lk
IHRjZ19jcHVfcmVzZXRfaG9sZChDUFVTdGF0ZSAqY3B1KQ0KPiAgIHsNCj4gLSAgICB0Y2df
Zmx1c2hfam1wX2NhY2hlKGNwdSk7DQo+ICsgICAgdGNnX2V4ZWNfcmVzZXQoY3B1KTsNCj4g
ICANCj4gICAgICAgdGxiX2ZsdXNoKGNwdSk7DQo+ICAgfQ0KDQpSZXZpZXdlZC1ieTogUGll
cnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

