Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94D1C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 02:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK6QM-0001GP-F7; Tue, 27 May 2025 22:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6QH-0001Fd-7a; Tue, 27 May 2025 22:21:41 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uK6QF-0006OA-Lr; Tue, 27 May 2025 22:21:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748398900; x=1779934900;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=iBU3z5qZlJT7vNeKtI75qxKgKQeoolmxL/DPdmy7sws=;
 b=ALJNjMN/MFHkrtZ4m6hE54Z9jznU/gj3Z/5G5EoL6HMsrm7NMNttk9XA
 eOx2Fhnrj6q31LSsA72/R6PrisuUUlGmvg30SULBjw6JZoqRI0alHRFln
 MdHwnd8E4qSyF8Ja3aB+j32cFzj/d1/hINqlQ4qZ2gyp/8Jf2wwaEBC7d
 U/6XpAR/uzAMoe02OYMboRrWv+/K2335XEqQbm69HQGZgWjJPv+mKBiwr
 ELZdys8gEFNXcs/hniBhVy+JdYMmwu56fg1t2qyyM3LD3xOosKriSK0gX
 Gd37irVTUCjH7eg2doV2RDSeeqJVd1L6RgAbgoCPXB6qKMB8JRa6O9b3p A==;
X-CSE-ConnectionGUID: QNOhZgQKTFC6Dkro8I4mJQ==
X-CSE-MsgGUID: N4hdo8kQR/aZbsnvcQ5TEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="49524501"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="49524501"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:21:38 -0700
X-CSE-ConnectionGUID: 0KLCa/2HSEGoYynE9MQ0KA==
X-CSE-MsgGUID: 2Ce566nTQRGwMtdyWzy7hw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; d="scan'208";a="173959880"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.247.1])
 ([10.124.247.1])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2025 19:21:31 -0700
Message-ID: <96a74d4a-f90a-4352-a9d1-92d8c726c15a@intel.com>
Date: Wed, 28 May 2025 10:21:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] hw/i386/x86: Remove
 X86MachineClass::save_tsc_khz field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20250512083948.39294-1-philmd@linaro.org>
 <20250512083948.39294-11-philmd@linaro.org>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20250512083948.39294-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/12/2025 4:39 PM, Philippe Mathieu-Daudé wrote:
> The X86MachineClass::save_tsc_khz boolean was only used
> by the pc-q35-2.5 and pc-i440fx-2.5 machines, which got
> removed. Remove it and simplify tsc_khz_needed().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>

