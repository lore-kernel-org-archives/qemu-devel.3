Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 679BCC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 18:05:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeqF-0003Aw-Vk; Thu, 15 Aug 2024 14:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeqE-0003AR-Uq
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:04:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeqD-0005xq-27
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 14:04:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-201cd78c6a3so9582895ad.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723745091; x=1724349891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UoAPauBCaz6cANehHh8PHNsql1EhKoL26sBOjtBqWuc=;
 b=zjyZ9Q2pX8vSkvUqvtKuyp43kYGO0Onx6JrsW9h6HdjGM9Pf3rZRKJDDByFOj23oSe
 iXaSKXJHzzkIcSDc9Khlo9EtFQcr5Xsd1CTgEn9tyiQ3BodWnoFVHUe7xdG4hCjQX1Zm
 tQHUanNd2IhcfViCGH0uTxJltAp5VhhrUj+EcPs9o0oRjpTOBXp1ZbGxDdHw5L5d8k9I
 DCWq3TKFpPn/10b7f4ubKheQDn15WlkOzCM5CZavweeulCfi4uicmewobqgWptyVFN9/
 FfwpwTIjJ6WFShBmJRJ2r3lYv9ASTOlX5mV/uoRLvwLLfhbJy3inTLaucqdPmt7BCaDZ
 SW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723745091; x=1724349891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UoAPauBCaz6cANehHh8PHNsql1EhKoL26sBOjtBqWuc=;
 b=l3xpDMoKE7dofMhYO4je3jU05nwFubUIdxY7S9+s3jTaEE0gpgmoQBpMWqpouD1kTs
 7jYZNhKGFq9EGuvzO1qpfojPRzz1ogg5H51rzBrSNSYgydLVBZCpTWZfCQkGaU/K9Z5a
 HpaYnvHACE8AxgSGghb8uOWacpCnZJ7pBlTCXLUd5BLUrFWgCHSRgMLIbaBDjYkkqdbC
 OSj1T26nXaolAc8MnBm6RBmyR80+Vp7XwZel9B6XKf8D2wW1ee8+YeU7wbQnJEZauvOO
 s72W9CI3taK/4hB12UOWqGh1qtArGWTQ3R5QY1+MMQPI4sUHUY8rtJpHY4vxXh+A3ILF
 di7A==
X-Gm-Message-State: AOJu0YyNouV1ioAr30RZ1As6eb3+xflvXHJ7XBwneMGyEB7vRChGGfxG
 6vOgLVLUOwkjBng48Wzl+MwrsXmOk0a8OoVTIPFLebNFGqFWVwTrp/jeNLhMfjg=
X-Google-Smtp-Source: AGHT+IHN2/7Ca12Yjp59xilEtD9HEp+shVSWwCcl0cJ0LeSOsBIB7YuhinnE2fA1Fb7to3uIJeExsA==
X-Received: by 2002:a17:903:1210:b0:1fd:6848:bc35 with SMTP id
 d9443c01a7336-20203ed2d8bmr6938655ad.33.1723745091270; 
 Thu, 15 Aug 2024 11:04:51 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038b43dsm12718645ad.210.2024.08.15.11.04.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 11:04:50 -0700 (PDT)
Message-ID: <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
Date: Thu, 15 Aug 2024 11:04:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
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

T24gOC8xNC8yNCAyMzowMCwgUGFvbG8gQm9uemluaSB3cm90ZToNCj4gT24gVGh1LCBBdWcg
MTUsIDIwMjQgYXQgMTozN+KAr0FNIFBpZXJyaWNrIEJvdXZpZXINCj4gPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4gd3JvdGU6DQo+PiBDb250cmliIHBsdWdpbnMgaGF2ZSBiZWVu
IGJ1aWx0IG91dCBvZiB0cmVlIHNvIGZhciwgdGhhbmtzIHRvIGEgTWFrZWZpbGUuDQo+PiBI
b3dldmVyLCBpdCBpcyBxdWl0ZSBpbmNvbnZlbmllbnQgZm9yIG1haW50ZW5hbmNlLCBhcyB3
ZSBtYXkgYnJlYWsgdGhlbSwNCj4+IGVzcGVjaWFsbHkgZm9yIHNwZWNpZmljIGFyY2hpdGVj
dHVyZXMuDQo+Pg0KPj4gRmlyc3QgcGF0Y2hlcyBhcmUgZml4aW5nIHdhcm5pbmdzIGZvciBl
eGlzdGluZyBwbHVnaW5zLCB0aGVuIHdlIGFkZCBtZXNvbg0KPj4gc3VwcG9ydCwgYW5kIGZp
bmFsbHksIHdlIHJlbW92ZSBNYWtlZmlsZSBmb3IgY29udHJpYi9wbHVnaW5zLg0KPj4NCj4+
IEJhc2VkIG9uIHRoZSBwcm9wb3NhbCBvZiBBbnRvbiBLb2Noa292IG9uIGFzc29jaWF0ZWQg
Z2l0bGFiIGlzc3VlLg0KPj4gU29sdmVzOiBodHRwczovL2dpdGxhYi5jb20vcWVtdS1wcm9q
ZWN0L3FlbXUvLS9pc3N1ZXMvMTcxMA0KPiANCj4gSXMgdGhlIGJ1ZyBhY3R1YWxseSBzdGls
bCB0aGVyZT8NCj4gDQoNCk1heWJlIHRoZSBjaGFuZ2VzIHlvdSBkaWQgZml4ZWQgdGhlIHBv
cnRhYmlsaXR5IGlzc3VlLiBJIGp1c3QgYWRkZWQgdGhpcyANCiJzb2x2ZXMiIGJlY2F1c2Ug
aXQncyB3aGVyZSB0aGUgaWRlYSB0byBjb21waWxlIHdpdGggbWVzb24gd2FzIHByZXNlbnRl
ZCANCmluaXRpYWxseS4NCg0KPiBUaGUgTWFrZWZpbGUgZXhwbGFpbnMgd2h5IGl0IHdhcyBk
b25lIHRoaXMgd2F5Og0KPiANCj4gIyBUaGlzIE1ha2VmaWxlIGV4YW1wbGUgaXMgZmFpcmx5
IGluZGVwZW5kZW50IGZyb20gdGhlIG1haW4gbWFrZWZpbGUNCj4gIyBzbyB1c2VycyBjYW4g
dGFrZSBhbmQgYWRhcHQgaXQgZm9yIHRoZWlyIGJ1aWxkLiBXZSBvbmx5IHJlYWxseQ0KPiAj
IGluY2x1ZGUgY29uZmlnLWhvc3QubWFrIHNvIHdlIGRvbid0IGhhdmUgdG8gcmVwZWF0IHBy
b2JpbmcgZm9yDQo+ICMgcHJvZ3JhbXMgdGhhdCB0aGUgbWFpbiBjb25maWd1cmUgaGFzIGFs
cmVhZHkgZG9uZSBmb3IgdXMuDQo+IA0KPiBJbiBvdGhlciB3b3JkcyB3ZSBzaG91bGQgYWxz
byB0YWtlIGludG8gYWNjb3VudCB0aGF0IHRoZXJlIGlzIGENCj4gZG9jdW1lbnRhdGlvbiBi
ZW5lZml0IHRvIGhhdmluZyBhIE1ha2VmaWxlIHRoYXQgd29ya3MgYWNyb3NzIFdpbmRvd3Ms
DQo+IERhcndpbiBhbmQgZ2VuZXJpYyBFTEYgVW5pY2VzLiBBbnl3YXkgUGhpbGlwcGUsIEFr
aWhpa28gYW5kIEFsZXggYXJlDQo+IHRoZSBiZXN0IHBlb3BsZSB0byBkZWNpZGUuDQo+ICA+
IE9uZSBhcmd1bWVudCBmcm9tIG1vdmluZyBjb250cmliL3BsdWdpbnMgdG8gbWVzb24gaXMg
dGhhdCB0aGUgV2luZG93cw0KPiBjYXNlIGRlcGVuZHMgb24gbGlicWVtdV9wbHVnaW5fYXBp
LmEgd2hpY2ggaXMgYnVpbHQgd2l0aCBtZXNvbigqKTsNCj4gdGhhdCBzYWlkLCBsaWJxZW11
X3BsdWdpbl9hcGkuYSBzaG91bGQgYmUgaW5zdGFsbGVkIC0gd2hpY2ggd291bGQNCj4ganVz
dGlmeSBpdCBiZWluZyB1c2VkIGZyb20gYW4gImV4dGVybmFsIiBtYWtlZmlsZS4NCj4NCg0K
WW91IG5lZWQgbWVzb24gdG8gYnVpbGQgdGhpcyBsaWIgaW4gdGhlIGZpcnN0IHBsYWNlLCBz
byBJIGd1ZXNzIHRoYXQgDQo5OS45JSBvZiB0aGUgcGVvcGxlIHdyaXRpbmcgYSBwbHVnaW4g
d2lsbCBoYXZlIGEgcWVtdSBzb3VyY2UgdHJlZSAod2l0aCANCmFjY2VzcyB0byBwbHVnaW4g
aGVhZGVycyksIGFuZCBmaXJzdCBjb21waWxlIHRoZSBsaWIuDQoNCkkgYW0gbm90IGNvbnZp
bmNlZCBieSB0aGUgc2NlbmFyaW8gd2hlcmUgcGVvcGxlIGJ1aWxkIHRoaXMgb3V0IG9mIHRy
ZWUgDQp0byBiZSBob25lc3QsIGJ1dCBJIG1heSBiZSB3cm9uZy4NCg0KPiBQYW9sbw0KPiAN
Cj4gKCopIGJ5IHRoZSB3YXksDQo+IA0K

