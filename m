Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4430C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 21:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXRtO-0000ig-MF; Mon, 13 Jan 2025 16:22:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXRtN-0000iK-Qp
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:22:37 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXRtM-0004or-1s
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 16:22:37 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-216426b0865so83446325ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736803354; x=1737408154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jb3/J/Tjc1TI8iveva0nI8pL3vopIhVQhyX+n4ROJ4g=;
 b=wymp++eVwL+oDmfo40ZkShZG+e9u8nwNX23mlYfmcET4sDEMIOg5wjOx5NumurRyTh
 p42lMop578i8Uzr830EM4o/ZqapLsBeYmNEjnN2kXSv26FMA3k2/OtN7MCkcdqw5WJbU
 sh1gAZ8UAIYafGzF3KGccMmPzqAYuXdWv/k2/cCooELG+ZU2jPg1nFBih4B8BCucVH5F
 jGcOaqk/QDqWW6J8+Io9L3xJPwvURq/gkPySGVbTYMK6sCHdJBflCdyeI5QQoC6zYvqz
 ou4HIppCO3niEzohaPAPHyTFLzjd42QO7JQPc2Xyhf7AUvSobzf2HZ+ieL0UElsIJv1x
 gagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736803354; x=1737408154;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jb3/J/Tjc1TI8iveva0nI8pL3vopIhVQhyX+n4ROJ4g=;
 b=vw1D7JjQAV35Hwt3mwtBBasf30onPEVViu88xX+DlMAJQAoyiEHA9Vh926UiEW+AKt
 F7ARBGnaTxP10KMrLIrpacrpw/9IR+s43USCK5o9crxZg5yaCSHPEBJxovKY81DvDtQt
 6hdZNIFEZXepE2Qj/t0x4KIN0xGsVjW/yN4LYady55YFJDIcmUzKMsiurODn/W9wdaSN
 BaP67rO60FwR0PTwq3As6gIIJlBdot4bmrR9tZXa0mu+k86yk64AP8tbtTRqXUCnoc1o
 c55N6eV9ZeaPlxjh1+cXNn/cFaOCUdlFv/3ipp/nbFmNB0lCT5hQe+vPVzH0BFLDPnX4
 cXMQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTxn8UaGVxEuhvdwh896432G2JY43llCu7g+yponvvr95nCvK38YF+unxTkqyJFDHMnYsDg242Hq1N@nongnu.org
X-Gm-Message-State: AOJu0YzUx8pYhjy8YmWvlGRl3a8Z69scaf6fDq9Y9zr1YKsbs7jpV0WO
 bUHb/U2laFaUg0jFoA+grP6RcyLRj2yiUNyXM3UXLqt4K0vAru6SJ9zvi2TWCqw=
X-Gm-Gg: ASbGncu333zjXU+LeHx8iOI59+Wz3yyTrA6Pi5f9wyXmSHaMJaxvsr3eotf4TT2NUWS
 durmHFL0uM5n1oHK1PNtLAh/aHa8MTjuz/gZt0eonrT8AMOH1RLRLFcw/Oqp1GHfidhoN4hoJKX
 BhMuobFz8cRKcqSOU/c7qoPvGgjxSOPQMsxf1yBKN8c1xLem5j/0L31kHPs3llcixjztcR79ezR
 l8iTA0NNiBZYLubXJfdrrOLBuUgu1AsQX83Q2aXG0imcg3Q6QSyNwgLrMlo+tTCI52nyQ==
X-Google-Smtp-Source: AGHT+IEyF2DWgZx3PrdbnMOxXT4Mxrsr5eYkpK+ZfLqHFXMhsYz04dDZ36U97Ck/sIFO3Zj1ubhzdQ==
X-Received: by 2002:a17:902:e5c2:b0:215:6f5d:b756 with SMTP id
 d9443c01a7336-21a83f36e79mr298867755ad.7.1736803354348; 
 Mon, 13 Jan 2025 13:22:34 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21a9f10f860sm57481725ad.46.2025.01.13.13.22.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 13:22:33 -0800 (PST)
Message-ID: <8d54ad80-f91b-4170-8f06-a387aeb649e8@linaro.org>
Date: Mon, 13 Jan 2025 13:22:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <73fd2f38-76a0-4274-875a-6f96faed79f6@linaro.org>
 <bc22d713-201e-414c-838e-6c0dc1fb3807@linaro.org>
 <876fe41d-df26-4a13-a465-feeee0004746@redhat.com>
 <6adc2994-e762-4923-9033-54efe165aaea@linaro.org>
 <87y0zejttk.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y0zejttk.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

T24gMS8xMy8yNSAxMzoxOSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBPbiAx
LzEyLzI1IDIyOjI2LCBUaG9tYXMgSHV0aCB3cm90ZToNCj4+PiBPbiAxMS8wMS8yMDI1IDE2
LjQ3LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+Pj4gT24gMTAvMS8yNSAy
MTozNywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+Pj4+IE9uIDEvMTAvMjUgMTI6MzMs
IFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4+Pj4gRm9yIG5vdywgaXQgd2FzIG9ubHkg
cG9zc2libGUgdG8gYnVpbGQgcGx1Z2lucyB1c2luZyBHQ0Mgb24gV2luZG93cy4NCj4+Pj4+
PiBIb3dldmVyLA0KPj4+Pj4+IHdpbmRvd3MtYWFyY2g2NCBvbmx5IHN1cHBvcnRzIENsYW5n
Lg0KPj4+Pj4+IFRoaXMgYmlnZ2VzdCByb2FkYmxvY2sgd2FzIHRvIGdldCByaWQgb2YgZ2Nj
X3N0cnVjdCBhdHRyaWJ1dGUsIHdoaWNoIGlzIG5vdA0KPj4+Pj4+IHN1cHBvcnRlZCBieSBD
bGFuZy4gQWZ0ZXIgaW52ZXN0aWdhdGlvbiwgd2UgcHJvdmVkIGl0IHdhcyBzYWZlIHRvIGRy
b3AgaXQuDQo+Pj4+Pj4NCj4+Pj4+PiBCdWlsdCBhbmQgdGVzdGVkIG9uIFdpbmRvd3MgKGFs
bCBtc3lzIGVudikvTGludXgvTWFjT1MgZm9yIHg4Nl82NCBhbmQNCj4+Pj4+PiBhYXJjaDY0
DQo+Pj4+Pj4gaG9zdHMuDQo+Pj4+Pj4NCj4+Pj4+PiB2MSBjb250YWluZWQgd2FybmluZyBm
aXhlcyBhbmQgdmFyaW91cyBiaXRzIHRoYXQgaGF2ZSBiZWVuIHVwc3RyZWFtZWQNCj4+Pj4+
PiBhbHJlYWR5Lg0KPj4+Pj4+IFRoZSBvbmx5IGJpdHMgbGVmdCBpbiB0aGlzIHNlcmllcyBh
cmUgdGhlIGdjY19zdHJ1Y3QgcmVtb3ZhbCwgYW5kIGZpeGluZyB0aGUNCj4+Pj4+PiBwbHVn
aW5zIGJ1aWxkIHdpdGggY2xhbmcuDQo+Pj4+Pj4NCj4+Pj4+PiBUaGlzIHNlcmllcyBpcyBm
b3IgMTAuMCwgYXMgd2UgZGVjaWRlZCB0byBub3QgaW5jbHVkZSB0aGUgZ2NjX3N0cnVjdA0K
Pj4+Pj4+IHJlbW92YWwgaXMNCj4+Pj4+PiA5LjIgcmVsZWFzZS4NCj4+Pj4+Pg0KPj4+Pj4+
IEFsbCBwYXRjaGVzIGFyZSBub3cgcmV2aWV3ZWQsIHNvIHRoaXMgc2VyaWVzIGNhbiBiZSBw
dWxsZWQuIEknbGwgcmVwb3J0DQo+Pj4+Pj4gdGhhdCB0bw0KPj4+Pj4+IE1TWVMyIHRvbywg
c28gd2UgY2FuIGVuYWJsZSBjbGFuZyBlbnZpcm9ubWVudHMgZm9yIFFFTVUuDQo+Pj4+Pj4N
Cj4+Pj4+PiB2MTogaHR0cHM6Ly9wYXRjaGV3Lm9yZy9RRU1VLzIwMjQxMDMxMDQwNDI2Ljc3
MjYwNC0xLQ0KPj4+Pj4+IHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZy8NCj4+Pj4+Pg0K
Pj4+Pj4+IHYyOg0KPj4+Pj4+IC0gZHJvcCBhdHRyaWJ1dGUgZ2NjX3N0cnVjdCBpbnN0ZWFk
IG9mIHVzaW5nIC1tbm8tbXMtYml0ZmllbGRzIG9wdGlvbg0KPj4+Pj4+IC0gYWRkIGEgc2Vj
dGlvbiBhYm91dCBiaXRmaWVsZHMgaW4gZG9jdW1lbnRhdGlvbg0KPj4+Pj4+DQo+Pj4+Pj4g
djM6DQo+Pj4+Pj4gLSBleHBsYWluIHdoeSBnY2Nfc3RydWN0IGF0dHJpYnV0ZSBtYXR0ZXJz
IGluIHBhY2tlZCBzdHJ1Y3RzIGluIGNvbW1pdA0KPj4+Pj4+IG1lc3NhZ2UNCj4+Pj4+PiAt
IHJld29yZCB0aGUgYml0ZmllbGRzIGRvY3VtZW50YXRpb24gd2l0aCBzdWdnZXN0aW9ucyBn
aXZlbg0KPj4+Pj4+DQo+Pj4+Pj4gdjQ6DQo+Pj4+Pj4gLSBlZGl0IGZvciBiaXRmaWVsZHMg
ZG9jIHJlcXVlc3RlZCBieSBQaGlsaXBwZQ0KPj4+Pj4+DQo+Pj4+Pj4gUGllcnJpY2sgQm91
dmllciAoMyk6DQo+Pj4+Pj4gICDCoMKgIHdpbjMyOiByZW1vdmUgdXNhZ2Ugb2YgYXR0cmli
dXRlIGdjY19zdHJ1Y3QNCj4+Pj4+PiAgIMKgwqAgZG9jcy9kZXZlbC9zdHlsZTogYWRkIGEg
c2VjdGlvbiBhYm91dCBiaXRmaWVsZCwgYW5kIGRpc2FsbG93IHRoZW0gZm9yDQo+Pj4+Pj4g
ICDCoMKgwqDCoCBwYWNrZWQgc3RydWN0dXJlcw0KPj4+Pj4+ICAgwqDCoCBwbHVnaW5zOiBl
bmFibGUgbGlua2luZyB3aXRoIGNsYW5nL2xsZA0KPj4+Pj4+DQo+Pj4+Pj4gICDCoCBkb2Nz
L2RldmVsL3N0eWxlLnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDIwICsrKysrKysrKysrKysrKysrKysNCj4+Pj4+PiAgIMKgIG1lc29uLmJ1aWxk
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCA2ICsrKy0tLQ0KPj4+Pj4+ICAgwqAgaW5jbHVkZS9xZW11L2NvbXBpbGVy
LmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDcgKy0tLS0tLQ0K
Pj4+Pj4+ICAgwqAgc2NyaXB0cy9jb2NjaS1tYWNyby1maWxlLmjCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDYgKy0tLS0tDQo+Pj4+Pj4gICDCoCBzdWJwcm9qZWN0cy9s
aWJ2aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaCB8wqAgNiArLS0tLS0NCj4+Pj4+PiAgIMKg
IGNvbnRyaWIvcGx1Z2lucy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDIgKy0NCj4+Pj4+PiAgIMKgIHBsdWdpbnMvbWVzb24uYnVpbGTCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI0ICsrKysrKysrKysrKysr
KysrKystLS0tDQo+Pj4+Pj4gICDCoCB0ZXN0cy90Y2cvcGx1Z2lucy9tZXNvbi5idWlsZMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMyArLS0NCj4+Pj4+PiAgIMKgIDggZmlsZXMg
Y2hhbmdlZCwgNDggaW5zZXJ0aW9ucygrKSwgMjYgZGVsZXRpb25zKC0pDQo+Pj4+Pj4NCj4+
Pj4+DQo+Pj4+PiBJdCB3b3VsZCBiZSBuaWNlIGlmIGEgbWFpbnRhaW5lciBjb3VsZCBwdWxs
IHRoaXMsIHNvIHdlIGNhbiBnZXQgdGhpcw0KPj4+Pj4gbWVyZ2VkIHVwc3RyZWFtLg0KPj4+
Pg0KPj4+PiBUaGF0J2QgYmUgVGhvbWFzIG9yIEFsZXggSSBzdXBwb3NlLg0KPj4+IFRoaXMg
dG91Y2hlcyBwbHVnaW5zLCBzbyBJIHRoaW5rIGl0IHNob3VsZCBnbyB0aHJvdWdoIEFsZXgn
IHRyZWU/DQo+Pj4gICAgIFRob21hcw0KPj4+DQo+Pg0KPj4gSXQncyB0b3VjaGluZyBwbHVn
aW5zLCBidXQgaXQgZG9lcyBhIHN5c3RlbSB3aWRlIGNoYW5nZSBhcyB3ZWxsICh3aGljaA0K
Pj4gaXMgdGhlIG1vc3QgaW1wb3J0YW50IHBhcnQpLg0KPj4NCj4+IEl0J3Mgbm90IHJlYWxs
eSBpbXBvcnRhbnQgd2hvIG1lcmdlcyB0aGlzLCBidXQgaXQgd291bGQgYmUgYmV0dGVyIGlm
DQo+PiB0aGUgc2VyaWVzIGNvdWxkIGJlIHB1bGxlZCBhcyBhIHdob2xlLCBpbnN0ZWFkIG9m
IGJyZWFraW5nIGl0IGludG8NCj4+IG11bHRpcGxlIHN1YnN5c3RlbXMuDQo+IA0KPiBJJ2xs
IGxvb2sgYXQgaXQgdG9tb3Jyb3cgd2hlbiBnb2luZyB0aHJvdWdoIG15IG1haW50YWluZXIg
cXVldWUuDQo+DQoNClRoYW5rcyBBbGV4IDopLg0KDQo+Pg0KPj4gVGhhbmtzLA0KPj4gUGll
cnJpY2sNCj4gDQoNCg==

