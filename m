Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4AAC369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 19:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5Usf-0008QL-Hm; Thu, 17 Apr 2025 15:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5Usd-0008PT-Gm
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:26:35 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5Usb-00049S-P4
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 15:26:35 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so989132a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 12:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744917992; x=1745522792; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T6vNi+KvalAybpKBOTSBR/8g9w1aPXTANi5u8KyUGS4=;
 b=MT+zBjAn3EElxQOO10E0lYvpdK/4G8mJQSQRM2AP3oJo9F+vY/uTVtp5723qGA88QQ
 S4k0XIYtjgzTB/kEs5WqlGYU+vNyTEGSoniFnVT44voo7xfAhmUqLy3ZYmwvQUuQ+LVk
 6tek1ACgnzlpu5XGbGxM/Q+JOfqxGD5UTsSw/Jt6L52qvdEIS89SYi+DdVdgqJ0a9htw
 iww2QojzfPgqLc1dOEOO4d5O4MSRDytouUyXgUx9Xne2o21JEEIhHnfZR1EtEr3RL6ce
 aVSQiWjI4hOhvkg2xOF9sCpKZUKj7WG4ExPK6zwiohfQhV1JRzCvYZJysTdgrHoon0zW
 SpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744917992; x=1745522792;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T6vNi+KvalAybpKBOTSBR/8g9w1aPXTANi5u8KyUGS4=;
 b=dfWMBnRM9Jwrdh1hL5pMZ+PAdsz8Uvf1JDEyBNjyymxzKAPY46O+ddN0mSVD6kh/Tj
 793D2gpOY35SGmqSG9j8zbWEh3iYXdL4F8WB7w5OieRdFZ2DyLHVgqNnoj8UaXezOGO7
 ILXeesVCdFiyb6xyLyiEXBuO5jZT5Fxt3FF1vlXyY4LoxmibUNcbZJnCh6YOaVTHLaXn
 jzSntCgqiidjXv9nBFlNQYjxmMgZ2t3T/Xo2ip7/dxG2eEIDu3ThhsHb97sddCR0//D6
 MWx5r2Aqt29EpGNlFpT3+6qc0szmOBW93BhHRZBhYy2qmv1wz+L/p3iOLtWUWV+lB9/w
 8Jgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9RuXD3Em7i1QXNA1Xv4gv3qktn+Zda3Qn/zReeyZnRv9qHZxTEIAmyDAaBZRdMbsZIc+bhIocpRfz@nongnu.org
X-Gm-Message-State: AOJu0Yys6DqbcpP6sUnvX+dKNXv0qE+FIgpFy38OIExOGI3bfOzlnJ8U
 RFDZ9BcezfMdekagVk+6b9NWR3Uh1IMwolKtUgvJ/ZTEjMI99k1KGbc/k3J01AE=
X-Gm-Gg: ASbGncuzDaKT9gm0SsiPAVlKBQV01l8VZqj8Mnua7pEgtZh10iCEnD+rfalHYGlYY6i
 A39fMemYz/6Gy+OS+7yp8DSCPLHLs87AULgeNEzhJMSBAnqAISGwsvDVuuWxw9OstReBo3dxe4E
 PJNSdmNt4mxj4ZapWM2GCtIPaljq3H9FBC8tMv+GbeoMfveHbqpZwGtsdPy8D1sCJOmCnn0U89W
 SRJrf05VPyeHEEOexsbmi32XNK1agS856oOAENIJ+grn7yVn9g7jL7hvuQ6BisA5E3VP7Ll6dCx
 7kKGe9RLyW4NVdw3zK2vfZCf3EHTiv4nNSSsL0aS5D/g/VP+Evq0KBnzYTOiHtH4
X-Google-Smtp-Source: AGHT+IGHHtFiPEoBHZZkH73N7lgPvWxsPBoeT3s3NWuf9qwTwnhaIDar2GdEUs5M8RjUpquyfWjIKA==
X-Received: by 2002:a05:6a20:9f06:b0:1f5:60fb:8d9 with SMTP id
 adf61e73a8af0-203cbd20487mr378240637.33.1744917991909; 
 Thu, 17 Apr 2025 12:26:31 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db13ceb10sm238842a12.45.2025.04.17.12.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 12:26:31 -0700 (PDT)
Message-ID: <344597f7-b3c0-4ff5-88a5-09b8d8e8bbe1@linaro.org>
Date: Thu, 17 Apr 2025 12:26:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target/ppc: Evaluate TARGET_BIG_ENDIAN at compile time
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250417131004.47205-1-philmd@linaro.org>
 <20250417131004.47205-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250417131004.47205-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x530.google.com
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

T24gNC8xNy8yNSAwNjoxMCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IFJh
dGhlciB0aGFuIGV2YWx1YXRpbmcgVEFSR0VUX0JJR19FTkRJQU4gYXQgcHJlcHJvY2Vzc2lu
Zw0KPiB0aW1lIHZpYSAjaWZkZWYncnksIGRvIGl0IGluIEMgYXQgY29tcGlsZSB0aW1lDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxp
bmFyby5vcmc+DQo+IC0tLQ0KPiAgIHRhcmdldC9wcGMvY3B1X2luaXQuYyAgIHwgMTIgKysr
KysrLS0tLS0tDQo+ICAgdGFyZ2V0L3BwYy9tZW1faGVscGVyLmMgfCAgNiArLS0tLS0NCj4g
ICB0YXJnZXQvcHBjL3RyYW5zbGF0ZS5jICB8ICA2ICstLS0tLQ0KPiAgIDMgZmlsZXMgY2hh
bmdlZCwgOCBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS90YXJnZXQvcHBjL2NwdV9pbml0LmMgYi90YXJnZXQvcHBjL2NwdV9pbml0LmMNCj4g
aW5kZXggMDc3OTkxZWQ1MzUuLmJiYWI0MTFhMDdjIDEwMDY0NA0KPiAtLS0gYS90YXJnZXQv
cHBjL2NwdV9pbml0LmMNCj4gKysrIGIvdGFyZ2V0L3BwYy9jcHVfaW5pdC5jDQo+IEBAIC03
MjYyLDE0ICs3MjYyLDE0IEBAIHN0YXRpYyB2b2lkIHBwY19jcHVfcmVzZXRfaG9sZChPYmpl
Y3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpDQo+ICAgI2lmIGRlZmluZWQoVEFSR0VUX1BQQzY0
KQ0KPiAgICAgICBtc3IgfD0gKHRhcmdldF91bG9uZykxIDw8IE1TUl9UTTsgLyogVHJhbnNh
Y3Rpb25hbCBtZW1vcnkgKi8NCj4gICAjZW5kaWYNCj4gLSNpZiAhVEFSR0VUX0JJR19FTkRJ
QU4NCj4gLSAgICBtc3IgfD0gKHRhcmdldF91bG9uZykxIDw8IE1TUl9MRTsgLyogTGl0dGxl
LWVuZGlhbiB1c2VyIG1vZGUgKi8NCj4gLSAgICBpZiAoISgoZW52LT5tc3JfbWFzayA+PiBN
U1JfTEUpICYgMSkpIHsNCj4gLSAgICAgICAgZnByaW50ZihzdGRlcnIsICJTZWxlY3RlZCBD
UFUgZG9lcyBub3Qgc3VwcG9ydCBsaXR0bGUtZW5kaWFuLlxuIik7DQo+IC0gICAgICAgIGV4
aXQoMSk7DQo+ICsgICAgaWYgKCFUQVJHRVRfQklHX0VORElBTikgew0KPiArICAgICAgICBt
c3IgfD0gKHRhcmdldF91bG9uZykxIDw8IE1TUl9MRTsgLyogTGl0dGxlLWVuZGlhbiB1c2Vy
IG1vZGUgKi8NCj4gKyAgICAgICAgaWYgKCEoKGVudi0+bXNyX21hc2sgPj4gTVNSX0xFKSAm
IDEpKSB7DQo+ICsgICAgICAgICAgICBmcHJpbnRmKHN0ZGVyciwgIlNlbGVjdGVkIENQVSBk
b2VzIG5vdCBzdXBwb3J0IGxpdHRsZS1lbmRpYW4uXG4iKTsNCj4gKyAgICAgICAgICAgIGV4
aXQoMSk7DQo+ICsgICAgICAgIH0NCj4gICAgICAgfQ0KPiAgICNlbmRpZg0KPiAtI2VuZGlm
DQo+ICAgDQo+ICAgI2lmIGRlZmluZWQoVEFSR0VUX1BQQzY0KQ0KPiAgICAgICBpZiAobW11
X2lzXzY0Yml0KGVudi0+bW11X21vZGVsKSkgew0KPiBkaWZmIC0tZ2l0IGEvdGFyZ2V0L3Bw
Yy9tZW1faGVscGVyLmMgYi90YXJnZXQvcHBjL21lbV9oZWxwZXIuYw0KPiBpbmRleCBkN2U4
ZDY3OGY0Yi4uY2MzZWQyOWEzNWIgMTAwNjQ0DQo+IC0tLSBhL3RhcmdldC9wcGMvbWVtX2hl
bHBlci5jDQo+ICsrKyBiL3RhcmdldC9wcGMvbWVtX2hlbHBlci5jDQo+IEBAIC0zMiwxMSAr
MzIsNyBAQA0KPiAgIA0KPiAgIHN0YXRpYyBpbmxpbmUgYm9vbCBuZWVkc19ieXRlc3dhcChj
b25zdCBDUFVQUENTdGF0ZSAqZW52KQ0KPiAgIHsNCj4gLSNpZiBUQVJHRVRfQklHX0VORElB
Tg0KPiAtICByZXR1cm4gRklFTERfRVg2NChlbnYtPm1zciwgTVNSLCBMRSk7DQo+IC0jZWxz
ZQ0KPiAtICByZXR1cm4gIUZJRUxEX0VYNjQoZW52LT5tc3IsIE1TUiwgTEUpOw0KPiAtI2Vu
ZGlmDQo+ICsgIHJldHVybiBUQVJHRVRfQklHX0VORElBTiBeIEZJRUxEX0VYNjQoZW52LT5t
c3IsIE1TUiwgTEUpOw0KPiAgIH0NCj4gICANCj4gICAvKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KiovDQo+IGRpZmYgLS1naXQgYS90YXJnZXQvcHBjL3RyYW5zbGF0ZS5jIGIvdGFyZ2V0L3Bw
Yy90cmFuc2xhdGUuYw0KPiBpbmRleCAzOTkxMDdkMzE5YS4uODI4Yjg1MGI0MGUgMTAwNjQ0
DQo+IC0tLSBhL3RhcmdldC9wcGMvdHJhbnNsYXRlLmMNCj4gKysrIGIvdGFyZ2V0L3BwYy90
cmFuc2xhdGUuYw0KPiBAQCAtMjEzLDExICsyMTMsNyBAQCBzdHJ1Y3QgRGlzYXNDb250ZXh0
IHsNCj4gICAvKiBSZXR1cm4gdHJ1ZSBpZmYgYnl0ZXN3YXAgaXMgbmVlZGVkIGluIGEgc2Nh
bGFyIG1lbW9wICovDQo+ICAgc3RhdGljIGlubGluZSBib29sIG5lZWRfYnl0ZXN3YXAoY29u
c3QgRGlzYXNDb250ZXh0ICpjdHgpDQo+ICAgew0KPiAtI2lmIFRBUkdFVF9CSUdfRU5ESUFO
DQo+IC0gICAgIHJldHVybiBjdHgtPmxlX21vZGU7DQo+IC0jZWxzZQ0KPiAtICAgICByZXR1
cm4gIWN0eC0+bGVfbW9kZTsNCj4gLSNlbmRpZg0KPiArICAgICByZXR1cm4gVEFSR0VUX0JJ
R19FTkRJQU4gXiBjdHgtPmxlX21vZGU7DQoNCk1heWJlIEknbSBtaXNzaW5nIHNvbWV0aGlu
ZywgYnV0IHdpdGgge1RBUkdFVF9CSUdfRU5ESUFOOiAxLCANCmN0eC0+bGVfbW9kZTogMX0s
IGl0IHdvdWxkIHJldHVybiAwLCB3aGlsZSBpdCBzaG91bGQgYmUgMSBpbnN0ZWFkLg0KDQpJ
dCB3b3VsZCBiZSBtb3JlIHJlYWRhYmxlIHRvIHVzZSBhIGlmIG9yIGEgdGVybmFyeSBleHBy
ZXNzaW9uLg0KU2FtZSBmb3IgcHJldmlvdXMgZnVuY3Rpb24gbmVlZHNfYnl0ZXN3YXAuDQoN
Cj4gICB9DQo+ICAgDQo+ICAgLyogVHJ1ZSB3aGVuIGFjdGl2ZSB3b3JkIHNpemUgPCBzaXpl
IG9mIHRhcmdldF9sb25nLiAgKi8NCg0K

