Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01B7C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seekU-0007QP-Id; Thu, 15 Aug 2024 13:58:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seekT-0007MI-Fp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:58:57 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seekR-0004mC-Nc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:58:57 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1ff67158052so9122375ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723744734; x=1724349534; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=soW/UxNTVhflNJS4erlXhZSbLv/T+YEiK5qqd9ov4Jw=;
 b=jNjLTOwfGXkEmbiiDVQPcMqt4eEhx1YEnzsYuKtEGIHbvhwl4yPYSd/+yw/OOcJrBF
 8fOvkwujP4+9kV4mPEDXCF65EoA2oLy/V+xfGw4RcCIaMMtr4NZfxpcwLi2LNexZSZ+K
 pG+cc35cRdbYgo2XDYDsgi3K10aErk/nxNK+YEMZA5BF3E4QqJ+naJsZSXj+TVxxNng/
 U8XerN3MBPUAveUO8ZlCWgjJb9vqgZdOSXvQmeWJZot+UVWuoYClgsj2jABSoU4YHcIq
 epkEInomWylYPXQ9y7+PkmduFC5ZhWlENkIWPRaVJFROJDA9J2TyZoJYMYwhsTtPzbKY
 3YMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723744734; x=1724349534;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=soW/UxNTVhflNJS4erlXhZSbLv/T+YEiK5qqd9ov4Jw=;
 b=hR5nuq5aoUz/RPt/bYV/MLAphRK7neIPvvUjqLRlt6CcZdJTBF+ATJORk0Yh+1QQZ3
 plbc7s7vpOOllmwhQIdRH/GmnyI7+uOY97o6TrxKSAdnk4pC7rWyu4pyRswTMTXm/c4v
 nWLNXC01P9pyCRACO5CbMdczkYAGSt1duORZim95XbEM+SD8TFSCf3KGOi1VhZQr/OEP
 mOyzkRCyNw/oHCVLhfIOSqES5grqdHmBe1xQ8soBWUA8xyDXNSJMOQVBUBgXq3kArf89
 9jutLqfc2KeN/VghsDnApNHmK6F7W5UeJVlL50I1ry0kDiDVk+i7p2h7IFGoIYQySdqY
 b5kw==
X-Gm-Message-State: AOJu0YwzwfE8DZxHyYaBLPCVFav3LSzDMKbmSQ/M8mhNKHf6mSl7OLRG
 w2L5tHCqDasXZ+HmvXaNChJyj9eCuofvrQCsHSJogoywEJqiR2R1JFcq56OcIGUCMSj7BETceBQ
 t55o=
X-Google-Smtp-Source: AGHT+IG8RgoCPeYjVGtE5HgUKk1iC6j3rCHioXfqsJUhDkWkGFBqSH86EVRl3Fze5yBsgzIdlxFsRQ==
X-Received: by 2002:a17:903:22cf:b0:1fb:6294:2e35 with SMTP id
 d9443c01a7336-20203f280a2mr5097105ad.50.1723744734003; 
 Thu, 15 Aug 2024 10:58:54 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f039e084sm12724745ad.243.2024.08.15.10.58.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:58:53 -0700 (PDT)
Message-ID: <4c133680-1be8-41f1-82ce-78e967809da1@linaro.org>
Date: Thu, 15 Aug 2024 10:58:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
 <Zr3g7lEfteRpNYVC@redhat.com>
 <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

T24gOC8xNS8yNCAxMDo1NCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4gT24gVGh1LCAxNSBB
dWcgMjAyNCBhdCAxMjowNSwgRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0
LmNvbT4gd3JvdGU6DQo+Pg0KPj4gT24gVGh1LCBBdWcgMTUsIDIwMjQgYXQgMTE6MTI6MzlB
TSArMDEwMCwgUGV0ZXIgTWF5ZGVsbCB3cm90ZToNCj4+PiBPbiBXZWQsIDE0IEF1ZyAyMDI0
IGF0IDIzOjQyLCBQaWVycmljayBCb3V2aWVyDQo+Pj4gPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4gd3JvdGU6DQo+Pj4+DQo+Pj4+IFdoZW4gYnVpbGRpbmcgd2l0aCBnY2MtMTIg
LWZzYW5pdGl6ZT10aHJlYWQsIGdjYyByZXBvcnRzIHNvbWUNCj4+Pj4gY29uc3RydWN0aW9u
cyBub3Qgc3VwcG9ydGVkIHdpdGggdHNhbi4NCj4+Pj4gRm91bmQgb24gZGViaWFuIHN0YWJs
ZS4NCj4+Pj4NCj4+Pj4gcWVtdS9pbmNsdWRlL3FlbXUvYXRvbWljLmg6MzY6NTI6IGVycm9y
OiDigJhhdG9taWNfdGhyZWFkX2ZlbmNl4oCZIGlzIG5vdCBzdXBwb3J0ZWQgd2l0aCDigJgt
ZnNhbml0aXplPXRocmVhZOKAmSBbLVdlcnJvcj10c2FuXQ0KPj4+PiAgICAgMzYgfCAjZGVm
aW5lIHNtcF9tYigpICAgICAgICAgICAgICAgICAgICAgKHsgYmFycmllcigpOyBfX2F0b21p
Y190aHJlYWRfZmVuY2UoX19BVE9NSUNfU0VRX0NTVCk7IH0pDQo+Pj4+ICAgICAgICB8ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4+Pg0KPj4+PiBTaWduZWQt
b2ZmLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQo+Pj4+IC0tLQ0KPj4+PiAgIG1lc29uLmJ1aWxkIHwgMTAgKysrKysrKysrLQ0KPj4+PiAg
IDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4+Pj4N
Cj4+Pj4gZGlmZiAtLWdpdCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQNCj4+Pj4gaW5k
ZXggODFlY2Q0YmFlN2MuLjUyZTVhYTk1Y2MwIDEwMDY0NA0KPj4+PiAtLS0gYS9tZXNvbi5i
dWlsZA0KPj4+PiArKysgYi9tZXNvbi5idWlsZA0KPj4+PiBAQCAtNDk5LDcgKzQ5OSwxNSBA
QCBpZiBnZXRfb3B0aW9uKCd0c2FuJykNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgcHJlZml4OiAnI2luY2x1ZGUgPHNhbml0aXplci90c2FuX2ludGVyZmFjZS5oPicpDQo+
Pj4+ICAgICAgIGVycm9yKCdDYW5ub3QgZW5hYmxlIFRTQU4gZHVlIHRvIG1pc3NpbmcgZmli
ZXIgYW5ub3RhdGlvbiBpbnRlcmZhY2UnKQ0KPj4+PiAgICAgZW5kaWYNCj4+Pj4gLSAgcWVt
dV9jZmxhZ3MgPSBbJy1mc2FuaXRpemU9dGhyZWFkJ10gKyBxZW11X2NmbGFncw0KPj4+PiAr
ICB0c2FuX3dhcm5fc3VwcHJlc3MgPSBbXQ0KPj4+PiArICAjIGdjYyAoPj0xMSkgd2lsbCBy
ZXBvcnQgY29uc3RydWN0aW9ucyBub3Qgc3VwcG9ydGVkIGJ5IHRzYW46DQo+Pj4+ICsgICMg
ImVycm9yOiDigJhhdG9taWNfdGhyZWFkX2ZlbmNl4oCZIGlzIG5vdCBzdXBwb3J0ZWQgd2l0
aCDigJgtZnNhbml0aXplPXRocmVhZOKAmSINCj4+Pj4gKyAgIyBodHRwczovL2djYy5nbnUu
b3JnL2djYy0xMS9jaGFuZ2VzLmh0bWwNCj4+Pj4gKyAgIyBIb3dldmVyLCBjbGFuZyBkb2Vz
IG5vdCBzdXBwb3J0IHRoaXMgd2FybmluZyBhbmQgdGhpcyB0cmlnZ2VycyBhbiBlcnJvci4N
Cj4+Pj4gKyAgaWYgY2MuaGFzX2FyZ3VtZW50KCctV25vLXRzYW4nKQ0KPj4+PiArICAgIHRz
YW5fd2Fybl9zdXBwcmVzcyA9IFsnLVduby10c2FuJ10NCj4+Pj4gKyAgZW5kaWYNCj4+Pg0K
Pj4+IFRoYXQgbGFzdCBwYXJ0IHNvdW5kcyBsaWtlIGEgY2xhbmcgYnVnIC0tIC1Xbm8tZm9v
IGlzIHN1cHBvc2VkDQo+Pj4gdG8gbm90IGJlIGFuIGVycm9yIG9uIGNvbXBpbGVycyB0aGF0
IGRvbid0IGltcGxlbWVudCAtV2ZvbyBmb3INCj4+PiBhbnkgdmFsdWUgb2YgZm9vICh1bmxl
c3Mgc29tZSBvdGhlciB3YXJuaW5nL2Vycm9yIHdvdWxkIGFsc28NCj4+PiBiZSBlbWl0dGVk
KS4NCj4+DQo+PiAtV25vLWZvbyBpc24ndCBhbiBlcnJvciwgYnV0IGl0IGlzIGEgd2Fybmlu
Zy4uLiB3aGljaCB3ZSB0aGVuDQo+PiB0dXJuIGludG8gYW4gZXJyb3IgZHVlIHRvIC1XZXJy
b3IsIHVubGVzcyB3ZSBwYXNzIC1Xbm8tdW5rbm93bi13YXJuaW5nLW9wdGlvbg0KPj4gdG8g
Y2xhbmcuDQo+IA0KPiBXaGljaCBpcyBpcnJpdGF0aW5nIGlmIHlvdSB3YW50IHRvIGJlIGFi
bGUgdG8gYmxhbmtldCBzYXkNCj4gJy1Xbm8tc2lsbHktY29tcGlsZXItd2FybmluZycgYW5k
IG5vdCBzZWUgYW55IG9mIHRoYXQNCj4gd2FybmluZyByZWdhcmRsZXNzIG9mIGNvbXBpbGVy
IHZlcnNpb24uIFRoYXQncyB3aHkgdGhlDQo+IGdjYyBiZWhhdmlvdXIgaXMgdGhlIHdheSBp
dCBpcyAoaS5lLiAtV25vLXN1Y2gtdGhpbmd5DQo+IGlzIG5laXRoZXIgYSB3YXJuaW5nIG5v
ciBhbiBlcnJvciBpZiBpdCB3b3VsZCBiZSB0aGUgb25seQ0KPiB3YXJuaW5nL2Vycm9yKSwg
YW5kIGlmIGNsYW5nIGRvZXNuJ3QgbWF0Y2ggaXQgdGhhdCdzIGEgc2hhbWUuDQo+IA0KDQpJ
dCdzIHdoeSBJIGNob3NlIHRvIGltcGxlbWVudCB0aGlzIHVzaW5nIGNjLmhhc19hcmd1bWVu
dCgpLCBpbnN0ZWFkIG9mIA0KdHJ5aW5nIHRvIGlkZW50aWZ5IGNvbXBpbGVyL3ZlcnNpb24u
DQoNCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

