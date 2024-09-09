Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D747ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 21:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snm9w-0003qU-2x; Mon, 09 Sep 2024 17:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1snm9u-0003pQ-Lb
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:42:54 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1snm9s-0005dQ-RR
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 17:42:54 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-7d7a9200947so1600549a12.3
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 14:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725918171; x=1726522971; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vHVljA8EpT/MvCdThZ1y2ivSfhl823Sa7N9Y6HUok7Q=;
 b=OLud7MZcH/06alR6YAtoPN304RCLr+W+VB8nNQi5fYYuGBvjVBNXqzQTytopzWAp7B
 n/ZUflpJbsYKZ+qZILOEkHIN8dkfO+g9DGIL5mmVF0nnHqcmK+tzqRXBcIV1jmQd9ZVR
 Z6S/20KKMgPFqIDuZ/m8D/zAGe6qKz/xJnuP275/Q+Ay3CjfJ+BL3TWadYNzGVfuN3YT
 kV50YxguK3/VlAanhFNlqN2nJ4lN+tn1aWo723RFBm0eqtz9fnH94nKy0jyNTtuL4sdt
 bdLAGcqEUreMW6MgeLEOBJ34kysApzVVu+sfnNgjdz+/qoAP4j9pDfXP3kfP4QicelT/
 6sxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725918171; x=1726522971;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vHVljA8EpT/MvCdThZ1y2ivSfhl823Sa7N9Y6HUok7Q=;
 b=lu9iIuzU1z3j8RxQnfx7muFSlZFcU436tl71txldyQBDcMMqvUfyxeK3jIMCVEOP/H
 6zhCyh95s7+iKQAPTZknkHG2evixCnzuL/nTVOA/gFeyEg9fvOsKDQVGS4E6qflmv6Gv
 mxYv8TM55jFqCFKedtWVmCDtgZLSpmbXAdYA/lX+X/cS0Hrg7q1dhAftoVGzX4JQZgzZ
 VmM7t6cZUk2kVfeOrEBQ8jB5DH5bbKwj3mQd8zMa0QOI+lYrnSz207zI+cr+zktfY5BO
 6SK6puPA4EAwDQ3X/SyM0N3HkdGYn26Eaf62BG9yt2/+4zcNhP7EFUd3l8KJd1nJ0HKR
 ZSWg==
X-Gm-Message-State: AOJu0Yyl7P38xTnnPv3t82HMJfm9WakvP5JgArt/3ErrMzCxXD7s6AkD
 YG1sHjUV/u0hZcrgftnLz8hW2TYiHivF+kWYFIPN4rsfu5LGy30Q8RDg04A4gwI=
X-Google-Smtp-Source: AGHT+IGs5/FX6Zc6/Kn0baQ1Hegm7dB9wpq7Teyt0ld/CATaN0PN/FcgS6ubY+YsM1uBplWkQ9jPxQ==
X-Received: by 2002:a05:6a21:1798:b0:1cf:3ced:bba3 with SMTP id
 adf61e73a8af0-1cf3cedbde2mr4910164637.36.1725918170736; 
 Mon, 09 Sep 2024 14:42:50 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::27bd? ([2604:3d08:9384:1d00::27bd])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7190909273dsm179155b3a.107.2024.09.09.14.42.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 14:42:50 -0700 (PDT)
Message-ID: <58fe9316-bf73-4e38-b162-96a3709ed48a@linaro.org>
Date: Mon, 9 Sep 2024 14:42:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] plugins: access values during a memory read/write
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Zhao Liu <zhao1.liu@intel.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240724194708.1843704-1-pierrick.bouvier@linaro.org>
 <8734met9c8.fsf@draig.linaro.org>
 <68171cdb-8dd9-4d80-85de-457e84e17d65@linaro.org>
 <87h6apxi2d.fsf@draig.linaro.org>
 <cc597a6b-1ac5-464e-9e39-85e36bd0023c@linaro.org>
 <874j6oy3wr.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <874j6oy3wr.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x531.google.com
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

T24gOS85LzI0IDEzOjIxLCBBbGV4IEJlbm7DqWUgd3JvdGU6DQo+IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPiANCj4+IE9uIDkv
OS8yNCAwMzowMCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4gd3JpdGVzOg0KPj4+DQo+Pj4+IE9uIDkv
NS8yNCAwODoyMSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4+Pj4gUGllcnJpY2sgQm91dmll
ciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+Pj4+Pg0KPj4+Pj4+
IFRoaXMgc2VyaWVzIGFsbG93cyBwbHVnaW5zIHRvIGtub3cgd2hpY2ggdmFsdWUgaXMgcmVh
ZC93cml0dGVuIGR1cmluZyBhIG1lbW9yeQ0KPj4+Pj4+IGFjY2Vzcy4NCj4+Pj4+Pg0KPj4+
Pj4+IEZvciBldmVyeSBtZW1vcnkgYWNjZXNzLCB3ZSBrbm93IGNvcHkgdGhpcyB2YWx1ZSBi
ZWZvcmUgY2FsbGluZyBtZW0gY2FsbGJhY2tzLA0KPj4+Pj4+IGFuZCB0aG9zZSBjYW4gcXVl
cnkgaXQgdXNpbmcgbmV3IEFQSSBmdW5jdGlvbjoNCj4+Pj4+PiAtIHFlbXVfcGx1Z2luX21l
bV9nZXRfdmFsdWUNCj4+Pj4+IFF1ZXVlZCB0byBwYXRjaGVzIDEtNSB0byBwbHVnaW5zL25l
eHQsIHRoYW5rcy4NCj4+Pj4+IFlvdSBjYW4gc2VuZCB0aGUgcmUtc3B1biB2ZXJzaW9uIG9m
IDYgb25jZSB0aGUgcmV2aWV3IGNvbW1lbnRzIGhhdmUNCj4+Pj4+IGJlZW4NCj4+Pj4+IGRv
bmUuDQo+Pj4+Pg0KPj4+Pg0KPj4+PiBUaGFua3MgQWxleCwNCj4+Pj4NCj4+Pj4gcmlnaHQg
bm93LCBteSB0cnkgdG8gbWFrZSBjaGVjay10Y2cgYXJlIGJsb2NrZWQgd2l0aCB0aGUgY3Jv
c3MNCj4+Pj4gY29udGFpbmVycyB3aG8gZG9uJ3QgY29tcGlsZSwgc28gSSdsbCB3YWl0IGZv
ciB0aGlzIHRvIGJlIHJlc29sdmVkLg0KPj4+IFdoaWNoIG9uZXM/DQo+Pg0KPj4gZG9ja2Vy
LWltYWdlLWRlYmlhbi1taXBzNjRlbC1jcm9zcw0KPj4gZG9ja2VyLWltYWdlLWRlYmlhbi1t
aXBzZWwtY3Jvc3MNCj4+IChhYm91dCBicm9rZW4gcGFja2FnZXMpLg0KPiANCj4gSSBoYXZl
IGZpeGVzIGZvciBtaXBzZWwgYXQgbGVhc3Qgd2hlbiBJIHBvc3QgbXkgc2VyaWVzLg0KPiAN
Cj4+DQo+PiBJIHNhdyBzb21ldGhpbmcgbWVudGlvbmluZyB0aGlzIHJlY2VudGx5IG9uIHRo
ZSBtYWlsaW5nIGxpc3QsIHNvIG5vdA0KPj4gc3VyZSB3aGF0IHdvdWxkIGJlIG91ciBzb2x1
dGlvbiB0byB0aGlzIChpZ25vcmluZz8pDQo+Pg0KPj4+DQo+Pj4+IEkgc3RpbGwgd29uZGVy
IGlmIGhhdmluZyBhIHNpbXBsZSBhYXJjaDY0L3g2NCB0ZXN0IGlzIG5vdCBlbm91Z2gsIGFu
ZA0KPj4+PiBjb3ZlcmluZyA5OS45JSBvZiB0aGUgYnVnIHdlIGNvdWxkIGludHJvZHVjZSBp
biB0aGUgZnV0dXJlIG9uIHRoaXMuDQo+Pj4gSGF2ZSB5b3UgbWVhc3VyZWQgdGhlIGNvZGUg
Y292ZXJhZ2Ugb2YgdGhlIHRlc3Q/DQo+Pj4NCj4+DQo+PiBOb3BlLCBidXQgYWxsIHRoZSBj
b2RlIGNoYW5nZWQgaXMgdGNnLWdlbmVyaWMsIHNvIHRlc3RpbmcgdGhpcyBvbiBhbGwNCj4+
IGFyY2ggZG9lcyBub3QgYnJpbmcgYmVuZWZpdCBpbiB0ZXJtcyBvZiBjb3ZlcmFnZS4NCj4g
DQo+IFdvdWxkIHRoYXQgaXQgd2VyZSBzbyBzaW1wbGUuIFF1aXRlIG9mdGVuIHdoaWNoIGJp
dHMgb2YgdGhlIGdlbmVyaWMgVENHDQo+IGNvZGUgZ2V0IGV4ZXJjaXNlZCBkZXBlbmRzIG9u
IHRoZSBndWVzdCBhcmNoaXRlY3R1cmUgdXNpbmcgaXQuIEknbSBub3QNCj4gc2F5aW5nIHdl
IGhhdmUgdG8gZ28gb3ZlciBhbmQgYWJvdmUgdG8gZW5hYmxlIGZpZGRseSBhcmNoaXRlY3R1
cmVzIGJ1dCB3ZQ0KPiBzaG91bGQgYXQgbGVhc3QgdW5kZXJzdGFuZCBpZiB0aGUgcmVhc29u
IHRoZXkgZmFpbCBpcyBkb3duIHRvIHRoZW0gb3INCj4gY29yZSBjb2RlLg0KDQpJIHVuZGVy
c3RhbmQgeW91ciBwb2ludCwgYW5kIHdpbGwgdHJ5IHRvIG1ha2UgdGhpcyB3b3JrIG9uIGFs
bCBhcmNoLg0KDQo+IA0KPj4gU28gYnkgZm9jdXNpbmcgb24gdGhlICJhbGwgYXJjaCIgYXNw
ZWN0LCB3ZSBqdXN0IHRlc3QgdGNnDQo+PiBpbXBsZW1lbnRhdGlvbiBpdHNlbGYsIGluc3Rl
YWQgb2YgdGhlIHBsdWdpbnMgcGFydC4NCj4+DQo+PiBUaGUgcHJvYmxlbXMgd2UgaWRlbnRp
ZmllZCBzbyBmYXIgaXMgY29tcGlsYXRpb24gZmxhZ3Mgc3BlY2lmaWMgcGVyDQo+PiBhcmNo
LCBhbmQgc3BlY2lmaWMgZmxhZ3MgdG8gZW1pdCB3b3JkcyBpbnN0cnVjdGlvbi4gSXQgZG9l
cyBub3Qgc2VlbQ0KPj4gcmVsYXRlZCB0byB3aGF0IHdlIHJlYWxseSB3YW50IHRvIHRlc3Qg
aGVyZS4NCj4gDQo+IEknbSBhbHNvIGludmVzdGlnYXRpbmcgd2h5IGFybS1zb2Z0bW11IHNl
ZW1zIHRvIGJlIHNlZWluZyBtb3JlIGFjY2Vzc2VzDQo+IHRoYW4gaXQgc2hvdWxkIGhhdmUg
ZnJvbSB0aGUgdGVzdC4NCj4gDQoNCkdvb2QhDQo=

