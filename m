Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1CF3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 04:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seoul-0006Vt-65; Fri, 16 Aug 2024 00:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seouj-0006Ui-4x
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:50:13 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1seouh-0000gJ-Dq
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 00:50:12 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7163489149eso1249756a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 21:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723783809; x=1724388609; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h/P4Gtw3ZvzjHjGJBzmC8g73SgGMjx5hxkvHJ64h8Ug=;
 b=HZO/SW8hamt3sd+54q+PVfWkO42p8S4E1wX2oZ0ASuUvbMAM3xSN+TO68CXX/9T26g
 SWgLIgWxXhFUtb9mzFE4Pla1tsRmkhGZHzcLUHG1vKQ29ePKrT+ywFsOfimctDW2eSML
 ft0xk3sdamLe2AtTQSJEr7HtozVfpubW+07XcxxyhCHiyVr2FnOYIfm+pcJw8pFZBxaj
 g0d6QRMIDL9EubE0Z52taG5snCqLKobp/vqILwqTlKK9e46UEPAAapIg0iRVSfGz5mOh
 lXO3fdMPzvXsbCOhWZTx2S5BafJEyfRdrWKUCK1RdZsDDWNrFq4G8mR34QrrFxtvjHTt
 jtsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723783809; x=1724388609;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h/P4Gtw3ZvzjHjGJBzmC8g73SgGMjx5hxkvHJ64h8Ug=;
 b=gR1jnH9Ysurk5w/T98BFNeT4xxy4/mnf/Qg5JUY2GlKnU4ZrjagMqs8KR8pgp2rE0B
 vuKPGnJjORwqfnarNuTAogYcrgmWX1Ns2XG68bzrLjfT7aSeAQIHTA2hf3rrCHmMQtjY
 y5vpPptVLDl++3PmBANRz6TPZDHfNOemRszrj/LvHpzIHQClnCc8m84LRrzSGaefxy3c
 NyCCfkOboDkzwhp0WWVx1X8XpH9mGojcgxUBpspKJPSY2aRE0auNd5bmQfu6rSDYVkWj
 2gwKF7pU5k/TFkYxyWlWITka5+VlDmyfgHdS9dEpl7qB8XhgKqGGdk4ykWO7b4mddIay
 1RRA==
X-Gm-Message-State: AOJu0YzdwwiB3zrD7CjaSQURruJwvRyOacqGEx7wJBFHn1DfMIPwENrT
 SMuqMAo9p43lDEMgmQW/1TD68p8KMd9k3+0re0q3+EHfMOdcZmF6GlXkQ/0377s=
X-Google-Smtp-Source: AGHT+IFqH24yOp6Ng4xqSQHGsIOG3/kchLvTh+m9jrl2L0xl57nJLgk/wjDrXhsAVSx1coUvvEndGQ==
X-Received: by 2002:a05:6a20:e68d:b0:1c4:2132:e205 with SMTP id
 adf61e73a8af0-1c905053485mr2108274637.48.1723783808885; 
 Thu, 15 Aug 2024 21:50:08 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::b861? ([2604:3d08:9384:1d00::b861])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201f039e4b5sm17787925ad.246.2024.08.15.21.50.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Aug 2024 21:50:08 -0700 (PDT)
Message-ID: <d541e832-b594-4214-aca2-21af5dd8a331@linaro.org>
Date: Thu, 15 Aug 2024 21:50:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] contrib/plugins/hwprofile: fix warning when compiling
 on 32bits host
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240814233645.944327-1-pierrick.bouvier@linaro.org>
 <20240814233645.944327-4-pierrick.bouvier@linaro.org>
 <353d0b10-8a7a-4660-a22c-f3dcb35df89e@redhat.com>
 <87plqa2dsm.fsf@draig.linaro.org>
 <62b8e9a8-67cf-48df-9b5c-9bfcfb10e9fd@linaro.org>
Content-Language: en-US
In-Reply-To: <62b8e9a8-67cf-48df-9b5c-9bfcfb10e9fd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

T24gOC8xNS8yNCAxMDo0MCwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4gT24gOC8xNS8y
NCAwNTowMywgQWxleCBCZW5uw6llIHdyb3RlOg0KPj4gVGhvbWFzIEh1dGggPHRodXRoQHJl
ZGhhdC5jb20+IHdyaXRlczoNCj4+DQo+Pj4gT24gMTUvMDgvMjAyNCAwMS4zNiwgUGllcnJp
Y2sgQm91dmllciB3cm90ZToNCj4+Pj4gRm91bmQgb24gZGViaWFuIHN0YWJsZSAoaTM4Niku
DQo+Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9od3Byb2ZpbGUuYzogSW4gZnVuY3Rpb24gJ25l
d19sb2NhdGlvbic6DQo+Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9od3Byb2ZpbGUuYzoxNzI6
MzI6IGVycm9yOiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBz
aXplIFstV2Vycm9yPWludC10by1wb2ludGVyLWNhc3RdDQo+Pj4+ICAgICAgMTcyIHwgICAg
IGdfaGFzaF90YWJsZV9pbnNlcnQodGFibGUsIChncG9pbnRlcikgb2ZmX29yX3BjLCBsb2Mp
Ow0KPj4+PiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeDQo+
Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9od3Byb2ZpbGUuYzogSW4gZnVuY3Rpb24gJ3ZjcHVf
aGFkZHInOg0KPj4+PiAuLi9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmM6MjI3OjE5OiBl
cnJvcjogY2FzdCBmcm9tIHBvaW50ZXIgdG8gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6ZSBb
LVdlcnJvcj1wb2ludGVyLXRvLWludC1jYXN0XQ0KPj4+PiAgICAgIDIyNyB8ICAgICAgICAg
ICAgIG9mZiA9ICh1aW50NjRfdCkgdWRhdGE7DQo+Pj4+ICAgICAgICAgIHwgICAgICAgICAg
ICAgICAgICAgXg0KPj4+PiAuLi9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmM6MjMyOjYy
OiBlcnJvcjogY2FzdCB0byBwb2ludGVyIGZyb20gaW50ZWdlciBvZiBkaWZmZXJlbnQgc2l6
ZSBbLVdlcnJvcj1pbnQtdG8tcG9pbnRlci1jYXN0XQ0KPj4+PiAgICAgIDIzMiB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAoZ3BvaW50ZXIpIG9mZik7DQo+Pj4+ICAgICAgICAgIHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4NCj4+Pj4gLi4v
Y29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jOiBJbiBmdW5jdGlvbiAndmNwdV90Yl90cmFu
cyc6DQo+Pj4+IC4uL2NvbnRyaWIvcGx1Z2lucy9od3Byb2ZpbGUuYzoyNTA6MjY6IGVycm9y
OiBjYXN0IHRvIHBvaW50ZXIgZnJvbSBpbnRlZ2VyIG9mIGRpZmZlcmVudCBzaXplIFstV2Vy
cm9yPWludC10by1wb2ludGVyLWNhc3RdDQo+Pj4+ICAgICAgMjUwIHwgICAgICAgICBncG9p
bnRlciB1ZGF0YSA9IChncG9pbnRlcikgKHNvdXJjZSA/IHFlbXVfcGx1Z2luX2luc25fdmFk
ZHIoaW5zbikgOiAwKTsNCj4+Pj4gICAgICAgICAgfA0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo+Pj4+IC0t
LQ0KPj4+PiAgICAgY29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jIHwgOSArKysrKy0tLS0N
Cj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+Pj4+IGRpZmYgLS1naXQgYS9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmMNCj4+
Pj4gYi9jb250cmliL3BsdWdpbnMvaHdwcm9maWxlLmMNCj4+Pj4gaW5kZXggNzM5YWMwYzY2
YjUuLmVlOTRhNzRhZDk0IDEwMDY0NA0KPj4+PiAtLS0gYS9jb250cmliL3BsdWdpbnMvaHdw
cm9maWxlLmMNCj4+Pj4gKysrIGIvY29udHJpYi9wbHVnaW5zL2h3cHJvZmlsZS5jDQo+Pj4+
IEBAIC0xNjUsNyArMTY1LDcgQEAgc3RhdGljIERldmljZUNvdW50cyAqbmV3X2NvdW50KGNv
bnN0IGNoYXIgKm5hbWUsIHVpbnQ2NF90IGJhc2UpDQo+Pj4+ICAgICAgICAgcmV0dXJuIGNv
dW50Ow0KPj4+PiAgICAgfQ0KPj4+PiAgICAgLXN0YXRpYyBJT0xvY2F0aW9uQ291bnRzICpu
ZXdfbG9jYXRpb24oR0hhc2hUYWJsZSAqdGFibGUsIHVpbnQ2NF90DQo+Pj4+IG9mZl9vcl9w
YykNCj4+Pj4gK3N0YXRpYyBJT0xvY2F0aW9uQ291bnRzICpuZXdfbG9jYXRpb24oR0hhc2hU
YWJsZSAqdGFibGUsIHVpbnRwdHJfdCBvZmZfb3JfcGMpDQo+Pj4+ICAgICB7DQo+Pj4+ICAg
ICAgICAgSU9Mb2NhdGlvbkNvdW50cyAqbG9jID0gZ19uZXcwKElPTG9jYXRpb25Db3VudHMs
IDEpOw0KPj4+PiAgICAgICAgIGxvYy0+b2ZmX29yX3BjID0gb2ZmX29yX3BjOw0KPj4+PiBA
QCAtMjAxLDcgKzIwMSw3IEBAIHN0YXRpYyB2b2lkIHZjcHVfaGFkZHIodW5zaWduZWQgaW50
IGNwdV9pbmRleCwgcWVtdV9wbHVnaW5fbWVtaW5mb190IG1lbWluZm8sDQo+Pj4+ICAgICAg
ICAgICAgIHJldHVybjsNCj4+Pj4gICAgICAgICB9IGVsc2Ugew0KPj4+PiAgICAgICAgICAg
ICBjb25zdCBjaGFyICpuYW1lID0gcWVtdV9wbHVnaW5faHdhZGRyX2RldmljZV9uYW1lKGh3
YWRkcik7DQo+Pj4+IC0gICAgICAgIHVpbnQ2NF90IG9mZiA9IHFlbXVfcGx1Z2luX2h3YWRk
cl9waHlzX2FkZHIoaHdhZGRyKTsNCj4+Pj4gKyAgICAgICAgdWludHB0cl90IG9mZiA9IHFl
bXVfcGx1Z2luX2h3YWRkcl9waHlzX2FkZHIoaHdhZGRyKTsNCj4+Pg0KPj4+IHFlbXVfcGx1
Z2luX2h3YWRkcl9waHlzX2FkZHIoKSByZXR1cm5zIGFuIHVpbnQ2NF90LCBzbyB0aGlzIGxv
b2tzDQo+Pj4gd3JvbmcgdG8gbWUuDQo+Pg0KPj4gSXQgaXMuIEhvd2V2ZXIgaXQganVzdCBn
b2VzIHRvIHNob3cgeW91IHNob3VsZCBiZSBleHBlY3RpbmcgdG8NCj4+IGluc3RydW1lbnQg
NjQgYml0IGNvZGUgd2l0aCBhIDMyIGJpdCBob3N0IGJlY2F1c2UgeW91IGNhbid0IGRvIHBv
aW50ZXINCj4+IHN0dWZmaW5nIHRyaWNrcyBsaWtlIHRoaXMuDQo+Pg0KPj4gTWF5YmUgd2Ug
Y291bGQganVzdCBkaXNhYmxlIHBsdWdpbnMgb24gMzIgYml0IGhvc3RzPw0KPj4NCj4gDQo+
IE9ubHkgdHdvIHBsdWdpbnMgYXJlIGNvbmNlcm5lZCBieSB0aGlzIHByb2JsZW0sIGl0J3Mg
d29ydGggZml4aW5nIHRoZW0NCj4gY29ycmVjdGx5IChpLmUuIG5vdCB1c2UgNjQgYml0cyBk
YXRhIGRpcmVjdGx5IGFzIGEgcG9pbnRlciwgYnV0IGFsbG9jYXRlDQo+IG1lbW9yeSBhbmQg
cGFzcyBwb2ludGVyIGluc3RlYWQpLg0KPiANCg0KQWZ0ZXIgbG9va2luZyBtb3JlIGNsb3Nl
bHkgYXQgZXhpc3RpbmcgcGx1Z2lucywgdGhlIHByb2JsZW0gaXMgd2lkZXIgDQp0aGFuIGV4
cGVjdGVkIChhbmQgYnVpbGQgd2FybmluZ3MpLg0KVGhlIEdMaWIgbWFjcm8gKEdVSU5UX1RP
X1BPSU5URVIpIHNpbGVudGx5IHRyYW5zZm9ybSBhbiBpbnQ2NCB2YWx1ZSB0byBhIA0KcG9p
bnRlciwgaW5jbHVkaW5nIG9uIDMyIGJpdHMgcGxhdGZvcm0uIEl0IHBlcmZvcm1zIGEgZG91
YmxlIGNhc2UgDQoodW5zaWduZWQgbG9uZyAtPiBwb2ludGVyKS4NCg0KVGh1cywgZXZlbiBp
ZiB0aGVyZSBpcyBubyB3YXJuaW5nLCBzb21lIHBsdWdpbnMgYXJlIGJyb2tlbiBiZWNhdXNl
IG9mIA0KZGF0YSAoZWl0aGVyIGJlY2F1c2UgdGhleSBwYXNzIGRhdGEgaW4gY2FsbGJhY2ss
IG9yIHRoZXkgaGF2ZSBhbiBhZGRyZXNzIA0KYmFzZWQgaGFzaHRhYmxlKS4NCg0KSXQgY291
bGQgYmUgZml4YWJsZSwgYnV0IHRoZSB3aXNlciBzb2x1dGlvbiBpcyBwcm9iYWJseSB0byBk
aXNhYmxlIA0KcGx1Z2lucyBvbiAzMiBiaXRzIHBsYXRmb3JtLCBsaWtlIEFsZXggcHJvcG9z
ZWQuDQoNCj4+Pg0KPj4+ICAgIFRob21hcw0KPj4NCg==

