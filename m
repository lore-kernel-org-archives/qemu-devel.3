Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E153CDD0ED
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 20:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3LcC-0001ca-Ah; Tue, 22 Oct 2024 16:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3LcA-0001cH-LQ
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:36:26 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t3Lc8-0008DN-5L
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 16:36:26 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-27b7a1480bdso2716742fac.2
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 13:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729629382; x=1730234182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pWCjqM/ZGrYgSGYtF/2fhacKTSpeH+nFNO6u0QKRQPs=;
 b=mjsJP/HkRFJBX6oUIjCg9LmORmFVo8p17dj1DSX/MB2/T7VE+0egd63Nl2+7mx4gqF
 U58koDSqjNbnJjxe6N97ds0mGY72k0p2EMutMjPOOqBUaohmlx1Vg8WZv+2SHa7yVZdF
 MaVUN/K3DESutoew7WYdSn0uIMsCIYybpooMErws6dQibHRAVX5j9LPkg6WKraHMacX0
 z81gN9pshva/T6eiKUDlBF3Z9DhBWKwJ+jUWt1FwGLTItN3L8iqQwVza+eCY1ipFbQVI
 z/4rJCM81Ze509HE3difg85QvHrttCoG09LIIpMtUlrfRtYWRe+9VVy6UAE28Gnxq3kV
 iAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729629382; x=1730234182;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pWCjqM/ZGrYgSGYtF/2fhacKTSpeH+nFNO6u0QKRQPs=;
 b=b5mkqxlsKZdnFzqQDYLURq5dU/XYthEQpTHnh9w3X34ITWoUCU6NJ+kyIZaErCODmy
 R1uBPsN2kbICligZKVG3IMMRqgAZJtUM5rk26VSnLbXwoJxbi3rlYLI7yVLpjH4K3lxg
 y+4BHHTelgOBTGpQWIheYbIEKQeR/YXl/lI1y/frTbcsy8ZOyulL56ottIMta3otbUwo
 EbJW04+Ssi4fqhfgvbagvGUmdVgmVlw1VIdyQGbSU1F3XI5NleIzkOnduUMEUFy7pI9A
 4/LBhKN1QM7XekHSXgzsxgV9X0XWc8yUfSSbu5wh+H9wbkHORMc/tD0U8NqATVPS/b5x
 z67Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVw/LAsk+JzPlbUx9BdgsJhVPL/EB2oFtJIBfDVe3HhABdJoTOx7UG4xmYYO3Ozpk/AfsOHXDttb6t@nongnu.org
X-Gm-Message-State: AOJu0Yy4wqBNGyBiIlvsLbFs7ScF2UgbamNgl/7N8CyqSjKbTVfeL/wm
 i7IlQsyYmCVMG/nO34E8sEzgHmQJoqEgNCFrxff6vPayVjfmBmzS5FkVEOhQm7M=
X-Google-Smtp-Source: AGHT+IFOV2tqy6lFuMgVduTERwsqrRtotWYLgFoAjiv7Y0ywFSpgU/BHCZTMaDagLLfJEs3P77nWEQ==
X-Received: by 2002:a05:6870:a990:b0:288:b220:a57e with SMTP id
 586e51a60fabf-28ccb68fa1cmr526849fac.40.1729629382058; 
 Tue, 22 Oct 2024 13:36:22 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeab1e5cdsm5499718a12.21.2024.10.22.13.36.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 13:36:21 -0700 (PDT)
Message-ID: <6b18238b-f9c3-4046-964f-de16dc30d26e@linaro.org>
Date: Tue, 22 Oct 2024 13:36:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/20] tests/tcg/x86_64: Add cross-modifying code test
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
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20241022105614.839199-1-alex.bennee@linaro.org>
 <20241022105614.839199-8-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241022105614.839199-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oa1-x2b.google.com
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

T24gMTAvMjIvMjQgMDM6NTYsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gRnJvbTogSWx5YSBM
ZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQo+IA0KPiBjb21taXQgZjAyNTY5MmM5
OTJjICgiYWNjZWwvdGNnOiBDbGVhciBQQUdFX1dSSVRFIGJlZm9yZSB0cmFuc2xhdGlvbiIp
DQo+IGZpeGVkIGNyb3NzLW1vZGlmeWluZyBjb2RlIGhhbmRsaW5nLCBidXQgZGlkIG5vdCBh
ZGQgYSB0ZXN0LiBUaGUNCj4gY2hhbmdlZCBjb2RlIHdhcyBmdXJ0aGVyIGltcHJvdmVkIHJl
Y2VudGx5IFsxXSwgYW5kIEkgd2FzIG5vdCBzdXJlDQo+IHdoZXRoZXIgdGhlc2UgbW9kaWZp
Y2F0aW9ucyB3ZXJlIHNhZmUgKHNwb2lsZXI6IHRoZXkgd2VyZSBmaW5lKS4NCj4gDQo+IEFk
ZCBhIHRlc3QgdG8gbWFrZSBzdXJlIHRoZXJlIGFyZSBubyByZWdyZXNzaW9ucy4NCj4gDQo+
IFsxXSBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAy
Mi0wOS9tc2cwMDAzNC5odG1sDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBJbHlhIExlb3Noa2V2
aWNoIDxpaWlAbGludXguaWJtLmNvbT4NCj4gTWVzc2FnZS1JZDogPDIwMjQxMDAxMTUwNjE3
Ljk5NzctMS1paWlAbGludXguaWJtLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5u
w6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0ZXN0cy90Y2cveDg2
XzY0L2Nyb3NzLW1vZGlmeWluZy1jb2RlLmMgfCA4MCArKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAgdGVzdHMvdGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQgICAgICAgIHwgIDQg
KysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDg0IGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgdGVzdHMvdGNnL3g4Nl82NC9jcm9zcy1tb2RpZnlpbmctY29kZS5jDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL3g4Nl82NC9jcm9zcy1tb2RpZnlpbmctY29k
ZS5jIGIvdGVzdHMvdGNnL3g4Nl82NC9jcm9zcy1tb2RpZnlpbmctY29kZS5jDQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAuLjI3MDRkZjYwNjENCj4gLS0t
IC9kZXYvbnVsbA0KPiArKysgYi90ZXN0cy90Y2cveDg2XzY0L2Nyb3NzLW1vZGlmeWluZy1j
b2RlLmMNCj4gQEAgLTAsMCArMSw4MCBAQA0KPiArLyoNCj4gKyAqIFRlc3QgcGF0Y2hpbmcg
Y29kZSwgcnVubmluZyBpbiBvbmUgdGhyZWFkLCBmcm9tIGFub3RoZXIgdGhyZWFkLg0KPiAr
ICoNCj4gKyAqIEludGVsIFNETSBjYWxscyB0aGlzICJjcm9zcy1tb2RpZnlpbmcgY29kZSIg
YW5kIHJlY29tbWVuZHMgYSBzcGVjaWFsDQo+ICsgKiBzZXF1ZW5jZSwgd2hpY2ggcmVxdWly
ZXMgYm90aCB0aHJlYWRzIHRvIGNvb3BlcmF0ZS4NCj4gKyAqDQo+ICsgKiBMaW51eCBrZXJu
ZWwgdXNlcyBhIGRpZmZlcmVudCBzZXF1ZW5jZSB0aGF0IGRvZXMgbm90IHJlcXVpcmUgY29v
cGVyYXRpb24gYW5kDQo+ICsgKiBpbnZvbHZlcyBwYXRjaGluZyB0aGUgZmlyc3QgYnl0ZSB3
aXRoIGludDMuDQo+ICsgKg0KPiArICogRmluYWxseSwgdGhlcmUgaXMgdXNlci1tb2RlIHNv
ZnR3YXJlIG91dCB0aGVyZSB0aGF0IHNpbXBseSB1c2VzIGF0b21pY3MsIGFuZA0KPiArICog
dGhhdCBzZWVtcyB0byBiZSBnb29kIGVub3VnaCBpbiBwcmFjdGljZS4gVGVzdCB0aGF0IFFF
TVUgaGFzIG5vIHByb2JsZW1zDQo+ICsgKiB3aXRoIHRoaXMgYXMgd2VsbC4NCj4gKyAqLw0K
PiArDQo+ICsjaW5jbHVkZSA8YXNzZXJ0Lmg+DQo+ICsjaW5jbHVkZSA8cHRocmVhZC5oPg0K
PiArI2luY2x1ZGUgPHN0ZGJvb2wuaD4NCj4gKyNpbmNsdWRlIDxzdGRsaWIuaD4NCj4gKw0K
PiArdm9pZCBhZGQxX29yX25vcChsb25nICp4KTsNCj4gK2FzbSgiLnB1c2hzZWN0aW9uIC5y
d3gsXCJhd3hcIixAcHJvZ2JpdHNcbiINCj4gKyAgICAiLmdsb2JsIGFkZDFfb3Jfbm9wXG4i
DQo+ICsgICAgLyogYWRkcSAkMHgxLCglcmRpKSAqLw0KPiArICAgICJhZGQxX29yX25vcDog
LmJ5dGUgMHg0OCwgMHg4MywgMHgwNywgMHgwMVxuIg0KPiArICAgICJyZXRcbiINCj4gKyAg
ICAiLnBvcHNlY3Rpb25cbiIpOw0KPiArDQo+ICsjZGVmaW5lIFRIUkVBRF9XQUlUIDANCj4g
KyNkZWZpbmUgVEhSRUFEX1BBVENIIDENCj4gKyNkZWZpbmUgVEhSRUFEX1NUT1AgMg0KPiAr
DQo+ICtzdGF0aWMgdm9pZCAqdGhyZWFkX2Z1bmModm9pZCAqYXJnKQ0KPiArew0KPiArICAg
IGludCB2YWwgPSAweDAwMjY3NDhkOyAvKiBub3AgKi8NCj4gKw0KPiArICAgIHdoaWxlICh0
cnVlKSB7DQo+ICsgICAgICAgIHN3aXRjaCAoX19hdG9taWNfbG9hZF9uKChpbnQgKilhcmcs
IF9fQVRPTUlDX1NFUV9DU1QpKSB7DQo+ICsgICAgICAgIGNhc2UgVEhSRUFEX1dBSVQ6DQo+
ICsgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAgY2FzZSBUSFJFQURfUEFUQ0g6DQo+
ICsgICAgICAgICAgICB2YWwgPSBfX2F0b21pY19leGNoYW5nZV9uKChpbnQgKikmYWRkMV9v
cl9ub3AsIHZhbCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
X19BVE9NSUNfU0VRX0NTVCk7DQo+ICsgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICAg
Y2FzZSBUSFJFQURfU1RPUDoNCj4gKyAgICAgICAgICAgIHJldHVybiBOVUxMOw0KPiArICAg
ICAgICBkZWZhdWx0Og0KPiArICAgICAgICAgICAgYXNzZXJ0KGZhbHNlKTsNCj4gKyAgICAg
ICAgICAgIF9fYnVpbHRpbl91bnJlYWNoYWJsZSgpOw0KDQpVc2UgZ19hc3NlcnRfbm90X3Jl
YWNoZWQoKSBpbnN0ZWFkLg0KY2hlY2twYXRjaCBlbWl0cyBhbiBlcnJvciBmb3IgaXQgbm93
Lg0KDQo+ICsgICAgICAgIH0NCj4gKyAgICB9DQo+ICt9DQo+ICsNCj4gKyNkZWZpbmUgSU5J
VElBTCA0Mg0KPiArI2RlZmluZSBDT1VOVCAxMDAwMDAwDQo+ICsNCj4gK2ludCBtYWluKHZv
aWQpDQo+ICt7DQo+ICsgICAgaW50IGNvbW1hbmQgPSBUSFJFQURfV0FJVDsNCj4gKyAgICBw
dGhyZWFkX3QgdGhyZWFkOw0KPiArICAgIGxvbmcgeCA9IDA7DQo+ICsgICAgaW50IGVycjsN
Cj4gKyAgICBpbnQgaTsNCj4gKw0KPiArICAgIGVyciA9IHB0aHJlYWRfY3JlYXRlKCZ0aHJl
YWQsIE5VTEwsICZ0aHJlYWRfZnVuYywgJmNvbW1hbmQpOw0KPiArICAgIGFzc2VydChlcnIg
PT0gMCk7DQo+ICsNCj4gKyAgICBfX2F0b21pY19zdG9yZV9uKCZjb21tYW5kLCBUSFJFQURf
UEFUQ0gsIF9fQVRPTUlDX1NFUV9DU1QpOw0KPiArICAgIGZvciAoaSA9IDA7IGkgPCBDT1VO
VDsgaSsrKSB7DQo+ICsgICAgICAgIGFkZDFfb3Jfbm9wKCZ4KTsNCj4gKyAgICB9DQo+ICsg
ICAgX19hdG9taWNfc3RvcmVfbigmY29tbWFuZCwgVEhSRUFEX1NUT1AsIF9fQVRPTUlDX1NF
UV9DU1QpOw0KPiArDQo+ICsgICAgZXJyID0gcHRocmVhZF9qb2luKHRocmVhZCwgTlVMTCk7
DQo+ICsgICAgYXNzZXJ0KGVyciA9PSAwKTsNCj4gKw0KPiArICAgIGFzc2VydCh4ID49IElO
SVRJQUwpOw0KPiArICAgIGFzc2VydCh4IDw9IElOSVRJQUwgKyBDT1VOVCk7DQo+ICsNCj4g
KyAgICByZXR1cm4gRVhJVF9TVUNDRVNTOw0KPiArfQ0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMv
dGNnL3g4Nl82NC9NYWtlZmlsZS50YXJnZXQgYi90ZXN0cy90Y2cveDg2XzY0L01ha2VmaWxl
LnRhcmdldA0KPiBpbmRleCA3ODNhYjViMjFhLi5kNmRmZjU1OWM3IDEwMDY0NA0KPiAtLS0g
YS90ZXN0cy90Y2cveDg2XzY0L01ha2VmaWxlLnRhcmdldA0KPiArKysgYi90ZXN0cy90Y2cv
eDg2XzY0L01ha2VmaWxlLnRhcmdldA0KPiBAQCAtMTcsNiArMTcsNyBAQCBYODZfNjRfVEVT
VFMgKz0gY21weGNoZw0KPiAgIFg4Nl82NF9URVNUUyArPSBhZG94DQo+ICAgWDg2XzY0X1RF
U1RTICs9IHRlc3QtMTY0OA0KPiAgIFg4Nl82NF9URVNUUyArPSB0ZXN0LTIxNzUNCj4gK1g4
Nl82NF9URVNUUyArPSBjcm9zcy1tb2RpZnlpbmctY29kZQ0KPiAgIFRFU1RTPSQoTVVMVElB
UkNIX1RFU1RTKSAkKFg4Nl82NF9URVNUUykgdGVzdC14ODZfNjQNCj4gICBlbHNlDQo+ICAg
VEVTVFM9JChNVUxUSUFSQ0hfVEVTVFMpDQo+IEBAIC0yNyw2ICsyOCw5IEBAIGFkb3g6IENG
TEFHUz0tTzINCj4gICBydW4tdGVzdC1pMzg2LXNzc2UzOiBRRU1VX09QVFMgKz0gLWNwdSBt
YXgNCj4gICBydW4tcGx1Z2luLXRlc3QtaTM4Ni1zc3NlMy0lOiBRRU1VX09QVFMgKz0gLWNw
dSBtYXgNCj4gICANCj4gK2Nyb3NzLW1vZGlmeWluZy1jb2RlOiBDRkxBR1MrPS1wdGhyZWFk
DQo+ICtjcm9zcy1tb2RpZnlpbmctY29kZTogTERGTEFHUys9LXB0aHJlYWQNCj4gKw0KPiAg
IHRlc3QteDg2XzY0OiBMREZMQUdTKz0tbG0gLWxjDQo+ICAgdGVzdC14ODZfNjQ6IHRlc3Qt
aTM4Ni5jIHRlc3QtaTM4Ni5oIHRlc3QtaTM4Ni1zaGlmdC5oIHRlc3QtaTM4Ni1tdWxkaXYu
aA0KPiAgIAkkKENDKSAkKENGTEFHUykgJDwgLW8gJEAgJChMREZMQUdTKQ0KDQpXaXRoIHRo
aXMgY2hhbmdlLA0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJv
dXZpZXJAbGluYXJvLm9yZz4NCg==

