Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2C5C36002
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 19:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twnez-0005VA-IR; Mon, 24 Mar 2025 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnep-0005RP-CZ
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:40:25 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twnen-00074U-B0
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 15:40:22 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22409077c06so95406265ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 12:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742845220; x=1743450020; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cx/OUfZdQzKU+LLj5qqzDfx9W3hPDmextBU4mFfzNsM=;
 b=QisUV0NkK+tR/fJcOT492dHBIEk5WYCqcSSqSaSwnt/LeCbne61145e6tgfJjBZHAq
 CquIG6BzDtkrLwYGK1zQPQwkvc4hom7lnv6WvVyujIlfa8k8JNA1GZmcEWzwWXCo8RCe
 3HmqtvlYdgejLWTIgVtItAr58n7cyrfiYUT5eBssZKA/UFSszsUDefXLYaejh7NxvuLA
 sXDxoshoEKo92uWBtc7CrPfJtG8uX/ca/Wu3bJNM3X0APqkSYDjXLYtCxpuEXJ8FBLhB
 sMpJRuLPG9QERV/JTAu4bxVFcBsfStcCu3knLZsnJWuuj+oB4NRE4h4QeQIwsWJkHI9J
 PGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742845220; x=1743450020;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cx/OUfZdQzKU+LLj5qqzDfx9W3hPDmextBU4mFfzNsM=;
 b=wZkU0ZCjrtuMit+kS/WefzC522kyz1Xnr9SEB5y0oQ6h0MZlLta03OGYA7l+C3T/os
 cMLdzju66WBZ46HCNt5hEMgzr1JtHOOsljubgwnU8YonL0F6EFj9r2rc2iT9tHTiaiRM
 ZXPCyC/CJbK8J3C8Dc0QgZY7oLaH9e1u/QnsY87wpvXHTlnRPSBQJ7i5I2J348VoQTQH
 9tbJSAw66t623K0cbiJIpACeo+y3h38tRBdhEkrc/QrUMfmIPaS/enYRrHgM5OVQ32Op
 VkBha3U+72Zq7V3+fQnK30WnCmFplOTeY2a3lD9W/aGASfjYTIIvaHuV8wPDa+tVekWy
 sy8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV889B6JF5fXkGXUgKiktBkGXhXK1SsuMQtuylcRYE4A3YlZTOTSPLrRY3kEZvhmjEL2ABs5VV32Oa+@nongnu.org
X-Gm-Message-State: AOJu0Yx1N8A00tK7JKt4wJN14kbQbHCYG38j7iNynPtMWxuLulaLAJsK
 1rw0/dYEDxgSx3GhMu2dyHMIV2x5dHvNqLBG/WLScW/+smheO7qvpn49637OmvU=
X-Gm-Gg: ASbGncv15IlkEfLiBp5yxVvmf8rtL4NIPW+fQCwpbF+MvApjPxz+16dz75mkn/Ri2YK
 pRq0mlM8bVAqC8UGPWdyEVZ9oqS4ie23tfgy9eJDL8dcuuDL04/fC3FKr8s7LYrP4zeFtyqvRZc
 Ab8xLEneJiZ08Bjy1mcWRrseJeh4clHcOHcBj1srxHWFENJbljei8/SveyXiwZKu/gZvQoZpBbO
 eiAOWWc06GHguj9hPMU/ATwb9uQBAFaKWVNXTzPtLKW3u1CllVP044UEGLSn5r+waJb33N1Pa19
 wzEqVYKsMbmjoWwumpoQw8tIZnzC+xxck1VqKW5JyE3RPGtgwvcsnhzSpw==
X-Google-Smtp-Source: AGHT+IEgoOv/tepq1C5Mfl8NNzZnF7xbs94TGwmXva9dSk1hM2gu+LBgRQWDjOUoS3RDtF3q1L2AQA==
X-Received: by 2002:a05:6a21:99a0:b0:1f5:8c86:5e2f with SMTP id
 adf61e73a8af0-1fe434518a2mr27105960637.37.1742845219726; 
 Mon, 24 Mar 2025 12:40:19 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a4da80sm7551310a12.74.2025.03.24.12.40.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Mar 2025 12:40:19 -0700 (PDT)
Message-ID: <eae35cc2-5784-4aa1-a594-240e29e600b6@linaro.org>
Date: Mon, 24 Mar 2025 12:40:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v2 0/7] cpus: Convert cpu_list definition to
 CPUClass:list_cpus callback
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20250324184611.44031-1-philmd@linaro.org>
 <03280ae6-c89b-41a7-a9a0-4157cba8c538@linaro.org>
 <9b51e17c-69f4-4390-9ecb-fb1f66f95742@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <9b51e17c-69f4-4390-9ecb-fb1f66f95742@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

T24gMy8yNC8yNSAxMjowMywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IE9u
IDI0LzMvMjUgMTk6NTksIFBpZXJyaWNrIEJvdXZpZXIgd3JvdGU6DQo+PiBPbiAzLzI0LzI1
IDExOjQ2LCBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSB3cm90ZToNCj4+PiBTaW5jZSB2MSAo
VGhvbWFzIHJldmlldyBjb21tZW50cykNCj4+PiAtIE1vdmUgczM5MF9zZXRfcWVtdV9jcHVf
bW9kZWwvczM5MF9jcHVfbGlzdCB0byAiY3B1X21vZGVscy5oIg0KPj4+IC0gQ29ycmVjdCAn
dGFyZ2V0L3MzOTB4OiBSZWdpc3RlciBDUFVDbGFzczpsaXN0X2NwdXMnIHN1YmplY3QNCj4+
Pg0KPj4+ICdjcHVfbGlzdCcgbWlnaHQgYmUgZGVmaW5lZCBwZXIgdGFyZ2V0LCBhbmQgZm9y
Y2UgY29kZSB0byBiZQ0KPj4+IGJ1aWx0IHBlci10YXJnZXQuIFdlIGNhbiBhdm9pZCB0aGF0
IGJ5IGludHJvZHVjaW5nIGEgQ1BVQ2xhc3MNCj4+PiBjYWxsYmFjay4NCj4+Pg0KPj4+IFRo
aXMgc2VyaWVzIGNvbWJpbmVkIHdpdGggYW5vdGhlciB3aGljaCBjb252ZXJ0cyBDUFVfUkVT
T0xWSU5HX1RZUEUNCj4+PiB0byBhIHJ1bnRpbWUgaGVscGVyLCBhbGxvd3MgdG8gbW92ZSBt
b3N0IG9mIGNwdS10YXJnZXQgdG8gY29tbW9uLg0KPj4+DQo+Pg0KPj4gSSB0aGluayB3ZSBz
aG91bGQgZm9jdXMgb24gYSBtb3JlIGdlbmVyYWwgc29sdXRpb24sIHVzYWJsZSB3aXRoDQo+
PiBtYWNoaW5lcywgY3B1cywgYW5kIGRldmljZXMsIGxpa2UgdGhlIGludGVyZmFjZSBiYXNl
ZCBhcHByb2FjaGVkIHdlDQo+PiB0YWxrZWQgYWJvdXQuDQo+Pg0KPj4gSGF2aW5nIGFuIG9w
dGlvbmFsIGNhbGxiYWNrLCBpbXBsZW1lbnRlZCBvbiBoYWxmIHRhcmdldCwgbG9va3MgbGlr
ZSBhDQo+PiBoYWxmIGJha2VkIHNvbHV0aW9uLiBBbmQgaXQgd291bGQgbm90IGJlIGRlc2ly
YWJsZSB0byBkbyB0aGUgc2FtZSB0aGluZw0KPj4gZm9yIG1hY2hpbmVzLCBhbmQgZGV2aWNl
cyBsYXRlci4NCj4+DQo+PiBJbiBjYXNlIENQVV9SRVNPTFZJTkdfVFlQRSBpcyBhbWJpZ3Vv
dXMgKGJlY2F1c2UgNjQgYml0IHR5cGUgaW5oZXJpdA0KPj4gZnJvbSAzMiBiaXQgdHlwZSwg
bGlrZSBUWVBFX0FBUkNINjRfQ1BVIGluaGVyaXRzIGZyb20gVFlQRV9BUk1fQ1BVKSwNCj4+
IGl0J3MgYmV0dGVyIHRvIGRlY2xhcmUgYW5vdGhlciBpbnRlcmZhY2UsIG5vbiBhbWJpZ3Vv
dXMsIGxpa2U6DQo+PiAtIFRZUEVfTUFDSElORV9UQVJHRVRfQUFSQ0g2NA0KPj4gLSBUWVBF
X01BQ0hJTkVfVEFSR0VUX0FSTQ0KPj4gLSBUWVBFX0NQVV9UQVJHRVRfQUFSQ0g2NA0KPj4g
LSBUWVBFX0NQVV9UQVJHRVRfQVJNDQo+PiAtIFRZUEVfREVWSUNFX1RBUkdFVF9BQVJDSDY0
DQo+PiAtIFRZUEVfREVWSUNFX1RBUkdFVF9BUk0NCj4+DQo+PiBJIHdvdWxkIGJlIGluIGZh
dm9yIHRvIGludHJvZHVjZSB0aGlzIGZvciBhbGwgdGFyZ2V0cywgc28gYWxsIG9mIHRoZW0N
Cj4+IGFyZSBpbXBsZW1lbnRlZCBpbiB0aGUgZXhhY3Qgc2FtZSB3YXksIGFuZCB0aGUgcGF0
dGVybiBpcyBlYXN5IHRvIGZvbGxvdy4NCj4+DQo+PiBCeSB1c2luZyB0aGlzIGFwcHJvYWNo
IGFuZCB0YWdnaW5nIG1hY2hpbmVzL2NwdXMvZGV2aWNlcyBhY2NvcmRpbmdseSwNCj4+IHRo
ZXJlIGlzIG5vIG5lZWQgZm9yIGFueSBjYWxsYmFjayBhbnl3aGVyZSwgYW5kIHRoZSBsaXN0
aW5nIGNvZGUgY2FuIGJlDQo+PiBnZW5lcmljLg0KPj4NCj4+IEFzIGEgYm9udXMsIHdlIGNh
biBhc3NlcnQgYWxsIG1hY2hpbmVzL2NwdXMgYXJlIHByb3Blcmx5IHRhZ2dlZCwNCj4+IHNv
bWV0aGluZyBpbXBvc3NpYmxlIHRvIGRvIHdpdGggdGhlIGNhbGxiYWNrcyBhcHByb2FjaCwg
d2hpY2ggb3BlbnMgcm9vbQ0KPj4gZm9yIGEgcG9zc2libGUgZXJyb3IsIGlmIG9uZSBvZiB0
aGUgY2FsbGJhY2sgaXMgYnVnZ3kuDQo+IA0KPiBUaGlzIGlzIGV4YWN0bHkgdGhlIHBsYW4g
KGFuZCB3aGF0IEkndmUgaW4gbXkgbG9jYWwgYnJhbmNoKS4gQnV0IHNpbmNlDQo+IHdlIG5l
ZWQgdG8gcmVtb3ZlIHRoZSBsaXN0X2NwdXMgZGVmaW5pdGlvbiAob3RoZXJ3aXNlIGNsYXNo
KSBJIHdlbnQgd2l0aA0KPiB0aGlzIHN1cmdpY2FsIGNsZWFudXAgZmlyc3QuDQoNCkkgZG9u
J3Qgc2VlIHdoeSBpdCdzIGFic29sdXRlbHkgbmVlZGVkIGFzIGEgZmlyc3Qgc3RlcC4NCk9u
Y2Ugd2UgZ2V0IGludGVyZmFjZSBhcHByb2FjaCBpbXBsZW1lbnRlZCwgYWxsIHRoYXQgaXMg
bmVlZGVkIGlzIHRvIA0KcmVtb3ZlIGNwdV9saXN0IGNvZGUgY29tcGxldGVseSAoaW4gY3B1
LXRhcmdldCkgYW5kIHJlcGxhY2Ugd2l0aCB0aGUgDQpzaW1wbGUgbmV3IGNwdV9saXN0KCkg
ZnVuY3Rpb24sIGJhc2VkIG9uIHR5cGUgdGFnZ2VkIGJ5IHRoZSB0YXJnZXQuDQoNClRoZSBj
cHVfbGlzdCBtYWNyb3MgYW5kIHN0dWZmIGNhbiBleGlzdCB1bnRpbCB0aGVyZSB3aXRob3V0
IGFueSBoYXJtLg0K

