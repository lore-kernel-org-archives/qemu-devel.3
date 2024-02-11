Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B7C4829A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Feb 2024 14:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZAmt-0002JX-C6; Sun, 11 Feb 2024 09:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZAmr-0002IW-II
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 09:26:29 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rZAmq-0002X5-2I
 for qemu-devel@nongnu.org; Sun, 11 Feb 2024 09:26:29 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3394ca0c874so1617021f8f.2
 for <qemu-devel@nongnu.org>; Sun, 11 Feb 2024 06:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707661585; x=1708266385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bYCBvQLwfMMhisjU/mUMUuTwLzrhW8QpeZPoOJQ6sI0=;
 b=mCYrT2riv/3ZEnLYPqtdgKWYvE6mya5lAjU0R0jzRlJlY8QbcfsQTQfVt/3wR4f+tC
 8T1poXB9ycOIHqpuljKE89WKbA12SctMrAW0921JNIItAR6SZKFSwqQ+n+yqJbaTb8vX
 tAF2DWY6bHQEX3he4BVpF/TMNH6igHX9LgV1iTzRUkU0IQvtmVxdsT1OJe8FCMqa/fH9
 i99jgqmA+uPSekqXF9KTjoPmLioSSduupCWp+19adg/kzHV3L3rh+JYx1pc7g94M47Qc
 8BJ2A5pC6YTIS1a0FYhSanNG/NvDqYusNP+hsraB07Bp3QF3vbsjEkXir3cNDX3dcg+U
 ZWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707661585; x=1708266385;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bYCBvQLwfMMhisjU/mUMUuTwLzrhW8QpeZPoOJQ6sI0=;
 b=ZNX0AoGb7tUrA1Sl3NC+ufEOgcvNLeYRN/z57Oo50cPb0tFhNQZl+8P/DaJyVmFBEw
 9nU97goXpD6schyuCKtUxke42U0Ex05ekNHdiMJWybGeAKDjLb16LRVJ+GryLTFd95vb
 9AlzJsKWuKkEkg5/qUY+AtleATL2ABryXwmqXnRN7FUetEKtaakiTyByqIHwXaEbJXoY
 n99euM4J7c+L59Vd24qGHNN9jWdrkU9YkOGh67cAGnYX+2haCGlm0Cf0X/z9Qj041Nsp
 n0vjnhMEcvXpljTc58jlZUwpZooynLWcLB/Cy0daPNeWL/npc/nQAGSj2xmRyI6G9g+q
 dPAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIztyg8kwoEku4Bz8eyRs3VEZjaUPVVmjwx/HA5Sp0QekfOvuQCmsNPI/NNMJBfGaitpaJZRS+0d3VAdvESegTvKRPEqU=
X-Gm-Message-State: AOJu0YwFi3bXRBpJpfxzG5cZT0WmAIJUPx4sk6QFxUqrn9M0qgld5QxZ
 +zKnoJoeXBXAtSyWwj1QGBBKg4uEDG5nBbAwiM9TJiiEXIE2fOR16cREN0LbdN8=
X-Google-Smtp-Source: AGHT+IHw5FkANLRmDYel/i3UCMMIo8ducw6GJ/L04uU5TOKAZWg1zwVZHsmCKoO0Iu7CVRoQlk6+mg==
X-Received: by 2002:adf:ef91:0:b0:33b:1a71:a8ef with SMTP id
 d17-20020adfef91000000b0033b1a71a8efmr3368295wro.26.1707661584527; 
 Sun, 11 Feb 2024 06:26:24 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXRbSrBdq5QXkvy7Bqrv4e+zDjZNE1V+h5QYlH0ZvFayNhITme42zMhacCX5xIqcAWAPetX/ZtO/LfJoAzsruHZuI0o4loXx6y6AF+NXsdH1Mo2gNsU1B6JQ0HbZuTJo9NMizblzRTyNbsL6sXZx7AZLCu7AcOFBjRYyCnIlYV6xqX3USTfMh0pmdPRKgCVrLAKVk1WHmgX2wBFZoAf4cNFWsocF/SlzjQdm0EU77l3gn1otkEzrS+AT980T12R5Dr3jODr2sKdkPgTNfeVJfXcT9MvvhLK2Ni54ApjqB7i2VF6LwRmJLQGeHHtbw8OTIz1oUg8MsBQuqdIFbWcOWir
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 o16-20020a5d58d0000000b0033afe816977sm4335019wrf.66.2024.02.11.06.26.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Feb 2024 06:26:24 -0800 (PST)
Message-ID: <18e758f6-eb96-4418-9494-88092f8813dd@linaro.org>
Date: Sun, 11 Feb 2024 18:26:19 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/17] plugins: scoreboard API
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240206092423.3005995-1-pierrick.bouvier@linaro.org>
 <20240206092423.3005995-6-pierrick.bouvier@linaro.org>
 <e4db51de-a040-4c9e-93fa-64a378e4e5fa@linaro.org>
 <3381ba3a-ae14-4160-b651-d88a7893189b@linaro.org>
 <73e5314b-5e92-4a57-9780-508a8f33fe72@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <73e5314b-5e92-4a57-9780-508a8f33fe72@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x431.google.com
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

T24gMi8xMS8yNCAwNDo0MSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDIvNi8y
NCAxOTo1OSwgUGllcnJpY2sgQm91dmllciB3cm90ZToNCj4+PiBXaHkgYSBoYXNoIHRhYmxl
P8KgIEFsbCB5b3Ugd2FudCBpcyB0byBiZSBhYmxlIHRvIGl0ZXJhdGUgdGhyb3VnaCBhbGws
IGFuZCBhZGQvcmVtb3ZlDQo+Pj4gZWFzaWx5LsKgIFNlZW1zIGxpa2UgUUxJU1QgZnJvbSA8
cWVtdS9xdWV1ZS5oPiB3b3VsZCBiZSBiZXR0ZXIsIGFuZCB0aGUgUUxJU1RfRU5UUlkgbWVt
YmVyDQo+Pj4gd291bGQgbWFrZSBzdHJ1Y3QgcWVtdV9wbHVnaW5fc2NvcmVib2FyZCB1c2Vm
dWwuDQo+Pj4NCj4+DQo+PiBUaG91Z2h0IHRoYXQgaGF2aW5nIE8oMSkgcmVtb3ZhbCB3YXMg
YSBuaWNlIHByb3BlcnR5LCBjb21wYXJlZCB0byBhIGxpbmtlZCBsaXN0LiBJIGNhbg0KPj4g
c3dpdGNoIHRvIGEgUUxJU1QgaWYgeW91IHN0aWxsIHRoaW5rIGl0J3MgYmV0dGVyLg0KPiAN
Cj4gUUxJU1QgaXMgZG91YmxlLWxpbmtlZCwgc28gaXQncyBzdGlsbCBPKDEpLg0KPiANCj4N
Cg0KSXMgaXQgYW4gImludHJ1c2l2ZSIgbGlua2VkIGxpc3QgKHdoZXJlIG5leHQgYW5kIHBy
ZXYgYXJlIHBhcnQgb2YgdGhlIA0Kc3RydWN0IGVudHJ5IGl0c2VsZik/DQoNCj4+IFdoYXQg
ZG8geW91IG1lYW4gYnkgIm1ha2Ugc3RydWN0IHFlbXVfcGx1Z2luX3Njb3JlYm9hcmQgdXNl
ZnVsIj8NCj4gDQo+IEFzIG9wcG9zZWQgdG8gc2ltcGx5IGEgdHlwZWRlZiBvZiBHQXJyYXku
DQo+IA0KPiANCj4gcn4NCj4gDQo=

