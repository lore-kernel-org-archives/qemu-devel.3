Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB54C54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 03:34:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roxZa-0000TN-6m; Mon, 25 Mar 2024 23:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1roxZY-0000T7-H3
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 23:34:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1roxZW-0004QO-Gy
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 23:34:00 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-341cf28e013so953052f8f.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 20:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711424036; x=1712028836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aEdIS0OKTIyR7AJF2bGJ3I4eVeO1XJMqptu7oyUH6X8=;
 b=SbXlqwkvoCppg0VyC/8/urI1wVyduZqUpe0ZRc+ophUb39itFARGQauUjnuQ0wYfWD
 6GYFLy5tnI1jaEqDrIbd6sljXmaChuFSPHiEuP4XGpUMToUTWwo86Fksa8QK2wtOXBO4
 GtTRee1FeoKtwrQWBvxciE7zhC16JfICYAQNOm+QtfdV+PfsMV2gjFBY78R04DqoDYVp
 eRLEg8u2r+LumGwaisBfyXbPv2czn+66ClsWOqZzZzkTzD0XBYxwZBzBVvMmUD7lSook
 Lc5AQxyKpSBWpXXd+Y1CAz2fWUr3XW8CSlstPH2GQ6up9W/y8fcHU+yOYZMRbvcUaZJH
 CRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711424036; x=1712028836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aEdIS0OKTIyR7AJF2bGJ3I4eVeO1XJMqptu7oyUH6X8=;
 b=V5V35BeJ/jffSgzMKWIvfCn1SnhsTxqIWCYdlimQZDpRFLR8cTgmkpVRJUIDRVJYld
 5pmJ1/KeQ1+pw4kL0GYAhLhPe3naS4+BcFe0PZFs+d+ZM2sLTI1F10LCVF7o4C35WULG
 WTr+Vah4wZStcpbFWm5hBwHO7lxUtKxbeQIcVJYRbtBLmOIgcswprJMloxtUMQv2GpZk
 DRoeKLgusAk83YCGA7WkzT/TQTeIlQDjeP7J6DYMm4AVSIut/072j60HtpVQJDShdP3v
 ymSkQ89O2wFCV/TwlqCIowWqSSEPBm39IJcmuF+r9jgL9Ii3xgQS/oNWzmCUcftAz4Zm
 Ny4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJcW0cOYYzKmtzBlJ0+MtzxLczUBOwtxtfT1EV6e9dpKBrPQlPIe89siBd93PorsFxUwVi3lIkD+mz0T+K5etdZALpRyc=
X-Gm-Message-State: AOJu0YxfX/3g8kDrxaOH7DwB338Gb7Y8La+BmxFeWYXDB55nx/s/ZKbx
 z1uarAsvXdO8g6E7mBrLcqe8Y/Al81nZIBgVbKSHrl6Jl57Agpdx+fmcJXZn76A=
X-Google-Smtp-Source: AGHT+IEgpzSZez8FeHY/NLqqSzwb+wCAqqaB+mz6NBFR95+36mHf1UY6vHBbtapHPavv/5yyMBT7mw==
X-Received: by 2002:a05:6000:10f:b0:33e:d51d:4cf with SMTP id
 o15-20020a056000010f00b0033ed51d04cfmr6178951wrx.64.1711424036065; 
 Mon, 25 Mar 2024 20:33:56 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 bf10-20020a0560001cca00b0033ec81ec4aesm11045839wrb.78.2024.03.25.20.33.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 20:33:55 -0700 (PDT)
Message-ID: <9eb2194e-7efe-448a-a511-9d10e589943e@linaro.org>
Date: Tue, 26 Mar 2024 07:33:50 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] contrib/plugins/execlog: Fix compiler warning
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 peter.maydell@linaro.org
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240326015257.21516-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x433.google.com
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

T24gMy8yNi8yNCAwNTo1MiwgWWFvIFhpbmd0YW8gd3JvdGU6DQo+IDEuIFRoZSBnX3BhdHRl
cm5fbWF0Y2hfc3RyaW5nKCkgaXMgZGVwcmVjYXRlZCB3aGVuIGdsaWIyIHZlcnNpb24gPj0g
Mi43MC4NCj4gICAgIFVzZSBnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmcoKSBpbnN0ZWFk
IHRvIGF2b2lkIHRoaXMgcHJvYmxlbS4NCj4gDQo+IDIuIFRoZSB0eXBlIG9mIHNlY29uZCBw
YXJhbWV0ZXIgaW4gZ19wdHJfYXJyYXlfYWRkKCkgaXMNCj4gICAgICdncG9pbnRlcicge2Fr
YSAndm9pZCAqJ30sIGJ1dCB0aGUgdHlwZSBvZiByZWctPm5hbWUgaXMgJ2NvbnN0IGNoYXIq
Jy4NCj4gICAgIENhc3QgdGhlIHR5cGUgb2YgcmVnLT5uYW1lIHRvICdncG9pbnRlcicgdG8g
YXZvaWQgdGhpcyBwcm9ibGVtLg0KPiANCj4gY29tcGlsZXIgd2FybmluZyBtZXNzYWdlOg0K
PiAvcm9vdC9xZW11L2NvbnRyaWIvcGx1Z2lucy9leGVjbG9nLmM6MzMwOjE3OiB3YXJuaW5n
OiDigJhnX3BhdHRlcm5fbWF0Y2hfc3RyaW5n4oCZDQo+IGlzIGRlcHJlY2F0ZWQ6IFVzZSAn
Z19wYXR0ZXJuX3NwZWNfbWF0Y2hfc3RyaW5nJw0KPiBpbnN0ZWFkIFstV2RlcHJlY2F0ZWQt
ZGVjbGFyYXRpb25zXQ0KPiAgICAzMzAgfCAgICAgICAgICAgICAgICAgaWYgKGdfcGF0dGVy
bl9tYXRjaF9zdHJpbmcocGF0LCByZC0+bmFtZSkgfHwNCj4gICAgICAgIHwgICAgICAgICAg
ICAgICAgIF5+DQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0y
LjAvZ2xpYi5oOjY3LA0KPiAgICAgICAgICAgICAgICAgICBmcm9tIC9yb290L3FlbXUvY29u
dHJpYi9wbHVnaW5zL2V4ZWNsb2cuYzo5Og0KPiAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xp
Yi9ncGF0dGVybi5oOjU3OjE1OiBub3RlOiBkZWNsYXJlZCBoZXJlDQo+ICAgICA1NyB8IGdi
b29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVyblNwZWMgKnBz
cGVjLA0KPiAgICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gL3Jvb3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzMToyMTogd2Fybmlu
Zzog4oCYZ19wYXR0ZXJuX21hdGNoX3N0cmluZ+KAmQ0KPiBpcyBkZXByZWNhdGVkOiBVc2Ug
J2dfcGF0dGVybl9zcGVjX21hdGNoX3N0cmluZycNCj4gaW5zdGVhZCBbLVdkZXByZWNhdGVk
LWRlY2xhcmF0aW9uc10NCj4gICAgMzMxIHwgICAgICAgICAgICAgICAgICAgICBnX3BhdHRl
cm5fbWF0Y2hfc3RyaW5nKHBhdCwgcmRfbG93ZXIpKSB7DQo+ICAgICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiAvdXNyL2luY2x1ZGUvZ2xp
Yi0yLjAvZ2xpYi9ncGF0dGVybi5oOjU3OjE1OiBub3RlOiBkZWNsYXJlZCBoZXJlDQo+ICAg
ICA1NyB8IGdib29sZWFuICAgICAgZ19wYXR0ZXJuX21hdGNoX3N0cmluZyAgIChHUGF0dGVy
blNwZWMgKnBzcGVjLA0KPiAgICAgICAgfCAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+
fn5+fn5+fn4NCj4gL3Jvb3QvcWVtdS9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jOjMzOTo2
Mzogd2FybmluZzogcGFzc2luZyBhcmd1bWVudCAyIG9mDQo+IOKAmGdfcHRyX2FycmF5X2Fk
ZOKAmSBkaXNjYXJkcyDigJhjb25zdOKAmSBxdWFsaWZpZXIgZnJvbSBwb2ludGVyIHRhcmdl
dCB0eXBlDQo+IFstV2Rpc2NhcmRlZC1xdWFsaWZpZXJzXQ0KPiAgICAzMzkgfCAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZ19wdHJfYXJyYXlfYWRkKGFsbF9yZWdfbmFtZXMsIHJl
Zy0+bmFtZSk7DQo+ICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+Xn5+fn5+DQo+IEluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAvdXNyL2luY2x1ZGUvZ2xpYi0yLjAvZ2xpYi5oOjMzOg0KPiAvdXNyL2luY2x1
ZGUvZ2xpYi0yLjAvZ2xpYi9nYXJyYXkuaDoxOTg6NjI6IG5vdGU6IGV4cGVjdGVkDQo+IOKA
mGdwb2ludGVy4oCZIHtha2Eg4oCYdm9pZCAq4oCZfSBidXQgYXJndW1lbnQgaXMgb2YgdHlw
ZSDigJhjb25zdCBjaGFyICrigJkNCj4gICAgMTk4IHwgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdwb2ludGVyICAgICAgICAgIGRhdGEpOw0KPiAgICAg
ICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfn5+fn5+
fn5+fn5+fn5+fn5+Xn5+fg0KPiANCj4gUmVzb2x2ZXM6IGh0dHBzOi8vZ2l0bGFiLmNvbS9x
ZW11LXByb2plY3QvcWVtdS8tL2lzc3Vlcy8yMjEwDQo+IFNpZ25lZC1vZmYtYnk6IFlhbyBY
aW5ndGFvIDx5YW94dC5mbnN0QGZ1aml0c3UuY29tPg0KPiAtLS0NCj4gICBjb250cmliL3Bs
dWdpbnMvZXhlY2xvZy5jIHwgMjQgKysrKysrKysrKysrKysrKysrKysrLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYyBiL2NvbnRyaWIvcGx1Z2lu
cy9leGVjbG9nLmMNCj4gaW5kZXggYTFkZmQ1OWFiNy4uZmFiMTgxMTNkNCAxMDA2NDQNCj4g
LS0tIGEvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYw0KPiArKysgYi9jb250cmliL3BsdWdp
bnMvZXhlY2xvZy5jDQo+IEBAIC0zMTEsNiArMzExLDI0IEBAIHN0YXRpYyBSZWdpc3RlciAq
aW5pdF92Y3B1X3JlZ2lzdGVyKHFlbXVfcGx1Z2luX3JlZ19kZXNjcmlwdG9yICpkZXNjKQ0K
PiAgICAgICByZXR1cm4gcmVnOw0KPiAgIH0NCj4gICANCj4gKy8qDQo+ICsgKiBnX3BhdHRl
cm5fbWF0Y2hfc3RyaW5nIGhhcyBiZWVuIGRlcHJlY2F0ZWQgaW4gR2xpYiBzaW5jZSAyLjcw
IGFuZA0KPiArICogd2lsbCBjb21wbGFpbiBhYm91dCBpdCBpZiB5b3UgdHJ5IHRvIHVzZSBp
dC4gRm9ydHVuYXRlbHkgdGhlDQo+ICsgKiBzaWduYXR1cmUgb2YgYm90aCBmdW5jdGlvbnMg
aXMgdGhlIHNhbWUgbWFraW5nIGl0IGVhc3kgdG8gd29yaw0KPiArICogYXJvdW5kLg0KPiAr
ICovDQo+ICtzdGF0aWMgaW5saW5lDQo+ICtnYm9vbGVhbiBnX3BhdHRlcm5fc3BlY19tYXRj
aF9zdHJpbmdfcWVtdShHUGF0dGVyblNwZWMgKnBzcGVjLA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZ2NoYXIgKnN0cmluZykNCj4gK3sN
Cj4gKyNpZiBHTElCX0NIRUNLX1ZFUlNJT04oMiwgNzAsIDApDQo+ICsgICAgcmV0dXJuIGdf
cGF0dGVybl9zcGVjX21hdGNoX3N0cmluZyhwc3BlYywgc3RyaW5nKTsNCj4gKyNlbHNlDQo+
ICsgICAgcmV0dXJuIGdfcGF0dGVybl9tYXRjaF9zdHJpbmcocHNwZWMsIHN0cmluZyk7DQo+
ICsjZW5kaWYNCj4gK307DQo+ICsjZGVmaW5lIGdfcGF0dGVybl9zcGVjX21hdGNoX3N0cmlu
ZyhwLCBzKSBnX3BhdHRlcm5fc3BlY19tYXRjaF9zdHJpbmdfcWVtdShwLCBzKQ0KPiArDQo+
ICAgc3RhdGljIEdQdHJBcnJheSAqcmVnaXN0ZXJzX2luaXQoaW50IHZjcHVfaW5kZXgpDQo+
ICAgew0KPiAgICAgICBnX2F1dG9wdHIoR1B0ckFycmF5KSByZWdpc3RlcnMgPSBnX3B0cl9h
cnJheV9uZXcoKTsNCj4gQEAgLTMyNyw4ICszNDUsOCBAQCBzdGF0aWMgR1B0ckFycmF5ICpy
ZWdpc3RlcnNfaW5pdChpbnQgdmNwdV9pbmRleCkNCj4gICAgICAgICAgICAgICBmb3IgKGlu
dCBwID0gMDsgcCA8IHJtYXRjaGVzLT5sZW47IHArKykgew0KPiAgICAgICAgICAgICAgICAg
ICBnX2F1dG9wdHIoR1BhdHRlcm5TcGVjKSBwYXQgPSBnX3BhdHRlcm5fc3BlY19uZXcocm1h
dGNoZXMtPnBkYXRhW3BdKTsNCj4gICAgICAgICAgICAgICAgICAgZ19hdXRvZnJlZSBnY2hh
ciAqcmRfbG93ZXIgPSBnX3V0Zjhfc3RyZG93bihyZC0+bmFtZSwgLTEpOw0KPiAtICAgICAg
ICAgICAgICAgIGlmIChnX3BhdHRlcm5fbWF0Y2hfc3RyaW5nKHBhdCwgcmQtPm5hbWUpIHx8
DQo+IC0gICAgICAgICAgICAgICAgICAgIGdfcGF0dGVybl9tYXRjaF9zdHJpbmcocGF0LCBy
ZF9sb3dlcikpIHsNCj4gKyAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX3NwZWNfbWF0
Y2hfc3RyaW5nKHBhdCwgcmQtPm5hbWUpIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgIGdf
cGF0dGVybl9zcGVjX21hdGNoX3N0cmluZyhwYXQsIHJkX2xvd2VyKSkgew0KPiAgICAgICAg
ICAgICAgICAgICAgICAgUmVnaXN0ZXIgKnJlZyA9IGluaXRfdmNwdV9yZWdpc3RlcihyZCk7
DQo+ICAgICAgICAgICAgICAgICAgICAgICBnX3B0cl9hcnJheV9hZGQocmVnaXN0ZXJzLCBy
ZWcpOw0KPiAgIA0KPiBAQCAtMzM2LDcgKzM1NCw3IEBAIHN0YXRpYyBHUHRyQXJyYXkgKnJl
Z2lzdGVyc19pbml0KGludCB2Y3B1X2luZGV4KQ0KPiAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGRpc2FzX2Fzc2lzdCkgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfbXV0
ZXhfbG9jaygmYWRkX3JlZ19uYW1lX2xvY2spOw0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGlmICghZ19wdHJfYXJyYXlfZmluZChhbGxfcmVnX25hbWVzLCByZWctPm5hbWUsIE5V
TEwpKSB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgZ19wdHJfYXJyYXlfYWRk
KGFsbF9yZWdfbmFtZXMsIHJlZy0+bmFtZSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZ19wdHJfYXJyYXlfYWRkKGFsbF9yZWdfbmFtZXMsIChncG9pbnRlcilyZWctPm5h
bWUpOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICBnX211dGV4X3VubG9jaygmYWRkX3JlZ19uYW1lX2xvY2spOw0KPiAgICAg
ICAgICAgICAgICAgICAgICAgfQ0KDQpXb3VsZCBiZSBuaWNlIGlmIGl0J3Mgc3RpbGwgcG9z
c2libGUgdG8gbWVyZ2UgdGhpcyBpbiA5LjAgUGV0ZXIuDQoNClJldmlld2VkLWJ5OiBQaWVy
cmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=

