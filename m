Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F3ED767FA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2024 19:02:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6aQ3-00067F-VB; Thu, 31 Oct 2024 15:01:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6aQ2-00066w-Lz
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:01:18 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t6aQ0-0006IX-Mp
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 15:01:18 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso971610b3a.3
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 12:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730401275; x=1731006075; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E8cLvW8psRdKCLIH6n53NDUXxFVVXKLmlQpAo584jCs=;
 b=pev1P/ZXUKc7rkMDw5MBcXljoNwZG0IO72HTgRl7UGHahSNTdGp4LCh0SSvQNKGhRH
 CtU2oohkdAcxUjiTDMu4t19bPLGxWq0sHwlZMc3/HoiH26sseu3vJcPRiMDa4j8hbll/
 GevUNXbf7U8Mdxfy/VvHlZhXX7mrQaQCdN2aDzjglytTbF6Mx2uI6ZK6GYWYvxrKjsS9
 fH05VS5goZn2jzSh1pgQ1JHkxkS7L8XbRkKcNT/3WxFMygNL/ClbBezoX//HR9hapAuU
 EeVtuUfIthy7gl4JmY7R9GrQmQfCEnULFszPMamCV63tKsXdQvaSlfgE9DI22s5YidNE
 3ETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730401275; x=1731006075;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E8cLvW8psRdKCLIH6n53NDUXxFVVXKLmlQpAo584jCs=;
 b=YqUrlD1FNDhKuTg4OveHECdD7sObPgCMYKY9LnXuPKgD5SP5KThW7QzG4vH8u+tCNy
 E8e8rUgCYBVQfezMeplLDo67Z9b/VCPXPOat+TZ+oWVv3GFLltHVfRqLPUaOdM5jevoa
 lbNwu5cWQzXRR1UR1kWhyDkFgOvMzDjuCO5OinVCgNXKa61eJeaxHLUWBxfBAT8XjWRd
 HwgW9RQoB9/fLEH2uTtjrRwO01NgI82r7O6sU7dGbyhdDIu4QGdh/D5aV+5XK7oy3WTS
 /q+QWv6j5yr9iDH5UIg5oVUdR/zhTj9bVlY/bPorPpATP15CDt1Zv1xQDiDZyngwdzsZ
 tlcw==
X-Gm-Message-State: AOJu0YzqiR2i2aS7//2ZXEMqRfZUKKySZBIx98sFkKCg+TY/MIu7Iyq1
 WFu1gNpvqYkWEx12e9FF8bm0ib8jNTc9wENmF4epWp9v5co9KsFicWXd0rT2g4I=
X-Google-Smtp-Source: AGHT+IFQxuBk7RLlufQHsDfaA1/+9F1dl5Wp7lYGl6h1iFt5w9KpAtbeeGJqbJUwuxHwMlTYONLpIw==
X-Received: by 2002:a05:6a00:2d89:b0:71e:21:d2d8 with SMTP id
 d2e1a72fcca58-720c98d32c6mr1435135b3a.7.1730401274595; 
 Thu, 31 Oct 2024 12:01:14 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-720bc2eb7b1sm1447946b3a.159.2024.10.31.12.01.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 12:01:13 -0700 (PDT)
Message-ID: <2831cc99-b2c3-414f-9a81-0e39e8dc6d34@linaro.org>
Date: Thu, 31 Oct 2024 12:01:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] win32: use compiler option instead of attribute
 gcc_struct
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Martin_Storsj=C3=B6?= <martin@martin.st>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk
 <kkostiuk@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20241031040426.772604-1-pierrick.bouvier@linaro.org>
 <20241031040426.772604-8-pierrick.bouvier@linaro.org>
 <ZyNNrKi2Of8j5WEh@redhat.com>
 <e7e2f194-601c-4c26-bc51-1fc786f06aa2@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e7e2f194-601c-4c26-bc51-1fc786f06aa2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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

T24gMTAvMzEvMjQgMDM6NDQsIFRob21hcyBIdXRoIHdyb3RlOg0KPiBPbiAzMS8xMC8yMDI0
IDEwLjI4LCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdyb3RlOg0KPj4gT24gV2VkLCBPY3QgMzAs
IDIwMjQgYXQgMDk6MDQ6MjFQTSAtMDcwMCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+
PiBUaGlzIGF0dHJpYnV0ZSBpcyBub3QgcmVjb2duaXplZCBieSBjbGFuZywgYnV0IHRoZSBh
c3NvY2lhdGVkIG9wdGlvbiBpcy4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAg
ICBtZXNvbi5idWlsZCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDggKysrKy0t
LS0NCj4+PiAgICBpbmNsdWRlL3FlbXUvY29tcGlsZXIuaCAgICAgICAgICAgICAgICAgICB8
IDcgKy0tLS0tLQ0KPj4+ICAgIHN1YnByb2plY3RzL2xpYnZob3N0LXVzZXIvbGlidmhvc3Qt
dXNlci5oIHwgNiArLS0tLS0NCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKSwgMTUgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVp
bGQgYi9tZXNvbi5idWlsZA0KPj4+IGluZGV4IGQ4YWYwODI5OWUwLi5kMGQ1ZGJlMTQ3OSAx
MDA2NDQNCj4+PiAtLS0gYS9tZXNvbi5idWlsZA0KPj4+ICsrKyBiL21lc29uLmJ1aWxkDQo+
Pj4gQEAgLTMzMCwxMCArMzMwLDEwIEBAIGVsaWYgaG9zdF9vcyA9PSAnc3Vub3MnDQo+Pj4g
ICAgZWxpZiBob3N0X29zID09ICdoYWlrdScNCj4+PiAgICAgIHFlbXVfY29tbW9uX2ZsYWdz
ICs9IFsnLURCX1VTRV9QT1NJVElWRV9QT1NJWF9FUlJPUlMnLCAnLURfQlNEX1NPVVJDRScs
ICctZlBJQyddDQo+Pj4gICAgZWxpZiBob3N0X29zID09ICd3aW5kb3dzJw0KPj4+IC0gIGlm
IG5vdCBjb21waWxlci5jb21waWxlcygnc3RydWN0IHggeyBpbnQgeTsgfSBfX2F0dHJpYnV0
ZV9fKChnY2Nfc3RydWN0KSk7JywNCj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAg
YXJnczogJy1XZXJyb3InKQ0KPj4+IC0gICAgZXJyb3IoJ1lvdXIgY29tcGlsZXIgZG9lcyBu
b3Qgc3VwcG9ydCBfX2F0dHJpYnV0ZV9fKChnY2Nfc3RydWN0KSkgLSBwbGVhc2UgdXNlIEdD
QyBpbnN0ZWFkIG9mIENsYW5nJykNCj4+PiAtICBlbmRpZg0KPj4+ICsgICMgaHR0cHM6Ly9n
Y2MuZ251Lm9yZy9vbmxpbmVkb2NzL2djYy94ODYtVHlwZS1BdHRyaWJ1dGVzLmh0bWwNCj4+
PiArICAjIFdlIHVzZSB0aGlzIGNvbXBpbGF0aW9uIG9wdGlvbiBpbnN0ZWFkIG9mIHJlbHlp
bmcgb24gZ2NjX3N0cnVjdCBhdHRyaWJ1dGUNCj4+PiArICAjIGJlY2F1c2UgY2xhbmcgZG9l
cyBub3Qgc3VwcG9ydCBpdCAoYnV0IHN1cHBvcnRzIHRoZSBvcHRpb24pLg0KPj4+ICsgIHFl
bXVfY29tbW9uX2ZsYWdzICs9IFsnLW1uby1tcy1iaXRmaWVsZHMnXQ0KPj4+ICAgIGVuZGlm
DQo+Pg0KPj4gSXMgdGhpcyByZWFsbHkgc2FmZSBmb3IgdXMgdG8gdXNlID8gICBUaGUgY3Vy
cmVudCBnY2Nfc3RydWN0DQo+PiBhdHRyaWJ1dGUgYWZmZWN0cyBvbmx5IHN0cnVjdHMgbWFy
a2VkIGFzIFFFTVVfUEFDS0VELiBUaGlzDQo+PiBmbGFnIHdpbGwgYWZmZWN0IGFsbCBjb2Rl
Lg0KPj4NCj4+IElmIHdlIGNhbGwgZnJvbSBRRU1VIGNvZGUgaW50byBXaW5kb3dzIG5hdGl2
ZSBBUElzLCBhbmQgcGFzcw0KPj4gb3IgcmVjZWl2ZSBzdHJ1Y3RzLCB0aGVuIHRob3NlIHN0
cnVjdHMnIGxheW91dHMgd291bGQgYmUNCj4+IGFmZmVjdGVkIGJ5IHRoaXMgZmxhZy4gSSBk
b24ndCBoYXZlIGEgc3BlY2lmaWMgZXhhbXBsZSwgYnV0DQo+PiB0aGlzIGZlZWxzIHVuc2Fm
ZSB0byBtZSwgb3RoZXJ3aXNlIHdlIHdvdWxkIGhhdmUgZG9uZSB0aGlzDQo+PiBvcmlnaW5h
bGx5IHJhdGhlciB0aGFuIG9ubHkgdGFyZ2V0dGluZyBpbnRlcm5hbCBwYWNrZWQgc3RydWN0
cw0KPj4gd2l0aCB0aGUgZ2NjX3N0cnVjdCBhdHRyaWJ1dGUuDQo+IA0KPiBJIGFncmVlIHdp
dGggRGFuaWVsLCB3ZSBsaWtlbHkgY2Fubm90IHVzZSB0aGlzIHN3aXRjaCBnbG9iYWxseS4N
Cj4gDQo+IEJ1dCBzZWVtcyBsaWtlIENsYW5nIGZvbGtzIGFyZSB0cnlpbmcgdG8gaW5jbHVk
ZSBzdXBwb3J0IGZvciB0aGUgYXR0cmlidXRlLA0KPiBzZWU6IGh0dHBzOi8vZ2l0bGFiLmNv
bS9xZW11LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yNDc2I25vdGVfMjE1OTY0MzA4MQ0KPiBz
byBJJ2QgcmF0aGVyIHJlY29tbWVuZCB0byB3YWl0IGZvciB0aGF0IGZvciBwcm9wZXIgQ2xh
bmcgc3VwcG9ydCBoZXJlLg0KPiANCj4gICAgVGhvbWFzDQo+IA0KDQpUaGFua3MgZm9yIHlv
dXIgcmV2aWV3cy4NCihhZGRpbmcgTWFydGluIHRvIHRoZSBjb252ZXJzYXRpb24sIHdobyB3
b3JrZWQgb24gbGx2bS1taW5ndyB0b29sY2hhaW4sIA0KYW5kIGNvbW1lbnRlZCBvbiBHaXRM
YWIgaXNzdWUpLg0KDQpBcyBtZW50aW9uZWQgaW4gZ2NjIGRvY3VtZW50YXRpb24sIHRoaXMg
b3B0aW9uIGFwcGxpZXMgb25seSB0byBwYWNrZWQgDQpzdHJ1Y3R1cmVzLCBvciB3aGVuIGJp
dGZpZWxkIGFyZSB1c2VkLiBTbyB0aGlzIGlzIHRoaXMgc2Vjb25kIGNhc2UgdGhhdCANCm1h
eSBiZSBhIHByb2JsZW0gZm9yIHVzIGluZGVlZC4NCkxvb2tpbmcgYXQgbWluZ3cgd2luZG93
cyBoZWFkZXJzLCBJIGNvdWxkIGZpbmQgYSBmZXcgb2YgdGhlbSwgYnV0IEkgDQpkaWRuJ3Qg
Y2hlY2sgaWYgdGhleSB3ZXJlIHVzZWQgZGlyZWN0bHkgb3IgaW5kaXJlY3RseSBieSBvdXIg
Y29kZS4NCg0KQWZ0ZXIgcmVhZGluZyB0aGUgZ2l0bGFiIGlzc3VlIGF0dGFjaGVkLCBhbmQg
bGlua3MgYXNzb2NpYXRlZCwgaXQgc2VlbXMgDQp0aGF0IFFFTVUgaXMgb25lIG9mIHRoZSBv
bmx5IGJpZyBwcm9qZWN0cyB1c2luZyB0aGlzLiBBbmQgY2xhbmcgc3VwcG9ydCANCmlzIG9u
bHkgYmxvY2tlZCBieSB0aGlzLg0KVGhlIHVwc3RyZWFtIGxsdm0gc3VwcG9ydCBmb3IgdGhp
cyBtaWdodCB0YWtlIG1vcmUgdGltZSB0aGFuIGV4cGVjdGVkIA0KKHRoZSBQUiB3YXMgb3Bl
bmVkIG1vcmUgdGhhbiAxIHllYXIgYWdvLi4uIGFuZCB0aGUgb3JpZ2luYWwgcmVwb3J0IGZv
ciANCm1pc3NpbmcgYXR0cmlidXRlIHN1cHBvcnQgd2FzIGluIDIwMTUpLCBzbyBJJ20gbm90
IHZlcnkgY29uZmlkZW50IHRoaXMgDQp3aWxsIGFwcGVhciAic29vbiIuDQoNCkkgbm90aWNl
ZCB0aGF0IERhbmllbCBjb25kdWN0ZWQgYSBzbWFsbCBpbnZlc3RpZ2F0aW9uIHVzaW5nIHBh
aG9sZSwgYW5kIA0KdGhlIHJlcG9ydCB3YXMgdGhhdCB0aGVyZSB3ZXJlIG5vdCBzbyBtYW55
IGRpZmZlcmVuY2UgKG9uZSBmb3VuZCwgYnV0IA0Kb25seSBjb21waWxlIHg4Nl82NC1zb2Z0
bW11IHRhcmdldCkuDQoNCkkgd291bGQgYmUgd2lsbGluZyB0byBwZXJmb3JtIGEgZnVsbCBi
dWlsZCAoYWxsIGRlcGVuZGVuY2llcywgYW5kIGFsbCANCnRhcmdldHMpLCBhbmQgY29tcGFy
ZSB3aGF0IHdlIG9idGFpbi4NCklmIHdlIGNhbiBmaXggdGhlIGNvcm5lciBjYXNlcywgd291
bGQgeW91IGJlIG9wZW4gdG8gYWNjZXB0IHJlbW92aW5nIA0KZ2NjX3N0cnVjdCBmcm9tIHRo
ZSBjb2RlYmFzZT8NCkkgY2FuIHVuZGVyc3RhbmQgaWYgaXQncyBhIGJpZyBOTywgYnV0IEkg
dGhpbmsgaXQncyB1bmZvcnR1bmF0ZSB0aGF0IHdlIA0KYXJlIGJsb2NrZWQgdG9kYXkganVz
dCBiZWNhdXNlIG9mIHRoaXMuDQo=

