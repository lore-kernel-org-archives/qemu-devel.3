Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2672C3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 23:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWlWB-0005Ne-I4; Wed, 24 Jul 2024 19:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWlW9-0005KG-6k
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 19:35:33 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWlW7-0005D9-K0
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 19:35:32 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-261112c303bso175428fac.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 16:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721864129; x=1722468929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NsGy5DAXNO4UuQpXHslqmh+ZdlGmA8wll75BeRCN12s=;
 b=MBuo8qQBy19MswPKKALDGaQIWiHrhOGau4LZMPwV2FyfBgdUXAjsJES+Z0nEA9m7xY
 jrCaXfjysd8LfkwZV+sYgH6IiuxWk2VCzvwZddXDr4CHRv70t+7W9WDpMcxnqEu+sGoX
 UnDm0uHS76u/keTP0ORNqB0Ze/wQQczYp1u3i3zddwUGa7Apk7yOtEOoYRUmT7yJmo0e
 YNkTbiZ+MnZb0DdnDrSHnb05p4AZbNV7b8Ml7oByRbeBvNMz8H64OOUDPr6xSc5m0Ru/
 Kc7NgO/b4nIZKm7M17XfGUpCSOixBdKmLzCyJ5wCyZCU2kis6oCO5aK3kbWZZlv/StfF
 JVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721864129; x=1722468929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NsGy5DAXNO4UuQpXHslqmh+ZdlGmA8wll75BeRCN12s=;
 b=X4ijXXKxtMXusrXGuLdtLZhsNVBXTme4NhXAv2le6XFUqxMfoxghKIrzpNYO61gFrH
 FPT2ujWgSqHGbxjs8AGxmheh/wj1/f7KAYzObMFy5Clx1kNC82vKEEdhgG2HoXdt7vCI
 mb4tVXdxYyqqb5jQfkIQhMX/ubn8c14MmPyXm/6NqkiDu7yGnjBmRbjcFgd4IHAAndFQ
 qaFKzD9Wi1p4aUc4GeOIQqPrUEJvqRrfbGoyLQbCcKCd3n7rolmu3e8nRvg+1b/ZQ3Ps
 e0DvTItbDXxClERu8Gau1Cx7TQbrQQrjT30QE9bcPg+RPEf9AvKHrew3FSsUzDdTlCAe
 hIYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU642Lp+fiqDQOxlQS/TqwErrH83iMTG7vE5EyChA0OTKUv4gPB/pWd0w6LqHvc+ZlNyJkIhJIOrVg02iqkGGVh/hA/OJ4=
X-Gm-Message-State: AOJu0YzYkr334dL/jHdEBc6gE6RK4AFPo1vH+gBHn7L9MfKUhRIrdZE3
 SDRiJD/CloYwuzYeYx7g4XfLy5F4EJb0A6szQ6/KoTGDFCD2uGMem6Vld/ZowCs=
X-Google-Smtp-Source: AGHT+IGlKayIOTWl9btYZ6oOKY2bw5GHm7I10gzvd4VsjZt2oNCRboAXQMTH4H8oTf1AEiLiDwcr0Q==
X-Received: by 2002:a05:6871:80d:b0:261:9c7:a0bb with SMTP id
 586e51a60fabf-266ede2a4damr258042fac.48.1721864129338; 
 Wed, 24 Jul 2024 16:35:29 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead86ff3csm107999b3a.147.2024.07.24.16.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 16:35:28 -0700 (PDT)
Message-ID: <6d609ff1-c4df-4960-be5f-4b29c5911879@linaro.org>
Date: Thu, 25 Jul 2024 09:35:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/23] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
References: <20240724175248.1389201-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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

On 7/25/24 03:52, Thomas Huth wrote:
> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
> 
> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
> 
> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel (e.g. the timeout settings work completely differently).
> 
> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset so
> far, but this already proves that many tests only need small modifi-
> cations to work without Avocado.
> 
> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> classes (e.g. based on cloud-init images or using SSH) really depend
> on the Avocado framework, so we'd need a solution for those if we
> want to continue using them. One solution might be to simply use the
> required functions from avocado.utils for these tests, and still run
> them via the meson test runner instead, but that needs some further
> investigation that will be done later.
> 
> 
> Now if you want to try out these patches: Apply the patches, then
> recompile and then run:
> 
>   make check-functional
> 
> You can also run single targets e.g. with:
> 
>   make check-functional-ppc
> 
> You can also run the tests without any test runner now by
> setting the PYTHONPATH environment variable to the "python" folder
> of your source tree, and by specifying the build directory via
> QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
> QEMU binary via QEMU_TEST_QEMU_BINARY. For example:
> 
>   export PYTHONPATH=$HOME/qemu/python
>   export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
>   export QEMU_BUILD_ROOT=$HOME/qemu/build
>   ~/qemu/tests/functional/test_virtio_version.py
> 
> The logs of the tests can be found in the build directory under
> tests/functional/<arch>/<testname> - console log and general logs will
> be put in separate files there.
> 
> Still to be done: Update the documentation for this new test framework.

I'll say again that the download *must* be handled separately from the test with timeout. 
This is an absolute show-stopper.

I've tried this twice now, from a decently fast connection in central Brisbane, and have 
had multiple downloads be canceled by the timeout.  Since the download isn't clever enough 
to pick up where it left off, it will never succeed.


r~

