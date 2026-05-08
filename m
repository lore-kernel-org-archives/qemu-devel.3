Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D611CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 13:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLLRE-0003DD-89; Fri, 08 May 2026 09:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wLLRC-0003Ch-I6
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:40:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lex.bailey@lowrisc.org>)
 id 1wLLR8-0007aM-JQ
 for qemu-devel@nongnu.org; Fri, 08 May 2026 09:40:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso24334885e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lowrisc.org; s=google; t=1778247613; x=1778852413; darn=nongnu.org;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ogpB03Cy5upLMyGtAxKnvAL/VYMBSzV08Fq5+TQ1pQA=;
 b=VbcpO3GTSb7GpVlP+qMTy70Lsc4Dk0LWq7SW56187ZwGhIuqsGx77zAjSOTc2dEgPD
 WQg+X1LUp0pu37rHvNBHAWLPT8fmaQfR1vSQMFTfG1VcZZjIj90YxgdhTml7W5LjqbZ1
 nHS0e1AAENS3eiK315P6yk6WxOLa+4S1+6JPVwPHFV710JH/n/BINppsagK00UFWppwR
 pI7MN3qSz0BD/3xaw3hUjgUuFbHyM9jB2/hLvab7ojtLS5aHzwv3PJhYPHVMKkzXYog9
 LZ6qnVb+/s6qtUUBN/ZMDAXcXJBiFr6Z0rAnzM3W27qJbLuwQeR6E515mVY4NUU814I0
 CoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778247613; x=1778852413;
 h=in-reply-to:autocrypt:from:content-language:references:cc:to
 :subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ogpB03Cy5upLMyGtAxKnvAL/VYMBSzV08Fq5+TQ1pQA=;
 b=bTls86cmGkWBUW7BEE/IJXVwUwoJKrW1xesEifkfQXukwFrhed/8U+GFDvQs8tEVPQ
 S29FTH3jiv0IVSEZe2hHe3xniDESqdeXMlNDdNxIT6KUVGlnaVum0hi4OPUIJMamW2zI
 bW8pB6dY/liakic11+s2JsbfrGYO7y/X32acpCkVAA9ait+6uPqrjfjSRjzs4lE9Oty6
 /s5OkXiv14Xs3V7HZjYuaamt/LowTUFVH/HpDkdmBqEECZ5gRpPpebB9JUxqnb6hLKbA
 oGqjc8f0DeDLBpi/R7Z+SR/kawy6m9nBLoPz/sLQwtnz+rSRutm3p7wXeaAukMLpDfwt
 cAPQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DUni5Pt2iTXyY/qvXGkDsnsyxDWbAkjLEPtdHQer7wrjYHkE8SCdEVb2Di8kOKmtGAvrHUDZrgqkS@nongnu.org
X-Gm-Message-State: AOJu0YycOgLPXVsQzA63wpgmEIiW9Te4fU2dZbaM94UkTbto1YOjuTJY
 b+kf3X1nLS2AJWY3H9mFRIevG3QIXH68hlLYrkm0bOttFH7rjVX2Dkmr1YBJvUvTnp0=
X-Gm-Gg: AeBDieu0WP0rsfrJiCrPchE98k/PtxQF3gXN8/8Zxu4tljxk1f5tQ6PltCRyZjpBLNk
 aGxTn1YzLRzoVEULqa0OFBq5yPL0YirGfGr2sKGvRUtciTMA+PjyO+DrJQYY4Pt4P+ehOagnBMR
 0uEaMSqoXK0Pn7PfROWBmldu/RuMe5ybednjfxdDzi7cOn16mxR80k/4NVN/X3n3SBvgSTMyPXo
 DR98oBobBQC6b1t0dR+LaTNU+t8tjgyV81nvNiZnAWBdzDejLu4xuhoqMNAOaIaL+chwBdI7bTV
 afPWggBmX7ZbyPhKmm6NqKzP3p/PUcWn1JgxQCfzkKIaDsDXJe8AVtC73YkqYQuANiK8SvYuCb3
 DkCSAZwOkCsL644RA7dgs/+xEUKmBVbu1yTA9KaQL0YHUVUAZkvBdyBaWeI+XnQlDCE/oqY8gOd
 XT5oLb1hpQKD3DwJ4ZPdRKvPKB58KjJfxn1vA=
X-Received: by 2002:a05:600d:18:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-48e51f3c4f4mr159654025e9.25.1778247612547; 
 Fri, 08 May 2026 06:40:12 -0700 (PDT)
Received: from [10.108.128.236] ([185.219.111.183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e68eb9967sm48042815e9.9.2026.05.08.06.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 06:40:12 -0700 (PDT)
Message-ID: <9e020bd5-eccb-48b3-b55a-e756ed6aabc3@lowrisc.org>
Date: Fri, 8 May 2026 14:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v4 2/9] ot_uart: move to new reset API
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-2@git.sr.ht>
 <CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmail.com>
Content-Language: en-US
From: Lex Bailey <lex.bailey@lowrisc.org>
Autocrypt: addr=lex.bailey@lowrisc.org; keydata=
 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
 WZXWKp/svUI=
In-Reply-To: <CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------R6QnJCyfG6HqJr90nogEQYIU"
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=lex.bailey@lowrisc.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------R6QnJCyfG6HqJr90nogEQYIU
Content-Type: multipart/mixed; boundary="------------Qpzye9dInq9WDoTb6OfTTIRM";
 protected-headers="v1"
From: Lex Bailey <lex.bailey@lowrisc.org>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org,
 Amit Kumar-Hermosillo <amitkh@google.com>,
 nabihestefan <nabihestefan@google.com>
Message-ID: <9e020bd5-eccb-48b3-b55a-e756ed6aabc3@lowrisc.org>
Subject: Re: [PATCH qemu v4 2/9] ot_uart: move to new reset API
References: <177756498815.8917.12449488721849651971-0@git.sr.ht>
 <177756498815.8917.12449488721849651971-2@git.sr.ht>
 <CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmail.com>
In-Reply-To: <CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmail.com>

--------------Qpzye9dInq9WDoTb6OfTTIRM
Content-Type: multipart/mixed; boundary="------------5euExJcUfa3Lc6wqVUM3oZjq"

--------------5euExJcUfa3Lc6wqVUM3oZjq
Content-Type: multipart/alternative;
 boundary="------------xaUES543xIMo8UUTP7TS4g0L"

--------------xaUES543xIMo8UUTP7TS4g0L
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgQWxpc3RhaXIsDQoNCnRoYW5rcyBmb3IgcmV2aWV3aW5nIHRoaXMuIEkganVzdCB3YW50
IHRvIGNoZWNrIEkgaGF2ZW4ndCBtaXNzZWQgYW55IA0KbWVzc2FnZXMgZnJvbSB5b3UsIGRp
ZCB5b3UgaGF2ZSBhIGNoYW5jZSB0byBsb29rIGFnYWluIGF0IHRoZSBvdGhlciANCmNvbW1p
dHM/IGFyZSB0aGVyZSBhbnkgb3RoZXIgY2hhbmdlcyB5b3UgbmVlZD8gb3IgaXMgdGhpcyBy
ZWFkeSB0byBtZXJnZT8NCg0KVGhhbmtzLA0KDQpMZXguDQoNCk9uIDA1LzA1LzIwMjYgMDU6
MjQsIEFsaXN0YWlyIEZyYW5jaXMgd3JvdGU6DQo+IE9uIEZyaSwgTWF5IDEsIDIwMjYgYXQg
MjowNuKAr0FNIH5sZXhiYWlsZXlsb3dyaXNjDQo+IDxsZXhiYWlsZXlsb3dyaXNjQGdpdC5z
ci5odD4gd3JvdGU6DQo+PiBGcm9tOiBMZXggQmFpbGV5PGxleC5iYWlsZXlAbG93cmlzYy5v
cmc+DQo+Pg0KPj4gc3dpdGNoIGZyb20gbGVnYWN5X3Jlc2V0IHRvIG5ldyBSZXNldHRhYmxl
Q2xhc3MgZm9yIE9wZW5UaXRhbiBVQVJUIGRldmljZQ0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IExleCBCYWlsZXk8bGV4LmJhaWxleUBsb3dyaXNjLm9yZz4NCj4gUmV2aWV3ZWQtYnk6IEFs
aXN0YWlyIEZyYW5jaXM8YWxpc3RhaXIuZnJhbmNpc0B3ZGMuY29tPg0KPg0KPiBBbGlzdGFp
cg0KPg0KPj4gLS0tDQo+PiAgIGh3L2NoYXIvb3RfdWFydC5jICAgICAgICAgfCAxNiArKysr
KysrKysrKysrLS0tDQo+PiAgIGluY2x1ZGUvaHcvY2hhci9vdF91YXJ0LmggfCAgOCArKysr
KysrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2h3L2NoYXIvb3RfdWFydC5jIGIvaHcvY2hh
ci9vdF91YXJ0LmMNCj4+IGluZGV4IGIzZWI2MTk2NDEuLjk0NzhhZjQwZjkgMTAwNjQ0DQo+
PiAtLS0gYS9ody9jaGFyL290X3VhcnQuYw0KPj4gKysrIGIvaHcvY2hhci9vdF91YXJ0LmMN
Cj4+IEBAIC0yMjcsOSArMjI3LDE0IEBAIHN0YXRpYyB2b2lkIHVhcnRfd3JpdGVfdHhfZmlm
byhPdFVBUlRTdGF0ZSAqcywgY29uc3QgdWludDhfdCAqYnVmLA0KPj4gICAgICAgICAgICAg
ICAgIChzLT5jaGFyX3R4X3RpbWUgKiA0KSk7DQo+PiAgIH0NCj4+DQo+PiAtc3RhdGljIHZv
aWQgb3RfdWFydF9yZXNldChEZXZpY2VTdGF0ZSAqZGV2KQ0KPj4gK3N0YXRpYyB2b2lkIG90
X3VhcnRfcmVzZXRfZW50ZXIoT2JqZWN0ICpvYmosIFJlc2V0VHlwZSB0eXBlKQ0KPj4gICB7
DQo+PiAtICAgIE90VUFSVFN0YXRlICpzID0gT1RfVUFSVChkZXYpOw0KPj4gKyAgICBPdFVB
UlRDbGFzcyAqYyA9IE9UX1VBUlRfR0VUX0NMQVNTKG9iaik7DQo+PiArICAgIE90VUFSVFN0
YXRlICpzID0gT1RfVUFSVChvYmopOw0KPj4gKw0KPj4gKyAgICBpZiAoYy0+cGFyZW50X3Bo
YXNlcy5lbnRlcikgew0KPj4gKyAgICAgICAgYy0+cGFyZW50X3BoYXNlcy5lbnRlcihvYmos
IHR5cGUpOw0KPj4gKyAgICB9DQo+Pg0KPj4gICAgICAgcy0+dWFydF9pbnRyX3N0YXRlID0g
MHgwMDAwMDAwMDsNCj4+ICAgICAgIHMtPnVhcnRfaW50cl9zdGF0ZSA9IDB4MDAwMDAwMDA7
DQo+PiBAQCAtNTQ0LDEyICs1NDksMTYgQEAgc3RhdGljIHZvaWQgb3RfdWFydF9yZWFsaXpl
KERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCj4+ICAgc3RhdGljIHZvaWQgb3Rf
dWFydF9jbGFzc19pbml0KE9iamVjdENsYXNzICprbGFzcywgY29uc3Qgdm9pZCAqZGF0YSkN
Cj4+ICAgew0KPj4gICAgICAgRGV2aWNlQ2xhc3MgKmRjID0gREVWSUNFX0NMQVNTKGtsYXNz
KTsNCj4+ICsgICAgT3RVQVJUQ2xhc3MgKnVjID0gT1RfVUFSVF9DTEFTUyhrbGFzcyk7DQo+
PiArICAgIFJlc2V0dGFibGVDbGFzcyAqcmMgPSBSRVNFVFRBQkxFX0NMQVNTKGtsYXNzKTsN
Cj4+DQo+PiAtICAgIGRldmljZV9jbGFzc19zZXRfbGVnYWN5X3Jlc2V0KGRjLCBvdF91YXJ0
X3Jlc2V0KTsNCj4+ICAgICAgIGRjLT5yZWFsaXplID0gb3RfdWFydF9yZWFsaXplOw0KPj4g
ICAgICAgZGMtPnZtc2QgPSAmdm1zdGF0ZV9vdF91YXJ0Ow0KPj4gICAgICAgZGV2aWNlX2Ns
YXNzX3NldF9wcm9wcyhkYywgb3RfdWFydF9wcm9wZXJ0aWVzKTsNCj4+ICAgICAgIHNldF9i
aXQoREVWSUNFX0NBVEVHT1JZX0lOUFVULCBkYy0+Y2F0ZWdvcmllcyk7DQo+PiArDQo+PiAr
ICAgIHJlc2V0dGFibGVfY2xhc3Nfc2V0X3BhcmVudF9waGFzZXMocmMsICZvdF91YXJ0X3Jl
c2V0X2VudGVyLCBOVUxMLCBOVUxMLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICZ1Yy0+cGFyZW50X3BoYXNlcyk7DQo+PiAgIH0NCj4+DQo+PiAgIHN0
YXRpYyBjb25zdCBUeXBlSW5mbyBvdF91YXJ0X2luZm8gPSB7DQo+PiBAQCAtNTU3LDYgKzU2
Niw3IEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBvdF91YXJ0X2luZm8gPSB7DQo+PiAgICAg
ICAucGFyZW50ICAgICAgICA9IFRZUEVfU1lTX0JVU19ERVZJQ0UsDQo+PiAgICAgICAuaW5z
dGFuY2Vfc2l6ZSA9IHNpemVvZihPdFVBUlRTdGF0ZSksDQo+PiAgICAgICAuaW5zdGFuY2Vf
aW5pdCA9IG90X3VhcnRfaW5pdCwNCj4+ICsgICAgLmNsYXNzX3NpemUgICAgPSBzaXplb2Yo
T3RVQVJUQ2xhc3MpLA0KPj4gICAgICAgLmNsYXNzX2luaXQgICAgPSBvdF91YXJ0X2NsYXNz
X2luaXQsDQo+PiAgIH07DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvY2hhci9v
dF91YXJ0LmggYi9pbmNsdWRlL2h3L2NoYXIvb3RfdWFydC5oDQo+PiBpbmRleCA1MTczMjRi
NjVkLi5mZWUyMTI4ZjkwIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9ody9jaGFyL290X3Vh
cnQuaA0KPj4gKysrIGIvaW5jbHVkZS9ody9jaGFyL290X3VhcnQuaA0KPj4gQEAgLTM0LDcg
KzM0LDcgQEANCj4+ICAgI2RlZmluZSBPVF9VQVJUX0NMT0NLIDUwMDAwMDAwIC8qIDUwTUh6
IGNsb2NrICovDQo+Pg0KPj4gICAjZGVmaW5lIFRZUEVfT1RfVUFSVCAib3QtdWFydCINCj4+
IC1PQkpFQ1RfREVDTEFSRV9TSU1QTEVfVFlQRShPdFVBUlRTdGF0ZSwgT1RfVUFSVCkNCj4+
ICtPQkpFQ1RfREVDTEFSRV9UWVBFKE90VUFSVFN0YXRlLCBPdFVBUlRDbGFzcywgT1RfVUFS
VCkNCj4+DQo+PiAgIHN0cnVjdCBPdFVBUlRTdGF0ZSB7DQo+PiAgICAgICAvKiA8cHJpdmF0
ZT4gKi8NCj4+IEBAIC03MCw0ICs3MCwxMCBAQCBzdHJ1Y3QgT3RVQVJUU3RhdGUgew0KPj4g
ICAgICAgcWVtdV9pcnEgdHhfZW1wdHk7DQo+PiAgICAgICBxZW11X2lycSByeF9vdmVyZmxv
dzsNCj4+ICAgfTsNCj4+ICsNCj4+ICtzdHJ1Y3QgT3RVQVJUQ2xhc3Mgew0KPj4gKyAgICBT
eXNCdXNEZXZpY2VDbGFzcyBwYXJlbnRfY2xhc3M7DQo+PiArICAgIFJlc2V0dGFibGVQaGFz
ZXMgcGFyZW50X3BoYXNlczsNCj4+ICt9Ow0KPj4gKw0KPj4gICAjZW5kaWYgLyogSFdfT1Rf
VUFSVF9IICovDQo+PiAtLQ0KPj4gMi40OS4xDQo+Pg0KPj4NCi0tIA0KTGV4IEJhaWxleSAo
dGhleS90aGVtKQ0KbG93UklTQyBDLkkuQy4gNyBIaWxscyBSb2FkLCBDYW1icmlkZ2UsIENC
MiAxR0UsIFVLLiBSZWdpc3RlcmVkIGluIA0KRW5nbGFuZCAmIFdhbGVzIDA5MjcyMjgzIGxl
eC5iYWlsZXlAbG93cmlzYy5vcmcNCg==
--------------xaUES543xIMo8UUTP7TS4g0L
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF=
-8">
  </head>
  <body>
    <p>Hi Alistair,</p>
    <p>thanks for reviewing this. I just want to check I haven't missed
      any messages from you, did you have a chance to look again at the
      other commits? are there any other changes you need? or is this
      ready to merge?</p>
    <p>Thanks,</p>
    <p>Lex.</p>
    <div class=3D"moz-cite-prefix">On 05/05/2026 05:24, Alistair Francis
      wrote:<br>
    </div>
    <blockquote type=3D"cite"
cite=3D"mid:CAKmqyKP_BjngLxMUmgEk9t2bmyz9LXe8UYbzmvTs3Ope039kwQ@mail.gmai=
l.com">
      <pre wrap=3D"" class=3D"moz-quote-pre">On Fri, May 1, 2026 at 2:06=E2=
=80=AFAM ~lexbaileylowrisc
<a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lexbaileylowrisc@git.sr=
=2Eht">&lt;lexbaileylowrisc@git.sr.ht&gt;</a> wrote:
</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">
From: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mailto:lex.ba=
iley@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>

switch from legacy_reset to new ResettableClass for OpenTitan UART device=


Signed-off-by: Lex Bailey <a class=3D"moz-txt-link-rfc2396E" href=3D"mail=
to:lex.bailey@lowrisc.org">&lt;lex.bailey@lowrisc.org&gt;</a>
</pre>
      </blockquote>
      <pre wrap=3D"" class=3D"moz-quote-pre">
Reviewed-by: Alistair Francis <a class=3D"moz-txt-link-rfc2396E" href=3D"=
mailto:alistair.francis@wdc.com">&lt;alistair.francis@wdc.com&gt;</a>

Alistair

</pre>
      <blockquote type=3D"cite">
        <pre wrap=3D"" class=3D"moz-quote-pre">---
 hw/char/ot_uart.c         | 16 +++++++++++++---
 include/hw/char/ot_uart.h |  8 +++++++-
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/hw/char/ot_uart.c b/hw/char/ot_uart.c
index b3eb619641..9478af40f9 100644
--- a/hw/char/ot_uart.c
+++ b/hw/char/ot_uart.c
@@ -227,9 +227,14 @@ static void uart_write_tx_fifo(OtUARTState *s, const=
 uint8_t *buf,
               (s-&gt;char_tx_time * 4));
 }

-static void ot_uart_reset(DeviceState *dev)
+static void ot_uart_reset_enter(Object *obj, ResetType type)
 {
-    OtUARTState *s =3D OT_UART(dev);
+    OtUARTClass *c =3D OT_UART_GET_CLASS(obj);
+    OtUARTState *s =3D OT_UART(obj);
+
+    if (c-&gt;parent_phases.enter) {
+        c-&gt;parent_phases.enter(obj, type);
+    }

     s-&gt;uart_intr_state =3D 0x00000000;
     s-&gt;uart_intr_state =3D 0x00000000;
@@ -544,12 +549,16 @@ static void ot_uart_realize(DeviceState *dev, Error=
 **errp)
 static void ot_uart_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
+    OtUARTClass *uc =3D OT_UART_CLASS(klass);
+    ResettableClass *rc =3D RESETTABLE_CLASS(klass);

-    device_class_set_legacy_reset(dc, ot_uart_reset);
     dc-&gt;realize =3D ot_uart_realize;
     dc-&gt;vmsd =3D &amp;vmstate_ot_uart;
     device_class_set_props(dc, ot_uart_properties);
     set_bit(DEVICE_CATEGORY_INPUT, dc-&gt;categories);
+
+    resettable_class_set_parent_phases(rc, &amp;ot_uart_reset_enter, NUL=
L, NULL,
+                                       &amp;uc-&gt;parent_phases);
 }

 static const TypeInfo ot_uart_info =3D {
@@ -557,6 +566,7 @@ static const TypeInfo ot_uart_info =3D {
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(OtUARTState),
     .instance_init =3D ot_uart_init,
+    .class_size    =3D sizeof(OtUARTClass),
     .class_init    =3D ot_uart_class_init,
 };

diff --git a/include/hw/char/ot_uart.h b/include/hw/char/ot_uart.h
index 517324b65d..fee2128f90 100644
--- a/include/hw/char/ot_uart.h
+++ b/include/hw/char/ot_uart.h
@@ -34,7 +34,7 @@
 #define OT_UART_CLOCK 50000000 /* 50MHz clock */

 #define TYPE_OT_UART "ot-uart"
-OBJECT_DECLARE_SIMPLE_TYPE(OtUARTState, OT_UART)
+OBJECT_DECLARE_TYPE(OtUARTState, OtUARTClass, OT_UART)

 struct OtUARTState {
     /* &lt;private&gt; */
@@ -70,4 +70,10 @@ struct OtUARTState {
     qemu_irq tx_empty;
     qemu_irq rx_overflow;
 };
+
+struct OtUARTClass {
+    SysBusDeviceClass parent_class;
+    ResettablePhases parent_phases;
+};
+
 #endif /* HW_OT_UART_H */
--
2.49.1


</pre>
      </blockquote>
    </blockquote>
    <div class=3D"moz-signature">-- <br>
      Lex Bailey (they/them)<br>
      <span style=3D"font-size:0.5em;color:#777777;">lowRISC C.I.C. 7
        Hills Road, Cambridge, CB2 1GE, UK. Registered in England &amp;
        Wales 09272283
        <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lex.bailey@l=
owrisc.org">lex.bailey@lowrisc.org</a></span></div>
  </body>
</html>

--------------xaUES543xIMo8UUTP7TS4g0L--

--------------5euExJcUfa3Lc6wqVUM3oZjq
Content-Type: application/pgp-keys; name="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Disposition: attachment; filename="OpenPGP_0x7CBB20D40B55582C.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
WZXWKp/svUI=3D
=3DQ1uI
-----END PGP PUBLIC KEY BLOCK-----

--------------5euExJcUfa3Lc6wqVUM3oZjq--

--------------Qpzye9dInq9WDoTb6OfTTIRM--

--------------R6QnJCyfG6HqJr90nogEQYIU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEq6gR1Rj7FCIRoDCVfLsg1AtVWCwFAmn957sFAwAAAAAACgkQfLsg1AtVWCxx
ewwAmx335XydxK6q7X84eBipOXuhQFaoITAxK1FBFlXjx6tIFrHRg0UaK6iT3KeuuiJXe8CgojCL
ndnoD6WSrDvP7SUHYs9D6Wr6Jgk/Y0Wor1pnz2CgHCbSaY/xQYLqLdnJKyqotM2x3lSEGDgyVLAx
qMcbFSAKgcZWev/3SkdmjkjdvJofZPqzgn8uhXMTe1PCri2pDxUTt7sYCFshbvrxW+qFqjgx711V
wzmxkdTRywra134MZh6itH5XYlI9Ig1MsabdX0rqGgjZp7WeaN6GnxrpZCbBPdmd0U+QvN09AVqP
TehgF70/rg6e9EJDbImO92iY0uYlnHReku8uh7qtl+YmDUf9AFI5GzVNAl9LW24JRb3UEEYY4tc9
yu4C+4c3RD8ZNtuNBVUGBQNBImPq7sFWKB1jbO6u2KC9tV8GLSNhVy9okCwh4SxTBkN0N9+ilVpZ
chOUOuJ1ioLzrx9kPcYgyzjGxFwMHSR2e9jLvQyprWV2ipiywgqcRPiqukIe
=tQ5H
-----END PGP SIGNATURE-----

--------------R6QnJCyfG6HqJr90nogEQYIU--

