Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE9FC28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 19:25:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqdDh-00040w-VF; Fri, 07 Mar 2025 14:18:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdB7-0007QB-U6
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:16:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tqdB6-00030r-4I
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 14:16:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2240b4de12bso19048325ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 11:16:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741374969; x=1741979769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OeP69WaxLi4fNPjz8XHoe9xACL5tC1MEITIPsCFXcfA=;
 b=BCTIgCJ/+pmlsiCuTB8OfLFXfckExtmNDQ6plerOMChXK7IfzSxo+UtjCa/HH5LKDD
 XAx6Ebv5z0KBzRLnEelcoUPafGpH72jxLJxhDfuH7NOIunlnB4uAzgug5dKemACYYBDW
 NxoBWSFv21bbRyh/4Tn8wUu4H8bgBYfmIXvbmhH/J/7Wbj3EkCqK/DEJXhxOX0yQ6FZm
 QmD7dh6Y9GmUamGD07zJehXqcMQpr354Mpwy3MEQCO/PNGhaRl7vsNAd07JayxhRG3dq
 sduii9G5YdmuFzqK2NGNKX8Tu4WLYTp2qmD1Aimimz0+tgYByy6YQcw7bhpEscBCd2rs
 b0LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741374969; x=1741979769;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OeP69WaxLi4fNPjz8XHoe9xACL5tC1MEITIPsCFXcfA=;
 b=ZMuZs7AoocMHbimVqxFUFuOu/MoXYabAWvaGV4pHhzTnCmvkZYLRnc4VHtVZ457/rE
 2vP5IGc3widQ2vggxc8YtqM/CpiLKTCjTiIwLTaQaAVvGcJvaX/iXZ4MwYw2y8YqVDkI
 7cYGlAjO60Ii0g/RciyqIl8AvbdPqDmk3M7o4wxeLbkdGQRss5pa8rjX0qLt0w8bAhSl
 BaJfTbMcQ0gXA0rq7ikevRlqw5fgQz70/qekn7FiIwkSrsZmuEJJCVdMKz7BTQ5gyOED
 eskIeCINZtGaFUlfoKFJFyariGHJbRWpk/XM7cjgHa9wI9DWreQru80aI6G/KDcP/d14
 lhKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9zT51ARlkKuOo4mTG6qn1MYNB+I3Fdx0Af5UHJtQUELOGqj0rskMy3TsKAN0ppUrw2bPv0A5nhmmg@nongnu.org
X-Gm-Message-State: AOJu0YzSkypDDjCD4X9pCqT87bkHbFNs+tF0ljJ+m1y1ArhV6MEpSbYp
 ykm1VWCfmSFGWS4BYWs79pvy2cXN3Va8M7M79JXpB2eAI7plFbnFoL503yNUs/D8dNqM/3xuitl
 y
X-Gm-Gg: ASbGncsdFxe9BOATvqqBp4pAO/n4k/1UZJCK9fgailTHKVDOlVHl1OHF6+zxrji1BJh
 iP8W2/YQxci26TkWrZOO3aFqVIEXBacLsoD5o9Ti1l9zkmFrB4uspmS4/DAqv9MVXv3NdqRlgok
 afPTa0BTpMlN6wKx24BjOehtTvwHww2B9jF0gqTHhdH76TQKdUxwk94eq2vDwTjrK9NlDH8qWND
 h3sF0kKFCbSOHY50SZ0d5FbTTmK1QfFh84h5Mf9M/UcmpGbMBCr9iL2nNoDwrs+M6KqA5Zut5/K
 wlhZXfi9U4KhkIZLRtVCPLR4PZpHGOEYj+zLoMmDh5t7j2NtCQrB86bZKw==
X-Google-Smtp-Source: AGHT+IGfPDOi36BknB8CY6dfJ0l8MlpdsZ6+O7IgClqLllxzbmME4yWe6V/2v88EVPuw41CC/cziww==
X-Received: by 2002:a17:902:db10:b0:224:1781:a947 with SMTP id
 d9443c01a7336-2242888b368mr72753315ad.21.1741374969486; 
 Fri, 07 Mar 2025 11:16:09 -0800 (PST)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f7cebsm3427547a91.45.2025.03.07.11.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Mar 2025 11:16:09 -0800 (PST)
Message-ID: <9e896ed1-0b82-4270-9b55-5b87ab3290cf@linaro.org>
Date: Fri, 7 Mar 2025 11:16:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] hw/vfio: Compile iommufd.c once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-s390x@nongnu.org, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20250307180337.14811-1-philmd@linaro.org>
 <20250307180337.14811-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250307180337.14811-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

T24gMy83LzI1IDEwOjAzLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4gUmVt
b3ZpbmcgdW51c2VkICJleGVjL3JhbV9hZGRyLmgiIGhlYWRlciBhbGxvdyB0byBjb21waWxl
DQo+IGlvbW11ZmQuYyBvbmNlIGZvciBhbGwgdGFyZ2V0cy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCj4gLS0t
DQo+ICAgaHcvdmZpby9pb21tdWZkLmMgICB8IDEgLQ0KPiAgIGh3L3ZmaW8vbWVzb24uYnVp
bGQgfCA2ICsrKy0tLQ0KPiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCA0
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vaW9tbXVmZC5jIGIv
aHcvdmZpby9pb21tdWZkLmMNCj4gaW5kZXggZGY2MWVkZmZjMDguLjQyYzg0MTJiYmY1IDEw
MDY0NA0KPiAtLS0gYS9ody92ZmlvL2lvbW11ZmQuYw0KPiArKysgYi9ody92ZmlvL2lvbW11
ZmQuYw0KPiBAQCAtMjUsNyArMjUsNiBAQA0KPiAgICNpbmNsdWRlICJxZW11L2N1dGlscy5o
Ig0KPiAgICNpbmNsdWRlICJxZW11L2NoYXJkZXZfb3Blbi5oIg0KPiAgICNpbmNsdWRlICJw
Y2kuaCINCj4gLSNpbmNsdWRlICJleGVjL3JhbV9hZGRyLmgiDQo+ICAgDQo+ICAgc3RhdGlj
IGludCBpb21tdWZkX2NkZXZfbWFwKGNvbnN0IFZGSU9Db250YWluZXJCYXNlICpiY29udGFp
bmVyLCBod2FkZHIgaW92YSwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmFt
X2FkZHJfdCBzaXplLCB2b2lkICp2YWRkciwgYm9vbCByZWFkb25seSkNCj4gZGlmZiAtLWdp
dCBhL2h3L3ZmaW8vbWVzb24uYnVpbGQgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+IGluZGV4
IDI5NzJjNmZmOGRlLi5mZWE2ZGJlODhjZCAxMDA2NDQNCj4gLS0tIGEvaHcvdmZpby9tZXNv
bi5idWlsZA0KPiArKysgYi9ody92ZmlvL21lc29uLmJ1aWxkDQo+IEBAIC00LDkgKzQsNiBA
QCB2ZmlvX3NzLmFkZChmaWxlcygNCj4gICAgICdjb250YWluZXIuYycsDQo+ICAgKSkNCj4g
ICB2ZmlvX3NzLmFkZCh3aGVuOiAnQ09ORklHX1BTRVJJRVMnLCBpZl90cnVlOiBmaWxlcygn
c3BhcHIuYycpKQ0KPiAtdmZpb19zcy5hZGQod2hlbjogJ0NPTkZJR19JT01NVUZEJywgaWZf
dHJ1ZTogZmlsZXMoDQo+IC0gICdpb21tdWZkLmMnLA0KPiAtKSkNCj4gICB2ZmlvX3NzLmFk
ZCh3aGVuOiAnQ09ORklHX1ZGSU9fUENJJywgaWZfdHJ1ZTogZmlsZXMoDQo+ICAgICAnZGlz
cGxheS5jJywNCj4gICAgICdwY2ktcXVpcmtzLmMnLA0KPiBAQCAtMjgsMyArMjUsNiBAQCBz
eXN0ZW1fc3MuYWRkKHdoZW46ICdDT05GSUdfVkZJTycsIGlmX3RydWU6IGZpbGVzKA0KPiAg
ICAgJ21pZ3JhdGlvbi1tdWx0aWZkLmMnLA0KPiAgICAgJ2Nwci5jJywNCj4gICApKQ0KPiAr
c3lzdGVtX3NzLmFkZCh3aGVuOiBbJ0NPTkZJR19WRklPJywgJ0NPTkZJR19JT01NVUZEJ10s
IGlmX3RydWU6IGZpbGVzKA0KPiArICAnaW9tbXVmZC5jJywNCj4gKykpDQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQoN
Cg==

