Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D509C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:41:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRYK-0001g6-Ig; Mon, 29 Jul 2024 10:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRYJ-0001ck-MK
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:40:43 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYRYI-00081n-3H
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:40:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso17621565e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264040; x=1722868840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j3e9b1ZbsCUPjFEgRqJ+hwXbs28Kkpn08+Yw7FV+otA=;
 b=LF36nJH/Q1g1SbvOzbLzR6BZ8ED3F4gb43syzDdFk+KmlR7ABUNTOv3o1LP4/uj6Nb
 XtoyEITjbBHM5oE/hEa55KwtMKXv+mNsNhG0p/hG3Of8xdm1mOJ0IqPEMwSbf481vK8M
 T8I54dIWtLkrrh9S9TE5QxXKMvpIr6jNT80x6G92UTvxyn/4KUOKt/cfo5hQkM0DNP86
 +Wn8wy4d2UG7djzgts419a+QTeA/SfsCPZ1E2UNENNVpC71ZeRuTE/IQTNxu0fGNq9TH
 14sOhbdoFmIX2VwuaCkIskWe3RDEUWNRQzZztg8rB1tIL6grzNp8/ShqlfiyhHNDMPiK
 3GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264040; x=1722868840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j3e9b1ZbsCUPjFEgRqJ+hwXbs28Kkpn08+Yw7FV+otA=;
 b=UIsO2urHrAAATTNMN46IeXJ/FCYRAfg3xyi8PzWC4b61UyOmLGAKIx6zVD3uLNM/Pg
 xoqriyNX5UJBfpAz+F8x2OJ9iPDoYiwbkpPqmI8iZTQdceSYRgUYaPlyr7Mwlas3RV9l
 T77fneAiz5pcZANNp/F3vBpHIgNpmxhHxhvlneiwix/Td/QvB1LHnEWcX8W6+UoBofw8
 9IdR4cCCwnHZlV+yafzVRYBoDBJ9cp5HNwTaiJkLG9Dbrat6EZpJwD3rWisLed5BbtTW
 AwkMYsS4mlvCs/RXo5i+q31BWJXhV4KXP1Ysy+uVT1Z55EyWQdeD0kVtpjcEVDh1OAAV
 x8Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVF0eexQ2syQMf+/cSSL55fz4NDMJoiWjkPUiIhBXX6wITxEhqGAmuyZnwMmVFFWQRrOB825AYCgoMkAbmwGETfx1BntXo=
X-Gm-Message-State: AOJu0YzymnABxcBJlp+ERKV+oYM8VOBLF6d2OxxzdlO5vrjS7MUIb36d
 jqwxlJmS5muz617r7HHoXCo1FeLBLo7jOvoABBv+h3AigJHlfevJJ6i87VbqWgc=
X-Google-Smtp-Source: AGHT+IFHgcVZBSsqx+kJWyuBFGP6dDtPg8rYuEWdm5awfdO3TlQSRElWHr7IrKK+DGDGkjwxVHIITg==
X-Received: by 2002:a05:600c:3ba6:b0:426:6667:bbbe with SMTP id
 5b1f17b1804b1-42811d89a5bmr62687045e9.9.1722264039627; 
 Mon, 29 Jul 2024 07:40:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428218a3934sm2651625e9.45.2024.07.29.07.40.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 07:40:39 -0700 (PDT)
Message-ID: <0977da6d-53c9-4ea4-a099-531d76258dfd@linaro.org>
Date: Mon, 29 Jul 2024 16:40:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Bump Avocado to 103.0 LTS and update tests for
 compatibility and new features
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240726134438.14720-1-crosa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 26/7/24 15:44, Cleber Rosa wrote:

> Cleber Rosa (13):
>    tests/avocado: mips: fallback to HTTP given certificate expiration
>    tests/avocado: mips: add hint for fetchasset plugin
>    tests/avocado/intel_iommu.py: increase timeout
>    tests/avocado: add cdrom permission related tests
>    tests/avocado: machine aarch64: standardize location and RO access
>    tests/avocado: use more distinct names for assets
>    tests/avocado/kvm_xen_guest.py: cope with asset RW requirements
>    testa/avocado: test_arm_emcraft_sf2: handle RW requirements for asset
>    tests/avocado/boot_xen.py: fetch kernel during test setUp()
>    tests/avocado/tuxrun_baselines.py: use Avocado's zstd support
>    tests/avocado/machine_aarch64_sbsaref.py: allow for rw usage of image
>    Bump avocado to 103.0
>    Avocado tests: allow for parallel execution of tests

Queuing patches #1, #2 and #8. Unfortunately #10 depends on Avocado
101.0 so can't be merged at this point.

