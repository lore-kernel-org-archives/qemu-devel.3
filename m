Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63796CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4gE-00068W-GM; Mon, 15 Sep 2025 04:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uy4g9-00067w-9r
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:35:17 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uy4fv-0001Zd-HC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757925304; x=1789461304;
 h=message-id:date:mime-version:subject:to:references:from:
 in-reply-to:content-transfer-encoding;
 bh=/9PJ1K+OzJlk/FnmySP3KZrbuF7EVj7K6V9EIrZpGo4=;
 b=EdmHPhFdkXIXzFHPHrGAj5suBuUf5IZvxdQshYU3tkuKnnHselD0mWzh
 tjXaRJoxTORSiJBTs3Z+bSn89Uo35Xn2mh7uef1MegBmUIdCzfAEGtMbd
 omn9qJ6dT5JuAnF4lGybFkiTpoNcZDGM0NAtT+qo7jST0vxO+JiupImIN
 eaM3YwiLFrIndemrx48+m0XvkgIUe2UnTYLVAcv/q1YALRKNzpuyn1pJ/
 7e+m8VnU+acKtD6QhzuyMVrHa7qqV9gMtbG7ySEhMZwOqaWeVLfodsZgg
 iCagFh8kMZBqNOjwq79sCS2LPit9qirn8I8Nq1PNKDjoxV3sGfmeOWV2R A==;
X-CSE-ConnectionGUID: kPb0MS8kQb2BGOowoKzmiA==
X-CSE-MsgGUID: 3caqkmzxRkGQjfBA/HoL/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11553"; a="59213062"
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="59213062"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:34:57 -0700
X-CSE-ConnectionGUID: QGV0z3P0QtGoKymuZV5KEg==
X-CSE-MsgGUID: +bjBUcuLTLSfD3ih5lB3Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,265,1751266800"; d="scan'208";a="178909413"
Received: from junlongf-mobl.ccr.corp.intel.com (HELO [10.238.1.52])
 ([10.238.1.52])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 01:34:55 -0700
Message-ID: <969ecc08-0ffe-4390-9847-c94fcbed70c1@intel.com>
Date: Mon, 15 Sep 2025 16:34:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] qemu-options: Change memory-encryption to
 confidential-guest-support in the example
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250714091953.448226-1-xiaoyao.li@intel.com>
 <20250714091953.448226-4-xiaoyao.li@intel.com> <aMPXH09Gyp7F8V1j@redhat.com>
 <aMPYkUsytGxLPIM7@redhat.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aMPYkUsytGxLPIM7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/12/2025 4:23 PM, Daniel P. Berrangé wrote:
> On Fri, Sep 12, 2025 at 09:17:35AM +0100, Daniel P. Berrangé wrote:
>> On Mon, Jul 14, 2025 at 05:19:51PM +0800, Xiaoyao Li wrote:
>>> "confidential-guest-support" is the recommended property instead of
>>> "memory-encryption". Switch to "confidential-guest-support" in the
>>> example of sev-guest.
>>>
>>> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> ---
>>>   qemu-options.hx | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Incidentally, how about adding another patch that declares 'memory-encryption'
> as deprecated (print a warning to stderr if used, and add note to
> docs/about/deprecated.rst).
> 
> We've had 'confidential-guest-support' for long enough that no one should
> be using 'memory-encryption' anymore, so it is time to start the clock
> for its removal.

Sure, I will add an additional patch to deprecate "memory-encryption".

And thanks for reviewing the series!

> 
> With regards,
> Daniel


