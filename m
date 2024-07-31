Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B7FC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 05:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ1Sn-0002NR-Ew; Wed, 31 Jul 2024 01:01:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ1SZ-0002Kk-RT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 01:01:16 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZ1SX-0008A4-DS
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 01:01:11 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so3327621a12.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 22:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722402068; x=1723006868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FOYOc9wy62itlpcBQ7DGJQj+MS4yToBJQm0iNdU0Iko=;
 b=Utd2V8dHNzw+h13HKRMgkURSQ8krzTjIgkf1AJostlqqoQxo2Q3pMhNHa7Hzqn8iWM
 iwFTmx/ExBih02p6E4a0rLZqioA2iNNRp6Xg+JFI+DDaxP2oCF9ERG1oD1WfbEihJipQ
 M7/Oing/ZrMgCKuAOOMTLQ151DYAWEtzeprTR8bzA+GBN2Vq79HoLT9R4zd7kS8cAsv/
 ZLg/aRquk8ifxYwXnLqjSkRqFM29DFfr1EZ4EB6o4Q0eNxSnNCOiQu7K7dWB3JF8kafx
 U92hlxHLo5Km1fZI2zyijO7UCIfsUY4c63e2OuAyLEaNMRfaDkGXDvZeIVbkXNsBIm4+
 bm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722402068; x=1723006868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FOYOc9wy62itlpcBQ7DGJQj+MS4yToBJQm0iNdU0Iko=;
 b=O57kSzJVskmjxMhwaNmF60TimqjurrwEHYG6X/D4AQR6e6nPGoG94+K/jsWfeIDqiX
 IVHVfw0B6JXmcXrEggkgtvL5mTmWsqvRpU7ucxG2eVMw7p1pfvCNselcAJhokYGXet8P
 o+rs7CN+9zhsBqp80/3LriDw+Lkz067B6F/eVuWQ0nCf8AT5BAYGO7ZMrK9ZtBOhSknd
 uRGF+7VApMQyOaM+daiEbIFTsj1c1eJ7yNakupZlBnZc0ykw8BnuDYcbeoC2eNNm6BqL
 dnmrza/+reT1c1Hm9MFxsxltQpNy0lx/BZDIRgQxDuretU7W7EW/F6u+W7if/OBgpq2Q
 D3Yw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjK22sxiTapdJplQs+bwaj6VBrBy7zX4vW94NRu4+K3WYU5CnO604jEyOmprr9AoQNirApqPm/YIJ1kJqZcEOWFkQhKwA=
X-Gm-Message-State: AOJu0YwIMgGwnnlvA61Y42ENgPsUi6RoSXSyxAqmciuSVgulF87DJMDi
 dLYTRJB1L1DXEwrSL8vXKcS6o0UBykObDE+V9whogup58IgpM+6J3CgV+eZFQ3Q=
X-Google-Smtp-Source: AGHT+IHJNx0xz8JMLS6pVjfbm8vT2FXiML9t3PLr7jnFXMRBiSfpE/mX2BMQmi2KadKgBbPlpOk7Dw==
X-Received: by 2002:a05:6a20:9e4b:b0:1bd:1df4:bd43 with SMTP id
 adf61e73a8af0-1c4a14fdcd6mr11195544637.54.1722402067658; 
 Tue, 30 Jul 2024 22:01:07 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:7406:659b:9ac8:69bb?
 (2403-580a-f89b-0-7406-659b-9ac8-69bb.ip6.aussiebb.net.
 [2403:580a:f89b:0:7406:659b:9ac8:69bb])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7c7f650sm111333505ad.59.2024.07.30.22.01.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 22:01:07 -0700 (PDT)
Message-ID: <354740c0-ac02-4be7-bf02-2b38ef55f807@linaro.org>
Date: Wed, 31 Jul 2024 15:01:00 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/24] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-10-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240730170347.4103919-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/31/24 03:03, Daniel P. Berrangé wrote:
> Many tests need to access assets stored on remote sites. We don't want
> to download these during test execution when run by meson, since this
> risks hitting test timeouts when data transfers are slow.
> 
> Add support for pre-emptive caching of assets by setting the env var
> QEMU_TEST_PRECACHE to point to a timestamp file. When this is set,
> instead of running the test, the assets will be downloaded and saved
> to the cache, then the timestamp file created.
> 
> A meson custom target is created as a dependency of each test suite
> to trigger the pre-emptive caching logic before the test runs.
> 
> When run in caching mode, it will locate assets by looking for class
> level variables with a name prefix "ASSET_", and type "Asset".
> 
> At the ninja level
> 
>     ninja test --suite functional
> 
> will speculatively download any assets that are not already cached,
> so it is advisable to set a timeout multiplier.
> 
>     QEMU_TEST_NO_DOWNLOAD=1 ninja test --suite functional
> 
> will fail the test if a required asset is not already cached
> 
>     nina check-func-precache

ninja or make, precache-functional.

Anyway, thanks for this.  I can confirm that it works, and that it takes ~50m to finish here.

Tested-by: Richard Henderson <richard.henderson@linaro.org>

r~

