Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C6DC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 19:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sED1C-0002PP-J1; Mon, 03 Jun 2024 15:06:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED1B-0002PD-Nb
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:06:53 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sED19-0000oZ-VU
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 15:06:53 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-6c4f3e0e3d2so242712a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 12:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717441610; x=1718046410; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSy3+HZdUVpRhXoT5tUTPpUwF3YUW62VGIcx2sj67eQ=;
 b=ueBC6F6CK7s3BOgQMra1G917u4tyucyXbq9nHe6OTHbt/CBcvJYWRUdae85Wuy/C5v
 O1L5WOu171RbPTdKFri/JEexdp0npsCROZDYMXTBSJ9IJetHgSMC4Esn3MHGYoXJiQVN
 Eguw1ifcQU6xarWIvUiEZ50FbfVu8ax1wSDy4mfToHxCO7UbAyrw4HQG03zRlXJMxt0U
 0BdHyQ8DhCgnWPlqEsRSrbBIGXKOvYRgelfqu4MqSqFM78flUzPVDBbcn0LsyI32oUII
 NFsNWoHuBxuT+/QKvmaIilDNkUeZNPpaqoi6uZj0Wue6ArUl/MsEsFjfm4c/oomUBQ2H
 nTGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717441610; x=1718046410;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QSy3+HZdUVpRhXoT5tUTPpUwF3YUW62VGIcx2sj67eQ=;
 b=NDHDT0+bHsLoDHX8ahChHlkbhK9pf/qLzuWXpV3nFOrAO3N12r4lmeaCK/PfNOmcta
 sWtxKsWioSddgEw85HrgsgvoRgqqkQtuRLhnzv+yCCayM7n9t0IdOLZMrlhqrFRVEBkL
 EOht/GctPcwY42xacvdcQ1CKIaA059+3wSGT6oYILaeOFVtGGsCBks2ffFUMsiDLvXrJ
 t4PlrgOJscGhSqutdByYC3NVNSHcq+chq4VUgFQfi+YhdtYbdBP/3BHwj8OjGu9ZScid
 7LVqZPa0HkPzVut1aWX0g95RTjUrSv6YpIRm4yB/LnuYV7aCJmHM4iVJ4hoRImDPKwA7
 YXoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXODU8LVCM/lGy6LtFZGrqrHnwVU/BwHfPYnz/60BY8Q4PBDHYmN+Q+dJJMlynotoVyfJdBxy70umB7aGy7v5OBDRISr+Y=
X-Gm-Message-State: AOJu0YyRYngnhwy77akFJETrs7sY50dWqyk+stEjWqgLRzV/t/Myv7j6
 pgm79UXjQ69WbCFKzaB1YdJLKOOR7iKVHfQHnuzIoNUMa9cpahZyvlhVjKGPWXA=
X-Google-Smtp-Source: AGHT+IEFQUQ5QrGjARibYQ8eBkbpd3+UL+xSijlsMQSY8/exlR7CqhFG7Uu1SbjKlQKWYn6/f36qXA==
X-Received: by 2002:a17:90b:83:b0:2bd:f751:e184 with SMTP id
 98e67ed59e1d1-2c1dc4b2c1bmr10386767a91.0.1717441610093; 
 Mon, 03 Jun 2024 12:06:50 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c1ac24c02dsm8132471a91.33.2024.06.03.12.06.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 12:06:49 -0700 (PDT)
Message-ID: <e36323d6-da91-40a5-82b5-316ddf13b601@linaro.org>
Date: Mon, 3 Jun 2024 12:06:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 25/27] hw/riscv/virt: Replace sprintf by g_strdup_printf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-26-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240412073346.458116-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

DQoNCk9uIDQvMTIvMjQgMDA6MzMsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBGcm9t
OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IA0KPiBz
cHJpbnRmKCkgaXMgZGVwcmVjYXRlZCBvbiBEYXJ3aW4gc2luY2UgbWFjT1MgMTMuMCAvIFhD
b2RlIDE0LjEuDQo+IFVzZSBnX3N0cmR1cF9wcmludGYgaW5zdGVhZC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4N
Cj4gTWVzc2FnZS1JZDogPDIwMjQwNDExMTA0MzQwLjY2MTctOC1waGlsbWRAbGluYXJvLm9y
Zz4NCj4gW3J0aDogVXNlIGdfc3RyZHVwX3ByaW50Zl0NCj4gU2lnbmVkLW9mZi1ieTogUmlj
aGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IC0tLQ0K
PiAgIGh3L3Jpc2N2L3ZpcnQuYyB8IDE3ICsrKysrKysrKy0tLS0tLS0tDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9ody9yaXNjdi92aXJ0LmMgYi9ody9yaXNjdi92aXJ0LmMNCj4gaW5kZXggZDE3
MWU3NGY3Yi4uNGZkYjY2MDUyNSAxMDA2NDQNCj4gLS0tIGEvaHcvcmlzY3YvdmlydC5jDQo+
ICsrKyBiL2h3L3Jpc2N2L3ZpcnQuYw0KPiBAQCAtMTYxNywxMCArMTYxNyw4IEBAIHN0YXRp
YyB2b2lkIHZpcnRfbWFjaGluZV9pbnN0YW5jZV9pbml0KE9iamVjdCAqb2JqKQ0KPiAgIHN0
YXRpYyBjaGFyICp2aXJ0X2dldF9haWFfZ3Vlc3RzKE9iamVjdCAqb2JqLCBFcnJvciAqKmVy
cnApDQo+ICAgew0KPiAgICAgICBSSVNDVlZpcnRTdGF0ZSAqcyA9IFJJU0NWX1ZJUlRfTUFD
SElORShvYmopOw0KPiAtICAgIGNoYXIgdmFsWzMyXTsNCj4gICANCj4gLSAgICBzcHJpbnRm
KHZhbCwgIiVkIiwgcy0+YWlhX2d1ZXN0cyk7DQo+IC0gICAgcmV0dXJuIGdfc3RyZHVwKHZh
bCk7DQo+ICsgICAgcmV0dXJuIGdfc3RyZHVwX3ByaW50ZigiJWQiLCBzLT5haWFfZ3Vlc3Rz
KTsNCj4gICB9DQo+ICAgDQo+ICAgc3RhdGljIHZvaWQgdmlydF9zZXRfYWlhX2d1ZXN0cyhP
YmplY3QgKm9iaiwgY29uc3QgY2hhciAqdmFsLCBFcnJvciAqKmVycnApDQo+IEBAIC0xNzQx
LDcgKzE3MzksNiBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVfZGV2aWNlX3BsdWdfY2Io
SG90cGx1Z0hhbmRsZXIgKmhvdHBsdWdfZGV2LA0KPiAgIA0KPiAgIHN0YXRpYyB2b2lkIHZp
cnRfbWFjaGluZV9jbGFzc19pbml0KE9iamVjdENsYXNzICpvYywgdm9pZCAqZGF0YSkNCj4g
ICB7DQo+IC0gICAgY2hhciBzdHJbMTI4XTsNCj4gICAgICAgTWFjaGluZUNsYXNzICptYyA9
IE1BQ0hJTkVfQ0xBU1Mob2MpOw0KPiAgICAgICBIb3RwbHVnSGFuZGxlckNsYXNzICpoYyA9
IEhPVFBMVUdfSEFORExFUl9DTEFTUyhvYyk7DQo+ICAgDQo+IEBAIC0xNzY3LDcgKzE3NjQs
NiBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAq
b2MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIG1hY2hpbmVfY2xhc3NfYWxsb3dfZHluYW1pY19z
eXNidXNfZGV2KG1jLCBUWVBFX1RQTV9USVNfU1lTQlVTKTsNCj4gICAjZW5kaWYNCj4gICAN
Cj4gLQ0KPiAgICAgICBvYmplY3RfY2xhc3NfcHJvcGVydHlfYWRkX2Jvb2wob2MsICJhY2xp
bnQiLCB2aXJ0X2dldF9hY2xpbnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2aXJ0X3NldF9hY2xpbnQpOw0KPiAgICAgICBvYmplY3RfY2xhc3NfcHJvcGVy
dHlfc2V0X2Rlc2NyaXB0aW9uKG9jLCAiYWNsaW50IiwNCj4gQEAgLTE3ODUsOSArMTc4MSwx
NCBAQCBzdGF0aWMgdm9pZCB2aXJ0X21hY2hpbmVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAq
b2MsIHZvaWQgKmRhdGEpDQo+ICAgICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGRfc3Ry
KG9jLCAiYWlhLWd1ZXN0cyIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIHZpcnRfZ2V0X2FpYV9ndWVzdHMsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHZpcnRfc2V0X2FpYV9ndWVzdHMpOw0KPiAtICAgIHNwcmludGYoc3RyLCAi
U2V0IG51bWJlciBvZiBndWVzdCBNTUlPIHBhZ2VzIGZvciBBSUEgSU1TSUMuIFZhbGlkIHZh
bHVlICINCj4gLSAgICAgICAgICAgICAgICAgInNob3VsZCBiZSBiZXR3ZWVuIDAgYW5kICVk
LiIsIFZJUlRfSVJRQ0hJUF9NQVhfR1VFU1RTKTsNCj4gLSAgICBvYmplY3RfY2xhc3NfcHJv
cGVydHlfc2V0X2Rlc2NyaXB0aW9uKG9jLCAiYWlhLWd1ZXN0cyIsIHN0cik7DQo+ICsgICAg
ew0KPiArICAgICAgICBnX2F1dG9mcmVlIGNoYXIgKnN0ciA9DQo+ICsgICAgICAgICAgICBn
X3N0cmR1cF9wcmludGYoIlNldCBudW1iZXIgb2YgZ3Vlc3QgTU1JTyBwYWdlcyBmb3IgQUlB
IElNU0lDLiAiDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIlZhbGlkIHZhbHVl
IHNob3VsZCBiZSBiZXR3ZWVuIDAgYW5kICVkLiIsDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgVklSVF9JUlFDSElQX01BWF9HVUVTVFMpOw0KPiArICAgICAgICBvYmplY3Rf
Y2xhc3NfcHJvcGVydHlfc2V0X2Rlc2NyaXB0aW9uKG9jLCAiYWlhLWd1ZXN0cyIsIHN0cik7
DQo+ICsgICAgfQ0KPiArDQo+ICAgICAgIG9iamVjdF9jbGFzc19wcm9wZXJ0eV9hZGQob2Ms
ICJhY3BpIiwgIk9uT2ZmQXV0byIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdmlydF9nZXRfYWNwaSwgdmlydF9zZXRfYWNwaSwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBOVUxMLCBOVUxMKTsNCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

