Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D373C47DDF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 14:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTjcm-0003ks-LV; Sat, 27 Jan 2024 09:25:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTjcd-0003jj-2a
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 09:25:30 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rTjca-0007nQ-PU
 for qemu-devel@nongnu.org; Sat, 27 Jan 2024 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706365524; x=1737901524;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=/ZOJsHEuxRDXfnhN5OyDIyF2Gnt9JOQJNKPpEigPpUA=;
 b=SwuXwKBqndfthc7mCWbS0dFkcWqwppmKv5X0it44YX2MiK7ndrP9gXMr
 PEPY/FSf/7HQDpzsVGsGWXjXU6XGJI7Gq1cQWgfvg9AGRnkr6peysmLA0
 d2IGOuScuC3K1gRpKM9SP3APeyD0azwGO8M+lEcuPBYEodKCjx6pFJpaY
 7Sw91CkZMG1kCDibcpr+Okrc3DysZKRlPpannxqSb/d2ifLWpLvdBY4y3
 9R6+cLcPoflGhF8w7EeHZJXIL/1SmMG0ICbiH/m9vQhhJ9vcljezAoZi/
 JEEkVkdsq8gRNaHtfqYrWM87T4Xxf5nvdP8sAfAGKGk19X2BFROE6G7T5 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="393114874"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="393114874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2024 06:25:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821434006"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; d="scan'208";a="821434006"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orsmga001.jf.intel.com with ESMTP; 27 Jan 2024 06:25:21 -0800
Date: Sat, 27 Jan 2024 22:38:24 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 1/2] tests/qtest/xlnx-versal-trng-test.c: Drop use of
 variable length array
Message-ID: <ZbUVYHDKF9XGcQdH@intel.com>
References: <20240125173211.1786196-1-peter.maydell@linaro.org>
 <20240125173211.1786196-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125173211.1786196-2-peter.maydell@linaro.org>
Received-SPF: pass client-ip=134.134.136.20; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -56
X-Spam_score: -5.7
X-Spam_bar: -----
X-Spam_report: (-5.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.282,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 05:32:10PM +0000, Peter Maydell wrote:
> Date: Thu, 25 Jan 2024 17:32:10 +0000
> From: Peter Maydell <peter.maydell@linaro.org>
> Subject: [PATCH 1/2] tests/qtest/xlnx-versal-trng-test.c: Drop use of
>  variable length array
> X-Mailer: git-send-email 2.34.1
> 
> This test program is the last use of any variable length array in the
> codebase.  If we can get rid of all uses of VLAs we can make the
> compiler error on new additions.  This is a defensive measure against
> security bugs where an on-stack dynamic allocation isn't correctly
> size-checked (e.g.  CVE-2021-3527).
> 
> In this case the test code didn't even want a variable-sized
> array, it was just accidentally using syntax that gave it one.
> (The array size for C has to be an actual constant expression,
> not just something that happens to be known to be constant...)
> 
> Remove the VLA usage.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/qtest/xlnx-versal-trng-test.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

> 
> diff --git a/tests/qtest/xlnx-versal-trng-test.c b/tests/qtest/xlnx-versal-trng-test.c
> index cef4e575bba..ba86f39d13c 100644
> --- a/tests/qtest/xlnx-versal-trng-test.c
> +++ b/tests/qtest/xlnx-versal-trng-test.c
> @@ -298,10 +298,13 @@ static size_t trng_collect(uint32_t *rnd, size_t cnt)
>      return i;
>  }
>  
> +/* These tests all generate 512 bits of random data with the device */
> +#define TEST_DATA_WORDS (512 / 32)
> +
>  static void trng_test_autogen(void)
>  {
> -    const size_t cnt = 512 / 32;
> -    uint32_t rng[cnt], prng[cnt];
> +    const size_t cnt = TEST_DATA_WORDS;
> +    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
>      size_t n;
>  
>      trng_reset();
> @@ -343,8 +346,8 @@ static void trng_test_autogen(void)
>  
>  static void trng_test_oneshot(void)
>  {
> -    const size_t cnt = 512 / 32;
> -    uint32_t rng[cnt];
> +    const size_t cnt = TEST_DATA_WORDS;
> +    uint32_t rng[TEST_DATA_WORDS];
>      size_t n;
>  
>      trng_reset();
> @@ -370,8 +373,8 @@ static void trng_test_oneshot(void)
>  
>  static void trng_test_per_str(void)
>  {
> -    const size_t cnt = 512 / 32;
> -    uint32_t rng[cnt], prng[cnt];
> +    const size_t cnt = TEST_DATA_WORDS;
> +    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
>      size_t n;
>  
>      trng_reset();
> @@ -415,8 +418,8 @@ static void trng_test_forced_prng(void)
>      const char *prop = "forced-prng";
>      const uint64_t seed = 0xdeadbeefbad1bad0ULL;
>  
> -    const size_t cnt = 512 / 32;
> -    uint32_t rng[cnt], prng[cnt];
> +    const size_t cnt = TEST_DATA_WORDS;
> +    uint32_t rng[TEST_DATA_WORDS], prng[TEST_DATA_WORDS];
>      size_t n;
>  
>      trng_reset();
> -- 
> 2.34.1
> 
> 

