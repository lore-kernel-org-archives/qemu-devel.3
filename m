Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A814C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ridbB-0005de-QG; Fri, 08 Mar 2024 12:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ridb7-0005WH-Jr
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:01:31 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ridb5-0000VB-PV
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:01:29 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e66e8fcc2dso696528b3a.3
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709917286; x=1710522086; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WxOybcM2F4fKRXlQZqwFzYrl9MTV4DucrhrBkzOmzg4=;
 b=wvPlmVpf5ElruY4jKr9Dwa6dWIHyaay+e6odT3eBr0cYfMYT+apBctJDD1ZZV/yumh
 MYkB6sMtA0RHIudQGTcmhrQgyyMjl2mThySNMM9gLCtZWCbNNY9QeMM8BpFMSk5DEnwj
 q7loBEgV6dTTVsIWLCA+VjpMFvN0uNuPxLO+CZsYY4GZuRu6RDxYxApwG4ATAvc+bPdM
 muYQKpLdsgqDjhDo8zPSfiYYzAXdez7cAkJEb7O3xKrydZn919RoG9A/+BACrNZtifxN
 QyCT9bJE0PIOBEr8vYMQklOL2yrQcb0P7ZDrp/rbWK7OPAy84CE857T64j9uygJl0ehs
 HX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709917286; x=1710522086;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxOybcM2F4fKRXlQZqwFzYrl9MTV4DucrhrBkzOmzg4=;
 b=K2SC1cJHcPU8BKflVDe1eRupxnAZER/lRl/Ct1Uib5isCO/n60bXI1zTABVQ4etlwa
 QMKccR9TmbByCnVAMddrwiLGWeE03oErkCuXMiHy+FlvAikhcXD3dsX1bNhi2fSfhjun
 NJUtuDaxI9IB5qwAnECoGt0rGFXTnPJb5ga29TIsKb102FgppaShIzeXpGJ2PDGLpA0J
 Adano3xCT94W8YEni7kS8h7wv2b3i3lamMqybj4HpI1zBiWolnNeYlN21f86887Xt4ta
 kEP7sVT25BDMdUq64fqhsUr123t6E0iuVhQEzsGkbT+6TAP/1UbJL2Ng48SAIJWJE1mp
 CJ2g==
X-Gm-Message-State: AOJu0Yy+JOuNLZeE+LOWUBfpMmvLLL1lM3O6weIIJlTOLol3rCaRq3ZL
 5bZLM8FuguPN6zov4B2fFEjVuGEDMy+XEtHGYwgM/+LAOnblImZKHwPoSDdmVK/DcXszijBpKJH
 d
X-Google-Smtp-Source: AGHT+IFMLGPl/cd3pckMFnV/N/z/An6KIxg/ITCtL8w5KsOBJVIIYmRh6GJ8OnughLs0DVEYSJuqJw==
X-Received: by 2002:a05:6a21:196:b0:1a1:4cd2:40a4 with SMTP id
 le22-20020a056a21019600b001a14cd240a4mr13312082pzb.6.1709917285877; 
 Fri, 08 Mar 2024 09:01:25 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:7e8e:216c:3f1a:12a4:d415?
 ([2804:7f0:b401:7e8e:216c:3f1a:12a4:d415])
 by smtp.gmail.com with ESMTPSA id
 j17-20020aa78d11000000b006e6454afe10sm5782402pfe.205.2024.03.08.09.01.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 09:01:25 -0800 (PST)
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
 <87y1atu0y8.fsf@draig.linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <9fea440d-f0c5-0a7c-a60e-b75e4dcf73c3@linaro.org>
Date: Fri, 8 Mar 2024 14:01:21 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87y1atu0y8.fsf@draig.linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.994,
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

SGkgQWxleCwNCg0KT24gMy83LzI0IDc6MzMgUE0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4g
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+IHdyaXRl
czoNCj4gDQo+PiBPbiAzLzcvMjQgMDg6MjYsIEd1c3Rhdm8gUm9tZXJvIHdyb3RlOg0KPj4+
IFNhdmUgdGFyZ2V0J3Mgc2lnaW5mbyBpbnRvIGdkYnNlcnZlcl9zdGF0ZSBzbyBpdCBjYW4g
YmUgdXNlZCBsYXRlciwgZm9yDQo+Pj4gZXhhbXBsZSwgaW4gYW55IHN0dWIgdGhhdCByZXF1
aXJlcyB0aGUgdGFyZ2V0J3Mgc2lfc2lnbm8gYW5kIHNpX2NvZGUuDQo+Pj4gVGhpcyBjaGFu
Z2UgYWZmZWN0cyBvbmx5IGxpbnV4LXVzZXIgbW9kZS4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBH
dXN0YXZvIFJvbWVybyA8Z3VzdGF2by5yb21lcm9AbGluYXJvLm9yZz4NCj4+PiBTdWdnZXN0
ZWQtYnk6IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3Jn
Pg0KPj4+IC0tLQ0KPj4+ICAgIGdkYnN0dWIvaW50ZXJuYWxzLmggICAgfCAgMyArKysNCj4+
PiAgICBnZGJzdHViL3VzZXItdGFyZ2V0LmMgIHwgIDMgKystDQo+Pj4gICAgZ2Ric3R1Yi91
c2VyLmMgICAgICAgICB8IDE0ICsrKysrKysrKystLS0tDQo+Pj4gICAgaW5jbHVkZS9nZGJz
dHViL3VzZXIuaCB8ICA2ICsrKysrLQ0KPj4+ICAgIGxpbnV4LXVzZXIvbWFpbi5jICAgICAg
fCAgMiArLQ0KPj4+ICAgIGxpbnV4LXVzZXIvc2lnbmFsLmMgICAgfCAgNSArKysrLQ0KPj4+
ICAgIDYgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4+PiBkaWZmIC0tZ2l0IGEvZ2Ric3R1Yi9pbnRlcm5hbHMuaCBiL2dkYnN0dWIvaW50ZXJu
YWxzLmgNCj4+PiBpbmRleCA1NmI3YzEzYjc1Li5hN2NjNjlkYWIzIDEwMDY0NA0KPj4+IC0t
LSBhL2dkYnN0dWIvaW50ZXJuYWxzLmgNCj4+PiArKysgYi9nZGJzdHViL2ludGVybmFscy5o
DQo+Pj4gQEAgLTU4LDYgKzU4LDkgQEAgdHlwZWRlZiBzdHJ1Y3QgR0RCU3RhdGUgew0KPj4+
ICAgICAgICBpbnQgbGluZV9jc3VtOyAvKiBjaGVja3N1bSBhdCB0aGUgZW5kIG9mIHRoZSBw
YWNrZXQgKi8NCj4+PiAgICAgICAgR0J5dGVBcnJheSAqbGFzdF9wYWNrZXQ7DQo+Pj4gICAg
ICAgIGludCBzaWduYWw7DQo+Pj4gKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+Pj4gKyAg
ICB1aW50OF90IHNpZ2luZm9bTUFYX1NJR0lORk9fTEVOR1RIXTsNCj4+PiArI2VuZGlmDQo+
Pg0KPj4gSWYgd2UgdGhpcyBpbiBHREJVc2VyU3RhdGUgaW4gdXNlci5jIC0tIG5vIG5lZWQg
Zm9yIGlmZGVmcyB0aGVuLg0KPiANCj4gQWx0aG91Z2ggaXQgZG9lcyBicmVhayBvbiBGcmVl
QlNEJ3MgdXNlciB0YXJnZXQ6DQo+IA0KPiAgICBGQUlMRUQ6IGxpYnFlbXUtYXJtLWJzZC11
c2VyLmZhLnAvZ2Ric3R1Yl91c2VyLXRhcmdldC5jLm8NCj4gICAgY2MgLW02NCAtbWN4MTYg
LUlsaWJxZW11LWFybS1ic2QtdXNlci5mYS5wIC1JLiAtSS4uIC1JdGFyZ2V0L2FybSAtSS4u
L3RhcmdldC9hcm0gLUkuLi9jb21tb24tdXNlci9ob3N0L3g4Nl82NCAtSS4uL2JzZC11c2Vy
L2luY2x1ZGUgLUlic2QtdXNlci9mcmVlYnNkIC1JLi4vYnNkLXVzZXIvZnJlZWJzZCAtSS4u
L2JzZC11c2VyL2hvc3QveDg2XzY0IC1JYnNkLXVzZXIgLUkuLi9ic2QtdXNlciAtSS4uL2Jz
ZC11c2VyL2FybSAtSXFhcGkgLUl0cmFjZSAtSXVpIC1JdWkvc2hhZGVyIC1JL3Vzci9sb2Nh
bC9pbmNsdWRlL2NhcHN0b25lIC1JL3Vzci9sb2NhbC9pbmNsdWRlL2dsaWItMi4wIC1JL3Vz
ci9sb2NhbC9saWIvZ2xpYi0yLjAvaW5jbHVkZSAtSS91c3IvbG9jYWwvaW5jbHVkZSAtZmRp
YWdub3N0aWNzLWNvbG9yPWF1dG8gLVdhbGwgLVdpbnZhbGlkLXBjaCAtV2Vycm9yIC1zdGQ9
Z251MTEgLU8yIC1nIC1mc3RhY2stcHJvdGVjdG9yLXN0cm9uZyAtV2VtcHR5LWJvZHkgLVdl
bmRpZi1sYWJlbHMgLVdleHBhbnNpb24tdG8tZGVmaW5lZCAtV2Zvcm1hdC1zZWN1cml0eSAt
V2Zvcm1hdC15MmsgLVdpZ25vcmVkLXF1YWxpZmllcnMgLVdpbml0LXNlbGYgLVdtaXNzaW5n
LWZvcm1hdC1hdHRyaWJ1dGUgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVduZXN0ZWQtZXh0ZXJu
cyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XcmVkdW5kYW50LWRlY2xzIC1Xc3RyaWN0LXBy
b3RvdHlwZXMgLVd0eXBlLWxpbWl0cyAtV3VuZGVmIC1XdmxhIC1Xd3JpdGUtc3RyaW5ncyAt
V25vLWdudS12YXJpYWJsZS1zaXplZC10eXBlLW5vdC1hdC1lbmQgLVduby1pbml0aWFsaXpl
ci1vdmVycmlkZXMgLVduby1taXNzaW5nLWluY2x1ZGUtZGlycyAtV25vLXBzYWJpIC1Xbm8t
c2hpZnQtbmVnYXRpdmUtdmFsdWUgLVduby1zdHJpbmctcGx1cy1pbnQgLVduby10YXV0b2xv
Z2ljYWwtdHlwZS1saW1pdC1jb21wYXJlIC1Xbm8tdHlwZWRlZi1yZWRlZmluaXRpb24gLVd0
aHJlYWQtc2FmZXR5IC1pcXVvdGUgLiAtaXF1b3RlIC90bXAvY2lycnVzLWNpLWJ1aWxkIC1p
cXVvdGUgL3RtcC9jaXJydXMtY2ktYnVpbGQvaW5jbHVkZSAtaXF1b3RlIC90bXAvY2lycnVz
LWNpLWJ1aWxkL2hvc3QvaW5jbHVkZS94ODZfNjQgLWlxdW90ZSAvdG1wL2NpcnJ1cy1jaS1i
dWlsZC9ob3N0L2luY2x1ZGUvZ2VuZXJpYyAtaXF1b3RlIC90bXAvY2lycnVzLWNpLWJ1aWxk
L3RjZy9pMzg2IC1wdGhyZWFkIC1EX0dOVV9TT1VSQ0UgLURfRklMRV9PRkZTRVRfQklUUz02
NCAtRF9MQVJHRUZJTEVfU09VUkNFIC1mbm8tc3RyaWN0LWFsaWFzaW5nIC1mbm8tY29tbW9u
IC1md3JhcHYgLWZ0cml2aWFsLWF1dG8tdmFyLWluaXQ9emVybyAtZlBJRSAtRE5FRURfQ1BV
X0ggJy1EQ09ORklHX1RBUkdFVD0iYXJtLWJzZC11c2VyLWNvbmZpZy10YXJnZXQuaCInICct
RENPTkZJR19ERVZJQ0VTPSJhcm0tYnNkLXVzZXItY29uZmlnLWRldmljZXMuaCInIC1NRCAt
TVEgbGlicWVtdS1hcm0tYnNkLXVzZXIuZmEucC9nZGJzdHViX3VzZXItdGFyZ2V0LmMubyAt
TUYgbGlicWVtdS1hcm0tYnNkLXVzZXIuZmEucC9nZGJzdHViX3VzZXItdGFyZ2V0LmMuby5k
IC1vIGxpYnFlbXUtYXJtLWJzZC11c2VyLmZhLnAvZ2Ric3R1Yl91c2VyLXRhcmdldC5jLm8g
LWMgLi4vZ2Ric3R1Yi91c2VyLXRhcmdldC5jDQo+ICAgIEluIGZpbGUgaW5jbHVkZWQgZnJv
bSAuLi9nZGJzdHViL3VzZXItdGFyZ2V0LmM6MTg6DQo+ICAgIC4uL2dkYnN0dWIvaW50ZXJu
YWxzLmg6NjI6MjE6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJlZCBpZGVudGlmaWVyICdNQVhf
U0lHSU5GT19MRU5HVEgnDQo+ICAgICAgIDYyIHwgICAgIHVpbnQ4X3Qgc2lnaW5mb1tNQVhf
U0lHSU5GT19MRU5HVEhdOw0KPiAgICAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgXg0K
PiAgICAxIGVycm9yIGdlbmVyYXRlZC4NCj4gICAgWzIwODQvNjczMV0gQ29tcGlsaW5nIEMg
b2JqZWN0IGxpYnFlbXUtYXJtDQo+IA0KPiBTZWU6IGh0dHBzOi8vZ2l0bGFiLmNvbS9zdHNx
dWFkL3FlbXUvLS9qb2JzLzYzNDU4Mjk0MTkNCg0KYXJnaCwgSSd2ZSB0ZXN0ZWQgYWxsIHRh
cmdldHMgZm9yIGxpbnV4LXVzZXIsIGJ1dCBtaXNzZWQgYnNkLXVzZXIuIEkndmUgdHJpZWQN
Cm9uY2UgdG8gYnVpbGQgaXQgYnV0IHRoYXQgcmVxdWlyZXMgYSBCU0QtbGlrZSBob3N0LCB3
aGljaCBJIGRvbid0IGhhdmUgYXQgdGhlDQptb21lbnQsIHRoZW4gSSBmb3Jnb3QgYWJvdXQg
aXQuLi4gTGV0IG1lIHNldHVwIG9uZSBhbmQgcmV2aWV3IHRoZSBjaGFuZ2UgaW4NCnRoZSBs
aWdodCBvZiB0aGUgY29tbWVudHMgZnJvbSB5b3UgYW5kIFJpY2hhcmQuDQoNClRoYW5rcyEN
Cg0KDQpDaGVlcnMsDQpHdXN0YXZvDQo=

