Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5758AC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 15:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQNN-0005Ka-PG; Wed, 12 Jun 2024 11:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQNM-0005KH-NI
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:59:04 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sHQNL-0000b6-0q
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 11:59:04 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2c4af25f7d7so571558a91.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 08:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718207941; x=1718812741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w09RxZOBny7Sg1bz7VrqcLEIzdlX8GfmywPXOlJGEc0=;
 b=E2e28Du4gJ7E935aY9kVw+g3WjP6Z1RgH/mqsH4AKjDSTRf5Cm9jPXk9K9Lg8RSojR
 j24UzylI8qM0V4TQj31a8h9LExEu2dCrpLE/vf/n+JiPOiuk/GHmi8r+lFFfMYRUhTQb
 krKB4Ctdti2w+aTwc76e2orL9FJbe01z0Cfhqdh6OjX7c3vRjFrulWIyDfq+qVz9VtF4
 UgS74kULsANk3Yo4OWx9yf25zSWD6IWMo4mrX65GhXcIAULt4zCTDrx3/tJU+ZL4e2Qi
 c6F5XAROJ1MrOq7w06JU+Lb6JKKNRAtM20Eb1aSZTIAOWNwdTpuO8NYubhbB+RVVw+dH
 3lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718207941; x=1718812741;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w09RxZOBny7Sg1bz7VrqcLEIzdlX8GfmywPXOlJGEc0=;
 b=s0vN72bpvqjE9tF11jLTKCRfshjzxLZUvsbVnuojfZ1WD6/ST5dLxYNpT11s077ten
 2VPlN3UL1nK+yfZ1k48jNF3fvSX9oU0gP2V/PAC53+k5huvyDJNaXpyK9ccPQ/4Lwoqt
 jLCDJie/JWz/s2Mxb3BhCk2H9PXy71rcOQTRI2DRvKF1spux0Rlj+ems4JCyyZlrR17P
 xy04aQI6HnfHKPALApwPdOsOxSnq3v9mTtuElEkoniIHUPbFNvXr5Xk/Ykc3clmLQC4o
 iZdvxsIpGbdD/4yEH0jpUzyRGCAVUWpl/8rEuBdn3e4p4JcPsP2xaMHoHeTtrVtGozZQ
 2K2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWj2rPhz0fA2Xr4roG6ORKnm4Znjh8/qwqgKtxtYfme+YJIlLEh5T5xHT64ADkIVXT8YQeQvqDg6KpX3yIdhwMtcfH6A4g=
X-Gm-Message-State: AOJu0YzkztA4KstZ3DLlX2PJiv/gnI3XiC41QsSUAHLSz6SzwynzCxxp
 ElSbO7zo41To7Qu75bsjlzUQ6Hb2CWkhKlvlW/FcwnHP6JcVeCgDgrLArWdseEs=
X-Google-Smtp-Source: AGHT+IFoOB41A/pNuCVe7i10DhwZq0RfFVAAxo73DwlamIyd9qOnO1yuSNSWMDuxunZowX6e1t+sWA==
X-Received: by 2002:a17:90a:5904:b0:2c2:f70a:3c17 with SMTP id
 98e67ed59e1d1-2c4a772cbd0mr2100460a91.46.1718207941451; 
 Wed, 12 Jun 2024 08:59:01 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::2193? ([2604:3d08:9384:1d00::2193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a75e1130sm1980891a91.3.2024.06.12.08.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Jun 2024 08:59:01 -0700 (PDT)
Message-ID: <757024bf-9da2-4f2e-9df1-dcbfac573582@linaro.org>
Date: Wed, 12 Jun 2024 08:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] plugins: Ensure register handles are not NULL
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org,
 Laurent Vivier <lvivier@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Alexandre Iooss <erdnaxe@crans.org>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Nicholas Piggin <npiggin@gmail.com>,
 Marco Liebel <mliebel@qti.qualcomm.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-ppc@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Cameron Esfahani <dirty@apple.com>,
 Jamie Iles <quic_jiles@quicinc.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240612153508.1532940-1-alex.bennee@linaro.org>
 <20240612153508.1532940-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240612153508.1532940-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1030.google.com
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

T24gNi8xMi8yNCAwODozNSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBGcm9tOiBBa2loaWtv
IE9kYWtpIDxha2loaWtvLm9kYWtpQGRheW5peC5jb20+DQo+IA0KPiBFbnN1cmUgcmVnaXN0
ZXIgaGFuZGxlcyBhcmUgbm90IE5VTEwgc28gdGhhdCBhIHBsdWdpbiBjYW4gYXNzdW1lIE5V
TEwgaXMNCj4gaW52YWxpZCBhcyBhIHJlZ2lzdGVyIGhhbmRsZS4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IEFraWhpa28gT2Rha2kgPGFraWhpa28ub2Rha2lAZGF5bml4LmNvbT4NCj4gTWVz
c2FnZS1JZDogPDIwMjQwMjI5LW51bGwtdjEtMS1lNzE2NTAxZDk4MWVAZGF5bml4LmNvbT4N
Cj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
Pg0KPiAtLS0NCj4gICBwbHVnaW5zL2FwaS5jIHwgNCArKy0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS9wbHVnaW5zL2FwaS5jIGIvcGx1Z2lucy9hcGkuYw0KPiBpbmRleCA1YTBhN2Y4YzcxLi42
YmRiMjZiYmUzIDEwMDY0NA0KPiAtLS0gYS9wbHVnaW5zL2FwaS5jDQo+ICsrKyBiL3BsdWdp
bnMvYXBpLmMNCj4gQEAgLTUwNyw3ICs1MDcsNyBAQCBzdGF0aWMgR0FycmF5ICpjcmVhdGVf
cmVnaXN0ZXJfaGFuZGxlcyhHQXJyYXkgKmdkYnN0dWJfcmVncykNCj4gICAgICAgICAgIH0N
Cj4gICANCj4gICAgICAgICAgIC8qIENyZWF0ZSBhIHJlY29yZCBmb3IgdGhlIHBsdWdpbiAq
Lw0KPiAtICAgICAgICBkZXNjLmhhbmRsZSA9IEdJTlRfVE9fUE9JTlRFUihncmQtPmdkYl9y
ZWcpOw0KPiArICAgICAgICBkZXNjLmhhbmRsZSA9IEdJTlRfVE9fUE9JTlRFUihncmQtPmdk
Yl9yZWcgKyAxKTsNCj4gICAgICAgICAgIGRlc2MubmFtZSA9IGdfaW50ZXJuX3N0cmluZyhn
cmQtPm5hbWUpOw0KPiAgICAgICAgICAgZGVzYy5mZWF0dXJlID0gZ19pbnRlcm5fc3RyaW5n
KGdyZC0+ZmVhdHVyZV9uYW1lKTsNCj4gICAgICAgICAgIGdfYXJyYXlfYXBwZW5kX3ZhbChm
aW5kX2RhdGEsIGRlc2MpOw0KPiBAQCAtNTI4LDcgKzUyOCw3IEBAIGludCBxZW11X3BsdWdp
bl9yZWFkX3JlZ2lzdGVyKHN0cnVjdCBxZW11X3BsdWdpbl9yZWdpc3RlciAqcmVnLCBHQnl0
ZUFycmF5ICpidWYpDQo+ICAgew0KPiAgICAgICBnX2Fzc2VydChjdXJyZW50X2NwdSk7DQo+
ICAgDQo+IC0gICAgcmV0dXJuIGdkYl9yZWFkX3JlZ2lzdGVyKGN1cnJlbnRfY3B1LCBidWYs
IEdQT0lOVEVSX1RPX0lOVChyZWcpKTsNCj4gKyAgICByZXR1cm4gZ2RiX3JlYWRfcmVnaXN0
ZXIoY3VycmVudF9jcHUsIGJ1ZiwgR1BPSU5URVJfVE9fSU5UKHJlZykgLSAxKTsNCj4gICB9
DQo+ICAgDQo+ICAgc3RydWN0IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmQgKnFlbXVfcGx1Z2lu
X3Njb3JlYm9hcmRfbmV3KHNpemVfdCBlbGVtZW50X3NpemUpDQoNClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

