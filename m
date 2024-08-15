Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD62C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 17:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seejZ-0004Le-Om; Thu, 15 Aug 2024 13:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seejX-0004K9-Jw
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:57:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seejT-0004ik-KR
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 13:57:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-710cad5778fso1000199b3a.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723744674; x=1724349474; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g2zXSYbhmYF2CAYqRjJR/DpyeR0RGytNvb7sahLmXoc=;
 b=lqTx+MtobYEfhThVSMNIoUulZJOrZHVWmqjtcL4i1QyKnfF/Yk1Fs8XCNnpmb9aWu6
 IklmJAmm2+1lAxq8fl+XOoi9K9e1kYXnR/WlZrad3UAvSVV1TMnp8vrFhIX1Kivln15t
 KoMu34BNfyYXddeJq2l5ATsQrtsb7njCCmN2KAJUV8mpbISZP2mz7ZTkUYJ9MsDFr2Uw
 1WKyApTtoOXnTDytvrJJSM/tgdTEoA0f0UXKD2RzrkcagqW+SpRZ94T41U+NyUooUKoB
 2HWzbXaChSyrgm+oyEhPzpAKZiN6mkKNk01QOZkztwS4FJ2WtqCSB+JdO4rJ1p89EbSF
 kK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723744674; x=1724349474;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g2zXSYbhmYF2CAYqRjJR/DpyeR0RGytNvb7sahLmXoc=;
 b=De0UGqwspYEYyik8DIFTjGEnUlj2BKxieKmHkV4fbBcKfGopUiYjaXkxasVOBZc8/d
 2GQRskJo71qhh7LtUHGZZxEBMIyyMzDEqh9uG3uyVKAj/UECm05pjvuDIF6mIusEA+rD
 kquy5T25mYaiKwv+jR63k4J7P8rugsWDpYLMOzoDbPYHk0V1SYtsqwtGeXwoKw/NR8u2
 rd2McYYsHdg4EzN5g7yg3GDFpwW9BWqaCWQAW3aRRWddwVPImP2p/X4cGXopbJDdh6ZA
 xsaY8aq4vBy598ECTwdO3syTraYmv+Sbf9bzQvrxiAuAPd0PPs+QzAfhQIgTHgvRtGle
 Blag==
X-Forwarded-Encrypted: i=1;
 AJvYcCW755QVyoHG6/KMykgBm2Iw9On8RR0l1l7dpBN2LPXZfoF2pv6dVtvwpPlVBz5gFbZX27GLeqSS+wwJJfSRPQLzFs6Zo6Q=
X-Gm-Message-State: AOJu0Yx6UxdV2bTOTqaLjX48Bb7QCK78y8GwKPr3JMSN377AS43rbNA4
 R1Y5ooafa8ZnrKl/mCisv1AImZWRNAHF4GSexjk2y+IkMiUpxR6+MPeB28xjVh8=
X-Google-Smtp-Source: AGHT+IEYjObpdvvbSflNmE9KwuBlSmcKhM40rDsJNnKlAsOF3prcvHCtvMDWUtdwMrFrJos1d/Ogdw==
X-Received: by 2002:a05:6a21:2d8d:b0:1c2:8d91:634 with SMTP id
 adf61e73a8af0-1c90506e40cmr572811637.45.1723744673986; 
 Thu, 15 Aug 2024 10:57:53 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7127aef5229sm1254761b3a.107.2024.08.15.10.57.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 10:57:53 -0700 (PDT)
Message-ID: <9286d40e-f760-4219-b202-e1e892687086@linaro.org>
Date: Thu, 15 Aug 2024 10:57:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <8a987dbb-aff5-42dc-ae56-0b6b4e6a985a@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <8a987dbb-aff5-42dc-ae56-0b6b4e6a985a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

T24gOC8xNS8yNCAwMjo1MCwgVGhvbWFzIEh1dGggd3JvdGU6DQo+IE9uIDE1LzA4LzIwMjQg
MDAuNDEsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBXaGVuIGJ1aWxkaW5nIHdpdGgg
Z2NjLTEyIC1mc2FuaXRpemU9dGhyZWFkLCBnY2MgcmVwb3J0cyBzb21lDQo+PiBjb25zdHJ1
Y3Rpb25zIG5vdCBzdXBwb3J0ZWQgd2l0aCB0c2FuLg0KPj4gRm91bmQgb24gZGViaWFuIHN0
YWJsZS4NCj4+DQo+PiBxZW11L2luY2x1ZGUvcWVtdS9hdG9taWMuaDozNjo1MjogZXJyb3I6
IOKAmGF0b21pY190aHJlYWRfZmVuY2XigJkgaXMgbm90IHN1cHBvcnRlZCB3aXRoIOKAmC1m
c2FuaXRpemU9dGhyZWFk4oCZIFstV2Vycm9yPXRzYW5dDQo+PiAgICAgIDM2IHwgI2RlZmlu
ZSBzbXBfbWIoKSAgICAgICAgICAgICAgICAgICAgICh7IGJhcnJpZXIoKTsgX19hdG9taWNf
dGhyZWFkX2ZlbmNlKF9fQVRPTUlDX1NFUV9DU1QpOyB9KQ0KPj4gICAgICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCj4+IC0t
LQ0KPj4gICAgbWVzb24uYnVpbGQgfCAxMCArKysrKysrKystDQo+PiAgICAxIGZpbGUgY2hh
bmdlZCwgOSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL21lc29uLmJ1aWxkIGIvbWVzb24uYnVpbGQNCj4+IGluZGV4IDgxZWNkNGJhZTdjLi41
MmU1YWE5NWNjMCAxMDA2NDQNCj4+IC0tLSBhL21lc29uLmJ1aWxkDQo+PiArKysgYi9tZXNv
bi5idWlsZA0KPj4gQEAgLTQ5OSw3ICs0OTksMTUgQEAgaWYgZ2V0X29wdGlvbigndHNhbicp
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJlZml4OiAnI2luY2x1ZGUgPHNh
bml0aXplci90c2FuX2ludGVyZmFjZS5oPicpDQo+PiAgICAgICAgZXJyb3IoJ0Nhbm5vdCBl
bmFibGUgVFNBTiBkdWUgdG8gbWlzc2luZyBmaWJlciBhbm5vdGF0aW9uIGludGVyZmFjZScp
DQo+PiAgICAgIGVuZGlmDQo+PiAtICBxZW11X2NmbGFncyA9IFsnLWZzYW5pdGl6ZT10aHJl
YWQnXSArIHFlbXVfY2ZsYWdzDQo+PiArICB0c2FuX3dhcm5fc3VwcHJlc3MgPSBbXQ0KPj4g
KyAgIyBnY2MgKD49MTEpIHdpbGwgcmVwb3J0IGNvbnN0cnVjdGlvbnMgbm90IHN1cHBvcnRl
ZCBieSB0c2FuOg0KPj4gKyAgIyAiZXJyb3I6IOKAmGF0b21pY190aHJlYWRfZmVuY2XigJkg
aXMgbm90IHN1cHBvcnRlZCB3aXRoIOKAmC1mc2FuaXRpemU9dGhyZWFk4oCZIg0KPj4gKyAg
IyBodHRwczovL2djYy5nbnUub3JnL2djYy0xMS9jaGFuZ2VzLmh0bWwNCj4+ICsgICMgSG93
ZXZlciwgY2xhbmcgZG9lcyBub3Qgc3VwcG9ydCB0aGlzIHdhcm5pbmcgYW5kIHRoaXMgdHJp
Z2dlcnMgYW4gZXJyb3IuDQo+PiArICBpZiBjYy5oYXNfYXJndW1lbnQoJy1Xbm8tdHNhbicp
DQo+PiArICAgIHRzYW5fd2Fybl9zdXBwcmVzcyA9IFsnLVduby10c2FuJ10NCj4+ICsgIGVu
ZGlmDQo+PiArICBxZW11X2NmbGFncyA9IFsnLWZzYW5pdGl6ZT10aHJlYWQnXSArIHRzYW5f
d2Fybl9zdXBwcmVzcyArIHFlbXVfY2ZsYWdzDQo+PiAgICAgIHFlbXVfbGRmbGFncyA9IFsn
LWZzYW5pdGl6ZT10aHJlYWQnXSArIHFlbXVfbGRmbGFncw0KPj4gICAgZW5kaWYNCj4+ICAg
IA0KPiANCj4gTm90IHN1cmUgaWYgd2Ugc2hvdWxkIGhpZGUgdGhlc2Ugd2FybmluZ3MgLi4u
IHRoZXkgc2VlbSB0byBiZSB0aGVyZSBmb3IgYQ0KPiByZWFzb24/IFBhb2xvLCBhbnkgaWRl
YXM/DQo+IA0KDQpUaGlzIGlzIGEgbmV3IHdhcm5pbmcgYWRkZWQgaW4gZ2NjLTExLCB0byBw
cmV2ZW50IHRoYXQgbm90IGFsbCANCmNvbnN0cnVjdGlvbnMgYXJlIHN1cHBvcnRlZCBieSB0
aHJlYWQgc2FuaXRpemVyLiBUaGlzIHdhcyB0cnVlIGJlZm9yZSwgDQphbmQgd2lsbCBiZSB0
cnVlIGFmdGVyLiBCYXNpY2FsbHksIG1hbnVhbCBtZW1vcnkgYmFycmllcnMgYXJlIG5vdCAN
CnN1cHBvcnRlZCB0byBtb2RlbCBjb25jdXJyZW5jeS4gV2UgY2FuIGhhcmRseSBjaGFuZ2Ug
c29tZXRoaW5nIG9uIFFFTVUgDQpzaWRlIGFzIGl0J3MgYSBsaW1pdGF0aW9uIG9mIHRzYW4g
aXRzZWxmLg0KDQpHb29kIG5ld3MgaXMgdGhhdCBpdCBkb2VzIG5vdCBzZWVtIHRvIGJyaW5n
IGZhbHNlIHBvc2l0aXZlcyB3aGVuIA0KZXhlY3V0aW5nIGEgcWVtdSB3aXRoIHRzYW4uIFRo
dXMsIHRoaXMgcGF0Y2ggdG8gaWdub3JlIHRoaXMgZm9yIG5vdy4NCg0KPiAgICBUaG9tYXMN
Cj4gDQo=

