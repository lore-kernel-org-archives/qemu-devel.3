Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A907DCDD551
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzmC-0008V0-W8; Wed, 18 Sep 2024 14:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzmB-0008NE-Bs
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:51:43 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzm9-0003ve-Cw
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:51:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71979bf5e7aso1477656b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726685500; x=1727290300; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LjIeRfMRna/s5IjipiaGPy/meIfbXoGPkLDkm3TO6Ow=;
 b=dMWZvbteex0HNfh7CqTZEQELqAV6GJUBTJFPSMaDm8V+yV9S/4RCcNBmzBmisYsqNo
 UriIbTM9rvTfJjetqG+vCj9fiJmaKndJ6X8oZ8ouq+wVT3qBj67ZJUgL3ebu7Vqv2gWg
 SWP6vV2RK+H8tVo++VpxuwSv5IzQwiFhjeBvsREUI1dtQlAtSsSfQf6+WPo8230JLpr2
 M8aoDUN/55st5FV2DS0kaFBwgx6EadENy/kabkwUD+42DDXzf03VBZzTkI/pmyGrDw5L
 Knn/fSPGppofNOAJDzX32tpn9/zrJWjDEUmQ7KTSnJSx22ByPtwJLjIBQi0vgzv3bDK3
 sF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726685500; x=1727290300;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LjIeRfMRna/s5IjipiaGPy/meIfbXoGPkLDkm3TO6Ow=;
 b=q53fW0Gi6/doK8m+9D+/+ryBOpd5Yu4aGkERuIAMEn8zu113F7akxlmifGo8cARKJL
 JM/eUv49IAXSfP2kvDsJOKA+I+hghKjrJMB8ey891fEyanpvrRgCTYJeHvuNBPvQqj6B
 0mV7awPhIHPdvldh/Sj6+uNcVnZER+y1kUfD6C+QIHarfJwy4B/j6a7BG9IkXES9F8q+
 zXd9yD7XFp6EUkT3lTpW52LqJmV+r7xs7G6qphyhQSOVZwYtCRdE4lnD3AfxgtTDLiK8
 r6SH+hcwp7GDLKHG+krnkWDHrCUrMwIOjpbM8JV5MxtcaMSKCRhrzFkX3wBk7izD5eUv
 RsOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk8+9zjbeewuALp9V4/N80Uk0zP4C+2ditQ1vjtkTd+2eTVsZvKmy2pFQUCbfNvCiO0dVn8ZWlkYTJ@nongnu.org
X-Gm-Message-State: AOJu0YweO70W4lxEtoRX+P8mKl+rv36IWcTsM22YztmIuT+m+9+BfDfU
 okyrfzrMwRJLktfahdOMttCg1irgPvgcW+SPX4duJQxKBNsCjjFiJYU1jbWXbyE=
X-Google-Smtp-Source: AGHT+IFmkfW8QeTXcjqZYOONjR6cDylFdST1nHdI7yrJda1mw+sUW5wiVY0WhEC7N3uPz65btc3Hcg==
X-Received: by 2002:a05:6a00:ac9:b0:718:d8dc:308a with SMTP id
 d2e1a72fcca58-7192606c44emr34260354b3a.12.1726685499827; 
 Wed, 18 Sep 2024 11:51:39 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71944ab507asm7027798b3a.50.2024.09.18.11.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 11:51:39 -0700 (PDT)
Message-ID: <c5771bb7-ffb9-4e3b-8f25-a88b2fd8b599@linaro.org>
Date: Wed, 18 Sep 2024 11:51:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/18] util/timer: avoid deadlock when shutting down
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Elisha Hollander <just4now666666@gmail.com>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
 <20240916085400.1046925-15-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240916085400.1046925-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

T24gOS8xNi8yNCAwMTo1MywgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXaGVuIHdlIHNodXQg
ZG93biBhIGd1ZXN0IHdlIGRpc2FibGUgdGhlIHRpbWVycy4gSG93ZXZlciB0aGlzIGNhbg0K
PiBjYXVzZSBkZWFkbG9jayBpZiB0aGUgZ3Vlc3QgaGFzIHF1ZXVlZCBzb21lIGFzeW5jIHdv
cmsgdGhhdCBpcyB0cnlpbmcNCj4gdG8gYWR2YW5jZSBzeXN0ZW0gdGltZSBhbmQgc3BpbnMg
Zm9yZXZlciB0cnlpbmcgdG8gd2luZCB0aW1lIGZvcndhcmQuDQo+IFBheSBhdHRlbnRpb24g
dG8gdGhlIHJldHVybiBjb2RlIGFuZCBiYWlsIGVhcmx5IGlmIHdlIGNhbid0IHdpbmQgdGlt
ZQ0KPiBmb3J3YXJkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBSZXBvcnRlZC1ieTogRWxpc2hhIEhvbGxhbmRlciA8
anVzdDRub3c2NjY2NjZAZ21haWwuY29tPg0KPiAtLS0NCj4gICB1dGlsL3FlbXUtdGltZXIu
YyB8IDE0ICsrKysrKysrKysrKy0tDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdXRpbC9xZW11LXRp
bWVyLmMgYi91dGlsL3FlbXUtdGltZXIuYw0KPiBpbmRleCAyMTMxMTRiZTY4Li42YjE1MzNi
YzJhIDEwMDY0NA0KPiAtLS0gYS91dGlsL3FlbXUtdGltZXIuYw0KPiArKysgYi91dGlsL3Fl
bXUtdGltZXIuYw0KPiBAQCAtNjg1LDEwICs2ODUsMTcgQEAgaW50NjRfdCBxZW11X2Nsb2Nr
X2FkdmFuY2VfdmlydHVhbF90aW1lKGludDY0X3QgZGVzdCkNCj4gICB7DQo+ICAgICAgIGlu
dDY0X3QgY2xvY2sgPSBxZW11X2Nsb2NrX2dldF9ucyhRRU1VX0NMT0NLX1ZJUlRVQUwpOw0K
PiAgICAgICBBaW9Db250ZXh0ICphaW9fY29udGV4dDsNCj4gKyAgICBpbnQ2NF90IGRlYWRs
aW5lOw0KPiArDQo+ICAgICAgIGFpb19jb250ZXh0ID0gcWVtdV9nZXRfYWlvX2NvbnRleHQo
KTsNCj4gLSAgICB3aGlsZSAoY2xvY2sgPCBkZXN0KSB7DQo+IC0gICAgICAgIGludDY0X3Qg
ZGVhZGxpbmUgPSBxZW11X2Nsb2NrX2RlYWRsaW5lX25zX2FsbChRRU1VX0NMT0NLX1ZJUlRV
QUwsDQo+ICsNCj4gKyAgICBkZWFkbGluZSA9IHFlbXVfY2xvY2tfZGVhZGxpbmVfbnNfYWxs
KFFFTVVfQ0xPQ0tfVklSVFVBTCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBRRU1VX1RJTUVSX0FUVFJfQUxMKTsNCj4gKyAg
ICAvKg0KPiArICAgICAqIEEgZGVhZGxpbmUgb2YgPCAwIGluZGljYXRlcyB0aGlzIHRpbWVy
IGlzIG5vdCBlbmFibGVkLCBzbyB3ZQ0KPiArICAgICAqIHdvbid0IGdldCBmYXIgdHJ5aW5n
IHRvIHJ1biBpdCBmb3J3YXJkLg0KPiArICAgICAqLw0KPiArICAgIHdoaWxlIChkZWFkbGlu
ZSA+PSAwICYmIGNsb2NrIDwgZGVzdCkgew0KPiAgICAgICAgICAgaW50NjRfdCB3YXJwID0g
cWVtdV9zb29uZXN0X3RpbWVvdXQoZGVzdCAtIGNsb2NrLCBkZWFkbGluZSk7DQo+ICAgDQo+
ICAgICAgICAgICBxZW11X3ZpcnR1YWxfY2xvY2tfc2V0X25zKHFlbXVfY2xvY2tfZ2V0X25z
KFFFTVVfQ0xPQ0tfVklSVFVBTCkgKyB3YXJwKTsNCj4gQEAgLTY5Niw2ICs3MDMsOSBAQCBp
bnQ2NF90IHFlbXVfY2xvY2tfYWR2YW5jZV92aXJ0dWFsX3RpbWUoaW50NjRfdCBkZXN0KQ0K
PiAgICAgICAgICAgcWVtdV9jbG9ja19ydW5fdGltZXJzKFFFTVVfQ0xPQ0tfVklSVFVBTCk7
DQo+ICAgICAgICAgICB0aW1lcmxpc3RfcnVuX3RpbWVycyhhaW9fY29udGV4dC0+dGxnLnRs
W1FFTVVfQ0xPQ0tfVklSVFVBTF0pOw0KPiAgICAgICAgICAgY2xvY2sgPSBxZW11X2Nsb2Nr
X2dldF9ucyhRRU1VX0NMT0NLX1ZJUlRVQUwpOw0KPiArDQo+ICsgICAgICAgIGRlYWRsaW5l
ID0gcWVtdV9jbG9ja19kZWFkbGluZV9uc19hbGwoUUVNVV9DTE9DS19WSVJUVUFMLA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFFFTVVfVElN
RVJfQVRUUl9BTEwpOw0KPiAgICAgICB9DQo+ICAgICAgIHFlbXVfY2xvY2tfbm90aWZ5KFFF
TVVfQ0xPQ0tfVklSVFVBTCk7DQo+ICAgDQoNClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

