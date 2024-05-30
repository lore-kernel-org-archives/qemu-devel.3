Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101D1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCoHi-00088w-Uv; Thu, 30 May 2024 18:30:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoHg-0007w1-N9
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:30:08 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoHf-0000uu-42
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:30:08 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7021ab0d0f5so408626b3a.2
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717108206; x=1717713006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xzNt1QiEjKt0w1/4U9EbtaV5vV9cgC+eL3TRM5VCBzc=;
 b=Zwj+dgwJXlwYaMt2elzcv6xDfCAcZ6iPdWNp4DpIWNaVBPZgYcG0Eaj9WEI0Ol7i8B
 vD8awS27pLkrT90UO0dT04rRAoSxSHViauLlTzACupZu8QPj/XUerEaXeplOaea2IYJ/
 ZdzvwzkOBrgqnfa6bj+XmRmGrFZ0JwduWnT8gWrVp+lBSEvVNg7PbCGGJxtTe9sEbc0Y
 0WmglfIaLUDOWjX2AdH66a/3YP0lqd+v8FXeBRgiDzvQtRvz+5ZqF2DWCveHV5pQX5/F
 is+1AuxriwHhivuzAn1y+KvWODM4Q0pxM2o8tRjSLopPqx3xGuebnYChyhIMXvGmAjwi
 4Lrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717108206; x=1717713006;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xzNt1QiEjKt0w1/4U9EbtaV5vV9cgC+eL3TRM5VCBzc=;
 b=jGploSBPSquo/c23Mrd2FelHmsdXrumfEDI7YLFwEluUPepGCigKnQSFXJzLDp1XGv
 Kf2iNA+1/3F1tNruhCoFRzQWWtxk39A1VVkDbD8bPVp1TRgVl0iMKH3y3o86WQ7Sg9nB
 HKHgJf3mRwKxMIkwrHwrQ8KhJcZIxc6V1fGYOVZasnbRfyqS+8lQDQQIZQ24JeHOXeJt
 XPyhT/R278UEeUGwRvLaUgGIrBbQG7rEKRb6Nk/3a5my5J4E+O2HalGpQvu6gyRAg/W9
 ChvsYkl9vh937RoThk6FsDo64+3rdJrBwLxq/uoBMzgzo5qNUXWG4HpIyeugEo4YIzmC
 vFhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpFZJ7ibUh++931OoNTpjnplE0awYPzeSI/UBLTgrvYI8MA5hLB8xXFRfCQr0DK/aGiRboBYOn9P433h93R4DIPEuHexw=
X-Gm-Message-State: AOJu0Yz83M9yM9F79HGu9hOWWu9sNsYoEdsxgzqkdDTyQC/aREdABTG5
 uUQ56K4pJkT8mxHYWx2pGzLRon/KmAbP+FeKMVzSb42x1bhJiCTCFPg/CkJzpFU=
X-Google-Smtp-Source: AGHT+IGQq9UBMHIpPaBKjiysXskFrZdduyvYpJkfCU/fNn9CDd86YzAn3IseJJPYTCnL98rgDfS99A==
X-Received: by 2002:a05:6a20:914e:b0:1af:4ea2:5424 with SMTP id
 adf61e73a8af0-1b26f20d7e3mr341572637.33.1717108205820; 
 Thu, 30 May 2024 15:30:05 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b0518csm225153b3a.147.2024.05.30.15.30.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 15:30:05 -0700 (PDT)
Message-ID: <f1b8d2dc-c803-4c45-898e-ef39934bbd0e@linaro.org>
Date: Thu, 30 May 2024 15:30:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] plugins: remove special casing for cpu->realized
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Cameron Esfahani <dirty@apple.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Reinoud Zandijk
 <reinoud@netbsd.org>, kvm@vger.kernel.org,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20240530194250.1801701-1-alex.bennee@linaro.org>
 <20240530194250.1801701-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240530194250.1801701-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

T24gNS8zMC8yNCAxMjo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBOb3cgdGhlIGNvbmRp
dGlvbiB2YXJpYWJsZSBpcyBpbml0aWFsaXNlZCBlYXJseSBvbiB3ZSBkb24ndCBuZWVkIHRv
IGdvDQo+IHRocm91Z2ggaG9vcHMgdG8gYXZvaWQgY2FsbGluZyBhc3luY19ydW5fb25fY3B1
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPg0KPiAtLS0NCj4gICBwbHVnaW5zL2NvcmUuYyB8IDYgKy0tLS0tDQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL3BsdWdpbnMvY29yZS5jIGIvcGx1Z2lucy9jb3JlLmMNCj4gaW5kZXggMDcy
NmJjN2YyNS4uYmFkZWRlMjhjZiAxMDA2NDQNCj4gLS0tIGEvcGx1Z2lucy9jb3JlLmMNCj4g
KysrIGIvcGx1Z2lucy9jb3JlLmMNCj4gQEAgLTY1LDExICs2NSw3IEBAIHN0YXRpYyB2b2lk
IHBsdWdpbl9jcHVfdXBkYXRlX19sb2NrZWQoZ3BvaW50ZXIgaywgZ3BvaW50ZXIgdiwgZ3Bv
aW50ZXIgdWRhdGEpDQo+ICAgICAgIENQVVN0YXRlICpjcHUgPSBjb250YWluZXJfb2Yoaywg
Q1BVU3RhdGUsIGNwdV9pbmRleCk7DQo+ICAgICAgIHJ1bl9vbl9jcHVfZGF0YSBtYXNrID0g
UlVOX09OX0NQVV9IT1NUX1VMT05HKCpwbHVnaW4ubWFzayk7DQo+ICAgDQo+IC0gICAgaWYg
KERFVklDRShjcHUpLT5yZWFsaXplZCkgew0KPiAtICAgICAgICBhc3luY19ydW5fb25fY3B1
KGNwdSwgcGx1Z2luX2NwdV91cGRhdGVfX2FzeW5jLCBtYXNrKTsNCj4gLSAgICB9IGVsc2Ug
ew0KPiAtICAgICAgICBwbHVnaW5fY3B1X3VwZGF0ZV9fYXN5bmMoY3B1LCBtYXNrKTsNCj4g
LSAgICB9DQo+ICsgICAgYXN5bmNfcnVuX29uX2NwdShjcHUsIHBsdWdpbl9jcHVfdXBkYXRl
X19hc3luYywgbWFzayk7DQo+ICAgfQ0KPiAgIA0KPiAgIHZvaWQgcGx1Z2luX3VucmVnaXN0
ZXJfY2JfX2xvY2tlZChzdHJ1Y3QgcWVtdV9wbHVnaW5fY3R4ICpjdHgsDQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=


