Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96DE6C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 18:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sf1wc-0003cN-Fi; Fri, 16 Aug 2024 14:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf1wb-0003b3-II
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:45:01 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sf1wZ-0004Ax-G1
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 14:45:01 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3db12a2f530so1492340b6e.1
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723833898; x=1724438698; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6A4omwWl8KLhK9zU2PP9jP5Mmfop4qMqoZmD135TwW4=;
 b=veOhVEiKgn9suefD31w5hekkHcwaQ4nNNDmwlxR6eKYRdctJK+QV/a5pxbX7R3BwXk
 dS5dIfyCDSsmdM0fntn1ShTJUaCBLf5l327j8qbRTBUQFMxDhnyBAolYlv183R34H2jD
 mhnhAwUyvh9CoLUf3F14cyFlT3AjtluvmV+InX12XKlXId5TlnFsIknZVoWTGkm966nI
 SXzjVN1nG9EB0ZV1v48kcgI15bqb+t3YEExBk4pCSGKn8m/okHAUQevhkpMJm8RZBiyu
 B9uZxt7E/cVzpQrgHBRye93z5nSwfYgNyUy0F7GpaXKeYnRFKokKueJ7K0rG2z2reBgv
 muQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723833898; x=1724438698;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6A4omwWl8KLhK9zU2PP9jP5Mmfop4qMqoZmD135TwW4=;
 b=QEWt1gIS79hJ7L93sWEt3MirhwFNFUgSZIfrmsiGjmnkbkyxH6KsVpU8nGgEtoffF9
 ic7lUj0bC4Gxo9pP5SjKnGIjKHg/gIfr5rOnZKbq4YyGoOje8k3/1VV3kbl6SBboNXML
 aJKb0NTd14dn8b1uRSHD6gQxMAI6x+TE9anAM6Vxf89XuY9ejYBLvTk8MCJLSowOEIg1
 JN3+rrUVE19qJNEAsZggQ3Gn1Ia5A9fp5+s8kw0aG5FAF8S7l8QpCOLlqLcMbEAMSoTE
 +vdGaEY1rnUeFfCet6FLq6Ifi8Yh2Ss1X/X7aO+19yQ2VyhoMjLU8x99TqfUypBt1GPz
 SCOQ==
X-Gm-Message-State: AOJu0YyjWWWSQSYLMb/gMgw5RyLGk9c/hjgszsjfZiQphQCZixZiLDHM
 v9v7i2DVMD7wnwXmnndG3RMyi29qwdiwgpxdaGxAOzoyMkFcq4699j7MzVChFwc=
X-Google-Smtp-Source: AGHT+IGtc4YNHNoa6LZ5uzzbAaQzIfr7u11WEe4ZU2plSrBny8t7q+xzRvxfxiZyhuKO9rbXzOQLMQ==
X-Received: by 2002:a05:6871:688:b0:270:2691:5ad5 with SMTP id
 586e51a60fabf-2702691c942mr2662660fac.7.1723833897865; 
 Fri, 16 Aug 2024 11:44:57 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6b636ca87sm3323666a12.84.2024.08.16.11.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 11:44:57 -0700 (PDT)
Message-ID: <ebe2e441-82e0-40e5-a679-af0a2a71f688@linaro.org>
Date: Fri, 16 Aug 2024 11:44:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] build contrib/plugins using meson
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <CABgObfa8GTo06hm0oDT+GUy-_6z=FVH2xnLWFcpm39_=_p4LNQ@mail.gmail.com>
 <f31bac22-5fcc-4f01-9eb3-c9512daa41d7@linaro.org>
 <742058e8-dc26-4d67-8b92-41a62ae675d6@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <742058e8-dc26-4d67-8b92-41a62ae675d6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x22c.google.com
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

SSBkb24ndCBoYXZlIHN0cm9uZyBvcGluaW9uIGluIHRoZSBlbmQsIEknbSBqdXN0IGxvb2tp
bmcgZm9yIGJ1aWxkaW5nIA0KY29udHJpYiBwbHVnaW5zIGxpa2UgdGhlIHJlc3Qgb2YgdGhl
IGNvZGViYXNlLCB0byByZWR1Y2UgbWFpbnRlbmFuY2UgYnVyZGVuLg0KDQpJbml0aWFsbHks
IHdoZW4gdGhpcyBpZGVhIHdhcyBpbXBsZW1lbnRlZCwgaXQgd2FzIHN1Z2dlc3RlZCBieSBB
bGV4IHRvIA0KcmVtb3ZlIHRoZSBNYWtlZmlsZSBbMV0uDQpOb3cgaXQgc2VlbXMgdG8gYmUg
c3VnZ2VzdGVkIHRvIGtlZXAgaXQgYXMgYW4gZXhhbXBsZS4gU28gSSdsbCBsZXQgeW91IA0K
ZGVjaWRlIHdoYXQncyB0aGUgYmVzdCwgSSdsbCBmb2xsb3cgdGhhdC4NCg0KWzFdIA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDIzMDYxNTE0MTMxNS45NjEzMTUt
MS1hbnRvbi5rb2Noa292QHByb3Rvbi5tZS9ULyNtMjIzN2ZiMjBiOWE1M2JkMmRkZWMyMjE4
MzE2OTIwOTBjZGExNGM2ZiANCg0KDQpPbiA4LzE1LzI0IDIzOjUwLCBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSB3cm90ZToNCj4gT24gMTUvOC8yNCAyMDowNCwgUGllcnJpY2sgQm91dmll
ciB3cm90ZToNCj4+IE9uIDgvMTQvMjQgMjM6MDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+
Pj4gT24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgMTozN+KAr0FNIFBpZXJyaWNrIEJvdXZpZXIN
Cj4+PiA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cm90ZToNCj4+Pj4gQ29udHJp
YiBwbHVnaW5zIGhhdmUgYmVlbiBidWlsdCBvdXQgb2YgdHJlZSBzbyBmYXIsIHRoYW5rcyB0
byBhDQo+Pj4+IE1ha2VmaWxlLg0KPj4+PiBIb3dldmVyLCBpdCBpcyBxdWl0ZSBpbmNvbnZl
bmllbnQgZm9yIG1haW50ZW5hbmNlLCBhcyB3ZSBtYXkgYnJlYWsgdGhlbSwNCj4+Pj4gZXNw
ZWNpYWxseSBmb3Igc3BlY2lmaWMgYXJjaGl0ZWN0dXJlcy4NCj4+Pj4NCj4+Pj4gRmlyc3Qg
cGF0Y2hlcyBhcmUgZml4aW5nIHdhcm5pbmdzIGZvciBleGlzdGluZyBwbHVnaW5zLCB0aGVu
IHdlIGFkZA0KPj4+PiBtZXNvbg0KPj4+PiBzdXBwb3J0LCBhbmQgZmluYWxseSwgd2UgcmVt
b3ZlIE1ha2VmaWxlIGZvciBjb250cmliL3BsdWdpbnMuDQo+Pj4+DQo+Pj4+IEJhc2VkIG9u
IHRoZSBwcm9wb3NhbCBvZiBBbnRvbiBLb2Noa292IG9uIGFzc29jaWF0ZWQgZ2l0bGFiIGlz
c3VlLg0KPj4+PiBTb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVt
dS8tL2lzc3Vlcy8xNzEwDQo+Pj4NCj4+PiBJcyB0aGUgYnVnIGFjdHVhbGx5IHN0aWxsIHRo
ZXJlPw0KPj4+DQo+Pg0KPj4gTWF5YmUgdGhlIGNoYW5nZXMgeW91IGRpZCBmaXhlZCB0aGUg
cG9ydGFiaWxpdHkgaXNzdWUuIEkganVzdCBhZGRlZCB0aGlzDQo+PiAic29sdmVzIiBiZWNh
dXNlIGl0J3Mgd2hlcmUgdGhlIGlkZWEgdG8gY29tcGlsZSB3aXRoIG1lc29uIHdhcyBwcmVz
ZW50ZWQNCj4+IGluaXRpYWxseS4NCj4+DQo+Pj4gVGhlIE1ha2VmaWxlIGV4cGxhaW5zIHdo
eSBpdCB3YXMgZG9uZSB0aGlzIHdheToNCj4+Pg0KPj4+ICMgVGhpcyBNYWtlZmlsZSBleGFt
cGxlIGlzIGZhaXJseSBpbmRlcGVuZGVudCBmcm9tIHRoZSBtYWluIG1ha2VmaWxlDQo+Pj4g
IyBzbyB1c2VycyBjYW4gdGFrZSBhbmQgYWRhcHQgaXQgZm9yIHRoZWlyIGJ1aWxkLiBXZSBv
bmx5IHJlYWxseQ0KPj4+ICMgaW5jbHVkZSBjb25maWctaG9zdC5tYWsgc28gd2UgZG9uJ3Qg
aGF2ZSB0byByZXBlYXQgcHJvYmluZyBmb3INCj4+PiAjIHByb2dyYW1zIHRoYXQgdGhlIG1h
aW4gY29uZmlndXJlIGhhcyBhbHJlYWR5IGRvbmUgZm9yIHVzLg0KPj4+DQo+Pj4gSW4gb3Ro
ZXIgd29yZHMgd2Ugc2hvdWxkIGFsc28gdGFrZSBpbnRvIGFjY291bnQgdGhhdCB0aGVyZSBp
cyBhDQo+Pj4gZG9jdW1lbnRhdGlvbiBiZW5lZml0IHRvIGhhdmluZyBhIE1ha2VmaWxlIHRo
YXQgd29ya3MgYWNyb3NzIFdpbmRvd3MsDQo+Pj4gRGFyd2luIGFuZCBnZW5lcmljIEVMRiBV
bmljZXMuIEFueXdheSBQaGlsaXBwZSwgQWtpaGlrbyBhbmQgQWxleCBhcmUNCj4+PiB0aGUg
YmVzdCBwZW9wbGUgdG8gZGVjaWRlLg0KPj4+ICDCoD4gT25lIGFyZ3VtZW50IGZyb20gbW92
aW5nIGNvbnRyaWIvcGx1Z2lucyB0byBtZXNvbiBpcyB0aGF0IHRoZSBXaW5kb3dzDQo+Pj4g
Y2FzZSBkZXBlbmRzIG9uIGxpYnFlbXVfcGx1Z2luX2FwaS5hIHdoaWNoIGlzIGJ1aWx0IHdp
dGggbWVzb24oKik7DQo+Pj4gdGhhdCBzYWlkLCBsaWJxZW11X3BsdWdpbl9hcGkuYSBzaG91
bGQgYmUgaW5zdGFsbGVkIC0gd2hpY2ggd291bGQNCj4+PiBqdXN0aWZ5IGl0IGJlaW5nIHVz
ZWQgZnJvbSBhbiAiZXh0ZXJuYWwiIG1ha2VmaWxlLg0KPj4+DQo+Pg0KPj4gWW91IG5lZWQg
bWVzb24gdG8gYnVpbGQgdGhpcyBsaWIgaW4gdGhlIGZpcnN0IHBsYWNlLCBzbyBJIGd1ZXNz
IHRoYXQNCj4+IDk5LjklIG9mIHRoZSBwZW9wbGUgd3JpdGluZyBhIHBsdWdpbiB3aWxsIGhh
dmUgYSBxZW11IHNvdXJjZSB0cmVlICh3aXRoDQo+PiBhY2Nlc3MgdG8gcGx1Z2luIGhlYWRl
cnMpLCBhbmQgZmlyc3QgY29tcGlsZSB0aGUgbGliLg0KPj4NCj4+IEkgYW0gbm90IGNvbnZp
bmNlZCBieSB0aGUgc2NlbmFyaW8gd2hlcmUgcGVvcGxlIGJ1aWxkIHRoaXMgb3V0IG9mIHRy
ZWUNCj4+IHRvIGJlIGhvbmVzdCwgYnV0IEkgbWF5IGJlIHdyb25nLg0KPiANCj4gQ29uc2lk
ZXIgdXNlcnMgaW50ZXJlc3RlZCB0byB1c2UgcGx1Z2lucyAobm90IHJlYWxseSBkZXZlbG9w
IHRoZW0pLg0KPiBUaGV5IHNob3VsZCBiZSBhYmxlIHRvIGJ1aWxkIHRoZSBwbHVnaW5zIHdp
dGggdGhlaXIgZGlzdHJpYiBRRU1VLA0KPiBub3QgY2xvbmluZyB0aGUgd2hvbGUgZ2l0IHRy
ZWUuIChBdCBsZWFzdCB0aGlzIGlzIGhvdyBJIHVuZGVyc3Rvb2QNCj4gd2hlbiBBbGV4IGV4
cGxhaW5lZCBtZSB0aGUgcGx1Z2lucyBwb3dlciBhbmQgc2ltcGxpY2l0eSBmb3IgdXNlcnMu
KQ0K

