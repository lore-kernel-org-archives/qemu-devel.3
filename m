Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F169C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmoYN-00013I-5p; Wed, 20 Mar 2024 01:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmoYK-00012n-Q3
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:31:52 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmoYJ-00075q-3D
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:31:52 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-513e134f73aso4292912e87.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 22:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912709; x=1711517509; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M3mWmTXS5D5uPhcjHyxZCWqAGFpHoQ+txmd88f1RyyE=;
 b=iZNXsQ17vjo5WcZ8yP7ocjyaNWrJM1MwgjMen/CvsHiLWMUbvYA8sXMYVrBftNO1ED
 EonKdrTpWokMEV8Wp9WQQHCurmUG1NjqfrD2enV7u7onyLM82gBQruVJUepy2JF+0hb7
 w5a82Y2tUZ0s+qrDRW+QeFioJLGKFs+iCCybC8pHiHVoqIX5MZKQmBpIEJ9l+gOrpJ+P
 gBJi35W4AABDRG1hyvJ/iY7LEH4kR/Tk3sNOxtljGi/PShCgDiWxtkK8E1MfBy+dcVjv
 yrGJ5wzLaxntgWmyttV0xjNOwP46xjupfRR0E6NHkkGFr7h5z1FfS7q6neDwRpbUFxQj
 LO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912709; x=1711517509;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M3mWmTXS5D5uPhcjHyxZCWqAGFpHoQ+txmd88f1RyyE=;
 b=TpZzjN0Uh8I+1pMyGGrzk5KcrgcSeqEFWoJYnMAnJ64uBM56sHpG2QydzYip0Ejb8I
 AQfcS1l6B16pHlat8cjTLhVGZx6O1eaTBDAFMn5ifDpJFZ15tD9V7HnbfKmkUqgeFYVG
 1Zfop/6kHsR9pgcLO6wdiBkT9yKDMbo7sYxIRhKA8gjQ8uKGG3zLIb1jDzaK9kYLXBZ5
 zNoUbeprjvbdxDxWFgJfRDlxA5aQwDGXLT+1ogNDzoJupqHA89EMuPfFjID0DjI+yn25
 l/CoNBbxOQ+eaeLzw9X4e+HgwnWGAvq6VJIIjGCXJAMMDU1pBlSHFg6q50oAAdDzJcvB
 4m/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6Tnl00/fzbzD5+LRDOc2RiAMXYz0e21CbUcnyVd8lVRg3oa7XtqOjVxR7CXIIxnFGE5pDr2TPlAjF15DsCTwPxgq5OPQ=
X-Gm-Message-State: AOJu0YySwd1g0520yXSozBVAvr5G7Z5mjpy2ROwoQWVlapbu+suyPm3t
 zAYsChiEVvRM+dbWtlfkQEALavJtmAA5duCA4yMJPrHoOcDAhsCSmru5f1TQI0YO64Y7Ff4K98a
 Gvlg=
X-Google-Smtp-Source: AGHT+IEiLMbkRa3riETrUR7vEre3ZLHTgyG/ddRBx3FP/+ANUezy8In0c9VQSqTL5tty633Lk4F+pA==
X-Received: by 2002:ac2:442e:0:b0:513:db34:7caf with SMTP id
 w14-20020ac2442e000000b00513db347cafmr3313426lfl.17.1710912708942; 
 Tue, 19 Mar 2024 22:31:48 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 f14-20020a05600c4e8e00b0041413aefeb9sm956251wmq.48.2024.03.19.22.31.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:31:48 -0700 (PDT)
Message-ID: <7ee6a415-0991-4c91-9db2-3c21c2b51511@linaro.org>
Date: Wed, 20 Mar 2024 09:31:44 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/22] plugins: Move function pointer in qemu_plugin_dyn_cb
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-6-richard.henderson@linaro.org>
 <aeeb7f81-1e43-4a89-bec3-faf047e4d53a@linaro.org>
 <49273724-0c8c-49e0-b626-bd0bb10a2b47@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <49273724-0c8c-49e0-b626-bd0bb10a2b47@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-lf1-x12a.google.com
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

T24gMy8yMC8yNCAwMTozMCwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTkv
MjQgMDM6MTgsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE2LzI0IDA1OjU3
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBUaGUgb3V0LW9mLWxpbmUgZnVuY3Rp
b24gcG9pbnRlciBpcyBtdXR1YWxseSBleGNsdXNpdmUNCj4+PiB3aXRoIGlubGluZSBleHBh
bnNpb24sIHNvIG1vdmUgaXQgaW50byB0aGUgdW5pb24uDQo+Pj4gV3JhcCB0aGUgcG9pbnRl
ciBpbiBhIHN0cnVjdHVyZSBuYW1lZCAncmVndWxhcicgdG8gbWF0Y2gNCj4+PiBQTFVHSU5f
Q0JfUkVHVUxBUi4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgSGVuZGVyc29u
IDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPg0KPj4+IC0tLQ0KPj4+ICDCoCBpbmNs
dWRlL3FlbXUvcGx1Z2luLmjCoCB8IDQgKysrLQ0KPj4+ICDCoCBhY2NlbC90Y2cvcGx1Z2lu
LWdlbi5jIHwgNCArKy0tDQo+Pj4gIMKgIHBsdWdpbnMvY29yZS5jwqDCoMKgwqDCoMKgwqDC
oCB8IDggKysrKy0tLS0NCj4+PiAgwqAgMyBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDcgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9xZW11
L3BsdWdpbi5oIGIvaW5jbHVkZS9xZW11L3BsdWdpbi5oDQo+Pj4gaW5kZXggMTJhOTZjZWEy
YS4uMTQzMjYyZGNhOCAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL3FlbXUvcGx1Z2luLmgN
Cj4+PiArKysgYi9pbmNsdWRlL3FlbXUvcGx1Z2luLmgNCj4+PiBAQCAtODQsMTMgKzg0LDE1
IEBAIGVudW0gcGx1Z2luX2R5bl9jYl9zdWJ0eXBlIHsNCj4+PiAgwqDCoCAqIGluc3RhbmNl
IG9mIGEgY2FsbGJhY2sgdG8gYmUgY2FsbGVkIHVwb24gdGhlIGV4ZWN1dGlvbiBvZiBhIHBh
cnRpY3VsYXIgVEIuDQo+Pj4gIMKgwqAgKi8NCj4+PiAgwqAgc3RydWN0IHFlbXVfcGx1Z2lu
X2R5bl9jYiB7DQo+Pj4gLcKgwqDCoCB1bmlvbiBxZW11X3BsdWdpbl9jYl9zaWcgZjsNCj4+
PiAgwqDCoMKgwqDCoCB2b2lkICp1c2VycDsNCj4+PiAgwqDCoMKgwqDCoCBlbnVtIHBsdWdp
bl9keW5fY2Jfc3VidHlwZSB0eXBlOw0KPj4+ICDCoMKgwqDCoMKgIC8qIEBydyBhcHBsaWVz
IHRvIG1lbSBjYWxsYmFja3Mgb25seSAoYm90aCByZWd1bGFyIGFuZCBpbmxpbmUpICovDQo+
Pj4gIMKgwqDCoMKgwqAgZW51bSBxZW11X3BsdWdpbl9tZW1fcncgcnc7DQo+Pj4gIMKgwqDC
oMKgwqAgLyogZmllbGRzIHNwZWNpZmljIHRvIGVhY2ggZHluX2NiIHR5cGUgZ28gaGVyZSAq
Lw0KPj4+ICDCoMKgwqDCoMKgIHVuaW9uIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgc3RydWN0
IHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bmlvbiBxZW11X3BsdWdpbl9jYl9z
aWcgZjsNCj4+PiArwqDCoMKgwqDCoMKgwqAgfSByZWd1bGFyOw0KPj4+ICDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IHsNCj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWVt
dV9wbHVnaW5fdTY0IGVudHJ5Ow0KPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBl
bnVtIHFlbXVfcGx1Z2luX29wIG9wOw0KPj4NCj4+IFdoaWxlIHdlIGFyZSBjbGVhbmluZyB0
aGlzLCBtYXliZSB0aGlzIGNvdWxkIGJlIG9ubHkgYSB1bmlvbiAobW92aW5nIHJ3IGFuZCB1
c2VycCB0bw0KPj4gZmllbGRzKSwgYW5kIG9ubHkgdHlwZSArIHVuaW9uIHdvdWxkIGJlIHVz
ZWQuDQo+PiBFdmVuIGlmIHdlIGR1cGxpY2F0ZSB1c2VycCBpbiByZWd1bGFyLCBhbmQgbWVt
X2NiLCBpdCB3b3VsZCBiZSBtdWNoIG1vcmUgcmVhZGFibGUuDQo+PiBGb3IgaW5zdGFuY2Us
IHVzZXJwIGlzIG5ldmVyIHVzZWQgYnkgaW5saW5lIG9wZXJhdGlvbnMuDQo+IA0KPiBJIHdh
cyB3b25kZXJpbmcgYWJvdXQgdGhpcy4gIEJ1dCBJIHdhcyBhbHNvIHRoaW5raW5nIGFib3V0
IHlvdXIgZm9sbG93LW9uIHBhdGNoIHNldCB0byBhZGQNCj4gY29uZGl0aW9uYWwgY2FsbHM6
IGRvIHdlIHdhbnQgYSBtdWx0aXBsaWNpdHkgb2YgdW5pb24gbWVtYmVycywgb3Igd2lsbCB3
ZSB3YW50IHNlcGFyYXRlDQo+IGJpdHMgYW5kIHBpZWNlcyB0aGF0IGNhbiBiZSBzdHJ1bmcg
dG9nZXRoZXI/DQo+IA0KPiBFLmcuDQo+IA0KPiAgICAgICBUQ0dDb25kIGNvbmQ7ICAvKiBB
TFdBWVMsIG9yIGNvbXBhcmUgZW50cnkgdnMgaW1tLiAqLw0KPiANCj4gICAgICAgLyogUExV
R0lOX0NCX1JFR1VMQVJfQ09ORCBvciBQTFVHSU5fQ0JfSU5MSU5FXyogKi8NCj4gICAgICAg
cWVtdV9wbHVnaW5fdTY0IGVudHJ5Ow0KPiAgICAgICB1aW50NjRfdCBpbW07DQo+IA0KPiAg
ICAgICAvKiBQTFVHSU5fQ0JfUkVHVUxBUl8qICovDQo+ICAgICAgIHVuaW9uIHFlbXVfcGx1
Z2luX2NiX3NpZyBmOw0KPiAgICAgICB2b2lkICp1c2VycDsNCj4gDQo+IA0KDQpJbiBhbiBp
ZGVhbCB3b3JsZDoNCg0Kc3RydWN0IHJlZ3VsYXJfY2Igew0KICAgIC8vIGZ1bGwgZGF0YSBm
b3IgcmVndWxhciBjYg0KfTsNCg0Kc3RydWN0IGNvbmRpdGlvbmFsX2NiIHsNCiAgICAvLyBm
dWxsIGRhdGEgZm9yIGNvbmQgY2INCn07DQoNCnN0cnVjdCBpbmxpbmVfb3Agew0KICAgIC8v
IGZ1bGwgZGF0YSBmb3IgaW5saW5lIG9wDQp9Ow0KDQouLi4NCg0KYW5kDQoNCnN0cnVjdCBx
ZW11X3BsdWdpbl9keW5fY2Igew0KICAgIGVudW0gcGx1Z2luX2R5bl9jYl9zdWJ0eXBlIHR5
cGU7DQogICAgdW5pb24gew0KICAgICAgICBzdHJ1Y3QgcmVndWxhcl9jYiByZWd1bGFyOw0K
ICAgICAgICBzdHJ1Y3QgY29uZGl0aW9uYWxfY2IgY29uZGl0aW9uYWw7DQogICAgICAgIHN0
cnVjdCBpbmxpbmVfb3AgaW5saW5lOw0KICAgIH07DQp9Ow0KDQpJdCdzIHRoZSBzYW1lIGFz
IGRlc2NyaWJpbmcgdGhlIHN0cnVjdHMgZGlyZWN0bHkgaW5zaWRlIHVuaW9uLCBidXQgYXQg
DQpsZWFzdCB5b3UgY2FuIGR1cGxpY2F0ZSBmaWVsZHMgd2l0aG91dCB0aGlua2luZyB0b28g
bXVjaC4gSW4gdGVybXMgb2YgDQptZW1vcnkgbGF5b3V0IGl0IGRvZXMgbm90IGNoYW5nZSBh
bnl0aGluZywgdGhlIHVwcGVyIGJvdW5kIGlzIHN0aWxsIHRoZSANCmxhcmdlc3Qgc3RydWN0
LCB3aGV0aGVyIHlvdSBzaGFyZSBmaWVsZHMgb3Igbm90Lg0KDQpJbiBzaG9ydCwgYW4gYWxn
ZWJyYWljIGRhdGEgdHlwZS4gSG9wZSBpdCdzIG5vdCBhIGJhZCB3b3JkIGFyb3VuZCBoZXJl
IDopDQoNCj4gcn4NCg==

