Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E496C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 17:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCjQN-0001t7-VI; Thu, 30 May 2024 13:18:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjQH-0001qR-TH
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:18:43 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCjQG-0005Cz-3V
 for qemu-devel@nongnu.org; Thu, 30 May 2024 13:18:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1f44b594deeso8400785ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717089518; x=1717694318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dRgEDEEKvlr9Dm3onZJ0JyaSzrte3DuOEQ7c5zAOb4c=;
 b=EYjRhB1tmeG0M4IQYGdZ/811c0K/V1tCaMJZrUhsyptXYidl2CrcggkRG60x/VMFOC
 y8tBjV5VOOCfLR0G1uw6fm4H8zMwO/uIWoI8lvFUDC5a++XWPvJyOqYjnZwctrkPpaXE
 bxgn/POmKqeDoCQC86IIqNKM6OcOnaoayhPoJUdR7F3wrF5Ds9eqFKgjjg6ETxtPiEOx
 r0nNErQnfO0+4s+N3N+Cfp96yIiETP3M/gT7bjLI24ZRmmi+lDybFqgAmmq6xSD6oofA
 8Kq46+eKQkFh0s5naPCU6KPsENbfMAYKVWnZY2zhYJuErIoGYzZR41agZVwlbSPuw2IY
 AUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717089518; x=1717694318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dRgEDEEKvlr9Dm3onZJ0JyaSzrte3DuOEQ7c5zAOb4c=;
 b=gvLG7TJge9YnpH54jc4kGf0dvrdQz+V51wrUelqEKy4zQuzbiPGsW0iPO8nDgeF9sD
 e08TQWv3Htv31sC9/bXn0rnnhGTDlSMvGKqkGYeVa04wmXsTwMKwkjt2vBHTwb4FAiQh
 lkYnNO2IiUEpykyYf87FGlu61Sesw3kW/LalJLzL+zd0+mD634I/rFwNQ65cPiKk1gOf
 bNyCNAo1Ttr9giK2Lt6tlonR70iM5hsx7pAAOmKJz23T5t4BUXk8R8boPVWo+YVPERJy
 rxcdOksyuxCABo1E83rA+SRWikzNABTlsu0X1PypEDDBix6A4RjkuNRRSLSOMHJEY8X/
 h0mA==
X-Gm-Message-State: AOJu0Yxbhkv0thHFT3MVm3sGkf5D51dEYx0qVeY2ryIHY3XYpXpY+tOB
 JBxYT202mzDN5fsEOAx0Luh0TknrhjufP4eIAGVXl6zhIk32+yxqAMHsSBav6lqaoxS5vy/WSVq
 TVe4=
X-Google-Smtp-Source: AGHT+IE7RWTVC3CHWOLWRYEvWUBKjbZ42+qBSeys12xV/MKRbAkGVZAaIJQdg6HE3BqHkezwNGp8mg==
X-Received: by 2002:a17:902:d492:b0:1f4:bb25:b8c8 with SMTP id
 d9443c01a7336-1f61961bd89mr29606115ad.27.1717089518248; 
 Thu, 30 May 2024 10:18:38 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f63232f212sm366065ad.24.2024.05.30.10.18.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 10:18:37 -0700 (PDT)
Message-ID: <c7508b7a-0b72-4ee2-9c84-0c3289ff7fea@linaro.org>
Date: Thu, 30 May 2024 10:18:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] sysemu: add set_virtual_time to accel ops
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240516222047.1853459-1-pierrick.bouvier@linaro.org>
 <20240516222047.1853459-2-pierrick.bouvier@linaro.org>
 <CABgObfaT-bj1=zVoWy8MqFPsBkAx27GiEjkVRx__7iJwdYCfEA@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfaT-bj1=zVoWy8MqFPsBkAx27GiEjkVRx__7iJwdYCfEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gNS8yOS8yNCAyMzozMCwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gRnJpLCBNYXkg
MTcsIDIwMjQgYXQgMTI6MjHigK9BTSBQaWVycmljayBCb3V2aWVyDQo+IDxwaWVycmljay5i
b3V2aWVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4gZGlmZiAtLWdpdCBhL3N0dWJzL21lc29u
LmJ1aWxkIGIvc3R1YnMvbWVzb24uYnVpbGQNCj4+IGluZGV4IDNiOWQ0MjAyM2NiLi42NzIy
MTNiNzQ4MiAxMDA2NDQNCj4+IC0tLSBhL3N0dWJzL21lc29uLmJ1aWxkDQo+PiArKysgYi9z
dHVicy9tZXNvbi5idWlsZA0KPj4gQEAgLTMsNiArMywxMSBAQA0KPj4gICAjIGJlbG93LCBz
byB0aGF0IGl0IGlzIGNsZWFyIHdobyBuZWVkcyB0aGUgc3R1YmJlZCBmdW5jdGlvbmFsaXR5
Lg0KPj4NCj4+ICAgc3R1Yl9zcy5hZGQoZmlsZXMoJ2NwdS1nZXQtY2xvY2suYycpKQ0KPj4g
K3N0dWJfc3MuYWRkKGZpbGVzKCdjcHVzLXZpcnR1YWwtY2xvY2suYycpKQ0KPj4gK3N0dWJf
c3MuYWRkKGZpbGVzKCdxZW11LXRpbWVyLW5vdGlmeS1jYi5jJykpDQo+PiArc3R1Yl9zcy5h
ZGQoZmlsZXMoJ2ljb3VudC5jJykpDQo+PiArc3R1Yl9zcy5hZGQoZmlsZXMoJ2R1bXAuYycp
KQ0KPj4gK3N0dWJfc3MuYWRkKGZpbGVzKCdlcnJvci1wcmludGYuYycpKQ0KPiANCj4gV2Fz
IHRoZXJlIGEgcHJvYmxlbSB3aGVuIHJlYmFzaW5nPw0KPiANCj4gUGFvbG8NCj4gDQoNCkhp
IFBhb2xvLA0KDQpZZXMsIFBoaWxpcHBlIG1hZGUgdGhlIHNhbWUgY29tbWVudC4gSSdsbCBm
aXggaXQgaW4gbmV4dCByZXZpc2lvbi4NClRoYW5rcyENCg0KPj4gICBzdHViX3NzLmFkZChm
aWxlcygnZmRzZXQuYycpKQ0KPj4gICBzdHViX3NzLmFkZChmaWxlcygnaW90aHJlYWQtbG9j
ay5jJykpDQo+PiAgIHN0dWJfc3MuYWRkKGZpbGVzKCdpcy1kYWVtb25pemVkLmMnKSkNCj4+
IEBAIC0yOCw3ICszMyw2IEBAIGVuZGlmDQo+PiAgIGlmIGhhdmVfYmxvY2sgb3IgaGF2ZV9n
YQ0KPj4gICAgIHN0dWJfc3MuYWRkKGZpbGVzKCdyZXBsYXktdG9vbHMuYycpKQ0KPj4gICAg
ICMgc3R1YnMgZm9yIGhvb2tzIGluIHV0aWwvbWFpbi1sb29wLmMsIHV0aWwvYXN5bmMuYyBl
dGMuDQo+PiAtICBzdHViX3NzLmFkZChmaWxlcygnY3B1cy1nZXQtdmlydHVhbC1jbG9jay5j
JykpDQo+PiAgICAgc3R1Yl9zcy5hZGQoZmlsZXMoJ2ljb3VudC5jJykpDQo+PiAgICAgc3R1
Yl9zcy5hZGQoZmlsZXMoJ2dyYXBoLWxvY2suYycpKQ0KPj4gICAgIGlmIGxpbnV4X2lvX3Vy
aW5nLmZvdW5kKCkNCj4+IC0tDQo+PiAyLjM5LjINCj4+DQo+IA0K

