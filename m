Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09812C54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:32:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpgU8-0004V9-37; Wed, 27 Mar 2024 23:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgU0-0004Uo-RS
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:31:18 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1rpgTx-0002z4-TP
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711596674; x=1743132674;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=hZKzJUOFvKytethmGxnRTIKtgjsKhTWDHk/UyV3U9Uw=;
 b=OvPvBS+wtCZ2GW6uvJvO1vhfUhSf5C+SfDJgD8Z5caUCZoY0bJAhw9gI
 ATv0STPfYFMpDoqJx1+tb0MLOfSUtUl40HUMD8+4Tc/Hj0wQq7QKa4kpc
 dGx3i8/1uPOKGm5iHCq5kgiRGUzaYZjXOJHyiw4liTWZjvdjGmmEeQNvv
 Re5A4MKHFekrOs7BcaDUmidTI5Cg/zbXDp+byutXn49R9ji9lmdzz1ISy
 /LH8QtmnpLmyl1osg3uvaE9l6nGV8SKgyocnBM9xmd8reOj3a5AuSTfaM
 eyJCvhit2961Qi0K9rgmkuXMqO6AyaYvsdYCnGzsiD0zY8+AmlN0Zk2g+ w==;
X-CSE-ConnectionGUID: fajsBLcFQAewKcis+TC7kQ==
X-CSE-MsgGUID: 7c7AtwG5QcyPaTGwtP5GEg==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6846659"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6846659"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:31:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="21228739"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.36])
 by orviesa004.jf.intel.com with ESMTP; 27 Mar 2024 20:31:04 -0700
Date: Thu, 28 Mar 2024 11:44:59 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH-for-9.1 v2 19/21] hw/i386/pc: Remove 2.3 and deprecate
 2.4 to 2.7 pc-i440fx machines
Message-ID: <ZgTnu5RlRYiSd++R@intel.com>
References: <20240327095124.73639-1-philmd@linaro.org>
 <20240327095124.73639-20-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240327095124.73639-20-philmd@linaro.org>
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Philippe,

On Wed, Mar 27, 2024 at 10:51:21AM +0100, Philippe Mathieu-Daudé wrote:
> Date: Wed, 27 Mar 2024 10:51:21 +0100
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> Subject: [PATCH-for-9.1 v2 19/21] hw/i386/pc: Remove 2.3 and deprecate 2.4
>  to 2.7 pc-i440fx machines
> X-Mailer: git-send-email 2.41.0
> 
> The pc-i440fx-2.3 machine was deprecated for the 8.2
> release (see commit c7437f0ddb "docs/about: Mark the
> old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
> time to remove it. Similarly to the cited commit,
> deprecate the 2.4 to 2.7 machines.

I suggest split the deprecation of 2.4-2.7 in another patch.

And when a old machine is marked as deprecated, is it necessary to
set "deprecation_reason" as commit c7437f0ddb?

I tend to set that field since boards.h said:

/**
 * MachineClass:
 * @deprecation_reason: If set, the machine is marked as deprecated. The
 *    string should provide some clear information about what to use instead.
 *...
 */

And that field would be printed when user boots the machine.

Additionally, could we define rules for deprecating old machines?
For example, if it's more than 8 years old (as commit c7437f0ddb) or
after how many releases, the old machine can be considered for
deprecation.

Thanks,
Zhao


