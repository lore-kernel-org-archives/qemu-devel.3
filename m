Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE28EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 06:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roe1e-0002c4-Bn; Mon, 25 Mar 2024 02:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1roe1d-0002bw-27
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:41:41 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1roe1a-0002jV-Rz
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 02:41:40 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4148bc73069so154765e9.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 23:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711348896; x=1711953696; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=y8qJV2nR7SmGTQVs29aZqx+lGFqQrNRtgk28TM1Zyzw=;
 b=qdFYSwoDoxLYPlVfJt34hebfajFjPXh+R9NDkcW904/0k2YVyVulrutMgxE50udQMT
 aIgstAJWSSLtLWJO5PZ8EW9uOYSKKUtkTEPrmjC5Ex6Fq/BZdq7FrYYG8Yar/ZNYyhgv
 oqCBAKvbO/e1jeNHgJ7VarkJmxV2fCZb9d2VLNtMXFcq5wIbdVyQcM7aPBJCseqLpJ28
 tNrrhZ9+gox5CI4KLT3Yp8nbU74pA8gP491dKvykdVviBIBb61KvSoSirvCx1mDuo0oL
 cvmBAhuKGZf/mNsBlufYK3hG+AqxXni2jm68ING6WmgiTlPCoXLO6vw72WpNHDg++yQc
 YfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711348896; x=1711953696;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y8qJV2nR7SmGTQVs29aZqx+lGFqQrNRtgk28TM1Zyzw=;
 b=tQlQiOA+HUowdYiLw0B1DLZfUjBq5hu/5kRGrjO8gNmaay665q8ye7sXiP1snLwlSU
 h/1tE3qh41K10x8IHQWk2OfEj7B82JzlmrV0v0Jw1Cbj8td+RrKFH4M0YtpQ7ViGRXlJ
 E9dlN5/eWq/W3chv2Hi5fS+D32lCcTbNpMtCJFeVHrTzWpoxGf8/qnP7xTpz0zf1NO3X
 YVf+9mfnnqsObd7W+KyYrhLNruSFrXC+ZgODsSNiVd8qvK7iddaN3HkZP+/5P0nPFtCh
 c+eUDfXEr5E5LGtbQbcor1dC7wE8AvxYkcOSiNTAw3O8d6/0NERUhbN6yih6EEV4T9L2
 Q4eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW17ghJLgcMWTSRHAquvmAby03h4H8wx/b0ftlczCEBhFwA0cDUS3/Yc6br/1NH1UYdvhPItHWfGVIVRS5DdVmHcqyJRyA=
X-Gm-Message-State: AOJu0Yyt1xYnQtIDDwltPDsJ5rTWdBbGqpTr8JOwbPJ44aG1EQJS8tNK
 JLMZIeuHeFOuxkVvtnhWPn1B/9v2HHbfN9m4I516C4ZxF8cD+zParj4T2p/+ouo=
X-Google-Smtp-Source: AGHT+IHD1krMueXqogm5wOGZVv4chXPFz00AUG3+fbiggvtASkVwJ5OSP4lSM8a7xuKbtqqvc7YBDw==
X-Received: by 2002:a05:600c:35d2:b0:413:f3c4:4d95 with SMTP id
 r18-20020a05600c35d200b00413f3c44d95mr5520515wmq.10.1711348895987; 
 Sun, 24 Mar 2024 23:41:35 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 r13-20020a05600c458d00b004148b9272a7sm264946wmo.0.2024.03.24.23.41.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 23:41:35 -0700 (PDT)
Message-ID: <3afbc002-1077-4bcd-a4e2-582b0c7de88c@linaro.org>
Date: Mon, 25 Mar 2024 10:41:31 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] contrib/plugins/execlog: Fix compiler warning
Content-Language: en-US
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, erdnaxe@crans.org, ma.mandourr@gmail.com,
 peter.maydell@linaro.org
References: <20240320020115.18801-1-yaoxt.fnst@fujitsu.com>
 <20240325060657.3934-1-yaoxt.fnst@fujitsu.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240325060657.3934-1-yaoxt.fnst@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
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

T24gMy8yNS8yNCAxMDowNiwgWWFvIFhpbmd0YW8gd3JvdGU6DQo+IDEuIFRoZSBnX3BhdHRl
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
dWdpbnMvZXhlY2xvZy5jIHwgNyArKysrKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIv
cGx1Z2lucy9leGVjbG9nLmMgYi9jb250cmliL3BsdWdpbnMvZXhlY2xvZy5jDQo+IGluZGV4
IGExZGZkNTlhYjcuLjA5NjU0OTEwZWUgMTAwNjQ0DQo+IC0tLSBhL2NvbnRyaWIvcGx1Z2lu
cy9leGVjbG9nLmMNCj4gKysrIGIvY29udHJpYi9wbHVnaW5zL2V4ZWNsb2cuYw0KPiBAQCAt
MzI3LDggKzMyNywxMyBAQCBzdGF0aWMgR1B0ckFycmF5ICpyZWdpc3RlcnNfaW5pdChpbnQg
dmNwdV9pbmRleCkNCj4gICAgICAgICAgICAgICBmb3IgKGludCBwID0gMDsgcCA8IHJtYXRj
aGVzLT5sZW47IHArKykgew0KPiAgICAgICAgICAgICAgICAgICBnX2F1dG9wdHIoR1BhdHRl
cm5TcGVjKSBwYXQgPSBnX3BhdHRlcm5fc3BlY19uZXcocm1hdGNoZXMtPnBkYXRhW3BdKTsN
Cj4gICAgICAgICAgICAgICAgICAgZ19hdXRvZnJlZSBnY2hhciAqcmRfbG93ZXIgPSBnX3V0
Zjhfc3RyZG93bihyZC0+bmFtZSwgLTEpOw0KPiArI2lmIEdMSUJfQ0hFQ0tfVkVSU0lPTigy
LCA3MCwgMCkNCj4gKyAgICAgICAgICAgICAgICBpZiAoZ19wYXR0ZXJuX3NwZWNfbWF0Y2hf
c3RyaW5nKHBhdCwgcmQtPm5hbWUpIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgIGdfcGF0
dGVybl9zcGVjX21hdGNoX3N0cmluZyhwYXQsIHJkX2xvd2VyKSkgew0KPiArI2Vsc2UNCj4g
ICAgICAgICAgICAgICAgICAgaWYgKGdfcGF0dGVybl9tYXRjaF9zdHJpbmcocGF0LCByZC0+
bmFtZSkgfHwNCj4gICAgICAgICAgICAgICAgICAgICAgIGdfcGF0dGVybl9tYXRjaF9zdHJp
bmcocGF0LCByZF9sb3dlcikpIHsNCj4gKyNlbmRpZg0KPiAgICAgICAgICAgICAgICAgICAg
ICAgUmVnaXN0ZXIgKnJlZyA9IGluaXRfdmNwdV9yZWdpc3RlcihyZCk7DQo+ICAgICAgICAg
ICAgICAgICAgICAgICBnX3B0cl9hcnJheV9hZGQocmVnaXN0ZXJzLCByZWcpOw0KPiAgIA0K
DQpBcyBzdWdnZXN0ZWQgYnkgUGV0ZXIgb24gcHJldmlvdXMgdmVyc2lvbiwgeW91IGNhbiBk
ZWNsYXJlIGEgbmV3IA0KZnVuY3Rpb24gYGdfcGF0dGVybl9tYXRjaF9zdHJpbmdfcWVtdWAg
aW4gaW5jbHVkZS9nbGliLWNvbXBhdC5oIHdoaWNoIA0KYWJzdHJhY3QgdGhpcy4NCllvdSds
bCBuZWVkIHRvIGFkZCBpbmNsdWRlLyB0byBNYWtlZmlsZSBhcyB3ZWxsLCBzbyBnbGliLWNv
bXBhdC5oIHdpbGwgDQpiZSBhY2Nlc3NpYmxlIHRvIGNvbnRyaWIgcGx1Z2lucyB0b28uDQoN
Cj4gQEAgLTMzNiw3ICszNDEsNyBAQCBzdGF0aWMgR1B0ckFycmF5ICpyZWdpc3RlcnNfaW5p
dChpbnQgdmNwdV9pbmRleCkNCj4gICAgICAgICAgICAgICAgICAgICAgIGlmIChkaXNhc19h
c3Npc3QpIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBnX211dGV4X2xvY2soJmFk
ZF9yZWdfbmFtZV9sb2NrKTsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICBpZiAoIWdf
cHRyX2FycmF5X2ZpbmQoYWxsX3JlZ19uYW1lcywgcmVnLT5uYW1lLCBOVUxMKSkgew0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfcHRyX2FycmF5X2FkZChhbGxfcmVnX25h
bWVzLCByZWctPm5hbWUpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdfcHRy
X2FycmF5X2FkZChhbGxfcmVnX25hbWVzLCAoZ3BvaW50ZXIpcmVnLT5uYW1lKTsNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
Z19tdXRleF91bmxvY2soJmFkZF9yZWdfbmFtZV9sb2NrKTsNCj4gICAgICAgICAgICAgICAg
ICAgICAgIH0NCg==

