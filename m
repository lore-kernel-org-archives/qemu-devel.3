Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0BD41C00
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 04:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBRCm-0003wp-G0; Wed, 13 Nov 2024 23:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCl-0003vG-4V
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:39 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tBRCi-0003ep-N6
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 23:11:38 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7183a3f3beaso79411a34.1
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 20:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731557495; x=1732162295; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TEN+4z1Vk7ScdaNl+Nv1dim/1Iw42NJSZFhbHfv4BQQ=;
 b=IpJow6tal0pFET4NcirSODrPvgqSC0nR6u2SVt+CqHtjFJVBt/0nC6YVqw/ZQwBaVL
 Uoqz8RQkAomTlFUShOky4XoNxRhNVyPmiCFmm2dSnKmT4AD2a+TgYADZkTKV0gyBULG6
 u8RsyamxBM4Lat1suiyRgXxryyxdpogleRI2Up1dR3SlqjFEE7RFO4+75t/T49oFUhvb
 7TLR5I0QPoZczBCuVu1fIGt+wWfUBTTIeAPHjoETpAKeCq1ch8PPPe6FOck9EP3T86JB
 hrKhQa3in/d+AbCYBOvQmYRegrRYHk58EstGmQK8sbMPfcyc7iWcmOt8vfAi3zPjkvym
 Vx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731557495; x=1732162295;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TEN+4z1Vk7ScdaNl+Nv1dim/1Iw42NJSZFhbHfv4BQQ=;
 b=G+cbFgw7M+lQOUTwVPWgiGIKbgLnPTLlPmP0pai3tNSnj5KHzkP4oderks/h+dtkie
 +ApRiGchcRFa9B9OVD8SwhBYUNABEdlTdAZb7wnM5Co0kxhnE4lD7rwJ4Q2TkJ4zeyKP
 URu23IITlrZKRmfMwtm1/7aUixlo7uPvZ7qazWEFYqolah5e5WzzD+MzBOUR2+TMgOnw
 3zLmTAQyJgLizc2PoSNXw+SEz5SPVr76f081FqUMX9VM9r/jjVzeZ42SX4HKubdUHfPN
 BmZcZV6oq1PAPpC2UbNA9p8ujyahkKITKHyIm+YttJtxHZiVD2LhQ7KnKp+1EIgTxtbj
 F6lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0bkhrmWcmvkryS5JwCF7s2Lh8W0DXoxOre0GXuAnTMYhqkGw3kFY2lqLY40OOL5Hjg304o6/l5VCV@nongnu.org
X-Gm-Message-State: AOJu0YylNn4rmL7fINP3yU63rCnSUuyfKuCLB6eRomRZmQW0MxnlkcdY
 L2p2NqW6vWCAITj15/4bWSFbUlhdbCRcjMQDHO2zRkEXGkm/MLu6AhfIcBhvtsE=
X-Google-Smtp-Source: AGHT+IFXUZfcWaL3ihlUDKzURSyduA4bdDa2twYusHD9JGEcxqLdtfyy/KskY6JVvm1hpmKOi/vamg==
X-Received: by 2002:a05:6830:668c:b0:716:8e7a:f0c2 with SMTP id
 46e09a7af769-71a1c2b1f87mr20904168a34.30.1731557495339; 
 Wed, 13 Nov 2024 20:11:35 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8b39af5e2sm132319a12.73.2024.11.13.20.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 20:11:34 -0800 (PST)
Message-ID: <754dcf6f-6c53-454e-b24d-8786c0e31c20@linaro.org>
Date: Wed, 13 Nov 2024 20:11:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] system/watchpoint: Include missing 'exec/cpu-all.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20241114011310.3615-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-ot1-x32c.google.com
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

DQoNCk9uIDExLzEzLzI0IDE3OjEyLCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToN
Cj4gVEFSR0VUX1BBR0VfTUFTSyBpcyBkZWZpbmVkIGluICJleGVjL2NwdS1hbGwuaCIuDQo+
IEluY2x1ZGUgaXQgaW4gb3JkZXIgdG8gYXZvaWQgd2hlbiByZWZhY3RvcmluZzoNCj4gDQo+
ICAgIHN5c3RlbS93YXRjaHBvaW50LmM6NTI6MjQ6IGVycm9yOiB1c2Ugb2YgdW5kZWNsYXJl
ZCBpZGVudGlmaWVyICdUQVJHRVRfUEFHRV9NQVNLJw0KPiAgICAgICA1MiB8ICAgICBpbl9w
YWdlID0gLShhZGRyIHwgVEFSR0VUX1BBR0VfTUFTSyk7DQo+ICAgICAgICAgIHwgICAgICAg
ICAgICAgICAgICAgICAgICBeDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRo
aWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+DQo+IC0tLQ0KPiAgIHN5c3RlbS93YXRj
aHBvaW50LmMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9zeXN0ZW0vd2F0Y2hwb2ludC5jIGIvc3lzdGVtL3dhdGNocG9p
bnQuYw0KPiBpbmRleCAyYWEyYTllYTYzLi5mNzM2NjU3NGEzIDEwMDY0NA0KPiAtLS0gYS9z
eXN0ZW0vd2F0Y2hwb2ludC5jDQo+ICsrKyBiL3N5c3RlbS93YXRjaHBvaW50LmMNCj4gQEAg
LTIwLDYgKzIwLDcgQEANCj4gICAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPiAgICNpbmNs
dWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPiAgICNpbmNsdWRlICJleGVjL2V4ZWMtYWxs
LmgiDQo+ICsjaW5jbHVkZSAiZXhlYy9jcHUtYWxsLmgiDQo+ICAgI2luY2x1ZGUgImh3L2Nv
cmUvY3B1LmgiDQo+ICAgDQo+ICAgLyogQWRkIGEgd2F0Y2hwb2ludC4gICovDQoNClJldmll
d2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+
DQoNCg==

