Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01E7C27C75
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 15:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH3U1-0003MG-BB; Tue, 11 Jun 2024 11:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sH3U0-0003M4-Id
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:32:24 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sH3Tw-0006Jh-9j
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 11:32:24 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1f4a0050b9aso47964465ad.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 08:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718119938; x=1718724738; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eG7XOGjL1NCNTpejGsE7L6EYRktGj9qQdfmrwyqQAXE=;
 b=oRSnDjIHp2tu7BYWXYWA0O1YcKgpyxn+z/v14PliiqXuhxE/TnPckw0T/auOCZcoV9
 kM+EKBH9EJ/syKcxH9gzO3CnZd6e/7Xt6tydG/4872ibdxNi5Ak57+go1LhIGGqkVpX+
 tpH5AimBq/Nn3TdITWmoHH1A2G4LiKGx/hG1egfVJs9JDt5dVZ4y4WeEzNQK19JQQJSy
 4gnJWJw9CkFcvq14BOo2knJIAd3waSuHqEn62Klcp8O76RD8t0jULzo8XiPEe8Ut+ikw
 r1keoFxYGjSaY2zslBmP8IiHA+7G/g+gA7F2vQWR4d3c039EoDDHPNet8cJ+qPIXCYnV
 ZhXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718119938; x=1718724738;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eG7XOGjL1NCNTpejGsE7L6EYRktGj9qQdfmrwyqQAXE=;
 b=TafML1zS2OrZwDDRrDEIPKnF7HTDc+1gq+TA0czY3fgmDFN56dxQWkACEFAtOvkxYB
 cjqKU/YzzgMOHXL/lEAhwNUM4Fu1DC2hyV8ihcjMQRjUnOnFXL+dJzmOuOQhnsYF89+Q
 skEEF3L17L/99fDDaQxPGWmE7PMrSnHJKE3PHfaZadcynCemevwMt7JtIsSG6kb+EGOO
 pxTSisNqFrQIxR5OK/rENs1nwpQ1KHwWdQxnztJyqGGXnLAbBE1ZDsKaw7S15oZ3HgMG
 pBqHCT2MF7atOVQmlbwBBrnPSuK2auIjxLPXv6aX93I6RCezszL+gPbIuxklmYlYWZeH
 94VQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTTC3QIzbfmaIcgTXNyZsslVIxLpe4pfmL8aLa3hjJZ+NWZYQzzTHVrq8VrrDJQtB9vQsXckBLpFlo+ZX2xaREbosWwis=
X-Gm-Message-State: AOJu0YxAMtPqLHMhIWSae0tk8mVfRVvAKs1R8PVOxQdvv7HkWxoKbi1N
 8kXUGNplY0PyLR8b2ugVmE0MSJ+jlwANI1BG56yUBwfzrkWGd3izvjyW0EdzLRc=
X-Google-Smtp-Source: AGHT+IFEBDas8C15kSDEKIY6mlkqDYow3XTSoOZcGdN9xdcmpg7UYFCxD+YTRQdwR7JJluw+09ixgg==
X-Received: by 2002:a17:903:1c8:b0:1f7:d1d:21ed with SMTP id
 d9443c01a7336-1f70d1d29e3mr60100665ad.19.1718119938373; 
 Tue, 11 Jun 2024 08:32:18 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6fbea199esm57386995ad.196.2024.06.11.08.32.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 08:32:17 -0700 (PDT)
Message-ID: <fecbcab1-1955-4369-a420-215105adbe93@linaro.org>
Date: Tue, 11 Jun 2024 08:32:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/6] Implement ARM PL011 in Rust
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr_=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud_=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>
References: <cover.rust-pl011-rfc-v1.git.manos.pitsidianakis@linaro.org>
 <d910708f-ed55-4eee-8f66-8703cb45081c@linaro.org>
 <evt7n.ggoypj31l14q@linaro.org>
 <6e7a14a1-8727-4ce5-ae67-797323704464@linaro.org>
 <87o787zvfi.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87o787zvfi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

T24gNi8xMS8yNCAwMjoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiA2
LzEwLzI0IDEzOjI5LCBNYW5vcyBQaXRzaWRpYW5ha2lzIHdyb3RlOg0KPj4+IE9uIE1vbiwg
MTAgSnVuIDIwMjQgMjI6MzcsIFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
bGluYXJvLm9yZz4gd3JvdGU6DQo+Pj4+IEhlbGxvIE1hbm9zLA0KPj4+Pg0KPiA8c25pcD4N
Cj4+Pj4gRXhjZWxsZW50IHdvcmssIGFuZCB0aGFua3MgZm9yIHBvc3RpbmcgdGhpcyBSRkMh
DQo+Pj4+DQo+Pj4+IElNSE8sIGhhdmluZyBwYXRjaGVzIDIgYW5kIDUgc3BsaXR0ZWQgaXMg
YSBiaXQgY29uZnVzaW5nLCBhbmQgZXhwb3NpbmcNCj4+Pj4gKHRlbXBvcmFyaWx5KSB0aGUg
Z2VuZXJhdGVkLnJzIGZpbGUgaW4gcGF0Y2hlcyBpcyBub3QgYSBnb29kIG1vdmUuDQo+Pj4+
IEFueSByZWFzb24geW91IGtlcHQgaXQgdGhpcyB3YXk/DQo+Pj4gVGhhdCB3YXMgbXkgZmly
c3QgYXBwcm9hY2gsIEkgd2lsbCByZXdvcmsgaXQgb24gdGhlIHNlY29uZCB2ZXJzaW9uLg0K
Pj4+IFRoZQ0KPj4+IGdlbmVyYXRlZCBjb2RlIHNob3VsZCBub3QgZXhpc3QgaW4gY29tbWl0
dGVkIGNvZGUgYXQgYWxsLg0KPj4+IEl0IHdhcyBpbml0YWxseSB0cmlja3kgc2V0dGluZyB1
cCB0aGUgZGVwZW5kZW5jeSBvcmRlcnMgY29ycmVjdGx5LA0KPj4+IHNvIEkNCj4+PiBmaXJz
dCBjb21taXR0ZWQgaXQgYW5kIHRoZW4gbWFkZSBpdCBhIGRlcGVuZGVuY3kuDQo+Pj4NCj4+
Pj4NCj4+Pj4gTWF5YmUgaXQgY291bGQgYmUgYmV0dGVyIGlmIGJ1aWxkLnJzIGZpbGUgd2Fz
ICpub3QqIG5lZWRlZCBmb3IgbmV3DQo+Pj4+IGRldmljZXMvZm9sZGVycywgYW5kIGNvdWxk
IGJlIGFic3RyYWN0ZWQgYXMgYSBkZXRhaWwgb2YgdGhlIHB5dGhvbg0KPj4+PiB3cmFwcGVy
IHNjcmlwdCBpbnN0ZWFkIG9mIHNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBjb21taXR0ZWQu
DQo+Pj4gVGhhdCdkIG1lYW4geW91IGNhbm5vdCB3b3JrIG9uIHRoZSBydXN0IGZpbGVzIHdp
dGggYSBMYW5ndWFnZVNlcnZlciwNCj4+PiB5b3UNCj4+PiBjYW5ub3QgcnVuIGNhcmdvIGJ1
aWxkIG9yIGNhcmdvIGNoZWNrIG9yIGNhcmdvIGNsaXBweSwgZXRjLiBUaGF0J3Mgd2h5IEkN
Cj4+PiBsZWZ0IHRoZSBhbHRlcm5hdGl2ZSBjaG9pY2Ugb2YgaW5jbHVkaW5nIGEgbWFudWFs
bHkgZ2VuZXJhdGVkIGJpbmRpbmdzDQo+Pj4gZmlsZSAoZ2VuZXJhdGVkLnJzLmluYykNCj4+
Pg0KPj4NCj4+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZywgYnV0IGl0IHNlZW1zIGxpa2Ug
aXQganVzdCBjaGVja3MvY29waWVzIHRoZQ0KPj4gZ2VuZXJhdGVkLnJzIGZpbGUgd2hlcmUg
aXQncyBleHBlY3RlZC4gRGVmaW5pdGVseSBzb21ldGhpbmcgdGhhdCBjb3VsZA0KPj4gYmUg
ZG9uZSBhcyBwYXJ0IG9mIHRoZSBydXN0IGJ1aWxkLg0KPj4NCj4+IEhhdmluZyB0byBydW4g
dGhlIGJ1aWxkIGJlZm9yZSBnZXR0aW5nIGNvbXBsZXRpb24gZG9lcyBub3Qgc2VlbSB0byBi
ZQ0KPj4gYSBodWdlIGNvbXByb21pc2UuDQo+Pg0KPiA8c25pcD4NCj4gDQo+IEFzIGxvbmcg
YXMgdGhlIExhbmd1YWdlIFNlcnZlciBjYW4ga2ljayBpbiBhZnRlciBhIGZpcnN0IGJ1aWxk
LiBSdXN0DQo+IGRlZmluaXRlbHkgbGVhbnMgaW4gdG8gdGhlIGNvbmNlcHQgb2YgdGhlIHRv
b2xpbmcgaGVscGluZyB5b3Ugb3V0IHdoaWxlDQo+IGNvZGluZy4NCj4gDQo+IEkgdGhpbmsg
Zm9yIHRoZSBDIExTUHMgY29tcGlsZV9jb21tYW5kcy5qc29uIGlzIGdlbmVyYXRlZCBkdXJp
bmcgdGhlDQo+IGNvbmZpZ3VyZSBzdGVwIGJ1dCBJIGNvdWxkIGJlIHdyb25nLg0KPiANCg0K
WWVzLCBtZXNvbiBnZW5lcmF0ZXMgaXQuDQpJIGFncmVlIGhhdmluZyBzdXBwb3J0IGZvciBj
b21wbGV0aW9uIHRvb2xpbmcgaXMgaW1wb3J0YW50IG5vd2FkYXlzLCANCndoZXRoZXIgaW4g
QyBvciBpbiBSdXN0Lg0K

