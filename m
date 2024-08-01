Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA276C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 16:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZYF1-000653-CH; Thu, 01 Aug 2024 12:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYEr-0005V5-Ci
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:01:15 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZYEp-0000iE-AR
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 12:01:13 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-58ef19aa69dso7702160a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 09:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722528068; x=1723132868; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=C7XiHRxBjUr+HUlbfd+0KbWq7BgvR1k3pX23yefkUgo=;
 b=LkXax9p2knc6Hvc9lRATe4YEXfZgN0N60q/jm5mlR57+AdRU3zm+MbWGV/c5NNK7+K
 zZmRsD4sUXRrX5OTMUyYkhaRzLRZ8BJIEznlv75g/dADWNDqF3AgJ1AWhgqBBaK76Yf7
 cVbtQnzvC+S/1F/Cl/PKEtSCRbvWGp/hLya4RmDWWCc3aoVmsNVcsM2xp+mLdhRHaTds
 meTxw6y3EmzGid7n9ZafOKcjwGNkw/wRmEfjMLs2PIWP1pQY2IM19IcRNvwNLXAfXmj5
 +2Y3KpRljjItL8R2mdB7bqcVhMn95JkklWkmoaEIV2kjakoY3CiCHRc4fyUgLyrVgyZK
 4bmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722528068; x=1723132868;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C7XiHRxBjUr+HUlbfd+0KbWq7BgvR1k3pX23yefkUgo=;
 b=AdoFQdvAlO9cSuL8CN9hS7Q7ENe5crsELeMIJYC47CKKs1x5+AelTjasOgJgaXkUJu
 S0+IrxF1RCdpxAzEaMoU3GcrIVm/8ZPAihPsjOucfjrxMWAJkbWIIjZPzWBh1y4OOT8b
 zMnIWIumIpoFoMjGvauV8Xf/RGY4YcGUzD1CPgNCLczAFgTj67iDtV/q3Qvi0TC9fBIL
 3PtQdR2U0kHOotDcEu52GbltKprw5u/7z0vZLGhJKO18FCqGjVj5uKo7Ev2+uJbpjj85
 BR2AIsE5DkjRsjMgs+DZDpuTJHlH1aQUxVAwVejK8a83123ia1CsBJzqErJZQKfbLR6z
 YCIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMTVqQ1vzI5B57IVhSXGBGFNm/EHVn90C7jLWdx2mn6I/Pf2aL545Zn22c3fzwbHG1k2Dwdp42ihIJ3fWK5G24/sG6nUc=
X-Gm-Message-State: AOJu0Yzo9sT7Qp6e6wJnNlbIzXUJtOJQrNvvhV8Z9hqtRs6vRNqo3u5f
 NRZJJvG0jCHA7XZx2u2znaDGxChqrBBgQ0HXlszY7107j8dMURSOze8O7O5ov8M=
X-Google-Smtp-Source: AGHT+IGaj3B/duKhhxZ4FsGcSTinvWiS87drMiQb6i/TJ8a7YjvDRaaLk/ys/EF7kIsrp3y6DNLPfw==
X-Received: by 2002:a50:e602:0:b0:5a2:763e:b8bf with SMTP id
 4fb4d7f45d1cf-5b7f53146d9mr592296a12.25.1722528067969; 
 Thu, 01 Aug 2024 09:01:07 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6377d005sm10310179a12.38.2024.08.01.09.01.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 09:01:07 -0700 (PDT)
Message-ID: <3d157a13-f256-4344-8d17-2babd6e99a54@linaro.org>
Date: Thu, 1 Aug 2024 18:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/24] tests/functional: enable pre-emptive caching of
 assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-10-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
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
> 
> will download and cache all assets required by the functional
> tests
> 
> At the make level, precaching is always done by
> 
>     make check-functional
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/Makefile.include                 |  3 ++-
>   tests/functional/meson.build           | 33 +++++++++++++++++++++++--
>   tests/functional/qemu_test/asset.py    | 34 ++++++++++++++++++++++++++
>   tests/functional/qemu_test/testcase.py |  8 ++++++
>   4 files changed, 75 insertions(+), 3 deletions(-)


> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 27bbf4a0af..21dbd90613 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -21,6 +21,7 @@
>   from qemu.machine import QEMUMachine
>   from qemu.utils import kvm_available, tcg_available
>   
> +from .asset import Asset
>   from .cmd import run_cmd
>   from .config import BUILD_DIR
>   
> @@ -58,6 +59,13 @@ def tearDown(self):
>           self.log.removeHandler(self._log_fh)
>   
>       def main():
> +        path = os.path.basename(sys.argv[0])[:-3]

This line should be added here in patch #2 in order to
avoid ...

> +
> +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
> +        if cache is not None:
> +            Asset.precache_suites(path, cache)
> +            return
> +
>           tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>                                      test_output_log = pycotap.LogMode.LogToError)
>           path = os.path.basename(sys.argv[0])[:-3]

.... this duplication.


