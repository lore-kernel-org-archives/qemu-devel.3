Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD960CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzid-000369-Q8; Wed, 18 Sep 2024 14:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzic-00035g-Od
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:48:02 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzia-0003bZ-Mt
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:48:01 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-206e614953aso1064265ad.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726685279; x=1727290079; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3rIwzAtOzwxNDXOgh/H5/QMlTQaEXIDY2xRDuWOumn0=;
 b=uEZpqLHzYTMPLszUtEXuS9I8Tra0l3ly15usVkd5AS/06T+SAVFFPjlaQmaNxH2O1W
 9FLSwsH9Z8mVzfw7p2vFIKCaU548yp5X07vzlY/WnnWaAJIGfzwHQ1qQF2AAAtSaVZZ6
 TpeIZ9Efu5VD/GoWH2EDcHHVZocy0j5MgIXzj8sbups9uQsHx0NNkw5PKTNszWsPPFJj
 vGCTj/uUNhcCJumOGAXC/1WgJCxEki72WqoPMlXbcUj/rWzvxiEVR4y8RdiVddNZM5Vf
 UP8Y3dEt+SK/uDkvu4lyu43SwIsvVqUuD8Sks/YyaU5G7sYISn4r28HOTrTkN+Bv2YlS
 CEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726685279; x=1727290079;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3rIwzAtOzwxNDXOgh/H5/QMlTQaEXIDY2xRDuWOumn0=;
 b=VZqJpEa7Rgt06a/fSKb1x7By6CEFZ+C2ffXClhGAdTpdohGZEDlEIzMdVRpjQrwe81
 aG4DoAbczhvitbXReVUuUfqvVR89AcSXxAJKJomQY35Q6LZDTiE+vFoLhyMBIka+yM1e
 jHm0/00UU//8HXCWpR8ukeqGzzDnguRyf5Rspjt7N+pCua7hAqor6NytTG6Dq0PPJ/xa
 NeUj81HKNfa2+DMOsSFgVtQyJC8KwpS8CinasTuDgfRKUoS226hLn0oh0svEnz2TynkX
 iODC7PW+a29NxTbmfVGKdhW+PXhyuY0tnkvzKP04aSCJOe2BCzv3oMvLOcFneaC+LQLi
 AsDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9BxwV8k0NF4LLJuJN+w0gXVBEdFC7lCjB1VbZ+Q3s4Dldrt+TOBzn5vp3rGaZ3g0rHTquOTRkd/nr@nongnu.org
X-Gm-Message-State: AOJu0YyeWFXyM+5dwyIbpwR+c66iICovzZsud2rvkZa4RxjgbvnTW0KT
 Lfok7MnySFjiZjIwQ4qfMqJlu3W/cUk1/x632jgeUkotYag7088MzilT7eyyxPRAcIvnSVkSoGQ
 DKvvaNw==
X-Google-Smtp-Source: AGHT+IFvJd9jA+AtqJJNTb8pbEwWdpnAxHaeSADc+bBVgZz/OKV3PVM9Exqo2FG0wiiMS1GV2VIMcA==
X-Received: by 2002:a17:902:e742:b0:207:18f5:7e78 with SMTP id
 d9443c01a7336-2076e43ccfamr310959575ad.48.1726685279001; 
 Wed, 18 Sep 2024 11:47:59 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2079473634esm68389865ad.262.2024.09.18.11.47.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 11:47:58 -0700 (PDT)
Message-ID: <b039deb6-06cf-4445-9510-7e188629d77f@linaro.org>
Date: Wed, 18 Sep 2024 11:47:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] contrib/plugins: avoid hanging program
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Elisha Hollander
 <just4now666666@gmail.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240913173807.189747-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240913173807.189747-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gOS8xMy8yNCAxMDozOCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBBbHRob3VnaCB3ZSBh
c2tzIGZvciBpbnN0cnVjdGlvbnMgcGVyIHNlY29uZCB3ZSB3b3JrIGluIHF1YW50YSBhbmQN
Cj4gdGhhdCBjYW5ub3QgYmUgMC4gRmFpbCB0byBsb2FkIHRoZSBwbHVnaW4gaW5zdGVhZCBh
bmQgcmVwb3J0IHRoZQ0KPiBtaW5pbXVtIElQUyB3ZSBjYW4gaGFuZGxlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBS
ZXBvcnRlZC1ieTogRWxpc2hhIEhvbGxhbmRlciA8anVzdDRub3c2NjY2NjZAZ21haWwuY29t
Pg0KPiAtLS0NCj4gICBjb250cmliL3BsdWdpbnMvaXBzLmMgfCA1ICsrKysrDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRy
aWIvcGx1Z2lucy9pcHMuYyBiL2NvbnRyaWIvcGx1Z2lucy9pcHMuYw0KPiBpbmRleCAyOWZh
NTU2ZDBmLi42ZjA3ODY4OWRjIDEwMDY0NA0KPiAtLS0gYS9jb250cmliL3BsdWdpbnMvaXBz
LmMNCj4gKysrIGIvY29udHJpYi9wbHVnaW5zL2lwcy5jDQo+IEBAIC0xNTIsNiArMTUyLDEx
IEBAIFFFTVVfUExVR0lOX0VYUE9SVCBpbnQgcWVtdV9wbHVnaW5faW5zdGFsbChxZW11X3Bs
dWdpbl9pZF90IGlkLA0KPiAgICAgICB2Y3B1cyA9IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmRf
bmV3KHNpemVvZih2Q1BVVGltZSkpOw0KPiAgICAgICBtYXhfaW5zbl9wZXJfcXVhbnR1bSA9
IG1heF9pbnNuX3Blcl9zZWNvbmQgLyBOVU1fVElNRV9VUERBVEVfUEVSX1NFQzsNCj4gICAN
Cj4gKyAgICBpZiAobWF4X2luc25fcGVyX3F1YW50dW0gPT0gMCkgew0KPiArICAgICAgICBm
cHJpbnRmKHN0ZGVyciwgIm1pbmltdW0gb2YgJWQgaW5zdHJ1Y3Rpb25zIHBlciBzZWNvbmQg
bmVlZGVkXG4iLCBOVU1fVElNRV9VUERBVEVfUEVSX1NFQyk7DQo+ICsgICAgICAgIHJldHVy
biAtMTsNCj4gKyAgICB9DQo+ICsNCj4gICAgICAgdGltZV9oYW5kbGUgPSBxZW11X3BsdWdp
bl9yZXF1ZXN0X3RpbWVfY29udHJvbCgpOw0KPiAgICAgICBnX2Fzc2VydCh0aW1lX2hhbmRs
ZSk7DQo+ICAgDQoNClRoZSBpcHMgcGx1Z2luIHVzZXMgdGIgYmFzZWQgdHJhcCwgc28gaXQg
c2hvdWxkIG5vdCBiZSBleHBlY3RlZCB0aGF0IGFuIA0KaXBzIG9mIDEgd2lsbCBkbyB3aGF0
IGlzIGV4cGVjdGVkIChpdCB3aWxsIGV4ZWN1dGUgdGhlIHdob2xlIHRiIGF0IG1pbmltdW0p
Lg0KDQpFaXRoZXIgd2UgY291bGQgZXh0ZW5kIHRoaXMgcGx1Z2luIHdpdGggYSBwcmVjaXNl
IG1vZGUgKGluc3RydWN0aW9uIA0KYmFzZWQpLCBvciBzaW1wbHkgZW1pdCBhbiBlcnJvciB3
aGVuIGlwcyBpcyB0b28gbG93LCBsaWtlIDwgMTAwLg0KSSdtIG1vcmUgaW4gZmF2b3Igb2Yg
dGhlIGxhdHRlciBzb2x1dGlvbi4NCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

