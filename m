Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788EAC02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 16:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXjK7-0004gH-Jw; Tue, 14 Jan 2025 10:59:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXjK5-0004fZ-QQ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:59:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXjK3-0000a9-VZ
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 10:59:21 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-21675fd60feso126264005ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 07:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736870357; x=1737475157; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLZznskkzXSRKtNVVZoCcGQST3kE5+6Od+zNfUd3UH0=;
 b=YjuXObAZJCpMVxpEIgV+Nd0eWNHKys1z2UwTWvaQ2JshTsCtYHhP/gviF3fCrd0iex
 895TrPCIMhQntoJk1SOD7AtLfqqooQP1tgIGNM9Px+572CgUVOYD/qHQ5qCBv5nYf5y/
 nVgVb2KJKvSGORWYqyS4daOTihyhJCoMmYPmIHSi1ds3DmqIDyWVa67iXPyTnzTcKxAl
 xtlL0BJ7bqHqchtIs0nYtuSrhL22vic9AzWEY5R+Q6LwcyQmjSlpQpP6M+wghfVQPvic
 bd9BO+VXBEbgJzwMns6am5RdavLyv/OMQ2UIGkqD6NkKjKXm3J2mDXfbX3BCBKY4mEHK
 93WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736870357; x=1737475157;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLZznskkzXSRKtNVVZoCcGQST3kE5+6Od+zNfUd3UH0=;
 b=X4q9WiLlMwqSQVE99kyILTg/7G3ZM3MnVAQuEiksVAZXdLK4o9/3GlSXEf5+d5I8/q
 aKMdg6d989dThg39AIqqvcK6rb9uw9yQtTiOFtf/IqrnCSLEvL1dMH4F0NBYN64Zkmll
 Z7Ees/bd4evo8OPIxDtY9NtU14jrqUvp9oJ3DXGYia3LNxH6iKCJRTI5PT10M1IR8ywp
 WhSjNvC+jIoUNILUayUjHgD2AbYupWherNz2yEFAmsVFIBYsfwkkS19uFL0ZGVm6LVSQ
 yBABobbsJHStDYHDZxlaBfNkrxl70HQbfmGVYdIpvTmN7h2xZSRFd22J7jnrnVz5Pin0
 zdqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2eol7kLQ7Oq+GacLxGVmkxRE4k+HoAb5u6W1Zd+O2SZcjROU1hrnmWLkPP4CGHxyg0X1QHxHLqsjz@nongnu.org
X-Gm-Message-State: AOJu0Yz8IFF8N7XoUvN+fDI/0vwhpbiDQYtee8gH6cmtttrMezQDGOcQ
 lz4GneSdlrM9dJwbkDFnf/aSCuYCF+skVKndHkKIDmLVS1ebTzUK6Mcsh2tq28w=
X-Gm-Gg: ASbGnctMJK1TKrL/qtvqFnM5hgoCdaE/It27A8+wpU14A+D516n1wpJU3AK4RlCXacT
 RIFecpCLKCgv4D1HmMPX5dr/hsS5uResFypXXphRiFLuIHrZUA1VI2ivSfIFjATKn2QfofyAYKO
 iwi0Q6lzBhzeigouEiTzyv6iRWm37bvRu3E0+NDB6RpsUUvWQWkQ2CdX5MnokJ4Xd79bOK+VKfL
 P27aOQXoPDl6o+sUMAZvrEmcuKfIpAg80SkXNqnIAW1IOJ3v37NVVu6RT1RZ3IIBTmE0A==
X-Google-Smtp-Source: AGHT+IFEx4lsS8WhOAIz0bdjRlRamYcpwGSTFKt/CAJzagj38ZeKuQ9tBq4IZSG9iOImMbhEYd6qhQ==
X-Received: by 2002:a17:90b:51c8:b0:2f4:4003:f3d4 with SMTP id
 98e67ed59e1d1-2f548f5f883mr36109795a91.30.1736870357153; 
 Tue, 14 Jan 2025 07:59:17 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f5593feaebsm9643204a91.13.2025.01.14.07.59.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 07:59:16 -0800 (PST)
Message-ID: <747a7717-81d5-4709-9b6b-6e4e9021c3c8@linaro.org>
Date: Tue, 14 Jan 2025 07:59:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] plugins: fix -Werror=maybe-uninitialized false-positive
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250114104820.2613099-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

SGkgTWFyYy1BbmRyw6ksDQoNCk9uIDEvMTQvMjUgMDI6NDgsIG1hcmNhbmRyZS5sdXJlYXVA
cmVkaGF0LmNvbSB3cm90ZToNCj4gRnJvbTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5k
cmUubHVyZWF1QHJlZGhhdC5jb20+DQo+IA0KPiAuLi9jb250cmliL3BsdWdpbnMvY2FjaGUu
Yzo2Mzg6OTogZXJyb3I6IOKAmGwyX2NhY2hl4oCZIG1heSBiZSB1c2VkIHVuaW5pdGlhbGl6
ZWQgWy1XZXJyb3I9bWF5YmUtdW5pbml0aWFsaXplZF0NCj4gICAgNjM4IHwgICAgICAgICBh
cHBlbmRfc3RhdHNfbGluZShyZXAsIGwxX2RtZW1fYWNjZXNzZXMsIGwxX2RtaXNzZXMsDQo+
ICAgICAgICB8ICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiANCj4gSXMgYSBmYWxzZS1wb3NpdGl2ZSwgc2luY2UgY29y
ZXMgPiAxLCBzbyB0aGUgdmFyaWFibGUgaXMgc2V0IGluIHRoZQ0KPiBhYm92ZSBsb29wLg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogTWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVy
ZWF1QHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAgIGNvbnRyaWIvcGx1Z2lucy9jYWNoZS5jIHwg
MiArLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5jIGIvY29udHJp
Yi9wbHVnaW5zL2NhY2hlLmMNCj4gaW5kZXggNTEyZWY2Nzc2Yi4uYzJjMjc0Y2ZjZCAxMDA2
NDQNCj4gLS0tIGEvY29udHJpYi9wbHVnaW5zL2NhY2hlLmMNCj4gKysrIGIvY29udHJpYi9w
bHVnaW5zL2NhY2hlLmMNCj4gQEAgLTYwOSw3ICs2MDksNyBAQCBzdGF0aWMgaW50IGwyX2Nt
cChnY29uc3Rwb2ludGVyIGEsIGdjb25zdHBvaW50ZXIgYikNCj4gICBzdGF0aWMgdm9pZCBs
b2dfc3RhdHModm9pZCkNCj4gICB7DQo+ICAgICAgIGludCBpOw0KPiAtICAgIENhY2hlICpp
Y2FjaGUsICpkY2FjaGUsICpsMl9jYWNoZTsNCj4gKyAgICBDYWNoZSAqaWNhY2hlLCAqZGNh
Y2hlLCAqbDJfY2FjaGUgPSBOVUxMOw0KPiAgIA0KPiAgICAgICBnX2F1dG9wdHIoR1N0cmlu
ZykgcmVwID0gZ19zdHJpbmdfbmV3KCJjb3JlICMsIGRhdGEgYWNjZXNzZXMsIGRhdGEgbWlz
c2VzLCINCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
IGRtaXNzIHJhdGUsIGluc24gYWNjZXNzZXMsIg0KDQpJdCBkb2VzIG5vdCBodXJ0IHRvIGlu
aXRpYWxpemUgaXQsIGV2ZW4gdGhvdWdoIGl0J3MgYSBmYWxzZSBwb3NpdGl2ZS4NClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQoNClRoYW5rcywNClBpZXJyaWNrDQo=

