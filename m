Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13DAC25B7E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:30:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCoHX-0007pd-A1; Thu, 30 May 2024 18:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoHV-0007jd-MY
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:29:57 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCoHT-0000ih-Vs
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:29:57 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f62a628b4cso5723725ad.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717108194; x=1717712994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hkPBMHLeRBfVAiU/7B4tMOnwG8CBmmo53p2GWWLUMeI=;
 b=XRilJfls9Hpag6G+aImLE2XKd+kABQkGrqM/zjHkdDQWysJVxJ03qvL0gfd2GSYYwn
 V4F1L3WFHE0k+MtMU5cy9rpE4j7zds7WzoCe+9UYC/Ni2xZeq5fSbLpXseUvlGHXv5K7
 Lj4f/o2k3SPJC0jWiFUg5nM8VJPiNPjO3tIpn4578tbtL+fmkZ2ibEHBksyqmWn8odlW
 Y8T55+gDG21QhYop0QMJOwTPgDXoCy/x48BGOwfWdNMU6pKdU3D1t3CJ0MBfIPApwRyi
 /k7TPcm9eJRywS4AIPTR1FA/ciQvagsP/MuYbSrcnmHfYDyh7DxJGPae4dTUO2l2pL7Y
 Unew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717108194; x=1717712994;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hkPBMHLeRBfVAiU/7B4tMOnwG8CBmmo53p2GWWLUMeI=;
 b=a7yurbzTW7088JDUtlxw+BWMeRj61dG7OFnc1DtKW/J2eycbfz8/5FCrjE09rVdK9q
 AL3G6e/4Z3ERQKJOKSQpO3Hv68g6md9I/Y3OFUVm4jfR5kdftqR8qsEuXtknjj8bimmW
 I/APBRho/eGNqyzkZaDy8tIux7jTxOQU/GvyB2qGfYRREfi0N9rHI0hOMgE7k21z+DJ3
 uULmV47NkzrrjNfFsw+/5FQQGD6E+Ha/Wk2zaIOx+TwCGs/skryKzb2x8Gfvark6U0vC
 q8u4cuVDSe47RxgWbewMJtOQ2ZsRD/aVRSFiyCUYPhO6f1r1f83/PBgWm63tymxo8daE
 tQYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV826VnurTXJZfQdU9dA7yInWcOGOrS08Cns/DIPOe9xKq5yljkokn6EauxDeTqprHQ/Ssx3N+KpCLiMnXrd9KHBgRoWoU=
X-Gm-Message-State: AOJu0Yw+84M9/rPCCsX0Z/67Z6da3Hj84m2ERXuZqdU3JRh+EDGt3/BL
 mmr2Rg7gI09vcRCyfqqwyz9t1lzxCb1+NNLMfK0Fi3w1i5fy5cIRpP/qNMxNZzI=
X-Google-Smtp-Source: AGHT+IEodTSwSq7zDnxZmvSRW6Gv4nMGV6OiOIIM6I4rmnUi0AT7QlRC3L09LX+PevZ0d7jLLNFlNw==
X-Received: by 2002:a17:902:db08:b0:1f3:1200:ceb3 with SMTP id
 d9443c01a7336-1f6370a0d07mr2192985ad.51.1717108194193; 
 Thu, 30 May 2024 15:29:54 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323f6e98sm2734425ad.217.2024.05.30.15.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 May 2024 15:29:53 -0700 (PDT)
Message-ID: <c86136b9-aaaa-4216-bf95-38908af9d3eb@linaro.org>
Date: Thu, 30 May 2024 15:29:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] cpu-target: don't set cpu->thread_id to bogus value
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
 <20240530194250.1801701-4-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240530194250.1801701-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gNS8zMC8yNCAxMjo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBUaGUgdGhyZWFkX2lk
IGlzbid0IHZhbGlkIHVudGlsIHRoZSB0aHJlYWRzIGFyZSBjcmVhdGVkLiBUaGVyZSBpcyBu
bw0KPiBwb2ludCBzZXR0aW5nIGl0IGhlcmUuIFRoZSBvbmx5IHRoaW5nIHRoYXQgY2FyZXMg
YWJvdXQgdGhlIHRocmVhZF9pZA0KPiBpcyBxbXBfcXVlcnlfY3B1c19mYXN0Lg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0K
PiAtLS0NCj4gICBjcHUtdGFyZ2V0LmMgfCAxIC0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NwdS10YXJnZXQuYyBiL2NwdS10YXJn
ZXQuYw0KPiBpbmRleCA1YWYxMjBlOGFhLi40OTlmYWNmNzc0IDEwMDY0NA0KPiAtLS0gYS9j
cHUtdGFyZ2V0LmMNCj4gKysrIGIvY3B1LXRhcmdldC5jDQo+IEBAIC0yNDEsNyArMjQxLDYg
QEAgdm9pZCBjcHVfZXhlY19pbml0Zm4oQ1BVU3RhdGUgKmNwdSkNCj4gICAgICAgY3B1LT5u
dW1fYXNlcyA9IDA7DQo+ICAgDQo+ICAgI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZDQo+IC0g
ICAgY3B1LT50aHJlYWRfaWQgPSBxZW11X2dldF90aHJlYWRfaWQoKTsNCj4gICAgICAgY3B1
LT5tZW1vcnkgPSBnZXRfc3lzdGVtX21lbW9yeSgpOw0KPiAgICAgICBvYmplY3RfcmVmKE9C
SkVDVChjcHUtPm1lbW9yeSkpOw0KPiAgICNlbmRpZg0KDQpSZXZpZXdlZC1ieTogUGllcnJp
Y2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBsaW5hcm8ub3JnPg0K

