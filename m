Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7082D0EE19
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:56:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJrZ-0003Lo-4b; Fri, 11 Oct 2024 13:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJrY-0003Lf-4z
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:55:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1szJrW-0001Ml-0x
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:55:39 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20ca388d242so7060855ad.2
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728669336; x=1729274136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0qpKZPbd+SK3pAJV1JjVK/MXxmXPesGdKRMToQ976pI=;
 b=fodVvwFUrgAXMfYGAfCu6p+Hdw9qqNIE2HlXIECmftQWnW/LxL9IdQga8fnHJx5O/H
 xMeARrIVkwl9JrOHe3dxdYn/tYd49hPaHYkroWOvtFC2Pj0QfyY80d2UjlJAg61w56Aj
 uTCST6YDfOwt9Z1ABfWbjfqAjy+JBlxFpMhMioBZz8n/BgmX4x0oOGt4tqvoevO7XCHZ
 4R5qnR8VIhb31FPhkF0SBay/47TPsxaNCTf6L6IDje41pknhhOsmEjpz9oYxnzO9RwiF
 bTptgBixZYCBbuT4yX2Y8irvoTpNY4h3Q1WVSHWP33QGUVdjADLcF2Ghu8YIOP8MjkvX
 /qsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728669336; x=1729274136;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0qpKZPbd+SK3pAJV1JjVK/MXxmXPesGdKRMToQ976pI=;
 b=OhKuBCdcG0pqnqmTPhBHMueDgLw9MtSOvGXtxBnONHlqnZLC5k7mYCFwsb5JZf18Yu
 smiB4OUVWz+8w1ww2uFzrYC9bYtyucso4goG939DyGlUxUIFDVG+G60JfcIEeECJqkfK
 NDSqVhKIFm1jYAGGpBBwclElHYYKem9tGo67I1zC+vZPSiYjcUhoRC/lwBs3uCtPKsHB
 4hM30gvARc0Q2PYv9EScvC8KbSPvH0Kym5MexQX2fY71SAfcyG/Gf5fsiPNgbv2xAZWh
 /f7dNWJkGZpsqWBfbIEKoVxpN+B3l6R0mWxUA4mkbEmn/O9convavf3hUjEBZHywEeHm
 RfkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4uH3HY7VrWXhGo8TURhz09GtueCi2VvtEZ4ssoGE4j4bDFljymgZGjrjFvQR4CB4EIZHtocb5YEq5@nongnu.org
X-Gm-Message-State: AOJu0YxN7ehLR4xdgAxaiX0+m0Vl3ipwtLfu/BxoszAj8LDTfeBDRjXx
 afUvsiisQzUEwC4cYzH+d0pw6WEZc0p2ODx0oL/B2WIMVhRPAPrmoalvwSGynNA=
X-Google-Smtp-Source: AGHT+IHC+Rgn/Q8Mi+6CDVvIv2A8u+MoYoszFsXFNPSpaoEiO+T3/xzyp/OGiHPNBUQOZMaX9mKjvQ==
X-Received: by 2002:a17:903:22c7:b0:206:96bf:b0cf with SMTP id
 d9443c01a7336-20cba9edd5bmr8104805ad.0.1728669335903; 
 Fri, 11 Oct 2024 10:55:35 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea448e3fe4sm2703785a12.10.2024.10.11.10.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Oct 2024 10:55:35 -0700 (PDT)
Message-ID: <1c96d9bf-7e40-4e7c-b90e-3b873cb1957b@linaro.org>
Date: Fri, 11 Oct 2024 10:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/23] accel/tcg: Always use IntervalTree for code lookups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20241009150855.804605-1-richard.henderson@linaro.org>
 <20241009150855.804605-20-richard.henderson@linaro.org>
 <c81af2ad-fe0d-4f9f-8bc2-23bcd49354ea@linaro.org>
 <ad8716ae-2d7b-43bb-9653-ed8d9e4b83df@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ad8716ae-2d7b-43bb-9653-ed8d9e4b83df@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMTAvMTEvMjQgMDc6NDcsIFJpY2hhcmQgSGVuZGVyc29uIHdyb3RlOg0KPiBPbiAxMC85
LzI0IDE3OjM1LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+IEBAIC0xMDYxLDE1ICsx
MDYxLDEzIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB0bGJfc2V0X2NvbXBhcmUoQ1BVVExCRW50
cnlGdWxsICpmdWxsLA0KPj4+IENQVVRMQkVudHJ5ICplbnQsDQo+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB2YWRkciBhZGRyZXNzLCBpbnQgZmxhZ3MsDQo+Pj4gIMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBNTVVBY2Nlc3NUeXBlIGFjY2Vzc190eXBlLCBib29sIGVuYWJsZSkNCj4+PiAgwqAg
ew0KPj4+IC3CoMKgwqAgaWYgKGVuYWJsZSkgew0KPj4+IC3CoMKgwqDCoMKgwqDCoCBhZGRy
ZXNzIHw9IGZsYWdzICYgVExCX0ZMQUdTX01BU0s7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGZs
YWdzICY9IFRMQl9TTE9XX0ZMQUdTX01BU0s7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGlmIChm
bGFncykgew0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFkZHJlc3MgfD0gVExCX0ZP
UkNFX1NMT1c7DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIH0NCj4+PiAtwqDCoMKgIH0gZWxzZSB7
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgIGFkZHJlc3MgPSAtMTsNCj4+PiAtwqDCoMKgwqDCoMKg
wqAgZmxhZ3MgPSAwOw0KPj4+ICvCoMKgwqAgaWYgKCFlbmFibGUpIHsNCj4+PiArwqDCoMKg
IGFkZHJlc3MgPSBUTEJfSU5WQUxJRF9NQVNLOw0KPj4+ICvCoMKgwqAgfQ0KPj4+ICvCoMKg
wqAgYWRkcmVzcyB8PSBmbGFncyAmIFRMQl9GTEFHU19NQVNLOw0KPj4+ICvCoMKgwqAgZmxh
Z3MgJj0gVExCX1NMT1dfRkxBR1NfTUFTSzsNCj4+PiArwqDCoMKgIGlmIChmbGFncykgew0K
Pj4+ICvCoMKgwqDCoMKgwqDCoCBhZGRyZXNzIHw9IFRMQl9GT1JDRV9TTE9XOw0KPj4+ICDC
oMKgwqDCoMKgIH0NCj4+DQo+PiBJJ20gbm90IHN1cmUgdG8gZm9sbG93IHRoaXMgY2hhbmdl
IGNvcnJlY3RseS4NCj4+IEFmdGVyLCB0aGUgZmluYWwgYWRkcmVzcyBhbmQgZmxhZ3MgdmFs
dWUgZGVwZW5kIG9uIGZsYWdzIGluIHBhcmFtZXRlciwgd2hpbGUgYmVmb3JlLCBpdA0KPj4g
dXNlZCB0byBkZXBlbmQgb24gZmxhZ3MgJiBlbmFibGUgcGFyYW1ldGVyLg0KPiANCj4gVGhp
cyBkZXNlcnZlcyB0byBiZSBzcGxpdCBvdXQ7IEkgZXZlbiB0aG91Z2h0IGFib3V0IGl0IE1v
bmRheSBuaWdodCBidXQgdGhlbiBmb3Jnb3Qgd2hlbiBJDQo+IHJlc3RhcnRlZCBvbiBUdWVz
ZGF5IG1vcm5pbmcuDQo+DQoNCkFncmVlLg0KDQo+IEJlZm9yZSwgYWRkcmVzcyBpcyAtMSBm
b3IgZGlzYWJsZWQsIG1vc3RseSBiZWNhdXNlIHRoYXQgbWlycm9ycyB3aGF0IHlvdSBnZXQg
d2l0aCBtZW1zZXQNCj4gdG8gaW5pdGlhbGl6ZSB0aGUgdGxiLiAgQWxsIG9mIHRoZSBmbGFn
cyBhcmUgZGlzY2FyZGVkLiAgQnV0IHRoZSBvbmx5IHRoaW5nIHRoYXQncw0KPiBpbXBvcnRh
bnQgaXMgdGhhdCBUTEJfSU5WQUxJRF9NQVNLIGlzIHNldC4NCj4gID4gQWZ0ZXIsIFRMQl9J
TlZBTElEX01BU0sgaXMgc3RpbGwgc2V0LCBidXQgdGhlIGZsYWdzIGFyZSByZXRhaW5lZC4g
DQpUaGlzIGlzIGJlY2F1c2Ugd2Ugd2FudA0KPiBhIHNvdXJjZSBvZiB0aG9zZSBmbGFncyB0
byB1c2UgZm9yIE1NVV9JTlNUX0ZFVENILiAgV2l0aCB0aGlzIHBhdGNoIHNldCB3ZSBubyBs
b25nZXIgc3RvcmUNCj4gZmxhZ3MgZm9yIGV4ZWN1dGUgYW5kIGluc3RlYWQgZ3JhYiB0aGVt
IGZyb20gdGhlIGZsYWdzIGZvciByZWFkLiAgRnJvbSB0bGJfc2V0X3BhZ2VfZnVsbC4uLg0K
Pg0KDQpUaGF0J3Mgc3VidGxlLiBXaGVuIHNldHRpbmcgdG8gVExCX0lOVkFMSURfTUFTSywg
aXQgc2VlbXMgdG8gaW1wbHkgd2UgDQp3b24ndCBjaGVjayBhbnkgZmxhZyBvbiB0aGlzIGVu
dHJ5LiBNYXliZSBqdXN0IGEgY29tbWVudCBhZGRlZCBoZXJlIA0Kd291bGQgY2xhcmlmeSB0
aGlzLg0KDQo+IA0KPj4+IEBAIC0xMjE1LDkgKzEyMTMsNiBAQCB2b2lkIHRsYl9zZXRfcGFn
ZV9mdWxsKENQVVN0YXRlICpjcHUsIGludCBtbXVfaWR4LA0KPj4+ICDCoMKgwqDCoMKgIC8q
IE5vdyBjYWxjdWxhdGUgdGhlIG5ldyBlbnRyeSAqLw0KPj4+ICDCoMKgwqDCoMKgIG5vZGUt
PmNvcHkuYWRkZW5kID0gYWRkZW5kIC0gYWRkcl9wYWdlOw0KPj4+IC3CoMKgwqAgdGxiX3Nl
dF9jb21wYXJlKGZ1bGwsICZub2RlLT5jb3B5LCBhZGRyX3BhZ2UsIHJlYWRfZmxhZ3MsDQo+
Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1NVV9JTlNUX0ZF
VENILCBwcm90ICYgUEFHRV9FWEVDKTsNCj4+PiAtDQo+Pj4gIMKgwqDCoMKgwqAgaWYgKHdw
X2ZsYWdzICYgQlBfTUVNX1JFQUQpIHsNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgIHJlYWRf
ZmxhZ3MgfD0gVExCX1dBVENIUE9JTlQ7DQo+Pj4gIMKgwqDCoMKgwqAgfQ0KPiANCj4gLi4u
IHdlIGNhbiBzZWUgdGhhdCB0aGUgb25seSBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIHR3byBp
cyB0aGUgd2F0Y2hwb2ludCBiaXQuDQo+IEltcG9ydGFudGx5LCBUTEJfTU1JTyBpcyBjb21t
b24gdG8gYWxsIHRocmVlIGNvbXBhcmF0b3JzLg0KPg0KPj4gU291bmRzIGdvb2QgdG8gaGF2
ZSBhIGZhc3QgcGF0aCBmb3IgY29kZSBmZXRjaC4gRGlkIHlvdSBtZWFzdXJlIHRoZSBiZW5l
Zml0LCBvciBqdXN0DQo+PiBpbXBsZW1lbnRlZCB0aGlzIHRoaW5raW5nIGl0J3Mgd29ydGg/
DQo+IA0KPiBUaGlzIGlzIG5vdCBhYm91dCBhIGZhc3QgcGF0aCBmb3IgY29kZSBmZXRjaCwg
YnV0IGFsd2F5cyB1c2luZyB0aGUgKnNsb3cqIHBhdGguICBUaGUNCj4gb2JqZWN0IGlzIHRv
IHJlcHVycG9zZSBvbmUgd29yZCBmcm9tIENQVVRMQkVudHJ5LCByZW1vdmVkIGhlcmUgYW5k
IGFkZGVkIGJhY2sgaW4gdGhlIG5leHQNCj4gcGF0Y2gsIHRvIGxpbmsgQ1BVVExCRW50cnkg
dG8gQ1BVVExCRW50cnlUcmVlIHdpdGhvdXQgY2hhbmdpbmcgc2l6ZW9mKENQVVRMQkVudHJ5
KS4NCj4NCg0KSSBtaXNzZWQgdGhlIGZhY3QgdGhhdCBNTVVfSU5TVF9GRVRDSCB3YXMgdXNl
ZCBvbmx5IHdoZW4gZmV0Y2hpbmcgY29kZSANCmF0IHRyYW5zbGF0aW9uIHRpbWUuDQoNCj4g
DQo+IHJ+DQo=

