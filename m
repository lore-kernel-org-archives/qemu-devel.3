Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71ADAD1713B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 20:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2zHG-00048K-DV; Mon, 21 Oct 2024 16:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2zHD-00047U-Gp
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:45:19 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2zHB-0007fT-Ep
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 16:45:19 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e3fca72a41so3221210a91.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729543516; x=1730148316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NpsgFsHiBEAVgvNQ3AGYa20mhdVVQBW40ZLanckKBeA=;
 b=HULBo7MrQjHqfFhVSQ4Q0JygKW/IyysfAxBWhfuwEXsqcYRrPoTE3SfIIm/wKULezn
 ivyG5TTlAxllL/CfFXwKiEohdWFdalzfmkxj7J8kBQbadkic+GIF/HLoNMmfmzZdNNH3
 qAV1ZgtIZptXu8//GHK0q0tuUVY5d/00I1k9hurZxwV5CNcMkfF+fHtwWFD4WOOYaehS
 VtVrd71ktfsTUD9omgW70BEYaXfKKa+L0VumBlC1WsBioWqCY98N4T3ighqB3WcoIaMi
 HFhnbl+Q3yQVyGsOk2KfHEUxXv/GNGHvocdWeWaDAiksBfE5Q9LRd/jSJyeKi2L8u11z
 TNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729543516; x=1730148316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NpsgFsHiBEAVgvNQ3AGYa20mhdVVQBW40ZLanckKBeA=;
 b=Tx7Q3lIrZw9c3ZI3EiXcQowRCLB+u6dgYZwTuXEVJotssPhkbBj20NguzFm6Jhv0/x
 l0UXR5nyG52GP7gHdJ79k/1kxmSDSKD1Wi8bQFDghp/DhK2rP4zTZZ+FNzHV60joSLqC
 N0SlSjHscfdk/JQFgISOG2AyzPlx8YtbQ3eHkx6I/MdXNRWd2KM3S9dCQFyfix82Gw9l
 d2qE4x46VM2N87v0EVjyVMNXiBHfYOAjNJRrm7a8uBn6zJ+/VpfJH1F4fwD77kaSfQZJ
 u6B6hyTe0Q1wl7qL7CCkDOx6CMvGxOspRO3UrqNRyI7nFxRuknHQxXsgEkBSV/JxeQFv
 B1Qg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxO0D6JbNEDMKj8eha6iFuGKKZ57jrykMg1V7Exczt6d+KDKytuk6O7OQ4ah3XbAzGYicb7Lk28prv@nongnu.org
X-Gm-Message-State: AOJu0YwsFmlEcZCfVwiAgKrEehnn5oy7fM9AvJX2oXVSMO5+8cLSiRlv
 dZ2mgilG015cBPwlrEzWHhcop2ON2yc5C6zqZAuiKXhFOmqaPy+67YOx++QXBgE=
X-Google-Smtp-Source: AGHT+IFqWxuQU2MyYs73S4MjSXTZlxbb2Jke+zCxuEpIAGiqeHElz8gPxvmESt5MdA8WlUUJMXK+Wg==
X-Received: by 2002:a17:90a:c906:b0:2dd:4f6b:638d with SMTP id
 98e67ed59e1d1-2e5ddba6fb1mr412249a91.17.1729543515776; 
 Mon, 21 Oct 2024 13:45:15 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad366c39sm4364715a91.15.2024.10.21.13.45.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 13:45:15 -0700 (PDT)
Message-ID: <5574c9d6-c4aa-43b4-bfdc-9a4f5eced066@linaro.org>
Date: Mon, 21 Oct 2024 13:45:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 0/7] tcg-plugins: add hooks for interrupts,
 exceptions and traps
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
References: <20231021122502.26746-1-neither@nut.email>
 <cover.1729355735.git.neither@nut.email>
 <fad67d3f-5b8d-45f6-a1aa-666852a0dad4@linaro.org>
 <878quhnvhm.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <878quhnvhm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102e.google.com
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

DQoNCk9uIDEwLzIxLzI0IDExOjQ3LCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNr
IEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+
IEhpIEp1bGlhbiwNCj4+DQo+PiBPbiAxMC8xOS8yNCAwOTozOSwgSnVsaWFuIEdhbnogd3Jv
dGU6DQo+Pj4gU29tZSBhbmFseXNpcyBncmVhdGx5IGJlbmVmaXRzLCBvciBkZXBlbmRzIG9u
LCBpbmZvcm1hdGlvbiBhYm91dA0KPj4+IGludGVycnVwdHMuIEZvciBleGFtcGxlLCB3ZSBt
YXkgbmVlZCB0byBoYW5kbGUgdGhlIGV4ZWN1dGlvbiBvZiBhIG5ldw0KPj4+IHRyYW5zbGF0
aW9uIGJsb2NrIGRpZmZlcmVudGx5IGlmIGl0IGlzIG5vdCB0aGUgcmVzdWx0IG9mIG5vcm1h
bCBwcm9ncmFtDQo+Pj4gZmxvdyBidXQgb2YgYW4gaW50ZXJydXB0Lg0KPj4+IEV2ZW4gd2l0
aCB0aGUgZXhpc3RpbmcgaW50ZXJmYWNlcywgaXQgaXMgbW9yZSBvciBsZXNzIHBvc3NpYmxl
IHRvDQo+Pj4gZGlzY2VybiB0aGVzZSBzaXR1YXRpb25zLCBlLmcuIGFzIGRvbmUgYnkgdGhl
IGNmbG93IHBsdWdpbi4gSG93ZXZlciwNCj4+PiB0aGlzIHByb2Nlc3MgcG9zZXMgYSBjb25z
aWRlcmFibGUgb3ZlcmhlYWQgdG8gdGhlIGNvcmUgYW5hbHlzaXMgb25lIG1heQ0KPj4+IGlu
dGVuZCB0byBwZXJmb3JtLg0KPj4+DQo+Pg0KPj4gSSBhZ3JlZSBpdCB3b3VsZCBiZSB1c2Vm
dWwuIEJleW9uZCB0aGUgc2NvcGUgb2YgdGhpcyBzZXJpZXMsIGl0IHdvdWxkDQo+PiBiZSBu
aWNlIGlmIHdlIGNvdWxkIGFkZCBhIGNvbnRyb2wgZmxvdyByZWxhdGVkIEFQSSBpbnN0ZWFk
IG9mIGFza2luZw0KPj4gdG8gcGx1Z2lucyB0byBkbyBpdCB0aGVtc2VsdmVzLg0KPiANCj4g
SSB0aGluayB0aGVyZSBpcyBhIGJhbGFuY2UgdG8gYmUgaGFkIGhlcmUuIFdlIGRvbid0IHdh
bnQgdG8NCj4gaW5hZHZlcnRlbnRseSBleHBvc2UgUUVNVSBpbnRlcm5hbHMgdG8gdGhlIHBs
dWdpbiBBUEkuIFdpdGggdGhpcyBzZXJpZXMNCj4gYXQgbGVhc3Qgd2UgcmVseSBvbiBzdHVm
ZiB0aGUgZnJvbnQtZW5kIGtub3dzIHdoaWNoIGNhbiBhdCBsZWFzdCBiZQ0KPiB0d2Vha2Vk
IHJlbGF0aXZlbHkgZWFzaWx5Lg0KPiANCg0KWW91J3JlIHJpZ2h0LiBNYXliZSBhIGdvb2Qg
d2F5IHRvIGZpbmQgdGhlIGJhbGFuY2UgaXMgdG8gaWRlbnRpZnkgdGhlIA0KcmVhbCB1c2Ug
Y2FzZXMgYmVoaW5kIHRoaXMgbmVlZC4NCg0KPj4gSWYgd2Ugd291bGQgcHJvdmlkZSBzb21l
dGhpbmcgbGlrZSB0aGlzLCBpcyB0aGVyZSBzdGlsbCBhIHZhbHVlIHRvIGFkZA0KPj4gYW4g
QVBJIHRvIGRldGVjdCBpbnRlcnJ1cHQvZXhjZXB0aW9ucy90cmFwcyBldmVudHM/DQo+Pg0K
Pj4gTm90ZTogSXQncyBub3QgYSBjcml0aWMgYWdhaW5zdCB3aGF0IHlvdSBzZW50LCBqdXN0
IGFuIG9wZW4gcXVlc3Rpb24NCj4+IG9uICp3aHkqIGl0J3MgdXNlZnVsIHRvIGFjY2VzcyB0
aGlzIFFFTVUgaW1wbGVtZW50YXRpb24gcmVsYXRlZA0KPj4gaW5mb3JtYXRpb24gdnMgc29t
ZXRoaW5nIG1vcmUgZ2VuZXJpYy4NCj4gPHNuaXA+DQo+IA0KPiBJdCB3b3VsZCBiZSBnb29k
IHRvIGhhdmUgdGhlIG9waW5pb24gb2YgdGhlIGZyb250LWVuZCBtYWludGFpbmVycyBpZg0K
PiB0aGlzIGlzIHRvbyBidXJkZW5zb21lIG9yIGVhc3kgZW5vdWdoIHRvIG1hbmFnZS4NCj4g
DQo+IA0K

