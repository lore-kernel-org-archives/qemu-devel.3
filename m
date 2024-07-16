Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3234AC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 15:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTkDU-0001Hr-Rd; Tue, 16 Jul 2024 11:35:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTkDR-0001H6-Qh
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:35:47 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTkDP-0002VU-H7
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 11:35:45 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70b04cb28acso4500851b3a.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721144141; x=1721748941; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ltMjZYg8iamV7WgWKaU9Pk0pD9QhZaxjdrP4FA9UljU=;
 b=JAjZJCZcWVCPfvuiVLI5UgJuaYO3xzTI602DADb1CrgDQ5xCpQzH0PR+/2r9frYJZ3
 mcRowctlh2Nk4OsvGXYr9a/n6ssuO4lrrMUGBJpLRhpthXi9PLtDo5yPNyOvUHmNac6m
 ttlFZYJp17oSqE1TkrSanfrD4h1NDjzf97Jup2pXr6TqUbLkV9ON4jhwzGX+MWMdDTrT
 dWozNlLNusj3Wruq6ODnOHPOId8WXxCV2cd8RHM0NyMt33Qh2s61nAcCoOFkdj7Py20T
 3GEyc/azoAGDYj6U1spHqnDj4NWfxPXIqi0TQaDI/k2LLX1clH6IhAyOt5iSvN0CRMn6
 55lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721144141; x=1721748941;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ltMjZYg8iamV7WgWKaU9Pk0pD9QhZaxjdrP4FA9UljU=;
 b=CZw3n1tfaq5goYvn2dJJpwvJzj3CPjOeM4FuGS9wQc7Arcw5uzIUS+Qs358SBSiVyh
 V5GcI8Qm4w7xJ6sJAEGUPzYeH4HcjN+xMoxCrrM7VA3Gze2nLFWFPvuSR5y12do7QUI1
 lXCH0K0InB1E2HtECOygY9mLAuQJrYRaqs7XNeWwCuNK1lAv1n7FvT5/A2XqYihOj0cr
 +mGqrNjztX91AVwf8yDdhEVWZhr+U6tO3HbhycbB/5uWu0Yo/T8cSgeRNkjWbs/UU381
 a0Wftv2xoSalo4zVZCeOlsdxsOIPXEMIle88F23QeNX90SVw+elG+KNaRcQbdM8pzzM6
 DR4A==
X-Gm-Message-State: AOJu0YxKQoOnk3Mi+V8+sW5aWV39Jt5yTIRSJWWqQttd6KAp0BPdfnre
 4DcxW8+O5wkINGZlh9Iga95B0mMifm69xTKlODKq9xRWpOLc7aen9nG0HhAS23U=
X-Google-Smtp-Source: AGHT+IG/U0RNhrGZ/NK6NqVHRx9F+7EDzy3MUvVdKKrDs+Oo/ekFsbqiuJHWeszs/JWZo2OrGuEQEw==
X-Received: by 2002:a05:6a00:3d53:b0:706:6867:7a63 with SMTP id
 d2e1a72fcca58-70cd839b428mr3468259b3a.6.1721144141127; 
 Tue, 16 Jul 2024 08:35:41 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-78e33cb6232sm5061491a12.24.2024.07.16.08.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Jul 2024 08:35:40 -0700 (PDT)
Message-ID: <da5e6235-311e-4dc2-ad01-fc4fd12b22df@linaro.org>
Date: Tue, 16 Jul 2024 08:35:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
To: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
 <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
 <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
 <4967cfde-65d0-46ac-8956-a23eb9836e90@linaro.org>
 <b964ae7b-6ae4-43a4-b886-70e8e9875f58@grenoble-inp.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <b964ae7b-6ae4-43a4-b886-70e8e9875f58@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gNy8xNi8yNCAwMjowMiwgU2ltb24gSGFtZWxpbiB3cm90ZToNCj4gDQo+IA0KPiBPbiA3
LzE2LzI0IDAxOjA4LCBQaWVycmljayBCb3V2aWVyIHdyb3RlOg0KPj4gT24gNy8xNS8yNCAw
MTowOSwgU2ltb24gSGFtZWxpbiB3cm90ZToNCj4+PiBIZWxsbyBQaWVycmljaywNCj4+Pg0K
Pj4+PiBDb3VsZCB5b3Ugc2hhcmUgYSBiaXQgbW9yZSBpbmZvcm1hdGlvbiBvbiB0aGUgZmlu
YWwgZ29hbCwgaWYgcG9zc2libGU/DQo+Pj4+IElzIHRoYXQgdXNlZCBmb3IgZnV6emluZyBi
aW5hcmllcywgc2VjdXJpdHkgYW5hbHlzaXMsIG9yIG90aGVyIHRoaW5ncz8NCj4+Pg0KPj4+
IEknbSBjdXJyZW50bHkgdXNpbmcgdGhpcyBwbHVnaW4gZm9yIHNlY3VyaXR5IGFuYWx5c2lz
IHB1cnBvc2VzLg0KPj4+IEJhc2ljYWxseSBteSBnb2FsIGlzIHRvIHNpbXVsYXRlIGZhdWx0
IGluamVjdGlvbiB1c2luZyBRRU1VLiBUbyBkbyBzbw0KPj4+IEknbSB1c2luZyB0aGlzIHBs
dWdpbiBhbG9uZyB3aXRoIGFub3RoZXIgcGx1Z2luIHRoYXQgc2tpcHMgYW4NCj4+PiBpbnN0
cnVjdGlvbiBhdCBhIGdpdmVuIGFkZHJlc3MuIFdpdGggdGhpcyBwbHVnaW4gSSdtIGFibGUg
dG8gc2VlIGhvdyB0aGUNCj4+PiBwcm9ncmFtIHJlYWN0cyB0byB0aGUgZmF1bHQgYW5kIHN0
b3AgaXQgd2l0aCBhIGN1c3RvbSByZXR1cm4gY29kZS4NCj4+PiBCYXNpY2FsbHkgdGhlcmUg
YXJlIDQgY2FzZXM6DQo+Pj4gIMKgwqDCoMKgIC0gVGhlIGZhdWx0IGRvZXMgbm90IGRpc3J1
cHQgdGhlIHByb2dyYW0gYW5kIGl0IHJlYWNoZXMgdGhlIGV4cGVjdGVkDQo+Pj4gYWRkcmVz
cy4NCj4+PiAgwqDCoMKgwqAgLSBUaGUgZmF1bHQgZGlzcnVwdCB0aGUgcHJvZ3JhbSBhbmQg
aXQgcmVhY2hlcyBhbiB1bmV4cGVjdGVkIGFkZHJlc3MNCj4+PiBrbm93biBhcyB0aGUgInRh
cmdldCIgYWRkcmVzcy4NCj4+PiAgwqDCoMKgwqAgLSBUaGUgZmF1bHQgZGlzcnVwdCB0aGUg
cHJvZ3JhbSBpbiBzdWNoIGEgd2F5IHRoYXQgaXQgZXhlY3V0ZXMgYSBsb3QNCj4+PiBvZiBp
bnN0cnVjdGlvbnMgd2l0aG91dCByZWFjaGluZyB0aGUgZXhwZWN0ZWQgYWRkcmVzcywgdGhp
cyBzaXR1YXRpb24gaXMNCj4+PiBrbm93biBhcyBhICJ0aW1lb3V0Ii4NCj4+PiAgwqDCoMKg
wqAgLSBUaGUgZmF1bHQgY3Jhc2hlcyB0aGUgZ3Vlc3QsIGNhdXNpbmcgaXQgdG8gcmVhY2gg
YW4gZXJyb3IgaGFuZGxlcg0KPj4+IGFkZHJlc3MuDQo+Pj4NCj4+DQo+PiBUaGFua3MgZm9y
IHNoYXJpbmcgdGhpcywgaXQncyBhbiBpbnRlcmVzdGluZyB1c2UgY2FzZS4NCj4+DQo+PiBI
b3cgZGlkIHlvdSBpbXBsZW1lbnQgaW5zdHJ1Y3Rpb24gc2tpcHBpbmc/DQo+PiBJcyB0aGF0
IGJhc2VkIG9uIGN1cnJlbnQgQVBJLCBvciBkbyB5b3UgaGF2ZSBhIFFFTVUgZm9yaz8NCj4+
DQo+IA0KPiBJIGhhZCB0byBleHRlbmQgdGhlIGN1cnJlbnQgQVBJIHRvIHN1cHBvcnQgd3Jp
dGluZyBndWVzdCByZWdpc3RlcnMsDQo+IHNwZWNpZmljYWxseSBJJ20gc2tpcHBpbmcgaW5z
dHJ1Y3Rpb25zIGJ5IHdyaXRpbmcgdG8gdGhlIFBDIHJlZ2lzdGVyLiBUbw0KPiBkbyB0aGlz
IEkgdXNlIHRoZSBzZXRfcGMgZnVuY3Rpb24gb2YgdGhlIENQVUNsYXNzIHN0cnVjdC4gVGhp
cyByZXF1aXJlcw0KPiBhIGJpdCBvZiBhIGhhY2sgdG8gbWFrZSB0aGUgVENHIHJlYWN0IHRv
IHRoZSBQQyBjaGFuZ2UgYXMgaXQncyBub3JtYWwNCj4gYmVoYXZpb3IgaXMgdG8gZXhlY3V0
ZSB0aGUgZW50aXJlIFRCIGFuZCBpZ25vcmUgdGhlIFBDIGNoYW5nZS4gVG8gbWFrZQ0KPiB0
aGUgVENHIHJlYWN0IHRvIHRoaXMgbW9kaWZpY2F0aW9uIHRoZSBvbmx5IHdheSBJJ3ZlIGZv
dW5kIGlzIHRvIGxlYXZlDQo+IGl0IG1pZHdheSBpdCdzIGV4ZWN1dGlvbiB1c2luZyB0aGUg
YGNwdV9sb29wX2V4aXRgIGZ1bmN0aW9uLg0KPiANCg0KT2suDQpTbyBmYXIsIG91ciBBUEkg
aXMgZGVzaWduZWQgdG8gbm90IGFsbG93IG1vZGlmaWNhdGlvbiBvbiBndWVzdCBzaWRlIA0K
KGNvZGUgb3IgZGF0YSB3aXNlKS4gSXQncyBkZWZpbml0ZWx5IGEgZGlzY3Vzc2lvbiB3ZSBz
aG91bGQgc3RhcnQgYXQgDQpzb21lIHBvaW50LCBhcyBpdCBtYXkgYmUgbmVlZGVkIGZvciBz
cGVjaWZpYyB1c2UgY2FzZXMuDQoNClRoYW5rcyENCg==

