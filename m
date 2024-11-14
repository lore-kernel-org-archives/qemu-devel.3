Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC18D41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRG3-0006WF-1Z; Wed, 13 Nov 2024 23:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRFs-00068Q-KR
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:14:55 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRFr-00046b-0N
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:14:52 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-288fa5ce8f0so94498fac.3
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557690; x=1732162490; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mOhtsNykJRrnEBy3hcLvcYZQqGiuqjCQTRDZ9B0NrNA=;
 b=sDcwFlsRu83ByUyK/ftMSCO6jpUe2vkWziZaRvD98n6CLF4XB2KucAGeqO4hP6edYI
 3uVIcdbRa/cFE+CzZqpvpwv0nTU0dPoJ8y/RZMfSFcktKUEZKxLBeFMJmVRfNHxZ+xGA
 PDy+wPk4swKnHJT9LBEFn1ynTZ3RisgV4OMOlsku8Pms/0uO0014pAUo+fr5I/ZiB6M9
 r1rbAYxlfMfPbu1Zb211KgFa8BGOsC8OT91tjRwFGfRcaBbTER3CDvTQNiPi9BSaGUnW
 hxUFPEzW7lPsO09XSttBakayyeE6szFBrI5Q+6Vo/n76cJEZGdaFqfCYm8BNLiMNL/FT
 C0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557690; x=1732162490;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mOhtsNykJRrnEBy3hcLvcYZQqGiuqjCQTRDZ9B0NrNA=;
 b=cOKt4d+6brGa3RVvDJf8BZJSxr+V9M7wLRxzMrfu4GWptwAl0i0p20kjerRlhfjENv
 v6Av4pfaEU3sUAfc7IbacBF18ZwYJuVztPTAN5l2/l5a4Mu54Fpf+ZsJDThHYNcG13mn
 zVUY8M8qQHJ+4NvWIortDmn6orIFahrDICwrSDYotJVRBGosRppm/FLscLwazdvf8uhO
 kryVE8WPHUSO20hlG2yGSLCZbPO9ftDvOLStmOnRwnfrmRkeeVpH0NOstKMpII+Adddx
 xvVSVWjSPsSaD1zjyPaPP9HeYfWYVRDbG7dWM8hyjXeVrhK8DLgw41hxRiOf0vZ4Fz/3
 M0Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO7R5R0G0nRpM9idwTWXxGsn763rt5DI3NK9w4MWNW9iZR/vwDDVAH1DIt6Nq7P7rwLwbVOlf0XnsY@nongnu.org
X-Gm-Message-State: AOJu0YzGGyOtkcJi3fB0JHFbLQxFRiFc+wyUlbFcE5i2vAxSMi6vxFgu
 Us+Dgv0tpJrqLTdKaBmO6u2qugN6DtD+dcRD9SXJLIgooetovyeUE9V/AYI6XEA=
X-Google-Smtp-Source: AGHT+IHkTVoebjq8Ld4e52DaNFO/rOcHB0iPOfGlk+293Xm1RnZ9Rq0SK6xRyogxBaYoRmL02pzjkw==
X-Received: by 2002:a05:6871:284:b0:287:0:9ecc with SMTP id
 586e51a60fabf-296107bba00mr780084fac.33.1731557689917; 
 Wed, 13 Nov 2024 20:14:49 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39d0773sm137842a12.83.2024.11.13.20.14.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:14:48 -0800 (PST)
Message-ID: <0b94aed9-b024-4ee8-8800-87f6432ae989@linaro.org>
Date: Wed, 13 Nov 2024 20:14:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] exec: Declare tlb_hit*() in 'exec/cputlb.h'
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
 <20241114011310.3615-20-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x31.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gTW92ZSBDUFUgVExCIHJlbGF0ZWQgbWV0aG9kcyB0byAiZXhlYy9jcHV0bGIuaCIuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9jcHUtYWxsLmggfCAyMyAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFjY2VsL3RjZy9jcHV0bGIuYyAgICAgfCAyMyAr
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0
aW9ucygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9l
eGVjL2NwdS1hbGwuaCBiL2luY2x1ZGUvZXhlYy9jcHUtYWxsLmgNCj4gaW5kZXggMWM4ZTA0
NDZkMC4uY2NhYTY1MGIxOSAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9leGVjL2NwdS1hbGwu
aA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvY3B1LWFsbC5oDQo+IEBAIC0zMjMsMjkgKzMyMyw2
IEBAIHN0YXRpYyBpbmxpbmUgaW50IGNwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29s
IGlmZXRjaCkNCj4gICAvKiBUaGUgdHdvIHNldHMgb2YgZmxhZ3MgbXVzdCBub3Qgb3Zlcmxh
cC4gKi8NCj4gICBRRU1VX0JVSUxEX0JVR19PTihUTEJfRkxBR1NfTUFTSyAmIFRMQl9TTE9X
X0ZMQUdTX01BU0spOw0KPiAgIA0KPiAtLyoqDQo+IC0gKiB0bGJfaGl0X3BhZ2U6IHJldHVy
biB0cnVlIGlmIHBhZ2UgYWxpZ25lZCBAYWRkciBpcyBhIGhpdCBhZ2FpbnN0IHRoZQ0KPiAt
ICogVExCIGVudHJ5IEB0bGJfYWRkcg0KPiAtICoNCj4gLSAqIEBhZGRyOiB2aXJ0dWFsIGFk
ZHJlc3MgdG8gdGVzdCAobXVzdCBiZSBwYWdlIGFsaWduZWQpDQo+IC0gKiBAdGxiX2FkZHI6
IFRMQiBlbnRyeSBhZGRyZXNzIChhIENQVVRMQkVudHJ5IGFkZHJfcmVhZC93cml0ZS9jb2Rl
IHZhbHVlKQ0KPiAtICovDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgdGxiX2hpdF9wYWdlKHVp
bnQ2NF90IHRsYl9hZGRyLCB2YWRkciBhZGRyKQ0KPiAtew0KPiAtICAgIHJldHVybiBhZGRy
ID09ICh0bGJfYWRkciAmIChUQVJHRVRfUEFHRV9NQVNLIHwgVExCX0lOVkFMSURfTUFTSykp
Ow0KPiAtfQ0KPiAtDQo+IC0vKioNCj4gLSAqIHRsYl9oaXQ6IHJldHVybiB0cnVlIGlmIEBh
ZGRyIGlzIGEgaGl0IGFnYWluc3QgdGhlIFRMQiBlbnRyeSBAdGxiX2FkZHINCj4gLSAqDQo+
IC0gKiBAYWRkcjogdmlydHVhbCBhZGRyZXNzIHRvIHRlc3QgKG5lZWQgbm90IGJlIHBhZ2Ug
YWxpZ25lZCkNCj4gLSAqIEB0bGJfYWRkcjogVExCIGVudHJ5IGFkZHJlc3MgKGEgQ1BVVExC
RW50cnkgYWRkcl9yZWFkL3dyaXRlL2NvZGUgdmFsdWUpDQo+IC0gKi8NCj4gLXN0YXRpYyBp
bmxpbmUgYm9vbCB0bGJfaGl0KHVpbnQ2NF90IHRsYl9hZGRyLCB2YWRkciBhZGRyKQ0KPiAt
ew0KPiAtICAgIHJldHVybiB0bGJfaGl0X3BhZ2UodGxiX2FkZHIsIGFkZHIgJiBUQVJHRVRf
UEFHRV9NQVNLKTsNCj4gLX0NCj4gLQ0KPiAgICNlbmRpZiAvKiAhQ09ORklHX1VTRVJfT05M
WSAqLw0KPiAgIA0KPiAgIC8qIFZhbGlkYXRlIGNvcnJlY3QgcGxhY2VtZW50IG9mIENQVUFy
Y2hTdGF0ZS4gKi8NCj4gZGlmZiAtLWdpdCBhL2FjY2VsL3RjZy9jcHV0bGIuYyBiL2FjY2Vs
L3RjZy9jcHV0bGIuYw0KPiBpbmRleCAwODBjYmNiMzRkLi5kYmE0ODMxY2QxIDEwMDY0NA0K
PiAtLS0gYS9hY2NlbC90Y2cvY3B1dGxiLmMNCj4gKysrIGIvYWNjZWwvdGNnL2NwdXRsYi5j
DQo+IEBAIC0xMjIwLDYgKzEyMjAsMjkgQEAgdm9pZCB0bGJfc2V0X3BhZ2UoQ1BVU3RhdGUg
KmNwdSwgdmFkZHIgYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJv
dCwgbW11X2lkeCwgc2l6ZSk7DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiB0bGJfaGl0
X3BhZ2U6IHJldHVybiB0cnVlIGlmIHBhZ2UgYWxpZ25lZCBAYWRkciBpcyBhIGhpdCBhZ2Fp
bnN0IHRoZQ0KPiArICogVExCIGVudHJ5IEB0bGJfYWRkcg0KPiArICoNCj4gKyAqIEBhZGRy
OiB2aXJ0dWFsIGFkZHJlc3MgdG8gdGVzdCAobXVzdCBiZSBwYWdlIGFsaWduZWQpDQo+ICsg
KiBAdGxiX2FkZHI6IFRMQiBlbnRyeSBhZGRyZXNzIChhIENQVVRMQkVudHJ5IGFkZHJfcmVh
ZC93cml0ZS9jb2RlIHZhbHVlKQ0KPiArICovDQo+ICtzdGF0aWMgaW5saW5lIGJvb2wgdGxi
X2hpdF9wYWdlKHVpbnQ2NF90IHRsYl9hZGRyLCB2YWRkciBhZGRyKQ0KPiArew0KPiArICAg
IHJldHVybiBhZGRyID09ICh0bGJfYWRkciAmIChUQVJHRVRfUEFHRV9NQVNLIHwgVExCX0lO
VkFMSURfTUFTSykpOw0KPiArfQ0KPiArDQo+ICsvKioNCj4gKyAqIHRsYl9oaXQ6IHJldHVy
biB0cnVlIGlmIEBhZGRyIGlzIGEgaGl0IGFnYWluc3QgdGhlIFRMQiBlbnRyeSBAdGxiX2Fk
ZHINCj4gKyAqDQo+ICsgKiBAYWRkcjogdmlydHVhbCBhZGRyZXNzIHRvIHRlc3QgKG5lZWQg
bm90IGJlIHBhZ2UgYWxpZ25lZCkNCj4gKyAqIEB0bGJfYWRkcjogVExCIGVudHJ5IGFkZHJl
c3MgKGEgQ1BVVExCRW50cnkgYWRkcl9yZWFkL3dyaXRlL2NvZGUgdmFsdWUpDQo+ICsgKi8N
Cj4gK3N0YXRpYyBpbmxpbmUgYm9vbCB0bGJfaGl0KHVpbnQ2NF90IHRsYl9hZGRyLCB2YWRk
ciBhZGRyKQ0KPiArew0KPiArICAgIHJldHVybiB0bGJfaGl0X3BhZ2UodGxiX2FkZHIsIGFk
ZHIgJiBUQVJHRVRfUEFHRV9NQVNLKTsNCj4gK30NCj4gKw0KPiAgIC8qDQo+ICAgICogTm90
ZTogdGxiX2ZpbGxfYWxpZ24oKSBjYW4gdHJpZ2dlciBhIHJlc2l6ZSBvZiB0aGUgVExCLg0K
PiAgICAqIFRoaXMgbWVhbnMgdGhhdCBhbGwgb2YgdGhlIGNhbGxlcidzIHByaW9yIHJlZmVy
ZW5jZXMgdG8gdGhlIFRMQiB0YWJsZQ0KDQpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0KDQo=

