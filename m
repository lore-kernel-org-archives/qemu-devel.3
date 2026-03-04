Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F309EFCE38
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqZX-0001f6-Le; Wed, 04 Mar 2026 13:03:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqZW-0001eN-8z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:03:46 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vxqZU-0002GG-Hp
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:03:46 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-82980945556so68989b3a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Mar 2026 10:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772647423; x=1773252223; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o1n06u65coHmbbH97JVv4Cn9RvR/5WCDNfdtfq5lDZI=;
 b=qrt3/zkO96QnADE7LDpHEZC5lQ2yyBqizkkS9hob5xe0TiS2msOxXD8GBJWSyew/FE
 LMmTlnJDRkplURlJlRsrizhKx7l6Gz7MlR3D2bpmpVSFrCQ8UddvtP6yK0PI37cPyWLs
 GqpuG96xjkkvUQZb9XfXe+m48WaMQ3zHUDTLvpIxwP6HYR1+JFESnZEZOyFV0ouTAiKi
 AysWfXAylxssAjt3wzZcxYetfpqSuvOxHsSh9CkKLgkgHEamOuppMu9wGmiwHzgA81+z
 DdUqUr+2vJSpi/yVZnzTj+zP+sqUmtKW6d9atTQF1ydkTHu9qkzt6c7dUDrzhr+vMgoX
 u3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772647423; x=1773252223;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o1n06u65coHmbbH97JVv4Cn9RvR/5WCDNfdtfq5lDZI=;
 b=bTMI6Hk8XRAYcCgG8OIC4btCnM8MGRbIhHMQldLL+2sGWyxyKRDKBZnQlRMUK+KeZi
 E6E5+mxttk8Ofa5MMWcJxEzM6Sdt56KfrQf9k1MMt++8jTv8SekF5QH3mYNHGbtWlOI/
 6UySR3CZkslgD/SkE4ekBVlHVNRAChkGl8f4CYaxaBKWLQe/YK/W0MJKap7yPg78Pz1q
 nZewx7+OtElMiIJuAJma7Q6/tJhrowcdJbfSv1w3w4PMg6EwpUr2jhSGqDZ5pvsVcBim
 521Fe8Xss/mFRqBLCew+nebmAcvoTVKHY3C+hGbvn5oSgxrU9tmc+H1g2R4wJ4gSmkK4
 BEuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQ5G1fAmJjeDsl28s89iPIRsNanyr6E0SMqiFh0l3Y9xcyr0EiM6l86XaXYLqJc21oZlzsVtDflBvk@nongnu.org
X-Gm-Message-State: AOJu0Ywm4huMHk9B2nC4SgCQl95jUJ7faYWKhy+j4gPye4C/dGwDwCyU
 +x4u+M2Gx5NbDbC+OdwhU3YnwsTbAv5x129inKhs4LXjPmRTzPSIPOtQJKpm0dMP5t0=
X-Gm-Gg: ATEYQzyi95Z/pg9/29ll2bP5HSNzhpp6M9q2Xo5dKfRfqhuUReyK1VVJuZV3rSWiHY3
 VyEiG4wTuO2R5Q/lsSsKoHF9sGodGdgDvAeSCBSp/g3YPm0hHyGVsxXxCc0Y9+S0YuLbprHU640
 fts3mEpAf+CSuJMatjhz386CotTNmeXh2AS8art+lZDkFDLJyxaOPk+QJXK1LOdNsr1cffeHNTo
 xnH8c6h4ShWARVfCN9HTeVwvjkPMDgkHnM3RjWZgwPU5iRUBUdRhGmW5Ako0yfHXOX/RYvwtyBU
 qXt/6WhiXC5aDXyejMlBzZwXQluUg1v8dK2nMNB84uo6Xnt2iPgi0RhhBtzgzyp6Ky472fnFZkZ
 9GfsQrP3Cri11OA3vazw5vMzxD+93A7DyFjEdqRO0P7EIwxVSFiGi9lbmAV4cKx1Q6N4FPthLJ5
 wEaOh9+vgu9tQRxAcl3oRSr7kZUp0qumm0LgP00pSVJuhHifLrfb08tnc+WB16XtIxRMSY
X-Received: by 2002:a05:6a00:32c5:b0:824:3eb9:11e2 with SMTP id
 d2e1a72fcca58-82972d0f5f4mr2293990b3a.46.1772647422498; 
 Wed, 04 Mar 2026 10:03:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8297faf677bsm374009b3a.60.2026.03.04.10.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Mar 2026 10:03:42 -0800 (PST)
Message-ID: <7904b95a-c48d-41e0-80ae-63759e5a24ab@linaro.org>
Date: Wed, 4 Mar 2026 10:03:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] contrib/plugins/cpp: Add -fcoroutines
Content-Language: en-US
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260304-cpp-v1-1-7d87b975fc1e@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260304-cpp-v1-1-7d87b975fc1e@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

T24gMy8zLzI2IDExOjU5IFBNLCBBa2loaWtvIE9kYWtpIHdyb3RlOg0KPiBHQ0MgMTUuMi4x
IHJlcXVpcmVzIGl0Og0KPiANCj4gWzY3LzYxMTFdIENvbXBpbGluZyBDKysgb2JqZWN0IGNv
bnRyaWIvcGx1Z2lucy9saWJjcHAuc28ucC9jcHAuY3BwLm8NCj4gRkFJTEVEOiBjb250cmli
L3BsdWdpbnMvbGliY3BwLnNvLnAvY3BwLmNwcC5vDQo+IGMrKyAtSWNvbnRyaWIvcGx1Z2lu
cy9saWJjcHAuc28ucCAtSWNvbnRyaWIvcGx1Z2lucyAtSS4uL2NvbnRyaWIvcGx1Z2lucyAt
SS4uL2luY2x1ZGUvcGx1Z2lucyAtSS91c3IvaW5jbHVkZS9nbGliLTIuMCAtSS91c3IvbGli
NjQvZ2xpYi0yLjAvaW5jbHVkZSAtSS91c3IvaW5jbHVkZS9zeXNwcm9mLTYgLWZkaWFnbm9z
dGljcy1jb2xvcj1hdXRvIC1EX0dMSUJDWFhfQVNTRVJUSU9OUz0xIC1XYWxsIC1XaW52YWxp
ZC1wY2ggLVdlcnJvciAtTzIgLWcgLURfR05VX1NPVVJDRSAtRF9GSUxFX09GRlNFVF9CSVRT
PTY0IC1EX0xBUkdFRklMRV9TT1VSQ0UgLWZuby1zdHJpY3QtYWxpYXNpbmcgLWZuby1jb21t
b24gLWZ3cmFwdiAtZnRyaXZpYWwtYXV0by12YXItaW5pdD16ZXJvIC1memVyby1jYWxsLXVz
ZWQtcmVncz11c2VkLWdwciAtRF9fU1REQ19MSU1JVF9NQUNST1MgLURfX1NURENfQ09OU1RB
TlRfTUFDUk9TIC1EX19TVERDX0ZPUk1BVF9NQUNST1MgLWZzYW5pdGl6ZT1hZGRyZXNzIC1m
c3RhY2stcHJvdGVjdG9yLXN0cm9uZyAtZnNhbml0aXplPXVuZGVmaW5lZCAtV2VtcHR5LWJv
ZHkgLVdlbmRpZi1sYWJlbHMgLVdleHBhbnNpb24tdG8tZGVmaW5lZCAtV2Zvcm1hdC1zZWN1
cml0eSAtV2Zvcm1hdC15MmsgLVdpZ25vcmVkLXF1YWxpZmllcnMgLVdpbXBsaWNpdC1mYWxs
dGhyb3VnaD0yIC1XaW5pdC1zZWxmIC1XbWlzc2luZy1mb3JtYXQtYXR0cmlidXRlIC1XcmVk
dW5kYW50LWRlY2xzIC1Xc2hhZG93PWxvY2FsIC1XdHlwZS1saW1pdHMgLVd1bmRlZiAtV3Zs
YSAtV3dyaXRlLXN0cmluZ3MgLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXBzYWJp
IC1Xbm8tc2hpZnQtbmVnYXRpdmUtdmFsdWUgLWlzeXN0ZW0gL2hvbWUvbWUvcS92YXIvcWVt
dS9saW51eC1oZWFkZXJzIC1pc3lzdGVtIGxpbnV4LWhlYWRlcnMgLWlxdW90ZSAuIC1pcXVv
dGUgL2hvbWUvbWUvcS92YXIvcWVtdSAtaXF1b3RlIC9ob21lL21lL3EvdmFyL3FlbXUvIQ0K
PiAgIGluY2x1ZGUgLWlxdW90ZSAvaG9tZS9tZS9xL3Zhci9xZW11L2hvc3QvaW5jbHVkZS9h
YXJjaDY0IC1pcXVvdGUgL2hvbWUvbWUvcS92YXIvcWVtdS9ob3N0L2luY2x1ZGUvZ2VuZXJp
YyAtaXF1b3RlIC9ob21lL21lL3EvdmFyL3FlbXUvdGNnL2FhcmNoNjQgLXB0aHJlYWQgLWZQ
SUMgLU1EIC1NUSBjb250cmliL3BsdWdpbnMvbGliY3BwLnNvLnAvY3BwLmNwcC5vIC1NRiBj
b250cmliL3BsdWdpbnMvbGliY3BwLnNvLnAvY3BwLmNwcC5vLmQgLW8gY29udHJpYi9wbHVn
aW5zL2xpYmNwcC5zby5wL2NwcC5jcHAubyAtYyAuLi9jb250cmliL3BsdWdpbnMvY3BwLmNw
cA0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vY29udHJpYi9wbHVnaW5zL2NwcC5jcHA6
OTE6DQo+IC91c3IvaW5jbHVkZS9jKysvMTUvY29yb3V0aW5lOjQzOjM6IGVycm9yOiAjZXJy
b3IgInRoZSA8Y29yb3V0aW5lPiBoZWFkZXIgcmVxdWlyZXMgLWZjb3JvdXRpbmVzIg0KPiAg
ICAgNDMgfCAjIGVycm9yICJ0aGUgPGNvcm91dGluZT4gaGVhZGVyIHJlcXVpcmVzIC1mY29y
b3V0aW5lcyINCj4gICAgICAgIHwgICBefn5+fg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWtp
aGlrbyBPZGFraSA8b2Rha2lAcnNnLmNpLmkudS10b2t5by5hYy5qcD4NCj4gLS0tDQo+ICAg
Y29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkIHwgOCArKysrKysrLQ0KPiAgIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9jb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQgYi9jb250cmliL3BsdWdpbnMvbWVz
b24uYnVpbGQNCj4gaW5kZXggMDk5MzE5ZTdhMTczLi5jYWEwZmNhMTcyNDUgMTAwNjQ0DQo+
IC0tLSBhL2NvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KPiArKysgYi9jb250cmliL3Bs
dWdpbnMvbWVzb24uYnVpbGQNCj4gQEAgLTI2LDggKzI2LDE0IEBAIGVuZGlmDQo+ICAgdCA9
IFtdDQo+ICAgaWYgZ2V0X29wdGlvbigncGx1Z2lucycpDQo+ICAgICBmb3JlYWNoIGkgOiBj
b250cmliX3BsdWdpbnMNCj4gKyAgICBpZiBpID09ICdjcHAuY3BwJyBhbmQgY3h4Lmhhc19h
cmd1bWVudCgnLWZjb3JvdXRpbmVzJykNCj4gKyAgICAgIGNwcF9hcmdzID0gWyctZmNvcm91
dGluZXMnXQ0KPiArICAgIGVsc2UNCj4gKyAgICAgIGNwcF9hcmdzID0gW10NCj4gKyAgICBl
bmRpZg0KPiArDQo+ICAgICAgIHQgKz0gc2hhcmVkX21vZHVsZShmcy5zdGVtKGkpLCBmaWxl
cyhpKSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5kZW5jaWVzOiBwbHVnaW5z
X2RlcHMpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNwcF9hcmdzOiBjcHBfYXJncywg
ZGVwZW5kZW5jaWVzOiBwbHVnaW5zX2RlcHMpDQo+ICAgICBlbmRmb3JlYWNoDQo+ICAgZW5k
aWYNCj4gICBpZiB0Lmxlbmd0aCgpID4gMA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBh
ZmU2NTM2NzZkYzZkZmQ0OWYwMzkwMjM5ZmY5MGIyZjAwNTJjMmI4DQo+IGNoYW5nZS1pZDog
MjAyNjAzMDQtY3BwLWRkYzIxOTM3NGU0Zg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0K
PiBBa2loaWtvIE9kYWtpIDxvZGFraUByc2cuY2kuaS51LXRva3lvLmFjLmpwPg0KPiANCg0K
SGkgQWtpaGlrbywNCg0KaXQgc2VlbXMgbGlrZSB5b3UgcmFuIGludG8gdGhpcyBpc3N1ZToN
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvODc1eDhmdDV2cS5mc2ZAcmVk
aGF0LmNvbS8NCg0KWW91IGNhbiBqdXN0IGNsZWFuIHlvdXIgYnVpbGQgZm9sZGVyIGFuZCBy
ZXN0YXJ0IGZyb20gc2NyYXRjaC4NClNlZSB0aGUgdGhyZWFkIGFib3ZlLCBpdCdzIGEgbGlt
aXRhdGlvbiBvZiBtZXNvbiAoYnkgZGVzaWduKSBub3QgDQp1cGRhdGluZyBsYW5ndWFnZSBz
dGFuZGFyZC4NCg0KVGhlIGJlc3QgZml4IG9uIG91ciBzaWRlIHdvdWxkIGJlIHRvIGFkZCAt
c3RkPS4uLiBkaXJlY3RseSBpbiBjL2N4eCANCmZsYWdzIGluc3RlYWQgb2YgcmVseWluZyBv
biBkZWZhdWx0IG9wdGlvbnMuDQoNClJlZ2FyZHMsDQpQaWVycmljaw0K

