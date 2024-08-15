Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9085C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeUO-0005gg-EO; Thu, 15 Aug 2024 13:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeUM-0005gC-Vi
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:42:19 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeUL-0002DZ-8m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:42:18 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-201d5af11a4so11766545ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723743736; x=1724348536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Aa5ba76V/UgPXH8MmjA+IPgtk+KWGcaXK/69QKbFPW8=;
 b=tXPOReLOKVdOJrn6nMKCy+dlNaLRefeROZtbkQ2Vb3c/4YJldWGhf3vIR4OeDHmXfY
 ONfJG1y0R1mfrs8H3JTn8kHJ2QY+XlObVJHkhgFfz48mgT3KzSXseWvWdBF0sSe91ZMf
 yqqC5Pp/85qLFQK6p5PQEw6D5N2/nFPfqdtQNT6AEYRvDOvJZeQxXgTWW0TKZOjK+gWS
 wnHTgNfXKLnPn2J3UmTBbxfFagnJQGhdOGsFAPzx/aNPUrMOi1MY6udeGX7y1Udr6bci
 IdztgZogK41dVdAjrMM65rg6HFbGRKoo9tlFj40RhbN8Uus+/pSJaYFPjd6bSXWWMJDp
 8jeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723743736; x=1724348536;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Aa5ba76V/UgPXH8MmjA+IPgtk+KWGcaXK/69QKbFPW8=;
 b=QXM/lyB7rT2xPXEGJz3QfVqsm0xKFh2bKpJ8Iy7LryPDuUBGcwCOVooVP28Awb1tMr
 jbbZcT4kgIhdej83gbbR3V4PELwbCaeQQdp4JAD14ARxdrJL/MWqpNZA4kJ+lFRnp+3Z
 HsdGfETkLsCso0JR0x63pE7haTO23VwBxGHY/6zZ+Zf0ieIL89M5YhbyvvB6TjpYNe6u
 bs+Cxmfq3EcXbK8Uqa2HOaAwIi9GlNf26mVyyebfEsFbcWkdQLiixhWXuKFb1arX9Lx5
 Z/wiznEmYcMv64cFQ0/OHzm1Qv8202WfJBJUiKQWr5pchn02oHQIoCOE2T7omPoXKDPE
 WGJg==
X-Gm-Message-State: AOJu0Ywh+AbVEp5wfrpI//eMhbSmqJqSP9vPMIG6JENcaPnevKxBqfRB
 GZiPBkg8wXVhSJAURY6bJlPNGKeTdM9JyGXO/AuBQvNP6jnAZ48cA+NTz/jgNR4=
X-Google-Smtp-Source: AGHT+IF9H/s26k1YzrYgqLQ3JcNZURQbrUQR+DLsy7720g/IhfsE8z07Cv9RZcutMNnmrfm7DACWew==
X-Received: by 2002:a17:902:ea0a:b0:1fd:acd1:b658 with SMTP id
 d9443c01a7336-20203f4f9dbmr5716025ad.55.1723743735658; 
 Thu, 15 Aug 2024 10:42:15 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f02fb432sm12647195ad.54.2024.08.15.10.42.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:42:15 -0700 (PDT)
Message-ID: <d6c7b18d-367c-4214-a06e-e70051b68383@linaro.org>
Date: Thu, 15 Aug 2024 10:42:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 <87y14y2ery.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y14y2ery.fsf@draig.linaro.org>
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

T24gOC8xNS8yNCAwNDo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQYW9sbyBCb256aW5p
IDxwYm9uemluaUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gT24gVGh1LCBBdWcgMTUs
IDIwMjQgYXQgMTozN+KAr0FNIFBpZXJyaWNrIEJvdXZpZXINCj4+IDxwaWVycmljay5ib3V2
aWVyQGxpbmFyby5vcmc+IHdyb3RlOg0KPj4+IENvbnRyaWIgcGx1Z2lucyBoYXZlIGJlZW4g
YnVpbHQgb3V0IG9mIHRyZWUgc28gZmFyLCB0aGFua3MgdG8gYSBNYWtlZmlsZS4NCj4+PiBI
b3dldmVyLCBpdCBpcyBxdWl0ZSBpbmNvbnZlbmllbnQgZm9yIG1haW50ZW5hbmNlLCBhcyB3
ZSBtYXkgYnJlYWsgdGhlbSwNCj4+PiBlc3BlY2lhbGx5IGZvciBzcGVjaWZpYyBhcmNoaXRl
Y3R1cmVzLg0KPj4+DQo+Pj4gRmlyc3QgcGF0Y2hlcyBhcmUgZml4aW5nIHdhcm5pbmdzIGZv
ciBleGlzdGluZyBwbHVnaW5zLCB0aGVuIHdlIGFkZCBtZXNvbg0KPj4+IHN1cHBvcnQsIGFu
ZCBmaW5hbGx5LCB3ZSByZW1vdmUgTWFrZWZpbGUgZm9yIGNvbnRyaWIvcGx1Z2lucy4NCj4+
Pg0KPj4+IEJhc2VkIG9uIHRoZSBwcm9wb3NhbCBvZiBBbnRvbiBLb2Noa292IG9uIGFzc29j
aWF0ZWQgZ2l0bGFiIGlzc3VlLg0KPj4+IFNvbHZlczogaHR0cHM6Ly9naXRsYWIuY29tL3Fl
bXUtcHJvamVjdC9xZW11Ly0vaXNzdWVzLzE3MTANCj4+DQo+PiBJcyB0aGUgYnVnIGFjdHVh
bGx5IHN0aWxsIHRoZXJlPw0KPj4NCj4+IFRoZSBNYWtlZmlsZSBleHBsYWlucyB3aHkgaXQg
d2FzIGRvbmUgdGhpcyB3YXk6DQo+Pg0KPj4gIyBUaGlzIE1ha2VmaWxlIGV4YW1wbGUgaXMg
ZmFpcmx5IGluZGVwZW5kZW50IGZyb20gdGhlIG1haW4gbWFrZWZpbGUNCj4+ICMgc28gdXNl
cnMgY2FuIHRha2UgYW5kIGFkYXB0IGl0IGZvciB0aGVpciBidWlsZC4gV2Ugb25seSByZWFs
bHkNCj4+ICMgaW5jbHVkZSBjb25maWctaG9zdC5tYWsgc28gd2UgZG9uJ3QgaGF2ZSB0byBy
ZXBlYXQgcHJvYmluZyBmb3INCj4+ICMgcHJvZ3JhbXMgdGhhdCB0aGUgbWFpbiBjb25maWd1
cmUgaGFzIGFscmVhZHkgZG9uZSBmb3IgdXMuDQo+Pg0KPj4gSW4gb3RoZXIgd29yZHMgd2Ug
c2hvdWxkIGFsc28gdGFrZSBpbnRvIGFjY291bnQgdGhhdCB0aGVyZSBpcyBhDQo+PiBkb2N1
bWVudGF0aW9uIGJlbmVmaXQgdG8gaGF2aW5nIGEgTWFrZWZpbGUgdGhhdCB3b3JrcyBhY3Jv
c3MgV2luZG93cywNCj4+IERhcndpbiBhbmQgZ2VuZXJpYyBFTEYgVW5pY2VzLiBBbnl3YXkg
UGhpbGlwcGUsIEFraWhpa28gYW5kIEFsZXggYXJlDQo+PiB0aGUgYmVzdCBwZW9wbGUgdG8g
ZGVjaWRlLg0KPiANCj4gV2UgY291bGQga2VlcCB0aGUgTWFrZWZpbGUgYXMgYW4gZXhhbXBs
ZSBidXQgdGhlIG1lc29uIGZpbGUgbG9va3MgZmFpcmx5DQo+IGVhc3kgdG8gcmVhZC4gSG93
ZXZlciBpdCBrZWVwcyBncm93aW5nIHdhcnRzIHRvIGFkYXB0IHRvIHRoZSBmYWN0IGl0cw0K
PiBub3QgaW50ZWdyYXRlZCB3aXRoIHRoZSB3aWRlciBwcm9qZWN0Lg0KPiANCg0KQXMgeW91
IHdpc2gsIGJ1dCBJIHRoaW5rIGl0J3MgdmVyeSBjb25mdXNpbmcgdG8gaGF2ZSBib3RoLg0K
DQpJbiBtb3JlLCB5b3UgKm5lZWQqIG1lc29uIHRvIGJ1aWxkIHRoZSBsaWIgdG8gd2hpY2gg
dGhlIHBsdWdpbiBpcyANCmxpbmtlZCwgc28gaXQncyBub3QgcG9zc2libGUgdG8gY29tcGls
ZSBhIHBsdWdpbiB3aXRoIG9ubHkgYSBNYWtlZmlsZSANCmZyb20gc2NyYXRjaC4NCg0KPj4g
T25lIGFyZ3VtZW50IGZyb20gbW92aW5nIGNvbnRyaWIvcGx1Z2lucyB0byBtZXNvbiBpcyB0
aGF0IHRoZSBXaW5kb3dzDQo+PiBjYXNlIGRlcGVuZHMgb24gbGlicWVtdV9wbHVnaW5fYXBp
LmEgd2hpY2ggaXMgYnVpbHQgd2l0aCBtZXNvbigqKTsNCj4+IHRoYXQgc2FpZCwgbGlicWVt
dV9wbHVnaW5fYXBpLmEgc2hvdWxkIGJlIGluc3RhbGxlZCAtIHdoaWNoIHdvdWxkDQo+PiBq
dXN0aWZ5IGl0IGJlaW5nIHVzZWQgZnJvbSBhbiAiZXh0ZXJuYWwiIG1ha2VmaWxlLg0KPj4N
Cj4+IFBhb2xvDQo+Pg0KPj4gKCopIGJ5IHRoZSB3YXksDQo+IA0K

