Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19EAC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 07:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfaaY-0003BF-RO; Thu, 29 Feb 2024 02:12:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfaaS-00037T-PC
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:12:13 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rfaaR-0004lR-Ap
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 02:12:12 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d568fbf62so302877f8f.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 23:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709190730; x=1709795530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=31fyNln3HVxURNE8vA4kzbKfqBNWlIGkBNsLE9GcSPQ=;
 b=ts9XVZxKdwvMx2oD3EbeRMpOH2aK9I+UQ/jFCCrd0DSsWMjGI+S0k7zfmnvK1XfV75
 uhRouTustNFH3seFUr3S+Xr3UOnb5z1pjrGImP1chzdfP3gU91ybgOceoS0/QCFdOlNp
 nV/lUppabliCg3H8Jt0BT2E4NQyWQO8KvSm6EmM/GRr9EgxvE9GAHFTawwqb/rd3ZIge
 Cp66bGngEXZ0SmPSBhEi8G8kSup8vyvAbF+rJzcUG3fIHgju65ECdcCelDqiCfXooPgI
 iC0r5xyi6rqzDxh0zy8lMOBs8n6z9+ZGoPj5tHjIpPWVSRXtqdCajUL0HPfI+wEaBhzo
 G1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709190730; x=1709795530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=31fyNln3HVxURNE8vA4kzbKfqBNWlIGkBNsLE9GcSPQ=;
 b=p6TPEXQx95ksRKuNw5bZ0APfC3b2SP7z4pytu3LrCJBzcwIreBQ83rUR67YColkuiH
 ZALAIzYvA0yPXkoMYy/begSrcgUaYnS/62iZJizx+QtaVEejhvJD3LBVvx/k6RoSVGkE
 5qgRgK2IU1qr5MmRa5ZzjFRMDWVLX+f8VzZ1fbu97PIgcEOULFR+3FuB/NckUIYEG2If
 WJ7qW/s8IDtGIxTSPxxNRAlrjJJ39029nly+gjDKvq9sSRZha+rANfI60/QAgf0jRc8s
 fCUquNId+MsvbeTrN2FdChIRn/aawAQO8pePd+iiw3+ICscqzqyB6ckJ8XdAgxbVpJw3
 vwzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyLWVNc5T4MM8sIHgr24L8+3+9VI/YXI/B5WGP+L9wbEljHT29DnxlHTrIXlx9BX21+o4Ql4P+T/DUN6Zvldx4UzupDKI=
X-Gm-Message-State: AOJu0YyW9bmBi3HRt69fHKheM3gWd+R1G3nn8HY7b3VNXGSm/+KQ3R9J
 LXh8374WYiKbTTjH+CVG6HEmqdibn1ZQwnQ+Md/MvH62mbBUgwy//2if2/5zVWg=
X-Google-Smtp-Source: AGHT+IHi422/sXt5SOoRD7Kxo6LQQ4MRhYGhvvZm1Hpea0KP4UjqMYPQpA41e832d18/WCJAROG01A==
X-Received: by 2002:adf:a311:0:b0:33e:82f:7efa with SMTP id
 c17-20020adfa311000000b0033e082f7efamr703891wrb.41.1709190729694; 
 Wed, 28 Feb 2024 23:12:09 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 j12-20020adfea4c000000b0033e11bd9febsm399471wrn.90.2024.02.28.23.12.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 23:12:09 -0800 (PST)
Message-ID: <03ce19fb-0b82-4819-aaa4-a2241517090e@linaro.org>
Date: Thu, 29 Feb 2024 11:12:03 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] tests/plugin/mem: migrate to new per_vcpu API
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240226091446.479436-1-pierrick.bouvier@linaro.org>
 <20240226091446.479436-7-pierrick.bouvier@linaro.org>
 <Zd2sxjxegajy7ZbF@luc-work-vm> <875xy8b5sg.fsf@draig.linaro.org>
 <f0133db0-63e1-4634-a18f-fe181754e17c@linaro.org>
 <87zfvjagse.fsf@draig.linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <87zfvjagse.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42b.google.com
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

T24gMi8yOS8yNCAxMTowOCBBTSwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBQaWVycmljayBC
b3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+IHdyaXRlczoNCj4gDQo+PiBP
biAyLzI5LzI0IDI6MDggQU0sIEFsZXggQmVubsOpZSB3cm90ZToNCj4+PiBMdWMgTWljaGVs
IDxsdWMubWljaGVsQGFtZC5jb20+IHdyaXRlczoNCj4+Pg0KPj4+PiBIaSBQaWVycmljaywN
Cj4+Pj4NCj4gPHNuaXA+DQo+Pj4NCj4+DQo+PiBNeSBiYWQuIE90aGVyIHBsdWdpbnMgZW5h
YmxlIG9ubHkgaW5saW5lIHdoZW4gYm90aCBhcmUgc3VwcGxpZWQsIHNvIEkNCj4+IG1pc3Nl
ZCB0aGlzIGhlcmUuDQo+PiBJIGFkZGVkIGFuIGV4cGxpY2l0IGVycm9yIHdoZW4gdXNlciBl
bmFibGUgY2FsbGJhY2sgYW5kIGlubGluZSBhdCB0aGUNCj4+IHNhbWUgdGltZSBvbiB0aGlz
IHBsdWdpbi4NCj4gDQo+IFdlIGNvdWxkIGRlZmF1bHQgdG8gaW5saW5lIHVubGVzcyB3ZSBu
ZWVkIHRoZSBtb3JlIGZlYXR1cmVzIG9mIGNhbGxiYWNrcz8NCj4gDQoNClRoaXMgcmVtYXJr
IGFwcGxpZXMgZm9yIGFsbCBwbHVnaW5zIGluIGdlbmVyYWwuIE5vdyB3ZSBoYXZlIHNhZmUg
YW5kIA0KY29ycmVjdCBpbmxpbmUgb3BlcmF0aW9ucywgY2FsbGJhY2tzIGFyZSBub3QgbmVl
ZGVkIGluIHNvbWUgY2FzZS4NCg0KV291bGQgdGhhdCBiZSBhY2NlcHRhYmxlIGZvciB5b3Ug
dGhhdCB3ZSBkZWxheSB0aGlzICJjbGVhbnVwIiB0byANCmV4aXN0aW5nIHBsdWdpbnMgYWZ0
ZXIgc29mdCBmcmVlemU/IFNvIHdlIGNhbiBmb2N1cyBvbiBtZXJnaW5nIGN1cnJlbnQgDQpB
UEkgY2hhbmdlcyBuZWVkZWQuDQo=

