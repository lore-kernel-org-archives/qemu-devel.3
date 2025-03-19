Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F235C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:09:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhvh-0005Cg-0e; Tue, 18 Mar 2025 21:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhvV-0005C0-0v
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:08:58 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tuhvQ-00075S-Nx
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:08:54 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-223a7065ff8so29881345ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742346531; x=1742951331; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W4PSn8O8Q/FGKOYAhlD2OsOaBZBwwIbxPClGVaKPGY8=;
 b=JSObNYapU0bU2eScKdNyvPFqHp5MpcjpWfIble0Y3uIVwuOHaHhhrpRiuTXBxdL9Dk
 mBhqqB1aGHIBYR0xIN2LsOIDNJjx4iJ5umo0UVMD23JKjIJX18SNrVZOjhm6fqjq86Pf
 SzscyxsKzrr2C3d7vHb7oPNYdtZWm2TkKmB48Er9XX1zcoZ+G9WIFY8zZovNySFyZFOG
 oxADnr9ztJsghmI5Wj3fR65juudbG7GSylOdduhcXznAVfItNpKrWrGXdT7KNR+xX5zN
 zlSiS9r8X3GYRMj9M6nzs0glBngRkrkhHWMYc/v2786MRmOP6fn5MDw+rBUp+IeAKGEY
 fiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742346531; x=1742951331;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W4PSn8O8Q/FGKOYAhlD2OsOaBZBwwIbxPClGVaKPGY8=;
 b=GtnvMN1cR6Oebczd4UDuKXu/W1wl0Gl0ozPKAM4/FnMQ4wDt+Yj/WWnecJXUOFHQQ0
 GHO4YCeyqqUrZUJq4TX7h69yLm8knZ83ip0Hs3nkNYQZRcv67yEgBI9TI1s1BnJKCaNE
 rhmPQR0S40laZ+sIsA6o+ZRc7zUT4cl6vOR8SWVrpcViBxP2DHd9sgTC9FMtwo0Ro77H
 kpSWc+inbpQf5SVuQFXeCq4o+gOfLWTa8JRM4KvP4hO44oCNK8pHGHzH684rN8l5d1Ys
 3CcmEw5/NdY4gZJVsOJqbnFbhj/ck8GF5AOgdKfwc7ZzSLbwOVP31/7UcTufh/ZOZbwg
 7sow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm2XVTGKyJGZ/fq9t5QjCVegNEDgP2QopGQr249o2wf5/67Hv1XMbG+jfOXUz7OHuzsK1lqteCca3y@nongnu.org
X-Gm-Message-State: AOJu0YyRKN9iFYVuXnob92qoJxwXgOaQ9qIWVfsUw43SSoFLdZOtCL31
 IhNfmdQsAmRF3QaOrG633nB3RBi26yChiZdcYqjFMD6z5KXbjor14qVxuQ+Tcfo=
X-Gm-Gg: ASbGnctsqmzP8GNxg6z/+GtZBYa72bdjG6XdG6lk6PID0AryeZm8TX/hIad28n0EnW/
 Nj6wZccbwzjmqsmCDXBxJgjW6PI+odMYMQuckk99vrrntodIqKcmYQ5tnZTtUZFi4sOeiHGG/wb
 06JjYHKvDN0I38/XTm+SgoSM/LsAghr3aSQlj5xclwuUBv/OgVp8WuJMqKnSkuNZJFDw4QELwz8
 qCgSVIul2scoeQ0U3CDm04xGXzkaCkHMm+xEpbX6/O35JBOIxESwFTxIykm3yZ34Ct0r7l1a48z
 3erRKrWS0w484ft/d5yJyVs0FIp3GDthbE2yqlDy1+ot2FVUeBmnCW0wFmsFC7kDdpyC
X-Google-Smtp-Source: AGHT+IGM7lNxGxSFXz5Ezb0L47WEr+ydbt9W8N4JTcADL1t1NZ6B3uSDdOH+Wzt1xxy53cBZDoiwIA==
X-Received: by 2002:a17:902:dad0:b0:223:f408:c3e2 with SMTP id
 d9443c01a7336-22649926828mr15062505ad.14.1742346530972; 
 Tue, 18 Mar 2025 18:08:50 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bd4da0sm101505665ad.222.2025.03.18.18.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:08:50 -0700 (PDT)
Message-ID: <db71a10a-c768-4ea7-8cad-44e67d057d82@linaro.org>
Date: Tue, 18 Mar 2025 18:08:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/42] accel/tcg: Fix cpu_ld*_code_mmu for user mode
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-4-richard.henderson@linaro.org>
 <de8fb1b6-0aef-47aa-aa17-37d836b5b983@linaro.org>
 <d76c9ca8-3f3b-45d6-9ea2-b53ff59ae7e1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <d76c9ca8-3f3b-45d6-9ea2-b53ff59ae7e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

T24gMy8xOC8yNSAxODowNSwgUmljaGFyZCBIZW5kZXJzb24gd3JvdGU6DQo+IE9uIDMvMTgv
MjUgMTY6NTIsIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzE4LzI1IDE0OjMx
LCBSaWNoYXJkIEhlbmRlcnNvbiB3cm90ZToNCj4+PiBUaGVzZSByb3V0aW5lcyBhcmUgYnVn
Z3kgaW4gbXVsdGlwbGUgd2F5czoNCj4+PiAgwqDCoCAtIFVzZSBvZiB0YXJnZXQtZW5kaWFu
IGxvYWRzLCB0aGVuIGEgYnN3YXAgdGhhdA0KPj4+ICDCoMKgwqDCoCBkZXBlbmRzIG9uIHRo
ZSBob3N0IGVuZGlhbm5uZXNzLg0KPj4NCj4+IFRoZSBjb2RlIGlzIHZlcnkgc2ltaWxhciB0
byBkb19sZCpfbW11IGZ1bmN0aW9ucywgc28gaXQncyBzdWJ0bGUgdG8gbm90aWNlLg0KPj4N
Cj4+IFdhcyB0aGUgZW5kaWFubmVzcyBidWcgZHVlIHRvIHRoZSBmYWN0IHdlIHVzZSBvaSAo
TWVtT3BJZHgpIGRpcmVjdGx5IGluc3RlYWQgb2YNCj4+IGdldF9tZW1vcChvaSkgKE1lbU9w
KT8NCj4gDQo+IE5vLCBpdCB3YXMgZHVlIHRvIC4uLg0KPiANCj4+PiAtwqDCoMKgIHJldCA9
IGxkdXdfcChoYWRkcik7DQo+Pj4gLcKgwqDCoCByZXQgPSBsZGxfcChoYWRkcik7DQo+Pj4g
LcKgwqDCoCByZXQgPSBsZHFfcChoYWRkcik7DQo+IA0KPiAuLi4gdGhlc2UgYmVpbmcgdGFy
Z2V0LWVuZGlhbiBtYWNyb3MuDQo+IA0KPiBXaGF0IHdhcyBpbnRlbmRlZCwgb25jZSB1cG9u
IGEgdGltZSwgd2FzIGxkbF9oZV9wIGV0YywNCj4gc28gdGhhdCB0aGUgbG9hZCB3YXMgaG9z
dC1lbmRpYW4uICBCdXQgdXNpbmcgdGhlIGF0b21pY2l0eQ0KPiByb3V0aW5lcyBpcyBldmVu
IGJldHRlci4NCj4gDQoNCk9oIHJpZ2h0LCBJIG1pc3NlZCB0aGUgbG9hZF9hdG9tXyogZm9y
IHNpemUgPiAxLCBhcyBJIHdhcyBsb29raW5nIGF0IA0KZG9fbGQxX21tdSwgd2hpY2ggdXNl
cyBsZHViX3AuDQoNClRoYW5rcw0KDQo+IA0KPiByfg0KDQo=

