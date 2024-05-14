Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 066C8C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 17:50:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6wID-0004Fm-QE; Tue, 14 May 2024 13:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s6wHl-0003mO-NQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:50:01 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1s6wHg-0006fR-BQ
 for qemu-devel@nongnu.org; Tue, 14 May 2024 13:49:54 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f44390e328so5436320b3a.2
 for <qemu-devel@nongnu.org>; Tue, 14 May 2024 10:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715708989; x=1716313789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sjrcA5Fj2b+MC4h5XtU0XYzKUktroJ81yE0TTUdVf2U=;
 b=Ej1GC1e8ASlm8ISBEGKsShhmwk8X3EzyrfyuDiRE8pQZap+9jkXB1WPAFZ5GeL47qd
 a6kIV9hTEVJkazU0l0ZO+mf52zyCMuMEHb0Qt7vTvEudLNSKnqG0nVv6344Xx/2NV89c
 1/4R0bC/N9CrVnfyzyT/7WGCns/T7BK9evPY3BcX7Go7+7K1LauoeSlcLZj1/8KncyF/
 HNPxSKXT4+Xe6La54VSXRmbcE9inQCb6ekBvb0JI5TV8th9kpUt/s9li8JK/MMeNtikK
 5wKibC01hrRqHQVcoJQiUG95ISSgemwmJx7BM48IUjpdvv7pEJpqiUPDmZyhMMTsPi0y
 5kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715708989; x=1716313789;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sjrcA5Fj2b+MC4h5XtU0XYzKUktroJ81yE0TTUdVf2U=;
 b=nWKDqQi7uBjTq6Jgt3VF0HD5h/4WXXw8/2EHmKoXKfzRY9lzJNV+Jxye0J3rraMkk9
 PMpdxGF/Dg/DQSs07wzUNGtmcVuwwEW9kW8nPiTb8juiDgcwSUdoWpiaxQhF6ms3Q1W4
 xTIdLeaDmh76Cndp+Z+raIIecCy1lEnod6iSwKbGgPo8fvHqIUGsYSVYUiV3e5Jv8bkT
 M90pHR3zG95cxyEhtoIYs907XyAKmV8pARzMh9Zaw+D3NMZCgUoKGLucqAE0jb5ElcSr
 gXvh0vGafEHcx5vHOHDN/trlyqEWhfHFlaX6xiBx9zCjBVqO1oNXtmi9cP0zj8NWF0e0
 0atQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9SLRSQgu6OuPFtUZ8la6zbVtgn1iqb2urUwS6sF9EwvyVPKsd3A54VldmUo2nE5NSP+DIs919yEWm3hkucEK0GadxMWg=
X-Gm-Message-State: AOJu0YyF5kN+WlJjJkel3eoXPQajZDSExKP+gz1fEV0WEziU63sl0Du0
 bpElIJ2MGHxvig6tXc51H1zyjG46QlXtN7kePbcGB76N9x/xljXJI8KMdXRVso4=
X-Google-Smtp-Source: AGHT+IEvODmR+AcVDR3P5T8y4cv1tO2xgFKLwwjUteCCcbrppAcXNVkdd51HQWV7VVMg5QxVKTJjdg==
X-Received: by 2002:a05:6a00:391a:b0:6f3:876a:c029 with SMTP id
 d2e1a72fcca58-6f4e02ac99bmr19244972b3a.10.1715708988983; 
 Tue, 14 May 2024 10:49:48 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::e697? ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f4d2a66585sm9726562b3a.10.2024.05.14.10.49.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 10:49:47 -0700 (PDT)
Message-ID: <04ba223b-4e09-4424-a3ec-640f6115c65b@linaro.org>
Date: Tue, 14 May 2024 10:49:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] tests/tcg: don't append QEMU_OPTS for armv6m-undef
 test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20240514174253.694591-1-alex.bennee@linaro.org>
 <20240514174253.694591-2-alex.bennee@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240514174253.694591-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

T24gNS8xNC8yNCAxMDo0MiwgQWxleCBCZW5uw6llIHdyb3RlOg0KPiBXZSBkb24ndCB3YW50
IHRvIGJ1aWxkIG9uIHRoZSBkZWZhdWx0IG1hY2hpbmUgc2V0dXAgaGVyZSBidXQgZGVmaW5l
IGENCj4gY3VzdG9tIG9uZSBmb3IgdGhlIG1pY3JvYml0Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiAtLS0NCj4gICB0
ZXN0cy90Y2cvYXJtL01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0IHwgMiArLQ0KPiAgIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL3Rlc3RzL3RjZy9hcm0vTWFrZWZpbGUuc29mdG1tdS10YXJnZXQgYi90ZXN0cy90
Y2cvYXJtL01ha2VmaWxlLnNvZnRtbXUtdGFyZ2V0DQo+IGluZGV4IDRjOTI2NDA1N2YuLjM5
ZTAxY2U0OWQgMTAwNjQ0DQo+IC0tLSBhL3Rlc3RzL3RjZy9hcm0vTWFrZWZpbGUuc29mdG1t
dS10YXJnZXQNCj4gKysrIGIvdGVzdHMvdGNnL2FybS9NYWtlZmlsZS5zb2Z0bW11LXRhcmdl
dA0KPiBAQCAtMTYsNyArMTYsNyBAQCB0ZXN0LWFybXY2bS11bmRlZjogdGVzdC1hcm12Nm0t
dW5kZWYuUw0KPiAgIAkJJDwgLW8gJEAgLW5vc3RkbGliIC1OIC1zdGF0aWMgXA0KPiAgIAkJ
LVQgJChBUk1fU1JDKS8kQC5sZA0KPiAgIA0KPiAtcnVuLXRlc3QtYXJtdjZtLXVuZGVmOiBR
RU1VX09QVFMrPS1zZW1paG9zdGluZyAtTSBtaWNyb2JpdCAta2VybmVsDQo+ICtydW4tdGVz
dC1hcm12Nm0tdW5kZWY6IFFFTVVfT1BUUz0tc2VtaWhvc3RpbmctY29uZmlnIGVuYWJsZT1v
bix0YXJnZXQ9bmF0aXZlLGNoYXJkZXY9b3V0cHV0IC1NIG1pY3JvYml0IC1rZXJuZWwNCj4g
ICANCj4gICBBUk1fVEVTVFMrPXRlc3QtYXJtdjZtLXVuZGVmDQo+ICAgDQoNClJldmlld2Vk
LWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQGxpbmFyby5vcmc+DQo=


