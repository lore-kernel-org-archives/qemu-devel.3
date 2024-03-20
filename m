Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EC6C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 05:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmocx-0002FM-4Q; Wed, 20 Mar 2024 01:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmocr-0002Ef-Ku
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:36:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rmocp-00083O-2X
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 01:36:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-414645c349dso2759175e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 22:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710912989; x=1711517789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EzM/RVN7wdUg0oMzSoD+AnBi7r/hvQWFM0TPN5W6aHQ=;
 b=xttxC4TIMSKyXOwmPploTJ6ozWEQVcPiU9n7ko9WnS8QezNR+td2tcuXNd7wfssm1x
 HxIjwoJwUwuGV21EMRLENCuWO88ZOLIIJVQq7cl8S20rrB4kEm4vt9r3vqxr47DSKDy2
 7WKAEIBorNkivVTMvbee1wzlXLAmgEBb2Vc/19ygtx3WPo+hox+JmcMdCdmFyI6aOkLn
 8ZOrvdzIVA41mUOSaamaiIZD8zoes1spZH4tb1TauOTzHD2RS3CYSaWtKjlq+O5DboKR
 5BWFZZMJ/cojpzGJzfRsn6EQ2YSRKBEuGniXGZXAlfnqXwcIQpN79u+lahmWKjTJRvBU
 CNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710912989; x=1711517789;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EzM/RVN7wdUg0oMzSoD+AnBi7r/hvQWFM0TPN5W6aHQ=;
 b=v+O3WKwqS82TG4T4JwEw+GjfhWdppwzRmKFZFcF13b3oklJduXx8sMWhIZJkuns47/
 hv1Ci3zfAxBISRR83vHLHNTBrJr0iwgKiOfgU8sC3JhmWVGIdps50X6Y4LWphf49ZkpE
 S2UcYQYicMoNYaQesZwym/ZuPKKQ6nSMQOJuxVHtDywdOzzscrh4N2Wn8mtkGuU5NEZQ
 YjJG8wr04AhkQUbjCp2sznQ80kcBDmgY6fN3wnSIPn6uxpY8vG5tBpWgvdWjlaXhjERE
 HwyFzoRE8PpmPfbrdyKT+CExZ6KLpUjHxD9fbsRCHIoHBjfkNqlb/CdaNkzZTKcMtZ6O
 G8WQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfQxpVjah1Jh2vanbxRsW8h5AUatJH7U3HpnGV2kYQzo8/XV2ggqM7bWM+GB8yH580e1TCa0wrgif+xo7X0eVX4rIV1SY=
X-Gm-Message-State: AOJu0YxrlZybEcUandnGC9E39ruQKO70KnbdvQPPrwG2RXh5w+nmtpBR
 /WHANEk4yLURlSlebehgPQpDtAyWBRcRxhI2ZnxgKOP1TEZ5PS5ddQ6dGKIOv+k=
X-Google-Smtp-Source: AGHT+IHMpabDkTzzSBTKt6G3cvgd60ppgK50OotaF6Wgocv+KzvC6slxHSqgixPHW1LD9+eJ6AAT4A==
X-Received: by 2002:a05:600c:1395:b0:413:fdc2:d9da with SMTP id
 u21-20020a05600c139500b00413fdc2d9damr1151024wmf.12.1710912989183; 
 Tue, 19 Mar 2024 22:36:29 -0700 (PDT)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 ay18-20020a05600c1e1200b004146d785508sm373454wmb.0.2024.03.19.22.36.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 22:36:28 -0700 (PDT)
Message-ID: <7bd582ca-e145-4790-ba31-2cc565b5631d@linaro.org>
Date: Wed, 20 Mar 2024 09:36:24 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] plugins: Use emit_before_op for
 PLUGIN_GEN_AFTER_INSN
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-8-richard.henderson@linaro.org>
 <5b9ff51d-439f-4e65-acb5-909bdfaf350c@linaro.org>
 <1eb36792-22e4-4f0c-b7b5-968b78e3a1bc@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <1eb36792-22e4-4f0c-b7b5-968b78e3a1bc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x330.google.com
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

T24gMy8xOS8yNCAyMzo1NiwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTkv
MjQgMDM6MzIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+Pj4gIMKgIHN0YXRpYyB2b2lk
IHBsdWdpbl9nZW5faW5qZWN0KHN0cnVjdCBxZW11X3BsdWdpbl90YiAqcGx1Z2luX3RiKQ0K
Pj4+ICDCoCB7DQo+Pj4gLcKgwqDCoCBUQ0dPcCAqb3A7DQo+Pj4gK8KgwqDCoCBUQ0dPcCAq
b3AsICpuZXh0Ow0KPj4+ICDCoMKgwqDCoMKgIGludCBpbnNuX2lkeCA9IC0xOw0KPj4+ICDC
oMKgwqDCoMKgIHByX29wcygpOw0KPj4+IC3CoMKgwqAgUVRBSUxRX0ZPUkVBQ0gob3AsICZ0
Y2dfY3R4LT5vcHMsIGxpbmspIHsNCj4+PiArwqDCoMKgIC8qDQo+Pj4gK8KgwqDCoMKgICog
V2hpbGUgaW5qZWN0aW5nIGNvZGUsIHdlIGNhbm5vdCBhZmZvcmQgdG8gcmV1c2UgYW55IGVi
YiB0ZW1wcw0KPj4+ICvCoMKgwqDCoCAqIHRoYXQgbWlnaHQgYmUgbGl2ZSB3aXRoaW4gdGhl
IGV4aXN0aW5nIG9wY29kZSBzdHJlYW0uDQo+Pj4gK8KgwqDCoMKgICogVGhlIHNpbXBsZXN0
IHNvbHV0aW9uIGlzIHRvIHJlbGVhc2UgdGhlbSBhbGwgYW5kIGNyZWF0ZSBuZXcuDQo+Pj4g
K8KgwqDCoMKgICovDQo+Pj4gK8KgwqDCoCBtZW1zZXQodGNnX2N0eC0+ZnJlZV90ZW1wcywg
MCwgc2l6ZW9mKHRjZ19jdHgtPmZyZWVfdGVtcHMpKTsNCj4+PiArDQo+Pg0KPj4gTm90IGFu
IGV4cGVydCBhdCB0aGlzLCBidXQgd291bGRuJ3QgdGhhdCBicmVhayBhbiBleGlzdGluZyBU
QiB0aGF0IGFscmVhZHkgaGFzIHNvbWUgb3BzIG9uDQo+PiB0aG9zZSB0ZW1wcz8NCj4gDQo+
IE5vLCB0aGlzIG9ubHkgYWZmZWN0cyBhbGxvY2F0aW9uIG9mIG5ldyB0ZW1wcyAtLSBpZiBm
cmVlX3RlbXBzIGlzIGVtcHR5LCBhIG5ldyB0ZW1wIHdpbGwNCj4gYmUgYWxsb2NhdGVkIGZy
b20gdGNnX2N0eC0+bmJfdGVtcHMrKy4NCj4gDQo+IFplcm9pbmcgZnJlZV90ZW1wcyBoZXJl
IGVuc3VyZXMgdGhhdCB3ZSAqZG8gbm90KiByZXVzZSBhIHRlbXAgdGhhdCBtaWdodCBhbHJl
YWR5IGJlIGxpdmUNCj4gYWNyb3NzIGFueSBwbHVnaW4gaW5zZXJ0aW9uIHBvaW50LiAgQmV0
d2VlbiBpbnNlcnRpb24gcG9pbnRzLCB3ZSB3aWxsIGZyZWUgcGx1Z2luIHRlbXBzDQo+IGFu
ZCBvbmx5IHJldXNlIHRob3NlLg0KPiANCg0KVGhhbmtzLCBieSBsb29raW5nIGF0IHRjZ190
ZW1wX25ld19pbnRlcm5hbCBmbiwgYW5kIHdpdGggeW91ciANCmV4cGxhaW5hdGlvbiwgaXQg
bWFrZXMgbW9yZSBzZW5zZS4NCg0KPiANCj4gcn4NCg==

