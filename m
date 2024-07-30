Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65A7C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 10:05:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjj6-0002w2-9t; Tue, 30 Jul 2024 06:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYjj4-0002nu-5K
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:05:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYjj1-0004W1-VJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 06:05:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4280c493719so23130085e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722333897; x=1722938697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G3RIWcZxkMfLWwQCSQnSZ4xXe+GqCSXMBgRM3Bc5hzE=;
 b=Y3PRKCEzrflwBCj/cME+GhRKltnQ5JZ4Nx1aZeRCxYJCFFNTW24NjW05fi1iO8z34P
 sksYnVRbWXInh/VCf5TwhI49TVdU9SQFoh8H/PUsBgBJf2qReGUkfIpXsEC/nrJKJW7D
 6WrPN5KVq8vJpp9kU7l0EOLvSUyGTkD8mO/sxa+HGFtTA8zhyQIRPNcmSQXJWE83unIv
 yPwIZkv39I4U6F/hNLvBTHXgZ0h+LHwBthZvsQiIYN2GUqL4Kh3Yx/GY820inx3IbkSq
 vlpY+6Xxp+++u/N5KoVcJSWdYXDPln0tRbrvG7yU6SfERy32QPT50gBhLLXsbTST1bFB
 zN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722333897; x=1722938697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G3RIWcZxkMfLWwQCSQnSZ4xXe+GqCSXMBgRM3Bc5hzE=;
 b=o3aT4J4MYCfoD7BiX3X7y8usxoT8ZXZdw25w+k/usOAltJaxnCO/udtonkuqiR95fk
 XAuUAIPyakA1eGyLGcq2G02LK5zsbD5ODc1fqNwlWn5GIAqEyTNmGdcD0W+Xo9f1C7UE
 cjmxzXfkUHx/3OK6rDawKuJDYgaU3qPoUdd2lj0qH4AQ8h0Q9TvCAWao4vFHFzP6f55c
 z2xReFTPrIOvA43UjZu+hoQAjq/kOjhLuPcdad/A62aj+W6x+zD5u82OR5KTm+4gnWmr
 kLqX+4HUcV5jWFSa6QqhSgFyMVEJyvHIZQVrYhyHDXq3gD4q9Ug/Z0DNeCcgc15etQen
 491A==
X-Gm-Message-State: AOJu0YxOmLFMe6+i6TO2W435m4XsQXuKUA+aEMh8WX/qvV0XZ0dQ92aB
 DDS/RUxIkg84TlGjiqqCIYatJDwAgej+Zg+qVLpk+Klnb+UwTmMORDwALE6XkPeIqoPwdtLDAGj
 Il/0=
X-Google-Smtp-Source: AGHT+IGXjgKXtNLsLDOYZcXhqEn6yb6KKizlFhRItd8wJx36v3XVISsqR2J4FJ2jesl7DzQLo4X5aA==
X-Received: by 2002:a05:600c:4fc8:b0:427:9a8f:9717 with SMTP id
 5b1f17b1804b1-42811a9e14dmr80535755e9.0.1722333897140; 
 Tue, 30 Jul 2024 03:04:57 -0700 (PDT)
Received: from [192.168.177.175] (82.red-88-28-10.dynamicip.rima-tde.net.
 [88.28.10.82]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4281fd619b6sm46478825e9.12.2024.07.30.03.04.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jul 2024 03:04:56 -0700 (PDT)
Message-ID: <d211f9c9-bef6-42b6-8bd8-8ef9cc7d6a29@linaro.org>
Date: Tue, 30 Jul 2024 12:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/14] Docs / testing patches for 2024-07-29
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20240729152714.10225-1-philmd@linaro.org>
 <Zqe2-4B8_qs3Oq0K@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Zqe2-4B8_qs3Oq0K@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/7/24 17:36, Daniel P. Berrangé wrote:
> On Mon, Jul 29, 2024 at 05:27:00PM +0200, Philippe Mathieu-Daudé wrote:

>> Thomas Huth (9):
>>    python: Install pycotap in our venv if necessary
>>    tests/functional: Add base classes for the upcoming pytest-based tests
>>    tests/Makefile.include: Increase the level of indentation in the help
>>      text
>>    tests/functional: Prepare the meson build system for the functional
>>      tests
>>    tests/functional: Convert simple avocado tests into standalone python
>>      tests
>>    tests/functional: Convert avocado tests that just need a small
>>      adjustment
>>    tests/functional: Convert the x86_cpu_model_versions test
>>    tests/functional: Convert the riscv_opensbi avocado test into a
>>      standalone test
>>    gitlab-ci: Add "check-functional" to the build tests
> 
> On the avocado review I mentioned that I didn't think we should
> be rebasing avocado during freeze. By the same token, I'm not
> convinced we should be introducing a new test framework during
> the freeze period.  This is alot simpler than avocado, but at
> the same time this small subset of Thomas' patches isn't really
> fixing any problem on its own, as avocado still exists in
> parallel.

- As you noticed, Avocado isn't rebased here
- The python file added is almost a copy of the avocado base class,
   already well tested
- Test are moved from Avocado, so no waste of time running them
   twice
- macOS developers can run 178 functional tests. This is the big
   win and time saver for me.

Do you really see merging these few patches now as being
counter productive for the community?

Regards,

Phil.


