Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF016D18157
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 00:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0VLC-00007w-B8; Mon, 14 Oct 2024 20:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VL7-00007b-Gl
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:23:05 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t0VL4-0004o7-Ik
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 20:23:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20c77459558so37246005ad.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 17:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728951780; x=1729556580; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zlxhOEgZgA50nLiLvJQGLETnKCDbLSysUcQzpuDgoDk=;
 b=vKXBuV0LhsaF8mqynX6TNguvtqVhycWnQZJe9tcwj+mJoUHOVWCvVhxoCLf38lJCy7
 BY0U6Pac0/iYvTbthQCDY3efEF+Y217KCu8hYjvfFW8OdQHVjlxQyjbEbtkvOrJ8yE44
 i3iPOGx6rgfhElBhmnzm6s5do8v49V54tOuLKF5C34nteQLQChewxvbdHgL8zApbc1QH
 AvEvqlbZzoyvonGCOqFwL8DBo2+rN9+2PoRBBdo4jCRfhzEH+M+nIVof4y3VbSwUicvP
 2PtanTiveC96pQCsuV3PyHbabnBjI+emQnrPORwvQTo+hR4nrvyhMB2D040oQELNquJU
 T12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728951780; x=1729556580;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zlxhOEgZgA50nLiLvJQGLETnKCDbLSysUcQzpuDgoDk=;
 b=iC3+KP0ETj1ERvgGH53dBLvLkqMj9wigaCcAGIZmuHLfOzim2wQtlBUZlUjeJBFXTu
 TlE0VrjDPtVUWHS/a03aPSev2NJHTeJLURALbXRx1YMi0ayLmJI5C+ftWkOkgu0Fd6NX
 JBZ1aCk5KwU+R6vNyG24l+ggKoQKXR6NqliNm5mnAQuvpFMuckt3HLuNBEYaD2YSifHY
 nsWaZ0B+NQRpgS58El+mHfFW8jcGSqy6Z81cz8/3m0mI3+NMjBXHLTCJlF7ljQlvJA+p
 k3rVFpupmtwQ+T+Y++gpXBhwvssuGJ1FvWRaMk0AQg5Xd0rumX2cmxBIaTSFreq6zYqp
 kXcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCdZbq5f9oz9F857BzDtA3Bu4dKTSmScuakedKdYbJ5S1UfWCGEavp5B//lue215P0OslQB6OjkF0P@nongnu.org
X-Gm-Message-State: AOJu0YzmKaI9kAIyeNLzha2sk+eMg5wKksupm+GBHo0XwVcoL41pQu1q
 N642dNoCh3jPATDqElz8PLr9uJn5Yg0gxPYfTOS2LjlYvMtsFhf/b5fyK4R2u6iz4M6cMUyAwvu
 lSy0Ltw==
X-Google-Smtp-Source: AGHT+IGCiOlkVfDeggaC5+v0yY3dr1CtK2AFyRI3rZFQVtIXyQhi7lQxEBTj4u7HacURYfPbvxJqtg==
X-Received: by 2002:a17:903:2bce:b0:20b:7c00:5e50 with SMTP id
 d9443c01a7336-20ca144ac39mr163216325ad.12.1728951779939; 
 Mon, 14 Oct 2024 17:22:59 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d17f84dddsm1230575ad.42.2024.10.14.17.22.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2024 17:22:59 -0700 (PDT)
Message-ID: <53a01137-d47a-481c-a72c-7092c12dd7e3@linaro.org>
Date: Mon, 14 Oct 2024 17:22:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] include/exec: Improve probe_access_full{, _mmu}
 documentation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241013184733.1423747-1-richard.henderson@linaro.org>
 <20241013184733.1423747-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241013184733.1423747-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

T24gMTAvMTMvMjQgMTE6NDcsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBTdWdnZXN0
ZWQtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gU2lnbmVk
LW9mZi1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+DQo+IC0tLQ0KPiAgIGluY2x1ZGUvZXhlYy9leGVjLWFsbC5oIHwgMjkgKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9leGVj
L2V4ZWMtYWxsLmggYi9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiBpbmRleCA3MjI0MGVm
NDI2Li4yZTRjNGNjNGI0IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwu
aA0KPiArKysgYi9pbmNsdWRlL2V4ZWMvZXhlYy1hbGwuaA0KPiBAQCAtMzY4LDYgKzM2OCwx
MyBAQCBpbnQgcHJvYmVfYWNjZXNzX2ZsYWdzKENQVUFyY2hTdGF0ZSAqZW52LCB2YWRkciBh
ZGRyLCBpbnQgc2l6ZSwNCj4gICAgKiBUaGUgQ1BVVExCRW50cnlGdWxsIHN0cnVjdHVyZSBy
ZXR1cm5lZCB2aWEgQHBmdWxsIGlzIHRyYW5zaWVudA0KPiAgICAqIGFuZCBtdXN0IGJlIGNv
bnN1bWVkIG9yIGNvcGllZCBpbW1lZGlhdGVseSwgYmVmb3JlIGFueSBmdXJ0aGVyDQo+ICAg
ICogYWNjZXNzIG9yIGNoYW5nZXMgdG8gVExCIEBtbXVfaWR4Lg0KPiArICoNCj4gKyAqIFRo
aXMgZnVuY3Rpb24gd2lsbCBub3QgZmF1bHQgaWYgQG5vbmZhdWx0IGlzIHNldCwgYnV0IHdp
bGwNCj4gKyAqIHJldHVybiBUTEJfSU5WQUxJRF9NQVNLIGlmIHRoZSBwYWdlIGlzIG5vdCBt
YXBwZWQsIG9yIGlzIG5vdA0KPiArICogYWNjZXNzaWJsZSB3aXRoIEBhY2Nlc3NfdHlwZS4N
Cj4gKyAqDQo+ICsgKiBUaGlzIGZ1bmN0aW9uIHdpbGwgcmV0dXJuIFRMQl9NTUlPIGluIG9y
ZGVyIHRvIGZvcmNlIHRoZSBhY2Nlc3MNCj4gKyAqIHRvIGJlIGhhbmRsZWQgb3V0LW9mLWxp
bmUgaWYgcGx1Z2lucyB3aXNoIHRvIGluc3RydW1lbnQgdGhlIGFjY2Vzcy4NCj4gICAgKi8N
Cj4gICBpbnQgcHJvYmVfYWNjZXNzX2Z1bGwoQ1BVQXJjaFN0YXRlICplbnYsIHZhZGRyIGFk
ZHIsIGludCBzaXplLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBNTVVBY2Nlc3NUeXBl
IGFjY2Vzc190eXBlLCBpbnQgbW11X2lkeCwNCj4gQEAgLTM3NSwyMiArMzgyLDE0IEBAIGlu
dCBwcm9iZV9hY2Nlc3NfZnVsbChDUFVBcmNoU3RhdGUgKmVudiwgdmFkZHIgYWRkciwgaW50
IHNpemUsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgIENQVVRMQkVudHJ5RnVsbCAqKnBm
dWxsLCB1aW50cHRyX3QgcmV0YWRkcik7DQo+ICAgDQo+ICAgLyoqDQo+IC0gKiBwcm9iZV9h
Y2Nlc3NfbW11KCkgLSBMaWtlIHByb2JlX2FjY2Vzc19mdWxsIGV4Y2VwdCBjYW5ub3QgZmF1
bHQgYW5kDQo+IC0gKiBkb2Vzbid0IHRyaWdnZXIgaW5zdHJ1bWVudGF0aW9uLg0KPiArICog
cHJvYmVfYWNjZXNzX2Z1bGxfbW11Og0KPiArICogTGlrZSBwcm9iZV9hY2Nlc3NfZnVsbCwg
ZXhjZXB0Og0KPiAgICAqDQo+IC0gKiBAZW52OiBDUFVBcmNoU3RhdGUNCj4gLSAqIEB2YWRk
cjogdmlydHVhbCBhZGRyZXNzIHRvIHByb2JlDQo+IC0gKiBAc2l6ZTogc2l6ZSBvZiB0aGUg
cHJvYmUNCj4gLSAqIEBhY2Nlc3NfdHlwZTogcmVhZCwgd3JpdGUgb3IgZXhlY3V0ZSBwZXJt
aXNzaW9uDQo+IC0gKiBAbW11X2lkeDogc29mdG1tdSBpbmRleA0KPiAtICogQHBob3N0OiBw
dHIgdG8gcmV0dXJuIHZhbHVlIGhvc3QgYWRkcmVzcyBvciBOVUxMDQo+IC0gKiBAcGZ1bGw6
IHB0ciB0byByZXR1cm4gdmFsdWUgQ1BVVExCRW50cnlGdWxsIHN0cnVjdHVyZSBvciBOVUxM
DQo+IC0gKg0KPiAtICogVGhlIENQVVRMQkVudHJ5RnVsbCBzdHJ1Y3R1cmUgcmV0dXJuZWQg
dmlhIEBwZnVsbCBpcyB0cmFuc2llbnQNCj4gLSAqIGFuZCBtdXN0IGJlIGNvbnN1bWVkIG9y
IGNvcGllZCBpbW1lZGlhdGVseSwgYmVmb3JlIGFueSBmdXJ0aGVyDQo+IC0gKiBhY2Nlc3Mg
b3IgY2hhbmdlcyB0byBUTEIgQG1tdV9pZHguDQo+IC0gKg0KPiAtICogUmV0dXJuczogVExC
IGZsYWdzIGFzIHBlciBwcm9iZV9hY2Nlc3NfZmxhZ3MoKQ0KPiArICogVGhpcyBmdW5jdGlv
biBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIGZvciBwYWdlIHRhYmxlIGFjY2Vzc2VzIGJ5DQo+
ICsgKiB0aGUgdGFyZ2V0IG1tdSBpdHNlbGYuICBTaW5jZSBzdWNoIHBhZ2Ugd2Fsa2luZyBo
YXBwZW5zIHdoaWxlDQo+ICsgKiBoYW5kbGluZyBhbm90aGVyIHBvdGVudGlhbCBtbXUgZmF1
bHQsIHRoaXMgZnVuY3Rpb24gbmV2ZXIgcmFpc2VzDQo+ICsgKiBleGNlcHRpb25zIChha2lu
IHRvIEBub25mYXVsdCB0cnVlIGZvciBwcm9iZV9hY2Nlc3NfZnVsbCkuDQo+ICsgKiBMaWtl
d2lzZSB0aGlzIGZ1bmN0aW9uIGRvZXMgbm90IHRyaWdnZXIgcGx1Z2luIGluc3RydW1lbnRh
dGlvbi4NCj4gICAgKi8NCj4gICBpbnQgcHJvYmVfYWNjZXNzX2Z1bGxfbW11KENQVUFyY2hT
dGF0ZSAqZW52LCB2YWRkciBhZGRyLCBpbnQgc2l6ZSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIE1NVUFjY2Vzc1R5cGUgYWNjZXNzX3R5cGUsIGludCBtbXVfaWR4LA0KDQpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8u
b3JnPg0K

