Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2FCC27C77
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 17:37:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sIAr3-0003Wo-8o; Fri, 14 Jun 2024 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sIAr1-0003W0-Ka
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:36:47 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sIAr0-0007am-1A
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 13:36:47 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3d21ebe1c3aso1278120b6e.1
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718386604; x=1718991404; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1LimRJM9cxSX2f5sFmiGnpuaZ10TrsMotLuL6FGbbKo=;
 b=DubwS6Y3td0CTof+4UsHJpHYfZPdSLP3T1pfYkgy3RoKqyPCEo08C4FO56X7/0XKZe
 irNvOOZ2veuJdKd7DNNAdXm/pq1mVoRfx67Zk083nMjakTyA6anMz5TT/uDFqAHXU7Vm
 jdiF089z+/TEyOsE544VYEuWxo3lYamSnuC0f/X/57GifCZQlQdYugeCdyXGWLQhUCW3
 i716cLm4mV7cudFPfjNIrRciv0I0hU25X0ElZr0Q6ZB2rqATwjtuqROMk/1gt4iX08Om
 WOaUWt1MP0aVj4A+rwzgctDsY95G2tkMVuLn0Wd+a4ilaU7Z9vY8Q8Udp6sUaeLhZYVi
 hM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718386604; x=1718991404;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1LimRJM9cxSX2f5sFmiGnpuaZ10TrsMotLuL6FGbbKo=;
 b=g7qWgX3Qxh9sDcykS7eEatd5pybCvDwWM92BL82+qM8mKL2xq4ncjQPnIRZdOjSP5a
 08SpkF9pHW49gMRdxUwdqtQTEjrgK3t8R/8FKGg5LTbuJ0meWnhq2fVtkNzs44O2QM0c
 fXuJCHfgyqUIcN1Po+0FSUVjL01ZoNDlowTrENAekvX96Ysuht1hdlTehY8E4YoklRsm
 xxQUnG+D2ZvnQEcL3FZ1G55N1770sm7iOPLRcHDhfan0zNknkvkUGpYfRF3bJCO0Gz32
 47A7CqTz8yzwpwI3BfifGETVV3RyrAEQusPbEt6Fz0TwF6frSU55z+vEZ/NqjEAPuwGi
 QEMQ==
X-Gm-Message-State: AOJu0Yzocoh4kv3CoXuypkzQflqhIDlPCJfWY9HBUFdwtgADPjmWP5Xe
 VuXPyk8aVOE46qeyqDU+AVpiLao26DcwpDFXSp0xpx/RKEDTZE64m5wPaa+tBIs=
X-Google-Smtp-Source: AGHT+IFqp54QBTCWDMIIVSm8l3m8LBnykdkXpasQW4hnt2Hq/DpO3ONARm3we9JumapgK+vz7R3LgQ==
X-Received: by 2002:a05:6870:4194:b0:254:b1b1:7ea5 with SMTP id
 586e51a60fabf-25842af7079mr4304081fac.37.1718386604036; 
 Fri, 14 Jun 2024 10:36:44 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-705cc91ed6asm3308225b3a.39.2024.06.14.10.36.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Jun 2024 10:36:43 -0700 (PDT)
Message-ID: <2812da25-495c-4356-a230-257ea96e6dcc@linaro.org>
Date: Fri, 14 Jun 2024 10:36:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] plugins: add time control API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-9-alex.bennee@linaro.org>
 <c4d36875-c70d-4e2c-b3a8-c50459c9db0f@linaro.org>
 <87r0d0vnt8.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87r0d0vnt8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x229.google.com
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

T24gNi8xMy8yNCAwODo1NiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAxMi82
LzI0IDE3OjM1LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+Pj4gRXhwb3NlIHRoZSBhYmlsaXR5
IHRvIGNvbnRyb2wgdGltZSB0aHJvdWdoIHRoZSBwbHVnaW4gQVBJLiBPbmx5IG9uZQ0KPj4+
IHBsdWdpbiBjYW4gY29udHJvbCB0aW1lIHNvIGl0IGhhcyB0byByZXF1ZXN0IGNvbnRyb2wg
d2hlbiBsb2FkZWQuDQo+Pj4gVGhlcmUgYXJlIHByb2JhYmx5IG1vcmUgY29ybmVyIGNhc2Vz
IHRvIGNhdGNoIGhlcmUuDQo+Pj4gRnJvbTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBs
aW5hcm8ub3JnPg0KPj4NCj4+IFNvbWUgb2YgeW91ciBwYXRjaGVzIGluY2x1ZGUgdGhpcyBk
dWJpb3VzIEZyb206IGhlYWRlciwgbWF5YmUgc3RyaXA/DQo+IA0KPiBJIHRoaW5rIGJlY2F1
c2UgbXkgb3JpZ2luYWwgUkZDIHBhdGNoZXMgd2VudCB2aWEgUGllcnJpY2sgYmVmb3JlIHB1
bGxpbmcNCj4gYmFjayBpbnRvIG15IHRyZWUuIEkgY2FuIGNsZWFuIHRob3NlIHVwLg0KPiAN
Cg0KVG8gYmUgaG9uZXN0LCBJIGRvbid0IHJlbWVtYmVyIHdoeSBJIGFkZGVkIHRob3NlLiBF
aXRoZXIgSSBzYXcgdGhhdCBpbiANCmFub3RoZXIgc2VyaWVzLCBvciBpdCB3YXMgYXNrZWQg
ZXhwbGljaXRlbHksIGJ1dCB5b3UgY2FuIHJlbW92ZSB0aGlzIGZvciANCnN1cmUuDQoNCj4+
DQo+Pj4gU2lnbmVkLW9mZi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmll
ckBsaW5hcm8ub3JnPg0KPj4+IFtBSkI6IHR3ZWFrZWQgdXNlci1tb2RlIGhhbmRsaW5nXQ0K
Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9y
Zz4NCj4+PiBNZXNzYWdlLUlkOiA8MjAyNDA1MzAyMjA2MTAuMTI0NTQyNC02LXBpZXJyaWNr
LmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiBwbHVnaW5zL25leHQNCj4+PiAg
ICAgLSBtYWtlIHFlbXVfcGx1Z2luX3VwZGF0ZV9ucyBhIE5PUCBpbiB1c2VyLW1vZGUNCj4+
PiAtLS0NCj4+PiAgICBpbmNsdWRlL3FlbXUvcWVtdS1wbHVnaW4uaCAgIHwgMjUgKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIHBsdWdpbnMvYXBpLmMgICAgICAgICAgICAg
ICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+ICAgIHBs
dWdpbnMvcWVtdS1wbHVnaW5zLnN5bWJvbHMgfCAgMiArKw0KPj4+ICAgIDMgZmlsZXMgY2hh
bmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPiANCg==

