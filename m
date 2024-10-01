Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B85CEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svgCY-00034O-JZ; Tue, 01 Oct 2024 12:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgC9-00030H-TD
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:57:56 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1svgC7-0008FD-FR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:57:53 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71dba8b05cbso1038028b3a.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727801870; x=1728406670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hko+oxlT08PXjzr7hkDSGu43O/zif8zFQn9O3Ptk/D8=;
 b=jORaLiK0i1/sjg2ol3NW0cJNDetj7shuOs/U+sopKSzWzB9CAKEmHGP6QnDd3qYkdv
 4A7crmMIydA0gdG8hZDuPsyGFyij3/GXtNb5Rf84hlMrQKQL7uO8LgpRgfdlR6KQ4P9I
 1HfJh0BAmYnRTcsGfBtBvNsduizIeBPd79kTGdhAWjkyAY3Ilvtiu466UXS0vPFqaOoq
 LjJk5hp6kk0ilOoFywucjgy9gCLThjUJbcL4jaOfmbawSQa/Dm+mtycxvQrMgA7Hh/3z
 sYqmiG+KEhEuniiABRhInnr+ou/99K1p3ud1Uqw44ZVo5FXV92q1blxYmoicGfpjdY94
 l4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727801870; x=1728406670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hko+oxlT08PXjzr7hkDSGu43O/zif8zFQn9O3Ptk/D8=;
 b=uKW5iDL6z6231HX/1cS3JyG/PjP/CART9XKXJF+m9gvzP3OmP0aExvDR2UE0XUvad9
 BmP2xzKYYrX3wJ/AahcnDZSl2Z30sJL+LYqE2GLnEDEctObuuck/QhQGFOUOSjbALI+X
 ubAnwJFFeQdHaykXF3A+1VhZKoAk7B/aYcrFIBxBqo3kxNf02czL8JYYuXZCWFmfQFxa
 M7WBBLgmSB8kBwbb6qVOcQGDdNkZMi5uCtxe5+X+e/6Tgc1FIQWH1i8c479v8vVmwUBG
 JWxyxcdNli1IBb4YSzDIkvf0wK7prWPeU5JMp041oNlYFAcssDBIQUWRCjFAOEiVtBbz
 WMdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD/PLKQRi/dvAvH4V/HDhDjowzBYsld8C3EYPDBFWLWEi4WCwGXGVaQ9G6Yml0p22iOMIpJWYR7fOB@nongnu.org
X-Gm-Message-State: AOJu0YzgPdTS+x/sgNTD83lnMtnDKG0loC12jEVL4Kk7SbKy45bbFg9C
 36GZk8TUuIRM95abIlN8mgsmTxjN7mfrnq33HTI0OXxqVomnY9E1bCWfnPKynvM=
X-Google-Smtp-Source: AGHT+IGc9GjfY/0IIXK/QvZHhJGOR7lfFaXFQPLfCutrKDoc/LC49iLB97IxEZSPhDkBLhckfVixUA==
X-Received: by 2002:a05:6a00:1396:b0:717:8a87:7d02 with SMTP id
 d2e1a72fcca58-71dc5d5cfc2mr457688b3a.23.1727801870262; 
 Tue, 01 Oct 2024 09:57:50 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71b264bc88bsm8293331b3a.71.2024.10.01.09.57.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2024 09:57:49 -0700 (PDT)
Message-ID: <24067656-d292-4bd5-b7ad-d101d89ce755@linaro.org>
Date: Tue, 1 Oct 2024 09:57:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] hw/net/tulip: Use ld/st_endian_pci_dma() API
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth
 <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>, Huacai Chen
 <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
References: <20240930073450.33195-1-philmd@linaro.org>
 <20240930073450.33195-14-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240930073450.33195-14-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

T24gOS8zMC8yNCAwMDozNCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJl
ZmFjdG9yIHRvIHVzZSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBsZC9zdF9lbmRpYW5fcGNp
X2RtYSgpDQo+IEFQSS4gTm8gbG9naWNhbCBjaGFuZ2UgaW50ZW5kZWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+
DQo+IC0tLQ0KPiAgIGh3L25ldC90dWxpcC5jIHwgMzIgKysrKysrKysrKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMjIg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaHcvbmV0L3R1bGlwLmMgYi9ody9u
ZXQvdHVsaXAuYw0KPiBpbmRleCA5ZGYzZTE3MTYyLi42YzY3OTU4ZGE3IDEwMDY0NA0KPiAt
LS0gYS9ody9uZXQvdHVsaXAuYw0KPiArKysgYi9ody9uZXQvdHVsaXAuYw0KPiBAQCAtNzEs
MzYgKzcxLDI0IEBAIHN0YXRpYyB2b2lkIHR1bGlwX2Rlc2NfcmVhZChUVUxJUFN0YXRlICpz
LCBod2FkZHIgcCwNCj4gICAgICAgICAgIHN0cnVjdCB0dWxpcF9kZXNjcmlwdG9yICpkZXNj
KQ0KPiAgIHsNCj4gICAgICAgY29uc3QgTWVtVHhBdHRycyBhdHRycyA9IHsgLm1lbW9yeSA9
IHRydWUgfTsNCj4gKyAgICBib29sIHVzZV9iaWdfZW5kaWFuID0gcy0+Y3NyWzBdICYgQ1NS
MF9EQk87DQo+ICAgDQo+IC0gICAgaWYgKHMtPmNzclswXSAmIENTUjBfREJPKSB7DQo+IC0g
ICAgICAgIGxkbF9iZV9wY2lfZG1hKCZzLT5kZXYsIHAsICZkZXNjLT5zdGF0dXMsIGF0dHJz
KTsNCj4gLSAgICAgICAgbGRsX2JlX3BjaV9kbWEoJnMtPmRldiwgcCArIDQsICZkZXNjLT5j
b250cm9sLCBhdHRycyk7DQo+IC0gICAgICAgIGxkbF9iZV9wY2lfZG1hKCZzLT5kZXYsIHAg
KyA4LCAmZGVzYy0+YnVmX2FkZHIxLCBhdHRycyk7DQo+IC0gICAgICAgIGxkbF9iZV9wY2lf
ZG1hKCZzLT5kZXYsIHAgKyAxMiwgJmRlc2MtPmJ1Zl9hZGRyMiwgYXR0cnMpOw0KPiAtICAg
IH0gZWxzZSB7DQo+IC0gICAgICAgIGxkbF9sZV9wY2lfZG1hKCZzLT5kZXYsIHAsICZkZXNj
LT5zdGF0dXMsIGF0dHJzKTsNCj4gLSAgICAgICAgbGRsX2xlX3BjaV9kbWEoJnMtPmRldiwg
cCArIDQsICZkZXNjLT5jb250cm9sLCBhdHRycyk7DQo+IC0gICAgICAgIGxkbF9sZV9wY2lf
ZG1hKCZzLT5kZXYsIHAgKyA4LCAmZGVzYy0+YnVmX2FkZHIxLCBhdHRycyk7DQo+IC0gICAg
ICAgIGxkbF9sZV9wY2lfZG1hKCZzLT5kZXYsIHAgKyAxMiwgJmRlc2MtPmJ1Zl9hZGRyMiwg
YXR0cnMpOw0KPiAtICAgIH0NCj4gKyAgICBsZGxfZW5kaWFuX3BjaV9kbWEodXNlX2JpZ19l
bmRpYW4sICZzLT5kZXYsIHAsICZkZXNjLT5zdGF0dXMsIGF0dHJzKTsNCj4gKyAgICBsZGxf
ZW5kaWFuX3BjaV9kbWEodXNlX2JpZ19lbmRpYW4sICZzLT5kZXYsIHAgKyA0LCAmZGVzYy0+
Y29udHJvbCwgYXR0cnMpOw0KPiArICAgIGxkbF9lbmRpYW5fcGNpX2RtYSh1c2VfYmlnX2Vu
ZGlhbiwgJnMtPmRldiwgcCArIDgsICZkZXNjLT5idWZfYWRkcjEsIGF0dHJzKTsNCj4gKyAg
ICBsZGxfZW5kaWFuX3BjaV9kbWEodXNlX2JpZ19lbmRpYW4sICZzLT5kZXYsIHAgKyAxMiwg
JmRlc2MtPmJ1Zl9hZGRyMiwgYXR0cnMpOw0KPiAgIH0NCj4gICANCj4gICBzdGF0aWMgdm9p
ZCB0dWxpcF9kZXNjX3dyaXRlKFRVTElQU3RhdGUgKnMsIGh3YWRkciBwLA0KPiAgICAgICAg
ICAgc3RydWN0IHR1bGlwX2Rlc2NyaXB0b3IgKmRlc2MpDQo+ICAgew0KPiAgICAgICBjb25z
dCBNZW1UeEF0dHJzIGF0dHJzID0geyAubWVtb3J5ID0gdHJ1ZSB9Ow0KPiArICAgIGJvb2wg
dXNlX2JpZ19lbmRpYW4gPSBzLT5jc3JbMF0gJiBDU1IwX0RCTzsNCj4gICANCj4gLSAgICBp
ZiAocy0+Y3NyWzBdICYgQ1NSMF9EQk8pIHsNCj4gLSAgICAgICAgc3RsX2JlX3BjaV9kbWEo
JnMtPmRldiwgcCwgZGVzYy0+c3RhdHVzLCBhdHRycyk7DQo+IC0gICAgICAgIHN0bF9iZV9w
Y2lfZG1hKCZzLT5kZXYsIHAgKyA0LCBkZXNjLT5jb250cm9sLCBhdHRycyk7DQo+IC0gICAg
ICAgIHN0bF9iZV9wY2lfZG1hKCZzLT5kZXYsIHAgKyA4LCBkZXNjLT5idWZfYWRkcjEsIGF0
dHJzKTsNCj4gLSAgICAgICAgc3RsX2JlX3BjaV9kbWEoJnMtPmRldiwgcCArIDEyLCBkZXNj
LT5idWZfYWRkcjIsIGF0dHJzKTsNCj4gLSAgICB9IGVsc2Ugew0KPiAtICAgICAgICBzdGxf
bGVfcGNpX2RtYSgmcy0+ZGV2LCBwLCBkZXNjLT5zdGF0dXMsIGF0dHJzKTsNCj4gLSAgICAg
ICAgc3RsX2xlX3BjaV9kbWEoJnMtPmRldiwgcCArIDQsIGRlc2MtPmNvbnRyb2wsIGF0dHJz
KTsNCj4gLSAgICAgICAgc3RsX2xlX3BjaV9kbWEoJnMtPmRldiwgcCArIDgsIGRlc2MtPmJ1
Zl9hZGRyMSwgYXR0cnMpOw0KPiAtICAgICAgICBzdGxfbGVfcGNpX2RtYSgmcy0+ZGV2LCBw
ICsgMTIsIGRlc2MtPmJ1Zl9hZGRyMiwgYXR0cnMpOw0KPiAtICAgIH0NCj4gKyAgICBzdGxf
ZW5kaWFuX3BjaV9kbWEodXNlX2JpZ19lbmRpYW4sICZzLT5kZXYsIHAsIGRlc2MtPnN0YXR1
cywgYXR0cnMpOw0KPiArICAgIHN0bF9lbmRpYW5fcGNpX2RtYSh1c2VfYmlnX2VuZGlhbiwg
JnMtPmRldiwgcCArIDQsIGRlc2MtPmNvbnRyb2wsIGF0dHJzKTsNCj4gKyAgICBzdGxfZW5k
aWFuX3BjaV9kbWEodXNlX2JpZ19lbmRpYW4sICZzLT5kZXYsIHAgKyA4LCBkZXNjLT5idWZf
YWRkcjEsIGF0dHJzKTsNCj4gKyAgICBzdGxfZW5kaWFuX3BjaV9kbWEodXNlX2JpZ19lbmRp
YW4sICZzLT5kZXYsIHAgKyAxMiwgZGVzYy0+YnVmX2FkZHIyLCBhdHRycyk7DQo+ICAgfQ0K
PiAgIA0KPiAgIHN0YXRpYyB2b2lkIHR1bGlwX3VwZGF0ZV9pbnQoVFVMSVBTdGF0ZSAqcykN
Cg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAbGlu
YXJvLm9yZz4NCg==

