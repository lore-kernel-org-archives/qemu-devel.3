Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF6AC369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 03:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5cV3-00050I-Dk; Thu, 17 Apr 2025 23:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cV1-000503-1d
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:34:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u5cUy-0004xD-PF
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 23:34:42 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-227c7e57da2so14298285ad.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 20:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744947278; x=1745552078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dk//PZHbVCGAWKAoM0O9gXWGCfbG5S78q7J42hqey0o=;
 b=zlLBQtekOXWeW6wew51d4zHJ6d5jnIe6W9MBzTOL4kWuGhUyIzNxfpaMXNc1qK8avk
 CsBP7mNf0zd+Pi2PW8d+6fong3Y0mCBHrpCL2C8/egnsjr2/HDRGtUU73G56cDIhYrRt
 Ya67WA9eOwDO6vA8bKg/BFKYWiy6niB56SUYVON9lPwXpEF6oQsB+rh+KI3tkFVa7OH/
 ZyQbTrF1GeFdCn/49g+toydNHbQaRuZR5TBCwlEDmlAo3TuZgjM/b66pCcGja7mMHRXH
 DyNf9cMMN8ROFsP9cQCaLOvNNwfU3NPSNiwk/m9OoA0mpc/mpL6454KWB5uqCMI1b9/Q
 ISNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744947278; x=1745552078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dk//PZHbVCGAWKAoM0O9gXWGCfbG5S78q7J42hqey0o=;
 b=jkNucVyibJlcWiK5VVVKu25euab0iqfI1x2PyPGA75A93fsuc0CN0eTQ3Cra3svZ2E
 KqdDKzgr1fDOxnmygzoMRANgfm8wRIQe61z0VPikf69hKIFYLPtAk/MZoBUvhU7Bj99t
 dModLye9rLAcnCGDbkL50BMsijAVe06RbDyxHnKrFzyx88zzrtX0DECJZVHveR/T8J/H
 kp2zZhzZ5d4e0owKkpk3+vkVyQ4TlFFZJaDyBj7xHtMPxNHVg4FFcl24d2rKXAN3VAjY
 nkYfRaSIoTj7uGqQImlSjLdwh9yrnlToqaWDAMUSahZAewR0x8bEOF00aWgvS7hIbEi0
 ZT6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqB4xc9H9GhsFRneqphRxpHjT+Rq3zJ7Xx0Ntv5VvBqgHNltkeWVhq4zAVvc4xmy30RoWoAJO/RPhc@nongnu.org
X-Gm-Message-State: AOJu0YxxcjtfJg1sC2LkUvUqlDP+dkWXMnaSTA+sVezXKp4PFyiXpiSz
 gB0+tePa7yOHFhEt4anqHPmP4KAgTQvbChPc9pw7eNDBPVV4S3Gvh7Rd7zuK7jM=
X-Gm-Gg: ASbGncskoP2uZDUhpVnZrZkQbWCpcXPj1e2yXQqyYWI4uWE3kIgGlBbqCjaRRtJzgHz
 GxrClJE6ZI95OC9kuVtmO7YHTgHvJLLrhhQ+sq6FvYZpTzBb/SpJepel77A9otSgwt+8y6yP4nV
 v0uTWr6XMVL5M+kxHebLCQx3hb5rVWTMMwlbch4unWKDIobsWX3XPECyQ2yzU7dmX/Q1t7p70ma
 2FOHj50NyygShAtNdshR9MuNEYysOqnVdtHq0ShX59L5NbU6bGHVwLQpD3FOr6e+w4eMqbOll2b
 ZM4kn0Ps0znzcZMwNijBHENYpHgcq3d+y4kXP7hzornvFtPJDt1zyQ==
X-Google-Smtp-Source: AGHT+IG4nZpy6cO0yJs5hUGJbNRccrfTlxiyk4KBTDIGKW0vVOAEfNSZSKpqAlXS0ra0YRMJ5nMBgA==
X-Received: by 2002:a17:903:1aa8:b0:225:ac99:ae0d with SMTP id
 d9443c01a7336-22c53285c0amr20502005ad.10.1744947278351; 
 Thu, 17 Apr 2025 20:34:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50ecee56sm7882615ad.195.2025.04.17.20.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 20:34:37 -0700 (PDT)
Message-ID: <74ceed6c-9701-4969-9871-457aa5c7e0e5@linaro.org>
Date: Thu, 17 Apr 2025 20:34:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 09/11] config/target: Implement per-binary
 TargetInfo structure (Aarch64)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250418005059.4436-1-philmd@linaro.org>
 <20250418005059.4436-10-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250418005059.4436-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

T24gNC8xNy8yNSAxNzo1MCwgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6DQo+IElt
cGxlbWVudCB0aGUgVGFyZ2V0SW5mbyBzdHJ1Y3R1cmUgZm9yIHFlbXUtc3lzdGVtLWFhcmNo
NjQgYmluYXJ5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUGhpbGlwcGUgTWF0aGlldS1EYXVk
w6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICBjb25maWdzL3RhcmdldHMvYWFy
Y2g2NC1zb2Z0bW11LmMgfCAyMiArKysrKysrKysrKysrKysrKysrKysrDQo+ICAgMSBmaWxl
IGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgY29u
Zmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29u
Zmlncy90YXJnZXRzL2FhcmNoNjQtc29mdG1tdS5jIGIvY29uZmlncy90YXJnZXRzL2FhcmNo
NjQtc29mdG1tdS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAw
MDAwLi5lNDhhYzI2NGQ3ZA0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmZpZ3MvdGFy
Z2V0cy9hYXJjaDY0LXNvZnRtbXUuYw0KPiBAQCAtMCwwICsxLDIyIEBADQo+ICsvKg0KPiAr
ICogUUVNVSBiaW5hcnkvdGFyZ2V0IEFQSSAocWVtdS1zeXN0ZW0tYWFyY2g2NCkNCj4gKyAq
DQo+ICsgKiAgQ29weXJpZ2h0IChjKSBMaW5hcm8NCj4gKyAqDQo+ICsgKiBTUERYLUxpY2Vu
c2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KPiArICovDQo+ICsNCj4gKyNpbmNs
dWRlICJxZW11L29zZGVwLmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1pbXBs
LmgiDQo+ICsjaW5jbHVkZSAicWVtdS90YXJnZXRfaW5mby1xb20uaCINCj4gKyNpbmNsdWRl
ICJjcHUtcW9tLmgiDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBUYXJnZXRJbmZvIHRhcmdldF9p
bmZvX2FhcmNoNjRfc3lzdGVtID0gew0KPiArICAgIC5uYW1lID0gImFhcmNoNjQiLA0KPiAr
ICAgIC5tYWNoaW5lX3R5cGVuYW1lID0gVFlQRV9UQVJHRVRfQUFSQ0g2NF9NQUNISU5FLA0K
PiArfTsNCj4gKw0KPiArY29uc3QgVGFyZ2V0SW5mbyAqdGFyZ2V0X2luZm8odm9pZCkNCj4g
K3sNCj4gKyAgICByZXR1cm4gJnRhcmdldF9pbmZvX2FhcmNoNjRfc3lzdGVtOw0KPiArfQ0K
DQpZb3UgY2FuIHNxdWFzaCB0aGlzIHdpdGggc2FtZSB0aGluZyBmb3IgYXJtIHRhcmdldCwg
YW5kIHNwbGl0IG1lc29uIA0KY2hhbmdlIGluIGFub3RoZXIgY29tbWl0Lg0K

