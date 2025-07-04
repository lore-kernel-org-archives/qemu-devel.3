Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D99C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfJm-0000hB-EO; Fri, 04 Jul 2025 08:15:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXfJO-0000fh-EV; Fri, 04 Jul 2025 08:14:38 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1uXfJH-0001X1-Tm; Fri, 04 Jul 2025 08:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751631272; x=1783167272;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Yv+aBB9Hki6+HDxlVgF6wNkRw3v40in58G3b/4NxQWo=;
 b=eQk6BFura71codR/rtcDvgbI/TZ4pT3vecRNXj+O5IPEgr7Tqx8Uc98B
 +00qQHxNu/wAiqUQLIvUw7v/LTQufaqmI/+YaDaAreLX+ypLWliBZSQ4J
 51jlcswRvKm7H4hv204EzkRnWyplj07GmGUnUJe/giEy6WtRH26RAQ2j+
 X/ZCSCj7unjcpGflLijy1qg0CHPFEFRJI/4RL48mtjzHQmG3RdyHuZKFe
 sgCTQTtWHo4NY2wrtmaH4+6V6Iy9nTrL90nQTRcl3Vt7SbESScUfnm3Ni
 QXOl7QpItHv1IABJFZPfmtTd5EBSfE6K1bEkH8JB0u9/qIaAuD19iZdfd g==;
X-CSE-ConnectionGUID: DL8wMW/xQiORmCza4U7G4w==
X-CSE-MsgGUID: R6EMfCToSuaxlLZFFjDtSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54085073"
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="54085073"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2025 05:14:29 -0700
X-CSE-ConnectionGUID: 7L6rUULbSVyaD9yWRJiN2g==
X-CSE-MsgGUID: FtVsQ70vQGSAt2ZHyMoZyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,287,1744095600"; d="scan'208";a="155393809"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jul 2025 05:14:27 -0700
Date: Fri, 4 Jul 2025 20:35:53 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/2] rust: add Derive macro unit tests
Message-ID: <aGfKqbywpiZEUr37@intel.com>
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> You can run the added tests directly with this meson command:
> 
>   meson test rust-qemu-api-macros-tests

Hi Manos, do you meet this error:

Traceback (most recent call last):
  File "/usr/lib/python3/dist-packages/mesonbuild/mesonmain.py", line 146, in run
    return options.run_func(options)
  File "/usr/lib/python3/dist-packages/mesonbuild/mtest.py", line 2004, in run
    b = build.load(options.wd)
  File "/usr/lib/python3/dist-packages/mesonbuild/build.py", line 2868, in load
    obj = pickle.load(f)
ModuleNotFoundError: No module named 'mesonbuild.options'

ERROR: Unhandled python exception

    This is a Meson bug and should be reported!
---

But I've tested this series via `make check`.





