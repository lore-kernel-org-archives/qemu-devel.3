Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F2BECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 19:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snjgd-0008KG-81; Mon, 09 Sep 2024 15:04:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1snjgb-0008Ja-6Y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:04:29 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1snjgZ-0007Iu-IK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 15:04:28 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2068bee21d8so46094955ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 12:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725908665; x=1726513465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=85jDFTOWnCo7LVEHUDWTxlMjHUOoBGEFLH/XNnJR+V8=;
 b=vox7tUE98KB+QdiYkPwlJQDZkidSvc2TpW0dZNo6hf5a25h0lGPKOYd7ZesgpoU+7F
 ptdCJHYdPXKrI5lc79Y8K3xFZbxn5eOCSQjkKO7PzJw0AbYReWBr3VxQmSLj9iLbGVpn
 7iXn7DuBIp7pBNuDMn4uWoTFrqpv72oTVUqx7aevotCsNJ0UU0K9VPGwXHfvdD3TyGcp
 DIqcNcZEeMb+Iw3S9uRgqbbRT9DyG5QVDLTg3+pEgtovoIRbOmQ5pVvQMLHgf+8PPp4l
 9y64W0ZLPQN2EWt0uzFGQq7Q7gdXxyD2Kp8lUqvYizdT/5Hf9LaAON2SA6HXm2pzwjW6
 SBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725908665; x=1726513465;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=85jDFTOWnCo7LVEHUDWTxlMjHUOoBGEFLH/XNnJR+V8=;
 b=mdc6jnOIe1ZILwKT9kEmgHR7u8xuJUcWaqVoOWdGhKlq0bNWbkKwkn6HwmEkHMRct/
 0yddkt8T1XFJcDy+6+WYE+lLWJt/OLQWoVBgTbt1gDkhc8SVuX+vNuhBYRV2gOio+aAc
 6IpJwQ7kFScjQxOVs8xSt2/PAD67B0HE2clGRNSzVvRGyXi+FEQXzvi2P1/p9ZTBJxF0
 7cr7qtIUuLcIe4t98Xe2o++tCGoxOYBqO+WnYGZAtOEMoCJaMB0P2ednkZClK9Qe/VJJ
 K2WwwjszNnf8Zzp7p8x78Nn2EQ2dsOp78rybBla6p6ZIHR2wDy2xEnDPWLczSDZOQeay
 g5LQ==
X-Gm-Message-State: AOJu0YxSw0fkJV8xCYnJOySdYt1AzfF+4GK+6Q8LzSbTBqg73qAVql94
 wvTRbqsjrx4/+aN1gndSeSPOYhlASrsg9k0QkAQp/Zt+wGJYG158RoP86DKdy3E=
X-Google-Smtp-Source: AGHT+IFc8jhqsArvVnTD9IlDpqVYjk5Z6jl3FMVzHz/a8wAo18fWIQXfD9zBPgsOAhV5DrvLYp5Mlw==
X-Received: by 2002:a17:903:187:b0:205:5f54:75a2 with SMTP id
 d9443c01a7336-2070c196808mr107135845ad.51.1725908664759; 
 Mon, 09 Sep 2024 12:04:24 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e322f2sm37053215ad.80.2024.09.09.12.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 12:04:24 -0700 (PDT)
Message-ID: <cc597a6b-1ac5-464e-9e39-85e36bd0023c@linaro.org>
Date: Mon, 9 Sep 2024 12:04:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <8734met9c8.fsf@draig.linaro.org>
 <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org>
 <87h6apxi2d.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87h6apxi2d.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gOS85LzI0IDAzOjAwLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IE9uIDkv
NS8yNCAwODoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPj4+DQo+Pj4+IFRoaXMg
c2VyaWVzIGFsbG93cyBwbHVnaW5zIHRvIGtub3cgd2hpY2ggdmFsdWUgaXMgcmVhZC93cml0
dGVuIGR1cmluZyBhIG1lbW9yeQ0KPj4+PiBhY2Nlc3MuDQo+Pj4+DQo+Pj4+IEZvciBldmVy
eSBtZW1vcnkgYWNjZXNzLCB3ZSBrbm93IGNvcHkgdGhpcyB2YWx1ZSBiZWZvcmUgY2FsbGlu
ZyBtZW0gY2FsbGJhY2tzLA0KPj4+PiBhbmQgdGhvc2UgY2FuIHF1ZXJ5IGl0IHVzaW5nIG5l
dyBBUEkgZnVuY3Rpb246DQo+Pj4+IC0gcWVtdV9wbHVnaW5fbWVtX2dldF92YWx1ZQ0KPj4+
IFF1ZXVlZCB0byBwYXRjaGVzIDEtNSB0byBwbHVnaW5zL25leHQsIHRoYW5rcy4NCj4+PiBZ
b3UgY2FuIHNlbmQgdGhlIHJlLXNwdW4gdmVyc2lvbiBvZiA2IG9uY2UgdGhlIHJldmlldyBj
b21tZW50cyBoYXZlDQo+Pj4gYmVlbg0KPj4+IGRvbmUuDQo+Pj4NCj4+DQo+PiBUaGFua3Mg
QWxleCwNCj4+DQo+PiByaWdodCBub3csIG15IHRyeSB0byBtYWtlIGNoZWNrLXRjZyBhcmUg
YmxvY2tlZCB3aXRoIHRoZSBjcm9zcw0KPj4gY29udGFpbmVycyB3aG8gZG9uJ3QgY29tcGls
ZSwgc28gSSdsbCB3YWl0IGZvciB0aGlzIHRvIGJlIHJlc29sdmVkLg0KPiANCj4gV2hpY2gg
b25lcz8NCg0KZG9ja2VyLWltYWdlLWRlYmlhbi1taXBzNjRlbC1jcm9zcw0KZG9ja2VyLWlt
YWdlLWRlYmlhbi1taXBzZWwtY3Jvc3MNCihhYm91dCBicm9rZW4gcGFja2FnZXMpLg0KDQpJ
IHNhdyBzb21ldGhpbmcgbWVudGlvbmluZyB0aGlzIHJlY2VudGx5IG9uIHRoZSBtYWlsaW5n
IGxpc3QsIHNvIG5vdCANCnN1cmUgd2hhdCB3b3VsZCBiZSBvdXIgc29sdXRpb24gdG8gdGhp
cyAoaWdub3Jpbmc/KQ0KDQo+IA0KPj4gSSBzdGlsbCB3b25kZXIgaWYgaGF2aW5nIGEgc2lt
cGxlIGFhcmNoNjQveDY0IHRlc3QgaXMgbm90IGVub3VnaCwgYW5kDQo+PiBjb3ZlcmluZyA5
OS45JSBvZiB0aGUgYnVnIHdlIGNvdWxkIGludHJvZHVjZSBpbiB0aGUgZnV0dXJlIG9uIHRo
aXMuDQo+IA0KPiBIYXZlIHlvdSBtZWFzdXJlZCB0aGUgY29kZSBjb3ZlcmFnZSBvZiB0aGUg
dGVzdD8NCj4gDQoNCk5vcGUsIGJ1dCBhbGwgdGhlIGNvZGUgY2hhbmdlZCBpcyB0Y2ctZ2Vu
ZXJpYywgc28gdGVzdGluZyB0aGlzIG9uIGFsbCANCmFyY2ggZG9lcyBub3QgYnJpbmcgYmVu
ZWZpdCBpbiB0ZXJtcyBvZiBjb3ZlcmFnZS4NCg0KU28gYnkgZm9jdXNpbmcgb24gdGhlICJh
bGwgYXJjaCIgYXNwZWN0LCB3ZSBqdXN0IHRlc3QgdGNnIGltcGxlbWVudGF0aW9uIA0KaXRz
ZWxmLCBpbnN0ZWFkIG9mIHRoZSBwbHVnaW5zIHBhcnQuDQoNClRoZSBwcm9ibGVtcyB3ZSBp
ZGVudGlmaWVkIHNvIGZhciBpcyBjb21waWxhdGlvbiBmbGFncyBzcGVjaWZpYyBwZXIgDQph
cmNoLCBhbmQgc3BlY2lmaWMgZmxhZ3MgdG8gZW1pdCB3b3JkcyBpbnN0cnVjdGlvbi4gSXQg
ZG9lcyBub3Qgc2VlbSANCnJlbGF0ZWQgdG8gd2hhdCB3ZSByZWFsbHkgd2FudCB0byB0ZXN0
IGhlcmUuDQo=

