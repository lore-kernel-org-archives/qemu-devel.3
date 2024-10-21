Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5393D15D99
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2ubQ-0008GE-EP; Mon, 21 Oct 2024 11:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2ubO-0008Fq-Uw
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:45:50 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t2ubM-0008DY-Rr
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:45:50 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7eb00dc77f1so250288a12.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729525547; x=1730130347; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xctf1Z3aUJn1TXGklsaFVmOCZmoRxJV/TDytNz6WNto=;
 b=scjoKlgUL0Ctvt5MsSpUtFSr+Dw2Z7OW2dWPm9ibyLiN5IbDL+m7LCkjQkbAr+Grcz
 vFmuDtV1bdD6nixHKpaM16TS36loBn81MEgJ4sRpScQidkJpyYAiIG+VWtf6OT+DmxJ1
 Xhise03F1pF1UACp/OP6hshPcODUm+toSktioHVbDz2k7BU0n+EmBF6FGpCvkytYGAbm
 fqCIuzPkEFrpin+fZ93R2OplJiDt8rpKQihI1u5U/nBDXho2lEGZdKCzolfGx/1F6I0c
 +zF6tevpZ0i2O6BMPi9+17yA6+QC7nj2tji/Exr6kvG9fVUjcwR9OH5yXRdotRuFWb2s
 Q7IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729525547; x=1730130347;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xctf1Z3aUJn1TXGklsaFVmOCZmoRxJV/TDytNz6WNto=;
 b=q0RY/+lxh9dKrrU5V2UzsC7zIxrFs1tjN369ipQ4XMi8+asVmxqjKOjgMWddB9jBti
 KWa3GvZi/vETK9WTfZPc6kpLYh19u1kNeLUizNSzldwLEVVQnE+bZsEBNF6z2IledGBq
 7jW4vJEWb5rDZf+QxfSWdS55YatdunXtxHkZKiIgPxcX7PG9WQomjjhLn31VXZKKIXb8
 KcAeGY9p+w+4wv1XIsMPxqsbKx+fVhItRW8Oe84axCrobtrQb3vy3Ry3m0Cd81xtZQTr
 +hkL1nWNE8dwCbK0fnW58zIYpmB06ADn8QSNsA/gsDsoylMzVKdDK0dJ0gb4h6l9JSud
 BgRg==
X-Gm-Message-State: AOJu0Yx4T6RHfXGv0HbGEnxFBhpPeaXnS4SvqQtZ/17CXTwLaUDYFAGd
 vVYt2rCmZB3BfcLKOHXLtrCz8OuSdOmwdm7bMx1xuSoYLApEpeAoG8QmnOoffGQ=
X-Google-Smtp-Source: AGHT+IHXvQ8d0jeo1tbsWe52tuY9PHrYX/Hop4JK1Ha0AzoTJ6lpOcik0t0gzfu1nqnAz0r2uXl+lQ==
X-Received: by 2002:a05:6a21:1349:b0:1d5:2767:9d08 with SMTP id
 adf61e73a8af0-1d92c56d346mr16981026637.39.1729525546985; 
 Mon, 21 Oct 2024 08:45:46 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec141507csm3031415b3a.215.2024.10.21.08.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 08:45:46 -0700 (PDT)
Message-ID: <0ea09363-c546-442d-9d41-44ea2798c75a@linaro.org>
Date: Mon, 21 Oct 2024 08:45:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] meson: build contrib/plugins with meson
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Brad Smith <brad@comstyle.com>
References: <20240925204845.390689-1-pierrick.bouvier@linaro.org>
 <20240925204845.390689-2-pierrick.bouvier@linaro.org>
 <87y12hokwp.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87y12hokwp.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x534.google.com
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

T24gMTAvMjEvMjQgMDI6MzgsIEFsZXggQmVubsOpZSB3cm90ZToNCj4gUGllcnJpY2sgQm91
dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPiB3cml0ZXM6DQo+IA0KPj4gVHJp
ZWQgdG8gdW5pZnkgdGhpcyBtZXNvbi5idWlsZCB3aXRoIHRlc3RzL3RjZy9wbHVnaW5zL21l
c29uLmJ1aWxkIGJ1dA0KPj4gdGhlIHJlc3VsdGluZyBtb2R1bGVzIGFyZSBub3Qgb3V0cHV0
IGluIHRoZSByaWdodCBkaXJlY3RvcnkuDQo+Pg0KPj4gT3JpZ2luYWxseSBwcm9wb3NlZCBi
eSBBbnRvbiBLb2Noa292LCB0aGFuayB5b3UhDQo+Pg0KPj4gU29sdmVzOiBodHRwczovL2dp
dGxhYi5jb20vcWVtdS1wcm9qZWN0L3FlbXUvLS9pc3N1ZXMvMTcxMA0KPj4gU2lnbmVkLW9m
Zi1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K
Pj4gLS0tDQo+PiAgIG1lc29uLmJ1aWxkICAgICAgICAgICAgICAgICB8ICA0ICsrKysNCj4+
ICAgY29udHJpYi9wbHVnaW5zL21lc29uLmJ1aWxkIHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKysNCj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+PiAgIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBjb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvbWVzb24uYnVpbGQgYi9tZXNvbi5idWlsZA0KPj4gaW5kZXggY2VlZTZi
MjJjOGQuLmIxOGMyYTU0YWI1IDEwMDY0NA0KPj4gLS0tIGEvbWVzb24uYnVpbGQNCj4+ICsr
KyBiL21lc29uLmJ1aWxkDQo+PiBAQCAtMzY1NSw2ICszNjU1LDEwIEBAIHN1YmRpcignYWNj
ZWwnKQ0KPj4gICBzdWJkaXIoJ3BsdWdpbnMnKQ0KPj4gICBzdWJkaXIoJ2VicGYnKQ0KPj4g
ICANCj4+ICtpZiAnQ09ORklHX1RDRycgaW4gY29uZmlnX2FsbF9hY2NlbA0KPj4gKyAgc3Vi
ZGlyKCdjb250cmliL3BsdWdpbnMnKQ0KPj4gK2VuZGlmDQo+PiArDQo+PiAgIGNvbW1vbl91
c2VyX2luYyA9IFtdDQo+PiAgIA0KPj4gICBzdWJkaXIoJ2NvbW1vbi11c2VyJykNCj4+IGRp
ZmYgLS1naXQgYS9jb250cmliL3BsdWdpbnMvbWVzb24uYnVpbGQgYi9jb250cmliL3BsdWdp
bnMvbWVzb24uYnVpbGQNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAw
MDAwMDAwMC4uYTBlMDI2ZDI1ZTINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL2NvbnRy
aWIvcGx1Z2lucy9tZXNvbi5idWlsZA0KPj4gQEAgLTAsMCArMSwyMyBAQA0KPj4gK3QgPSBb
XQ0KPj4gK2lmIGdldF9vcHRpb24oJ3BsdWdpbnMnKQ0KPj4gKyAgZm9yZWFjaCBpIDogWydj
YWNoZScsICdkcmNvdicsICdleGVjbG9nJywgJ2hvdGJsb2NrcycsICdob3RwYWdlcycsICdo
b3d2ZWMnLA0KPj4gKyAgICAgICAgICAgICAgICdod3Byb2ZpbGUnLCAnaXBzJywgJ2xvY2tz
dGVwJywgJ3N0b3B0cmlnZ2VyJ10NCj4+ICsgICAgaWYgaG9zdF9vcyA9PSAnd2luZG93cycN
Cj4+ICsgICAgICB0ICs9IHNoYXJlZF9tb2R1bGUoaSwgZmlsZXMoaSArICcuYycpICsgJ3dp
bjMyX2xpbmtlci5jJywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBpbmNsdWRlX2Rp
cmVjdG9yaWVzOiAnLi4vLi4vaW5jbHVkZS9xZW11JywNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICBsaW5rX2RlcGVuZHM6IFt3aW4zMl9xZW11X3BsdWdpbl9hcGlfbGliXSwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICBsaW5rX2FyZ3M6IFsnLUxwbHVnaW5zJywgJy1s
cWVtdV9wbHVnaW5fYXBpJ10sDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgZGVwZW5k
ZW5jaWVzOiBnbGliKQ0KPj4gKw0KPj4gKyAgICBlbHNlDQo+PiArICAgICAgdCArPSBzaGFy
ZWRfbW9kdWxlKGksIGZpbGVzKGkgKyAnLmMnKSwNCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICBpbmNsdWRlX2RpcmVjdG9yaWVzOiAnLi4vLi4vaW5jbHVkZS9xZW11JywNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBkZXBlbmRlbmNpZXM6IGdsaWIpDQo+IA0KPiBJIHdh
cyB0cnlpbmcgdG8gd29yayBvdXQgd2hlcmUgdGhlIGluY2x1ZGUgZGlycyBjb21lIGZyb20g
dG8gbWFrZSBzdXJlDQo+IEJyYWQncyBmaXggKHNlZSBadTQwNjNmamZIQzVoSFVsQGh1bXB0
eS5ob21lLmNvbXN0eWxlLmNvbSkgYWxzbyBhcHBsaWVzLg0KPiBJdCBkb2VzIGJ1dDoNCj4g
DQo+ICAgIOKenCAgbWFrZSBjb250cmliL3BsdWdpbnMvbGliZXhlY2xvZy5zbyBWPTENCj4g
ICAgL3Vzci9iaW4vbmluamEgLXYgICAtajEgLWQga2VlcGRlcGZpbGUgY29udHJpYi9wbHVn
aW5zL2xpYmV4ZWNsb2cuc28gfCBjYXQNCj4gICAgWzEvMl0gY2MgLW02NCAtSWNvbnRyaWIv
cGx1Z2lucy9saWJleGVjbG9nLnNvLnAgLUljb250cmliL3BsdWdpbnMgLUkuLi8uLi9jb250
cmliL3BsdWdpbnMgLUkuLi8uLi9pbmNsdWRlL3FlbXUgLUkvdXNyL2luY2x1ZGUvZ2xpYi0y
LjAgLUkvdXNyL2xpYi94ODZfNjQtbGludXgtZ251L2dsaWItMi4wL2luY2x1ZGUgLWZkaWFn
bm9zdGljcy1jb2xvcj1hdXRvIC1XYWxsIC1XaW52YWxpZC1wY2ggLVdlcnJvciAtc3RkPWdu
dTExIC1PMiAtZyAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLVdlbXB0eS1ib2R5IC1XZW5k
aWYtbGFiZWxzIC1XZXhwYW5zaW9uLXRvLWRlZmluZWQgLVdmb3JtYXQtc2VjdXJpdHkgLVdm
b3JtYXQteTJrIC1XaWdub3JlZC1xdWFsaWZpZXJzIC1XaW1wbGljaXQtZmFsbHRocm91Z2g9
MiAtV2luaXQtc2VsZiAtV21pc3NpbmctZm9ybWF0LWF0dHJpYnV0ZSAtV21pc3NpbmctcHJv
dG90eXBlcyAtV25lc3RlZC1leHRlcm5zIC1Xb2xkLXN0eWxlLWRlY2xhcmF0aW9uIC1Xb2xk
LXN0eWxlLWRlZmluaXRpb24gLVdyZWR1bmRhbnQtZGVjbHMgLVdzaGFkb3c9bG9jYWwgLVdz
dHJpY3QtcHJvdG90eXBlcyAtV3R5cGUtbGltaXRzIC1XdW5kZWYgLVd2bGEgLVd3cml0ZS1z
dHJpbmdzIC1Xbm8tbWlzc2luZy1pbmNsdWRlLWRpcnMgLVduby1wc2FiaSAtV25vLXNoaWZ0
LW5lZ2F0aXZlLXZhbHVlIC1pc3lzdGVtIC9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9saW51
eC1oZWFkZXJzIC1pc3lzdGVtIGxpbnV4LWhlYWRlcnMgLWlxdW90ZSAuIC1pcXVvdGUgL2hv
bWUvYWxleC9sc3JjL3FlbXUuZ2l0IC1pcXVvdGUgL2hvbWUvYWxleC9sc3JjL3FlbXUuZ2l0
L2luY2x1ZGUgLWlxdW90ZSAvaG9tZS9hbGV4L2xzcmMvcWVtdS5naXQvaG9zdC9pbmNsdWRl
L3g4Nl82NCAtaXF1b3RlIC9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC9ob3N0L2luY2x1ZGUv
Z2VuZXJpYyAtaXF1b3RlIC9ob21lL2FsZXgvbHNyYy9xZW11LmdpdC90Y2cvaTM4NiAtcHRo
cmVhZCAtbWN4MTYgLW1wb3BjbnQgLW1uZWVkZWQgLW1tb3ZiZSAtbWFibSAtbWJtaSAtbWJt
aTIgLW1mbWEgLW1mMTZjIC1tYXZ4MiAtRF9HTlVfU09VUkNFIC1EX0ZJTEVfT0ZGU0VUX0JJ
VFM9NjQgLURfTEFSR0VGSUxFX1NPVVJDRSAtZm5vLXN0cmljdC1hbGlhc2luZyAtZm5vLWNv
bW1vbiAtZndyYXB2IC1mdHJpdmlhbC1hdXRvLXZhci1pbml0PXplcm8gLWZ6ZXJvLWNhbGwt
dXNlZC1yZWdzPXVzZWQtZ3ByIC1mUElDIC1NRCAtTVEgY29udHJpYi9wbHVnaW5zL2xpYmV4
ZWNsb2cuc28ucC9leGVjbG9nLmMubyAtTUYgY29udHJpYi9wbHVnaW5zL2xpYmV4ZWNsb2cu
c28ucC9leGVjbG9nLmMuby5kIC1vIGNvbnRyaWIvcGx1Z2lucy9saWJleGVjbG9nLnNvLnAv
ZXhlY2xvZy5jLm8gLWMgLi4vLi4vY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYw0KPiAgICBb
Mi8yXSBjYyAtbTY0ICAtbyBjb250cmliL3BsdWdpbnMvbGliZXhlY2xvZy5zbyBjb250cmli
L3BsdWdpbnMvbGliZXhlY2xvZy5zby5wL2V4ZWNsb2cuYy5vIC1XbCwtLWFzLW5lZWRlZCAt
V2wsLS1hbGxvdy1zaGxpYi11bmRlZmluZWQgLXNoYXJlZCAtZlBJQyAtZnN0YWNrLXByb3Rl
Y3Rvci1zdHJvbmcgLVdsLC16LHJlbHJvIC1XbCwteixub3cgLVdsLC0tc3RhcnQtZ3JvdXAg
L3Vzci9saWIveDg2XzY0LWxpbnV4LWdudS9saWJnbGliLTIuMC5zbyAvdXNyL2xpYi94ODZf
NjQtbGludXgtZ251L2xpYmdtb2R1bGUtMi4wLnNvIC1XbCwtLWVuZC1ncm91cCAtcHRocmVh
ZA0KPiANCj4gSSdtIG5vdCBzdXJlIHdoeSB3ZSBzZWUgIi1JY29udHJpYi9wbHVnaW5zIC1J
Li4vLi4vY29udHJpYi9wbHVnaW5zIi4NCj4gSXQncyBwcm9iYWJseSBhIGhhcm1sZXNzIHJl
ZHVuZGFuY3kgYnV0IEknbSBjdXJpb3VzIGFzIHRvIHdoZXJlIHRoZSBwYXRoDQo+IGNvbWVz
IGZyb20sIGFueSBpZGVhPw0KPiANCg0KSXQgY29tZXMgZnJvbSBtZXNvbiBpdHNlbGYuDQpZ
b3UgY2FuIHNlZSB0aGUgc2FtZSBraW5kIG9mIGluY2x1ZGUgc2NoZW1lIGlzIHVzZWQgZm9y
IGFueSBzb3VyY2UgZmlsZSANCmluIHRoZSBRRU1VIHRyZWUuDQpJIGd1ZXNzIHRoZSByYXRp
b25hbGUgaXMgdG8gcHJvdmlkZSBpbmNsdWRlIGRpcmVjdG9yeSBlaXRoZXIgZnJvbSByb290
IA0KdHJlZSwgb3IgZnJvbSBidWlsZCBkaXJlY3RvcnkgKGluIGNhc2UgYSBnZW5lcmF0ZWQg
c291cmNlIGRlcGVuZHMgb24gaXQ/KS4NCg0KSXQncyBoYXJtbGVzcyBpbmRlZWQsIGJlY2F1
c2UgYXMgeW91IG5vdGljZWQsIFFFTVUgbmV2ZXIgaGFkIGFueSBidWlsZCANCmZhaWx1cmUg
cmVsYXRlZCB0byB0aGlzIHNpbmNlIG1lc29uIHdhcyBpbnRyb2R1Y2VkLg0KDQo+PiArICAg
IGVuZGlmDQo+PiArICBlbmRmb3JlYWNoDQo+PiArZW5kaWYNCj4+ICtpZiB0Lmxlbmd0aCgp
ID4gMA0KPj4gKyAgYWxpYXNfdGFyZ2V0KCdjb250cmliLXBsdWdpbnMnLCB0KQ0KPj4gK2Vs
c2UNCj4+ICsgIHJ1bl90YXJnZXQoJ2NvbnRyaWItcGx1Z2lucycsIGNvbW1hbmQ6IGZpbmRf
cHJvZ3JhbSgndHJ1ZScpKQ0KPj4gK2VuZGlmDQo+IA0K

