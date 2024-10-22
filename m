Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C1FCDD0EA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LXj-0004Vr-Ub; Tue, 22 Oct 2024 16:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LXh-0004Sz-FV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:31:49 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LXf-0007lN-SC
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:31:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2e2bd0e2c4fso4626758a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629106; x=1730233906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oB483hQexTEaOWDvU61A56qrwM7YWeWBfyueGHYezvc=;
 b=VauaU2Jc5WhMz70VRLZXzzMbA/lopPmdnkmGUBR+f6DNLPevrWb64ugzWAEzyzAEWj
 ZEvWpPkJxwMpMbuWdgIOIJ5afVKZM1hu2aYPfC1JWBxbw5ObkOnZxYemgvHjsN4NVGvN
 8KIbh233ijGD6fJQV/0fEodZOUREEsUIcIOKjHYcd7PoQ2GCexzsMLXbElnH+YTvHHFB
 Zk8CBFbpY6Rt/vd3gmmPZZpYNR/RUM0Q1LTSSFdtejNrAhOT4alAt1/nwBfWGweCecbu
 yuaANMbpy8KMD15GCCNg0NC7bD9UEX6l8zFTnFBu5+yNX2DexX2aLt2GZIsEpvaqoS5H
 O8ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629106; x=1730233906;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oB483hQexTEaOWDvU61A56qrwM7YWeWBfyueGHYezvc=;
 b=YRUdy0Pndnb1OtUiLxIR3F+9zn9Qo7JL3zl+dyUwXohaCDDLGYu5STW6SOgQlrFRS2
 2PnDHWn6UZ99q9ZFS/13I0XbyCQdwcBkeT50VDB8KNSuLIUUXlxdzd1LpLkes1dPlL+7
 B4CpFtqyjpe09OMiNT3dEUaIPUsNywahF9TYmKmAKVWkR8GmfmIHungbDfl/qMh+2vHL
 ZhWgmAtStAFN1IMkerNAn6mCtDE+lFKVYosijt+4atZyAoNSu+VNtw44rGhAXLF6H4Bp
 h7XoaxVh8uRS7fu4P6c9xUervvF7sZSkohEBDlUxdAcsgUjthZGLeWDDQ8WijRd+FEUM
 VKhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXv2N8jGV5QAkDBOTpTJeWnXY4O/lvVD5oAQJEIJj/e+iKgrrHBH31/+/9zsV+WayD7DFOPtCCacfqQ@nongnu.org
X-Gm-Message-State: AOJu0YywyMX8enasy+YTgkt8twCNlqbbZqsuXUFT4VPtM6hU7UwQGlAS
 ao1FHVOwmif/wyhI4FIK2E+di+8YGJuQbkEJXp4TF70cCA8clJmfYQ3GQzy6bRo=
X-Google-Smtp-Source: AGHT+IHOfhvheXJxw9in5Rg8Qqoc4W+j3iF1Z8mFQAoMgSmn+ZFqHHEv4hP0+Rc5vNRAQag4kQezkA==
X-Received: by 2002:a17:90b:4c4b:b0:2e2:d15c:1a24 with SMTP id
 98e67ed59e1d1-2e76b618c40mr223184a91.23.1729629105804; 
 Tue, 22 Oct 2024 13:31:45 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e5ad388ea9sm6722471a91.29.2024.10.22.13.31.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:31:45 -0700 (PDT)
Message-ID: <20d8ac14-d920-4a21-a5cc-432acc7d582f@linaro.org>
Date: Tue, 22 Oct 2024 13:31:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/20] tests/docker: add NOFETCH env variable for
 testing
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 devel@lists.libvirt.org, Cleber Rosa <crosa@redhat.com>,
 kvm@vger.kernel.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alexandre Iooss <erdnaxe@crans.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMTAvMjIvMjQgMDM6NTUsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gVGVzdGluZyBub24t
YXV0byBidWlsdCBkb2NrZXIgY29udGFpbmVycyAoaS5lLiBjdXN0b20gYnVpbHQgY29tcGls
ZXJzKQ0KPiBpcyBhIGJpdCBmaWRkbHkgYXMgeW91IGNvdWxkbid0IGNvbnRpbnVlIGEgYnVp
bGQgd2l0aCBhIHByZXZpb3VzbHkNCj4gbG9jYWxseSBidWlsdCBjb250YWluZXIuIFdoaWxl
IHlvdSBjYW4gcGxheSBnYW1lcyB3aXRoIFJFR0lTVFJZIGl0cw0KPiBzaW1wbGVyIHRvIGFs
bG93IGEgTk9GRVRDSCB0aGF0IHdpbGwgZ28gdGhyb3VnaCB0aGUgY2FjaGVkIGJ1aWxkDQo+
IHByb2Nlc3Mgd2hlbiB5b3UgcnVuIHRoZSB0ZXN0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4NCj4gLS0tDQo+ICAgdGVz
dHMvZG9ja2VyL01ha2VmaWxlLmluY2x1ZGUgfCA1ICsrKy0tDQo+ICAgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQg
YS90ZXN0cy9kb2NrZXIvTWFrZWZpbGUuaW5jbHVkZSBiL3Rlc3RzL2RvY2tlci9NYWtlZmls
ZS5pbmNsdWRlDQo+IGluZGV4IDY4MWZlYWU3NDQuLmZlYWQ3ZDNhYmUgMTAwNjQ0DQo+IC0t
LSBhL3Rlc3RzL2RvY2tlci9NYWtlZmlsZS5pbmNsdWRlDQo+ICsrKyBiL3Rlc3RzL2RvY2tl
ci9NYWtlZmlsZS5pbmNsdWRlDQo+IEBAIC05MiwxMCArOTIsMTAgQEAgZW5kaWYNCj4gICBk
b2NrZXItaW1hZ2UtYWxwaW5lOiBOT1VTRVI9MQ0KPiAgIA0KPiAgIGRlYmlhbi10b29sY2hh
aW4tcnVuID0gXA0KPiAtCSQoaWYgJChOT0NBQ0hFKSwgCQkJCQkJXA0KPiArCSQoaWYgJChO
T0NBQ0hFKSQoTk9GRVRDSCksCQkJCQlcDQo+ICAgCQkkKGNhbGwgcXVpZXQtY29tbWFuZCwJ
CQkJCVwNCj4gICAJCQkkKERPQ0tFUl9TQ1JJUFQpIGJ1aWxkIC10IHFlbXUvJDEgLWYgJDwg
CVwNCj4gLQkJCSQoaWYgJFYsLC0tcXVpZXQpIC0tbm8tY2FjaGUgCQkJXA0KPiArCQkJJChp
ZiAkViwsLS1xdWlldCkgJChpZiAkKE5PQ0FDSEUpLC0tbm8tY2FjaGUpCVwNCj4gICAJCQkt
LXJlZ2lzdHJ5ICQoRE9DS0VSX1JFR0lTVFJZKSAtLWV4dHJhLWZpbGVzCVwNCj4gICAJCQkk
KERPQ0tFUl9GSUxFU19ESVIpLyQxLmQvYnVpbGQtdG9vbGNoYWluLnNoLAlcDQo+ICAgCQkJ
IkJVSUxEIiwgJDEpLAkJCQkgICAgICAgIFwNCj4gQEAgLTE3Nyw2ICsxNzcsNyBAQCBkb2Nr
ZXI6DQo+ICAgCUBlY2hvICcgICAgTkVUV09SSz0kJEJBQ0tFTkQgICAgIEVuYWJsZSB2aXJ0
dWFsIG5ldHdvcmsgaW50ZXJmYWNlIHdpdGggJCRCQUNLRU5ELicNCj4gICAJQGVjaG8gJyAg
ICBOT1VTRVI9MSAgICAgICAgICAgICBEZWZpbmUgdG8gZGlzYWJsZSBhZGRpbmcgY3VycmVu
dCB1c2VyIHRvIGNvbnRhaW5lcnMgcGFzc3dkLicNCj4gICAJQGVjaG8gJyAgICBOT0NBQ0hF
PTEgICAgICAgICAgICBJZ25vcmUgY2FjaGUgd2hlbiBidWlsZCBpbWFnZXMuJw0KPiArCUBl
Y2hvICcgICAgTk9GRVRDSD0xICAgICAgICAgICAgRG8gbm90IGZldGNoIGZyb20gdGhlIHJl
Z2lzdHJ5LicNCj4gICAJQGVjaG8gJyAgICBFWEVDVVRBQkxFPTxwYXRoPiAgICBJbmNsdWRl
IGV4ZWN1dGFibGUgaW4gaW1hZ2UuJw0KPiAgIAlAZWNobyAnICAgIEVYVFJBX0ZJTEVTPSI8
cGF0aD4gWy4uLiA8cGF0aD5dIicNCj4gICAJQGVjaG8gJyAgICAgICAgICAgICAgICAgICAg
ICAgICBJbmNsdWRlIGV4dHJhIGZpbGVzIGluIGltYWdlLicNCg0KUmV2aWV3ZWQtYnk6IFBp
ZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

