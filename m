Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA92C5320D
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 15:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sez6W-0003k2-GC; Fri, 16 Aug 2024 11:43:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sez6V-0003j8-3g
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:43:03 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sez6S-0002fg-SJ
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 11:43:02 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-201fbd0d7c2so13403435ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723822978; x=1724427778; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIZ/A5rDlf46NJXJ4OOPIYj2YAtdaJskFshUubpzcA4=;
 b=YS7V86BD3iKY7IJuUdVGXAITvU+QxvHE3D59Ge1QTUb5REs/yDoUXDGXE0lYckgaXJ
 0rYADoHac8rtKdge44zcx1S/MoUcs6uv4kaJD8yuo79Y1fVESQwtQEow4AVYmucx0v3T
 jfbnXUL02UmJ94Xhx9j21tqz6f2CUot1Jt656y/bNlNJ9UXET/WyfBDcePYLjyab2mmY
 7Ivw7MtK7Jz+XMRRN6TKqieV5Hsh/P06jIeqdrVL1vLwXzK5PAdEeYCAQhg4DRZ64piz
 m7wiaXD/oXyxTTlOy30rGkzXnGf/FMDTW4qjfK1xiarAK//S1D7YbQTlabrILoFTbI0a
 Q/5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723822978; x=1724427778;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIZ/A5rDlf46NJXJ4OOPIYj2YAtdaJskFshUubpzcA4=;
 b=Mddm4u7GxBGJbiidM7H4v+WpXUsb2QhEmLzNI4KLGqP4qlNUV0rQe7iwm6w8HllBoa
 2TQEDj5Lsdt+IAGALAIs79JtbGffO0rL+f9uu6SSXKj2g0FeB9fsl3EqtTCNq9IHQOoW
 Prp18xP1iPqkZwQX9oGh727mTg+PVbpDW41pG7JweTe6m5AFsdbjYX6LNu+6mhkVCRJN
 mJyTrAv16g6v4u0zXqIrOBpPM8bkT1NHgEU/NGcTVPfsENcrc/BE6Hp+lUrK+kkrUDv2
 1NUwzf/XsnlnFA9YhlXkm7YLgLW+EGCICptsiY+Vhxw2IUCwgosPeh9GmKT5f6Vnrg2a
 2HAw==
X-Gm-Message-State: AOJu0YxJut+zKVLX8uer2NGvSUcAz2ncZ6LnQCcS6Z/wOHGiKQSVT48K
 b/AH6PcTgF2qAmNw1LNcUz721i8aUvB/E068VLL+Ax5Hlcsqs5gBJ1btx5OD8rY=
X-Google-Smtp-Source: AGHT+IGQTpefNapHRpAgx2lXKZeL2OVnz+Wr7QolwHolkF698Tkd+OUX3fmbn7XHZQAbrNkmuNh3kQ==
X-Received: by 2002:a17:902:d48b:b0:200:8c4d:9120 with SMTP id
 d9443c01a7336-20203ee7920mr46255885ad.39.1723822978129; 
 Fri, 16 Aug 2024 08:42:58 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f038a3d7sm26943685ad.186.2024.08.16.08.42.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Aug 2024 08:42:57 -0700 (PDT)
Message-ID: <6c0077f8-ce8b-438e-9c3e-9a97fb074f7d@linaro.org>
Date: Fri, 16 Aug 2024 08:42:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins: Add a plugin to generate basic block
 vectors
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Cc: qemu-devel@nongnu.org, Yotaro Nada <yotaro.nada@gmail.com>
References: <20240815-bb-v2-1-6222ee98297b@daynix.com>
 <8e027dfd-4fa7-4eab-852a-6f9d649c4b53@linaro.org>
 <f6f9f742-3213-436c-8f73-d4f32da5d7d2@daynix.com>
 <748eeda6-0400-4cbb-9322-57e092afaa0a@daynix.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <748eeda6-0400-4cbb-9322-57e092afaa0a@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URI_DOTEDU=1 autolearn=no autolearn_force=no
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

T24gOC8xNS8yNCAyMjoyOCwgQWtpaGlrbyBPZGFraSB3cm90ZToNCj4gT24gMjAyNC8wOC8x
NiAxNDoxMywgQWtpaGlrbyBPZGFraSB3cm90ZToNCj4+IE9uIDIwMjQvMDgvMTUgMTQ6NDgs
IFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gT24gOC8xNC8yNCAyMDowNCwgQWtpaGlr
byBPZGFraSB3cm90ZToNCj4+Pj4gU2ltUG9pbnQgaXMgYSB3aWRlbHkgdXNlZCB0b29sIHRv
IGZpbmQgdGhlIGlkZWFsIG1pY3JvYXJjaGl0ZWN0dXJlDQo+Pj4+IHNpbXVsYXRpb24gcG9p
bnRzIHNvIFZhbGdyaW5kWzJdIGFuZCBQaW5bM10gc3VwcG9ydCBnZW5lcmF0aW5nIGJhc2lj
DQo+Pj4+IGJsb2NrIHZlY3RvcnMgZm9yIHVzZSB3aXRoIHRoZW0uIExldCdzIGFkZCBhIGNv
cnJlc3BvbmRpbmcgcGx1Z2luIHRvDQo+Pj4+IFFFTVUgdG9vLg0KPj4+Pg0KPj4+PiBOb3Rl
IHRoYXQgdGhpcyBwbHVnaW4gaGFzIGEgZGlmZmVyZW50IGdvYWwgd2l0aCB0ZXN0cy9wbHVn
aW4vYmIuYy4NCj4+Pj4NCj4+Pj4gVGhpcyBwbHVnaW4gY3JlYXRlcyBhIHZlY3RvciBmb3Ig
ZWFjaCBjb25zdGFudCBpbnRlcnZhbCBpbnN0ZWFkIG9mDQo+Pj4+IGNvdW50aW5nIHRoZSBl
eGVjdXRpb24gb2YgYmFzaWMgYmxvY2tzIGZvciB0aGUgZW50aXJlIHJ1biBhbmQgYWJsZSB0
bw0KPj4+PiBkZXNjcmliZSB0aGUgY2hhbmdlIG9mIGV4ZWN1dGlvbiBiZWhhdmlvci4gSXRz
IG91dHB1dCBpcyBhbHNvDQo+Pj4+IHN5bnRhY3RpY2FsbHkgc2ltcGxlIGFuZCBiZXR0ZXIg
c3VpdGVkIGZvciBwYXJzaW5nLCB3aGlsZSB0aGUgb3V0cHV0IG9mDQo+Pj4+IHRlc3RzL3Bs
dWdpbi9iYi5jIGlzIG1vcmUgaHVtYW4tcmVhZGFibGUuDQo+Pj4+DQo+Pj4+IFsxXSBodHRw
czovL2NzZXdlYi51Y3NkLmVkdS9+Y2FsZGVyL3NpbXBvaW50Lw0KPj4+PiBbMl0gaHR0cHM6
Ly92YWxncmluZC5vcmcvZG9jcy9tYW51YWwvYmJ2LW1hbnVhbC5odG1sDQo+Pj4+IFszXQ0K
Pj4+PiBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVy
L2FydGljbGVzL3Rvb2wvcGluLWEtZHluYW1pYy1iaW5hcnktaW5zdHJ1bWVudGF0aW9uLXRv
b2wuaHRtbA0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZb3Rhcm8gTmFkYSA8eW90YXJv
Lm5hZGFAZ21haWwuY29tPg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBBa2loaWtvIE9kYWtpIDxh
a2loaWtvLm9kYWtpQGRheW5peC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBDaGFuZ2VzIGluIHYy
Og0KPj4+PiAtIE1lcmdlZCBmaWxlcyB2YXJpYWJsZSBpbnRvIHRoZSBnbG9iYWwgc2NvcmVi
b2FyZC4NCj4+Pj4gLSBBZGRlZCBhIGxvY2sgZm9yIGJicy4NCj4+Pj4gLSBBZGRlZCBhIHN1
bW1hcnkgdG8gY29udHJpYi9wbHVnaW5zL2Jidi5jLg0KPj4+PiAtIFJlYmFzZWQuDQo+Pj4+
IC0gTGluayB0byB2MToNCj4+Pj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDgx
My1iYi12MS0xLWVmZmJiNzdkYWViZkBkYXluaXguY29tDQo+Pj4+IC0tLQ0KPj4+PiAgwqAg
ZG9jcy9hYm91dC9lbXVsYXRpb24ucnN0IHzCoCAzMCArKysrKysrKysNCj4+Pj4gIMKgIGNv
bnRyaWIvcGx1Z2lucy9iYnYuY8KgwqDCoCB8IDE1OA0KPj4+PiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+PiAgwqAgY29udHJpYi9wbHVn
aW5zL01ha2VmaWxlIHzCoMKgIDEgKw0KPj4+PiAgwqAgMyBmaWxlcyBjaGFuZ2VkLCAxODkg
aW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvZG9jcy9hYm91dC9lbXVs
YXRpb24ucnN0IGIvZG9jcy9hYm91dC9lbXVsYXRpb24ucnN0DQo+Pj4+IGluZGV4IGMwMzAz
M2U0ZTk1Ni4uNzJkNzg0NmFiNmY4IDEwMDY0NA0KPj4+PiAtLS0gYS9kb2NzL2Fib3V0L2Vt
dWxhdGlvbi5yc3QNCj4+Pj4gKysrIGIvZG9jcy9hYm91dC9lbXVsYXRpb24ucnN0DQo+Pj4+
IEBAIC0zODEsNiArMzgxLDM2IEBAIHJ1bjo6DQo+Pj4+ICDCoMKgwqAgMTYwwqDCoMKgwqDC
oMKgwqDCoMKgIDHCoMKgwqDCoMKgIDANCj4+Pj4gIMKgwqDCoCAxMzXCoMKgwqDCoMKgwqDC
oMKgwqAgMcKgwqDCoMKgwqAgMA0KPj4+PiArQmFzaWMgQmxvY2sgVmVjdG9ycw0KPj4+PiAr
Li4uLi4uLi4uLi4uLi4uLi4uLg0KPj4+PiArDQo+Pj4+ICtgYGNvbnRyaWIvcGx1Z2lucy9i
YnYuY2BgDQo+Pj4+ICsNCj4+Pj4gK1RoZSBiYnYgcGx1Z2luIGFsbG93cyB5b3UgdG8gZ2Vu
ZXJhdGUgYmFzaWMgYmxvY2sgdmVjdG9ycyBmb3IgdXNlDQo+Pj4+IHdpdGggdGhlDQo+Pj4+
ICtgU2ltUG9pbnQgPGh0dHBzOi8vY3Nld2ViLnVjc2QuZWR1L35jYWxkZXIvc2ltcG9pbnQv
PmBfXyBhbmFseXNpcyB0b29sLg0KPj4+PiArDQo+Pj4+ICsuLiBsaXN0LXRhYmxlOjogQmFz
aWMgYmxvY2sgdmVjdG9ycyBhcmd1bWVudHMNCj4+Pj4gK8KgIDp3aWR0aHM6IDIwIDgwDQo+
Pj4+ICvCoCA6aGVhZGVyLXJvd3M6IDENCj4+Pj4gKw0KPj4+PiArwqAgKiAtIE9wdGlvbg0K
Pj4+PiArwqDCoMKgIC0gRGVzY3JpcHRpb24NCj4+Pj4gK8KgICogLSBpbnRlcnZhbD1ODQo+
Pj4+ICvCoMKgwqAgLSBUaGUgaW50ZXJ2YWwgdG8gZ2VuZXJhdGUgYSBiYXNpYyBibG9jayB2
ZWN0b3Igc3BlY2lmaWVkIGJ5IHRoZQ0KPj4+PiBudW1iZXIgb2YNCj4+Pj4gK8KgwqDCoMKg
wqAgaW5zdHJ1Y3Rpb25zIChEZWZhdWx0OiBOID0gMTAwMDAwMDAwKQ0KPj4+PiArwqAgKiAt
IG91dGZpbGU9UEFUSA0KPj4+PiArwqDCoMKgIC0gVGhlIHBhdGggdG8gb3V0cHV0IGZpbGVz
Lg0KPj4+PiArwqDCoMKgwqDCoCBJdCB3aWxsIGJlIHN1ZmZpeGVkIHdpdGggYGAuTi5iYmBg
IHdoZXJlIGBgTmBgIGlzIGEgdkNQVSBpbmRleC4NCj4+Pj4gKw0KPj4+PiArRXhhbXBsZTo6
DQo+Pj4+ICsNCj4+Pj4gK8KgICQgcWVtdS1hYXJjaDY0IFwNCj4+Pj4gK8KgwqDCoCAtcGx1
Z2luIGNvbnRyaWIvcGx1Z2lucy9saWJiYnYuc28saW50ZXJ2YWw9MTAwLG91dGZpbGU9c2hh
MSBcDQo+Pj4+ICvCoMKgwqAgdGVzdHMvdGNnL2FhcmNoNjQtbGludXgtdXNlci9zaGExDQo+
Pj4+ICvCoCBTSEExPTE1ZGQ5OWExOTkxZTBiMzgyNmZlZGUzZGVmZmMxZmViYTQyMjc4ZTYN
Cj4+Pj4gK8KgICQgZHUgc2hhMS4wLmJiDQo+Pj4+ICvCoCAyMzEyOMKgwqAgc2hhMS4wLmJi
DQo+Pj4+ICsNCj4+Pj4gIMKgIEhvdCBCbG9ja3MNCj4+Pj4gIMKgIC4uLi4uLi4uLi4NCj4+
Pj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvcGx1Z2lucy9iYnYuYyBiL2NvbnRyaWIvcGx1Z2lu
cy9iYnYuYw0KPj4+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4+PiBpbmRleCAwMDAwMDAw
MDAwMDAuLjQxMTM5ZjQyM2ZlMg0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsrKyBiL2Nv
bnRyaWIvcGx1Z2lucy9iYnYuYw0KPj4+PiBAQCAtMCwwICsxLDE1OCBAQA0KPj4+PiArLyoN
Cj4+Pj4gKyAqIEdlbmVyYXRlIGJhc2ljIGJsb2NrIHZlY3RvcnMgZm9yIHVzZSB3aXRoIHRo
ZSBTaW1Qb2ludCBhbmFseXNpcw0KPj4+PiB0b29sLg0KPj4+PiArICogU2ltUG9pbnQ6IGh0
dHBzOi8vY3Nld2ViLnVjc2QuZWR1L35jYWxkZXIvc2ltcG9pbnQvDQo+Pj4+ICsgKg0KPj4+
PiArICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCj4+Pj4g
KyAqLw0KPj4+PiArDQo+Pj4+ICsjaW5jbHVkZSA8c3RkaW8uaD4NCj4+Pj4gKyNpbmNsdWRl
IDxnbGliLmg+DQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlIDxxZW11LXBsdWdpbi5oPg0KPj4+
PiArDQo+Pj4+ICt0eXBlZGVmIHN0cnVjdCBCYiB7DQo+Pj4+ICvCoMKgwqAgc3RydWN0IHFl
bXVfcGx1Z2luX3Njb3JlYm9hcmQgKmNvdW50Ow0KPj4+PiArwqDCoMKgIHVuc2lnbmVkIGlu
dCBpbmRleDsNCj4+Pj4gK30gQmI7DQo+Pj4+ICsNCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZj
cHUgew0KPj4+PiArwqDCoMKgIHVpbnQ2NF90IGNvdW50Ow0KPj4+PiArwqDCoMKgIEZJTEUg
KmZpbGU7DQo+Pj4+ICt9IFZjcHU7DQo+Pj4+ICsNCj4+Pj4gK1FFTVVfUExVR0lOX0VYUE9S
VCBpbnQgcWVtdV9wbHVnaW5fdmVyc2lvbiA9IFFFTVVfUExVR0lOX1ZFUlNJT047DQo+Pj4+
ICtzdGF0aWMgR0hhc2hUYWJsZSAqYmJzOw0KPj4+PiArc3RhdGljIEdSV0xvY2sgYmJzX2xv
Y2s7DQo+Pj4+ICtzdGF0aWMgY2hhciAqZmlsZW5hbWU7DQo+Pj4+ICtzdGF0aWMgc3RydWN0
IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmQgKnZjcHVzOw0KPj4+PiArc3RhdGljIHVpbnQ2NF90
IGludGVydmFsID0gMTAwMDAwMDAwOw0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgdm9pZCBwbHVn
aW5fZXhpdChxZW11X3BsdWdpbl9pZF90IGlkLCB2b2lkICpwKQ0KPj4+PiArew0KPj4+PiAr
wqDCoMKgIGZvciAoaW50IGkgPSAwOyBpIDwgcWVtdV9wbHVnaW5fbnVtX3ZjcHVzKCk7IGkr
Kykgew0KPj4+PiArwqDCoMKgwqDCoMKgwqAgZmNsb3NlKCgoVmNwdSAqKXFlbXVfcGx1Z2lu
X3Njb3JlYm9hcmRfZmluZCh2Y3B1cywgaSkpLT5maWxlKTsNCj4+Pj4gK8KgwqDCoCB9DQo+
Pj4+ICsNCj4+Pj4gK8KgwqDCoCBnX2hhc2hfdGFibGVfdW5yZWYoYmJzKTsNCj4+Pj4gK8Kg
wqDCoCBnX2ZyZWUoZmlsZW5hbWUpOw0KPj4+PiArwqDCoMKgIHFlbXVfcGx1Z2luX3Njb3Jl
Ym9hcmRfZnJlZSh2Y3B1cyk7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gK3N0YXRpYyB2b2lk
IGZyZWVfYmIodm9pZCAqZGF0YSkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBxZW11X3BsdWdp
bl9zY29yZWJvYXJkX2ZyZWUoKChCYiAqKWRhdGEpLT5jb3VudCk7DQo+Pj4+ICvCoMKgwqAg
Z19mcmVlKGRhdGEpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMgcWVtdV9wbHVn
aW5fdTY0IGNvdW50X3U2NCh2b2lkKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIHJldHVybiBx
ZW11X3BsdWdpbl9zY29yZWJvYXJkX3U2NF9pbl9zdHJ1Y3QodmNwdXMsIFZjcHUsIGNvdW50
KTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHFlbXVfcGx1Z2luX3U2NCBiYl9j
b3VudF91NjQoQmIgKmJiKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIHJldHVybiBxZW11X3Bs
dWdpbl9zY29yZWJvYXJkX3U2NChiYi0+Y291bnQpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+
ICtzdGF0aWMgdm9pZCB2Y3B1X2luaXQocWVtdV9wbHVnaW5faWRfdCBpZCwgdW5zaWduZWQg
aW50IHZjcHVfaW5kZXgpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgZ19hdXRvZnJlZSBnY2hh
ciAqdmNwdV9maWxlbmFtZSA9IE5VTEw7DQo+Pj4+ICvCoMKgwqAgVmNwdSAqdmNwdSA9IHFl
bXVfcGx1Z2luX3Njb3JlYm9hcmRfZmluZCh2Y3B1cywgdmNwdV9pbmRleCk7DQo+Pj4+ICsN
Cj4+Pj4gK8KgwqDCoCB2Y3B1X2ZpbGVuYW1lID0gZ19zdHJkdXBfcHJpbnRmKCIlcy4ldS5i
YiIsIGZpbGVuYW1lLCB2Y3B1X2luZGV4KTsNCj4+Pj4gK8KgwqDCoCB2Y3B1LT5maWxlID0g
Zm9wZW4odmNwdV9maWxlbmFtZSwgInciKTsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3Rh
dGljIHZvaWQgdmNwdV9pbnRlcnZhbF9leGVjKHVuc2lnbmVkIGludCB2Y3B1X2luZGV4LCB2
b2lkICp1ZGF0YSkNCj4+Pj4gK3sNCj4+Pj4gK8KgwqDCoCBWY3B1ICp2Y3B1ID0gcWVtdV9w
bHVnaW5fc2NvcmVib2FyZF9maW5kKHZjcHVzLCB2Y3B1X2luZGV4KTsNCj4+Pj4gK8KgwqDC
oCBHSGFzaFRhYmxlSXRlciBpdGVyOw0KPj4+PiArwqDCoMKgIHZvaWQgKnZhbHVlOw0KPj4+
PiArDQo+Pj4+ICvCoMKgwqAgaWYgKCF2Y3B1LT5maWxlKSB7DQo+Pj4+ICvCoMKgwqDCoMKg
wqDCoCByZXR1cm47DQo+Pj4+ICvCoMKgwqAgfQ0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgdmNw
dS0+Y291bnQgLT0gaW50ZXJ2YWw7DQo+Pj4+ICsNCj4+Pj4gK8KgwqDCoCBmcHV0YygnVCcs
IHZjcHUtPmZpbGUpOw0KPj4+PiArDQo+Pj4+ICvCoMKgwqAgZ19yd19sb2NrX3JlYWRlcl9s
b2NrKCZiYnNfbG9jayk7DQo+Pj4+ICvCoMKgwqAgZ19oYXNoX3RhYmxlX2l0ZXJfaW5pdCgm
aXRlciwgYmJzKTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgIHdoaWxlIChnX2hhc2hfdGFibGVf
aXRlcl9uZXh0KCZpdGVyLCBOVUxMLCAmdmFsdWUpKSB7DQo+Pj4+ICvCoMKgwqDCoMKgwqDC
oCBCYiAqYmIgPSB2YWx1ZTsNCj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGJiX2Nv
dW50ID0gcWVtdV9wbHVnaW5fdTY0X2dldChiYl9jb3VudF91NjQoYmIpLA0KPj4+PiB2Y3B1
X2luZGV4KTsNCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKCFiYl9jb3VudCkg
ew0KPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb250aW51ZTsNCj4+Pj4gK8KgwqDC
oMKgwqDCoMKgIH0NCj4+Pj4gKw0KPj4+PiArwqDCoMKgwqDCoMKgwqAgZnByaW50Zih2Y3B1
LT5maWxlLCAiOiV1OiUiIFBSSXU2NCAiICIsIGJiLT5pbmRleCwgYmJfY291bnQpOw0KPj4+
PiArwqDCoMKgwqDCoMKgwqAgcWVtdV9wbHVnaW5fdTY0X3NldChiYl9jb3VudF91NjQoYmIp
LCB2Y3B1X2luZGV4LCAwKTsNCj4+Pj4gK8KgwqDCoCB9DQo+Pj4+ICsNCj4+Pj4gK8KgwqDC
oCBnX3J3X2xvY2tfcmVhZGVyX3VubG9jaygmYmJzX2xvY2spOw0KPj4+PiArwqDCoMKgIGZw
dXRjKCdcbicsIHZjcHUtPmZpbGUpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICtzdGF0aWMg
dm9pZCB2Y3B1X3RiX3RyYW5zKHFlbXVfcGx1Z2luX2lkX3QgaWQsIHN0cnVjdCBxZW11X3Bs
dWdpbl90Yg0KPj4+PiAqdGIpDQo+Pj4+ICt7DQo+Pj4+ICvCoMKgwqAgdWludDY0X3Qgbl9p
bnNucyA9IHFlbXVfcGx1Z2luX3RiX25faW5zbnModGIpOw0KPj4+PiArwqDCoMKgIHVpbnQ2
NF90IHZhZGRyID0gcWVtdV9wbHVnaW5fdGJfdmFkZHIodGIpOw0KPj4+PiArwqDCoMKgIEJi
ICpiYiA9IGdfaGFzaF90YWJsZV9sb29rdXAoYmJzLCAmdmFkZHIpOw0KPj4+DQo+Pj4gTWlz
c2luZyBhIHJlYWRfbG9jayBmb3IgdGhpcyBhY2Nlc3MuDQo+Pg0KPj4gSSBleHBlY3QgdmNw
dV90Yl90cmFucygpIHdpbGwgbm90IGJlIGV4ZWN1dGVkIGNvbmN1cnJlbnRseS4NCj4gDQo+
IE5vLCBRRU1VIGRvZXNuJ3QgbG9jayB1bmxlc3MgaXQgaXMgdXNlcnNwYWNlIGVtdWxhdGlv
bi4gSSdsbCBhZGQgdGhlDQo+IHJlYWQgbG9jay4NCj4NCg0KVXNlciBtb2RlIHVzZXMgYSBz
aGFyZWQgY29kZSBjYWNoZSB3aGlsZSBzeXN0ZW0gbW9kZSB1c2VzIGEgY29kZSBjYWNoZSAN
CnBlciB2Y3B1ICh0aHVzLCB0cmFuc2xhdGlvbiBjYW4gaGFwcGVuIGNvbmN1cnJlbnRseSku
DQpodHRwczovL3d3dy5xZW11Lm9yZy9kb2NzL21hc3Rlci9kZXZlbC9tdWx0aS10aHJlYWQt
dGNnLmh0bWwjZ2xvYmFsLXRjZy1zdGF0ZQ0KDQo+IFJlZ2FyZHMsDQo+IEFraWhpa28gT2Rh
a2kNCg==

