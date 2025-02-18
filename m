Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A96C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 23:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkWqR-0006MU-Fg; Tue, 18 Feb 2025 18:17:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkWqP-0006M0-Di
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 18:17:37 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tkWqN-0002Yx-E6
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 18:17:37 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220c2a87378so86113995ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 15:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739920653; x=1740525453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3Tf/UjxqJIVXUNkeiXp8VTGMkldDsfBYEqoyM5Aliw=;
 b=Y6LpXj2Alrfo9J9jqG5ISS8NkPnrFyhtndwM6P+r4/V//NqQ9z/bRrOVGgcV7ZiCoE
 HOGNi8Lghud7Z08hRrPsFS8VH1Z2OH567wqehx5Y2ZC8JxKllNb4mScbQPZuFa5DAhhX
 1/EmDvyJKdeC035suXAsJxx7YVfLMt2aC3b4HrOO+Gd/M3xJ1CSN6uYZ+RXd3FYX/cmA
 krRtDliGOY3nXCIWYILw3grE/QXJa6C4U/2fOMJwQUDreN4siFkMKpxkLyIMQ7+4FhdR
 e04ooLBGrb67l0pZvX6B9W1s6Dbk+yPNDAeo8daJPgAk+vHFVHObNnOTDLfcS+hFubSE
 bL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739920653; x=1740525453;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s3Tf/UjxqJIVXUNkeiXp8VTGMkldDsfBYEqoyM5Aliw=;
 b=c2ebNWaDBvxHrkek/DnfO3pwvclE0o/2MwFo2Vo0NVCWTPfJg/vmhxk3yy7IqXeNA/
 Dn6dpvRPCc3TY7/lHWan26Brb4XS6f76cLq06yEll+D3A8DHOF6dPmXX2jmq9lpjClDA
 Yasb3EQOOHGONT8lR3oo5iwdTzEYv3PY4MM9JFKkBWdVvmSlM2oWXGRQ6wP/e3MRcJuC
 DoC40yoYhBGJEbmnatjEoHI7l4oLLzX2nI5egBtL34NrehmaMSJoE/PLdDE8ry5BueYk
 IB/lP/ey91VZw7TvyXceNc1j1QxtpC/3qSYjZlHG3QD6l76pvnXhMK4gwh6YkWHyfdrf
 K/cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVk1nDEROJ+KzNM1y2HYu4RY8Kw4s6oav9RTIeg8Oy5ttDuGKAzhmC84k8+FBkS6HNimVRlaD0HtmqF@nongnu.org
X-Gm-Message-State: AOJu0YxyG17jBH3rWBTAgablW0i5AwKQR4nnCDKgqlee0xgjat5etjyR
 l+l6m7Z9cPpF/lP2uTMOyES8dlkYASpTGI1r/xadhfqSSoxEoSl7Aj6ws1htvjY=
X-Gm-Gg: ASbGncsjRsvCwGUS3gDIUKGxzTVewzsO8ZDltjK/ZFQkWGzFxY8SVaPKFJL8XCLFQ4L
 yA9pRCE9d2ybezY3Jt3MLp6LRZlSkwySLf/KZcV8Z2jKQNxntsjL6qX/5hXLfWDMHgs3WK0DDGA
 A0opf9tDRW43dF4CxAFpPoTxRiFP+s76Yzi0hxLNSNGj9CM4Z62yNdBrs6trkSmBHwfRYpjd/Nc
 i82esGUO1erC5EtewHckOST6bPECWVuYpnKVWnRk/MlXtJssiw9elNCwBv9VatXR3LJRQoNGUpa
 kF0Ka48IVfGNdR1zphfCxemdFY7Z
X-Google-Smtp-Source: AGHT+IE2IlKbujFpasBsFYP4rGaI2y3lfRyp/okPEYwfug7dkafJibkEbUDEsNUshAOxgsaoL5UUjw==
X-Received: by 2002:a05:6a00:124e:b0:732:23ed:9470 with SMTP id
 d2e1a72fcca58-73261901144mr22387013b3a.23.1739920653225; 
 Tue, 18 Feb 2025 15:17:33 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73285416eb6sm3967821b3a.13.2025.02.18.15.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 15:17:32 -0800 (PST)
Message-ID: <845d324d-833a-4d48-a78e-d384002b17af@linaro.org>
Date: Tue, 18 Feb 2025 15:17:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
To: Stefan Weil <sw@weilnetz.de>, Brian Cain <brian.cain@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
 <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
 <71254e1d-3e17-4082-968f-db7fe6cea590@linaro.org>
 <4e36d996-7446-4bca-8699-063c3c6d91fc@weilnetz.de>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <4e36d996-7446-4bca-8699-063c3c6d91fc@weilnetz.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

T24gMi8xOC8yNSAxMjo1OSwgU3RlZmFuIFdlaWwgd3JvdGU6DQo+IEFtIDE4LjAyLjI1IHVt
IDE3OjIyIHNjaHJpZWIgUGllcnJpY2sgQm91dmllcjoNCj4+IE9uIDIvMTcvMjUgMjA6MTEs
IEJyaWFuIENhaW4gd3JvdGU6DQo+Pj4gSXMgdGhpcyB0b29sY2hhaW4gYXZhaWxhYmxlIHB1
YmxpY2x5IG9yIGRpZCB5b3UgYnVpbGQgaXQgeW91cnNlbGY/wqAgSXQNCj4+PiB3b3VsZCBi
ZSBoYW5keSBpZiB0aGVyZSB3ZXJlIGEgbGludXggeDg2XzY0IGhvc3RlZCBjcm9zcy10b29s
Y2hhaW4gdGhhdA0KPj4+IGNhbiB0YXJnZXQgV2luZG93cy1hYXJjaDY0LsKgIE9yIGxpbnV4
IGFhcmNoNjQgaG9zdGVkIHdvdWxkIGJlIHByZXR0eQ0KPj4+IGdvb2QsIHRvby4NCj4+Pg0K
Pj4NCj4+IEF0IHRoZSBtb21lbnQsIHRoZSBvbmx5IG9wZW4gc291cmNlIHRvb2xjaGFpbiBz
dXBwb3J0aW5nIHdpbmRvd3MtYXJtNjQNCj4+IGlzIGxsdm0tbWluZ3cgKGh0dHBzOi8vZ2l0
aHViLmNvbS9tc3RvcnNqby9sbHZtLW1pbmd3KS4NCj4+IFRoZXJlIGlzIHNvbWUgcHJvZ3Jl
c3Mgb24gZ2NjLCBidXQgaXQgaXMgbm90IHlldCBmdWxseSB1cHN0cmVhbS4NCj4+IE1TWVMy
IHVzZXMgbGx2bS1taW5ndyBmb3Igd2luZG93cy1hcm02NCBlbnZpcm9ubWVudC4NCj4+DQo+
PiBPbiBteSBzaWRlLCBJIHVzZWQgYSB3aW5kb3dzLWFybTY0IG1hY2hpbmUgd2l0aCBNU1lT
MiBuYXRpdmUgZW52aXJvbm1lbnQuDQo+Pg0KPj4gSXQgd291bGQgYmUgaGFuZHkgdG8gY3Jv
c3MgY29tcGlsZSwgYW5kIHRoZSBwcm9ibGVtIGlzIG5vdCByZWFsbHkgUUVNVQ0KPj4gaXRz
ZWxmLCBidXQgdG8gY3Jvc3MgY29tcGlsZSBhbGwgdGhlIGRlcGVuZGVuY2llcy4NCj4+IEZv
ciB4ODZfNjQsIHdlIHVzZSBmZWRvcmEsIHdoaWNoIHByb3ZpZGVzIGNvbnZlbmllbnQgcHJl
Y29tcGlsZWQgbWluZ3cNCj4+IHBhY2thZ2VzIGZvciBkZXBlbmRlbmNpZXMuDQo+PiBJdCdz
IGRlZmluaXRlbHkgbm90IGltcG9zc2libGUgdG8gZG8gdGhlIHNhbWUgZm9yIHdpbmRvd3Mt
YXJtNjQsIGJ1dCBpdA0KPj4ganVzdCB0YWtlcyBtdWNoIG1vcmUgZWZmb3J0Lg0KPj4NCj4+
PiBJcyB0aGVyZSBhbiBNU1lTMiBvciBvdGhlciBkaXN0cmlidXRvciB0aGF0IHByb3ZpZGVz
IHdpbmRvd3MtYWFyY2g2NA0KPj4+IGJ1aWxkcyBvZiB0aGUgZ2xpYiBhbmQgb3RoZXIgbGli
cmFyeSBkZXBlbmRlbmNpZXM/DQo+Pj4NCj4+DQo+PiBNU1lTMiBkb2VzLCBidXQgaXQncyBj
b21wbGljYXRlZCB0byBkb3dubG9hZCBwYWNrYWdlcyBieSBoYW5kIGlmIGl0J3MNCj4+IHlv
dXIgaWRlYS4gQmV0dGVyIHRvIGNyb3NzIGNvbXBpbGUgaXQuDQo+IA0KPiBJIGNvdWxkIHJ1
biBhIFFFTVUgY3Jvc3MgY29tcGlsZSBvbiBEZWJpYW4gd2l0aCB0aGUgbGx2bSB0b29sY2hh
aW4gYW5kDQo+IG1zeXMyIGNsYW5nYXJtNjQgcGFja2FnZXMgaW5zdGFsbGVkIHdpdGggcGFj
bWFuLiBUaGUgcmVzdWx0aW5nIGluc3RhbGxlcg0KPiBpcyBoZXJlOg0KPiANCg0KSGF2ZSB5
b3UgaW5zdGFsbGVkIHRoZSBtc3lzMiBjbGFuZ2FybTY0IHBhY2thZ2VzIG9uIGEgd2luZG93
cyBtYWNoaW5lIA0KZmlyc3QsIGFuZCB0aGVuIGNvcHkgdGhlbSB0byB5b3VyIERlYmlhbiBt
YWNoaW5lPw0KDQo+IGh0dHBzOi8vcWVtdS53ZWlsbmV0ei5kZS9hYXJjaDY0Lw0KPiANCj4g
VGhlIG9ubHkgdG9vbHMgd2hpY2ggd2FzIG1pc3NpbmcgYW5kIHdoaWNoIEkgaGFkIHRvIGJ1
aWxkIGJlZm9yZSBydW5uaW5nDQo+IHRoZSBRRU1VIGJ1aWxkIGlzIGFhcmNoNjQtdzY0LW1p
bmd3MzItd2luZG1jLg0KPiANCj4gSXQgbG9va3MgbGlrZSB0aGUgTlNJUyBpbnN0YWxsZXIg
aXMgaTM4NiBjb2RlLCBzbyBJIGRvbid0IGtub3cgd2hldGhlcg0KPiBpdCBjYW4gYmUgdXNl
ZCBvbiBXaW5kb3dzIGZvciBhYXJjaDY0Lg0KPiANCj4gSSBhbHNvIGhhdmUgbm8gc3VpdGFi
bGUgV2luZG93cyBob3N0IGZvciB0ZXN0aW5nIHRoZSBiaW5hcmllcywgc28gbm8NCj4gdGVz
dCB3YXMgZG9uZS4NCj4gDQo+IFN0ZWZhbiBXLg0KDQo=

