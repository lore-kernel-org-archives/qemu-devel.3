Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3620EC02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 20:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQsV-0004bq-C5; Mon, 13 Jan 2025 15:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQsO-0004Zv-0V
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:17:34 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tXQsM-0001km-0B
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 15:17:31 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2163dc5155fso86613405ad.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 12:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736799448; x=1737404248; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JMLQYtwFUFChrj7pruOA6x3nyDx4SBOqxoo8vv1iDa0=;
 b=M53e52+w6DLdlB/gO3ZoH7h+ySsX3K8O4K2Rcwht4ByPnroFZ9Zfm4BduseyY7xsuB
 iYmop1AvlHiTwjaNmKIR25M9/FYZIGXCwDMmJMzrxZdDMS0j94pqsSTELS8rDi8lcK/j
 xvpKcOzvfDF+xldtTQNTGlVEOI0oPewJDPJztMgVi9eJbuYype7dP3QI7bk9apxasVPQ
 IXg3DmW8z359mHLATfCCpx02ajGmRXRYDwecAd6DW0B9IyIvpeD48fOQW3/oy96uqHFu
 rEdFI9XB9GlLppCFBES1kIrdk3z9Etl2A+z1u20q8L8c9xKWoS0EAW4uvOA/DQ4QOI3e
 valA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736799448; x=1737404248;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JMLQYtwFUFChrj7pruOA6x3nyDx4SBOqxoo8vv1iDa0=;
 b=Kbe5EBiw5RkRmTkMbKO0JjEz3QpmkUWkqskc0HRb1jvcVpuNFtvyJFE95IoUgwNk/r
 IMUOXdB9dLU5/AHbWCMqC1XxZBleehD9lWCUjUy0pLkbvfK6/HjnT9iZL2j9RoQUrBFG
 ++f74k7Oi/Hiv+mjaKaHyB4hHGU9ms0H9gwR5prMpuCbzSWYglw4ZQC3PcjN9/RGTP6z
 6VR8OyCVwwHJl7bdUBvAjWTzequXxr7cCdikem7H4rjWAQsmW1t+tk1o0HjY9PvyWS4H
 FTeUs/BQycQ6s7YU38FRW6K4zMS5Ob2RXGQXCl0aGrBtJOOMzULN6m1BFs7fTE4iM0Ea
 CVJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKxezOQspGdz+mBLdP9IJOzUn9BeOk/Rle9hv8v9hsBAMMXO5n2aYxLFaEUTtzfBzbRztF7Irg9g+e@nongnu.org
X-Gm-Message-State: AOJu0YwFI7/CMCxiMgNiSZgbDvYe8amBf84+BdY29upunvzBVSwNlMHt
 k7KqWEKerCu7Rgd+H+xmzZx40kJwxQAG2GUPD+MZgSifq+8EQOhxCSEQTw5jK/I=
X-Gm-Gg: ASbGncs6or8j7uutsmDQdkW574jQiHBMxxica4BWhqNSWHMUED2/FktR8Cq4I+j+jXH
 Oup9ScJc5h3HCZ6htEHz6oi4W8XwkttnhEkzsv/6k4vndxikii0sGo8LJmuvspI3M72LJOYkuP+
 6qbF4MNqU+MBsVNImLW5XDEx/rrKs9xOeVwvBL1P2h7KX3C9uU30t+H2qaIqpONyUYmsfvX4nfu
 fk8C6lKgu68kq1HuJfqqGmT0sEPaFtE+AHBHn4ZqAOyPSCz0ip5ulzOwumyhXuwBrdUOg==
X-Google-Smtp-Source: AGHT+IFMCdgvnBVSKxlVPD/TQK7w2IxmAVrJ+Qa+4YOtQNLC1aN0ENbkc3mblEw9IKaWJICfKjH+nw==
X-Received: by 2002:a05:6a00:3c92:b0:725:aa5d:f217 with SMTP id
 d2e1a72fcca58-72d21fa5e7cmr30944062b3a.7.1736799448472; 
 Mon, 13 Jan 2025 12:17:28 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a31844ba45bsm7311949a12.19.2025.01.13.12.17.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jan 2025 12:17:28 -0800 (PST)
Message-ID: <6adc2994-e762-4923-9033-54efe165aaea@linaro.org>
Date: Mon, 13 Jan 2025 12:17:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
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
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <876fe41d-df26-4a13-a465-feeee0004746@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

T24gMS8xMi8yNSAyMjoyNiwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDExLzAxLzIwMjUg
MTYuNDcsIFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIHdyb3RlOg0KPj4gT24gMTAvMS8yNSAy
MTozNywgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBPbiAxLzEwLzI1IDEyOjMzLCBQ
aWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4+PiBGb3Igbm93LCBpdCB3YXMgb25seSBwb3Nz
aWJsZSB0byBidWlsZCBwbHVnaW5zIHVzaW5nIEdDQyBvbiBXaW5kb3dzLg0KPj4+PiBIb3dl
dmVyLA0KPj4+PiB3aW5kb3dzLWFhcmNoNjQgb25seSBzdXBwb3J0cyBDbGFuZy4NCj4+Pj4g
VGhpcyBiaWdnZXN0IHJvYWRibG9jayB3YXMgdG8gZ2V0IHJpZCBvZiBnY2Nfc3RydWN0IGF0
dHJpYnV0ZSwgd2hpY2ggaXMgbm90DQo+Pj4+IHN1cHBvcnRlZCBieSBDbGFuZy4gQWZ0ZXIg
aW52ZXN0aWdhdGlvbiwgd2UgcHJvdmVkIGl0IHdhcyBzYWZlIHRvIGRyb3AgaXQuDQo+Pj4+
DQo+Pj4+IEJ1aWx0IGFuZCB0ZXN0ZWQgb24gV2luZG93cyAoYWxsIG1zeXMgZW52KS9MaW51
eC9NYWNPUyBmb3IgeDg2XzY0IGFuZA0KPj4+PiBhYXJjaDY0DQo+Pj4+IGhvc3RzLg0KPj4+
Pg0KPj4+PiB2MSBjb250YWluZWQgd2FybmluZyBmaXhlcyBhbmQgdmFyaW91cyBiaXRzIHRo
YXQgaGF2ZSBiZWVuIHVwc3RyZWFtZWQNCj4+Pj4gYWxyZWFkeS4NCj4+Pj4gVGhlIG9ubHkg
Yml0cyBsZWZ0IGluIHRoaXMgc2VyaWVzIGFyZSB0aGUgZ2NjX3N0cnVjdCByZW1vdmFsLCBh
bmQgZml4aW5nIHRoZQ0KPj4+PiBwbHVnaW5zIGJ1aWxkIHdpdGggY2xhbmcuDQo+Pj4+DQo+
Pj4+IFRoaXMgc2VyaWVzIGlzIGZvciAxMC4wLCBhcyB3ZSBkZWNpZGVkIHRvIG5vdCBpbmNs
dWRlIHRoZSBnY2Nfc3RydWN0DQo+Pj4+IHJlbW92YWwgaXMNCj4+Pj4gOS4yIHJlbGVhc2Uu
DQo+Pj4+DQo+Pj4+IEFsbCBwYXRjaGVzIGFyZSBub3cgcmV2aWV3ZWQsIHNvIHRoaXMgc2Vy
aWVzIGNhbiBiZSBwdWxsZWQuIEknbGwgcmVwb3J0DQo+Pj4+IHRoYXQgdG8NCj4+Pj4gTVNZ
UzIgdG9vLCBzbyB3ZSBjYW4gZW5hYmxlIGNsYW5nIGVudmlyb25tZW50cyBmb3IgUUVNVS4N
Cj4+Pj4NCj4+Pj4gdjE6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDI0MTAzMTA0MDQy
Ni43NzI2MDQtMS0NCj4+Pj4gcGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnLw0KPj4+Pg0K
Pj4+PiB2MjoNCj4+Pj4gLSBkcm9wIGF0dHJpYnV0ZSBnY2Nfc3RydWN0IGluc3RlYWQgb2Yg
dXNpbmcgLW1uby1tcy1iaXRmaWVsZHMgb3B0aW9uDQo+Pj4+IC0gYWRkIGEgc2VjdGlvbiBh
Ym91dCBiaXRmaWVsZHMgaW4gZG9jdW1lbnRhdGlvbg0KPj4+Pg0KPj4+PiB2MzoNCj4+Pj4g
LSBleHBsYWluIHdoeSBnY2Nfc3RydWN0IGF0dHJpYnV0ZSBtYXR0ZXJzIGluIHBhY2tlZCBz
dHJ1Y3RzIGluIGNvbW1pdA0KPj4+PiBtZXNzYWdlDQo+Pj4+IC0gcmV3b3JkIHRoZSBiaXRm
aWVsZHMgZG9jdW1lbnRhdGlvbiB3aXRoIHN1Z2dlc3Rpb25zIGdpdmVuDQo+Pj4+DQo+Pj4+
IHY0Og0KPj4+PiAtIGVkaXQgZm9yIGJpdGZpZWxkcyBkb2MgcmVxdWVzdGVkIGJ5IFBoaWxp
cHBlDQo+Pj4+DQo+Pj4+IFBpZXJyaWNrIEJvdXZpZXIgKDMpOg0KPj4+PiAgwqDCoCB3aW4z
MjogcmVtb3ZlIHVzYWdlIG9mIGF0dHJpYnV0ZSBnY2Nfc3RydWN0DQo+Pj4+ICDCoMKgIGRv
Y3MvZGV2ZWwvc3R5bGU6IGFkZCBhIHNlY3Rpb24gYWJvdXQgYml0ZmllbGQsIGFuZCBkaXNh
bGxvdyB0aGVtIGZvcg0KPj4+PiAgwqDCoMKgwqAgcGFja2VkIHN0cnVjdHVyZXMNCj4+Pj4g
IMKgwqAgcGx1Z2luczogZW5hYmxlIGxpbmtpbmcgd2l0aCBjbGFuZy9sbGQNCj4+Pj4NCj4+
Pj4gIMKgIGRvY3MvZGV2ZWwvc3R5bGUucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwgMjAgKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgwqAgbWVz
b24uYnVpbGTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDYgKysrLS0tDQo+Pj4+ICDCoCBpbmNsdWRlL3FlbXUvY29t
cGlsZXIuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNyArLS0t
LS0tDQo+Pj4+ICDCoCBzY3JpcHRzL2NvY2NpLW1hY3JvLWZpbGUuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArLS0tLS0NCj4+Pj4gIMKgIHN1YnByb2plY3RzL2xp
YnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci5oIHzCoCA2ICstLS0tLQ0KPj4+PiAgwqAgY29u
dHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
wqAgMiArLQ0KPj4+PiAgwqAgcGx1Z2lucy9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjQgKysrKysrKysrKysrKysrKysrKy0t
LS0NCj4+Pj4gIMKgIHRlc3RzL3RjZy9wbHVnaW5zL21lc29uLmJ1aWxkwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoCAzICstLQ0KPj4+PiAgwqAgOCBmaWxlcyBjaGFuZ2VkLCA0OCBp
bnNlcnRpb25zKCspLCAyNiBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pg0KPj4+IEl0IHdvdWxk
IGJlIG5pY2UgaWYgYSBtYWludGFpbmVyIGNvdWxkIHB1bGwgdGhpcywgc28gd2UgY2FuIGdl
dCB0aGlzDQo+Pj4gbWVyZ2VkIHVwc3RyZWFtLg0KPj4NCj4+IFRoYXQnZCBiZSBUaG9tYXMg
b3IgQWxleCBJIHN1cHBvc2UuDQo+IA0KPiBUaGlzIHRvdWNoZXMgcGx1Z2lucywgc28gSSB0
aGluayBpdCBzaG91bGQgZ28gdGhyb3VnaCBBbGV4JyB0cmVlPw0KPiANCj4gICAgVGhvbWFz
DQo+IA0KPiANCg0KSXQncyB0b3VjaGluZyBwbHVnaW5zLCBidXQgaXQgZG9lcyBhIHN5c3Rl
bSB3aWRlIGNoYW5nZSBhcyB3ZWxsICh3aGljaCANCmlzIHRoZSBtb3N0IGltcG9ydGFudCBw
YXJ0KS4NCg0KSXQncyBub3QgcmVhbGx5IGltcG9ydGFudCB3aG8gbWVyZ2VzIHRoaXMsIGJ1
dCBpdCB3b3VsZCBiZSBiZXR0ZXIgaWYgdGhlIA0Kc2VyaWVzIGNvdWxkIGJlIHB1bGxlZCBh
cyBhIHdob2xlLCBpbnN0ZWFkIG9mIGJyZWFraW5nIGl0IGludG8gbXVsdGlwbGUgDQpzdWJz
eXN0ZW1zLg0KDQpUaGFua3MsDQpQaWVycmljaw0K

