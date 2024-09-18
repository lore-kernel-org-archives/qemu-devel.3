Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E614CDD54F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 18:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqzle-0007Jx-Lv; Wed, 18 Sep 2024 14:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzlc-0007H4-3B
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:51:09 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sqzlY-0003uB-6T
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 14:51:06 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2d87f34a650so28423a91.1
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 11:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726685462; x=1727290262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IRSNPrVRWiLE20ISQj2EUMXLlGNKrC0bmUUMes5EDYo=;
 b=Znie7AoGQXvJdRl7HcO+5zPQRPHnmJGRIM82cpGkW2h/xkJKdesUNz+g/Lh3L/eB8z
 GHyUQ6lMEm1/f6AktD/xagRvOlXRmBuJ93zXZbsFOJPzr3Si/cnvMct4BjqflRlEXyw9
 NmwqwKUYZZfmbxPC6x+e+whvQp+4dnS2OztOuwp3CXUwnVpDkgj9SbIGB7emKOr+NyUK
 GWjkY4hh1hsJWy6Fdo13XhRZ5PlsQoJY97GZpc4pOD575XEMUw31MFcqGUz/6JXjgsYI
 rL20i8ebkCAqFd0FnkXTZczXsGl3kwcdel9fP9WnGnxqzCn6ddmIkQ1u8ZkcZISFFgjC
 saqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726685462; x=1727290262;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IRSNPrVRWiLE20ISQj2EUMXLlGNKrC0bmUUMes5EDYo=;
 b=EHSoHMjlAoIPwzXV0TrNWrSkHAnDcqjyxTB9AKHZ1VF5puwTYLfoQe4UmcIgbV/Ak3
 GWJ7oyux7UIMBcZ9mVo3fL1nBPkbwYhuY4aLHKPpTkYsxptSMJkKZMA1Z2Tgd3vwCT5c
 CB7xDSAGhjmzy0HYvIEzNUt/i0Jn3/WhskQ1XnHPjBLPU/MKP9NWIWeoJNHBNEIjID9u
 YaDLef472+hjGVI1pNtVWEGimLIgxCp8eOpk4+J5JA8LblmqvfPWHOqCO18+iKSyMdqv
 PewaFD+pzPS3l03lV+7ecHT8Ip+TeVuR9YFa19Pm1sy5JDO7/BXKOrJZGUATX3le+7Ko
 llBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmSZ/fc4B4jcqm75Mlzk4sXc2Xl+zWOcU43cBTYJqhi+Leh4W025gmIrdgjDOEJ/QgM5N8mszpRysJ@nongnu.org
X-Gm-Message-State: AOJu0YwEeM+oL776jzrLxF/Pnd3/kldjfz0NCR14Sb8xmIBjaPrbbFMq
 liGWiCURBaQaL4OK1AugNZcXZNrLqNIuzPXDjSeTv2lezg0gmjAasLp0gBNiXTg=
X-Google-Smtp-Source: AGHT+IGZFd1MmG23/OKP5PW29XIyrr6hpuqlU30QAsBq2Md+5cm7TfC57LClVFH4quoELhM1MnBoug==
X-Received: by 2002:a17:90b:1c81:b0:2c9:7343:71f1 with SMTP id
 98e67ed59e1d1-2dd6ce47a21mr1030283a91.14.1726685462504; 
 Wed, 18 Sep 2024 11:51:02 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd6eee08d8sm20484a91.38.2024.09.18.11.51.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2024 11:51:01 -0700 (PDT)
Message-ID: <997e86ac-7eb3-4e79-9e99-e61ebef595b5@linaro.org>
Date: Wed, 18 Sep 2024 11:51:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/18] contrib/plugins: avoid hanging program
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Hildenbrand <david@redhat.com>, devel@lists.libvirt.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Elisha Hollander <just4now666666@gmail.com>
References: <20240916085400.1046925-1-alex.bennee@linaro.org>
 <20240916085400.1046925-19-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240916085400.1046925-19-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

T24gOS8xNi8yNCAwMTo1NCwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBBbHRob3VnaCB3ZSBh
c2tzIGZvciBpbnN0cnVjdGlvbnMgcGVyIHNlY29uZCB3ZSB3b3JrIGluIHF1YW50YSBhbmQN
Cj4gdGhhdCBjYW5ub3QgYmUgMC4gRmFpbCB0byBsb2FkIHRoZSBwbHVnaW4gaW5zdGVhZCBh
bmQgcmVwb3J0IHRoZQ0KPiBtaW5pbXVtIElQUyB3ZSBjYW4gaGFuZGxlLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiBS
ZXBvcnRlZC1ieTogRWxpc2hhIEhvbGxhbmRlciA8anVzdDRub3c2NjY2NjZAZ21haWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIGNvbnRyaWIvcGx1Z2lucy9pcHMuYyB8IDUgKysr
KysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvY29udHJpYi9wbHVnaW5zL2lwcy5jIGIvY29udHJpYi9wbHVnaW5zL2lwcy5jDQo+
IGluZGV4IDI5ZmE1NTZkMGYuLjZmMDc4Njg5ZGMgMTAwNjQ0DQo+IC0tLSBhL2NvbnRyaWIv
cGx1Z2lucy9pcHMuYw0KPiArKysgYi9jb250cmliL3BsdWdpbnMvaXBzLmMNCj4gQEAgLTE1
Miw2ICsxNTIsMTEgQEAgUUVNVV9QTFVHSU5fRVhQT1JUIGludCBxZW11X3BsdWdpbl9pbnN0
YWxsKHFlbXVfcGx1Z2luX2lkX3QgaWQsDQo+ICAgICAgIHZjcHVzID0gcWVtdV9wbHVnaW5f
c2NvcmVib2FyZF9uZXcoc2l6ZW9mKHZDUFVUaW1lKSk7DQo+ICAgICAgIG1heF9pbnNuX3Bl
cl9xdWFudHVtID0gbWF4X2luc25fcGVyX3NlY29uZCAvIE5VTV9USU1FX1VQREFURV9QRVJf
U0VDOw0KPiAgIA0KPiArICAgIGlmIChtYXhfaW5zbl9wZXJfcXVhbnR1bSA9PSAwKSB7DQo+
ICsgICAgICAgIGZwcmludGYoc3RkZXJyLCAibWluaW11bSBvZiAlZCBpbnN0cnVjdGlvbnMg
cGVyIHNlY29uZCBuZWVkZWRcbiIsIE5VTV9USU1FX1VQREFURV9QRVJfU0VDKTsNCj4gKyAg
ICAgICAgcmV0dXJuIC0xOw0KPiArICAgIH0NCj4gKw0KPiAgICAgICB0aW1lX2hhbmRsZSA9
IHFlbXVfcGx1Z2luX3JlcXVlc3RfdGltZV9jb250cm9sKCk7DQo+ICAgICAgIGdfYXNzZXJ0
KHRpbWVfaGFuZGxlKTsNCj4gICANCg0KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIg
PHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz4NCg==

