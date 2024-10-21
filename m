Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7E3D15DB4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2uim-0004nI-IS; Mon, 21 Oct 2024 11:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2uik-0004hr-1R
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:53:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2uih-0000nA-Om
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:53:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ea12e0dc7aso2895146a12.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729526002; x=1730130802; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KOvGRmoAwYKUCIhjQscGa0RAlJ1bYadDVfLb9UI/els=;
 b=hDuLhNLAqtuyrEunNzoe54oKXyt7jQAj3mWF6DCypxSV3q2GY8jOEYu4IGlaPoCCQk
 5wYI7+TlOpWH4FQMD6u6bBPm2Qwjlno+aP28Y8IxRmArcnk7iulD/nHV+2ncAYvZEE3U
 lSRwPfGYRfocgOx1pLsmVf8OYLRTHrMjxGHJbZlwEpTuRw2rw8WzXtC3KTUJ9X9dt0uX
 Au/cm7fUYccYcmwPGQjdqkcOna/hoBOUue/1NaVa1/dTzZW5G8nTomF7NeD3zc8bNMGW
 g03sVRrn891czcvMWAUiTthgg0VHHqp1zZK9mWjAcOsO3FL2be2CjFGKI3/O8okNvxpT
 7uPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729526002; x=1730130802;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KOvGRmoAwYKUCIhjQscGa0RAlJ1bYadDVfLb9UI/els=;
 b=ekIrqlRgYhTzL+YpJpvyYa+tuDTQoRwFhPFWzfhD/02OYru+CRBfAKpZ9Z3HABIIj9
 QzzIYkKzOMMdD58UqePcA6elydxLxkvUQCkA72dMeCITfDXUn3x6gYYerc0aWkntgaJE
 FqV3DPGXmkf3vJUHFI6Neqa5zIgLajRiciN4RYoKbG1xdyWN5iGw+ufmsItyhaLatlR9
 zic0jVbyd3EmlpjhvXsv7fSpsYbYyQCJqFaGGtnO7IDhrbpHS0rcKC6qTvCZNU+uon8t
 ootR+hiCorSwQkCY4TjJdVXgy2z2/YwMIEB+XnIKCSnhtE4wqWYRyr5XwzI/Ud+rI+WV
 +i8w==
X-Gm-Message-State: AOJu0YzMJ7W2mWsYLSyP/6SGInJZop2hrHfdMT/SeE1xNN//8R8gZwte
 0qKKBzrs7d4etdAE8sVqG4jkt5/ncfxJT7gOaE3C3F9TIQWJHJguhtiW7hUeMPc=
X-Google-Smtp-Source: AGHT+IGOSevQI5R/ni0GG+E+KXg6b/CO3ejaOZjSTilDk17QPuBTYVD9irBgTgWRRr2qpIv6t2TeHQ==
X-Received: by 2002:a05:6a21:178a:b0:1d9:21a0:14e0 with SMTP id
 adf61e73a8af0-1d92c4df65bmr16831560637.12.1729526002102; 
 Mon, 21 Oct 2024 08:53:22 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec132ffc3sm3068423b3a.62.2024.10.21.08.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:53:21 -0700 (PDT)
Message-ID: <439aa9b5-7ca8-4ebf-be5a-a104de2f0f77@linaro.org>
Date: Mon, 21 Oct 2024 08:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] meson: build contrib/plugins with meson
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>
References: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
 <20240925204845.390689-2-pierrick.bouvier@linaro.org>
 <87y12hokwp.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y12hokwp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

T24gMTAvMjEvMjQgMDI6MzgsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gVHJp
ZWQgdG8gdW5pZnkgdGhpcyBtZXNvbi5idWlsZCB3aXRoIHRlc3RzL3RjZy9wbHVnaW5zL21l
c29uLmJ1aWxkIGJ1dA0KPj4gdGhlIHJlc3VsdGluZyBtb2R1bGVzIGFyZSBub3Qgb3V0cHV0
IGluIHRoZSByaWdodCBkaXJlY3RvcnkuDQo+Pg0KPj4gT3JpZ2luYWxseSBwcm9wb3NlZCBi
eSBBbnRvbiBLb2Noa292LCB0aGFuayB5b3UhDQo+Pg0KPj4gU29sdmVzOiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMTcxMA0KPj4gU2lnbmVkLW9m
Zi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
Pj4gLS0tDQo+PiAgIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICA0ICsrKysNCj4+
ICAgY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkIHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBjb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KPj4gaW5kZXggY2VlZTZi
MjJjOGQuLmIxOGMyYTU0YWI1IDEwMDY0NA0KPj4gLS0tIGEvbWVzb24uYnVpbGQNCj4+ICsr
KyBiL21lc29uLmJ1aWxkDQo+PiBAQCAtMzY1NSw2ICszNjU1LDEwIEBAIHN1YmRpcignYWNj
ZWwnKQ0KPj4gICBzdWJkaXIoJ3BsdWdpbnMnKQ0KPj4gICBzdWJkaXIoJ2VicGYnKQ0KPj4g
ICANCj4+ICtpZiAnQ09ORklHX1RDRycgaW4gY29uZmlnX2FsbF9hY2NlbA0KPj4gKyAgc3Vi
ZGlyKCdjb250cmliL3BsdWdpbnMnKQ0KPj4gK2VuZGlmDQo+PiArDQo+PiAgIGNvbW1vbl91
c2VyX2luYyA9IFtdDQo+PiAgIA0KPj4gICBzdWJkaXIoJ2NvbW1vbi11c2VyJykNCj4+IGRp
ZmYgLS1naXQgYS9jb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQgYi9jb250cmliL3BsdWdp
bnMvbWVzb24uYnVpbGQNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAw
MDAwMDAwMC4uYTBlMDI2ZDI1ZTINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2NvbnRy
aWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KPj4gQEAgLTAsMCArMSwyMyBAQA0KPj4gK3QgPSBb
XQ0KPj4gK2lmIGdldF9vcHRpb24oJ3BsdWdpbnMnKQ0KPj4gKyAgZm9yZWFjaCBpIDogWydj
YWNoZScsICdkcmNvdicsICdleGVjbG9nJywgJ2hvdGJsb2NrcycsICdob3RwYWdlcycsICdo
b3d2ZWMnLA0KPj4gKyAgICAgICAgICAgICAgICdod3Byb2ZpbGUnLCAnaXBzJywgJ2xvY2tz
dGVwJywgJ3N0b3B0cmlnZ2VyJ10NCj4+ICsgICAgaWYgaG9zdF9vcyA9PSAnd2luZG93cycN
Cj4+ICsgICAgICB0ICs9IHNoYXJlZF9tb2R1bGUoaSwgZmlsZXMoaSArICcuYycpICsgJ3dp
bjMyX2xpbmtlci5jJywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBpbmNsdWRlX2Rp
cmVjdG9yaWVzOiAnLi4vLi4vaW5jbHVkZS9xZW11JywNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICBsaW5rX2RlcGVuZHM6IFt3aW4zMl9xZW11X3BsdWdpbl9hcGlfbGliXSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICBsaW5rX2FyZ3M6IFsnLUxwbHVnaW5zJywgJy1s
cWVtdV9wbHVnaW5fYXBpJ10sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5k
ZW5jaWVzOiBnbGliKQ0KPj4gKw0KPj4gKyAgICBlbHNlDQo+PiArICAgICAgdCArPSBzaGFy
ZWRfbW9kdWxlKGksIGZpbGVzKGkgKyAnLmMnKSwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICBpbmNsdWRlX2RpcmVjdG9yaWVzOiAnLi4vLi4vaW5jbHVkZS9xZW11JywNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IGdsaWIpDQo+IA0KPiBJIHdh
cyB0cnlpbmcgdG8gd29yayBvdXQgd2hlcmUgdGhlIGluY2x1ZGUgZGlycyBjb21lIGZyb20g
dG8gbWFrZSBzdXJlDQo+IEJyYWQncyBmaXggKHNlZSBadTQwNjNmamZIQzVoSFVsQGh1bXB0
eS5ob21lLmNvbXN0eWxlLmNvbSkgYWxzbyBhcHBsaWVzLg0KDQpJbiB0aGUgbWVzb24uYnVp
bGQsIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBzdWNoIGEgZml4LCBhcyBpdCBkb2VzIHRoZSAN
CnJpZ2h0IHRoaW5nIG91dCBvZiB0aGUgYm94Lg0KSWRlYWxseSwgd2Ugc2hvdWxkIHJlbW92
ZSB0aGUgTWFrZWZpbGUgdG8gYXZvaWQgaGF2aW5nIHRvIG1haW50YWluIGl0IA0Kd2hlbiB3
ZSdsbCBpbnRyb2R1Y2Ugb3RoZXIgZGVwcy9wbHVnaW5zIGluIHRoZSBmdXR1cmUuDQoNClVz
ZXJzIHdobyB3YW50IHRvIGNvbXBpbGUgb3V0IG9mIHRyZWUgY2FuIHN0aWxsIGdldCB0aGUg
Y29tcGlsYXRpb24gDQpjb21tYW5kIGZyb20gbmluamEsIGFuZCBhZGFwdCBpdCB0byB0aGVp
ciBuZWVkcy4NCg0KPiBJdCBkb2VzIGJ1dDoNCj4gDQo+ICAgIOKenCAgbWFrZSBjb250cmli
L3BsdWdpbnMvbGliZXhlY2xvZy5zbyBWPTENCj4gICAgL3Vzci9iaW4vbmluamEgLXYgICAt
ajEgLWQga2VlcGRlcGZpbGUgY29udHJpYi9wbHVnaW5zL2xpYmV4ZWNsb2cuc28gfCBjYXQN
Cj4gICAgWzEvMl0gY2MgLW02NCAtSWNvbnRyaWIvcGx1Z2lucy9saWJleGVjbG9nLnNvLnAg
LUljb250cmliL3BsdWdpbnMgLUkuLi8uLi9jb250cmliL3BsdWdpbnMgLUkuLi8uLi9pbmNs
dWRlL3FlbXUgLUkvdXNyL2luY2x1ZGUvZ2xpYi0yLjAgLUkvdXNyL2xpYi94ODZfNjQtbGlu
dXgtZ251L2dsaWItMi4wL2luY2x1ZGUgLWZkaWFnbm9zdGljcy1jb2xvcj1hdXRvIC1XYWxs
IC1XaW52YWxpZC1wY2ggLVdlcnJvciAtc3RkPWdudTExIC1PMiAtZyAtZnN0YWNrLXByb3Rl
Y3Rvci1zdHJvbmcgLVdlbXB0eS1ib2R5IC1XZW5kaWYtbGFiZWxzIC1XZXhwYW5zaW9uLXRv
LWRlZmluZWQgLVdmb3JtYXQtc2VjdXJpdHkgLVdmb3JtYXQteTJrIC1XaWdub3JlZC1xdWFs
aWZpZXJzIC1XaW1wbGljaXQtZmFsbHRocm91Z2g9MiAtV2luaXQtc2VsZiAtV21pc3Npbmct
Zm9ybWF0LWF0dHJpYnV0ZSAtV21pc3NpbmctcHJvdG90eXBlcyAtV25lc3RlZC1leHRlcm5z
IC1Xb2xkLXN0eWxlLWRlY2xhcmF0aW9uIC1Xb2xkLXN0eWxlLWRlZmluaXRpb24gLVdyZWR1
bmRhbnQtZGVjbHMgLVdzaGFkb3c9bG9jYWwgLVdzdHJpY3QtcHJvdG90eXBlcyAtV3R5cGUt
bGltaXRzIC1XdW5kZWYgLVd2bGEgLVd3cml0ZS1zdHJpbmdzIC1Xbm8tbWlzc2luZy1pbmNs
dWRlLWRpcnMgLVduby1wc2FiaSAtV25vLXNoaWZ0LW5lZ2F0aXZlLXZhbHVlIC1pc3lzdGVt
IC9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9saW51eC1oZWFkZXJzIC1pc3lzdGVtIGxpbnV4
LWhlYWRlcnMgLWlxdW90ZSAuIC1pcXVvdGUgL2hvbWUvYWxleC9sc3JjL3FlbXUuZ2l0IC1p
cXVvdGUgL2hvbWUvYWxleC9sc3JjL3FlbXUuZ2l0L2luY2x1ZGUgLWlxdW90ZSAvaG9tZS9h
bGV4L2xzcmMvcWVtdS5naXQvaG9zdC9pbmNsdWRlL3g4Nl82NCAtaXF1b3RlIC9ob21lL2Fs
ZXgvbHNyYy9xZW11LmdpdC9ob3N0L2luY2x1ZGUvZ2VuZXJpYyAtaXF1b3RlIC9ob21lL2Fs
ZXgvbHNyYy9xZW11LmdpdC90Y2cvaTM4NiAtcHRocmVhZCAtbWN4MTYgLW1wb3BjbnQgLW1u
ZWVkZWQgLW1tb3ZiZSAtbWFibSAtbWJtaSAtbWJtaTIgLW1mbWEgLW1mMTZjIC1tYXZ4MiAt
RF9HTlVfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJVFM9NjQgLURfTEFSR0VGSUxFX1NPVVJD
RSAtZm5vLXN0cmljdC1hbGlhc2luZyAtZm5vLWNvbW1vbiAtZndyYXB2IC1mdHJpdmlhbC1h
dXRvLXZhci1pbml0PXplcm8gLWZ6ZXJvLWNhbGwtdXNlZC1yZWdzPXVzZWQtZ3ByIC1mUElD
IC1NRCAtTVEgY29udHJpYi9wbHVnaW5zL2xpYmV4ZWNsb2cuc28ucC9leGVjbG9nLmMubyAt
TUYgY29udHJpYi9wbHVnaW5zL2xpYmV4ZWNsb2cuc28ucC9leGVjbG9nLmMuby5kIC1vIGNv
bnRyaWIvcGx1Z2lucy9saWJleGVjbG9nLnNvLnAvZXhlY2xvZy5jLm8gLWMgLi4vLi4vY29u
dHJpYi9wbHVnaW5zL2V4ZWNsb2cuYw0KPiAgICBbMi8yXSBjYyAtbTY0ICAtbyBjb250cmli
L3BsdWdpbnMvbGliZXhlY2xvZy5zbyBjb250cmliL3BsdWdpbnMvbGliZXhlY2xvZy5zby5w
L2V4ZWNsb2cuYy5vIC1XbCwtLWFzLW5lZWRlZCAtV2wsLS1hbGxvdy1zaGxpYi11bmRlZmlu
ZWQgLXNoYXJlZCAtZlBJQyAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLVdsLC16LHJlbHJv
IC1XbCwteixub3cgLVdsLC0tc3RhcnQtZ3JvdXAgL3Vzci9saWIveDg2XzY0LWxpbnV4LWdu
dS9saWJnbGliLTIuMC5zbyAvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2xpYmdtb2R1bGUt
Mi4wLnNvIC1XbCwtLWVuZC1ncm91cCAtcHRocmVhZA0KPiANCj4gSSdtIG5vdCBzdXJlIHdo
eSB3ZSBzZWUgIi1JY29udHJpYi9wbHVnaW5zIC1JLi4vLi4vY29udHJpYi9wbHVnaW5zIi4N
Cj4gSXQncyBwcm9iYWJseSBhIGhhcm1sZXNzIHJlZHVuZGFuY3kgYnV0IEknbSBjdXJpb3Vz
IGFzIHRvIHdoZXJlIHRoZSBwYXRoDQo+IGNvbWVzIGZyb20sIGFueSBpZGVhPw0KPiANCj4+
ICsgICAgZW5kaWYNCj4+ICsgIGVuZGZvcmVhY2gNCj4+ICtlbmRpZg0KPj4gK2lmIHQubGVu
Z3RoKCkgPiAwDQo+PiArICBhbGlhc190YXJnZXQoJ2NvbnRyaWItcGx1Z2lucycsIHQpDQo+
PiArZWxzZQ0KPj4gKyAgcnVuX3RhcmdldCgnY29udHJpYi1wbHVnaW5zJywgY29tbWFuZDog
ZmluZF9wcm9ncmFtKCd0cnVlJykpDQo+PiArZW5kaWYNCj4gDQo=

