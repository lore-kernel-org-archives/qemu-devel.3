Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE682C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seeQx-0005HJ-2w; Thu, 15 Aug 2024 13:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeQv-0005GC-A9
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:38:45 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seeQt-0001p2-HM
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:38:45 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-201d9fa899dso8891925ad.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723743521; x=1724348321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y3HjH4dZJYgclGIiedJQJmO8vgqmhtvAFQlrzEyrz2s=;
 b=Nmb2Pg6B7H3Maa0Zmsje2TFD9ADN+ne/a+pocQp8web6tXGkD5lt2T8sJDRvaspijB
 fKnGygU8hRfLMtuI4361pum1Wp2pB+mT5eoGEj1nZcCwIa/IjVv9rYS+Quj7KWbHvXuO
 EAblGM6VY6lt8zNK1+1u8Bm2BibZQPscS1xd86Bqb2XK1oAbtxKbO+2zqskrlZG38oc+
 zAXYYDbj2rimhXz3e2uO+mOZCt4zI9lUpwXzRgUCBoLOR5NryXXdYlIXuCLcU2lcStPJ
 pnfbKYs0Pb5Id5eYKmESEgBOkeMOsjqC6opEW6VwVWodJW34SXp7eCP3iBMxEbeIWay8
 qQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723743521; x=1724348321;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y3HjH4dZJYgclGIiedJQJmO8vgqmhtvAFQlrzEyrz2s=;
 b=S1s9tFQr1pT38GpSqENCh8hbbG72do+5oyJR6lczj3IdfLfFA2jVu+50hdIwAWOKSP
 jpkb8M9KiqJ+ApwlZ93fWHOqWAtddX3xKW+KkIg/G/iosK/UhiaMFCaAp+bk03JY8BYj
 Y7FjFb8jiWDnnYz8uNkVzU203SUCF1+aW3kENySEPNda511XcjzWEBUbK91/VoagOT6Q
 LmnBd/5Z5qSeo1ijlNbyZ4l4mcz0ZlA4PTkwKyi/bfJQvXNEmhbADO+xtKIetXthCEf1
 XaL5/wptNia+DldvbIdamXJQ+KiVVBKxJaIVNkREN6jydboB3dPV1eRjZ8sZbWO2S75o
 rFCw==
X-Gm-Message-State: AOJu0YysiRvdF1ZVM748xC1iS3jZPyzlsq6BauN7Nx57gOIYVL75m3bX
 Q0u1wh1xKLtn79MY8tszdiscrS6SUsN47t0umAV+TgIQo5wq/hEk3QGyoLUsOvk=
X-Google-Smtp-Source: AGHT+IEAiA/olozTgqYjN5GOr6o0CN/HQ+mtqwhNVBXA8+F43Tk6IYekefV+wedi2Y0O3lrDuyaOkw==
X-Received: by 2002:a17:902:f90f:b0:1fc:6b8b:4918 with SMTP id
 d9443c01a7336-20203f3238fmr3871565ad.41.1723743521255; 
 Thu, 15 Aug 2024 10:38:41 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f0379ab3sm12474465ad.137.2024.08.15.10.38.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:38:40 -0700 (PDT)
Message-ID: <10d3fd64-bb03-487b-afd2-28e0f5e014c6@linaro.org>
Date: Thu, 15 Aug 2024 10:38:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] contrib/plugins/cache: fix warning when compiling on
 32bits host
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-3-pierrick.bouvier@linaro.org>
 <491b34f6-a81a-4793-984c-6a588910d0e1@redhat.com>
 <87ttfm2em2.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <87ttfm2em2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gOC8xNS8yNCAwNDo0NiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaG9tYXMgSHV0aCA8
dGh1dGhAcmVkaGF0LmNvbT4gd3JpdGVzOg0KPiANCj4+IE9uIDE1LzA4LzIwMjQgMDEuMzYs
IFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gRm91bmQgb24gZGViaWFuIHN0YWJsZSAo
aTM4NikuDQo+Pj4gLi4vY29udHJpYi9wbHVnaW5zL2NhY2hlLmM6IEluIGZ1bmN0aW9uICd2
Y3B1X3RiX3RyYW5zJzoNCj4+PiAuLi9jb250cmliL3BsdWdpbnMvY2FjaGUuYzo0Nzc6MzA6
IGVycm9yOiBjYXN0IGZyb20gcG9pbnRlciB0byBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXpl
IFstV2Vycm9yPXBvaW50ZXItdG8taW50LWNhc3RdDQo+Pj4gICAgIDQ3NyB8ICAgICAgICAg
ICAgIGVmZmVjdGl2ZV9hZGRyID0gKHVpbnQ2NF90KSBxZW11X3BsdWdpbl9pbnNuX2hhZGRy
KGluc24pOw0KPj4+ICAgICAgICAgfA0KPj4+IFNpZ25lZC1vZmYtYnk6IFBpZXJyaWNrIEJv
dXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+PiAtLS0NCj4+PiAgICBj
b250cmliL3BsdWdpbnMvY2FjaGUuYyB8IDYgKysrLS0tDQo+Pj4gICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+PiBkaWZmIC0tZ2l0IGEv
Y29udHJpYi9wbHVnaW5zL2NhY2hlLmMgYi9jb250cmliL3BsdWdpbnMvY2FjaGUuYw0KPj4+
IGluZGV4IDUxMmVmNjc3NmI3Li44MmVkNzM0ZDZkNCAxMDA2NDQNCj4+PiAtLS0gYS9jb250
cmliL3BsdWdpbnMvY2FjaGUuYw0KPj4+ICsrKyBiL2NvbnRyaWIvcGx1Z2lucy9jYWNoZS5j
DQo+Pj4gQEAgLTQ3MSwxMiArNDcxLDEyIEBAIHN0YXRpYyB2b2lkIHZjcHVfdGJfdHJhbnMo
cWVtdV9wbHVnaW5faWRfdCBpZCwgc3RydWN0IHFlbXVfcGx1Z2luX3RiICp0YikNCj4+PiAg
ICAgICAgbl9pbnNucyA9IHFlbXVfcGx1Z2luX3RiX25faW5zbnModGIpOw0KPj4+ICAgICAg
ICBmb3IgKGkgPSAwOyBpIDwgbl9pbnNuczsgaSsrKSB7DQo+Pj4gICAgICAgICAgICBzdHJ1
Y3QgcWVtdV9wbHVnaW5faW5zbiAqaW5zbiA9IHFlbXVfcGx1Z2luX3RiX2dldF9pbnNuKHRi
LCBpKTsNCj4+PiAtICAgICAgICB1aW50NjRfdCBlZmZlY3RpdmVfYWRkcjsNCj4+PiArICAg
ICAgICB1aW50cHRyX3QgZWZmZWN0aXZlX2FkZHI7DQo+Pj4gICAgICAgICAgICAgIGlmIChz
eXMpIHsNCj4+PiAtICAgICAgICAgICAgZWZmZWN0aXZlX2FkZHIgPSAodWludDY0X3QpIHFl
bXVfcGx1Z2luX2luc25faGFkZHIoaW5zbik7DQo+Pj4gKyAgICAgICAgICAgIGVmZmVjdGl2
ZV9hZGRyID0gKHVpbnRwdHJfdCkgcWVtdV9wbHVnaW5faW5zbl9oYWRkcihpbnNuKTsNCj4+
PiAgICAgICAgICAgIH0gZWxzZSB7DQo+Pj4gLSAgICAgICAgICAgIGVmZmVjdGl2ZV9hZGRy
ID0gKHVpbnQ2NF90KSBxZW11X3BsdWdpbl9pbnNuX3ZhZGRyKGluc24pOw0KPj4+ICsgICAg
ICAgICAgICBlZmZlY3RpdmVfYWRkciA9ICh1aW50cHRyX3QpDQo+Pj4gcWVtdV9wbHVnaW5f
aW5zbl92YWRkcihpbnNuKTsNCj4+PiAgICAgICAgICAgIH0NCj4+DQo+PiBJcyB0aGlzIHRo
ZSByaWdodCBmaXg/IEkgYXNzdW1lIGVmZmVjdGl2ZV9hZGRyIHN0b3JlcyBhbiBhZGRyZXNz
IG9mDQo+PiB0aGUgZ3Vlc3QsIHNvIGlmIHRoZSBndWVzdCBpcyA2NC1iaXQgYW5kIHRoZSBo
b3N0IGlzIDMyLWJpdCwgeW91IG5vdw0KPj4gbG9zZSB0aGUgdXBwZXIgYml0cyBvZiB0aGUg
YWRkcmVzcy4uLj8NCj4gDQo+IEkgdGhpbmsgdGhlIHByb2JsZW0gaXMgaGlnaGVyIHVwLCBp
dCB3YXMgYSBtaXN0YWtlIHRvIGhhdmU6DQo+IA0KPiAgICB2b2lkICpxZW11X3BsdWdpbl9p
bnNuX2hhZGRyKGNvbnN0IHN0cnVjdCBxZW11X3BsdWdpbl9pbnNuICppbnNuKTsNCj4gDQo+
IHJldHVybiAqdm9pZCwgYXQgbGVhc3QgdmFkZHIgcmV0dXJucyBhbiBleHBsaWNpdCA2NCBi
aXQgdmFsdWUgd2hpY2ggY2FuDQo+IGhvbGQgZXZlcnl0aGluZyAoYXQgYSBzbGlnaHQgZXhw
ZW5zZSB0byAzMmJpdCBlbXVsYXRpb24gaG9zdHMsIGJ1dA0KPiBzZXJpb3VzbHkgc3RvcCBk
b2luZyB0aGF0IHdlJ3ZlIGJlZW4gaW4gdGhlIDY0Yml0IHdvcmxkIGZvciBzb21lIHRpbWUN
Cj4gbm93KS4NCj4gDQoNCkl0J3MgYW4gb3BlbiBxdWVzdGlvbiBJIGhhZC4gV2hlbiBleGVj
dXRpbmcgNjQgYml0cyBiaW5hcmllcyBvbiBhIDMyIA0KYml0cyBob3N0LCBhcmUgd2UgZW11
bGF0aW5nIHRoZSBmdWxsIDY0IGJpdHMgYWRkcmVzcyBzcGFjZSwgb3IgZG8gd2UgDQpyZXN0
cmljdCB0byAzMiBiaXRzPyBGb3IgdXNlciBtb2RlLCBJIGRvbid0IHNlZSBob3cgaXQgY291
bGQgYmUgcG9zc2libGUgDQp0byBoYXZlIGFkZHJlc3Mgc3BhY2UgYmV5b25kIHRoZSAzMiBi
aXRzIHJhbmdlLCBidXQgc3lzdGVtIG1vZGUgaXMgDQpwcm9iYWJseSBkaWZmZXJlbnQuDQoN
ClRoZSByZWFsIHByb3BlciBmaXggaXMgdG8gbm90IGVuY29kZSBkaXJlY3RseSB2YWx1ZSB1
bmRlciB1ZGF0YSBmb3IgDQpjYWxsYmFja3MsIGJ1dCBhbGxvY2F0ZSB0aGlzIGFuZCBwYXNz
IGEgcG9pbnRlciBpbnN0ZWFkLg0KDQo+Pg0KPj4gVGhlIGNhc3RpbmcgZm9yIHFlbXVfcGx1
Z2luX2luc25fdmFkZHIgaXMgbm90IHJlcXVpcmVkIGF0IGFsbCBzaW5jZSBpdA0KPj4gYWxy
ZWFkeSByZXR1cm5zIGFuIHVpbnQ2NF90LCBzbyB5b3UgY2FuIHJlbW9lIHRoYXQgb25lLiBG
b3IgdGhlIGhhZGRyDQo+PiBwYXJ0LCBtYXliZSBkbyBhIGRvdWJsZS1jYXN0Og0KPj4NCj4+
ICAgIGVmZmVjdGl2ZV9hZGRyID0gKHVpbnQ2NF90KSh1aW50cHRyX3QpcWVtdV9wbHVnaW5f
aW5zbl9oYWRkcihpbnNuKQ0KPj4NCj4+ID8NCj4+DQo+PiAgIFRob21hcw0KPiANCg==

